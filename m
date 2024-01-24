Return-Path: <linux-rdma+bounces-717-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6179383A39D
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jan 2024 08:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AB2A2937F5
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jan 2024 07:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F9C171BA;
	Wed, 24 Jan 2024 07:58:21 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B3117543;
	Wed, 24 Jan 2024 07:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706083101; cv=none; b=AGFigSXvv98amzNaU/70wyvWMWrsJGlmp82jlfMxreX1rww3wfQki3f1ed58V7EPP2PUtsKnL9CXelpQlccAupboGzymn6tQEEifm6uocI0YIJYstKRny5/SVXsfBk44s03pMsGDO/XjJGQT2Wj9m0Uu36oQAN5AczIf23HzcPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706083101; c=relaxed/simple;
	bh=1v3O0YVMPI+F7nAtQ6rXg2jQUbThSXmEGB9qvSA8O5g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pFAw9f5jMcGmxTQSyI9wvc+WiNIHWmTXfat8ZGz1mXjHIsV6rxpAZwxj9ZTMiPO3NqACFSFNLyL6n2+H+h2nQESSXtsGWg0k224aoTpdSsPVUGBVGlYit3gGE+Rs8DyzLkwy1EM694rKg5wyULNngxU1rm5PbpeYkmbi6gLxxqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 299d9bbcd641409e9a7b28d2a21bd8ad-20240124
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:924919e9-e9e1-45c7-b695-27da69cd3540,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:924919e9-e9e1-45c7-b695-27da69cd3540,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:11c5998e-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:240124155807WFON35KP,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|44|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 299d9bbcd641409e9a7b28d2a21bd8ad-20240124
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2099680962; Wed, 24 Jan 2024 15:58:05 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id DBC79E000EB9;
	Wed, 24 Jan 2024 15:58:04 +0800 (CST)
X-ns-mid: postfix-65B0C30C-697750425
Received: from kernel.. (unknown [172.20.15.234])
	by mail.kylinos.cn (NSMail) with ESMTPA id 3762CE000EB9;
	Wed, 24 Jan 2024 15:58:03 +0800 (CST)
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
Subject: [PATCH] net: rds: Simplify the allocation of slab caches in rds_conn_init
Date: Wed, 24 Jan 2024 15:58:01 +0800
Message-Id: <20240124075801.471330-1-chentao@kylinos.cn>
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
 net/rds/connection.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/rds/connection.c b/net/rds/connection.c
index b4cc699c5fad..c749c5525b40 100644
--- a/net/rds/connection.c
+++ b/net/rds/connection.c
@@ -829,9 +829,7 @@ int rds_conn_init(void)
 	if (ret)
 		return ret;
=20
-	rds_conn_slab =3D kmem_cache_create("rds_connection",
-					  sizeof(struct rds_connection),
-					  0, 0, NULL);
+	rds_conn_slab =3D KMEM_CACHE(rds_connection, 0);
 	if (!rds_conn_slab) {
 		rds_loop_net_exit();
 		return -ENOMEM;
--=20
2.39.2


