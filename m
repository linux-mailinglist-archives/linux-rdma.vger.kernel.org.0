Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3847DA2B7
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Oct 2023 23:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235062AbjJ0V7v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Oct 2023 17:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjJ0V7u (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Oct 2023 17:59:50 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020003.outbound.protection.outlook.com [52.101.56.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612A71A6;
        Fri, 27 Oct 2023 14:59:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjpkrICuFQ88c7EjA2BEnEn3jOiQfNKLDHw4vU+Dqy2AuLqIXgiH6+fnEAAQzIyqC6g7hTTyktaRKjy7jzbt9zzRaOdPMolIxvCV+JD4RIPNmnCUTqS9lDn/YFysff7F3Ks3HugSZ/gFY01F3bQTCTU83ZNHzmBm4dXsguTWzUIYGJuTTLvIdvQBC6yVJwpNrC6jOS4dm1zjP7BmGj6lGdtJIqTZK1oi0mbIkCmwLm38dGITuiRZVhtqM1hiOdSHGx1kUInbyzi34E/DssXqJ+fVceuKDElsJNj0srK4N2toznBtfNnl+mRy//NqNLmBHemTHfpVsbGIPLQz5kbX/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zE9pCBWFmrjuNbfTAN3X8LFj1GDiY9ejOJw7EFJ73dg=;
 b=OEj5SJdwq3vXa/LVFP07vw5dSFitsLWmS4h9dR0B5wLaK7TDSibmFqUIIW5+X+s+5S1f0D5b39FI7YXiuKxQ5BshlZXW6mhzqiA+v91r5bmPCqohs9X+UHBA85aTZcbJGIIQVPna8r9OOsLeC0ALb8zM8UyKU2NX8kb1o+7VRkAu4ebobrQnW0Ok3enzISKeOU4FmiFGvE1jLWz/q+9vd/I1Gf6ppL9OtjCYR/uR4NXaqfbmcO9qXDR/YZQsy+BjI11PhFwMAE+KjtnVcRBMQzDSyMlmiS8RCjb2ss0Qw+MHMOOkbc7RAT0THTvg2BgzAx9mAX/rPwRB8P3XCZgfBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zE9pCBWFmrjuNbfTAN3X8LFj1GDiY9ejOJw7EFJ73dg=;
 b=DD6Z9FT8fyCA5hyNdQHIv8IVTXfBvQ0t/r1uH1xQR3gay3aTnU+D5TNJfNqMiVyJb/qr+cHY70Tbv/GwlBCU5tANRdXxurXHp4VaWcdBIctaU9zbeTfQSY14E04JJoZ15q82+tBnANLI6TZAafXuZmoDCAikQKctHnL7Ofw494Q=
Received: from MN0PR21MB3264.namprd21.prod.outlook.com (2603:10b6:208:37c::19)
 by DS7PR21MB3247.namprd21.prod.outlook.com (2603:10b6:8:7f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.8; Fri, 27 Oct
 2023 21:59:43 +0000
Received: from MN0PR21MB3264.namprd21.prod.outlook.com
 ([fe80::9f51:f462:e8d2:d242]) by MN0PR21MB3264.namprd21.prod.outlook.com
 ([fe80::9f51:f462:e8d2:d242%5]) with mapi id 15.20.6954.005; Fri, 27 Oct 2023
 21:59:42 +0000
From:   Long Li <longli@microsoft.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        "sharmaajay@linuxonhyperv.com" <sharmaajay@linuxonhyperv.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ajay Sharma <sharmaajay@microsoft.com>
Subject: RE: [Patch v7 2/5] RDMA/mana_ib: Register Mana IB  device with
 Management SW
Thread-Topic: [Patch v7 2/5] RDMA/mana_ib: Register Mana IB  device with
 Management SW
Thread-Index: AQHaAH3PKtvFJ9Q1Uk2+grKfQjpeV7BXueMAgAaFe1A=
Date:   Fri, 27 Oct 2023 21:59:42 +0000
Message-ID: <MN0PR21MB3264DD5A4F35B5A579D43966CEDCA@MN0PR21MB3264.namprd21.prod.outlook.com>
References: <1697494322-26814-1-git-send-email-sharmaajay@linuxonhyperv.com>
 <1697494322-26814-3-git-send-email-sharmaajay@linuxonhyperv.com>
 <20231023181918.GJ691768@ziepe.ca>
In-Reply-To: <20231023181918.GJ691768@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=31915970-c671-42a7-a966-3d25e758a558;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-10-27T21:54:36Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR21MB3264:EE_|DS7PR21MB3247:EE_
x-ms-office365-filtering-correlation-id: da66fb25-5fe6-428d-18e4-08dbd7380666
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LrcRj65u/wJfaHH2+tmS8Jhb2l+Ed8RLg6/l/aZut79ChampwgktkIhMr7cM7kzS7IpApWBB9EcR337DYALKJRiw0sobFhuzlEEXdTV9EH5xx/FgxztnMZFL0MoSZbhJavLGXW+vRn45OPgWurmC22uCs9vLvDSfck+E+4SQ89N1STR6oyw5bZVpBxOr31h0myDdUizKWWAXRURegoW+VCv+dhCyOuqzH68LzNS+CPSEogE1UB818GRqIQd75zz+HbNh8dJmok8BzV5HL24pgtluu7qbAa/qgCg/Df1oZZs/RrB+z5eBmy69fNBNyAvnFR4CwvqIrYTb/X3YHI0pzwsfoHwxjQLXxVQvRuLON8HlZivm6ahvx1DILM/VspoPtgXL9SbIc9Dhj6BbykmfWGQEHdPNMDE/aKgE5wAmXz23QrQ9T2sPWRj59SRUAq0TVd1HtoiTSpcs4cTORvVHG1TgqX8PVH8V+SSYTuLlIxUSEfmYeVnaBRFE1zD8gHPATj0QUpLf6bTxBZVfdyiTG29Ty34H5n4QzJi6hvR9aWuvh1EPOVvf/0WdxhMOp4gZ5xDNuFhuaxFOv5tiM5Y9rkq8GUmmwL6VIliYhJeYgDrUN0y83rN/Kkjb6r77lVL13XF3YDZPSfsyvXfqES40eY27soMAftLn5qng2ysfIRE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR21MB3264.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(136003)(376002)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(8990500004)(5660300002)(2906002)(7416002)(41300700001)(4326008)(66899024)(38070700009)(107886003)(71200400001)(82960400001)(83380400001)(122000001)(33656002)(86362001)(82950400001)(38100700002)(478600001)(10290500003)(76116006)(316002)(52536014)(8936002)(8676002)(54906003)(55016003)(66556008)(66446008)(9686003)(110136005)(66476007)(6506007)(66946007)(7696005)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q+U8V6q0smw6DnX6YZzRFsZrECvl1Pp+k2Upyg8sU0ZgBiOFwKtXBxgn/aX9?=
 =?us-ascii?Q?OBFtPYjj2nr6LTpUUKMHpDhqtsqnAfaRg7/V+uLWpjLnF3n6WWXOpT/kagGV?=
 =?us-ascii?Q?pIXN+lWfwSmUmTna7+s1xN0mUkJySGyG5nJS7v1RxTJvXKK6hEyIIkHJxaVQ?=
 =?us-ascii?Q?MRxGNVc0b0StdatnNmzwk5z/PTSDIhbFJ/TpftZ1dGO62X5utJIwepShgleP?=
 =?us-ascii?Q?1+QT47/poStEMekHmbN98/gBecZFUdKUX4RG1/09aWORLRvAELVeOetn+U99?=
 =?us-ascii?Q?QJDeXqnRhJS+jymc29KqJ9k5oIC06SW0xoXVDuW71AR5kQpw4CiKvM7nAk33?=
 =?us-ascii?Q?Xi0tiIGEhpIxX3nbHfmuiZW6jS6tK+OZWUaGwQ6YzC8Jzno+RTFvakjHYKNU?=
 =?us-ascii?Q?4a++uVk6IwNfsRwlaGJuwfnyfvq9pMsIxFNUnGUb6wEkiuRSKmluu1T7NQML?=
 =?us-ascii?Q?Th+lR1/577o6t5qV/6DUFCLaqtj5Nx98myL4XAjRoWxTRPpO9yqLRocHpIQC?=
 =?us-ascii?Q?QGS73We6V0mm9Tsv/9HLFVnCr367WM5I/0uwMG/g4Z0hvZp5JeS2Op5B2a7N?=
 =?us-ascii?Q?KZYGdTY1YNXzK196FktCmjWtT0awYNQqXffCiiSzA9DQj6MT1y2qX+6uuUHw?=
 =?us-ascii?Q?c/tmXxvJ/39gGt8zvGgqdpNKwildUvJuBVKjHBry7ghYta+G98SbWbzal7sk?=
 =?us-ascii?Q?W1m2NlOa3I/ltqFpWZ/IRienjCQLpe1drnaM9/s+6VCB2aZNuB4+uiLtPlfK?=
 =?us-ascii?Q?BZZEnqWmmcXLHdTM1O0ZuKG5blMD+gI/j6djm/sIfKeJG9/tcFdNSQNpintu?=
 =?us-ascii?Q?FRY/lce7qf/NkP72P2ILm12jreCIdOSSMmhu6Qu5g0ZB1VOjD40I+L9LCC/8?=
 =?us-ascii?Q?KRIvJxaVqHo3QTYpKnIWxLh4+z1qdo939HikF+tdWCAXBGJHuQLBlhtsiS4t?=
 =?us-ascii?Q?NVvtBZpbl8hLZCR8jCgKzh7jHRky3UXFvS7WfyUtECQv2xL1WH4kaZ5wTO+d?=
 =?us-ascii?Q?0riGbI/2phY/yPlVWon4cD6AgEGZVIw4qp6iQP4xmGxZ+VJt8OuiQLPv+3/z?=
 =?us-ascii?Q?xDxbuvCZJcrxu8td1pq6ceaWi9DPYCQDm640q9vXRubuan/M6XcZzcdFZK3s?=
 =?us-ascii?Q?jZh8YNgoJjtygBXQ6JkdJg5GpxGan9kCwacoGpebGHX7eJ2KavRic6xMO7Zh?=
 =?us-ascii?Q?ZmPQ+lpc+WXghjIBiHwjBc6+iP6cdvNCnPqqO2f3y2TA7Isxa7YGp1RirOLD?=
 =?us-ascii?Q?zS27AsdJBVWHT0cv+H7LZ4g2q6HAG8OkEf1zUnhe6TIzlrkWTLskuNeSbhOj?=
 =?us-ascii?Q?u5iszyEDr7W/JE6cd2NAf9Mo5R8uiiGNNlotk/7o7EPPGiGlQId5BunHR7Qz?=
 =?us-ascii?Q?3KIQr/7duziKcw4sEjhD/vQjGaB3YeB/Lry9VVyFiroxusJLJUZGwQ7J3/S6?=
 =?us-ascii?Q?RqJgptiMbF5t0Vms2yLHxtg+9rt1D25Lh2+jFHKFcnjXwgUHDo/BNQejo3c4?=
 =?us-ascii?Q?Kr85qJ90iM0l6Tnl9pLk6rboqHvwNoI/PaPH3495h4IDui5x8KhY62Q3BDWK?=
 =?us-ascii?Q?exi9gGUZww+pARZxc7hMxYfqgKZ4HgEORu0MlZaD+ZjRhZwWkec0nHB19itJ?=
 =?us-ascii?Q?iWclvEkYd367WhiTea6FBHxzSh5rIgWmKKSUqw8UDlD0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR21MB3264.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da66fb25-5fe6-428d-18e4-08dbd7380666
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 21:59:42.8217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: os8GVz/hWIF6tuObEDGRtkdtNKzpivSMqSMQPLGcg0h8pymiJYzWSwCvEnMh9seKGm/rYvxEG8Sbbv1WcaRsug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3247
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: Re: [Patch v7 2/5] RDMA/mana_ib: Register Mana IB device with
> Management SW
>=20
> On Mon, Oct 16, 2023 at 03:11:59PM -0700,
> sharmaajay@linuxonhyperv.com wrote:
>=20
> > diff --git a/drivers/infiniband/hw/mana/device.c
> > b/drivers/infiniband/hw/mana/device.c
> > index 083f27246ba8..ea4c8c8fc10d 100644
> > --- a/drivers/infiniband/hw/mana/device.c
> > +++ b/drivers/infiniband/hw/mana/device.c
> > @@ -78,22 +78,34 @@ static int mana_ib_probe(struct auxiliary_device
> *adev,
> >  	mib_dev->ib_dev.num_comp_vectors =3D 1;
> >  	mib_dev->ib_dev.dev.parent =3D mdev->gdma_context->dev;
> >
> > -	ret =3D ib_register_device(&mib_dev->ib_dev, "mana_%d",
> > -				 mdev->gdma_context->dev);
> > +	ret =3D mana_gd_register_device(&mib_dev->gc->mana_ib);
> >  	if (ret) {
> > -		ib_dealloc_device(&mib_dev->ib_dev);
> > -		return ret;
> > +		ibdev_err(&mib_dev->ib_dev, "Failed to register device,
> ret %d",
> > +			  ret);
> > +		goto free_ib_device;
> >  	}
> >
> > +	ret =3D ib_register_device(&mib_dev->ib_dev, "mana_%d",
> > +				 mdev->gdma_context->dev);
> > +	if (ret)
> > +		goto deregister_device;
> > +
> >  	dev_set_drvdata(&adev->dev, mib_dev);
> >
> >  	return 0;
> > +
> > +deregister_device:
> > +	mana_gd_deregister_device(&mib_dev->gc->mana_ib);
> > +free_ib_device:
> > +	ib_dealloc_device(&mib_dev->ib_dev);
> > +	return ret;
> >  }
> >
> >  static void mana_ib_remove(struct auxiliary_device *adev)  {
> >  	struct mana_ib_dev *mib_dev =3D dev_get_drvdata(&adev->dev);
> >
> > +	mana_gd_deregister_device(&mib_dev->gc->mana_ib);
> >  	ib_unregister_device(&mib_dev->ib_dev);
> >  	ib_dealloc_device(&mib_dev->ib_dev);
> >  }
>=20
> That's definitely in the wrong order
>=20
> Are you shure these things should just be part of
> ops->enable_driver/dealloc_driver?

I think we want to register with the management interface before calling ib=
_register_device(). Because we need to communicate with PF to respond to qu=
ery_device().

But the order in mana_ib_remove() is wrong, the call to mana_gd_deregister_=
device() should be moved after calling ib_unregister_device().

Thanks,

Long
