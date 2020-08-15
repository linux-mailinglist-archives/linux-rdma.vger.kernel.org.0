Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2562452FA
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Aug 2020 23:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgHOV5I (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Aug 2020 17:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729012AbgHOVwK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 15 Aug 2020 17:52:10 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79530C0612FF
        for <linux-rdma@vger.kernel.org>; Fri, 14 Aug 2020 21:59:38 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id j7so10012401oij.9
        for <linux-rdma@vger.kernel.org>; Fri, 14 Aug 2020 21:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=opQ5PQYAFjcFf54uc0HWsHLrSgEnDQ3xUI0E2iiCI/g=;
        b=hzztmP4Q3XvogBg+dZXVPOcFzJsWNoJK/EZ2fEX9POpTJRawCRUhug0GlcCx/CCckF
         WbQNxvZ2oqH62YFzrM1b1V6Sa47WVWbUpvSauP+I14AN0roaKqVQ7qCeyHu4W/e2vwJb
         hb8mZ/V4tVaoyPCUwEWiQ17m72kwmHs/Zj2+34aEe4xrzfPSANGbPuak7rSr4MA+NOg4
         lfXRC5eU19gF4LC5kozBWKfyB8A67wNUqf+2v7c6jfTYuI0Io+zmLNS3x4q6nSE1sduk
         SGHU62BtEldx5AbGfUdi41NFpczIRyfIYEReial4jy0JHr9WGDuAjCY7sORn8rQEEYQA
         Et/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=opQ5PQYAFjcFf54uc0HWsHLrSgEnDQ3xUI0E2iiCI/g=;
        b=cfHCbKUkFPLR5EB6IA7xQUws7cSKZlM2dlJjyo0yOA5c/abB7sju4ASdgBeVEYq7lx
         YhmbB4m8LB2AQT9i9K9tr5MMdgOgU5MTP6FxfFAjXRcgKyD+KUL1pB0I6nOFYwh3VL0T
         Oz1GCiEbg4tid0lysblSt3SDWXXZgVANUIcWDYmOOnr8XlczfObhtRQ1B1mA7A8qztTr
         /zcDIk73ZS82WEJCaRkE4vMi+AHXAuDv0cBkGPC9pfc76Gl7cDqMT+r8wa3/J0idnzuz
         2RTl8QzkwGdXLB2AjmKiWsBPVRNNCBoYFPrEjBFwMFC3UyxhirHeUTMpjhW4s2qIDAMa
         t4JA==
X-Gm-Message-State: AOAM531zCpbfZMAIXfP+Ggvz6Aj3Mcr0moW2qCNIPl0U2TehE/406BzV
        POl3hZZNOzR+Y7/w9BouAPHntN7mDJaMOA==
X-Google-Smtp-Source: ABdhPJytR0QkHf/vBzFuBJFyXZNODGjjlIeXrZtJ/AutcF0DFxG0rcwya4TlbrkZrYkmDhxgr9UxPg==
X-Received: by 2002:aca:504f:: with SMTP id e76mr3399452oib.87.1597467577281;
        Fri, 14 Aug 2020 21:59:37 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:b453:c5f2:2895:a54c])
        by smtp.gmail.com with ESMTPSA id h68sm2077710otb.50.2020.08.14.21.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 21:59:36 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH 01/20] Added ib_uverbs_wc_opcode to ib_user_verbs.h
Date:   Fri, 14 Aug 2020 23:58:25 -0500
Message-Id: <20200815045912.8626-2-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200815045912.8626-1-rpearson@hpe.com>
References: <20200815045912.8626-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This enum plays the same role as ib_uverbs_wr_opcode documenting
the opcodes in the user space API. It plays a role for software
drivers like rxe.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 include/uapi/rdma/ib_user_verbs.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/uapi/rdma/ib_user_verbs.h b/include/uapi/rdma/ib_user_verbs.h
index 0474c7400268..456438c18c2c 100644
--- a/include/uapi/rdma/ib_user_verbs.h
+++ b/include/uapi/rdma/ib_user_verbs.h
@@ -457,6 +457,17 @@ struct ib_uverbs_poll_cq {
 	__u32 ne;
 };
 
+enum ib_uverbs_wc_opcode {
+	IB_UVERBS_WC_SEND = 0,
+	IB_UVERBS_WC_RDMA_WRITE = 1,
+	IB_UVERBS_WC_RDMA_READ = 2,
+	IB_UVERBS_WC_COMP_SWAP = 3,
+	IB_UVERBS_WC_FETCH_ADD = 4,
+	IB_UVERBS_WC_BIND_MW = 5,
+	IB_UVERBS_WC_LOCAL_INV = 6,
+	IB_UVERBS_WC_TSO = 7,
+};
+
 struct ib_uverbs_wc {
 	__aligned_u64 wr_id;
 	__u32 status;
-- 
2.25.1

