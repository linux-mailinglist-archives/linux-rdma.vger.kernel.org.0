Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8A95135AF2
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jan 2020 15:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbgAIOFY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Jan 2020 09:05:24 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:33794 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730032AbgAIOFX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Jan 2020 09:05:23 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yishaih@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 9 Jan 2020 16:05:16 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 009E5G6k016622;
        Thu, 9 Jan 2020 16:05:16 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id 009E5GWY001346;
        Thu, 9 Jan 2020 16:05:16 +0200
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id 009E5GXu001345;
        Thu, 9 Jan 2020 16:05:16 +0200
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, dledford@redhat.com, yishaih@mellanox.com,
        maorg@mellanox.com, michaelgur@mellanox.com,
        Edward Srouji <edwards@mellanox.com>
Subject: [PATCH rdma-core 6/7] pyverbs: Add relaxed ordering access flag
Date:   Thu,  9 Jan 2020 16:04:35 +0200
Message-Id: <1578578676-752-7-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1578578676-752-1-git-send-email-yishaih@mellanox.com>
References: <1578578676-752-1-git-send-email-yishaih@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Michael Guralnik <michaelgur@mellanox.com>

Add to access flags enum the value for enabling relaxed ordering on
memory regions.

Signed-off-by: Michael Guralnik <michaelgur@mellanox.com>
Signed-off-by: Edward Srouji <edwards@mellanox.com>
---
 pyverbs/libibverbs_enums.pxd | 1 +
 1 file changed, 1 insertion(+)

diff --git a/pyverbs/libibverbs_enums.pxd b/pyverbs/libibverbs_enums.pxd
index 74ee16b..67a1b6a 100755
--- a/pyverbs/libibverbs_enums.pxd
+++ b/pyverbs/libibverbs_enums.pxd
@@ -112,6 +112,7 @@ cdef extern from '<infiniband/verbs.h>':
         IBV_ACCESS_ZERO_BASED
         IBV_ACCESS_ON_DEMAND
         IBV_ACCESS_HUGETLB
+        IBV_ACCESS_RELAXED_ORDERING
 
     cpdef enum ibv_wr_opcode:
         IBV_WR_RDMA_WRITE
-- 
1.8.3.1

