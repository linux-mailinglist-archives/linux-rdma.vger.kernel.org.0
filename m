Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A481840E9EE
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Sep 2021 20:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346945AbhIPSgU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Sep 2021 14:36:20 -0400
Received: from mail-dm6nam08on2057.outbound.protection.outlook.com ([40.107.102.57]:13729
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346954AbhIPSgL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Sep 2021 14:36:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OF5dB+tha2Cf2/4mkp11Tih1WNpueBJG8b+z6iWLdw2YZm3eVUP90O8pwy4N35VUNiSzWBExD3iLALsqnX4hPnqr1xnn8J9TCnXP3JmMo2bdOSSX++RFg2IoqTxg/s7pWAs9izC2J/JJzUmsJlgZ4kJBaiEc7ONKm6c+fYIfwQ5wKHFVBzNkyTow+8PrAW0FV5a4AtNOFNK3iRB7q5NhdcPYZ7TbbtyodcwAvhLCZiQCcKohHOPLyWSOLyolTKHMTXxXBd36PgzGCwqPSAl1IGBRvJDdzRkoxCxgkrfVPks8hFuLoZyCuha1oT/a3+WyXmKuYUYUrxyIdOt40JWG2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=4PyNaWIvbBE5WhLcrY2ZbdHVrvKPZDNbdFnEdIEw5NY=;
 b=VKwpLcSSu85fjJ6vJL9jdGn0/3x/syDku5mbD8IixaRRCMDawForbNJVdV7cID/sHSdzeuiNxFzebuynk88BjZwk7peXDasrncDq7UG6NBBLp+EqNXYhpBPY8NsNqzxLcynkbyZov/K+OD/6/uG972CX5lSEl0zLP3t+XA9hYWzJ4Zs9yeHhnFmubwb+8knjv92w/fGYb+NQPdN4ET/LSJf48SjQtqmz4NDvtdGmm2NYsMcSFXpGUuHpy+boOic1l2Ywv99UiWhYe30/w3Gi4tDSb4GUTvbkPOO5cXKG8JpQc0XraH74+innr9l9zhaYCVVkKCZZZWE5UyfL1h2qsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PyNaWIvbBE5WhLcrY2ZbdHVrvKPZDNbdFnEdIEw5NY=;
 b=DGHpewqiw7ZBuSWT6S1qLoQO2sCx/+HJQSYQS3xlJ8cGWTZxdFcEOKBefomXUaY7XDpBsyDAna3CzKlqOyCs8KKAw7zK14RMxcMyLkBzPbX8y53v0WtMCt9F9qYAmnq8a9pzbLdPlEDLYQ8triim9F9bA/J2fUvZl+/djRx+hw25m6UuBeVhKkNwO1YCK5Sx6QnjVWP98BgoUEerpcVYD49LIFcbJ0dsU7103o6Y3Du+F8zA8t7pVJS48Yw803gCa4rNmWH1lC3GLEBxSDpmJdThS70MIp9gsv4W87/zv0aK+3ryIKu49Dg/YDAKVZ4qeKMHZmL129Wc0CNBNEivrw==
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5333.namprd12.prod.outlook.com (2603:10b6:208:31f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 18:34:49 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 18:34:49 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dmitry Vyukov <dvyukov@google.com>, linux-rdma@vger.kernel.org
Cc:     syzbot+dc3dfba010d7671e05f5@syzkaller.appspotmail.com
Subject: [PATCH rc] RDMA/cma: Ensure rdma_addr_cancel() happens before issuing more requests
Date:   Thu, 16 Sep 2021 15:34:46 -0300
Message-Id: <0-v1-3bc675b8006d+22-syz_cancel_uaf_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0338.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::13) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by SJ0PR03CA0338.namprd03.prod.outlook.com (2603:10b6:a03:39c::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 18:34:49 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mQwDe-001qox-2R; Thu, 16 Sep 2021 15:34:46 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dad6a149-e4ac-4046-3ca9-08d97940aa65
X-MS-TrafficTypeDiagnostic: BL1PR12MB5333:
X-Microsoft-Antispam-PRVS: <BL1PR12MB533316853E64BEFD17E170AAC2DC9@BL1PR12MB5333.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TpHYpW6pOlMitbX4fJjSbItc0fPEh0oT7qRudSfWdiecFijJePfCT1g7r1/eVUUreJhn3XDqPH4MmHY1P592QRaM5PbaVPBuPIcMsHNNpmD+9LgJ3I1LN8UYxRx9bm5sDOuSHcVHBLWSm8FIF8m5bePx1GQe6nPoaIRQzXwpIyMUjeR94ubYNtDmatl57oO/dBJCS4NZMRf0WJzpn5PBINQGvGSqH5sKyb96jHC8RnhFGvmB6reNS1HQTdyP1fH3nheV4NSasx0exP08FxpaCCvg+kZogbUljuaVounyfWQoncCJhFYwbkgzl3uMo1z93jbBOlUekVu+7v0eGHU810ErvDlxTyKXXj7wFiEuMtbaa4wyzjbf55JUeZB/SH/0mn5iZyZHqBKwTiRg+jFaD+p4okuzTFO0JBNiTlDD13hT5Y8bLRH2JZsj/OFGdC1jlUfjPaje6YeHT8lnwwhBdI+qAzeuXRA9OmB764Ku8RPl9ji+OU6lorP6Vi5ndM40n7M7jtJO5CYzlbyLTHIa8H+n0bBXz8LtAKorgknzF9R6mhPNfYYwPWH92XsJEoyglcon0OTYRM3tJENM9KfqZXclqIudwgyJ6pvQcvBWdlbvc4194BSDKoH16E/qXFCZfV9LogDjlUWM3LTaawv3FX+U4UTwoXdnPPAYceNOVkgA1gYPZSBdWJgxZlnwr8B1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(5660300002)(8936002)(186003)(38100700002)(4326008)(86362001)(26005)(478600001)(83380400001)(426003)(2906002)(66476007)(8676002)(66556008)(36756003)(316002)(9746002)(9786002)(66946007)(2616005)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AYBIj0lLqTGE6xg8Zcc/icj2rUrINVkLhOPK4z0cksNO5OYT14dK7/mNPtqr?=
 =?us-ascii?Q?HEH8zBqP11r3IKPVKFS6++xnM4O0a1cPfyKFcWQvXz4tM89qdipnz0mNG+d9?=
 =?us-ascii?Q?DCaIBJ5W2um7AQu8wE3ILQoaBI/+PHnHr1zJ5jJjdIKUBcbxRGJW0XGRL+9I?=
 =?us-ascii?Q?e0ZIsLQksFR2SdWQ+SsfYa0iSUSUPjSrFJtrYranINn5n+Wv6OGgtlFwPBHB?=
 =?us-ascii?Q?66mbwp+4lB0+2ga8IE2U9LDY0eesWFwaFfeRvQpnq3DlUlSBGb+CG42/6VVj?=
 =?us-ascii?Q?Z7Ic8Fp+2JKWY+sogERD5KmLqnYaCV+O3tMXjSDOP8iALa01Vn61XEIml139?=
 =?us-ascii?Q?CTTmJ00TgLwMi0Eedqr+/TEnO+ad1tolAuPGWFqtQVR4jmcg10u/vbrQiyyU?=
 =?us-ascii?Q?sv+YrP1BsaanT53UHTlczm1VTlHvirdQHG0PHjYAw4TUiT2gDICWQPPwyAeL?=
 =?us-ascii?Q?47pfZvmLdlnL1BLmiu7kWwKko9Y0JRF51Wc0CKRgDmr1BWE/PoEhP1wBdEZk?=
 =?us-ascii?Q?9K6IYSNA1//ocCKBoKeLh3c/m5i1eK+qczr339QggG2Q+eJnDbl9BBk+bFqM?=
 =?us-ascii?Q?AUZ4ymW3dQMnelXvw34TN7v2otFeIyYY3hJ6wFmcwB3QhoaPiGeZRC/vGbiG?=
 =?us-ascii?Q?67lj9ysfTWKhM+RBEsPHUpg9l6i30JC9tlgOZxuKBFQtxuYC/GvUowZIFy5y?=
 =?us-ascii?Q?imOQUzDBaJ0Co8ZM2mbw3Ngl5VQd5BJRkRyDqa+ixG23xrkLw2xjIj+2tZs9?=
 =?us-ascii?Q?mAG01yVfdSG63cm5prv2JSgLfkFsShiZFhL+TNpYuHl7NPLN/qtIr1OBQMi4?=
 =?us-ascii?Q?IubtxkL07lEJQYRcMbp973X+6RI2rcRgr0eqc4InXgYi5WHak1KBOqpL9hhS?=
 =?us-ascii?Q?5/83Jcd5hlxf1TbBFx5me+ft4ZHGbKlrZfX3IR4njtAjKZSrqbKRYtp1JqkQ?=
 =?us-ascii?Q?0sob0SHGFJLxA3OaQPJqxKmdImmXRnbfz13KG8O6CfFPe643unlckCq282Lc?=
 =?us-ascii?Q?lQ/xPJW2K+n8YoQpOvxhOpjMNhZoj4YMugJXSjd2DUEs/Nx5URUeY23vYFoN?=
 =?us-ascii?Q?iZ6fdajrW9nlKpmZnrnAf+PYwRkaaU1gA7fL7EX0bbetRB0Brl0xC4o3UBlg?=
 =?us-ascii?Q?4kdB2FMqPzGtvKUO9pbq1pjOdVl6iSD/6GtLlVUTBJAAzruJAPlRAn1eH0tP?=
 =?us-ascii?Q?kvjMvBWl54nDtE3pJIoNor50/Qb7WMABVP//DBpGmNFW3/jHLX8+I8wpnJFk?=
 =?us-ascii?Q?OxOSBtjguQi2TU5ocZKBvKLEg5o6Y1zZTrL6caN8p7F0/dRVlfPrvzdWBSWW?=
 =?us-ascii?Q?FhltiYebztk85+C77nQ2sKxM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dad6a149-e4ac-4046-3ca9-08d97940aa65
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 18:34:49.3952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dP4v06CKqySog38pMdGGGvf6KLn4jx8xMR+pdiNOoYFtkVWFrNSrravCy8p9um6m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5333
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The FSM can run in a circle allowing rdma_resolve_ip() to be called twice
on the same id_priv. While this cannot happen without going through the
work, it violates the invariant that the same address resolution
background request cannot be active twice.

       CPU 1                                  CPU 2

rdma_resolve_addr():
  RDMA_CM_IDLE -> RDMA_CM_ADDR_QUERY
  rdma_resolve_ip(addr_handler)  #1

			 process_one_req(): for #1
                          addr_handler():
                            RDMA_CM_ADDR_QUERY -> RDMA_CM_ADDR_BOUND
                            mutex_unlock(&id_priv->handler_mutex);
                            [.. handler still running ..]

rdma_resolve_addr():
  RDMA_CM_ADDR_BOUND -> RDMA_CM_ADDR_QUERY
  rdma_resolve_ip(addr_handler)
    !! two requests are now on the req_list

rdma_destroy_id():
 destroy_id_handler_unlock():
  _destroy_id():
   cma_cancel_operation():
    rdma_addr_cancel()

                          // process_one_req() self removes it
		          spin_lock_bh(&lock);
                           cancel_delayed_work(&req->work);
	                   if (!list_empty(&req->list)) == true

      ! rdma_addr_cancel() returns after process_on_req #1 is done

   kfree(id_priv)

			 process_one_req(): for #2
                          addr_handler():
	                    mutex_lock(&id_priv->handler_mutex);
                            !! Use after free on id_priv

rdma_addr_cancel() expects there to be one req on the list and only
cancels the first one. The self-removal behavior of the work only happens
after the handler has returned. This yields a situations where the
req_list can have two reqs for the same "handle" but rdma_addr_cancel()
only cancels the first one.

The second req remains active beyond rdma_destroy_id() and will
use-after-free id_priv once it inevitably triggers.

Fix this by remembering if the id_priv has called rdma_resolve_ip() and
always cancel before calling it again. This ensures the req_list never
gets more than one item in it and doesn't cost anything in the normal flow
that never uses this strange error path.

Cc: stable@vger.kernel.org
Fixes: e51060f08a61 ("IB: IP address based RDMA connection manager")
Reported-by: syzbot+dc3dfba010d7671e05f5@syzkaller.appspotmail.com
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/cma.c      | 17 +++++++++++++++++
 drivers/infiniband/core/cma_priv.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index c40791baced588..751cf5ea25f296 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -1776,6 +1776,14 @@ static void cma_cancel_operation(struct rdma_id_private *id_priv,
 {
 	switch (state) {
 	case RDMA_CM_ADDR_QUERY:
+		/*
+		 * We can avoid doing the rdma_addr_cancel() based on state,
+		 * only RDMA_CM_ADDR_QUERY has a work that could still execute.
+		 * Notice that the addr_handler work could still be exiting
+		 * outside this state, however due to the interaction with the
+		 * handler_mutex the work is guaranteed not to touch id_priv
+		 * during exit.
+		 */
 		rdma_addr_cancel(&id_priv->id.route.addr.dev_addr);
 		break;
 	case RDMA_CM_ROUTE_QUERY:
@@ -3413,6 +3421,15 @@ int rdma_resolve_addr(struct rdma_cm_id *id, struct sockaddr *src_addr,
 		if (dst_addr->sa_family == AF_IB) {
 			ret = cma_resolve_ib_addr(id_priv);
 		} else {
+			/* The FSM can return back to RDMA_CM_ADDR_BOUND after
+			 * rdma_resolve_ip() is called, eg through the error
+			 * path in addr_handler. If this happens the existing
+			 * request must be canceled before issuing a new one.
+			 */
+			if (id_priv->used_resolve_ip)
+				rdma_addr_cancel(&id->route.addr.dev_addr);
+			else
+				id_priv->used_resolve_ip = 1;
 			ret = rdma_resolve_ip(cma_src_addr(id_priv), dst_addr,
 					      &id->route.addr.dev_addr,
 					      timeout_ms, addr_handler,
diff --git a/drivers/infiniband/core/cma_priv.h b/drivers/infiniband/core/cma_priv.h
index 5c463da9984536..f92f101ea9818f 100644
--- a/drivers/infiniband/core/cma_priv.h
+++ b/drivers/infiniband/core/cma_priv.h
@@ -91,6 +91,7 @@ struct rdma_id_private {
 	u8			afonly;
 	u8			timeout;
 	u8			min_rnr_timer;
+	u8 used_resolve_ip;
 	enum ib_gid_type	gid_type;
 
 	/*

base-commit: ad17bbef3dd573da937816edc0ab84fed6a17fa6
-- 
2.33.0

