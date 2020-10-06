Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4544A28442B
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Oct 2020 05:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbgJFDAA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Oct 2020 23:00:00 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:15091 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbgJFDAA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 5 Oct 2020 23:00:00 -0400
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7bddac0000>; Tue, 06 Oct 2020 10:59:56 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 6 Oct
 2020 02:59:36 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 6 Oct 2020 02:59:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHFpei9c6vrxLyeWKB+SJzH0r0uVkqPyEUwhz0TYN9c1y9Oo3ej5UG2FAiVV7sg/VUXs71/XTxhlHIuD7T6duDrNNh9o9pq6qtLjoNHZUOV+GJQYesdvksAGAlBRLPpcMRwbWMSp2b81CD7w9kocomjMnX+uLuHUdsOjiZUDbpUAvORrR3zFZyClNPNGA1jshWL5t6a/vGhU8Qg0PJGBprzf+4wdK1XKkB/Ry4VFp6DMMNiVa0jwwWUo9FLTJtvZ7M+pShi1MazfEmP6k8VUlNL3erxauhk6nKKbmNXdOyYvs2UrUoMh5Xh3LtD1ge/xtH2tZbeWJ4UJp4K8Xho2Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDlVJGOOe6eIsfOcaYx5FCZfB+tb0x5aEHLVX/xwRnM=;
 b=gGAKpgpBJu2JBxtRy1Wp1jG7QLzVzFZ21IfQNv5YxafSfOgJSQRxEm9P3o6Y71deSnfT8EHg+a5VRcbAJj3CsIl+0lYoH+vYIVOqUgmx6zdyqgN9vYb5/LsPGmqMdH/8klGVWoCmu0QVn6gFxw4npB9T3FRASjkau9MQHuFx61Fw3SM9tHmcrgEYo6raN5oAVL6DhL/7GqaJlCqhvjQ18FIy3M0k0K1R7llacD+awzzcWp80AusJf0qm709FHulbO169gBSb/kKqAfCzNmjZ/S5lIAyQ4yTvYqnw6L6Hkliz7aTsAPyV5lep9SF+TbB4NRZvc/4UQVyD5u/UcSu51w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 by BY5PR12MB3763.namprd12.prod.outlook.com (2603:10b6:a03:1a8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.38; Tue, 6 Oct
 2020 02:59:33 +0000
Received: from BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::3c25:6e4c:d506:6105]) by BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::3c25:6e4c:d506:6105%6]) with mapi id 15.20.3433.044; Tue, 6 Oct 2020
 02:59:33 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Christian Benvenuti <benve@cisco.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Gal Pressman <galpress@amazon.com>,
        Lijun Ou <oulijun@huawei.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        "Mike Marciniszyn" <mike.marciniszyn@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        "Parvi Kaustubhi" <pkaustub@cisco.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Yanjun Zhu <yanjunz@nvidia.com>
Subject: RE: [PATCH rdma-next v1] RDMA: Explicitly pass in the dma_device to
 ib_register_device
Thread-Topic: [PATCH rdma-next v1] RDMA: Explicitly pass in the dma_device to
 ib_register_device
Thread-Index: AQHWmwbRRxc8jRrW3EWImRoxJ1u756mJBxsAgAASyQCAAMkRoA==
Date:   Tue, 6 Oct 2020 02:59:32 +0000
Message-ID: <BY5PR12MB43223BDE9E73B5E001B75E22DC0D0@BY5PR12MB4322.namprd12.prod.outlook.com>
References: <20201005110050.1703618-1-leon@kernel.org>
 <20201005135110.GA12620@infradead.org> <20201005145824.GB1874917@unreal>
In-Reply-To: <20201005145824.GB1874917@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [49.207.195.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b829e7db-dd25-4d63-de5a-08d869a3d9fa
x-ms-traffictypediagnostic: BY5PR12MB3763:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB37635EBD97EDD6C7E4208F01DC0D0@BY5PR12MB3763.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 42JfP9YuDLoBNXGYpdcIi3QUuZtt985iLa+lCsmrOuSzg7N/nTzxkYZGxqJBviOOGzvgPEYR+wFU/cdOuYYVBcrW+8yWSopO2wTo/FhwserslpxnGyDgFJW7TuLRxK0fQTuZ/txbqSqwAJ+gt4c5/dPOk/NzeixOQFjrTYc57KfEE0XQjOlQwvt9jWqyoMw4QxVj6/SGp5U2GmXL8aLI0SjuiC5Bfdl7TtdhxWPNJz+0lrJhbep4SRrdtp/7XNJjntDEYopQCwfe+srrHlTXJep00SFP7K7vrkni8kOJs25TkdD6k6wBfiIVQHbz4YqiaPRH2/6ajW5bvkzUj6B2cA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4322.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(2906002)(4326008)(83380400001)(478600001)(8936002)(33656002)(316002)(66556008)(7416002)(64756008)(76116006)(66946007)(66476007)(52536014)(5660300002)(66446008)(7696005)(8676002)(26005)(110136005)(54906003)(55016002)(71200400001)(55236004)(9686003)(6506007)(86362001)(107886003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Rrr+tDpowgs2rD7fLT9/Tb1xE5X+SabWEkV27wI/UWxIn7ADO8v9obdJIZr8pTy91yn2KY9FfxLJaOLEguO9v7HL82sr8OqTMZ1Wz47JtJ0T/kAS2WPjSxh1nt/NnkdCxKxkWU6biPwCCHQPAWrM4zP9yRRKWSwBhjP0UYgQo0OWcOnAj/52Rls662L3SX8uMs6PZJD2v68icP9ctpdfxu/JkB3dcMnYYXFaAiJPRy3M1j8swlN4LufwZ5Z812C8L5iXz8YMN7sW9nRDM0G/mFbSjPag0oYnfJtNShXVXBj00ghyaeRpoLjVXPivZlkqpa4dpvBvgOVR2ODVZqDrlkH3qhLtvcVAGmuKiwDjylUaZW2QzOlEZvvtfB1n1nv4TuSGrVnd+iBLqs20gkOjLo8M9qDbPxjV0TyWIAlPfGSkZdctH7LKXx0JCtHJyxURdl9MBGDXM2awx/EBSL0m6XM9fRXGdMTJPOgC94bX7RBnWW131JbPXxiLC/myBoetnMFvuyDTTFAgmaosbrd7oQ/CD9IgqbH15ILFOznWmZX1UC5sWMkdWHVQ4B3ks6DO4KXN3lBufoHKe5yszkGcLEbfVIz9/f1SuwXPFOw+pwLetg3+VNvCdk3IuvJiA8zceuPJQfxWeHesBEHDSHJBUQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4322.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b829e7db-dd25-4d63-de5a-08d869a3d9fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2020 02:59:32.8626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7I9bYIb2Ib/iF3EiWzAJAarMMia4oCYkZ9mo5XDrMmo4SrTsnnbYs8w0+WI5xFdL5T5r/iNebw8nrw44Ivw44g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3763
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601953196; bh=mDlVJGOOe6eIsfOcaYx5FCZfB+tb0x5aEHLVX/xwRnM=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
         In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
         x-ms-traffictypediagnostic:x-ms-exchange-transport-forked:
         x-microsoft-antispam-prvs:x-ms-oob-tlc-oobclassifiers:
         x-ms-exchange-senderadcheck:x-microsoft-antispam:
         x-microsoft-antispam-message-info:x-forefront-antispam-report:
         x-ms-exchange-antispam-messagedata:Content-Type:
         Content-Transfer-Encoding:MIME-Version:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=idmwzLw/xMehb3ElwpRAtjA2dw9mjKwnlnayYOBFSSzPn0gwbECIJA3TynodJLobX
         zchTCcStRhF67laXEPmMMwLxeHK857CeLP1+71X8AQ7zigtgBIdRcpu/c9eymAxDoJ
         Zb2e3UK8AeNL2eFSv35nM6jxjMtcKF9vGLk8KBs+jilLuU/A7qVx+TMOhkgzROSswx
         NeL6p/OwqkNMivaAMiZirIXbWGz+tZDRZFYL4Lav0qedhTT//4+88Q/0STE4syvpCF
         lEr3UQJVV/Q2mrtpxunJVuJM/Gj6ea/UYPBL2k3fpXh6xFHkaSM34HHPtps8EW8apN
         OtG5u97onLdnA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> From: Leon Romanovsky <leon@kernel.org>
> Sent: Monday, October 5, 2020 8:28 PM
>=20
> On Mon, Oct 05, 2020 at 02:51:10PM +0100, Christoph Hellwig wrote:
> > >
> > > -static void setup_dma_device(struct ib_device *device)
> > > +static void setup_dma_device(struct ib_device *device,
> > > +			     struct device *dma_device)
> > >  {
> > > +	if (!dma_device) {
> > >  		/*
> > > +		 * If the caller does not provide a DMA capable device then
> the
> > > +		 * IB device will be used. In this case the caller should fully
> > > +		 * setup the ibdev for DMA. This usually means using
> > > +		 * dma_virt_ops.
> > >  		 */
> > > +#ifdef CONFIG_DMA_OPS
> > > +		if (WARN_ON(!device->dev.dma_ops))
> > > +			return;
> > > +#endif
> >
> > Per the discussion last round I think this needs to warn if the ops is
> > not dma_virt_ops, or even better force dma_virt_ops here.
> >
> > Something like:
> >
> > 	if (!dma_device) {
> > 		if
> (WARN_ON_ONCE(!IS_ENABLED(CONFIG_DMA_VIRT_OPS)))
> > 			return -EINVAL;
> > 		device->dev.dma_ops =3D &dma_virt_ops;
> >
> > > +		if (WARN_ON(!device->dev.dma_parms))
> > > +			return;
> >
> > I think you either want this check to operate on the dma_device and be
> > called for both branches, or removed entirely now that the callers
> > setup the dma params.
>=20
> I would say that all those if(WARN_...) return are too zealous. They can'=
t be
> in our subsystem, so it is better to simply delete all if()s and left bla=
nk
> WARN_ON(..).
>=20
> Something like that:
> if (!dma_device) {
>       WARN_ON_ONCE(!IS_ENABLED(CONFIG_DMA_VIRT_OPS))
>       device->dev.dma_ops =3D &dma_virt_ops;
>       ....
Looks good to me.
Will you revise or I should?
