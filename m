Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25AC4241CEA
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Aug 2020 17:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbgHKPGD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Aug 2020 11:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728850AbgHKPGC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Aug 2020 11:06:02 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0659FC06174A
        for <linux-rdma@vger.kernel.org>; Tue, 11 Aug 2020 08:06:02 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k20so3152480wmi.5
        for <linux-rdma@vger.kernel.org>; Tue, 11 Aug 2020 08:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EzVXNb2W/aEhwGeXeGneCc7euwWFA1/NXRdIU3n8lUc=;
        b=RPHvSnTaCG0/oj2Ix8nxD+JUS3s5bJCcHbDI5VtybKMvl3p9XNiCEsh7fgCVRNaCTM
         bOmUPitvG0n0xXV0NhVUZotDeZeN/zC22aa/8GL6yMbrASmTTmcBeT57kRBzbjUZuBGF
         Qe/KWXs5los3blNSRStY3sbjTUozZC1QwAYviT3Gw4cqAuwh2EgHnlRPKFwC13Y9mzhq
         EUodaNphNuP/TYTZDh+pD7s4YFNQEc8bX70RrnMBgh/HOwo0mdDJ9Cv4xS4ppkATVSTv
         3HxYCUcMkMPFEgDZ3TipWpxtROK//mrLenM5CIuo8KSx9hUtI7clOD7WwbSf/ddmH1QH
         dd2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EzVXNb2W/aEhwGeXeGneCc7euwWFA1/NXRdIU3n8lUc=;
        b=bfMmMC1PYlYHAabyYOQVPtRy4TsvXocORHpnGaLlPYW8rIFPylFucolLJgR1XQZP3I
         1pWBwkkbHL+NyhwEtSm9/8fHVY3/CC7YdVwOGpHyvOFCBeO2oY2CqRDlx7vsPZjSsnUd
         3z9Mb9K0Z+wXaqvSXeCPUqHZOwX7mkK6i5MEQ+pjX2tJIkT0SJLtQ/xlJhLCGZP0X3FH
         vZvcr3E5xg7rcRxXDmRKCdHJddH4m7yp3LXqf6XYN8tPSznSdmImRxNziEfduNXrieyu
         SPP5h9x0ymjvILJFosCixRF6D/46+YJux8DGWQ5NuxaaQSW9eIR6vPF26VM3IccifSdf
         KdvA==
X-Gm-Message-State: AOAM533Tl0fbGd8D+ah9EOa+B/I0TgmMO7JQPvWmuh/c2E+Ul1fVmAcl
        rCSzOcHDEM6TDCxXYlvTHESsZjEcTf9v
X-Google-Smtp-Source: ABdhPJzIxTxIIDFOlKgFvdCeYXT0VbVeTfV0MvSZuRz4rNEQuBqNmW+Magnq1AZeFmAatN69MFEAAQ==
X-Received: by 2002:a7b:c401:: with SMTP id k1mr4295449wmi.18.1597158360181;
        Tue, 11 Aug 2020 08:06:00 -0700 (PDT)
Received: from localhost.Home ([2a02:ed0:52b8:d200:a27:853c:38cb:3b83])
        by smtp.gmail.com with ESMTPSA id z8sm5439514wmf.10.2020.08.11.08.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 08:05:59 -0700 (PDT)
From:   Mohammad Heib <goody698@gmail.com>
To:     linux-rdma@vger.kernel.org, yanjunz@mellanox.com
Cc:     dledford@redhat.com, jgg@ziepe.ca, kamalheib1@gmail.com,
        leon@kernel.org, Mohammad Heib <goody698@gmail.com>
Subject: [PATCH] RDMA/rxe: prevent rxe creation on top of vlan interface
Date:   Tue, 11 Aug 2020 18:04:15 +0300
Message-Id: <20200811150415.3693-1-goody698@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Creating rxe device on top of vlan interface will create a non-functional device
that has an empty gids table and can't be used for rdma cm communication.

This is caused by the logic in enum_all_gids_of_dev_cb()/is_eth_port_of_netdev(),
which only considers networks connected to "upper devices" of the configured
network device, resulting in an empty set of gids for a vlan interface,
and attempts to connect via this rdma device fail in cm_init_av_for_response
because no gids can be resolved.

apparently, this behavior was implemented to fit the HW-RoCE devices that create
RoCE device per port, therefore RXE must behave the same like HW-RoCE devices
and create rxe device per real device only.

In order to communicate via a vlan interface, the user must use the gid index of
the vlan address instead of creating rxe over vlan.

Signed-off-by: Mohammad Heib <goody698@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.c       | 6 ++++++
 drivers/infiniband/sw/rxe/rxe_sysfs.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 5642eefb4ba1..d2076aa7a732 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -310,6 +310,12 @@ static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
 	struct rxe_dev *exists;
 	int err = 0;
 
+	if (is_vlan_dev(ndev)) {
+		pr_err("rxe creation allowed on top of a real device only\n");
+		err = -EPERM;
+		goto err;
+	}
+
 	exists = rxe_get_dev_from_net(ndev);
 	if (exists) {
 		ib_device_put(&exists->ib_dev);
diff --git a/drivers/infiniband/sw/rxe/rxe_sysfs.c b/drivers/infiniband/sw/rxe/rxe_sysfs.c
index ccda5f5a3bc0..0a083c3d900a 100644
--- a/drivers/infiniband/sw/rxe/rxe_sysfs.c
+++ b/drivers/infiniband/sw/rxe/rxe_sysfs.c
@@ -73,6 +73,12 @@ static int rxe_param_set_add(const char *val, const struct kernel_param *kp)
 		return -EINVAL;
 	}
 
+	if (is_vlan_dev(ndev)) {
+		pr_err("rxe creation allowed on top of a real device only\n");
+		err = -EPERM;
+		goto err;
+	}
+
 	exists = rxe_get_dev_from_net(ndev);
 	if (exists) {
 		ib_device_put(&exists->ib_dev);
-- 
2.26.2

