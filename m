Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42D4A153F41
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Feb 2020 08:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgBFHa1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Feb 2020 02:30:27 -0500
Received: from mail-eopbgr40057.outbound.protection.outlook.com ([40.107.4.57]:23438
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727904AbgBFHa1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 6 Feb 2020 02:30:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cc6sAe9fPlIttTG8dfENGGNxuEdinRdHOGfEInA9M1xZD7AZHU2G99QxXXcESpjpSNSxx6fgd6MPHnfd8Lj/Aznc9fQ22baZFf9m92nwPlmIwu787JbeIDd8Wan7TcM0bAb2xAcO6j0a20uSNeRAePGw/SIDsYo6qhWnRiNzNTm4oUeIpNDpUsmUGZlUdRGp6hiXZdUSNRVSKaA0lbfrII9rh0aNHUJHC+gHgN5KxuHxLtB6KC9UoFZjLJdXj98Mi27usHEzM8A39q4QxkZj4FmD6ORYhwFe82mfJzS00684/cmyGUh+aM4e67wayAr7ECeEKGVZbHSs/FEk23emOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwAV2qlksA6YChr6UNE4kFlDPkmy0EXusnEqLepTHrM=;
 b=IIurxGNFGLILrH/S2Wo+GmjyA66KyiucAoSdjq5J6qKoxy1RnsVeUAVZqYaYfIYNBdlJuKZBvTFlv5M5jTvKVujJj4ybjMVJQ3JCE2C5Gc9uNx+EldRs19XLWfuKNkP38WgKMms68rPRCKZqxRoRzU947b76JhPiwv/VU8tkJ31qWtl31lCOiB+Lu0tkKGL7hYDFz8PU3gbINx/2UCxA/zl7U208Xsi4utEfETWuzpa1LRPSbzF12EiJTPP/Tu8sImS/rUUagZgCMwtWDBjm7osWINUeOvXUuYbmWYOg3C29lSB7n25XGY6C7i6uH1ml4C+dKRWKk507Ug1MAz5WrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwAV2qlksA6YChr6UNE4kFlDPkmy0EXusnEqLepTHrM=;
 b=Ld6PaD377rscZWSsdlcxslKYthkoZZSxqtpisK44rh5qHYMHupE9b9eK3NjJaq+hVhbSXOl63UcmJqa8i/NM5+mDZsfTEySZsAeLRAPopsqRMIeIr327T9A6fYW5nShRMxNpvJVI4XoyjmDquLeXfvOaDSoY41Qc8PDDvkyCIvw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
Received: from AM0PR05MB6401.eurprd05.prod.outlook.com (20.179.33.209) by
 AM0PR05MB4530.eurprd05.prod.outlook.com (52.133.60.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Thu, 6 Feb 2020 07:30:21 +0000
Received: from AM0PR05MB6401.eurprd05.prod.outlook.com
 ([fe80::696a:cf1d:c438:bcd5]) by AM0PR05MB6401.eurprd05.prod.outlook.com
 ([fe80::696a:cf1d:c438:bcd5%7]) with mapi id 15.20.2686.034; Thu, 6 Feb 2020
 07:30:21 +0000
Date:   Thu, 6 Feb 2020 09:30:19 +0200
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: linux-next: Tree for Jan 30 + 20200206
 (drivers/infiniband/hw/mlx5/)
Message-ID: <20200206073019.GC414821@unreal>
References: <20200130152852.6056b5d8@canb.auug.org.au>
 <df42492f-a57e-bf71-e7e2-ce4dd7864462@infradead.org>
 <ee5f17b6-3282-2137-7e9d-fa0008f9eeb0@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee5f17b6-3282-2137-7e9d-fa0008f9eeb0@infradead.org>
X-ClientProxiedBy: FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20)
 To AM0PR05MB6401.eurprd05.prod.outlook.com (2603:10a6:208:13e::17)
MIME-Version: 1.0
Received: from localhost (193.47.165.251) by FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend Transport; Thu, 6 Feb 2020 07:30:21 +0000
X-Originating-IP: [193.47.165.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 11554267-29a1-4024-99e0-08d7aad66c52
X-MS-TrafficTypeDiagnostic: AM0PR05MB4530:
X-Microsoft-Antispam-PRVS: <AM0PR05MB45303831FF10A80A005FF894B01D0@AM0PR05MB4530.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 0305463112
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(189003)(199004)(9686003)(956004)(66476007)(66556008)(52116002)(66946007)(186003)(53546011)(5660300002)(316002)(54906003)(81166006)(81156014)(8676002)(6496006)(86362001)(6486002)(33716001)(478600001)(8936002)(33656002)(26005)(16526019)(2906002)(1076003)(6916009)(4744005)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4530;H:AM0PR05MB6401.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pJtRCL0rANp7tf1P8IiJg6wpLWahCUiHlr+0zmyr6pNG0RYeaiP7/tmjqCKx0rjnQYO35dEDOB2gv87iy+yeWZ6vR9kr8emm4jBrJlyOt3806aKMOp+HVHa6BInp7tifu55kVqUzCZYbOsltpzkAmIf3VurXfbUX17yQdDSePfc+0ATlZJX5y7X27+VKLM6o/NIUMWxGg6n6BBRJuOxxL/bc/b+MCyYHs1EPlcTaTagbTqTnu9ly/fhxYgbnIeoYEV/gIvlWAv0NBgOt2SYT4Kwe3vgE6JDe12/NxZTBKz01oIpnyFsb6BOF4Eox1Joeql5Bbj9bgb/ma6MSxmo/BH81npIofZVbJl0/7jBtU18iLHsX/YvGgfBBtlFJaobSBP3kFRodweX+9UcYT3/3R4ZYsIRLtCbBjrmm9E/OmKLatHELzlv2PamNA4QdrSPH
X-MS-Exchange-AntiSpam-MessageData: v3zTRxPXd4gXJ2kFjSsFlWdDLwBM7ATjgpiNGnbLNA9KUBv0NuYY7YJkGD791POdijiP2NQEtuRxJciG3idd6+or/3b0u5wO2WVPykLhszEH91eQlRjZ3QNWVFUCYsorz68oNg0DLscUt4rTSydcQg==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11554267-29a1-4024-99e0-08d7aad66c52
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 07:30:21.4599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YMk2hCQa82Rcn1rb/s70whecCYXpjIav/7wzfd9BKM6en1u/AXzxZeWn7dZWMiJVI1XWc4A7m8PnCTThGJ4bNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4530
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 05, 2020 at 09:31:15PM -0800, Randy Dunlap wrote:
> On 1/30/20 5:47 AM, Randy Dunlap wrote:
> > On 1/29/20 8:28 PM, Stephen Rothwell wrote:
> >> Hi all,
> >>
> >> Please do not add any v5.7 material to your linux-next included
> >> branches until after v5.6-rc1 has been released.
> >>
> >> Changes since 20200129:
> >>
> >
> > on i386:
> >
> > ERROR: "__udivdi3" [drivers/infiniband/hw/mlx5/mlx5_ib.ko] undefined!
> > ERROR: "__divdi3" [drivers/infiniband/hw/mlx5/mlx5_ib.ko] undefined!
> >
> >
> > Full randconfig file is attached.
> >
> >
>
> I am still seeing this on linux-next of 20200206.

Sorry, I was under wrong impression that this failure is connected to
other issue reported by you.

I'm looking on it right now.

Thanks

>
> --
> ~Randy
>
