Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D33DB46EAC
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Jun 2019 09:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbfFOHMi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Jun 2019 03:12:38 -0400
Received: from mail-eopbgr70089.outbound.protection.outlook.com ([40.107.7.89]:41947
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725828AbfFOHMi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 15 Jun 2019 03:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Swih4FYc82qBLXxT8o6+ulKgup/1alXQeOXBJ3dcpZQ=;
 b=XqPZTecAM9oAzl5OM7/hYxsLpGkZsd3YXOGXebI651JXXwmtyJ0WL7lUkfei+IrRpTe8S/CeblkQbKmoBnpr6rhJlfe/GSJ59ltndTciYn1SPiOhl2d1Lx+PE8xkGhdA9iAl4ppO8WBMQnDKlCLTwzp368PLjOZY7NLeYQORBBQ=
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com (10.171.186.14) by
 AM4PR05MB3185.eurprd05.prod.outlook.com (10.171.188.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Sat, 15 Jun 2019 07:12:27 +0000
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::bc5a:ba8b:1a69:91b6]) by AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::bc5a:ba8b:1a69:91b6%6]) with mapi id 15.20.1987.013; Sat, 15 Jun 2019
 07:12:27 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Doug Ledford <dledford@redhat.com>
CC:     Colin Ian King <colin.king@canonical.com>,
        Gal Pressman <galpress@amazon.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: RDMA: Clean destroy CQ in drivers do not return errors
Thread-Topic: RDMA: Clean destroy CQ in drivers do not return errors
Thread-Index: AQHVIrlo0Ha/lYZPxkOD3nwuzZMhyaabjl4AgAC/iwA=
Date:   Sat, 15 Jun 2019 07:12:27 +0000
Message-ID: <20190615071224.GA4694@mtr-leonro.mtl.com>
References: <68d62660-902c-ca49-20fd-32e92830faa7@canonical.com>
 <ee0c017e93e28317791b7395e257801a208c7306.camel@redhat.com>
In-Reply-To: <ee0c017e93e28317791b7395e257801a208c7306.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM7PR03CA0028.eurprd03.prod.outlook.com
 (2603:10a6:20b:130::38) To AM4PR05MB3137.eurprd05.prod.outlook.com
 (2603:10a6:205:3::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [37.142.3.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57c18133-5702-4ada-b459-08d6f160d295
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM4PR05MB3185;
x-ms-traffictypediagnostic: AM4PR05MB3185:
x-microsoft-antispam-prvs: <AM4PR05MB3185B4FC092A7DBCBF846511B0E90@AM4PR05MB3185.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0069246B74
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(39860400002)(346002)(376002)(199004)(189003)(8676002)(71200400001)(71190400001)(73956011)(386003)(6506007)(52116002)(68736007)(99286004)(33656002)(229853002)(2906002)(186003)(6486002)(76176011)(102836004)(14454004)(26005)(6436002)(316002)(54906003)(478600001)(6916009)(256004)(486006)(476003)(3846002)(11346002)(6116002)(25786009)(446003)(4326008)(1076003)(66066001)(5660300002)(86362001)(53936002)(6246003)(8936002)(9686003)(64756008)(66556008)(66476007)(66446008)(66946007)(81166006)(81156014)(6512007)(7736002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR05MB3185;H:AM4PR05MB3137.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Pcs//go+y2P3i4orFTDScVm/gN0caT2aWTz4NI6ZWShvJUAWzZGrG0+AQqDQzQBzt0Jn826LQDu8SuJCx/pH7BtQMU2h5pkAgF+KGCjNdPDF1DNbP8FqXxLUgfNTvA6/H6lCduJIhGV3s4UyVNHU9ObtOCaNq2vI/TuEe19ANwq6Dxb/6SDlPFndqP3Byv5ArBFbHo8F1YKDVn1L+fGWwTQLDPHL914RqWSA7uV4r++tB/Am61M7oGz+lSIs4GxUQhkn7LnvlE2pbnka1dY8oy8S5fFYmZjCUzfRvzLYVsptw4WlKi9en+dF5i87XyqMpJGfweatRDS8tjpI5odpRwlJEJaRiS78HPjDx0cnAWWotgCxIlJIMv5z4TNc6PyWoxf43zijIRZCxGrYsug/Vo7WBlhdCV9p/iHlIclAalg=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C2621CA764179B4DAA30AD367EA0F07E@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c18133-5702-4ada-b459-08d6f160d295
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2019 07:12:27.8370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leonro@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3185
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 14, 2019 at 03:46:50PM -0400, Doug Ledford wrote:
> On Fri, 2019-06-14 at 14:59 +0100, Colin Ian King wrote:
> > Hi,
> >
> > Static analysis with Coverity reported an issue with the following
> > commit:
> >
> > commit a52c8e2469c30cf7ac453d624aed9c168b23d1af
> > Author: Leon Romanovsky <leonro@mellanox.com>
> > Date:   Tue May 28 14:37:28 2019 +0300
> >
> >     RDMA: Clean destroy CQ in drivers do not return errors
> >
> > In function bnxt_re_destroy_cq() contains the following:
> >
> >         if (!cq->umem)
> >                 ib_umem_release(cq->umem);
>
> Given that the original test that was replaced was:
> 	if (!IS_ERR_OR_NULL(cq->umem))
>
> we aren't really worried about a null cq, just that umem is valid.  So,
> the logic is inverted on the test (or possibly we shouldn't have
> replaced !IS_ERR_OR_NULL(cq->umem) at all).

I took a very brief look and think that the better way will be to put
this "if (null)" check inside ib_umem_release() and make unconditional
call to that function in all call sites.

>
> But on closer inspection, the bnxt_re specific portion of this patch
> appears to have another problem in that it no longer checks the result
> of bnxt_qplib_destroy_cq() yet it does nothing to keep that function
> from failing.

It was intentional for two reasons. First, bnxt_re already had exactly
same logic without any checks of returned call inside bnxt_re_create_cq().
Second, we need to release kernel memory without any relation to HW state.

Maybe I should move bnxt_qplib_free_hwq() to be immediately after
bnxt_qplib_rcfw_send_message() inside of bnxt_qplib_destroy_cq()?

>
> Leon, can you send a followup fix?

Sure, I'll do it tomorrow.

>
> > Coverity detects this as a deference after null check on the null
> > pointer cq->umem:
> >
> > "var_deref_model: Passing null pointer cq->umem to ib_umem_release,
> > which dereferences it"
> >
> > Is the logic inverted on that null check?
> >
> > Colin
>
> --
> Doug Ledford <dledford@redhat.com>
>     GPG KeyID: B826A3330E572FDD
>     Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57
> 2FDD


