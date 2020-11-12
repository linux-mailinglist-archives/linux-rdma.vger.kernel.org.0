Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4EC22B0A3A
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Nov 2020 17:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgKLQi4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Nov 2020 11:38:56 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:2902 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729073AbgKLQiz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Nov 2020 11:38:55 -0500
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fad651e0000>; Fri, 13 Nov 2020 00:38:54 +0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 12 Nov
 2020 16:38:54 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 12 Nov 2020 16:38:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8F0rwG3arU3pnSQAQdqIicH+QUQjOeOISLNNrSLM3VOc+c7CjFmLDf6Os+DFtLovck/0PMQnZ3TC6xaUjhcKr1w08ZUd5F2BfQidBo3KuGR1vZx6WjKeGWkQ5Yn5a2s+pZ5KYL6yohAmlzQrx/iDmhqqNtTJReJUHc+3AEkTk5oVy5jRD8XR32ZkmTSEL8P03SKqPJEzoLYYtM0+gxHA5+aXUvtO61bOYkU8nr7MCbM6lIbRed1v39hcmN6u/g8tOlV+64/2v5kEV/qeUvOcns3MNcJgBVnI36jyvfnVOYlFoDvEsiQVsigOaxvcXXC4m9ZQ1QwTLLJ3/QmOy4WYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcyMM9rZEup2OyXezPHk5c4Fjam1jio7CZyhzxNI6u8=;
 b=EzRAT7cgxlvQJc0LUSNYMJzYVCWV6nYtSS8GsuZ3tuTqc2GWhbhb0zUoH/zYsLx5URYhB+NGEkpc7+0+W9zOjNwpjX4d/0yy9fEbXtIFNVdbs60SRABrqul59mtSI3Rw/X2UKDtOnRP628UK3rMFCcbX5QJkJWKMcX7Kk3dU1crcrPUYQMzSJzAr16GwtRZ7U2jZcprCHoCLw1g/s3NWm+HMWmdNbH/Gztn/4YtLrA//hL1ttnMIGyDyXsxFSsyrC6Qq65rXHVazH7FR5Uk1qIcKje7M2I3O86Le5Vwan067n4YyM1fF1hBgkGAtQbiNL4wbJ2HvhK7A1s5GxzREBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3212.namprd12.prod.outlook.com (2603:10b6:5:186::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Thu, 12 Nov
 2020 16:38:51 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.032; Thu, 12 Nov 2020
 16:38:51 +0000
Date:   Thu, 12 Nov 2020 12:38:49 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next v1 0/2] Cleanup FD destroy
Message-ID: <20201112163849.GB917430@nvidia.com>
References: <20201104144556.3809085-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201104144556.3809085-1-leon@kernel.org>
X-ClientProxiedBy: BL1PR13CA0056.namprd13.prod.outlook.com
 (2603:10b6:208:257::31) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL1PR13CA0056.namprd13.prod.outlook.com (2603:10b6:208:257::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.22 via Frontend Transport; Thu, 12 Nov 2020 16:38:51 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kdFcX-003qgo-WB; Thu, 12 Nov 2020 12:38:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605199134; bh=fcyMM9rZEup2OyXezPHk5c4Fjam1jio7CZyhzxNI6u8=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=qPNeXE/oG4Bh3HV5QFifMoVcf41YX3GmsfvFBfSzTZv3DVHyz4KwAdzehlqQsPpcD
         4c3nCl6pPjB4iaR+H18TB6hoIsaPqLPEKfiPD/zPQfPD0ceDG95b/GElMDBCLEIcqZ
         YPo69Kh+0oQtjTY9ZMhodqjn7VBCJn+8LbhEq677sCoHYhQC6rR7opZ2HdAKEhka1W
         CAVOEoCylf+L8A7Ldnfz58H1mrzQrp9I6QxN0YbLU7HDVvAIZNoCaTkn7Qt4FiyR1J
         oTBiIMl/EgrxW5uacQQX0QvsAVT8p62KfBV1DoLvabM6akijAx/Ke0SaOQKCdfk5BZ
         oF+C960URWuSg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 04, 2020 at 04:45:54PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> v1: Added Jason's variant of first patch
> v0: https://lore.kernel.org/lkml/20201012045600.418271-1-leon@kernel.org
> 
> Leon Romanovsky (2):
>   RDMA/core: Postpone uobject cleanup on failure till FD close
>   RDMA/core: Make FD destroy callback void

Applied to for-next, thanks

Jason
