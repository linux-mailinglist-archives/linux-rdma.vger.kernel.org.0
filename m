Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A68360583
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Apr 2021 11:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbhDOJV5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Apr 2021 05:21:57 -0400
Received: from mail-m17635.qiye.163.com ([59.111.176.35]:52036 "EHLO
        mail-m17635.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbhDOJV5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 15 Apr 2021 05:21:57 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17635.qiye.163.com (Hmail) with ESMTPA id 8EEAE4002ED;
        Thu, 15 Apr 2021 17:21:30 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Kamal Heib <kamalheib1@gmail.com>,
        Alaa Hleihel <alaa@mellanox.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Valentine Fatiev <valentinef@mellanox.com>,
        Christoph Lameter <cl@linux.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
Subject: [PATCH] infiniband: ulp: Remove unnecessary struct declaration
Date:   Thu, 15 Apr 2021 17:21:16 +0800
Message-Id: <20210415092124.27684-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGkMYT1ZLGE5LQkseHU4dSR9VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NRQ6DTo4TT8SKBI2CT8WEQtI
        LU0aFDNVSlVKTUpDT0xDT0JKSkJNVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKQkNKNwY+
X-HM-Tid: 0a78d4d5e496d991kuws8eeae4002ed
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

struct ipoib_cm_tx is defined at 245th line.
And the definition is independent on the MACRO.
The declaration here is unnecessary. Remove it.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/infiniband/ulp/ipoib/ipoib.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib.h b/drivers/infiniband/ulp/ipoib/ipoib.h
index 179ff1d068e5..d255aa69ba6d 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib.h
+++ b/drivers/infiniband/ulp/ipoib/ipoib.h
@@ -677,8 +677,6 @@ void ipoib_cm_handle_rx_wc(struct net_device *dev, struct ib_wc *wc);
 void ipoib_cm_handle_tx_wc(struct net_device *dev, struct ib_wc *wc);
 #else
 
-struct ipoib_cm_tx;
-
 #define ipoib_max_conn_qp 0
 
 static inline int ipoib_cm_admin_enabled(struct net_device *dev)
-- 
2.25.1

