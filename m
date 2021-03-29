Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E348D34D1EB
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Mar 2021 15:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbhC2NzL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Mar 2021 09:55:11 -0400
Received: from mail-bn7nam10on2096.outbound.protection.outlook.com ([40.107.92.96]:28224
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231947AbhC2NzH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Mar 2021 09:55:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQ9eIMzEUaXVWGbrPD7j0ahrouGw2MERWku/wc0jQCoWx37Bagq452Hrzo/tBzcr6y6gbOIzbAM3ezZYRd6cRlXfbfPIewtXfSTTH8qAPWX8X2+k4ixuZRLPcN/9J+egBkU/0h8kuXF6OQfJizkfngI2IBW6uFdqN1dhRezfSHZUuF3i1CBJAOSVXBpj7E1zQ3+0lqV1R85971pWaCaa5n0+GHh2urpiPEKZwLeSFjD06XcoS1f5T9qX43QUhiEYmsAjiarLLScJ8taij8EPd+lGkiAySircaFtkzUn528Nv6hvkx0ps+9RLU2pfiMcplD7cUIPi9qT/5Y0h3jPayQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Sy7mI6vqCgV4Cggqb7Uf5JI5WfnQnVE+PQEZNM9Wv8=;
 b=BDsanK/mMfdSeRjEYHEI7Jw7SLz8oqEe8dzjuaa/wV4gDBiCuU/5VSJhyWFw4orH9klToWrbQoWeNAU9rn5s+478JGFDtxnt7O1OpAyEW4aTf/AoQKa7qPBGh94yIijCyhiRB53+WOtsDKLl4adfFXXNW/kaCJyGdNS+mNLEUNCz2C7eLqvwz7SoYugvUmtgf+mlNO4CzQ2LbZ575EW+fzt+aZwAODpa9886Zxa2X7V21BQZZmHqn0nHJYQw3/Fh5gmr88+j3HH5MyYcL5jCs0sXNUP3SepGwVYMBMdnroLjKh814AyXXeBgnkQSgWiweJTLpzZgnGTy/hkNCALj9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Sy7mI6vqCgV4Cggqb7Uf5JI5WfnQnVE+PQEZNM9Wv8=;
 b=iM3xhbTIHYfkMGX++QpLrSm8u/W+y4QWmArqRknt481T0e7uSE+Rg582kSa7m3eO27YKFhK/Yka707xgLESCemP+nVT+U9Y+APAGyws4Xej7LLQkaTSnyh7Rh7nTyH896KwPjVIOSeNkWbMWwE3ui6Qd3zZxsarjk7oeLk9GiRZisa9xR1MEJr4bPPfHegD7S+nXPpCvdwh8VbE+wBwZJNMJMfK/wfWwqiQjICRGwsWduS2CvOIEVuSr5QT8XrlDAi+RBKXuVoOxRzqCl/x/0KsklUgG45CyxL23LdwQ/DTef7WVruY5lmkIbRFJ4w5FGb9YYsK1CXNDD2i2KMnbzg==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6618.prod.exchangelabs.com (2603:10b6:510:78::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.24; Mon, 29 Mar 2021 13:55:05 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::75a5:79c6:dd14:3860]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::75a5:79c6:dd14:3860%5]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 13:55:05 +0000
From:   dennis.dalessandro@cornelisnetworks.com
To:     dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Subject: [PATCH for-next 06/10] rdma: Set physical MTU for query_port function
Date:   Mon, 29 Mar 2021 09:54:12 -0400
Message-Id: <1617026056-50483-7-git-send-email-dennis.dalessandro@cornelisnetworks.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1617026056-50483-1-git-send-email-dennis.dalessandro@cornelisnetworks.com>
References: <1617026056-50483-1-git-send-email-dennis.dalessandro@cornelisnetworks.com>
Content-Type: text/plain
X-Originating-IP: [198.175.72.68]
X-ClientProxiedBy: SJ0PR03CA0166.namprd03.prod.outlook.com
 (2603:10b6:a03:338::21) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from awfm-01.cornelisnetworks.com (198.175.72.68) by SJ0PR03CA0166.namprd03.prod.outlook.com (2603:10b6:a03:338::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Mon, 29 Mar 2021 13:55:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ece9742e-e87e-4808-549b-08d8f2ba41ec
X-MS-TrafficTypeDiagnostic: PH0PR01MB6618:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR01MB6618EDB800A806E30B57A38DF47E9@PH0PR01MB6618.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:190;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W4QtfETqyuMhg8+hsnbGZ3DWc51YMpnGSALNQXoKmIG/8v2wIf7o27GwqXSThUFwLokBBzQz5WIjNrM2DOGQR4q6JdAUOd+/SaG4qI0c3VTq4VIHsdjqt4n34oUsMAn/KltU64822/fWHd3OB4CepvkemPSkprOQQoA2nkdHzuTJ0jX2HYbQ18xAArAOxmsycxupWkEmiekm3rc74Xkrb6Vj3tP6fTj8ANSKp3Z5f0V9dIlewXpnmx0B9R4S0CNejtngGmcRTZ+Pozp7pMTHiX0UwZeBHO3+T/BHCWB11YD0QIt2Fc+5n9zDeilt1x5M40+b2gG3ZLjsAZyqO7iLT8ysPgMgC0+nI+mFon3eEi/N3uJLvgE0b+0XV/Tf0KMkUXps51vr4wiZDY642HEBjkgp5lNqepV2FohhUGnk4t8jU+bhb8e/AhHGxWH8n8P4TmA+5m/7oKKeaeeb5tOK2oxwj5R5seOkJDksvCGJOedxuKf2Yxl8iQIXnjcbbMLELtEvXU9cTIf5yqfgkW/JvfepO/wx/bFSu2V3AMg3aeNXToH2tikasyvO/sv+nfbnhRncCk2I6+sFE5SddxqwooILeN8teHH65RjLI5VdTafWGqMHHb3Zx/tpNZJBAzYEYQ+X7p/D7y5d13bTDqcgfywaTRsFJRssSkffdLweAwY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39830400003)(366004)(346002)(376002)(396003)(86362001)(5660300002)(52116002)(186003)(4326008)(7696005)(2906002)(36756003)(66556008)(8936002)(956004)(66476007)(107886003)(2616005)(478600001)(54906003)(83380400001)(66946007)(6486002)(38100700001)(8676002)(26005)(316002)(30864003)(9686003)(6666004)(16526019);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Vwxm45f++4b5AENIivJBp74Tvqaw2it/BCXM5aq+PU00N8yFfnU/I9KwlvmF?=
 =?us-ascii?Q?928D4M99X5uXCcvVNOFlyJtWONkhuIM2iunc1/fmsWp+RJr7kBaBOGeUIdY4?=
 =?us-ascii?Q?syQT9RjdvizCQgkW/CbwFQ+twLqLpD+N9RqaFv89EgVM6kstKYxFRoRiBANo?=
 =?us-ascii?Q?AgHMimEogWjkoWzRFvTUomI6UtK+b7Eo8c5RMAk3cfAWcx+99F2Q60XL7DDY?=
 =?us-ascii?Q?y1X2OYr5x6q5N5xrDgnT2KK2dXksmUWUOUXOaeYd0PBRVStF7DyHGmwjdXaX?=
 =?us-ascii?Q?YiJ0sHuFQrvYZ67SnVr4zMqOm43bwpGvxVPnO5/5ovQnUYz1gE3hq4We4AJG?=
 =?us-ascii?Q?rygeJde+sKhLcFbOdH69aiRxxWY4MqoXjKd322xqMg7pnphTNlWOALZ0r1ef?=
 =?us-ascii?Q?YY9hp340TqYu0P/GyXWlV8Jp+0/6lz3mRee3XsV6zr66XxnFx/p65rJePY9+?=
 =?us-ascii?Q?2mBo79jx4FE/FUdckr2InWHP6Wy5N//rskBWIoo2JMVlMXHoYq9pVw1AUQXC?=
 =?us-ascii?Q?3NfT8SOASD1pL40sLQhzTtBOO4MaUmhtHOgKf+Zywj/Uhx7wg3uuASLxSy9A?=
 =?us-ascii?Q?fhjNzLVx1qgfLZhITK1j5UzZVLcTvtrAJFGSsBlmj8P1DtQDmNbc9zxwClcj?=
 =?us-ascii?Q?Xus42Jz5jMy8MFHCNT44dXC1Rb/61bKFHQB/f4D8jP1zqV8CcG8Ubq+cGRgg?=
 =?us-ascii?Q?k9m1qq6R70z6pteUFgBlRPx00eZ0aN5qRjFqd5RCYARFAte2YFAt4JZeIZJ2?=
 =?us-ascii?Q?m5ju3BArLDwSHoj/VamFQjXetix4U6vP4mjtBW3NySRtGwTv09QXmFhX8kyr?=
 =?us-ascii?Q?FluQWjPRtj3uTDqGl41U5PipeXTIHQ+SewwguFav4EFaaOkvdmjYqhrtTYO9?=
 =?us-ascii?Q?bR2Iw9IUq5t95OyRC2k8rAx3lwPqI76k6UcFsF/Gx6+OeI+kweLJvZibRC8g?=
 =?us-ascii?Q?JgM6/Kb+b2uxJDGN/fYqHZKvDbronIE32NFk6RYHyHmn8MmUtK5RGNM/0Uqb?=
 =?us-ascii?Q?8YViMcmS5JX9u8hJP4X9V4TeSNsjxr2vgjVHZZQmreu0ur3+huOoCw4PeFHm?=
 =?us-ascii?Q?b5GAwptTRuVualZApOWjKsArNBablp7zW85hYk3lXmR9UBU/42IzUZXyEP+z?=
 =?us-ascii?Q?N97+7p8fKcjujAD42kOLIRBmE6AzOQLmoUbCxsG1044Wu7y1d7OOlNTxfYUl?=
 =?us-ascii?Q?XxuXWwVNdsSp5G4ayx/Mb4FfLqAtlk3J5IEvMfKQDAonSs5RpwHT5mCmPnfc?=
 =?us-ascii?Q?viPCkp7SjT/TSm0bedhOfK5iOndr08yni4mQAx5A1ipCDd3A2VZJocMJPupM?=
 =?us-ascii?Q?/ZxlE2+KlWxW2hoTX6ykho17?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ece9742e-e87e-4808-549b-08d8f2ba41ec
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 13:55:05.7896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TwD8CN5zxDZRD1uIF+BHbwYUANwtk8jNB/Zg6PwgRPAaREFU8cemcL4FQ5gXC/nGRU2B3XWCOHnujg5sQz52atFGiJXYj8hcFLY4Ya6II4zE4xXsFU3mIbdf9Gn6ePyz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6618
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Kaike Wan <kaike.wan@intel.com>

This is a follow on patch to add a phys_mtu field to the
ib_port_attr structure to indicate the maximum physical MTU
the underlying device supports.

Extends the following:
commit 6d72344cf6c4 ("IB/ipoib: Increase ipoib Datagram mode MTU's upper limit")

Reviewed-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c        |  1 +
 drivers/infiniband/hw/cxgb4/provider.c          |  1 +
 drivers/infiniband/hw/efa/efa_verbs.c           |  1 +
 drivers/infiniband/hw/hns/hns_roce_main.c       |  1 +
 drivers/infiniband/hw/i40iw/i40iw_verbs.c       |  1 +
 drivers/infiniband/hw/mlx4/main.c               |  1 +
 drivers/infiniband/hw/mlx5/mad.c                |  1 +
 drivers/infiniband/hw/mlx5/main.c               |  2 ++
 drivers/infiniband/hw/mthca/mthca_provider.c    |  1 +
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c     |  1 +
 drivers/infiniband/hw/qib/qib_verbs.c           |  1 +
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c    |  1 +
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c |  1 +
 drivers/infiniband/sw/siw/siw_verbs.c           |  1 +
 drivers/infiniband/ulp/ipoib/ipoib_main.c       |  2 +-
 include/rdma/ib_verbs.h                         | 17 -----------------
 16 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index ba515ef..17d4871 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -205,6 +205,7 @@ int bnxt_re_query_port(struct ib_device *ibdev, u8 port_num,
 		port_attr->phys_state = IB_PORT_PHYS_STATE_DISABLED;
 	}
 	port_attr->max_mtu = IB_MTU_4096;
+	port_attr->phys_mtu = ib_mtu_enum_to_int(port_attr->max_mtu);
 	port_attr->active_mtu = iboe_get_mtu(rdev->netdev->mtu);
 	port_attr->gid_tbl_len = dev_attr->max_sgid;
 	port_attr->port_cap_flags = IB_PORT_CM_SUP | IB_PORT_REINIT_SUP |
diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
index 1f1f856..09a995b 100644
--- a/drivers/infiniband/hw/cxgb4/provider.c
+++ b/drivers/infiniband/hw/cxgb4/provider.c
@@ -311,6 +311,7 @@ static int c4iw_query_port(struct ib_device *ibdev, u8 port,
 	    IB_PORT_VENDOR_CLASS_SUP | IB_PORT_BOOT_MGMT_SUP;
 	props->gid_tbl_len = 1;
 	props->max_msg_sz = -1;
+	props->phys_mtu = ib_mtu_enum_to_int(props->max_mtu);
 
 	return ret;
 }
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 479b604..1a426c0 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -261,6 +261,7 @@ int efa_query_port(struct ib_device *ibdev, u8 port,
 	props->active_speed = IB_SPEED_EDR;
 	props->active_width = IB_WIDTH_4X;
 	props->max_mtu = ib_mtu_int_to_enum(dev->dev_attr.mtu);
+	props->phys_mtu = ib_mtu_enum_to_int(props->max_mtu);
 	props->active_mtu = ib_mtu_int_to_enum(dev->dev_attr.mtu);
 	props->max_msg_sz = dev->dev_attr.mtu;
 	props->max_vl_num = 1;
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 1a747f7..0fb46eb 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -228,6 +228,7 @@ static int hns_roce_query_port(struct ib_device *ib_dev, u8 port_num,
 	/* props being zeroed by the caller, avoid zeroing it here */
 
 	props->max_mtu = hr_dev->caps.max_mtu;
+	props->phys_mtu = ib_mtu_enum_to_int(props->max_mtu);
 	props->gid_tbl_len = hr_dev->caps.gid_table_len[port];
 	props->port_cap_flags = IB_PORT_CM_SUP | IB_PORT_REINIT_SUP |
 				IB_PORT_VENDOR_CLASS_SUP |
diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
index 375b774..0e76968 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -104,6 +104,7 @@ static int i40iw_query_port(struct ib_device *ibdev,
 	props->active_width = IB_WIDTH_4X;
 	props->active_speed = 1;
 	props->max_msg_sz = I40IW_MAX_OUTBOUND_MESSAGE_SIZE;
+	props->phys_mtu = ib_mtu_enum_to_int(props->max_mtu);
 	return 0;
 }
 
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index f26a0d9..a33a7b7 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -702,6 +702,7 @@ static int ib_link_query_port(struct ib_device *ibdev, u8 port,
 	props->active_width	= out_mad->data[31] & 0xf;
 	props->active_speed	= out_mad->data[35] >> 4;
 	props->max_mtu		= out_mad->data[41] & 0xf;
+	props->phys_mtu		= ib_mtu_enum_to_int(props->max_mtu);
 	props->active_mtu	= out_mad->data[36] >> 4;
 	props->subnet_timeout	= out_mad->data[51] & 0x1f;
 	props->max_vl_num	= out_mad->data[37] >> 4;
diff --git a/drivers/infiniband/hw/mlx5/mad.c b/drivers/infiniband/hw/mlx5/mad.c
index 652c6cc..9a1806d 100644
--- a/drivers/infiniband/hw/mlx5/mad.c
+++ b/drivers/infiniband/hw/mlx5/mad.c
@@ -555,6 +555,7 @@ int mlx5_query_mad_ifc_port(struct ib_device *ibdev, u8 port,
 	props->active_width	= out_mad->data[31] & 0xf;
 	props->active_speed	= out_mad->data[35] >> 4;
 	props->max_mtu		= out_mad->data[41] & 0xf;
+	props->phys_mtu		= ib_mtu_enum_to_int(props->max_mtu);
 	props->active_mtu	= out_mad->data[36] >> 4;
 	props->subnet_timeout	= out_mad->data[51] & 0x1f;
 	props->max_vl_num	= out_mad->data[37] >> 4;
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 9ff28f7..732e5ce 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -511,6 +511,7 @@ static int mlx5_query_port_roce(struct ib_device *device, u8 port_num,
 		props->qkey_viol_cntr = qkey_viol_cntr;
 	}
 	props->max_mtu          = IB_MTU_4096;
+	props->phys_mtu		= ib_mtu_enum_to_int(props->max_mtu);
 	props->max_msg_sz       = 1 << MLX5_CAP_GEN(dev->mdev, log_max_msg);
 	props->pkey_tbl_len     = 1;
 	props->state            = IB_PORT_DOWN;
@@ -1321,6 +1322,7 @@ static int mlx5_query_hca_port(struct ib_device *ibdev, u8 port,
 	mlx5_query_port_max_mtu(mdev, &max_mtu, port);
 
 	props->max_mtu = mlx5_mtu_to_ib_mtu(max_mtu);
+	props->phys_mtu = ib_mtu_enum_to_int(props->max_mtu);
 
 	mlx5_query_port_oper_mtu(mdev, &oper_mtu, port);
 
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index 1a3dd07..87f7b11 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -164,6 +164,7 @@ static int mthca_query_port(struct ib_device *ibdev,
 	props->active_width      = out_mad->data[31] & 0xf;
 	props->active_speed      = out_mad->data[35] >> 4;
 	props->max_mtu           = out_mad->data[41] & 0xf;
+	props->phys_mtu		 = ib_mtu_enum_to_int(props->max_mtu);
 	props->active_mtu        = out_mad->data[36] >> 4;
 	props->subnet_timeout    = out_mad->data[51] & 0x1f;
 	props->max_vl_num        = out_mad->data[37] >> 4;
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index 3acb5c1..d0496c1 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -167,6 +167,7 @@ int ocrdma_query_port(struct ib_device *ibdev,
 		props->phys_state = IB_PORT_PHYS_STATE_DISABLED;
 	}
 	props->max_mtu = IB_MTU_4096;
+	props->phys_mtu = ib_mtu_enum_to_int(props->max_mtu);
 	props->active_mtu = iboe_get_mtu(netdev->mtu);
 	props->lid = 0;
 	props->lmc = 0;
diff --git a/drivers/infiniband/hw/qib/qib_verbs.c b/drivers/infiniband/hw/qib/qib_verbs.c
index 8e0de26..0534a12 100644
--- a/drivers/infiniband/hw/qib/qib_verbs.c
+++ b/drivers/infiniband/hw/qib/qib_verbs.c
@@ -1209,6 +1209,7 @@ static int qib_query_port(struct rvt_dev_info *rdi, u8 port_num,
 	props->max_vl_num = qib_num_vls(ppd->vls_supported);
 
 	props->max_mtu = qib_ibmtu ? qib_ibmtu : IB_MTU_4096;
+	props->phys_mtu = ib_mtu_enum_to_int(props->max_mtu);
 	switch (ppd->ibmtu) {
 	case 4096:
 		mtu = IB_MTU_4096;
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
index 3705c6b..a83eaf0 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
@@ -373,6 +373,7 @@ int usnic_ib_query_port(struct ib_device *ibdev, u8 port,
 	props->bad_pkey_cntr = 0;
 	props->qkey_viol_cntr = 0;
 	props->max_mtu = IB_MTU_4096;
+	props->phys_mtu = ib_mtu_enum_to_int(props->max_mtu);
 	props->active_mtu = iboe_get_mtu(us_ibdev->ufdev->mtu);
 	/* Userspace will adjust for hdrs */
 	props->max_msg_sz = us_ibdev->ufdev->mtu;
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
index fc412cb..a40083ae 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
@@ -150,6 +150,7 @@ int pvrdma_query_port(struct ib_device *ibdev, u8 port,
 
 	props->state = pvrdma_port_state_to_ib(resp->attrs.state);
 	props->max_mtu = pvrdma_mtu_to_ib(resp->attrs.max_mtu);
+	props->phys_mtu = ib_mtu_enum_to_int(props->max_mtu);
 	props->active_mtu = pvrdma_mtu_to_ib(resp->attrs.active_mtu);
 	props->gid_tbl_len = resp->attrs.gid_tbl_len;
 	props->port_cap_flags =
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index e389d44..8a5df31 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -173,6 +173,7 @@ int siw_query_port(struct ib_device *base_dev, u8 port,
 	attr->gid_tbl_len = 1;
 	attr->max_msg_sz = -1;
 	attr->max_mtu = ib_mtu_int_to_enum(sdev->netdev->mtu);
+	attr->phys_mtu = ib_mtu_enum_to_int(attr->max_mtu);
 	attr->active_mtu = ib_mtu_int_to_enum(sdev->netdev->mtu);
 	attr->phys_state = sdev->state == IB_PORT_ACTIVE ?
 		IB_PORT_PHYS_STATE_LINK_UP : IB_PORT_PHYS_STATE_DISABLED;
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index 2fb2fa16..4ca6150 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -1865,7 +1865,7 @@ static int ipoib_parent_init(struct net_device *ndev)
 			priv->port);
 		return result;
 	}
-	priv->max_ib_mtu = rdma_mtu_from_attr(priv->ca, priv->port, &attr);
+	priv->max_ib_mtu = attr.phys_mtu;
 
 	result = ib_query_pkey(priv->ca, priv->port, 0, &priv->pkey);
 	if (result) {
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 84f7084..221c5b2 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -3338,23 +3338,6 @@ static inline int rdma_mtu_enum_to_int(struct ib_device *device, u8 port,
 		return ib_mtu_enum_to_int((enum ib_mtu)mtu);
 }
 
-/**
- * rdma_mtu_from_attr - Return the mtu of the port from the port attribute.
- * @device: Device
- * @port_num: Port number
- * @attr: port attribute
- *
- * Return the MTU size supported by the port as an integer value.
- */
-static inline int rdma_mtu_from_attr(struct ib_device *device, u8 port,
-				     struct ib_port_attr *attr)
-{
-	if (rdma_core_cap_opa_port(device, port))
-		return attr->phys_mtu;
-	else
-		return ib_mtu_enum_to_int(attr->max_mtu);
-}
-
 int ib_set_vf_link_state(struct ib_device *device, int vf, u8 port,
 			 int state);
 int ib_get_vf_config(struct ib_device *device, int vf, u8 port,
-- 
1.8.3.1

