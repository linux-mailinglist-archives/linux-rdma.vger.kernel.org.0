Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE6728E8E6
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Oct 2020 00:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbgJNWvb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Oct 2020 18:51:31 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:2809 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728250AbgJNWvb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 14 Oct 2020 18:51:31 -0400
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f8780f10000>; Thu, 15 Oct 2020 06:51:29 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 14 Oct
 2020 22:51:28 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 14 Oct 2020 22:51:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVG2ab2FQ2SjqWijDOygTlZdasvsSC30Y/ggNP/j5OQElLRP3PLOPe16AtJAy3a86d9Ex96zNKTHTF5WCIWKl3aH1aCRwVci1J1jIfP/RG62ePr6lpeqT2wa1/Aj6r7W1WF+2eODXxDlW+ezeCGv58xp8I0Cey+mtZ4wa/7rpUboSDVAM+h+h8sgsgqo3l5l0jEk6L5N795R5t/eoVkdrE0aetNEt5MuoKvfsO4A6udlxZ6HCKq69nrbsh5coKYJv4I+zq0+KRF62PgEGnuzZaAr6Yo00j2sg4PdNZB49EXnsYXecMvvtXP5h3PpJzez+vWWUDqXKM+kQiTHczCKIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QozgLSbLg2T03V2She+aAryUiB0cUMnvhA5uWoyx1u4=;
 b=GDX2XVdCoKcZ6oJA7AFJ58RjoOTduj31F1JxCJvb978zufLQ0vrTcykfAV08BVFle8eEEaDsXggWTd5mQnBJzt3bMuSKERA+eAzgRreoMetZUYCpmTlq6tY4OwOoIJ/xcpx7GanOuEj1uJHzdSlg7rskZ+pB43OEoq6nhtsR2WCOD/7J7fnYdP7Pf5SXwONbBSZXzdOXuQbXdnidHhjjOy09Mio1eobSBKOV1ZNz+3TRO64KWMyYUu19yhnTq8vKi1QtS7HDmQ3md0whg4377y5aCv/M5M79FojPqSVc8GJHGOpWMvQCEKbAqSYG09NPmjlr6XLzP/iVdneS6y0/ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4483.namprd12.prod.outlook.com (2603:10b6:5:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Wed, 14 Oct
 2020 22:51:26 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.020; Wed, 14 Oct 2020
 22:51:26 +0000
Date:   Wed, 14 Oct 2020 19:51:25 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Maor Gottlieb <maorg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>
Subject: Re: dynamic-sg patch has broken rdma_rxe
Message-ID: <20201014225125.GC5316@nvidia.com>
References: <0fdfc60e-ea93-8cf2-b23a-ce5d07d5fe33@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0fdfc60e-ea93-8cf2-b23a-ce5d07d5fe33@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR01CA0009.prod.exchangelabs.com (2603:10b6:208:10c::22)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.177.128.188) by MN2PR01CA0009.prod.exchangelabs.com (2603:10b6:208:10c::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20 via Frontend Transport; Wed, 14 Oct 2020 22:51:26 +0000
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)    (envelope-from <jgg@nvidia.com>)        id 1kSpcD-0001ew-Ci; Wed, 14 Oct 2020 19:51:25 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602715889; bh=QozgLSbLg2T03V2She+aAryUiB0cUMnvhA5uWoyx1u4=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:User-Agent:X-ClientProxiedBy:
         MIME-Version:X-MS-Exchange-MessageSentRepresentingType;
        b=Q3+D8eMEuwlAupdZQXG4kg+DoK20VF5JnL2ShN8/mi0ONcH8GZOfZKgwmaC+eO+xW
         nGKSURl3SmcosXDiTbvBL9CpjBdCJTfHHAOoP/h9dkDprB4xEMJ0orl9DEbU/78SDW
         vuY4WcjzyaBHA5FzK7tnR2UfWHDQTc+MH1QGt8RETHn0xxVefuUuIS2tox9q14B12H
         XslKautH2AymYzqQNqw2lSzyfLGoU2Uv/mqlU1YDk9z/nlPaTyJ/4BxLi2+H8BZ4oU
         PUNxFBi8KRD6GCHBHf18yQF71dE18LUiyU4nxctK3O6GBFfow8+AE0jHezDbS9VdAQ
         TAtlzHydS8vtQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 13, 2020 at 09:33:14AM -0500, Bob Pearson wrote:
> Jason,
> 
> Just pulled for-next and now hit the following warning.
> Register user space memory is not longer working.
> I am trying to debug this but if you have any idea where to look let me know.

The offset_in_page is wrong, but it is protecting some other logic..

Maor? Leon? Can you sort it out tomorrow?

Jason
