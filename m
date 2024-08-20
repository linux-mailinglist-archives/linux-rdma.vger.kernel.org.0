Return-Path: <linux-rdma+bounces-4435-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE359587C7
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Aug 2024 15:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2142D1F22D8B
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Aug 2024 13:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBFC190463;
	Tue, 20 Aug 2024 13:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GpxfbjC5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A5018E35F;
	Tue, 20 Aug 2024 13:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724160152; cv=none; b=Soa5yN/Vukq/zOpoH8I6hNxBefmNInwqzMNNRo4AkiLSy/veUVmQfXeGERSqZBJzWADuM7EWaNJOarWjhtISc9rCTcNh0Apht+0mpWsjUIHaznoC5qkqJwyWHwPWS41mVFurcvo6EPsKXkyQL7Sd5ayjHfAEYNKCYFEMA6eHqic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724160152; c=relaxed/simple;
	bh=Fq9uBaqt8u8035uDrlu0QNVSlEn1APirXuQSNTuwPI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VPuFQLvydI+lVkkfh0cIieIyx1Mrlj+pp5ce7zzTsXeTuldBL+q05YrkidxElg4SscStXYlV5/9XSlEjDCGhv+3/mKuzeoguYSITqf5T7xeHkDJqIX0V20vTJcZ5h63xJWU76cgHMtHIo0eNYrd4qhFfEKi6nJqsrnFS5UtcHQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GpxfbjC5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47K1crnJ013051;
	Tue, 20 Aug 2024 13:17:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=s
	L2usFYulSiiFHaz9/+IWNbNJHOf/Jn5bRdCLpCnDFk=; b=GpxfbjC5LXGt0KEz9
	NehM6ev8rS5q1U86Klw0RsYFlJrykMiEFjfpJ4xR9l/00Ux9C2ltbIN/gPKwWeBq
	EGdjWu6K7+XxLop+Vk57lECEk6oWww73typCw7yOR4ZSqqTn1iGuhgGJ7masxRlU
	S8kQH6AKB8voxFgC4cWGFG2dYsWHhzvev24cTD9e/KCNO2tDkj7dWu6zBhUsROWI
	64NHkMrpL5PxZtueTxydvjNCry7HvlKrcqb70oig5oV5ENa9NvSq80OuIau+3Pw9
	9SzyXCcVvy0xxn0Y9EVSOldUqirykU0o5gR4hJx78ZwuZmmMrDNyKx7ERd5RuulA
	IaupA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mcydbam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 13:17:10 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47KDH9fr017200;
	Tue, 20 Aug 2024 13:17:09 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mcydbae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 13:17:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47KA0VdJ013103;
	Tue, 20 Aug 2024 13:17:08 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41366u37uw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 13:17:08 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47KDH56J31326860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 13:17:07 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED8242004D;
	Tue, 20 Aug 2024 13:17:04 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43F9420043;
	Tue, 20 Aug 2024 13:17:04 +0000 (GMT)
Received: from [9.179.26.157] (unknown [9.179.26.157])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 20 Aug 2024 13:17:04 +0000 (GMT)
Message-ID: <0d5e2cec-dd0b-4920-99ff-9299e4df604f@linux.ibm.com>
Date: Tue, 20 Aug 2024 15:16:57 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/4] Make SMC-R can work with rxe devices
To: Liu Jian <liujian56@huawei.com>, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org
Cc: jgg@ziepe.ca, leon@kernel.org, zyjzyj2000@gmail.com, wenjia@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
References: <20240809083148.1989912-1-liujian56@huawei.com>
From: Jan Karcher <jaka@linux.ibm.com>
Organization: IBM - Network Linux on Z
In-Reply-To: <20240809083148.1989912-1-liujian56@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JOjJz38i82HqiDG42C6cc4CyXr1F2Q55
X-Proofpoint-GUID: vFFZcxmYsihYBqDgxaC2JpvVUR8kWs_m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_09,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=600 spamscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408200097



On 09/08/2024 10:31, Liu Jian wrote:
> Make SMC-R can work with rxe devices. This allows us to easily test and
> learn the SMC-R protocol without relying on a physical RoCE NIC.

Hi Liu,

sorry for taking quite some time to answer.

Looking into this i cannot accept this series at the given point of time.

FWIU, RXE is mainly for testing and development and i agree that it 
would be a nice thing to have for SMC-R.
The problem is that there is no clean layer for different RoCE devices 
currently. Adding RXE to it works but isn't clean.
Also we have no way to do a "test" build which would have such a device 
supported and a "prod" build which would not support it.

Please give us time to investigate how to solve this in a neat way 
without building up to much technical debt.

Thanks for your contribution and making us aware of this area of improvment.
- Jan

> 
> Liu Jian (4):
>    rdma/device: export ib_device_get_netdev()
>    net/smc: use ib_device_get_netdev() helper to get netdev info
>    net/smc: fix one NULL pointer dereference in smc_ib_is_sg_need_sync()
>    RDMA/rxe: Set queue pair cur_qp_state when being queried
> 
>   drivers/infiniband/core/core_priv.h   |  3 ---
>   drivers/infiniband/core/device.c      |  1 +
>   drivers/infiniband/sw/rxe/rxe_verbs.c |  2 ++
>   include/rdma/ib_verbs.h               |  2 ++
>   net/smc/smc_ib.c                      | 10 +++++-----
>   net/smc/smc_pnet.c                    |  6 +-----
>   6 files changed, 11 insertions(+), 13 deletions(-)
> 

