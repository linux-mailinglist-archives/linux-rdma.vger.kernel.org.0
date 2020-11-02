Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D27C2A3400
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Nov 2020 20:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbgKBTZZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Nov 2020 14:25:25 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:15186 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgKBTZY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Nov 2020 14:25:24 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa05d240002>; Mon, 02 Nov 2020 11:25:24 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 2 Nov
 2020 19:25:24 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 2 Nov 2020 19:25:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLi02G/Th36J5anSD/TQb01IQzGR2Y/ZwyHvYUY4PSHWSV+b9zmmY6Cy+zRTc4UbsN1rRWglR75R2+Ck2E4kbqTWqERwdgKDjgyK24vsIm9uEHGM4XSt5v+5to8kMwnkf3NmMzYAZsfddIO0ze0S/10mf+kBvgs0yI0SFUHEK/9xv6OCT5XaOu32bYuBL5q8q1/yE7wVcYPDeU/SOPmzXEcZdr1wVjr+c262tAR0eHFzJG0Haf+k6clbNFVIKqh4g3OriVEOyKFs9Eec7VvHEBmNpUc0WXANlRlWoIbvIjlxZvUSqwLFoKTLisqJ94B5J80tTkIwtVNuZEnCcBl7Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Ne8MZvNPA4fKU0rQ40fueIRhdxwpN/ksoE7U7+rIUg=;
 b=MWt0QVKwxELV+O/phoqocCErGnLgKZBh3BI2/5vj8sxsyRa/uGI56tT16wgKw+cRvXy5Y7JCmQo0OvGr3VeL9F0ZLQs6EdPRuZNpoAtL45/LYCUAgLZ2N/2UBmySXlMobBmcBTgzeNxTpIuzqorqa4jmeLIzCIeLESBOaODXsvE6rMVtqXXMHum0Q3cL8e6HvkYFN6199hAYahAH/FGF+ki0P9YlxZX/GxbwuHtMXO/gSgp/lUqvngX9wvVKoWZCq6yoeNK/aRJI2bP3yoXmpdXG+LRDwy+lolu2CXFKT+KnhVYwIA5OrMqi8452/0cvjbjFfYJY6zA9cvHL7mivRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4299.namprd12.prod.outlook.com (2603:10b6:5:223::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 2 Nov
 2020 19:25:22 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 19:25:22 +0000
Date:   Mon, 2 Nov 2020 15:25:21 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@nvidia.com>,
        Bart Van Assche <bvanassche@acm.org>,
        <linux-rdma@vger.kernel.org>,
        "Nicholas A. Bellinger" <nab@risingtidesystems.com>,
        <target-devel@vger.kernel.org>
Subject: Re: [PATCH rdma-next v2] IB/srpt: Fix memory leak in srpt_add_one
Message-ID: <20201102192521.GA3710231@nvidia.com>
References: <20201028065051.112430-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201028065051.112430-1-leon@kernel.org>
X-ClientProxiedBy: BL1PR13CA0194.namprd13.prod.outlook.com
 (2603:10b6:208:2be::19) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL1PR13CA0194.namprd13.prod.outlook.com (2603:10b6:208:2be::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.10 via Frontend Transport; Mon, 2 Nov 2020 19:25:22 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kZfSD-00FZD7-Is; Mon, 02 Nov 2020 15:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604345124; bh=3Ne8MZvNPA4fKU0rQ40fueIRhdxwpN/ksoE7U7+rIUg=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=DDH5kOzq4CMKGpUAiMZpXeflgo/awOJ3YYxfexzwDY69cFg1f8Id/WufRXqzrVqJa
         U0b++PM0g0yPqC1l83xB1oPJgAJgUko5kNnvqQo44eIB5yIaFaIs/1H+QBPkcObSEN
         7X/xo/062/zneA33s7tL4plRrE5U9R5OMNCsEx3WejMC99gFGAYYG5mgVQBMPSBfnB
         6WAJ0Acq/hBj3zMi/OyrVnNK+D4bayQYn20+MBMwc8BF++mUBFNQzFlIdUQ+BBSOQY
         4UBMHLPQJLyt3l0ENxEUNnB6vZhtplPfBAznjA4X5ue62jM4PJuEn8RWpP1Ajthll4
         n3ZsBMpBSzj3Q==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 28, 2020 at 08:50:51AM +0200, Leon Romanovsky wrote:
> From: Maor Gottlieb <maorg@nvidia.com>
> 
> Failure in srpt_refresh_port() for the second port will leave MAD
> registered for the first one, however, the srpt_add_one() will be
> marked as "failed" and SRPT will leak resources for that registered
> but not used and released first port.
> 
> Unregister the MAD agent for all ports in case of failure.
> 
> Fixes: a42d985bd5b2 ("ib_srpt: Initial SRP Target merge for v3.3-rc1")
> Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
> Changelog:
> v2:
>  * Added an extra parameter to srpt_unregister_mad_agent() to eliminate
>    an extra obfuscation call.
> v1:
> https://lore.kernel.org/linux-rdma/20201027055920.1760663-1-leon@kernel.org
>  * Fixed and updated commit message.
>  * Remove port_cnt check from __srpt_unregister_mad_agent().
> v0:
> https://lore.kernel.org/linux-rdma/20201026132737.1338171-1-leon@kernel.org
> ---
>  drivers/infiniband/ulp/srpt/ib_srpt.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)

Applied to for-rc, thanks

Jason
