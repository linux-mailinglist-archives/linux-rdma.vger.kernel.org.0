Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAA62C1978
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Nov 2020 00:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgKWXdY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Nov 2020 18:33:24 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:1323 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbgKWXdW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 23 Nov 2020 18:33:22 -0500
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fbc46c00000>; Tue, 24 Nov 2020 07:33:20 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 23 Nov
 2020 23:33:19 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 23 Nov 2020 23:33:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCpDPXm02VFD5qM9rgILr44HIYEMAik1EWpnW1sIxTN959aPOYWZZ5XvSjZHWuKZROTj4IQwtSHj1ghc4HgzuLH9XtMekcJVLX2VASUMcAw8IF25gMG2dNFbHhIiMO/GsNcNMaPckFOFNnbhOpKAsYp3kP/LHXLUxb+5ire+R89SDYAbHo+p1Qh5mMol9PQxaheB3gFu3lDxxDiuWxoA3zP/uTZAqpGXsyeC66fli9hcchCHQnY8gsJ+fBKzP+vyrcbRePA8HkZZP7TZb7EJSKZRxa0QVtV2yrRWdOeQ8F092vssDc443isevAdNZ1Xy1zSEw/sz6KRwphy4FQRCug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46Zof/ha+42OczJtraxAfCZIJfL/2KzADagvkFzwtiA=;
 b=EHSdEK/7wnlXUKOFm6v9TwGdZamRh/zcSFHAEIeqaim/KqNkNzNC/3yWoJgBh6LId1fQueiLHusOyb75+jLtgGCtglxs7FjOFuNFTgRE1HX65dIxkpB8dn5SBP/kMA3Hxkx6MxDekLfOxxXcQYC8mIAdTJpm7xKTqkShpnCU5m2ywS7tThJQshEP5bys4KWDUXbaseJ+RMFXYABIc4cVYveXYGI1+Pz3cy7PzZ/BtqMfT8hU4O+zfXnw3w41gqIap2wNaNH6iuHp1eo7gv8NMbgxoJw9sqvgUyh8xnCcT9QxQm6kRw8HJ7UVllWfkxNG6Dj8cnpOBPR6cm2kpl9CvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4402.namprd12.prod.outlook.com (2603:10b6:5:2a5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Mon, 23 Nov
 2020 23:33:17 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9%7]) with mapi id 15.20.3589.022; Mon, 23 Nov 2020
 23:33:17 +0000
Date:   Mon, 23 Nov 2020 19:33:15 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@nvidia.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] tools/testing/scatterlist: Test dynamic
 __sg_alloc_table_from_pages
Message-ID: <20201123233315.GA135146@nvidia.com>
References: <20201115120650.139277-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201115120650.139277-1-leon@kernel.org>
X-ClientProxiedBy: BL0PR02CA0125.namprd02.prod.outlook.com
 (2603:10b6:208:35::30) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR02CA0125.namprd02.prod.outlook.com (2603:10b6:208:35::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Mon, 23 Nov 2020 23:33:16 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1khLKd-000ZAl-TP; Mon, 23 Nov 2020 19:33:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606174400; bh=46Zof/ha+42OczJtraxAfCZIJfL/2KzADagvkFzwtiA=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=FBFYIXYziVyxYDvGeYq7GGaXnGnux7fbXLKCXEE2npcPiTIiMdv4oblU9urXPZwn1
         9jp1739P6MYstTEOBsHFpBdp2QsPC4AA5UlM9LbA0D4VDtXZ/9yYCWl0kGlcv7vkKo
         WvBBECnYdQfecQaVKH8Cs7ylDNOK3rOsuvRgHpu7SPGypyIjIkPgu3C5ufazOqAsd2
         nM8ZklC1f0mL/i28zUg4NOg0rili7WHLSJjZvGfwl18uDuVN7ke5msm1Yvd6C8hw+t
         Ad7ucRQSrxeU7Nfd4cCz1d1Dmvdo/40sEgyVjVfcQNs/4jLdCRv/uxLA+LN6MclgPf
         m3KjDm8ESrMXQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Nov 15, 2020 at 02:06:50PM +0200, Leon Romanovsky wrote:
> From: Maor Gottlieb <maorg@nvidia.com>
> 
> Add few cases to test the dynamic allocation flow of
> __sg_alloc_table_from_pages.
> 
> Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  tools/testing/scatterlist/main.c | 64 ++++++++++++++++++++------------
>  1 file changed, 41 insertions(+), 23 deletions(-)

Applied to for-next, thanks

Jason
