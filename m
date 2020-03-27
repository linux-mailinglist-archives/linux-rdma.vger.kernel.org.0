Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19177195C3B
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2020 18:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgC0RPx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Mar 2020 13:15:53 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:44810 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727612AbgC0RPw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Mar 2020 13:15:52 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 27 Mar 2020 20:15:48 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx [10.209.102.136])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 02RHFjjG004869;
        Fri, 27 Mar 2020 20:15:47 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, martin.petersen@oracle.com, jsmart2021@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     idanb@mellanox.com, axboe@kernel.dk, maxg@mellanox.com,
        vladimirk@mellanox.com, oren@mellanox.com, shlomin@mellanox.com,
        israelr@mellanox.com, jgg@mellanox.com
Subject: [PATCH 13/17] nvme: Add Metadata Capabilities enumerations
Date:   Fri, 27 Mar 2020 20:15:41 +0300
Message-Id: <20200327171545.98970-15-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200327171545.98970-1-maxg@mellanox.com>
References: <20200327171545.98970-1-maxg@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Israel Rukshin <israelr@mellanox.com>

The enumerations will be used to expose the namespace metadata format by
the target.

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
---
 include/linux/nvme.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 3d5189f..4e968d3 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -396,6 +396,8 @@ enum {
 	NVME_NS_FEAT_THIN	= 1 << 0,
 	NVME_NS_FLBAS_LBA_MASK	= 0xf,
 	NVME_NS_FLBAS_META_EXT	= 0x10,
+	NVME_NS_MC_META_EXT	= 1 << 0,
+	NVME_NS_MC_META_BUF	= 1 << 1,
 	NVME_LBAF_RP_BEST	= 0,
 	NVME_LBAF_RP_BETTER	= 1,
 	NVME_LBAF_RP_GOOD	= 2,
-- 
1.8.3.1

