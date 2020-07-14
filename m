Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C36721EB0B
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2020 10:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgGNIKy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jul 2020 04:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgGNIKy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Jul 2020 04:10:54 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7516C061755
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2020 01:10:53 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z13so20202427wrw.5
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2020 01:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+xwtCoElLLo1FXG9Vaq9b+0G1RX76SWaOSLyZ61U0N8=;
        b=Sd/rCvNL6pVFWm8IQ3x0vQdaH1mC26BdrhTOddvPsl9mbokGp937/vFqzcqwU/HFUW
         7vyG0QxtcKU4Xie62Xu9wsf3OEZm8Ah1f28RiMu60KPX5+4GtD9kynqYPeTGSrk8MzzQ
         QpEyK6YegghCyJyYhnfHzTsisECgtwCzZ++RfCSOi+smg12GClnBpHDRoavrQbbP3DFf
         PAdiAM/4vhW3Y0iwBg/9mTAfJ6x1AT80w1W42NHSy2qjxcwGzojGB57eE8mDWVo7GCO4
         CVhzNMSp9vPTTR4ro/dWtws4IerSOZB80iY/p9dAx4kUMq7YoAH10Cfw+d9RGi4YT1jL
         OAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+xwtCoElLLo1FXG9Vaq9b+0G1RX76SWaOSLyZ61U0N8=;
        b=PT5TgueArS4LWoi5t0t6VmCfR9m5GnrQtbW4s9ltWHHjZkgIPdUNo5C0KHAahiMhKJ
         f2hDUIdaGyUgyySTRUlGfVOV3kyhKGh+dk6P8tt0rcHVNoFc2GCtwK5YCIRBnZZi8ZvX
         N3q/vZijsFbN+o5RrLWCCy5iTZDcdH35C0sRu4Nbkf04nZHkoEUQ7mjqrYtGjVpeuN02
         27/uOKJl/yu+WsXF9YsFQ7+7Fd0VoKRbzFcuzczYUcOiUxaX7AoPr0K8TtNqCZ1+a1M4
         S4Z9jbjfacWdW7quQ3neeMq0LWYNKSqh5fu9ibdk0CmtuaIUN5OQnNeCejtCqWmEG0Ow
         H/Ow==
X-Gm-Message-State: AOAM530IlcAfdG9NtMomCqw39GXArIXgK1V2wFKO9bJ6yDJWe5Hngcco
        JN8yraAqUr/uAjsW7DQTMOecSjtAtiU=
X-Google-Smtp-Source: ABdhPJxbHzE1tCeKFEpxBNHGRExVr8MMDX2BxfZLhVbU1jh7i6iCFDM+8ldaNmrDKKgW8DzteBqClg==
X-Received: by 2002:a05:6000:12c5:: with SMTP id l5mr4050340wrx.219.1594714252355;
        Tue, 14 Jul 2020 01:10:52 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-79-176-63-152.red.bezeqint.net. [79.176.63.152])
        by smtp.gmail.com with ESMTPSA id f197sm3403891wme.33.2020.07.14.01.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 01:10:51 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Kalderon <mkalderon@marvell.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next 2/7] RDMA/core: Allocate the pkey cache only if the pkey_tbl_len is set
Date:   Tue, 14 Jul 2020 11:10:33 +0300
Message-Id: <20200714081038.13131-3-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200714081038.13131-1-kamalheib1@gmail.com>
References: <20200714081038.13131-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Allocate the pkey cache only if the pkey_tbl_len is set by the provider,
also add checks to avoid accessing the pkey cache when it not
initialized.

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/core/cache.c | 45 +++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index a670209bbce6..ffad73bb40ff 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -1054,7 +1054,7 @@ int ib_get_cached_pkey(struct ib_device *device,
 
 	cache = device->port_data[port_num].cache.pkey;
 
-	if (index < 0 || index >= cache->table_len)
+	if (!cache || index < 0 || index >= cache->table_len)
 		ret = -EINVAL;
 	else
 		*pkey = cache->table[index];
@@ -1099,6 +1099,10 @@ int ib_find_cached_pkey(struct ib_device *device,
 	read_lock_irqsave(&device->cache_lock, flags);
 
 	cache = device->port_data[port_num].cache.pkey;
+	if (!cache) {
+		ret = -EINVAL;
+		goto err;
+	}
 
 	*index = -1;
 
@@ -1117,6 +1121,7 @@ int ib_find_cached_pkey(struct ib_device *device,
 		ret = 0;
 	}
 
+err:
 	read_unlock_irqrestore(&device->cache_lock, flags);
 
 	return ret;
@@ -1139,6 +1144,10 @@ int ib_find_exact_cached_pkey(struct ib_device *device,
 	read_lock_irqsave(&device->cache_lock, flags);
 
 	cache = device->port_data[port_num].cache.pkey;
+	if (!cache) {
+		ret = -EINVAL;
+		goto err;
+	}
 
 	*index = -1;
 
@@ -1149,6 +1158,7 @@ int ib_find_exact_cached_pkey(struct ib_device *device,
 			break;
 		}
 
+err:
 	read_unlock_irqrestore(&device->cache_lock, flags);
 
 	return ret;
@@ -1425,23 +1435,26 @@ ib_cache_update(struct ib_device *device, u8 port, bool enforce_security)
 			goto err;
 	}
 
-	pkey_cache = kmalloc(struct_size(pkey_cache, table,
-					 tprops->pkey_tbl_len),
-			     GFP_KERNEL);
-	if (!pkey_cache) {
-		ret = -ENOMEM;
-		goto err;
-	}
+	if (tprops->pkey_tbl_len) {
+		pkey_cache = kmalloc(struct_size(pkey_cache, table,
+						 tprops->pkey_tbl_len),
+				     GFP_KERNEL);
+		if (!pkey_cache) {
+			ret = -ENOMEM;
+			goto err;
+		}
 
-	pkey_cache->table_len = tprops->pkey_tbl_len;
+		pkey_cache->table_len = tprops->pkey_tbl_len;
 
-	for (i = 0; i < pkey_cache->table_len; ++i) {
-		ret = ib_query_pkey(device, port, i, pkey_cache->table + i);
-		if (ret) {
-			dev_warn(&device->dev,
-				 "ib_query_pkey failed (%d) for index %d\n",
-				 ret, i);
-			goto err;
+		for (i = 0; i < pkey_cache->table_len; ++i) {
+			ret = ib_query_pkey(device, port, i,
+					    pkey_cache->table + i);
+			if (ret) {
+				dev_warn(&device->dev,
+					 "ib_query_pkey failed (%d) for index %d\n",
+					 ret, i);
+				goto err;
+			}
 		}
 	}
 
-- 
2.25.4

