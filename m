Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 956CE1428D8
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jan 2020 12:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgATLHu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Jan 2020 06:07:50 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:5738 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726148AbgATLHu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Jan 2020 06:07:50 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00KB5GPH003394;
        Mon, 20 Jan 2020 03:07:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=gRHfPX2f6CtePbD4NGl2OsXUe0luO9L/v26W34i8QCA=;
 b=DsO9pkLcVhs4Sh5uGzDCixrcJmVkT0rFBU9gr9IWJU80d1QZN5AFZkQqrBgnB8X6oRO/
 ajQme8hgubF9FcuV2vdm2cfldYR2ASxwyX79xjRvAoIflkGs+lQr/txVE37XYAXh0IjK
 /kznZiwlOGj5K7jBxFThZ7mNImcUvBmLirxItcWwEFM4URAlxC8B8bb1bd2ngW2a6XOt
 dZJCS57gCpQ8x+tT+cDM45XKPPQ9eQqlgXTkzfznG4hiqYmCiuPQMP9TMmcOWT+VkMV9
 JusF0P2wuRTSnMTTYl4rQwbOmV/bi/qTrxLznemPQ5Je8ehh9u7B6DdENy6VqJHJ54be qg== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2xm2dswpek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 20 Jan 2020 03:07:43 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 20 Jan
 2020 03:07:42 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 20 Jan 2020 03:07:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QgTQZu0EG0kCJXe79aZki0Fk321B6ABThsUceFKenBG727DI0rB7lFQYjSdq5AAUP++A/NrEEMIq8EfbpVSTpnH1v+Ng8hbNiq/wzQ/4Ibpiv/SHhmb+Cyzry5eKcOxXSk2G1qBFEojpgksa2mgv6fwu3g4aiRnhfol2xOwrPNaN1ANoEZQFQFBXgKazROeZBhxOhTM/HizUjx1DKrw/K7We4ezQsmD2oZ+GGTn/WS/Dc1dioT7klTJcvBeer5v5AJvYwG65/jGwBpjxWVdH3jNpF2BC7hqhNH9493HpbVCYKI0W2Vm8ccA1xCQXhRbOJKvBEu+tb3+uh043ED7fQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRHfPX2f6CtePbD4NGl2OsXUe0luO9L/v26W34i8QCA=;
 b=fMZczd5biI3lS3eyXUDpuPUllpVSEYCELWA6r7hV7ZXbSM9aSJVVQ69Qg0L9YCYneVq7PGcQHKcIr5u0LqS+MceMNw1OGU8zTE3VOBAPpPJqDtkfXNyY6Ctw2ib4Ku71sI8xvdE6jvvxkh3c2ejhfMe3KxQtHEk2o0ljyr+C5ClK5pp6Ai1IHD9iFz7d/zw176BwfZ2Le5c2ZA+1YkdV/N1Ym81dpINAXbjEkOA/jl9zaBADZkU0dtsTrVqzcvoZARKvbQjUx3opqQcSzlEZWPlqM73o18mWJPfqan2q17v909pSE0twULir6yvizH+AkcDnSo+0x8zsLSVHPAbUgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRHfPX2f6CtePbD4NGl2OsXUe0luO9L/v26W34i8QCA=;
 b=RKEmEpvzZju2Dqn0RydRgVae7C5bdUUOGWHe/7P2C8dzC+ufSQgkjj04hoHVb8nbRsGpRJXPdAiqEmqVOmNXUyhpDT0PbH1+MucNtlhCYsqxbVUvtVcx6ZlannLQQ8S3G8V39lC8glnSyUbcM6MrkSHgcVUrcqNWryqSFQdh22U=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB3168.namprd18.prod.outlook.com (10.255.236.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Mon, 20 Jan 2020 11:07:40 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::703e:1571:8bb7:5f8f]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::703e:1571:8bb7:5f8f%6]) with mapi id 15.20.2644.026; Mon, 20 Jan 2020
 11:07:40 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Jason Gunthorpe <jgg@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Gal Pressman <galpress@amazon.com>
Subject: RE: [PATCH] RDMA/core: Ensure that rdma_user_mmap_entry_remove() is a
 fence
Thread-Topic: [PATCH] RDMA/core: Ensure that rdma_user_mmap_entry_remove() is
 a fence
Thread-Index: AQHVy+FEjDSjACX4D0WvK+XBwBxvV6fza73g
Date:   Mon, 20 Jan 2020 11:07:40 +0000
Message-ID: <MN2PR18MB31826EE9F0DFAA06135BA80FA1320@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20200115202041.GA17199@ziepe.ca>
In-Reply-To: <20200115202041.GA17199@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [79.179.5.176]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b20fc6b4-fe5f-47e5-dd9a-08d79d98f75c
x-ms-traffictypediagnostic: MN2PR18MB3168:
x-microsoft-antispam-prvs: <MN2PR18MB316838AC52E6CE4E2248956CA1320@MN2PR18MB3168.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(199004)(189003)(316002)(86362001)(5660300002)(55016002)(110136005)(76116006)(8676002)(81156014)(66556008)(81166006)(66946007)(66446008)(64756008)(9686003)(8936002)(66476007)(2906002)(6506007)(478600001)(7696005)(26005)(71200400001)(33656002)(186003)(52536014);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3168;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CPpm3aNdoViC7djYIfi+SRGprSoLF4s3trmB3ScIQbRm4TCltTjTSemWdRRUSaIgeHqBswI76LvEspbnWp7/f6ZTXmvlV19uhc8bZZ7PSGbcOCcv+BGFVnQsjbxEC2lKNx/GeiZ4uBG+2D7xguhjqnVXoPA/DchU9Y5sm15gzxM0eNYxNdXYpn+aUNO0bGSIB/GI5WsD3qjgIgqmBYrYAto2FSdfbZAcPlWw9b+Yt/kX36JDWJDhKg83URIO4u/KWC9aho0UwVPVZAYcRon5Ypw3t2Ka9bASqiWJPS0Uq1Qvqt3IV+Op/QztFLXWdl3FHcemvVrAANSihgeWi5KgZ+xW/LMkuFT5EbYzChvQzTbXLkF3b2sRvYG06Y0K0uSTQz2ymrLb6HxVXc3X5MWOEaz/fu5Zm7KKxjxPQ/gXDQdozzfQwNGFzPgYCBdByHXW
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b20fc6b4-fe5f-47e5-dd9a-08d79d98f75c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 11:07:40.5653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iksn03gBqkTAXcP/Q4TNGX9ORlJdqnoTD65PAN9ZlUC+0+XHU+JBhx2U2aSSI+X2K3+B6Tp0ulBTQFXCBxXP4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3168
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-20_02:2020-01-20,2020-01-20 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> owner@vger.kernel.org> On Behalf Of Jason Gunthorpe
>=20
> The set of entry->driver_removed is missing locking, protect it with
> xa_lock() which is held by the only reader.
>=20
> Otherwise readers may continue to see driver_removed =3D false after
> rdma_user_mmap_entry_remove() returns and may continue to try and
> establish new mmaps.
>=20
> Fixes: 3411f9f01b76 ("RDMA/core: Create mmap database and cookie helper
> functions")
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  drivers/infiniband/core/ib_core_uverbs.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/infiniband/core/ib_core_uverbs.c
> b/drivers/infiniband/core/ib_core_uverbs.c
> index b7cb59844ece45..b51bd7087a881f 100644
> --- a/drivers/infiniband/core/ib_core_uverbs.c
> +++ b/drivers/infiniband/core/ib_core_uverbs.c
> @@ -232,7 +232,9 @@ void rdma_user_mmap_entry_remove(struct
> rdma_user_mmap_entry *entry)
>  	if (!entry)
>  		return;
>=20
> +	xa_lock(&entry->ucontext->mmap_xa);
>  	entry->driver_removed =3D true;
> +	xa_unlock(&entry->ucontext->mmap_xa);
>  	kref_put(&entry->ref, rdma_user_mmap_entry_free);  }
> EXPORT_SYMBOL(rdma_user_mmap_entry_remove);
> --

Thanks,=A0

Acked-by: Michal Kalderon=A0<michal.kalderon@marvell.com>


> 2.24.1
