Return-Path: <linux-rdma+bounces-8639-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1845FA5ED44
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 08:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D4A7179228
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 07:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D26D25FA0E;
	Thu, 13 Mar 2025 07:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PggQ7cNO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5791C84AA;
	Thu, 13 Mar 2025 07:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741852070; cv=none; b=uJ8y9kooR3EICvreQUQdmQqv8q3DzI8tv7WDhxMn6OtQK3WZc912+ts7Lu+65snJzXgQZFdNXAlMdiD/M2a6kIs+q2mXf4+ioipKPirzm6CuMKWLSuDwcqeZeyDhvJ/N9lqfNqjFvd/BTj0+M1uOl0H4DSCQ1wG+GPLXOFWIemk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741852070; c=relaxed/simple;
	bh=W3UPsC0myzOAp3Fllix+rHiBPdE0rsYU/7717F4GDZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iOOLIXa8tzWJ8Am1iDAwVxY24u7MC9PhHDTftq2aqVDxy0LbLZXwP3+lWEBnGK4tAv5X3GxPrvc8em0Rizzssbgkmrx1oYza5WHQgJro3btAzkG4lIUWfBAzbJlxcmhzSMT9g5QNwYLdIJRbDBPQ43YjqX5vIrst8c4SNmZ5XXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PggQ7cNO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CKZoIu026642;
	Thu, 13 Mar 2025 07:47:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6KKLZv
	+Ah3wluN0jEfHqdNL/PYQ+sFgKqpAxlzMlagg=; b=PggQ7cNOWRJXkg4gBqwZnR
	lLAkdI8ACoWhJJ6/QN+fMzdfX5GY6wHp9ox8q/BqvFAWNrV0pfUwDLSqBTkXbq7K
	pl1J758W3YxKSJpRnXwsSeGVYKo33NjQTodJm/2iMb8+mYssMVt6nggsmD43L//H
	7wl3v3pmr8x/MZwCh8lv37ZUYlKsVU21X7Rdr6tV/RdPiPQ6a/xs4DjKMMLdkO5n
	tpeSEyyAYmfzkrJGJdtmsXCg1yeiy7q8FALgza+O931Jn30DHtnOT9xnWQbK9N26
	llDtRzAvMrhhoOdUL2zTQj0MJEkNCu2PU2F+x7fHzsF5NO62rcWuLWirYFpKQZ+A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45bhepj9gv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 07:47:41 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52D7VU1H017576;
	Thu, 13 Mar 2025 07:47:40 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45bhepj9gs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 07:47:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52D4mhNq026166;
	Thu, 13 Mar 2025 07:47:39 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45atspgjva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 07:47:39 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52D7lccr28770854
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 07:47:38 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 197405806F;
	Thu, 13 Mar 2025 07:47:38 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1424758087;
	Thu, 13 Mar 2025 07:46:58 +0000 (GMT)
Received: from [9.179.27.216] (unknown [9.179.27.216])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Mar 2025 07:46:57 +0000 (GMT)
Message-ID: <80afe99b-ca14-4b21-a200-1d695ed6ae63@linux.ibm.com>
Date: Thu, 13 Mar 2025 08:46:57 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net/smc: use the correct ndev to find pnetid
 by pnetid table
To: Guangguan Wang <guangguan.wang@linux.alibaba.com>, pasic@linux.ibm.com,
        jaka@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
        mjambigi@linux.ibm.com, sidraya@linux.ibm.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250304124304.13732-1-guangguan.wang@linux.alibaba.com>
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20250304124304.13732-1-guangguan.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BEvM-THc_fy69j_TOkPvOEkro3aniTba
X-Proofpoint-ORIG-GUID: 7Ruz8LHPlvLXZIsG537MxOl_DWe-m7js
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 clxscore=1011 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503130058



On 04.03.25 13:43, Guangguan Wang wrote:
> When using smc_pnet in SMC, it will only search the pnetid in the
> base_ndev of the netdev hierarchy(both HW PNETID and User-defined
> sw pnetid). This may not work for some scenarios when using SMC in
> container on cloud environment.
> In container, there have choices of different container network,
> such as directly using host network, virtual network IPVLAN, veth,
> etc. Different choices of container network have different netdev
> hierarchy. Examples of netdev hierarchy show below. (eth0 and eth1
> in host below is the netdev directly related to the physical device).
>              _______________________________
>             |   _________________           |
>             |  |POD              |          |
>             |  |                 |          |
>             |  | eth0_________   |          |
>             |  |____|         |__|          |
>             |       |         |             |
>             |       |         |             |
>             |   eth1|base_ndev| eth0_______ |
>             |       |         |    | RDMA  ||
>             | host  |_________|    |_______||
>             ---------------------------------
>       netdev hierarchy if directly using host network
>             ________________________________
>             |   _________________           |
>             |  |POD  __________  |          |
>             |  |    |upper_ndev| |          |
>             |  |eth0|__________| |          |
>             |  |_______|_________|          |
>             |          |lower netdev        |
>             |        __|______              |
>             |   eth1|         | eth0_______ |
>             |       |base_ndev|    | RDMA  ||
>             | host  |_________|    |_______||
>             ---------------------------------
>              netdev hierarchy if using IPVLAN
>              _______________________________
>             |   _____________________       |
>             |  |POD        _________ |      |
>             |  |          |base_ndev||      |
>             |  |eth0(veth)|_________||      |
>             |  |____________|________|      |
>             |               |pairs          |
>             |        _______|_              |
>             |       |         | eth0_______ |
>             |   veth|base_ndev|    | RDMA  ||
>             |       |_________|    |_______||
>             |        _________              |
>             |   eth1|base_ndev|             |
>             | host  |_________|             |
>             ---------------------------------
>               netdev hierarchy if using veth
> Due to some reasons, the eth1 in host is not RDMA attached netdevice,
> pnetid is needed to map the eth1(in host) with RDMA device so that POD
> can do SMC-R. Because the eth1(in host) is managed by CNI plugin(such
> as Terway, network management plugin in container environment), and in
> cloud environment the eth(in host) can dynamically be inserted by CNI
> when POD create and dynamically be removed by CNI when POD destroy and
> no POD related to the eth(in host) anymore. It is hard to config the
> pnetid to the eth1(in host). But it is easy to config the pnetid to the
> netdevice which can be seen in POD. When do SMC-R, both the container
> directly using host network and the container using veth network can
> successfully match the RDMA device, because the configured pnetid netdev
> is a base_ndev. But the container using IPVLAN can not successfully
> match the RDMA device and 0x03030000 fallback happens, because the
> configured pnetid netdev is not a base_ndev. Additionally, if config
> pnetid to the eth1(in host) also can not work for matching RDMA device
> when using veth network and doing SMC-R in POD.
> 
> To resolve the problems list above, this patch extends to search user
> -defined sw pnetid in the clc handshake ndev when no pnetid can be found
> in the base_ndev, and the base_ndev take precedence over ndev for backward
> compatibility. This patch also can unify the pnetid setup of different
> network choices list above in container(Config user-defined sw pnetid in
> the netdevice can be seen in POD).
> 
> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
> ---
>   net/smc/smc_pnet.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
> index 716808f374a8..b391c2ef463f 100644
> --- a/net/smc/smc_pnet.c
> +++ b/net/smc/smc_pnet.c
> @@ -1079,14 +1079,16 @@ static void smc_pnet_find_roce_by_pnetid(struct net_device *ndev,
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
> +	    smc_pnet_find_ndev_pnetid_by_table(base_ndev, ndev_pnetid) &&
>   	    smc_pnet_find_ndev_pnetid_by_table(ndev, ndev_pnetid)) {
> -		smc_pnet_find_rdma_dev(ndev, ini);
> +		smc_pnet_find_rdma_dev(base_ndev, ini);
>   		return; /* pnetid could not be determined */
>   	}
>   	_smc_pnet_find_roce_by_pnetid(ndev_pnetid, ini, NULL, net);

Hi Guangguan,

sorry for the late answer! It looks good to me. Here is my R-b:

Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>

Btw. could you give Halil some time for the review? He also wants to 
have a look.

Thanks,
Wenjia


