Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795387D4ED1
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Oct 2023 13:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjJXLbe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Oct 2023 07:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjJXLbd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Oct 2023 07:31:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649E9D68;
        Tue, 24 Oct 2023 04:31:31 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39O5v5AY024473;
        Tue, 24 Oct 2023 11:31:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-03-30;
 bh=JwA7XcXSD2yS62gJP3iWjIAz0aeYK65uWUKUg66LfJE=;
 b=n+JSHMSnMFTC8AOmkPML2JVeZlehBLkIEfVQ6pZT9wN/eSQUiHvv6/p8jhR+ubjLN7nq
 kraFjEf64ZZ9P9T/1kEReDgNXO0YuAl4IeDOhwv/NmvbcPoZpCXBBKmeQbDEkr/6+F11
 Yw55em/e1jAI14TqqhOyLB7hfWHXgGeHE4pIJAUuXCSEVIL2ZkwvrL0UE1BRn9699VrS
 C4jRXnMCW9/Cinn0iZp9lc4/vyQJwEXtOls/novfRXDGw/bKDr4anPUXk7V+0jh//W2H
 mzk93++KSeIEetN0UGszWqxEolW5DJL/PiyYhXdyrGvanGQtQjZfgkNCH+rQXH8G9/R3 ow== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv6pcw8k2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Oct 2023 11:31:26 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39OAUGQv001460;
        Tue, 24 Oct 2023 11:31:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tv53bmpuh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Oct 2023 11:31:25 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39OBVPO3027370;
        Tue, 24 Oct 2023 11:31:25 GMT
Received: from gkennedy-linux.us.oracle.com (gkennedy-linux.us.oracle.com [10.152.170.45])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3tv53bmpu2-1;
        Tue, 24 Oct 2023 11:31:25 +0000
From:   George Kennedy <george.kennedy@oracle.com>
To:     leon@kernel.org, jgg@ziepe.ca, sd@queasysnail.net,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     george.kennedy@oracle.com, tom.hromatka@oracle.com,
        harshit.m.mogalapalli@oracle.com
Subject: [PATCH] mlx5: reset state to avoid attempted QP double free and UAF
Date:   Tue, 24 Oct 2023 06:30:05 -0500
Message-Id: <1698147005-5396-1-git-send-email-george.kennedy@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_11,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310240097
X-Proofpoint-GUID: 0SfTIXhGcEMQrZftR7nvqSsPcRabn2OK
X-Proofpoint-ORIG-GUID: 0SfTIXhGcEMQrZftR7nvqSsPcRabn2OK
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In the unlikely event that workqueue allocation fails and returns
NULL in mlx5_mkey_cache_init(), reset the state to
MLX5_UMR_STATE_UNINIT in mlx5_ib_stage_post_ib_reg_umr_init()
after the call to mlx5r_umr_resource_cleanup(), which frees
the QP. This will avoid attempted double free of the same QP
when __mlx5_ib_add() does its cleanup.

Syzkaller reported a UAF in ib_destroy_qp_user

workqueue: Failed to create a rescuer kthread for wq "mkey_cache": -EINTR
infiniband mlx5_0: mlx5_mkey_cache_init:981:(pid 1642):
    failed to create work queue
infiniband mlx5_0: mlx5_ib_stage_post_ib_reg_umr_init:4075:(pid 1642):
    mr cache init failed -12
==================================================================
BUG: KASAN: slab-use-after-free in ib_destroy_qp_user (drivers/infiniband/core/verbs.c:2073)
Read of size 8 at addr ffff88810da310a8 by task repro_upstream/1642

Call Trace:
 <TASK>
kasan_report (mm/kasan/report.c:590)
ib_destroy_qp_user (drivers/infiniband/core/verbs.c:2073)
mlx5r_umr_resource_cleanup (drivers/infiniband/hw/mlx5/umr.c:198)
__mlx5_ib_add (drivers/infiniband/hw/mlx5/main.c:4178)
mlx5r_probe (drivers/infiniband/hw/mlx5/main.c:4402)
...
 </TASK>

Allocated by task 1642:
__kmalloc (./include/linux/kasan.h:198 mm/slab_common.c:1026
    mm/slab_common.c:1039)
create_qp (./include/linux/slab.h:603 ./include/linux/slab.h:720
    ./include/rdma/ib_verbs.h:2795 drivers/infiniband/core/verbs.c:1209)
ib_create_qp_kernel (drivers/infiniband/core/verbs.c:1347)
mlx5r_umr_resource_init (drivers/infiniband/hw/mlx5/umr.c:164)
mlx5_ib_stage_post_ib_reg_umr_init (drivers/infiniband/hw/mlx5/main.c:4070)
__mlx5_ib_add (drivers/infiniband/hw/mlx5/main.c:4168)
mlx5r_probe (drivers/infiniband/hw/mlx5/main.c:4402)
...

Freed by task 1642:
__kmem_cache_free (mm/slub.c:1826 mm/slub.c:3809 mm/slub.c:3822)
ib_destroy_qp_user (drivers/infiniband/core/verbs.c:2112)
mlx5r_umr_resource_cleanup (drivers/infiniband/hw/mlx5/umr.c:198)
mlx5_ib_stage_post_ib_reg_umr_init (drivers/infiniband/hw/mlx5/main.c:4076
    drivers/infiniband/hw/mlx5/main.c:4065)
__mlx5_ib_add (drivers/infiniband/hw/mlx5/main.c:4168)
mlx5r_probe (drivers/infiniband/hw/mlx5/main.c:4402)
...

The buggy address belongs to the object at ffff88810da31000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 168 bytes inside of
 freed 2048-byte region [ffff88810da31000, ffff88810da31800)

The buggy address belongs to the physical page:
page:000000003b5e469d refcount:1 mapcount:0 mapping:0000000000000000
    index:0x0 pfn:0x10da30
head:000000003b5e469d order:3 entire_mapcount:0 nr_pages_mapped:0
    pincount:0
flags: 0x17ffffc0000840(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
page_type: 0xffffffff()
raw: 0017ffffc0000840 ffff888100042f00 ffffea0004180800 dead000000000002
raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88810da30f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88810da31000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88810da31080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff88810da31100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88810da31180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
Disabling lock debugging due to kernel taint

Fixes: 04876c12c19e ("RDMA/mlx5: Move init and cleanup of UMR to umr.c")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: George Kennedy <george.kennedy@oracle.com>
---
 drivers/infiniband/hw/mlx5/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 555629b7..eca8c1c 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4074,6 +4074,7 @@ static int mlx5_ib_stage_post_ib_reg_umr_init(struct mlx5_ib_dev *dev)
 	if (ret) {
 		mlx5_ib_warn(dev, "mr cache init failed %d\n", ret);
 		mlx5r_umr_resource_cleanup(dev);
+		dev->umrc.state = MLX5_UMR_STATE_UNINIT;
 	}
 	return ret;
 }
-- 
1.8.3.1

