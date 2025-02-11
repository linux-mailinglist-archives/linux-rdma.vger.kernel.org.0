Return-Path: <linux-rdma+bounces-7647-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B25A2FEB1
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Feb 2025 01:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2379416691A
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Feb 2025 00:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B12C374EA;
	Tue, 11 Feb 2025 00:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iX5WbZS+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E1711CBA
	for <linux-rdma@vger.kernel.org>; Tue, 11 Feb 2025 00:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739232078; cv=none; b=D1y7YAyE1cNa1E5JhdcK7/phpxrzR58490wqqjcsiTkdRigAFRxV2XDP5j9Y29B8qxHALz2fdc4rj4UiSWQdqh+t0GLOBlyA5aIXBov7nW+4fsPhIDcI0yA+CylyyVvEC0T5vd3cz/DC9UBenuTItbTWI5FPoq0W6imL3e5OcEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739232078; c=relaxed/simple;
	bh=nJ6LzyoeCFVUzoZJxDKWwrZWehljrX0DhSYi/LN5Rh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shrp6Sh/sJOmYEmY0SDdXiqGVzfrlwPRjDFM/UcN6IzGp/zCndtUgSOzanspwX9rW1NA7+UEISWKtiRUljRXgl/TxWr12padqIfTnQ5WElefXAYsIgOvojWIp7YtLJQ2QuknEs50KQTsOy5sncuSTsxmfjt/4LTCYyj+BJRX3Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iX5WbZS+; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3cfeff44d94so14550505ab.0
        for <linux-rdma@vger.kernel.org>; Mon, 10 Feb 2025 16:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739232076; x=1739836876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o+6VjZyKkm05cc5abGkcRCYDQiyuvjp7DI1YWDZerk8=;
        b=iX5WbZS+JoAYBsgYxpl6YrW89+p70yhF992Vocgl1ivjdsv+Satdjm2HcL7lSdBpl7
         SOEeJpC9dxduVk8eQbhzyGyfRtI84+H8+5zVdhqxsg8ct01aHL96fo5EfI4zNh2sqSHt
         2ceVv45CI4Ub4aUp0R4dRks7NoYYo75pH8X8e8oERVapjcQAP8w2P6rkqKdcU30iASKB
         bnkSFwH7cSU2GIkcpT4SWfGfI6lo2RC0NJIfZ7o47OQ1zbtdZk6/ElOdg9qhjGEr3pPw
         OEvhYdS8nmV2sUGoqX5JwZAT7qFttafzr7Hzg/uuJ04wWSkdoY/dAKjaaLRal6NOeg2+
         N7RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739232076; x=1739836876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+6VjZyKkm05cc5abGkcRCYDQiyuvjp7DI1YWDZerk8=;
        b=b9ASoxNw/ybniWS7hzk0xWPmaQDXaM3Z6Cv3N0mMZ7eGjxUL7e7gys1t3aa1MsSpba
         HT3ba4OPlckLzzAfc3FcL7IIPd2hhKEIdtK7PDa3MXYrKpDG+LZsQaNKNB3oFyusscpU
         5Mjo+u8/WcKJxR8TpaPs7Uwt+uMNDgdI6f0h3PKgfDbDqC3imxnkVdMOHpGsENtNC3fX
         mk/9fI5VaVqsS54fC4UcUlkZRfV3hgB2DJ5p0LW2QTWVnq9cwmUSqJZwnvnlejljZnUa
         9lh5fjAB5GabVvDR4X9n7aTtPJVCjn7n4yY0avTqkNa40G4Vn+OHyBmoja/fgiROq5KX
         rRyA==
X-Forwarded-Encrypted: i=1; AJvYcCWu7S8Tq3VlbalfkOviaEU7f/lLSwwVgZBOhLcdlsO5GNOHoWgcqQFjqM5RNdR+in0S0ncSMQYh1v9Z@vger.kernel.org
X-Gm-Message-State: AOJu0YzCp1hBBkwfqmHkPADaLV6/KtkdIaK899p0EjOuptLhR1ruvevr
	bpOAidthZ3IF3Ytq8GbflGeeT4WpKbPLsHj1TXavZIm/v/e0C1WNiKu1Qpk8vQtMmcZBJhBxS/O
	WrA==
X-Gm-Gg: ASbGncsFDyrFq4UlhiHDusUwAtxqsr8GlqRXPODqyPWjG1RftOF5xm7jIFiUodl3e9N
	eQXy5th//OjxqedSBf9+Smqaub9FcpyBLJi440/AhF7UFc+nFBluR3SUqXkdzYOSzfvp70+Tm/c
	EDVpnscfTv5VEweU67dqLRdnE7EgcVpex8WWq9uaySttpDaSVV1gNc9+Gm66wrgFX28KJ9XM561
	8m4V00tcPeq4uT0YWqdGREKJg64yTSkawdFAwWYd9+ecMw7m1qjPZHACkLPDt101t6gyiPU/7jo
	ONOVafU9TCl4Q74xMVIuun2ZuhFrUpoEuUWgKSJ0mX1s7v61QpIhGpU=
X-Google-Smtp-Source: AGHT+IEPW+Dnhu306cg6k4cp4JKL9h87jLz1ibbxMZeZMr5tSf0uulSyxZPsQKhKZyhcDka4DYJs9Q==
X-Received: by 2002:a05:6e02:b43:b0:3d0:23ac:b29f with SMTP id e9e14a558f8ab-3d13dcee786mr134115905ab.1.1739232076020;
        Mon, 10 Feb 2025 16:01:16 -0800 (PST)
Received: from google.com (143.96.28.34.bc.googleusercontent.com. [34.28.96.143])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ecef0c9674sm1185594173.117.2025.02.10.16.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 16:01:15 -0800 (PST)
Date: Mon, 10 Feb 2025 16:01:10 -0800
From: Justin Stitt <justinstitt@google.com>
To: Kees Cook <kees@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Yishai Hadas <yishaih@nvidia.com>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net/mlx4_core: Avoid impossible mlx4_db_alloc() order
 value
Message-ID: <3biiqfwwvlbkvo5tx56nmcl4rzbq5w7u3kxn5f5ctwsolxpubo@isskxigmypwz>
References: <20250210174504.work.075-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210174504.work.075-kees@kernel.org>

On Mon, Feb 10, 2025 at 09:45:05AM -0800, Kees Cook wrote:
> GCC can see that the value range for "order" is capped, but this leads
> it to consider that it might be negative, leading to a false positive
> warning (with GCC 15 with -Warray-bounds -fdiagnostics-details):
> 
> ../drivers/net/ethernet/mellanox/mlx4/alloc.c:691:47: error: array subscript -1 is below array bounds of 'long unsigned int *[2]' [-Werror=array-bounds=]
>   691 |                 i = find_first_bit(pgdir->bits[o], MLX4_DB_PER_PAGE >> o);
>       |                                    ~~~~~~~~~~~^~~
>   'mlx4_alloc_db_from_pgdir': events 1-2
>   691 |                 i = find_first_bit(pgdir->bits[o], MLX4_DB_PER_PAGE >> o);                        |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |                     |                         |                                                   |                     |                         (2) out of array bounds here
>       |                     (1) when the condition is evaluated to true                             In file included from ../drivers/net/ethernet/mellanox/mlx4/mlx4.h:53,
>                  from ../drivers/net/ethernet/mellanox/mlx4/alloc.c:42:
> ../include/linux/mlx4/device.h:664:33: note: while referencing 'bits'
>   664 |         unsigned long          *bits[2];
>       |                                 ^~~~
> 
> Switch the argument to unsigned int, which removes the compiler needing
> to consider negative values.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Tariq Toukan <tariqt@nvidia.com>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Yishai Hadas <yishaih@nvidia.com>
> Cc: netdev@vger.kernel.org
> Cc: linux-rdma@vger.kernel.org
> ---
>  drivers/net/ethernet/mellanox/mlx4/alloc.c | 6 +++---
>  include/linux/mlx4/device.h                | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/alloc.c b/drivers/net/ethernet/mellanox/mlx4/alloc.c
> index b330020dc0d6..f2bded847e61 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/alloc.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/alloc.c
> @@ -682,9 +682,9 @@ static struct mlx4_db_pgdir *mlx4_alloc_db_pgdir(struct device *dma_device)
>  }
>  
>  static int mlx4_alloc_db_from_pgdir(struct mlx4_db_pgdir *pgdir,
> -				    struct mlx4_db *db, int order)
> +				    struct mlx4_db *db, unsigned int order)
>  {
> -	int o;
> +	unsigned int o;
>  	int i;
>  
>  	for (o = order; o <= 1; ++o) {

  ^ Knowing now that @order can only be 0 or 1 can this for loop (and
  goto) be dropped entirely?

  The code is already short and sweet so I don't feel strongly either
  way.

> @@ -712,7 +712,7 @@ static int mlx4_alloc_db_from_pgdir(struct mlx4_db_pgdir *pgdir,
>  	return 0;
>  }
>  
> -int mlx4_db_alloc(struct mlx4_dev *dev, struct mlx4_db *db, int order)
> +int mlx4_db_alloc(struct mlx4_dev *dev, struct mlx4_db *db, unsigned int order)
>  {
>  	struct mlx4_priv *priv = mlx4_priv(dev);
>  	struct mlx4_db_pgdir *pgdir;
> diff --git a/include/linux/mlx4/device.h b/include/linux/mlx4/device.h
> index 27f42f713c89..86f0f2a25a3d 100644
> --- a/include/linux/mlx4/device.h
> +++ b/include/linux/mlx4/device.h
> @@ -1135,7 +1135,7 @@ int mlx4_write_mtt(struct mlx4_dev *dev, struct mlx4_mtt *mtt,
>  int mlx4_buf_write_mtt(struct mlx4_dev *dev, struct mlx4_mtt *mtt,
>  		       struct mlx4_buf *buf);
>  
> -int mlx4_db_alloc(struct mlx4_dev *dev, struct mlx4_db *db, int order);
> +int mlx4_db_alloc(struct mlx4_dev *dev, struct mlx4_db *db, unsigned int order);
>  void mlx4_db_free(struct mlx4_dev *dev, struct mlx4_db *db);
>  
>  int mlx4_alloc_hwq_res(struct mlx4_dev *dev, struct mlx4_hwq_resources *wqres,
> -- 
> 2.34.1
> 

Justin

