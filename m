Return-Path: <linux-rdma+bounces-5532-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0339B1D5A
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2024 12:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3B3AB211CB
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2024 11:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D1C1422AB;
	Sun, 27 Oct 2024 11:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YJffDRJL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA278161;
	Sun, 27 Oct 2024 11:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730027897; cv=none; b=cEnDxyGHDwRuXQHDACKLqP5RjMtpDvWHLXs27u5F5ZTiJv6zwE1p9kBog9t8UWGUOeP6GSa8onG9QoL8hNie0lnBxQCDAZhXJcy3PFq9C5kgf3x6XtoHehY/spXbWP244ePnDd5n8I5+B/5sVe7m2r5ueTCap6gUvQLuSlG+h78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730027897; c=relaxed/simple;
	bh=1t0hPj5j/GoJWCB+D9JDiK6Ur3FebwDE732vMCkQfas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jGeFpVRzE56z7MwWPpQVd8RwktPSxquCGcKh5PxmhEIzFCuTiX7V7sm6Ydzxaw3r+p53U/Iv5MMf1dsrpl3APrUAdcDg9KMxJiE8aTqRITQnN+o4d2vFPZq8W8PvYMe92QHJ8BZZ01MKMgJ0ALPIWG0+6u8fAzvEE/HyuBV01/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YJffDRJL; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730027883; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=SMAOEmNZAtuLgKjy34T7btJXdrvMUuoF7jRJ7UBb9Zg=;
	b=YJffDRJLNzncT9zQNakw9VLtciuvTQcZ+vwEoqYpv91SgNkz0m8BAEwCpmWDOYEYbZIwUggEngXiKbta2skKrxNxlyeeh6NeJcyxzi4cWJ64lotCCex4kR9MIdBo0vyYRav2a4JeFd9sJekxtGteURedN4NzaB6nQeE38l4uHx8=
Received: from 30.212.186.15(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WHxbQlB_1730027880 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 27 Oct 2024 19:18:03 +0800
Message-ID: <456e2ab1-d137-45e0-a130-eef1ffb582a4@linux.alibaba.com>
Date: Sun, 27 Oct 2024 19:18:00 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: Fix lookup of netdev by using
 ib_device_get_netdev()
To: Wenjia Zhang <wenjia@linux.ibm.com>, "D. Wythe"
 <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 Jan Karcher <jaka@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>,
 Alexandra Winter <wintera@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Nils Hoppmann <niho@linux.ibm.com>, Niklas Schnell <schnelle@linux.ibm.com>,
 Thorsten Winkler <twinkler@linux.ibm.com>,
 Karsten Graul <kgraul@linux.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>,
 Aswin K <aswin@linux.ibm.com>
References: <20241025072356.56093-1-wenjia@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <20241025072356.56093-1-wenjia@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/10/25 15:23, Wenjia Zhang wrote:
> Commit c2261dd76b54 ("RDMA/device: Add ib_device_set_netdev() as an
> alternative to get_netdev") introduced an API ib_device_get_netdev.
> The SMC-R variant of the SMC protocol continued to use the old API
> ib_device_ops.get_netdev() to lookup netdev. As this commit 8d159eb2117b
> ("RDMA/mlx5: Use IB set_netdev and get_netdev functions") removed the
> get_netdev callback from mlx5_ib_dev_common_roce_ops, calling
> ib_device_ops.get_netdev didn't work any more at least by using a mlx5
> device driver. Thus, using ib_device_set_netdev() now became mandatory.
> 
> Replace ib_device_ops.get_netdev() with ib_device_get_netdev().
> 
> Fixes: 54903572c23c ("net/smc: allow pnetid-less configuration")
> Fixes: 8d159eb2117b ("RDMA/mlx5: Use IB set_netdev and get_netdev functions")
> Reported-by: Aswin K <aswin@linux.ibm.com>
> Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
> Signed-off-by: Wenjia Zhang <wenjia@linux.ibm.com>

LGTM!

Reviewed-by: Wen Gu <guwen@linux.alibaba.com>

> ---
>   net/smc/smc_ib.c   | 8 ++------
>   net/smc/smc_pnet.c | 4 +---
>   2 files changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
> index 9297dc20bfe2..9c563cdbea90 100644
> --- a/net/smc/smc_ib.c
> +++ b/net/smc/smc_ib.c
> @@ -899,9 +899,7 @@ static void smc_copy_netdev_ifindex(struct smc_ib_device *smcibdev, int port)
>   	struct ib_device *ibdev = smcibdev->ibdev;
>   	struct net_device *ndev;
>   
> -	if (!ibdev->ops.get_netdev)
> -		return;
> -	ndev = ibdev->ops.get_netdev(ibdev, port + 1);
> +	ndev = ib_device_get_netdev(ibdev, port + 1);
>   	if (ndev) {
>   		smcibdev->ndev_ifidx[port] = ndev->ifindex;
>   		dev_put(ndev);
> @@ -921,9 +919,7 @@ void smc_ib_ndev_change(struct net_device *ndev, unsigned long event)
>   		port_cnt = smcibdev->ibdev->phys_port_cnt;
>   		for (i = 0; i < min_t(size_t, port_cnt, SMC_MAX_PORTS); i++) {
>   			libdev = smcibdev->ibdev;
> -			if (!libdev->ops.get_netdev)
> -				continue;
> -			lndev = libdev->ops.get_netdev(libdev, i + 1);
> +			lndev = ib_device_get_netdev(libdev, i + 1);
>   			dev_put(lndev);
>   			if (lndev != ndev)
>   				continue;
> diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
> index 1dd362326c0a..8566937c8903 100644
> --- a/net/smc/smc_pnet.c
> +++ b/net/smc/smc_pnet.c
> @@ -1054,9 +1054,7 @@ static void smc_pnet_find_rdma_dev(struct net_device *netdev,
>   		for (i = 1; i <= SMC_MAX_PORTS; i++) {
>   			if (!rdma_is_port_valid(ibdev->ibdev, i))
>   				continue;
> -			if (!ibdev->ibdev->ops.get_netdev)
> -				continue;
> -			ndev = ibdev->ibdev->ops.get_netdev(ibdev->ibdev, i);
> +			ndev = ib_device_get_netdev(ibdev->ibdev, i);
>   			if (!ndev)
>   				continue;
>   			dev_put(ndev);

