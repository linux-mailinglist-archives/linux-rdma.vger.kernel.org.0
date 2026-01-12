Return-Path: <linux-rdma+bounces-15455-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A54F4D12436
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 12:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A1E663019C61
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 11:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAD0356A0F;
	Mon, 12 Jan 2026 11:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="AD7f0bZ+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD754356A18;
	Mon, 12 Jan 2026 11:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768216967; cv=none; b=kttis/RD5XvlCcXFqMF/IB1X+DiYWUywbPMSB8Jl3yjpWVW0r9BxfLK2bBXW2HEl96B2u09NjAlIi5XcZha0HtcxfD0rpxZ4pCTluBOUHHfyjX96eAH+zYGunmwt1DAIEb7uUEWi3H3Q51vzuKLJxGX+dPjtmwsngfV7AJbRtyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768216967; c=relaxed/simple;
	bh=wHINRcFIg9zMRYnWoIA5DvfXXX2LdiW47hI/Zj2u9fo=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Mns8ywApmeiFdb5UplS8GCy4tD/0PmEiaApPAxmElTgOtu/GQudLLzZw2wBvMi21/aCanKPeAg9e/mMpAOioNlnkLroUf1Su4JkHXeqnGOi3t1/0jSN2gBvqcFg7iBJiX6a1oIlU5IB1YJJphGdkrIozSvNsEIP8J9fLHYrrmI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=AD7f0bZ+; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=vbDYGIXXRXLnCmsRtUPUIjw1vXocJzMCGRQqtNEDzgY=;
	b=AD7f0bZ+NL61KYTnk8rvo+Xd3BitgZNT4IGtXVpTpFnOIhMzgy8IyMednDhlh7SbdF/41PuA1
	1lcOKTfDeYk8mGx8sRtllCtTpxxRvOqoQVf23PC+EmKdconn/tamS7SSz1rZIt+GRzXca0kS5dd
	HhFDvh4c9anppPLqt3lSXj4=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4dqVJS6CsFz1K96f;
	Mon, 12 Jan 2026 19:19:20 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 3F53340562;
	Mon, 12 Jan 2026 19:22:37 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 12 Jan 2026 19:22:35 +0800
Message-ID: <6c01abe2-7d0f-47d9-b4db-098e11b2b9e6@huawei.com>
Date: Mon, 12 Jan 2026 19:22:33 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, Jian Shen <shenjian15@huawei.com>, Salil Mehta
	<salil.mehta@huawei.com>, Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Shahar Shitrit <shshitrit@nvidia.com>, Yael Chemla
	<ychemla@nvidia.com>, Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH net-next V2 2/3] net: hns3: Use netif_xmit_timeout_ms()
 helper
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
References: <1768209383-1546791-1-git-send-email-tariqt@nvidia.com>
 <1768209383-1546791-3-git-send-email-tariqt@nvidia.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <1768209383-1546791-3-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2026/1/12 17:16, Tariq Toukan wrote:
> From: Shahar Shitrit <shshitrit@nvidia.com>
>
> Replace the open-coded TX queue timeout check
> in hns3_get_timeout_queue() with a call to
> netif_xmit_timeout_ms() helper.
>
> Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
> Reviewed-by: Yael Chemla <ychemla@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Thanks,
Reviewed-by: Jijie Shao <shaojijie@huawei.com>

> ---
>   drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> index 7a0654e2d3dd..7b9269f6fdfc 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> @@ -25,6 +25,7 @@
>   #include <net/tcp.h>
>   #include <net/vxlan.h>
>   #include <net/geneve.h>
> +#include <net/netdev_queues.h>
>   
>   #include "hnae3.h"
>   #include "hns3_enet.h"
> @@ -2807,14 +2808,12 @@ static int hns3_get_timeout_queue(struct net_device *ndev)
>   
>   	/* Find the stopped queue the same way the stack does */
>   	for (i = 0; i < ndev->num_tx_queues; i++) {
> +		unsigned int timedout_ms;
>   		struct netdev_queue *q;
> -		unsigned long trans_start;
>   
>   		q = netdev_get_tx_queue(ndev, i);
> -		trans_start = READ_ONCE(q->trans_start);
> -		if (netif_xmit_stopped(q) &&
> -		    time_after(jiffies,
> -			       (trans_start + ndev->watchdog_timeo))) {
> +		timedout_ms = netif_xmit_timeout_ms(q);
> +		if (timedout_ms) {
>   #ifdef CONFIG_BQL
>   			struct dql *dql = &q->dql;
>   
> @@ -2823,8 +2822,7 @@ static int hns3_get_timeout_queue(struct net_device *ndev)
>   				    dql->adj_limit, dql->num_completed);
>   #endif
>   			netdev_info(ndev, "queue state: 0x%lx, delta msecs: %u\n",
> -				    q->state,
> -				    jiffies_to_msecs(jiffies - trans_start));
> +				    q->state, timedout_ms);
>   			break;
>   		}
>   	}

