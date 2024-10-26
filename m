Return-Path: <linux-rdma+bounces-5525-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D9D9B13DA
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Oct 2024 02:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12DCC1F229BB
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Oct 2024 00:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686598488;
	Sat, 26 Oct 2024 00:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oiuZBBsv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE30F1388;
	Sat, 26 Oct 2024 00:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729903370; cv=none; b=tasToYiGkRoBA+VWnnf8FirVbP3Luvv1RdQx6F6rkmbrIcPxi0OigzOWlgc/fBZVTPV99Yl5x5QjLm8HuHHVpTjxWVgS5BnQZ6nK/R4dI8oWf1tbM5K+kQ/qyHa+Vw3h7we9vAEXHs09u89LAO4JLnRUnJzTe3lX+wILjrsShno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729903370; c=relaxed/simple;
	bh=+b2sWTz3hwtYXk3pZLvRyO5rNRS4CtQFgRu3RPzx9lM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCzd2vCN9fzzhzVYq8D3ornUW6ktW8eKUIFzgGmW/l2UBCZE2EH8jj6UTTzaekGbSuGEdv2oiIAJE30zHFciqvVKvbm3b/gsGpVM9kZT5eVF7Di3KDy+PmPH3EPScwkU3455NaFYOCaqBDRgssRAYojxrQNMrNiYC2oz83/bREE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oiuZBBsv; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729903359; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=dAhdbugx+wh7RVvcf9zYMWRkick2x+Y7+PPYR5b5v9U=;
	b=oiuZBBsv55Rs26mQRTY3ABLr7RmN7q2JOXJn/Am7CPG3wqNBP/q7PA/o9B8ZP5t+pZwe8rkkHp49XG56YQWUZjb9wSoHOt74MMhc/9YR+KFJM7PiCr42h8f37aG+RdWfnByn182iNQfYZo/6kBA6+7or/HD2BTsslAHORMwkhf4=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WHtcm5f_1729903357 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 26 Oct 2024 08:42:38 +0800
Date: Sat, 26 Oct 2024 08:42:37 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Wenjia Zhang <wenjia@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Nils Hoppmann <niho@linux.ibm.com>,
	Niklas Schnell <schnelle@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Karsten Graul <kgraul@linux.ibm.com>,
	Stefan Raspl <raspl@linux.ibm.com>, Aswin K <aswin@linux.ibm.com>
Subject: Re: [PATCH net] net/smc: Fix lookup of netdev by using
 ib_device_get_netdev()
Message-ID: <20241026004237.GE36583@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20241025072356.56093-1-wenjia@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025072356.56093-1-wenjia@linux.ibm.com>

On 2024-10-25 09:23:55, Wenjia Zhang wrote:
>Commit c2261dd76b54 ("RDMA/device: Add ib_device_set_netdev() as an
>alternative to get_netdev") introduced an API ib_device_get_netdev.
>The SMC-R variant of the SMC protocol continued to use the old API
>ib_device_ops.get_netdev() to lookup netdev. As this commit 8d159eb2117b
>("RDMA/mlx5: Use IB set_netdev and get_netdev functions") removed the
>get_netdev callback from mlx5_ib_dev_common_roce_ops, calling
>ib_device_ops.get_netdev didn't work any more at least by using a mlx5
>device driver. Thus, using ib_device_set_netdev() now became mandatory.
>
>Replace ib_device_ops.get_netdev() with ib_device_get_netdev().
>
>Fixes: 54903572c23c ("net/smc: allow pnetid-less configuration")
>Fixes: 8d159eb2117b ("RDMA/mlx5: Use IB set_netdev and get_netdev functions")
>Reported-by: Aswin K <aswin@linux.ibm.com>
>Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
>Signed-off-by: Wenjia Zhang <wenjia@linux.ibm.com>

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>

>---
> net/smc/smc_ib.c   | 8 ++------
> net/smc/smc_pnet.c | 4 +---
> 2 files changed, 3 insertions(+), 9 deletions(-)
>
>diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
>index 9297dc20bfe2..9c563cdbea90 100644
>--- a/net/smc/smc_ib.c
>+++ b/net/smc/smc_ib.c
>@@ -899,9 +899,7 @@ static void smc_copy_netdev_ifindex(struct smc_ib_device *smcibdev, int port)
> 	struct ib_device *ibdev = smcibdev->ibdev;
> 	struct net_device *ndev;
> 
>-	if (!ibdev->ops.get_netdev)
>-		return;
>-	ndev = ibdev->ops.get_netdev(ibdev, port + 1);
>+	ndev = ib_device_get_netdev(ibdev, port + 1);
> 	if (ndev) {
> 		smcibdev->ndev_ifidx[port] = ndev->ifindex;
> 		dev_put(ndev);
>@@ -921,9 +919,7 @@ void smc_ib_ndev_change(struct net_device *ndev, unsigned long event)
> 		port_cnt = smcibdev->ibdev->phys_port_cnt;
> 		for (i = 0; i < min_t(size_t, port_cnt, SMC_MAX_PORTS); i++) {
> 			libdev = smcibdev->ibdev;
>-			if (!libdev->ops.get_netdev)
>-				continue;
>-			lndev = libdev->ops.get_netdev(libdev, i + 1);
>+			lndev = ib_device_get_netdev(libdev, i + 1);
> 			dev_put(lndev);
> 			if (lndev != ndev)
> 				continue;
>diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
>index 1dd362326c0a..8566937c8903 100644
>--- a/net/smc/smc_pnet.c
>+++ b/net/smc/smc_pnet.c
>@@ -1054,9 +1054,7 @@ static void smc_pnet_find_rdma_dev(struct net_device *netdev,
> 		for (i = 1; i <= SMC_MAX_PORTS; i++) {
> 			if (!rdma_is_port_valid(ibdev->ibdev, i))
> 				continue;
>-			if (!ibdev->ibdev->ops.get_netdev)
>-				continue;
>-			ndev = ibdev->ibdev->ops.get_netdev(ibdev->ibdev, i);
>+			ndev = ib_device_get_netdev(ibdev->ibdev, i);
> 			if (!ndev)
> 				continue;
> 			dev_put(ndev);
>-- 
>2.43.0
>

