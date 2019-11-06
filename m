Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B99CAF16A1
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2019 14:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfKFNG1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Nov 2019 08:06:27 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:23288 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726845AbfKFNG1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 Nov 2019 08:06:27 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA6D5hBG016563;
        Wed, 6 Nov 2019 05:06:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=dvgCX6eq0ZFh697Uqsq+/vA4OeuNksuWxE85Iu4IZys=;
 b=KrQM36hHA27LEOblyuinX8CsgQ76E5KMAQoPEB24V/ZRRjQWGbLCyX6SYAkWo/iia9Oh
 bbfeFld0/7qMqbp3YJLzZ5DKAAP94EquCOR4jHBrVwv5AjlNsQdNeHNd8n9llEtfskeD
 ZJaYzy6G+WF30Ksj7hKxhIee4pkoIySwzJn5TDIfX+3hbB/mSefSKaLC1PNVLwGaOnut
 0/aeDLO6kLseAVhrnTN8fTJcmLejT5h7jJEtUqtWNbYCIPmGeKv4ss7MUPWt8uyQU12w
 AlkYf8QrlcE850O5vXM+1OQ5StTTQWUpPFTEo5XOiHrPdgJnBB84TZIMJan/jCDCBzgT Ng== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2w19amyxfn-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 06 Nov 2019 05:06:17 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 6 Nov
 2019 05:05:00 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.54) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 6 Nov 2019 05:05:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5guThNSPbFg5wBdxxxtbYW0IfsDwbMoCwkxn6LN1CAkVibuwDiYA6Ce/e/MGDBFqGAkD9qfJxNl7N3Gw7PjqDTRRHtRt8iN5w8jlb1B8z01PQTPJt/XXKFTTSGNR8BZjiShTEZZ2T0qTltqcB790+SArSYud4dnlLRPxG86JHe9KdPi0P2sVkvY275zrKBIBr8cDrREfbtr2/SuulQlDTNq6dR2E51jU3qU+cSvrvs34YJ4um3iGJD2gQuMQrCzwz55OJH6lXwjeQOhbdrZGrSq++g3hH876M2gUT4hD4OGPjAROnrXKbADeHmYsPxAuapS9ZQjtd6fCGC7z4RQhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvgCX6eq0ZFh697Uqsq+/vA4OeuNksuWxE85Iu4IZys=;
 b=MubrktPOs1h43KSdh+gdClgwsYkZKmJ+CqxQlifbUt5BEziHEj/iPy0XhbapSQdGBo/2dKR1BYBTUVgOp0VsyvYZK+4kGAhuNfYZCyx2z+VJyfJzXYnbEBW8QPvrbtsbPXCaQlaxBv2XhFwZRn821zhmkcMc8Hh4YPBrrK3VXbqQlnw1AD4K+W9+/4cyFDblZxjfSpwsvpv1ynfeOq+Xy7szZm+wPhMwkVQ2XMf0AQeOUAE/4Lpkv9Zqq5P5tTUD10CUDMVJnksH+kTB+4Go+gWLdQftPOgMyW0osrdnK+QPntDcHsOfQ/5Y9E0tI2CUq2cYqINRXXUvKIz+haoXqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvgCX6eq0ZFh697Uqsq+/vA4OeuNksuWxE85Iu4IZys=;
 b=cw3C9Qn9wq0wuRknaJ3Nbn6iEtiSg5U4DVtSTsHk0IaPMU033j0UWqxobYsx6SODOnmNCCZfjVaFpG9gvL9kd08Gb5mUiXllFJz/Mcbx/t8YQ1Pm2KMT3VkRW4iQIVLom0xsIq4RSUOWURQ52i5YbseHUg5o+6Oz0llWswNEM1o=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB3200.namprd18.prod.outlook.com (10.255.86.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 6 Nov 2019 13:04:59 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::4c1d:fb1e:ea9c:6811]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::4c1d:fb1e:ea9c:6811%6]) with mapi id 15.20.2430.020; Wed, 6 Nov 2019
 13:04:58 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Ariel Elior <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "galpress@amazon.com" <galpress@amazon.com>,
        "yishaih@mellanox.com" <yishaih@mellanox.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH v12 rdma-next 0/8] RDMA/qedr: Use the doorbell overflow
 recovery mechanism for RDMA
Thread-Topic: [PATCH v12 rdma-next 0/8] RDMA/qedr: Use the doorbell overflow
 recovery mechanism for RDMA
Thread-Index: AQHVjwb1rgsQsF0GakGUgiE/9W9Jsqd9FNAAgADiK+A=
Date:   Wed, 6 Nov 2019 13:04:58 +0000
Message-ID: <MN2PR18MB318254AD4C7254E12BE970ECA1790@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20191030094417.16866-1-michal.kalderon@marvell.com>
 <20191105204144.GB19938@ziepe.ca>
In-Reply-To: <20191105204144.GB19938@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.203.130.254]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3d4e718-9ab1-4dd7-1e67-08d762b9ed8b
x-ms-traffictypediagnostic: MN2PR18MB3200:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB320081855E6B1AAEB13527C7A1790@MN2PR18MB3200.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1002;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(199004)(189003)(54906003)(66556008)(4326008)(66476007)(66946007)(6436002)(64756008)(76116006)(6916009)(25786009)(14454004)(5660300002)(3846002)(229853002)(6246003)(14444005)(7736002)(256004)(6116002)(966005)(305945005)(8676002)(102836004)(66066001)(81156014)(66446008)(26005)(81166006)(478600001)(446003)(99286004)(11346002)(52536014)(9686003)(486006)(476003)(33656002)(55016002)(316002)(86362001)(7696005)(2906002)(8936002)(6506007)(186003)(76176011)(6306002)(71190400001)(71200400001)(74316002)(19627235002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3200;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rRerGC3t+FfFtLS5dDwLYLSvfNkBuAvGK+3ahcF6OjIcKNDYigxg0zx0ku5Uc9I8YHrmLDcphCqlPMUozYnkCK2GjjTUdakmlrZFyT4o2UsFwTYnzhjKDWBalEALgDDBES9qKu1Lj0/AV5foiIHG+7e6XHduZjsDSov+JgneDnaGohtBNF+6s2i3cv4+iogeYmpgDmETkMLRFziRO4sGrr9vElCyRwCtmhuOvXj1GGNs2ZfEOFchEKzUhqhRkvELSV5B8l4SoU1T4T16DZdTqtZ0QS7pVuxdPIgUgdt1wQV8lg79KhR112UEaBQpiqPIwL5/gdUunPyAB8Dr4fLYuExPwzRwEOaDcrkX/0yJXPw8i3BM9uosDfu7DJNFkYo3domQmRFOo7sYRXJiItNOSCDQmLie8ADQb7r39xmHm0tpOECaq/m26t7cwMspqz0j9sZEQI3ztoj3redA8ZwI8dS0W81P2pzEx9mXqvex9SU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a3d4e718-9ab1-4dd7-1e67-08d762b9ed8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 13:04:58.8824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m6ZFF6bs29Lou/4ubGhvEa/BFmEn6o8Q6gCZH9CR+WKoshdWmGB9fbLIgJZIyVnFJD+tir1a9VPyZqi0n1cPWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3200
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-06_03:2019-11-06,2019-11-06 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> owner@vger.kernel.org> On Behalf Of Jason Gunthorpe
>=20
> On Wed, Oct 30, 2019 at 11:44:09AM +0200, Michal Kalderon wrote:
> > This patch series uses the doorbell overflow recovery mechanism
> > introduced in commit 36907cd5cd72 ("qed: Add doorbell overflow
> > recovery mechanism") for rdma ( RoCE and iWARP )
> >
> > The first six patches modify the core code to contain helper functions
> > for managing mmap_xa inserting, getting and freeing entries. The code
> > was based on the code from efa driver.
> > There is still an open discussion on whether we should take this even
> > further and make the entire mmap generic. Until a decision is made, I
> > only created the database API and modified the efa, qedr, siw driver
> > to use it. The functions are integrated with the umap mechanism.
> >
> > The doorbell recovery code is based on the common code.
> >
> > rdma-core pull request #493 was closed for now, once kernel series is
> > accepted will be reopend.
> >
> > This series applies over the wip/jgg-for-next branch and not the
> > for-next since it contains the series:
> > RDMA/qedr: Fix memory leaks and synchronization
> > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__www.spinics.net_l
> > ists_linux-
> 2Drdma_msg85242.html&d=3DDwIBAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3D7Y
> > unNpwaTtA-
> c31OjGDRljIVVAwuEHIfekR2HBOc7Ss&m=3DL5mJN0hgrbvf3DM5YqnWV_SP8x
> > T4w4-
> EglZvbLfNeac&s=3DvhHBEGZnBPmT8qnK6mkfWyDGgjuTscDayoTdsqEe4Sk&e=3D
> >
> > SIW driver was reviewed, tested and signed-off by Bernard Metzler.
>=20
> Since we are on v12 now, let us get this done. I added this diff to the s=
eries.
> Mostly just renaming, indenting, the notes I gave already (to all drivers=
) and
> probably a few other things I forgot
>=20
> Here is the series with everything reflowed hopefully properly:
>=20
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__github.com_jgunthorpe_linux_commits_rdma-
> 5Fmmap&d=3DDwIBAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3D7YunNpwaTtA-
> c31OjGDRljIVVAwuEHIfekR2HBOc7Ss&m=3DL5mJN0hgrbvf3DM5YqnWV_SP8xT
> 4w4-EglZvbLfNeac&s=3DMsa-
> ckgjuOMPVTodTsdmuiOIg88xQUn0zXYiXybrGv4&e=3D
>=20
> Please let me know if I messed it up, otherwise I'll apply this in a few =
days.
Thanks Jason. One small comment is that the length field was removed from s=
iw + efa=20
But not qedr_user_mmap_entry, I can also send a patch after to fix this.=20
And one small insignificant typo below

Other than that all fixes look good, thanks.
Tested-by: Michal Kalderon <michal.kalderon@marvell.com>


>=20
> Thanks,
> Jason
>=20
> diff --git a/drivers/infiniband/core/ib_core_uverbs.c
> b/drivers/infiniband/core/ib_core_uverbs.c
> index 88d9d47fb8adaa..6238842fd06402 100644
> --- a/drivers/infiniband/core/ib_core_uverbs.c
> +++ b/drivers/infiniband/core/ib_core_uverbs.c
> @@ -11,14 +11,14 @@
>=20
>  /**
> - * rdma_user_mmap_entry_insert() - Insert an entry to the mmap_xa.
> + * rdma_user_mmap_entry_insert() - Insert an entry to the mmap_xa
>   *
>   * @ucontext: associated user context.
>   * @entry: the entry to insert into the mmap_xa
>   * @length: length of the address that will be mmapped
>   *
>   * This function should be called by drivers that use the rdma_user_mmap
> - * interface for handling user mmapped addresses. The database is handle=
d
> in
> - * the core and helper functions are provided to insert entries into the
> - * database and extract entries when the user calls mmap with the given
> key.
> - * The function allocates a unique key that should be provided to user, =
the
> user
> - * will use the key to retrieve information such as address to
> - * be mapped and how.
> + * interface for implementing their mmap syscall A database of mmap
> + offsets is
> + * handled in the core and helper functions are provided to insert
> + entries
> + * into the database and extract entries when the user calls mmap with
> + the
> + * given offset.  The function allocates a unique page offset that
> + should be
> + * provided to user, the user will use the iffset to retrieve

Typo - should be offset
