Return-Path: <linux-rdma+bounces-3193-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1CC90A7CD
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 09:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A8192829E4
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 07:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F9918FDC4;
	Mon, 17 Jun 2024 07:55:08 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443F938396;
	Mon, 17 Jun 2024 07:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718610908; cv=none; b=N3wanslBfUYqsdZhatWxYy2K1g8uqnh9BzPK3W75lZriKnGlc+IJzyJ03lSH4Y5Yij5lgkvV7X0TO4/zHldtCNv55OaF9ht6gx6XhevDF/gkv6ViMiupy+9yKMO1jyWLDR1Deuyzau6NdtW1lDGRO1tsMRVJZxIR2ARF5KU03AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718610908; c=relaxed/simple;
	bh=hndhAOlplxognng3cxzbFWCZ9umDXFlaNtPNJzSyr8w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xlkc9Grs/vDpUZt16eV5qUuUopW78+qCI7SI80yhyrJ0cOYs/nYQlYcUwluoLyLa1szfdNZMjESvCCZVJLlDVCaRxlNaDrobyNszF8Swxp5NjDD4WHyFPfEqW/RJU/Qj5sLYbm8jq9EXQyqdA3+kUZojh9ctVtQOCQT8sTzcuM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e276183e2c7e11ef9305a59a3cc225df-20240617
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:443579d2-97eb-4e0f-91c2-287698b67311,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:8,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:23
X-CID-INFO: VERSION:1.1.38,REQID:443579d2-97eb-4e0f-91c2-287698b67311,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:8,FILE:0,BULK:0,RULE:Release_HamU,ACTION:
	release,TS:23
X-CID-META: VersionHash:82c5f88,CLOUDID:d88086991a0b95b091a265b6840480d7,BulkI
	D:2406171554551IQWSKXU,BulkQuantity:0,Recheck:0,SF:24|16|19|44|66|38|102,T
	C:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil
	,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_USA,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_UNTRUSTED, SA_UNFAMILIAR
	SN_UNTRUSTED, SN_UNFAMILIAR, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
	ABX_MISS_RDNS
X-UUID: e276183e2c7e11ef9305a59a3cc225df-20240617
X-User: lihongfu@kylinos.cn
Received: from localhost.localdomain [(223.70.159.255)] by mailgw.kylinos.cn
	(envelope-from <lihongfu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1014997129; Mon, 17 Jun 2024 15:54:54 +0800
From: Hongfu Li <lihongfu@kylinos.cn>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	allison.henderson@oracle.com
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org,
	Hongfu Li <lihongfu@kylinos.cn>
Subject: [PATCH] rds:Simplify the allocation of slab caches
Date: Mon, 17 Jun 2024 15:54:35 +0800
Message-Id: <20240617075435.110024-1-lihongfu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
to simplify the creation of SLAB caches.

Signed-off-by: Hongfu Li <lihongfu@kylinos.cn>
---
 net/rds/tcp.c      | 4 +---
 net/rds/tcp_recv.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index d8111ac83bb6..3dc6956f66f8 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -719,9 +719,7 @@ static int __init rds_tcp_init(void)
 {
 	int ret;
 
-	rds_tcp_conn_slab = kmem_cache_create("rds_tcp_connection",
-					      sizeof(struct rds_tcp_connection),
-					      0, 0, NULL);
+	rds_tcp_conn_slab = KMEM_CACHE(rds_tcp_connection, 0);
 	if (!rds_tcp_conn_slab) {
 		ret = -ENOMEM;
 		goto out;
diff --git a/net/rds/tcp_recv.c b/net/rds/tcp_recv.c
index c00f04a1a534..7997a19d1da3 100644
--- a/net/rds/tcp_recv.c
+++ b/net/rds/tcp_recv.c
@@ -337,9 +337,7 @@ void rds_tcp_data_ready(struct sock *sk)
 
 int rds_tcp_recv_init(void)
 {
-	rds_tcp_incoming_slab = kmem_cache_create("rds_tcp_incoming",
-					sizeof(struct rds_tcp_incoming),
-					0, 0, NULL);
+	rds_tcp_incoming_slab = KMEM_CACHE(rds_tcp_incoming, 0);
 	if (!rds_tcp_incoming_slab)
 		return -ENOMEM;
 	return 0;
-- 
2.25.1


