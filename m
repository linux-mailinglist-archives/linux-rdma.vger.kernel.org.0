Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4CF29E2E9
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Oct 2020 03:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgJ2CoN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Oct 2020 22:44:13 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:3170 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726702AbgJ1VfJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 28 Oct 2020 17:35:09 -0400
Received: from HKMAIL103.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f99b7130000>; Thu, 29 Oct 2020 02:23:15 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 28 Oct
 2020 18:23:09 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.59) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 28 Oct 2020 18:23:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHIRnTfQlV7abFhH6blTb1QdYtiqXSL/9PwWgDQPmBv0G2G/XEveZJmmQtY1YKHarwnkhdqnkBgIKWpYidTFJZyDX5gye+4NLwsNnEyr/lOytUvNOl65PhsqkUMjef63nnllhad7PJmRY1erm8rBwIRgF920Fh0Q8hoRYDlcpPj7Q87AGFRJ15f7/Nl7YDtzJDmOmhcq+VecpVdtEfo1WfnCj0dSjg4zXFYyCCm5pVLDd5zYI+1/BExzCUjmBYBBfHYbZcdqYAohc+cUIMeUY/fKolfBEjs4AStwvavrHLamwXvj8Hjly7oSvvSr7Zl+NXcQkyYYXvyRRDeKL+sYFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEnYKbgAGShB5vJqGgbSYA5lS5W2WKbxiDfCILIM+Fs=;
 b=kALeZfxuCaiXpOkU/dzcxu/V26poCQlnTOxUEyu8IvbLDjn3VsMBj4Pt8Q/To0Cea7+BVL+0TvKP+cIKJKWdbHsBKP5KIR2QvN1k8kCQ5EjoDxiyUjN5ESLk5+9/Rca+U525hphPciJ9n8ybSCKuMBNjlP/UbLsSnqsyeTIOBeenSm5vOFnJxHRvzMfLSy8MbjJ/e/lnPZlSkRYkOMXCn8ShEef5lEpiYK/ZTIVS1z+toE0R9d70rj4951JBeTnq08l1+HEUpEGCQS6RUOEwnOHnRiZgpeLkYy8dBVEh52YahTBfq7RZIHQbuDboqAdkQWcA/fl7PHvQKgNq+IZRHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2438.namprd12.prod.outlook.com (2603:10b6:4:b5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 28 Oct
 2020 18:23:06 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.027; Wed, 28 Oct 2020
 18:23:06 +0000
Date:   Wed, 28 Oct 2020 15:23:04 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Joe Perches <joe@perches.com>
CC:     Doug Ledford <dledford@redhat.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        "Dennis Dalessandro" <dennis.dalessandro@intel.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Bart Van Assche <bvanassche@acm.org>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH 3/4] RDMA: manual changes for sysfs_emit and neatening
Message-ID: <20201028182304.GA2481078@nvidia.com>
References: <cover.1602122879.git.joe@perches.com>
 <f5c9e4c9d8dafca1b7b70bd597ee7f8f219c31c8.1602122880.git.joe@perches.com>
 <20201028172530.GA2460290@nvidia.com>
 <4684eb7d2a872b23bd3258153370d4de1691bbe4.camel@perches.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4684eb7d2a872b23bd3258153370d4de1691bbe4.camel@perches.com>
X-ClientProxiedBy: MN2PR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:208:fc::33) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR02CA0020.namprd02.prod.outlook.com (2603:10b6:208:fc::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 28 Oct 2020 18:23:05 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kXq6C-00APTr-Fr; Wed, 28 Oct 2020 15:23:04 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603909395; bh=0KaTZlNxJJSdhfy8rgDJoKZUU+9vm6d3OOQ6TabEiyQ=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=bX9DTCcvWxegwm+ra1kCxwV1KQ81YmlMiZjKUrNqq3tFA8+ZY+RWzhtwbtpH1+Y0V
         AIcucJh7RMyO6+K4+vH9FqVaOl5xptoBLhK5gQep6KmPIR/P+80QSveyd+DqvKATss
         qGABGUzzMuPgKipYIy7Hhh6ZFgmBsfMo+RozrVm60rZxJi2r26ETxwc9/kJsCz0AiV
         h7o0G+bydgvlbfGh7aydlUtTBdfySDsMaxRRxDaRcjBacNENQUBQknko32tuo8ffUb
         Z5axC23IaIF5Gy2uHGdRsrATY1FQmG/MRaDVEz4VlI+wXW0ST/Cwx5oXsiM35uZTs6
         2kiGAza3L1YXQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 28, 2020 at 10:54:19AM -0700, Joe Perches wrote:
> On Wed, 2020-10-28 at 14:25 -0300, Jason Gunthorpe wrote:
> > On Wed, Oct 07, 2020 at 07:36:26PM -0700, Joe Perches wrote:
> >=20
> > > @@ -653,10 +651,7 @@ static ssize_t serial_show(struct device *device=
,
> > > =C2=A0		rdma_device_to_drv_device(device, struct qib_ibdev, rdi.ibdev=
);
> > > =C2=A0	struct qib_devdata *dd =3D dd_from_dev(dev);
> > > =C2=A0
> > >=20
> > > -	buf[sizeof(dd->serial)] =3D '\0';
> > > -	memcpy(buf, dd->serial, sizeof(dd->serial));
> > > -	strcat(buf, "\n");
> > > -	return strlen(buf);
> > > +	return sysfs_emit(buf, "%s\n", dd->serial);
> > > =C2=A0}
> >=20
> > This is not the same thing? dd->serial does not look null terminated,
> > eg it is filled like this:
> >=20
> > 		memcpy(dd->serial, ifp->if_serial, sizeof(ifp->if_serial));
> >=20
> > From data read off the flash
>=20
> It seems you are correct.
>=20
> Maybe instead:
> static ssize_t serial_show(struct device *device,
> 			   struct device_attribute *attr, char *buf)
> {
> 	struct qib_ibdev *dev =3D
> 		rdma_device_to_drv_device(device, struct qib_ibdev, rdi.ibdev);
> 	struct qib_devdata *dd =3D dd_from_dev(dev);
> 	const u8 *end =3D memchr(dd->serial, 0, ARRAY_SIZE(dd->serial));
> 	int size =3D end ? end - dd->serial : ARRAY_SIZE(dd->serial);
>=20
> 	return sysfs_emit(buf, "%*s\n", size, dd->serial);
> }
> static DEVICE_ATTR_RO(serial);

I adjusted it

Thanks,
Jason
