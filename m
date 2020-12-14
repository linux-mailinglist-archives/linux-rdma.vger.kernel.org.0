Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C17F2D991C
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Dec 2020 14:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405207AbgLNNnN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Dec 2020 08:43:13 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:9881 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730506AbgLNNnH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Dec 2020 08:43:07 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CvjH06QBKz78hL;
        Mon, 14 Dec 2020 21:41:48 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Mon, 14 Dec 2020 21:42:15 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] hw/hfi1/qsfp: convert comma to semicolon
Date:   Mon, 14 Dec 2020 21:42:43 +0800
Message-ID: <20201214134243.4563-1-zhengyongjun3@huawei.com>
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
 drivers/infiniband/hw/hfi1/qsfp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/qsfp.c b/drivers/infiniband/hw/hfi1/qsfp.c
index 8386c84c2d92..38f311f855b5 100644
--- a/drivers/infiniband/hw/hfi1/qsfp.c
+++ b/drivers/infiniband/hw/hfi1/qsfp.c
@@ -242,7 +242,7 @@ static int i2c_bus_write(struct hfi1_devdata *dd, struct hfi1_i2c_bus *i2c,
 		msgs[0].buf = offset_bytes;
 
 		msgs[1].addr = slave_addr;
-		msgs[1].flags = I2C_M_NOSTART,
+		msgs[1].flags = I2C_M_NOSTART;
 		msgs[1].len = len;
 		msgs[1].buf = data;
 		break;
@@ -290,7 +290,7 @@ static int i2c_bus_read(struct hfi1_devdata *dd, struct hfi1_i2c_bus *bus,
 		msgs[0].buf = offset_bytes;
 
 		msgs[1].addr = slave_addr;
-		msgs[1].flags = I2C_M_RD,
+		msgs[1].flags = I2C_M_RD;
 		msgs[1].len = len;
 		msgs[1].buf = data;
 		break;
-- 
2.22.0

