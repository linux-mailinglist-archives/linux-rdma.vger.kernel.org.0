Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF0B2F71D7
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Jan 2021 06:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731641AbhAOE7w (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Jan 2021 23:59:52 -0500
Received: from mail-dm6nam12on2068.outbound.protection.outlook.com ([40.107.243.68]:15457
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726019AbhAOE7v (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 14 Jan 2021 23:59:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TF+tCpjRCsDV58j+nWdDAZmx4jDNaYQ266tYFoDGceduVxxvTWCvStCGXeBbwWyXIaSVpJfnOgxyukKHSidvHaqYOxz39Wy0DetFpfaAfebI+XeGtKjVjQ79ilgS8X1AccANf7mMongJM5wsbG7p7YOhU2zS1m86hNIwVO5GYKfrNWQdFdz4wa340gqiwK+l3ohHmVaZvUyivIMrjZn/tCMFGpuFDaVBAjslbOWp6a3OCT1ospnHzxQYqVdzXKYePGwbhxV5mledQiZSVXrXZV0Sy12FznviZVKAFawWphuY3oQj7/AGWyLIicZ7F+n/nFcG1dH9o/6ufatoE+F/Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkoJ+LZVaYsZ9ppfGlcKIZeNk1WSuR8NHVvfzo1WQXk=;
 b=NJo+trS422GWSOWOJ9u2chjoCPZY2H9snc0AONWmsx8YyI0NNh23LWQ5C+Z8S+NaAomazdT84OSl4+EFMj5EbLNqbrPZD82Il/JAgUwowMHfB7BFHBZFqkWHXvE/CqnQ1ijn3RmcyS4Hcyv4fD3YmnizxJz2Tdk+/fdxlvbf1NGtRqVEjo36v+qDm3lZq/sUjcSQYCEF2HfGAZLclfQRgbbqwUckdyM5ptxTApoB55cnqQ04mWyaoms7LOv/TAKCiwWhLQqMfPuVaDcWP6Us6jXofkz6YpgRresvtZE+eB3Op03fC7QG6OO7m4Qc3XHgSGhWhnra/gYUXoIvFyJ7Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkoJ+LZVaYsZ9ppfGlcKIZeNk1WSuR8NHVvfzo1WQXk=;
 b=NrRl4qtIWXMqUEuH/EX7L5vx4SV+UgdLcEQG/1KoWPPq0HEC7wefNGIccg232QS26Asn+b/ugVgL45vwV9V2pGnXTOmN0ENArMiRSuqzuVP8sdOT+AzuI/SLAurpI/+fghG63Ul2U4DWoWGQzH+VCnSV35RXJ7CO7WkTHFQviws=
Received: from (2603:10b6:208:36::17) by
 MN2PR05MB6864.namprd05.prod.outlook.com (2603:10b6:208:179::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.6; Fri, 15 Jan
 2021 04:58:58 +0000
Received: from BL0PR05MB5010.namprd05.prod.outlook.com
 ([fe80::b5a6:c2f0:f5fd:1fce]) by BL0PR05MB5010.namprd05.prod.outlook.com
 ([fe80::b5a6:c2f0:f5fd:1fce%6]) with mapi id 15.20.3784.006; Fri, 15 Jan 2021
 04:58:58 +0000
From:   Bryan Tan <bryantan@vmware.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Pv-drivers <Pv-drivers@vmware.com>
Subject: RE: [PATCH for-rc] RDMA/vmw_pvrdma: Fix network_hdr_type reported in
 WC
Thread-Topic: [PATCH for-rc] RDMA/vmw_pvrdma: Fix network_hdr_type reported in
 WC
Thread-Index: AQHW6oFSgRSBXw4ME0q8w/xESfn7YKonXxSAgADB0RA=
Date:   Fri, 15 Jan 2021 04:58:58 +0000
Message-ID: <BL0PR05MB501015BAF25CADD722F5A9FCB2A79@BL0PR05MB5010.namprd05.prod.outlook.com>
References: <1610634408-31356-1-git-send-email-bryantan@vmware.com>
 <20210114172359.GC316809@nvidia.com>
In-Reply-To: <20210114172359.GC316809@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: adc7f85b-fa85-4ba6-1907-08d8b91244b4
x-ms-traffictypediagnostic: MN2PR05MB6864:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR05MB6864A07596E390F9E6BA4C26B2A79@MN2PR05MB6864.namprd05.prod.outlook.com>
x-vmwhitelist: True
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bvaDcrEVDfj1VYP7u4wG6MqvgWWfxDUrZbiRUhX1ZZ5jN2KN0ul9fH2XO/8t0votTn00BPckkZY0AxEoiA+XSE46CVTxiM7cvPcdH9uXVYNEQS/TvyQPpEN/AAKhYqVWlRV6mAKQY6griM/6ORD0qnh22nf4YYOHBx7kAIAE8o+UFSpFcuHly6MqDNiebsAe/pXRN00y3vyjCcwb/hLZLJZlFdBcdFTPsD6fbFT8TV9A0B/9WkiJ1CeHntSRmou/Bsjp3P5QlYcOMnmW0sdz5x3wmxqL2LOznfKqP21CDqdlm4EFTLO0kknzUftIwSCozAv8idU267MDEa8ZOBK8SKhBK2Iq3h+h0ITg98Mwdtdut2EwOFbDJecyXuERZGdZ4G0ovJBvazA9q/b6bhcatg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR05MB5010.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(76116006)(6916009)(8936002)(33656002)(6506007)(64756008)(66556008)(66476007)(54906003)(66946007)(66446008)(8676002)(2906002)(7696005)(9686003)(55016002)(52536014)(186003)(86362001)(26005)(5660300002)(478600001)(71200400001)(107886003)(4326008)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?CxPw1xnmSBnjBoZ443HeW1egWosFVfI2jAcVYXhb4UtR8pbCS22Ic+zX779m?=
 =?us-ascii?Q?AdFCV8KAOLnWNhfvFaUr0FBZSNXcdtZSKg2npb5sjxN+JCzHW1QqN1e0zBCx?=
 =?us-ascii?Q?ztQIdCVTVVrymu+4N7REJjZIFjMDUokSNE75guPpMt3HG2wz5tO8GijSyTXL?=
 =?us-ascii?Q?jbfTZ4Nne7zS7EPxRhzW0evDW1w7edFMKjKp8VwTPZPMVemVFh52niAeA65m?=
 =?us-ascii?Q?6AEv/rG/Aisduzp3wT2fwhq8GSvQHEPG1ucR0d3tGHBEKJRUOwIjNWNIFFnA?=
 =?us-ascii?Q?a77zoh5rfHxjh8XLi5hmgCjIsPO3T/VENEbmbDnXJiUSHn4Kl5yxlxMIvXTN?=
 =?us-ascii?Q?mrnpO+y2LfNY7MoERGuigEh7m1HdLnZmpigXH9bYRbVMLofXem2DLc9rZsim?=
 =?us-ascii?Q?BvhSWMytn8wfIP8NSWPqUNsYKhKrxfsQqKuYDEeKSrMkQICCFHlEK3z2lue0?=
 =?us-ascii?Q?nKOejCWXazbNbRIejKBf4b4EC3s7A1tEk6Y8RO/qdpkEraTC4hVuAQ+GQ+8s?=
 =?us-ascii?Q?VpoNBu+QPZ5+6Ky7s72rwrWE0KkaTUN/sJLCjNzNw5Fdo2lIbMdXJRHx3lhn?=
 =?us-ascii?Q?WEBWDgaH8HXCquC3LX0mF1l0Hz+dnIw4p3q6yiZtmexdQJ4hpgot/pg+j9Fa?=
 =?us-ascii?Q?+v+pLsKY5wmK6kzduoHzZ/NV8FrQhJpgo3pQ6vo5RMzwIZEwFBfO1D8yWNAR?=
 =?us-ascii?Q?vJNKUlSAiJYsUpmmK9N51NnFoO7dFDj1aIqfAme3FqSvweudM1VPnRvxPARJ?=
 =?us-ascii?Q?VecksYt9iHGXejkI2WqbdJaifUj6v4oL58vc4aELC945WSph1GA+V9bmNVIL?=
 =?us-ascii?Q?PXBM+K9mn7//NE1R2Ep+4ejwL9oIs9akxtN/knA0eX7nPAPPCSh9qQZv/k1X?=
 =?us-ascii?Q?/QWzvS+nCeMZPF7bVCYzk4AS6kX0jmf+yO5g1Kzo84nh6DaI3HMhbd1TbWEi?=
 =?us-ascii?Q?VAznKYEHmeGii0EHPy+DjV1DxI3xrYwol57zkMzLoP4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR05MB5010.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adc7f85b-fa85-4ba6-1907-08d8b91244b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2021 04:58:58.4879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /0019b6kwkVlprvWo40zGFHjCCuFMQpw0VzsmTmWjtosveSAMQLFp3blvYvtlV177oqAYqF4LWhaZ2sxfFh5KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6864
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>=20
> Sent: Friday, January 15, 2021 1:24 AM
> On Thu, Jan 14, 2021 at 06:26:48AM -0800, Bryan Tan wrote:
> > The PVRDMA device defines network_hdr_type according to an old
> > definition of the rdma_network_type enum that has since changed,
> > resulting in the wrong rdma_network_type being reported. Fix this by
> > explicitly defining the enum used by the PVRDMA device and adding a
> > function to convert the pvrdma_network_type to rdma_network_type enum.
>=20
> How come I can't find anything reading this in rdma-core?
>=20
> $ ~/oss/rdma-core#git grep network_hdr_type
> kernel-headers/rdma/vmw_pvrdma-abi.h:  __u8 network_hdr_type;
>=20
> ??

network_hdr_type isn't exposed in the userspace WC ibv_wc. Given that the
field is only in the kernel side, it didn't seem like we should add the
new enum to vmw_pvrdma-abi.h either.

> > Fixes: 1c15b4f2a42f ("RDMA/core: Modify enum ib_gid_type and enum rdma_=
network_type")
> > Signed-off-by: Bryan Tan <bryantan@vmware.com>
>=20
> Add Cc: stable@vger.kernel.org # 5.10+

Will do.

> > diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h b/driver=
s/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h
> > index 86a6c054ea26..637d33944f95 100644
> > --- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h
> > +++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h
> > @@ -201,6 +201,13 @@ enum pvrdma_device_mode {
> >     PVRDMA_DEVICE_MODE_IB,     /* InfiniBand. */
> >  };
> > =20
> > +enum pvrdma_network_type {
> > +   PVRDMA_NETWORK_IB,
> > +   PVRDMA_NETWORK_ROCE_V1 =3D PVRDMA_NETWORK_IB,
> > +   PVRDMA_NETWORK_IPV4,
> > +   PVRDMA_NETWORK_IPV6
> > +};
>=20
> This is in the wrong place, uapi data needs to be in
> includ/ulp/rdma/vmw_pvrdma-abi.h

Please see above.

Thanks,
Bryan
