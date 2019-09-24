Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E201BD3FE
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Sep 2019 23:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633491AbfIXVDv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Sep 2019 17:03:51 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:46031 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2633461AbfIXVDv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Sep 2019 17:03:51 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 25 Sep 2019 00:03:47 +0300
Received: from r-vnc12.mtr.labs.mlnx (r-vnc12.mtr.labs.mlnx [10.208.0.12])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x8OL3lOS010119;
        Wed, 25 Sep 2019 00:03:47 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     jgg@mellanox.com, linux-rdma@vger.kernel.org, dledford@redhat.com,
        leonro@mellanox.com, sagi@grimberg.me
Cc:     martin.petersen@oracle.com, Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH 1/1] IB/iser: bound protection_sg size by data_sg size
Date:   Wed, 25 Sep 2019 00:03:47 +0300
Message-Id: <1569359027-10987-1-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In case we don't set the sg_prot_tablesize, the scsi layer assign the
default size (65535 entries). We should limit this size since we should
take into consideration the underlaying device capability. This cap is
considered when calculating the sg_tablesize. Otherwise, for example,
we can get that /sys/block/sdb/queue/max_segments is 128 and
/sys/block/sdb/queue/max_integrity_segments is 65535.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/infiniband/ulp/iser/iscsi_iser.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.c b/drivers/infiniband/ulp/iser/iscsi_iser.c
index 5036155..55f45ed 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.c
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.c
@@ -646,6 +646,7 @@ static void iscsi_iser_cleanup_task(struct iscsi_task *task)
 		if (ib_conn->pi_support) {
 			u32 sig_caps = ib_dev->attrs.sig_prot_cap;
 
+			shost->sg_prot_tablesize = shost->sg_tablesize;
 			scsi_host_set_prot(shost, iser_dif_prot_caps(sig_caps));
 			scsi_host_set_guard(shost, SHOST_DIX_GUARD_IP |
 						   SHOST_DIX_GUARD_CRC);
-- 
1.8.3.1

