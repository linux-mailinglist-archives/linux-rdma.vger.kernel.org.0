Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C243624C7EA
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Aug 2020 00:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbgHTWrY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Aug 2020 18:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728368AbgHTWrT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Aug 2020 18:47:19 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CE5C061386
        for <linux-rdma@vger.kernel.org>; Thu, 20 Aug 2020 15:47:18 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id c4so127623otf.12
        for <linux-rdma@vger.kernel.org>; Thu, 20 Aug 2020 15:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=opQ5PQYAFjcFf54uc0HWsHLrSgEnDQ3xUI0E2iiCI/g=;
        b=PU1rv/ZfIBzyOHgelnVsr/N1tgcBmwFlQuPhrXrYRVxVEZ7Rqa4WvjXZnkM4Ean3Tb
         Z3nKh9I8UiEz5wShWxx4H7fjPeEJqO9/yGYHNHhv5Pcn6ouSCRw9Xhx2cRgP9TFdtl+8
         bPERv5/AySFJu7gg9+jqdsiqqb1mnSjZW97M6tRkCpP4aGTzhsVdy0oQ2+ZfwzupaC2v
         lm8UnMK/Z4ZbftIu2QWSMY24RiD5w9Qii1yicNPNKFzBUE82FstqGu45JHtmFoKrqrMZ
         Z3h8X/OLKp1Fc/GDQqZycernaLibf5BKJqlQyLdgqX1KNMfFkarl8fHIt2Jy6YsSRZIY
         6b7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=opQ5PQYAFjcFf54uc0HWsHLrSgEnDQ3xUI0E2iiCI/g=;
        b=aIu8C22avasw36+ejOy1yTmMPs4jh9YB8bws2x3D87+k7brAf+B2RNhBBL8Q47WAa9
         LbJcyEfROf4Y+Fp5e2kJhqFCb4UOWbybRjY6Jzhf8opAXvclW3ZpxxaOz0ItbHacTTY+
         NYzgWp79G24rtCc+tioigYQQXXWc3SGweZIJZ/Pv/0GanQ+fC97ZY7rsCxRKfOUY3YN+
         Xj2uBCxdcjc0CVKynTEv+eh342X2elT9AdyW2wNEUedfM2/Mx6xXsoT9QDjhxMpEL6TK
         RTd8VYoEc9hq5Y7YPQBM6MDT5KU6XMdSTSH5JRuJYHCabwWQa1bDZ5wNNtWCQVbngVuQ
         uAYA==
X-Gm-Message-State: AOAM530sd0ITTxnRLpoRVTI18m4NdDfNw/UN3uGBWYf9/8dxZkpbitIh
        NXFd9JF79mNAbBfxIsir9pu8MLy5UhDFAw==
X-Google-Smtp-Source: ABdhPJzyefhM/l8B34L18/hVdIvV/apOcOkBkQhtMykDtJqDTg0xAjUPwmh1F+yPAkmVrBmqsHusuw==
X-Received: by 2002:a9d:7405:: with SMTP id n5mr9550otk.286.1597963635474;
        Thu, 20 Aug 2020 15:47:15 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:e2a0:5228:a0c3:36eb])
        by smtp.gmail.com with ESMTPSA id i10sm682219oie.42.2020.08.20.15.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 15:47:15 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH v3 03/17] ib_user_verbs.h: Added ib_uverbs_wc_opcode
Date:   Thu, 20 Aug 2020 17:46:24 -0500
Message-Id: <20200820224638.3212-4-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200820224638.3212-1-rpearson@hpe.com>
References: <20200820224638.3212-1-rpearson@hpe.com>
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

