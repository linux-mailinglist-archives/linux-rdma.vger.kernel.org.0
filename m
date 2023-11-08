Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E917E5F7F
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Nov 2023 21:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjKHUzJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Nov 2023 15:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjKHUzJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Nov 2023 15:55:09 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FDA2113
        for <linux-rdma@vger.kernel.org>; Wed,  8 Nov 2023 12:55:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7OXzPocYMX9OFizUQpD0KatiwoRDA47WLjawFfmDXK4tEXCgqVJIyrDIc/xGv9p+2qqkmWYo90U/VKYTLNvMA/jM+rZgrDXffE6Dbv5BlWE6ltC8j2q5dstt1DW+FFLpU72Kb4cj9VbBiCUX7FcqFEREzGgjmt+x2qTxCzDeTSfAkpQ1lDv6mtzvjdgpASjVOt1PkcnK8YSGjIG5cglZbg9vPvZ8M/E32fBpw59WDHxUh1r5bgyW1WqP9xdh/SRd2PD1lKWptGY5ZM4eAEpg7ty0l31UhDRQpOw02GkYYBaVSMIQIidyhbTkL/h+hEAYKk0LiuUCurm20AfNWw5OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+O08z54mvPSqvPAAQGEKHXyyVBA/A9PwERI3ChK1M6I=;
 b=DprWk5zO1RUZNimvjKAd590LioyoyArG+nOUrJA29G8muW2HtrY/cjQB0ZuczBzklwAyd5Ixy/Mnm0ZcFeoS3Iy6QVBpNDnmXCFFpqaC1NjYKgJ6LV2MTrV1otI7USmfDnUBRp8ONdnlraRjEXGP2pToNpr8aMaJxCWGx9TGX4ROuugvtWRAxapK+41JCEFoEAAPfcuHIxK/RT5PPsKUnoWjuEIaJ/rGxefioWpi8V+TfIWFkdXu7HjOyBn3npFjIjXzG6RjdiFVkDecVppO5K2k8/vTHMDZ2/tRX3AEVKDFD97wNG9nXve86ERg9NC8r8lqHmPN8dGYOONMB0FuLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+O08z54mvPSqvPAAQGEKHXyyVBA/A9PwERI3ChK1M6I=;
 b=eLqz+eOOL+nhIcN6xMCVtp7h/6OThqS0+K/nmM8SUgXXXWnHgaLV0ee891230GGwTJp9XXbb/ep5lQjtKuKUor1QgztkWZqs3sYUwV9aRPj7e2zQm8vuN5vW/6rtidXi+tXR45WZ8wizCCd6TmscKv/YD3Ot7tizuWbDJsV7TMhHVsPv5AeLNWOQ7V9otpE6jTTfHtsydfnTzuJOxNzHVaCI5+5zLIYV20lF1sO03RmuCkZMb+/+KS9vLhamzgbuvYblpgMN8lCIKyKx0Uw32g3LEx8DHNtVrA7E5S1zUWJyIoD5wX0vNK9k1EdDZ2bk0PFdcDWLUHSIOvKYFuCZ+Q==
Received: from DS7PR05CA0064.namprd05.prod.outlook.com (2603:10b6:8:57::26) by
 MN0PR12MB5908.namprd12.prod.outlook.com (2603:10b6:208:37c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 20:55:02 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:8:57:cafe::47) by DS7PR05CA0064.outlook.office365.com
 (2603:10b6:8:57::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Wed, 8 Nov 2023 20:55:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.19 via Frontend Transport; Wed, 8 Nov 2023 20:55:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 8 Nov 2023
 12:54:50 -0800
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 8 Nov 2023
 12:54:49 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <loberman@redhat.com>
CC:     <keith.busch@intel.com>, <linux-rdma@vger.kernel.org>,
        <kch@nvidia.com>, <linux-nvme@lists.infradead.org>
Subject: Mellanox CX6 and nvmet connectivity failure, happens on RHEL9.2 kernels and latest 6.6 upstream
Date:   Wed, 8 Nov 2023 12:54:34 -0800
Message-ID: <20231108205434.5284-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <475a37e920badad12a0d71fff65e817979417594.camel@redhat.com>
References: <475a37e920badad12a0d71fff65e817979417594.camel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|MN0PR12MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: 125531b4-41d9-4a0d-1e4c-08dbe09cfa3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: prMIe4v0hU5c2grX/wuAPFAVq5zX/nX5efYmBPhJmMC79rieZNGgvj/Zu1IAet9oHvk+unhxE5cbmg4gjWSIVBkV2TYtfvR8i3jeiwOTzeFZ/KZp+0c+cPi+GZeE1nIIPDAWxud6yrYZRzWlIJicjx0bxBf8lMshM0jH6gEz4UcE8uR6472h81qSwmWvUTv1IlxEOOSoItJ2X66cMCKEDlA9IV62+VkcUmSHqpiY3MDsIJ9cDLxJN2i8Zqkmn80RG9m2C/8lg1d3qd0A1ti8M4AQOUoVK+vtONT5HXLAUidx0AWwvHV57rv3+9PObsNjjZ5JxP7O5FfVPfqiKoSdCD7i0/jz+AgKww/2AePIvCJMcuBdFIq20gNd9zildyoXZ+lowagvVWLkhIK+Pa5F+tPfsNsDi1vh0989zNM3b/t9H+0bJmEnn8xQwT/h7coDuZBiV7c0emPMbRc/z9CZCwlnj30K3aFcEfUNN0Qz0tDX4Hy0wkSXUNuQcfEUSJcFJWVmi3HRcQjF1/2v0LpaXveiuYpl/CKweRzlkWBsCd2o2+0CpQiYByGWHLdDtlLlJT6Tc9T4f3Cbhwm8Kl5zQSQXWfNLCafPGqittUhSlMv+BFbVASzGBZejos1yB85qKLs2E+MiYPy9ABJw9uyoksDeXZenlwatTZybaEw9n+R+MyWVBfBOfdNHYwJQ6T+sYSJ3++SNk9uuxROVBXtYm3nf8t9/EbrL1smMN8VYqqO3/N9oG+RdE85vXPXlVw64
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799009)(46966006)(36840700001)(40470700004)(19618925003)(40480700001)(40460700003)(41300700001)(16526019)(1076003)(4270600006)(426003)(7696005)(47076005)(2616005)(6666004)(336012)(26005)(7636003)(36756003)(356005)(82740400003)(8676002)(5660300002)(4326008)(8936002)(2906002)(558084003)(316002)(36860700001)(54906003)(6916009)(70586007)(478600001)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 20:55:01.8855
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 125531b4-41d9-4a0d-1e4c-08dbe09cfa3d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5908
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

adding linux-nvme to the discussion

-ck


