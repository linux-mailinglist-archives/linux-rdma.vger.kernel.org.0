Return-Path: <linux-rdma+bounces-18475-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHFGAjTSvWm8CQMAu9opvQ
	(envelope-from <linux-rdma+bounces-18475-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Mar 2026 00:03:16 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7742E2307
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Mar 2026 00:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE49C3053DE1
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 23:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9424389454;
	Fri, 20 Mar 2026 23:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="ceqaioKz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA663815CE
	for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2026 23:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774047756; cv=none; b=kogMKEB/0G5tRv+N+3M4wFRa+9PgvMFvnhQWCHpxE/sQTOWGvFocoIiw77Qir6JJyO20SwXU4/ftcBE2C1ra3A9P6NA+3QTAiBs2ok/tsIzsiB86y0dtZK6+BWOYKrImv0fWmhx+JDBdB+g152uKYI6UWk5L8UTk0UI/PbFI0IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774047756; c=relaxed/simple;
	bh=7UcKqNqUMGElXvB3apCmM1Rrjy8IGPj9FQ52Qpbs9gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCZb/kSxce7qYl7TYLhS1k0nb3Jsi+Zu92LI1VISIcELVFStkTdEdnL5qf5208byrd7ctYxQjq3cNnAsragpUQ0R/yQp02FVw4vdFBlgL3ML0tcXQuh2hRWorWKl+rAI3xJUOenATn2YUdhaVAqFDH6YEwI2w0obNweS50Tzn8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=ceqaioKz; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35a288a2c00so1203955a91.2
        for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2026 16:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774047755; x=1774652555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJCb1rgMxhRDKaUdftwMEyliYc1In3VuNS5gMJ0u0Zk=;
        b=ceqaioKz0tzFFt5RQ6hWG6w6rVEO93frW10h88GxPSRWHPACeEtPeR9nzNxI8gHg3s
         Rx5JVpS4OV/KFzqQ6tIhWjzCL/CG2FL8IwEwz4t8B1lgvbRVRAlMtw7fPZp0WsMsh54a
         IpzUkqdoVhCyhci4TW4tinYNXTY0YOkuLjbABAROWDa9nTr77GEOkekC/e9suMgCZF9o
         ZXVxjSDUFzQhsFbda8v3U9KxJPZUkoN1gUDYePt68SAC+sa2L83TlJmNl/8PF8Oe3Lu1
         NxsaD24yUJXquSPNO6Keh6xlyk2neBpQcfXjAlANgQka7Z8ccZimdEz5ycWaI4WIltzB
         AOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774047755; x=1774652555;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AJCb1rgMxhRDKaUdftwMEyliYc1In3VuNS5gMJ0u0Zk=;
        b=Ex2ScKV5fM8QXufdxTWa97YcElt+B2WcztFsAxln4a9W4c6fEuB4BXpNsANRA0+vaz
         GMKXOZwgz9BwPjGdZORuBBqZ9XOSW5oBW4NAF1zxICOkOyDfSu+uBWE96O/BJqmLtSHM
         28RrPTk/a6EMXNS1gJc6UG2wXJFcoE1AAE1aHaQudR2ZEGIgWKm70pramSWI0xI7XuTu
         Gm8J3S/mMGXYudYMOCjCYn76gsHXT8590AsOmlYFdKB4CrcR3Cif2Xj9GKTggnxOpS8E
         e0VqSsnPwIq5dvEPbYZvI4LYE/w2BX5GrNYd6vyuNFZbZHhiJbQv0gInafr3L65QC8tZ
         wpvg==
X-Forwarded-Encrypted: i=1; AJvYcCXexDHLhaiY9mcTM956u0g4CvRoY+Oj0dBMBucViZsQ2kXEJYgzLQ0DlJUYWxhKzQF88DL89yVSsbaW@vger.kernel.org
X-Gm-Message-State: AOJu0YzLPGoV/sj4R0NFEwu67wl5FnbC0GXTKU1/JU4ffpDY9ggOqaqM
	0EPl9P0JbdIYZsqJyt2WX7DDGOJ16BEZT2RhEjqpdOLf4dx6Gv9ECKGvHHCMIlblBGc=
X-Gm-Gg: ATEYQzymhO95Q0p8wBaRKe/o4v3ZSppFOOQUwXIhTClCMyV4WI98DfUMwCCQuseSvl2
	EhSjYo7mg1AeGPE0/DPtzMXD3MCsVGMD5TbYbfbZIr4itolfwkt9ZXMNr39muHX+yUxXTeH7Rj+
	FC+nB70A1fl6cGV5UN1fuzdXj6R31HuMsdOe05HMvSoW6TC0fjkOqh2v7GgEEM+2VHJWRbiOSB6
	1YftDunYqU33EIoCgbScM0j3XJRRufVVJcgYjY83ecivV4cAgwvx2OxUWR05SkDFCMh/l2aHnAu
	I01tt8lRQIxvzFwGFob5SSc5Iy/USwyLINjUSVSZSyE/WDtow5HY57S8a+5M2tv9L8y/o49YK++
	5HBJ5M1X7irdcRO9p9SYWD+pK2ioE6orz71GYR6xPTqTjZ61Oj26JZ9zuoA2hmLe1KPO5PvPhIB
	KjcbqgDb2e4lpGjg==
X-Received: by 2002:a17:90b:2242:b0:35b:a7be:ae62 with SMTP id 98e67ed59e1d1-35bd2d2c8e1mr3707375a91.30.1774047754718;
        Fri, 20 Mar 2026 16:02:34 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd4109c3bsm3000607a91.13.2026.03.20.16.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 16:02:34 -0700 (PDT)
Date: Fri, 20 Mar 2026 16:02:33 -0700
From: Joe Damato <joe@dama.to>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next 1/3] net/mlx5e: Move RX MPWQE slowpath fields
 into a separate struct
Message-ID: <ab3SCcyoqBJfQRmh@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Tariq Toukan <tariqt@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
References: <20260319074338.24265-1-tariqt@nvidia.com>
 <20260319074338.24265-2-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319074338.24265-2-tariqt@nvidia.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18475-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,devvm20253.cco0.facebook.com:mid,dama-to.20230601.gappssmtp.com:dkim,dama.to:email]
X-Rspamd-Queue-Id: 5B7742E2307
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 09:43:36AM +0200, Tariq Toukan wrote:
> Move fields that are not read/written in fast path to a different
> struct / cacheline in the RQ structure.
> 
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en.h      |  4 +++-
>  drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 12 +++++++-----
>  2 files changed, 10 insertions(+), 6 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>

