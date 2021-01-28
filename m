Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D319307F10
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Jan 2021 21:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbhA1UC2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Jan 2021 15:02:28 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:15649 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhA1T66 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Jan 2021 14:58:58 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B601317550007>; Thu, 28 Jan 2021 11:58:13 -0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 28 Jan
 2021 19:58:13 +0000
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 28 Jan
 2021 19:58:11 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 28 Jan 2021 19:58:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7/uR/zU80eyzGt57ixSZQgiAiSQ29tVCtUa7nPgeYBrLpDv2issjQ0kppdbJSa22Td6SlJwLLz8lBz2tpbgxZAZyUJOHK3709GoA3zkIqdZIxSt+A2FsDn6eckT+78juvrNd4fXwpumN6wdATo8pBovX5BpCMHku+7UyXbWEC7zTsm1mMflXZTtGS3M9dEHwgT9jIJKQCbSOahWAUCpknqY5MZuYr8nFErTrq8xc48N6uTdPRxZ6Gq+9VcQ2vQzY2p4N0FwU8hk//1kIq//6/BTVxi/rht6M5PgYfI1FzDGGaVOZVQFC/p1VTg24PdNvoWq+0mF2FDr+N6oa10jjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BIYYi7Jqk6fodZhr0fUGozHYoNeTHs5hAfzXD9FPeTk=;
 b=Or+pOBHEM/dYNldhdWPErLch+MFk+e51WYRJV8yI8Lr26Add0R4JIlXotZWu0hHC6UKpyGtFOwa5J0gWZCLOhy019jFKEudFzQKD/FuEojLB2qFBp48EVA2w3efj89kLQJGjMfZsmdDF4xstyfsLy7Evcf5GDNvE2htJmVP3+6vSszhnPEoxpYcl9QsL4SV4yii1iNYgaCR0tkerWSYsZwvhZdyhiUHjapNEQOiJpj3neqvwJY+KmS7xoZDG0vWhyYvrxkNkFc4011FKjGhY2yZDK+ToePTCNeVG/NfD+XCODusrZh0f6hNpOqLlcUG8F8Ho8hf+G1vUR2F+9THU5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2938.namprd12.prod.outlook.com (2603:10b6:5:18a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.16; Thu, 28 Jan
 2021 19:58:08 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3784.019; Thu, 28 Jan 2021
 19:58:08 +0000
Date:   Thu, 28 Jan 2021 15:58:06 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>
Subject: Re: [PATCH for-next 0/5] EFA cleanups 2021-01-26
Message-ID: <20210128195806.GA135851@nvidia.com>
References: <20210126120702.9807-1-galpress@amazon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210126120702.9807-1-galpress@amazon.com>
X-ClientProxiedBy: MN2PR07CA0024.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::34) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR07CA0024.namprd07.prod.outlook.com (2603:10b6:208:1a0::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Thu, 28 Jan 2021 19:58:07 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l5DQc-000ZLm-Q0; Thu, 28 Jan 2021 15:58:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611863893; bh=BIYYi7Jqk6fodZhr0fUGozHYoNeTHs5hAfzXD9FPeTk=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=B+M5qukvg50I+d47hGDVH1TiXLOoUvfxR47XsYIPH5C8g6nmFzwwhWQwr45Uh33mc
         nkMON/VxeaKtAvxCQWXy1wJab/mb53kXMv54qaG+XSQF+QNjScA4D+mSgxehA+5qro
         +irSlQP865SCqmM8I3g17yvgaafn0akunPIv4zp9XHHOxC06CSvARW+p5dTMwRMD6u
         jFdACD8nfFMznXKlHaLB14yfF5+yD8cm3/TGOtEJQM32w/OarqwmBN6ydnv5uKoGMF
         7dyg0qoQIQ3HMwnEWbOQsumG6/mRn5zoBkiDbB7HwJ0WS9RFKMdvhsYSIlDAAhdHNK
         5HI4TFZzVR9pQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 26, 2021 at 02:06:56PM +0200, Gal Pressman wrote:
> Hi,
> 
> This series contains misc cleanups to the EFA driver and device
> definitions. Detailed descriptions can be found in the commit messages.
> 
> Thanks,
> Gal
> 
> Gal Pressman (5):
>   RDMA/efa: Remove redundant NULL pointer check of CQE
>   RDMA/efa: Remove duplication of upper/lower_32_bits
>   RDMA/efa: Remove unnecessary indentation in defs comments
>   RDMA/efa: Remove unused 'select' field from get/set feature command
>     descriptor
>   RDMA/efa: Remove unused syndrome enum values

Applied to for-next, thanks

Jason
