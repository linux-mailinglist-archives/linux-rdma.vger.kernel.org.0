Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586F85687DC
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Jul 2022 14:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbiGFMLF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Jul 2022 08:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiGFMLD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 Jul 2022 08:11:03 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5693229C90;
        Wed,  6 Jul 2022 05:11:02 -0700 (PDT)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LdJGV1Jjlz686qR;
        Wed,  6 Jul 2022 20:08:18 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 6 Jul 2022 14:11:00 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 6 Jul 2022 13:10:54 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <bvanassche@acm.org>, <hch@lst.de>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <hare@suse.de>, <satishkh@cisco.com>,
        <sebaddel@cisco.com>, <kartilak@cisco.com>
CC:     <linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-s390@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <mpi3mr-linuxdrv.pdl@broadcom.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <nbd@other.debian.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v3 1/6] scsi: core: Remove reserved request time-out handling
Date:   Wed, 6 Jul 2022 20:03:49 +0800
Message-ID: <1657109034-206040-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1657109034-206040-1-git-send-email-john.garry@huawei.com>
References: <1657109034-206040-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The SCSI core code does not currently support reserved commands. As such,
requests which time-out would never be reserved, and scsi_timeout()
'reserved' arg should never be set.

Remove handling for reserved requests, drop the wrapper scsi_timeout()
as it now just calls scsi_times_out() always, and finally rename
scsi_times_out() -> scsi_timeout() to match the blk_mq_ops method name.

Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 Documentation/scsi/scsi_eh.rst          | 3 +--
 Documentation/scsi/scsi_mid_low_api.rst | 2 +-
 drivers/scsi/scsi_error.c               | 7 ++++---
 drivers/scsi/scsi_lib.c                 | 8 --------
 drivers/scsi/scsi_priv.h                | 3 ++-
 5 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/Documentation/scsi/scsi_eh.rst b/Documentation/scsi/scsi_eh.rst
index 885395dc1f15..bad624fab823 100644
--- a/Documentation/scsi/scsi_eh.rst
+++ b/Documentation/scsi/scsi_eh.rst
@@ -87,8 +87,7 @@ with the command.
 1.2.2 Completing a scmd w/ timeout
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-The timeout handler is scsi_times_out().  When a timeout occurs, this
-function
+The timeout handler is scsi_timeout().  When a timeout occurs, this function
 
  1. invokes optional hostt->eh_timed_out() callback.  Return value can
     be one of
diff --git a/Documentation/scsi/scsi_mid_low_api.rst b/Documentation/scsi/scsi_mid_low_api.rst
index 63ddea2b9640..a8c5bd15a440 100644
--- a/Documentation/scsi/scsi_mid_low_api.rst
+++ b/Documentation/scsi/scsi_mid_low_api.rst
@@ -731,7 +731,7 @@ Details::
     *      Notes: If 'no_async_abort' is defined this callback
     *  	will be invoked from scsi_eh thread. No other commands
     *	will then be queued on current host during eh.
-    *	Otherwise it will be called whenever scsi_times_out()
+    *	Otherwise it will be called whenever scsi_timeout()
     *      is called due to a command timeout.
     *
     *      Optionally defined in: LLD
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 49ef864df581..a8b71b73a5a5 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -139,7 +139,7 @@ static bool scsi_eh_should_retry_cmd(struct scsi_cmnd *cmd)
  *
  * Note: this function must be called only for a command that has timed out.
  * Because the block layer marks a request as complete before it calls
- * scsi_times_out(), a .scsi_done() call from the LLD for a command that has
+ * scsi_timeout(), a .scsi_done() call from the LLD for a command that has
  * timed out do not have any effect. Hence it is safe to call
  * scsi_finish_command() from this function.
  */
@@ -316,8 +316,9 @@ void scsi_eh_scmd_add(struct scsi_cmnd *scmd)
 }
 
 /**
- * scsi_times_out - Timeout function for normal scsi commands.
+ * scsi_timeout - Timeout function for normal scsi commands.
  * @req:	request that is timing out.
+ * @reserved:	whether the request is a reserved request.
  *
  * Notes:
  *     We do not need to lock this.  There is the potential for a race
@@ -325,7 +326,7 @@ void scsi_eh_scmd_add(struct scsi_cmnd *scmd)
  *     normal completion function determines that the timer has already
  *     fired, then it mustn't do anything.
  */
-enum blk_eh_timer_return scsi_times_out(struct request *req)
+enum blk_eh_timer_return scsi_timeout(struct request *req, bool reserved)
 {
 	struct scsi_cmnd *scmd = blk_mq_rq_to_pdu(req);
 	enum blk_eh_timer_return rtn = BLK_EH_DONE;
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index cdf0056582d5..1b3ca5c16c3d 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1790,14 +1790,6 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return ret;
 }
 
-static enum blk_eh_timer_return scsi_timeout(struct request *req,
-		bool reserved)
-{
-	if (reserved)
-		return BLK_EH_RESET_TIMER;
-	return scsi_times_out(req);
-}
-
 static int scsi_mq_init_request(struct blk_mq_tag_set *set, struct request *rq,
 				unsigned int hctx_idx, unsigned int numa_node)
 {
diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
index 5c4786310a31..695d0c83ffe0 100644
--- a/drivers/scsi/scsi_priv.h
+++ b/drivers/scsi/scsi_priv.h
@@ -72,7 +72,8 @@ extern void scsi_exit_devinfo(void);
 
 /* scsi_error.c */
 extern void scmd_eh_abort_handler(struct work_struct *work);
-extern enum blk_eh_timer_return scsi_times_out(struct request *req);
+extern enum blk_eh_timer_return scsi_timeout(struct request *req,
+					     bool reserved);
 extern int scsi_error_handler(void *host);
 extern enum scsi_disposition scsi_decide_disposition(struct scsi_cmnd *cmd);
 extern void scsi_eh_wakeup(struct Scsi_Host *shost);
-- 
2.35.3

