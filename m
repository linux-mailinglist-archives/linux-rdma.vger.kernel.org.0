Return-Path: <linux-rdma+bounces-6155-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 710F29DBFF5
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Nov 2024 08:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37C0C281762
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Nov 2024 07:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0ED2158558;
	Fri, 29 Nov 2024 07:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DsakWj3T"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455D71386DA;
	Fri, 29 Nov 2024 07:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732866981; cv=none; b=Isad4Mnw9NMLywJA8bgsQnJq8OCuhYO9VDj+jTJm29F62+F6HS4z0jOuRDA3AObjfwOLH3jHxAekzIJpeGNvklukCr7QmW9oYm/sNV1da4jk46/MsH8dzayUVdtmF8h/nyjxF0RJzy98IjorLrar74rv9fIjsXom0ToHYLSr9LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732866981; c=relaxed/simple;
	bh=0hp3fv8latmmTUlCkTeTsykaKr+aVsRE9AosEWzuB/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MCCXSgU8L6mMID1RU0qdUb94Ob5eKKt6LefnmFwTXndXt+sfEFL7qePqYO425bVuZQjM/ClP9rULVwBo0Cbm3DH1BvLwajve1k4jxkbFtCBJxExCDjr384OrRPCVMwjYwjKYVwCF7Lm+ejzTCyViaJVMcWE8r7r/X1MMKjGGFf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DsakWj3T; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ASKUJfP026300;
	Fri, 29 Nov 2024 07:55:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=S162lE
	ykbbUIwtjqTy60eSL+RFAw/ewG9cU7TZXYEH4=; b=DsakWj3TXUNFbpBE27Er1B
	9CrcjtkTju3xJJOKBQVlD01irkCTutcKFBKhxJAOYbOYHADx0cobYfBbx8FN4IYO
	Et8iQ/t3gLB8Ay0XRw1YpsCjc/cVxrSKq9c/c1bII5NpcNXqznZMwKzB/pi+Jjh5
	UGcLIM6t0IUoZAsnFt1ATevtxcUCSSFiHtuNZAC/3Da64wYuFzYO5ktjfudzmtLG
	v4+ZNiPnfIyVtjaJWjmsqIw4odOh0y6BEMvg0xgjq0/Rg5N+yhgEIsY5M2Xy2AsS
	kPB53qFX40pf3Yd5eR3qllOg/30N2jYGVCWloA7pYZKkyL52zYivZKL4aQCz42Yw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 436ym5acvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Nov 2024 07:55:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4ASMQBrW020364;
	Fri, 29 Nov 2024 07:55:43 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43672gbffy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Nov 2024 07:55:43 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AT7thN852560134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Nov 2024 07:55:43 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F8EE5805C;
	Fri, 29 Nov 2024 07:55:43 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC50558059;
	Fri, 29 Nov 2024 07:55:40 +0000 (GMT)
Received: from [9.171.64.111] (unknown [9.171.64.111])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 Nov 2024 07:55:40 +0000 (GMT)
Message-ID: <6dee5d52-3fe2-4c3b-9eb3-47de7d7c5c62@linux.ibm.com>
Date: Fri, 29 Nov 2024 13:25:39 +0530
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: blktests failures with v6.12 kernel
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "nbd@other.debian.org" <nbd@other.debian.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <6crydkodszx5vq4ieox3jjpwkxtu7mhbohypy24awlo5w7f4k6@to3dcng24rd4>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <6crydkodszx5vq4ieox3jjpwkxtu7mhbohypy24awlo5w7f4k6@to3dcng24rd4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SseiB5tslUBzSKGd-O-7-DSzefp6-zmG
X-Proofpoint-ORIG-GUID: SseiB5tslUBzSKGd-O-7-DSzefp6-zmG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 clxscore=1011
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2411290060

Hi Shinichiro,

On 11/26/24 07:49, Shinichiro Kawasaki wrote:
> Hi all,
> 
> I ran the latest blktests (git hash: 83781f257857) with the v6.12 kernel. Also,
> I checked CKI project runs for the kernel. I observed five failures below.
> 
> Comparing with the previous report using the v6.12-rc1 kernel [1], two failures
> were resolved: nvme/014 and srp group. On the other hand, four new failures were
> observed.
> 
> [1] https://lore.kernel.org/linux-block/xpe6bea7rakpyoyfvspvin2dsozjmjtjktpph7rep3h25tv7fb@ooz4cu5z6bq6/
> 
> 
> List of failures
> ================
> #1: nvme/031 (fc transport)
> #2: nvme/037 (fc transport)
> #3: nvme/041 (fc transport)
> #4: nvme/052 (loop transport)
> #5: throtl/001 (CKI project, s390 arch)
> 
> Failure description
> ===================
> 
<snip>
> #4: nvme/052 (loop transport)
> 
>   The test case fails due to the "BUG: sleeping function called from invalid
>   context" [5]. A fix candidate was posted which sets NVME_F_BLOCKING to loop
>   transport, but it is not the best solution [6]. It is desired to have a better
>   fix and the test case to confirm it.
> 
>   [5] https://lore.kernel.org/linux-nvme/tqcy3sveity7p56v7ywp7ssyviwcb3w4623cnxj3knoobfcanq@yxgt2mjkbkam/
>   [6] https://lore.kernel.org/linux-nvme/20241017172052.2603389-1-kbusch@meta.com/
> 
I have developed a blktest to recreate this bug and also probable fix as suggested by Christoph[1].
I will send the blktest and patch later today.

[1] https://lore.kernel.org/linux-nvme/20241022070252.GA11389@lst.de/

Thanks,
--Nilay

