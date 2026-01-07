import 'package:flutter/material.dart';
import '../models/movie.dart';

/// Widget displaying movie information in a card
class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (movie.posterPath != null)
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(4),
              ),
              child: Image.network(
                movie.fullPosterUrl,
                height: 400,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 400,
                    color: Colors.grey[300],
                    child: const Icon(Icons.movie, size: 100),
                  );
                },
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (movie.voteAverage != null) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        movie.voteAverage!.toStringAsFixed(1),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ],
                if (movie.overview != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    movie.overview!,
                    maxLines: 8,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ],
                if (movie.releaseDate != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    'Çıkış Tarihi: ${movie.releaseDate}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
