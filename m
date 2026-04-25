Return-Path: <linux-rdma+bounces-19545-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHAACvmK7GmtZgAAu9opvQ
	(envelope-from <linux-rdma+bounces-19545-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Apr 2026 11:35:53 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7875465B35
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Apr 2026 11:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5ED00300CC08
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Apr 2026 09:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86E9386C25;
	Sat, 25 Apr 2026 09:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="NhDkwtUJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131FA291864;
	Sat, 25 Apr 2026 09:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777109722; cv=none; b=IxKx3h8gjkqsaO7cLHGyNWLr/fcPF249FbiRIp//dG29HL7Z/gBNIMCStvlZFBO/gKF//R2gz6qtvlp4HI7mLvqIjEnBwhwO+qrz4B6Obh2EnDti8ihSK3jGEIoa25rq6Pny011m4PG3tW4tjs6ySzrvn1JivmMCnIXPgqgW3Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777109722; c=relaxed/simple;
	bh=LQPnE0yGcQn7HycJmDAgXmRpDVz1POSk7D4JnPb7erI=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nXvcdBwYDpn7Q5csmEls0kPJCdX5gXVXDang7OInfVUEEsKWnAsj8SsYhvOxBh59plXVT1mcIfQG/Yf7gv2fGvuWV6dQbHML5jrNPJZp2q+qJrQOSV8PjZW790wwVJd40vcWFQ4G6L3pUrWG4HfsF/vxL4x0+blcJa2jdvffzDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=NhDkwtUJ; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=WC16CckvRz6XfRpMJ3/ZX+wdcc3h6T3wHCMFNEI8I70=;
	b=NhDkwtUJE6uaGFBKF0xoGNXE10EsTkQrjBR3cO+7iebuTAx7PiBUCmsk5wUxphsUucgbkqUnK
	bFJpC5Q1qrG5o8o8lXQgD5Kd1nwwFsnoSfDGlIVj8s/k0k10vEPeiPh6freRY4J6d1iM/5BRAtA
	gRYp0jeg35GOffo063lR9o4=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4g2kzL3qFVzLlSv;
	Sat, 25 Apr 2026 17:28:46 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 393924056F;
	Sat, 25 Apr 2026 17:35:10 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Sat, 25 Apr 2026 17:35:09 +0800
Message-ID: <6ae96ead-61b3-470a-a30b-3418350a45f0@huawei.com>
Date: Sat, 25 Apr 2026 17:35:08 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>
Subject: Re: [PATCH v4 net 3/3] net: hns3: fix CWR handling in drivers to
 preserve ACE signal
To: <chia-yu.chang@nokia-bell-labs.com>, <linyunsheng@huawei.com>,
	<andrew+netdev@lunn.ch>, <parav@nvidia.com>, <jasowang@redhat.com>,
	<mst@redhat.com>, <shenjian15@huawei.com>, <salil.mehta@huawei.com>,
	<saeedm@nvidia.com>, <tariqt@nvidia.com>, <mbloch@nvidia.com>,
	<leonro@nvidia.com>, <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <ij@kernel.org>,
	<ncardwell@google.com>, <koen.de_schepper@nokia-bell-labs.com>,
	<g.white@cablelabs.com>, <ingemar.s.johansson@ericsson.com>,
	<mirja.kuehlewind@ericsson.com>, <cheshire@apple.com>, <rs.ietf@gmx.at>,
	<Jason_Livingood@comcast.com>, <vidhi_goel@apple.com>
References: <20260417152642.71674-1-chia-yu.chang@nokia-bell-labs.com>
 <20260417152642.71674-4-chia-yu.chang@nokia-bell-labs.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20260417152642.71674-4-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk100013.china.huawei.com (7.202.194.61)
X-Rspamd-Queue-Id: C7875465B35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[nokia-bell-labs.com,huawei.com,lunn.ch,nvidia.com,redhat.com,vger.kernel.org,davemloft.net,google.com,kernel.org,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19545-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shaojijie@huawei.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nokia-bell-labs.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]


on 2026/4/17 23:26, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> Currently, hns3 Rx paths use SKB_GSO_TCP_ECN flag when a TCP segment
> with the CWR flag set. This is wrong because SKB_GSO_TCP_ECN is only
> valid for RFC3168 ECN on Tx, and using it on Rx allows RFC3168 ECN
> offload to clear the CWR flag. As a result, incoming TCP segments
> lose their ACE signal integrity required for AccECN (RFC9768),
> especially when the packet is forwarded and later re-segmented by GSO.
>
> Fix this by setting SKB_GSO_TCP_ACCECN for any Rx segment with the CWR
> flag set. SKB_GSO_TCP_ACCECN ensure that RFC3168 ECN offload will
> not clear the CWR flag, therefore preserving the ACE signal.
>
> Fixes: d474d88f88261 ("net: hns3: add hns3_gro_complete for HW GRO process")
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> ---
>   drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> index a3206c97923e..e1b0dba56182 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> @@ -3904,7 +3904,7 @@ static int hns3_gro_complete(struct sk_buff *skb, u32 l234info)
>   
>   	skb_shinfo(skb)->gso_segs = NAPI_GRO_CB(skb)->count;
>   	if (th->cwr)
> -		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ECN;
> +		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
>   
>   	if (l234info & BIT(HNS3_RXD_GRO_FIXID_B))
>   		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_FIXEDID;

I agree with Paolo's previous point;
for already released hardware, it is indeed not suitable to modify it.
During the hardware aggregation process, the ACE signal may have already been lost.

Jijie Shao




