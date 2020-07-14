Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E86AD21EB0A
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2020 10:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgGNIKx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jul 2020 04:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgGNIKw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Jul 2020 04:10:52 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D552C061755
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2020 01:10:52 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id q5so20215572wru.6
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2020 01:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P3FeplwX7HmH0XJSqMZAz23/5QljzWQMWm3qFcvrstI=;
        b=uDDXMVLDNK1uB9y9f8/AC5+PHDgAyKfmge1uUxueceMf/zF+HZ+CHAcmSxlL5T2ghu
         NLkbHKqFvKqB1ui4nUtTOQ9KSen201g0IIEh7VRfKd6bF/fWIDuqcrQ8Jjf8pY7I3zqc
         rONZdDsYh6yYOJySMfgdVnyH0BsDM2a/7dsKQu4+zKqd7aSyFogiTROdrbNgDdZD6q5U
         PIfUH8Fsw/dStM+cc5XGrqsJTculN7IYi8izjzBBiagCPn7VHkwnNNo78gQeyMMaYIIa
         uQ/xYHlExL2y/9jrEbLXjpmIWN5SaGDZcYLNDJEXkOQCLKbUqIrDhlHfDG89TGAgQRHz
         s6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P3FeplwX7HmH0XJSqMZAz23/5QljzWQMWm3qFcvrstI=;
        b=EHfyIxXlFvCdrOvY32y8UNdd1PMQ4y7d5qe3GPK2pyNGQLamW978zESl6pXbfYxZIU
         K7RKKXCxnZ1TDUkmvzoMCevUAE4p2nY/C/NNMEH35FQSiut/QJDDuHD+7BQF7ntrUuOi
         PJxQAoKftGexNPMd+ZPYgk7dvMYozt9MB9SeEGc0P0VAwPUPyvImva/edur/Jp9HpXaX
         m2elc8GK6qsoXMqn4XyuoZztrs8hkq48sSptwrYl/cRN7TogIal/WWHazUopPkq1Aa4g
         wo9EhR/dDxW43m9t8cGCp7T1jd4kD5sqVIuPYZZAhkAf2i5tT2fnAhOxzM6buzq3Q5H0
         nb9g==
X-Gm-Message-State: AOAM530dhAVQRST7jWbgP4fDpTbIs/HwkSEtqqOA2aMlAX+i7OMPY6gl
        PWG72IT3E7kXLqhQ5vQ1QtpGByRa6lg=
X-Google-Smtp-Source: ABdhPJzz6zJcAtY7e3XlJn/GjtXVJ3nEgovEJN8tUqeWrL/tPpaQG7eLzNSj1PdhU+gXKwzzbKMcRA==
X-Received: by 2002:adf:97d6:: with SMTP id t22mr3597069wrb.385.1594714250727;
        Tue, 14 Jul 2020 01:10:50 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-79-176-63-152.red.bezeqint.net. [79.176.63.152])
        by smtp.gmail.com with ESMTPSA id f197sm3403891wme.33.2020.07.14.01.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 01:10:50 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Kalderon <mkalderon@marvell.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next 1/7] RDMA/core: Expose pkeys sysfs files only if pkey_tbl_len is set
Date:   Tue, 14 Jul 2020 11:10:32 +0300
Message-Id: <20200714081038.13131-2-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200714081038.13131-1-kamalheib1@gmail.com>
References: <20200714081038.13131-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Expose the pkeys sysfs files only if the pkey_tbl_len is set by the
providers.

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/core/sysfs.c | 64 ++++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index defe9cd4c5ee..a7bca62a622e 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -58,7 +58,7 @@ struct ib_port {
 	struct ib_device      *ibdev;
 	struct gid_attr_group *gid_attr_group;
 	struct attribute_group gid_group;
-	struct attribute_group pkey_group;
+	struct attribute_group *pkey_group;
 	struct attribute_group *pma_table;
 	struct attribute_group *hw_stats_ag;
 	struct rdma_hw_stats   *hw_stats;
@@ -681,11 +681,13 @@ static void ib_port_release(struct kobject *kobj)
 		kfree(p->gid_group.attrs);
 	}
 
-	if (p->pkey_group.attrs) {
-		for (i = 0; (a = p->pkey_group.attrs[i]); ++i)
-			kfree(a);
+	if (p->pkey_group) {
+		if (p->pkey_group->attrs) {
+			for (i = 0; (a = p->pkey_group->attrs[i]); ++i)
+				kfree(a);
 
-		kfree(p->pkey_group.attrs);
+			kfree(p->pkey_group->attrs);
+		}
 	}
 
 	kfree(p);
@@ -1118,17 +1120,26 @@ static int add_port(struct ib_core_device *coredev, int port_num)
 	if (ret)
 		goto err_free_gid_type;
 
-	p->pkey_group.name  = "pkeys";
-	p->pkey_group.attrs = alloc_group_attrs(show_port_pkey,
-						attr.pkey_tbl_len);
-	if (!p->pkey_group.attrs) {
-		ret = -ENOMEM;
-		goto err_remove_gid_type;
+	if (attr.pkey_tbl_len) {
+		p->pkey_group = kzalloc(sizeof(*p->pkey_group), GFP_KERNEL);
+		if (!p->pkey_group) {
+			ret = -ENOMEM;
+			goto err_remove_gid_type;
+		}
+
+		p->pkey_group->name  = "pkeys";
+		p->pkey_group->attrs = alloc_group_attrs(show_port_pkey,
+							 attr.pkey_tbl_len);
+		if (!p->pkey_group->attrs) {
+			ret = -ENOMEM;
+			goto err_free_pkey_group;
+		}
+
+		ret = sysfs_create_group(&p->kobj, p->pkey_group);
+		if (ret)
+			goto err_free_pkey;
 	}
 
-	ret = sysfs_create_group(&p->kobj, &p->pkey_group);
-	if (ret)
-		goto err_free_pkey;
 
 	if (device->ops.init_port && is_full_dev) {
 		ret = device->ops.init_port(device, port_num, &p->kobj);
@@ -1150,14 +1161,23 @@ static int add_port(struct ib_core_device *coredev, int port_num)
 	return 0;
 
 err_remove_pkey:
-	sysfs_remove_group(&p->kobj, &p->pkey_group);
+	if (p->pkey_group)
+		sysfs_remove_group(&p->kobj, p->pkey_group);
 
 err_free_pkey:
-	for (i = 0; i < attr.pkey_tbl_len; ++i)
-		kfree(p->pkey_group.attrs[i]);
+	if (p->pkey_group) {
+		for (i = 0; i < attr.pkey_tbl_len; ++i)
+			kfree(p->pkey_group->attrs[i]);
+
+		kfree(p->pkey_group->attrs);
+		p->pkey_group->attrs = NULL;
+	}
 
-	kfree(p->pkey_group.attrs);
-	p->pkey_group.attrs = NULL;
+err_free_pkey_group:
+	if (p->pkey_group) {
+		kfree(p->pkey_group);
+		p->pkey_group = NULL;
+	}
 
 err_remove_gid_type:
 	sysfs_remove_group(&p->gid_attr_group->kobj,
@@ -1317,7 +1337,11 @@ void ib_free_port_attrs(struct ib_core_device *coredev)
 
 		if (port->pma_table)
 			sysfs_remove_group(p, port->pma_table);
-		sysfs_remove_group(p, &port->pkey_group);
+		if (port->pkey_group) {
+			sysfs_remove_group(p, port->pkey_group);
+			kfree(port->pkey_group);
+			port->pkey_group = NULL;
+		}
 		sysfs_remove_group(p, &port->gid_group);
 		sysfs_remove_group(&port->gid_attr_group->kobj,
 				   &port->gid_attr_group->ndev);
-- 
2.25.4

