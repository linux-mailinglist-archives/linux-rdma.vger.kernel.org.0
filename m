Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAE72B533B
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Nov 2020 21:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732213AbgKPUwK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Nov 2020 15:52:10 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:5780 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728574AbgKPUwK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Nov 2020 15:52:10 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb2e67e0000>; Mon, 16 Nov 2020 12:52:14 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 16 Nov
 2020 20:52:09 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.58) by
 HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 16 Nov 2020 20:52:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DkAy66xyY1iCU2EPbf3cixHAUOg8WtkE8EgHeuxGrvPwf5FKci6RXPMlVIHfwg1bh4jzfi4vFwKYXsxUkaAjgSHTRAPaYq9DGvXUhw+QHFxamLatu+yam45oIOEBXrKiq+RWd8LIfRp/avwaSYvrOG4FQFzTtjbXIUPsfms0K4JZCINqcfNDLGf0B9NRXUdYeQWK/cH1t2VKQFEKQpUMaHcd6WhVJdYUZ1m1gTgdj3d3xjHFgHvBYqVNYAcuk4At6fMmYD02EwGddnT8aewhPx5PIwHcN71Pv+r7GdOCSc0mQsoRoyiTwZnqXO/sOEnaabAFpJuie3U8n4s3n71uhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k198o+kTIxsDVEnPJk9BgBxot4/BuThak28c9+Fbrm8=;
 b=J+/NVpZeqi/SLMC9BEL571UA66pvP8AzCkBI4g/gGW5Tgjru50P6U5gORUEKuHrtGKZGMqUxIg0ER5KuLMDEW1ddGV7Js8REHBONYqxr5uLzs9t//CQAP6boS52QHYsf4uNJ3aPSzu8LS5KLZ5jzkLzu3EqPvn8qg7R5e0flqcfcFu0caGp2dFOufWTICsyEE7c21QkhCxuRPLXBtVIsDQVn200RW/3KUIS5MuPkvo2CzmC+CGyBIMg/F1GssZ0/+wE2U7co8HlkJEcKVgVWdM6EWbeW0yZu9kX2BzcQ6+cf/O+KD1LddExDFo69MCtG1QQCJFclmMg+6Qr+Yeykrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0204.namprd12.prod.outlook.com (2603:10b6:4:51::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Mon, 16 Nov
 2020 20:52:09 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9%7]) with mapi id 15.20.3564.028; Mon, 16 Nov 2020
 20:52:09 +0000
Date:   Mon, 16 Nov 2020 16:52:07 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next 0/2] create_user_ah introduction fixups
Message-ID: <20201116205207.GA1614182@nvidia.com>
References: <20201115103404.48829-1-galpress@amazon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201115103404.48829-1-galpress@amazon.com>
X-ClientProxiedBy: MN2PR16CA0036.namprd16.prod.outlook.com
 (2603:10b6:208:134::49) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR16CA0036.namprd16.prod.outlook.com (2603:10b6:208:134::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25 via Frontend Transport; Mon, 16 Nov 2020 20:52:08 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kelTr-006lw0-Kr; Mon, 16 Nov 2020 16:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605559934; bh=k198o+kTIxsDVEnPJk9BgBxot4/BuThak28c9+Fbrm8=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=DqLce/x4tHDq+QOuMxRdFkc/OD2fC7MD5vxqsX0HdHm6llfTN/aGTSZTvAc1lmlKj
         ci09uT9bpEG1GfF5oDsCKm+AbYAk4lXtBLfd5r3kn+2eIZI4n/IDEzqNhshyqIPJ0W
         rNl6sr10EnimREwWZxXyAUk+3tT43kaMO+HNREamNda3mRAJDEwz4+TmFJi2KD8tD/
         pE/MxjyZCzQ8zG8yUgfQK+ouXiYbmKDIz4k9cMp31CoVs+DcDhAAU0q/dOU4W6pge5
         M0P9g19cdXPIlwxzcNB9RgXHF4srkd1wqzfqFKX6lcornacRvOHPOwfohmUb0KFqS5
         Z6P8L1N778Ysw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Nov 15, 2020 at 12:34:01PM +0200, Gal Pressman wrote:
> The first patch fixes the create_ah NULL check to only happen in case of
> kernel AH (!udata).
> The second patch removes the create_ah callback from EFA as it does not
> support kverbs.
> 
> Thanks,
> Gal
> 
> Gal Pressman (2):
>   RDMA/core: Check .create_ah is not NULL only in case it's needed
>   RDMA/efa: Remove .create_ah callback assignment

I squashed them together, thanks

Jason
