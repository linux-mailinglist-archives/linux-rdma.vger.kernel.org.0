Return-Path: <linux-rdma+bounces-6076-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AF49D61B3
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2024 17:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2BDCB218BC
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2024 16:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AC21ABEB0;
	Fri, 22 Nov 2024 16:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XBWUFSJR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7053E2E3EE;
	Fri, 22 Nov 2024 16:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732291429; cv=none; b=i+JAdxukXl3s3FxewlprP/h7g8SkcSRHce6oJjgtdYSaNHwnrVULiqbayW8ilZtaX7TW7wnJdsDWS4TZBc8xhtLbAgZXpssnJLpL0Sed4HxArn87qog5NWkDMG+VDhUFRszB61Z6kgsNJuoGL8YDE/8EBtiCImgjSRkWF4ZV7G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732291429; c=relaxed/simple;
	bh=JwxNw5AkHhLwSbIy+fcUkdftsoNLiYQ4BZfb57dX64c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I05yvzK9WG2Q221iAT2Di9LJ6KMieuvoVyB4auTt5dBo8qrIZVjvs+Shmu1iWwz5ljfpgDwQDxCuUEXAZJLXY4d4HYwKT6qoSlXX6SU15ITOsz6keZ03fYheq27xufcF9D4S4SYruxA6NM5UcZdgfP4pUsg3h5v5fl3JzImzK5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XBWUFSJR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMCIwjP010456;
	Fri, 22 Nov 2024 16:03:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=x11/Od
	pS9QyEjMyOpYBRIjtC9gU6RGquDgl4eCqQ0z0=; b=XBWUFSJRy52o6L+bkfSTFL
	aA7Y7CcTv7LS9abSrSNCSTCdDtYO+XGiru/oxrAI9SJkLzQjVnZvakDTflayma+D
	77fe8X6bFaurlst3hRe2FoVB82zxmXitddg76VxfV8lWAugp6wW8L2YSz/PowNB3
	woEOXL3B+dpdPuZJIA+BVmguUo79nVOCDk8DB5Fa5bGsME0WBEDjr5jQrq5yqKXJ
	BPWKgXWiz5ZcXto01HG9SpR3PU5a1yXwNttukHlIr4a3eX3ziwRooPDqHbdyZ8Xb
	Htyn+NcWR7I4DjctDFSAxzj5cx/PPxnrAtZqAf/HE6ty3IZy8Y8STs7WCkbnJ6nQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 432fw248ca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 16:03:39 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AMG3cas011394;
	Fri, 22 Nov 2024 16:03:38 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 432fw248c6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 16:03:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMBg0nY011430;
	Fri, 22 Nov 2024 16:03:37 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42y7xjuagd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 16:03:37 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AMG3YLo54460856
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 16:03:34 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 618D42005A;
	Fri, 22 Nov 2024 16:03:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC5B92004F;
	Fri, 22 Nov 2024 16:03:33 +0000 (GMT)
Received: from [9.171.57.248] (unknown [9.171.57.248])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 Nov 2024 16:03:33 +0000 (GMT)
Message-ID: <5688fe46-dda0-4050-ba24-eb5ef573f120@linux.ibm.com>
Date: Fri, 22 Nov 2024 17:03:33 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] net/smc: fix LGR and link use-after-free issue
Content-Language: en-US
To: Wen Gu <guwen@linux.alibaba.com>, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc: alibuda@linux.alibaba.com, tonylu@linux.alibaba.com, horms@kernel.org,
        linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241122071630.63707-1-guwen@linux.alibaba.com>
 <20241122071630.63707-3-guwen@linux.alibaba.com>
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20241122071630.63707-3-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8kCuRs91ibQ_n5qQfpb6pX1KSUa2h7r2
X-Proofpoint-ORIG-GUID: TZJINKf0fvbJq6LVLl_5YJy_BYXT2oNV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 adultscore=0 bulkscore=0 phishscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=956
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411220135



On 22.11.24 08:16, Wen Gu wrote:
> We encountered a LGR/link use-after-free issue, which manifested as
> the LGR/link refcnt reaching 0 early and entering the clear process,
> making resource access unsafe.
> 
>  refcount_t: addition on 0; use-after-free.
>  WARNING: CPU: 14 PID: 107447 at lib/refcount.c:25 refcount_warn_saturate+0x9c/0x140
>  Workqueue: events smc_lgr_terminate_work [smc]
>  Call trace:
>   refcount_warn_saturate+0x9c/0x140
>   __smc_lgr_terminate.part.45+0x2a8/0x370 [smc]
>   smc_lgr_terminate_work+0x28/0x30 [smc]
>   process_one_work+0x1b8/0x420
>   worker_thread+0x158/0x510
>   kthread+0x114/0x118
> 
> or
> 
>  refcount_t: underflow; use-after-free.
>  WARNING: CPU: 6 PID: 93140 at lib/refcount.c:28 refcount_warn_saturate+0xf0/0x140
>  Workqueue: smc_hs_wq smc_listen_work [smc]
>  Call trace:
>   refcount_warn_saturate+0xf0/0x140
>   smcr_link_put+0x1cc/0x1d8 [smc]
>   smc_conn_free+0x110/0x1b0 [smc]
>   smc_conn_abort+0x50/0x60 [smc]
>   smc_listen_find_device+0x75c/0x790 [smc]
>   smc_listen_work+0x368/0x8a0 [smc]
>   process_one_work+0x1b8/0x420
>   worker_thread+0x158/0x510
>   kthread+0x114/0x118
> 
> It is caused by repeated release of LGR/link refcnt. One suspect is that
> smc_conn_free() is called repeatedly because some smc_conn_free() are not
> protected by sock lock.
> 
> Calls under socklock        | Calls not under socklock
> -------------------------------------------------------
> lock_sock(sk)               | smc_conn_abort
> smc_conn_free               | \- smc_conn_free
> \- smcr_link_put            |    \- smcr_link_put (duplicated)
> release_sock(sk)
> 
> So make sure smc_conn_free() is called under the sock lock.
> 
> Fixes: 8cf3f3e42374 ("net/smc: use helper smc_conn_abort() in listen processing")
> Co-developed-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
> Co-developed-by: Kai <KaiShen@linux.alibaba.com>
> Signed-off-by: Kai <KaiShen@linux.alibaba.com>
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---
>  net/smc/af_smc.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index ed6d4d520bc7..e0a7a0151b11 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -973,7 +973,8 @@ static int smc_connect_decline_fallback(struct smc_sock *smc, int reason_code,
>  	return smc_connect_fallback(smc, reason_code);
>  }
>  
> -static void smc_conn_abort(struct smc_sock *smc, int local_first)
> +static void __smc_conn_abort(struct smc_sock *smc, int local_first,
> +			     bool locked)
>  {
>  	struct smc_connection *conn = &smc->conn;
>  	struct smc_link_group *lgr = conn->lgr;
> @@ -982,11 +983,27 @@ static void smc_conn_abort(struct smc_sock *smc, int local_first)
>  	if (smc_conn_lgr_valid(conn))
>  		lgr_valid = true;
>  
> -	smc_conn_free(conn);
> +	if (!locked) {
> +		lock_sock(&smc->sk);
> +		smc_conn_free(conn);
> +		release_sock(&smc->sk);
> +	} else {
> +		smc_conn_free(conn);
> +	}
>  	if (local_first && lgr_valid)
>  		smc_lgr_cleanup_early(lgr);
>  }
>  
> +static void smc_conn_abort(struct smc_sock *smc, int local_first)
> +{
> +	__smc_conn_abort(smc, local_first, false);
> +}
> +
> +static void smc_conn_abort_locked(struct smc_sock *smc, int local_first)
> +{
> +	__smc_conn_abort(smc, local_first, true);
> +}
> +
>  /* check if there is a rdma device available for this connection. */
>  /* called for connect and listen */
>  static int smc_find_rdma_device(struct smc_sock *smc, struct smc_init_info *ini)
> @@ -1352,7 +1369,7 @@ static int smc_connect_rdma(struct smc_sock *smc,
>  
>  	return 0;
>  connect_abort:
> -	smc_conn_abort(smc, ini->first_contact_local);
> +	smc_conn_abort_locked(smc, ini->first_contact_local);
>  	mutex_unlock(&smc_client_lgr_pending);
>  	smc->connect_nonblock = 0;
>  
> @@ -1454,7 +1471,7 @@ static int smc_connect_ism(struct smc_sock *smc,
>  
>  	return 0;
>  connect_abort:
> -	smc_conn_abort(smc, ini->first_contact_local);
> +	smc_conn_abort_locked(smc, ini->first_contact_local);
>  	mutex_unlock(&smc_server_lgr_pending);
>  	smc->connect_nonblock = 0;
>  

I wonder if this can deadlock, when you take lock_sock so far down in the callchain.
example:
 smc_connect will first take lock_sock(sk) and then mutex_lock(&smc_server_lgr_pending);  (e.g. in smc_connect_ism())
wheras
smc_listen_work() will take mutex_lock(&smc_server_lgr_pending); and then lock_sock(sk) (in your __smc_conn_abort(,,false))

I am not sure whether this can be called on the same socket, but it looks suspicious to me.


All callers of smc_conn_abort() without socklock seem to originate from smc_listen_work(). 
That makes me think whether smc_listen_work() should do lock_sock(sk) on a higher level.

Do you have an example which function could collide with smc_listen_work()?
i.e. have you found a way to reproduce this?


Are you sure that all callers of smc_conn_free(), that are not smc_conn_abort(), do set the socklock?
It seems to me that the path of smc_conn_kill() is not covered by your solution.


Please excuse, that I am not deeply familiar with this code. 
I'm just trying to ask helpful questions.

