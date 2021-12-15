Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C23E475A0E
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Dec 2021 14:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237615AbhLON5a (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Dec 2021 08:57:30 -0500
Received: from mail-bn8nam11on2059.outbound.protection.outlook.com ([40.107.236.59]:19297
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243038AbhLON5a (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Dec 2021 08:57:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dz/sq5yDzM6rxP7yaXE4j23fwL2qplj+xkAR10P3zTyVPtykkfnPME/sCfsBE6+XaOm5n1Zm0r3VcExpuu6YtoHpAF6kOmSqjHSQb1Eh8Xbzqf+an323+oHqzSSvAzKUiA+XVFKvqhIthYlgCcGp4nL5R8tbcs5mmeOz2pJy8lgrY2Zqn411anlkPK+mZLr2N70p0zaLZ+QF2mlB6f2lgnNYTJveZkm/LkpQRA04w/4XmhMXqNRgXlUxfY6R6llPO/01FxyfrANxNotAY+EQX9M+Bicy2xokECJ7aQLoanR0Shyejan99n1ncGLKEIG8P6heI6f/NbX2imK71oJlPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MF/acoWscqmqDcWV0J1qBKGWs/rM+NsXoMdYM7IljOg=;
 b=WEDeh9QSrzcPtINAp0sP8Lme52/lpJ9kHBMB/Z9W8XtovWfQITRDiIbwhyutRQ1Cc8NaOdWRIafcPuYZPHPttVy7i9RxPG6YhVYRFO2/NeG3gKhuxVtJxeH5c4C1jAWLbc5G2vnfQ86+AA8b61nNzyqxsgYOujpCTo4i8Acydw8bJNM8WWwRQWaeZD7jepEk1vzJRvH1v9Y7WNTYOD1vSEWnhy0Rb//l7Xk7LDtdb23kFX1aKdoli2gI/8Tjy3fUd48Y1dI9lFcy/gjBntfMnp1tpwizyRJd1wtiIUp15vIlbEptmV0J9nutDD8AGDB7JnGPLUQ48FrbSNyMJ1ob8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.14) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MF/acoWscqmqDcWV0J1qBKGWs/rM+NsXoMdYM7IljOg=;
 b=mIFGtMz91WRxouM/HESr7MDR4i6xjwRX8kgkbx5jPCg0bw5o/xz9EAh86ybKDXHtOSDQCOkQndZhGQ7SIkzR5Ue+ptSYlHD7hDQ9Iqhcvg45oNq38PDFgp5QFypi+UNB1SuqO0UDGKAHoTyE6JfkP4DO7njB4zFUcgov1KH9caBmH9NyDKZiT60tfFu0ZLGm8knrWIij6OK3SHrMm7SzZO5te3oVgmR1rE74a3p9ooWDAB5dFJLggMqGq3hGUixOZrefyDDqQHno+NBtJMeq8Y7dS1R3isMTwyukLqiVED2Oqi2DFBuHu63zBpQLSQHzOC70W0As1fpA0hqmXHoVRA==
Received: from MW4PR03CA0123.namprd03.prod.outlook.com (2603:10b6:303:8c::8)
 by MN2PR12MB4607.namprd12.prod.outlook.com (2603:10b6:208:a1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Wed, 15 Dec
 2021 13:57:28 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::4a) by MW4PR03CA0123.outlook.office365.com
 (2603:10b6:303:8c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Wed, 15 Dec 2021 13:57:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.14)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.14 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.14; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.14) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4778.13 via Frontend Transport; Wed, 15 Dec 2021 13:57:27 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 15 Dec
 2021 13:57:26 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 15 Dec
 2021 13:57:24 +0000
Received: from r-arch-stor02.mtr.labs.mlnx (172.20.187.6) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 15 Dec 2021 13:57:22 +0000
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <linux-rdma@vger.kernel.org>, <sagi@grimberg.me>, <jgg@nvidia.com>
CC:     <oren@nvidia.com>, <israelr@nvidia.com>, <sergeygo@nvidia.com>,
        "Max Gurtovoy" <mgurtovoy@nvidia.com>
Subject: [PATCH 0/6] iSER fixes and cleanups for kernel-5.17
Date:   Wed, 15 Dec 2021 15:57:15 +0200
Message-ID: <20211215135721.3662-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e199e3e-4187-4b2e-b7cb-08d9bfd2d476
X-MS-TrafficTypeDiagnostic: MN2PR12MB4607:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4607E66B7E338FE808DFD440DE769@MN2PR12MB4607.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 52OQIkBwY2zGZAshQNoUTq9SuUjU6OIIMoby7+23tZjjWkmsDhZ4qtVNPN2Tqib14lc1O58h0g4Z74/YNl/03OPdbmw8yCfAVqKd5FQ8UKX7UB/UYqyOfdUr1LWKJSnwG486nGcsnT4Mo6QrjaWovUCrW4Xun/N5jL6vswzZkXwtcIRysSHVsDOpgugu5sT/W5YerfL18tyui4O3R7xtUjrmYIe5Nmq41ed5c4p2SdxpD8WYOKc2A+4L/7btJU0JDDFxmEOm/XjO0YWHcfkGo5HQaai6Y4x/rDvrGTtiOlvfFzAQRZy7NbfnCwChVwsc0CU1oilCZ4ji/1mwQeWBaPhLZX1w9v0HzoD8fHPjzSKIb6WE72b2sJq/jf9XHEUMCpeB9J7eLV8/I3Dm5saw7EHRxut33Av3N1OWdcGfylFfWoBluBlN7bvG1o8Aw8Nbdyt5hKPDCfTMON/FZ6eWAp4qRbQJwQNKjtUoc9aMOHIA148wlRSm22GsMZStXP+fgsxMBSUIbMXm68pLJdFtMbcdY9l5bdDLttTTu2wsS7tCNbAuCGWVWAz06kHA19bKHW4d1TMFeF4oXgieRjjErDE9cmh/+wegngragsCTFEQeoo4/oLnNfV9vmi16+rs0KOrwl8U2kruHx4FBgqE7OtXmkRkBytC0OX4XGzTsL+3SFJN8s/WmmLqk9V/Q5Ee7/xYYoawdsEq6kT9IznJEU625yM281RYJC+dMlrJyLhCfv+7JodFHed0hMOf/byT3F1TcsknbhkjG07p8cFo4HinUb49/RWEBeJ3zevCk5Qk=
X-Forefront-Antispam-Report: CIP:203.18.50.14;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(1076003)(6636002)(8676002)(2906002)(47076005)(4326008)(186003)(26005)(5660300002)(36756003)(8936002)(6666004)(110136005)(54906003)(316002)(2616005)(36860700001)(107886003)(86362001)(356005)(426003)(40460700001)(7636003)(83380400001)(34020700004)(82310400004)(70586007)(70206006)(336012)(508600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 13:57:27.4786
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e199e3e-4187-4b2e-b7cb-08d9bfd2d476
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.14];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4607
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason and Sagi,
This series is the first fixes and cleanups for iSER intiator that we
aim for kernel-5.17 edition.

It starts with removing deprecated module parameter from ib_iser driver
(patch 1/6).

The series continues with a patch (SergeyG) that fixes RNR messages sent
to the target HCA since there are not enough credits/space in the receive
queue (patch 2/6).

Patch 3/6 is a simple renaming patch.

Patch 4/6 is a preparation patch to eventually guarantee that the HCA
will never perform an access violation when retrying a send operation
(same as done in NVMe-oF).

Patches 5/6 and 6/6 are some cleanups and coding style fixes to help
maintaining the driver.

Max Gurtovoy (5):
  IB/iser: remove deprecated pi_guard module param
  IB/iser: rename ib_ret local variable
  IB/iser: don't suppress send completions
  IB/iser: remove un-needed casting to/from void pointer
  IB/iser: align coding style accross driver

Sergey Gorenko (1):
  IB/iser: fix RNR errors

 drivers/infiniband/ulp/iser/iscsi_iser.c     |  78 ++++-------
 drivers/infiniband/ulp/iser/iscsi_iser.h     |  23 +---
 drivers/infiniband/ulp/iser/iser_initiator.c | 106 ++++++---------
 drivers/infiniband/ulp/iser/iser_memory.c    |  60 ++++----
 drivers/infiniband/ulp/iser/iser_verbs.c     | 136 ++++++++-----------
 5 files changed, 156 insertions(+), 247 deletions(-)

-- 
2.18.1

