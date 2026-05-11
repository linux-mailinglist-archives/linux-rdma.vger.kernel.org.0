Return-Path: <linux-rdma+bounces-20388-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAjwLxTLAWqgjwEAu9opvQ
	(envelope-from <linux-rdma+bounces-20388-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 14:27:00 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8314750DADB
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 14:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E820D307187D
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 12:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F7137B018;
	Mon, 11 May 2026 12:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPIKejtE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C7337B027
	for <linux-rdma@vger.kernel.org>; Mon, 11 May 2026 12:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778501978; cv=none; b=BawQf8Ni7P+Yly2XK/2KwmO4eFg2/g+4wev4olP63uIRsreJrD3PYexAJ8m19J7zQrmoBT2sYz68uI+5hJWuNKmx/w+kaCh1Eqq3JGCCEuofe6tTxDjtZnFHgy3Qa446C5bJ204O90iGlZfAEBBjLD8njn4j+cimFyyaYP+v4pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778501978; c=relaxed/simple;
	bh=aAyYYc/BZZOKFAby+9yyYHzLhG5Qm+vDqOti661O9Uo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C7Cni9D6KI1HMse8LK6UjhiOWdWS2LBuK+cFllCmAxnNTERlHXT/dN29r5+vaFJf+vLxZrSTG+vs86m0v8FbgxMdrWIGVE/uPICHUP12MewUnC1cN51/tQ+PkBqR5o84RwwXWcBTvMMkK0eDFQcPQcGphgUk/I6PcaXtaV1oyyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPIKejtE; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7dcdaf06498so2962611a34.2
        for <linux-rdma@vger.kernel.org>; Mon, 11 May 2026 05:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778501976; x=1779106776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yWk99ifVcDrs+eCK2r1At1mRDzEM1XrdyRPQ+rc1Meo=;
        b=QPIKejtE6T/Wny2Z78B4H3X496eF4L3nwmywnWWPjSkUspVO0R3ZjRGIA+eAO48LfK
         Jzk3d5PKZ/akuDeozEyb+6zO9Sobep9RZMho8izwtVlZVP8cMjYrTGjsiIcNKnTnBxEL
         NseNWK3rlugUQVal8RYI5ys71xl+h0bTL0LsRZ69eGT8d54/D+vwoABEvFuRLU5ZClmL
         jBJsuKGDr1ptf4oA6f+vzFbKt7gHHWBG5LQSet9/bax7LD9na4CBo9D+mv8YHknidrj5
         Jk6OvCVJ4oHhqb5kdaJyMWEOltFDJS0Ab1zAqXkj3ooSauBM2LviHGLHEeDz8U6cNg7f
         VYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778501976; x=1779106776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWk99ifVcDrs+eCK2r1At1mRDzEM1XrdyRPQ+rc1Meo=;
        b=ejq13oAQn59eSTYqs2sZgs90jHB8ZY342r+u+akYjaqxf9cliuzUvxvYi53a57TKly
         5Ok1mr7TEc/xIyr+iWE6fvz9Rwc7TPrzML8HxRmElkDHL+1kezg2tLtEP71DaVyDTj7w
         /nOvlqHWyNZgShUwwECjVplHy7+O01Jwyry5PBGyiEdd1hbklCzqapWxjnJByhHDTbuY
         zank84GCyX+rjqmTEEZM0wR34C3VBZ9XgAgEUBtz/Yj8/oYeJq/aOOJZz41i5K3UiTuu
         k5GxfGcQTeLz2lQudQFdCbNnud1ImOTpKx8ahINoU8HRuWfqljmDJL1Vb7VbUKLV0Ax2
         CAjg==
X-Forwarded-Encrypted: i=1; AFNElJ9kN3dYRPT7nJJ3pyfgkPl47Qnx2XfefIGzYYdnVfSL+MAOdWJ1Q4oWRYR6fQWDMJ701h9A6qsFYinj@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj+S7PQKPGa2jelQ/rfXU0x0bLD5lSou3Cvfl3FG8eBfxBMy9y
	PghENdvnmjFh1QUpTBafAXyope/rdGiEloGe60y2Z2ydvDiSOHZ37SUn
X-Gm-Gg: Acq92OHXnvnyOiz8H7erT4DMnhyq9RcHQSMPiXC2JYG1efUSYnvqK8dCt+LRYLelPwK
	Wox3hSayKdxXLVOV2RmcMghnfZoLBUg5lDlsoIlYwm2X5qGrS/VxA71DcDpU1Vc1of+zMc7eZWG
	elDD8ciKKYpEHPPr7j2RHnZdpi2mxdBoo8uh4b1uFL+DsAXiNDpIiVg52hxIkSGFZk4m0ZRQ3I4
	RxH5ahnc5cc7ePYDNBA2ih9WIernew34dfyeNF2ynuLvZfNqSbD6cBcT8tjr8pcsk9dKFo/WUPS
	6jdYdImR293Sw0PBXzmALegvEOLE0pi9HjSW/Oxs75R9vag4jD2W2XtlFnJHDVkVEWiAfDJn1JL
	dg8E/g9DvNFVFlmXvOaQYif1YHuqHia24al5vQzplau9rQGO8DvWvZi1/MFZngFukvv9u8mjLY5
	19s3QcYg==
X-Received: by 2002:a05:6830:921:b0:7d7:d615:3040 with SMTP id 46e09a7af769-7e1defe8469mr14049107a34.17.1778501975783;
        Mon, 11 May 2026 05:19:35 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e367c0bc16sm6775684a34.12.2026.05.11.05.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 05:19:35 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Yishai Hadas <yishaih@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Roland Dreier <roland@purestorage.com>,
	Jack Morgenstein <jackm@dev.mellanox.co.il>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v5] IB/mlx4: Fix refcount leak in add_port() error path
Date: Mon, 11 May 2026 20:16:49 +0800
Message-ID: <20260511121649.770529-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8314750DADB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-20388-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

After kobject_init_and_add(), the lifetime of the embedded struct
kobject is expected to be managed through the kobject core reference
counting.

In add_port(), several failure paths after kobject_init_and_add() free
struct mlx4_port directly instead of releasing the embedded kobject with
kobject_put(). This leaves the kobject reference count unbalanced and can
lead to incorrect lifetime handling.

Fix this by routing the kobject_init_and_add() failure path through
kobject_put(), and by calling kobject_del() before kobject_put() on
later failure paths after the kobject has been successfully added. Since
the release callback may now be called for partially initialized
mlx4_port objects, make mlx4_port_release() tolerate NULL attribute
arrays.

The duplicated attribute array frees in add_port() are removed, as the
release callback now handles them.

Fixes: c1e7e466120b ("IB/mlx4: Add iov directory in sysfs under the ib device")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
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

 drivers/infiniband/hw/mlx4/sysfs.c | 44 ++++++++++++++----------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/sysfs.c b/drivers/infiniband/hw/mlx4/sysfs.c
index b8fa4ecfc961..224a6a1c289d 100644
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
@@ -649,43 +653,37 @@ static int add_port(struct mlx4_ib_dev *dev, int port_num, int slave)
 				  dev->dev->caps.pkey_table_len[port_num]);
 	if (!p->pkey_group.attrs) {
 		ret = -ENOMEM;
-		goto err_alloc;
+		goto err_del;
 	}
 
 	ret = sysfs_create_group(&p->kobj, &p->pkey_group);
 	if (ret)
-		goto err_free_pkey;
+		goto err_del;
 
 	p->gid_group.name  = "gid_idx";
 	p->gid_group.attrs = alloc_group_attrs(show_port_gid_idx, NULL, 1);
 	if (!p->gid_group.attrs) {
 		ret = -ENOMEM;
-		goto err_free_pkey;
+		goto err_del;
 	}
 
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
-
-err_free_pkey:
-	for (i = 0; i < dev->dev->caps.pkey_table_len[port_num]; ++i)
-		kfree(p->pkey_group.attrs[i]);
-	kfree(p->pkey_group.attrs);
+err_del:
+	kobject_del(&p->kobj);
 
-err_alloc:
+err_put:
 	kobject_put(dev->dev_ports_parent[slave]);
-	kfree(p);
+	kobject_put(&p->kobj);
 	return ret;
 }
 
-- 
2.43.0


