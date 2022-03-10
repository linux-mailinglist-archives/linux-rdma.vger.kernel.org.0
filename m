Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B224D41DB
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Mar 2022 08:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240095AbiCJHfB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Mar 2022 02:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235458AbiCJHfA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Mar 2022 02:35:00 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D1B7892C
        for <linux-rdma@vger.kernel.org>; Wed,  9 Mar 2022 23:33:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1FjFXW+E17jEamjNoxWRIWC/G6RG616JZ5rg3gPDZDsB83fNZ1bEkoDGXXo7B3m+NRd1jQZCM+Ah783sXgMojBBphZqcrDDelm5IJtdUvf7gAEcs1tqn8Si+atx/pLHCTfW3PpoZ9asNAqobP6awsHAXqXO7OiNpgD0rNfkwR3/7CQehzTAdFgEBmB6n2wixpwsnqppyxLkWg0tHkoxRTxFhKysPDPXmfVmwpb3Tio0b0Ibk218YaJ897ZZuUS639AIhkZ5AVPrgfcEuiTAPUbRYKz5b6qCktFosBYOCm03RReIBVnz13h+seiy1VQ/2sFC6QeQDzIo3hyhLTTidg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kT+w05G5HIjElWMTjviTl627nCoYD/EgWE8cNXdxUv4=;
 b=HIvGpgQ0kcQBmtR/tZxBoWXa99Mc5ekB6lx5ojHXyI9u8CKZhGfc1VQSkEJSCMnMR6AUWSh3AmirssWvMi8eYlE9VOFu+ShNncNUh9fhvm8bwzqO+tJHbsaVgoXDmfdvivCx0jisw5ByfeZIbrYRcM/vIPsAS6jbQba8o8M929l7q/9X4Bu/L1QBXTrlhD/YFdeqinW5iQviZZkW/89v6EpaHtcHk22ztk2KCw7du0+X4bA1wEpWaBQxL6ZlKhYseX8d15tN5cUy8gAAe5jF7tRKb2xLht0nTpUBCwuLB83mfKly6fxp9xwM2HR/rDavqQPh4RqUPFe4YO1xduq9RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kT+w05G5HIjElWMTjviTl627nCoYD/EgWE8cNXdxUv4=;
 b=ZHxWjcpOSUg0GMHO0k66uDY3/5rjjl9iL8BlVGjxtNmpdsJzeLeupsOQ6nh7fURyPsW0Ev/YSRcMPgLngkHKDe592UAUbsiXdvHibRQqQRWq1/khpuxbIemq7BHbxVDfMxpQ8ihLtlLHeay2Jbdx9F9tKS9DRtFJg/S7yImzOTuvT24UMTjxW6aeriAcXW1SOYX9JZLKuKO4eh6r4g0aiermJSEU4c1xD2II9WXMPcWi2reNGq1DGD5I1vWp0L+NavVpPqcmB0whVdCNq0Ki7uqJhVbt0j6uSwUNclcy0q9o2LqhZ0HB2pWKXXU3trIdlQxX2l4bTUZUVkG1A1C9NA==
Received: from BN6PR16CA0003.namprd16.prod.outlook.com (2603:10b6:404:f5::13)
 by CY4PR1201MB0262.namprd12.prod.outlook.com (2603:10b6:910:23::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.20; Thu, 10 Mar
 2022 07:33:55 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:f5:cafe::c) by BN6PR16CA0003.outlook.office365.com
 (2603:10b6:404:f5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22 via Frontend
 Transport; Thu, 10 Mar 2022 07:33:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5038.14 via Frontend Transport; Thu, 10 Mar 2022 07:33:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 10 Mar
 2022 07:33:54 +0000
Received: from [172.27.14.4] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 9 Mar 2022
 23:33:52 -0800
Message-ID: <90ad4596-72f6-c5e3-d168-f7cabdafec7a@nvidia.com>
Date:   Thu, 10 Mar 2022 09:33:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH rdma-core 0/5] Add new bitmap API
Content-Language: en-US
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <maorg@nvidia.com>, <msanalla@nvidia.com>
References: <20220228084830.96274-1-yishaih@nvidia.com>
From:   Yishai Hadas <yishaih@nvidia.com>
In-Reply-To: <20220228084830.96274-1-yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8496111e-e594-48a8-9744-08da02685541
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0262:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB026234E0FC468EE271C77CF9C30B9@CY4PR1201MB0262.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rGkmWZO9uHty5gn8jt9XtGFjr0d/LiLUlVHkX4sLZnVm1MaGuYaQuEFAMAqgp8nXPdcv1pJ8wHAgPXp2fSu83QJN+ZNZuHEMA8sbvTc7vRWvb4wypajDbwb8Ko1GKQKpf67H9to8gGGbo7czUDuvO999YEb0Wc1A0NwG3g4xMcV0ff37Rm3FF/Awv3nRnv2zosBvqHHrzdrTc3nI0GYycTJ8zSL0KLtpGYSor2ustvp/BVpfBVN5VBpgvNywiYmB4FfMY43hfKwh9bSP21j5+2oFalIKoW6WyV+VOOv8TFEDCMeLl0sMDx48/TJeEPOR9YH7vCjMpR96pvvHHZM6jcbIptdk0og+ugg6i0zRl5UVfz9gCA6xt1o2zoRlKZoSaZRPnravE/MnyNO2cM4Uboey9oNojPdBLGyy94X8M5osdouOP5mQdstDY23JlHHxriOz2G3OFquY3E2AWgp3TOIcnsgHoQggjNmyjvWvYkFSIUSkpK1i5/w/OAiZCf9WiKH4dxx2c0fyh7XCzlFF1QBmes4gdz/yQsb4oPkKUkVlURwHUUqLHY4eWzzdNDAZYtDdPLmULsuRAuqibKirFQwUYK+ov4IoErjrEo6mTg4VSqV1b+5C90uVzDGQK0vdQcQeyqaYJoaVODtfFfyjbwIaaUmKyHmI5w8hUfTmPgf6WD3i/WtAT1ANrQtmVn/YNQZXykug6HRxRe9bwkk69uZPkVcSkVvL7S++0LXQGg4QyKS2sUoDiKk3e0umCXlCTzqEWCo6NtSxeOXI1AMKfyMkhdhfjcr1pw3dQYMBZqQ+R5VHLfCNGLD0FzL1WlNN
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(81166007)(47076005)(16576012)(53546011)(54906003)(5660300002)(4326008)(40460700003)(316002)(2906002)(31686004)(83380400001)(6916009)(356005)(8676002)(426003)(336012)(70586007)(70206006)(16526019)(36860700001)(82310400004)(966005)(26005)(186003)(8936002)(31696002)(86362001)(508600001)(36756003)(2616005)(107886003)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 07:33:55.4687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8496111e-e594-48a8-9744-08da02685541
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0262
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/28/2022 10:48 AM, Yishai Hadas wrote:
> This series adds new bitmap implementation to util directory which replaces the
> ccan equivalent.
>
> The ccan/bitmap stuff was published under the LGPLv2+ license which is not
> fitting in rdma-core.
>
> As of the above, the applicable bitmap code in rdma-core was adapted to use the
> util new API.
>
> PR was sent:
> https://github.com/linux-rdma/rdma-core/pull/1144
>
> Maher Sanalla (5):
>    util: Add new bitmap API
>    mlx5: Adapt bitmap usage to use util API
>    libhns: Adapt bitmap usage to use util API
>    verbs: Adapt bitmap usage to use util API
>    ccan: Remove bitmap code
>
>   ccan/CMakeLists.txt           |   2 -
>   ccan/bitmap.c                 | 125 ----------------------
>   ccan/bitmap.h                 | 239 ------------------------------------------
>   libibverbs/ibverbs.h          |   4 +-
>   providers/hns/hns_roce_u.h    |   4 +-
>   providers/hns/hns_roce_u_db.c |   4 +-
>   providers/mlx5/bitmap.h       | 111 --------------------
>   providers/mlx5/buf.c          | 187 +++++++--------------------------
>   providers/mlx5/dr_buddy.c     |  12 +--
>   providers/mlx5/mlx5.h         |  17 +--
>   providers/mlx5/mlx5_vfio.c    |   3 +-
>   providers/mlx5/mlx5_vfio.h    |   2 +-
>   providers/mlx5/mlx5dv_dr.h    |   6 +-
>   util/CMakeLists.txt           |   2 +
>   util/bitmap.c                 | 180 +++++++++++++++++++++++++++++++
>   util/bitmap.h                 | 120 +++++++++++++++++++++
>   util/util.h                   |   1 +
>   17 files changed, 362 insertions(+), 657 deletions(-)
>   delete mode 100644 ccan/bitmap.c
>   delete mode 100644 ccan/bitmap.h
>   delete mode 100644 providers/mlx5/bitmap.h
>   create mode 100644 util/bitmap.c
>   create mode 100644 util/bitmap.h
>
The PR was merged.

Yishai

