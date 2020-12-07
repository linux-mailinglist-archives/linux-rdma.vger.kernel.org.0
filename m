Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611382D19FA
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Dec 2020 20:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgLGTq0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Dec 2020 14:46:26 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:18255 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgLGTq0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Dec 2020 14:46:26 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fce86690002>; Mon, 07 Dec 2020 11:45:45 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 7 Dec
 2020 19:45:40 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 7 Dec 2020 19:45:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VdTezL3B4zuPm42o0m9M6mPT32uH29iJ8uc8dYeDtrsXsqpUNVizrx1mv+BhGHc5o66QTRTbBqLs6ih3iY3Az+m9V4mcPdipkXr65rn7aIVAOKc/s4GucsvMT/LOSLDgl/8FVyktYbgC+0IQezVnIyNQVhumVie374KASqgR7dnrUYBPVs/WI0Ek0VsRYu+9HaOTh6eVi6dNcwLJdQrijWz0aGf1u/H04WBCdTfL2X6MUoEfWwOl5FDRSXDFYdCpbIV23y/bruklyiez6ycKmgSgQnBopg2MvYnxet2+bjDM+kDe2/mEIgzgNFkYMJ9EDx9iqquzOzKKl1lf8PSOXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyvblNlLXu9iQJRjEQSCmA5c+aAQ+qKWPNZohcdvZOc=;
 b=I6E8aMzdzW2O1RN+nGPbH8MojpOnpKUocsH0Arxva9lIcBS/ynoGTghSQe3y7ALjsn0ivv6sIEUmz7/xdlyWCztYpCa9xY7lohzqzyVIAjOnDAOL7QG+z+pYqbx6xXMgWTPTlGyXW9C4kcLf3yvvAev5ov9e/cWoDaQ6znf/tnICKx9xU0gwQ5SL49bio54aWfmA87JXJGh/ZJltkKHbYrsa9FYIoYF+e10Q5EqV8OddOKZYiqD4tfKNLT0TTER3KGpynCW0Qp/vD+5k6AcJUAJQT0NAqA364QQ/G1ETVLKSrnV3WgvcqYHs802D4c0RQM539rCIf7YnFbDG4MJjiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3018.namprd12.prod.outlook.com (2603:10b6:5:118::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Mon, 7 Dec
 2020 19:45:37 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3632.023; Mon, 7 Dec 2020
 19:45:37 +0000
Date:   Mon, 7 Dec 2020 15:45:35 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
CC:     <linux-rdma@vger.kernel.org>, <dledford@redhat.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>
Subject: Re: [PATCH] RDMA/bnxt_re: Fix max_qp_wrs reported
Message-ID: <20201207194535.GA1773945@nvidia.com>
References: <1606741986-16477-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1606741986-16477-1-git-send-email-selvin.xavier@broadcom.com>
X-ClientProxiedBy: BL1PR13CA0304.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::9) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0304.namprd13.prod.outlook.com (2603:10b6:208:2c1::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.5 via Frontend Transport; Mon, 7 Dec 2020 19:45:36 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kmMRz-007RUY-3i; Mon, 07 Dec 2020 15:45:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607370345; bh=GyvblNlLXu9iQJRjEQSCmA5c+aAQ+qKWPNZohcdvZOc=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=cjkFmtOLAyztO84+BouyzVXBIVTUgRI9wMSLJ3LEVHvYWPJstAv91XiXlsBEDnCiW
         JXHEIxrF9YeCjXbnKti33E2+GqdcbwIANz22t2bC1aTFU79wF7d8D9WzZ4Z76mxdW8
         w99WYr4jMr7b0HYbAH92ak2u5YaUePArf4sELuekHxHob2wUhkaTmxLIZ9EJOPQHYa
         pTD+pcVSFMcMHewK5u8HAdrb+8OQP9n9U6+a/m5D+/obtpIb7YkpdG1Z7xRadqiueU
         qPYqdxy6baeI1LvqyWNu88/XkZ00LiDvguufpI8kDnMUYVHOQ4ZSb0gCmquCccndQv
         FF3x2Li2Qhsng==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 30, 2020 at 05:13:06AM -0800, Selvin Xavier wrote:
> While creating qps, driver adds one extra entry to the sq size
> passed by the ULPs in order to avoid queue full condition.
> When ULPs creates QPs with max_qp_wr reported, driver creates
> QP with 1 more than the max_wqes supported by HW. Create QP fails
> in this case. To avoid this error, reduce 1 entry in max_qp_wqes
> and report it to the stack.
> 
> Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/qplib_sp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
