Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9D11274D2
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2019 05:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfLTEvE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Dec 2019 23:51:04 -0500
Received: from mail-eopbgr150048.outbound.protection.outlook.com ([40.107.15.48]:64134
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727128AbfLTEvE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Dec 2019 23:51:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I1oUbIValJA5NNqUV6TBM9+pCEDjU8N+Df+EbQEUVst5/dWpZAeBmN5qKY0jUPnaM5xEFtKsfzgyzz7YXiofRGFP/hFrimrvGhUa85WmTrU7qyfrLuMvyDxurZp4M3fol4P8gZRilGxRr4N06BPOLJqWU61iWe6xccplJKBBuDej96uHpwXaDXcWUDmLGmcS5tDyRl7jPS7B88elaGzM1/NTO0yBXAm1G/LGrhe/u+cz3I0ro3k9ueF4ezhZRjfD4UZf7W+0ZL1owvcl2Fi4ykJRGCuG2+nb0SrJ2ToIOE9OcqGfhuDEYqtgsLYJHKoN0Pk8ASHb/nTlLmHa7EhWwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35F7bo+U5BBHwGnzgj9s2goWZtbv1HZ7WauKYhbyWes=;
 b=TK1aFPyRChYXTrkUFVTZd6fkZS3EeVJebz14BrRxJRjnzZodcTWGID7cBFVUONSFSkQwFi15aXrfv6yteqI2x/ozuZVcq4bEylebey2Xaqx/dUrUiK7CCO7QU4cXZPNqO/sCCF9fbQ1URBx6dRKywtTkRhkWqkr/6/ppBGOq4J0HPVFkOc5tX46Ig32ZbYrdt5s9Wgc+OCeGcNSagohDDbSJCSVrspydMtoEFgiWJgyewpbchRytx0kuAjZkEI1QCwi59pZx7QPavDMGnIyWvyodIXxCa/SCQUyTexrtmga3NfAY++RBO89RI0cd89cZYomm+YC1hjdJHu8/Xa15xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35F7bo+U5BBHwGnzgj9s2goWZtbv1HZ7WauKYhbyWes=;
 b=AZFkjQdut9nvUfYtM1DaA1h6rOdgV8dnI/c1QIBA+KlKrRMcV3uy+KUYempKmA7U7+blEgjUBbeaPIxcjaW2RA2RY3TGvgyNeIztg8aBO/7mHXJVVEAi6M9BPLv4uMSHWRf0yySy3c/Mp8696wvK8e7tvNESh6JcQNokQ2JjGwc=
Received: from AM6PR0502MB3638.eurprd05.prod.outlook.com (52.133.22.141) by
 AM6PR0502MB3814.eurprd05.prod.outlook.com (52.133.21.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Fri, 20 Dec 2019 04:51:00 +0000
Received: from AM6PR0502MB3638.eurprd05.prod.outlook.com
 ([fe80::811c:d98c:ff3c:d83b]) by AM6PR0502MB3638.eurprd05.prod.outlook.com
 ([fe80::811c:d98c:ff3c:d83b%6]) with mapi id 15.20.2559.015; Fri, 20 Dec 2019
 04:51:00 +0000
From:   Artemy Kovalyov <artemyko@mellanox.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Aviad Yehezkel <aviadye@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: RE: [PATCH rdma-rc 3/3] IB/core: Fix ODP with IB_ACCESS_HUGETLB
 handling
Thread-Topic: [PATCH rdma-rc 3/3] IB/core: Fix ODP with IB_ACCESS_HUGETLB
 handling
Thread-Index: AQHVtnLKDMRyDGvoGEKmP7IvLHf1FqfByHqAgACsTJA=
Date:   Fri, 20 Dec 2019 04:51:00 +0000
Message-ID: <AM6PR0502MB3638228D4DD3E713A5AE8951B72D0@AM6PR0502MB3638.eurprd05.prod.outlook.com>
References: <20191219134646.413164-1-leon@kernel.org>
 <20191219134646.413164-4-leon@kernel.org> <20191219183237.GJ17227@ziepe.ca>
In-Reply-To: <20191219183237.GJ17227@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=artemyko@mellanox.com; 
x-originating-ip: [213.57.222.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f35e2534-45d8-4f98-2f99-08d7850835b4
x-ms-traffictypediagnostic: AM6PR0502MB3814:|AM6PR0502MB3814:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR0502MB3814F66C1B559FAADC0474EEB72D0@AM6PR0502MB3814.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 025796F161
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(189003)(199004)(13464003)(5660300002)(4326008)(478600001)(8936002)(76116006)(66946007)(33656002)(66476007)(66556008)(64756008)(66446008)(8676002)(81166006)(81156014)(186003)(6506007)(53546011)(7696005)(86362001)(26005)(71200400001)(2906002)(52536014)(107886003)(9686003)(316002)(54906003)(110136005)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0502MB3814;H:AM6PR0502MB3638.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Kp3ydDhggsTInpoYbkys5gOkNdvvGj1elMowmcvC1hBxpzZj4wkwzcDZu8sIRENY1dEEI9Ko1njgaYWX3fghmWRAjERm8Snazh+TSNXzAhOp5sKQIhv4Fvbw6I1nIlxgqByQKuVwvUVIOT8sCjtuHNaabRjeaI7H+97EN1H6859TMlM/fsdiOoa11S8yzYqAzDO27p3sB2beVfXei4soJw/IS4uNXTxbxOhvB65TQ59pnkByK3bpv/zUP5htzp/a/8q3eAK4+QIgBQRm4JumiQWip0O8diN+iStYkwhh+CjzyJ8CPoeiSRHu9n558/FBcuYlQgwHSQRieHsNDS4M4PXHHjsBIebxTIopuD3tt/yzmEOLvQ0fyEiYlLEZrBepUdL7H7aoakaQgRSCMcSLis/21rA+lDAS4itzbLhy8YifzKXLmQRhI2hu1I/vn8hACIrFuSTnOQVOHrSVymSHYzLUdZque0xaSltegVNwjbIqfp7FPr3CGGTMUPNWJkGp
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f35e2534-45d8-4f98-2f99-08d7850835b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2019 04:51:00.2988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Oqh2JAf+lEPFU5gSFkFO0oZck7/0Q+gALtH0YHXNVp2QhwNMUZg5chbvUgKsHT93lwSahAjVMxjkJL70PW/xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0502MB3814
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



-----Original Message-----
From: Jason Gunthorpe <jgg@ziepe.ca>=20
Sent: Thursday, December 19, 2019 8:33 PM
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>; Leon Romanovsky <leonro@mellanox.co=
m>; RDMA mailing list <linux-rdma@vger.kernel.org>; Artemy Kovalyov <artemy=
ko@mellanox.com>; Aviad Yehezkel <aviadye@mellanox.com>; Yishai Hadas <yish=
aih@mellanox.com>
Subject: Re: [PATCH rdma-rc 3/3] IB/core: Fix ODP with IB_ACCESS_HUGETLB ha=
ndling

On Thu, Dec 19, 2019 at 03:46:46PM +0200, Leon Romanovsky wrote:

> @@ -403,6 +390,7 @@ int ib_umem_odp_map_dma_pages(struct ib_umem_odp *ume=
m_odp, u64 user_virt,
>  	int j, k, ret =3D 0, start_idx, npages =3D 0;
>  	unsigned int flags =3D 0, page_shift;
>  	phys_addr_t p =3D 0;
> +	struct vm_area_struct **vmas;
> =20
>  	if (access_mask =3D=3D 0)
>  		return -EINVAL;
> @@ -415,6 +403,12 @@ int ib_umem_odp_map_dma_pages(struct ib_umem_odp *um=
em_odp, u64 user_virt,
>  	if (!local_page_list)
>  		return -ENOMEM;
> =20
> +	vmas =3D (struct vm_area_struct **)__get_free_page(GFP_KERNEL);
> +	if (!vmas) {
> +		ret =3D -ENOMEM;
> +		goto out_free_page_list;
> +	}

I'd rather not do this on the fast path

> +			if ((1 << page_shift) > vma_kernel_pagesize(vmas[j])) {
> +				ret =3D -EFAULT;
> +				break;
> +			}

And vma's cannot be de-refenced outside the mmap_sem

There is already logic checking for linear contiguous pages:

                        if (user_virt & ~page_mask) {
                                p +=3D PAGE_SIZE;
                                if (page_to_phys(local_page_list[j]) !=3D p=
) {
                                        ret =3D -EFAULT;
                                        break;
                                }

Why do we need to add the vma check?

AK: checking for linear contiguity may be not enough, page may be transpare=
nt huge page, so in addition we also ensure its indeed persistent.

Jason
