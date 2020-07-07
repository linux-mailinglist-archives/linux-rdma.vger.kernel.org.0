Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF1F9216B57
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2020 13:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgGGLVZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jul 2020 07:21:25 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:3963 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbgGGLVZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jul 2020 07:21:25 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f045aa70000>; Tue, 07 Jul 2020 04:21:11 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 07 Jul 2020 04:21:23 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 07 Jul 2020 04:21:23 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 Jul
 2020 11:21:12 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 7 Jul 2020 11:21:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jh7cCF49sveKCf5Pl5h4OXzZ58FPasxaCF7zTYcGWkggQnNV7Rg5pmKPJCw+4aZjT4GieoBJUWjZG0QX3dkB1itZdR8Ahh4b0N6GYxAbEBbTi3QZDZTD7Pp2Vmoo062XFVrI1Rx7gs0QvguoIzO3yiE4aeXdehplzWHJ814H6w7P7PN40enl87N8zAisUq82Si5ZyYVL7cKHHGYhgdt2d1x3uQCblKyRmzpSzp94/pxspv0iWr1QnpgpYoeGq9dHKrKLKxbWjA5FWxF2OCYU019hxEXaYBohl1QTTIJKX3CiLDho+IO/COfssRNVF9mZMB/QPcAwTKFrE9UvNRrUig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIWzUH8KwE3/iJzmRJp+YnwWoE96Q5BxaPScscz1+3I=;
 b=WOTd8NPqdrYfznR36NYKLmSiMqaK7aFEX0VlSbsT9YXcIPKJohOtCPMkE1wiYLrlWfEXYh//GTmgCYzFhGCIGiiGF141UJ16XkZVArji6g0zDvwKaY11P3o3msLsiGYnI5lQOyKfQaAQGHduuY9SuvXoPQU3efOe4kocHA4eqDJ5RJcmmo+AchA+Kxl/3QYSAAXTsGyf9+bBFksUZ0026pZF1u6MvUCr16g3a+J2Iu/NO9Gw3h6Im1K3trYlDpgwwsXKET7Fu93PcQR53/5EKRaCapnajpIFZIwilA0C31GpFoEqWPMqc7qDWS6hEmZSgGy1d/6u+PaZ+mOfgb3f0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Tue, 7 Jul
 2020 11:21:10 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 11:21:10 +0000
Date:   Tue, 7 Jul 2020 08:21:09 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>, Lijun Ou <oulijun@huawei.com>,
        <linux-rdma@vger.kernel.org>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-next v1 2/4] RDMA: Clean MW allocation and free flows
Message-ID: <20200707112109.GL23676@nvidia.com>
References: <20200630101855.368895-1-leon@kernel.org>
 <20200630101855.368895-3-leon@kernel.org>
 <20200706230416.GA1283287@nvidia.com> <20200707044203.GI207186@unreal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200707044203.GI207186@unreal>
X-ClientProxiedBy: YT1PR01CA0101.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::10) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0101.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23 via Frontend Transport; Tue, 7 Jul 2020 11:21:10 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jslev-005dre-0Y; Tue, 07 Jul 2020 08:21:09 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7064ea09-b160-440f-9e65-08d82267d9d2
X-MS-TrafficTypeDiagnostic: DM6PR12MB2939:
X-Microsoft-Antispam-PRVS: <DM6PR12MB29397C405FE7524DEC84AC90C2660@DM6PR12MB2939.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0457F11EAF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 42EiXK9FksCB+HdvKmZPniMcrSW2djDoDFSqcAcoasvJs1+IRywLuHk/LYPPsQPTkCR4zX+oTgH0ODnkgWqt+TEdxxQFiMCshXq03icuVreOOdBW2HiBkUZ3kuxlxTca/YjTWpZLTyofzfn1zksdV8mYV6Tigpi+bMTDoph1SO2432+NjZAs3oO/rzAfvDCwpv+qB7TaCujIh2KJSt9ZozfN0KxvOe4bIMHYxGwt7eiWqooJduyvDyqlUl4Vk2HDz1eEQNQ4T5LXwPrEUlEdU7/YogK6xy/dRbP8sTGm7BHdrwC30Ji7xCfB0KsJiAliyH1ixu97Td2k5tUILksLHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(86362001)(8936002)(4326008)(9786002)(9746002)(1076003)(26005)(66946007)(66556008)(66476007)(5660300002)(426003)(186003)(2906002)(36756003)(316002)(33656002)(6916009)(2616005)(54906003)(8676002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: gZCawehYFvd/XSxab7kZgq1YWuzF8S082022s2K0B37OSqebDDrfN4i6xnA7qpesGmEaCMWHH12MRvKb6gg6ImTKB8tnHaAJ1xgw4HvepY/vN/DfV43EemwoaVtR60RZPzACion5K0QVHICKr8k4QlXd2G+QBPwvA/rsWPdkuIOGKRwbpF/451AdJjgbxnEwkpoPnqcqmQOEmJulxv5P28IMNMF6lEZC1MMUuNH55D+9vsf+24Ce3KCyB3roVREsjWXPhACd3PTzZKn5JM6xkUBTf2E6QXs+wR075Cvdhrpv0QyEEtaGEw1YroO3i78PPGWY4ShnuWi0pnfUkwf/vpopi1TZG/MLi1gb37azFcfqFd2dUT8TfAyIvkt0DgjUu8OCRc10xh93w+1kcQUiDtfJg6REF1P4jxc36jhLauEV5SZYpOBSfg394NFHXC+O6+9YpZnJb1YPyvMXaV6J9BdyasqpaatU6ax/YJEVAtoijDKpAX2tdPtTl/nJKxbH
X-MS-Exchange-CrossTenant-Network-Message-Id: 7064ea09-b160-440f-9e65-08d82267d9d2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2020 11:21:10.7388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ckeD8WCczgoTnvpLdWpHYeZXFuzUGSD14XUz1U54rL6n6A94/VP3yfxNYqKP+Ntb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2939
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594120871; bh=DIWzUH8KwE3/iJzmRJp+YnwWoE96Q5BxaPScscz1+3I=;
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
        b=dCy7LdJc6BnEnwfZaUHqsmbjpVG6oZfLEfoqbDmiqk4mgCuEGu6WZDKZBvqpQM0jc
         bovBABRV5Ly3KsSWGCzuPyzRQ+XUoHK1zypUuMzYX/dID+04zXxiAihc7tygihfbwj
         1N/CWpr03t7i2GtoKuT54epTySl0lcUUTcEAa16bBzwa5i/LNO7drnkaSgaLT5ZXD2
         z+xZVxojZ5dkF7LI50YW/s/NGu7bVL4vERB3GLJrU7utEpJuZXAqz3WrdDqbXJVaLk
         zYqQDUaBbiB50VYKD4Ntua8IX+/BNYh32SXKRXJjx5WCDSD+YldqFSJVUsuyM7YZvd
         QdJ7ek5kOWm6w==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 07, 2020 at 07:42:03AM +0300, Leon Romanovsky wrote:
> On Mon, Jul 06, 2020 at 08:04:16PM -0300, Jason Gunthorpe wrote:
> > On Tue, Jun 30, 2020 at 01:18:53PM +0300, Leon Romanovsky wrote:
> > > @@ -916,21 +916,24 @@ static int ib_uverbs_alloc_mw(struct uverbs_attr_bundle *attrs)
> > >  		goto err_put;
> > >  	}
> > >
> > > -	mw = pd->device->ops.alloc_mw(pd, cmd.mw_type, &attrs->driver_udata);
> > > -	if (IS_ERR(mw)) {
> > > -		ret = PTR_ERR(mw);
> > > +	mw = rdma_zalloc_drv_obj(ib_dev, ib_mw);
> > > +	if (!mw) {
> > > +		ret = -ENOMEM;
> > >  		goto err_put;
> > >  	}
> > >
> > > -	mw->device  = pd->device;
> > > -	mw->pd      = pd;
> > > +	mw->device = ib_dev;
> > > +	mw->pd = pd;
> > >  	mw->uobject = uobj;
> > > -	atomic_inc(&pd->usecnt);
> > > -
> > >  	uobj->object = mw;
> > > +	mw->type = cmd.mw_type;
> > >
> > > -	memset(&resp, 0, sizeof(resp));
> > > -	resp.rkey      = mw->rkey;
> > > +	ret = pd->device->ops.alloc_mw(mw, &mw->rkey, &attrs->driver_udata);
> >
> > Why the strange &mw->rkey ? Can't the drivers just do mw->rkey = foo ?
> 
> We can, if we want to allow drivers set fields in ib_* structures that
> there passed as part of alloc_* flows.

This is better than passing weird loose pointers around

Jason
