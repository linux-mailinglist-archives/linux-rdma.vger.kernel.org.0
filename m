Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B1C33E8C7
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Mar 2021 06:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhCQFKV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Mar 2021 01:10:21 -0400
Received: from saphodev.broadcom.com ([192.19.232.172]:42610 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229519AbhCQFJy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 17 Mar 2021 01:09:54 -0400
Received: from dhcp-10-192-206-197.iig.avagotech.net.net (dhcp-10-123-156-118.dhcp.broadcom.net [10.123.156.118])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id F0F1A7DDA;
        Tue, 16 Mar 2021 22:09:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com F0F1A7DDA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1615957793;
        bh=qAXmOkH4PjPjgu4zbL5sx+W6KnwLuYqg7hQYXXiPQnU=;
        h=From:To:Cc:Subject:Date:From;
        b=l4aAlj20/paVwLIc731M93UtGI+bBoC8voTT8+LdItYNqHGdFZX0666eDn8TVvp9q
         TZlY7uPfxtXav4GnDj74HgPVkrqSSHdxcWC+Fk9mGmk5pCZLaAnWm0L7xZR+kIvD2Z
         H72g/IMI8jUIN8hjNoiTQd3P2EhsmsljfC7x8VgY=
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>
Subject: [PATCH for-next] RDMA/bnxt_re: Move device to error state upon device crash
Date:   Tue, 16 Mar 2021 22:09:49 -0700
Message-Id: <1615957789-30077-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When L2 driver detects a device crash or device undergone
reset, it invokes a stop callback to recover from error.
Current RoCE driver doesn't recover the device. So move
the device to error state and dispatch fatal events to all qps.
Release the MSIx vectors to avoid a crash when  L2 driver
disables the MSIx.
Also, check for the device state to avoid posting further
commands to the HW.

Signed-off-by: Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>
Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h    |  1 +
 drivers/infiniband/hw/bnxt_re/main.c       | 42 ++++++++++++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c |  4 +++
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |  2 ++
 4 files changed, 49 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index b930ea3..ba26d8e 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -138,6 +138,7 @@ struct bnxt_re_dev {
 #define BNXT_RE_FLAG_QOS_WORK_REG		5
 #define BNXT_RE_FLAG_RESOURCES_ALLOCATED	7
 #define BNXT_RE_FLAG_RESOURCES_INITIALIZED	8
+#define BNXT_RE_FLAG_ERR_DEVICE_DETACHED       17
 #define BNXT_RE_FLAG_ISSUE_ROCE_STATS          29
 	struct net_device		*netdev;
 	unsigned int			version, major, minor;
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index fdb8c24..63e7433 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -81,6 +81,7 @@ static struct workqueue_struct *bnxt_re_wq;
 static void bnxt_re_remove_device(struct bnxt_re_dev *rdev);
 static void bnxt_re_dealloc_driver(struct ib_device *ib_dev);
 static void bnxt_re_stop_irq(void *handle);
+static void bnxt_re_dev_stop(struct bnxt_re_dev *rdev);
 
 static void bnxt_re_set_drv_mode(struct bnxt_re_dev *rdev, u8 mode)
 {
@@ -221,6 +222,39 @@ static void bnxt_re_set_resource_limits(struct bnxt_re_dev *rdev)
 /* for handling bnxt_en callbacks later */
 static void bnxt_re_stop(void *p)
 {
+	struct bnxt_re_dev *rdev = p;
+	struct bnxt_qplib_rcfw *rcfw;
+	struct bnxt *bp;
+
+	if (!rdev)
+		return;
+	ASSERT_RTNL();
+
+	/* L2 driver invokes this callback during device error/crash or device
+	 * reset. Current RoCE driver doesn't recover the device in case of
+	 * error. Handle the error by dispatching fatal events to all qps
+	 * ie. by calling bnxt_re_dev_stop and release the MSIx vectors as
+	 * L2 driver want to modify the MSIx table.
+	 */
+	bp = netdev_priv(rdev->netdev);
+	rcfw = &rdev->rcfw;
+
+	ibdev_info(&rdev->ibdev, "Handle device stop call from L2 driver");
+	/* Check the current device state from L2 structure and move the
+	 * device to detached state if FW_FATAL_COND is set.
+	 * This prevents more commands to HW during clean-up,
+	 * in case the device is already in error.
+	 */
+	if (test_bit(BNXT_STATE_FW_FATAL_COND, &bp->state))
+		set_bit(ERR_DEVICE_DETACHED, &rdev->rcfw.cmdq.flags);
+
+	bnxt_re_dev_stop(rdev);
+	bnxt_re_stop_irq(rdev);
+	/* Move the device states to detached and  avoid sending any more
+	 * commands to HW
+	 */
+	set_bit(BNXT_RE_FLAG_ERR_DEVICE_DETACHED, &rdev->flags);
+	set_bit(ERR_DEVICE_DETACHED, &rdev->rcfw.cmdq.flags);
 }
 
 static void bnxt_re_start(void *p)
@@ -234,6 +268,8 @@ static void bnxt_re_sriov_config(void *p, int num_vfs)
 	if (!rdev)
 		return;
 
+	if (test_bit(BNXT_RE_FLAG_ERR_DEVICE_DETACHED, &rdev->flags))
+		return;
 	rdev->num_vfs = num_vfs;
 	if (!bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx)) {
 		bnxt_re_set_resource_limits(rdev);
@@ -427,6 +463,9 @@ static int bnxt_re_net_ring_free(struct bnxt_re_dev *rdev,
 	if (!en_dev)
 		return rc;
 
+	if (test_bit(BNXT_RE_FLAG_ERR_DEVICE_DETACHED, &rdev->flags))
+		return 0;
+
 	memset(&fw_msg, 0, sizeof(fw_msg));
 
 	bnxt_re_init_hwrm_hdr(rdev, (void *)&req, HWRM_RING_FREE, -1, -1);
@@ -489,6 +528,9 @@ static int bnxt_re_net_stats_ctx_free(struct bnxt_re_dev *rdev,
 	if (!en_dev)
 		return rc;
 
+	if (test_bit(BNXT_RE_FLAG_ERR_DEVICE_DETACHED, &rdev->flags))
+		return 0;
+
 	memset(&fw_msg, 0, sizeof(fw_msg));
 
 	bnxt_re_init_hwrm_hdr(rdev, (void *)&req, HWRM_STAT_CTX_FREE, -1, -1);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 441eb42..5d384de 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -212,6 +212,10 @@ int bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
 	u8 opcode, retry_cnt = 0xFF;
 	int rc = 0;
 
+	/* Prevent posting if f/w is not in a state to process */
+	if (test_bit(ERR_DEVICE_DETACHED, &rcfw->cmdq.flags))
+		return 0;
+
 	do {
 		opcode = req->opcode;
 		rc = __send_message(rcfw, req, resp, sb, is_block);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
index 5f2f0a5..9474c00 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
@@ -138,6 +138,8 @@ struct bnxt_qplib_qp_node {
 #define FIRMWARE_INITIALIZED_FLAG	(0)
 #define FIRMWARE_FIRST_FLAG		(31)
 #define FIRMWARE_TIMED_OUT		(3)
+#define ERR_DEVICE_DETACHED             (4)
+
 struct bnxt_qplib_cmdq_mbox {
 	struct bnxt_qplib_reg_desc	reg;
 	void __iomem			*prod;
-- 
2.5.5

