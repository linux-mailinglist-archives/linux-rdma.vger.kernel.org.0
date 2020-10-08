Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD8D287F01
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Oct 2020 01:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgJHXQu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Oct 2020 19:16:50 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:2524 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbgJHXQu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Oct 2020 19:16:50 -0400
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7f9ddf0000>; Fri, 09 Oct 2020 07:16:47 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 8 Oct
 2020 23:16:47 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.51) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 8 Oct 2020 23:16:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOb1uQ+DoaJRUN38cmy3fm+peJTdfMwqBS/Pv4CpOte4i7Ab0OaQ71s80hBtAFABG88OzgrNOQ1pHodQ8ioGUZ/gjfB/VLDzz6jmvnJfSdLRswFDfErEMdtI0AD8+6lhZ7QprkSKcoOLS3zHRok6WO8EN2sNMNsbfpzKLPdef/zOd6DF7pkbV+EZ4j3uGlW1ppXUSQjnduCPr1Hsxu24KQwLe9p8rP87QyTsOJSPLkdRL9Qf3abHAXWyNLQ233Ww8izWiULke8hKjvr3yQeJlf7HuQ1Tq69BrJdZTyG/JhO/xJbDsyt32UuLynZlB1rOLmotexYrqlOq9EGkbnq+Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rZ1wAFmMN8N1S+3Hu1P7ewZTxmAldR8wBMzmn6QN+Y=;
 b=WgTfFtOzR2hFcWQOPIZLwFdzZOlNHM+NR1GoggSSc780FqDCqvdwmhhvRbgyxr89zC0vWg/e1ZN2RRciuvMknPMyoSw9WNQ/FHOxtPVGdPAQZxcMCSVNjQvZ+PcpV8023YC4nfwCZjObRzMYkAF5TaVgu8Mb2w4YxQLCCH24AvfsVjetuC4bI3MErjQCO9q3iyE90KoPSK9Jk+70MqqxOk3JhfJiUiF/dM99rz8nisdrXQs1yESO6ycc3yhJd0y2AKSLKQZNJbFCAHd85yDSyKBbOFU0Isb+9jfJpiqnTc7S056w/OYoKRaXeWGly8miONTORAYbimLet3uiy/dkZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0202.namprd12.prod.outlook.com (2603:10b6:4:4d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.38; Thu, 8 Oct
 2020 23:16:44 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.046; Thu, 8 Oct 2020
 23:16:44 +0000
Date:   Thu, 8 Oct 2020 20:16:42 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     <zyjzyj2000@gmail.com>, <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH 4/4] rdma_rxe: remove duplicate entries in struct rxe_mr
Message-ID: <20201008231642.GA417448@nvidia.com>
References: <20201008212818.265303-1-rpearson@hpe.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201008212818.265303-1-rpearson@hpe.com>
X-ClientProxiedBy: MN2PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:208:d4::40) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR04CA0027.namprd04.prod.outlook.com (2603:10b6:208:d4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23 via Frontend Transport; Thu, 8 Oct 2020 23:16:44 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kQf9O-001lhy-Ku; Thu, 08 Oct 2020 20:16:42 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602199007; bh=6rZ1wAFmMN8N1S+3Hu1P7ewZTxmAldR8wBMzmn6QN+Y=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=rZrdXcx9ueY81tcXOFxhUsJmnqT3YI8jYz8/xXJ1BjnYv6/s81/7+mzEcwCgLxM7X
         l8KWj7+IkVZBv0Wzb4vCkL+lMmsUb0sSiPbBAcYsccNMnt3fLAvUQ4jK9ZhGQHSv1y
         hEado9PCKFwR8YO1prEYv87hdSp+qy9wPnSL+EQZvDbx7n18FzhgESqEIq1zomEilt
         3Kn7gioItW3+J0YG6sVnZRWOS4kWFKDj1LTw2tU4cInU2xastzCxSNFNyFjifiZeHT
         XeIpq0DvMKjQe+3IPpnJgRAYpzBn8U+IrK70Dh2nBwYNM0FYZBXRVKGYmSJg/sR2fN
         E7QmO89bmj3Cw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 08, 2020 at 04:28:18PM -0500, Bob Pearson wrote:

Subject should be of the form

RDMA/rxe: Some subject

RDMA convention is to capitalize the first letter ie 'Some'

> - Struct rxe_mem had pd, lkey and rkey values both in itself
>     and in the struct ib_mr which is also included in rxe_mem.
>   - Delete these entries and replace references with ones in ibmr.
>   - Add mr_lkey and mr_rkey macros which extract these values from mr.
>   - Added mr_pd macro which extracts pd from mr.

Commit body text should be paragraphs not point form

> @@ -333,6 +329,10 @@ struct rxe_mc_grp {
>  	u16			pkey;
>  };
>  
> +#define mr_pd(mr) to_rpd((mr)->ibmr.pd)
> +#define mr_lkey(mr) ((mr)->ibmr.lkey)
> +#define mr_rkey(mr) ((mr)->ibmr.rkey)

Try to avoid macros for implementing functions, I changed this to:

+static inline struct rxe_pd *mr_pd(struct rxe_mem *mr)
+{
+       return to_rpd(mr->ibmr.pd);
+}
+
+static inline u32 mr_lkey(struct rxe_mem *mr)
+{
+       return mr->ibmr.lkey;
+}
+
+static inline u32 mr_rkey(struct rxe_mem *mr)
+{
+       return mr->ibmr.rkey;
+}
+

and fixed the other stuff, applied to for-next

Thanks,
Jason
