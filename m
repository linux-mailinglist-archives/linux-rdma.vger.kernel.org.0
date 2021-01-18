Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9212FA25E
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jan 2021 15:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388249AbhARN6P (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jan 2021 08:58:15 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:16423 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392492AbhARN6B (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jan 2021 08:58:01 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B600593c00000>; Mon, 18 Jan 2021 05:57:20 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 18 Jan
 2021 13:57:20 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.50) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 18 Jan 2021 13:57:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izNoCFqnGhvtF4rHO6IRH7vxxIQVUebaK/YGHO5a3VbsZ7jqfwB+JQ0wrPZTT2eu2lenjW33ZdqFjhWt4/k2J6shLpgVdfQfHgdgdqyTmtk8h3swrv6YgbpCXHobU5OdLaWEg9wmNCyRfj4ZCk8M6Vy3ERNb/buQVvhivV5NRKSF7ydvDecr9kKMmp+69zEHsf1lNbwMQ9JtgnAYDVHtxl3k5BnJV+bqWerYAujgCaict0Fy7pnY9RIn8Z9qVxLxvmSTegMueRO3PRIaCrAp/gZVcUUl6f2lOtyUQiOVa1XBHDnyE0lCXUcxq3yZpvN6Yf0YUrpwftx/Jz58ehGyog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWuots7K2mwSVvXQWlJ4gmXulV9QNxfkW/8FZUnCbF8=;
 b=VveZxtoPR/T6d9FL7/Fc65z5mwG8jOvzZGRBCfE0LA1/NF2pvuIxpXfHKo/GNqEghB4TwlgBwC1EhvguuWWnSq8+u42ctj7ZExchjEjUlAdKbtuuojgQpRdwvPyrsGAUCUZ01G4BMgq5sKnMHRgJQqk6046q4xlFO4aTPb7G9gZSHBSQrhk7R6qsox5Pcjo9swmSNIzy+ErTp0kXicYXGH/KnKB46QmUvfykl131Km0bYt0lx9+Sp0yiqDN9IY8O8vsK5gKptTVGWpA4Rk1Wc4Qjmv0yRllQnkEMNV5Rzj0KZtEyHlqPLq9fwWCh2AxYj8pF+1isfogCJMO6mKJFKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3113.namprd12.prod.outlook.com (2603:10b6:5:11b::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Mon, 18 Jan
 2021 13:57:19 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 13:57:19 +0000
Date:   Mon, 18 Jan 2021 09:57:17 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bryan Tan <bryantan@vmware.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Pv-drivers <Pv-drivers@vmware.com>
Subject: Re: [PATCH for-rc] RDMA/vmw_pvrdma: Fix network_hdr_type reported in
 WC
Message-ID: <20210118135717.GG4147@nvidia.com>
References: <1610634408-31356-1-git-send-email-bryantan@vmware.com>
 <20210114172359.GC316809@nvidia.com>
 <BL0PR05MB501015BAF25CADD722F5A9FCB2A79@BL0PR05MB5010.namprd05.prod.outlook.com>
 <20210115125031.GY4147@nvidia.com>
 <BL0PR05MB50108203905E205C6B4D2682B2A49@BL0PR05MB5010.namprd05.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BL0PR05MB50108203905E205C6B4D2682B2A49@BL0PR05MB5010.namprd05.prod.outlook.com>
X-ClientProxiedBy: BLAPR03CA0075.namprd03.prod.outlook.com
 (2603:10b6:208:329::20) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BLAPR03CA0075.namprd03.prod.outlook.com (2603:10b6:208:329::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11 via Frontend Transport; Mon, 18 Jan 2021 13:57:18 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l1V1x-002wGA-DS; Mon, 18 Jan 2021 09:57:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610978240; bh=kWuots7K2mwSVvXQWlJ4gmXulV9QNxfkW/8FZUnCbF8=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=JgCctYbZxlZ5Cp/gFRl0TK0KK2yjMwCQUg8A5EdnYHdjzv7z3y1oG9kgEG+42jTkg
         IIOVWX+wq+hVz1W1rIl9qO6/AnWTHtDhK/Z40teM0GAEEB+l5zyMBXfgyle+GqdyKB
         VtpGmizh+4zK5eqChkl992KJkp/loOyfKqKAUZ0y5lJslxcDewX9BACtukF1b9qaJN
         Tr/oSQlsaP0iv4wIwkmCMT5K3I6JrA2a9aaLfDJFl17WzwOu2mTQTOqU1x0/IveYZJ
         tuKRmFbLEQ00ghkyt0XZGA6xCy69bJJyGsGA6SZdPB0kFhl0c6jSLhq2O0offY+/O6
         pk7EvtZBsFo0Q==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 18, 2021 at 11:46:28AM +0000, Bryan Tan wrote:

> Yes, the pvrdma_cqe struct is populated by the HW. Both the driver and
> the userspace library use this struct to populate the corresponding WCs.
> That makes sense, let me move them into the uapi header. Apologies if
> this is answered somewhere, couldn't find any info--am I responsible for
> updating the header in rdma-core then?

It happens automatically unless you need to send a related rdma-core
github PR, then you should do it in the PR

Jason
