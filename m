Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B9F3BE1BE
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jul 2021 06:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbhGGEEc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Jul 2021 00:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhGGEE2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Jul 2021 00:04:28 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97264C061574
        for <linux-rdma@vger.kernel.org>; Tue,  6 Jul 2021 21:01:48 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id w15-20020a056830144fb02904af2a0d96f3so988599otp.6
        for <linux-rdma@vger.kernel.org>; Tue, 06 Jul 2021 21:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bz3V5ojuUP/A+CT8wC8BF8ApPM0Os6RmAzoPYOfuSws=;
        b=B5iDNsHPOeEuM6VrAGOcBUfEn/gQ+pITZLRWlDOsgSUpqF6/MUDXKHQJXX0nM95/6i
         LTRGZQUzrh650jxIS8rXNvIMKQfdW2Z8gF3yTZ14SRIdgq55tQK0BR3Bq8BhCJUP4ksv
         iZyMPFSsVQHncG3SgS048L1pimHA8wOPP71aVjFOPR0W2I1xkywiyBq8UZI2weCFYJ+g
         fkyEjyg9ug4O/M8cviAptiXxs8ruxjGdGoDDeXQ9cqS0l8QT9wAzlh8SIaBA9ij0yBu7
         N37PEfjVXyhBuqYbwdW6YDrnJ6dbOdn+q3MckUW6umgAPrDMJ6cM6zEz743fezTQmYZ+
         e7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bz3V5ojuUP/A+CT8wC8BF8ApPM0Os6RmAzoPYOfuSws=;
        b=W1VjERp7GJ0H3lYhzDirPr/PweEfvjLmSkD1C5xoai9zTZC0808Xj89O2mUPT55RRf
         4V+4afc5ilDHUc/tWmXP0vOAuWqPtTrlMs6cE5RyFQeNf+T0v640/8loxbO0e+45ICuj
         7//VWmUscPbdl2JjL+RTefndiKp/CLuIYArCyFZgd/eQlerTCTar3W6LiBPQ4Nr8DZoZ
         T0x3g8Volm8XXU53Cg4VCQn3bSSPd3HpBFI4YE2rn465T9R640VVZwhqSIAl2rLJQPxD
         H24JHKnY4Ewbec9X+l0aeyGFbLdw5FgIRmwU3J2bPNj6Bg97uIKfIbh/yY6ZmZYZGVHZ
         WhLg==
X-Gm-Message-State: AOAM530DVGtvXN6Xp39hxK0Lsy3WtRPjrzNeD2/OVi3EnzwX53949FtE
        Teq6HKEkyEucetQdxeC8KZI=
X-Google-Smtp-Source: ABdhPJwg3KqknukzwUEb/OVf4u1OFH5Wc8NXaUozuQUEETQWWjFpapt4iiSoL2G0ruOwvk7cwPa/Fw==
X-Received: by 2002:a05:6830:22fa:: with SMTP id t26mr7575670otc.2.1625630508065;
        Tue, 06 Jul 2021 21:01:48 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-3e85-59b9-418d-5cfe.res6.spectrum.com. [2603:8081:140c:1a00:3e85:59b9:418d:5cfe])
        by smtp.gmail.com with ESMTPSA id l63sm317937ooc.7.2021.07.06.21.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 21:01:47 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH v2 7/9] RDMA/rxe: Move crc32 init code to rxe_icrc.c
Date:   Tue,  6 Jul 2021 23:00:39 -0500
Message-Id: <20210707040040.15434-8-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210707040040.15434-1-rpearsonhpe@gmail.com>
References: <20210707040040.15434-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch collects the code from rxe_register_device() that sets
up the crc32 calculation into a subroutine rxe_icrc_init() in
rxe_icrc.c.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.h       |  1 -
 drivers/infiniband/sw/rxe/rxe_icrc.c  | 18 ++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_loc.h   |  1 +
 drivers/infiniband/sw/rxe/rxe_verbs.c | 11 +++--------
 4 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rxe.h
index 65a73c1c8b35..1bb3fb618bf5 100644
--- a/drivers/infiniband/sw/rxe/rxe.h
+++ b/drivers/infiniband/sw/rxe/rxe.h
@@ -14,7 +14,6 @@
 
 #include <linux/module.h>
 #include <linux/skbuff.h>
-#include <linux/crc32.h>
 
 #include <rdma/ib_verbs.h>
 #include <rdma/ib_user_verbs.h>
diff --git a/drivers/infiniband/sw/rxe/rxe_icrc.c b/drivers/infiniband/sw/rxe/rxe_icrc.c
index 777199517e9a..62bcdfc8e96a 100644
--- a/drivers/infiniband/sw/rxe/rxe_icrc.c
+++ b/drivers/infiniband/sw/rxe/rxe_icrc.c
@@ -4,9 +4,27 @@
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
  */
 
+#include <linux/crc32.h>
+
 #include "rxe.h"
 #include "rxe_loc.h"
 
+int rxe_icrc_init(struct rxe_dev *rxe)
+{
+	struct crypto_shash *tfm;
+
+	tfm = crypto_alloc_shash("crc32", 0, 0);
+	if (IS_ERR(tfm)) {
+		pr_warn("failed to init crc32 algorithm err:%ld\n",
+			       PTR_ERR(tfm));
+		return PTR_ERR(tfm);
+	}
+
+	rxe->tfm = tfm;
+
+	return 0;
+}
+
 static u32 rxe_crc32(struct rxe_dev *rxe, u32 crc, void *next, size_t len)
 {
 	u32 icrc;
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 73a2c48a3160..f0c954575bde 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -193,6 +193,7 @@ int rxe_requester(void *arg);
 int rxe_responder(void *arg);
 
 /* rxe_icrc.c */
+int rxe_icrc_init(struct rxe_dev *rxe);
 int rxe_icrc_check(struct sk_buff *skb, struct rxe_pkt_info *pkt);
 void rxe_icrc_generate(struct sk_buff *skb, struct rxe_pkt_info *pkt);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index c223959ac174..f7b1a1f64c13 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1154,7 +1154,6 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
 {
 	int err;
 	struct ib_device *dev = &rxe->ib_dev;
-	struct crypto_shash *tfm;
 
 	strscpy(dev->node_desc, "rxe", sizeof(dev->node_desc));
 
@@ -1173,13 +1172,9 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
 	if (err)
 		return err;
 
-	tfm = crypto_alloc_shash("crc32", 0, 0);
-	if (IS_ERR(tfm)) {
-		pr_err("failed to allocate crc algorithm err:%ld\n",
-		       PTR_ERR(tfm));
-		return PTR_ERR(tfm);
-	}
-	rxe->tfm = tfm;
+	err = rxe_icrc_init(rxe);
+	if (err)
+		return err;
 
 	err = ib_register_device(dev, ibdev_name, NULL);
 	if (err)
-- 
2.30.2

