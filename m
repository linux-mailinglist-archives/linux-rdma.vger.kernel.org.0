Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24BC34C6501
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Feb 2022 09:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbiB1Itq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Feb 2022 03:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbiB1Itp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Feb 2022 03:49:45 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D2C36682
        for <linux-rdma@vger.kernel.org>; Mon, 28 Feb 2022 00:49:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LkQJkAn5AsFd8AE+y9Mhj0CBGJwsDAmI17HM0osDvEiZ0/7tL7DvUMwjtb4LaYmDTxPzn1OERB5uvajvnyU9bHqoHB1hK23NKfJbMlmlua9x0NazrW2EGzqOZQY/XlnDpqcQO8zrch2LbxDTi3U+WTKZQpONKC3jvEiEKZ4Q994zYbRjC+oSQTkPzXPQatBfVF6X1phRD14f71fzY8vs8bg82FoDHwOA3qqz+NiGqkcPPM5pEkUWUwguSeMIijf1vuK4UaC4dF1eH9zr+Y2mnt4fKBw9vedTW8FuoJ+T+xSbZ4v4BDEOakEDZUYI18nla4reaXFWXaxhkwD3MYhYKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XKorE9QM5y3MW5vMTEO6IUndnlNb9oR+pR6c9IyG80w=;
 b=HRb0IwNA3TQWs1nOwQQWOl4OE8Takyq2E2C64zG8BJtFxSehIHKgPi4B7i5YMcU6bsD1D5OsgwZvaC4o+gtyOP9GlJUT7WHz5HTStLOhhAPg00Y+MbmeZnUBxuZK2WdNFXiaNSX57Mv2XMQLeG+I7AavFaXb9hAh3KQ1/OoWuDR22YRUiROlzwg4INkj1g/Efflfm4tkBXM5pk0DjNtEh++mTRWNnnPwZHiY3fdWiljD2RmdksI9yJOrpbaOzgchRzTSWHXaOx1KJHyS6k87JiytHUx2895pi69nKQfV5jQKvtSPJgCSTUY1xDgwppPipFibxz+BkybbXuWeMXYcMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKorE9QM5y3MW5vMTEO6IUndnlNb9oR+pR6c9IyG80w=;
 b=cxdIJrzDuJ38GQwK9JFBRPEwB8Jw1bS+1S5ceQ9bnnC7KkCtwBzpF8AaAIAFPXMyllttFyXiSPZ3P/l2WBig9V6yd6JWiOntWhCT8pa4Uq7KDPIuXagksUBFKjTAa4oxxXpyT0oWBmM3MdyObnyBiHTD9ex82+0+n1RmyeGtxpWYW8+XD6aQLT+Mi3oZjxL/gaXOBPun12vX+QrNe22vqB8ASObWzWyCLk3v4cBjSrkCcObwQbpHtDzr7sEYL1LgxEMwZTwfPWhjhkRRWg+Ouz1RoIzkoHhYVBIOKGWYswsoHiJwGl7rWHf0pvtZU7ablVknO4uQbtpnUoNyJp+EIg==
Received: from BN0PR04CA0061.namprd04.prod.outlook.com (2603:10b6:408:ea::6)
 by BYAPR12MB4981.namprd12.prod.outlook.com (2603:10b6:a03:10d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Mon, 28 Feb
 2022 08:49:04 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::ec) by BN0PR04CA0061.outlook.office365.com
 (2603:10b6:408:ea::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Mon, 28 Feb 2022 08:49:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5017.22 via Frontend Transport; Mon, 28 Feb 2022 08:49:04 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 28 Feb
 2022 08:49:03 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Mon, 28 Feb 2022
 00:49:02 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.9 via Frontend Transport; Mon, 28 Feb
 2022 00:48:57 -0800
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
        <msanalla@nvidia.com>, <oulijun@huawei.com>
Subject: [PATCH rdma-core 0/5] Add new bitmap API
Date:   Mon, 28 Feb 2022 10:48:25 +0200
Message-ID: <20220228084830.96274-1-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 246e7017-01d8-4d24-d3dd-08d9fa972c88
X-MS-TrafficTypeDiagnostic: BYAPR12MB4981:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB4981BCB07C510750712A4E47C3019@BYAPR12MB4981.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UTsUVLGm6tyGojihj4S10Pew+2faL0ltP404/vct82Ocp4H9lzFJ3HjJakW4cQeYAG0LkG7NasaTxhdb+1cYcnYgvsALVvow8hgOjhaZb//s6zw39f6HbcZW67/sgFB7+06Z8RNRT5AiZDvF7eqc1PEeXGczOoeIcqZcV6POHrb9lrlWDFYlANZtXDPdPcM6FAceSe1lNxwlWhBFUaUhZMQjg3GG5k3rMkpKN7Edg4btJsJBrvjI/M+9rl6HnibEiPNt4ltHY9PfU+tgZ72iCWi1xCliR3tM7ppdQWwlc9H3pfUBjqLPo73yK+2mzT3mC97vphj1yi+nHAZZ1iiO2NSMmQwN6Ek7Yw6lKQvTIuanvQpx1W0r1TksFUVfAgsdijzUgXTAWAaTJnFzbV9PknZjBZm1Z4Q60Ec5OGiR6LADUAJJzpeX2AmZ2MsOmregsroZgW/QnwBgOsWxj9aj9i6i25vQ2PaHzS8IXnAscMl7edBrVkX2Uf0iH+wS01k7/pbwbvBDmhwQ9NjsVyz38RczjHqjxfqKzqMNzPS9V8dvWS0WsPHL33/m7GwsoBmJiXO01QKEgKDn7zDAxCeL50EofH+dVbshCjI08pNRUWexxCfVCD1iRfCOCHfwKJgff51exGSAliPy8LBG2QoKKs9N0Z62xN5oRb3/ZBdQdQn5Qv0fd925n3GPgrllv+2G96e3rEqRwGbDL8MmeLV9GUuRiISWAxRclwUQsqLgHJyAeSny7QFFOK86qXHEedAZes6TCo1x+ttPCsHIFmd8eQ/fOxTIrLVS/YCy2VXTBrk=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(508600001)(336012)(426003)(36860700001)(26005)(8936002)(40460700003)(5660300002)(2616005)(186003)(82310400004)(83380400001)(81166007)(356005)(966005)(70586007)(70206006)(54906003)(6916009)(86362001)(47076005)(316002)(2906002)(7696005)(6666004)(36756003)(4326008)(8676002)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 08:49:04.2243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 246e7017-01d8-4d24-d3dd-08d9fa972c88
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4981
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series adds new bitmap implementation to util directory which replaces the
ccan equivalent.

The ccan/bitmap stuff was published under the LGPLv2+ license which is not
fitting in rdma-core.

As of the above, the applicable bitmap code in rdma-core was adapted to use the
util new API.

PR was sent:
https://github.com/linux-rdma/rdma-core/pull/1144

Maher Sanalla (5):
  util: Add new bitmap API
  mlx5: Adapt bitmap usage to use util API
  libhns: Adapt bitmap usage to use util API
  verbs: Adapt bitmap usage to use util API
  ccan: Remove bitmap code

 ccan/CMakeLists.txt           |   2 -
 ccan/bitmap.c                 | 125 ----------------------
 ccan/bitmap.h                 | 239 ------------------------------------------
 libibverbs/ibverbs.h          |   4 +-
 providers/hns/hns_roce_u.h    |   4 +-
 providers/hns/hns_roce_u_db.c |   4 +-
 providers/mlx5/bitmap.h       | 111 --------------------
 providers/mlx5/buf.c          | 187 +++++++--------------------------
 providers/mlx5/dr_buddy.c     |  12 +--
 providers/mlx5/mlx5.h         |  17 +--
 providers/mlx5/mlx5_vfio.c    |   3 +-
 providers/mlx5/mlx5_vfio.h    |   2 +-
 providers/mlx5/mlx5dv_dr.h    |   6 +-
 util/CMakeLists.txt           |   2 +
 util/bitmap.c                 | 180 +++++++++++++++++++++++++++++++
 util/bitmap.h                 | 120 +++++++++++++++++++++
 util/util.h                   |   1 +
 17 files changed, 362 insertions(+), 657 deletions(-)
 delete mode 100644 ccan/bitmap.c
 delete mode 100644 ccan/bitmap.h
 delete mode 100644 providers/mlx5/bitmap.h
 create mode 100644 util/bitmap.c
 create mode 100644 util/bitmap.h

-- 
1.8.3.1

