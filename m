Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B873F2EC598
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Jan 2021 22:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbhAFVSz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Jan 2021 16:18:55 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:1092 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbhAFVSy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 Jan 2021 16:18:54 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5ff629160001>; Wed, 06 Jan 2021 13:18:14 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 6 Jan
 2021 21:18:14 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.51) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 6 Jan 2021 21:18:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ru7sL6CiSENbSRcpZU61kABxG2t2cYhLw1pxoDiyaedS5AST2plcHQbbJeg+foXGkNeVLydzmCWOPdu8wTU9yMMik9pmvRHxdCvYCcHMwfYu8j2/hEeDGWmaBgKJ4PQ8AxT63R42PcIgQp+X5O+em+uuE6wMXAsdvg7UI+znMEAYr+Yd0ao7DOM4OcO+sUuZYSmD3l10tV1xmEeUBYJK9zfqaLTAjtH/fmnhSPW0WyA4A9tWkb2YH4pq3H7bAf0mQwMAPdn6fgu0rohRwWLYsyuqXG1SIZ0BwU3nSOPgvx9Lsp1d45ciwNV7e6Cnq+EhUzeWKYTR9BACKBc2Um8eVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mH9C2II6dvMtryo/BMQHYXqHMnukUNKgcMS2xijb+R8=;
 b=CIYSG6iu6/axXTOOWSYWRNT/k7NGWcj2mwpRil02u/P+Q0VVH1DKOGq91PwStreYjQDcBcS4KhsygRoztieOGaUBSu9PQytr85VjIfMCqi/seHZizd2a/5uVOdcPP+DosbQM3R98UX8r+6uWnaofCphs0KpmtZRy0MzU4nMZkcVYydnlInu4cNEmfiUgZoc7Y4TQDvkYfxjYDRMje8cX6F+7fA6i0HEH01gTnr5n64ihKOJqEQFiH7UvLzhim66g+oOmvMvNRFsQedfiq45Xlj4s2MaeF4QUiWiZmAWQ5baf4ihTbDFeNXrJFiCVzOH4At//78vh9iV0dqu0+cDT1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3018.namprd12.prod.outlook.com (2603:10b6:5:118::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Wed, 6 Jan
 2021 21:18:13 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3721.024; Wed, 6 Jan 2021
 21:18:13 +0000
Date:   Wed, 6 Jan 2021 17:18:11 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-rc] RDMA/ucma: Do not miss ctx destruction steps in
 some cases
Message-ID: <20210106211811.GA824299@nvidia.com>
References: <20210105111327.230270-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210105111327.230270-1-leon@kernel.org>
X-ClientProxiedBy: YT1PR01CA0119.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::28) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0119.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Wed, 6 Jan 2021 21:18:12 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kxGC3-003SRr-C9; Wed, 06 Jan 2021 17:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1609967894; bh=mH9C2II6dvMtryo/BMQHYXqHMnukUNKgcMS2xijb+R8=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=g6jbodwfBOmgWX6AVcw8OTBQkFBX76LrF+3/n8CZ8BdO1ejlIxDMsodL21YElvS8K
         v3YJSIG1VbIOtkgmr9vh1YOLMP5T8PzRn4znBS2LktoNB1z0P/1aboLNVQV2MILG4A
         M9VKJmVz+KCo+PbUtxOwAOdqB+JZnB+ihUNlN9cvvvNj7YPvf64q7cMQSj8qgCfMvY
         wzJL96G11paGw2VNfKt9yLHxtl/pa7LXLQxGEXhOkU46qc6qXSv6TpEXanrsHskja4
         Y2hFfSL7C3bnm7aOWkqRAr/CeraYnPC9ePDTXLKZvVpCGW5IAj4NLsJCuC1KvVhMBO
         WuZ4Hb8DuBv8A==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 05, 2021 at 01:13:27PM +0200, Leon Romanovsky wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> The destruction flow is very complicated here because the cm_id can be
> destroyed from the event handler at any time if the device is
> hot-removed. This leaves behind a partial ctx with no cm_id in the xarray.
> 
> Make everything consistent in this flow in all places:
> 
>  - Return the xarray back to XA_ZERO_ENTRY before beginning any
>    destruction. The thread that reaches this first is responsible to
>    kfree, everyone else does nothing.
> 
>  - Test the xarray during the special hot-removal case to block the
>    queue_work, this has much simpler locking and doesn't require a
>    'destroying'
> 
>  - Fix the ref initialization so that it is only positive if cm_id !=
>    NULL, then rely on that to guide the destruction process in all cases.
> 
> Now the new ucma_destroy_private_ctx() can be called in all places that
> want to free the ctx, including all the error unwinds, and none of the
> details are missed.
> 
> Fixes: a1d33b70dbbc ("RDMA/ucma: Rework how new connections are passed through event delivery")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/ucma.c | 135 ++++++++++++++++++---------------
>  1 file changed, 72 insertions(+), 63 deletions(-)

Applied to for-rc, thanks

Jason
