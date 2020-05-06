Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8371C6D5B
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2020 11:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgEFJmK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 May 2020 05:42:10 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:33015 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729209AbgEFJmH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 May 2020 05:42:07 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from yishaih@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 6 May 2020 12:42:00 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 0469g0I3015458;
        Wed, 6 May 2020 12:42:00 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id 0469g0E1024604;
        Wed, 6 May 2020 12:42:00 +0300
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id 0469g0HT024603;
        Wed, 6 May 2020 12:42:00 +0300
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, yishaih@mellanox.com, maorg@mellanox.com
Subject: [PATCH rdma-core 6/8] verbs: Fix ibv_create_wq() to set wq_context
Date:   Wed,  6 May 2020 12:41:07 +0300
Message-Id: <1588758069-24464-7-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1588758069-24464-1-git-send-email-yishaih@mellanox.com>
References: <1588758069-24464-1-git-send-email-yishaih@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fix ibv_create_wq() to set wq_context upon a successful creation.

Fixes: 2864904f82bf ("Introduce Work Queue object and its verbs")
Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
---
 libibverbs/verbs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libibverbs/verbs.h b/libibverbs/verbs.h
index 288985d..5e256b4 100644
--- a/libibverbs/verbs.h
+++ b/libibverbs/verbs.h
@@ -3073,6 +3073,7 @@ static inline struct ibv_wq *ibv_create_wq(struct ibv_context *context,
 
 	wq = vctx->create_wq(context, wq_init_attr);
 	if (wq) {
+		wq->wq_context = wq_init_attr->wq_context;
 		wq->events_completed = 0;
 		pthread_mutex_init(&wq->mutex, NULL);
 		pthread_cond_init(&wq->cond, NULL);
-- 
1.8.3.1

