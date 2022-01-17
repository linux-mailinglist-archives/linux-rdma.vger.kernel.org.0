Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D660F490440
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jan 2022 09:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiAQIsc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Jan 2022 03:48:32 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:51580 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229620AbiAQIsc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 17 Jan 2022 03:48:32 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V21zh5B_1642409309;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V21zh5B_1642409309)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 17 Jan 2022 16:48:30 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, chengyou@linux.alibaba.com,
        tonylu@linux.alibaba.com
Subject: [PATCH rdma-next v2 01/11] RDMA: Add ERDMA to rdma_driver_id definition
Date:   Mon, 17 Jan 2022 16:48:18 +0800
Message-Id: <20220117084828.80638-2-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220117084828.80638-1-chengyou@linux.alibaba.com>
References: <20220117084828.80638-1-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 include/uapi/rdma/ib_user_ioctl_verbs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/rdma/ib_user_ioctl_verbs.h b/include/uapi/rdma/ib_user_ioctl_verbs.h
index 3072e5d6b692..7dd56210226f 100644
--- a/include/uapi/rdma/ib_user_ioctl_verbs.h
+++ b/include/uapi/rdma/ib_user_ioctl_verbs.h
@@ -250,6 +250,7 @@ enum rdma_driver_id {
 	RDMA_DRIVER_QIB,
 	RDMA_DRIVER_EFA,
 	RDMA_DRIVER_SIW,
+	RDMA_DRIVER_ERDMA,
 };
 
 enum ib_uverbs_gid_type {
-- 
2.27.0

