Return-Path: <linux-rdma+bounces-21061-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UK0aH7HeDWqh4QUAu9opvQ
	(envelope-from <linux-rdma+bounces-21061-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 18:17:53 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A2D591B3E
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 18:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 633DC3004D00
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 16:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFEE361666;
	Wed, 20 May 2026 16:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EkibwO+8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9067361675;
	Wed, 20 May 2026 16:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779293811; cv=none; b=qnUe+FjAW/PFKv2RSYwL0ur1sXR6hj29hBbFtvVzZ+YDvm7eylJw9T5pQyY/m3FNK5CvK8NgjO6XZhKtPlHkjmNRP99fQlc+vPFf5QwiigFA0TH9IUYozvY1F/cGwX8u99eFMVq56qpiutIq5poNY3vvlbcv8oSM2VoA5RDHI4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779293811; c=relaxed/simple;
	bh=kNPE34yawf4fp8S8rvjPg80YOS4gbsK3uw2l0myYhZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OCrmx/aQu37ZWiR5yhu4VugfI+UmwPFgcZIS11xV9zXYFt5uFdp7hBboOjrveBSq+3ycsSweESZ+w37xjhJWNq8H60TQkhqOKVn2kuPkh3P3sTmjQMRP4gFV1pLRgje0WF5naO6zTslZ8iFWLD23AkghA/IhV42e4rq9c6Lf0n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EkibwO+8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KDmC4J4037410;
	Wed, 20 May 2026 16:16:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jtBRzz
	5m60LUmJmHcV6A9sokM07eHk95J/86r8PIhMo=; b=EkibwO+8SEdyJLIXAD2Zwi
	mxxsKqThZUYDoGmWzgPKGNsUxv9RMhKAbtPnakoofzaxd4ybc/7hcy8InHJiCYyv
	TEbetSbLmrBcdKgt4EJtjJKeSl02Nz3/dZw/KnyVjEeG94MWCijBEYRx5imUuESu
	z5YE7qcb1h4kCQ2+wDpxn60Js2rAl9C7YFFarw52ldJKbUgs7f9WqN9PrXjHCIbB
	aAFUy3jOTgdN6cS1YgYqXjPR5XrWwm9XpWklOwkfOyT9eJYYZrO5NaCkpzJl4GT0
	j/GnOMs3j5u6djMctioDjEthwh7ldRKoTCfGbDFcPKj+TE/pwXG7WYOXCk0SEzXw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h752xtp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 16:16:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KFsE24015474;
	Wed, 20 May 2026 16:16:40 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wk84dx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 16:16:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64KGGaeD54919434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 16:16:36 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B26232004B;
	Wed, 20 May 2026 16:16:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 74EE220040;
	Wed, 20 May 2026 16:16:32 +0000 (GMT)
Received: from [9.124.215.187] (unknown [9.124.215.187])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 May 2026 16:16:32 +0000 (GMT)
Message-ID: <b4ee7365-1399-48db-b7ed-3a6e934e5a49@linux.ibm.com>
Date: Wed, 20 May 2026 21:46:31 +0530
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smc: Use flexible array for SMCD connections
To: Rosen Penev <rosenp@gmail.com>, linux-rdma@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Mahanta Jambigi
 <mjambigi@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:SHARED MEMORY COMMUNICATIONS (SMC) SOCKETS"
 <linux-s390@vger.kernel.org>
References: <20260519005206.628071-1-rosenp@gmail.com>
Content-Language: en-US
From: Sidraya Jayagond <sidraya@linux.ibm.com>
In-Reply-To: <20260519005206.628071-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a0dde6a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=ZbTSrghoC70LP3vHm3cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: yL4yzjBGjEmrudba89gHXfMBvJIxv2fI
X-Proofpoint-GUID: 5D1pYWNJqUTRuWPwn1m0sR9z1O8Rs8jR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE1NiBTYWx0ZWRfXytZt5/cjUxa0
 ac+VUNqDGaCd7VFoN0V0XvNbqyEB7H9+6vY6y52q4Yxwyiwjf+6eUDU9YU8AUCzsTj/k/FHh+Gy
 HzqzWRhUwM6s/6JYl2pBsS77zEibHwVzXInfti3M0Q9orc6vyZsdSKP98U8YNyRD53NT/6bKJIL
 mxyrZcSH3nFHWY1lR/lqNC8spE9tGswsvq1l7h3xqqDqRbPrZp/nbkCm1tgXYoALSKQoCcCGliB
 k4YUbxv7KHemZ4U6C9zau4ams6cDcFA52PrCNeAC6ZNMi8C9QB8+wDtW70UtTTi/q8YifVSVbc0
 VgU1O7l8Z8/+uVIrFboP0Zm64qAyOCEjy2WfhIIlG3Q9VQmUPeFHrkLl4btzfh75Csu5sktUNu+
 T2Q1Ilw5dRQnvLiXcrzsuDEOtP/Y8rKN+5wiRpE6Khvlo+oydq31VKaOcdsjP5gZyYsEaLSwmTG
 1KAhqGpaKt1H+mSJf6Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200156
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21061-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sidraya@linux.ibm.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 27A2D591B3E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 19/05/26 6:22 am, Rosen Penev wrote:
> Store the per-DMB connection pointers in the SMCD device allocation
> instead of allocating a separate connection array.
> 
> This keeps the connection table tied to the SMCD device lifetime and
> simplifies the allocation and cleanup paths.
> 
> Assisted-by: Codex:GPT-5.5
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  include/net/smc.h |  2 +-
>  net/smc/smc_ism.c | 10 ++--------
>  2 files changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/include/net/smc.h b/include/net/smc.h
> index bfdc4c41f019..a2bc3ab88075 100644
> --- a/include/net/smc.h
> +++ b/include/net/smc.h
> @@ -40,7 +40,6 @@ struct smcd_dev {
>  	struct dibs_dev *dibs;
>  	struct list_head list;
>  	spinlock_t lock;
> -	struct smc_connection **conn;
>  	struct list_head vlan;
>  	struct workqueue_struct *event_wq;
>  	u8 pnetid[SMC_MAX_PNETID_LEN];
> @@ -50,6 +49,7 @@ struct smcd_dev {
>  	atomic_t lgr_cnt;
>  	wait_queue_head_t lgrs_deleted;
>  	u8 going_away : 1;
> +	struct smc_connection *conn[];
>  };
>  
>  #define SMC_HS_CTRL_NAME_MAX 16
> diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
> index e0dba2c7b6e3..bde938c5eb39 100644
> --- a/net/smc/smc_ism.c
> +++ b/net/smc/smc_ism.c
> @@ -467,17 +467,14 @@ static struct smcd_dev *smcd_alloc_dev(const char *name, int max_dmbs)
>  {
>  	struct smcd_dev *smcd;
>  
> -	smcd = kzalloc_obj(*smcd);
> +	smcd = kzalloc_flex(*smcd, conn, max_dmbs);
>  	if (!smcd)
>  		return NULL;
> -	smcd->conn = kzalloc_objs(struct smc_connection *, max_dmbs);
> -	if (!smcd->conn)
> -		goto free_smcd;
>  
>  	smcd->event_wq = alloc_ordered_workqueue("ism_evt_wq-%s)",
>  						 WQ_MEM_RECLAIM, name);
>  	if (!smcd->event_wq)
> -		goto free_conn;
> +		goto free_smcd;
>  
>  	spin_lock_init(&smcd->lock);
>  	spin_lock_init(&smcd->lgr_lock);
> @@ -486,8 +483,6 @@ static struct smcd_dev *smcd_alloc_dev(const char *name, int max_dmbs)
>  	init_waitqueue_head(&smcd->lgrs_deleted);
>  	return smcd;
>  
> -free_conn:
> -	kfree(smcd->conn);
>  free_smcd:
>  	kfree(smcd);
>  	return NULL;
> @@ -557,7 +552,6 @@ static void smcd_unregister_dev(struct dibs_dev *dibs)
>  	list_del_init(&smcd->list);
>  	mutex_unlock(&smcd_dev_list.mutex);
>  	destroy_workqueue(smcd->event_wq);
> -	kfree(smcd->conn);
>  	kfree(smcd);
>  }
>  

Code changes looks good to me.
Reviewed-by: Sidraya Jayagond <sidraya@linux.ibm.com>

