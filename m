Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3882419C890
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Apr 2020 20:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387654AbgDBSMk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Apr 2020 14:12:40 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55383 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733252AbgDBSMk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Apr 2020 14:12:40 -0400
Received: by mail-wm1-f68.google.com with SMTP id r16so4427615wmg.5
        for <linux-rdma@vger.kernel.org>; Thu, 02 Apr 2020 11:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1KhPWJx0D/zAclqaERIdSLBJyKbEq+jJ0JYAmPyPAJY=;
        b=Kv+SMGuP7TJ6oQMwQnIfF6w2e1N8iakfcDwrvy1HK2WpZUlidAjDxi9nZ2fe3luZTx
         XDTgEBW1ce2kH5TNHbPcI5zqSfmFEh25ffeJU0mTBuPadyiAt5PicXc7IwUyZEBofA0R
         GGz2Gt2HPX2oZA5wqS+LSAxO+tg955fMeh1IY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1KhPWJx0D/zAclqaERIdSLBJyKbEq+jJ0JYAmPyPAJY=;
        b=Jh75DYuu1XlAabYqjDLeebk0x6TxP4u3+AvqrY/vxMa6pUauDujnl0sLCsWWakd4+2
         Ld7dmc2+dBNX3E9vnk3eDrubRDxLoRWHRpylJNR+zD/ke5LgsqiGIXzG7cRppvdDE+yB
         lsbMZegEvZ0AxFrqdQLgKbFi0yq8xWpBLgnkel8DW6PuCD39HtIttmVvMimlrx+VU2yL
         wE68PesQRhO0XbOCMfuCW1AbTAVGp1GRoUNELhwlECcQI4kbQnLQMtJ0DKILtPKVHnpq
         +rtLVU8FXh67x9hrge81M7QlsmjO1tRpRb9m2WvU9VtGH/l+BUKxIcEQDSfKqEaePg3K
         DK8g==
X-Gm-Message-State: AGi0PubpRQzb8028Rn8EdXXbcq3Hn1wDeuuG5Hd7r4EWSIUjxvIG8g4X
        6fWuHM8LCBN/kDwgvljE+4o7iWWAAHGo0FhZzLwSIedLEP9epy0qpI5iIili2TOiBvkMlTRVdGd
        r3wt2zKRaZEJek+5w+smunga/wszKD9y5ojbEXTXg397gsUXOCKDCH87dvzXNlislH846wfhbfR
        Arlcw=
X-Google-Smtp-Source: APiQypIuvO6kwai3SCBZM/kygRmrHKcFnqzxiGuvGl6EsTt7lGUeB3mJgrAe6QnapSnhMS++cQsyjQ==
X-Received: by 2002:a1c:b657:: with SMTP id g84mr4584387wmf.107.1585851158359;
        Thu, 02 Apr 2020 11:12:38 -0700 (PDT)
Received: from neo00-el73.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id k3sm8399351wro.39.2020.04.02.11.12.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2020 11:12:37 -0700 (PDT)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, dledford@redhat.com
Subject: [PATCH for-next 4/4] RDMA/bnxt_re: Remove dead code from rcfw
Date:   Thu,  2 Apr 2020 14:12:15 -0400
Message-Id: <1585851136-2316-5-git-send-email-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1585851136-2316-1-git-send-email-devesh.sharma@broadcom.com>
References: <1585851136-2316-1-git-send-email-devesh.sharma@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In the previous refactoring serise there were few
leftover functions which are not is use anymore.
Removed them as it is a dead code.

Fixes: 6f53196bc5e7 ("Refactor doorbell management functions")
Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h | 50 ------------------------------
 1 file changed, 50 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
index bf38409..1573876 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
@@ -112,56 +112,6 @@ struct bnxt_qplib_crsbe {
 #define CREQ_CMP_VALID(hdr, raw_cons, cp_bit)			\
 	(!!((hdr)->v & CREQ_BASE_V) ==				\
 	   !((raw_cons) & (cp_bit)))
-
-#define CREQ_DB_KEY_CP			(0x2 << CMPL_DOORBELL_KEY_SFT)
-#define CREQ_DB_IDX_VALID		CMPL_DOORBELL_IDX_VALID
-#define CREQ_DB_IRQ_DIS			CMPL_DOORBELL_MASK
-#define CREQ_DB_CP_FLAGS_REARM		(CREQ_DB_KEY_CP |	\
-					 CREQ_DB_IDX_VALID)
-#define CREQ_DB_CP_FLAGS		(CREQ_DB_KEY_CP |	\
-					 CREQ_DB_IDX_VALID |	\
-					 CREQ_DB_IRQ_DIS)
-
-static inline void bnxt_qplib_ring_creq_db64(void __iomem *db, u32 index,
-					     u32 xid, bool arm)
-{
-	u64 val = 0;
-
-	val = xid & DBC_DBC_XID_MASK;
-	val |= DBC_DBC_PATH_ROCE;
-	val |= arm ? DBC_DBC_TYPE_NQ_ARM : DBC_DBC_TYPE_NQ;
-	val <<= 32;
-	val |= index & DBC_DBC_INDEX_MASK;
-
-	writeq(val, db);
-}
-
-static inline void bnxt_qplib_ring_creq_db_rearm(void __iomem *db, u32 raw_cons,
-						 u32 max_elements, u32 xid,
-						 bool gen_p5)
-{
-	u32 index = raw_cons & (max_elements - 1);
-
-	if (gen_p5)
-		bnxt_qplib_ring_creq_db64(db, index, xid, true);
-	else
-		writel(CREQ_DB_CP_FLAGS_REARM | (index & DBC_DBC32_XID_MASK),
-		       db);
-}
-
-static inline void bnxt_qplib_ring_creq_db(void __iomem *db, u32 raw_cons,
-					   u32 max_elements, u32 xid,
-					   bool gen_p5)
-{
-	u32 index = raw_cons & (max_elements - 1);
-
-	if (gen_p5)
-		bnxt_qplib_ring_creq_db64(db, index, xid, true);
-	else
-		writel(CREQ_DB_CP_FLAGS | (index & DBC_DBC32_XID_MASK),
-		       db);
-}
-
 #define CREQ_ENTRY_POLL_BUDGET		0x100
 
 /* HWQ */
-- 
1.8.3.1

