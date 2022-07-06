Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C729568805
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Jul 2022 14:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbiGFML7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Jul 2022 08:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbiGFMLj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 Jul 2022 08:11:39 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8152A424;
        Wed,  6 Jul 2022 05:11:30 -0700 (PDT)
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LdJFH458gz686xt;
        Wed,  6 Jul 2022 20:07:15 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 6 Jul 2022 14:11:28 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 6 Jul 2022 13:11:22 +0100
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
Subject: [PATCH v3 6/6] blk-mq: Drop local variable for reserved tag
Date:   Wed, 6 Jul 2022 20:03:54 +0800
Message-ID: <1657109034-206040-7-git-send-email-john.garry@huawei.com>
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

The local variable is now only referenced once so drop it.

Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 block/blk-mq-tag.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 4e9b8ec55bda..8e3b36d1cb57 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -262,7 +262,6 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 	struct blk_mq_hw_ctx *hctx = iter_data->hctx;
 	struct request_queue *q = iter_data->q;
 	struct blk_mq_tag_set *set = q->tag_set;
-	bool reserved = iter_data->reserved;
 	struct blk_mq_tags *tags;
 	struct request *rq;
 	bool ret = true;
@@ -272,7 +271,7 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 	else
 		tags = hctx->tags;
 
-	if (!reserved)
+	if (!iter_data->reserved)
 		bitnr += tags->nr_reserved_tags;
 	/*
 	 * We can hit rq == NULL here, because the tagging functions
@@ -333,12 +332,11 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 {
 	struct bt_tags_iter_data *iter_data = data;
 	struct blk_mq_tags *tags = iter_data->tags;
-	bool reserved = iter_data->flags & BT_TAG_ITER_RESERVED;
 	struct request *rq;
 	bool ret = true;
 	bool iter_static_rqs = !!(iter_data->flags & BT_TAG_ITER_STATIC_RQS);
 
-	if (!reserved)
+	if (!(iter_data->flags & BT_TAG_ITER_RESERVED))
 		bitnr += tags->nr_reserved_tags;
 
 	/*
-- 
2.35.3

