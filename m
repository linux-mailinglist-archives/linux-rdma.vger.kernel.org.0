Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1281450233
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Nov 2021 11:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbhKOKSW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 15 Nov 2021 05:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhKOKSS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 15 Nov 2021 05:18:18 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD82EC061746
        for <linux-rdma@vger.kernel.org>; Mon, 15 Nov 2021 02:15:21 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id c8so69106826ede.13
        for <linux-rdma@vger.kernel.org>; Mon, 15 Nov 2021 02:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LSi6uxn37Ano+lNSgRPuREDoZ6IBWVTS6IeDCvDs4Po=;
        b=dNfV78QZzDsqy1orOy+y3HZm8LTzRqgf31bda7yHD/qpr0thcJtTAFasdl/zL1uvo5
         XNShBypnO3woxIz92jm57qEmagu/JkcwfPyD4FygEPVhXE9jNhOgjPhJovXzJ5BOOoAC
         OcBvQe5SlOB6wNBo1CldFeJISYdQ9k8mTSGeFS44oVIifGQhE+fsR5+Aw0ukQ2z77LYi
         0EUQuSek62rGO7Q2Nbk8eFcPDnWolqmKmfgTbBaPpu5/aoe94mBKV6yy7urKiW4/ZfUV
         mO937jP22/Pq+AjsWy4qGiVK+iE+LlgDqD94wWZ21+2aaPidj/JqtVDOeX4gPI3cdFvH
         cdug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LSi6uxn37Ano+lNSgRPuREDoZ6IBWVTS6IeDCvDs4Po=;
        b=YdifmH9NcDAeA1EcZ9qO9IMSSLGYVcvf5JWI2X/BF+7Gk2s/bWl+pf9MBHARunsh0l
         kshfKIMublUM1iO80KkzPaHGba+lh24z9h5SUGiEFoI6+v/J5TUaCEdPlIKmMmEKUL7k
         wXRM6adJwQoG5XqD3fFThpT4C1HBz0H6DZ2wGOxrSd0EjlP9gv3LTRbeY+tjPzCTI+TH
         QMGZXDq0Ay7B9xbTdhvXiiobzvXDAhVnzFAWjqJhOyYtrXqhZWlKuPe8i67+Ar6gvWdc
         vrob68/UT2apiXSbiDSsF69Fh0HJO6BUE38S0Q6GSSbYKPdJknkdf6/BcPTcWGuGtkwR
         Vsww==
X-Gm-Message-State: AOAM531guZSITW3baNoxHWQdwhZduuslAtk8KKHw1FDWIGYWCnKA6L3a
        lvyZaYT6mWLO3hn/REOyCLeN3vW+bMQIlQ==
X-Google-Smtp-Source: ABdhPJzyzVsQHfNdW119TRxVKEFKhkx/nzhzsRgGqveD33UJkyDEJr2Th0oDDYMcvfX9qgIEoJl7Fg==
X-Received: by 2002:a17:907:1c15:: with SMTP id nc21mr47679115ejc.260.1636971320203;
        Mon, 15 Nov 2021 02:15:20 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box (200116b8451c4e009c29b4df471af528.dip.versatel-1u1.de. [2001:16b8:451c:4e00:9c29:b4df:471a:f528])
        by smtp.gmail.com with ESMTPSA id t16sm7455532edd.18.2021.11.15.02.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 02:15:19 -0800 (PST)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, yishaih@nvidia.com
Subject: [PATCH] RDMA/mlx4: Do not fail the registration on port stats
Date:   Mon, 15 Nov 2021 11:15:19 +0100
Message-Id: <20211115101519.27210-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

If the FW doesn't support MLX4_DEV_CAP_FLAG2_DIAG_PER_PORT,
mlx4 driver will fail the ib_setup_port_attrs, which is called
from ib_register_device/enable_device_and_get, in the end leads
to device not detected[1][2]

To fix it, add a new mlx4_ib_hw_stats_ops1, w/o alloc_hw_port_stats
if FW does not support MLX4_DEV_CAP_FLAG2_DIAG_PER_PORT.

[1] https://bugzilla.redhat.com/show_bug.cgi?id=2014094
[2] https://lore.kernel.org/linux-rdma/CAMGffEn2wvEnmzc0xe=xYiCLqpphiHDBxCxqAELrBofbUAMQxw@mail.gmail.com/T/#t

Fixes: 4b5f4d3fb408 ("RDMA: Split the alloc_hw_stats() ops to port and device variants")

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/hw/mlx4/main.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index f367f4a4abff..2ad9c6d12ac0 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -2217,6 +2217,12 @@ static const struct ib_device_ops mlx4_ib_hw_stats_ops = {
 	.get_hw_stats = mlx4_ib_get_hw_stats,
 };
 
+
+static const struct ib_device_ops mlx4_ib_hw_stats_ops1 = {
+	.alloc_hw_device_stats = mlx4_ib_alloc_hw_device_stats,
+	.get_hw_stats = mlx4_ib_get_hw_stats,
+};
+
 static int mlx4_ib_alloc_diag_counters(struct mlx4_ib_dev *ibdev)
 {
 	struct mlx4_ib_diag_counters *diag = ibdev->diag_counters;
@@ -2229,9 +2235,15 @@ static int mlx4_ib_alloc_diag_counters(struct mlx4_ib_dev *ibdev)
 		return 0;
 
 	for (i = 0; i < MLX4_DIAG_COUNTERS_TYPES; i++) {
-		/* i == 1 means we are building port counters */
-		if (i && !per_port)
-			continue;
+		/* i == 1 means we are building port counters, set a different
+		 * stats ops without port stats callback.
+		 */
+		if (i && !per_port) {
+			ib_set_device_ops(&ibdev->ib_dev,
+					  &mlx4_ib_hw_stats_ops1);
+
+			return 0;
+		}
 
 		ret = __mlx4_ib_alloc_diag_counters(ibdev, &diag[i].name,
 						    &diag[i].offset,
-- 
2.25.1

