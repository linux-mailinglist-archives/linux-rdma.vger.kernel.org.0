Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3E4290A34
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Oct 2020 19:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410587AbgJPRE2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Oct 2020 13:04:28 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:19058 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410555AbgJPRE2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Oct 2020 13:04:28 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f89d28f0000>; Fri, 16 Oct 2020 10:04:15 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 16 Oct
 2020 17:04:27 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 16 Oct 2020 17:04:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqNmQM2nmYJsHouOdIQIwAiCUKQrPleUFcx9iGwzZTDUJu66g/TEU78ASCiGzgp2Pp18W9ftxpYurpkAlARv4Yb595fBdDCdMYJrkF9+ToVBgrJcloaOFwXlSysj0L6jKAReEuy8+p0cmsUFg4nOF5HmNzpizd/shP0/+62klEMYWkfQlbZAOyyc4Cengsvjt6LTLVVWoormFAYGDwo5NJwxQg0SYJYvWuw8FiNtgUQDotuwpaiN55p/vprnHjRpX4pXq35BA5tvLR+XxJIb3ouyb7NCROPbhTBR/E/0JnVELAWeVAPv8qZNpEhBBIum8Zsa1q+KgN6CyeTRkZtLKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ex1IfC+H+LMj/vvs4T5XJXWgHVGCXfN2KDwvirgIBHs=;
 b=Jp6MYHCNYnUrBIllq6t13DPBDv8i4eMZoOYNOyehpA39syK7iJSEzwPWHcj4lcjg9XKnGDCNtJGLq7TKXiG6PXPKGH0tCEZtQDin0um/ppquW8ILBidE9PWpwHnKyd3hoA9AQ2Z9Q3N5CTt37nWp0y+xZZE+Na3/NAxZawdryP5SOexe30T54XAoTu8LI/n4d81CfaIyFe9uJu87hARU+DEO/pmJdlBAvRXR2U9xBTibpuG99N7fV0gaZQmFqnUHbuXocrAlNv6AfOcKkj3cChfY6kPAOmwi1A/FQ6aZX9vyvXsctkhrG1MMY6vMrfKgfwMp+KowLzHTaSClcbodCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4500.namprd12.prod.outlook.com (2603:10b6:5:28f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Fri, 16 Oct
 2020 17:04:26 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.020; Fri, 16 Oct 2020
 17:04:26 +0000
Date:   Fri, 16 Oct 2020 14:04:24 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alex Dewar <alex.dewar90@gmail.com>
CC:     Zhu Yanjun <yanjunz@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/rxe: Fix possible NULL pointer dereference
Message-ID: <20201016170424.GA161687@nvidia.com>
References: <20201012165229.59257-1-alex.dewar90@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201012165229.59257-1-alex.dewar90@gmail.com>
X-ClientProxiedBy: BL0PR1501CA0035.namprd15.prod.outlook.com
 (2603:10b6:207:17::48) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR1501CA0035.namprd15.prod.outlook.com (2603:10b6:207:17::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend Transport; Fri, 16 Oct 2020 17:04:25 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kTT9U-000g4d-CS; Fri, 16 Oct 2020 14:04:24 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602867855; bh=Ex1IfC+H+LMj/vvs4T5XJXWgHVGCXfN2KDwvirgIBHs=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=SLkXa8MukMOX3QkVos0sCopy2nWXDr7l00Y+iGaUmI4Q+Pf7StZYYWl7MVK1Dko0I
         ZaAHgqNVwIwnkbsP5p9dL/lo6ExwtWnse4GbaI9eHEP5POqHHSto/h8izeIFtXqPtJ
         Cq/vsAa5gB+ZjipEzgkIqrao95wA7adaCN7Dmyk0oLWoE0d9UEkcmN83RtK6x8hMm/
         833KdDJRZW9Au8xmbG8KKB5CnYvzeEo0ci9PLFfV5YnlGpV2gT/OAigoOZuVcO57uF
         mFzcgeIQ2O3kuEcv9Y1/2lhIUPzvXdI/9argv8E97Oqe9hIVOMhcBkzSze1fAbLDWT
         8+GWaBy71SxNA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 12, 2020 at 05:52:30PM +0100, Alex Dewar wrote:
> skb_clone() is called without checking if the returned pointer is NULL
> before it is dereferenced. Fix by adding an additional error check.
> 
> Fixes: e7ec96fc7932 ("RDMA/rxe: Fix skb lifetime in rxe_rcv_mcast_pkt()")
> Addresses-Coverity-ID: 1497804: Null pointer dereferences (NULL_RETURNS)
> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_recv.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

I took Bob's version of this since it is a little bit simpler

Thanks,
Jason
