Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF37295E10
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Oct 2020 14:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438021AbgJVMKo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Oct 2020 08:10:44 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:50803 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390905AbgJVMKn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 22 Oct 2020 08:10:43 -0400
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9176c10000>; Thu, 22 Oct 2020 20:10:41 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 22 Oct
 2020 12:10:39 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 22 Oct 2020 12:10:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFuTG9Svu4l7dxHUXC1BkCXQ10zsf9JwHRtRA/nQdiCYP4dCMmDxKCjRLLw0/peDZzkFVLeus2ltCaRFiwvlwFHb9gGWJhIxh+kwHNkBqbin3C05Pu4c5+CfY6YDYURpBbHwn0h1MKHNs5Nm+quOJV6caZKjT6O+T4z0xYVd4qU2xdBuEPjfC+lvj2KSvbpUX3nG4O67exG0GwrvhcfFW6uXxNze9neq/rrW7aWuEj0F2cUo6Ori9+YccBvgLmFuOioepS+n/u8FDt3XT7LJNE6mQQnN6Cvb2KkP//FLzPFjP9jq3HWHUvThKBMu4h+IFQcTh9883iMxcQoB6zjU3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iz0P+u1Ou8SsN6TMYUA/zwncbmIBAxKacmHHIyD0P2I=;
 b=kySLxNb9r8kfZQ4esyxu8OZWWqCOF6QF7zNeHaiPqgCDZujS7feMHowmr4vhVWKLU2LuHRp5wRMKnD61CiSIK4WrqjWAFaAAsbW1JFnTT2TAJLSAhiICWNZWtxr4t7FOjaqDnHcsknlmnuSBFPl8LQgN1E4sKojDcLXlCwagRj5f54QfHTNh/Tw9m/3G/m9cgu9rTqV4FYZi2Y5p7z63Os1ASAP4linsF0XRfkKPp0DpnZoJs2BfsfY2IeWg+d/s175LbyFB2q/r9f9QvRqVCqjR9Y5zCjUcpiUGCPrSnq6g2JN/A24/IXsHVjOyoJxMNtURk3T1Rg79pWHN6PWgTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4012.namprd12.prod.outlook.com (2603:10b6:5:1cc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Thu, 22 Oct
 2020 12:10:36 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.028; Thu, 22 Oct 2020
 12:10:36 +0000
Date:   Thu, 22 Oct 2020 09:10:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leonro@nvidia.com>
CC:     Gal Pressman <galpress@amazon.com>,
        Avihai Horon <avihaih@nvidia.com>,
        Maor Gottlieb <maorg@nvidia.com>, <linux-rdma@vger.kernel.org>,
        "Leybovich, Yossi" <sleybo@amazon.com>
Subject: Re: New GID query API broke EFA
Message-ID: <20201022121035.GX6219@nvidia.com>
References: <3e956560-3c76-5f4b-b8fa-ad96483cd042@amazon.com>
 <20201022112100.GE2611066@unreal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201022112100.GE2611066@unreal>
X-ClientProxiedBy: BL0PR0102CA0062.prod.exchangelabs.com
 (2603:10b6:208:25::39) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR0102CA0062.prod.exchangelabs.com (2603:10b6:208:25::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Thu, 22 Oct 2020 12:10:36 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kVZQR-0041Lp-2X; Thu, 22 Oct 2020 09:10:35 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603368641; bh=Iz0P+u1Ou8SsN6TMYUA/zwncbmIBAxKacmHHIyD0P2I=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=ktS3MewPFZ4dRTsJ9shjmsWOdNqd9Nex6n8So2O5mZs4D0Xb8uwktzv57iIBubSI2
         BbKF4D8pRW2Les5bWJcK6tfxFmVtFeDkeTclAhtaUjvfuprtZOFdM9YiMGc4h7kjAd
         4j23/1ZXIZUFx9MM5FdoQ0OjBNaJhHE8ECAc68jBheY44KjZqULYiQ0niijPie43ID
         MjlI2J1feWPFRRUa4qnBtWEeCecbv2TDnn3nNVeNRNasmyJwu4c6VnAkbe3bTnkYQV
         ZavG2jkCkcuDNZOTSAFj+t2CiAl/cLAdc031RlR3hfeloVut6ZXydGKijULcHZYrHX
         2yYqZEu2AXCKQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 22, 2020 at 02:21:00PM +0300, Leon Romanovsky wrote:
> On Thu, Oct 22, 2020 at 01:58:29PM +0300, Gal Pressman wrote:
> > Hi all,
> >
> > The new IOCTL query GID API 9f85cbe50aa0 ("RDMA/uverbs: Expose the new GID query
> > API to user space") currently breaks EFA, as ibv_query_gid() no longer works.
> >
> > The problem is that the IOCTL call checks for:
> > 	if (!rdma_ib_or_roce(ib_dev, port_num))
> > 		return -EOPNOTSUPP;
> >
> > EFA is neither of these, but it uses GIDs.
> >
> > Any objections to remove the check? Any other solutions come to mind?
> 
> We added this check to protect access to rdma_get_gid_attr() for devices
> without GID table.
>  1234         table = rdma_gid_table(device, port_num);
>  1235         if (index < 0 || index >= table->sz)
>  1236                 return ERR_PTR(-EINVAL);
>
> So you can extend that function to return for table == NULL an error and
> remove rdma_ib_or_roce()

How does table == NULL ever?

Jason
