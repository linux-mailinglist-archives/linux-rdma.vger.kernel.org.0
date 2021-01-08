Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7D52EF92F
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Jan 2021 21:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbhAHU3R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Jan 2021 15:29:17 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:57882 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728929AbhAHU3R (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 8 Jan 2021 15:29:17 -0500
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5ff8c0740000>; Sat, 09 Jan 2021 04:28:36 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 8 Jan
 2021 20:28:35 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.55) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 8 Jan 2021 20:28:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MpZ8syYWCxNdX6E5wAjzw9YIh/k9YAnC9KZfW1QJkXpXrl2zws+PeRrSfQOPnlkr2/o8ujZ1zFdy0VXKCIOteeLwVnhHLT5eumQERpT73ByR2FMUgLreIWPelRZssqAA3+cnEMGs7MfJ8TRjozfCYhbhth8/7k86YkFUF4Dd3lfgGGViHXfguBeIQ/O9o2I7RIqU2M5+wfZ14toTeQTMa3Gzyb9s+w7nC7dPDwGgO3k4N9AVheZkEHyE2ZHIBrvcZZw6lusFoD39cmi8AeioX0Gaxd3nTHnHM16EqBha1ZjVIasdYgz7/bCixi9YGnYZvMSK9YT/obYP7lei2W2TGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ReR2NmBgYrthq97VPaw73pmBelxhYS1BFW4Mfc6dY1Y=;
 b=CwFq4RdE9QJMrj5zpcMWeezs2GvfLTvOaIEZwENF7eindDEiEGsKrVqkoSfESFm4pNNvUk3FCCfzGC8nOWV2oJqVpu1pxy2FIgJHaqggDi2fU9QiDByOV604a2yFQdxLnq/4DJgQ9ZESyf6ZeKXfKT8WOFcw6gp0AoSBT+C2OHsPstEqQi05gWhfQiegAbnFGsXwh3o4G1cTjsKWtHgI3os9hD305lZClqSLAGJ6X38zAAR4zJXqLyFhnkZNAI4fNoQgWaIQgztYC31x6odkljSfDPf5hm/23OTR0+fqAs1jdr/JP7Z+axAu8su1iqDRUZKEkI7JsD5Ii7HAABU/ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0201.namprd12.prod.outlook.com (2603:10b6:4:5b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Fri, 8 Jan
 2021 20:28:33 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3742.008; Fri, 8 Jan 2021
 20:28:33 +0000
Date:   Fri, 8 Jan 2021 16:28:31 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/umem: Silence build warning on i386
 architecture
Message-ID: <20210108202831.GA1042005@nvidia.com>
References: <20210106122047.498453-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210106122047.498453-1-leon@kernel.org>
X-ClientProxiedBy: BL0PR0102CA0018.prod.exchangelabs.com
 (2603:10b6:207:18::31) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR0102CA0018.prod.exchangelabs.com (2603:10b6:207:18::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Fri, 8 Jan 2021 20:28:33 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kxyN5-004NFZ-70; Fri, 08 Jan 2021 16:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610137716; bh=ReR2NmBgYrthq97VPaw73pmBelxhYS1BFW4Mfc6dY1Y=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=NFgf/redqQ6KRxBlXNgc0/JqGZ/OUTKgKtYHGJFg/U6QKPyQmYcEyKEZGwQ3FkwDX
         nmSpSVKTRAEwFfzKiabFRVseyWgv58ghHjg4zjkBxb2nc8h19tGL5T1gAqSdnQ+xtG
         QcRsgIFc/U+zxuZre23cf3zu0Bwwjtzw4hw4wYOhQaDZibIUpZ7Bsy3GtY7d2Ej01z
         dc1L1652fnOvs5JxHa5NH+evWLlVsJmwVAahmRIpd+UFtKj6KDOYYw7NyyFsTrFjZw
         CpXf5uweuHIP5QL7aAAjPdAKGiUBRIfplK5P/JuQJsRtRtXw5oZ5NCPZWxncDlNv7y
         YcmXsZo0m5B9w==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 06, 2021 at 02:20:47PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Sacrifice one page in order to silence compilation failure on i386
> architecture.
> 
> drivers/infiniband/core/umem.c:205 __ib_umem_get() warn: impossible
> 			condition '(npages > (~0)) => (0-u32max > u32max)'

I think I prefer to just leave this warning on 32 bit builds.. 32 bit
inherently can't have this overflow so yes the condition should be
impossible

Using >= is just confusing

If you really want to fix it then npages and every place that touches
it should be made size_t or unsigned long.

This includes __sg_alloc_table_from_pages, which doesn't look so bad
actually..

Jason
