Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5C3FAFD24
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2019 14:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfIKMyD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Sep 2019 08:54:03 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:53139 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727302AbfIKMyC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Sep 2019 08:54:02 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from sergeygo@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 11 Sep 2019 15:53:59 +0300
Received: from rsws38.mtr.labs.mlnx (rsws38.mtr.labs.mlnx [10.209.40.117])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x8BCrxr5023616;
        Wed, 11 Sep 2019 15:53:59 +0300
From:   Sergey Gorenko <sergeygo@mellanox.com>
To:     sagi@grimberg.me
Cc:     maxg@mellanox.com, linux-rdma@vger.kernel.org,
        Sergey Gorenko <sergeygo@mellanox.com>
Subject: [PATCH] IB/iser: Support up to 16MB data transfer in a single command
Date:   Wed, 11 Sep 2019 12:53:40 +0000
Message-Id: <20190911125340.19017-1-sergeygo@mellanox.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Maximum supported IO size is 8MB for the iSER driver. The
current value is limited by the ISCSI_ISER_MAX_SG_TABLESIZE
macro. But the driver is able to handle 16MB IOs without any
significant changes. Increasing this limit can be useful for
the storage arrays which are fine tuned for IOs larger than
8 MB.

This commit allows to configure maximum IO size up to 16MB
using the max_sectors module parameter.

Signed-off-by: Sergey Gorenko <sergeygo@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/infiniband/ulp/iser/iscsi_iser.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.h b/drivers/infiniband/ulp/iser/iscsi_iser.h
index 39bf213444cb..fe478c576846 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.h
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.h
@@ -103,8 +103,8 @@
 /* Default support is 512KB I/O size */
 #define ISER_DEF_MAX_SECTORS		1024
 #define ISCSI_ISER_DEF_SG_TABLESIZE	((ISER_DEF_MAX_SECTORS * 512) >> SHIFT_4K)
-/* Maximum support is 8MB I/O size */
-#define ISCSI_ISER_MAX_SG_TABLESIZE	((16384 * 512) >> SHIFT_4K)
+/* Maximum support is 16MB I/O size */
+#define ISCSI_ISER_MAX_SG_TABLESIZE	((32768 * 512) >> SHIFT_4K)
 
 #define ISER_DEF_XMIT_CMDS_DEFAULT		512
 #if ISCSI_DEF_XMIT_CMDS_MAX > ISER_DEF_XMIT_CMDS_DEFAULT
-- 
2.17.2

