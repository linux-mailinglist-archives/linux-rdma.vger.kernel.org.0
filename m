Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94E19F68F5
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Nov 2019 13:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbfKJMiT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 10 Nov 2019 07:38:19 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:34962 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726301AbfKJMiT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 10 Nov 2019 07:38:19 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAACZtwS014095;
        Sun, 10 Nov 2019 04:38:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=mEM91B3a6dAGjZ5jjTP23u4Y+UBLd4hba/IJb7h52VI=;
 b=ZP+osSmo9OkhfZoa+hIzaFsZS+7iUdPC/c9Qfss9XcB0W6NWGCjhRXKjzPLilmVy3zLk
 C+A7AybRUgcCbSeDJ8ycbqGVQARH3KmemSafOFkB61ZqZtP+GFPYjr1Iu8Tqq8Tw6SRv
 DHLKLjCYYnnr+jyNpmZ8qOcQ80DMXGcbJ1CYmpRyNbtag6MjPizednXw3kPfdbNJ2xCu
 yIdbbrTRembr7YK57dgARR8q8XvuBEq3KURUKYifRRKTKNlPfsSAMqQ97FQCvIHYVji+
 s3EYOyApAQi2eNKY6iNY8iVEp7rHr+fP0tJGO10Px3K+Ae2sbinL5qN+U616I2VOO936 6Q== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2w5wurjsfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 10 Nov 2019 04:38:14 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Sun, 10 Nov
 2019 04:38:13 -0800
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (104.47.32.59) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sun, 10 Nov 2019 04:38:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6pDDyPmxItYKfD2W+hSqmklCgwFnxUGx+GO6JXP53w/QLns15M+bD5lX6JIxzWB4pSVu0Kbcq+gm7gvQLtk4SGy9rFFNvnSflf6xy8v+kTdbdRr2L0IFITW0L25K3iQmTzLkeKivDd9+dHIoKIXgiZq4WtiqF0AecopJ95TQK/riRbBQRgOAe7UM22mezAY31tyJISr5ZGGlQI7VHD+HOAtHPH8bNj5L5aHgsDZI9N0ETiaUGqE6IOm/LLnWiYNwgNH0IrUEuxKJ5U3TEqyxTDGfn02s4ybN4rVx+NRlMU+Yoqgazh81fIU1CUn5AkqxgoYaz8QPZaxBIeGLJUATA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEM91B3a6dAGjZ5jjTP23u4Y+UBLd4hba/IJb7h52VI=;
 b=l3o+GbSrEZ7s1d79eeDhBfx/ogc+dG3ZqqWJhduBWGipKxVbzF9LhKrRC47GQ28pnkS35NF2y36KGyoNnCXkuHh7i0Z01EvmpaqBtxMlDEbXw8V9ETib8Hp1pu7OtknM1Z2PglYXRgwpQgRaWE729NQUWq29OPRiLrQMENnpvGpZjEFr8MA0GTS+8cx3n9L7PE6DFTdXYJJoc4IUoV8DWlTztf7lCFWLwkTrYipjaFJi+B2Uvl/A+UkzgStESgEPvaVQzPst3lAdNN39nUFQf+G21+dR6e37An45+A74hzxpPTwxejfNp4iQdLkuVIt7zopPC4BfL+zwbnHNB/FOzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEM91B3a6dAGjZ5jjTP23u4Y+UBLd4hba/IJb7h52VI=;
 b=FSti1RKZ4oF+duW3l+v8NHZogTTmLjR/UIoPdifIj4e48013lvY6kJmTnBiBV+cl2UL1uHMK35K4MW37jgBQthqjMDHywlkIA6MjprowRLO/V4sJ21pJXqM0DyVLncAOfpCrjRqU0D3jyWsE+3OotQpRfmQ0u+QE09nolOWKzsY=
Received: from CH2PR18MB3175.namprd18.prod.outlook.com (10.255.155.216) by
 CH2PR18MB3112.namprd18.prod.outlook.com (52.132.246.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Sun, 10 Nov 2019 12:38:11 +0000
Received: from CH2PR18MB3175.namprd18.prod.outlook.com
 ([fe80::9121:d829:65e1:b766]) by CH2PR18MB3175.namprd18.prod.outlook.com
 ([fe80::9121:d829:65e1:b766%3]) with mapi id 15.20.2430.023; Sun, 10 Nov 2019
 12:38:11 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Kamal Heib <kamalheib1@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: RE: [PATCH for-next] RDMA/qedr: Make qedr_iw_load_qp() static
Thread-Topic: [PATCH for-next] RDMA/qedr: Make qedr_iw_load_qp() static
Thread-Index: AQHVl7svyKUooB1QiEuWJaHiauRzq6eEV9yg
Date:   Sun, 10 Nov 2019 12:38:11 +0000
Message-ID: <CH2PR18MB317554BE34CDEE83C90B5B4EA1750@CH2PR18MB3175.namprd18.prod.outlook.com>
References: <20191110113645.20058-1-kamalheib1@gmail.com>
In-Reply-To: <20191110113645.20058-1-kamalheib1@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [212.199.69.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b707d468-c744-4e2e-e4d1-08d765dad935
x-ms-traffictypediagnostic: CH2PR18MB3112:
x-microsoft-antispam-prvs: <CH2PR18MB3112656985C5ECA69650854FA1750@CH2PR18MB3112.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-forefront-prvs: 02176E2458
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39850400004)(366004)(376002)(346002)(396003)(136003)(199004)(189003)(110136005)(316002)(478600001)(7736002)(229853002)(305945005)(74316002)(8936002)(14454004)(8676002)(4744005)(2906002)(52536014)(54906003)(3846002)(6116002)(5660300002)(81166006)(81156014)(99286004)(25786009)(2501003)(86362001)(76176011)(446003)(4326008)(26005)(11346002)(6506007)(33656002)(6436002)(7696005)(14444005)(66556008)(76116006)(476003)(66066001)(9686003)(55016002)(71190400001)(71200400001)(186003)(102836004)(66946007)(66476007)(486006)(64756008)(6246003)(66446008)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR18MB3112;H:CH2PR18MB3175.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s7xgfHDE+/HQm23r/uV9pIPqVYkpJU3Eo/7oA1T+iGflRIY1XZmS8BLQJBDRw6Jz59WDO6BWJyEX9m6mcumuMUys8kFWn0WEFAxH8OGZhNKOmRf9pAmON1shT3KV0lAbGVFK/1lKyjjMXLuqweb8xxBAxpLdp/tyDECZIUY7pQEEfsfzfLEH5zMrNcL4mYfAsIpa9YETxL2UPFX7hFHHq33J4/O3IawMCTg6Ck73KMgGIm8di8PPlPe5Bcsn2XUEXHlQf+bCPsC6Ys1rpwYa8R+bVFPL9/Ykquel+nG92vN3GVL6pL3hXwhVUFo56bIXR/HgLpQq5DULn9nZ64AjB6OQlG2h3NWdd4C4Z670dm5DvwfXh5Fp/51EhWT6jtovOB8JQidnzEBWqfhrN312QijXeaknptcGqJmHYraj9nRsGYZ2god3DDmnUsl4udxa
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b707d468-c744-4e2e-e4d1-08d765dad935
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2019 12:38:11.6089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eSFETv1epNO+54ZSKDJBFchqhcN2AXU4X0mlhjJ9deycjl88yttT1jEYbgFFbapt8dhRYzKDOS/1EJZugpHk0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR18MB3112
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-10_02:2019-11-08,2019-11-10 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> owner@vger.kernel.org> On Behalf Of Kamal Heib
>=20
> The function qedr_iw_load_qp() is only used in qedr_iw_cm.c
>=20
> Fixes: 82af6d19d8d9 ("RDMA/qedr: Fix synchronization methods and
> memory leaks in qedr")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/hw/qedr/qedr_iw_cm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/hw/qedr/qedr_iw_cm.c
> b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
> index 5e9732990be5..a98002018f0c 100644
> --- a/drivers/infiniband/hw/qedr/qedr_iw_cm.c
> +++ b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
> @@ -506,7 +506,7 @@ qedr_addr6_resolve(struct qedr_dev *dev,
>  	return rc;
>  }
>=20
> -struct qedr_qp *qedr_iw_load_qp(struct qedr_dev *dev, u32 qpn)
> +static struct qedr_qp *qedr_iw_load_qp(struct qedr_dev *dev, u32 qpn)
>  {
>  	struct qedr_qp *qp;
>=20
> --
> 2.21.0

Thanks,=A0

Acked-by: Michal Kalderon=A0<michal.kalderon@marvell.com>


