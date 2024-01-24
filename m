Return-Path: <linux-rdma+bounces-716-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3099183A257
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jan 2024 07:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE9D628356F
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jan 2024 06:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EDC134CD;
	Wed, 24 Jan 2024 06:52:22 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EA9168A4;
	Wed, 24 Jan 2024 06:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706079142; cv=none; b=Qz0U1C+7SbaIvD2F/If/vMPeaExM8QrL2jmTvMkNQmTe8VfVeFgkgdtnk6LeqYdx2hm8YENM+nLJr54eHhS4M7cDWzRpDnZt36qEktyTFfSO/3BlYX+CsKbBvO9NwLtk/P8nTJawV6XCMIji4fZWuPQwNe6a+3UaLC+VqqFYO6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706079142; c=relaxed/simple;
	bh=2gG83sfVnMnpj1PwNtosLhy2mgrSAfycSWCXarHBPic=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dyuOfCWLEF5P+L2OWVz580jGbb1pkLK2bW56UP1+MOuMAlRTEYF+xVNAj2owGNJApBwlnVgcn/3l+fTIEXL6bUHtUr9U2bHihoT82lKkptxYsoclNeJrUmrRL8lTZQ3idE67D2Xn2T9T137SiUl0g490/kfXmWZnbwNmwIknoGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4fb796d1e5684301ba7f95fc5bfe8ed3-20240124
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:04c5d8b8-b5c4-453a-a4dd-ec9d73c07a80,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:5
X-CID-INFO: VERSION:1.1.35,REQID:04c5d8b8-b5c4-453a-a4dd-ec9d73c07a80,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-META: VersionHash:5d391d7,CLOUDID:e6fd988e-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:2401241452084ZXC2A0F,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|44|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 4fb796d1e5684301ba7f95fc5bfe8ed3-20240124
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1003242987; Wed, 24 Jan 2024 14:52:07 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 8444CE000EB9;
	Wed, 24 Jan 2024 14:52:07 +0800 (CST)
X-ns-mid: postfix-65B0B397-315832218
Received: from kernel.. (unknown [172.20.15.234])
	by mail.kylinos.cn (NSMail) with ESMTPA id 313D8E000EB9;
	Wed, 24 Jan 2024 14:52:06 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: santosh.shilimkar@oracle.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] net: rds: Simplify the allocation of slab caches in rds_tcp_init
Date: Wed, 24 Jan 2024 14:51:57 +0800
Message-Id: <20240124065157.467348-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
to simplify the creation of SLAB caches.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 net/rds/tcp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index 2dba7505b414..73317c86e995 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -720,9 +720,7 @@ static int __init rds_tcp_init(void)
 {
 	int ret;
=20
-	rds_tcp_conn_slab =3D kmem_cache_create("rds_tcp_connection",
-					      sizeof(struct rds_tcp_connection),
-					      0, 0, NULL);
+	rds_tcp_conn_slab =3D KMEM_CACHE(rds_tcp_connection, 0);
 	if (!rds_tcp_conn_slab) {
 		ret =3D -ENOMEM;
 		goto out;
--=20
2.39.2


