Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B781D1626D4
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2020 14:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgBRNJt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Feb 2020 08:09:49 -0500
Received: from mail-eopbgr70052.outbound.protection.outlook.com ([40.107.7.52]:1446
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726340AbgBRNJt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Feb 2020 08:09:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQN/k+617Z14d1VGFnKnB281QhdsCC63HVO95A9GFLpbLtkaRXpkhSNkWjip4/oWlpdSEbGcaysu+Xq0rOxFpe9/SfX+kSQ5WDojb1OHm/y3B08gOo9Or5uuSMFItZp/lAmgWuIkwkSGfEY3uPGgNcZOH3eHm5EQQNdfS/eHdDWZwoMMC/iZSAH1Iu0VPcTUufNdSjJov7MTiFkvGHTE8BlOFXGDYvp+/BTr0KCn9q0zyqrWXI4BYoun41xpSJARoADQr+ohUvDhou4YDTAh5YO40SglCA4wA80AydW6xF8OchvTolWd/0n/p2+IPAZbni9PoOrOLFX4HwrFe+cO3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mADDQX+SGkdcwUMNA1eIP/xPfDyMVxnxCSOcmXqrbRg=;
 b=GXCEGWdMEiNnCXoWvrmF8jSkkBFMU4ajt2/tufPK4rGNTn0t3IpXkF6tYo2pm3dSuHn9TBv5kQ2lifrRErSDwlTK7z/8JRZ7nLjRC46FiThZZt75wYjCmRZw/85Uz2NOfd5SDS0J2SEugCO68RlMO1+hDFuWCcCAOz1Qx6+jf7sIKt6HZ5iYYp9B9c/4e64tsoRgXELk44OniS7Tnt2HMt7J8U4oDI8bF+uigaLoZ6vB9jDtsIfBl3LVyws5pnRhRWIZwEOwCPR7Vla+HrRCOEkZFAlwjJjYomrUS0wYCy2K/NBnENGblzvMlNrCVq3eF2iF5N1ewQhtlE+q+maR/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mADDQX+SGkdcwUMNA1eIP/xPfDyMVxnxCSOcmXqrbRg=;
 b=oWCq3T5Vh/7I1rTSI4imG5qOVOhWfAm8QoqEHIus5UBfpD4P8DjFjcneB+5YX/TOt0XkgS08dv8UDZuWm6nFX2iAlwd8nc4/5VGzswtJRSyjVhthWVKAE74YiP/ixjUFvb1GX3jgtxR3Zz9KocVqqpz+xiwLEkmDWBWONQNWogY=
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com (20.179.5.215) by
 AM6PR05MB6582.eurprd05.prod.outlook.com (20.179.7.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.24; Tue, 18 Feb 2020 13:09:46 +0000
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::c99f:9130:561f:dea0]) by AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::c99f:9130:561f:dea0%3]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 13:09:45 +0000
Received: from localhost (193.47.165.251) by AM0P190CA0001.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17 via Frontend Transport; Tue, 18 Feb 2020 13:09:44 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
CC:     Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Moni Shoua <monis@mellanox.com>
Subject: Re: [PATCH] RDMA/rxe: Fix configuration of atomic queue pair
 attributes
Thread-Topic: [PATCH] RDMA/rxe: Fix configuration of atomic queue pair
 attributes
Thread-Index: AQHV5dTbPFFk6Ot3bkeVZUUeQQJsaaggtwEAgAA2sgA=
Date:   Tue, 18 Feb 2020 13:09:45 +0000
Message-ID: <20200218130942.GB3846@unreal>
References: <20200217205714.26937-1-bvanassche@acm.org>
 <CAD=hENff-t-xCrYOnCFLMKYgKDodxEamm-Z++U4W202MprEWDg@mail.gmail.com>
In-Reply-To: <CAD=hENff-t-xCrYOnCFLMKYgKDodxEamm-Z++U4W202MprEWDg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0P190CA0001.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::11) To AM6PR05MB6408.eurprd05.prod.outlook.com
 (2603:10a6:20b:b8::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 985105a3-ac78-445b-be78-08d7b473d326
x-ms-traffictypediagnostic: AM6PR05MB6582:|AM6PR05MB6582:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR05MB658279D6845B997799274813B0110@AM6PR05MB6582.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 031763BCAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(189003)(199004)(53546011)(86362001)(26005)(66556008)(478600001)(6496006)(66446008)(4326008)(16526019)(6916009)(52116002)(956004)(186003)(6486002)(2906002)(66476007)(1076003)(316002)(8676002)(9686003)(64756008)(81166006)(54906003)(8936002)(81156014)(107886003)(33656002)(66946007)(71200400001)(5660300002)(33716001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB6582;H:AM6PR05MB6408.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JnIIzf/6n2mIT5zg8I6oYoRESfa0v9ckLHK6L0rbU480FiXtM4ic1xSDrORAIsoHqAEGddVRtWB9iVncycB6/yn0TxQcFkFSyFlPrNYZJRZUfjn1DR6myfW2CsWPHI5IaO1sTYPGDBbAWxf3NJLkqyI1yGfcneCQTnQ8CfXIvzua1PDOECoV3ANG1gqw3B2C9I5mkYv3pMy/abjxUuOWPT5HA0JkvMgo1hBg5STaquF6OWME284VQEft9zOJOgW5kvtV7B+CnkPxaB5d0o2o3DymI1eVrRXk2KeRX6i10EcvZVIMU9XFDp9Z9MrKNTa7ZUiYDK3fjrka+7nyRmFxoGOKS29uYnBQOAca8kN0b/CxnANOlff+USSnFexRzYP3e79CIDEDtas6wmNzu5gsetWKiftbWOP9L68ukWtTbxqs2e66yCb0bzuOMFRXc7WS
x-ms-exchange-antispam-messagedata: 7NdmjI2uscelFMgwhOwMow4+8FCQZuK21yfFSP/E9oobtWNyKiCuJ7bbdj6j7D5X+SdBU5Z23pscEJlBXPTbqOsN+ZUhlfMbwJ9wj0pT5RX8lSlFKvJdoRWsmnMfwhLminxQ64F02MEvfDjG4DIMBA==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <300C4215170E0F45A13A381817D9D07D@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 985105a3-ac78-445b-be78-08d7b473d326
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2020 13:09:45.3934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NmK1ao6J7KG2pJqFyEEFvbgFpp/bOAbPyGNpvU6CcFeCXKkAMUyR8la2KIqB2TfpYAaK9H5YxUPokPwU3EZzqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6582
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 18, 2020 at 05:53:56PM +0800, Zhu Yanjun wrote:
> Sorry, when max_rd_atomic will be set to 0?

User can set it.
ib_uverbs_ex_modify_qp()
 -> modify_qp()
  -> ib_modify_qp_with_udata()
   -> _ib_modify_qp()
    -> ib_security_modify_qp()
     -> .modify_q()
      -> rxe_modify_qp()
       -> rxe_qp_from_attr()

>
> Thanks,
> Zhu Yanjun
>
> On Tue, Feb 18, 2020 at 4:59 AM Bart Van Assche <bvanassche@acm.org> wrot=
e:
> >
> > From the comment above the definition of the roundup_pow_of_two() macro=
:
> >
> >      The result is undefined when n =3D=3D 0.
> >
> > Hence only pass positive values to roundup_pow_of_two(). This patch fix=
es
> > the following UBSAN complaint:
> >
> > UBSAN: Undefined behaviour in ./include/linux/log2.h:57:13
> > shift exponent 64 is too large for 64-bit type 'long unsigned int'
> > Call Trace:
> >  dump_stack+0xa5/0xe6
> >  ubsan_epilogue+0x9/0x26
> >  __ubsan_handle_shift_out_of_bounds.cold+0x4c/0xf9
> >  rxe_qp_from_attr.cold+0x37/0x5d [rdma_rxe]
> >  rxe_modify_qp+0x59/0x70 [rdma_rxe]
> >  _ib_modify_qp+0x5aa/0x7c0 [ib_core]
> >  ib_modify_qp+0x3b/0x50 [ib_core]
> >  cma_modify_qp_rtr+0x234/0x260 [rdma_cm]
> >  __rdma_accept+0x1a7/0x650 [rdma_cm]
> >  nvmet_rdma_cm_handler+0x1286/0x14cd [nvmet_rdma]
> >  cma_cm_event_handler+0x6b/0x330 [rdma_cm]
> >  cma_ib_req_handler+0xe60/0x22d0 [rdma_cm]
> >  cm_process_work+0x30/0x140 [ib_cm]
> >  cm_req_handler+0x11f4/0x1cd0 [ib_cm]
> >  cm_work_handler+0xb8/0x344e [ib_cm]
> >  process_one_work+0x569/0xb60
> >  worker_thread+0x7a/0x5d0
> >  kthread+0x1e6/0x210
> >  ret_from_fork+0x24/0x30
> >
> > Cc: Moni Shoua <monis@mellanox.com>
> > Fixes: 8700e3e7c485 ("Soft RoCE driver")
> > Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> > ---
> >  drivers/infiniband/sw/rxe/rxe_qp.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw=
/rxe/rxe_qp.c
> > index ec21f616ac98..6c11c3aeeca6 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_qp.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> > @@ -590,15 +590,16 @@ int rxe_qp_from_attr(struct rxe_qp *qp, struct ib=
_qp_attr *attr, int mask,
> >         int err;
> >
> >         if (mask & IB_QP_MAX_QP_RD_ATOMIC) {
> > -               int max_rd_atomic =3D __roundup_pow_of_two(attr->max_rd=
_atomic);
> > +               int max_rd_atomic =3D attr->max_rd_atomic ?
> > +                       roundup_pow_of_two(attr->max_rd_atomic) : 0;
> >
> >                 qp->attr.max_rd_atomic =3D max_rd_atomic;
> >                 atomic_set(&qp->req.rd_atomic, max_rd_atomic);
> >         }
> >
> >         if (mask & IB_QP_MAX_DEST_RD_ATOMIC) {
> > -               int max_dest_rd_atomic =3D
> > -                       __roundup_pow_of_two(attr->max_dest_rd_atomic);
> > +               int max_dest_rd_atomic =3D attr->max_dest_rd_atomic ?
> > +                       roundup_pow_of_two(attr->max_dest_rd_atomic) : =
0;
> >
> >                 qp->attr.max_dest_rd_atomic =3D max_dest_rd_atomic;
> >
