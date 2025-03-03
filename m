Return-Path: <linux-rdma+bounces-8332-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E5DA4E8AA
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 18:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DC4D8A0974
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 17:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5F927BF94;
	Tue,  4 Mar 2025 16:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="p3bK6d8D"
X-Original-To: linux-rdma@vger.kernel.org
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C1E2BF3CF
	for <linux-rdma@vger.kernel.org>; Tue,  4 Mar 2025 16:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107209; cv=pass; b=SaaeaCCQUexEVJo/k3VWhh6+mFg9+iBNie9c5vfJDkPuUIXSo5HxZXplAyxPN4hm3Odmen55oV5nJrUNvStRt+vwXA9uMoYmM57zyOlhk40j5yZHEQ6cDHCEB/voI+Y6G6KDw7+tnqQgbYFwqd73v+NgwQdaTi8R2LxtgOvYFjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107209; c=relaxed/simple;
	bh=32Qik+C6Gy82VbaZ+W9H7pBMHl/CZaXxobg9NI2Xga4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBpKuqyFrF2VJ5iQZ3xPbNKPRzipPQXecpl3dsYAMeQmaMkv267Cj+ojHyRsTfDwjIV0rFbATSeyFbowUYwPygr6IfuD6JJpawsGd6GAXYcLqWqEXMazUBKblCdJvmLtrC1iCS+AERiX+VXkGOBD8b8Z1FUfA6r6xBQ03a/GQ+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=p3bK6d8D; arc=none smtp.client-ip=209.85.221.48; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; arc=pass smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id 50371408B649
	for <linux-rdma@vger.kernel.org>; Tue,  4 Mar 2025 19:53:24 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=p3bK6d8D
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dbM13H1zFxCY
	for <linux-rdma@vger.kernel.org>; Tue,  4 Mar 2025 17:38:39 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 16F654275B; Tue,  4 Mar 2025 17:38:32 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=p3bK6d8D
X-Envelope-From: <linux-kernel+bounces-541609-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=p3bK6d8D
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 2551E41E09
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:41:27 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw1.itu.edu.tr (Postfix) with SMTP id CAAF1305F789
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:41:26 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BCC2162C72
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AD4202F65;
	Mon,  3 Mar 2025 11:40:24 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43F920296C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 11:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002021; cv=none; b=Ch2ycr6idfAlIyRguf6XUiHCQMr4cHUOhbegOj8b0TMDNw0PSTIyaupPVHAIuQtsmCD9gtow+zaJHMIqU6TaouIBrs6ldCFMflrhNngtEXK6kFyb5cb5oxRaNH2KsILEi1+sWynL3ZZRT4fczgYqZ25a6vWdZv8w6zOzvgWt6Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002021; c=relaxed/simple;
	bh=32Qik+C6Gy82VbaZ+W9H7pBMHl/CZaXxobg9NI2Xga4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjhAt4eIT/UH82nLxU/wWPzUqb23+l30FrVs2omLN0wkMgxJTd5yXc21OtRffyBVnbJfhwh83rpLFwDkI+edBQHjXbzVVLPVDNHhWja72YRIMuciHAm9UXCB2CdEmKOXFOeVUVHVnvl9zfSrpIuXIma0AyDKZJPfoJIEYRgVhNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=p3bK6d8D; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-390ec7c2d40so2724433f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 03:40:18 -0800 (PST)
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
        b=BBfrxdcDTkV7QihRYcOrSea0Jh+mved6IG3uOdLbUwtc7fpnfzjbIoT6ZkwH8RFjE7
         8bV2KzpRqzGBTl3AqNOiEOrVQiLI/OZCLDM9nhH++o3bMC5ecRVsfZKjuFUQq/JclNY2
         4cGZX47fJ3GFslIPQNIOeAkHh2vmtGqjNTHpNJxXkEpTkYvUTGxBzxKvR2jK+3MTbHw/
         y/VPc+LQKrKXwmhzGb6ihCcM3jTrMX0kUf+p1Q6+AAzSHyMn/L1Z2P7/mXUYi2NcIxwA
         O2LUEzmZKzIBikJ7K7jmQ+TycjEGgmc1GauyZcwSb38Cg+B/T8qAZDf3N6KlkwldAtTa
         1kqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnNYUjYkq5pTN9FR0FESnWz8s/18hfmlQ5OlUnAcdp4DbU7EksNv3GjIr0xXrL9hWX3VQVDNZLHJLcNiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHSjWN3xuypSQPglmGS/dvGTbcZgWHgLtK6LzjHhz+GYq/EZ6L
	Lkq9vOMWdFjFtUASMLN/mJmZFHKfUykPbuzPZH26nUttPa3dyNTdWkHhxaAa3pA=
X-Gm-Gg: ASbGnctyBpKJOeAAjD6bN9BnoK83hFY//qH/j3vhyOAAqQLCdEFzESAZVov767oWVi/
	2hRyiGM+o9GmUqqQRxReB14nUCSoR/FF5zncg9PpAW6b2rJVpb78148LLB0HOFILT2mAYCCU0AK
	p1nqtm8gcoBR9DvtF/ZlO6g2EsYoNrir2uvTN9DSrKo7Wvv6PsJiRyCb7nRxCsUiYIkvUDLkx9P
	yFpy/AA4kPxjgr6z6q889bXu1vSM5sEMJe93aoN1R9gvYTOGyEdASU28brbLh9M++W6CiZFR5ph
	f6fL6M09HpX5AJFZKQilPBz+7o9jg18mfYugkJv9YYO5G5Jj9A/XQk8juovYj1vDrSvtZq0P
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
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1740781513-10090-1-git-send-email-longli@linuxonhyperv.com>
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dbM13H1zFxCY
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741711885.1255@mO2y3CdX4GwhzTr3bA5cgQ
X-ITU-MailScanner-SpamCheck: not spam

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


