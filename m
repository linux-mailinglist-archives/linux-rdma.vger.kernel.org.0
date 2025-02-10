Return-Path: <linux-rdma+bounces-7640-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6F8A2EEE0
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2025 14:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D323A1885276
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2025 13:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4DA230998;
	Mon, 10 Feb 2025 13:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TJr+InTy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705A721C9E0;
	Mon, 10 Feb 2025 13:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739195615; cv=none; b=Ps+xqloqrBfXga3+rpNiQKHHJSkB/8ySnMcnGCl1MhRHFYJxMjcY7nd0h7hIva5y8Wch/tDUIJ4I2KFwhIqD8gEq4ey7/LHvv3bRn1D2emp5Pbh3jfj9sChsF6nX+LdELVC02cZGW91oPful1Z8qGdjUJokHxzRYg1A5SnQS9Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739195615; c=relaxed/simple;
	bh=+yxgt6+xyAp6s+YD52QMLqkv1qTdvCPj8HeHjseiZRs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J5E54DTQnjd7fjulF1Ql76MLMRGilivYNqPPrntZVZEjItKh+QDUaVMxa/BJDYjTNDnMn05Fw5GHTCFm3D1nGk3YRj1SK8wy3h+5EgGNYr67Mkr6Q+kPjQqnefztjUN3pkCE1ahdofp4WK8+hQnRvlkb64RNogW6I5G7yEU7hgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TJr+InTy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51A7X6pI020862;
	Mon, 10 Feb 2025 13:53:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=550vrO
	d5X6IQBeVHaRhw+8u8h7h1HP+3g0ov9GC21RM=; b=TJr+InTyJZ9U4e04kJrytk
	TwJ4Y2I0jSZ15emqC840+rzjNbytEVwEU/lt/wand0gR0BoviixxVOJpSaMhOlS8
	y+ZMnkQk2SXAs5vTt8qoVZVnyTsjoTLo5Z3v//EyuBrn/tHRkUsoX3LrNGKq+R7Z
	3BAMh3qft29S3lBHZPTZJBAsquinG36AT2IHK3WtaScwRr33w4TRy3RXfgA9IRnY
	02PkVsED2of93IVp/NuX+5CxYQWlR6V/X4bGTsPTu9SyRXBWukzrz2i0V9ZBIbFG
	I53vfu9U2395SU2cBG/5iRAx8lNk952FuWL9JzLr3ybAjPKQcjZQuWPlMCS+i1Zg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44qd5nsq38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 13:53:15 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51ADoGFH029176;
	Mon, 10 Feb 2025 13:53:14 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44qd5nsq33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 13:53:14 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51AC7PkY001051;
	Mon, 10 Feb 2025 13:53:13 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44pjkmxj66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 13:53:13 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51ADrAVp14680354
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 13:53:10 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 03057200F2;
	Mon, 10 Feb 2025 13:53:10 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 137E9200F0;
	Mon, 10 Feb 2025 13:53:09 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.171.22.27])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon, 10 Feb 2025 13:52:58 +0000 (GMT)
Date: Mon, 10 Feb 2025 14:52:55 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Cc: Paolo Abeni <pabeni@redhat.com>, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, horms@kernel.org, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexandra Winter <wintera@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH net] net/smc: use the correct ndev to find pnetid by
 pnetid table
Message-ID: <20250210145255.793e6639.pasic@linux.ibm.com>
In-Reply-To: <b1053a92-3a3f-4042-9be9-60b94b97747d@linux.alibaba.com>
References: <20241227040455.91854-1-guangguan.wang@linux.alibaba.com>
	<1f4a721f-fa23-4f1d-97a9-1b27bdcd1e21@redhat.com>
	<20250107203218.5787acb4.pasic@linux.ibm.com>
	<908be351-b4f8-4c25-9171-4f033e11ffc4@linux.alibaba.com>
	<20250109040429.350fdd60.pasic@linux.ibm.com>
	<b1053a92-3a3f-4042-9be9-60b94b97747d@linux.alibaba.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: z7c8wxOxHz5HvQIUQRHj7y0YaOkhha7N
X-Proofpoint-ORIG-GUID: 9lggT4HDYvzhX0pavHSmB7QoLTkpK_W8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_07,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 phishscore=0 mlxscore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502100113

On Fri, 10 Jan 2025 13:43:44 +0800
Guangguan Wang <guangguan.wang@linux.alibaba.com> wrote:

> We want to use SMC in container on cloud environment, and encounter problem
> when using smc_pnet with commit 890a2cb4a966. In container, there have choices
> of different container network, such as directly using host network, virtual
> network IPVLAN, veth, etc. Different choices of container network have different
> netdev hierarchy. Examples of netdev hierarchy show below. (eth0 and eth1 in host
> below is the netdev directly related to the physical device).
>  _______________________________      ________________________________   
> |   _________________           |     |   _________________           |  
> |  |POD              |          |     |  |POD  __________  |          |  
> |  |                 |          |     |  |    |upper_ndev| |          |  
> |  | eth0_________   |          |     |  |eth0|__________| |          |  
> |  |____|         |__|          |     |  |_______|_________|          |  
> |       |         |             |     |          |lower netdev        |  
> |       |         |             |     |        __|______              |  
> |   eth1|base_ndev| eth0_______ |     |   eth1|         | eth0_______ |  
> |       |         |    | RDMA  ||     |       |base_ndev|    | RDMA  ||  
> | host  |_________|    |_______||     | host  |_________|    |_______||  
> ———————————————————————————————-      ———————————————————————————————-    
>  netdev hierarchy if directly          netdev hierarchy if using IPVLAN    
>    using host network
>  _______________________________
> |   _____________________       |
> |  |POD        _________ |      |
> |  |          |base_ndev||      |
> |  |eth0(veth)|_________||      |
> |  |____________|________|      |
> |               |pairs          |
> |        _______|_              |
> |       |         | eth0_______ |
> |   veth|base_ndev|    | RDMA  ||
> |       |_________|    |_______||
> |        _________              |
> |   eth1|base_ndev|             |
> | host  |_________|             |
>  ———————————————————————————————
>   netdev hierarchy if using veth
> 
> Due to some reasons, the eth1 in host is not RDMA attached netdevice, pnetid
> is needed to map the eth1(in host) with RDMA device so that POD can do SMC-R.
> Because the eth1(in host) is managed by CNI plugin(such as Terway, network
> management plugin in container environment), and in cloud environment the
> eth(in host) can dynamically be inserted by CNI when POD create and dynamically
> be removed by CNI when POD destroy and no POD related to the eth(in host)
> anymore.

I'm pretty clueless when it comes to the details of CNI but I think
I'm barely able to follow. Nevertheless if you have the feeling that
my extrapolations are wrong, please do point it out.

> It is hard for us to config the pnetid to the eth1(in host). So we
> config the pnetid to the netdevice which can be seen in POD.

Hm, this sounds like you could set PNETID on eth1 (in host) for each of
the cases and everything would be cool (and would work), but because CNI
and the environment do not support it, or supports it in a very
inconvenient way, you are looking for a workaround where PNETID is set
in the POD. Is that right? Or did I get something wrong?

> When do SMC-R, both
> the container directly using host network and the container using veth network
> can successfully match the RDMA device, because the configured pnetid netdev is a
> base_ndev. But the container using IPVLAN can not successfully match the RDMA
> device and 0x03030000 fallback happens, because the configured pnetid netdev is
> not a base_ndev. Additionally, if config pnetid to the eth1(in host) also can not
> work for matching RDMA device when using veth network and doing SMC-R in POD.

That I guess answers my question from the first paragraph. Setting
PNETID on eth1 (host) would not be sufficient for veth. Right?

Another silly question: is making the PNETID basically a part of the Pod
definition shifting PNETID from the realm of infrastructure (i.e.
configured by the cloud provider) to the ream of an application (i.e.
configured by the tenant)?

AFAIU veth (host) is bridged (or similar) to eth1 (host) and that is in
the host, and this is where we make sure that the requirements for SMC-R
are satisfied.

But veth (host) could be attached to eth3 which is on a network not
reachable via eth0 (host) or eth1 (host). In that case the pod could
still set PNETID on veth (POD). Or?

> 
> My patch can resolve the problem we encountered and also can unify the pnetid setup
> of different network choices list above, assuming the pnetid is not limited to
> config to the base_ndev directly related to the physical device(indeed, the current
> implementation has not limited it yet).

I see some problems here, but I'm afraid we see different problems. For
me not being able to set eth0 (veth/POD)'s PNEDID from the host is a
problem. Please notice that with the current implementation users can
only control the PNETID if infrastructure does not do so in the first
place.


Can you please help me reason about this? I'm unfortunately lacking
Kubernetes skills here, and it is difficult for me to think along.

Regards,
Halil

