Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE8E2139AC
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jul 2020 14:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgGCMA2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Jul 2020 08:00:28 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:18656 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbgGCMA1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 3 Jul 2020 08:00:27 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eff1dd90000>; Fri, 03 Jul 2020 20:00:25 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Fri, 03 Jul 2020 05:00:25 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Fri, 03 Jul 2020 05:00:25 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 3 Jul
 2020 12:00:15 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 3 Jul 2020 12:00:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j1JlIwmHt3PGaY4DJgBIkuqRQOKGEqK9yY8CRXzg+1xXd/LxB0ArlMrVBfPTWOfQwaDSP4VKucHzdbTq8WpjjwLcrcu2Lawz8w8Zz5dmxVTgh4ThHCeTHhdQNHPZN2Ke2I83698/gDYHUd20FRWAyZjvl6m9QIz6PjH/x6DZQ3c4dtwCjZw4bk54Zyr/HvjK1m8roeD2DX2mgG5Nw4JxTTiPTGjAFXjYNhfjno72rVSg5xnqUYNxcHsmCggGO8VssndzvFylYfeunbyOs6f4YMmNKL2M4eO1g6BjgsQV9gjRh291Zyp50futTRHtVZD1gJQUULzlCq3k3oMnNgzsEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zrnky/IRUOutWjJgZPvT2/RVTV3+GO+vIIZxc+nH7NU=;
 b=I3Kt6uM2U1jzaruKW4LHxJ/jmAm9lwfa7gY0h+dTkseYQde2MRUNromTO19v8hT0mXepajsAzjQHi2Ley3D61qMhdCUTGYF3rU/ac4AHthNyvcsuGq2Ym1cC0QE22D0Ec+cmAI0plX95Chgkpu0ZCfixC4kTCtZQlXtzAUbONN7n9HcPcpoP8No7w6n2YHkqoUQPPK8ysfOJXTuPw7JTUImsHUaTlOs04+yWHXp7Bzsvl/ikm4IXttctWODTlkazIFggDcbtBcNhVZGZx9JQZ+7k5q8DNqlnBCz7Ovdx+3sRn/ETpqwbDBvzW9btTvOVWdmVrZ4X5E4+NXUqMlAI/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3210.namprd12.prod.outlook.com (2603:10b6:5:185::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Fri, 3 Jul
 2020 12:00:12 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3153.028; Fri, 3 Jul 2020
 12:00:12 +0000
Date:   Fri, 3 Jul 2020 09:00:11 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next v1 1/2] RDMA: Clean ib_alloc_xrcd() and reuse
 it to allocate XRC domain
Message-ID: <20200703120011.GK23676@nvidia.com>
References: <20200623111531.1227013-1-leon@kernel.org>
 <20200623111531.1227013-2-leon@kernel.org>
 <20200702182724.GA744415@nvidia.com> <20200703062512.GF4837@unreal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200703062512.GF4837@unreal>
X-ClientProxiedBy: MN2PR11CA0010.namprd11.prod.outlook.com
 (2603:10b6:208:23b::15) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR11CA0010.namprd11.prod.outlook.com (2603:10b6:208:23b::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23 via Frontend Transport; Fri, 3 Jul 2020 12:00:12 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jrKMV-003RWT-Bk; Fri, 03 Jul 2020 09:00:11 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f021ac8-0040-41ab-b404-08d81f48a421
X-MS-TrafficTypeDiagnostic: DM6PR12MB3210:
X-Microsoft-Antispam-PRVS: <DM6PR12MB321058EB9348A2F34A5F4931C26A0@DM6PR12MB3210.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xQ0hEvnP+XO/N5NRDxQcFH0tIdLZG1oA4bdoPVlmcVmACmG3ZuDMcIse8/NGkoikX6ksRpJG9BVUF5Op+Uh4vtCzcmLYIPFQbgjcBdXkJeQ2PEgGJ7BFExAgVzjme9vimhYbkRuR6SFxfjyESvk4J59yFjVi8BvdBGymgGUE998Ao4qTJ0R/NB/ZmLMskDuVLdJFe037UvNgF2NQjWJcOrud/jN0uScWygn4aesz8rigL2mWC0biyPIpST9PQVj9QV72KVxl8rz0XWMGmvYSz4K/cGXuoSiUyMi1tAJaZB2yhaAI0CkxLV/z9jU3p7Iu0u63YB+roNW6jwzyc8LB5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(346002)(376002)(39860400002)(136003)(2906002)(36756003)(4326008)(1076003)(54906003)(66476007)(66556008)(66946007)(186003)(2616005)(426003)(86362001)(5660300002)(83380400001)(8676002)(8936002)(9786002)(9746002)(478600001)(26005)(33656002)(316002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: QzTALQ4M3170ePAjOaKsk3D0d+zm8XFOdphonzoxeJw7NHBJkcPmCtC+QskiXacpT/k/JucJjNCdy2/KP7dpUoXtu7rwfa9it1bMb5OdkIMQLN7RzJaXTMzGvEEhy618pzYZLkmnGPzEb2Xaj79ERZMRB6PPRVfbOJ3eMTGAz011T/duxZOw2DHh26Era6tYGJLNmGE19Pt5b+t+mUOjGN2Js5qtezVPPiItDUffar/OgWGs3M9yZhPQ8ngD+YfEeO5OhaI9vYd9LLZ47nsRccGbbPGDzxVGW4Or7FnG5iZQHq3e50/vhlV7tqUweeS63AaaedXyZ0MOazj/QJyjMSRrDr7m7e9o5u4IMSgDpoySMGetaX3TZP5yL57e7MYSM9fmsh+DWbOWIB+kkDy/O/ulXSQQOsa4GbYlrxlZ+ahwD+ZIwUgXkcjng62b4KCJqVVHURiXhU5YjEgYGznDDmWo6N7+YJqIbvKDcp0LnRo=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f021ac8-0040-41ab-b404-08d81f48a421
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 12:00:12.7941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MER+YMhb9PZGo2XAXJ2cTtdn+OsvPgULMHXz3UVJV9UERUFE5JNoS2/vQkOWI9C1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3210
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593777625; bh=Zrnky/IRUOutWjJgZPvT2/RVTV3+GO+vIIZxc+nH7NU=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-Forefront-PRVS:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=L+sBprolIaF+09maDC+LtoEyQ/sfDgK645cSAXEnAyONZF0FaWJwNdjjRjcbxBaWz
         +RBC3n64WKYoAYjrw3xxumexixdof50fhBivhYtTgHjQLYxEphO855uxUR6n9InqgX
         V488zGqHfewh9Pn7/S3tNuctUvel+jLuIIVkboAkQh2PdJV29Brk1W25EiAkREJVvm
         eQMaNbt4EYgvDE7Uo4Oxbtw194U/N/7CuPq75rsTggzv7fLsaqYoy6WwbHhScRYyoB
         QDl/McljnN/00DjAHCCUJKkpU+UB3U3nw8iG5482XZ7Nv8EbBOIepVNiexMPdqBTcd
         9Xl9zVW+DjA4w==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 03, 2020 at 09:25:12AM +0300, Leon Romanovsky wrote:
> > Why is this an improvement? Whatever this internal driver thing is, it
> > is not a visible XRCD..
> >
> > In fact why use an ib_xrcd here at all when this only needs the
> > xrcdn? Just call the mlx_cmd_xrcd_* directly.
> 
> This is proper IB object and IMHO it should be created with standard primitives,
> so we will be able account them properly and see full HW objects picture without
> need to go and combine pieces from driver and ib_core.

I'm not sure it is a proper IB object, it is some weird driver
internal thing, and I couldn't guess what it is being used for. Why
are user QPs being associated with a driver internal XRCD?

The key thing here is that it is never actaully used with any other
core API expecting an xrcd, only the driver specific xrcdn is
extracted and used in a few places.

Further it doesn't even act like an core xrcd, QPs being attached to
it are not recorded in the lists, the refcounts are not incrd, etc.

So even if you did expose it over rdmatool the whole thing would be an
inconsistent mess that doesn't reflect the expected configuration of a
real xrcd.

Jason
