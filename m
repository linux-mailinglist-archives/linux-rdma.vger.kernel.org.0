Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0BC2BBAC4
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Nov 2020 01:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgKUASM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Nov 2020 19:18:12 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:17871 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728291AbgKUASL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Nov 2020 19:18:11 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb85cce0000>; Fri, 20 Nov 2020 16:18:22 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 21 Nov
 2020 00:18:05 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.50) by
 HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Sat, 21 Nov 2020 00:18:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeD9tHfz1cuc8DL6/YfOgirXnOadtDbmXVm0pkMZHwMv86pW3rrJMJnUeTCe+ZR2hrI0GmskUZlyUHZ5zMMyQIVry7kjPKLWM2WhtJFE/t8bOmRwIGOh4DvYqx+GqNkM4iiyDML40ijuYb+iC3gEe5N72UjT/kOhX/ozQvXSjbznazXtRQeLz/9I7JGLxOo9fnGnSZBA24rEcnLbi9u1Pkn/blqIUZvqprmDT1FYOAQXpkl1N9vg5KCFm558bUBBax7P+qGmBxTEmfozAmXmvgToytv6eptOE0AfI4HuQw7Fj+dCwMjgIJWWNcNcJ6jB485BD5tEOek0aojO5KvvBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVakWYJGLzPdEdh8p/IzWJ4N3L9Dz8UtttPzPeyAuyI=;
 b=O0AopfiiFmPZFohVmPmet6lfnaKTSCcmPi+9/IC1IdHlN3st2qPi34eyS1bNSJpmBuuJ273JMSYxKiVP0ToqN3vEuZEr3zShBnIRrCY1a1reSR7JfHKXPhujm3fYNK8NGN9UBfmNkSKZBWXwDUVWELoZM6Rrl746JA8ta2CWvrUMzQD+yPGJp91dlTSsbIyoJ5IbFvX32jHfon2hdW0QaCRXHduRdSNbKrTwEaa3Y1FjgV2KclqFC5p2MhLWhzFit/Kcl0iIaFWBqt6t7teW75OaxOm7phNP7elYEWe/DblRgQqAJIInSCJbfieBnYUIj78DcziVUZgGKPh76pM0bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4483.namprd12.prod.outlook.com (2603:10b6:5:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.25; Sat, 21 Nov
 2020 00:18:03 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9%7]) with mapi id 15.20.3589.022; Sat, 21 Nov 2020
 00:18:03 +0000
Date:   Fri, 20 Nov 2020 20:18:02 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>
CC:     zhudi <zhudi21@huawei.com>,
        "Latif, Faisal" <faisal.latif@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "rose.chen@huawei.com" <rose.chen@huawei.com>
Subject: Re: [PATCH] RDMA/i40iw: Fix a mmap handler exploitation
Message-ID: <20201121001802.GL917484@nvidia.com>
References: <20201119093523.7588-1-zhudi21@huawei.com>
 <20201119172712.GA1973356@nvidia.com>
 <9edd382c89c64c988b8833f22fe027ba@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <9edd382c89c64c988b8833f22fe027ba@intel.com>
X-ClientProxiedBy: MN2PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:208:23a::14) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR03CA0009.namprd03.prod.outlook.com (2603:10b6:208:23a::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Sat, 21 Nov 2020 00:18:03 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kgGbK-0092nQ-9U; Fri, 20 Nov 2020 20:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605917902; bh=eeQNXooyNB5feKF6kBclY4C83tbT2eTO0zdNPk39YEc=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=K8RH6vvwiIu0uX8AbERT8bZB1z+065q95NzFs2lQhaMtxvjLKaQcZo39s5Rgwb8ub
         wa4J7GCSwNpjsRshZ5UMThtlIaZ9K9/Q2Be3Ne19W7Ea3WlFqKttO4WTbABN61R8fv
         J/WmMR7lvewyAFQ+gT4XJj2Jtpj86UlVT2mbB+QqK5ozVGOyB0jdbO20K89R4G+uNy
         KNjbQt5Rvw+ntrMpYB3rDQkMF5aFKoggM4SiqF5JsElf7UvXkt5dh1QqFlZaBxU5Dh
         oFNII+499GBysABXjmZcTo1WnGC/iXHoJJLTAeEtBUGV0KNQzy8dABc6RRj2VzT5AL
         9Hc75T/Hx6NwQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 20, 2020 at 11:56:36PM +0000, Saleem, Shiraz wrote:

> Well, the push feature is disabled by default and today there will
> be no push page mmap from user-space since uresp.push_idx is an
> invalid one. Its disabled for good reason as its not working as
> expected. There is an option to turn it on via module param but that
> does not work as expected still resulting in an invalid
> uresp.push_idx passed to user-space and no mmap.
>=20
> So isn=E2=80=99t it better to just remove the push related code in the
> driver? which should also remove the manipulation on the vm_pgoff I
> believe.

Yes, delete all the push code, module param, etc. Set the invalid
push_idx, verify vm_pgoff =3D=3D 0 and hardwire the pfn to be a single BAR
page.

Can you send a patch soon?

> I will review the mmap API and see how we can use it for DB mmap.

This would be something to use if you ever make it work again

Jason
