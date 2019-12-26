Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C332912AC5C
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Dec 2019 14:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfLZNWx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Dec 2019 08:22:53 -0500
Received: from mail.fudan.edu.cn ([61.129.42.10]:41265 "EHLO fudan.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725954AbfLZNWx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 26 Dec 2019 08:22:53 -0500
Received: from localhost.localdomain (unknown [10.222.182.212])
        by app2 (Coremail) with SMTP id XQUFCgAn4fX8swReeGNhAA--.45422S3;
        Thu, 26 Dec 2019 21:22:04 +0800 (CST)
From:   xiyuyang19@fudan.edu.cn
To:     xiyuyang19@fudan.edu.cn
Cc:     yuanxzhang@fudan.edu.cn, kjlu@umn.edu, leon@kernel.org,
        Xin Tan <tanxin.ctf@gmail.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] infiniband: i40iw: fix a potential NULL pointer dereference
Date:   Thu, 26 Dec 2019 21:21:56 +0800
Message-Id: <1577366516-19556-1-git-send-email-xiyuyang19@fudan.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: XQUFCgAn4fX8swReeGNhAA--.45422S3
X-Coremail-Antispam: 1UD129KBjvdXoW7XF4DKrWfJF18Wr48Zr1UZFb_yoWkXrX_Kr
        4UZFn7ur98AF12kr4kKFnrXFy2v34YvwsrZw4Dt34fJ34rWw1DJrZ5A3Wrur47urWxGFsr
        Cas5Cw4xCFWrGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbSAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wA2ocxC64kI
        II0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7
        xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
        z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4
        CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26ry5
        Xr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc
        8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwAKzVCY07xG64k0F24lc7CjxVAaw2AF
        wI0_Jw0_GFylc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Xr
        y5Jr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
        7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
        C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
        04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
        IEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JjVPfdUUUUU=
X-CM-SenderInfo: irzsiiysuqikmy6i3vldqovvfxof0/
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xiyu Yang <xiyuyang19@fudan.edu.cn>

in_dev_get may return a NULL object. The fix handles the situation
by adding a check to avoid NULL pointer dereference on idev,
as pick_local_ipaddrs does.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
Changes in v2:
- Release rtnl lock when in_dev_get return NULL
Changes in v3:
- Continue the next loop when in_dev_get return NULL

 drivers/infiniband/hw/i40iw/i40iw_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_main.c b/drivers/infiniband/hw/i40iw/i40iw_main.c
index d44cf33d..2386143 100644
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

