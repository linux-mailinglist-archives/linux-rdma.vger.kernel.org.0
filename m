Return-Path: <linux-rdma+bounces-18364-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INWlAMIFu2kgeQIAu9opvQ
	(envelope-from <linux-rdma+bounces-18364-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 21:06:26 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9556D2C2565
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 21:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C3C253023D70
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 20:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC173ED13A;
	Wed, 18 Mar 2026 20:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="NIwj81m4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368BA346AC6
	for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2026 20:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773864380; cv=none; b=hl1Xue3l7eLMD+aevK4YGpR5JRshr4E6Wv0mvJorRZJeTL42AICnxb90EEAvwVrKB9J+IfCoGmorXl6cR8s/+fP9CST36mIDkMHJNzPrAxVC5fZreITflNH6r6l20xiePLwRTQVwubPcjaitee6FnIM/FagPUGmrxjwFKVAEEIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773864380; c=relaxed/simple;
	bh=KuPSmFfK/2b8A5e3jfwFssD+wIacjMZ+zJyp9NVt61k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpSJIoqS3dcnva2w9kMtATxNUFfh1GaF44GtYULSA35ksvuvferqioIgyStjjXXapJusIHQ6AoMeGYIyrUdJKtpwRuZ/k9P0r/VBCU0/Eg2PzkxY7CjJPjcWU1+fNiRKQZ1GHCgn6fQMzjc9+6R2nAhyX8P8QUszfyuYdEcR5T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=NIwj81m4; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3591cc98871so174149a91.3
        for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2026 13:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773864379; x=1774469179; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dp/L77L0/zotrZ2zU531gMdFREkU2AqJ3gHWhhi3kO0=;
        b=NIwj81m4abnB79pq4TrYR1IOiQikbwXs2YA3icy+hn+OY8YPAsTUYcyYM09SVf25EW
         iwxiVtfHo2BDclHKL/1s3O3XGm/V64ktgehyf+gl3M9Tsq+SsYjiunLE9DYu22BcYp+4
         LamPoDxUkhXz01wWgaBtSK+G1iYgMGHktc9XWdHbKuIVTIHgL/3jZsyxpH+9P0WjCG1i
         MkC8n3BxTZmF0gfUbCH9L0hhSvqiNIavvD/10YrAx4qQP8yDWIxvWgD+PLwQiXDYCtFF
         DMQ1mJ/0N8lx5URw0iqeJxpPiwA8sxeKpgoFjvni2Y/+frJ0juTHbuqhRqHut/1i+MQ0
         1wJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773864379; x=1774469179;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dp/L77L0/zotrZ2zU531gMdFREkU2AqJ3gHWhhi3kO0=;
        b=OYF8VIwKv3UmCtST9dpMv8+142u8BIctPpuYbkxY0CxhXCKRLvonJdBSh7Eyz6heKZ
         aG+iymXtwBJi/fFwEv5OsWXIAZB1lrK1V+Bhw8+n9opawg8F8CJKHaXiEYd/W2t+0ylB
         UPxph8ylMyX6s5WipY6xbYMiBvQfbWREGv7Ivj5c6uqYcReGaixdOP0+N7/4yFZim2Lz
         kO710GyMrqo3LZgtbqBKOl0+ZaaJ1dL2nSDMPacNhJhBKPMEZaOZpWyI8qZHs+7vuV+s
         L8sgIeoJjTEAOwiqGYTDfso+h9fVU9IFb7vfqE5y0ypeYZ9vHtYEgBNjfii8we2BebNq
         O37A==
X-Forwarded-Encrypted: i=1; AJvYcCVR1IrtrsAta9sbg4qAyuq5h2UxcDbzlxV+R+Q1mu7Wl7bwXWIheVgVKCm82EL26izFen6zsJ8q73AB@vger.kernel.org
X-Gm-Message-State: AOJu0YzK4/OC7J+jvMQ7NUkQKq+S3pWmUiGRUhTWO26mx2ZP7P/MnpFW
	ieTGjY5eB2/7HbExxpxyrPI3Xza5FsjkQO58BHfLM++MTdMRWEanWTwygVQXwMG3wgs=
X-Gm-Gg: ATEYQzzgzxhQU/+eqKQU9c5mMjBapj2iF0pde+VH9ILwxH/vCTJXBLGwYpE7EYYJjh3
	t5T8bqnYzc5HXDgI9g13QbbM5NJ9cIuWP/WDN5goxsE7K80D4E9+N8A/J3DEfLaySi5K7+InBn5
	Ulf4C5xnJ/wmgNceAisLNBcMtQ5Jlhu2gl3/a8u0Lr6MDXxheqc6mc8mvzIidZipdnRMpT7U5Lt
	x3I1ttCUkXD1fWJdsAooHtmIpB9yY6dqldqIseO77kz4re1VIbIqX8Grzvmo74bvl46Dy1aW3Fm
	Lekpambz0WcGSfGUFEsKHAuvGW6NrmDBJE8df0jjql+34AUCXzjyFuovhSf+Cc3S987hq5RkX55
	PAULUsBps6Qr3baTp9Xm663zPglVdHdTBfCHEPNnGY1283BB8+AFtRoR5yGvO3++JHznJqs29SJ
	Oh+V1O
X-Received: by 2002:a17:90b:2ec4:b0:35b:a7be:ae48 with SMTP id 98e67ed59e1d1-35bb9e5c4ebmr4159648a91.12.1773864378543;
        Wed, 18 Mar 2026 13:06:18 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:42::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc618be0fsm433703a91.0.2026.03.18.13.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 13:06:17 -0700 (PDT)
Date: Wed, 18 Mar 2026 13:06:16 -0700
From: Joe Damato <joe@dama.to>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
Subject: Re: [PATCH net-next] net/mlx5e: Remove unused field in
 mlx5e_flow_steering struct
Message-ID: <absFuJ/Iuh4YUjrL@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Tariq Toukan <tariqt@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
References: <20260317104548.15697-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317104548.15697-1-tariqt@nvidia.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18364-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,devvm20253.cco0.facebook.com:mid,dama-to.20230601.gappssmtp.com:dkim,nvidia.com:email,dama.to:email]
X-Rspamd-Queue-Id: 9556D2C2565
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 12:45:48PM +0200, Tariq Toukan wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> Not used in mlx5e, clean it up.
> 
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_fs.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Joe Damato <joe@dama.to>

