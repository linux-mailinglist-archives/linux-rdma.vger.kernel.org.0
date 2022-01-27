Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F45649ED98
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jan 2022 22:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344422AbiA0ViW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jan 2022 16:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344421AbiA0ViU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jan 2022 16:38:20 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A34C061748
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:20 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id v67so8512641oie.9
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dH8B2cNvdFl06sxTfKf2vqr2ZG1+fZx21yGBIrgJ5L4=;
        b=DdW96JLpM/AXFVqyTSl9SSgL4uMiFqQz5ksvfqH5RelzkUScATwbnxB5Dm60B9NaSg
         2Y85TdY7ukwTNWBHrRkFH4ppHq0tvuYsJgPBVZwYcyGsO8gLvQSjif1D+gHMnOLwkUPS
         iWL+2ZyvlDEr34MAs4oWMU3woqrZzook3EuPcK3S19S+qd9A1XOKlvtIjunPjkDKproI
         qej6MuJs5/c80dOoTSDjCJS8AbRt5T8KJ30W3VKnMfrLgx5qHlGX3pyL3cZZEFis2srQ
         jZzltXvi+uOnNYChsEK5PPZZsrpOCH/5p70moQnjvIJ61gW5nQinzFRmioO5C1H5JlWG
         4VlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dH8B2cNvdFl06sxTfKf2vqr2ZG1+fZx21yGBIrgJ5L4=;
        b=R75tpHVsrFVVJ5jRltLtbz6GXJ2fyRxOsOhMIgJl0VzhnwY5RLdWlwSLBls2MySFAC
         oAiIBzGWFFq6xEzemS2CR2SmMX051dCrZ29VI5mfI0q9Cr+Id6b6nSi7umwYLjovzu4+
         7KbndP/MO15AvkCTOQGbIVMq1BR5REk+w/1vACC5DGyEZLzbY0nNFritgRYwi//Dx1jA
         7XudyM2Uugow9FPt6kimVc3upuR2vjIPoC5GoQ9Ng6LHvWnPfu2z3luc56Qtt10kuwjf
         av31ftofTUfyYBkJLjsfdMxX8mhmrFCkdOf5xuQGt4518F5TNgyfQ/yE2pJNcrchaWF8
         KHCQ==
X-Gm-Message-State: AOAM53361V/7j1tqs2tTWN3JhXuNyWOblW6XcRH+zxvbmR3LbWTcjSDS
        aaUd9Uz7pGQwUdFR+Ln5Uh4=
X-Google-Smtp-Source: ABdhPJyElXEE2LPILJ9ef8KWX+e0uKuz2itFmMQpHN4e8/b5TVc0GvT1+0qqkD+fNJ/IcYY/8bjdMg==
X-Received: by 2002:aca:1011:: with SMTP id 17mr3370670oiq.27.1643319500172;
        Thu, 27 Jan 2022 13:38:20 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id v32sm3994677ooj.45.2022.01.27.13.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 13:38:19 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [RFC PATCH v9 21/26] RDMA/rxe: Replace obj by elem in declaration
Date:   Thu, 27 Jan 2022 15:37:50 -0600
Message-Id: <20220127213755.31697-22-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220127213755.31697-1-rpearsonhpe@gmail.com>
References: <20220127213755.31697-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fix a harmless typo replacing obj by elem in the cleanup fields.
This has no effect but is confusing.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 2 +-
 drivers/infiniband/sw/rxe/rxe_pool.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index b3c74988b0e9..a024c3bf8696 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -12,7 +12,7 @@ static const struct rxe_type_info {
 	const char *name;
 	size_t size;
 	size_t elem_offset;
-	void (*cleanup)(struct rxe_pool_elem *obj);
+	void (*cleanup)(struct rxe_pool_elem *elem);
 	enum rxe_pool_flags flags;
 	u32 min_index;
 	u32 max_index;
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index b7babf4789c7..3d3470d0e3c8 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -39,7 +39,7 @@ struct rxe_pool {
 	struct rxe_dev		*rxe;
 	const char		*name;
 	rwlock_t		pool_lock; /* protects pool add/del/search */
-	void			(*cleanup)(struct rxe_pool_elem *obj);
+	void			(*cleanup)(struct rxe_pool_elem *elem);
 	enum rxe_pool_flags	flags;
 	enum rxe_elem_type	type;
 
-- 
2.32.0

