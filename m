Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4C3DCFB2
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Oct 2019 22:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440380AbfJRUBG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Oct 2019 16:01:06 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:24004 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2440361AbfJRUBG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 18 Oct 2019 16:01:06 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9IJugA6026233;
        Fri, 18 Oct 2019 13:00:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=hoZnV76+VBjHaDTg+ut+fH5WPBHp35bKPncNuzATJIg=;
 b=SYBcUNcoo9WG2ZNRloVAO0gVWcO8GVbefCCU8ihADUWWhAFXYk5cPydMqpvTJ3nB/OpV
 AWy7zJso1cJvlWIMDgZWNyKp6m5a10bzhbWF0U+F3d+l8J+G9FJlYw/P067dzmF0Q1ZP
 iL6WeFVDV2cGoEhENya4Znnd7HmsTMSedcNfYvEafR8tOLwb4B8qwCGjuAw7ojD0ROiw
 UpNqzKaFOwHtk4nuX4L7u1RK5L20bQN2xtY7I1dYkuMPqgd56UwAyV0T9vBirSdgCnYZ
 /MkuKS/12jabzfwOrObvZ6H9Q9NxMZ52zTPUIoR0dEjBp+GdFPuUR5aOdqr6QGkc7CcJ qQ== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2vpurkd7vh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 18 Oct 2019 13:00:58 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 18 Oct
 2019 13:00:57 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.57) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 18 Oct 2019 13:00:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6K1nECwN9HbkNaSNPBI1eKGipPwWn4K1zLCs9Hj764x3+vZZjTQg+U8Xmti1VviOVO4RO6KSa12aLo9Zjambb+OCHcSmp8CqGgdsFDgTcHiWY/AT5W7HYMoUghAY1cSjoQ4+U8CT3ZgaSDetLIVhgYYA8outrhURgTEa3OzziiFS23QWGHjyTGheF8RKGo9PkvRDupatf2BIAlausNBuI3/sn6qtn+3UoyjldWyHcqqXAz0JsOnqxFqaCzuGw2XDSyTkuf2p3fLtmqJffaIogWP1zNkALKvj0hEpVfTHYU4f8+cr1ZDp4ef/QYXpArrpnRyBu8xKIWMCgwnywZloQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hoZnV76+VBjHaDTg+ut+fH5WPBHp35bKPncNuzATJIg=;
 b=YVvE1er7vm06eQPx0cVLV6Ua/QBZAqeDX30JJr+CK4aU8fQVSLHtA7vTiSuw401CV3TXDZ0cP7sEpzr3oeN2DxreZxO/FxZIoww5TrFB/lR8i+5DyT6uUBjyYmA+CMerGvoJZYaxrL8/wpoSFm7Q+wD2RP8sCMCOIL2g9BdQrb/wa8WHMxDJl2Bu2DXuCWuTGZ+0XO0/bBjq3KGpgJcEqsEbqPlH4KhvTKI0Drgu3soaNgnSBJXbiV5WN28aJpjkjGEZZ+gyjq3Y/QGJNRkLzCG3KOo4ja45dy8IZBEsAVxGY2DfADyjqQrfjRyqtGpSlGBpfeo1xgW9KBOeXc3+kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hoZnV76+VBjHaDTg+ut+fH5WPBHp35bKPncNuzATJIg=;
 b=kyI0KMqwydCgOj+nO9wD6q4+lda5/AOugT08E+bIG6D6r7yYOn3LJdtDhSKihOrIgb1N+XAingucAneIBz2p55yffNHljbGRvAbJqSJxMCjLa3bPa441Vm4vifQmcgB9Boq3rv3jGDQhrRqxcXfi9ZkCJUh6lf4RsCmbxgAVEf4=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB3392.namprd18.prod.outlook.com (10.255.239.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.20; Fri, 18 Oct 2019 20:00:56 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::4c1d:fb1e:ea9c:6811]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::4c1d:fb1e:ea9c:6811%6]) with mapi id 15.20.2347.024; Fri, 18 Oct 2019
 20:00:56 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Kamal Heib <kamalheib1@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Lijun Ou" <oulijun@huawei.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: RE: [PATCH for-next v3 4/4] RDMA/qedr: Remove unsupported modify_port
 callback
Thread-Topic: [PATCH for-next v3 4/4] RDMA/qedr: Remove unsupported
 modify_port callback
Thread-Index: AQHVhZhArAlsfSlXSUqarNYKwXc0vKdg0i0w
Date:   Fri, 18 Oct 2019 20:00:56 +0000
Message-ID: <MN2PR18MB3182671F7584235379B4FD24A16C0@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20191018094115.13167-1-kamalheib1@gmail.com>
 <20191018094115.13167-5-kamalheib1@gmail.com>
In-Reply-To: <20191018094115.13167-5-kamalheib1@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [79.178.84.141]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44cfadfa-3c6b-4ebc-550e-08d75405e359
x-ms-traffictypediagnostic: MN2PR18MB3392:
x-microsoft-antispam-prvs: <MN2PR18MB3392E6772079A7F4923C4E17A16C0@MN2PR18MB3392.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 01949FE337
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(39850400004)(396003)(376002)(136003)(189003)(199004)(4326008)(486006)(6116002)(66066001)(6506007)(110136005)(3846002)(102836004)(25786009)(14454004)(11346002)(476003)(26005)(33656002)(316002)(478600001)(81156014)(81166006)(8676002)(446003)(186003)(54906003)(8936002)(229853002)(66476007)(66556008)(64756008)(66946007)(66446008)(256004)(2501003)(6436002)(7736002)(5660300002)(9686003)(55016002)(52536014)(2906002)(86362001)(99286004)(76116006)(71190400001)(6246003)(76176011)(305945005)(74316002)(71200400001)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3392;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mc/sB78DvLwCidzxfB8JOe3G1VKtH60uTFfGk0nC/sE2SJTw2Wn5zItqA4tXQCHP/uJRaJKl09Z5AqRKnacOo9rFbv35yDkYPxt+SvhSoCWniLjhvEIf/I9jvhDbvXIoP9T/W4RKJvIarFFC33e6be1l/sqdes7V+SBv18V9dy54xZgXzgrUbI+kNX0yUbBOXNl3wV+TjlLnAw+lIHjVovktXxF3GZUl3wmhE3bmLno5MohzKkV3sdJht9uGx9Cigoup/tz+/qBE22QQdAusg57LP9V/Y2SXB+2mSQ+oIteNSuSbqFGqostRPvg4Y7JiLkjQ1Djs6b1l4FeABVI2+WpZAlDKjrR5DXU56DtOF5Zb8t/FDynlfuJ2oI1okjLJW774W7Dx7VVb2qtLra1bFgthGyANqZDRub1GPp81lfSiFogemhxicfWTBXQsFKj4
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 44cfadfa-3c6b-4ebc-550e-08d75405e359
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2019 20:00:56.0887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hkJqTX794OwpFZrUk/hJ/JXTRNfH+JSgeAuEJpM5GuyOwjLtq1jZ3Q+TiHEkYmHv6pgl+PNUr9Jym2JYlkNdFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3392
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-18_05:2019-10-18,2019-10-18 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> owner@vger.kernel.org> On Behalf Of Kamal Heib
>=20
> There is no need to return always zero for function which is not supporte=
d.
>=20
> Fixes: ac1b36e55a51 ("qedr: Add support for user context verbs")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/hw/qedr/main.c  | 1 -
> drivers/infiniband/hw/qedr/verbs.c | 6 ------
> drivers/infiniband/hw/qedr/verbs.h | 2 --
>  3 files changed, 9 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/qedr/main.c
> b/drivers/infiniband/hw/qedr/main.c
> index 5136b835e1ba..e5f36adb0120 100644
> --- a/drivers/infiniband/hw/qedr/main.c
> +++ b/drivers/infiniband/hw/qedr/main.c
> @@ -212,7 +212,6 @@ static const struct ib_device_ops qedr_dev_ops =3D {
>  	.get_link_layer =3D qedr_link_layer,
>  	.map_mr_sg =3D qedr_map_mr_sg,
>  	.mmap =3D qedr_mmap,
> -	.modify_port =3D qedr_modify_port,
>  	.modify_qp =3D qedr_modify_qp,
>  	.modify_srq =3D qedr_modify_srq,
>  	.poll_cq =3D qedr_poll_cq,
> diff --git a/drivers/infiniband/hw/qedr/verbs.c
> b/drivers/infiniband/hw/qedr/verbs.c
> index 6f3ce86019b7..fee02ac47f32 100644
> --- a/drivers/infiniband/hw/qedr/verbs.c
> +++ b/drivers/infiniband/hw/qedr/verbs.c
> @@ -250,12 +250,6 @@ int qedr_query_port(struct ib_device *ibdev, u8
> port, struct ib_port_attr *attr)
>  	return 0;
>  }
>=20
> -int qedr_modify_port(struct ib_device *ibdev, u8 port, int mask,
> -		     struct ib_port_modify *props)
> -{
> -	return 0;
> -}
> -
>  static int qedr_add_mmap(struct qedr_ucontext *uctx, u64 phy_addr,
>  			 unsigned long len)
>  {
> diff --git a/drivers/infiniband/hw/qedr/verbs.h
> b/drivers/infiniband/hw/qedr/verbs.h
> index 9aaa90283d6e..d81b81f86f0a 100644
> --- a/drivers/infiniband/hw/qedr/verbs.h
> +++ b/drivers/infiniband/hw/qedr/verbs.h
> @@ -35,8 +35,6 @@
>  int qedr_query_device(struct ib_device *ibdev,
>  		      struct ib_device_attr *attr, struct ib_udata *udata);  int
> qedr_query_port(struct ib_device *, u8 port, struct ib_port_attr *props);=
 -int
> qedr_modify_port(struct ib_device *, u8 port, int mask,
> -		     struct ib_port_modify *props);
>=20
>  int qedr_iw_query_gid(struct ib_device *ibdev, u8 port,
>  		      int index, union ib_gid *gid);
> --
> 2.20.1

Thanks,=A0

Acked-by: Michal Kalderon=A0<michal.kalderon@marvell.com>


