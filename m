Return-Path: <linux-rdma+bounces-20683-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEh3A2msBWrHZgIAu9opvQ
	(envelope-from <linux-rdma+bounces-20683-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 13:05:13 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECE9540C12
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 13:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CF84300DF4F
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 11:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178503A9DA4;
	Thu, 14 May 2026 11:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5ATa12B"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9158F37648D
	for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 11:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778756708; cv=none; b=fRTjnfNzGtaci1a3O+l7moolO4vLpMDG52HrlyXDBALXcPSyZgsKGNnAotxa+SEWZRFX0h5d1kwbqb2RhYv44zlQO9P7tkMV+F6YMkUhG63ddUfmARp454oO+Oe9ywu34mz1toyHYppgiQBP6fkDrJQ7BsNGVrObEAtmqeV4mq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778756708; c=relaxed/simple;
	bh=2IJhF+iwhH0daRljtdGQOGv59DLUiPhUZ8llNuzuSB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r6IYFM05fHTyLGCS9HeASszJqVwrTFdg05+hAm9GBk6txrcN9P3z2aDcnWXYzXzoWdvfZrCNJcaevoMRQ6Jn1HrLr4hYvim00h8p3hEZCvM6TB/6VjLuLXa1GrLy6P1VaPW1UA9WmghuVUSRZgezzuVOyk1lhJISZkPnTywTW88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5ATa12B; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3664df30f53so4074101a91.1
        for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 04:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778756707; x=1779361507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VdojlyrzhDEJxjpjW25tCjgmnw9si3YuJBr21UjVzKI=;
        b=Q5ATa12BTvjjaJWCKNAHsP18b2kcS+fKC6JM+1IoEaiRP6sRRrlpqK4hEp6B6z1hSv
         f6KbFQMMxp6KcAU/iJK992p0oMhfmKhdNoKT+rlvXtxUM8la7SGyi86F5F0O1C1k4gZo
         yRCXEEpopn/ryUngDhuKA467Ln7I9k/EPFCdy/VSbaz+OJu4JjHdidMp1QsA7+wwG54e
         yZYNpbpOABqFffBtjAd7XkJOFXlJlSVcjiDUllJyk+tU7593Ml8UCkbIpi2GZBIuEpWj
         oa2/dUIaCegSO+ui9lrumujmmLRQ2zy3AcbW7AmOQ0bPlg35WgF7GMid8qbRlpovrI01
         nAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778756707; x=1779361507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VdojlyrzhDEJxjpjW25tCjgmnw9si3YuJBr21UjVzKI=;
        b=G+P0YrxdeSuxj+MxR9+FxMTENjuzQdaSrXVxDO6urT2zmi4rkNVScdYhF0fP0NJCG3
         Q2aB2O/36eNDkTltIr2Ih5r8oDlzJBnoHE5l3/1wV2oOhLAWnPBomxn1bxu2D0gkX9o0
         MPhm49rG/V/U/YofbtbBR4jLo/R3ytMUqBH+8aACYpunwSyAszsnBXWw+e7GXBTJqstC
         2L3b8jdP1qgYw75QuqtGLuKqbGNHCT/HMaUMSkhs22P94Pt44wf8S2Qx0Wa1ydexRm5N
         pHN3DLolo5F5aY/D2CY03bSSNaF0pMq4jv5Jbl/HmiqLlChJeShNph01GHhlZd0lakXQ
         /9qg==
X-Forwarded-Encrypted: i=1; AFNElJ9JxfLklgCXOTVxQgZG86rm5svd4nCY5ZthuXm5LooV8JWEfsFQaILe41rAN+TjTcaFefaUH9n2QT7y@vger.kernel.org
X-Gm-Message-State: AOJu0YxUc/55Fc30wjI6Dai+OVZ+4s/c2Q/whp5MgUZ5ivsvBDHAjxRz
	TnRn9RZ1pU2r3cZhsDx/Md7KSOq0MhrQLPFmJWVvLC9H4cmnr5fPp4Q8
X-Gm-Gg: Acq92OGaiYYH93zpvR8Cz4mVmkDy5HPfHSG4OOG1b1TShP7jZslCH8xbP2jCMOcprfU
	ZG4dNkx4krRRfDmBYtEw+b1RtzAXSwXGuYm8gSg9ZCVf3MmI6jF7vMZnEjC7BsHm9oeiJG6zFIp
	UrOocfJ5uVKm5e+OsDMmeSOaYWas0zedrVk8SFX1dnW34q9BZ38rheEuOVNQq73bVihArQJUFje
	EDxPu7+LMlv9G7B5D/yHS7oJufFk76gf1JDNCZJqcglCUt7HxPcq9lqD3NPKJYZTdVppf5SgVeZ
	4kW1YmRM3x15rJaVAv83Geoqib9ZfDhOLRZRRPq1EMi9tCodGmpRX1whVH5zOGt3TrBUcjK3Lez
	TFLhsK3G3NTu89457WBBqysaj7bB31D9aI4B9kZzxvQ6f9i7dovv2suzsZUqRjfUDLKOzszZpcb
	uBWZESYzZt2RBmwavw9FStpeIjWkw=
X-Received: by 2002:a17:90a:d00e:b0:368:b724:6d53 with SMTP id 98e67ed59e1d1-368f398cc9dmr7642042a91.4.1778756706624;
        Thu, 14 May 2026 04:05:06 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368edf4d935sm6016880a91.5.2026.05.14.04.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 04:05:06 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Yishai Hadas <yishaih@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Jack Morgenstein <jackm@dev.mellanox.co.il>,
	Roland Dreier <roland@purestorage.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH v6] IB/mlx4: Fix refcount leak in add_port() error path
Date: Thu, 14 May 2026 19:01:39 +0800
Message-ID: <20260514110139.864340-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4ECE9540C12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-20683-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

After kobject_init_and_add(), the lifetime of the embedded struct
kobject is expected to be managed through the kobject core reference
counting.

In add_port(), several failure paths after kobject_init_and_add() free
struct mlx4_port directly instead of releasing the embedded kobject with
kobject_put(). This leaves the kobject reference count unbalanced and can
lead to incorrect lifetime handling.

Allocate the pkey and gid attribute arrays before kobject_init_and_add(),
so failures before kobject initialization can be handled by directly
freeing the allocated memory. Once kobject_init_and_add() has been
called, route failures through kobject_put(), and call kobject_del()
before kobject_put() on later failure paths after the kobject has been
successfully added.

Fixes: c1e7e466120b ("IB/mlx4: Add iov directory in sysfs under the ib device")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v6:
  - drop the Cc stable tag
  - allocate pkey and gid attribute arrays before kobject_init_and_add()
  - keep the release callback unchanged by ensuring the attribute arrays
    are initialized before kobject_init_and_add()

v5:
  - split the add_port() error paths after kobject_init_and_add()
  - call kobject_del() before kobject_put() for failures after
    kobject_init_and_add() succeeds

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

 drivers/infiniband/hw/mlx4/sysfs.c | 39 ++++++++++++++++--------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/sysfs.c b/drivers/infiniband/hw/mlx4/sysfs.c
index b8fa4ecfc961..e4c822c96ee6 100644
--- a/drivers/infiniband/hw/mlx4/sysfs.c
+++ b/drivers/infiniband/hw/mlx4/sysfs.c
@@ -636,12 +636,6 @@ static int add_port(struct mlx4_ib_dev *dev, int port_num, int slave)
 	p->port_num = port_num;
 	p->slave = slave;
 
-	ret = kobject_init_and_add(&p->kobj, &port_type,
-				   kobject_get(dev->dev_ports_parent[slave]),
-				   "%d", port_num);
-	if (ret)
-		goto err_alloc;
-
 	p->pkey_group.name  = "pkey_idx";
 	p->pkey_group.attrs =
 		alloc_group_attrs(show_port_pkey,
@@ -649,13 +643,9 @@ static int add_port(struct mlx4_ib_dev *dev, int port_num, int slave)
 				  dev->dev->caps.pkey_table_len[port_num]);
 	if (!p->pkey_group.attrs) {
 		ret = -ENOMEM;
-		goto err_alloc;
+		goto err_free_port;
 	}
 
-	ret = sysfs_create_group(&p->kobj, &p->pkey_group);
-	if (ret)
-		goto err_free_pkey;
-
 	p->gid_group.name  = "gid_idx";
 	p->gid_group.attrs = alloc_group_attrs(show_port_gid_idx, NULL, 1);
 	if (!p->gid_group.attrs) {
@@ -663,28 +653,41 @@ static int add_port(struct mlx4_ib_dev *dev, int port_num, int slave)
 		goto err_free_pkey;
 	}
 
+	ret = kobject_init_and_add(&p->kobj, &port_type,
+				   kobject_get(dev->dev_ports_parent[slave]),
+				   "%d", port_num);
+	if (ret)
+		goto err_put;
+
+	ret = sysfs_create_group(&p->kobj, &p->pkey_group);
+	if (ret)
+		goto err_del;
+
 	ret = sysfs_create_group(&p->kobj, &p->gid_group);
 	if (ret)
-		goto err_free_gid;
+		goto err_del;
 
 	ret = add_vf_smi_entries(p);
 	if (ret)
-		goto err_free_gid;
+		goto err_del;
 
 	list_add_tail(&p->kobj.entry, &dev->pkeys.pkey_port_list[slave]);
 	return 0;
 
-err_free_gid:
-	kfree(p->gid_group.attrs[0]);
-	kfree(p->gid_group.attrs);
+err_del:
+	kobject_del(&p->kobj);
+
+err_put:
+	kobject_put(dev->dev_ports_parent[slave]);
+	kobject_put(&p->kobj);
+	return ret;
 
 err_free_pkey:
 	for (i = 0; i < dev->dev->caps.pkey_table_len[port_num]; ++i)
 		kfree(p->pkey_group.attrs[i]);
 	kfree(p->pkey_group.attrs);
 
-err_alloc:
-	kobject_put(dev->dev_ports_parent[slave]);
+err_free_port:
 	kfree(p);
 	return ret;
 }
-- 
2.43.0


