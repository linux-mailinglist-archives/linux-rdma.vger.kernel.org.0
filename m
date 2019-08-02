Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46D6D800F0
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Aug 2019 21:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405685AbfHBT1s (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Aug 2019 15:27:48 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:53116 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405639AbfHBT1r (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Aug 2019 15:27:47 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x72JPKV6022932;
        Fri, 2 Aug 2019 12:26:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=3+VPDPGxXdASuWkGaidBpDGpxHq6suVTu69yPSENuDs=;
 b=COXw61xj3w4RSGPgnEfZqYtdebQykTDu0LNNrV0Ra+UAxx91g6yB4K4Ho3+If/hNKkAL
 71xT98NFvuT29Ay8orwDxWXY3V7mYQJB0B9B4XmJebhAoYVeErAye4elOgLnhqV3XHUx
 PpA01hX/FXXXlY1BjgUc1A7x5Q/uwKcRilKI1UMR4qiWKLNC4frKj1t1zDwbzweVWuX2
 fq5hf+rUXJtcSmHVLYLkcA8Mlw3chAS0d4V1Uay4pmX558HA3wjEYT1u1nY8pIFI4KyY
 8h1gQNUgClPAvYy4Mtez0mVogA7Z9Q2Pi9zVEbhba5RhcAALry/+bszJOzlkmRJcjSfv fg== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2u3jujsjnv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 02 Aug 2019 12:26:55 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 2 Aug
 2019 12:26:54 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.55) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 2 Aug 2019 12:26:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jSsudDzmVbwoTKK8BgHW+IlSkFlWW77xjP7nNNClSMq3qVjzYoc6l8OtU11cE6O/lba01f3rICxk9hkjXPxPXnT0Z5whEdhl9XqNK6HKJzwiU6j26/RtQity3RcXeDkCQ6XHGDfn94AdpcX6z18lQ1lCco078IbWNXD7z800SD8oc6eKvLdwweQ1wEm5Tf3zNr0vVa0+GdkU6cuFfGekpoYYvzua2MjRJtZLZ1I3CPWZSdbzjRSHKg9dg8T31daQyPOMxl2PBeQSvgm1FHt9qvJQDjI2Tw3o+nCp5gNpstOHZ2aN2ThbHdJ0n8P9gktOHgfSRAOGfBiAYJiClBawNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+VPDPGxXdASuWkGaidBpDGpxHq6suVTu69yPSENuDs=;
 b=cZKCgQrzcVHQxbLx1OlDYZZ3cdtPzM7+nLsqfWGaGuyhZC/yaWiL/J4fgnunQ4ViQGFJ8aL0DPXSfd4lTDS535D6dv3L5KkPwAlgyzpyWtalj1mW+d0Xp8RJe4HYFB5Ky2yO60AsDHi55ML8ZKTRO6njg8ByUdyu8ZlgbBbFyWfrH47RTq0puVC96AOO42qkX8wAwdupPARldngJjxKioYtpVsaraYH58Ytwy31lA9wE3Ge7v6N4lV+l3/kl2RNroW3Ew7PqjrUNUmCkC9kkUqKJCypM9wq3dat8owbd4j1PgcF/iz93qhb6nmbgYq/wur5gNULrx3bDpWSoGeLwcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=marvell.com;dmarc=pass action=none
 header.from=marvell.com;dkim=pass header.d=marvell.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+VPDPGxXdASuWkGaidBpDGpxHq6suVTu69yPSENuDs=;
 b=OcdlEYssbZLyV3wuTgG0vePhHHJkdnU1UKWhmGCmi79LXb3TRXSsbqVxkv8o/YKkM2+Qc5jKVL9vkioXfLY5GVPYQWqjQAtNBvbrpSKIPmP0wzpIR6j6ySqkoI3g73EIaXfyjIY3JDMBsKgFGzVI3j9I2l5E+vFO+yN0ooY6Vxc=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB2750.namprd18.prod.outlook.com (20.179.20.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.15; Fri, 2 Aug 2019 19:26:49 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::f001:1b96:3396:1781]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::f001:1b96:3396:1781%5]) with mapi id 15.20.2136.010; Fri, 2 Aug 2019
 19:26:49 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Kamal Heib <kamalheib1@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Gal Pressman <galpress@amazon.com>,
        "Leon Romanovsky" <leon@kernel.org>,
        Christian Benvenuti <benve@cisco.com>,
        "Moni Shoua" <monis@mellanox.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        "Shiraz Saleem" <shiraz.saleem@intel.com>,
        Andrew Boyer <aboyer@tobark.org>
Subject: RE: [EXT] [PATCH for-next V3 1/4] RDMA: Introduce ib_port_phys_state
 enum
Thread-Topic: [EXT] [PATCH for-next V3 1/4] RDMA: Introduce ib_port_phys_state
 enum
Thread-Index: AQHVSRU8oFLLrM+83kSR8+yG4CCNV6boPcew
Date:   Fri, 2 Aug 2019 19:26:48 +0000
Message-ID: <MN2PR18MB318238EB4B6DB193BAED2FA1A1D90@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20190802093210.5705-1-kamalheib1@gmail.com>
 <20190802093210.5705-2-kamalheib1@gmail.com>
In-Reply-To: <20190802093210.5705-2-kamalheib1@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [79.183.34.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59009934-8f92-4735-1c50-08d7177f5d5b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2750;
x-ms-traffictypediagnostic: MN2PR18MB2750:
x-microsoft-antispam-prvs: <MN2PR18MB2750CF52C9058BE2731A930CA1D90@MN2PR18MB2750.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:494;
x-forefront-prvs: 011787B9DD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(199004)(189003)(9686003)(5660300002)(2501003)(110136005)(54906003)(52536014)(486006)(6436002)(476003)(102836004)(6246003)(11346002)(68736007)(186003)(53936002)(86362001)(4326008)(55016002)(66066001)(26005)(478600001)(446003)(66446008)(3846002)(76176011)(14454004)(6116002)(81156014)(229853002)(8676002)(6506007)(8936002)(74316002)(81166006)(7416002)(7736002)(7696005)(71200400001)(71190400001)(25786009)(316002)(2906002)(256004)(14444005)(99286004)(66476007)(76116006)(305945005)(33656002)(64756008)(66556008)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2750;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Wsqf83fXt1ljIm5Vrftyp2huw1iN44b2U+9hrQoW5IpKOFqc1dO9WxJamsHYC4x4deWu4xeLG32V5G6CC5uPyKkCmmA9b+UMdj5yfu4jfFgXDC/hKG/cZkMu90Kapy9Lc2KSgoMGlZlzYk7B/7XXeeZ6PTP+gDwlXHcoVbmS6HN7d28tNm1jql8dE5b7Rt7Llje3ar342c58Tg5L56oC9flWqg3FKQESsUrO9H/nrQnkWA0B5HDlEsBlmUvaISXKdT6JIc+Us0rU/OMqCKDu5ktL4QV6jyV5m6jWLYc2zebeJS8MjfRs8Kc8zgj3N+8voN8LPswjF2OrOb/ogs5yqc31F4JS9ib7mWepG4zwj8ixSdY2OZ6D3RQmVMbUibt8iIJcCc7Q9rAd4R0yzA3nqP00FI46abFZl+mwkx0TBB8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 59009934-8f92-4735-1c50-08d7177f5d5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2019 19:26:48.9362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mkalderon@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2750
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-02_08:2019-07-31,2019-08-02 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: Kamal Heib <kamalheib1@gmail.com>
> Sent: Friday, August 2, 2019 12:32 PM
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> In order to improve readability, add ib_port_phys_state enum to replace t=
he
> use of magic numbers.
>=20
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> Reviewed-by: Andrew Boyer <aboyer@tobark.org>
> ---
>  drivers/infiniband/core/sysfs.c              | 24 +++++++++++++-------
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c     |  4 ++--
>  drivers/infiniband/hw/efa/efa_verbs.c        |  2 +-
>  drivers/infiniband/hw/hns/hns_roce_device.h  | 10 --------
>  drivers/infiniband/hw/hns/hns_roce_main.c    |  3 ++-
>  drivers/infiniband/hw/mlx4/main.c            |  3 ++-
>  drivers/infiniband/hw/mlx5/main.c            |  4 ++--
>  drivers/infiniband/hw/ocrdma/ocrdma_verbs.c  |  4 ++--
>  drivers/infiniband/hw/qedr/verbs.c           |  4 ++--
>  drivers/infiniband/hw/usnic/usnic_ib_verbs.c |  7 +++---
>  drivers/infiniband/sw/rxe/rxe.h              |  4 ----
>  drivers/infiniband/sw/rxe/rxe_param.h        |  2 +-
>  drivers/infiniband/sw/rxe/rxe_verbs.c        |  6 ++---
>  drivers/infiniband/sw/siw/siw_verbs.c        |  3 ++-
>  include/rdma/ib_verbs.h                      | 10 ++++++++
>  15 files changed, 49 insertions(+), 41 deletions(-)
>=20
> a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
> index 0c6a4bc848f5..6f3ce86019b7 100644
> --- a/drivers/infiniband/hw/qedr/verbs.c
> +++ b/drivers/infiniband/hw/qedr/verbs.c
> @@ -221,10 +221,10 @@ int qedr_query_port(struct ib_device *ibdev, u8
> port, struct ib_port_attr *attr)
>  	/* *attr being zeroed by the caller, avoid zeroing it here */
>  	if (rdma_port->port_state =3D=3D QED_RDMA_PORT_UP) {
>  		attr->state =3D IB_PORT_ACTIVE;
> -		attr->phys_state =3D 5;
> +		attr->phys_state =3D IB_PORT_PHYS_STATE_LINK_UP;
>  	} else {
>  		attr->state =3D IB_PORT_DOWN;
> -		attr->phys_state =3D 3;
> +		attr->phys_state =3D IB_PORT_PHYS_STATE_DISABLED;
>  	}
>  	attr->max_mtu =3D IB_MTU_4096;
>  	attr->active_mtu =3D iboe_get_mtu(dev->ndev->mtu); diff --git

Thanks,=A0
For qedr changes
Acked-by: Michal Kalderon=A0<michal.kalderon@marvell.com>


