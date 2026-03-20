Return-Path: <linux-rdma+bounces-18477-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gO0BNtHSvWktCgMAu9opvQ
	(envelope-from <linux-rdma+bounces-18477-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Mar 2026 00:05:53 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C982E2347
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Mar 2026 00:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 395213042D4D
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 23:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB77B39099E;
	Fri, 20 Mar 2026 23:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="yNB+Ssgd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3392F36A030
	for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2026 23:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774047948; cv=none; b=fl0O1jUs7aTwdBftw/fJkWkZrxyA2VTP/+T/E0YO4ITYgumaIZxcR0xlWt07HQ4cUeVkGQq5dttDC3Ah5rtIg2y4TI4tBEmc0V9OGoa72wZ2LAteNNJj3L5NBut9HIldGxMGDgN+52J2x70DNTXMLUNs1V1i2lo9iax2mNhNS0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774047948; c=relaxed/simple;
	bh=FIAh290YQLzscCgK3QRlfs3qcGanHE3RzenIPMODm7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVhz4uSCgqdCeotSKSOG7a/sDmkNzLB9JfgZVUiph7DxW/T0WIEdLOvC3EtNUotK68/b1xuXh2Jug347/pR+aNavjELVII7dKzndCU1eHJT6fjUEZg47278KFWtC7vTfcO6gTd9MUJFG+n7RP2+0Him3DK29q02bDlxHVY33Njg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=yNB+Ssgd; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35a09e0dd63so1343909a91.3
        for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2026 16:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774047945; x=1774652745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mhc4N9jlJHnN9buMBRq2NE8bw7QGAFCXpHJparJXDnE=;
        b=yNB+SsgdILnUsbEes0sFov/IqCPyO7nsAGWXH1PH51+mwfjC39ov+fjGSWNS7nBAqO
         6rpJFxVt1deYKTE+e4kVcy4xBo+iN5uMbvJ0AX7XOL3nmAO+UdwoPt+8QdAP2Zp6Btpa
         YQHEsqnfV0Af6K4oihBLM1fSf8I1xh6yjHW4ifaCC4P78wpMXGFGPYS/KwO+XxO7YTOy
         V5M0/HoRTFl7fsNQZuNoEjPH9c7ozMQcw1IokiwVSt0BcxPnux2RhxbzrInK7W/qtKPA
         7v2MtzHOaOS7mzIoA2Tixp29bzKETZz+h5ulW0KObr31xLW2FscUSpQYmby2bsKKwVKC
         5iXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774047945; x=1774652745;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mhc4N9jlJHnN9buMBRq2NE8bw7QGAFCXpHJparJXDnE=;
        b=l1HE6EoKNYjQTdpQmoWL0bTup+XUZ6SdoNg+J4ebDFJaVhgm8DvCtU9Lg+4hMTyoIl
         onn55hTzLCbsmHg0Zno6jK0nFV2RnZtLFklpuRFhrwvWBDkh9zJLWUVUxYxPh+1CRUqL
         evZNqWl9kyHIMWi+pVgDmz+5l47d/SWYkUjqNjUjUzaaZSrtoNeyi8HJCXBOQy5aFdFu
         wABO16s8feobDn8e3/mHNlMl9X8Zl1nlFpGWIkDo+UM+HAvvogMgVvdkdIlSdRiaOY2W
         Vg2Q1cJciz/15ipfDKzjXj/TqARqf+ZSRAEm7cZOpWF4jKMir7y/mnxc5OuRlTWbAns5
         3X4A==
X-Forwarded-Encrypted: i=1; AJvYcCXvmahdWyIe2cDx0Gd10+LIKIQGLx0cdBa/Cy5SAjm/m8mbZ7A46ClpTr35CfgSByNCmlE5e5ekfuso@vger.kernel.org
X-Gm-Message-State: AOJu0Yx31+wt1InqZshwdGFMkn8flLlZijlNx1I+i0yTBNhzoNDM7uRY
	zmbY3egRTng8WQDN06tYbJbWBr2bgQI75XYiESKVS/w5ROGogcQgx1YP4yYEz2Nfibg=
X-Gm-Gg: ATEYQzzPPTppAWO+nu1a4xS9XaUdn02meDbyzcbhrfXiF5IokPMk0y8LFZd3VncX1x6
	AOetODSxrTXnyFV7DJKiwGBoNxtE3qr6P3aL/5B1Kw/7h75S0i4X0/xGDJzTasSLMYXtdRNHGNU
	r5xwjL87UUNR1TvlU9WANMFliLLbECLfKI1kqVK3UZRGO+rZF2NFFoMqXTK59lftnOt1VSWDY29
	O1ltoqa383rDxNbv+hO8Ij28T28dXzsfYJkQDpYmBZRDy9TdHEOF2JNae6PKqWozKm7u58GcFIR
	BjSRN7EH8Ns1Gu6Kkmj1aIrDecQrmo8ncBhGtFlWtmq8Y+nrx2jGPmkczSu8N251jFt3ci5KbpS
	isk3AIVqL6qS6GTVbi5K4KSC/8a3xJfzuZFWpUWT/CsovLDVj73c/3EN8moTfrQHl9bqvQsnWX5
	LDwnPxh+CsXO02mg==
X-Received: by 2002:a17:90b:3c0d:b0:359:9014:99e7 with SMTP id 98e67ed59e1d1-35bd2d68359mr3803559a91.29.1774047945558;
        Fri, 20 Mar 2026 16:05:45 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:9::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd40e4bf2sm2816680a91.11.2026.03.20.16.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 16:05:45 -0700 (PDT)
Date: Fri, 20 Mar 2026 16:05:44 -0700
From: Joe Damato <joe@dama.to>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Mark Bloch <mbloch@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Simon Horman <horms@kernel.org>, Shay Drori <shayd@nvidia.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>, Alexei Lazar <alazar@nvidia.com>
Subject: Re: [PATCH mlx5-next 1/2] mlx5: Remove redundant iseg base
Message-ID: <ab3SyIfv/0FrMPM5@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Saeed Mahameed <saeedm@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Mark Bloch <mbloch@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Simon Horman <horms@kernel.org>, Shay Drori <shayd@nvidia.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>, Alexei Lazar <alazar@nvidia.com>
References: <20260319122211.27384-1-tariqt@nvidia.com>
 <20260319122211.27384-2-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319122211.27384-2-tariqt@nvidia.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18477-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,dama-to.20230601.gappssmtp.com:dkim,devvm20253.cco0.facebook.com:mid,dama.to:email]
X-Rspamd-Queue-Id: 48C982E2347
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 02:22:10PM +0200, Tariq Toukan wrote:
> From: Parav Pandit <parav@nvidia.com>
> 
> iseg_base and base_addr both point to BAR0, making iseg_base redundant.
> Remove iseg_base and rely on base_addr instead, reducing the size of
> struct mlx5_core_dev.
> 
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Shay Drori <shayd@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/main.c                       | 2 +-
>  drivers/net/ethernet/mellanox/mlx5/core/main.c          | 3 +--
>  drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c | 3 +--
>  include/linux/mlx5/driver.h                             | 1 -
>  4 files changed, 3 insertions(+), 6 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>

