Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7F32CB207
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Dec 2020 02:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbgLBBFM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Dec 2020 20:05:12 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:2839 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgLBBFL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Dec 2020 20:05:11 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc6e81f0000>; Tue, 01 Dec 2020 17:04:31 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Dec
 2020 01:04:31 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 2 Dec 2020 01:04:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=al0pdN3a6DyaFFCrhFuPRiTL4zEyUM3USIQZIl7NHk0YCNp3I6qWxZMgNHngr5UvBIrcbHgdxO5QFeTqsa4XXkKoAmPF2kZDcbEJTIwXuIv1ywnHputaYao+GUmZjnclHzWvOFh3BBs6qECoo5BiK12dL8aQ/PboJoYB+sCZ98QhVJKHj2k41mJ+a8kaIqaI7A4neMeDRSV31JphvjjEb61rMg9Y96DFpkOxavjmYQvFpGsT84QbWFWMW6ykCL9VRwLPK7nRwxoVfTx2XySChJxeC5+iJVUn0BoeZVUFusPJse0dpVmtjKe5gc+QodlRjEW4+ajviWhXOQkMgYSWtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YA1OIFK87vwxudM5LoJown2qQEekFJrMRZvv7lU9nZ4=;
 b=ZK00tlTlDehqRLdEiOD42M3QJdEE3yx4TuzkUzDQgLSmoYLf0/H1AQkpv8nNEL/Drby2X9qzwiRCX5a6PkbDF5z4XJcVI1h9+4jyoxRQY6/eeXXTAyGwp7L8hoieX4B2apNkF3b5KpNPvKxIMro+RTsHYxV4KqfTskd7cH3fIgxsJDPsFxPsD3f2ArEFXThtBHGq7WugKxwSkZGtrvDyIWw967ppH9U8I/OQRsKOQeXTkNn635Exx3D4rs0TTUd/co1gPTYvXEyh3WF7B7H3YumHontQPWWSwzksgAfasvHBPXHo/x1D11lpKDDSeHKMl/yhJOUlD1gkuxnsnDOPfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB2490.namprd12.prod.outlook.com (2603:10b6:3:e3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Wed, 2 Dec
 2020 01:04:30 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3611.031; Wed, 2 Dec 2020
 01:04:30 +0000
Date:   Tue, 1 Dec 2020 21:04:27 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Use dma_set_mask_and_coherent to
 simplify code
Message-ID: <20201202010427.GA1150256@nvidia.com>
References: <20201201091811.37984-1-galpress@amazon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201201091811.37984-1-galpress@amazon.com>
X-ClientProxiedBy: BL0PR0102CA0025.prod.exchangelabs.com
 (2603:10b6:207:18::38) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR0102CA0025.prod.exchangelabs.com (2603:10b6:207:18::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Wed, 2 Dec 2020 01:04:29 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kkGZH-004pFl-LI; Tue, 01 Dec 2020 21:04:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606871071; bh=YA1OIFK87vwxudM5LoJown2qQEekFJrMRZvv7lU9nZ4=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=S+9O/PGcTE1fSGtCwjUwd3dNeUu4dpKdcpvIRwlZBAqCcxqqyjScxJEY7rLFPv93C
         OPxSudr6JrlGiYBTkrLUXhPfjd9Y2RJ3V96hX7Ce2FZqWhSBec7E2ZeoWyqlaDUD3z
         Uh89P7qFTXNxCFxogdgR1U29V9n0BEwxR8XKZRXcs2CC9RRyz0vGIX3RvQJodtTe4z
         3in05vmKsaGKeVYd3M57MwF5l11plagZ5LXsXtuT4DQzNfNhMejYDYem+a5p5P1zzG
         ZApI9xPrJcRgmNP4YWAGH+LMn7ZpBvbD6VpQ3BqwzQrsNHkux1FKqmTxb3jKjj377H
         ET6vRUHdToNMg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 01, 2020 at 11:18:11AM +0200, Gal Pressman wrote:
> Use dma_set_mask_and_coherent() instead of pci_set_dma_mask() followed
> by a pci_set_consistent_dma_mask().
> 
> Reviewed-by: Firas JahJah <firasj@amazon.com>
> Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> ---
>  drivers/infiniband/hw/efa/efa_main.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)

Applied to for-next, thanks

Jason
