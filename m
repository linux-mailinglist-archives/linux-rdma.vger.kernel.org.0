Return-Path: <linux-rdma+bounces-19680-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACYdCJPk8GmoagEAu9opvQ
	(envelope-from <linux-rdma+bounces-19680-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 18:47:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC28D489453
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 18:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B77FF30D24A8
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 16:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED5C3033F5;
	Tue, 28 Apr 2026 16:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFWpn26c"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B593195E4
	for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 16:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393948; cv=none; b=lO/OdweMhuow/Ngyy5gnZNlGSyj59L2m5GXdwstvEonSIwhmkejRJc571oQn8WzUlYXXkhozqpXIKRO93yVWmKWQUrPgoi7yUE7/9hBOyhxgfmQsPApwXPl1i/0do7t+UPmC4fLiNIPmG1xSM4UdEoKWM39suI7aOCJWoS7D2tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393948; c=relaxed/simple;
	bh=0ENRuXWI0OBYQahVdx+XhQkYgeiN8tN1qPvBInEH5dM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RxC9YWu0u4ILZ6VmuhokOrciPjtDJlgUYyQ8jhx0h6xisrFE+2SMQf2UZ+JsQDNMU5RFW2P4baJFE8v60+/OxF9ZiMHW15YKeXdNxUDJvQW20g5FkOUt5k1fbGK2hkv3AcTuluwzabt8dVMBPKN43dPYPjIf8ltl/Uo7pZJmZK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFWpn26c; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82faf871346so7285855b3a.0
        for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 09:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777393947; x=1777998747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kF3liaLTsQt3vcqZoazicjJL/7jtNYNyKZT6lA6QbTA=;
        b=PFWpn26cswgQcVH0Y8W1MjOJEM3M9b7bYA+E908TKr9TTnGfgcVEYBbScM9kQUpq6K
         BoRMll+fJSyRMos+S3B92XCSpJbPpVi8mUftBLzNnc9g8+A/rW86GdjV3lw6H6uIboj6
         ZYWIjlcJkaSsncQ99bNcet7NsfM+CR6Yjoxq4h7KAO5FDkUpVXFFQPx9V/FB7P7YIxU5
         YCAtQH2QAlvb77NfvuJdCeLj1vLDXI8qQcWPguq3QzHWj+5lPSNNfGD9Lo5Nb2evNQpD
         u5cTrR61w2THeQNig+dbPHpWkFuHkZxZ2bJRQscvRhXGZtiunLINEZDo1kwb/wu9wHUK
         0ICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777393947; x=1777998747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kF3liaLTsQt3vcqZoazicjJL/7jtNYNyKZT6lA6QbTA=;
        b=Fqc178Y7+Aj/ieLruCKihz+ARE5oID+pV4VgA+hM4iLOJGfkfhN+/uoMKueBQ1WIEU
         1f88GsG1IFlBJ9+f+CXoeHPjYuNwujIM3yOKt9m+cMyDazC0KyByw6nqKOoPCQLuKNF9
         o1WoLmLnm+kg9wZBnmn7kXGPgJ6WhGmYjyoe9CsMcJrWiNqjU4Ccr1y6vvek2lbOwMPY
         3kII2sZbp1CNZ3BF2QBRg0Gq9tNhSQr3jbK4g2vAlLHHoiMzyW9SKfckOzLL0wLn2JS7
         +/ovl+UT/XvTP/sKYquStnK5OiXRSGyYnjqGjvvaXXFvMm3Qj7SQmKd3TVZI/NpNjJS5
         13pg==
X-Forwarded-Encrypted: i=1; AFNElJ+OOus4SyFFHSEeEbI30UG6fqKl4H91Bs9/lywIJjDxNKNs7X/cNBTsstcom0ngqwuHG9ixPfhUFbWb@vger.kernel.org
X-Gm-Message-State: AOJu0YwJwQiiyzaI+400ENybMHl0pVQrAeBzcCJzudu0aRyudVXsnVdb
	2fZ5yP9vd/2Rgs2QP96XV7y7G1U6VOaKT+E175+yzBwufUxIIcW2J6Eh
X-Gm-Gg: AeBDieuGoSDhhriNKij4dREhfMRwHxLAIh8pB23Ll8r4bcBRxp+7WOtu6O1Sie2wl45
	pm4HKlqC+1JoMNJhb0H/cQn9nwJB2YYdxbxsBh2WJ12OPZhWcKGWP9GFLzwCVzgj9+QfgBJnf1C
	ttuprBwJ34ahRWyl7Lhm6vbmQFJIaCnGxEtgM/zGUcfpqwrvK9Gi+04QF+kQB0IOm0rfkHNrPtf
	RH/QOM3BZT14I48M6uJD9V7oWtIHBi64GJjN53Vt5+E3k/bCE5nm3Kb1SxMnO6aEn3hdYBdeydL
	g8SSLAUwFj/nfLnHi820Zi6IytsMfEcQnh2UzOxPL1xHeEjYCeT9lOz6mFD68ZYOJACDxQFcgjz
	Qq3OgMGjQJqyDJDw57rvRv3SwbPYA2LoQtDP2bbsfXvMOGFU0/GnrE93Y1mDhRixV/6YndWHmxr
	RyL2EMTRWbum9uLAH3nM24eQ+H1vg=
X-Received: by 2002:a05:6a00:f93:b0:82f:8b20:9165 with SMTP id d2e1a72fcca58-834ddc9b31dmr4003728b3a.44.1777393946400;
        Tue, 28 Apr 2026 09:32:26 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::5a26])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834dae00a4fsm3212266b3a.5.2026.04.28.09.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 09:32:25 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Yishai Hadas <yishaih@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Roland Dreier <roland@purestorage.com>,
	Jack Morgenstein <jackm@dev.mellanox.co.il>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH v4] IB/mlx4: Fix refcount leak in add_port() error path
Date: Wed, 29 Apr 2026 00:30:14 +0800
Message-ID: <20260428163014.379069-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BC28D489453
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-19680-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

After kobject_init_and_add(), the lifetime of the embedded struct
kobject is expected to be managed through the kobject core reference
counting.

In add_port(), several failure paths after kobject_init_and_add() free
struct mlx4_port directly instead of releasing the embedded kobject with
kobject_put(). This leaves the kobject reference count unbalanced and can
lead to incorrect lifetime handling.

Fix this by routing all failures after kobject_init_and_add() through a
single kobject_put() based error path. Since the release callback may now
be called for partially initialized mlx4_port objects, make
mlx4_port_release() tolerate NULL attribute arrays.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: c1e7e466120b ("IB/mlx4: Add iov directory in sysfs under the ib device")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v4:
  - route all add_port() failures after kobject_init_and_add() through
    a single kobject_put() based error path
  - remove duplicated attribute array frees from add_port()
  - keep mlx4_port_release() tolerant of partially initialized objects

v3:
  - make mlx4_port_release() tolerate NULL attribute arrays
  - drop the parent kobject reference on the kobject_init_and_add()
    failure path before putting the embedded kobject

v2:
  - note that the issue was identified by my static analysis tool
  - and confirmed by manual review

 drivers/infiniband/hw/mlx4/sysfs.c | 44 ++++++++++++++----------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/sysfs.c b/drivers/infiniband/hw/mlx4/sysfs.c
index b8fa4ecfc961..fe505e07849d 100644
--- a/drivers/infiniband/hw/mlx4/sysfs.c
+++ b/drivers/infiniband/hw/mlx4/sysfs.c
@@ -380,12 +380,17 @@ static void mlx4_port_release(struct kobject *kobj)
 	struct attribute *a;
 	int i;
 
-	for (i = 0; (a = p->pkey_group.attrs[i]); ++i)
-		kfree(a);
-	kfree(p->pkey_group.attrs);
-	for (i = 0; (a = p->gid_group.attrs[i]); ++i)
-		kfree(a);
-	kfree(p->gid_group.attrs);
+	if (p->pkey_group.attrs) {
+		for (i = 0; (a = p->pkey_group.attrs[i]); ++i)
+			kfree(a);
+		kfree(p->pkey_group.attrs);
+	}
+
+	if (p->gid_group.attrs) {
+		for (i = 0; (a = p->gid_group.attrs[i]); ++i)
+			kfree(a);
+		kfree(p->gid_group.attrs);
+	}
 	kfree(p);
 }
 
@@ -623,7 +628,6 @@ static void remove_vf_smi_entries(struct mlx4_port *p)
 static int add_port(struct mlx4_ib_dev *dev, int port_num, int slave)
 {
 	struct mlx4_port *p;
-	int i;
 	int ret;
 	int is_eth = rdma_port_get_link_layer(&dev->ib_dev, port_num) ==
 			IB_LINK_LAYER_ETHERNET;
@@ -640,7 +644,7 @@ static int add_port(struct mlx4_ib_dev *dev, int port_num, int slave)
 				   kobject_get(dev->dev_ports_parent[slave]),
 				   "%d", port_num);
 	if (ret)
-		goto err_alloc;
+		goto err_put;
 
 	p->pkey_group.name  = "pkey_idx";
 	p->pkey_group.attrs =
@@ -649,44 +653,36 @@ static int add_port(struct mlx4_ib_dev *dev, int port_num, int slave)
 				  dev->dev->caps.pkey_table_len[port_num]);
 	if (!p->pkey_group.attrs) {
 		ret = -ENOMEM;
-		goto err_alloc;
+		goto err_put;
 	}
 
 	ret = sysfs_create_group(&p->kobj, &p->pkey_group);
 	if (ret)
-		goto err_free_pkey;
+		goto err_put;
 
 	p->gid_group.name  = "gid_idx";
 	p->gid_group.attrs = alloc_group_attrs(show_port_gid_idx, NULL, 1);
 	if (!p->gid_group.attrs) {
 		ret = -ENOMEM;
-		goto err_free_pkey;
+		goto err_put;
 	}
 
 	ret = sysfs_create_group(&p->kobj, &p->gid_group);
 	if (ret)
-		goto err_free_gid;
+		goto err_put;
 
 	ret = add_vf_smi_entries(p);
 	if (ret)
-		goto err_free_gid;
+		goto err_put;
 
 	list_add_tail(&p->kobj.entry, &dev->pkeys.pkey_port_list[slave]);
 	return 0;
 
-err_free_gid:
-	kfree(p->gid_group.attrs[0]);
-	kfree(p->gid_group.attrs);
-
-err_free_pkey:
-	for (i = 0; i < dev->dev->caps.pkey_table_len[port_num]; ++i)
-		kfree(p->pkey_group.attrs[i]);
-	kfree(p->pkey_group.attrs);
-
-err_alloc:
+err_put:
 	kobject_put(dev->dev_ports_parent[slave]);
-	kfree(p);
+	kobject_put(&p->kobj);
 	return ret;
+
 }
 
 static int register_one_pkey_tree(struct mlx4_ib_dev *dev, int slave)
-- 
2.43.0


