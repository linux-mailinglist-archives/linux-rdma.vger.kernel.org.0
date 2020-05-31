Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4CD1E95FB
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2020 09:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgEaHE0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 31 May 2020 03:04:26 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:27734 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726020AbgEaHEW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 31 May 2020 03:04:22 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04V71F4r017263;
        Sun, 31 May 2020 00:03:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=TffQs6O++e9WvzlU4+7k0jbh8ocpsv9/RYsOW332KzA=;
 b=K6CBOONxwVEkbRrF8/bJIYMNNTj798zNHzBAjKPQ8tAwgyo1U9cCFAevVOUHHhsDgA6p
 PpPOW/dhH4OC+azpkcPiC2KFNbWDnzwPiBXfTiABbsNudiR3lzyvxtHZfZLj6CzQ1zjZ
 iMYN2+2bBlvrIK8QteZBfVnV1tcSw2kbKqAZMV2noGM6LU0NaGYe6bJO6lUvinLiZ1gW
 rIe/IFKUYI60/wNBfj9gS735tH/W6HQOSi0DYnb9E+DVbxIJe9/5Qx3+sxNzCuJQzBpA
 I1yvSYwtkTxx9gyHQLi9Y1xuCsG8Yrr5MZaWlHsFXmVGLo9zidGY8FhU1JdwwjZyM3xt sg== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 31bq0mjcau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 31 May 2020 00:03:57 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 31 May
 2020 00:03:55 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.54) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Sun, 31 May 2020 00:03:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJW6t7oXnpTS19ZMUpt5WW0onreFrvgAwxyO6OE+okENRBVYHQaHM5sQmliG6Id2Qo2vVyAcv/WOtJSXqgIWH26alC8Hy7gru7WzWEfNFtRVVFfM8Jhc4WNPa8sL8tQA0o+tv2BW+eKO9UugGyHns+I+lK0+Q2uj/c6NDl5rCfTRG5n/mJj2C/InplmsPYBz72UGOXxS3kBWaYVSBR8/z7mcSwLQD3txI9TWx/+mxWeO05NqTdaZxFaWgSYSynjDzRIcMKzZ0K+J+LILGlzuuqvwEQ7bhAdgZbrSAz9/v4raqhI/cSqYeiTPqPLjljBy9HDjD6BSoObs9BCWzSnUog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TffQs6O++e9WvzlU4+7k0jbh8ocpsv9/RYsOW332KzA=;
 b=np5lTov89BXitf1zwEmOHgsvhYqNEYQSe6tInRBH1XOpWjTIKqrSnYPrBrTftOawcUJ48yKhz3fMYytr6yp4HRpxbWnTiwrla6gyvbUbnTQLbRVfHnpiFKh8semzJslL5L4BNMYpFN/rjRm2DAx+70TkAXP4quwiEi1in1yO66wE2PkMUXy7TaB0Vg6PIdHBEVj7i6WjeJsb4AboeqmmCvgXlli1qhTgd6RvhnqVw13rFMD5wQlH+oV3WeMp5wcrae2t2oXLgQsKS5R92qRq/te0Xkxspx4F3fpBHDQee3BWzrmr0OksxBN63UZmYfZ2KYBv/uxHYgFOTs9CPjMf0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TffQs6O++e9WvzlU4+7k0jbh8ocpsv9/RYsOW332KzA=;
 b=umkwCHz4BNLf4VeKuNG9//Ga1BYrHPMxLan3BkZX3fZejHl6SwyflJlglSv1oYzfCbYBEvmqW47n+5GfqNJ0C1hTPkEj1h2jLOw0BrulpYgmvXY7VNioWQQOqdocK09vpZhxONqLy7VkNPnKK4/O+EhXJAD7AvIISbq7hmAMFjY=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (2603:10b6:208:163::15)
 by MN2PR18MB2976.namprd18.prod.outlook.com (2603:10b6:208:3e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Sun, 31 May
 2020 07:03:54 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::71dc:797b:941a:9032]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::71dc:797b:941a:9032%3]) with mapi id 15.20.3045.022; Sun, 31 May 2020
 07:03:53 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Krishnamraju Eraparaju <krishna2@chelsio.com>,
        Bernard Metzler <BMT@zurich.ibm.com>,
        "faisal.latif@intel.com" <faisal.latif@intel.com>,
        "shiraz.saleem@intel.com" <shiraz.saleem@intel.com>,
        Ariel Elior <aelior@marvell.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "bharat@chelsio.com" <bharat@chelsio.com>,
        "nirranjan@chelsio.com" <nirranjan@chelsio.com>
Subject: RE: Re: Re: Re: [RFC PATCH] RDMA/siw: Experimental e2e negotiation of
 GSO usage.
Thread-Topic: Re: Re: Re: [RFC PATCH] RDMA/siw: Experimental e2e negotiation
 of GSO usage.
Thread-Index: AQHWNEDu5F3Bp8UZ3UuepJ2k2LrJgKjByhjA
Date:   Sun, 31 May 2020 07:03:53 +0000
Message-ID: <MN2PR18MB3182D69EF3FA984146EBA256A18D0@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20200428200043.GA930@chelsio.com>
 <20200415105135.GA8246@chelsio.com>
 <20200414144822.2365-1-bmt@zurich.ibm.com>
 <OFA289A103.141EDDE1-ON0025854B.003ED42A-0025854B.0041DBD8@notes.na.collabserv.com>
 <OF0315D264.505117BA-ON0025855F.0039BD43-0025855F.003E3C2B@notes.na.collabserv.com>
 <OFF3B8551C.FB7A8965-ON00258565.0043E6E2-00258565.00550882@notes.na.collabserv.com>
 <OF8C4B32A9.212C6DC0-ON00258567.0031506F-00258567.003EBFFB@notes.na.collabserv.com>
 <OF5AE22DD2.A8A5C20E-ON00258568.004804AF-00258568.00481A8E@notes.na.collabserv.com>
 <20200515135038.GA15967@chelsio.com>
 <OFD36340BE.9065DAAE-ON00258574.0049B60E-00258574.004CA5BC@notes.na.collabserv.com>
 <20200527160657.GA20672@chelsio.com>
In-Reply-To: <20200527160657.GA20672@chelsio.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: chelsio.com; dkim=none (message not signed)
 header.d=none;chelsio.com; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [46.116.60.160]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22f14519-11b0-479f-9d7f-08d80530c7a4
x-ms-traffictypediagnostic: MN2PR18MB2976:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB29766ADB3C4FAABD985E8845A18D0@MN2PR18MB2976.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0420213CCD
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ba5JtAs/vC6pGAFDD2nvhA9gg2Qj+ui7zqzV6b2oRyXnO5YgJav1AHx8rWLqDB/Ob9pmuRaq8xlG+ru3PF7wC/MH38dNQWG+T+JTE5T70SemHY3eKm9UalnfSshLcXyEpNMTrUm4pZjr36sK41N/Gk43XHAS4f7GDhJHBkrRaD00SWIjVzlC/iZHqY+JzHVqNadayQq9L9lVP3GrrjsO6Z42kDEDHr9rpckIKRbR++KV4a0P5NqYIHV9Oe6GU7fB6h6dG77EUD4EuLGZm6ooGxgKkVPUoFJ+GR3XNLLeXKAqKKwUWqdqfDpsYcyUE4y9DOKPI4k0mgzxNEGixTgIPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR18MB3182.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(346002)(39850400004)(396003)(376002)(66556008)(4326008)(64756008)(66476007)(9686003)(83380400001)(55016002)(5660300002)(33656002)(52536014)(7696005)(66946007)(66446008)(30864003)(6636002)(76116006)(6506007)(186003)(2906002)(71200400001)(110136005)(8936002)(478600001)(316002)(8676002)(86362001)(26005)(54906003)(579004)(559001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 8bZSP2Ho6Hgkk4e39K+izJTUakcR4Wj7vRUp82lGVbeYYxHvrZYXyDdFdYyLrPSCwmvhVop9uQUJBHf7GxmnLHFDavsgFJnMZpj0OSExSADQ0xZLK0qkcQbEQ8moe1cTRtWRAJ1p0KQiRZo94ilH/cR5Nv0lnhSiiXDGEUcv9etQhArcq0gaPAvqhy+dmO9+oPTNZQRC46p8Yxh7Rm/Vlu7xOMvau8rg3Rx7isR8UTiYWGRWKzlPdQO8hHkKv9I3Uc2kfLnTrG/9yLz4ephCAtebM/lhrWaxOafyYAixx7nkQKw/2fakGORFJj+aQGJvhnSPWWJ6eR2x8f3S9AxSQQbueWbZV0Sn/+Ouf9KY2A+Npbx8L+tqdM3+L0kltnFloOAbQAehNV6kg1UMi19XZMN6I4BIST8XD2MEkqENthwsiyfzxLerj7NyjcepDBkTe0R7iL/5tNp2n8Jmlp9LyB8S3lRt6m9L4a1Ox5o456Q=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f14519-11b0-479f-9d7f-08d80530c7a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2020 07:03:53.6419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wtHA5F4QBYrzYjShFwfuEvNlrz4PyXrJrNJufFoPw+kNwUhmdCI3ssuoBfLctahWclYBf5a6OaJkkSkaYReYSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2976
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-31_01:2020-05-28,2020-05-31 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> owner@vger.kernel.org> On Behalf Of Krishnamraju Eraparaju
>=20
>=20
> > Before we move ahead with that story in any direction, I would really
> > really appreciate to hear what other iWarp vendors have to say.
>=20
> Ok Bernard, will wait for other iWARP vendors to answer you questions.
Hi Bernard, Krishna,=20

Currently our adapter supports only FPDU length < MTU, we do support Jumbo =
frames.
We could add support for this in the future, enabling any FPDU size, but th=
is would be a SW based
Solution, not sure it will give us a performance boost.=20

We think changing the wire protocol requires standardization.=20
The port mapper seems like a better solution for OS specific.

Thanks,
Michal

>=20
>=20
> Thanks,
> Krishna.
> On Tuesday, May 05/26/20, 2020 at 13:57:11 +0000, Bernard Metzler wrote:
> >
> > -----"Krishnamraju Eraparaju" <krishna2@chelsio.com> wrote: -----
> >
> > >To: "Bernard Metzler" <BMT@zurich.ibm.com>
> > >From: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
> > >Date: 05/15/2020 03:58PM
> > >Cc: faisal.latif@intel.com, shiraz.saleem@intel.com,
> > >mkalderon@marvell.com, aelior@marvell.com, dledford@redhat.com,
> > >jgg@ziepe.ca, linux-rdma@vger.kernel.org, bharat@chelsio.com,
> > >nirranjan@chelsio.com
> > >Subject: [EXTERNAL] Re: Re: Re: Re: [RFC PATCH] RDMA/siw:
> > >Experimental e2e negotiation of GSO usage.
> > >
> > >Here is the rough prototype of iwpmd approach(only kernel part).
> > >Please take a look.
> >
> >
> > This indeed looks like a possible solution, which would not affect the
> > wire protocol.
> >
> > Before we move ahead with that story in any direction, I would really
> > really appreciate to hear what other iWarp vendors have to say.
> >
> > 0) would other vendors care about better performance
> >    in a mixed hardware/software iwarp setting?
> >
> > 1) what are the capabilities of other adapters in that
> >    respect, e.g. what is the maximum FPDU length it
> >    can process?
> >
> > 2) would other adapters be able to send larger FPDUs
> >    than MTU size?
> >
> > 3) what would be the preferred solution - using spare
> >    MPA protocol bits to signal capabilities or
> >    extending the proprietary iwarp port mapper with that
> >    functionality?
> >
> > Thanks very much!
> > Bernard.
> >
> >
> >
> > >diff --git a/drivers/infiniband/core/iwcm.c
> > >b/drivers/infiniband/core/iwcm.c index ade71823370f..ffe8d4dce45e
> > >100644
> > >--- a/drivers/infiniband/core/iwcm.c
> > >+++ b/drivers/infiniband/core/iwcm.c
> > >@@ -530,6 +530,12 @@ static int iw_cm_map(struct iw_cm_id *cm_id,
> > >bool
> > >active)
> > >        pm_msg.rem_addr =3D cm_id->remote_addr;
> > >        pm_msg.flags =3D (cm_id->device->iw_driver_flags &
> > >IW_F_NO_PORT_MAP) ?
> > >                       IWPM_FLAGS_NO_PORT_MAP : 0;
> > >+       ret =3D ib_query_qp(qp, &qp_attr, 0, &qp_init_attr);
> > >+        if (ret)
> > >+                return ret;
> > >+       else
> > >+               pm_msg.loc_fpdu_maxlen =3D qp_attr.loc_fpdu_maxlen;
> > >+
> > >        if (active)
> > >                status =3D iwpm_add_and_query_mapping(&pm_msg,
> > >                                                    RDMA_NL_IWCM); @@
> > >-544,6 +550,14 @@ static int iw_cm_map(struct iw_cm_id *cm_id, bool
> > >active)
> > >                                             &cm_id->remote_addr,
> > >                                             &cm_id->m_remote_addr);
> > >                }
> > >+
> > >+               if (pm_msg.rem_fpdu_maxlen) {
> > >+                       struct ib_qp_attr qp_attr =3D {0};
> > >+
> > >+                       qp_attr.rem_fpdu_maxlen =3D
> > >pm_msg.rem_fpdu_maxlen;
> > >+                       ib_modify_qp(qp, &qp_attr,
> > >IB_QP_FPDU_MAXLEN);
> > >+               }
> > >+
> > >        }
> > >
> > >        return iwpm_create_mapinfo(&cm_id->local_addr,
> > >diff --git a/drivers/infiniband/sw/siw/siw.h
> > >b/drivers/infiniband/sw/siw/siw.h
> > >index dba4535494ab..2c717f274dbf 100644
> > >--- a/drivers/infiniband/sw/siw/siw.h
> > >+++ b/drivers/infiniband/sw/siw/siw.h
> > >@@ -279,6 +279,7 @@ struct siw_qp_attrs {
> > >        enum siw_qp_flags flags;
> > >
> > >        struct socket *sk;
> > >+       u16 rem_fpdu_maxlen; /* max len of FPDU that remote node can
> > >accept */
> > > };
> > >
> > > enum siw_tx_ctx {
> > >@@ -415,7 +416,6 @@ struct siw_iwarp_tx {
> > >        u8 orq_fence : 1; /* ORQ full or Send fenced */
> > >        u8 in_syscall : 1; /* TX out of user context */
> > >        u8 zcopy_tx : 1; /* Use TCP_SENDPAGE if possible */
> > >-       u8 gso_seg_limit; /* Maximum segments for GSO, 0 =3D unbound *=
/
> > >
> > >        u16 fpdu_len; /* len of FPDU to tx */
> > >        unsigned int tcp_seglen; /* remaining tcp seg space */ @@
> > >-505,7 +505,6 @@ struct iwarp_msg_info {
> > >
> > > /* Global siw parameters. Currently set in siw_main.c */  extern
> > >const bool zcopy_tx; -extern const bool try_gso;  extern const bool
> > >loopback_enabled;  extern const bool mpa_crc_required;  extern const
> > >bool mpa_crc_strict; diff --git a/drivers/infiniband/sw/siw/siw_cm.c
> > >b/drivers/infiniband/sw/siw/siw_cm.c
> > >index 8c1931a57f4a..c240c430542d 100644
> > >--- a/drivers/infiniband/sw/siw/siw_cm.c
> > >+++ b/drivers/infiniband/sw/siw/siw_cm.c
> > >@@ -750,10 +750,6 @@ static int siw_proc_mpareply(struct siw_cep
> > >*cep)
> > >
> > >                return -ECONNRESET;
> > >        }
> > >-       if (try_gso && rep->params.bits & MPA_RR_FLAG_GSO_EXP) {
> > >-               siw_dbg_cep(cep, "peer allows GSO on TX\n");
> > >-               qp->tx_ctx.gso_seg_limit =3D 0;
> > >-       }
> > >        if ((rep->params.bits & MPA_RR_FLAG_MARKERS) ||
> > >            (mpa_crc_required && !(rep->params.bits &
> > >MPA_RR_FLAG_CRC))
> > >||
> > >            (mpa_crc_strict && !mpa_crc_required && @@ -1373,6
> > >+1369,7 @@ int siw_connect(struct iw_cm_id *id, struct
> > >iw_cm_conn_param *params)
> > >                rv =3D -EINVAL;
> > >                goto error;
> > >        }
> > >+
> > >        if (v4)
> > >                siw_dbg_qp(qp,
> > >                           "pd_len %d, laddr %pI4 %d, raddr %pI4
> > >%d\n", @@ -1469,9 +1466,6 @@ int siw_connect(struct iw_cm_id *id,
> > >struct iw_cm_conn_param *params)
> > >        }
> > >        __mpa_rr_set_revision(&cep->mpa.hdr.params.bits, version);
> > >
> > >-       if (try_gso)
> > >-               cep->mpa.hdr.params.bits |=3D MPA_RR_FLAG_GSO_EXP;
> > >-
> > >        if (mpa_crc_required)
> > >                cep->mpa.hdr.params.bits |=3D MPA_RR_FLAG_CRC;
> > >
> > >@@ -1594,6 +1588,7 @@ int siw_accept(struct iw_cm_id *id, struct
> > >iw_cm_conn_param *params)
> > >
> > >                return -EINVAL;
> > >        }
> > >+
> > >        down_write(&qp->state_lock);
> > >        if (qp->attrs.state > SIW_QP_STATE_RTR) {
> > >                rv =3D -EINVAL;
> > >@@ -1602,10 +1597,6 @@ int siw_accept(struct iw_cm_id *id, struct
> > >iw_cm_conn_param *params)
> > >        }
> > >        siw_dbg_cep(cep, "[QP %d]\n", params->qpn);
> > >
> > >-       if (try_gso && cep->mpa.hdr.params.bits &
> > >MPA_RR_FLAG_GSO_EXP) {
> > >-               siw_dbg_cep(cep, "peer allows GSO on TX\n");
> > >-               qp->tx_ctx.gso_seg_limit =3D 0;
> > >-       }
> > >        if (params->ord > sdev->attrs.max_ord ||
> > >            params->ird > sdev->attrs.max_ird) {
> > >                siw_dbg_cep(
> > >diff --git a/drivers/infiniband/sw/siw/siw_main.c
> > >b/drivers/infiniband/sw/siw/siw_main.c
> > >index 05a92f997f60..28c256e52454 100644
> > >--- a/drivers/infiniband/sw/siw/siw_main.c
> > >+++ b/drivers/infiniband/sw/siw/siw_main.c
> > >@@ -31,12 +31,6 @@ MODULE_LICENSE("Dual BSD/GPL");
> > > /* transmit from user buffer, if possible */  const bool zcopy_tx =3D
> > >true;
> > >
> > >-/* Restrict usage of GSO, if hardware peer iwarp is unable to
> > >process
> > >- * large packets. try_gso =3D true lets siw try to use local GSO,
> > >- * if peer agrees.  Not using GSO severly limits siw maximum tx
> > >  bandwidth.
> > >- */
> > >-const bool try_gso;
> > >-
> > > /* Attach siw also with loopback devices */  const bool
> > >loopback_enabled =3D true;
> > >
> > >diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c
> > >b/drivers/infiniband/sw/siw/siw_qp_tx.c
> > >index 5d97bba0ce6d..2a9fa4efab60 100644
> > >--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
> > >+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
> > >@@ -661,14 +661,19 @@ static void siw_update_tcpseg(struct
> > >siw_iwarp_tx *c_tx,
> > >                                     struct socket *s)  {
> > >        struct tcp_sock *tp =3D tcp_sk(s->sk);
> > >+       struct siw_qp *qp =3D  container_of(c_tx, struct siw_qp,
> > >tx_ctx);
> > >
> > >-       if (tp->gso_segs) {
> > >-               if (c_tx->gso_seg_limit =3D=3D 0)
> > >-                       c_tx->tcp_seglen =3D tp->mss_cache *
> > >tp->gso_segs;
> > >-               else
> > >+       if (tp->gso_segs && qp->attrs.rem_fpdu_maxlen) {
> > >+               if(tp->mss_cache >  qp->attrs.rem_fpdu_maxlen) {
> > >+                       c_tx->tcp_seglen =3D qp->attrs.rem_fpdu_maxlen=
;
> > >+               } else {
> > >+                       u8 gso_seg_limit;
> > >+                       gso_seg_limit =3D qp->attrs.rem_fpdu_maxlen /
> > >+                                               tp->mss_cache;
> > >                        c_tx->tcp_seglen =3D
> > >                                tp->mss_cache *
> > >-                               min_t(u16, c_tx->gso_seg_limit,
> > >                                tp->gso_segs);
> > >+                               min_t(u16, gso_seg_limit,
> > >tp->gso_segs);
> > >+               }
> > >        } else {
> > >                c_tx->tcp_seglen =3D tp->mss_cache;
> > >        }
> > >diff --git a/drivers/infiniband/sw/siw/siw_verbs.c
> > >b/drivers/infiniband/sw/siw/siw_verbs.c
> > >index b18a677832e1..c5f40d3454f3 100644
> > >--- a/drivers/infiniband/sw/siw/siw_verbs.c
> > >+++ b/drivers/infiniband/sw/siw/siw_verbs.c
> > >@@ -444,8 +444,7 @@ struct ib_qp *siw_create_qp(struct ib_pd *pd,
> > >        qp->attrs.sq_max_sges =3D attrs->cap.max_send_sge;
> > >        qp->attrs.rq_max_sges =3D attrs->cap.max_recv_sge;
> > >
> > >-       /* Make those two tunables fixed for now. */
> > >-       qp->tx_ctx.gso_seg_limit =3D 1;
> > >+       /* Make this tunable fixed for now. */
> > >        qp->tx_ctx.zcopy_tx =3D zcopy_tx;
> > >
> > >        qp->attrs.state =3D SIW_QP_STATE_IDLE; @@ -537,6 +536,7 @@ int
> > >siw_query_qp(struct ib_qp *base_qp, struct ib_qp_attr *qp_attr,
> > >        qp_attr->cap.max_send_sge =3D qp->attrs.sq_max_sges;
> > >        qp_attr->cap.max_recv_wr =3D qp->attrs.rq_size;
> > >        qp_attr->cap.max_recv_sge =3D qp->attrs.rq_max_sges;
> > >+       qp_attr->cap.loc_fpdu_maxlen =3D  SZ_64K - 1;
> > >        qp_attr->path_mtu =3D ib_mtu_int_to_enum(sdev->netdev->mtu);
> > >        qp_attr->max_rd_atomic =3D qp->attrs.irq_size;
> > >        qp_attr->max_dest_rd_atomic =3D qp->attrs.orq_size; @@ -550,6
> > >+550,7 @@ int siw_query_qp(struct ib_qp *base_qp, struct ib_qp_attr
> > >*qp_attr,
> > >        qp_init_attr->recv_cq =3D base_qp->recv_cq;
> > >        qp_init_attr->srq =3D base_qp->srq;
> > >
> > >+       qp_init_attr->cap =3D qp_attr->cap;
> > >        qp_init_attr->cap =3D qp_attr->cap;
> > >
> > >        return 0;
> > >@@ -589,6 +590,8 @@ int siw_verbs_modify_qp(struct ib_qp *base_qp,
> > >struct ib_qp_attr *attr,
> > >
> > >                siw_attr_mask |=3D SIW_QP_ATTR_STATE;
> > >        }
> > >+       if (attr_mask & IB_QP_FPDU_MAXLEN)
> > >+                qp->attrs.rem_fpdu_maxlen =3D attr->rem_fpdu_maxlen;
> > >        if (!siw_attr_mask)
> > >                goto out;
> > >
> > >diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h index
> > >e7e733add99f..5bc3e3b9ea61 100644
> > >--- a/include/rdma/ib_verbs.h
> > >+++ b/include/rdma/ib_verbs.h
> > >@@ -1054,6 +1054,8 @@ struct ib_qp_cap {
> > >         * and MRs based on this.
> > >         */
> > >        u32     max_rdma_ctxs;
> > >+       /* Maximum length of FPDU that the device at local node could
> > >accept */
> > >+       u16     loc_fpdu_maxlen;
> > > };
> > >
> > > enum ib_sig_type {
> > >@@ -1210,6 +1212,7 @@ enum ib_qp_attr_mask {
> > >        IB_QP_RESERVED3                 =3D (1<<23),
> > >        IB_QP_RESERVED4                 =3D (1<<24),
> > >        IB_QP_RATE_LIMIT                =3D (1<<25),
> > >+       IB_QP_FPDU_MAXLEN               =3D (1<<26),
> > > };
> > >
> > > enum ib_qp_state {
> > >@@ -1260,6 +1263,7 @@ struct ib_qp_attr {
> > >        u8                      alt_port_num;
> > >        u8                      alt_timeout;
> > >        u32                     rate_limit;
> > >+       u16                     rem_fpdu_maxlen; /* remote node's max
> > >len cap */
> > > };
> > >
> > > enum ib_wr_opcode {
> > >diff --git a/include/rdma/iw_portmap.h b/include/rdma/iw_portmap.h
> > >index c89535047c42..af1bc798f709 100644
> > >--- a/include/rdma/iw_portmap.h
> > >+++ b/include/rdma/iw_portmap.h
> > >@@ -61,6 +61,8 @@ struct iwpm_sa_data {
> > >        struct sockaddr_storage mapped_loc_addr;
> > >        struct sockaddr_storage rem_addr;
> > >        struct sockaddr_storage mapped_rem_addr;
> > >+       u16 loc_fpdu_maxlen;
> > >+       u16 rem_fpdu_maxlen;
> > >        u32 flags;
> > > };
> > >
> > >On Friday, May 05/15/20, 2020 at 19:20:40 +0530, Krishnamraju
> > >Eraparaju wrote:
> > >> On Thursday, May 05/14/20, 2020 at 13:07:33 +0000, Bernard Metzler
> > >wrote:
> > >> > -----"Krishnamraju Eraparaju" <krishna2@chelsio.com> wrote: -----
> > >> >
> > >> > >To: "Bernard Metzler" <BMT@zurich.ibm.com>
> > >> > >From: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
> > >> > >Date: 05/14/2020 01:17PM
> > >> > >Cc: faisal.latif@intel.com, shiraz.saleem@intel.com,
> > >> > >mkalderon@marvell.com, aelior@marvell.com,
> dledford@redhat.com,
> > >> > >jgg@ziepe.ca, linux-rdma@vger.kernel.org, bharat@chelsio.com,
> > >> > >nirranjan@chelsio.com
> > >> > >Subject: [EXTERNAL] Re: Re: Re: [RFC PATCH] RDMA/siw:
> > >Experimental
> > >> > >e2e negotiation of GSO usage.
> > >> > >
> > >> > >On Wednesday, May 05/13/20, 2020 at 11:25:23 +0000, Bernard
> > >Metzler
> > >> > >wrote:
> > >> > >> -----"Krishnamraju Eraparaju" <krishna2@chelsio.com> wrote:
> > >-----
> > >> > >>
> > >> > >> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
> > >> > >> >From: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
> > >> > >> >Date: 05/13/2020 05:50AM
> > >> > >> >Cc: faisal.latif@intel.com, shiraz.saleem@intel.com,
> > >> > >> >mkalderon@marvell.com, aelior@marvell.com,
> > >dledford@redhat.com,
> > >> > >> >jgg@ziepe.ca, linux-rdma@vger.kernel.org, bharat@chelsio.com,
> > >> > >> >nirranjan@chelsio.com
> > >> > >> >Subject: [EXTERNAL] Re: Re: Re: [RFC PATCH] RDMA/siw:
> > >Experimental
> > >> > >> >e2e negotiation of GSO usage.
> > >> > >> >
> > >> > >> >On Monday, May 05/11/20, 2020 at 15:28:47 +0000, Bernard
> > >Metzler
> > >> > >> >wrote:
> > >> > >> >> -----"Krishnamraju Eraparaju" <krishna2@chelsio.com> wrote:
> > >> > >-----
> > >> > >> >>
> > >> > >> >> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
> > >> > >> >> >From: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
> > >> > >> >> >Date: 05/07/2020 01:07PM
> > >> > >> >> >Cc: faisal.latif@intel.com, shiraz.saleem@intel.com,
> > >> > >> >> >mkalderon@marvell.com, aelior@marvell.com,
> > >dledford@redhat.com,
> > >> > >> >> >jgg@ziepe.ca, linux-rdma@vger.kernel.org,
> > >bharat@chelsio.com,
> > >> > >> >> >nirranjan@chelsio.com
> > >> > >> >> >Subject: [EXTERNAL] Re: Re: [RFC PATCH] RDMA/siw:
> > >Experimental
> > >> > >e2e
> > >> > >> >> >negotiation of GSO usage.
> > >> > >> >> >
> > >> > >> >> >Hi Bernard,
> > >> > >> >> >Thanks for the review comments. Replied in line.
> > >> > >> >> >
> > >> > >> >> >On Tuesday, May 05/05/20, 2020 at 11:19:46 +0000, Bernard
> > >> > >Metzler
> > >> > >> >> >wrote:
> > >> > >> >> >>
> > >> > >> >> >> -----"Krishnamraju Eraparaju" <krishna2@chelsio.com>
> > >wrote:
> > >> > >> >-----
> > >> > >> >> >>
> > >> > >> >> >> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
> > >> > >> >> >> >From: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
> > >> > >> >> >> >Date: 04/28/2020 10:01PM
> > >> > >> >> >> >Cc: faisal.latif@intel.com, shiraz.saleem@intel.com,
> > >> > >> >> >> >mkalderon@marvell.com, aelior@marvell.com,
> > >> > >dledford@redhat.com,
> > >> > >> >> >> >jgg@ziepe.ca, linux-rdma@vger.kernel.org,
> > >> > >bharat@chelsio.com,
> > >> > >> >> >> >nirranjan@chelsio.com
> > >> > >> >> >> >Subject: [EXTERNAL] Re: [RFC PATCH] RDMA/siw:
> > >Experimental
> > >> > >e2e
> > >> > >> >> >> >negotiation of GSO usage.
> > >> > >> >> >> >
> > >> > >> >> >> >On Wednesday, April 04/15/20, 2020 at 11:59:21 +0000,
> > >> > >Bernard
> > >> > >> >> >Metzler
> > >> > >> >> >> >wrote:
> > >> > >> >> >> >Hi Bernard,
> > >> > >> >> >> >
> > >> > >> >> >> >The attached patches enables the GSO negotiation code
> > >in SIW
> > >> > >> >with
> > >> > >> >> >> >few modifications, and also allows hardware iwarp
> > >drivers to
> > >> > >> >> >> >advertise
> > >> > >> >> >> >their max length(in 16/32/64KB granularity) that they
> > >can
> > >> > >> >accept.
> > >> > >> >> >> >The logic is almost similar to how TCP SYN MSS
> > >announcements
> > >> > >> >works
> > >> > >> >> >> >while
> > >> > >> >> >> >3-way handshake.
> > >> > >> >> >> >
> > >> > >> >> >> >Please see if this approach works better for softiwarp
> > ><=3D>
> > >> > >> >> >hardiwarp
> > >> > >> >> >> >case.
> > >> > >> >> >> >
> > >> > >> >> >> >Thanks,
> > >> > >> >> >> >Krishna.
> > >> > >> >> >> >
> > >> > >> >> >> Hi Krishna,
> > >> > >> >> >>
> > >> > >> >> >> Thanks for providing this. I have a few comments:
> > >> > >> >> >>
> > >> > >> >> >> It would be good if we can look at patches inlined in
> > >the
> > >> > >> >> >> email body, as usual.
> > >> > >> >> >Sure, will do that henceforth.
> > >> > >> >> >>
> > >> > >> >> >> Before further discussing a complex solution as
> > >suggested
> > >> > >> >> >> here, I would like to hear comments from other iWarp HW
> > >> > >> >> >> vendors on their capabilities regarding GSO frame
> > >acceptance
> > >> > >> >> >> and potential preferences.
> > >> > >> >> >>
> > >> > >> >> >> The extension proposed here goes beyond what I initially
> > >sent
> > >> > >> >> >> as a proposed patch. From an siw point of view, it is
> > >> > >straight
> > >> > >> >> >> forward to select using GSO or not, depending on the
> > >iWarp
> > >> > >peer
> > >> > >> >> >> ability to process large frames. What is proposed here
> > >is a
> > >> > >> >> >> end-to-end negotiation of the actual frame size.
> > >> > >> >> >>
> > >> > >> >> >> A comment in the patch you sent suggests adding a module
> > >> > >> >> >> parameter. Module parameters are deprecated, and I
> > >removed
> > >> > >any
> > >> > >> >> >> of those from siw when it went upstream. I don't think
> > >we can
> > >> > >> >> >> rely on that mechanism.
> > >> > >> >> >>
> > >> > >> >> >> siw has a compile time parameter (yes, that was a module
> > >> > >> >> >> parameter) which can set the maximum tx frame size (in
> > >> > >multiples
> > >> > >> >> >> of MTU size). Any static setup of siw <-> Chelsio could
> > >make
> > >> > >> >> >> use of that as a work around.
> > >> > >> >> >>
> > >> > >> >> >> I wonder if it would be a better idea to look into an
> > >> > >extension
> > >> > >> >> >> of the rdma netlink protocol, which would allow setting
> > >> > >driver
> > >> > >> >> >> specific parameters per port, or even per QP.
> > >> > >> >> >> I assume there are more potential use cases for driver
> > >> > >private
> > >> > >> >> >> extensions of the rdma netlink interface?
> > >> > >> >> >
> > >> > >> >> >I think, the only problem with "configuring FPDU length
> > >via
> > >> > >rdma
> > >> > >> >> >netlink" is the enduser might not feel comfortable in
> > >finding
> > >> > >what
> > >> > >> >> >adapter
> > >> > >> >> >is installed at the remote endpoint and what length it
> > >> > >supports.
> > >> > >> >Any
> > >> > >> >> >thoughts on simplify this?
> > >> > >> >>
> > >> > >> >> Nope. This would be 'out of band' information.
> > >> > >> >>
> > >> > >> >> So we seem to have 3 possible solutions to the problem:
> > >> > >> >>
> > >> > >> >> (1) detect if the peer accepts FPDUs up to current GSO
> > >size,
> > >> > >> >> this is what I initially proposed. (2) negotiate a max FPDU
> > >> > >> >> size with the peer, this is what you are proposing, or (3)
> > >> > >> >> explicitly set that max FPDU size per extended user
> > >interface.
> > >> > >> >>
> > >> > >> >> My problem with (2) is the rather significant proprietary
> > >> > >> >> extension of MPA, since spare bits code a max value
> > >negotiation.
> > >> > >> >>
> > >> > >> >> I proposed (1) for its simplicity - just a single bit flag,
> > >> > >> >> which de-/selects GSO size for FPDUs on TX. Since Chelsio
> > >> > >> >> can handle _some_ larger (up to 16k, you said) sizes, (1)
> > >> > >> >> might have to be extended to cap at hard coded max size.
> > >> > >> >> Again, it would be good to know what other vendors limits
> > >> > >> >> are.
> > >> > >> >>
> > >> > >> >> Does 16k for siw  <-> Chelsio already yield a decent
> > >> > >> >> performance win?
> > >> > >> >yes, 3x performance gain with just 16K GSO, compared to GSO
> > >> > >diabled
> > >> > >> >case. where MTU size is 1500.
> > >> > >> >
> > >> > >>
> > >> > >> That is a lot. At the other hand, I would suggest to always
> > >> > >> increase MTU size to max (9k) for adapters siw attaches to.
> > >> > >> With a page size of 4k, anything below 4k MTU size hurts,
> > >> > >> while 9k already packs two consecutive pages into one frame,
> > >> > >> if aligned.
> > >> > >>
> > >> > >> Would 16k still gain a significant performance win if we have
> > >> > >> set max MTU size for the interface?
> > >> Unfortunately no difference in throughput when MTU is 9K, for 16K
> > >FPDU.
> > >> Looks like TCP stack constructs GSO/TSO buffer in multiples of HW
> > >> MSS(tp->mss_cache). So, as 16K FPDU buffer is not a multiple of 9K,
> > >TCP
> > >> stack slices 16K buffer into 9K & 7K buffers before passing it to
> > >NIC
> > >> driver.
> > >> Thus no difference in perfromance as each tx packet to NIC cannot
> > >go
> > >> beyond 9K, when FPDU len is 16K.
> > >> > >>
> > >> > >> >Regarding the rdma netlink approach that you are suggesting,
> > >> > >should
> > >> > >> >it
> > >> > >> >be similar like below(?):
> > >> > >> >
> > >> > >> >rdma link set iwp3s0f4/1 max_fpdu_len 102.1.1.6:16384,
> > >> > >> >102.5.5.6:32768
> > >> > >> >
> > >> > >> >
> > >> > >> >rdma link show iwp3s0f4/1 max_fpdu_len
> > >> > >> >        102.1.1.6:16384
> > >> > >> >        102.5.5.6:32768
> > >> > >> >
> > >> > >> >where "102.1.1.6" is the destination IP address(such that the
> > >same
> > >> > >> >max
> > >> > >> >fpdu length is taken for all the connections to this
> > >> > >> >address/adapter).
> > >> > >> >And "16384" is max fdpu length.
> > >> > >> >
> > >> > >> Yes, that would be one way of doing it. Unfortunately we would
> > >> > >> end up with maintaining additional permanent in kernel state
> > >> > >> per peer we ever configured.
> > >> > >>
> > >> > >> So, would it make sense to combine it with the iwpmd, which
> > >> > >> then may cache peers, while setting max_fpdu per new
> > >> > >> connection? This would probably include extending the
> > >> > >> proprietary port mapper protocol, to exchange local
> > >> > >> preferences with the peer. Local capabilities might be queried
> > >> > >> from the device (extending enum ib_mtu to more than 4k, and
> > >> > >> using ibv_query_port()). And the iw_cm_id to be extended to
> > >> > >> carry that extra parameter down to the driver... Sounds
> > >> > >> complicated.
> > >> > >If I understand you right, client/server advertises their Max
> > >FPDU
> > >> > >len
> > >> > >in Res field of PMReq/PMAccept frames.
> > >> > >typedef struct iwpm_wire_msg {
> > >> > >        __u8    magic;
> > >> > >        __u8    pmtime;
> > >> > >        __be16  reserved;
> > >> > >Then after Portmapper negotiation, the fpdu len is propagated to
> > >SIW
> > >> > >qp
> > >> > >strucutre from userspace iwpmd.
> > >> > >
> > >> > >If we weigh up the pros and cons of using PortMapper Res field
> > >vs MPA
> > >> > >Res feild, then looks like using MPA is less complicated,
> > >considering
> > >> > >the lines of changes and modules invovled in changes. Not sure
> > >my
> > >> > >analysis is right here?
> > >> > >
> > >> > One important difference IMHO is that one approach would touch an
> > >> > established IETF communication protocol (MPA), the other a
> > >> > proprietary application (iwpmd).
> > >> Ok, will explore more on iwpmd approach, may be prototyping this
> > >would help.
> > >> >
> > >> >
> > >> > >Between, looks like the existing SIW GSO code needs a logic to
> > >limit
> > >> > >"c_tx->tcp_seglen" to 64K-1, as MPA len is only 16bit. Say, in
> > >future
> > >> > >to
> > >> > >best utilize 400G Ethernet, if Linux TCP stack has increased
> > >> > >GSO_MAX_SIZE to 128K, then SIW will cast 18bit value to 16bit
> > >MPA
> > >> > >len.
> > >> > >
> > >> > Isn't GSO bound to IP fragmentation?
> > >> Not sure. But I would say it's better we limit "c_tx->tcp_seglen"
> > >> somewhere to 64K-1 to avoid future risks.
> > >> >
> > >> > Thanks,
> > >> > Bernard
> > >> >
> > >
> >
