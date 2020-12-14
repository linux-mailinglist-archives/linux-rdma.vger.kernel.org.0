Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C35B2D9914
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Dec 2020 14:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405793AbgLNNlo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Dec 2020 08:41:44 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:9880 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408024AbgLNNll (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Dec 2020 08:41:41 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CvjFK1fpXz7G3F;
        Mon, 14 Dec 2020 21:40:21 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Mon, 14 Dec 2020 21:40:47 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] sw/siw/siw_main: convert comma to semicolon
Date:   Mon, 14 Dec 2020 21:41:18 +0800
Message-ID: <20201214134118.4349-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Replace a comma between expression statements by a semicolon.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/infiniband/sw/siw/siw_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index 181e06c1c43d..c2fa6132762a 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -403,7 +403,7 @@ static struct siw_device *siw_device_create(struct net_device *netdev)
 	       sizeof(base_dev->iw_ifname));
 
 	/* Disable TCP port mapping */
-	base_dev->iw_driver_flags = IW_F_NO_PORT_MAP,
+	base_dev->iw_driver_flags = IW_F_NO_PORT_MAP;
 
 	sdev->attrs.max_qp = SIW_MAX_QP;
 	sdev->attrs.max_qp_wr = SIW_MAX_QP_WR;
-- 
2.22.0

