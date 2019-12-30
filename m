Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC75812CBEA
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Dec 2019 03:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfL3CZh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 29 Dec 2019 21:25:37 -0500
Received: from mail.fudan.edu.cn ([61.129.42.10]:35169 "EHLO fudan.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726726AbfL3CZh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 29 Dec 2019 21:25:37 -0500
Received: from localhost.localdomain (unknown [10.222.182.212])
        by app2 (Coremail) with SMTP id XQUFCgC3vJgGYAlejTybAA--.686S3;
        Mon, 30 Dec 2019 10:25:10 +0800 (CST)
From:   Xiyu Yang <xiyuyang19@fudan.edu.cn>
To:     xiyuyang19@fudan.edu.cn
Cc:     yuanxzhang@fudan.edu.cn, kjlu@umn.edu, leon@kernel.org,
        Markus.Elfring@web.de, Xin Tan <tanxin.ctf@gmail.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Shannon Nelson <shannon.nelson@intel.com>,
        Anjali Singhai Jain <anjali.singhai@intel.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] infiniband: i40iw: fix a potential NULL pointer dereference
Date:   Mon, 30 Dec 2019 10:24:28 +0800
Message-Id: <1577672668-46499-1-git-send-email-xiyuyang19@fudan.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: XQUFCgC3vJgGYAlejTybAA--.686S3
X-Coremail-Antispam: 1UD129KBjvJXoWrKF48tw47uw48CFWkur4fGrg_yoW8Jr1Dpw
        48JF9FkrWrAF1UZa18Kw42vFyfJas8Jw1qvr1ktwn8urn8GFZrtryrKFnrWFW8ZrW5Cw4I
        vFs0gF4kCF4rWw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvI1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28E
        F7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzx
        vE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_Xry5
        Jr1UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5c
        I20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkIecxEwVCm-wCF04k20xvY0x0EwIxG
        rwCF04k20xvE74AGY7Cv6cx26ry5Xr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x0JjaSoXUUUUU=
X-CM-SenderInfo: irzsiiysuqikmy6i3vldqovvfxof0/
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

A NULL pointer can be returned by in_dev_get(). Thus add
a corresponding check so that a NULL pointer dereference
will be avoided at this place.

Fixes: 8e06af711bf2 ("i40iw: add main, hdr, status")
Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
---
Changes in v2:
- Release rtnl lock when in_dev_get return NULL
Changes in v3:
- Continue the next loop when in_dev_get return NULL
Changes in v4:
- Change commit message

 drivers/infiniband/hw/i40iw/i40iw_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_main.c b/drivers/infiniband/hw/i40iw/i40iw_main.c
index d44cf33df81a..238614370927 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_main.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_main.c
@@ -1225,6 +1225,8 @@ static void i40iw_add_ipv4_addr(struct i40iw_device *iwdev)
 			const struct in_ifaddr *ifa;
 
 			idev = in_dev_get(dev);
+			if (!idev)
+				continue;
 			in_dev_for_each_ifa_rtnl(ifa, idev) {
 				i40iw_debug(&iwdev->sc_dev, I40IW_DEBUG_CM,
 					    "IP=%pI4, vlan_id=%d, MAC=%pM\n", &ifa->ifa_address,
-- 
2.7.4

