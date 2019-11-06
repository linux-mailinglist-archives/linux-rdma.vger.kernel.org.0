Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F57FF1169
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2019 09:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbfKFIs2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Nov 2019 03:48:28 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:19696 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730178AbfKFIs2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 Nov 2019 03:48:28 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA68fDvA026650;
        Wed, 6 Nov 2019 00:48:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=QUux3aZjTvh7MiCitro9ymouCd2ox6kfTzCqd5dDmDU=;
 b=TxDNCM9LWf52zzGSP443pEcpF7ajeW0VGraLRuRXR8SLR0VHR9zqG/CFylnNrtAJmEX4
 cSY46ux+TAerrTGd8QiEicLKRgQiG1DVtM8nTzFplLChhILeUpriDuXsHJIGAChi7KL7
 9mAjRF3QTMSZOsBftKcjjp44StS0JqLe9qwx2jd0H845UkzPvMn/8R8H1e2vS2nYg6tc
 lNAHfvY/Em1NdjDMwuLDPbuaIAboeDsYrLFAKYUcgyMtYh5bQtlhDLTofS2UhogjZ5a3
 0XeXUw+yoi1AS4Ci6mGMvKnppvw3qDYeInxjCHOsBgbx14kdB3TEtSdYV4RQIwkbm6KR UA== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2w19amy5m3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 06 Nov 2019 00:48:20 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 6 Nov
 2019 00:48:19 -0800
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.55) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 6 Nov 2019 00:48:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFxdRRfn5MYJI6GuGJ1FUvQWQA6K0NrpAg+icohfq1P7dLI0I9wPXbh6cDZxntCFWEkP2fT1eXeRrgK3X8ODB8T5aXjEqZMOOw6zCzqa30CJFHuYmFu+iMTPmVWKktc6eQLgAFJknhX6IwnfMhzyrUJcgFy0D0xb0sy7CO8SyCtvleLeh2aj5bmQ5hiTtpcLmALGms6uOJqcPj6NMaxv1r8oXsn1dTxgdeb40hByL4NgOkZm7rfoOkZgnEZsGzciNIZvRWkUW5hmoSkqjd+j3k0EtIRa6pB7aYz+NSeSXMz0RgXV5MO3kF53n3L9lynOQKSunD2iOc3XZFMVIbsyow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUux3aZjTvh7MiCitro9ymouCd2ox6kfTzCqd5dDmDU=;
 b=Ullvpb0nXKyfH96o3C4WXeVVXQdDpy+DILUEMrlVYtHRKO9zH7wIwEZcpeunIKB9MWOBMEdYLc1pVJzgn8gEfXRC1N2iXlALfM46LjLG5hXxJM+EnAaqHUiWL3UDjPf5oh3cxSDV32XS742nyQfCVeA6m+HPF3iMCnIJ2g96yRnp1NXeawy+HbVuvZoT6m/hhGV+nGhzZsOzfE5twHw7aAc7jMzAxITK89JY0KhzwOfAZmUkEtbS4LudXLahvJcIsnhE5cUZuKJBDCqeY3bO5L02H7dHIOXyF7P8gZsJWxcsKJEkGRqRzCHGfsH2asEjFaggnBZ749/Bnohbo0ZSlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUux3aZjTvh7MiCitro9ymouCd2ox6kfTzCqd5dDmDU=;
 b=Kp90Awnu/EOtR7NWsA1Fpge2wf+88aZPDs8yjPIWR3RUexd+K+D6Zc4vow7FzS/e8k8LqfARKJYTzi62S8c1f4aWz6NECBAxeoBDRWookpAnzzdJl+tPg+azeAgzI+e/EAPPsFhJX/zgs34h0CtndVbbUjmK45a76a4xSigMwD8=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB2750.namprd18.prod.outlook.com (20.179.22.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 6 Nov 2019 08:48:16 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::4c1d:fb1e:ea9c:6811]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::4c1d:fb1e:ea9c:6811%6]) with mapi id 15.20.2430.020; Wed, 6 Nov 2019
 08:48:16 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Pan Bian <bianpan2016@163.com>, Ariel Elior <aelior@marvell.com>,
        "Doug Ledford" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] [PATCH] RDMA/qedr: fix potential use after free
Thread-Topic: [EXT] [PATCH] RDMA/qedr: fix potential use after free
Thread-Index: AQHVlGrc8KRGJaR2/USW+t2m4Syntad91POg
Date:   Wed, 6 Nov 2019 08:48:16 +0000
Message-ID: <MN2PR18MB3182E3D4E7FD120FA1F6248BA1790@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <1573021434-18768-1-git-send-email-bianpan2016@163.com>
In-Reply-To: <1573021434-18768-1-git-send-email-bianpan2016@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.203.130.254]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b95c09ae-c6f7-4bf8-3efa-08d76296110c
x-ms-traffictypediagnostic: MN2PR18MB2750:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB2750A2B289F509029754A332A1790@MN2PR18MB2750.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:569;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(199004)(189003)(74316002)(3846002)(6116002)(476003)(14444005)(305945005)(7696005)(2906002)(256004)(7736002)(71190400001)(71200400001)(4326008)(66066001)(4744005)(99286004)(486006)(102836004)(6506007)(33656002)(54906003)(76176011)(110136005)(316002)(76116006)(52536014)(446003)(26005)(229853002)(55016002)(8676002)(9686003)(6436002)(86362001)(14454004)(66556008)(66946007)(66446008)(64756008)(66476007)(478600001)(25786009)(81166006)(81156014)(6246003)(11346002)(5660300002)(8936002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2750;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nqa+zeIrEenzcYr0dCCGRFb/AfhqC6jX/44nGTsuEh3Tt0rJrOHxG6gw1YmzhEQYhyEbOY/iyX+TZKNiJJ5FCf+bxI3KjYz8ii0g8ezAPByd0J9fs7E0HGxTbtLN7/zaV5v1NSM8Wv6fDi+RLzn0n27wZVfqVxm3yYKCOO9qZ5ElJ4IlXsd6S85doPmF2Ufv/2xxBKKbXQbHiHg3Xt5rVhGbpzsJHpiLARR69gILigFttC8P84BrIqoT6Q7xto4LImlx2We3OLrvhbIpyJ175EJCQw/j4XqwprtishlQLw34c4Nz2tNteVHipmGVG0xTELrs73yRUORgNOdTeU5kJ9snR2qmhhfnwGwkYXIxJf1Gyf1DKlUv3ia7F4t1Ae3ceVwvBlK3yDqfCYjlITi244mJRadVTHRvEKzHo68LUT+lnwb7TVZZ456pBtsm2cKz
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b95c09ae-c6f7-4bf8-3efa-08d76296110c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 08:48:16.4847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KRaY2yRu8rk1qZPbagvOO4b2lgt01MkngFz0CthV5mHyVPkxRJ3cFIpwKTy8x2alF1JAce77kqRvy6QLeTt7zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2750
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-06_02:2019-11-05,2019-11-06 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: Pan Bian <bianpan2016@163.com>
> Sent: Wednesday, November 6, 2019 8:24 AM
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> Move the release operation after error log to avoid possible use after fr=
ee.
>=20
> Signed-off-by: Pan Bian <bianpan2016@163.com>
> ---
>  drivers/infiniband/hw/qedr/qedr_iw_cm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/hw/qedr/qedr_iw_cm.c
> b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
> index 22881d4442b9..eedc32b72ff2 100644
> --- a/drivers/infiniband/hw/qedr/qedr_iw_cm.c
> +++ b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
> @@ -451,10 +451,10 @@ qedr_addr6_resolve(struct qedr_dev *dev,
>=20
>  	if ((!dst) || dst->error) {
>  		if (dst) {
> -			dst_release(dst);
>  			DP_ERR(dev,
>  			       "ip6_route_output returned dst->error =3D %d\n",
>  			       dst->error);
> +			dst_release(dst);
>  		}
>  		return -EINVAL;
>  	}
> --
> 2.7.4

Thanks,=A0

Acked-by: Michal Kalderon=A0<michal.kalderon@marvell.com>


