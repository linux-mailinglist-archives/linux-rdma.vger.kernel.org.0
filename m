Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6D52D6BBA
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Dec 2020 00:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbgLJXPE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Dec 2020 18:15:04 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:7054 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393087AbgLJXOt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Dec 2020 18:14:49 -0500
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fd2abbe0001>; Fri, 11 Dec 2020 07:14:06 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 10 Dec
 2020 23:14:06 +0000
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.52) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 10 Dec 2020 23:14:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GO576VMKRVLrSWkADBVc4N/P1Or1bAAAeUwOO12t9whwjF5NMNJK6W6UDPIiv/ponWySv9m2kDPFimLPis7gaqTJmUZVyA5VQynnwAHieXaGm5E7SeWKv2YvlNNjXvlf6BJwZsa1hmwg3hV/KCn/jbuLcHaLhJofxKMBUu+AmWd3GDz9Vz0SpxXEAk+eQNsvsyXnWJ7lQgyQT6IQwnQhwKypCZFYbejA9RByoKsbTk3Y48hdEMDnscLNbaJm9rTaovg9fPY0ee5mpGDUmBVOYkFoJvT+5rfLbwjvUhQSer9i3jwsjMYmyaeyN7SrhVFHIvExER1kLVIZuVo+EF63fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qbtO4vxst9IHdsTAD0AiE+cAnTtxaqNxTOGX8eLOLY=;
 b=hoFIeUMEM+bixP37KLNMW40HU5ZGgyxKqnz8rgBY5RZnkRwgVDvs3NxppbPynAghfZ0veb80MNfgv+z3KX3CKgvNao42LanwuFbZShWogqL+eywjOIKs1jiAyvfI7c0p9eHhAJazj8eQ5NXYWAwJrjxfT8kpp1pyBDkERp4hv+SOhH8Bp8juBkqUw9r3dVU986aWyWAyCKpzOb5jipwg8YUYa2D9Uuuy/1qgmlYa0TTJPGv2nfE//mk7bgW1MFeXKieRI5g9lvoxHfWcA9RHPmE4wF1Viw6MOb5NBQELg86RMIgsDd3wYcPzmchK42kEpl3A4rp2J490Z86GQf1z8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3836.namprd12.prod.outlook.com (2603:10b6:5:1c3::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Thu, 10 Dec
 2020 23:14:02 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3632.023; Thu, 10 Dec 2020
 23:14:02 +0000
Date:   Thu, 10 Dec 2020 19:14:00 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     <zyjzyj2000@gmail.com>, <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH v2] RDMA/rxe: Use acquire/release for memory ordering
Message-ID: <20201210231400.GZ552508@nvidia.com>
References: <20201210174258.5234-1-rpearson@hpe.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201210174258.5234-1-rpearson@hpe.com>
X-ClientProxiedBy: BL1PR13CA0428.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::13) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0428.namprd13.prod.outlook.com (2603:10b6:208:2c3::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.10 via Frontend Transport; Thu, 10 Dec 2020 23:14:02 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1knV8K-0091AF-UO; Thu, 10 Dec 2020 19:14:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607642046; bh=7qbtO4vxst9IHdsTAD0AiE+cAnTtxaqNxTOGX8eLOLY=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=cSsYtR0Uj+yTQfD3YifTODfqRP+YZVp4u+wlnSY6LRWIN+ZXbYgnJTJJojUk2fEwd
         uU34PSKy505heliJGnuN871oDWNUCglBvtIp8F1+y4qrVeIH8O6TA8IkG5ivqgdXlM
         HzLGeIGNIPSO8JuNCCQVDn0iWr4LPKgZbbs4QswbVyFWOz8ZscCi1IXctrfgpYrWPv
         8BFuLBMWUUEF0C20FTPGnMwj3KH9gwFECtG10CaWxfPSCachaowRMQfKFQMJd5/QTG
         aYaePsiVavkze0ZK5ZQFEy/XZ3qqpWKmnTw1SCfHCNIiTi8pJv1HBamDZoAwsZcn2m
         p4NwS8gfaw8sQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 10, 2020 at 11:42:59AM -0600, Bob Pearson wrote:

> @@ -76,26 +56,56 @@ static inline int next_index(struct rxe_queue *q, int index)
>  
>  static inline int queue_empty(struct rxe_queue *q)
>  {
> -	return ((q->buf->producer_index - q->buf->consumer_index)
> -			& q->index_mask) == 0;
> +	u32 prod;
> +	u32 cons;
> +
> +	/* make sure all changes to queue complete before
> +	 * testing queue empty
> +	 */
> +	prod = smp_load_acquire(&q->buf->producer_index);
> +	/* same */
> +	cons = smp_load_acquire(&q->buf->consumer_index);

This is not so sensible. The one written by the kernel should be just
a normal load and there must be some lock held here to protect that

The one written by user space should be just READ_ONCE

acquire only has meaning if you go on to read additional data based on
the result of the acquire - then acquire ensures the additional reads
can't cross writes that occured before the matching release.

Jason
