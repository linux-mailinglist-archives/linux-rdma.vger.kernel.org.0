Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8B21F0EFF
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2019 07:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbfKFGjk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Nov 2019 01:39:40 -0500
Received: from mail-m973.mail.163.com ([123.126.97.3]:41070 "EHLO
        mail-m973.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729470AbfKFGjk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 Nov 2019 01:39:40 -0500
X-Greylist: delayed 907 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Nov 2019 01:39:39 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=ZW7ADXOpY7jtfDW7OG
        JksEYT6Hht/9ZWqeFWJehNnHY=; b=faHvyNdhd7HbjtZqDveFTPKZ6/7nMDwot0
        h+rK3VdRd0Nctm7wLwWcCulsbK3FOo/YRIMw2+0E+r1ZfhS63ps9uC3HZHchprB3
        792N0sCnIwhccWH0zZ1o6PZa7ivrhAFpYb0SoMrxUEOhBuc9erjxA4iyuAADB0cZ
        hZ5f9TeCw=
Received: from localhost.localdomain (unknown [202.112.113.212])
        by smtp3 (Coremail) with SMTP id G9xpCgAXbAsCZ8JdsYANHw--.188S3;
        Wed, 06 Nov 2019 14:24:24 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Michal Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pan Bian <bianpan2016@163.com>
Subject: [PATCH] RDMA/qedr: fix potential use after free
Date:   Wed,  6 Nov 2019 14:23:54 +0800
Message-Id: <1573021434-18768-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: G9xpCgAXbAsCZ8JdsYANHw--.188S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFyfJrW5ur1ktw1rAw13urg_yoW3Gwb_Ca
        yq9w1xXw1UCF1Fk34UWr13ZFWIqayq9wn5Xwnxt3W3CryYyF9xJ3s5Zrn5u397J34kGFZx
        Jr4UK3s7Ar4rGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU14xRPUUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/1tbiQBhlclSIdH7ERgAAsb
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Move the release operation after error log to avoid possible use after
free.

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/infiniband/hw/qedr/qedr_iw_cm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/qedr/qedr_iw_cm.c b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
index 22881d4442b9..eedc32b72ff2 100644
--- a/drivers/infiniband/hw/qedr/qedr_iw_cm.c
+++ b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
@@ -451,10 +451,10 @@ qedr_addr6_resolve(struct qedr_dev *dev,
 
 	if ((!dst) || dst->error) {
 		if (dst) {
-			dst_release(dst);
 			DP_ERR(dev,
 			       "ip6_route_output returned dst->error = %d\n",
 			       dst->error);
+			dst_release(dst);
 		}
 		return -EINVAL;
 	}
-- 
2.7.4

