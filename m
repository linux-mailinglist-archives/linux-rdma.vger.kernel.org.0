Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0173F1A4B
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Aug 2021 15:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239151AbhHSNZP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Aug 2021 09:25:15 -0400
Received: from mail-bn8nam11on2065.outbound.protection.outlook.com ([40.107.236.65]:3169
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231826AbhHSNZO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Aug 2021 09:25:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqStqXVR9+L2HIUtJS7azYpq+w/+f7KLbBCI1vpSomU0J0aiMp9f9fHH7kmG9xLyq/P4q0M+vBqDzN/lJv++cCIjuG1NqEDsOaXKKkEuMK/IUd+UCLME+KQ+pPY0ume1gnlaxi/Mu3orpE7/Dsnm9IRDXgYX1lvgvbJhEjHXR33EF+WJ9VurIqilIARyDvq1F34352Y5TvC3WPZluw9qefDFKtX3z7UQf+AaiwCtxdR+Rt7RKaQVNfdx386q3piCJXfOWA8xcfCR0YaStVUv1zp9LdyAxHIwstEE8UC3khd4F6c1xHHcL/GRwOjW5RrZqPH64ex+nE1Bt/Ag/nqJQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUTfQcyz7RULNd7+paB2VrubFsFObF3hqHJuXUe6dL0=;
 b=jxSmCM0CBbeP8NDNxw+zGyP3pmtaHzbbDw3/av2P+OaIk/sP8gS+OIVSIckeRKXEWsfpcvSaeMgBdcgt6iArEmSCRXEQ1vrm5ktb0te552gZpmqOfYI/GYK3zPH13w+p7TmNc+MZuhAH5KY/kN/cRusOAxD34L/6EzbJ/9DdRrTwqk/82ZPi9HoJnXSnLUALBzhWD+Y81iVqQTZS/YNNLtYJYx+n6i/9pxLnJFjrr74hyFCQa7AUuCqqZ6mdRRXmCGMmfFNOtg7GA13CZE4XODEfitCrjMNQMs1bSJ3wVKTsx/5gWf7Ii0rrzNrNFrxYwT6cyDU9UK4M4/u4pfevAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUTfQcyz7RULNd7+paB2VrubFsFObF3hqHJuXUe6dL0=;
 b=ZPE96IgM+hitXVER8j5+EP0HPtsKp5ZN2BeVNhtSJu64CWpYQZR6R1QhLGYaydJhALDWm188EwC15X7eXBNLtKo4UO4eFhAB76Z2ye3baRVYFXt2ghChBnrVpe+rpOKRP5d5Ij7WzYo3uZoMg8kUp0Xn1mlp5juTqHnah7sSZdBpxvYcugEFzxHSri6POVwDBLdV/Ql5QwlV2CuFlVKRBnE3tST4a3rp+hl+5MCUEOpVxeQS+hNau0L7I+GkAHjPhHzKNmgAQtwVaW6K6/puhwqSL+q6t1K1EC1vNffNrQH+PZ9DdA/OfixnVoviazF4OOx5urUFNjcowqrpD6F8DQ==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5271.namprd12.prod.outlook.com (2603:10b6:208:315::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Thu, 19 Aug
 2021 13:24:37 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%8]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 13:24:37 +0000
Date:   Thu, 19 Aug 2021 10:24:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Fix crash when unbind multiport slave
Message-ID: <20210819132435.GA282811@nvidia.com>
References: <17ec98989b0ba88f7adfbad68eb20bce8d567b44.1628587493.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17ec98989b0ba88f7adfbad68eb20bce8d567b44.1628587493.git.leonro@nvidia.com>
X-ClientProxiedBy: CH2PR11CA0022.namprd11.prod.outlook.com
 (2603:10b6:610:54::32) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH2PR11CA0022.namprd11.prod.outlook.com (2603:10b6:610:54::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 13:24:37 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mGi27-001BaA-Tv; Thu, 19 Aug 2021 10:24:35 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f463bb01-fa24-481d-aa8f-08d96314b125
X-MS-TrafficTypeDiagnostic: BL1PR12MB5271:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB527150141BD8098E0EC7013BC2C09@BL1PR12MB5271.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jjcAZMTg4RDZr6wwxnOEfbAaCFlW1bNngM3xl03MCghlzJxaz/ZJTvrU0Eojabg1pZUljO4uAYWyiIuiFXf7/g66ypHnSLki6/WGDA40t1mdY1zP2V2W31dfzT3qaMwfyWMVc+1OCxsv7jjMM00Pmm1I0rpUgbN241UgNLZC76v4CpS/jcfcBu5jP5zIe0MxSQVvHRkU+S8ZYPQTS2IJrACOpgF5T/zk2IPBr5M506o0KUuQhlM/Mc+zen3SdvUYXuw9DRoF73juSoHHgRU2utfwIrwE/cfjwCPDGwR2DE03TWJg3OQ61JsF5PyQ4rCxQAPLPTifB/j3Lrvk7Rwc8vWZEILbWhnRQe+KXqr/F0yGsz0KiOWs3gRKlWDtCDKf13jCBPxI2DX99UyrI1VF4ikDe+NZ4GMaMhns5wsKjQ6qbxjzgEJPxxg0JvRpben4aXLDe1W7HKlBPdbU379aqMgIS4LbOEWMp4TXLLkYNDOj3A+x5+JFuyQWM10p0gkd64VRvrboWKXjmH4Dff/oq6zK+GR1lv2GOB7RF9rCvj8w4UVGM2e2KytKcwvk7y7XWA19N2jNkU5QrLW3O2t/42vsoO0CTTFT9GGiBzE6BKDYQavAM0C1cgvFW7d/PpTHDisYcZDn119Y1qUIVUs99P72GITMN038zoc+0PtWwJVh3Bkcu++E6/7Ue4i+hzMWhiNQ4cCor2iFHdTjVr32XA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(83380400001)(38100700002)(5660300002)(86362001)(66476007)(4326008)(2906002)(186003)(9746002)(9786002)(66946007)(33656002)(54906003)(2616005)(316002)(6916009)(8676002)(508600001)(36756003)(426003)(26005)(8936002)(1076003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yFZnE7VGKXcXuu+BXhrioggYyNL4QET8n/nkU8De77FEizGe1aoTcYr1XLg5?=
 =?us-ascii?Q?u+iR2HKurQG8IrFZIQ2bH7kQl/JnAbgymnAhpzPsIsmovm5z3P6H+scW+Q9g?=
 =?us-ascii?Q?nzjx3IxIG8loriFrHkRbZgXEa35nddv9NUzDtTWptfcdP/jhf5HZteu8bOh/?=
 =?us-ascii?Q?pQaKelcE4SeblLITt29E7bIol45mJbPgwjo5aUVf3UzHRUKmDA29TE306DY4?=
 =?us-ascii?Q?5aEGOgUNvI6ICzJkueUhJrfbrW2DfRfxyfk3PP9AHOqfAYJhaI5BkIcMYisF?=
 =?us-ascii?Q?ElxcE5e4Nb/gzimXEovYj3z5kW/axQqvquepF651LFKQoxbncRuUG28WjWrH?=
 =?us-ascii?Q?O2314NGKVqqD+BzmbyC3jylhWeS6Wjm5dxSrpoIxCCX1NYae/0XGLrIzRi2w?=
 =?us-ascii?Q?g/x3z6d1F0WSapBfdMB3Z1a/IO8sG1lkuMcsQ0uLaaWRejLcArYuL+iVUXN3?=
 =?us-ascii?Q?QKUY6D0RHBW9u8O9jnZnybo6Wae2j4ij8smkm+HrvKNvohOMXqSX0hRGAjzx?=
 =?us-ascii?Q?tzS0mxjLlItxBuSGoFGITGYo8ZC1RRqXLHsHethwc0kjFJG2/w/vtYGZTZc5?=
 =?us-ascii?Q?MdHZcLUJtnY4H6GqiPha3nEjTmWdKb+rMDDehrrxbhBzk8ddtD41xz2V+/gS?=
 =?us-ascii?Q?zTI23fLRjUfYcRu9nK3BMgdMRhkfG82ZZM9lBdR0yXRpms9rDv8gU5lkBtBC?=
 =?us-ascii?Q?QweegPJ4Aiyfg2P/8zzE7GrPo2KmGgxeqwBY3dupJQJzMORKg3gy1HdzPXs4?=
 =?us-ascii?Q?ydUIqPWS6YhMz4vJU2uLNYtN2xCR3HT1IaSAcBsgInzZqV7E7naUJqFwrEmM?=
 =?us-ascii?Q?XGab319IRpXiALD2VtFYv8nYsJTrbVt/Hcq/p/su/BAFpMjRT6cIZzSZ0IB8?=
 =?us-ascii?Q?UUKmtpEZNnDndL4BrTsTM7ReTSa1cTGuY/7TF7o4EsHTy4v7EaBg7BB9X+6L?=
 =?us-ascii?Q?MjyoxLYjmKNNBKkSzc+Jzvlbl+tewkFnQftpOUO9jInrpP+ZSxgOZL4tbnIX?=
 =?us-ascii?Q?TYvrg/yTLaukyKFOiiBF5xPgGoyIoNK1n2xhYOJJZbj67JA3iMRzdMJxaraF?=
 =?us-ascii?Q?FjwkYnzX3Sdkr87sYYdGSPV3ZvI0FEG5c9beXxDh9PuHdg7Ghd1zJzjHABEC?=
 =?us-ascii?Q?RPyEKNAGgZYVkE1LXtFusUlY4j0983TeiHn7xeawp6hrIDdUtXtygeAEeTDO?=
 =?us-ascii?Q?xAhecGtTTvxZiqpTrmS42bWBlMQnkeXZl8J3aWmoccuEBmi5wFATXBEyY8Wp?=
 =?us-ascii?Q?MUO7yhhszYxiiomCEqkGo4ciB0WVGOXadJwA9uulXdilaWoe4t4gIk75fFK4?=
 =?us-ascii?Q?kCJ2U+IyRMGzGS7jw7aaP9Ry?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f463bb01-fa24-481d-aa8f-08d96314b125
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 13:24:37.3770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aza7Cd3F5UPV40FC8i+EOuaM51Ix9UHoMEu8t/TH6rrE3mIOYPTBbesWzJbOt4i0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5271
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 10, 2021 at 12:25:11PM +0300, Leon Romanovsky wrote:
> From: Maor Gottlieb <maorg@nvidia.com>
> 
> Fix the below crash when delete slave from the unaffiliated list
> twice. First time when the slave is bounded to the master and the
> second when the slave is unloaded.
> 
> Fix it by checking if slave is unaffiliated (doesn't have ib device)
> before removing from the list.
> 
> [ 5140.584361] RIP: 0010:mlx5r_mp_remove+0x4e/0xa0 [mlx5_ib]
> [ 5140.595866] Call Trace:
> [ 5140.596213]  auxiliary_bus_remove+0x18/0x30
> [ 5140.596738]  __device_release_driver+0x177/x220
> [ 5140.597304]  device_release_driver+0x24/0x30
> [ 5140.597832]  bus_remove_device+0xd8/0x140
> [ 5140.598339]  device_del+0x18a/0x3e0
> [ 5140.598795]  mlx5_rescan_drivers_locked+0xa9/0x210 [mlx5_core]
> [ 5140.599521]  mlx5_unregister_device+0x34/0x60 [mlx5_core]
> [ 5140.600184]  mlx5_uninit_one+0x32/0x100 [mlx5_core]
> [ 5140.600792]  remove_one+0x6e/0xe0 [mlx5_core]
> [ 5140.601350]  pci_device_remove+0x36/0xa0
> [ 5140.601846]  __device_release_driver+0x177/0x220
> [ 5140.602408]  device_driver_detach+0x3c/0xa0
> [ 5140.602931]  unbind_store+0x113/0x130
> [ 5140.603400]  kernfs_fop_write_iter+0x110/0x1a0
> [ 5140.603942]  new_sync_write+0x116/0x1a0
> [ 5140.604428]  vfs_write+0x1ba/0x260
> [ 5140.604873]  ksys_write+0x5f/0xe0
> [ 5140.605310]  do_syscall_64+0x3d/0x90
> [ 5140.605778]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Fixes: 93f8244431ad ("RDMA/mlx5: Convert mlx5_ib to use auxiliary bus")
> Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
