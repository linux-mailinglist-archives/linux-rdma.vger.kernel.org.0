Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6263F4ED5
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Aug 2021 18:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhHWRAA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Aug 2021 13:00:00 -0400
Received: from mail-dm6nam12on2075.outbound.protection.outlook.com ([40.107.243.75]:21049
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229471AbhHWQ76 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 23 Aug 2021 12:59:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XlI5SRAoTr5cg9DN+Hzw347pyQ/s5ZfIGmtUT0kU6asv098vkVMjA7KySp1zygTaerpeAiG7C/MXYMR+xOB67kPw/IYAYV3N0eQZUVGeBWatLHmiJ80A9omCws2sEoM7KSzrI61YUmIv655SwIzigEFvaJGseQP/RZJbU9oLdldqvVl5sb/TMpLYCxaPTzDTfc3nZEJw3EfmnoH4nnXwjkGJ3q3wQxKvScICCYxDEiMTxIJAfF9gubFtpQxHyien8rUoiOBhXHuXgRJOduOaSMkVPyJNAuDK1g6vZXOngsSWhNNblLQ+as8Uh4JOA/Zmfnct9NnxmgB/f2j8/tESQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zznwYNx7DswgCyqDJU3pkXynXZImCOe3aG3v/jsqfxM=;
 b=cOxYjH+yK/BYVu0BCLhU/cY34l9smeRQ5XCk/HCoLIsYsrhZU3pYTYfy7ELhVV7Y+5FVCzM+gfKKUWj7Ac7mn2NXUPaY6vo/4DcSUGeE7Bi/+AfmEZsZgyUG/dFcChMblwA5RXWrj6QXI/mByHgO+LswOtxKTbkvchaGGMk6LuhJ37pCIM6bN96pMRgVMEu3gWnxgz96jbIXJz9sQpsHC8yE3RucEVG/OPqGsrMc1FVPZEs8OyYE/HE4Rfh6HfTRt71WKEKvNPWvzFAGjQSLsvTao8Io+ojGYLFHxkjR3VVPIboIt+9vO4kdg0Lv7uXobqiSTAcVQGnkprVP+h/fdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zznwYNx7DswgCyqDJU3pkXynXZImCOe3aG3v/jsqfxM=;
 b=qbDS4Ufq6vPTAJWTpxUB5GC5MTLbPqLRCLgLFRWk7G0hXNlOo1j9iby0Yrahe5DOcK69ctMzMBW9AerU0kyh9jS/lgDGWCuIMZys+tlW+rhML2v3Ek+T4AXciEMJccrKJiuoU0RV8TZTyU22UaEtyDTfwJsBKwNIUO/JGmWOvQdDjHk1BB6hftJM/mH6+UaRLp7A/dMUqI+K91rODZxooLPkX9R9hejoh3oX77kCgRbEGSsDP2WTLic0nZokqeUTFkDbg9Q0j9zEPvUlUOIfAj2Gb6zTUYdeDu3HHDnyrMWIBjaIBStT0UWSQ8zNci3Ltpf/JZYcXKYjT/LZhmax3A==
Authentication-Results: wanadoo.fr; dkim=none (message not signed)
 header.d=none;wanadoo.fr; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5363.namprd12.prod.outlook.com (2603:10b6:208:317::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13; Mon, 23 Aug
 2021 16:59:03 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%8]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 16:59:03 +0000
Date:   Mon, 23 Aug 2021 13:59:02 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     mike.marciniszyn@cornelisnetworks.com,
        dennis.dalessandro@cornelisnetworks.com, dledford@redhat.com,
        aditr@vmware.com, pv-drivers@vmware.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA: switch from 'pci_' to 'dma_' API
Message-ID: <20210823165902.GB984782@nvidia.com>
References: <259e53b7a00f64bf081d41da8761b171b2ad8f5c.1629634798.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <259e53b7a00f64bf081d41da8761b171b2ad8f5c.1629634798.git.christophe.jaillet@wanadoo.fr>
X-ClientProxiedBy: MN2PR18CA0014.namprd18.prod.outlook.com
 (2603:10b6:208:23c::19) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR18CA0014.namprd18.prod.outlook.com (2603:10b6:208:23c::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 16:59:02 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mIDHq-0048IB-1r; Mon, 23 Aug 2021 13:59:02 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bf0ddad-213d-4b4b-e8b0-08d966574f5e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5363:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5363D315A41453C6F225D1C8C2C49@BL1PR12MB5363.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IuUxRAhkxExFx4WhKesr5QhIUbZnczVSHQmNr7ao8jwOCahlHu0mXc1NQnOJSiVfybcYeQjML6rrPkK0csjywWtIuByC4kWw0+y9ZOq78Vy8bQHYbzd/cNXQyHipXamhdiaWMquUHopSs1GYouYV+LiXf88X8zylHeTeQ7YiHbi3zG1kE2j2d7ngLKMTF3B6xCRQ69fYohGis1d+twKtvRrLtVjlKQv0pwGv18MY5nk9jGb8mBYOtTgghfXwMOzioRKMK81azXcwW1gyDjZi06TQqLU7RIoKDMfx0xoHph0/E8zcjGhXMbO5G1D2uYmAJhvk+ZDpRc42P/YxZoE3FT8IBY3/QtiqhirzEnQLd0XEOz4BGK+AhUKbGeB+uKXr+rZOmeBFS0+aKJoFs52KelA6u+khjo4odYyDlVZ3QVGxwcux9F76g761ANp8jbqXiPj4uR8yIqBb7DstdLspZXwtZyApcHpt0S6jWAvAZgyFa6QO1fVCSCpNb9MRqbpMlO/V6e+Hrhh52H+1iz9vYmboj3iYNZAUUeA1cJRAApy3aYjxqx8GqS3794fA30zTaU7bsPnd5LImSm7/8zM5JrG/44FBIfWpfPB2eF1ojP9Pc8b3/C9o0OpdDmnYKTfTBgSMW2APe1vTSO8K3L9vzgD3JlpbEb22HUNRl6H7aGCqOKcnlkR5+aEg9sXbQe4Qjk0q/NAVXbkWh2e3Zoc51XvtC2HpTBW4fYyQURrJkAspqgkOmbT09AUxWkAoa6WLmtUfTODnsMIzzgHiRGeKYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(8936002)(316002)(966005)(9746002)(8676002)(1076003)(33656002)(36756003)(2906002)(66476007)(2616005)(66556008)(5660300002)(508600001)(4326008)(66946007)(83380400001)(38100700002)(26005)(9786002)(186003)(426003)(86362001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tAjgYpJKR0hVQfmj4H7sPSu3GU6OtxCdWXcRenVXA90o3EqfFR7ZL4rd4N9T?=
 =?us-ascii?Q?cQR9lNuI56AWW2Dq075qnedMjA3a0WW4xYD6egx1Dwh853ltGiRaoirVR7To?=
 =?us-ascii?Q?8tOGFiXWhIKOcZ4y6cYCCIyuboe31n5FXOkzzHbO523N9hYzzCo7mMwr6Dzg?=
 =?us-ascii?Q?8TMYR15mcLAejgmxBACyrzj84wSuX2iho/1w/aXVaHnCEQoYnVdW0ZhQvra6?=
 =?us-ascii?Q?ds6qc5YOqRavPX1FJQRE/VpXAm14HrMi9CeF4CrdT/lfiyGLSMaFiNVhrCcU?=
 =?us-ascii?Q?43n+U7dN6zdIjJ1RvitnoUJG4Q2Tgc8aFPsGgqnj4rRKmccIEJ8hIue2ULw0?=
 =?us-ascii?Q?CRFFdYL7kKRDmmo4d6s/Z9U2hShK2EP3O8QgTPSOgLrVsitSjqPRVj8vdQ2P?=
 =?us-ascii?Q?xTvD7sv5xsoP/o0LAWLBxN8n8Y0PdFixCrjEu73oNMXUswisjLTqnweqx93x?=
 =?us-ascii?Q?eSkr/KtUI5413LfztuUZPphoEvKY9rVE7tg6ALCNuPhGy5ik+Yh6ajT56r48?=
 =?us-ascii?Q?78VdqDxGhGr750yLJQzmxIvD/GMhjjAuHykUSkm802hJHHb6N0dJxJtzBon1?=
 =?us-ascii?Q?GRMm8ehyMZrWUNH5iVXTAjckhcdJwwpgA9hAAe7oo/OfUKeHxyyPc3wxQa7V?=
 =?us-ascii?Q?x3uMdpR++fPwmnMEpQBATexoqp+aV9OYGMONiVPtL0+cSqk2QhIEqQ/JWWiF?=
 =?us-ascii?Q?04ecetT41+unfhQezKbnTeZ2r3/SodIJmyyTFPjNEFgy5jgCeSaj6oHi6GkS?=
 =?us-ascii?Q?385BIdOx7+7dLKkyH72SB2RZc8jXAvUvUtTAftaT3bhwg7SghzebdwTIHp+c?=
 =?us-ascii?Q?kcBIy2G47buYtATVCizWt62bXdLqbEiN2NrmR7SmFWN6w11uenMREYaE8IKO?=
 =?us-ascii?Q?mrd5ffX4j7/wenRyMdoSlOKXAVBwAL/bv3rh3ylujpfg1GuFlayB61UjGcLa?=
 =?us-ascii?Q?xH4G+VYqiSUP3slEhJq069/lr49mJ7M+Tuu4+hS4/QxEocqnPPyuRGoDpJKB?=
 =?us-ascii?Q?FZwjT/vRSyKZBQGpq7tZiDiJwcu1jEHi95W4s2tAkVS88ibx9LiP2xl3pj8v?=
 =?us-ascii?Q?lpBzcwOtGEMihuamcVEYTbtnLnW6oHV52mnJ6w5LS/B6/Gxfs8no06uo9kV8?=
 =?us-ascii?Q?oDziC1KqTcvvpDul48rdkqwakA7hmBTEKWZqKH8NPPp27PbKtDyLbulL/LdK?=
 =?us-ascii?Q?bdZonkl6f/nD70jFhQc/nxLQ4hoz9xzjn0/YlWvxwDqCMaNP6KrZH+SPbROE?=
 =?us-ascii?Q?XPHmcIEVIfGYuAEnSKH49+cP5AmXOKTJOUtZnajMu4AcL9OGzcsdP2ZtzBT+?=
 =?us-ascii?Q?lTwWCVTtrYvCli9t4L74XIg3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bf0ddad-213d-4b4b-e8b0-08d966574f5e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 16:59:03.5039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ro17G2F8KLWBOFUl+KK4Pwh0FGlgzl2kFNl8aw4RPgkATEAzgLy4dAz2+DwJJtI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5363
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Aug 22, 2021 at 02:24:44PM +0200, Christophe JAILLET wrote:
> The wrappers in include/linux/pci-dma-compat.h should go away.
> 
> The patch has been generated with the coccinelle script below.
> 
> It has been hand modified to use 'dma_set_mask_and_coherent()' instead of
> 'pci_set_dma_mask()/pci_set_consistent_dma_mask()' when applicable.
> This is less verbose.
> 
> It has been compile tested.
> 
> 
> @@
> @@
> -    PCI_DMA_BIDIRECTIONAL
> +    DMA_BIDIRECTIONAL
> 
> @@
> @@
> -    PCI_DMA_TODEVICE
> +    DMA_TO_DEVICE
> 
> @@
> @@
> -    PCI_DMA_FROMDEVICE
> +    DMA_FROM_DEVICE
> 
> @@
> @@
> -    PCI_DMA_NONE
> +    DMA_NONE
> 
> @@
> expression e1, e2, e3;
> @@
> -    pci_alloc_consistent(e1, e2, e3)
> +    dma_alloc_coherent(&e1->dev, e2, e3, GFP_)
> 
> @@
> expression e1, e2, e3;
> @@
> -    pci_zalloc_consistent(e1, e2, e3)
> +    dma_alloc_coherent(&e1->dev, e2, e3, GFP_)
> 
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_free_consistent(e1, e2, e3, e4)
> +    dma_free_coherent(&e1->dev, e2, e3, e4)
> 
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_map_single(e1, e2, e3, e4)
> +    dma_map_single(&e1->dev, e2, e3, e4)
> 
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_unmap_single(e1, e2, e3, e4)
> +    dma_unmap_single(&e1->dev, e2, e3, e4)
> 
> @@
> expression e1, e2, e3, e4, e5;
> @@
> -    pci_map_page(e1, e2, e3, e4, e5)
> +    dma_map_page(&e1->dev, e2, e3, e4, e5)
> 
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_unmap_page(e1, e2, e3, e4)
> +    dma_unmap_page(&e1->dev, e2, e3, e4)
> 
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_map_sg(e1, e2, e3, e4)
> +    dma_map_sg(&e1->dev, e2, e3, e4)
> 
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_unmap_sg(e1, e2, e3, e4)
> +    dma_unmap_sg(&e1->dev, e2, e3, e4)
> 
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_dma_sync_single_for_cpu(e1, e2, e3, e4)
> +    dma_sync_single_for_cpu(&e1->dev, e2, e3, e4)
> 
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_dma_sync_single_for_device(e1, e2, e3, e4)
> +    dma_sync_single_for_device(&e1->dev, e2, e3, e4)
> 
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_dma_sync_sg_for_cpu(e1, e2, e3, e4)
> +    dma_sync_sg_for_cpu(&e1->dev, e2, e3, e4)
> 
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_dma_sync_sg_for_device(e1, e2, e3, e4)
> +    dma_sync_sg_for_device(&e1->dev, e2, e3, e4)
> 
> @@
> expression e1, e2;
> @@
> -    pci_dma_mapping_error(e1, e2)
> +    dma_mapping_error(&e1->dev, e2)
> 
> @@
> expression e1, e2;
> @@
> -    pci_set_dma_mask(e1, e2)
> +    dma_set_mask(&e1->dev, e2)
> 
> @@
> expression e1, e2;
> @@
> -    pci_set_consistent_dma_mask(e1, e2)
> +    dma_set_coherent_mask(&e1->dev, e2)
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> If needed, see post from Christoph Hellwig on the kernel-janitors ML:
>    https://marc.info/?l=kernel-janitors&m=158745678307186&w=4
> 
> This patch is mostly mechanical and compile tested. I hope it is ok to
> update the "drivers/infiniband/hw/" directory all at once.

I think I would have preferred to see the more tricky
dma_set_mask_and_coherent() conversion as its own patch, but it looks
OK

> ---
>  drivers/infiniband/hw/hfi1/pcie.c             | 11 ++-------
>  drivers/infiniband/hw/hfi1/user_exp_rcv.c     | 13 +++++------
>  drivers/infiniband/hw/mthca/mthca_eq.c        | 21 +++++++++--------
>  drivers/infiniband/hw/mthca/mthca_main.c      | 15 ++----------
>  drivers/infiniband/hw/mthca/mthca_memfree.c   | 23 +++++++++++--------
>  drivers/infiniband/hw/qib/qib_file_ops.c      | 12 +++++-----
>  drivers/infiniband/hw/qib/qib_init.c          |  4 ++--
>  drivers/infiniband/hw/qib/qib_user_pages.c    | 12 +++++-----
>  .../infiniband/hw/vmw_pvrdma/pvrdma_main.c    | 14 +++--------
>  9 files changed, 51 insertions(+), 74 deletions(-)

Applied to for-next, thanks

Jason
