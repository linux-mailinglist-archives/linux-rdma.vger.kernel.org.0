Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6BC4D2BB0
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Mar 2022 10:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbiCIJWU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Mar 2022 04:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiCIJWT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Mar 2022 04:22:19 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AB61662E8;
        Wed,  9 Mar 2022 01:21:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mISzEt2kpLDxVrMYB0LqVDSxaufEiQuG4JuBl8KyN2MrU7UxqRvSKMgLAY7ABaaylFe3A05CkP5wfmlWwj/7Hj9GyK1LT56c4UJnGeExMM+r111kqnO+QB8MDPYzg1o9qTHk3YKNPqSZCTZ0wGbf/hEF/tVWU84/zEi6eb6rfUwa0VR9rTlxzaGgaoW4jqNMAONyZybnpW76ZUNvGH7FMAczeqys80j2D+0eyv3Fp5hJJSoUvkTZ95ZY54DqD7Ja3sT/BjI1+tAb9fBo8dfhtYtQmGWSzZR7jTb5WoIA4T9OV7tUvcvWyIeqHBYeQ/QcFd1GVq60i1/cjaqPApMhQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vpoPLcwFCcskhEn8ed6SuoZpzlZoHjG0uOch9AnvSI=;
 b=NMYL9qJ2QPFmBvYLSFFGtIYyb8rkTAYR0NZkQfFGdL4i7SLngbxcj3ph8VpzRFHrIkEEL6tYJyvrhQScvJpV7cYP4qAzKgqwHdGmBN5FcHO4rtx0GWL+5ZE1fR6Oru9O9rwUxiUsByiBllN2H8m1z5ADrrZuq2ym3Kg8spfx9wx7PVF25Pz0Whxcfo4BEnrpn1zT4QW5d/Rj6OaaXRYypdCuvW8zDEA/dMnbWKZ+0hZcqpY3ZjZsLthBTJGUOrbLewlNihxzXC8ZN03Uczs9udmk8RBnEBQtNVoyxYGxWYB0FrKXaU0m8viLWjf4oVzXeGP0a4RpRIx4xbnCSunzBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=cornelisnetworks.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vpoPLcwFCcskhEn8ed6SuoZpzlZoHjG0uOch9AnvSI=;
 b=oxAa/YD4x0nkfO8pNv+7R0zZbOQY0Jx4LkwpzpXYZwsIlDBsItGXGolDsQoHGPFvDtK72aIBm7lUPFzZyxH8ODXM8RvsziFjgkVZYo6EYN4l/tttVo2633fCtcvo9SW46ZziDI4QbUTbFTiM73twehdtFpuVzCWQfo3lJOZQyf0RElP+ew8wzFf0uIEs657iRTuQ/dJI+Tu+jHPJ8E3xdtuafFjD5jIeyjC6IBgAmd6e+EeMr3vbfsA6fMc/68VII47Xqe4kArCDhm5neAu6gQFfJJujx1JK2jkP+O42bBFkoipV9m1ddYPHnfUPCfOJUh1k29SeAhx8tIikeyinBw==
Received: from BN6PR12MB1426.namprd12.prod.outlook.com (2603:10b6:404:22::16)
 by DM6PR12MB4156.namprd12.prod.outlook.com (2603:10b6:5:218::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Wed, 9 Mar
 2022 09:21:19 +0000
Received: from BN1PR14CA0030.namprd14.prod.outlook.com (2603:10b6:408:e3::35)
 by BN6PR12MB1426.namprd12.prod.outlook.com (2603:10b6:404:22::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 09:21:17 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::9e) by BN1PR14CA0030.outlook.office365.com
 (2603:10b6:408:e3::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Wed, 9 Mar 2022 09:21:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5038.14 via Frontend Transport; Wed, 9 Mar 2022 09:21:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 9 Mar
 2022 09:21:15 +0000
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Wed, 9 Mar 2022
 01:21:14 -0800
Date:   Wed, 9 Mar 2022 11:21:11 +0200
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Yajun Deng <yajun.deng@linux.dev>
CC:     <jgg@nvidia.com>, <selvin.xavier@broadcom.com>,
        <galpress@amazon.com>, <sleybo@amazon.com>,
        <liangwenpeng@huawei.com>, <liweihang@huawei.com>,
        <mustafa.ismail@intel.com>, <shiraz.saleem@intel.com>,
        <dennis.dalessandro@cornelisnetworks.com>,
        <mike.marciniszyn@cornelisnetworks.com>, <zyjzyj2000@gmail.com>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-next 0/9] RDMA: get rid of create_user_ah
Message-ID: <Yihxh3HdEqu3B2w9@unreal>
References: <20220308143428.3401170-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220308143428.3401170-1-yajun.deng@linux.dev>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b71876c-11c6-47b8-8d84-08da01ae2a49
X-MS-TrafficTypeDiagnostic: BN6PR12MB1426:EE_|DM6PR12MB4156:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB14268D113E7B51921C5B75EABD0A9@BN6PR12MB1426.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uiLZgUiW1QEf/z92deHzzdKbz4UH0v0FUxJ0yBLnWFUsBg/BUd7qHkL8gg4xcPdPfqyMovzm1dcqdQpVh+fz46JCPCWLZsc2Vf64++WTkFuHO0zgQRHpbCLB+/gO1i97A42J5jcXRTEAoRow0IGRfl/HXHC3OtcWEjK8inaM0CzmFfYeUBsLyyNyW+Jq3KTS16YY2Tt6EFhlvzXK33RtKYge3EobNFN4LO5J5u8B65VMZZbUdREnlfLPgErGxbyMXz1tSFFOvsDRGeV/QhuyAUksQYjwMPBSC403dmm2OaOcrYAavgTkyUDhKM8SSGGQKThVK3OpIwAC1Oq480r4vkzhW4OvZjSH/mnJ1R8pl/4X0endephAjBzVRqsZmbiH3x8jECbiBT1KqrVn5MPOB2pUk5sAdzp0hNQf3P7VEbXP0rsRmPWtC66yfzIwK7HWLiZDWApqHz8leV+PbEUQML4763C5ldKMYZsZaIU5qhM7tKHN48Zx2aJJrX6OBrkT0AJ+OUExBe1qjYfz6BxhuZr/fZZNl2ki1bF7YbO4QK5/Y1tG6qYHggumtqgzxPXE4syHE1hIKHBOqoPgd4u/HGHYqANa/YXZ7NotLJcU5ir6AF0mnsX8CBOgQ6Vt/pnotd5IK5CLZd6XjzP+fR1QmKQpN5qM1QbL7/snu33bZKIyR/254ACKZ3BEysnuLAo0+dE3k1TsQpmBrtcJTWTnvkkMexDbuGQCTXwZL5J2aus=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(7916004)(46966006)(36840700001)(40470700004)(86362001)(33716001)(186003)(508600001)(82310400004)(40460700003)(26005)(83380400001)(426003)(336012)(16526019)(6666004)(47076005)(9686003)(4326008)(5660300002)(2906002)(81166007)(70586007)(8676002)(70206006)(4744005)(54906003)(7416002)(36860700001)(316002)(356005)(6916009)(8936002)(26583001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 09:21:17.0028
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b71876c-11c6-47b8-8d84-08da01ae2a49
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4156
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 08, 2022 at 10:34:28PM +0800, Yajun Deng wrote:
> The two members create_user_ah and create_ah in struct ib_device_ops
> are very similar. we can use create_ah for all case. so get rid of
> create_user_ah.

1. Please read commit message and content of commit 676a80adba01
("RDMA: Remove AH from uverbs_cmd_mask") that added that .create_user_ah()
callback.
2. You should send patches as a series that is threaded and not as
stand-alone patches.

Thanks
