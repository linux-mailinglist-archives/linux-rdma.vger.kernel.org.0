Return-Path: <linux-rdma+bounces-19659-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IASyFWDX8GlHaAEAu9opvQ
	(envelope-from <linux-rdma+bounces-19659-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 17:50:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AC54883E1
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 17:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 79FDA3029A1D
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 15:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3626C42EEC0;
	Tue, 28 Apr 2026 15:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YouJ1J/B"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81C4429833
	for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 15:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777391380; cv=none; b=jOPwYUZ4zZJ4PKcPjBqfQfOgALpseVCUo60BvaZnjchqNehyyC8O8umUgrcMffQ3BMzGncTFPcg8jg5LKFtCUUDhweMJbOxZMiJK97cs1eYUVEWeVi9VDkAwYtZbh8Tt7r7m+QXRy+m/LDe8VMczlADzVvtBohAidGRFWmjhC9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777391380; c=relaxed/simple;
	bh=gEq1WNSpClxLJGJHfzct1aBrVImuzfvAm+8wE/BNLqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rOzgeq7h8p74bboZwuBwDeORZD2sJUwBXTHLU23snjfCinbZQB0Lf1siluY6qKfQRxt32lhvY99pCfn1VPtTqg995UOgf+GaE76OOKUIG0aEcOdAUblmAO2qa6TCiRRVjlIvAjux8xIr3ZewhByyI9lokN7tOtFhHWbcShW5qX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YouJ1J/B; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c76b994f7a8so4664535a12.3
        for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 08:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777391378; x=1777996178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xwkwixniYzyB4iGLWVcHnfTyiUGtbDFLnU92Lc6bweo=;
        b=YouJ1J/BMRLN2JReSOGGPe2whjYVK67N8S6LyjxbqEXIkQ8L2LH5gcDGnJMBL6bykF
         xcEJi2Pv669hoBSulFjOJaIZ8n+rSeZR1vKRkJBGFdi76fAw0iJMKV2kchNMXuIkaqeE
         1eg41EU1OG28TNWsRU9Six0gymBA8Pz2ZKK++t/HS1KcV8EQDGrvVa0tDmfZgoXz2o+t
         grEOkwER4dRD1SbgaL27n7bZRdRURCoSkevtfoXWCdvLZDjI7WkWIFeO8UHhHjDLFpVy
         5G9nxWZou6HGplfMwzF0TP8v8kUmW67r3twH2RybL3QhVaQkSGBJwTUbV9UDIf/3JNMe
         ghgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777391378; x=1777996178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwkwixniYzyB4iGLWVcHnfTyiUGtbDFLnU92Lc6bweo=;
        b=kc+M4TlD0hFLIl6+BdIi5FZGFSau+4bfqJEspHRYl1jUG51EV3RDFD7sffl/AuYROk
         uee+LV9NVC7fIifuXP8okw69GLemea1/FAvuDmIv23cP/aJUtLzNxYhdCd2QQ+oay5Cy
         vGgtneQZ5l4UcHn4P3+0UM/ZqbcgpQOeEkIsAv+s07jeQRXMOE3sXX+pxcV15X0ZTW91
         t98EKvHYrTNjsAFAVaG5fzQ+ZqcVN0tNwFX9uHAf0osSvtQ1yie+jYXRoozDPxDgBmr9
         UEHMaEK7lQ2XRUwQ7h3b3J3os3TDqnQ321HSy9voEAixn5glcnRBbOPKy38cHyg6Glq+
         5joA==
X-Forwarded-Encrypted: i=1; AFNElJ8JQcqs7jHOoeUEoUH9j/rW4WYzROQ61niutgic2CL10PU0IaOmCC7Hv9v9ARYzDOT/bTG3c4UB6lmS@vger.kernel.org
X-Gm-Message-State: AOJu0YwRJse2p/8EO3PcVrorVs4Xpao8Xz4nlIq5QQ7uBG1LRhtKUomU
	5VrJmfjT8IBZKDyP+X1SE2uCN0jJJaMjB8qQzJpiD8DCg3zqpQztARDnUSV9+d0fZVChzQ==
X-Gm-Gg: AeBDieuKNZaPXkB9iEQNvwkuBY8243RC4Z+uEfTU5KjULZdj+/OPQUCEYmD6tjivfhw
	PLqjFh3GryIgUyO1wbb/HAkQpnXQG5T4qmvZsS/dQbHeT+Ltr7RWqHJabjPAOrFF3L8j6wS9dYF
	fMRGS2/tDeTNpzeVEqY/tez7LPZA4IiM6peTfecRpBLGvbf3hVRU3B7GcUwiF69Yoc7l1WoLFXu
	RKSykLVZYvpKKD9QLPKPf+uOMexrG32/0bnogOKZBRzux/DuEi4pXPQv0w4+f3BG1hL+8HRbix0
	wWCJheIlqZtXLlZeTdsYWtrgnvadqzSsk6RYqphSbzoCASBRrSTQu2139fpOAAAN00TjDPcUM7w
	uvJU0Doh1N4RGsHHySlNciL2O/jG3Vi2y6AK+seHKiuEnP3IwCC9lp044Pd8LJdixlspSer+RFM
	/N/eQkuOwAtWXxzuJJ
X-Received: by 2002:a17:902:b689:b0:2ae:450c:951e with SMTP id d9443c01a7336-2b97c435bc1mr23615015ad.17.1777391377862;
        Tue, 28 Apr 2026 08:49:37 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::5a26])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b97aaaf65fsm30416065ad.31.2026.04.28.08.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 08:49:37 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Yishai Hadas <yishaih@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Jack Morgenstein <jackm@dev.mellanox.co.il>,
	Roland Dreier <roland@purestorage.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] IB/mlx4: Fix refcount leak in add_port() error path
Date: Tue, 28 Apr 2026 23:47:16 +0800
Message-ID: <20260428154716.375069-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F1AC54883E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-19659-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

After kobject_init_and_add(), the lifetime of the embedded struct
kobject is expected to be managed through the kobject core reference
counting.

In add_port(), if kobject_init_and_add() fails, the error path frees p
directly instead of releasing the kobject reference with kobject_put().
This may leave the reference count of the embedded struct kobject
unbalanced, resulting in a refcount leak and potentially leading to a
use-after-free.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fix this by using kobject_put(&p->kobj) in the kobject_init_and_add()
failure path.

Fixes: c1e7e466120b ("IB/mlx4: Add iov directory in sysfs under the ib device")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v3:
  - make mlx4_port_release() tolerate NULL attribute arrays
  - drop the parent kobject reference on the kobject_init_and_add()
    failure path before putting the embedded kobject

v2:
  - note that the issue was identified by my static analysis tool
  - and confirmed by manual review

 drivers/infiniband/hw/mlx4/sysfs.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/sysfs.c b/drivers/infiniband/hw/mlx4/sysfs.c
index b8fa4ecfc961..38c64b5fb23a 100644
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
 
@@ -640,7 +645,7 @@ static int add_port(struct mlx4_ib_dev *dev, int port_num, int slave)
 				   kobject_get(dev->dev_ports_parent[slave]),
 				   "%d", port_num);
 	if (ret)
-		goto err_alloc;
+		goto err_kobj;
 
 	p->pkey_group.name  = "pkey_idx";
 	p->pkey_group.attrs =
@@ -687,6 +692,12 @@ static int add_port(struct mlx4_ib_dev *dev, int port_num, int slave)
 	kobject_put(dev->dev_ports_parent[slave]);
 	kfree(p);
 	return ret;
+
+err_kobj:
+	kobject_put(dev->dev_ports_parent[slave]);
+	kobject_put(&p->kobj);
+	return ret;
+
 }
 
 static int register_one_pkey_tree(struct mlx4_ib_dev *dev, int slave)
-- 
2.43.0


