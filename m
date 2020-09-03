Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B34425C0F0
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Sep 2020 14:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbgICMZa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Sep 2020 08:25:30 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:5441 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728817AbgICMYQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Sep 2020 08:24:16 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f50dfe30001>; Thu, 03 Sep 2020 05:21:55 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 03 Sep 2020 05:24:04 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 03 Sep 2020 05:24:04 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Sep
 2020 12:24:03 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 3 Sep 2020 12:24:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYyr1jEhYGkrPpwph834d80NcB2soMTRH0/Cr1Xn68WTgYv1gngP851EW80YgqJRUV72gpIH+PJYCvTgx0zUFppFnlND5oHYpRbizroYlCVRY5aUvUSfuLbpYc4z7amGbGf5dxdd+wCNn1HnMao2zVYX1dx5AqEvU1/W/RSXmnJlE6+cNRRcq8Cs0qGxCbeiUAz+4fDl75sHOPq3353emKSoeZBwKf/HZ/wuBHzNWK5IUQtI/aRCmLUstPFLklMSPrBCyfDc+KSorOdnj0DJVEHqfhhiCEhWnwZCQK/HKK4XSiPQVqdYgeZVEwcGZqt6N70eWuzWyQWpyvbwhTTfpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5cQ/hNj5gShE69g4OuU3lRZIXGATs2ajhLD09wyG10=;
 b=hFR9QQm6bmW/tUtuvWv6N8Uah35fKUxBtRs9UEUihqVUGhOyfYmz4b3B6I5Bu9lRDHjc15JkHqV9yWVrag4zpLbrKZwGy8OISrNzKfBc66uqczufIAmf6n8TU/KP8gVJEE8DnQjVQmWbEJfbUPnVZUBVu7DjvXv1Flkr+vUoFVrwRt3rYpdE79IAfIyFVJ7jNtvWd4C/jF7w1xy2BzJ1y4hkg8Z6b4xFdd/hdUypAh7wV/1wrNE+7K7F+4AdIMgjiHWzAIqom512RLeHbMNLKI0wypWvo6jNu1IfjBPmWMhRf4OBr3tv0cXiJAPYIStLVojQ/rbmRFJMheXv7iOb9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2485.namprd12.prod.outlook.com (2603:10b6:4:bb::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 3 Sep
 2020 12:24:02 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Thu, 3 Sep 2020
 12:24:02 +0000
Date:   Thu, 3 Sep 2020 09:24:00 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next v1 06/10] RDMA/core: Delete function
 indirection for alloc/free kernel CQ
Message-ID: <20200903122400.GB1152540@nvidia.com>
References: <20200830084010.102381-1-leon@kernel.org>
 <20200830084010.102381-7-leon@kernel.org>
 <20200903002048.GA1480415@nvidia.com> <20200903053517.GR59010@unreal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200903053517.GR59010@unreal>
X-ClientProxiedBy: MN2PR20CA0041.namprd20.prod.outlook.com
 (2603:10b6:208:235::10) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR20CA0041.namprd20.prod.outlook.com (2603:10b6:208:235::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Thu, 3 Sep 2020 12:24:01 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kDoHY-006RgT-9u; Thu, 03 Sep 2020 09:24:00 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9aed5065-a527-4aa2-2e0c-08d850043dc6
X-MS-TrafficTypeDiagnostic: DM5PR12MB2485:
X-Microsoft-Antispam-PRVS: <DM5PR12MB248574938FA15B79E2D73754C22C0@DM5PR12MB2485.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pyhLRE3PkiPMB5Oy9Mt2JVx02y/eTzrQT2Oe6dVEvedkSEc9x3LntrxzBa40+Vl2OxTOPkQZ6HN6DySr1jv5UR9r/5OTgB2uDS76Q2zg3Tfp7h0fNYOkkzrD/4AtprZWhFB/hfXHug3heA0+IWQlA2/EqvqeZ+3Z3MhLUMvIC7yYgS25vGAhYQM0wokfBc7wdcGSQ+Lgxd2oE52OdrTYwRxcpANm19SkP06Dm0hu5H6oL6UAf5PSjlaQcoWSyLZI3FdkrSAwwzWHueNuEkvCpNh9aEbO/DchWPrSWI2ddP30VL2vj3tDTNvARsjOVcYP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(316002)(33656002)(9746002)(9786002)(2616005)(426003)(86362001)(6916009)(5660300002)(36756003)(8936002)(478600001)(66946007)(186003)(8676002)(2906002)(1076003)(66556008)(66476007)(26005)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: QY3D3DgKDQASrJZTWfMXfRqeVnekPgh4NgGWxaHfwVjDB/PY4xUjQgplhpq8gicU5mHImlOUFHwa6uCWooGyp4tkzyC/xIrREB49w5iCiv1av0rrECHFAAdxbfJNoPXvzcZpZ/Hy2FSPiDVL4W31qUjvGS0uTAHUtTeD9JrdMpoppBu70ougaHORPMeIH71ENYidYGL/77lkOTTxzPBT1q5fRdv3KxdvlPkFdkYTztPvVjl1Vc0NmiL5y9NsO3BNZuq6Z2wVfX3sDKH6SC1227X7CGEb2qBr6TmoQRzz7Oi4ulEsF1kMazd4rWjVVPCLZtUHU3+F1l0fI2ahvBnmCH7iwTCprsYkj2D3tKS5uT8241hPwaYB6hRS15X5TcN8a30PAYCYJ0jOvU6Uj5vCzNo1FzGtP/OwrkxHUET08wY39ZUwz7yaWDjwIt3oRfyxQb5+ktaIbjimas4yGyBCe73F9BTRGRaq3KN5u1AuC0mn5YL1BPNuPiGA1QLNmoQ+eHX0sAji9u2Tl/tm241FddBtNqlVRo4gmhCh5Mue45XPAkzOBrpsnMERQOrzG6RnXykkN0ZJmVPhI1xF7L/dgBOLsoLPySTRK/Lo85JqWBbXvBbvD9c2fpE5MPcukQrnXSVk8CpIgHJSZWWJfEhMWQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aed5065-a527-4aa2-2e0c-08d850043dc6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 12:24:02.2053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YZ2FMnqm/+UJNLCT9L1XU6QWVdz+vl/1vRlqRO0qDbFHuWikvk8GcjNJNRlVE1GL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2485
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599135715; bh=B5cQ/hNj5gShE69g4OuU3lRZIXGATs2ajhLD09wyG10=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
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
        b=SQR9mU6yx2l2vANjDhFP0fboFv53+LEO13mS+7v/2xFR1OndJTlVkcUAiz9epH/Qp
         EN+hNFiEsc+gaLZH18/5RKWzybSt1mStLyinNvFuLaEUMN1jYVcWGaT5FvPWVZxl1D
         4WVTItA79PIUTP8zxm8nt8C4qlpmibOAw6R2DaHsHHw9J1qVTmf6jyuehmPvrwqUgp
         mRcCZbBnxu2sMKulcBqyr/GqR3YKTWAJU/R+JV2XNeGTMgv2rAD8pscH1SSY4X6Fei
         xVP77MvMTbcpa2LMbn+61K0TmF2QJniRMg9l2Px88fo+mgU5kw1Wd+JcXneFmueoLj
         WG4tlRxfYHUtA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 03, 2020 at 08:35:17AM +0300, Leon Romanovsky wrote:
> On Wed, Sep 02, 2020 at 09:20:48PM -0300, Jason Gunthorpe wrote:
> > On Sun, Aug 30, 2020 at 11:40:06AM +0300, Leon Romanovsky wrote:
> > >  /**
> > > - * ib_free_cq_user - free a completion queue
> > > + * ib_free_cq - free a completion queue
> > >   * @cq:		completion queue to free.
> > > - * @udata:	User data or NULL for kernel object
> > >   */
> > > -void ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
> > > +void ib_free_cq(struct ib_cq *cq)
> > >  {
> > > -	if (WARN_ON_ONCE(atomic_read(&cq->usecnt)))
> > > -		return;
> > > -	if (WARN_ON_ONCE(cq->cqe_used))
> > > -		return;
> > > +	WARN_ON_ONCE(atomic_read(&cq->usecnt));
> >
> > In this case we expect ops.destroy_cq to fail, so no sense in
> > continuing, leak everything, the ULP is buggy.
> 
> I disagree, we should clean as much as possible and leave the HW object.

There is no reason, this just creates possible data corruption.

Once these WARN_ONs are hit, the system is leaking memory. It doesn't
really matter how much is leaked, and there is no reason to try to
minimize the leaking.

Jason
