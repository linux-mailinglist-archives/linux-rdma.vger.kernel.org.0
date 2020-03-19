Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F398218BB74
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2020 16:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbgCSPqq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Mar 2020 11:46:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:52030 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727627AbgCSPqq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Mar 2020 11:46:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 028D1ABBE;
        Thu, 19 Mar 2020 15:46:44 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     linux-rdma@vger.kernel.org
Cc:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH] infiniband: hfi1: Use scnprintf() for avoiding potential buffer overflow
Date:   Thu, 19 Mar 2020 16:46:41 +0100
Message-Id: <20200319154641.23711-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Since snprintf() returns the would-be-output size instead of the
actual output size, the succeeding calls may go beyond the given
buffer limit.  Fix it by replacing with scnprintf().

Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/infiniband/hw/hfi1/fault.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/fault.c b/drivers/infiniband/hw/hfi1/fault.c
index 986c12153e62..0dfbcfb048ca 100644
--- a/drivers/infiniband/hw/hfi1/fault.c
+++ b/drivers/infiniband/hw/hfi1/fault.c
@@ -222,11 +222,11 @@ static ssize_t fault_opcodes_read(struct file *file, char __user *buf,
 	while (bit < bitsize) {
 		zero = find_next_zero_bit(fault->opcodes, bitsize, bit);
 		if (zero - 1 != bit)
-			size += snprintf(data + size,
+			size += scnprintf(data + size,
 					 datalen - size - 1,
 					 "0x%lx-0x%lx,", bit, zero - 1);
 		else
-			size += snprintf(data + size,
+			size += scnprintf(data + size,
 					 datalen - size - 1, "0x%lx,",
 					 bit);
 		bit = find_next_bit(fault->opcodes, bitsize, zero);
-- 
2.16.4

