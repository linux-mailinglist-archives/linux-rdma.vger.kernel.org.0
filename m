Return-Path: <linux-rdma+bounces-4303-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D2194E03C
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Aug 2024 08:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 428001F21416
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Aug 2024 06:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB991AAC4;
	Sun, 11 Aug 2024 06:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OFm3fuJf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B6817758;
	Sun, 11 Aug 2024 06:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723356343; cv=none; b=nbbQ7O9TIyypKOobq9YWe6IRuJT85Rvl5kaxI+ISCKnMH8Q36HEE5xAVwbPWMTUe7xlDNjZqVGrMoavpw3g5G5K2XneTAGoIEQSUwOF17Hrsztavt/671+49TazwhLflvxVC/Ncg0HyBWsXEzjup+alNrGSOWvuArTCtiUL1+FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723356343; c=relaxed/simple;
	bh=1wDnn82iWsMF3myAk2/GB+fl5fpsudaP3YxBB3CSPio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k/RxrlrZgFTIdCdJrjky1y+e5aC2yxV0TsKuhCrrhGFmNwFf+6BWfK42YAfoPbjNa1NykVXM5TezseBK2etBefA7IEf+HAnbu3XclivLpvGbsgGV9z5v1R1Ji5846TsIKwvBDDY1fcRT8SdsZ7dlJ4Zfe2CiY+sRPbuix3S11bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OFm3fuJf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47B4bP6Q000517;
	Sun, 11 Aug 2024 06:05:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=d
	tSdA7UPCYo5T1a0eiiyRVHahUWRq2EwwuPn2nGp7Zo=; b=OFm3fuJfcH3l26QDS
	6UTm7RKrWDsCTkY62sqQPrjaX1KWpgBt9ltbXlTCGSXpmvb4Ze5C72sOyt/XvRt7
	SoNyG9l3gFQN07X0XGN+xt3JpKCa2nmUQEV2T2ZV7eNygoITyFpp3XSi+QvV8iM0
	f9GywFZ1V8EyViQ//sYofqHS+P0tydKZaxdVa10e3jSUk6SAjIp8fXPOBZFx9bL/
	jzrWgb2yanyqlMBkkPI/jzdN4iNWt4lOSiC+oEHt3jUXMJi/OXVb4JuaCgQJ4M1g
	Kynzn4BxHnvuEWrfTZR2Z1eMHckC4wdfegafrGpgIvEE8PPDnjDqD6hDUDcUB1OA
	O1eaw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40wyvvt3fd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 11 Aug 2024 06:05:26 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47B65Pes016055;
	Sun, 11 Aug 2024 06:05:26 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40wyvvt3f8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 11 Aug 2024 06:05:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47B3FTtQ020902;
	Sun, 11 Aug 2024 06:05:24 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40xn82rfss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 11 Aug 2024 06:05:24 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47B65LVn57344462
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 11 Aug 2024 06:05:23 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4065E20040;
	Sun, 11 Aug 2024 06:05:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64DCA2004B;
	Sun, 11 Aug 2024 06:05:20 +0000 (GMT)
Received: from [9.171.59.108] (unknown [9.171.59.108])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 11 Aug 2024 06:05:20 +0000 (GMT)
Message-ID: <0da83fa7-8866-4ba9-803d-c207106c2eb2@linux.ibm.com>
Date: Sun, 11 Aug 2024 08:05:19 +0200
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
X-Proofpoint-ORIG-GUID: kIDop0nuWcL_ysW-kVwcGhEHBf6C8C-4
X-Proofpoint-GUID: yog6F8ykDEUDQJludh86tz2oO4eXOsXF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-11_04,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=779 spamscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 phishscore=0 clxscore=1011 bulkscore=0 mlxscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408110046



On 09/08/2024 10:31, Liu Jian wrote:
> Make SMC-R can work with rxe devices. This allows us to easily test and
> learn the SMC-R protocol without relying on a physical RoCE NIC.

Hi Liu,

thank you for your contribution. Please give me some time to review and 
test it in the next couple of days.

Thanks
- J

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

