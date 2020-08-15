Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA66B245378
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Aug 2020 00:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgHOVvZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Aug 2020 17:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728704AbgHOVvW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 15 Aug 2020 17:51:22 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DC5C0612A0
        for <linux-rdma@vger.kernel.org>; Fri, 14 Aug 2020 21:59:40 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id x6so2344016ooe.8
        for <linux-rdma@vger.kernel.org>; Fri, 14 Aug 2020 21:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=429me9TE7Vhzd2q6YVBMVKKbtkPoL3HxIm0ExCPvfUs=;
        b=VMpGp3IHovoVx0NlJXVNclR1tuGP2zqKlt/8gLr+Ae/pEVZCYo8NhUqqOcWpXDCIhu
         poMZzpfxKxvhjQA3/CkBGLcD8kwiYQQdDzL7Q1tndFzEFgJFdIgM1F1vFzXGmMDP95Pc
         1JcyJUXZYysXIytudfgJwnqfm8feu1pyno7lycCzSw9JWnz+v3vnbSw/VSgJxG0uH6nB
         pvZqpuGIMOA2tiEdb3CwcaX4B8X5FoncJLGRPaWeQBydDlcr+zg8hLVjpEWY0KMggotO
         5/HgF/yefiVJKSskoid783bmbvF9fPhRdvoGZ4aP3S6RYMYtz5jm2HGeodKXwmm3Nhdt
         XgxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=429me9TE7Vhzd2q6YVBMVKKbtkPoL3HxIm0ExCPvfUs=;
        b=OwRySXxGzAZDyl+v+sBrMlL/1UEb07yNeq4Hdjm4fDflC9Ttv9mPYcfj6SSKPJlwgq
         U/z2yFbKrzLuim7BGHa502zydfvyyAM6Zn5ccsmhCx2fPfxPr0X8kkF3VVD97s4+r0Qi
         M3K7guqx1e9uh6d/C7ZaZtWvm1Oj7xjFoRqzwdtIYP0y1a0bMVdppgEIyEsL+rBY/IcD
         QtntevlGasM9HagigIzGWlH6wTvfTxPObaYVRMK6niEMX7HG7xjLQHVyYeYOeK+cSuXP
         Q7l4h3/TBm5KEAsUQ1IgcpRQs3Tr5EocccDmsdHrTRbm4SWmiKrpQMgQp0MrAjoU+f3O
         YC5w==
X-Gm-Message-State: AOAM5320NA8OXVtFHrUPt/Cj5+cSgkuuYADLyUh5c9LSSRbrZvf1ivOl
        59BnqpajBWrc507oObs5dr8I8MczLqROnA==
X-Google-Smtp-Source: ABdhPJy1CVL8rwhdcx3trnDX5VSjDHn8fIukm9ncF5G9ipqQnyDdGMideToZoAN2JxF5ZWrO1mWTdA==
X-Received: by 2002:a4a:b983:: with SMTP id e3mr3967506oop.91.1597467579364;
        Fri, 14 Aug 2020 21:59:39 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:b453:c5f2:2895:a54c])
        by smtp.gmail.com with ESMTPSA id e194sm2200597oib.41.2020.08.14.21.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 21:59:39 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH 02/20] Added missing IB_WR_BIND_MW opcode
Date:   Fri, 14 Aug 2020 23:58:26 -0500
Message-Id: <20200815045912.8626-3-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200815045912.8626-1-rpearson@hpe.com>
References: <20200815045912.8626-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Also assigned the IB_WC_XXX to the IB_UVERBS_WC_XXX where they
are defined. This follows the same pattern as the IB_WR_XXX opcodes.
This fixes an incorrect value for LSO that had crept in but was not used.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 include/rdma/ib_verbs.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index c0b2fa7e9b95..05362947322b 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -952,13 +952,14 @@ enum ib_wc_status {
 const char *__attribute_const__ ib_wc_status_msg(enum ib_wc_status status);
 
 enum ib_wc_opcode {
-	IB_WC_SEND,
-	IB_WC_RDMA_WRITE,
-	IB_WC_RDMA_READ,
-	IB_WC_COMP_SWAP,
-	IB_WC_FETCH_ADD,
-	IB_WC_LSO,
-	IB_WC_LOCAL_INV,
+	IB_WC_SEND = IB_UVERBS_WC_SEND,
+	IB_WC_RDMA_WRITE = IB_UVERBS_WC_RDMA_WRITE,
+	IB_WC_RDMA_READ = IB_UVERBS_WC_RDMA_READ,
+	IB_WC_COMP_SWAP = IB_UVERBS_WC_COMP_SWAP,
+	IB_WC_FETCH_ADD = IB_UVERBS_WC_FETCH_ADD,
+	IB_WC_BIND_MW = IB_UVERBS_WC_BIND_MW,
+	IB_WC_LOCAL_INV = IB_UVERBS_WC_LOCAL_INV,
+	IB_WC_LSO = IB_UVERBS_WC_TSO,
 	IB_WC_REG_MR,
 	IB_WC_MASKED_COMP_SWAP,
 	IB_WC_MASKED_FETCH_ADD,
@@ -1291,6 +1292,7 @@ enum ib_wr_opcode {
 	IB_WR_RDMA_READ = IB_UVERBS_WR_RDMA_READ,
 	IB_WR_ATOMIC_CMP_AND_SWP = IB_UVERBS_WR_ATOMIC_CMP_AND_SWP,
 	IB_WR_ATOMIC_FETCH_AND_ADD = IB_UVERBS_WR_ATOMIC_FETCH_AND_ADD,
+	IB_WR_BIND_MW = IB_UVERBS_WR_BIND_MW,
 	IB_WR_LSO = IB_UVERBS_WR_TSO,
 	IB_WR_SEND_WITH_INV = IB_UVERBS_WR_SEND_WITH_INV,
 	IB_WR_RDMA_READ_WITH_INV = IB_UVERBS_WR_RDMA_READ_WITH_INV,
-- 
2.25.1

