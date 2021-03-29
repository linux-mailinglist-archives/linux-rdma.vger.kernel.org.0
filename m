Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7291834D1EA
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Mar 2021 15:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbhC2NzJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Mar 2021 09:55:09 -0400
Received: from mail-bn7nam10on2130.outbound.protection.outlook.com ([40.107.92.130]:57952
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231600AbhC2Nys (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Mar 2021 09:54:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRTENW1L0DaLYemBtZpzb2nDAUVTHPg7q+wycAIpluf+LQjRYlu+9rvOguARqP01Htq+Zzst1JO23apLFW5xSCaxmqz9WELUudoYVT5xOoH6p3wMbQ/ke2kk057whGx7MRKOUu0XwwtRmgdUjeC9mOmCr6F5LoA0imMY9bi8BEUwdPuzdph67DFfmVnCe2DflBBPVtS+L3Svs5Lbd9E7FMlZMOH5qfAUb0nhFPeTs3kTtUyvOtqm4Z1D2qgkWqk56hBOCqpkXByYGr0i0sQ3itDqqYIuWZSlGVk9oa2kdqjJLaH71dmuX3e/PwGpdW1ecjUBWiEW+BbJLS7l1cEMcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=li+z3i1njb82FI+vjiuw61jTdc9p03vVFwsfkae/PiY=;
 b=PCLYJjWoNieeTrpMykxkYo05JpxgDjU9b7hhQm3RgW0vQP0VskiITX+OAKjwHFgAn83ZzP+uBtWS5C2kUnxVb+7Z0vZpbk9foc6RQrlYkJCeLGsKV8rgXgaUzSQgfLdUACTwzmTYQO02d4VI3LXwV+KCQqA1b7t9G4BN/YsU5CNlJqWoRgLwhX9MUwR9zoCly3iZH9SMgX4BTNN+ZDZlrYTqm85LFcFI2iwJF7/8e1FBOaTB+upy+Q477RlfISiT809LKrF2MPmW15zXhn8ZbrfTulTWK6VSjFdhLDChYqYjRllRnZj4CkendBOvN3wdCz3Y/NLK6L+XdWCqasM+BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=li+z3i1njb82FI+vjiuw61jTdc9p03vVFwsfkae/PiY=;
 b=gC0WH6PSwnN1KQl5wvxNP6lYJQ6NW/m85E9oOufXpbwDkMCZfBFxnRu0A6yt4sMDIafrckgeScUvfsBZMkotKTNKRVWHyoYsxxsPS/rCA6f3kVZMgukXtb922KMFFcpkJici3Lq9/OdYNatGyPKVeYRdbcYv+CEAlx+vcu4eNHzCjQlFmi4QCoVpg7v4SmuDiJJ7kkYanJEucWuWb88i+NP0kS40XQ1vioykiHCJMndaR69ReZyste6UBigBELsmDKFXU13ke8/wxIlCAJ372o/eecccvidI4DCwexIito7ADWTNf9UT3AD94bQOKERfD1XaTDJLAUIQpJrU7IEvCQ==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6618.prod.exchangelabs.com (2603:10b6:510:78::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.24; Mon, 29 Mar 2021 13:54:45 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::75a5:79c6:dd14:3860]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::75a5:79c6:dd14:3860%5]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 13:54:45 +0000
From:   dennis.dalessandro@cornelisnetworks.com
To:     dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Subject: [PATCH for-next 00/10] Fixes for 5.13
Date:   Mon, 29 Mar 2021 09:54:06 -0400
Message-Id: <1617026056-50483-1-git-send-email-dennis.dalessandro@cornelisnetworks.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-Originating-IP: [198.175.72.68]
X-ClientProxiedBy: SJ0PR03CA0166.namprd03.prod.outlook.com
 (2603:10b6:a03:338::21) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from awfm-01.cornelisnetworks.com (198.175.72.68) by SJ0PR03CA0166.namprd03.prod.outlook.com (2603:10b6:a03:338::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Mon, 29 Mar 2021 13:54:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df457675-65b6-48a0-4dbc-08d8f2ba3578
X-MS-TrafficTypeDiagnostic: PH0PR01MB6618:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR01MB66183FAEB50ED29D443CD759F47E9@PH0PR01MB6618.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /FGw8aYM/N51mrx7GF3dkg/BjX+6ZJu72QezbOzGgIhXuJjJcEK4epkBVvxqc1A+PbClCrhpjvEimkCr9F4s4RGCGCFL4JZ8EHhprNEgRP2GnCfhAFK2+R1avyWst72ZSA+Kkqmx34/4swc88PEbem026dDhlhzFBGy44PSm5bJASLjodyrrg0kOU6d1x3wpdFed5K9WikkPGZWdBdwfqcllHZdf569aeLNQmeixMS/8NzjLp6srxka74uNVCkZAtHQTwvLJVT1UwwIZgJuHO3y7kNghMLtyryXs4O2ytLIx7YBbIkMY8lrpqyM3qa1NwJa9wIe38W7cgZIbuKCuoDiIMBkZa3R8C5aOyysuWEruBNg/AbDjrnMNeh4N450ETeL4GN2nCxSQyIvB4y3GiDJRvrarb1buhtjRig0BlZ058FzpTcV+kf36ETxHaVcOOIEjvnUqJBKzOsgzit9gzpRWJfQLN2EdHDLWUFRHg+77L7zMtMFtPysttbY1l6+7vFJd+xwt3w5b6oeMrMW+ogGvN5fGnORGb2VvP2mWZTVCQZqtNlHCf2puM3c97QHhoa9j/K6IQWeZL+Gk3t2knC5qXn6BDxju1QOq3LWj63vSIwV/MHiNdIp7LgxGn34Com2FfeoE7xW1K2ufiHihiJyJbeCaJvrpg28qHmI3jCA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39830400003)(366004)(346002)(376002)(396003)(86362001)(5660300002)(52116002)(186003)(4326008)(7696005)(2906002)(36756003)(66556008)(8936002)(956004)(66476007)(107886003)(2616005)(478600001)(83380400001)(66946007)(6486002)(38100700001)(8676002)(26005)(316002)(9686003)(6666004)(16526019);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0gvbQlW/BX5bPvvWcmfXv2HCqQDGtWc7HksxsggOw/Fjn0Dk7W4NDd5FH9EC?=
 =?us-ascii?Q?KFM+gKnqnl0byh2ND7XaWpqdAN4IzcwyDDkfTMEjLQodKLgnxaeowNqIEG/b?=
 =?us-ascii?Q?luahbTgksu8sgRefJUiRSV/dbh7GqGlW/YE4VDRHJ4gy4mMaXtciTgBFjYFz?=
 =?us-ascii?Q?AAWY8ZT/DRezr20FqJkFCLxOAgChfAcGBJAGpslrEb7L69sAVfOfS8ndK4f4?=
 =?us-ascii?Q?fjtSSn2E/D9QgJvbSp8IxDJt+FXHqNgW1YCpgklndViaKWZOmiWsNrDk4Kd8?=
 =?us-ascii?Q?AR00AJ6uua3HUWHu7+sLtGxXUIRdn9y6opbxyTlJsz+/16Eie8S0fVWVP4JZ?=
 =?us-ascii?Q?M8/qOHlal0zrVLr/1K2KN0nkUHlp6DUzn012ppfEEH0wbcG+qzZZYZ1PxtuZ?=
 =?us-ascii?Q?Hw2BOClunw7agOyCDV8Zgi0G12tKcWppL+AFjS2zwRQ8OCaEDqZ65A77PS8F?=
 =?us-ascii?Q?MSqeVTCgeqfgKS8cvNcTpX2lZDzZQvN2Mam5LP9jKAiHnrYw5PTMDKSMFvRK?=
 =?us-ascii?Q?BJ69Eee0gRUz+de5pGT2lK+xrVGPb2KwkMx0L/lVAq5WMCcTz21/B2+BEBe6?=
 =?us-ascii?Q?KPTXnmrKpij4+DqmYKLYbYdABunBMXY2hbAix8aHlACtaNbg42tJvCwAM3V7?=
 =?us-ascii?Q?sERbAWZ4MWdWNx26gaBRJN9XFYCVDF/ADv4jIn9ApbZh8+X8QK5IEk+B1/nW?=
 =?us-ascii?Q?hg9nN0AEiSPMF2MIeyEuI/5jTohX/uhYHBhefXozMBAR7Dv6xNY0FkSltn6L?=
 =?us-ascii?Q?35KXVzOoAl7uUsGxPFHwaAgR+pwPqBvUzbbPWp7lRRgz86L69R4Ictpmhu5b?=
 =?us-ascii?Q?qWA1npAVyj+r7XNBMqJ7UyVFtZzyMZY6tZeTkx0jv42SzzjTZ1cFnxZvVB8f?=
 =?us-ascii?Q?5CtL9lIH6Ey8rV6qauRsM4U7nigfT2nvWj/xVhWQ/QUhO47cwQVAe8YOXAq6?=
 =?us-ascii?Q?3fXbkqEa9TSJpT/YkGyNyN7MkbyXO0CiiNk6Uh0nqNThCrwtWn58oDu+sjpF?=
 =?us-ascii?Q?PZWqknbEsI09+GoAKbom1/YYwGrsh1QRuYozO2gPSInvknNuFPXOMu+ZFCQs?=
 =?us-ascii?Q?rHwq6djgx2E/Gf4RLyJcKZYTtAZwne9YgvrgUP4ImRF8QL7NPW6z+qFEsPvW?=
 =?us-ascii?Q?SlarIaOjnM1GOLIq+geDidE/Siw9SZFPVpyJfLcqUyL4yhosqPpgpdMIijyI?=
 =?us-ascii?Q?HttYiiHt3m4xgspM7Z5pFWQdHrIw1abJzvvyfKDFVZQFgyv3adbYBYSb4yq6?=
 =?us-ascii?Q?PCL1WvuZMFxtJO55olEXK/u5ooB1MZSOyCoWz5WsU2GPNrIfFGWpHoxUmI2+?=
 =?us-ascii?Q?H/Gq6aR+v+GyFIXixIAOrz0D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df457675-65b6-48a0-4dbc-08d8f2ba3578
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 13:54:44.8886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uJYcMTOQz9IFHRTJWWpPAQUdD8JPgc9S3wHjEBUZc5CCBr09obC/6uKlovvENlVQUzbPmvJS2PyyjeZPwwlH/B++yLG0PvD6ev0uaairt1z/BgCjsQlCBdF+YpnC4u9n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6618
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>

Here are some fixes, clean-up and debugging type patches for-next. There are
some changs to the way AIP/VNIC netdevs are used and a timeout handler is added
for rdma_netdev. 

The MTU patch from Kaike will to add a physical MTU to query_port is also of
particualr note.

Kaike Wan (2):
  rdma: Set physical MTU for query_port function
  IB/hfi1: Remove unused function

Mike Marciniszyn (8):
  IB/hfi1: Add AIP tx traces
  IB/{ipoib,hfi1}: Add a timeout handler for rdma_netdev
  IB/hfi1: Correct oversized ring allocation
  IB/hfi1: Use napi_schedule_irqoff() for tx napi
  IB/hfi1: Remove indirect call to hfi1_ipoib_send_dma()
  IB/hfi1: Add additional usdma traces
  IB/hfi1: Use kzalloc() for mmu_rb_handler allocation
  IB/hfi1: Rework AIP and VNIC dummy netdev usage

 drivers/infiniband/hw/bnxt_re/ib_verbs.c        |   1 +
 drivers/infiniband/hw/cxgb4/provider.c          |   1 +
 drivers/infiniband/hw/efa/efa_verbs.c           |   1 +
 drivers/infiniband/hw/hfi1/chip.c               |   6 +-
 drivers/infiniband/hw/hfi1/hfi.h                |   4 +-
 drivers/infiniband/hw/hfi1/init.c               |   2 +-
 drivers/infiniband/hw/hfi1/ipoib.h              |  13 +-
 drivers/infiniband/hw/hfi1/ipoib_main.c         |   9 +-
 drivers/infiniband/hw/hfi1/ipoib_tx.c           |  71 ++++++++--
 drivers/infiniband/hw/hfi1/mmu_rb.c             |   2 +-
 drivers/infiniband/hw/hfi1/netdev.h             |  39 ++----
 drivers/infiniband/hw/hfi1/netdev_rx.c          | 177 +++++++++++------------
 drivers/infiniband/hw/hfi1/sdma.h               |  18 ---
 drivers/infiniband/hw/hfi1/trace_tx.h           | 179 ++++++++++++++++++++++++
 drivers/infiniband/hw/hfi1/user_sdma.c          |  12 +-
 drivers/infiniband/hw/hfi1/user_sdma.h          |   1 +
 drivers/infiniband/hw/hns/hns_roce_main.c       |   1 +
 drivers/infiniband/hw/i40iw/i40iw_verbs.c       |   1 +
 drivers/infiniband/hw/mlx4/main.c               |   1 +
 drivers/infiniband/hw/mlx5/mad.c                |   1 +
 drivers/infiniband/hw/mlx5/main.c               |   2 +
 drivers/infiniband/hw/mthca/mthca_provider.c    |   1 +
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c     |   1 +
 drivers/infiniband/hw/qib/qib_verbs.c           |   1 +
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c    |   1 +
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c |   1 +
 drivers/infiniband/sw/siw/siw_verbs.c           |   1 +
 drivers/infiniband/ulp/ipoib/ipoib_main.c       |   7 +-
 include/rdma/ib_verbs.h                         |  19 +--
 29 files changed, 386 insertions(+), 188 deletions(-)

-- 
1.8.3.1

