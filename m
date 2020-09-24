Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF9E2779B1
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Sep 2020 21:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgIXTuG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Sep 2020 15:50:06 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:12880 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIXTuF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Sep 2020 15:50:05 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6cf8600001>; Thu, 24 Sep 2020 12:49:52 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 24 Sep
 2020 19:50:05 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 24 Sep 2020 19:50:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPNbM7WqzDfqyn40fA5v+X60hf/SA48re+yRwj+hyaBKDJGei7g9mj/Wq9lXWwLr7s6wGtH9xMklRkiZ5zcNx5C9prBpujb2Oupoqi5BwDSAOlyjB4ftMtmHa4PQZF3qtfD85BrGLWyTFzoYekhRMInux0zQQREjsgsVSLq1JwPM9759XGg8CBpnBj5umhzNO7aV0JdPTbWMRj5AdIvMPzEKmTg7OEuhgw2dvZf3FSBc0bWI0cnw5otYmxmjyFyuum4uVXTAK5EqlUzEXtTM//t/8+jXXdIJYsG8qZ/7EifaK7Hu4029ZC72Qj5gFZskmguZfDvDzXQKSPxHJjSxvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fzod1Go5YRZZQLhJWzsg6HzB80k8pzxHrPWj8Rqxp2c=;
 b=S0LSI1huJWi4FQkJ6Fwn6LgqTm9GbyUq2vMTg5nKg0Yb/0wsar0D5KePPE/XdRkx3f+5FtsQqVEVl8SigTuFVu6wn9ld+SN9Ct3ivbMHimGkFsGoND02AteK2gmzHCS8WWfbj07/RYkguSaZUbbFCyXxdphC6Cnfd5jJ3qHyTY/kfWjN4hm5hjBoKuGCdaP3GXlVtbaAVpcw35R+a54oSP7WJOy3ZPPDMEBX2J8Wli8SCGjjFH+GG09yhBybtQRUoRk0xbQOC13Bd3/fEPIgrq3G+K8AcLupVCfqkATRmJeGKU2wCj+y7WGSPeEwgvnPVCm+l5C7Zvgh855ao2D3cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2440.namprd12.prod.outlook.com (2603:10b6:4:b6::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Thu, 24 Sep
 2020 19:50:03 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3412.020; Thu, 24 Sep 2020
 19:50:02 +0000
Date:   Thu, 24 Sep 2020 16:50:01 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        Mark Zhang <markz@nvidia.com>
Subject: Re: [PATCH rdma-next v2 11/14] RDMA/restrack: Make restrack DB
 mandatory for IB objects
Message-ID: <20200924195001.GP9475@nvidia.com>
References: <20200907122156.478360-1-leon@kernel.org>
 <20200907122156.478360-12-leon@kernel.org> <20200918233152.GF3699@nvidia.com>
 <20200919090928.GC869610@unreal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200919090928.GC869610@unreal>
X-Originating-IP: [156.34.48.30]
X-ClientProxiedBy: MN2PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:208:c0::15) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR05CA0002.namprd05.prod.outlook.com (2603:10b6:208:c0::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.13 via Frontend Transport; Thu, 24 Sep 2020 19:50:02 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kLXFh-000Xec-7Z; Thu, 24 Sep 2020 16:50:01 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4e959c2-827d-4cce-263b-08d860c306c4
X-MS-TrafficTypeDiagnostic: DM5PR12MB2440:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2440D2F80DEB941A431A0A8BC2390@DM5PR12MB2440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P/xvGiZDbu05ihuoPy/uWpqW1J2XowmK55Xt/L120AhMQQjA78kN48pdv+yvUUrKjd095BSMBTqsgZWTVtqV0i3ajiHNmHaZeVlc3LRycllv1geL90/kfihybXMaRwrAJHrC0tR60zp43b6XbkQfrcbbts9Xl743/ueQD/81IskxZWVzBhF/VOn7Llc9nDZnsvPKmI4nF2bfEW2RhS7Ox5rg/KLJejwm0LmpZVHpGncoCTaKv3VKh9+lD5CRNaWwaz0H7mYqgTPBILG/WgWAXnrWOn5Qub1XyyipTWcuLQEt8G91zvbiWyIf6U3t0OdERWwZVAGfHYaNIe3ks8FZqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(186003)(66946007)(2616005)(316002)(107886003)(66556008)(36756003)(66476007)(9746002)(26005)(83380400001)(4326008)(54906003)(33656002)(9786002)(5660300002)(8936002)(6916009)(478600001)(1076003)(426003)(86362001)(2906002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: MwilTdTiZjY3tkHTuTOLjhEY/tKEo1Dy7N3K0nFofmdQhqNP03uzi+cIwKZH9Wdl9o1o24RxTI7FM0QLJCpXkgKf2iBENO0e3DrX742+z/zr1eG0CS5qXlofFDBLolkQK9ETjb2Xp5RRxm5dam8n8IkK4T2XMH0nfcQya7LutSMOlkuzAbQdUec5vHgE+V+ae4fife+1SouKgtSGIDou9fSRZyJP2zl8dohEwd38U+KOlbw/eaC9AF0v6anTm0W5soJPigEd3K442QMLgHy2zlXArMUIUXR5Wc3UncjmZCfN4mSeBLEbNN3sFakZOlVqNfNQzxblfF44Tvsx1OAcYmG7rf+twT5K7QQmaeCEW9/g3cSPb0wBHL7m5yHdi0wPE2xooPctX9sPHx4YFvHgoi1ySUleRfNHH0VJ0uTAZEDuOyvNsrIKYTINd1aq4Z173WwtfF3pnv1w54DsJygzN9yroLjSwwY7nQJPmLb9wX3j1ck1qFS5P+reA3XkBXANypQIG56H5VOh+e+iN/cndihwBvE0+5QxLnQoSRAHSU0Gd0xtxL6gVRofgwWP6/Q3BVSQDLagt89iHfIWgMCocXcyA5fFrGKd1/GuvAYx0Rd+vQIu00XxWnPgyc8g0oKR6Ad+31SQmJoYn7MYGCTDOA==
X-MS-Exchange-CrossTenant-Network-Message-Id: c4e959c2-827d-4cce-263b-08d860c306c4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 19:50:02.4720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QlJ9zHrrIFlLwE2QiVcyAH1ZQxgOwBCfvEjQaMr9aXEZsnRUVv/Kpo3le75i1lJd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2440
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600976992; bh=Fzod1Go5YRZZQLhJWzsg6HzB80k8pzxHrPWj8Rqxp2c=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:Date:From:To:CC:Subject:Message-ID:
         References:Content-Type:Content-Disposition:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-MS-Exchange-Transport-Forked:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=TGkK2Yk+LgtKidS8azgjQZrzMLmKtnnAKb+uBZfe64aJcM/LgKMxQ49qnElM4et4j
         wEkIRkt+9PZKYhomDgGBTyY5Usqm+g1bqQ/JqgHgaMsyZayRdH5PN9JqXmZbfsvxA2
         MmgHvR95XSuPwypxBgcxNcKJAYwrCDRwg+lPXnskADkfSZBGHQr1HkFRzdCdr+kVoS
         oochXwHi2xkEGsAVSYIpv4zbWcNu9OKUsVYloWOtLI3jgGA4b8X4+2/yrhjgaaq7aC
         n8oRAU1yrZItKd2vqVcbWse6R+h03pgMrmk8sJUMohDuO/g5otgHYTDGjpR7MCrtU2
         i6QqhqiHOAErg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Sep 19, 2020 at 12:09:28PM +0300, Leon Romanovsky wrote:
> On Fri, Sep 18, 2020 at 08:31:52PM -0300, Jason Gunthorpe wrote:
> > On Mon, Sep 07, 2020 at 03:21:53PM +0300, Leon Romanovsky wrote:
> > > From: Leon Romanovsky <leonro@mellanox.com>
> > >
> > > Restrack stores the IB objects in the internal xarray and insertion
> > > where can fail. As long as restrack was helper tool for the
> > > debuggability, such failure were ignored.
> > >
> > > In the following patches, the ib_core will be changed to manage allocated
> > > IB objects in restrack DB for the proper memory lifetime. It requires to
> > > ensure that insertion errors are not ignored.
> >
> > Why? This looks like it is all about removing valid, not sure what the
> > kref has to do with it..
> 
> This DB is going to be main source of all HW objects and their memory
> allocations. We want to be sure that everything there is valid.

Not really, what has happened here is no_track replaces valid. valid
used to mean the entry was in the xarray, now no_track means the same
thing. The patches in between had both because of how the conversion
ended up

This commit message should just explain that valid is no longer needed
and no_track now indicates if the entry is in the xarray or not so
destruction knows what to do.

Jason
