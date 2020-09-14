Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19FAC2693DD
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Sep 2020 19:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgINRoM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Sep 2020 13:44:12 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:14880 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgINMGD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Sep 2020 08:06:03 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5f5b150000>; Mon, 14 Sep 2020 04:59:17 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 14 Sep 2020 05:00:03 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 14 Sep 2020 05:00:03 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 14 Sep
 2020 11:59:59 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 14 Sep 2020 11:59:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dldHjZZn+yrknV679wZLVEn5QlwqBSkbO5D6aus4W13ByAqHOPLp91Rg1mg6IWdA5tHKEneFcTIup9qEBppiSh76ztT7yBkc1jij51XHfLc6ah9zQN7gcm2BREloRrNjU37M67KTeqFuIuPHUcqbdlB2L8jFoIFbsBGx46IzHYhMuqX3bB1RMddYVobqy886MVqJF8C9FgVXETbbL2819X+6zNSJapogtm57VRoHkAjXGBbu8+Wwz+nDWNWJN8a9SV+9Zwzh4ncltrzhsxqkGXLEIX6rZNFLzBiqunqTM8axooxGLPMKTshEeWP/mJVwNpsOziF+y8RjAJDLmMFbLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9oUKi7YbUrXMA7IqGsLQq7PFdLcxvF1qgT3il2J3Jo=;
 b=K95SeMlRT9/2NKdZPsipIIfH1Sb2mLB+bwOr9QI/+aFmOrJ32EXRAAB7IFRSFSw79B/XTZgTs2KoYkkrjgWUpI0Q7v777DucLGl+KJoHYXCUDgAXWJ/NyxJK/LOBP9UMb1NaeqoLW4LZCh3v+bytnWK+eEaygvznzaHta/F/iGp3MOTnBJ3eBJPou06scZ0BM5tGo1MSuq/nZbmHDINR4Q4tIT0ZVKPfV9bDylxv7ikPQ5+WS9Ct47/8AHjCqbVii88acyRwBCu0emjyhgv6lG1/evmGZD6VPCxnZoG2Ij/lZmPq5MLRKXJlw+kbfoOdhdYQ7RxjBKMwvcHIP9OODg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: sina.com; dkim=none (message not signed)
 header.d=none;sina.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4267.namprd12.prod.outlook.com (2603:10b6:5:21e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 11:59:58 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 11:59:58 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Hillf Danton <hdanton@sina.com>, <linux-rdma@vger.kernel.org>
CC:     Sean Hefty <sean.hefty@intel.com>,
        <syzbot+cc6fc752b3819e082d0c@syzkaller.appspotmail.com>
Subject: [PATCH] RDMA/ucma: Rework ucma_migrate_id() to avoid races with destroy
Date:   Mon, 14 Sep 2020 08:59:56 -0300
Message-ID: <0-v1-05c5a4090305+3a872-ucma_syz_migrate_jgg@nvidia.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::21) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Mon, 14 Sep 2020 11:59:58 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kHn9I-005vWo-PF; Mon, 14 Sep 2020 08:59:56 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cd0307c-9e35-460f-2bd8-08d858a5b3d1
X-MS-TrafficTypeDiagnostic: DM6PR12MB4267:
X-Microsoft-Antispam-PRVS: <DM6PR12MB426714B7A161AA008E80DD6DC2230@DM6PR12MB4267.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VP8v79z//tRkinScVMxaACqwyjny0xv1y1iQCGU1eOH7VVZBgOTyh/+Fy4mkkvkoLub/rIq8t+F7kGKgtxxm33o+jwBRpeffcB2qLz9xnA345EPtwHpuGxdFGVyb7Xn2J0w02o3utg1JKtFamQ6TVlmQ/U4EfSRmL2gdqxAcIB3YUDKlpamIcxGt2qcU52FVfNnKTZ0+0T7gIcO35EelMqb8r1PAL1Fyfl8xbBhqNxDX/edp82SfvvSZFxIrAxcyEIwrK6sIg9SSItdTWgufnPZaIWGfTUptxQdU1KJSECrU9HdrYfYIMZCSWiDfmNzwFxDKqNLoC2euKtf/hYV28jThbCKVUeCby04227Xti4CPMtzAxrADnUpztNx50IKX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(478600001)(86362001)(5660300002)(66476007)(83380400001)(66946007)(66556008)(2906002)(316002)(26005)(9786002)(9746002)(186003)(36756003)(8936002)(2616005)(426003)(4326008)(8676002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: HnWcAuC+g9RwMfL6k8/mi182oGV9zO0phOvKE1Bd2AQ5JtliNqzOevOvExVN1H7s7ghXpGrZPhOzv1RErZz09EcezkvZkADJ7/+mgG9TW488SYp8G6KONuv2JuiN7oSujc27MaCga1TS8R3FiaYTQWROHzuMMX78sCzUAeY1shw2fae6aE5VRJIPTQvFCnUixN8ddsfUPFmUeZ7yqsui6N0rrsZ8e2cK1ODfxgDlxo7ekw7QKRDHXRNip0BeVPkwEKxk7Mq4H6fMuojwTs/aHEuT5IrMzKShgxZGd4svgb4EaNEtJB/wpXr2H5aPK2bcFTSqq7Kwn2LQDLPWPh5od4ILq3kz9tQJW2LMKiv1sKk+XLQ1hpAhDWay4yDhujAGcQyoHX2G+oTu0qN397XLJvbwr4EmumNSz6IenWiwiMu/jkmqW8p9hXP5W3Yw+ZneQXpNpvMed1LGb9lTsaQIL9bJ3S3HtkJ+I6aV38M0uXeHsTEJnvvrE7HWQMrWFpIDGqhvPincPZM9BQVuU4j1gQrZb786uQi0Te8MgRvYaKoUCYMmfy1NKyZRf8JKA2q1BqfpDsIopPta+ijqFoRfN0j5SZmIdaqYS8/ejhr3dayFedtecbpeUOjudthm8iExrRg40vLRLf6k41J7sV0V5Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd0307c-9e35-460f-2bd8-08d858a5b3d1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2020 11:59:58.3742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pbcuhU361pBne9Y3FaEwwThEuwxxyzSlh5/WkzfxF95ueeYfeTnoip3gmGXMfqJI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4267
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600084757; bh=ew+5WtIHcTr79qV3Se5mAVyzfcQnMSADGZxTba10cgg=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:From:To:CC:
         Subject:Date:Message-ID:Content-Transfer-Encoding:Content-Type:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=Xm/O5lvaisPmKXKN3ml3VLsqgqLIvzH6pdxRrfDseWQxvjQ6hbgVPF9vD6W9MIiNB
         PJZHLg6w1kXeappRNQfg9qx4l3oLfjPIxobAW9gK9F7RJU3Zzo2F2ps+bIJi2nSC5D
         y1gIJNFNPOXTI5ZCjiFVvMa7P/FLJhs0DfM3nGi03Bx8/EW2mRd4dOwUNL4I5TcWDy
         4PkMMyOqFE5UIfe22RD9/4uVlJTCNTY7TAkGtDqp7KR+56Vv9Za8gk62WeH0MbSJww
         rSudaHSvG/h3MuCY68W2H5CTMk8vCspmiRVGnISDb70bIrrP8mArGgAcKkurOxQSxB
         NxIHOiK0g/6UQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

ucma_destroy_id() assumes that all things accessing the ctx will do so via
the xarray. This assumption violated only in the case the FD is being
closed, then the ctx is reached via the ctx_list. Normally this is OK
since ucma_destroy_id() cannot run concurrenty with release(), however
with ucma_migrate_id() is involved this can violated as the close of the
2nd FD can run concurrently with destroy on the first:

                CPU0                      CPU1
        ucma_destroy_id(fda)
                                  ucma_migrate_id(fda -> fdb)
                                       ucma_get_ctx()
        xa_lock()
         _ucma_find_context()
         xa_erase()
        xa_unlock()
                                       xa_lock()
                                        ctx->file =3D new_file
                                        list_move()
                                       xa_unlock()
                                      ucma_put_ctx()

                                   ucma_close(fdb)
                                      _destroy_id()
                                      kfree(ctx)

        _destroy_id()
          wait_for_completion()
          // boom, ctx was freed

The ctx->file must be modified under the handler and xa_lock, and prior to
modification the ID must be rechecked that it is still reachable from
cur_file, ie there is no parallel destroy or migrate.

To make this work remove the double locking and streamline the control
flow. The double locking was obsoleted by the handler lock now directly
preventing new uevents from being created, and the ctx_list cannot be read
while holding fgets on both files. Removing the double locking also
removes the need to check for the same file.

Fixes: 88314e4dda1e ("RDMA/cma: add support for rdma_migrate_id()")
Reported-and-tested-by: syzbot+cc6fc752b3819e082d0c@syzkaller.appspotmail.c=
om
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/ucma.c | 79 +++++++++++++---------------------
 1 file changed, 29 insertions(+), 50 deletions(-)

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.=
c
index a5595bd489b089..b3a7dbb12f259e 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1587,45 +1587,15 @@ static ssize_t ucma_leave_multicast(struct ucma_fil=
e *file,
 	return ret;
 }
=20
-static void ucma_lock_files(struct ucma_file *file1, struct ucma_file *fil=
e2)
-{
-	/* Acquire mutex's based on pointer comparison to prevent deadlock. */
-	if (file1 < file2) {
-		mutex_lock(&file1->mut);
-		mutex_lock_nested(&file2->mut, SINGLE_DEPTH_NESTING);
-	} else {
-		mutex_lock(&file2->mut);
-		mutex_lock_nested(&file1->mut, SINGLE_DEPTH_NESTING);
-	}
-}
-
-static void ucma_unlock_files(struct ucma_file *file1, struct ucma_file *f=
ile2)
-{
-	if (file1 < file2) {
-		mutex_unlock(&file2->mut);
-		mutex_unlock(&file1->mut);
-	} else {
-		mutex_unlock(&file1->mut);
-		mutex_unlock(&file2->mut);
-	}
-}
-
-static void ucma_move_events(struct ucma_context *ctx, struct ucma_file *f=
ile)
-{
-	struct ucma_event *uevent, *tmp;
-
-	list_for_each_entry_safe(uevent, tmp, &ctx->file->event_list, list)
-		if (uevent->ctx =3D=3D ctx)
-			list_move_tail(&uevent->list, &file->event_list);
-}
-
 static ssize_t ucma_migrate_id(struct ucma_file *new_file,
 			       const char __user *inbuf,
 			       int in_len, int out_len)
 {
 	struct rdma_ucm_migrate_id cmd;
 	struct rdma_ucm_migrate_resp resp;
+	struct ucma_event *uevent, *tmp;
 	struct ucma_context *ctx;
+	LIST_HEAD(event_list);
 	struct fd f;
 	struct ucma_file *cur_file;
 	int ret =3D 0;
@@ -1641,43 +1611,52 @@ static ssize_t ucma_migrate_id(struct ucma_file *ne=
w_file,
 		ret =3D -EINVAL;
 		goto file_put;
 	}
+	cur_file =3D f.file->private_data;
=20
 	/* Validate current fd and prevent destruction of id. */
-	ctx =3D ucma_get_ctx(f.file->private_data, cmd.id);
+	ctx =3D ucma_get_ctx(cur_file, cmd.id);
 	if (IS_ERR(ctx)) {
 		ret =3D PTR_ERR(ctx);
 		goto file_put;
 	}
=20
 	rdma_lock_handler(ctx->cm_id);
-	cur_file =3D ctx->file;
-	if (cur_file =3D=3D new_file) {
-		mutex_lock(&cur_file->mut);
-		resp.events_reported =3D ctx->events_reported;
-		mutex_unlock(&cur_file->mut);
-		goto response;
-	}
-
 	/*
-	 * Migrate events between fd's, maintaining order, and avoiding new
-	 * events being added before existing events.
+	 * ctx->file can only be changed under the handler & xa_lock. xa_load()
+	 * must be checked again to ensure the ctx hasn't begun destruction
+	 * since the ucma_get_ctx().
 	 */
-	ucma_lock_files(cur_file, new_file);
 	xa_lock(&ctx_table);
-
-	list_move_tail(&ctx->list, &new_file->ctx_list);
-	ucma_move_events(ctx, new_file);
+	if (_ucma_find_context(cmd.id, cur_file) !=3D ctx) {
+		xa_unlock(&ctx_table);
+		ret =3D -ENOENT;
+		goto err_unlock;
+	}
 	ctx->file =3D new_file;
+	xa_unlock(&ctx_table);
+
+	mutex_lock(&cur_file->mut);
+	list_del(&ctx->list);
+	/*
+	 * At this point lock_handler() prevents addition of new uevents for
+	 * this ctx.
+	 */
+	list_for_each_entry_safe(uevent, tmp, &cur_file->event_list, list)
+		if (uevent->ctx =3D=3D ctx)
+			list_move_tail(&uevent->list, &event_list);
 	resp.events_reported =3D ctx->events_reported;
+	mutex_unlock(&cur_file->mut);
=20
-	xa_unlock(&ctx_table);
-	ucma_unlock_files(cur_file, new_file);
+	mutex_lock(&new_file->mut);
+	list_add_tail(&ctx->list, &new_file->ctx_list);
+	list_splice_tail(&event_list, &new_file->event_list);
+	mutex_unlock(&new_file->mut);
=20
-response:
 	if (copy_to_user(u64_to_user_ptr(cmd.response),
 			 &resp, sizeof(resp)))
 		ret =3D -EFAULT;
=20
+err_unlock:
 	rdma_unlock_handler(ctx->cm_id);
 	ucma_put_ctx(ctx);
 file_put:
--=20
2.28.0

