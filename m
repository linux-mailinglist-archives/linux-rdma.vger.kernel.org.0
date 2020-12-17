Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1972DD2E9
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Dec 2020 15:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbgLQOVW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Dec 2020 09:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbgLQOVU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Dec 2020 09:21:20 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B3EC0619D5
        for <linux-rdma@vger.kernel.org>; Thu, 17 Dec 2020 06:19:36 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id b9so13165962ejy.0
        for <linux-rdma@vger.kernel.org>; Thu, 17 Dec 2020 06:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZRNr7nlUEozad4LnhtqJsV5xxVNxa/4zZv9vQgfZxek=;
        b=EOm1E3k/fHhRNp6AmbQfjcTLEZjkikBV4iCKGSHdMSCEmZk0Hwk0Sauwe/6YziDTLD
         e4yWjVqCR/vSTv9+QohZmARiUqIiYPp1QE0fCyxI0279hmAdjOuEtkrBnrkW/EoeT13B
         4wvnfGYOeB/7BTnCn8SHOMn+u7Lvj194O5dwJldyP+Y0J3LtbDV6cR+iPKChKD7l4GW/
         bOHplG2S1tre3irTiek64o7icd70k+L0iA/5k7VFHDpNM+zCT0A9pdl0TSn7uObTE0Lq
         dpoYH5KQaiGcbwMTt1D3pUR27QG/ymJGYMux5C8kYXfn6KYe836tJRLQRaYtxpKT9UfY
         FuZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZRNr7nlUEozad4LnhtqJsV5xxVNxa/4zZv9vQgfZxek=;
        b=sZCNwEjFP3l0Vc6aYwTgPGQ2gO6u1HDSMjygYkHzEA2FwIovoWDgWpOEXUng/XN2xh
         XN0C7LJxwitq0c76o2JnUYS/hlLMQl3k03vqfO9GzxrPj5oVc4h24JAadBX+su18DYvo
         xlZ081OgIYuz3amgO4LWAeq5y7libVuCwDZFI3Nuku/A08EY5067B9WMU6yoBX4W+NsC
         EnClUDKNuP6BjRVFko1kzrI+TRTwpXCt8Igdmh3J9uDMARk7UyM+jkJYvyfYWmCY39Rk
         NC4XkZXOjZGjANul3o8foIPRalkAHZT3hearsRzCuRM55RgWf2/G5ZmPNV6z6E1S5xoq
         QkOw==
X-Gm-Message-State: AOAM530f2MV2o9Dq74UfB834SPDO8h7+bdc26wIAtNMMkxy9DUGnD/1R
        qC+bTu2vjt0mN/vq8IiZBOgW53eq/dHmBQ==
X-Google-Smtp-Source: ABdhPJwZj+XkgOmjP99XGOotuLKcuC/eiA1tyRtRVKmFSknI/W54fgGPNeO7HkC6adXZQ6KU7aeMHQ==
X-Received: by 2002:a17:906:7104:: with SMTP id x4mr36161709ejj.141.1608214774600;
        Thu, 17 Dec 2020 06:19:34 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4991:de00:e5a4:2f4d:99:ddc5])
        by smtp.gmail.com with ESMTPSA id b14sm18168969edu.3.2020.12.17.06.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 06:19:34 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: [PATCHv2 for-next 19/19] RDMA/rtrs: Fix KASAN: stack-out-of-bounds bug
Date:   Thu, 17 Dec 2020 15:19:15 +0100
Message-Id: <20201217141915.56989-20-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201217141915.56989-1-jinpu.wang@cloud.ionos.com>
References: <20201217141915.56989-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When KASAN is enabled, we notice warning below:
[  483.436975] ==================================================================
[  483.437234] BUG: KASAN: stack-out-of-bounds in _mlx5_ib_post_send+0x188a/0x2560 [mlx5_ib]
[  483.437430] Read of size 4 at addr ffff88a195fd7d30 by task kworker/1:3/6954

[  483.437731] CPU: 1 PID: 6954 Comm: kworker/1:3 Kdump: loaded Tainted: G           O      5.4.82-pserver #5.4.82-1+feature+linux+5.4.y+dbg+20201210.1532+987e7a6~deb10
[  483.437976] Hardware name: Supermicro Super Server/X11DDW-L, BIOS 3.3 02/21/2020
[  483.438168] Workqueue: rtrs_server_wq hb_work [rtrs_core]
[  483.438323] Call Trace:
[  483.438486]  dump_stack+0x96/0xe0
[  483.438646]  ? _mlx5_ib_post_send+0x188a/0x2560 [mlx5_ib]
[  483.438802]  print_address_description.constprop.6+0x1b/0x220
[  483.438966]  ? _mlx5_ib_post_send+0x188a/0x2560 [mlx5_ib]
[  483.439133]  ? _mlx5_ib_post_send+0x188a/0x2560 [mlx5_ib]
[  483.439285]  __kasan_report.cold.9+0x1a/0x32
[  483.439444]  ? _mlx5_ib_post_send+0x188a/0x2560 [mlx5_ib]
[  483.439597]  kasan_report+0x10/0x20
[  483.439752]  _mlx5_ib_post_send+0x188a/0x2560 [mlx5_ib]
[  483.439910]  ? update_sd_lb_stats+0xfb1/0xfc0
[  483.440073]  ? set_reg_wr+0x520/0x520 [mlx5_ib]
[  483.440222]  ? update_group_capacity+0x340/0x340
[  483.440377]  ? find_busiest_group+0x314/0x870
[  483.440526]  ? update_sd_lb_stats+0xfc0/0xfc0
[  483.440683]  ? __bitmap_and+0x6f/0x100
[  483.440832]  ? __lock_acquire+0xa2/0x2150
[  483.440979]  ? __lock_acquire+0xa2/0x2150
[  483.441128]  ? __lock_acquire+0xa2/0x2150
[  483.441279]  ? debug_lockdep_rcu_enabled+0x23/0x60
[  483.441430]  ? lock_downgrade+0x390/0x390
[  483.441582]  ? __lock_acquire+0xa2/0x2150
[  483.441729]  ? __lock_acquire+0xa2/0x2150
[  483.441876]  ? newidle_balance+0x425/0x8f0
[  483.442024]  ? __lock_acquire+0xa2/0x2150
[  483.442172]  ? debug_lockdep_rcu_enabled+0x23/0x60
[  483.442330]  hb_work+0x15d/0x1d0 [rtrs_core]
[  483.442479]  ? schedule_hb+0x50/0x50 [rtrs_core]
[  483.442627]  ? lock_downgrade+0x390/0x390
[  483.442781]  ? process_one_work+0x40d/0xa50
[  483.442931]  process_one_work+0x4ee/0xa50
[  483.443082]  ? pwq_dec_nr_in_flight+0x110/0x110
[  483.443231]  ? do_raw_spin_lock+0x119/0x1d0
[  483.443383]  worker_thread+0x65/0x5c0
[  483.443532]  ? process_one_work+0xa50/0xa50
[  483.451839]  kthread+0x1e2/0x200
[  483.451983]  ? kthread_create_on_node+0xc0/0xc0
[  483.452139]  ret_from_fork+0x3a/0x50

The problem is we use wrong type when send wr, hw driver expect the type
of IB_WR_RDMA_WRITE_WITH_IMM wr should be ib_rdma_wr, and doing
container_of to access member. The fix is simple use ib_rdma_wr instread
of ib_send_wr.

Fixes: c0894b3ea69d ("RDMA/rtrs: core: lib functions shared between client and server modules")
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
index 97af8f0bb806..d13aff0aa816 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs.c
@@ -182,16 +182,16 @@ int rtrs_post_rdma_write_imm_empty(struct rtrs_con *con, struct ib_cqe *cqe,
 				    u32 imm_data, enum ib_send_flags flags,
 				    struct ib_send_wr *head)
 {
-	struct ib_send_wr wr;
+	struct ib_rdma_wr wr;
 
-	wr = (struct ib_send_wr) {
-		.wr_cqe	= cqe,
-		.send_flags	= flags,
-		.opcode	= IB_WR_RDMA_WRITE_WITH_IMM,
-		.ex.imm_data	= cpu_to_be32(imm_data),
+	wr = (struct ib_rdma_wr) {
+		.wr.wr_cqe	= cqe,
+		.wr.send_flags	= flags,
+		.wr.opcode	= IB_WR_RDMA_WRITE_WITH_IMM,
+		.wr.ex.imm_data	= cpu_to_be32(imm_data),
 	};
 
-	return rtrs_post_send(con->qp, head, &wr);
+	return rtrs_post_send(con->qp, head, &wr.wr);
 }
 EXPORT_SYMBOL_GPL(rtrs_post_rdma_write_imm_empty);
 
-- 
2.25.1

