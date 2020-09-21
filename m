Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1279827336F
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Sep 2020 22:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgIUUEK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Sep 2020 16:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgIUUEJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Sep 2020 16:04:09 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B294AC061755
        for <linux-rdma@vger.kernel.org>; Mon, 21 Sep 2020 13:04:09 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id v20so18380006oiv.3
        for <linux-rdma@vger.kernel.org>; Mon, 21 Sep 2020 13:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VSY0rWV+YrVs2UJzkPk/9ZicS8svAtSxY1LJXcwGG08=;
        b=onkLPcuXHEABnzOyzQbrPoLt8+mYoaewyppPzZecAafLYmRkj6FEnOgIFKvRW+/fn1
         RaDGxcpAdS9sftUuZ35ytTZ/feuh12XEP2yFaoZQXDhppcw+PcNzhokHw+5xCPGs0I5n
         dxKD/0soWE6E517VR1v3qbizcE7mUQXI/YNAXtcJbqkHgssJh24ueWRgdRlmTzSFV7eT
         UzpZcfB9iod93UFNo4cFDGV0D8BpViDTlxynqaPCEF2O9HWJfKiK5BEnPf+lQxMy1oa7
         Riyt+EQ/cTedvVeoIhj42ccWwtpZCE7EAAiIJz4X3TB/ZHqTTDK9L6FkdG61Jl7YDrb9
         kkUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VSY0rWV+YrVs2UJzkPk/9ZicS8svAtSxY1LJXcwGG08=;
        b=iZlkYUPjF215iDNc9Nh08f2BdN7bq2MSRtQfw3Aa+d85eZBnj3+soc5OTmMbV0zSuE
         Y+6dsGcOOqkr04H9R23kYrY76M1+nrLuDmfxAGQf26eL/VAtCu2YkimYzinPlGd5K4Nl
         ya9Vj+MI+qTfOvhETRyxf7TqPKWb00lOSCZIdXDXg9By78fMBX0kx2KpDFcAdeZ4l10f
         d0TKPRxRvzKu5cBy6vwrJPrxqMBDEF3FsTFmRmVm3Izny+7xA5LyLpUSJTP7H1pSUYsn
         UWZohnVNLulK6FwbZSMO6PMXZO9LR0eUYYu89WYrPkCp5iHk6/7/tVvuK59fE2hH02Al
         T2aQ==
X-Gm-Message-State: AOAM531DI0VpmZi+YWcjWRpBpO3aF/tkdS4pGnuT6kGE8345WWF06Vo9
        KHb0mN6ummrWiJc01AJHbvQ=
X-Google-Smtp-Source: ABdhPJxeHv2lY2S2LdXb7tF9xycSkJGcw1r4FtHsUuCItrVbrmpaDMchrspxgLE66oVE4bVryxLblw==
X-Received: by 2002:aca:38d6:: with SMTP id f205mr677857oia.6.1600718649101;
        Mon, 21 Sep 2020 13:04:09 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:9211:f781:8595:d131])
        by smtp.gmail.com with ESMTPSA id a20sm7507747oos.13.2020.09.21.13.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 13:04:08 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v6 02/12] rdma_rxe: Enable MW objects
Date:   Mon, 21 Sep 2020 15:03:46 -0500
Message-Id: <20200921200356.8627-3-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200921200356.8627-1-rpearson@hpe.com>
References: <20200921200356.8627-1-rpearson@hpe.com>
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

