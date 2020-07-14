Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35F221F987
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2020 20:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbgGNSek (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jul 2020 14:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgGNSej (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Jul 2020 14:34:39 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F2EC061755
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2020 11:34:39 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id b6so23987394wrs.11
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2020 11:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+xwtCoElLLo1FXG9Vaq9b+0G1RX76SWaOSLyZ61U0N8=;
        b=q5SYHakPgoW937h4DMo9t7FSkZMAg4Xy5/v6GK3/EUIHvzlHYuviDLL4hOG/JE2/Qb
         +UsYn/npY8QjzeKXovcjJYkPHHiiyQN+YXPuabeXgU4Un67mk/G9KgqD9s7mpbaqhk78
         /h6AFG1ooy7LkJILtanQCVIUtyNld0kKT4lJ9xwB+KNxex8yGNIlB8lEeOFf9pv8GOXF
         5zoZv1wE4lUfsfv6CPOeDUaGGzpCYhrxgf3aJG+z/ElIhVAy0ksJuyupjtE3WTv127MA
         6tx8bRgqNdKEKCUwhjXcRw76DIv/DBSdAC/XGlRiIiepl2azpkWX1Rkg5GkYIoaL+F5E
         juqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+xwtCoElLLo1FXG9Vaq9b+0G1RX76SWaOSLyZ61U0N8=;
        b=UEcqsb6bW2oduFkseNRAuZBv2LLSGM4hUL5dPQQ2ZCboJHWuZXsFNvEoh71FYQ3l28
         g8QLQI47/jSBUrzC5AZ+XSv5fTkn902R4q+B3gAPoViz7olVbGW0vIB73s3UbOBc9RuO
         RAJuqOVRKpjB3D09X71fgNsI1nqcTgZW6YV2GMxbmuDlmmPzEa+Z58W9sRVo8BupAPO5
         12UFwoxJRLjnC1YtoGGQjLP6q3sbg6uB9DLKeLvxNrxW/6mg+bnNhoLHRjxw9oFvr+pt
         em7yTdxZgyRPFXAsOZvkK4AnU17jGB2L7hQhfToD9GMXXsWvHm3aeC8htILkLXp09ofy
         md4Q==
X-Gm-Message-State: AOAM530xJO/5cKbzacNkLMXs54S9rL5YTgZJpWueVWu+71PsOIqLRMA1
        R7DFkdKEuZLsBHDBfxa9S5JEFODi2cA=
X-Google-Smtp-Source: ABdhPJybQ4SgQu1ky7nNUYT5cq8HnPD/2a8OsyEndUXgP16bPMeZ9328tYNpzacIr5Bots7FNsHKSA==
X-Received: by 2002:a5d:40ca:: with SMTP id b10mr7969642wrq.56.1594751678040;
        Tue, 14 Jul 2020 11:34:38 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([37.142.6.100])
        by smtp.gmail.com with ESMTPSA id 190sm5728982wmb.15.2020.07.14.11.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 11:34:37 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Kalderon <mkalderon@marvell.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next v1 2/7] RDMA/core: Allocate the pkey cache only if the pkey_tbl_len is set
Date:   Tue, 14 Jul 2020 21:34:09 +0300
Message-Id: <20200714183414.61069-3-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200714183414.61069-1-kamalheib1@gmail.com>
References: <20200714183414.61069-1-kamalheib1@gmail.com>
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

