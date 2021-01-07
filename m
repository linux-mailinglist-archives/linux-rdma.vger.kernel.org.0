Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFCE2EE714
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Jan 2021 21:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbhAGUmC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Jan 2021 15:42:02 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:12723 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbhAGUmC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Jan 2021 15:42:02 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5ff771f10001>; Thu, 07 Jan 2021 12:41:21 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 7 Jan
 2021 20:41:18 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 7 Jan 2021 20:41:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZhNue5W0/dO4M3NfQqGrPEhdbjdEd/OGOZiV5aQg5rJavLrfwlQOzUNE3GepwzJ3gh0RgW8j43ysYD+BXdeR+2fkRWBjnlDNWeTJAJqXaeNKKs/tTimhPwHmAk3ylq69k1VpRckE+OF3tiXn6zhd8Y4GlFgWPWEYC3wD6PaJxXfje28KD9Net7jhZ5ghsqDw/rL5uLfIPKZfhgfIVUN6lHSaIMHLRyTY9cAIYzel7fKcqShYVVVdk68WVc5fAywHAGfp7my1RXpU61oai4p9Gg0vdQwvTLwdckrMwmjK0NPWpFwjQJPbSa7uOAWiA1cLS8WdDft9xJfmWDzN/ZVJSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FufXpCFnDOPIGllVzNFFnacXfmXf2vniF97au/WFNi0=;
 b=gf46UR1mAM6O5Wf3JWrMpfIgTKC6Gpawvmr9kmSMlUa7doMhl6tGCaixbM+YODihj0ACkTWbNIwZSA/n3s6nD0IHjOhT49gi9JM5KEVs8kMvOpmEQwfW8q1bRduUOxs80Y/svpD2QHEybWI1bvLQ4WU1XZ7ydZHHrQYaozXgw+DF3/BACLjDzHA4yq3y8STgJwUWs0Ls8J46tD6hhTAVbbSgB/GtB9n23QKY6+Ye2mUunEtXa4omuFv1gnMOdxXFU355TfXgZgYQOOtAxkwAzodtoy78FB40bljibmA+n7QDl6HQi0xHPv5+dDszLuUig464Y76evpLn3TlCBB0ppQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4633.namprd12.prod.outlook.com (2603:10b6:5:16f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Thu, 7 Jan
 2021 20:41:17 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3742.008; Thu, 7 Jan 2021
 20:41:17 +0000
Date:   Thu, 7 Jan 2021 16:41:15 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
CC:     <kjlu@umn.edu>, Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/usnic: Fix memleak in find_free_vf_and_create_qp_grp
Message-ID: <20210107204115.GA933040@nvidia.com>
References: <20201226074248.2893-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201226074248.2893-1-dinghao.liu@zju.edu.cn>
X-ClientProxiedBy: MN2PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:208:160::36) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR13CA0023.namprd13.prod.outlook.com (2603:10b6:208:160::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.2 via Frontend Transport; Thu, 7 Jan 2021 20:41:16 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kxc5r-003uzM-4e; Thu, 07 Jan 2021 16:41:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610052081; bh=FufXpCFnDOPIGllVzNFFnacXfmXf2vniF97au/WFNi0=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=EljinzklUx4QdUGZtDMblRWOvva6jq/ihdSWR45gxbouWddlnvEib5ojO3AT4zJwX
         Hu4y8o0SfBlgAtZRTVu8qOMgJrNVEWZAaFM+rdB8oLV+xd2+SV7MMG0TqCJMwU0JuJ
         /XCmmXQXsLwbTQqKWj3dtbWTQUm2R7anjfwkwa+LhgOe/eUzmjAtBQlDhvCqjhKe2Z
         8PeBMS7dhhuTLarXWA9Y9ND8YlMlhhpoRJyMa6XDjVsN6bD/eNjnjU26p6BW6ssUgZ
         g/yiEgAkPm4TmTmZrmfrRS69bxLGbyGcqQveemJ4ySpKELJPgt2oGEv9aMOTyPvRmx
         lmlU0Esq1ZzqA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Dec 26, 2020 at 03:42:48PM +0800, Dinghao Liu wrote:
> If usnic_ib_qp_grp_create() fails at the first call, dev_list
> will not be freed on error, which leads to memleak.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/usnic/usnic_ib_verbs.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied to for-rc with

Fixes: e3cf00d0a87f ("IB/usnic: Add Cisco VIC low-level hardware driver")

Thanks,
Jason
