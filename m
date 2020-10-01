Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A602805DD
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Oct 2020 19:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732995AbgJARtK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Oct 2020 13:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733009AbgJARtK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Oct 2020 13:49:10 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D53CC0613E8
        for <linux-rdma@vger.kernel.org>; Thu,  1 Oct 2020 10:49:09 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id x69so6498259oia.8
        for <linux-rdma@vger.kernel.org>; Thu, 01 Oct 2020 10:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7ZpZLp9uHExOAGYVe2DGT9DP+CSVCfXtjYnapnR4Lz0=;
        b=uNBLrykmAvTCFWjpIKYtSIqAViXtyLaSDdJ9ckPoPoGWez1qGdx5zGM2ulQo5wPkSP
         xirf+iGkvQK3HcEmUJChXR2XT62oOaK1JYQm3OTCyoaoFmTzJeWGHss9NqWDYffqLqT7
         gNs7dg4KcYaH74gfu8OwQlm42YRuy9o33N10D2e9ceaIc/oIYMfQ0x6cSK7rOo186220
         EXbqdGkmmuhE002NwrSoyIrhrnWn/ix97EeL1ZBmG01aoSs2P/jZxB4AIPw78GaFu/dF
         iNoMlDoyA7CxzYlvhSeDWbekyq3naXp35Z5vcwTLGO8CmogD4hoXc8gn5yIOFjQo4sLH
         eiWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7ZpZLp9uHExOAGYVe2DGT9DP+CSVCfXtjYnapnR4Lz0=;
        b=eHEeYWAl3pxX+PfAXZl0DjDgKRvLxtt80cQ25RVyfu1O4Uks7SfyUOhMJlXybfchAj
         UObCvXWxuEpPHOaVZJbe6ChjN+dWryXGWBUTAsdByL2MzIpQzsbiwdl3n0TjKPw4NH/T
         9oTzWzDaYdfLHA47Bzfg52ExjNUjUy7LdHn4P+SuJVeZVerU2UhNDefm2+PucBqtBZmc
         ZHmZrxJsmp7LI5V73eF56/7iakZJ82uVD6yTYHr5kqplPMxt3VsoPFn6Ch4+tdPWXJu0
         MquIbFee2D00NgmzVMlrrzNWXxFak0ZXX/494qdYTGJaUWrZpbCc/u5A0r2Exn+izPER
         3GyA==
X-Gm-Message-State: AOAM533JsztMsEy+usbFl24j6W/wnFuMHHlIj1hNKpaQREtOgy+/Y5ue
        amyszAUt/SrvCkkSFd002G7yBdrS1Z4=
X-Google-Smtp-Source: ABdhPJzY+1G6COKyfRSvVSedz4lVbgTi3nSEhd1rBUUMV000sBNUcXz9iNhv6iSOWkCM3LYfwjJ2/w==
X-Received: by 2002:aca:ecc4:: with SMTP id k187mr677844oih.138.1601574548716;
        Thu, 01 Oct 2020 10:49:08 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:d01f:9a3e:d22f:7a6])
        by smtp.gmail.com with ESMTPSA id 71sm1450315otm.81.2020.10.01.10.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 10:49:08 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v7 17/19] rdma_rme: removed unused RXE_MR_TYPE_FMR
Date:   Thu,  1 Oct 2020 12:48:45 -0500
Message-Id: <20201001174847.4268-18-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201001174847.4268-1-rpearson@hpe.com>
References: <20201001174847.4268-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is a left over from the past. A step in replacing rxe mr types
with ib mr types.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c    | 1 -
 drivers/infiniband/sw/rxe/rxe_verbs.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index f96f908644b1..1901f388c747 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -28,7 +28,6 @@ static int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
 		return 0;
 
 	case RXE_MR_TYPE_MR:
-	case RXE_MR_TYPE_FMR:
 		if (iova < mr->iova ||
 		    length > mr->length ||
 		    iova > mr->iova + mr->length - length)
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 847f80d7a1b6..ea9861998413 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -275,7 +275,6 @@ enum rxe_mr_type {
 	RXE_MR_TYPE_NONE,
 	RXE_MR_TYPE_DMA,
 	RXE_MR_TYPE_MR,
-	RXE_MR_TYPE_FMR,
 };
 
 #define RXE_BUF_PER_MAP		(PAGE_SIZE / sizeof(struct rxe_phys_buf))
-- 
2.25.1

