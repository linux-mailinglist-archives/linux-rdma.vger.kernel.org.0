Return-Path: <linux-rdma+bounces-8247-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CAAA4BF04
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Mar 2025 12:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D583161FB9
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Mar 2025 11:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B27D202993;
	Mon,  3 Mar 2025 11:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="p3bK6d8D"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AA4201116
	for <linux-rdma@vger.kernel.org>; Mon,  3 Mar 2025 11:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002020; cv=none; b=iW1Y0ved+n3AleIgbz90hKjRQArJ2SfrgJkn5O4XOpAJ7vQ3XVLXcXlZ4axRElxL+pic5ccvsALsWRqAspKTD19q/2HfwtZftr+HQXDMxF5Fhi54csOzXgu+4TvE+tlwgUM4kiGWMkP3/vDB/pv98MPCCF2ZzTEKKv0hohqDPyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002020; c=relaxed/simple;
	bh=32Qik+C6Gy82VbaZ+W9H7pBMHl/CZaXxobg9NI2Xga4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a//sNhxoHfFwuUZznvfHHuVar9xuqZmB2k7EnXLWtZYbhqabDbPTzffhFYpAkVQ5uAK/T/bzdDqw0DWQ1nXz5V/RjVzP3+LWCa0ZFdrLNn/11vKG28qt1RS/zNMnj6+UT3WzF0+IughfMrGx3x/zcwbB7kW5EQJibAtS9TOcAIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=p3bK6d8D; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43bb6b0b898so10863665e9.1
        for <linux-rdma@vger.kernel.org>; Mon, 03 Mar 2025 03:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1741002017; x=1741606817; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4NtAA2UHYocmR2KbGMJPhzPhzOIPXF5Y+cD7gkzWW/A=;
        b=p3bK6d8DrjrhK0/qO2+o0XXclKbDdJbPyaEJqebJFnj6UftGu/Wlp0g0z460UuK8eQ
         jqP5dZiDvaf13EWZxYf429fumpQf+BuKXNtjjUA1NBj79GysscTVo0cg0j48fqmhX5NV
         9efVLZPrgc0Lj4xKJGCHbJmoh8/VB/GderaMZxkIzlOfM8yT/xfitEr/NJBqrSttwzsv
         D2S8SLnciUvPRACHbdtcIkpSchM5xwppp3eKPT9K2p2QOLfBtVwD7D66BHHzvMMQDhR3
         p5TyUVouF6jIyBsh7KwZIVWxs5mF+hJOLYmeHoxXDNdBYVQ5ilopY0Vx1AvSDV4gvTVv
         9zZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741002017; x=1741606817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NtAA2UHYocmR2KbGMJPhzPhzOIPXF5Y+cD7gkzWW/A=;
        b=tWoBraxGxCV++iT/UQTUmPFDUcBLr3z2qbU0pTEvKfh0exKppzPwJmI0/OaWhsGOZT
         uc0Wt8lU79FahHieAf0itJ6i6SpI6AZLrP272/ztzJo+xgpPkyc1jw0PVpOHMmxQtnsf
         6Aiq+aZdYhU1cRJawvu4EdAlZtLC5wpxB69dbzalNUHLFCthzbQVj0XblW2o7hiCUY2u
         zu57+YfsEgYkRNE63ivvcE7bgQhjotHNwZeYcpuL+bIhvWnHqmeT71ev7OCiNfnPYyTs
         s+1XgYrFDDYkP0F8WgSB9K5e+Oift3awz4ZYVKK1pV6yBvozhwxeX79P5d0I6vc7Ngh+
         nDyQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/00q7jqwrL+T3j6zu3BGR6Cdy6uJTofMANXDq7T1pwKJmcbXPLImS3fEAwoptF2CxlPnSAJ/qviGA@vger.kernel.org
X-Gm-Message-State: AOJu0YyoddkZId5SNmMnSIUNCteOMyAc9Xgyu7ytIoBsTmQNe+WsCTpd
	C0yW9wySQiW/63AxM0f3m4WlMTWNUJ2g4wyD5ot80bXjg7BJF0o7VZCniEbKaB0=
X-Gm-Gg: ASbGncvdzsYD2gByMsqn3e/zoUwq5tzv8JWYu4hqMCdPe9FqHOmfQF2JSUjB9AQJ75q
	3G4+TDf5EtG07Cb6bZi2F1d4Z4xJZfTH1q+RujA3ceOEw7u6Rw/r4w+uVC4wle7KQK3zjuemhkl
	am945fQdJLWPSCQV7U4t8fuVR/VO027rdx22xDDZd83k7oWnPIK0MTew9wxTFaGubLyTlluTr4H
	AEEJoGn8che5eCwmEI0uu+budRS3AvSi2KwEtcfQQJkCJ1+3LUQ6GY7syzduZI+RPMx7GBjqnL2
	14uy+tKe9Es9TC8KojQNh977k3ybCsiNqKzxmUv2+q6caWQJyob8PDivFoDWkDxu0iEnzprL
X-Google-Smtp-Source: AGHT+IFz1lKrp8HJjVJu85QHKOfDHRDkxYAgfR/PMWyeJaGKL7qzodzH7XjGqSVE9eCdgx8AE4rhHQ==
X-Received: by 2002:a05:6000:144c:b0:391:c3a:b8ae with SMTP id ffacd0b85a97d-3910c3aba7emr2411994f8f.23.1741002017110;
        Mon, 03 Mar 2025 03:40:17 -0800 (PST)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e479596dsm14212516f8f.7.2025.03.03.03.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 03:40:16 -0800 (PST)
Date: Mon, 3 Mar 2025 12:40:13 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: longli@linuxonhyperv.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shradha Gupta <shradhagupta@linux.microsoft.com>, Simon Horman <horms@kernel.org>, 
	Konstantin Taranov <kotaranov@microsoft.com>, Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>, 
	Erick Archer <erick.archer@outlook.com>, linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, Long Li <longli@microsoft.com>
Subject: Re: [PATCH] hv_netvsc: set device master/slave flags on bonding
Message-ID: <52aig2mkbfggjyar6euotbihowm6erv3wxxg5crimveg3gfjr2@pmlx6omwx2n2>
References: <1740781513-10090-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1740781513-10090-1-git-send-email-longli@linuxonhyperv.com>

Fri, Feb 28, 2025 at 11:25:13PM +0100, longli@linuxonhyperv.com wrote:
>From: Long Li <longli@microsoft.com>
>
>Currently netvsc only sets the SLAVE flag on VF netdev when it's bonded. It
>should also set the MASTER flag on itself and clear all those flags when
>the VF is unbonded.

I don't understand why you need this. Who looks at these flags?


>
>Signed-off-by: Long Li <longli@microsoft.com>
>---
> drivers/net/hyperv/netvsc_drv.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
>index d6c4abfc3a28..7ac18fede2f3 100644
>--- a/drivers/net/hyperv/netvsc_drv.c
>+++ b/drivers/net/hyperv/netvsc_drv.c
>@@ -2204,6 +2204,7 @@ static int netvsc_vf_join(struct net_device *vf_netdev,
> 		goto rx_handler_failed;
> 	}
> 
>+	ndev->flags |= IFF_MASTER;
> 	ret = netdev_master_upper_dev_link(vf_netdev, ndev,
> 					   NULL, NULL, NULL);
> 	if (ret != 0) {
>@@ -2484,7 +2485,12 @@ static int netvsc_unregister_vf(struct net_device *vf_netdev)
> 
> 	reinit_completion(&net_device_ctx->vf_add);
> 	netdev_rx_handler_unregister(vf_netdev);
>+
>+	/* Unlink the slave device and clear flag */
>+	vf_netdev->flags &= ~IFF_SLAVE;
>+	ndev->flags &= ~IFF_MASTER;
> 	netdev_upper_dev_unlink(vf_netdev, ndev);
>+
> 	RCU_INIT_POINTER(net_device_ctx->vf_netdev, NULL);
> 	dev_put(vf_netdev);
> 
>-- 
>2.34.1
>
>

