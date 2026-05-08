Return-Path: <linux-rdma+bounces-20233-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKPmKX3H/WkpigAAu9opvQ
	(envelope-from <linux-rdma+bounces-20233-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 13:22:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 726504F5B15
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 13:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D3D88301AA7E
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2026 11:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9869397E92;
	Fri,  8 May 2026 11:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="dCNo/pXx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57542391837;
	Fri,  8 May 2026 11:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778239353; cv=none; b=os/i5IPj9CT9Z50Q2rg8nYPHrw9xjxjuLigh1H0GxrqkpztsVQ10j1qCAFuJ5PRb6LyNYRv7k6C+RNkBQoKEi5ekAI7gNBSAuZbFKUdp+Fe1L5oNF2Hpt+9yBa1XR3f2TY4/K72diaS+QAcxuLKyJ8BEs+UplD8XI+VPDxZjoNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778239353; c=relaxed/simple;
	bh=TefaeVnDgO5HJw5krNA7gKg08j918DZOBjY3E/uSDL8=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=L5MzNVF5s/Xjch6waw3lklJTweUUrR/rQgmhHRYoSA9IxxlfUYJzyB2d8kQv18K/mfo3RkH9WAqk5UXoIMSWEDyxyzF6RoyWK8G6VDTwTqf1k9+WC+/aCxO/d6G1bas+dLv/BszGjbT/B6Ir8KA8noSTyFwV25nPVU/v3mUyrHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=dCNo/pXx; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=mk8T4h2POm1Gh7v/THTjLkFeyRD4K+Mhi0S9q4bCysw=;
	b=dCNo/pXxvVfaTcACa5UroQNo5tXlDbrIre1YJu694RHuZCQV80PJDLf4+FR4zsCaT+VPlTJMC
	nqfRIaQ0P8j+BDT1rT0xJISfzwh2BJHt9kgw0NnUtXkIGPNHJBKmNmz6m7HVrHelVGGhubiyvAG
	muo0A8DGm9Ry1X2QfaUvIKg=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gBmjf4s4dzmV8k;
	Fri,  8 May 2026 19:14:46 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id E223D402AB;
	Fri,  8 May 2026 19:22:21 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 8 May 2026 19:22:20 +0800
Message-ID: <47530dd8-cba6-4282-ae80-4cabd52b08bc@huawei.com>
Date: Fri, 8 May 2026 19:22:19 +0800
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
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>,
	"linyunsheng@huawei.com" <linyunsheng@huawei.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "parav@nvidia.com" <parav@nvidia.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
	<mst@redhat.com>, "shenjian15@huawei.com" <shenjian15@huawei.com>,
	"salil.mehta@huawei.com" <salil.mehta@huawei.com>, "saeedm@nvidia.com"
	<saeedm@nvidia.com>, "tariqt@nvidia.com" <tariqt@nvidia.com>,
	"mbloch@nvidia.com" <mbloch@nvidia.com>, "leonro@nvidia.com"
	<leonro@nvidia.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "ij@kernel.org" <ij@kernel.org>,
	"ncardwell@google.com" <ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
	<g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
References: <20260417152642.71674-1-chia-yu.chang@nokia-bell-labs.com>
 <20260417152642.71674-4-chia-yu.chang@nokia-bell-labs.com>
 <6ae96ead-61b3-470a-a30b-3418350a45f0@huawei.com>
 <PAXPR07MB7984A31018E9B85DEC28B68CA3282@PAXPR07MB7984.eurprd07.prod.outlook.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <PAXPR07MB7984A31018E9B85DEC28B68CA3282@PAXPR07MB7984.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk100013.china.huawei.com (7.202.194.61)
X-Rspamd-Queue-Id: 726504F5B15
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20233-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[nokia-bell-labs.com,huawei.com,lunn.ch,nvidia.com,redhat.com,vger.kernel.org,davemloft.net,google.com,kernel.org,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shaojijie@huawei.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action


on 2026/4/25 22:30, Chia-Yu Chang (Nokia) wrote:
>> -----Original Message-----
>> From: Jijie Shao <shaojijie@huawei.com>
>> Sent: Saturday, April 25, 2026 11:35 AM
>> To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>; linyunsheng@huawei.com; andrew+netdev@lunn.ch; parav@nvidia.com; jasowang@redhat.com; mst@redhat.com; shenjian15@huawei.com; salil.mehta@huawei.com; saeedm@nvidia.com; tariqt@nvidia.com; mbloch@nvidia.com; leonro@nvidia.com; linux-rdma@vger.kernel.org; netdev@vger.kernel.org; davem@davemloft.net; edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; horms@kernel.org; ij@kernel.org; ncardwell@google.com; Koen De Schepper (Nokia) <koen.de_schepper@nokia-bell-labs.com>; g.white@cablelabs.com; ingemar.s.johansson@ericsson.com; mirja.kuehlewind@ericsson.com; cheshire@apple.com; rs.ietf@gmx.at; Jason_Livingood@comcast.com; vidhi_goel@apple.com
>> Cc: shaojijie@huawei.com
>> Subject: Re: [PATCH v4 net 3/3] net: hns3: fix CWR handling in drivers to preserve ACE signal
>>
>>
>> on 2026/4/17 23:26, chia-yu.chang@nokia-bell-labs.com wrote:
>>> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>>>
>>> Currently, hns3 Rx paths use SKB_GSO_TCP_ECN flag when a TCP segment
>>> with the CWR flag set. This is wrong because SKB_GSO_TCP_ECN is only
>>> valid for RFC3168 ECN on Tx, and using it on Rx allows RFC3168 ECN
>>> offload to clear the CWR flag. As a result, incoming TCP segments lose
>>> their ACE signal integrity required for AccECN (RFC9768), especially
>>> when the packet is forwarded and later re-segmented by GSO.
>>>
>>> Fix this by setting SKB_GSO_TCP_ACCECN for any Rx segment with the CWR
>>> flag set. SKB_GSO_TCP_ACCECN ensure that RFC3168 ECN offload will not
>>> clear the CWR flag, therefore preserving the ACE signal.
>>>
>>> Fixes: d474d88f88261 ("net: hns3: add hns3_gro_complete for HW GRO
>>> process")
>>> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>>> ---
>>>    drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
>>> b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
>>> index a3206c97923e..e1b0dba56182 100644
>>> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
>>> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
>>> @@ -3904,7 +3904,7 @@ static int hns3_gro_complete(struct sk_buff
>>> *skb, u32 l234info)
>>>    
>>>    	skb_shinfo(skb)->gso_segs = NAPI_GRO_CB(skb)->count;
>>>    	if (th->cwr)
>>> -		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ECN;
>>> +		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
>>>    
>>>    	if (l234info & BIT(HNS3_RXD_GRO_FIXID_B))
>>>    		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_FIXEDID;
>> I agree with Paolo's previous point;
>> for already released hardware, it is indeed not suitable to modify it.
>> During the hardware aggregation process, the ACE signal may have already been lost.
>>
>> Jijie Shao
> Hi Jijie,
>
> I would disagree with not fixing on released hardware. (Did Paolo explicit mention that?)
> The ACCECN protocol is based on ACE signal, and a broken ACE signal might be due to SKB_GSO_TCP_ECN at the RX path.
> You can see the explicit explanations and examples in the commit message.
> There is already a fix in patch 4e4f7cefb130af6aba6a393b2d13930b49390df9 for tcp_gro_receive() of tcp_offload.c
>
> And In this patch series, we would like to propose the similar fix on hns3 and mlx5e.
> While one main issue is to confirm is how the GRO is done in the corresponding HW-GRO.
> And if the driver can be safely changed from SKB_GSO_TCP_ECN to SKB_GSO_TCP_ACCECN, then we can ensure ECN and AccECN can be supported over existing hardware.

Sorry for the late reply.

It is confirmed that ACC_ECN is not supported.
HW-GRO will set the TOS field to 0.

Jijie Shao



