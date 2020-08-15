Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3AF124529E
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Aug 2020 23:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgHOVxj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Aug 2020 17:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729148AbgHOVwl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 15 Aug 2020 17:52:41 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50BDC061246
        for <linux-rdma@vger.kernel.org>; Fri, 14 Aug 2020 22:00:09 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id v21so9247900otj.9
        for <linux-rdma@vger.kernel.org>; Fri, 14 Aug 2020 22:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I02BPlvFy618itBX0mtykTToAXHctOOIS2ZLlT6vRJk=;
        b=Q5888Tf00gbqvTzCMbG6sF/oQLu8rDP5TTkp/YhE0Mu8qi9reUTfEaIMHqR/v6yq9p
         NSEkRSxTIbM4wVdBCrkgAnr3CsHV1ESW4m3d0HoCF1h4izI/dE8/UQr1ipc+UgR1eCLI
         eTt/GMoWym03yXmnbf6bnbpaLNYZT3V1aRQjcWCYewi1R3YhMhovjtbyvrqPda/5O1TD
         2cwmKg6dIs35zPeOhc2Pvu9Wd/UbtDMcO3UmUCfMb3YZZXihI9Jco0aRxwdoiDL9e1ox
         bGsVbcWuIfThkpLVgGkGFGgSN+SHApjYS4S9JOPbP8Tgf4KFa7Ra+e36tvBf8ef8cgdX
         ZyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I02BPlvFy618itBX0mtykTToAXHctOOIS2ZLlT6vRJk=;
        b=XCZc52jh4kcMHIUdj/ajcSlNq7uNn92KF4PeGUpF5TxboAkgVo3VC0OiIBNiShrL7B
         OrpBDZpSpwK5BIulXkO530jN/sliIumbgLd6jqyDpa2gXFWiFhbSQ3dlgm45oCFfRwjY
         dVkF+/w9/b5MTPVmv2lH7KGJFS/zTetLNbPtrUDe9U19KkJy8t5oh+kdU6YfkOt4twhr
         fqgbZjdZgYg0fw/cx952A9RmZWbJOaeNlYBljpPgSlHf910vrtZLVhvtzjw0wIuP73Pv
         DRbHGyjI6Bql4hU9tFE+uBN3UGdRczjYAQ19UUCTltBVbAFRACbabY9RhAQEQz9+t70z
         FUdw==
X-Gm-Message-State: AOAM531pueb/YrV89Ym0gJUt8EpaxY1j2H6jikV4Xfp+g5CMvcqS70nB
        9TSUEGKXOHx+6CHaYu+X3STHNEsoWTpCKQ==
X-Google-Smtp-Source: ABdhPJzBmHjlYbwpPnAMNlyp7T4vmCIYr5gz3gv23YrspzfeLfwEFYOfGzfjz+dVSJ7QLL+1fT2YIA==
X-Received: by 2002:a9d:2f23:: with SMTP id h32mr4370729otb.334.1597467609042;
        Fri, 14 Aug 2020 22:00:09 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:b453:c5f2:2895:a54c])
        by smtp.gmail.com with ESMTPSA id l17sm2125126otn.2.2020.08.14.22.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 22:00:08 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH 19/20] fixed white space issues
Date:   Fri, 14 Aug 2020 23:58:43 -0500
Message-Id: <20200815045912.8626-20-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200815045912.8626-1-rpearson@hpe.com>
References: <20200815045912.8626-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Checkpatch reported some trailing whitespace. Trying to fix that
here.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_mw.c    | 4 ++--
 drivers/infiniband/sw/rxe/rxe_verbs.h | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index 6b998527b34b..ae7f5710f7dd 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -370,7 +370,7 @@ static void do_invalidate_mw(struct rxe_mw *mw)
 	mw->mr = NULL;
 
 	mw->access = 0;
-	mw->addr = 0; 
+	mw->addr = 0;
 	mw->length = 0;
 	mw->state = RXE_MEM_STATE_FREE;
 }
@@ -405,7 +405,7 @@ static void do_dealloc_mw(struct rxe_mw *mw)
 
 	mw->ibmw.pd = NULL;
 	mw->access = 0;
-	mw->addr = 0; 
+	mw->addr = 0;
 	mw->length = 0;
 	mw->state = RXE_MEM_STATE_INVALID;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index b4855d3ea6f4..c990654e396d 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -66,7 +66,7 @@ struct rxe_ucontext {
 };
 
 struct rxe_pd {
-	struct ib_pd            ibpd;
+	struct ib_pd		ibpd;
 	struct rxe_pool_entry	pelem;
 };
 
@@ -309,8 +309,8 @@ enum rxe_mr_type {
 #define RXE_BUF_PER_MAP		(PAGE_SIZE / sizeof(struct rxe_phys_buf))
 
 struct rxe_phys_buf {
-	u64      addr;
-	u64      size;
+	u64	 addr;
+	u64	 size;
 };
 
 struct rxe_map {
-- 
2.25.1

