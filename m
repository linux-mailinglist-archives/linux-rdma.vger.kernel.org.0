Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A80931FACEB
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2020 11:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgFPJlS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jun 2020 05:41:18 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:47870 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728114AbgFPJlR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 16 Jun 2020 05:41:17 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05G9dwoH000858;
        Tue, 16 Jun 2020 02:41:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=gH+ZTDtiXgOA/7szRYfmSpILjgf7GQrBJ8O9hR0N5Yw=;
 b=YKLZMMYDC6KX7zXwXJXGMBtm0Bbnsym4FcA21Gk6FgEZ7157DSMj6FlWo6rNA6ziOdux
 LZYk1RQFmFfBOjEYhJJyyM7Wbbzt/1bOD6NzpOhAUPYJx1t+aXRfGecfTkqtisxGdkxh
 RQ9ERPPJdF+llpE90+/QhlXv13N9U8b480GoZJbSlskbdbJ2JRC0LQnLpg2ZduP/WqJc
 SKBurZhdm1gLGzCgLxhUrg1S34kdIChjI9bLfp8+kilSV6BYPn+z4L8AXkQ4U3u2knUg
 1zmoWxWH/HiPwyT9jk3uJ6Y6bMDuOTHHfNSkrefomIHlwMco6fJjS9XAZ07I+QsSWxdP 1g== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 31mv5qjdmt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 16 Jun 2020 02:41:15 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 16 Jun
 2020 02:41:14 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 16 Jun
 2020 02:41:14 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 16 Jun 2020 02:41:14 -0700
Received: from lb-tlvb-michal.il.qlogic.org (unknown [10.5.220.215])
        by maili.marvell.com (Postfix) with ESMTP id A7D393F703F;
        Tue, 16 Jun 2020 02:41:12 -0700 (PDT)
From:   Michal Kalderon <michal.kalderon@marvell.com>
To:     <jgg@ziepe.ca>, <dledford@redhat.com>, <ariel.elior@marvell.com>,
        <michal.kalderon@marvell.com>
CC:     <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma] RDMA/qedr: Fix KASAN: use-after-free in ucma_event_handler+0x532
Date:   Tue, 16 Jun 2020 12:34:08 +0300
Message-ID: <20200616093408.17827-1-michal.kalderon@marvell.com>
X-Mailer: git-send-email 2.14.5
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-16_03:2020-06-15,2020-06-16 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Private data passed to iwarp_cm_handler is copied for
connection request / response, but ignored otherwise.
If junk is passed, it is stored in the event and used later
in the event processing.
Driver passed old junk pointer during connection close
which lead to a use-after-free on event processing.
Set private data to NULL for events that don 't have private
data.

BUG: KASAN: use-after-free in ucma_event_handler+0x532/0x560 [rdma_ucm]
kernel: Read of size 4 at addr ffff8886caa71200 by task kworker/u128:1/5250
kernel:
kernel: Workqueue: iw_cm_wq cm_work_handler [iw_cm]
kernel: Call Trace:
kernel: dump_stack+0x8c/0xc0
kernel: print_address_description.constprop.0+0x1b/0x210
kernel: ? ucma_event_handler+0x532/0x560 [rdma_ucm]
kernel: ? ucma_event_handler+0x532/0x560 [rdma_ucm]
kernel: __kasan_report.cold+0x1a/0x33
kernel: ? ucma_event_handler+0x532/0x560 [rdma_ucm]
kernel: kasan_report+0xe/0x20
kernel: check_memory_region+0x130/0x1a0
kernel: memcpy+0x20/0x50
kernel: ucma_event_handler+0x532/0x560 [rdma_ucm]
kernel: ? __rpc_execute+0x608/0x620 [sunrpc]
kernel: cma_iw_handler+0x212/0x330 [rdma_cm]
kernel: ? iw_conn_req_handler+0x6e0/0x6e0 [rdma_cm]
kernel: ? enqueue_timer+0x86/0x140
kernel: ? _raw_write_lock_irq+0xd0/0xd0
kernel: cm_work_handler+0xd3d/0x1070 [iw_cm]

Fixes: e411e0587e0d ("RDMA/qedr: Add iWARP connection management functions")
Signed-off-by: Ariel Elior <ariel.elior@marvell.com>
Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
---
 drivers/infiniband/hw/qedr/qedr_iw_cm.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/qedr_iw_cm.c b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
index 792eecd206b6..97fc7dd353b0 100644
--- a/drivers/infiniband/hw/qedr/qedr_iw_cm.c
+++ b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
@@ -150,8 +150,17 @@ qedr_iw_issue_event(void *context,
 	if (params->cm_info) {
 		event.ird = params->cm_info->ird;
 		event.ord = params->cm_info->ord;
-		event.private_data_len = params->cm_info->private_data_len;
-		event.private_data = (void *)params->cm_info->private_data;
+		/* Only connect_request and reply have valid private data
+		 * the rest of the events this may be left overs from
+		 * connection establishment. CONNECT_REQUEST is issued via
+		 * qedr_iw_mpa_request
+		 */
+		if (event_type == IW_CM_EVENT_CONNECT_REPLY) {
+			event.private_data_len =
+				params->cm_info->private_data_len;
+			event.private_data =
+				(void *)params->cm_info->private_data;
+		}
 	}
 
 	if (ep->cm_id)
-- 
2.14.5

