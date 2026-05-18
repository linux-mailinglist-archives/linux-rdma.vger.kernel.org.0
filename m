Return-Path: <linux-rdma+bounces-20871-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAKON0Z5Cmqm1wQAu9opvQ
	(envelope-from <linux-rdma+bounces-20871-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 04:28:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA29565134
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 04:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DCE8C30015BD
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 02:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4675D376BEA;
	Mon, 18 May 2026 02:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eM3Wf4hT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98194374E7A
	for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 02:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779071290; cv=none; b=L20t3NhhDAU8QmYv3eOZHD+JymDH1hRH0RZw+OOgBM6YUNGC++YuobAicHeR0wXU28Rt3bl04p70DUNYsDcezcIYgCzEPTAq7tU5sTG4RhhbFwmLjS834gz/Wihzcj52eZ47iri6Al5HcPqukQDRmRKB816odaNJJRvhz8yaGHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779071290; c=relaxed/simple;
	bh=M4ZD7F5P/kUsY4X7ToRKhptIAy7vGngfalRm5DpYQdk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ejzcsoe93bmb4MUQtW3DTMNKJND7bvtYvabYTfQXQNo6QfZom84aOdlCDCeeJp8iIyjklTyqqPmAOmB8RsHuYVgsqpg7MfMo+pRPosjB30m4XK9vvRW/y2PjXargU9bRY4LpqRToetQQSABOUPAty2y5b4qWokHbPKunoT8lcsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eM3Wf4hT; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-837b39eb078so1185499b3a.2
        for <linux-rdma@vger.kernel.org>; Sun, 17 May 2026 19:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779071286; x=1779676086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WtwvvlGg4mzt0KkyXLT6Zi9TNTsz3hit8A05dFJNp7I=;
        b=eM3Wf4hT8OoRsgHgeJ0iEK/4BRj3RT4jEruM71a2qojWkMGTQfgAh5JaCOqvqGYfFy
         uKC4S2t9jhxm/st+cYP21EzlJ384YkE848orgdlIzct/FN2kk+gNfLx4lbonBjNgAGo2
         gyq2wfMOMg2BWI4RYJSeAsVNGylhNkdhB+fCU0TO4U+opCKlT5a23QCLFh8hCXxqf1PA
         BNvK+8JXQy6+itDQLUs8mrnsVST65Aic5a2NQupYDkKkxPL+zZFhBEXiO7xsAdvJ1jev
         FtzhWqBYFdHfaPJb6+jndKp+n3tlXC1iI3wNNjGc78w5AHrzqBf1/77oOZsjRmUU+1IZ
         dUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779071286; x=1779676086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtwvvlGg4mzt0KkyXLT6Zi9TNTsz3hit8A05dFJNp7I=;
        b=FqqlKAT42qW8ibSdjZ02+r4oVZ+d6sIg801b1Uh4Ynf1WMW6Ho2llgM6YS3j/48fxO
         DPNHThovonJgc5/Ug/Sgjiw+q1u17SrszODxoAB1yQIzZ+TadUhKh0cQNS1PqSZqPKH9
         /dhwgn4QraLYoCxScTTP0DqMEGbimUdYF2xjHRez3zpQaaDufkSCyK/wylvMJTVuujMl
         QD7o+ntQaOhpE7dTRt96IZRy101FVCCEcsZMPob3jJBWF5UCu5cLGVcg/AGglBx6dE6A
         KJ6WaJkYvW2tzpear/I9M5GS9aFuLtLVdXnhS6r35edagQ+dWxwnwuLFNFnPyREY4v/l
         XwzA==
X-Forwarded-Encrypted: i=1; AFNElJ+peQfvF4LsOiPx+XYVf4IL1gCoKvfp3lWc6m1USrqCLy/h9/dff0IaaS77jf+LVYPN8Pz5beZYgHRb@vger.kernel.org
X-Gm-Message-State: AOJu0YyRgRRVVvSIThmbPYfZF62nAFKndTyuTI6kKpp/Tce/IQTlMkap
	/JbN8AnIGD+F6Y3kjACKvgb/haUb5513VPLN5YGJcEvu+F5bra1xdwtN
X-Gm-Gg: Acq92OEynaxuJyxGMREVjpKXwd65T/znrK6iKtVdW1eejsPWGX8sVhEnOrwVNCSuyNk
	CVV8ytHoc4kjTNHDJWUvkUj1Kr8YPxIIF9Tj0cfNW8MSqtlmAkeV4QD7qW9Nbz7gpboEPiqj+mW
	j4jyTcLIN4wjMAW5J817Yd9jNu+0Hd+Q+jza3P4VPlhyw/PufWBz8K/liWP14jeF270ziQikQUP
	+qam94Xq7a4z0gJVmI1IT4eJ0IcM85BqBYzetpVHZppZSKAodperhjgXLhRMrXdcVG3zodhkQi9
	qtoDjQUUOxvBlLv+DsIKuvZSlsS38qY/v0Sb1cnl7mB/okF5njY5LeLocUn631feqvCyVjovA7k
	/GH9BaPHZdT1oFYCoFOxo0tXEMBFu5n5/KrBfdTkKsta4U4DQiY5YrhUsi45YuAHVOm4QC9mAgb
	0KHN/ouA==
X-Received: by 2002:a05:6a00:bd8c:b0:82f:4f63:31e1 with SMTP id d2e1a72fcca58-83f33aebdb9mr13742406b3a.8.1779071285742;
        Sun, 17 May 2026 19:28:05 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f196660easm12434842b3a.11.2026.05.17.19.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 19:28:05 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Yishai Hadas <yishaih@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Jack Morgenstein <jackm@dev.mellanox.co.il>,
	Roland Dreier <roland@purestorage.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH v7] IB/mlx4: Fix refcount leak in add_port() error path
Date: Mon, 18 May 2026 10:19:10 +0800
Message-ID: <20260518021910.972900-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CCA29565134
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-20871-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

After kobject_init_and_add(), the lifetime of the embedded struct
kobject is expected to be managed through the kobject core reference
counting.

In add_port(), failure paths after kobject_init_and_add() must not free
struct mlx4_port directly, because the embedded kobject is then managed
by the kobject core. Freeing it directly leaves the kobject reference
counting unbalanced and can lead to incorrect lifetime handling.

Allocate the pkey and gid attribute arrays before kobject_init_and_add(),
so failures before kobject initialization can be handled by directly
freeing the allocated memory. Once kobject_init_and_add() has been
called, unwind later failures by removing any successfully created sysfs
groups, calling kobject_del(), and then releasing the embedded kobject
with kobject_put().

Fixes: c1e7e466120b ("IB/mlx4: Add iov directory in sysfs under the ib device")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v7:
  - remove already created sysfs groups on add_port() error paths before
    deleting and putting the kobject

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

 drivers/infiniband/hw/mlx4/sysfs.c | 45 ++++++++++++++++++------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/sysfs.c b/drivers/infiniband/hw/mlx4/sysfs.c
index b8fa4ecfc961..e688ad66a895 100644
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
@@ -663,28 +653,47 @@ static int add_port(struct mlx4_ib_dev *dev, int port_num, int slave)
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
+		goto err_remove_pkey;
 
 	ret = add_vf_smi_entries(p);
 	if (ret)
-		goto err_free_gid;
+		goto err_remove_gid;
 
 	list_add_tail(&p->kobj.entry, &dev->pkeys.pkey_port_list[slave]);
 	return 0;
 
-err_free_gid:
-	kfree(p->gid_group.attrs[0]);
-	kfree(p->gid_group.attrs);
+err_remove_gid:
+	sysfs_remove_group(&p->kobj, &p->gid_group);
+
+err_remove_pkey:
+	sysfs_remove_group(&p->kobj, &p->pkey_group);
+
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


