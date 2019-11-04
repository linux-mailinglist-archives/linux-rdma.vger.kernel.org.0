Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06809EDFF1
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Nov 2019 13:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbfKDMZx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Nov 2019 07:25:53 -0500
Received: from stargate.chelsio.com ([12.32.117.8]:65110 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728562AbfKDMZx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Nov 2019 07:25:53 -0500
Received: from localhost (mehrangarh.blr.asicdesigners.com [10.193.185.169])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id xA4CPn4Q032285;
        Mon, 4 Nov 2019 04:25:50 -0800
From:   Potnuri Bharat Teja <bharat@chelsio.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org, bharat@chelsio.com,
        nirranjan@chelsio.com
Subject: [PATCH v2 rdma-core] cxgb4: free appropriate pointer in error case
Date:   Mon,  4 Nov 2019 17:55:45 +0530
Message-Id: <1572870345-8629-1-git-send-email-bharat@chelsio.com>
X-Mailer: git-send-email 2.3.9
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

error unmap case wrongly frees only the cqid2ptr for qp/mmid2ptr.
This patch frees the appropriate pointer.

Fixes: 9b2d3af5735e ("Query device to get the max supported stags, qps, and cqs")
Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
v0 -> v1:
- add missing description
---
 providers/cxgb4/dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/providers/cxgb4/dev.c b/providers/cxgb4/dev.c
index 7f5955449ca1..4d02c7a91892 100644
--- a/providers/cxgb4/dev.c
+++ b/providers/cxgb4/dev.c
@@ -203,9 +203,9 @@ err_free:
 	if (rhp->cqid2ptr)
 		free(rhp->cqid2ptr);
 	if (rhp->qpid2ptr)
-		free(rhp->cqid2ptr);
+		free(rhp->qpid2ptr);
 	if (rhp->mmid2ptr)
-		free(rhp->cqid2ptr);
+		free(rhp->mmid2ptr);
 	verbs_uninit_context(&context->ibv_ctx);
 	free(context);
 	return NULL;
-- 
2.3.9

