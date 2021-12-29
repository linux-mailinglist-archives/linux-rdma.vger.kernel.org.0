Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717CE48111A
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Dec 2021 09:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239411AbhL2Izk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Dec 2021 03:55:40 -0500
Received: from mail-mw2nam12on2041.outbound.protection.outlook.com ([40.107.244.41]:53601
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239391AbhL2Izk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 29 Dec 2021 03:55:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSD/cr04pY7uK5oOmRM4v0cwwB5s8euH2A3IVDlKYaAtIyOhA7+YVvBfvyOIBgaPtsPCA1DkCHlKvgdip5NNkGiFGRQXUeirfAJb8Dx8T+duSbcStoyfTEjFIR/m+K/+ApaWvd67SZhqfvvn+oqcqBl40aRxONyZpixkG2+wHDLFb9PVQ72Y2ZVRpugnvcK88dQrTbbBkUz+ukWjYRP2TGJ80c8Y6DZYG+5fdu4qokCyR1q4u38q5Guf1/jtVa1Vn/v0nVeYM8wZzZnFiYIqxdikKZerDXDdLhj3VAkXGQ2qiMrd/pG0NEUjKpaGdS5AnojG+/5Nk002JtjBjqkOYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMTnnH3T/yxJ/+k5yz+eYb08LzCaYHgYFltCMGeb4c0=;
 b=DAaxR2Od1T5WF2CQrU/oB/3O+aMHtxutlbd8WU/uZRTSL/R2g0gDoc8IN7qN+gIC4xRFlnUnUbe6+AQHz0DE81t37h5GgnToGe435whCRK582XLmXaG8lJ6ShWuFTa7ihBXvIkwuLfWMCzQtQndoa+jzvPRHue5CAuTC5FuJIxZbuMxKWkZHSarXm7Mmi0lLIlpqXdPM5eTiYgrwO9FgMW6c3o6eBM9LC1XDx32HIGFO9yUFrEgi77LPl6Awyt8teJKNIM/3lmx7pG3whFh3CqnGQHuN5V7qvTHFdVaQsEFfQPiKYfIWk0VT5fBIcHXI/xDwYGNYDewLjKVMy/ksMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMTnnH3T/yxJ/+k5yz+eYb08LzCaYHgYFltCMGeb4c0=;
 b=C2+6i5qzxexPLP8sKwKTqNrghG/yukWbFStv8OfwmKO/qKwBmZvRi+td7MVEapsexkz5xBytym6l887filS39rNSkvfpzF0WkM7wJogWFP9uNFfOxKmIq9ndBKZJ5LM7lsM/5J8MV2xcX+dkc4JbtoITUkeMrbpIee9Ykmac/quGeeFIUZfqfUdabS5G1nmj5dW4lOyFGEIwLexGyQJDHcnUv64flJbYVgo9c8HuJ9URe/F2lktFXNKCDr0sA/1g4VkL0QCop+KpkgvZAnQ52gXHSeycesB1GeMiU9GfSrxYMK9lgfkwp2imbhWAc08rnSsb9rY0r1zhMzMnBzQ7gA==
Received: from DM5PR07CA0162.namprd07.prod.outlook.com (2603:10b6:3:ee::28) by
 PH0PR12MB5435.namprd12.prod.outlook.com (2603:10b6:510:ed::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4823.18; Wed, 29 Dec 2021 08:55:38 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ee:cafe::c1) by DM5PR07CA0162.outlook.office365.com
 (2603:10b6:3:ee::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.13 via Frontend
 Transport; Wed, 29 Dec 2021 08:55:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4844.14 via Frontend Transport; Wed, 29 Dec 2021 08:55:38 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 29 Dec
 2021 08:55:37 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 29 Dec
 2021 08:55:37 +0000
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 29 Dec 2021 08:55:35 +0000
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
        <msanalla@nvidia.com>, <edwards@nvidia.com>
Subject: [PATCH rdma-core 0/3] Add NDR support
Date:   Wed, 29 Dec 2021 10:54:59 +0200
Message-ID: <20211229085502.167651-1-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02edd38f-b00c-4c64-aec1-08d9caa8fc10
X-MS-TrafficTypeDiagnostic: PH0PR12MB5435:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB5435167530914505C2EC24D7C3449@PH0PR12MB5435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FioAhn+r3JF9c3rYGIH4Rqrn8Z67JQBvlk2TfC0pxpe6Ykqm1h40xrzIfWQyPnjbtYFdxlfe+Ctl/AH+mXdEC12AKu6LDPHLX2e2BNGY+3nOH8p0LukpI1d08/+LZCKVNyRvTIw+njiUv2iiWNcD0Kt4udPlTDTN0RskuNne1QFC6+Fh0lFuivH7/Wwrou5ka+0+SJx6qkl2OePX8cGPdD24yyUF0VZuansJnneR9WCXbsGS2Va3BOgkrppDsCyl5DLJ+AQSY9YqiAV5DCWY80pnSsQ9gJ0ClR+FItlgkHAzJsEoy3nisQisF3KoI7URrsvmtIf675RTCynQT6m8pPdRayEr5+X2QItJ1SPAQBh0hpyYHI7ZppXcApQ0lTfKFC9JLqV3gshtxRp/N+uF0j1YsSaUC+JO1Lvc3lgjT+q68m4C27W7oxq3iYAtlRoptpK7zjhj/rRBJbrpfgxAPERLoL4AtnyQDUzEUejjsGMCgwL2MBYb2rqf82JUqX+uEpl+xZFYu8Nnt53zSOlYzVe+N4OOsfVbFmCgMtvCqmIbCVg7bZbNm+nGBckqNVnnX+WGRDxOMut6JNwoGsxJFQIIbS7ql1eSPGSH2V+FHcbtZSz3TRi5GSr9UNLR5ToOjsPh8+h39o666EcuL9b+hSbSgHtK+xqOKcIk3X7S/XjBff+YlseQbnelWUtA746ZfOhAHH4VnGOvoPZUURDh0NSW9zoZW098GpGOU1MY93EZB8rVnlka1JsDDnvtI1wEhiaVuigGBiP0KrgnztQ6DmKnOeNqF323XmNjWL0WYAyrFne5LibbQ9zUIg32EIoVyVkRI5DE1IJ5Gn6VIY8K3PdW2vd/4wtYotdrstBDYl+tqfk3P34DV2bRPj35ecKx
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(46966006)(40470700002)(36840700001)(8936002)(40460700001)(2906002)(26005)(4744005)(70586007)(70206006)(316002)(107886003)(19627235002)(426003)(186003)(336012)(36756003)(82310400004)(2616005)(4326008)(81166007)(6666004)(86362001)(356005)(1076003)(6916009)(47076005)(54906003)(8676002)(36860700001)(966005)(508600001)(5660300002)(83380400001)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2021 08:55:38.0654
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02edd38f-b00c-4c64-aec1-08d9caa8fc10
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5435
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series extends verbs and diags to include the NDR support.

It includes the NDR support bit from PortInfo.CapabilityMask2 and the new rates
as were defined in IB Spec Release 1.5.

The matching utilities inside verbs to print and convert to/from the new rates
were updated as well.

In addition, the series includes some pyverbs extension to support the new NDR
definitions.

PR was sent:
https://github.com/linux-rdma/rdma-core/pull/1114

Yishai

Edward Srouji (1):
  pyverbs: Extend support of NDR rates

Maher Sanalla (2):
  verbs: Extend support of NDR rates
  ibdiags: Extend support of NDR rates

 infiniband-diags/ibportstate.c | 8 +++++++-
 libibmad/iba_types.h           | 3 +++
 libibverbs/examples/devinfo.c  | 1 +
 libibverbs/verbs.c             | 8 ++++++++
 libibverbs/verbs.h             | 3 +++
 pyverbs/device.pyx             | 3 ++-
 pyverbs/libibverbs_enums.pxd   | 1 +
 7 files changed, 25 insertions(+), 2 deletions(-)

-- 
1.8.3.1

