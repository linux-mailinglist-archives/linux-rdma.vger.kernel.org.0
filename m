Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1E4DA81E
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Oct 2019 11:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393102AbfJQJPG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Oct 2019 05:15:06 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:44742 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733113AbfJQJPG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 17 Oct 2019 05:15:06 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9H99hqL004401;
        Thu, 17 Oct 2019 02:14:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=QeLTgJVrXg2unh0QwAWrz3Ev12+NEhdjtWO3ra068H0=;
 b=u5zI+EKJh4CRfa3MPIYO64a3ApO+MAI2ic5LU63yDUZv02g885uZ4rxN+bqYr0ApFUpH
 lC2/hgic0/7rTtKOyaYaD6NBZDRgGnGfO5pRi9444mfIgQyM1SU5vtOSUUs+2EJOdZJJ
 8Lq8E0d87sM1bBZC0li7gxozOYtMM07IWnc4f4BqlJASTzSL1R1edhcsXWBr+DrgbDA4
 q/NPMlmtoQDMXXKWaxGIGyI5QbNPln/u17HYgA0PZ+xScCKZuqcUPDxo+xyqd4WZyhdU
 q9YaZo5/U+pfXVS2bUKMr5h4lfhscafkap/MyTwUknse6MnhfS07iyVTAMfCB7w2Bhl2 XQ== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2vnpmbq1e2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 17 Oct 2019 02:14:56 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 17 Oct
 2019 02:14:55 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (104.47.34.52) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 17 Oct 2019 02:14:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ObEqkDEAzfx1/FA2ctFysPbyqUt6mkz1zRK9F9fPAbPktG/HCWid4NOA6IwBzY0nnLxDFMijHso2OlJbApnlUH9dGvwumzTedDvhNuRAtftAXCvWO/vIDKsxg1tzrMfAELamfYdKLY5xgwppobaAEp+Fo+4ljwRFu07Od6qIByPhvoV5vf3yHRK+x9nI/dceV62OuSibsUDdaPqvkjmcpwYYLr5opv0CMZgHqL3ecyDRvrhT6C3PrQXUjadP0Mupm6KGUjvobst+HJ19vgqZZzrMA1sw4S8MkQ2cWLeMqzENBkeOK0K6sl7cPUaPIKKCgAjZQ4im36adbA4+M8v/5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QeLTgJVrXg2unh0QwAWrz3Ev12+NEhdjtWO3ra068H0=;
 b=V9RaxO2Qk+qvtRtFlk4Ta+nd9Qvfx227JvY6uNuXoE38HU1T0OeR/m2vPnTiZgAF1iUwJNeWklJAy2Qe6t56wYJUYhg3uPEpPik08+zVBCB2wiMywf1qJMTIIgio1AX0z9VZ0jI7ACYs6lJcMFAY+YZguH5z/19hV3kY31CJCNNYfIC+8UyBiViqzACBhsgE7CzK1iircnelEnouIY649diaPFBuK+abH/BV7rgmAbdi12JSoV9poZiEovFn0nEIQLYT7srdfqlS//hIwP5/8sf6uoZ9I+b0529PBuAVIXyCT2WmerQ3HmnNzIsetI8fwu6tFmXjc069Oa5bDkggUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QeLTgJVrXg2unh0QwAWrz3Ev12+NEhdjtWO3ra068H0=;
 b=Agst5KnwZoBM5bVc3923RI1DlJ91l0t4IDJNg8pxvNCkuA5p+h6YDDSEVFuQpX+FtmMmtsy3WqyWjtH/68DMEjw4QIRADD8e3I5w93Aykv1lBOvrXJ4iaIykChVShDfctP0VhddTXHwHbYyA5+3Apb/nU17yfWfpIsV2v9WCz6U=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB2733.namprd18.prod.outlook.com (20.179.21.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Thu, 17 Oct 2019 09:14:54 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::4c1d:fb1e:ea9c:6811]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::4c1d:fb1e:ea9c:6811%6]) with mapi id 15.20.2347.024; Thu, 17 Oct 2019
 09:14:53 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Kamal Heib <kamalheib1@gmail.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Lijun Ou <oulijun@huawei.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: RE: [EXT] [PATCH for-next v2 1/4] RDMA/core: Fix return code when
 modify_port isn't supported
Thread-Topic: [EXT] [PATCH for-next v2 1/4] RDMA/core: Fix return code when
 modify_port isn't supported
Thread-Index: AQHVg/KNP07l2qZtYkyT1zxeSAMyuqdc6CCAgAGlJQCAAAFDsA==
Date:   Thu, 17 Oct 2019 09:14:53 +0000
Message-ID: <MN2PR18MB3182B29937262A44C8452CD4A16D0@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20191016072234.28442-1-kamalheib1@gmail.com>
 <20191016072234.28442-2-kamalheib1@gmail.com>
 <MN2PR18MB31825843C5DFA493069485D2A1920@MN2PR18MB3182.namprd18.prod.outlook.com>
 <20191017090930.GA28093@kheib-workstation>
In-Reply-To: <20191017090930.GA28093@kheib-workstation>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.203.130.254]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31a030ad-50a0-49e7-714f-08d752e278d4
x-ms-traffictypediagnostic: MN2PR18MB2733:
x-microsoft-antispam-prvs: <MN2PR18MB27330E13DEC554695BDE117FA16D0@MN2PR18MB2733.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 01930B2BA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(199004)(189003)(55016002)(486006)(6916009)(446003)(6436002)(66946007)(229853002)(74316002)(3846002)(7736002)(305945005)(6116002)(476003)(14444005)(256004)(64756008)(11346002)(6246003)(9686003)(4326008)(66476007)(66556008)(2906002)(76116006)(66446008)(81166006)(25786009)(1411001)(8936002)(6506007)(71190400001)(8676002)(81156014)(76176011)(186003)(7696005)(71200400001)(99286004)(26005)(86362001)(478600001)(316002)(102836004)(52536014)(14454004)(66066001)(54906003)(33656002)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2733;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X22ragScdpeELHYnGOnuZcYaJAA/9f7KCjPjEskevn5kqaSj6i7pSj2lLHxYmYn0CnL9RkRnke+tlWHJT26YwDwX9laQF0+oHXrI50b8rqfGslN2J8QwttxTyW328YAtAHgOYSdybX1j2P6VUdAvhv6blc2pP0/m+cMPNsz1cVlTXczS+t12k3NbkeKv0pdxIO13OcNJ560UM0b3QnmoStuu8qQyTzghLGH5uVJCo8tgpajP1NhLhEb/9NqSjfofiSji5EoYXSxreCM8NEs5Q4BNdRjWiDxYROLJZx0JXTtoXQg6w75x7xwpKLfYT/mPsnJEc3mdVo34JjhmYUNgzIM+4RqsbApjoE6WVDz925Vuyg9vUkXdpD1uQnytHD1/JfMbuOFps3XAJUbTiYiw+EvfOmLtcCoH43AQHVkaYzU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 31a030ad-50a0-49e7-714f-08d752e278d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2019 09:14:53.7330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pxgwcPGMvEtgVAMayrTpittE1Tyb022bhHZamKst1MbcfkxSql3OIZL8f0n7p0Lsrfm8mBRuBJnOIb7d6nqtvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2733
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-17_04:2019-10-17,2019-10-17 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> owner@vger.kernel.org> On Behalf Of Kamal Heib
>=20
> On Wed, Oct 16, 2019 at 08:05:49AM +0000, Michal Kalderon wrote:
> > > From: Kamal Heib <kamalheib1@gmail.com>
> > > Sent: Wednesday, October 16, 2019 10:23 AM
> > >
> > > External Email
> > >
> > > --------------------------------------------------------------------
> > > -- The proper return code is "-EOPNOTSUPP" when modify_port callback
> > > is not supported.
> > >
> > > Fixes: 61e0962d5221 ("IB: Avoid ib_modify_port() failure for RoCE
> > > devices")
> > > Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> > > ---
> > >  drivers/infiniband/core/device.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/infiniband/core/device.c
> > > b/drivers/infiniband/core/device.c
> > > index a667636f74bf..98a01caf7850 100644
> > > --- a/drivers/infiniband/core/device.c
> > > +++ b/drivers/infiniband/core/device.c
> > > @@ -2397,7 +2397,7 @@ int ib_modify_port(struct ib_device *device,
> > >  					     port_modify_mask,
> > >  					     port_modify);
> > >  	else
> > > -		rc =3D rdma_protocol_roce(device, port_num) ? 0 : -ENOSYS;
> > > +		rc =3D rdma_protocol_roce(device, port_num) ? 0 : -
> > > EOPNOTSUPP;
> >
> > This is a bit confusing, looks like for RoCE it's ok not to have a
> > callback but for the The other protocols it's required. For iWARP for
> example there also isn't a modify-port.
> > Is there any other protocol except ib that this is relevant to ?
> > If not perhaps modify rdma_protocol_roce(..)? to rdma_protocol_ib(...)?=
 -
> EOPNOTSUPP : 0?
> >
>=20
> Yes, I agree this is confusing.
>=20
> This change was introduced by the following commit to avoid the failures =
of
> ib_modify_port() calls from CM when the protocol is RoCE, I also see that
> almost all providers that support RoCE return success from the
> modify_port() callback (hns, mlx4, mlx5, ocrdma, qedr), except rxe and
> vmw_pvrdma which I think they shouldn't.
>=20
> So, I suggest adding a check to CM avoid calling ib_modify_port() when th=
e
> protocol is RoCE and cleanup the mess from the providers, thoughts?
I think we can leave the logic inside the function ib_modify_port, and just=
 return
Success if the protocol isn't IB.=20

>=20
> commit 61e0962d52216f2e5bab59bb055f1210e41f484f
> Author: Selvin Xavier <selvin.xavier@broadcom.com>
> Date:   Wed Aug 23 01:08:07 2017 -0700
>=20
>     IB: Avoid ib_modify_port() failure for RoCE devices
>=20
>     IB CM calls ib_modify_port() irrespective of link layer. If the
>     failure is returned, the mad agent gets unregistered for those
>     devices. Recently, modify_port() hook was removed from some of the
>     low level drivers as it was always returning success. This breaks
>     rdma connection establishment over those devices.
>     For ethernet devices, Qkey violation and port capabilities are not
>     applicable. So returning success for RoCE when modify_port hook is
>     is not implemented.
>=20
>     Cc: Leon Romanovsky <leon@kernel.org>
>     Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
>     Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
>     Signed-off-by: Doug Ledford <dledford@redhat.com>
>=20
> diff --git a/drivers/infiniband/core/device.c
> b/drivers/infiniband/core/device.c
> index fc6be1175183..2466ffc6362d 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -1005,14 +1005,17 @@ int ib_modify_port(struct ib_device *device,
>                    u8 port_num, int port_modify_mask,
>                    struct ib_port_modify *port_modify)  {
> -       if (!device->modify_port)
> -               return -ENOSYS;
> +       int rc;
>=20
>         if (!rdma_is_port_valid(device, port_num))
>                 return -EINVAL;
>=20
> -       return device->modify_port(device, port_num, port_modify_mask,
> -                                  port_modify);
> +       if (device->modify_port)
> +               rc =3D device->modify_port(device, port_num, port_modify_=
mask,
> +                                          port_modify);
> +       else
> +               rc =3D rdma_protocol_roce(device, port_num) ? 0 : -ENOSYS=
;
> +       return rc;
>  }
>  EXPORT_SYMBOL(ib_modify_port);
>=20
>=20
> >
> >
> > >  	return rc;
> > >  }
> > >  EXPORT_SYMBOL(ib_modify_port);
> > > --
> > > 2.20.1
> >
