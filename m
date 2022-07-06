Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56335687E4
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Jul 2022 14:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbiGFMLR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Jul 2022 08:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbiGFMLO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 Jul 2022 08:11:14 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE2829CA0;
        Wed,  6 Jul 2022 05:11:08 -0700 (PDT)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LdJJS3J7Nz689Q8;
        Wed,  6 Jul 2022 20:10:00 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 6 Jul 2022 14:11:05 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 6 Jul 2022 13:11:00 +0100
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
Subject: [PATCH v3 2/6] blk-mq: Add a flag for reserved requests
Date:   Wed, 6 Jul 2022 20:03:50 +0800
Message-ID: <1657109034-206040-3-git-send-email-john.garry@huawei.com>
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

Add a flag for reserved requests so that drivers may know this for any
special handling.

Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 block/blk-mq.c         | 6 ++++++
 include/linux/blk-mq.h | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 15c7c5c4ad22..a00e43cc67e5 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -475,6 +475,9 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 	if (!(data->rq_flags & RQF_ELV))
 		blk_mq_tag_busy(data->hctx);
 
+	if (data->flags & BLK_MQ_REQ_RESERVED)
+		data->rq_flags |= RQF_RESV;
+
 	/*
 	 * Try batched alloc if we want more than 1 tag.
 	 */
@@ -589,6 +592,9 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	else
 		data.rq_flags |= RQF_ELV;
 
+	if (flags & BLK_MQ_REQ_RESERVED)
+		data.rq_flags |= RQF_RESV;
+
 	ret = -EWOULDBLOCK;
 	tag = blk_mq_get_tag(&data);
 	if (tag == BLK_MQ_NO_TAG)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 43aad0da3305..7c62b7fabec7 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -57,6 +57,7 @@ typedef __u32 __bitwise req_flags_t;
 #define RQF_TIMED_OUT		((__force req_flags_t)(1 << 21))
 /* queue has elevator attached */
 #define RQF_ELV			((__force req_flags_t)(1 << 22))
+#define RQF_RESV			((__force req_flags_t)(1 << 23))
 
 /* flags that prevent us from merging requests: */
 #define RQF_NOMERGE_FLAGS \
@@ -825,6 +826,11 @@ static inline bool blk_mq_need_time_stamp(struct request *rq)
 	return (rq->rq_flags & (RQF_IO_STAT | RQF_STATS | RQF_ELV));
 }
 
+static inline bool blk_mq_is_reserved_rq(struct request *rq)
+{
+	return rq->rq_flags & RQF_RESV;
+}
+
 /*
  * Batched completions only work when there is no I/O error and no special
  * ->end_io handler.
-- 
2.35.3

