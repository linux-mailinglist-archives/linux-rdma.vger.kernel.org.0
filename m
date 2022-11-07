Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E632361ED78
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Nov 2022 09:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbiKGIwK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Nov 2022 03:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbiKGIwJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Nov 2022 03:52:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54C415A3B
        for <linux-rdma@vger.kernel.org>; Mon,  7 Nov 2022 00:52:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 767BCB80E59
        for <linux-rdma@vger.kernel.org>; Mon,  7 Nov 2022 08:52:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFC6C433D6;
        Mon,  7 Nov 2022 08:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667811124;
        bh=hI2kiq55eyLX4FTWZwwM/e5+vhVaaBYWWPJ3Pc8iZWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=djbJmTBVXNj8mpEr2tWt4T7Yb5Szyug3oTCgFM9T53RVlvf4ajq7aJYLcqzHcsihE
         Em0AK/49+zLBYbTku6txyzCC4oXhjxqeO3xPeXKLrl+HVuPpbA0ev0Z49vboyaUIF+
         Hf2/jeqKDt/8QiLeQ03GvTuK6wpHMym688PzM1amwiq7XRGk6GSgk7UE/2XxmGwWW4
         rh8Il2FFEq0efdpIq/nusxHI+qGeQmq8TjGH2UEWi5iErdHSYqVYH/rwz9fFitQo+e
         tKa9Wuh+k7+hK1iV4A/nHFvaqta9zyqYIaEPV7n7VG0Adzz5hBtahxy5IksRlclfaZ
         XdfN3jsX+TmXw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Zhang <markzhang@nvidia.com>, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>,
        Or Har-Toov <ohartoov@nvidia.com>
Subject: [PATCH rdma-next 3/4] RDMA/core: Make sure "ib_port" is valid when access sysfs node
Date:   Mon,  7 Nov 2022 10:51:35 +0200
Message-Id: <88867e705c42c1cd2011e45201c25eecdb9fef94.1667810736.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1667810736.git.leonro@nvidia.com>
References: <cover.1667810736.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markzhang@nvidia.com>

The "ib_port" structure must be set before adding the sysfs kobject,
and reset after removing it, otherwise it may crash when accessing
the sysfs node:
  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000050
  Mem abort info:
    ESR = 0x96000006
    Exception class = DABT (current EL), IL = 32 bits
    SET = 0, FnV = 0
    EA = 0, S1PTW = 0
  Data abort info:
    ISV = 0, ISS = 0x00000006
    CM = 0, WnR = 0
  user pgtable: 4k pages, 48-bit VAs, pgdp = 00000000e85f5ba5
  [0000000000000050] pgd=0000000848fd9003, pud=000000085b387003, pmd=0000000000000000
  Internal error: Oops: 96000006 [#2] PREEMPT SMP
  Modules linked in: ib_umad(O) mlx5_ib(O) nfnetlink_cttimeout(E) nfnetlink(E) act_gact(E) cls_flower(E) sch_ingress(E) openvswitch(E) nsh(E) nf_nat_ipv6(E) nf_nat_ipv4(E) nf_conncount(E) nf_nat(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) mst_pciconf(O) ipmi_devintf(E) ipmi_msghandler(E) ipmb_dev_int(OE) mlx5_core(O) mlxfw(O) mlxdevm(O) auxiliary(O) ib_uverbs(O) ib_core(O) mlx_compat(O) psample(E) sbsa_gwdt(E) uio_pdrv_genirq(E) uio(E) mlxbf_pmc(OE) mlxbf_gige(OE) mlxbf_tmfifo(OE) gpio_mlxbf2(OE) pwr_mlxbf(OE) mlx_trio(OE) i2c_mlxbf(OE) mlx_bootctl(OE) bluefield_edac(OE) knem(O) ip_tables(E) ipv6(E) crc_ccitt(E) [last unloaded: mst_pci]
  Process grep (pid: 3372, stack limit = 0x0000000022055c92)
  CPU: 5 PID: 3372 Comm: grep Tainted: G      D    OE     4.19.161-mlnx.47.gadcd9e3 #1
  Hardware name: https://www.mellanox.com BlueField SoC/BlueField SoC, BIOS BlueField:3.9.2-15-ga2403ab Sep  8 2022
  pstate: 40000005 (nZcv daif -PAN -UAO)
  pc : hw_stat_port_show+0x4c/0x80 [ib_core]
  lr : port_attr_show+0x40/0x58 [ib_core]
  sp : ffff000029f43b50
  x29: ffff000029f43b50 x28: 0000000019375000
  x27: ffff8007b821a540 x26: ffff000029f43e30
  x25: 0000000000008000 x24: ffff000000eaa958
  x23: 0000000000001000 x22: ffff8007a4ce3000
  x21: ffff8007baff8000 x20: ffff8007b9066ac0
  x19: ffff8007bae97578 x18: 0000000000000000
  x17: 0000000000000000 x16: 0000000000000000
  x15: 0000000000000000 x14: 0000000000000000
  x13: 0000000000000000 x12: 0000000000000000
  x11: 0000000000000000 x10: 0000000000000000
  x9 : 0000000000000000 x8 : ffff8007a4ce4000
  x7 : 0000000000000000 x6 : 000000000000003f
  x5 : ffff000000e6a280 x4 : ffff8007a4ce3000
  x3 : 0000000000000000 x2 : aaaaaaaaaaaaaaab
  x1 : ffff8007b9066a10 x0 : ffff8007baff8000
  Call trace:
   hw_stat_port_show+0x4c/0x80 [ib_core]
   port_attr_show+0x40/0x58 [ib_core]
   sysfs_kf_seq_show+0x8c/0x150
   kernfs_seq_show+0x44/0x50
   seq_read+0x1b4/0x45c
   kernfs_fop_read+0x148/0x1d8
   __vfs_read+0x58/0x180
   vfs_read+0x94/0x154
   ksys_read+0x68/0xd8
   __arm64_sys_read+0x28/0x34
   el0_svc_common+0x88/0x18c
   el0_svc_handler+0x78/0x94
   el0_svc+0x8/0xe8
  Code: f2955562 aa1603e4 aa1503e0 f9405683 (f9402861)

Fixes: d8a5883814b9 ("RDMA/core: Replace the ib_port_data hw_stats pointers with a ib_port pointer")
Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/sysfs.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 84c53bd2a52d..ee59d7391568 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -1213,6 +1213,9 @@ static struct ib_port *setup_port(struct ib_core_device *coredev, int port_num,
 	p->port_num = port_num;
 	kobject_init(&p->kobj, &port_type);
 
+	if (device->port_data && is_full_dev)
+		device->port_data[port_num].sysfs = p;
+
 	cur_group = p->groups_list;
 	ret = alloc_port_table_group("gids", &p->groups[0], p->attrs_list,
 				     attr->gid_tbl_len, show_port_gid);
@@ -1258,9 +1261,6 @@ static struct ib_port *setup_port(struct ib_core_device *coredev, int port_num,
 	}
 
 	list_add_tail(&p->kobj.entry, &coredev->port_list);
-	if (device->port_data && is_full_dev)
-		device->port_data[port_num].sysfs = p;
-
 	return p;
 
 err_groups:
@@ -1268,6 +1268,8 @@ static struct ib_port *setup_port(struct ib_core_device *coredev, int port_num,
 err_del:
 	kobject_del(&p->kobj);
 err_put:
+	if (device->port_data && is_full_dev)
+		device->port_data[port_num].sysfs = NULL;
 	kobject_put(&p->kobj);
 	return ERR_PTR(ret);
 }
@@ -1276,14 +1278,17 @@ static void destroy_port(struct ib_core_device *coredev, struct ib_port *port)
 {
 	bool is_full_dev = &port->ibdev->coredev == coredev;
 
-	if (port->ibdev->port_data &&
-	    port->ibdev->port_data[port->port_num].sysfs == port)
-		port->ibdev->port_data[port->port_num].sysfs = NULL;
 	list_del(&port->kobj.entry);
 	if (is_full_dev)
 		sysfs_remove_groups(&port->kobj, port->ibdev->ops.port_groups);
+
 	sysfs_remove_groups(&port->kobj, port->groups_list);
 	kobject_del(&port->kobj);
+
+	if (port->ibdev->port_data &&
+	    port->ibdev->port_data[port->port_num].sysfs == port)
+		port->ibdev->port_data[port->port_num].sysfs = NULL;
+
 	kobject_put(&port->kobj);
 }
 
-- 
2.38.1

