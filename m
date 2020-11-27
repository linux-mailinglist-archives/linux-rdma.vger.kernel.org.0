Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C86C2C6910
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Nov 2020 17:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbgK0QDv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Nov 2020 11:03:51 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:11674 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727904AbgK0QDu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Nov 2020 11:03:50 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc1236d0003>; Fri, 27 Nov 2020 08:03:57 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 27 Nov
 2020 16:03:49 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 27 Nov 2020 16:03:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2wBZd/5c+yRNALcknChB9vvDRMQDD9m8AGYxZ1DZjtHY7CgFI5sXHi3dpRoYlvls4HbPqBerqeu9NhSl0wiE8bR5YQqC3XG07Nhla/pszFXoBE5ehxJFYBUCxSM1hfr0sr0quJOIgU7g/vi6FZlij+ieodcz0f7dPy1mwGBx701ELubru46Y0xDQwW6CIFDN6wE6v8fpQQKqqaidQiOK4j7buz4um5XnlWLF8Ul/KZcbODsjq9WJGf6puLiA3wX3XVBP4bOP2NWugQR02nVIx+jb3LLPqKfG4N1vj1NYnpIbIqV2hX+yR/BxIBsN5E4Amk5corP6w9iAwHA/LYtSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/Jpyt7K6cI5XO45AbJhk7guOYgAR5OkJvIZ6evQXEU=;
 b=DKDqO5i4SC7b4fKoQxn9JNlqNHYVuCFKFjA/Hso0o2PyoZXDqPN3T2MOzCCuBW7oz9jPr85ECCle9jKbzHIQJonxHD282HqDBrbd4wUKVGgbYCwfK9cm719o4slfs54cfeIKxoRX9+vnk+/IOB+LfAtvNu88Cuopk6QV4cI1hi91NFxBOMXjJE+icsVuOZCbyol8rsVo7VE6NuJc+3dps4nK7oB+DC2De9VwpcYKzNAaY1e2uNiwMEP5Q0z92GeELioFg25dM2UUvgBC07TF2eI3XJyRu3YgofOM3HEu5FGmB+cc5pR6bWsMU2qf7YfwEwISgc17IlPTg9rq6Aaisw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3116.namprd12.prod.outlook.com (2603:10b6:5:38::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Fri, 27 Nov
 2020 16:03:47 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3611.025; Fri, 27 Nov 2020
 16:03:46 +0000
Date:   Fri, 27 Nov 2020 12:03:45 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Ariel Levkovich <lariel@mellanox.com>,
        Gal Pressman <galpress@amazon.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Mark Zhang <markz@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-next v5 0/3] Track memory allocation with restrack
 DB help (Part II)
Message-ID: <20201127160345.GA667848@nvidia.com>
References: <20201117070148.1974114-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201117070148.1974114-1-leon@kernel.org>
X-ClientProxiedBy: MN2PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:208:d4::32) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR04CA0019.namprd04.prod.outlook.com (2603:10b6:208:d4::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Fri, 27 Nov 2020 16:03:46 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kigDp-002nkT-8G; Fri, 27 Nov 2020 12:03:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606493037; bh=A/Jpyt7K6cI5XO45AbJhk7guOYgAR5OkJvIZ6evQXEU=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=HSmbXCBR6LwMu6LebsVTPJYbKIJJv2A80xshQrudrgPlOBLemgB/BEOYbDovGnzy7
         SUxDI8vLqboEfn/nTxH0IWPdLj34xNZv2tipj/QPJQNZFy7vMmp/VlmNCLLhOt2oi5
         Y5sjDOCU5p/dU6vv7vamlElY0YLHqrles8aVY+T7+EHuy8ZLT3uW5GRFT8z1uASc01
         WXr/k3sDzJRtSfo9kGjxobb5s+xD8XZU8jtSIjrErcWaeKK8iL65Rpq23JZ+6tfCOb
         Yta0o0a6qxkLpnHaBRmM7nKVAetN8gjIPI3EOu/NGypRB8CPKkc0xiH4SA2+/zxqgD
         CQbINowf+pS7g==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 17, 2020 at 09:01:45AM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Changelog:
> v5:
>  * Reorder patches to postpone changes in rdma_restrack_add to be in next series.
> v4: https://lore.kernel.org/linux-rdma/20201104144008.3808124-1-leon@kernel.org/
>  * Rebased on latest for-upstream, all that time the patches were in
>  our regression and didn't introduce any issues.
>  * Took first five patches that hadn't any comments
> v3: https://lore.kernel.org/lkml/20200926101938.2964394-1-leon@kernel.org
>  * Rebased on already accepted patches.
>  * Added mlx4 special QPs to the list of not-tracked QPs (dropped previous mlx4 special QP patch).
>  * Separated to two patches change in return value of cma_listen_* routines.
>  * Changed commit messages and added Fixes as Jason requested.
> v2: https://lore.kernel.org/linux-rdma/20200907122156.478360-1-leon@kernel.org/
>  * Added new patch to fix mlx4 failure on SR-IOV, it didn't have port set.
>  * Changed "RDMA/cma: Delete from restrack DB after successful destroy" patch.
> v1: https://lore.kernel.org/lkml/20200830101436.108487-1-leon@kernel.org
>  * Fixed rebase error, deleted second assignment of qp_type.
>  * Rebased code on latests rdma-next, the changes in cma.c caused to change
>    in patch "RDMA/cma: Delete from restrack DB after successful destroy".
>  * Dropped patch of port assignment, it is already done as part of this
>    series.
>  * I didn't add @calller description, regular users should not use _named() funciton.
> v0: https://lore.kernel.org/lkml/20200824104415.1090901-1-leon@kernel.org
> 
> ----------------------------------------------------------------------------------
> 
> Leon Romanovsky (3):
>   RDMA/core: Track device memory MRs
>   RDMA/core: Allow drivers to disable restrack DB
>   RDMA/restrack: Support all QP types

Applied to for-next, thanks

Jason
