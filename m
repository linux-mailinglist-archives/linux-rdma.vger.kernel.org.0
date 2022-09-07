Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41415B0342
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Sep 2022 13:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiIGLik (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Sep 2022 07:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbiIGLid (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Sep 2022 07:38:33 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E54E41D35
        for <linux-rdma@vger.kernel.org>; Wed,  7 Sep 2022 04:38:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6D+urQXgdNZR7bGmsh3/Mbg+poTiDo8hNdnK6Snha+/y2s0gdEyokCJjQD6HPFFLDGDJxxmZdra8jC2nBjqu36k36mXhlwHhaidQhI+9JiB2RJcdCwKGZIBNPlNnNvOmSFm24BppcfoYDWj0KqGXv/y4EhKebWfqcZ7BAqMJ7kcyLvajTmXB0WGJxxuXxNwy/bd+/Hlw31JjgzMp+8UxP/t0ctVgxbx1IZ0TE0zEmKpAQfKKZoINAtEeo3t7tALkQq8+bpppN4BtA1xAr9qLWO94rigT3oo8gggs3We4V7zbjlpK/Ouk2uMESB8jhDDM/mwtrAAF3mJqYFsZFcVyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3j75oOywd7fB22BRtRR2JqlWg21/FbM5ubQxVTf+vU=;
 b=VlzT7zG9INtsai271Oho2bkrnSgTucMZvfFPFeAJqoZE++z3+FQZxNfzwdSd0fdvW/N1JOoJ6HU+wMTAU9OITMPo3yqYwLGuWOwR2EzKTBPMuYYHBgNjxlpigzQ/gBWSS/slUWKecWcLXu2zLW2GqRaqXmygXWJKoun2iQ6CuqZcvbXLuU2NvJ9KBCDA/Cz5OeJ0tYjFKAGoPT/+QmrvF/N5qzgMMdGp4ABMkv6LsAqNT6q2LO/n40PBefeYWiXcB5M0rSPPt03Vjo6qplaBHZVBgLQmLVqoErjJzkZarZlapBPIL21WquSHCkQvBiqPtcg8Tl2+LNKZhAEMApAAfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3j75oOywd7fB22BRtRR2JqlWg21/FbM5ubQxVTf+vU=;
 b=qw3t/+2m2HwivCtu85VijC6ABGBogIUxQCa1+7x6ZtfNrs209HvgVpey/n3C611XzHpKj8kAbaY68LfdI1iWgihtQ6bT79dMCEiDWXkoUA74Utdyiqr7Hjr/QXkLRmyd3aa2zZeRyPZ3kPkjY2pTtf0XVI68BtR8Or8CN6rkUTrJYQYUwuOCa+eeJsOwl/HfpItkbesr3IDd8Jf65LDNP18YPRTRZsYPI8MEUElr9qLhNqm+tWA170Kn0ZBJvZT5m6ksEGh2oeNga4BUwsdhb/ztxek2LRn3GL7h8qwK4KIb3ufa4RXvW3kRTc5kBFIG8UPy75PZ7iZB2vftcNUXbQ==
Received: from MW4PR04CA0342.namprd04.prod.outlook.com (2603:10b6:303:8a::17)
 by BN9PR12MB5260.namprd12.prod.outlook.com (2603:10b6:408:101::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Wed, 7 Sep
 2022 11:38:24 +0000
Received: from CO1NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::68) by MW4PR04CA0342.outlook.office365.com
 (2603:10b6:303:8a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17 via Frontend
 Transport; Wed, 7 Sep 2022 11:38:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT108.mail.protection.outlook.com (10.13.175.226) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 11:38:24 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Wed, 7 Sep
 2022 11:38:23 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 7 Sep 2022
 04:38:23 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.29 via Frontend Transport; Wed, 7 Sep
 2022 04:38:20 -0700
From:   Patrisious Haddad <phaddad@nvidia.com>
To:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
CC:     Patrisious Haddad <phaddad@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux-nvme <linux-nvme@lists.infradead.org>,
        <linux-rdma@vger.kernel.org>,
        Michael Guralnik <michaelgur@nvidia.com>,
        Israel Rukshin <israelr@nvidia.com>,
        Maor Gottlieb <maorg@nvidia.com>,
        "Max Gurtovoy" <mgurtovoy@nvidia.com>
Subject: [PATCH rdma-next 0/4] Provide more error details when a QP moves to
Date:   Wed, 7 Sep 2022 14:37:56 +0300
Message-ID: <20220907113800.22182-1-phaddad@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT108:EE_|BN9PR12MB5260:EE_
X-MS-Office365-Filtering-Correlation-Id: c81f6ad3-3646-4129-ace8-08da90c5794e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K22pTpHzeXqas+GOY3AY2raII/Lf5FUHpN227RhDVYskxTsqLyLplaDHqUMbOZEiNNILvBJQOVsyegDhjTroXPWQ/sTJPI2eOoHooS/ERhlygtSr0Cc90PCM1vaMWffJX79/O1TZ/3niR/qwhHCqjI+h52KKYI7k0t2p371r9ZO7CKXU9Re/hJd+Ia+h23HC2Rg1ljUBlkWcB+0omtXko5MumvcoI3FlogtbOxsZLS1A/yfbMQvzt1nBIF20yBz0z8w6aSTC/56W2Nei8gZpSHpT0g/8ac9tetydnTbt/7Tu9fVOY7rzo/QqVoMKkahhGeoWc2b75hgddUzko0W6kvkYmjkxNztTsY8rjEPzBiSON8W9MB8aRLX/9X69ykegYkJ9axcrcdlJpr44ny6ydeCO9zYngOAWc2UVVt5sfgClteDdKUANA/KdaW1Q+NiBZuE7zw1TmzerO6fbzFAB9cHy1KR5w0HVsi/2c6Fq4V0MgjEnNJfum4zeiMDd45U5pOFPg9E6FdbAhRvBg7DXsPp++k1SHwGSJBKHr1n9nBY/tWqpm6jhT6t4m9q0n5uEuHL1bEjqXIYaqKyJDoZhQW+tEVUgxWnEqzSH4Jjas1SwMeSQyE2bYBYhtDyJMkxWlg1O+Uxm0awiu0Xjev8IQoTjXpLjaRijDuDTNH2Pn4Kk3PnBVfdNhH1M+up5eFdoc5x8RBsL5Mvlkoqfgi/ZSN3OR6/iCm4tMmFtkXty8SQA2TZ6nVheForz5hb8TJJmQjhUxnPaPHOaf4CoeYDLb/E+7J9/ONZz8H9adkgBup1chT/mrueXN/BuqgnFKf2k
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(396003)(376002)(39860400002)(36840700001)(46966006)(40470700004)(6666004)(107886003)(86362001)(82310400005)(316002)(478600001)(54906003)(26005)(110136005)(7696005)(36860700001)(82740400003)(83380400001)(336012)(2616005)(186003)(356005)(4326008)(41300700001)(2906002)(8936002)(1076003)(40460700003)(81166007)(40480700001)(47076005)(8676002)(5660300002)(426003)(36756003)(70206006)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 11:38:24.3409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c81f6ad3-3646-4129-ace8-08da90c5794e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5260
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The following series adds debug prints for fatal QP events that are
helpful for finding the root cause of the errors.
The ib_get_qp_err_syndrome is called at a work queue since the QP event callback is
running on an interrupt context that can't sleep.

The functions is especially useful for debugging purposes for few
reasons:
First of all it provides the information in a human readable way, that
would make it easier to identify the bug root cause.
Secondly it also allows providing vendor specfic error codes or information
that could be very useful to users who know them.
Lastly and most importantly the function provides information about the
reason the QP moved to error state, in cases where CQE isn't generated
and without this feature it would have been way harder to know the root cause
of the error.

An example of such case would be a remote write with RKEY violation,
whereas on the remote side no CQE would be generated but this print
allows to know the reason behind the failure.

Thanks.

Israel Rukshin (1):
  nvme-rdma: add more error details when a QP moves to an error state

Patrisious Haddad (3):
  net/mlx5: Introduce CQE error syndrome
  RDMA/core: Introduce ib_get_qp_err_syndrome function
  RDMA/mlx5: Implement ib_get_qp_err_syndrome

 drivers/infiniband/core/device.c     |  1 +
 drivers/infiniband/core/verbs.c      |  8 +++++
 drivers/infiniband/hw/mlx5/main.c    |  1 +
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  1 +
 drivers/infiniband/hw/mlx5/qp.c      | 42 ++++++++++++++++++++++++-
 drivers/infiniband/hw/mlx5/qp.h      |  2 +-
 drivers/infiniband/hw/mlx5/qpc.c     |  4 ++-
 drivers/nvme/host/rdma.c             | 24 ++++++++++++++
 include/linux/mlx5/mlx5_ifc.h        | 47 +++++++++++++++++++++++++---
 include/rdma/ib_verbs.h              | 13 ++++++++
 10 files changed, 135 insertions(+), 8 deletions(-)

-- 
2.18.1

