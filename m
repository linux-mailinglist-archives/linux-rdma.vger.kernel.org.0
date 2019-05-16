Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8CC420F17
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2019 21:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfEPTNE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 May 2019 15:13:04 -0400
Received: from mail-eopbgr130041.outbound.protection.outlook.com ([40.107.13.41]:59888
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728022AbfEPTNC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 May 2019 15:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXuO6IggD9heUcJAc78fxxPowkF6SLyFQQHvUimAphc=;
 b=XoNcZO20HKrcAY3H7dTaYUKOiT+Ysdq1MAVlEkpzOisut/MCK7e5BR0LH10ONEafoqlKmrg90LuWf2/MWPHgO1rarMrk10ApYQ73+NGB1c6EHvvzDqTM6fNHpdDOJI3DDkKWRErZHBaFW9Al6fMvXgsAULQrq/uoZZZVD7AIhWk=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB3294.eurprd05.prod.outlook.com (10.170.238.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Thu, 16 May 2019 19:12:59 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1900.010; Thu, 16 May 2019
 19:12:59 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Adit Ranadive <aditr@vmware.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        Bryan Tan <bryantan@vmware.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Pv-drivers <Pv-drivers@vmware.com>
Subject: Re: [PATCH for-next] RDMA/vmw_pvrdma: Use resource ids from physical
 device if available
Thread-Topic: [PATCH for-next] RDMA/vmw_pvrdma: Use resource ids from physical
 device if available
Thread-Index: AQHVDBSlkap1QWBkwEm57ccCex0bMqZuEk2AgAAIp4CAAAObgA==
Date:   Thu, 16 May 2019 19:12:59 +0000
Message-ID: <20190516191253.GJ22573@mellanox.com>
References: <1558031071-14110-1-git-send-email-aditr@vmware.com>
 <20190516182901.GH22573@mellanox.com>
 <9b951e0f-e662-197a-8af2-a0fd57744aee@vmware.com>
In-Reply-To: <9b951e0f-e662-197a-8af2-a0fd57744aee@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQBPR0101CA0066.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::43) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.49.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7bb01610-24cc-45c0-fb7d-08d6da328236
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB3294;
x-ms-traffictypediagnostic: VI1PR05MB3294:
x-microsoft-antispam-prvs: <VI1PR05MB329496122267E0913FE4FAFACF0A0@VI1PR05MB3294.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(396003)(136003)(376002)(199004)(189003)(316002)(86362001)(6436002)(54906003)(8936002)(14454004)(53936002)(81166006)(6512007)(33656002)(99286004)(81156014)(76176011)(4326008)(102836004)(52116002)(6486002)(6916009)(8676002)(6506007)(386003)(66066001)(6246003)(478600001)(229853002)(256004)(14444005)(25786009)(36756003)(26005)(486006)(476003)(2616005)(186003)(11346002)(446003)(2906002)(5660300002)(1076003)(71190400001)(71200400001)(68736007)(7736002)(6116002)(64756008)(305945005)(66946007)(66476007)(66556008)(66446008)(73956011)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3294;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: e5UHcwmIrX72A1LSbEVu9H3GdD4bg8Soc90tkM1K/h4NaMmSeH7wmzJsC+MmKz2870TKaQvSYPHlxp3E7hY/OV4DW7xZzBG+ikdV3qfogKdokPFeWmj4p5n19x2dPLU9Hl/oZOIgY/HP7MPnTI3tKdRCuuh042TDOcGDrNwSIKH4GKZ6EYaq9+oiNoz9NldniuwfQ+2+tht928b1j4FlCv2afBsPlpLjO6uSFmiZ2oFQhMdyuecWdNwP+Kqo8rNMmkksEqEJRiZAz0Fs2Rd7UKgnuXnTKrJPMWvfs+xFMoKVnE/b/LC7DR1SJhEOMWikqLI3dfjS6G2sF8kmFmA610Wk+kA3UERGCx5p3hD/qTUijfUhr/NzPQn3Vdt3lUcsnKrW0FgxqhFz+W3YY27foBm823UvgQav7Cqbq5sItqs=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E9731A328501FC4EABD37BBE678A1EB3@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bb01610-24cc-45c0-fb7d-08d6da328236
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 19:12:59.0273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3294
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 16, 2019 at 06:59:45PM +0000, Adit Ranadive wrote:
> >> diff --git a/include/uapi/rdma/vmw_pvrdma-abi.h b/include/uapi/rdma/vm=
w_pvrdma-abi.h
> >> index 6e73f0274e41..8ebab11dadcb 100644
> >> +++ b/include/uapi/rdma/vmw_pvrdma-abi.h
> >> @@ -49,7 +49,9 @@
> >> =20
> >>  #include <linux/types.h>
> >> =20
> >> -#define PVRDMA_UVERBS_ABI_VERSION	3		/* ABI Version. */
> >> +#define PVRDMA_UVERBS_NO_QP_HANDLE_ABI_VERSION	3
> >> +#define PVRDMA_UVERBS_ABI_VERSION		4	/* ABI Version. */
> >=20
> > Don't mess with ABI version when all you are doing is making the
> > response or request struct longer.
>=20
> Hmm, I thought we always had to update the ABI in case of such
> changes as well?

No. Only if you break the ABI. Don't break the ABI.

> Previously, we weren't copying out qpresp to udata at all and this
> adds a new response to user-space.  Also, wouldn't older rdma-core
> probably break because of this since it assumes the qpn reported is
> the virtual one? I guess that's a bug already from a backward compat
> perspective..

Indeed, don't break the ABI :)

Jason
