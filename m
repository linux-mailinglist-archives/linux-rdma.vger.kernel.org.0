Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0DA2A11D3
	for <lists+linux-rdma@lfdr.de>; Sat, 31 Oct 2020 01:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgJaAES (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Oct 2020 20:04:18 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:1509 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbgJaAES (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 30 Oct 2020 20:04:18 -0400
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9caa010000>; Sat, 31 Oct 2020 08:04:17 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 31 Oct
 2020 00:04:11 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Sat, 31 Oct 2020 00:04:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C9kAtUJ0Gl8sGqXwakO7h/Pbp5JTgQ0hoyMzvkYUFDuMu5DL3f7M6WwmjEuI3uV6Fxk/YaazXeGj7N9wofxk0FVvPFUWkgVEg22QcKLVHZNfYipk1OnacI9yfkEylGhiVpZsvIhdxhfuGEs2LXwAD8G3ClaxbHJTK8G12xZIvB1mHpR56FwDuVzWUu2e8GhwAtPXumPXhE/Yjx1KvScobJIuB0cejrbGhwac41IjWaGADu2KzIm0e8p7GA6fe755J7djOV6HC6Gm8omLwVo3MjtEJ60lQoHE5lDFWk3qayfBTAEx4gbiv3uTZnl7A22qu2GC25jojXxFh9f4jc0GRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XMPWbwPLNEnfUxGyNvA/v8K54PCBG4T5JgXBMem8nI=;
 b=VThwbI63YvVXBECU9LocHMBcFX7tvJjpa7my7ZC252cXR8uIPN1R6V1zGpk1bG5pgEJ+isHMsjVxtMl2H6CdFSn4AldfmWjDW8ISM4V0a7gxFAzdUkmKO/Jn8tyLeHuU66D5BkuP7glHWi/pSLnL/eB0nhBjdLDLRp8mAX+GutInYI2reW7Hy+lKNp9oC4qe7gkrYM2D1uFWuWxjQE+3NJJH+KMoCfNtW09hvUsti6SMJqQk4XFtUuETuppgJORL89AvrIdbYbD5Bi2x6KKiWwZSIeciqy6PFJ7xLcBDFOn5N0zAffV/dhqmgvT+UhNRU4/duPmSLPGXArvvVp42HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB2488.namprd12.prod.outlook.com (2603:10b6:3:e1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Sat, 31 Oct
 2020 00:04:08 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.027; Sat, 31 Oct 2020
 00:04:08 +0000
Date:   Fri, 30 Oct 2020 21:04:07 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Joe Perches <joe@perches.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
CC:     Doug Ledford <dledford@redhat.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        "Yishai Hadas" <yishaih@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "Christian Benvenuti" <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        "Parvi Kaustubhi" <pkaustub@cisco.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Bart Van Assche <bvanassche@acm.org>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH 3/4] RDMA: manual changes for sysfs_emit and neatening
Message-ID: <20201031000407.GS2620339@nvidia.com>
References: <cover.1602122879.git.joe@perches.com>
 <f5c9e4c9d8dafca1b7b70bd597ee7f8f219c31c8.1602122880.git.joe@perches.com>
 <20201028172530.GA2460290@nvidia.com>
 <4684eb7d2a872b23bd3258153370d4de1691bbe4.camel@perches.com>
 <d045c9c63b5ba9535314d9af823607d0659758c0.camel@perches.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d045c9c63b5ba9535314d9af823607d0659758c0.camel@perches.com>
X-ClientProxiedBy: BL1PR13CA0113.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::28) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL1PR13CA0113.namprd13.prod.outlook.com (2603:10b6:208:2b9::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.8 via Frontend Transport; Sat, 31 Oct 2020 00:04:08 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kYeNL-00E7rh-3l; Fri, 30 Oct 2020 21:04:07 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604102657; bh=EAZTo68fh1G+OLB8awJKbWg/zkcr3gGVZOk3pI7v4wA=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=nLykhwvrHsPBZHkEUhB7KBmSC67zpARZCDT7P6MvPJY88UIkr63fLu48ZYm7wrUie
         oL+aUQ62zPZIZE0Ay7nF2TzCeJOEFqXaefJDF8yjxDm6aIKNOns2Z2Y/5etN/f5jg2
         GZcSq67lEBTg08fFnjsHKe0auP5pJPqyfTgYUBUG0785YCliH1D+BWkVMeg+LY1JAj
         SRPmWJAFaYnV5l02NmQXMraMT5Np0cJtc5eqezgmHw9hYFOtkyuEa5gn/k7gduwubj
         lVXhNMJTETv0zX/Dc8FHZTQMM375iaBxa+mxV4rfSF6zMWHLjpWqZDRgiFLM5kkhra
         sDEMZZ/7eod7A==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 29, 2020 at 10:16:46AM -0700, Joe Perches wrote:
> On Wed, 2020-10-28 at 10:54 -0700, Joe Perches wrote:
> > On Wed, 2020-10-28 at 14:25 -0300, Jason Gunthorpe wrote:
> > > On Wed, Oct 07, 2020 at 07:36:26PM -0700, Joe Perches wrote:
> > >=20
> > > > @@ -653,10 +651,7 @@ static ssize_t serial_show(struct device *devi=
ce,
> > > > =C2=A0		rdma_device_to_drv_device(device, struct qib_ibdev, rdi.ibd=
ev);
> > > > =C2=A0	struct qib_devdata *dd =3D dd_from_dev(dev);
> > > > =C2=A0
> > > >=20
> > > > -	buf[sizeof(dd->serial)] =3D '\0';
> > > > -	memcpy(buf, dd->serial, sizeof(dd->serial));
> > > > -	strcat(buf, "\n");
> > > > -	return strlen(buf);
> > > > +	return sysfs_emit(buf, "%s\n", dd->serial);
> > > > =C2=A0}
> > >=20
> > > This is not the same thing? dd->serial does not look null terminated,
> > > eg it is filled like this:
> > >=20
> > > 		memcpy(dd->serial, ifp->if_serial, sizeof(ifp->if_serial));
> > >=20
> > > From data read off the flash
> >=20
> > It seems you are correct.
> >=20
> > Maybe instead:
> > static ssize_t serial_show(struct device *device,
> > 			   struct device_attribute *attr, char *buf)
> > {
> > 	struct qib_ibdev *dev =3D
> > 		rdma_device_to_drv_device(device, struct qib_ibdev, rdi.ibdev);
> > 	struct qib_devdata *dd =3D dd_from_dev(dev);
> > 	const u8 *end =3D memchr(dd->serial, 0, ARRAY_SIZE(dd->serial));
> > 	int size =3D end ? end - dd->serial : ARRAY_SIZE(dd->serial);
> >=20
> > 	return sysfs_emit(buf, "%*s\n", size, dd->serial);
>=20
> I believe for this to actually be correct, this should be:
>=20
> 	return sysfs_emit(buf, "%.*s\n", size, dd->serial);

Yes, I think so, I squished it in

Maybe Dennis can check it in the wip/jgg/for-next branch?

Thanks,
Jason
