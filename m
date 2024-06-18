Return-Path: <linux-rdma+bounces-3257-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE2690C47F
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 09:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B01101C2083A
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 07:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1AE13AD0E;
	Tue, 18 Jun 2024 07:27:10 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ABC15B0F0;
	Tue, 18 Jun 2024 07:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718695630; cv=none; b=BS/Od/u12tDVspxyZCsqYfmAcb1EZ2H0ULbgks4L4US1A37R4w2Asr4ulqpCeiuSgbqrurP8SsiOPxAWSXffKcAOlNwoiLLa2oiNmEtDFKxpL7M2+x4mQRfsRDK7rEQi2DUXSCF6Rts4DOF9TuUjQxnCnmlXHThUwdD3nhGmB00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718695630; c=relaxed/simple;
	bh=v+8kEJ1OUngwE8rxso5D9lb/3tGgmgmX7ZUQc61K5XI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nUC5rSUQqljSusl1t/tSehy9J3+8ZDyiQlbs+xL/ho3m3INua5cxUaJzEERjBL/cz3CDcxHwfU6LxDRNS2QgOhDtw4EG06OnxyLxq5GTFBFHw+Ys8f8JJ5iequkrWOP3oaB/sj4SdWKg8Oq23jVN56pHRoEGOs3Idd27xkixVZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 67bed1d82d4311ef9305a59a3cc225df-20240618
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:57452060-6d28-4dc8-8c16-2a184e905e64,IP:25,
	URL:0,TC:0,Content:9,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:35
X-CID-INFO: VERSION:1.1.38,REQID:57452060-6d28-4dc8-8c16-2a184e905e64,IP:25,UR
	L:0,TC:0,Content:9,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:35
X-CID-META: VersionHash:82c5f88,CLOUDID:9d76cedba94e646680ad55363fc6a752,BulkI
	D:2406171554551IQWSKXU,BulkQuantity:1,Recheck:0,SF:24|72|19|42|74|57|66|81
	7|102,TC:nil,Content:4|-5,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:ni
	l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_LANG
	HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN
	HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED
	SRC_TRUSTED, DN_TRUSTED, SA_UNTRUSTED, SA_UNFAMILIAR, SN_UNTRUSTED
	SN_UNFAMILIAR, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-UUID: 67bed1d82d4311ef9305a59a3cc225df-20240618
X-User: lihongfu@kylinos.cn
Received: from localhost.localdomain [(223.70.159.255)] by mailgw.kylinos.cn
	(envelope-from <lihongfu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2042290132; Tue, 18 Jun 2024 15:21:39 +0800
From: Hongfu Li <lihongfu@kylinos.cn>
To: yanjun.zhu@linux.dev
Cc: allison.henderson@oracle.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	lihongfu@kylinos.cn,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	rds-devel@oss.oracle.com
Subject: [PATCH] rds:Simplify the allocation of slab caches
Date: Tue, 18 Jun 2024 15:21:21 +0800
Message-Id: <20240618072121.67838-1-lihongfu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <5a2cbc3e-bb37-4753-9c47-b196399ecf0a@linux.dev>
References: <5a2cbc3e-bb37-4753-9c47-b196399ecf0a@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
>> to simplify the creation of SLAB caches.
>> 
>> Signed-off-by: Hongfu Li <lihongfu@kylinos.cn>
>> ---
>>   net/rds/tcp.c      | 4 +---
>>   net/rds/tcp_recv.c | 4 +---
>>   2 files changed, 2 insertions(+), 6 deletions(-)
>> 
>> diff --git a/net/rds/tcp.c b/net/rds/tcp.c
>> index d8111ac83bb6..3dc6956f66f8 100644
>> --- a/net/rds/tcp.c
>> +++ b/net/rds/tcp.c
>> @@ -719,9 +719,7 @@ static int __init rds_tcp_init(void)
>>   {
>>   	int ret;
>>   
>> -	rds_tcp_conn_slab = kmem_cache_create("rds_tcp_connection",
>> -					      sizeof(struct rds_tcp_connection),
>> -					      0, 0, NULL);
>> +	rds_tcp_conn_slab = KMEM_CACHE(rds_tcp_connection, 0);

>KMEM_CACHE is declared as below:
>
>/*
>  * Please use this macro to create slab caches. Simply specify the
>  * name of the structure and maybe some flags that are listed above.
>  *
>  * The alignment of the struct determines object alignment. If you
>  * f.e. add ____cacheline_aligned_in_smp to the struct declaration
>  * then the objects will be properly aligned in SMP configurations.
>  */
>#define KMEM_CACHE(__struct, __flags)                                   \
>                 kmem_cache_create(#__struct, sizeof(struct __struct),   \
>                         __alignof__(struct __struct), (__flags), NULL)

Sorry, I'll check it carefully next time.

Thanks, 

Hongfu Li

>>   	if (!rds_tcp_conn_slab) {
>>   		ret = -ENOMEM;
>>   		goto out;
>> diff --git a/net/rds/tcp_recv.c b/net/rds/tcp_recv.c
>> index c00f04a1a534..7997a19d1da3 100644
>> --- a/net/rds/tcp_recv.c
>> +++ b/net/rds/tcp_recv.c
>> @@ -337,9 +337,7 @@ void rds_tcp_data_ready(struct sock *sk)
>>   
>>   int rds_tcp_recv_init(void)
>>   {
>> -	rds_tcp_incoming_slab = kmem_cache_create("rds_tcp_incoming",
>> -					sizeof(struct rds_tcp_incoming),
>> -					0, 0, NULL);
>> +	rds_tcp_incoming_slab = KMEM_CACHE(rds_tcp_incoming, 0);
>>   	if (!rds_tcp_incoming_slab)
>>   		return -ENOMEM;
>>   	return 0;

