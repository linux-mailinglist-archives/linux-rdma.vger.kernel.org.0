Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A167946416
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2019 18:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbfFNQ24 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Jun 2019 12:28:56 -0400
Received: from mga02.intel.com ([134.134.136.20]:49446 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbfFNQ2z (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 14 Jun 2019 12:28:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 09:28:55 -0700
X-ExtLoop1: 1
Received: from sedona.ch.intel.com ([10.2.136.157])
  by orsmga001.jf.intel.com with ESMTP; 14 Jun 2019 09:28:55 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id x5EGSsbB060736;
        Fri, 14 Jun 2019 09:28:55 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id x5EGSram044900;
        Fri, 14 Jun 2019 12:28:53 -0400
Subject: [PATCH for-next 9/9] IB/hfi1: No need to use try_module_get for
 debugfs
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>
Date:   Fri, 14 Jun 2019 12:28:53 -0400
Message-ID: <20190614162853.44714.42818.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20190614162724.44714.22604.stgit@awfm-01.aw.intel.com>
References: <20190614162724.44714.22604.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The call in debugfs.c for try_module_get() is not needed. A reference to
the module will be taken by the VFS layer as long as the owner field is
set in the file ops struct. So set this as well as remove the call.

Suggested-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/debugfs.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/debugfs.c b/drivers/infiniband/hw/hfi1/debugfs.c
index 15efb4a..d268bf9 100644
--- a/drivers/infiniband/hw/hfi1/debugfs.c
+++ b/drivers/infiniband/hw/hfi1/debugfs.c
@@ -987,9 +987,6 @@ static int __i2c_debugfs_open(struct inode *in, struct file *fp, u32 target)
 	struct hfi1_pportdata *ppd;
 	int ret;
 
-	if (!try_module_get(THIS_MODULE))
-		return -ENODEV;
-
 	ppd = private2ppd(fp);
 
 	ret = acquire_chip_resource(ppd->dd, i2c_target(target), 0);
@@ -1155,6 +1152,7 @@ static int exprom_wp_debugfs_release(struct inode *in, struct file *fp)
 { \
 	.name = nm, \
 	.ops = { \
+		.owner = THIS_MODULE, \
 		.read = readroutine, \
 		.write = writeroutine, \
 		.llseek = generic_file_llseek, \
@@ -1165,6 +1163,7 @@ static int exprom_wp_debugfs_release(struct inode *in, struct file *fp)
 { \
 	.name = nm, \
 	.ops = { \
+		.owner = THIS_MODULE, \
 		.read = readf, \
 		.write = writef, \
 		.llseek = generic_file_llseek, \

