Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84501249383
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Aug 2020 05:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgHSDln (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Aug 2020 23:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgHSDlm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Aug 2020 23:41:42 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1148DC061389
        for <linux-rdma@vger.kernel.org>; Tue, 18 Aug 2020 20:41:42 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id a24so19853702oia.6
        for <linux-rdma@vger.kernel.org>; Tue, 18 Aug 2020 20:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SveaCAtFjxN2ACznXbenoGVoxN9aBwl4Wxra9CVO434=;
        b=NVLK6pCGXd1CIHxHWzEtNWsfXpq6MTeOt3yqFbl3iGsmSGG+a8sHMfouAgXvDWAdgb
         WRSPeBxMk/nCdsyqBeX7gDryoUWA0GgpVk/g4Enai4eaQu9aTpOlmBhyyPNRqt19FhpT
         guYXbQmoaaFwzzn26a2JKomXCpvqYHAlvb5AV5gy0iaqT9pbzE9FFNm7Jm/U62vPJ+gi
         C0/WL5TWFRjAd+biBHwXQN4Ay2G2zCffNzyV+dmQqCTS3SXaTTBBSqnBAfpiXtxy7L0V
         BrdY/CwFX6SwhsyYSusrFRYLpYLbTSsvv55ol2rwjbSLSStv+sA0s2IolkieF2HQAx5M
         p4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SveaCAtFjxN2ACznXbenoGVoxN9aBwl4Wxra9CVO434=;
        b=IBN6KaERjw6DLJiilS9732ugNuLS1uKsMipCMgph5SHj1BTkEGbs/yrtvfZIoD8ehb
         jYeviG5JrxElZq1WOKzaV6TP5Jddv+vYMtiZIUpgYTCzOJz7PaskkWNze8yULhRGQWuD
         a6wUmv8M2QqoyJv+j+ugoS0T5e/NekETACAXEDEUgjI6N9GfyGAIsOD2d/QlfqX8z6GQ
         iWBfBwpeqld/5BNvnrkQLX3npJ1Ef1lNuveUzkqUlLuEd0QNhElOYo1ztk/6cDHd5a5u
         cDoGbZXnXSt1T2q4JSwpvy+x3ctZgfk1nfbjpBUhydlqonmGtggTU/QfcdndL0/WHyWf
         wOHw==
X-Gm-Message-State: AOAM531W77WgGZ+oD/P6NPLyiJHw41xxjofEXZ6pYtrY7JIpaDnZ4Y64
        tceqnhd/j4wywWtRB3Ky03c=
X-Google-Smtp-Source: ABdhPJy6OC/VvpUELe4pTQgY66gLQGx/dMzphoaJcF0N6wzbKvpK5q+2SCKcW5E6p/4P25ZIBxafwQ==
X-Received: by 2002:aca:c7cc:: with SMTP id x195mr2163956oif.9.1597808501501;
        Tue, 18 Aug 2020 20:41:41 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:2731:80e6:14c6:1150])
        by smtp.gmail.com with ESMTPSA id t21sm4216540ooc.43.2020.08.18.20.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 20:41:41 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH v2 04/16] ib_verbs.h: Added missing IB_WR_BIND_MW opcode
Date:   Tue, 18 Aug 2020 22:39:54 -0500
Message-Id: <20200819034002.8835-5-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200819034002.8835-1-rpearson@hpe.com>
References: <20200819034002.8835-1-rpearson@hpe.com>
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
index ef2f3986c493..e1d9c5aa0eac 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -978,13 +978,14 @@ enum ib_wc_status {
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
@@ -1317,6 +1318,7 @@ enum ib_wr_opcode {
 	IB_WR_RDMA_READ = IB_UVERBS_WR_RDMA_READ,
 	IB_WR_ATOMIC_CMP_AND_SWP = IB_UVERBS_WR_ATOMIC_CMP_AND_SWP,
 	IB_WR_ATOMIC_FETCH_AND_ADD = IB_UVERBS_WR_ATOMIC_FETCH_AND_ADD,
+	IB_WR_BIND_MW = IB_UVERBS_WR_BIND_MW,
 	IB_WR_LSO = IB_UVERBS_WR_TSO,
 	IB_WR_SEND_WITH_INV = IB_UVERBS_WR_SEND_WITH_INV,
 	IB_WR_RDMA_READ_WITH_INV = IB_UVERBS_WR_RDMA_READ_WITH_INV,
-- 
2.25.1

