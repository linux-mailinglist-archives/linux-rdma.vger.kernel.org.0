Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E32462707F3
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Sep 2020 23:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgIRVPy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Sep 2020 17:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgIRVPx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Sep 2020 17:15:53 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E1FC0613CE
        for <linux-rdma@vger.kernel.org>; Fri, 18 Sep 2020 14:15:53 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id c13so8679662oiy.6
        for <linux-rdma@vger.kernel.org>; Fri, 18 Sep 2020 14:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VSY0rWV+YrVs2UJzkPk/9ZicS8svAtSxY1LJXcwGG08=;
        b=LzzZuutEkmWAE65FIDcf0JUkbv8zpic5KB8qXJrkprohmqv+nDqt+H85uxNWQCHpUS
         47IqdvNRuu1iaQpjmM2dWwCxY3g3Qd24nMWmSOSoLKeFzA0C1z9DFsZN1BXEzGvbYRy6
         4g4BnEWcqM8psy+AdKLhF/oMb5tG/aborD5t/oHbfleQKLcQeVtxfqTgdmcogIEfg6pH
         JhEPVLXSErc1N8P12050Ofn3uBeabNYx/OUSkL+EOkcq+bDe3j5KSPUa2VjOzOW0Jo+x
         8LCMedAhGvwie06+MBHPu/PzyGrknbLV868DGQdu9L9cdS8DvH2zihQC6TkOEaADsWPV
         geNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VSY0rWV+YrVs2UJzkPk/9ZicS8svAtSxY1LJXcwGG08=;
        b=WDjbn5OxUz8pvJFKFDieJkQoMMACx1RXNYdoBNr2vvRv0YvMafMPk+GgX1ZjG/NliD
         xRPcdnjurj/nltJHyXkJ8JEw4Vk14LCZI8RkopVGKdbCr1f2mE/2Bd8VMgso0kcKYnqm
         Zp7pgbdWQZoEXfbp3n2d6KDB850v6dsWi0N1HJgIBd9YQFlsTQyAYuG/7ANNMMu5EMTD
         QKcndjRhb5PbH+O88rYFSsvi5BWeyyOzCqINC6y34t6vNWrPBu+DbaTjb2RQ6dEOzkLG
         dcZfRaw4Mt+hxY9Enc5jdheFiBKN6ld8aRNHzlvVqZX64wPdH7tCoYNFA+gjkjoRIOk6
         cQYw==
X-Gm-Message-State: AOAM532taFbZkmCV7uvX8gm3YPntW/E/rBShyLh7oQptSza0GuzPi6IS
        RlgaxMyecSJDg16PC1LW+s1G8JaetGg=
X-Google-Smtp-Source: ABdhPJwK+GQeHHs+uFO+3g/1czXK4lUodCNDls4GHgE5UHNN9euuhtILts8O/26D7tkWJkjbHU7Trg==
X-Received: by 2002:aca:ac8e:: with SMTP id v136mr10747076oie.113.1600463753219;
        Fri, 18 Sep 2020 14:15:53 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:4725:6035:508:6d87])
        by smtp.gmail.com with ESMTPSA id z5sm3174266otp.16.2020.09.18.14.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 14:15:52 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v5 02/12] rdma_rxe: Enable MW objects
Date:   Fri, 18 Sep 2020 16:15:07 -0500
Message-Id: <20200918211517.5295-3-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918211517.5295-1-rpearson@hpe.com>
References: <20200918211517.5295-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Change parameters in rxe_param.h so that MAX_MW is the same as MAX_MR.
Set device attribute in rxe.c so max_mw = MAX_MW.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe.c       |  1 +
 drivers/infiniband/sw/rxe/rxe_param.h | 10 ++++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 43b327b53e26..fab291245366 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -52,6 +52,7 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
 	rxe->attr.max_cq			= RXE_MAX_CQ;
 	rxe->attr.max_cqe			= (1 << RXE_MAX_LOG_CQE) - 1;
 	rxe->attr.max_mr			= RXE_MAX_MR;
+	rxe->attr.max_mw			= RXE_MAX_MW;
 	rxe->attr.max_pd			= RXE_MAX_PD;
 	rxe->attr.max_qp_rd_atom		= RXE_MAX_QP_RD_ATOM;
 	rxe->attr.max_res_rd_atom		= RXE_MAX_RES_RD_ATOM;
diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index 25ab50d9b7c2..4ebb3da8c07d 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -58,7 +58,8 @@ enum rxe_device_param {
 	RXE_MAX_SGE_RD			= 32,
 	RXE_MAX_CQ			= 16384,
 	RXE_MAX_LOG_CQE			= 15,
-	RXE_MAX_MR			= 256 * 1024,
+	RXE_MAX_MR			= 0x40000,
+	RXE_MAX_MW			= 0x40000,
 	RXE_MAX_PD			= 0x7ffc,
 	RXE_MAX_QP_RD_ATOM		= 128,
 	RXE_MAX_RES_RD_ATOM		= 0x3f000,
@@ -87,9 +88,10 @@ enum rxe_device_param {
 	RXE_MAX_SRQ_INDEX		= 0x00040000,
 
 	RXE_MIN_MR_INDEX		= 0x00000001,
-	RXE_MAX_MR_INDEX		= 0x00040000,
-	RXE_MIN_MW_INDEX		= 0x00040001,
-	RXE_MAX_MW_INDEX		= 0x00060000,
+	RXE_MAX_MR_INDEX		= RXE_MIN_MR_INDEX + RXE_MAX_MR - 1,
+	RXE_MIN_MW_INDEX		= RXE_MIN_MR_INDEX + RXE_MAX_MR,
+	RXE_MAX_MW_INDEX		= RXE_MIN_MW_INDEX + RXE_MAX_MW - 1,
+
 	RXE_MAX_PKT_PER_ACK		= 64,
 
 	RXE_MAX_UNACKED_PSNS		= 128,
-- 
2.25.1

