Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBE738C41E
	for <lists+linux-rdma@lfdr.de>; Fri, 21 May 2021 11:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237854AbhEUJ5L (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 May 2021 05:57:11 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5720 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235740AbhEUJzT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 May 2021 05:55:19 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fmhg42fLlzqVWQ;
        Fri, 21 May 2021 17:50:24 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 21 May 2021 17:53:56 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 21 May 2021 17:53:55 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Weihang Li <liweihang@huawei.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH v2 for-next 14/17] RDMA/i40iw: Use refcount_t instead of atomic_t on refcount of i40iw_puda_buf
Date:   Fri, 21 May 2021 17:53:42 +0800
Message-ID: <1621590825-60693-15-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1621590825-60693-1-git-send-email-liweihang@huawei.com>
References: <1621590825-60693-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The refcount_t API will WARN on underflow and overflow of a reference
counter, and avoid use-after-free risks.

Cc: Faisal Latif <faisal.latif@intel.com>
Cc: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/i40iw/i40iw_cm.c   | 8 ++++----
 drivers/infiniband/hw/i40iw/i40iw_puda.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_cm.c b/drivers/infiniband/hw/i40iw/i40iw_cm.c
index c1becb9..9bb86a4 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_cm.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_cm.c
@@ -77,7 +77,7 @@ void i40iw_free_sqbuf(struct i40iw_sc_vsi *vsi, void *bufp)
 	struct i40iw_puda_buf *buf = (struct i40iw_puda_buf *)bufp;
 	struct i40iw_puda_rsrc *ilq = vsi->ilq;
 
-	if (!atomic_dec_return(&buf->refcount))
+	if (refcount_dec_and_test(&buf->refcount))
 		i40iw_puda_ret_bufpool(ilq, buf);
 }
 
@@ -531,7 +531,7 @@ static struct i40iw_puda_buf *i40iw_form_cm_frame(struct i40iw_cm_node *cm_node,
 	if (pdata && pdata->addr)
 		memcpy(buf, pdata->addr, pdata->size);
 
-	atomic_set(&sqbuf->refcount, 1);
+	refcount_set(&sqbuf->refcount, 1);
 
 	return sqbuf;
 }
@@ -1096,7 +1096,7 @@ int i40iw_schedule_cm_timer(struct i40iw_cm_node *cm_node,
 		spin_unlock_irqrestore(&cm_node->retrans_list_lock, flags);
 		new_send->timetosend = jiffies + I40IW_RETRY_TIMEOUT;
 
-		atomic_inc(&sqbuf->refcount);
+		refcount_inc(&sqbuf->refcount);
 		i40iw_puda_send_buf(vsi->ilq, sqbuf);
 		if (!send_retrans) {
 			i40iw_cleanup_retrans_entry(cm_node);
@@ -1286,7 +1286,7 @@ static void i40iw_cm_timer_tick(struct timer_list *t)
 		vsi = &cm_node->iwdev->vsi;
 
 		if (!cm_node->ack_rcvd) {
-			atomic_inc(&send_entry->sqbuf->refcount);
+			refcount_inc(&send_entry->sqbuf->refcount);
 			i40iw_puda_send_buf(vsi->ilq, send_entry->sqbuf);
 			cm_node->cm_core->stats_pkt_retrans++;
 		}
diff --git a/drivers/infiniband/hw/i40iw/i40iw_puda.h b/drivers/infiniband/hw/i40iw/i40iw_puda.h
index 53a7d58..5996626 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_puda.h
+++ b/drivers/infiniband/hw/i40iw/i40iw_puda.h
@@ -90,7 +90,7 @@ struct i40iw_puda_buf {
 	u8 tcphlen;		/* tcp length in bytes */
 	u8 maclen;		/* mac length in bytes */
 	u32 totallen;		/* machlen+iphlen+tcphlen+datalen */
-	atomic_t refcount;
+	refcount_t refcount;
 	u8 hdrlen;
 	bool ipv4;
 	u32 seqnum;
-- 
2.7.4

