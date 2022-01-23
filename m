Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60CED49741A
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Jan 2022 19:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239481AbiAWSDj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Jan 2022 13:03:39 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:56092 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239504AbiAWSDi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 23 Jan 2022 13:03:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C6746102C;
        Sun, 23 Jan 2022 18:03:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2EC0C340E2;
        Sun, 23 Jan 2022 18:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642961017;
        bh=eYnrREAK325afTu/6g5jFsGD8pwyIysWpEQlvDyyTaE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SKg0aA1vqFQscdpFAaoHd49A3pAu3UrfLZ+oVwI1/OGnDt/p2XkMqBJgDCpbdJ2R4
         AzPyVA9Pv8ML3qkHF/3Lpn5eTlTD3YJ2Lm5U/L10H0iDJx49apR7QDHzj096LBVR/j
         ZegDfkhBmWrVVCgg4nO+rTguIkAuiNHzGHmBzlcRBMkeG94SIa+ydQRNwg7SqDHLrV
         2tFpZVynxfs4vIASCUfGmOYpvoViNCJljM0s30rhJp6tTrTQv1If3YVMtK98gMwRVv
         CnbxYemhmTk2La4vewEyzAZni490QOLTwQH9dsAaVFqlsOq2zKAKaMYdiDYcKooHxK
         2WdcySmkKyXCw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Christian Benvenuti <benve@cisco.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [PATCH rdma-next 08/11] RDMA/rxe: Delete useless module.h include
Date:   Sun, 23 Jan 2022 20:02:57 +0200
Message-Id: <8bdb652b01f2316bc57b456fb8c60bfbffe6cc64.1642960861.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1642960861.git.leonro@nvidia.com>
References: <cover.1642960861.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

There is no need in include of module.h in the following files.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/sw/rxe/rxe.h      | 1 -
 drivers/infiniband/sw/rxe/rxe_mmap.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rxe.h
index fb9066e6f5f0..30fbdf3bc76a 100644
--- a/drivers/infiniband/sw/rxe/rxe.h
+++ b/drivers/infiniband/sw/rxe/rxe.h
@@ -12,7 +12,6 @@
 #endif
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/module.h>
 #include <linux/skbuff.h>
 
 #include <rdma/ib_verbs.h>
diff --git a/drivers/infiniband/sw/rxe/rxe_mmap.c b/drivers/infiniband/sw/rxe/rxe_mmap.c
index 035f226af133..9149b6095429 100644
--- a/drivers/infiniband/sw/rxe/rxe_mmap.c
+++ b/drivers/infiniband/sw/rxe/rxe_mmap.c
@@ -4,7 +4,6 @@
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
  */
 
-#include <linux/module.h>
 #include <linux/vmalloc.h>
 #include <linux/mm.h>
 #include <linux/errno.h>
-- 
2.34.1

