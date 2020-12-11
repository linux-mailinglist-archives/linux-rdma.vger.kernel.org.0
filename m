Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C69C22D832F
	for <lists+linux-rdma@lfdr.de>; Sat, 12 Dec 2020 01:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437616AbgLLABb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Dec 2020 19:01:31 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:19664 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437568AbgLLAAB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Dec 2020 19:00:01 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fd407d70001>; Fri, 11 Dec 2020 15:59:19 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 11 Dec
 2020 23:59:19 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 11 Dec 2020 23:59:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dP6kswS+V+1LQ8VnmGFihuuvy34aDqVvwuAWV0P+jgA/TQveD1fcQn2fQPmYQXpUI+tQywQ0/OZgHmUVx1BkM8rhXwtKd8xPrlz80R0yiESbKDS7ily+in+HTKhfWQZ1yiTqx+J5xv4ptzL/GVElfzGWevOfuR/0gSBPWQggqIBwpXHLZ+AEGrl2ZoWC0kVlr0b3TGx2uzb4LM4yWmZYTesasz1OtJJSb5NlMj4AigetXl7Xf0sukUyWbpFCe4GayKy5nMatqiYkpL4AD9MVtOaVNpD9E1pHJ6CBMhwSJBnwin3ffcOnjMZeQmm/GTeGrvpky7PELva6mNoxkSNQ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/if1WBxk5r4F0dqVC7ajScoQ40BPyW7UNHiaRzSDW4=;
 b=B4k3fFdVKFU4xwUmqZONlUblQbloizrlrSKTntGRaXIaKkTx0/t/44PlHPr9nne2rAVj0w/tC3PzkAC7flQ4w51JmbuSejyLLtq9IsstrxqmHdM4aYlkBxQP4Qt3+PQtJPLqMjKQPbW4ThsGIwBdwSrI+7MZ5q7CvFNHLLUe/QT08jxyTCJoHIDhE6WhSAYFLOOk2w93Cz45YWIsZRWXnk0km38OVTeIK25cCa/TrozaCuDLl3eF6uNo5Ij6l3Q1gEgNffqK1pqtxQY7zuY5HPMVoQxgbVxbxG9+yaarVGwHdWBQ1zQ9/0r01uFnFucrnLjygQXzWTlXSbZzzUq3+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4483.namprd12.prod.outlook.com (2603:10b6:5:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Fri, 11 Dec
 2020 23:59:18 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3654.018; Fri, 11 Dec 2020
 23:59:18 +0000
Date:   Fri, 11 Dec 2020 19:59:16 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     <zyjzyj2000@gmail.com>, <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH v2] RDMA/rxe: Use acquire/release for memory ordering
Message-ID: <20201211235916.GA2238970@nvidia.com>
References: <20201210174258.5234-1-rpearson@hpe.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201210174258.5234-1-rpearson@hpe.com>
X-ClientProxiedBy: BL1PR13CA0090.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::35) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0090.namprd13.prod.outlook.com (2603:10b6:208:2b8::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.9 via Frontend Transport; Fri, 11 Dec 2020 23:59:17 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1knsJg-009OTi-Aj; Fri, 11 Dec 2020 19:59:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607731159; bh=n/if1WBxk5r4F0dqVC7ajScoQ40BPyW7UNHiaRzSDW4=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=O+JZbxGYOj2JYLqky20yHwky/IwYUe+jizlahv1UnacozAsnIOAToQ6v9/0TUYCcR
         oSKNGb334R9ua6lpNLfXTO78ND0RVO8g7yFTIt+3PXUXRgU3Oq4ictmDsIM7bj1hCH
         XnRm/0+rrS+ywJwJwVfXcwqvx2puj9fz2dI8aNbFhvXpGLIMnkPN6wXniGL5YO3mIT
         qta+hjFFo/frElsJsiJR+3/NuykyI3nBGrJ6W+v8OOQRO7TVIVTNvj/qflM+JuiVKv
         IOUhKGL31Tm+KGZUOjsIDRXsaiZ4De5060zhJEGLe1Y00TBHGAq7nzCIn7PF+sBU1L
         oi5tO5EOfJ2Cw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 10, 2020 at 11:42:59AM -0600, Bob Pearson wrote:
> Changed work and completion queues to use smp_load_acquire() and
> smp_store_release() to synchronize between driver and users.
> This commit goes with a matching series of commits in the rxe user
> space provider.
> 
> v2: Addressed same issue for kernel ULPs which use rxe_post_send/recv().
> 
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_cq.c    |  5 --
>  drivers/infiniband/sw/rxe/rxe_queue.h | 94 +++++++++++++++++----------
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 11 ----
>  include/uapi/rdma/rdma_user_rxe.h     | 21 ++++++
>  4 files changed, 81 insertions(+), 50 deletions(-)

This really is a lot better than what was here, the extra barriers on
empty/full can be fine tuned later

So applied to for-next

Thanks,
Jason
