Return-Path: <linux-rdma+bounces-6074-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D119D619F
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2024 16:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8641C160430
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2024 15:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355C11D5164;
	Fri, 22 Nov 2024 15:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bF1UAQtM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8903237171;
	Fri, 22 Nov 2024 15:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732290999; cv=none; b=QDXLLuCaw55ZZNoXEpR68BLtTpg69yKYIA8W7+kWMFmYTqZnHqPWQHanY8hGWRcw2OGEhoZoML73asQ2unfYbE3M/BVbXgtBXCrmpAI+V2UCqYYum588G8s7/QsHFLI5e++Ba6Q/mHDEOmWl/cjscG1BezoXUIpyiL2TOIHxmwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732290999; c=relaxed/simple;
	bh=+OMbc/XwftdxUR4oD4irFa2VWszcWmfXwbsURr/2m6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eF+4XA7XbFDdp0OrYvBQMZsNSXJbL1dpc+Td2PloX1L2eZ32KXKxTHfNSW01cCx9eTc97N8RQ4G1XtgOR9eH+pbH/qyzxt1+bYwoxITp7GsxZXpSG7peFFSTUva42Pj7iBYzmOSE91zwM3saXvnvp/dkEEiVeRAsoBqm75RggnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bF1UAQtM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMAgM3l006909;
	Fri, 22 Nov 2024 15:56:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BtS4Qc
	/esBxeTVYq7ccMMMG1Zp+siGlrneQgiDLoZyo=; b=bF1UAQtMZ6pOG+EF2Oh8Nj
	054IPB0d1FQ85AA5UQ8QXU5x7ccFbTabRJWw18Ko7f2mgCClhOFauCxn5pp7yIhc
	rr+HrP8BM36TTwEzX9HYPdWpcyI9UmHvqRoyKrR4STLPqDMAu4Ap8f0p+sIj0C0i
	bkUV2DjDx+mN3Y5Ubj5LCZuyxqVjGSz0gxvhppwMjcPba86CvanRSKsG59Oru3hU
	Rtj3UezM09tCsQZ3FwBlTbQW7AKJ9NxRBpezdFCD99ZOkGdSDSA2U3K8pfddf/5a
	fX18Y8i9otuozad80J7HiMpHNAx75WgVKSy7KKMdy6GZj795/twzwD3On7gCK2zQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xyu291s4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 15:56:31 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AMFQtZt028286;
	Fri, 22 Nov 2024 15:56:30 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xyu291s0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 15:56:30 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMCGgrL013699;
	Fri, 22 Nov 2024 15:56:29 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42y7xju9w5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 15:56:29 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AMFuTbD51773780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 15:56:29 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 31ECC5805F;
	Fri, 22 Nov 2024 15:56:29 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF9B858059;
	Fri, 22 Nov 2024 15:56:26 +0000 (GMT)
Received: from [9.171.76.132] (unknown [9.171.76.132])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 Nov 2024 15:56:26 +0000 (GMT)
Message-ID: <faba3530-c5f9-48af-be80-3847aa4921b7@linux.ibm.com>
Date: Fri, 22 Nov 2024 16:56:25 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net/smc: initialize close_work early to avoid
 warning
To: Wen Gu <guwen@linux.alibaba.com>, jaka@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: alibuda@linux.alibaba.com, tonylu@linux.alibaba.com, horms@kernel.org,
        linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241122071630.63707-1-guwen@linux.alibaba.com>
 <20241122071630.63707-2-guwen@linux.alibaba.com>
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20241122071630.63707-2-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TRAArkc36m_aQ__PuSUVa1CYc2fwBGFH
X-Proofpoint-ORIG-GUID: 6x9L0fJA9uJrH3xu2WtvYOciLTenCXuM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411220130



On 22.11.24 08:16, Wen Gu wrote:
> We encountered a warning that close_work was canceled before
> initialization.
> 
>    WARNING: CPU: 7 PID: 111103 at kernel/workqueue.c:3047 __flush_work+0x19e/0x1b0
>    Workqueue: events smc_lgr_terminate_work [smc]
>    RIP: 0010:__flush_work+0x19e/0x1b0
>    Call Trace:
>     ? __wake_up_common+0x7a/0x190
>     ? work_busy+0x80/0x80
>     __cancel_work_timer+0xe3/0x160
>     smc_close_cancel_work+0x1a/0x70 [smc]
>     smc_close_active_abort+0x207/0x360 [smc]
>     __smc_lgr_terminate.part.38+0xc8/0x180 [smc]
>     process_one_work+0x19e/0x340
>     worker_thread+0x30/0x370
>     ? process_one_work+0x340/0x340
>     kthread+0x117/0x130
>     ? __kthread_cancel_work+0x50/0x50
>     ret_from_fork+0x22/0x30
> 
> This is because when smc_close_cancel_work is triggered, e.g. the RDMA
> driver is rmmod and the LGR is terminated, the conn->close_work is
> flushed before initialization, resulting in WARN_ON(!work->func).
> 
> __smc_lgr_terminate             | smc_connect_{rdma|ism}
> -------------------------------------------------------------
>                                  | smc_conn_create
> 				| \- smc_lgr_register_conn
> for conn in lgr->conns_all      |
> \- smc_conn_kill                |
>     \- smc_close_active_abort    |
>        \- smc_close_cancel_work  |
>           \- cancel_work_sync    |
>              \- __flush_work     |
> 	         (close_work)   |
> 	                        | smc_close_init
> 	                        | \- INIT_WORK(&close_work)
> 
> So fix this by initializing close_work before establishing the
> connection.
> 
> Fixes: 46c28dbd4c23 ("net/smc: no socket state changes in tasklet context")
> Fixes: 413498440e30 ("net/smc: add SMC-D support in af_smc")
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---

It looks plausible to me. Thank you for fixing it!

Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>

Thanks,
Wenjia

