Return-Path: <linux-rdma+bounces-8583-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 025B9A5C3F6
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 15:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48DDF1770B1
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 14:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F7B25CC95;
	Tue, 11 Mar 2025 14:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="V0o+I1cU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CD825C717;
	Tue, 11 Mar 2025 14:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741703779; cv=none; b=GhjytBTvXPb26Xy7A+q39tvP7yryxWHRd7o0Swn5LQPcSldIlNUGlCesmO48WQbOdlb9nf4p0IEMTMJ5y+jnVkqm5B203E+QvWz+lO/mii/B2j/3pMSaHLtHh4ahzmntS4riL15v3/M3cxjywUBgDijZikuBy0xB4D3dyeczpE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741703779; c=relaxed/simple;
	bh=QpK53emxzundB3boPQwv2DDoyNFHOdeOqIuWMFSBX84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UfjZKuw5V3hB87I3qKZa51+7YCosYAmEnW9Gp7xj76CbO+equUrcb7a8yXCK8jSm+PvGFZbMyWW+nzOg2LuXzeK2E0T1d48EiwTuEDgWilTQTtSsQ0slZVlf4Iw4XamdS0opTnhz5dWk2SsMfgXR+XkA00uxRY8xioRnmkPdSg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=V0o+I1cU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BA09M0004515;
	Tue, 11 Mar 2025 14:36:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+gJJGx
	RnLVbsWoeczP6FG8yWHlZQ5ofOXHgWg+4VQzQ=; b=V0o+I1cUSA2jJpM51uVhWP
	1UTmlgDvrstXM+Nwh3Prk0PKsmCcAa5pVHTOPheQkrSQhd/Ihb3pZpUCAh2qnrLQ
	FfhHAEeuoTCE7zSQ9OmFT4C8wGIZ/bNv+sU9I2OZRSz3YmpZn+2YvmHfaKk30Xha
	kzuOtL29hBtEheeFGjb8khDb+Et9z+9jxY1b/U/+paMXPQsnpnKwPc8gwzGErSgk
	jiT6NC7Ap0xW4ol2cT2rfhPrFigCGcSotXHbf3n3zryPDyRPK4cLCdbTBi3jd+rI
	AE+mrPSreS7o/Xw2jdqCOFVUqdIoTnDAiAey+jT7CdPOS19Pag63NVJm0nD17sfA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45a78qvghk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 14:36:11 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52BEKG21003836;
	Tue, 11 Mar 2025 14:36:11 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45a78qvghh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 14:36:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52BBVjMM014003;
	Tue, 11 Mar 2025 14:36:10 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4592x1v7re-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 14:36:10 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52BEa9P014025446
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 14:36:09 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42D6C58054;
	Tue, 11 Mar 2025 14:36:09 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4663458050;
	Tue, 11 Mar 2025 14:36:06 +0000 (GMT)
Received: from [9.152.224.242] (unknown [9.152.224.242])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Mar 2025 14:36:06 +0000 (GMT)
Message-ID: <77e4653d-6ad2-4b97-9952-99d506276b1a@linux.ibm.com>
Date: Tue, 11 Mar 2025 15:36:05 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net/smc: use the correct ndev to find pnetid
 by pnetid table
To: Paolo Abeni <pabeni@redhat.com>,
        Guangguan Wang <guangguan.wang@linux.alibaba.com>, pasic@linux.ibm.com,
        jaka@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
        mjambigi@linux.ibm.com, sidraya@linux.ibm.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        horms@kernel.org, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250304124304.13732-1-guangguan.wang@linux.alibaba.com>
 <2c9accbd-fd6f-421c-9d00-1f36a6152b8d@redhat.com>
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <2c9accbd-fd6f-421c-9d00-1f36a6152b8d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8JyPt17XETZmYuWNC-l4JQSMMxY5YMh1
X-Proofpoint-ORIG-GUID: w2dWjNPE_sJVQ19EQ9OjxDoJDdrL6PGb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503110091



On 11.03.25 09:59, Paolo Abeni wrote:
> On 3/4/25 1:43 PM, Guangguan Wang wrote:
>> When using smc_pnet in SMC, it will only search the pnetid in the
>> base_ndev of the netdev hierarchy(both HW PNETID and User-defined
>> sw pnetid). This may not work for some scenarios when using SMC in
>> container on cloud environment.
>> In container, there have choices of different container network,
>> such as directly using host network, virtual network IPVLAN, veth,
>> etc. Different choices of container network have different netdev
>> hierarchy. Examples of netdev hierarchy show below. (eth0 and eth1
>> in host below is the netdev directly related to the physical device).
>>              _______________________________
>>             |   _________________           |
>>             |  |POD              |          |
>>             |  |                 |          |
>>             |  | eth0_________   |          |
>>             |  |____|         |__|          |
>>             |       |         |             |
>>             |       |         |             |
>>             |   eth1|base_ndev| eth0_______ |
>>             |       |         |    | RDMA  ||
>>             | host  |_________|    |_______||
>>             ---------------------------------
>>       netdev hierarchy if directly using host network
>>             ________________________________
>>             |   _________________           |
>>             |  |POD  __________  |          |
>>             |  |    |upper_ndev| |          |
>>             |  |eth0|__________| |          |
>>             |  |_______|_________|          |
>>             |          |lower netdev        |
>>             |        __|______              |
>>             |   eth1|         | eth0_______ |
>>             |       |base_ndev|    | RDMA  ||
>>             | host  |_________|    |_______||
>>             ---------------------------------
>>              netdev hierarchy if using IPVLAN
>>              _______________________________
>>             |   _____________________       |
>>             |  |POD        _________ |      |
>>             |  |          |base_ndev||      |
>>             |  |eth0(veth)|_________||      |
>>             |  |____________|________|      |
>>             |               |pairs          |
>>             |        _______|_              |
>>             |       |         | eth0_______ |
>>             |   veth|base_ndev|    | RDMA  ||
>>             |       |_________|    |_______||
>>             |        _________              |
>>             |   eth1|base_ndev|             |
>>             | host  |_________|             |
>>             ---------------------------------
>>               netdev hierarchy if using veth
>> Due to some reasons, the eth1 in host is not RDMA attached netdevice,
>> pnetid is needed to map the eth1(in host) with RDMA device so that POD
>> can do SMC-R. Because the eth1(in host) is managed by CNI plugin(such
>> as Terway, network management plugin in container environment), and in
>> cloud environment the eth(in host) can dynamically be inserted by CNI
>> when POD create and dynamically be removed by CNI when POD destroy and
>> no POD related to the eth(in host) anymore. It is hard to config the
>> pnetid to the eth1(in host). But it is easy to config the pnetid to the
>> netdevice which can be seen in POD. When do SMC-R, both the container
>> directly using host network and the container using veth network can
>> successfully match the RDMA device, because the configured pnetid netdev
>> is a base_ndev. But the container using IPVLAN can not successfully
>> match the RDMA device and 0x03030000 fallback happens, because the
>> configured pnetid netdev is not a base_ndev. Additionally, if config
>> pnetid to the eth1(in host) also can not work for matching RDMA device
>> when using veth network and doing SMC-R in POD.
>>
>> To resolve the problems list above, this patch extends to search user
>> -defined sw pnetid in the clc handshake ndev when no pnetid can be found
>> in the base_ndev, and the base_ndev take precedence over ndev for backward
>> compatibility. This patch also can unify the pnetid setup of different
>> network choices list above in container(Config user-defined sw pnetid in
>> the netdevice can be seen in POD).
>>
>> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
>> ---
>>   net/smc/smc_pnet.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
>> index 716808f374a8..b391c2ef463f 100644
>> --- a/net/smc/smc_pnet.c
>> +++ b/net/smc/smc_pnet.c
>> @@ -1079,14 +1079,16 @@ static void smc_pnet_find_roce_by_pnetid(struct net_device *ndev,
>>   					 struct smc_init_info *ini)
>>   {
>>   	u8 ndev_pnetid[SMC_MAX_PNETID_LEN];
>> +	struct net_device *base_ndev;
>>   	struct net *net;
>>   
>> -	ndev = pnet_find_base_ndev(ndev);
>> +	base_ndev = pnet_find_base_ndev(ndev);
>>   	net = dev_net(ndev);
>> -	if (smc_pnetid_by_dev_port(ndev->dev.parent, ndev->dev_port,
>> +	if (smc_pnetid_by_dev_port(base_ndev->dev.parent, base_ndev->dev_port,
>>   				   ndev_pnetid) &&
>> +	    smc_pnet_find_ndev_pnetid_by_table(base_ndev, ndev_pnetid) &&
>>   	    smc_pnet_find_ndev_pnetid_by_table(ndev, ndev_pnetid)) {
>> -		smc_pnet_find_rdma_dev(ndev, ini);
>> +		smc_pnet_find_rdma_dev(base_ndev, ini);
>>   		return; /* pnetid could not be determined */
>>   	}
>>   	_smc_pnet_find_roce_by_pnetid(ndev_pnetid, ini, NULL, net);
> 
> I understand Wenjia opposed to this solution as it may create invalid
> topologies ?!?
> 
> https://lore.kernel.org/netdev/08cd6e15-3f8c-47a0-8490-103d59abf910@linux.ibm.com/#t
> 
> Wenjia, could you please confirm?
> 
> Thanks,
> 
> Paolo
> 

Hi Paolo,

Thanks for asking! I really appreciate it.

I was initially opposed, but after discussing with Halil, I agreed that 
my concerns might be not necessary. Halil and I reached an agreement 
that he responded to the emails (v1) to ask for the version as he 
already did, and we will double-check version 2 to ensure it works 
correctly.

In any case, I still need to review it carefully and will provide my 
answer as soon as possible.

Thanks,
Wenjia

