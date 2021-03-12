Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCEE33838D
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Mar 2021 03:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhCLC1G (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Mar 2021 21:27:06 -0500
Received: from mail-m17635.qiye.163.com ([59.111.176.35]:54006 "EHLO
        mail-m17635.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbhCLC1E (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 Mar 2021 21:27:04 -0500
X-Greylist: delayed 447 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Mar 2021 21:27:03 EST
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.250.176.228])
        by mail-m17635.qiye.163.com (Hmail) with ESMTPA id AEACA40014A;
        Fri, 12 Mar 2021 10:19:34 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] rdma: delete the useless casting value returned
Date:   Fri, 12 Mar 2021 10:19:30 +0800
Message-Id: <1615515570-1692-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGkMfGBkZQh5LGkkaVkpNSk5OSk5OTE9CT0JVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OlE6Azo6OT8LAwIjHzdDEise
        PAlPCShVSlVKTUpOTkpOTkxOSUlLVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5LVUpMTVVJSUNZV1kIAVlBSk5DSTcG
X-HM-Tid: 0a78243b6259d991kuwsaeaca40014a
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fix the following coccicheck warning:
WARNING: casting value returned by memory allocation function is useless.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 include/rdma/ib_verbs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index ca28fca..f4d24d8
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2259,7 +2259,7 @@ struct iw_cm_conn_param;
 				      struct ib_struct)))
 
 #define rdma_zalloc_drv_obj_gfp(ib_dev, ib_type, gfp)                         \
-	((struct ib_type *)kzalloc(ib_dev->ops.size_##ib_type, gfp))
+	kzalloc(ib_dev->ops.size_##ib_type, gfp)
 
 #define rdma_zalloc_drv_obj(ib_dev, ib_type)                                   \
 	rdma_zalloc_drv_obj_gfp(ib_dev, ib_type, GFP_KERNEL)
-- 
2.7.4

