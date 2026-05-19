Return-Path: <linux-rdma+bounces-20955-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJRWBN8nDGq/XgUAu9opvQ
	(envelope-from <linux-rdma+bounces-20955-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 11:05:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A221957AE02
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 11:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 39C183050CD5
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 08:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F4D3F4114;
	Tue, 19 May 2026 08:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XDLIR5Z9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2AE3EFFA1;
	Tue, 19 May 2026 08:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779181074; cv=none; b=o11Tdqvz9PjJvgbrT4QyQ6P46d2woRoqyLYrs1DVeTC2aXB0VBuuSN/Yqk2RsJBc2vz7zgkp8fBvBsPc+5BibIdsRcWEyIjvmh9fwQmmZEdp/Cs8JA1+tuNOZ0c9/OWVNJVPPXaOmV4CLuGOI2FBiPxiTf57GgiKk2BWkc6c0a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779181074; c=relaxed/simple;
	bh=vN60PjbJzbQ5WWHxaroZ1AVh/dZPqpOBY39aTDZFQYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gsw3Sa+y9fR4QQFZDuYNOJ75PssbOrN3uKeH/V79AW1TDKl2jTUbqXSvn045eSRFqiSTA0hI9p0ek4nPje58dQpTfZZR7sGD92ifDajekw/z/RB9kQeRGbFkQ77w9ZxgVtX8W7vEdxsccVeqplrUf3pl/KksVBRqOfjtHRyOh5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XDLIR5Z9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J8YKSs470901;
	Tue, 19 May 2026 08:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QZH9wj
	cmIeE57wNi9FaEDmYSxnaFxNVYbUX3qCAT3wM=; b=XDLIR5Z9JjZi84UpYkXXsv
	S0pmV6syQWYXwM58xszVogQsCYyvWWTjsdYQnJMQLIQsCw4sisvm4HfVBTu8LWeK
	zENCB5rsKc+Q+akqPUe+I6kTm5cubCEdkboRd5ex5lubk9JLND6JfduswXUgq3rK
	se3Z2RHttWAVL6nOjdsaHGhyVqSjstzkp2iUuboC7VCf0h+xIZlgmHnnzwYVjmIc
	BsG7TZ3wAwbL3Rk5oBb2nzBqEk+agMeRn2TKdKKN7rzVmRt4FQupgPIfgrysBH0I
	z24LFjhE5OZyMMP+iL0QlY8S1dBhROJ/CI1cxCaupuqNJA+8FUFYaLIuJD2ZGbeg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h88be9g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 08:57:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64J8sD5R028409;
	Tue, 19 May 2026 08:57:45 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e72wq207x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 08:57:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64J8vfC255574806
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 08:57:42 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9174F2004B;
	Tue, 19 May 2026 08:57:41 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B56E320043;
	Tue, 19 May 2026 08:57:40 +0000 (GMT)
Received: from [9.87.137.247] (unknown [9.87.137.247])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 May 2026 08:57:40 +0000 (GMT)
Message-ID: <0b4cff6d-b9e7-4c34-9279-93bec10bcc9d@linux.ibm.com>
Date: Tue, 19 May 2026 10:57:40 +0200
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
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Wenjia Zhang
 <wenjia@linux.ibm.com>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:SHARED MEMORY COMMUNICATIONS (SMC) SOCKETS"
 <linux-s390@vger.kernel.org>
References: <20260519005206.628071-1-rosenp@gmail.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20260519005206.628071-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: T4Kd7USZJpDqbwodVidxmi3qJ_Xz86fM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDA4NCBTYWx0ZWRfX8Qx4Fdsu03TB
 WnPnFwdyPvVZXG410i4JnnDXqp4qb/X8QcpOyruZR4eipM4whehWaCVeJx5r/sAA5fgbqhqq/n8
 6vyhizwTwzHc8aQ671828T62Rax8n7HjZJUYEelGuULMrwhyLSmk0007JSkdgRFysl8a1nr7hgp
 7PhALXslPZyIvkZqCdq7dub7S3bFKFEFRRshIncKCpxx5gQTGULYInWYloBS7O1hvehOpOaEEES
 KwXvpudjmheCXrzFofasz2eV1xwcJlTrEXiyCqgxpmpZ+Q5In0x01GJdq7KRpFNUMpTJwr7/7IJ
 m65aIRSArriH/RwxRI/btKgfJED14VVUDxMNDTXNo1Qr+YdKKA1LMMPlwC7FRjAei0VAJagW6R9
 sPkUzK4dXq1d5fcvInCl6M9e0R4e4Cgcymvnu35b1wKCfQi5Dou0qF9eu3W7N+s1L3tCp/Oqnpm
 b1FdPocRbI38euoBOdg==
X-Proofpoint-GUID: JTgSCbU6zysfeA6G2s3ICnZRbfyyTsut
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a0c260b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=pGLkceISAAAA:8
 a=uY9fc7PcPamsBxGr6G4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605190084
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20955-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wintera@linux.ibm.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: A221957AE02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 19.05.26 02:52, Rosen Penev wrote:
> Store the per-DMB connection pointers in the SMCD device allocation
> instead of allocating a separate connection array.
> 
> This keeps the connection table tied to the SMCD device lifetime and
> simplifies the allocation and cleanup paths.
> 
> Assisted-by: Codex:GPT-5.5
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---

I don't think GPT did a good job here.
There are many other instances, where smcd->conn is freed,
those would need adoption as well afaiu.

I am also not sure that there is enough improvement in the idea
to warrant a patch, but I leave that to the SMC maintainers.



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


