Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800845FFA60
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Oct 2022 15:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiJONx5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Oct 2022 09:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiJONx4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 15 Oct 2022 09:53:56 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AFB52FD1
        for <linux-rdma@vger.kernel.org>; Sat, 15 Oct 2022 06:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665842034; x=1697378034;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qPTbasVP50W404x37JNM0Jxss6YQkhFFHJC9kcAopDY=;
  b=GddG/4dQOZq8qakEAjPlwO04kvSjuBkJiTprl6yS8qtmGxgDvFmfysD1
   ZcZwCAQhRPaHd2j4GeEHLI82WsydUCznafU+t5QhOmnzN3QEGB6QtQj8j
   m62D5Tgx2Wje5R29SYAerOilHmhI6aTH8J0oKK7vl078au56drbn1lOq2
   MUOG0GIIv44n5nSZwe7LTsrUsdYJUch4LJ7JaLe9SHNHSdm13Wnbg7vN0
   ygGDyF8/KbSrX4Lyk4mk4m7J52kqjfapSe0iDEMmNHJh0R12C9aww67zm
   ACAPM8OtryMwtzmMBTz1KTS/JXDp1Nay9n5FlkHRWm/7wd3kOOZZR76rO
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10501"; a="285274909"
X-IronPort-AV: E=Sophos;i="5.95,187,1661842800"; 
   d="scan'208";a="285274909"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2022 06:53:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10501"; a="627855370"
X-IronPort-AV: E=Sophos;i="5.95,187,1661842800"; 
   d="scan'208";a="627855370"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga002.jf.intel.com with ESMTP; 15 Oct 2022 06:53:52 -0700
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     leon@kernel.org, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        yanjun.zhu@linux.dev, yanjun.zhu@intel.com
Subject: [PATCH 1/1] RDMA/mlx5: Make mlx5 device work with ib_device_get_by_netdev
Date:   Sun, 16 Oct 2022 02:19:25 -0400
Message-Id: <20221016061925.1831180-1-yanjun.zhu@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

Before mlx5 ib device is registered, the function ib_device_set_netdev
is not called to map the mlx5 ib device with the related net device.

As such, when the function ib_device_get_by_netdev is called to get ib
device, NULL is returned.

Other ib devices, such as irdma, rxe and so on, the function
ib_device_get_by_netdev can get ib device from the related net device.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/hw/mlx5/main.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 883d7c60143e..6899c3f73509 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -168,6 +168,7 @@ static int mlx5_netdev_event(struct notifier_block *this,
 	u32 port_num = roce->native_port_num;
 	struct mlx5_core_dev *mdev;
 	struct mlx5_ib_dev *ibdev;
+	int ret = 0;
 
 	ibdev = roce->dev;
 	mdev = mlx5_ib_get_native_port_mdev(ibdev, port_num, NULL);
@@ -183,6 +184,14 @@ static int mlx5_netdev_event(struct notifier_block *this,
 		if (ndev->dev.parent == mdev->device)
 			roce->netdev = ndev;
 		write_unlock(&roce->netdev_lock);
+		if (ndev->dev.parent == mdev->device) {
+			ret = ib_device_set_netdev(&ibdev->ib_dev, ndev, port_num);
+			if (ret) {
+				pr_warn("func: %s, error: %d\n", __func__, ret);
+				goto done;
+			}
+		}
+
 		break;
 
 	case NETDEV_UNREGISTER:
@@ -191,6 +200,15 @@ static int mlx5_netdev_event(struct notifier_block *this,
 		if (roce->netdev == ndev)
 			roce->netdev = NULL;
 		write_unlock(&roce->netdev_lock);
+
+		if (roce->netdev == ndev) {
+			ret = ib_device_set_netdev(&ibdev->ib_dev, NULL, port_num);
+			if (ret) {
+				pr_warn("func: %s, error: %d\n", __func__, ret);
+				goto done;
+			}
+		}
+
 		break;
 
 	case NETDEV_CHANGE:
-- 
2.27.0

