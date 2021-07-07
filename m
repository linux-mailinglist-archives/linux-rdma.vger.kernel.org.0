Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 480693BE1BB
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jul 2021 06:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbhGGEE1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Jul 2021 00:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbhGGEEZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Jul 2021 00:04:25 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A363C061574
        for <linux-rdma@vger.kernel.org>; Tue,  6 Jul 2021 21:01:46 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id b2so1903452oiy.6
        for <linux-rdma@vger.kernel.org>; Tue, 06 Jul 2021 21:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q/sZ5yhZkLWFf8OuiXd+lEDsqtGzklgaAqQA/VHIlMs=;
        b=J7lUNeC+ESfSyk9kfQShR+McycqRC0umn+ookz5NVRb7/0DpRwK6wqknoQ1QL63cmc
         SiYlRvgQINP5yNnc+SvsU3CiuyLRhwn9YL0trMNrnCJ7E1YKtWw2QyOBEX0zqXp9fr7X
         cNfqSsF/qqCab7b1tstyGrRTWG2gH7YN3lqpkWwmUeoV6j9nvIVaKA65Y0RUbUmmx6ks
         xN5imd9RdKaEhcaq9lrqmALyiDmcaomYVl5ejmMvrVmlTcRsoOmb9gDi+B6XP16/3OiT
         vEy6CDBV7v+oj9LpZYeDci8qeW1KvrCesNb8Xb77saZ7iO9eTa8im6i2V5LXhIFwFBF/
         CpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q/sZ5yhZkLWFf8OuiXd+lEDsqtGzklgaAqQA/VHIlMs=;
        b=bSUbIKTrxH4zfIWtPK/FbkJAI5Ai1MwQK7BhdrY7OJ17cm++s18E3X3+yO/BIy3o/h
         qm7bm6zb7pS/2+rUx63+97P01om2/4zZy5AR5WQAgP/DYTLYHetvHEh5afHSvQ0qKEfS
         zg34ec4BRK6FBmzvWRr0kvd/OVD/SY+3MGvNDWCe3A0v0Md9VxgbpmFTe7v6DkWbJE/x
         UqOuPhrAHq1RJ8BnKNGhNPmD/6yilEUw1N7Cppmh5iAD7Gi/FCqEt7qmanlXUrQkiy1T
         hknCf5IkHQhTL6tLjVSH5X0ojwpv4LIz85qACYSIGWr9l6Qd76X+Z4zh727jZ86ZVyk1
         dHBw==
X-Gm-Message-State: AOAM533I1imAvOX9+RiQjH1D/akOFgcReM6eY5eVd8L7CsGKuUnq7t3k
        QkP+C83naEWzvKuTEdh3dC8=
X-Google-Smtp-Source: ABdhPJzJAEd4b9A4/NV4Lm8IOit09NJ0Ez9tqcGDu6WtUqsoUQ1+toWrq3WLojO2mLEftA9fUfhA5Q==
X-Received: by 2002:aca:ab4a:: with SMTP id u71mr3385918oie.174.1625630505698;
        Tue, 06 Jul 2021 21:01:45 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-3e85-59b9-418d-5cfe.res6.spectrum.com. [2603:8081:140c:1a00:3e85:59b9:418d:5cfe])
        by smtp.gmail.com with ESMTPSA id a16sm2630323oiy.17.2021.07.06.21.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 21:01:45 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH v2 5/9] RDMA/rxe: Move rxe_crc32 to a subroutine
Date:   Tue,  6 Jul 2021 23:00:37 -0500
Message-Id: <20210707040040.15434-6-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210707040040.15434-1-rpearsonhpe@gmail.com>
References: <20210707040040.15434-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Move rxe_crc32() from rxe.h to rxe_icrc.c as a static local function.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.h      | 21 ---------------------
 drivers/infiniband/sw/rxe/rxe_icrc.c | 21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rxe.h
index 623fd17df02d..65a73c1c8b35 100644
--- a/drivers/infiniband/sw/rxe/rxe.h
+++ b/drivers/infiniband/sw/rxe/rxe.h
@@ -42,27 +42,6 @@
 
 extern bool rxe_initialized;
 
-static inline u32 rxe_crc32(struct rxe_dev *rxe,
-			    u32 crc, void *next, size_t len)
-{
-	u32 retval;
-	int err;
-
-	SHASH_DESC_ON_STACK(shash, rxe->tfm);
-
-	shash->tfm = rxe->tfm;
-	*(u32 *)shash_desc_ctx(shash) = crc;
-	err = crypto_shash_update(shash, next, len);
-	if (unlikely(err)) {
-		pr_warn_ratelimited("failed crc calculation, err: %d\n", err);
-		return crc32_le(crc, next, len);
-	}
-
-	retval = *(u32 *)shash_desc_ctx(shash);
-	barrier_data(shash_desc_ctx(shash));
-	return retval;
-}
-
 void rxe_set_mtu(struct rxe_dev *rxe, unsigned int dev_mtu);
 
 int rxe_add(struct rxe_dev *rxe, unsigned int mtu, const char *ibdev_name);
diff --git a/drivers/infiniband/sw/rxe/rxe_icrc.c b/drivers/infiniband/sw/rxe/rxe_icrc.c
index 08ab32eb6445..00916440f17b 100644
--- a/drivers/infiniband/sw/rxe/rxe_icrc.c
+++ b/drivers/infiniband/sw/rxe/rxe_icrc.c
@@ -7,6 +7,27 @@
 #include "rxe.h"
 #include "rxe_loc.h"
 
+static u32 rxe_crc32(struct rxe_dev *rxe, u32 crc, void *next, size_t len)
+{
+	u32 icrc;
+	int err;
+
+	SHASH_DESC_ON_STACK(shash, rxe->tfm);
+
+	shash->tfm = rxe->tfm;
+	*(u32 *)shash_desc_ctx(shash) = crc;
+	err = crypto_shash_update(shash, next, len);
+	if (unlikely(err)) {
+		pr_warn_ratelimited("failed crc calculation, err: %d\n", err);
+		return crc32_le(crc, next, len);
+	}
+
+	icrc = *(u32 *)shash_desc_ctx(shash);
+	barrier_data(shash_desc_ctx(shash));
+
+	return icrc;
+}
+
 /* Compute a partial ICRC for all the IB transport headers. */
 u32 rxe_icrc_hdr(struct rxe_pkt_info *pkt, struct sk_buff *skb)
 {
-- 
2.30.2

