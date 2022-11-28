Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B556063A796
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Nov 2022 13:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiK1MA6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Nov 2022 07:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbiK1MAj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Nov 2022 07:00:39 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C4218B19;
        Mon, 28 Nov 2022 04:00:36 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NLPDf66jdz5BNS0;
        Mon, 28 Nov 2022 20:00:34 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl1.zte.com.cn with SMTP id 2ASC0QvF053505;
        Mon, 28 Nov 2022 20:00:26 +0800 (+08)
        (envelope-from zhang.songyi@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Mon, 28 Nov 2022 20:00:29 +0800 (CST)
Date:   Mon, 28 Nov 2022 20:00:29 +0800 (CST)
X-Zmail-TransId: 2afa6384a2ddffffffffcdf0581b
X-Mailer: Zmail v1.0
Message-ID: <202211282000293202417@zte.com.cn>
Mime-Version: 1.0
From:   <zhang.songyi@zte.com.cn>
To:     <yishaih@nvidia.com>
Cc:     <jgg@ziepe.ca>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <zhang.songyi@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIFJETUEvbWx4NDogcmVtb3ZlIE5VTEwgY2hlY2sgYmVmb3JlIGRldl97cHV0LCBob2xkfQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2ASC0QvF053505
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 6384A2E2.001 by FangMail milter!
X-FangMail-Envelope: 1669636834/4NLPDf66jdz5BNS0/6384A2E2.001/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<zhang.songyi@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6384A2E2.001/4NLPDf66jdz5BNS0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: zhang songyi <zhang.songyi@zte.com.cn>

The call netdev_{put, hold} of dev_{put, hold} will check NULL,
so there is no need to check before using dev_{put, hold}.

Fix the following coccicheck warnings:
/drivers/infiniband/hw/mlx4/main.c:1311:2-10: WARNING:
WARNING  NULL check before dev_{put, hold} functions is not needed.

/drivers/infiniband/hw/mlx4/main.c:148:2-10: WARNING:
WARNING  NULL check before dev_{put, hold} functions is not needed.

/drivers/infiniband/hw/mlx4/main.c:1959:3-11: WARNING:
WARNING  NULL check before dev_{put, hold} functions is not needed.

/drivers/infiniband/hw/mlx4/main.c:1962:3-10: WARNING:
WARNING  NULL check before dev_{put, hold} functions is not needed.

Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>
---
 drivers/infiniband/hw/mlx4/main.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index ba47874f90d3..dceebcd885bb 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -144,8 +144,7 @@ static struct net_device *mlx4_ib_get_netdev(struct ib_device *device,
                        }
                }
        }
-       if (dev)
-               dev_hold(dev);
+       dev_hold(dev);

        rcu_read_unlock();
        return dev;
@@ -1307,8 +1306,7 @@ int mlx4_ib_add_mc(struct mlx4_ib_dev *mdev, struct mlx4_ib_qp *mqp,

        spin_lock_bh(&mdev->iboe.lock);
        ndev = mdev->iboe.netdevs[mqp->port - 1];
-       if (ndev)
-               dev_hold(ndev);
+       dev_hold(ndev);
        spin_unlock_bh(&mdev->iboe.lock);

        if (ndev) {
@@ -1955,11 +1953,9 @@ static int mlx4_ib_mcg_detach(struct ib_qp *ibqp, union ib_gid *gid, u16 lid)
        if (ge) {
                spin_lock_bh(&mdev->iboe.lock);
                ndev = ge->added ? mdev->iboe.netdevs[ge->port - 1] : NULL;
-               if (ndev)
-                       dev_hold(ndev);
+               dev_hold(ndev);
                spin_unlock_bh(&mdev->iboe.lock);
-               if (ndev)
-                       dev_put(ndev);
+               dev_put(ndev);
                list_del(&ge->list);
                kfree(ge);
        } else
--
2.15.2
