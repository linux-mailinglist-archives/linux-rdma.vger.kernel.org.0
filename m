Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB59390920
	for <lists+linux-rdma@lfdr.de>; Tue, 25 May 2021 20:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbhEYSn3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 May 2021 14:43:29 -0400
Received: from mail-dm6nam12on2068.outbound.protection.outlook.com ([40.107.243.68]:41313
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231356AbhEYSn3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 May 2021 14:43:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WD1tgrEzfJbO8ZUxfLtgxnaluiq2Whv6ESmYzMqmshaevY6WHMzAdkLPIqgpXRl7YA7tZT4P/WKSPU3jlp1DUrOmQHtbwNGqV5QQE/QC2Q+m02kwVtJprgF3XgN31bVnpcTE/RHjOQtGVjN0oJSZMq+clQawMfwYctK75/EYrT5UPdW2hF3eA+HnIkOHjnHOnmwcPuLdwLZh8uZNV8DRxSAblRAafN6CUaUM2PraVfKGM/wxRQA/IbZ9FcPl5i5hn/ukzNX4vMcFO+cl1mfXAsY8fdymH5fPNerEiCN4Yg6n0iu9mToddvjDqKs9MZKHsrgvHCg2VsGOWdA1cB74XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdOOidRq6dJDNWj84X+37ZDmLRd8zaW/0txz1GdIfuE=;
 b=lNlXh+Yx3uxZCSVMEegP6pMna/lHrCsQ2OD4Ky3mZSwXWJeBB3siDJ/65Ovwi10sKMtN1rCDi5D441scXAGqhF/cL6/Z7LNHj3ENVAAoBH8Yod7rmRlo1v1rzshq+tGp85enC+5qUyXN6ie4blRGFH39UzkfXZ/UKu/EGOZFfJncQTHodi3pg6akenFKmF+96gl4R/nKwTWnlEMHMoPMFHoslkOWkhPRb6f0VBzlLVAJooXw5PoK43drhrtWBLDvPGNNMxUc2lE7zM3uFuDS1OctZaAxkrJwb5UkBWW6OEZXoIF1Di8fXB802BDDyr9ecvturK9MWy3KSiQZEPV+VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdOOidRq6dJDNWj84X+37ZDmLRd8zaW/0txz1GdIfuE=;
 b=dbRdej3KVuEmEiqh940pEK7KpaDuKi2fhIorltzkJ1hBc3TjJe3Bp9Ba3xHRu9cJRpr/wirOB0DzqLXPtJ9lkfuY+G/u40z8Qdk1cWWbF7lcunJeLGRQqouxcv7RwqpUI5kAIALok5zFZ2ncoKIJhzyCGuRJ3O6z6kvop31zZozWJ0X2oU0YOBjuIKaS63T7u5FOIceDq/ynTVpp8JlGdRUMvFEt8W5LO242zp6eXwpMxcKbwCLrPu68mz8Vc95+TdTL/JYJia3vOpX4j+tIG4jy82pSgCDSOC7Lv0vFlvo3ObYmk8O1LXg2Qf6s9+XCBRKdyDMzVDiDNZPTUo3r6A==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5128.namprd12.prod.outlook.com (2603:10b6:208:316::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Tue, 25 May
 2021 18:41:57 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4173.020; Tue, 25 May 2021
 18:41:57 +0000
Date:   Tue, 25 May 2021 15:41:56 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Pearson, Robert B" <rpearsonhpe@gmail.com>
Cc:     "Pearson, Robert B" <robert.pearson2@hpe.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next v7 00/10] RDMA/rxe: Implement memory windows
Message-ID: <20210525184156.GF1002214@nvidia.com>
References: <20210521201824.659565-1-rpearsonhpe@gmail.com>
 <CAD=hENeKHgwLEOAsZ+2tu7M-+3Pv9QVccbWSwLy+zV-zX2h-bg@mail.gmail.com>
 <dd81d60d-f4fa-feae-90a0-201ee995e07f@gmail.com>
 <CAD=hENeP=wh2gHAzkyi9KyZrKmDcmQeR3GB46Re-7ufL-CJqXw@mail.gmail.com>
 <CS1PR8401MB1096CDA5C1FF0BD22611015FBC259@CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM>
 <CAD=hENdi4XC=ZQDnm4TGx2CHTgkQuFWd2ET7GbXOMz1zsz_JRg@mail.gmail.com>
 <CS1PR8401MB10960767E276430FB619CC6ABC259@CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM>
 <CAD=hENfATTprVG+wYa+1qjdTcuetLyzTt8gHjfcWp5PsLVL4Pw@mail.gmail.com>
 <CS1PR8401MB109691557DEE165AC0B9C47ABC259@CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM>
 <77192b9c-9d8a-061f-5ffc-1052504104bc@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77192b9c-9d8a-061f-5ffc-1052504104bc@gmail.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: CH0PR03CA0114.namprd03.prod.outlook.com
 (2603:10b6:610:cd::29) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH0PR03CA0114.namprd03.prod.outlook.com (2603:10b6:610:cd::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26 via Frontend Transport; Tue, 25 May 2021 18:41:57 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1llc04-00ETan-75; Tue, 25 May 2021 15:41:56 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58c69315-9b69-4cfa-e9c9-08d91facc69c
X-MS-TrafficTypeDiagnostic: BL1PR12MB5128:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5128BC63D257816F3313C29DC2259@BL1PR12MB5128.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iwdR5VmlUgm6HMXVdlMgqILuH+TchUyMI/wIvEy+MW+UNq/H8yIFzbN4aoirt+ztcDRm/+mfESgSXQ01SE8gWHI4VZ1OHW7DbmiOavp+r56FBnRZkOma6Yq+fNYs3E1JXvGVAyXVzCgrZqZ3/RLvGR36lzfEp2gUbO22fdv2e+wz2Oamoe6vEi+J48ZW52Tldl8m5cTOQGRRrDET/a8Tom91MNssqzTRacaadf1AIH5T2I2OiTCWu+qOgc9Y2brTLVCCijy+jSmQznss8MOXRb0UTTVz8w0i5GwQ+Eqhq00i3ZpMo5/qK/8tGaS984VbM1D+hH3vGYfvX6VoZ6Tx/bb70eBNlGgR1ULpXii2tO1SzKb0EXLTsQUjRckUADYyPNu0ppVYytsDfK/3bdbUFGH9euV7+05RqcBpCrJ6hxmsca5jO/pqlGg7pgcTlmmq0U6lYM/+IX4Mwu1DtEiDyt5rmNYVM3NdQZSkcUssakx/CT4Fgt2Nw21mzUyOQ/6NvR8iEc1NLTCSa/Bo9D+4bRlYcG++uHo/VZqGZGClJsBX7Fy2Z8F3qu+V0R78H3a7CHis3Hdirho+Et6UNZ2MN7UZVOiivMdLLYomGHocPTc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(316002)(8936002)(36756003)(83380400001)(38100700002)(4326008)(66476007)(66946007)(2906002)(6916009)(8676002)(9746002)(9786002)(5660300002)(1076003)(54906003)(26005)(86362001)(426003)(478600001)(33656002)(53546011)(2616005)(66556008)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?z9uDjNP2dadoc1Sgm1yPbH7NNDweVXsNCee0ps202JpQtTHZNREOcmOOa8yP?=
 =?us-ascii?Q?S3SixKwfGILiL/IgvEfwMEbbDAPer38iBOVGNvr2g6h8ZwCTCrGAZ2qnNtpU?=
 =?us-ascii?Q?K0C7TfBOkdN5La+4rgbj8SaPkOzRXJacNbsCLAXfpm4XETYH04khLHanx9Z9?=
 =?us-ascii?Q?3VMKB/F+GSTsZIQGILBP7mxz13iVTb/oNOTVtYpGZ7M8uzaoMPOCgU3GyaeA?=
 =?us-ascii?Q?HA1iGgH/5E4XZKkg8fKs3dPyYqzzmYrsp/AKCHTax2JoIH9jrapuZ60jsn7Q?=
 =?us-ascii?Q?Hgyc8UYzYYzE+BkrvyV1Sb+YDCSxrAzlnXD/5sXqZH/Yrs3+2PPO14kZe4sR?=
 =?us-ascii?Q?SEYEdrBBJPdVj4VaZqqYm7uUQoLu2kn9HVO5jhnOKtyjUrOL+fkSLRcxLzqV?=
 =?us-ascii?Q?2xyt3w3NibDGJsKV+Kys+0YLMhfMCdUyjJ2lUfE1xEyDbGqYLAzSMUiax9/k?=
 =?us-ascii?Q?PtnetGEfVIsDucRe621QisoyIUMkPHFVB3dwIKgjbD8awYOObI2BNWLO3JuI?=
 =?us-ascii?Q?JWn+/uFHo3O4X96Fo3GLU41tOcRxRkNSiSf1hXD83+U8Tc1oO4sYfkT9GhGq?=
 =?us-ascii?Q?jUEdTZ6lrh2TXRDFV6ZzX7jUSr0gffZmoy62wmg63gvCswUZAbAlbxc5PeOn?=
 =?us-ascii?Q?51/0JniSWYEON/a9dJqctER/t3w1LU3LKpo9C341fOuGER+KJ1wZcuWnc8Ly?=
 =?us-ascii?Q?KhSZ/a2YPDqrYNKnAJNU1edBcRwVh7+ImiTWhMrYLcxGUjNpvwMpeBRZ7Dgy?=
 =?us-ascii?Q?lFsrF9/T9QWHkZ3uuxrH7af0UWWdtBgy+aYAAlkWVNbuN3vdTv6UqE2NxpBY?=
 =?us-ascii?Q?w2y116dMXHp+kxaHsYVyFmoIo54T08VKzmYMRqj3EmekjyLald/s05Dt1T14?=
 =?us-ascii?Q?PR8t3jhhKBGXS8kZZFRzLNcBUV2+i596VbtKBCImF7cTKzeh74ncKv6ghHVK?=
 =?us-ascii?Q?VEmTdDiMHV92y0CQDsZ92tJVax7hQa7Y+dYalj81nniG2B+Wd221l4IXm+dv?=
 =?us-ascii?Q?UsXXo8sb/lKeMyN3OhYcmJDfyjvwTKZQHC1D4MgcUm91Jzti3uC9XngdNO/Y?=
 =?us-ascii?Q?3UYbaok/+/VaUggbahy3sQT70+gJjl1aK40HGQV+6sX7ZiQBtgM4m9E1cSIY?=
 =?us-ascii?Q?zb0VyT7/6mLSCr1OBEjBCn6GpEi1yHzg/9F8e+KPB24TflxZTRwOeI8rict0?=
 =?us-ascii?Q?qHCcoBv04pfaF2zUdBgVpNY7xdqTqae2ekiROcUvwJENgP3MLJ0B7iUawGLz?=
 =?us-ascii?Q?shDiI5c+RgYd/jGkP+Y3Kj2CnOqjZlvXo8M0H/f2Nfv4zldwEjbdjnTfX4NY?=
 =?us-ascii?Q?arAIi0XoBPpJoGzWUvoTs3s+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c69315-9b69-4cfa-e9c9-08d91facc69c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 18:41:57.8545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FMV3Rwo9QiUawPDf9DHOiETjEzwaUw0wpLIpg3ONRsh7ch6noJFAX5yLhpBwakP+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5128
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 25, 2021 at 01:09:01PM -0500, Pearson, Robert B wrote:
> 
> On 5/25/2021 10:23 AM, Pearson, Robert B wrote:
> > On further reflection I realize I did not understand correctly the user/kernel API issue correctly. I was assuming that the user application should continue to run but that we could require re-compiling rdma-core. If we require that old rdma-core binaries run on newer kernels then the 40 bytes is an issue. I always recompiled rdma-core and didn't test running with old binaries. Fortunately there is an easy fix. The flags field in the earlier rxe mw version had one bit in it but the new version dropped that and I never went back and removed the field. Dropping the flags field doesn't break anything but lets the mw struct fit in the wr union without extending it.
> > 
> > I will fix, retest and resubmit.
> > 
> > Bob
> > 
> > From: Zhu Yanjun <zyjzyj2000@gmail.com>
> > Sent: Tuesday, May 25, 2021 10:00 AM
> > To: Pearson, Robert B <robert.pearson2@hpe.com>
> > Cc: Pearson, Robert B <rpearsonhpe@gmail.com>; Jason Gunthorpe <jgg@nvidia.com>; RDMA mailing list <linux-rdma@vger.kernel.org>
> > Subject: Re: [PATCH for-next v7 00/10] RDMA/rxe: Implement memory windows
> > 
> > On Tue, May 25, 2021 at 1:27 PM Pearson, Robert B <robert.pearson2@hpe.com> wrote:
> > > There's nothing to change. There is no problem. Just get the headers sync'ed.
> > > If that doesn't fix your issues your tree has gotten corrupted somehow. But, I don't think that is the issue. I saw the same type of errors you reported when rdma_core is built with the old header file. That definitely will cause problems. The size of the send queue WQEs changed because new fields were added. Then user space and the kernel immediately get off from each other.
> > > 
> > > Good luck,
> > About rdma-core, the root cause is clear. I am fine with this patch series.
> > Thanks, Bob.
> > 
> > Zhu Yanjun
> > 
> Well. Interesting. Having pulled latest rdma-core again and fixed the wr.mw
> size issue I now see a bunch of CQ and QP errors which have nothing to do
> with the memory windows patches. It looks more like a memory ordering
> problem around the queues. Is this possibly related to the recent relaxed
> ordering changes?? 

They haven't been merged and wouldn't effect a SW driver like rxe

> The one py test failure I have chased down is in the resize cq
> test. The first time it runs after building a new module I can print
> out the new cqe and the current queue count and see the expected 1
> which is less than 6 but the code takes the wrong branch and does
> not report an error. Rerunning the test I get the expected behavior
> and the test passes. This will take a bit of effort.

Bisect the kernel?

Jason
