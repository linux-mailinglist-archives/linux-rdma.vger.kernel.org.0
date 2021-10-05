Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09538422FDC
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Oct 2021 20:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbhJESXy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Oct 2021 14:23:54 -0400
Received: from mail-co1nam11on2052.outbound.protection.outlook.com ([40.107.220.52]:2048
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231858AbhJESXy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 5 Oct 2021 14:23:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCCpLjHIK/nrG8tIOW7prvNB1tVmAqNXOp/BJMXDAkDjVIscVkEZ5EfPEmPfZoRXqhbjO/J4qRa31j6rXqQmCPdyYsRyUbHSLoQqvDh7uotmL5q3+jpibolgnZ8EUJjM7IsMl2EmcsZ7FarDbbXfGCqaoaAb6QD0b0XW3lAlKlLFxw+/Wod0IXiJ0bt5nmyuSuprENs4vMuj2A3Nt06zLucjB6lXU7deAFyWayLs63yIpLLUVWJAM5xJj5n7XsyLAnSanRlUdYC27Wtpi24F/Ft9pAe/2qWxuLJmLzFEq0NkVqXrZAmxO3r0SDEk3dGpLXQb9hZdcAMXkMFU/5bvjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8I915sZOgy7/FuyWpV6TNCpg+l6ek+bRAJfA6ZfQ4s=;
 b=V7g+4xZT7ZCdGYs+WTDiCidCeCpD3F9sztw6D0G1Z4YHVOU+Kfr/l8OHZYU4jetOHfyKI5mQjtPXAOZ15GbsWDawq+bQx0QXkvbyl5Pp+F2jPGWGPObiYxNAkWEhSUm8dZ2gTDM/v0gKf0E2TE5iW5kqu8qvkc8u9eFnv9nG+xpH+5tIGUQYBV2BgEVmkRnw2/hjwxXPBZwEPm3ghafGCirBdTzL895O5AEjkXPau1rbBMahhj5v/2z+XTATAg1tOGLeqPCKfPbWipFX8DJ1b71hWr+eo78C0KU7G9e7t97qg4VrKVBz2YlNOHRFG6467jkT+0GMlWQoQib+K47Wqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8I915sZOgy7/FuyWpV6TNCpg+l6ek+bRAJfA6ZfQ4s=;
 b=OZDbFL7M+WrXNm6aI9qIJbTnTk0gtFcY1r9i7/mRj5QlBKUzPnGtB74R3LIu3k+s/hDeiQcvXNkwJQaUVqbtsSFsUNsicsMQScMEHrkNd9MDxHUS0yNVrKCo3Lwjn36lTk5iDklvHEaYebcmHbVklzgSdFYAJoLoizTO4UAFeD7mktkmv6iJCII6jUwOwSfGTOtpHpTR3mIkwRNac4aC5X1k+OV5YGDQLZP95at2oQak6PplqDB9/oaOxPTNs8ZRfm9iC3zGUR5Up/yugbblzolCuNUQ/uyLGStmmSeFm8JV9lkdBrhJSe+oA6coDfQJOOoUzhjTItu9ZJkGiDlOhg==
Authentication-Results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5553.namprd12.prod.outlook.com (2603:10b6:208:1c9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 18:22:01 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%7]) with mapi id 15.20.4587.018; Tue, 5 Oct 2021
 18:22:01 +0000
Date:   Tue, 5 Oct 2021 15:22:00 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zheng Yongjun <zhengyongjun3@huawei.com>,
        Wenpeng Liang <liangwenpeng@huawei.com>,
        Leon Romanovsky <leon@kernel.org>,
        Weihang Li <liweihang@huawei.com>,
        Mark Bloch <mbloch@nvidia.com>
Subject: Re: [PATCH] RDMA/rw: switch to dma_map_sgtable()
Message-ID: <20211005182200.GA2677974@nvidia.com>
References: <20211001213215.3761-1-logang@deltatee.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211001213215.3761-1-logang@deltatee.com>
X-ClientProxiedBy: MN2PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:208:d4::26) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR04CA0013.namprd04.prod.outlook.com (2603:10b6:208:d4::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend Transport; Tue, 5 Oct 2021 18:22:01 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mXp4i-00BEgj-Fu; Tue, 05 Oct 2021 15:22:00 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0cb2a0a-e5f3-434f-9c88-08d9882d069d
X-MS-TrafficTypeDiagnostic: BL0PR12MB5553:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB555361DB02CBDE7E6110823AC2AF9@BL0PR12MB5553.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D2dgi1tt9OBZ4YlC5Qy92NsG2k7AWrKJMfv+nsfPflWAN9zgw1AO4qVq9swHwGOGT2Mtf7mHaN6xTtHPLR063NjoF2Gz9Wqnf76R/LV3hC9ZDUIdTU5iejaG46h73XwQfnZo7AOkU/IuLYsMqYiX+wwIU0K/uAGDezHAYB55qmi/eZyjKxtOrpWnxydzNWzIRHdiRnnpr3zU00c2QnuGd6PeGyUtMHHKgERBnoMNUJN+nhwbPIL7f3YtTZy90khTkYmeHwoWQXorUh+klfkOZRiapOvLv0AqoQl/FRmfs9paPPHCwChboiqUf147T0MvvzQBDq4FPtiaA0wD8RellK3/4Y7vgy9+AgnZc63xO1LD/aA+Gx+V5VXL8hodIwysSovAKx4UU5tYpSDkEPIP8YE9OnSZK6HVIC+jjYMX+flGOw3vrUwkZelVQcbGp2QNGyWFnnrdqlP423rUlqfGqsU0hvYgaL+VQwnlpj5DLKviKX4n5cuDFXVftpVQC8oLyapKkyjzV/daS7oM9vIBdsFwTNp9CMQjorJXp8J482kIC5fhMX4rf6t5k3lTY+eoLOWsPQO4E6oEfW+bMFo7kyOST//EeE4mAyLOgpVvHpG5goqS4afO5+IXA+YGCjTXRG/kWgR2/WLCVuEJGYxx7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(9786002)(8936002)(66476007)(9746002)(426003)(1076003)(6916009)(54906003)(8676002)(2616005)(4326008)(26005)(316002)(508600001)(66556008)(107886003)(36756003)(5660300002)(186003)(86362001)(33656002)(2906002)(66946007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4ZjUpcb7XaFIq4IY2o9MnCKG+iSs3/6Ue4BxwFmCuC40apCRRK0EoT04B0q+?=
 =?us-ascii?Q?NG0NFahBroRE/InhWeK53PGcKlWy4vyhGPtp+gEDAkYTPKbzQBr6kTS9NqQH?=
 =?us-ascii?Q?WkvvlENmKO5FLSQZLzEDccJjHtgmpRjJRKE+Enfhug4au6r4aRt2Ur5g08m3?=
 =?us-ascii?Q?lLP60E/Qka/GUUzh4mkMuQwS0mIeQejnI1TSrpZPr9vd2sM6yN+Q8pXDV4Pw?=
 =?us-ascii?Q?A1gWXyG1DIprvzd4xIn4RsHoC7Fix2SQqSXWiERC+l1dZ9vzHgUDndkRMkfN?=
 =?us-ascii?Q?xApEoXg6n7QPcCA2JiV1ZGgynmehOaXT0uSKLun4b+H/SkG1wRmtZ6B8qeyg?=
 =?us-ascii?Q?LK8DVpS/pf8FedhNFb8fMatBTCLeSV/ZPtRYNUOoKNGQkcrVpy2TmvdqXN8x?=
 =?us-ascii?Q?wbRHkXPTBspPGLpp2VG6wqvOPvUr35BPvaNGHAs11vXU5yHQ0nZuhKb2MMFX?=
 =?us-ascii?Q?Dg2+g/qpocbt23o9vhtp1axqBzY41TlhytJErQjte2wYNyc9s4SPiLObU18w?=
 =?us-ascii?Q?g7v9LZH4kqlviSiC5e0VuJkKuUBn+OqzuSJxGxCniYUQMcv3bgMETwnvT94r?=
 =?us-ascii?Q?cRodIgdyth2N0zBqItBlonKV77A8NqarDM5v1vkKFgz4CJVqqXUjeEIP/OXx?=
 =?us-ascii?Q?biui/YB0mqqzpu0RUfzLWo2MwKNiMDSrahDx/1mXZ0YewnvMsp3543M0xpTv?=
 =?us-ascii?Q?E4cbDv8452B6ZTFHfXTqBtUKGZbz0FHwsb24kjC8i5ViML3LMM7EMcQMtlc4?=
 =?us-ascii?Q?IaUKxOfiuFPKkw1oq3ER8srMNiX6FwzO4d3v9jpqeeMDnRzRcLlCI46Y3YSa?=
 =?us-ascii?Q?VhAh5JmBFj1FbrHIzCb+jBr0lFaS/W2IOqBJRg7nw1tFxMFzV98beaUVFgRY?=
 =?us-ascii?Q?JxmgCWlUJ4noRBbKKiVkJzupYm759k4sFca6UrZl8GxtAFVTi2ONpp5ee0JZ?=
 =?us-ascii?Q?hmUYWWKuqxYS59/9LYDeklscbB2x90V5xOwzPMnIQ7dc4nW/nKuyI4laKOrH?=
 =?us-ascii?Q?mHuuUu1T+wDeCFH3/2gt9qD9F4LpjpNewleyCC1ARMMNS7mC04c+VpnwCmw7?=
 =?us-ascii?Q?wAM70qkte3uRHIDDs8rLxDYBWKo//uTCDrxPnLB5QC5RyX6qY9sMipRpWuys?=
 =?us-ascii?Q?uwdcILgeN7gwpymXh0Efzpk0JQgKvXWmUt7/6nDX7L+oi+tGLbmxxONmkgAn?=
 =?us-ascii?Q?0QS9iLVG8HhBO7l7TP4WlIc2EjpaXsBGGhik0JyvAXb7yz3BRbLq72Olg2Hv?=
 =?us-ascii?Q?U5wiEkTU+axtcvkeAt5GQ6J44PKiKZ346ye4LVgxW4TG9vNd/UJLktZCPRHI?=
 =?us-ascii?Q?DO80mMUdffar+4WcHBGu20nC2r4XJNYrnzRfXV47CJw7OQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0cb2a0a-e5f3-434f-9c88-08d9882d069d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 18:22:01.8053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pl6uD0BWMcKTLHXQkIFxEJE4aGKJ/tahRD62wHj3J4K8IAyM/02Nr4ogCFU+GoPG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5553
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 01, 2021 at 03:32:15PM -0600, Logan Gunthorpe wrote:
> There are a couple of subtle error path bugs related to mapping the
> sgls:
> 
> - In rdma_rw_ctx_init(), dma_unmap would be called with an sg that
>   could have been incremented from the original call, as well as an
>   nents that was not the original number of nents called when mapped.
> - Similarly in rdma_rw_ctx_signature_init, both sg and prot_sg were
>   unmapped with the incorrect number of nents.
> 
> To fix this, switch to the sgtable interface for mapping which
> conveniently stores the original nents for unmapping. This will get
> cleaned up further once the dma mapping interface supports P2PDMA and
> pci_p2pdma_map_sg() can be removed. At that point the sgtable interface
> will be preferred as it offers better error reporting for P2PDMA pages.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
 ---
>  drivers/infiniband/core/rw.c | 66 ++++++++++++++++++++++--------------
>  1 file changed, 41 insertions(+), 25 deletions(-)

Applied to for-next, thanks

Jason
