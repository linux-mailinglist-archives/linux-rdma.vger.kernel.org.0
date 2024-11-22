Return-Path: <linux-rdma+bounces-6078-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBD19D61F6
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2024 17:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B9661611E7
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2024 16:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092C81DF747;
	Fri, 22 Nov 2024 16:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VhfdFFnx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5201DF99F;
	Fri, 22 Nov 2024 16:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732292236; cv=none; b=EHIotQaoV2nkRH1BTEWkvOCCPLro6j/5g+cLAs6jSv983uak/+9guQJ0sGJHh0RVGJ6vZW28iwVHd6vq3NvBFMtDfZQuxNisamX14Gq0re075lYv+WDRetcGADzxIQ/lfbuPGdZRb3PGG3R4cL1X8AH86+LV5v4PAgwk7UkdiB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732292236; c=relaxed/simple;
	bh=YzT+Es9/r0Nk8ji75is2LAqMUQbHockjpf5WvhsLNeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P8urXbDY6WN+W/F0CklLlIIquH/srjsCpPe4hrjclJ2cOHQwTWtVSjY7vrxSGajhvfcjimQ1NaN/2fs944TmM64mZ+yjyQwPWXui8NxIEyF7QI9czekGz/c/1VQgEi5hzlhQ/CyTTN5+ooTeuh6FrT2x1p7CHGacnUjq6xTAFxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VhfdFFnx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMBpVe6029097;
	Fri, 22 Nov 2024 16:17:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vdaEE2
	rniiMaP5IeAGFH9iciTB4UVN8gNK9Mw/1GLAU=; b=VhfdFFnxp9LPZNd31/u/7C
	JzQo9bJNgPwGK0KtQkwblrx5Bmz+M8nI0LB5jTW86JL0h7KVucR/WHFpgcZ7Lu/q
	4xX5XefOGO6l28JMWJaQl6W0GQTrqqp/QuK7HGgkSVwGGjTV+eAfT8lHGyU4i3AV
	zVrgyid6Vw74LNCtWmoBoNV0mF2C3rkZZBxcwnGX+YYtXX08v4uXzALejvIdbK4H
	tiXRTFdcreWDFs4tOS6AGpoNKZ6rugqheYjWd68IAtI9QUMDs++FojRbGAGa2qru
	zyuIq79ekHzeiO7+klnrS+hDuJ9wd/MNe0/ykFSqlj8Qw2uDKjf5vc0eLOQvcapg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xhtk9yyk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 16:17:06 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AMG70J6014298;
	Fri, 22 Nov 2024 16:17:06 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xhtk9yye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 16:17:05 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMCGBrl024589;
	Fri, 22 Nov 2024 16:17:05 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42y8e1k9eh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 16:17:05 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AMGH1K341025962
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 16:17:01 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA8AF2004F;
	Fri, 22 Nov 2024 16:17:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 274372004E;
	Fri, 22 Nov 2024 16:17:01 +0000 (GMT)
Received: from [9.171.57.248] (unknown [9.171.57.248])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 Nov 2024 16:17:01 +0000 (GMT)
Message-ID: <05586fa4-308b-4a13-a5f7-0c93ec3760a5@linux.ibm.com>
Date: Fri, 22 Nov 2024 17:17:00 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net/smc: initialize close_work early to avoid
 warning
Content-Language: en-US
To: Wen Gu <guwen@linux.alibaba.com>, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc: alibuda@linux.alibaba.com, tonylu@linux.alibaba.com, horms@kernel.org,
        linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241122071630.63707-1-guwen@linux.alibaba.com>
 <20241122071630.63707-2-guwen@linux.alibaba.com>
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20241122071630.63707-2-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: k_01IezWKk5IHnvxTtGUEt0HUCF5J5Zv
X-Proofpoint-GUID: 2rlw1_ADSm6LApR0iENBbbsFbgrmrOU-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411220135



On 22.11.24 08:16, Wen Gu wrote:
> We encountered a warning that close_work was canceled before
> initialization.
> 
>   WARNING: CPU: 7 PID: 111103 at kernel/workqueue.c:3047 __flush_work+0x19e/0x1b0
>   Workqueue: events smc_lgr_terminate_work [smc]
>   RIP: 0010:__flush_work+0x19e/0x1b0
>   Call Trace:
>    ? __wake_up_common+0x7a/0x190
>    ? work_busy+0x80/0x80
>    __cancel_work_timer+0xe3/0x160
>    smc_close_cancel_work+0x1a/0x70 [smc]
>    smc_close_active_abort+0x207/0x360 [smc]
>    __smc_lgr_terminate.part.38+0xc8/0x180 [smc]
>    process_one_work+0x19e/0x340
>    worker_thread+0x30/0x370
>    ? process_one_work+0x340/0x340
>    kthread+0x117/0x130
>    ? __kthread_cancel_work+0x50/0x50
>    ret_from_fork+0x22/0x30
> 
> This is because when smc_close_cancel_work is triggered, e.g. the RDMA
> driver is rmmod and the LGR is terminated, the conn->close_work is
> flushed before initialization, resulting in WARN_ON(!work->func).
> 
> __smc_lgr_terminate             | smc_connect_{rdma|ism}
> -------------------------------------------------------------
>                                 | smc_conn_create
> 				| \- smc_lgr_register_conn
> for conn in lgr->conns_all      |
> \- smc_conn_kill                |
>    \- smc_close_active_abort    |
>       \- smc_close_cancel_work  |
>          \- cancel_work_sync    |
>             \- __flush_work     |
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
>  net/smc/af_smc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 9d76e902fd77..ed6d4d520bc7 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -383,6 +383,7 @@ void smc_sk_init(struct net *net, struct sock *sk, int protocol)
>  	smc->limit_smc_hs = net->smc.limit_smc_hs;
>  	smc->use_fallback = false; /* assume rdma capability first */
>  	smc->fallback_rsn = 0;
> +	smc_close_init(smc);
>  }
>  
>  static struct sock *smc_sock_alloc(struct net *net, struct socket *sock,
> @@ -1299,7 +1300,6 @@ static int smc_connect_rdma(struct smc_sock *smc,
>  		goto connect_abort;
>  	}
>  
> -	smc_close_init(smc);
>  	smc_rx_init(smc);
>  
>  	if (ini->first_contact_local) {
> @@ -1435,7 +1435,6 @@ static int smc_connect_ism(struct smc_sock *smc,
>  			goto connect_abort;
>  		}
>  	}
> -	smc_close_init(smc);
>  	smc_rx_init(smc);
>  	smc_tx_init(smc);
>  
> @@ -2479,7 +2478,6 @@ static void smc_listen_work(struct work_struct *work)
>  		goto out_decl;
>  
>  	mutex_lock(&smc_server_lgr_pending);
> -	smc_close_init(new_smc);
>  	smc_rx_init(new_smc);
>  	smc_tx_init(new_smc);
>  


Thank you for the very good commit message. Makes sense to me.

Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>

