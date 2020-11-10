Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DACBA2ADD4F
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Nov 2020 18:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731011AbgKJRq0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Nov 2020 12:46:26 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:37627 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731105AbgKJRqZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Nov 2020 12:46:25 -0500
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5faad1ef0003>; Wed, 11 Nov 2020 01:46:23 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 10 Nov
 2020 17:46:19 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 10 Nov 2020 17:46:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTw+Tnl1Msjj5fV/IYYrQcXlwfdsIOx6qdvwLuPolbPi7KQqwHmowS6eH/6BkQWbPQTCDqb022XqXk9Ub8lNfM/G59ebn/T0kKt5nbz1Yeis43lmgVWcw98QD0qts+KgjMqxA0M/r6ANG6e36aLgUxeGu1L6EW8fX38LbtrI+0lmEPVj+BRqoiYqG50pvka2MzVoGmu0PoQsyw9b6JMVVUBpdRtRBc1x988XHS9ZNd7d42Fkwf8hR32en7WIfWq4+MjMLqzGfB20C8ITHfP0HdrU0HyUab92QriUzuk6vrKlxnljIvz7bOI1D2w6UZP0WVrf01+eh9UToNmY8Q47mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwWZEOIgNKt0XIPV+xeQqgihHGWHJKpimg4FnI0NoG8=;
 b=Zo4GQVtklNJ6RkBKN5bdS9/zgsnk6eV9ycgDfKZCyOS/cs3W8Hq8OufmJu6L2/Za15jvp03TY6NNF8rMkyLYzj3Hi+WF+q+jyCD8rURwFursbQP7/UdABPXnreKqjoh0WoDB7I5ZQQM2oCVo3TnzEHY2xsjn54lMGzjNfchJGRSnKLYI+sR4stQolg2Qzjvbt/TgiX0F2GF/mJH7lsf4nGWd5dLVC9U6HjwiuArcRzK3tKId6vDG6zfovmclEqtwLgcScCYMh6cdlB1FxOZPBxtZu1I6Fn0ftXA2lRRfhv9/8zBC9Zj/lwbsgjIacO+0DCE6HM68m9WoivxpeOo0zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2859.namprd12.prod.outlook.com (2603:10b6:5:15d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.22; Tue, 10 Nov
 2020 17:46:17 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.032; Tue, 10 Nov 2020
 17:46:17 +0000
Date:   Tue, 10 Nov 2020 13:46:15 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     liweihang <liweihang@huawei.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH for-next] RDMA/hns: Create QP/CQ with selected QPN/CQN
 for bank load balance
Message-ID: <20201110174615.GQ2620339@nvidia.com>
References: <1599642563-10264-1-git-send-email-liweihang@huawei.com>
 <20200918142525.GA306144@nvidia.com>
 <115588ae632747f29e977f6abf0a5733@huawei.com>
 <20201106133707.GV2620339@nvidia.com>
 <c33b1adfea354db5b7332e8d23bd8880@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c33b1adfea354db5b7332e8d23bd8880@huawei.com>
X-ClientProxiedBy: BL0PR02CA0139.namprd02.prod.outlook.com
 (2603:10b6:208:35::44) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR02CA0139.namprd02.prod.outlook.com (2603:10b6:208:35::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Tue, 10 Nov 2020 17:46:16 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kcXih-002kae-Gd; Tue, 10 Nov 2020 13:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605030383; bh=UF2oO138csKHerWpEXr12LmLnEgP54VSLQXiEQGb+oA=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=EwYZjtv898Fc9tu6fcHWzkDusDIG20GJw9nf3okbCMTy1uo2jO64/Qf9GsEk2f6c8
         9V7DKw8tHDgv17EjOj9EGM1kKbcGBBU47vEeVIE6f586W7iVPzNx939ZmQ9lkXRl6n
         JjEmOpr+gPzk7PL1pMPKyoISbvil+KfvL1pIbFNYIC7TraClctiM1IYqJ5riXzAfM4
         HvwzSDud8XRrlavoKq1olSa9LEC6fNPlEwmVh8OOmGKIfOIXJMuFwwn9jYpWhkX3La
         B5fSfiK2Qq58wiTpRkOpfDJ8KRy/nDmDjyxuKIGzLR8Z7Dq7aFznWOIkxKdhX1/gvm
         j3/1+b3cxP7cA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 10, 2020 at 09:19:39AM +0000, liweihang wrote:
> On 2020/11/6 21:37, Jason Gunthorpe wrote:
> > On Fri, Nov 06, 2020 at 01:52:57AM +0000, liweihang wrote:
> >=20
> >> There are 8 banks and each of them has a counter which represents
> >> how many QPs are using this bank. We first find the bank with the
> >> smallest count, and then try to find a QPN belongs to this bank
> >> according to the bitmap.  The ida will find an unused ID starting
> >> from 0, I think it can't meet our needs. If we use ida here, the
> >> code may looks like:
> >=20
> > I don't understand, why wouldn't the ida give you a free QPN in a bank
> > directly?
> >=20
> > Jason
> >=20
>=20
> Hi Jason,
>=20
> Here is the QPN that belongs to each bank:
>=20
> QPN on bank0=EF=BC=9A0, 8, 16, 24 ... <lower three bits is 0>
> QPN on bank1: 1, 9, 17, 25 ... <lower three bits is 1>
> QPN on bank2: 2, 10, 18, 26 ... <lower three bits is 2>
> ...
> QPN on bank6: 6, 14, 22, 30 ... <lower three bits is 6>
> QPN on bank7: 7, 15, 23, 31 ... <lower three bits is 7>
>=20
> If bank 6 is the one with the lowest load, then we need to find a
> valid QPN belongs to bank6, that means, the lower 3 bits of QPN is
> 6 and it hasn't been used.
> We can't find out a way to use ida in this situation because the
> QPNs of each bank are discontinuous.

Each bank has an IDA, you allocate from the IDA then shift left and or
in the bank number

Jason
