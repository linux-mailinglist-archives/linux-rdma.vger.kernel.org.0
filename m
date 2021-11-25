Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B2C45E112
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Nov 2021 20:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356765AbhKYTjb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Nov 2021 14:39:31 -0500
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:53185 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356768AbhKYTha (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Nov 2021 14:37:30 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id qKVambYFrqYovqKVdmK5kh; Thu, 25 Nov 2021 20:34:18 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 25 Nov 2021 20:34:18 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     selvin.xavier@broadcom.com, dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/2] RDMA/ocrdma: Simplify code in 'ocrdma_search_mmap()'
Date:   Thu, 25 Nov 2021 20:34:11 +0100
Message-Id: <ec5cab9611ba062adea4cf8c98a63406ed510a71.1637868728.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <b157f9e1586fb4d1083cb4058d7ac81b10bb86d7.1637868728.git.christophe.jaillet@wanadoo.fr>
References: <b157f9e1586fb4d1083cb4058d7ac81b10bb86d7.1637868728.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

'pd_bitmap' does not need to be const. Without it, it is possible to use
this variable when calling '__set_bit()'. This is less verbose and more
logical.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index 72629e706191..bfa7aad92ead 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -247,13 +247,13 @@ static bool ocrdma_search_mmap(struct ocrdma_ucontext *uctx, u64 phy_addr,
 static u16 _ocrdma_pd_mgr_get_bitmap(struct ocrdma_dev *dev, bool dpp_pool)
 {
 	u16 pd_bitmap_idx = 0;
-	const unsigned long *pd_bitmap;
+	unsigned long *pd_bitmap;
 
 	if (dpp_pool) {
 		pd_bitmap = dev->pd_mgr->pd_dpp_bitmap;
 		pd_bitmap_idx = find_first_zero_bit(pd_bitmap,
 						    dev->pd_mgr->max_dpp_pd);
-		__set_bit(pd_bitmap_idx, dev->pd_mgr->pd_dpp_bitmap);
+		__set_bit(pd_bitmap_idx, pd_bitmap);
 		dev->pd_mgr->pd_dpp_count++;
 		if (dev->pd_mgr->pd_dpp_count > dev->pd_mgr->pd_dpp_thrsh)
 			dev->pd_mgr->pd_dpp_thrsh = dev->pd_mgr->pd_dpp_count;
@@ -261,7 +261,7 @@ static u16 _ocrdma_pd_mgr_get_bitmap(struct ocrdma_dev *dev, bool dpp_pool)
 		pd_bitmap = dev->pd_mgr->pd_norm_bitmap;
 		pd_bitmap_idx = find_first_zero_bit(pd_bitmap,
 						    dev->pd_mgr->max_normal_pd);
-		__set_bit(pd_bitmap_idx, dev->pd_mgr->pd_norm_bitmap);
+		__set_bit(pd_bitmap_idx, pd_bitmap);
 		dev->pd_mgr->pd_norm_count++;
 		if (dev->pd_mgr->pd_norm_count > dev->pd_mgr->pd_norm_thrsh)
 			dev->pd_mgr->pd_norm_thrsh = dev->pd_mgr->pd_norm_count;
-- 
2.30.2

