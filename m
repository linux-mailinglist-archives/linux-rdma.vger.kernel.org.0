Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A620449FC50
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jan 2022 16:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346346AbiA1PAg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jan 2022 10:00:36 -0500
Received: from mail-dm6nam12on2061.outbound.protection.outlook.com ([40.107.243.61]:4192
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346718AbiA1PA3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 Jan 2022 10:00:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEM2mgZBBTH4lWinHDHmIef3IYbC5wJLj/pH0qiTpzTkIC0O4q97q3NgrRtfq9J3vs3LdF+DupsNdIMjkwGBXyBpPQa74ODl1kCjiWaIw41H/CvFSLZfZJB12sLTaH7jFeH9dU846EKO/RtRc4UVVbNniEADrcvDLykagsYAC/pZKPIdvBnmTPf40UyAiEb1zQBDiJl+muQmfx9yI167I7i5DpLgsm67dSCKNxTkrIgtERgYp8+W9OmDDf8TO7QX1FW5ZgdiVQS7pkrYlRqqhvMAO/jaHKEvhc5r78TggIiLMPqjPFo3rwhoQrgT21sqtEwzq4/2wOANlkhZvfScHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMmrSCjVLtpMCsSW8UMQLv546NRiDC0vxKy/28545fM=;
 b=ISAx+v91D9g/mGnN62/N5w6Oy5W3v223+ayxW2qE06uLhAkO7keq7q1FfxDAn13YrIU/VuQrCYMfzH9/Zt8iTpf0KDlJdLQWyz7lbLuwlnDZs62amKISmmAbF6qzyvmBDs3EV/bUpUVOfsxVGVwMum+uk/fC1HV82SzzXmLEfPvuNcqtZE3vuEp3+jBff4wgt6In8foVaCj4ZOjHI30sDQPJ4iV6bk3HeKqa9RQqwK+/HSkn3CLlKRgdISH7eIf/Krnv/eu4co3/6/pT2Q+MDKPhFBYhb76NYsWGz7i1TaBkStlxB33n5ATkn87sTtTj0lwPDFtXoYUaC/4usSA/Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMmrSCjVLtpMCsSW8UMQLv546NRiDC0vxKy/28545fM=;
 b=W0ZIJTDg6tdAjoBwGgeN/QIyImyvTPjr94viqJUEGk0pSKjWw08Cjh+wYI67M6oEn74WgxmYwcyfGezIRHgjcwIkCWq2pxhcvPjFEaoH2lh8NDgWIH8pVggZH0VsAtCPPrTvau8BfMN1nnPg65KkIvPkuYWI3se5DLnLsd+XXjAr7qtXxO1VxjFCyRydbrl0YJcxwufN/S016htw9EL4LUF/+Vxuoj5ZOE1EUMnO8VCMd/1gPOYRmm0MJD6Q/DKkZCU9uJT/6HuZoUo1alT3YO5vS/+zuRokwwFHiuIxh8KqS+h1qjatqy5L8M9GPx/r1AaNAzcM8cUaYfOpu+5TYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB4481.namprd12.prod.outlook.com (2603:10b6:5:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 15:00:28 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4930.020; Fri, 28 Jan 2022
 15:00:28 +0000
Date:   Fri, 28 Jan 2022 11:00:26 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Haris Iqbal <haris.iqbal@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        dledford@redhat.com, jinpu.wang@ionos.com
Subject: Re: [PATCH for-next 0/5] Misc update for RTRS
Message-ID: <20220128150026.GA1797164@nvidia.com>
References: <20220114154753.983568-1-haris.iqbal@ionos.com>
 <CAJpMwyhEK8gKNebu91da+1=GzvKAktxbt2D9hrqRyxFOULvRgQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJpMwyhEK8gKNebu91da+1=GzvKAktxbt2D9hrqRyxFOULvRgQ@mail.gmail.com>
X-ClientProxiedBy: BL1PR13CA0177.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::32) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9007bde-0352-4f9d-b723-08d9e26eebad
X-MS-TrafficTypeDiagnostic: DM6PR12MB4481:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB44814B066A97CE4463377B22C2229@DM6PR12MB4481.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lBiqv7XcHlIYTKq8iqe/PRoPT/cEKxlHg+0p02dFRwd8lUFw3YWpQr8LaiEYwrEAAxnp+OJ2W1w9LMTuDXvasFw9YK7Ut9MfXeacvrvazg6QGvye6yS797yawitY6sFM0+eB6efZYlPsP/7BwOX7GHeO05EPyEkYLSaNpM1b8dzTaJ0LcD6o/o4Yd8Ca27f/5Q2RaWB7S8Lf7f04uoskuo9TmwE9W9+gicCdxCSebuwsnSRSCdaY73V7SrKO8rKCJD2TpiGhesmZkbIVq6P5cIf/kyn7akWYr3QLrp4SBhKdVttZu9pdsdLp8ws34i/YZxwQLORU33DPtNL6tvi+dQcoD/tYfBITeAwa+8Ds4+2XBiclrtmjk5mSrUh933q/f1cT8dgev7ne9CkFdfCd4pATAMXF3n5QzPJ7bLVT+EnB4Prol+PvzB38YWl3J2VwGNoReDTErsb2CyRKQHKNPQkJubNQ+TpAx7dH4bqR2gwhSqvMQDDPOFujDv/xgMcI5QJ7FnCD2zVBP8wy5bvOPv/uPXvneGLD5yk03eCZYj+KEq5uUujrEEjsFWJI4hANAo/rQbr6BHmuUTcveHnl3L1imh8BMRgqB+mJhneeyDKCunKfZG51LNMWY774tOjh2Uuu6fDTzGcBoTnT1zcu3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(38100700002)(86362001)(4744005)(4326008)(316002)(8676002)(66946007)(66476007)(8936002)(5660300002)(53546011)(15650500001)(66556008)(2616005)(36756003)(83380400001)(1076003)(26005)(6486002)(186003)(6506007)(508600001)(2906002)(33656002)(6512007)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5dW9JRd3NZgjCwdUXGK2SYWxCLoIo943xoUhe2ewEc4qliEN1LFTPMqFmVxv?=
 =?us-ascii?Q?4eFsw95h+OfzO7F5kFoaeMCA5VdeATTttgkE6RyKF7HLfVQpmKSKh4fKuq0S?=
 =?us-ascii?Q?lat/IwdLy9HddwREK7/5BinHOsgzYq8MpusM3xwyi/Ua+zxlhMqC+4w8PJhc?=
 =?us-ascii?Q?FSrK3iBu8vIfWgsCqJiAA3GsLNlib7IKc0l+OmXw2TkPGPPwO9TAGXzTWKaa?=
 =?us-ascii?Q?Ugad2niLi6i7bqRtekrSjzKqdjjIL5bWcEby9Js8pb92jVXp8j7Y8p7neIx/?=
 =?us-ascii?Q?JHxHe9svgNIcsuuvz2WggdEq6BCu0mzva7EGs1NB37z/rKMNOzdciT2+GllV?=
 =?us-ascii?Q?6uvUMA4Dr8iKFDhVKXVJCqeTs9wkG+M3iWmEf1habA/Nyj2dI5dCehXOnxWi?=
 =?us-ascii?Q?YWLulA6lSp5r7RI+2W8QBL09MSE2F5PsRHbqkmxNgOnh4uxKBQ8W/sNiYB9R?=
 =?us-ascii?Q?5qtLSoRepnfHgMrMqozx8OX7A/S9Rdsnnw3eeY6t26RVlwjAUDJkVw4mqCax?=
 =?us-ascii?Q?ibpqYeKhtM0Rd+5ZBsVaEyLf3F9NwuMnDAci7d49rM410+CuMhYUp3rSbjV5?=
 =?us-ascii?Q?0erplrMRrcgUksgu4fLMYjzmJbLoDrIZ/bseMt25lBkd7ilS1Ou7z+1ctYyG?=
 =?us-ascii?Q?lhUuZ5PGCiDDE4BF4YvQ9UVnf83WaaDUrKlVJWsNgU5j7SeSDZD1kIF1qh/i?=
 =?us-ascii?Q?bSn80CmHLAmqIE3yhCfBB9q/SFRIIGQJJ5bUXXOVsyYNKYRojc8FFX6uqx5b?=
 =?us-ascii?Q?VZd8MUXWmjoUoYf3pvVYq1vURMVDOY8IeDRX084saGTvt/EXNbJYzZT83Nye?=
 =?us-ascii?Q?jZruTLzGr9pDKXk8QkZYNERh2SaXwkKMM4zLrFZcu9H54LbX4+SQWDaCKl0n?=
 =?us-ascii?Q?fLOGrA2FAkP7Hz2ez+V63gC+dizHsn2Ntf5DoqEZ5rn3jQL6DEUF+bBEycwn?=
 =?us-ascii?Q?SUM5fgwudqTHZcyPzUBEAsymGPxZGNCD9+nN6RDAtcURWL8awOn+XKvF5FIV?=
 =?us-ascii?Q?u6nY3HxUctHkzFt5hYpCeKJaDVqnMRwzDpvEc7PZk7io+jAbacG3ujk8Njzy?=
 =?us-ascii?Q?9ShGvPnf+AEM/LSaYgFWKiKWS7YrFTW6+X+wi7cj54Dm10wjCtx/PytJVca+?=
 =?us-ascii?Q?cAk0Pe9n88G7bNplLpEIKwvfVP4lT6ptxUDRH6eQerD5BbI1B7OFijCfsD7g?=
 =?us-ascii?Q?pPRo3Vh5LAQcMclPD69Quxe1MRXoos8f7Bgxk7Wmc/AqCmX2kvbVsWlP8OUj?=
 =?us-ascii?Q?dcaYqF1gIuH+AJS2kILmwQm8KwVCOnbjJtRnX0vGm+fNjwjKnB8YoavKwjqF?=
 =?us-ascii?Q?KCe1oSuXo3PU86S6DuaRcpegNOtmOJyHRwWkGza2yQ8Li75mi72WyzJze8av?=
 =?us-ascii?Q?xHts/7eECSaVI04WvkRvDYMFz3A8XElDlSNhRB7AXHfH/kXHpkr2nMw/BQ36?=
 =?us-ascii?Q?8onbF6IBNWowj1CkS80G+GxS7QmLl24TcjWY2PbI0Mu0RSkHHv3dIypsLlox?=
 =?us-ascii?Q?/rcLgHo2Q1WDLocmLdbIMuR7O4MzYeBPxhY8L9PO/iOVfGOkKwCWfiwkMTF1?=
 =?us-ascii?Q?UZqWxTbHs9LVf7NuNp8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9007bde-0352-4f9d-b723-08d9e26eebad
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 15:00:28.0075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jzIyfV2HMDlzaQ1B8DPfx10c4RpeMx7khmYxacLD3tiUKO74rBzxagH6JDa0rjE2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4481
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 26, 2022 at 02:56:31PM +0100, Haris Iqbal wrote:
> On Fri, Jan 14, 2022 at 4:48 PM Md Haris Iqbal <haris.iqbal@ionos.com> wrote:
> >
> > Hi Jason, hi Doug,
> >
> > Please consider to include following changes to the next merge window.
> 
> Ping.

I don't look at most patches during the merge window.

> >
> > The patchset is organized as:
> > - patch1, patch2, patch3 fixes warnings generated from checkpatch
> > - patch4 updates a comment.
> > - patch5 In case of error, performs failover earlier & avoids deadlock
> >
> > Gioh Kim (3):
> >   RDMA/rtrs: fix CHECK:BRACES type warning
> >   RDMA/rtrs-clt: fix CHECK type warnings
> >
> > Jack Wang (2):
> >   RDMA/rtrs-clt: Update one outdated comment in path_it_deinit
> >   RDMA/rtrs-clt: Do stop and failover outside reconnect work.

I took these ones to for-next

> >   RDMA/rtrs-clt: fix CHECK type warnings

This one needs some more thinking

I fixed all the commit messages too

Thanks,
Jason
