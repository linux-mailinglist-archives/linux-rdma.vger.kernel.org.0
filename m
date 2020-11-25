Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B782C353A
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Nov 2020 01:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgKYAHm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Nov 2020 19:07:42 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:12514 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbgKYAHm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 24 Nov 2020 19:07:42 -0500
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fbda04d0000>; Wed, 25 Nov 2020 08:07:41 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 25 Nov
 2020 00:07:30 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 25 Nov 2020 00:07:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8NL82clqwU04R9waT+08G63mlkFvFJW5lrdNpDbzFymV4EiiUvkLjTUdO5RtW9PxPaHweUgy0lgsyY58zWyVWfLKq22G1TVh7kLMWAojZEExFHS7p9IiO7rxs84TSZuizM5FomGWHu/r8+YQRxQbXbf36RZNO2wZZGpLsnD3PsCz4w/YJczHhHDk4ikrpDqxSyl9U25xC/QmPvIpGKLTss0yHbbSQg7NkPCCY56XiC8wty3gcQKVSUpCoOoXoQh1nauJLIkYEUOTXE5BrGZ4CixYriWnUSX16iYpPNwV8nh7Sg8QViGZMcxCoWxTB/5vSkcaTFam0bX7CL5m1krrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/U7WD/vzDUTRLY0TuN9s5JI791Aa+KHiJZaN+7M6dUU=;
 b=Qgzj3pWiwTHjUOzAeU/DSSoRT9QKYk+I4OBpzQLHuWa+4Ks2fnoirBwSyOQlNrbB7d/bWKHAXsyva/58iieq4xfCsAzfapRgdyrusI1FNtfqbHU71PhC2R1Tf26S/Z270Gg8MUmCLyDEZT98P9nECNHhEgPr51yzBxZ/Phih04SxMcAyiR/azBUKlsDpfj5GA9gRhHXVAYU8ulWHg9c/QoSZXDVmycvipNTlKjU/Omx062KmDvf20niwy+ZvJVPJaRkegHxLnq7MqHitB3nbEFoz7zsvuqSiMKJJWL9hfH+w5vUms6npq2mnXwRziNj3C1dj4JQmY6neV43J+mGUFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4338.namprd12.prod.outlook.com (2603:10b6:5:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Wed, 25 Nov
 2020 00:07:28 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9%7]) with mapi id 15.20.3589.022; Wed, 25 Nov 2020
 00:07:28 +0000
Date:   Tue, 24 Nov 2020 20:07:26 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Shiraz Saleem <shiraz.saleem@intel.com>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <stable@kernel.org>, Di Zhu <zhudi21@huawei.com>
Subject: Re: [PATCH v1 1/2] RDMA/i40iw: Address an mmap handler exploit in
 i40iw
Message-ID: <20201125000726.GG4800@nvidia.com>
References: <20201124235102.1745-1-shiraz.saleem@intel.com>
 <20201124235102.1745-2-shiraz.saleem@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201124235102.1745-2-shiraz.saleem@intel.com>
X-ClientProxiedBy: MN2PR05CA0053.namprd05.prod.outlook.com
 (2603:10b6:208:236::22) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR05CA0053.namprd05.prod.outlook.com (2603:10b6:208:236::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.11 via Frontend Transport; Wed, 25 Nov 2020 00:07:28 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1khiLG-00121w-QA; Tue, 24 Nov 2020 20:07:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606262861; bh=3KvC0HxyPKSqD1qnkGn2hF7YW/abOqdIVajQoVP0ui4=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=mN/afRqtZc1Mg2zzIhkQ98CJ90aLjswnVRSpW8zR9lkV/vaK2/I4VWVleP1I2Jw+D
         ZhFP1Dqq5bmHk9QzUprYYpl+FfSianVMQne+KgZfPUnorCnd9rH0MJk0tEeMbhH1fu
         Ydbp/MX/7QycRrzDW/6aM7p6XDPkoCT/cZ2aavA+933D113QLBseIf0wIc95wQVTtY
         +EAQngkfjNeeCtQur4jiOU/mwAbC/MtX7kS9lXobCaBx4O2JrOfI/w/IPgBtFYO4xp
         ANvZdS4RoT5iC3cy8w3HHDKbYggJok87+qSxCIRMDJqICTT85r7qMGblyyX/ScqDGt
         kq5bqkntnX8oQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 24, 2020 at 05:51:02PM -0600, Shiraz Saleem wrote:
> i40iw_mmap manipulates the vma->vm_pgoff to differentiate a push page
> mmap vs a doorbell mmap, and uses it to compute the pfn in remap_pfn_rang=
e
> without any validation. This is vulnerable to an mmap exploit as
> described in [1].
>=20
> Push feature is disabled in the driver currently and therefore no push
> mmaps are issued from user-space. The feature does not work as expected
> in the x722 product.
>=20
> Remove the push module parameter and all VMA attribute manipulations
> for this feature in i40iw_mmap. Update i40iw_mmap to only allow DB
> user mmapings at offset =3D 0. Check vm_pgoff for zero and if the mmaps
> are bound to a single page.
>=20
> [1] https://lore.kernel.org/linux-rdma/20201119093523.7588-1-zhudi21@huaw=
ei.com/raw
>=20
> Fixes: d37498417947 ("i40iw: add files for iwarp interface")
> Cc: stable@kernel.org
> Reported-by: Di Zhu <zhudi21@huawei.com>
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
>  drivers/infiniband/hw/i40iw/i40iw_main.c  |    4 ---
>  drivers/infiniband/hw/i40iw/i40iw_verbs.c |   37 +++++------------------=
-----
>  2 files changed, 7 insertions(+), 34 deletions(-)

Please compile your patches:

drivers/infiniband/hw/i40iw/i40iw_main.c: In function =E2=80=98i40iw_setup_=
init_state=E2=80=99:
drivers/infiniband/hw/i40iw/i40iw_main.c:1579:21: error: =E2=80=98push_mode=
=E2=80=99 undeclared (first use in this function); did you mean =E2=80=98us=
er_mode=E2=80=99?
 1579 |  iwdev->push_mode =3D push_mode;
      |                     ^~~~~~~~~
      |                     user_mode
drivers/infiniband/hw/i40iw/i40iw_main.c:1579:21: note: each undeclared ide=
ntifier is reported only once for each function it appears in

Jason
