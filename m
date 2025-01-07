Return-Path: <linux-rdma+bounces-6847-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A55BA03500
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 03:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 027303A4C84
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 02:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486BD8248D;
	Tue,  7 Jan 2025 02:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="l3iE6MmI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065252594AC;
	Tue,  7 Jan 2025 02:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736216294; cv=none; b=UzjY9HeQpxOUWoTyrq88nmSyKsRUJatz8U68OK8lNOS8XwMqqo4HqbnhKDZ4SLk7v4aMCkKEb0ILSShIF69otJ7b+HnEOr/SQS2KOvpPf6w6H1Ql+lmeH0d12pcKr/tUypCwZlU+o2OZuW/G/YfXDN9NKnVtyBYWVapyj/23Jq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736216294; c=relaxed/simple;
	bh=eJmghvnmLkFTCwMWfUEsH6NOY9e29K/vfw2TZb4n1gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a1NmIbCV2o1za0kGmN7Kw/HHsXwX9b70dkKrjZ+JRqbTH466LgPo3kmZc4C9bxCpjbVxPU4ytFCmLjVVcGFHPWVnOgZNUoeykUtO+Hi4rBBKOrUPl1ofDYM9i5OY3ns5DIrl3hrOXDYVyADJrUm0sGeDmY6TgKLPHeH/2GKG/ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=l3iE6MmI; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736216280; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=BrlAbkrmliPNS+hvATlVqovFmBYRnuxmyFSlNK1Sq/o=;
	b=l3iE6MmIoSXMdccqfkufggsnr9UqY5kEa3/YJsfL0n6f1Yi1yhwpWQX79KEphLr+hdeS/k8yuyut3Jgn9XkEev/8v39xP2cUdIsoQlXMHU244344G0rnhijIhi3jMM6gvWMBxNUYxPe5dshByHyT7KdiLJF8atR3vsbA/YnmAGg=
Received: from 30.221.145.177(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WN8xqgP_1736216279 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 07 Jan 2025 10:18:00 +0800
Message-ID: <a84414e8-bb69-4f63-84f6-80df89e3917a@linux.alibaba.com>
Date: Tue, 7 Jan 2025 10:17:57 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: use the correct ndev to find pnetid by
 pnetid table
To: Guangguan Wang <guangguan.wang@linux.alibaba.com>, wenjia@linux.ibm.com,
 jaka@linux.ibm.com, PASIC@de.ibm.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241227040455.91854-1-guangguan.wang@linux.alibaba.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <20241227040455.91854-1-guangguan.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/12/27 12:04, Guangguan Wang wrote:
> The command 'smc_pnet -a -I <ethx> <pnetid>' will add <pnetid>
> to the pnetid table and will attach the <pnetid> to net device
> whose name is <ethx>. But When do SMCR by <ethx>, in function
> smc_pnet_find_roce_by_pnetid, it will use <ethx>'s base ndev's
> pnetid to match rdma device, not <ethx>'s pnetid. The asymmetric
> use of the pnetid seems weird. Sometimes it is difficult to know
> the hierarchy of net device what may make it difficult to configure
> the pnetid and to use the pnetid. Looking into the history of
> commit, it was the commit 890a2cb4a966 ("net/smc: rework pnet table")
> that changes the ndev from the <ethx> to the <ethx>'s base ndev
> when finding pnetid by pnetid table. It seems a mistake.
> 
> This patch changes the ndev back to the <ethx> when finding pnetid
> by pnetid table.
> 
> Fixes: 890a2cb4a966 ("net/smc: rework pnet table")
> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>

It makes sense to me, thanks!

Reviewed-by: Wen Gu <guwen@linux.alibaba.com>

> ---
>   net/smc/smc_pnet.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
> index 716808f374a8..cc098780970b 100644
> --- a/net/smc/smc_pnet.c
> +++ b/net/smc/smc_pnet.c
> @@ -1079,14 +1079,15 @@ static void smc_pnet_find_roce_by_pnetid(struct net_device *ndev,
>   					 struct smc_init_info *ini)
>   {
>   	u8 ndev_pnetid[SMC_MAX_PNETID_LEN];
> +	struct net_device *base_ndev;
>   	struct net *net;
>   
> -	ndev = pnet_find_base_ndev(ndev);
> +	base_ndev = pnet_find_base_ndev(ndev);
>   	net = dev_net(ndev);
> -	if (smc_pnetid_by_dev_port(ndev->dev.parent, ndev->dev_port,
> +	if (smc_pnetid_by_dev_port(base_ndev->dev.parent, base_ndev->dev_port,
>   				   ndev_pnetid) &&
>   	    smc_pnet_find_ndev_pnetid_by_table(ndev, ndev_pnetid)) {
> -		smc_pnet_find_rdma_dev(ndev, ini);
> +		smc_pnet_find_rdma_dev(base_ndev, ini);
>   		return; /* pnetid could not be determined */
>   	}
>   	_smc_pnet_find_roce_by_pnetid(ndev_pnetid, ini, NULL, net);

