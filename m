Return-Path: <linux-rdma+bounces-8696-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B71A60CC7
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Mar 2025 10:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D578461554
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Mar 2025 09:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142C71DE2C1;
	Fri, 14 Mar 2025 09:07:41 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8AB2AF00
	for <linux-rdma@vger.kernel.org>; Fri, 14 Mar 2025 09:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741943260; cv=none; b=rTJ+X0IBMDuoLXdNySqlUJYs/OISEaE28njCmjD/iF6qQFQE0YsJJD9YfuCjzX3BZojJTmzGWbJ9cxNgaVnae0Tj9jmAuOlstfPWVQW+A5IvLjp+fdepG4LstfIvzbIQmWbBjQvS47vMQsWNxT/41J7u6EPm+NxYHVSk9o5fnTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741943260; c=relaxed/simple;
	bh=b9oRKc+XrMkdIjD6kwQijixoJXFshN32RoFRwpDcncY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gadtxykwNMwHDhN1X+CgbR7Te9G71Cy1Qh5NCGwK1icinoLyo7rXNza1n+wtDtQAKD4LACh2xzbLyfAg/J3TVrsQd6qOrICPdlEjkpx8XrqfMZuSBLij8eY1I5jcQMit87YnzQ9zDHlp39o6aXaCKunQd5i7RJVXFzMpGqiKM7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c200159600b311f0a216b1d71e6e1362-20250314
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:73c814a7-dfb4-43e7-b6e8-6d2d96a9f713,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:7db09b3e08c96f98d04eed1e7bc80b01,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c200159600b311f0a216b1d71e6e1362-20250314
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <luoxuanqiang@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1797440584; Fri, 14 Mar 2025 17:07:30 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 138F5B804EA6;
	Fri, 14 Mar 2025 17:07:30 +0800 (CST)
X-ns-mid: postfix-67D3F1D1-9963111704
Received: from [10.42.20.130] (unknown [10.42.20.130])
	by node2.com.cn (NSMail) with ESMTPA id BCC7EB804EA4;
	Fri, 14 Mar 2025 09:07:29 +0000 (UTC)
Message-ID: <e668dbc4-fcf4-4814-88a6-9923d8bdd918@kylinos.cn>
Date: Fri, 14 Mar 2025 17:07:28 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [PATCH net-next] RDMA/device: Change dev_hold() to
 netdev_hold() in ib_device_get_netdev()
To: luoxuanqiang <xuanqiang.luo@linux.dev>, leon@kernel.org,
 linux-rdma@vger.kernel.org
Cc: eric.dumazet@gmail.com
References: <20250314085451.1551714-1-xuanqiang.luo@linux.dev>
From: luoxuanqiang <luoxuanqiang@kylinos.cn>
In-Reply-To: <20250314085451.1551714-1-xuanqiang.luo@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Please ignore the previous email. I overlooked some logic. Sorry for the=20
disturbance.

=E5=9C=A8 2025/3/14 16:54, luoxuanqiang =E5=86=99=E9=81=93:
> From: luoxuanqiang <luoxuanqiang@kylinos.cn>
>
> When adding the "netdevice ref tracker" mechanism to ib_port_data, the
> dev_hold() in ib_device_get_netdev() was missed, which may cause false
> alarms of ref leak. Replace dev_hold() with netdev_hold() to fix it.
>
> Fixes: 09f530f0c6d6 ("RDMA: Add netdevice_tracker to ib_device_set_netd=
ev()")
> Signed-off-by: luoxuanqiang <luoxuanqiang@kylinos.cn>
> ---
>   drivers/infiniband/core/device.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core=
/device.c
> index 0ded91f056f3..f65a7e2b4f2b 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -2270,7 +2270,7 @@ struct net_device *ib_device_get_netdev(struct ib=
_device *ib_dev,
>   		spin_lock(&pdata->netdev_lock);
>   		res =3D rcu_dereference_protected(
>   			pdata->netdev, lockdep_is_held(&pdata->netdev_lock));
> -		dev_hold(res);
> +		netdev_hold(res, &pdata->netdev_tracker, GFP_ATOMIC);
>   		spin_unlock(&pdata->netdev_lock);
>   	}
>  =20

