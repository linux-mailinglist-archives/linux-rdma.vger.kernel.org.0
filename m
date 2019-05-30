Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6553D301AA
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2019 20:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfE3SR0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 May 2019 14:17:26 -0400
Received: from mail-eopbgr10064.outbound.protection.outlook.com ([40.107.1.64]:13275
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725961AbfE3SR0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 May 2019 14:17:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLbXKLY4Thbfw1+bnmqaJTdNTLw3WKuCULnYdRkjG2c=;
 b=JNzCEcnD4Toi5TATeuJptJekdbYLts7hvx5riJZOgNilyGxnCHFxRWV/US9ENxhlyOa3IUGdxvQFCbkEdq6bs5of+mPHMHCGPzc0VhbxFJ6OeM534sBhg2t7ndLkFHubpFJ5poN+OimI6wmQdeREpYpxhDpkAoVCv5c14GT0Dw4=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5517.eurprd05.prod.outlook.com (20.177.200.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.18; Thu, 30 May 2019 18:17:22 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1943.016; Thu, 30 May 2019
 18:17:22 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Yuval Shaia <yuval.shaia@oracle.com>
CC:     Michal Kalderon <mkalderon@marvell.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v3 rdma-core] verbs: Introduce a new reg_mr API for
 virtual address space
Thread-Topic: [PATCH v3 rdma-core] verbs: Introduce a new reg_mr API for
 virtual address space
Thread-Index: AQHVFq3BD+IbLFlwDUGZa6Hf17rhnqaDm3oAgAAg2oCAAD4jgA==
Date:   Thu, 30 May 2019 18:17:21 +0000
Message-ID: <20190530181717.GP13461@mellanox.com>
References: <20190530060539.7136-1-yuval.shaia@oracle.com>
 <MN2PR18MB3182E08DB0E164C6BE6C409FA1180@MN2PR18MB3182.namprd18.prod.outlook.com>
 <20190530143452.GA19236@lap1>
In-Reply-To: <20190530143452.GA19236@lap1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR12CA0011.namprd12.prod.outlook.com
 (2603:10b6:208:a8::24) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bde6e28f-4739-4f6d-67ad-08d6e52b0ed4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5517;
x-ms-traffictypediagnostic: VI1PR05MB5517:
x-microsoft-antispam-prvs: <VI1PR05MB5517FB12C90217A9BDF4AFA2CF180@VI1PR05MB5517.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00531FAC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(346002)(136003)(396003)(199004)(189003)(478600001)(316002)(68736007)(5660300002)(1076003)(26005)(66556008)(73956011)(66946007)(66066001)(66446008)(64756008)(71190400001)(2616005)(11346002)(66476007)(446003)(186003)(486006)(14454004)(14444005)(256004)(6512007)(6486002)(6116002)(6436002)(476003)(99286004)(54906003)(6246003)(81166006)(36756003)(71200400001)(8676002)(305945005)(229853002)(7736002)(3846002)(33656002)(2906002)(81156014)(86362001)(6916009)(53936002)(52116002)(25786009)(386003)(76176011)(6506007)(4326008)(8936002)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5517;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HZU4Ekr3XoLz8eP4j+zsZp2+0eNRhhJ0O0HrzD/mgaSJsDOliyD6/F8pgAirBlyMlofKYl6ZoiZQpyb/WtlI27jTa/ydImkpu7OEkPCj09mZ6d7JiG5WwAGc+OQXYQiBjhjEa7KGUH5S+NpLes9LcXI9J0xg+xLkmvcLf0M+Sm4/mP1SrjfpdfVAFo/Bj2icEch4xEbKnMGyoqAH5Tp/1mVUc/pm57z56RcfzFW08eNQnuPtEIjl5i2rQyVngXHA4kMYQ+jx1MtkKSKPH00IXwpKy+hSgDEnS2ClcG8bmQhTSbBadw12srup6h1ixItbzYoJSKKjg5wjFnTbDTg+mOEAde0aZXNQanNxh4ZRaiItBNhhaIBVxT0pgVALg4uEWFDs5ot/z95ORgu+G+pEj/XZq9QaxNADX3xonAXNZBg=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9D7C76603AABF545BB6A9343DB1275AA@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bde6e28f-4739-4f6d-67ad-08d6e52b0ed4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2019 18:17:21.9326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5517
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 30, 2019 at 05:34:53PM +0300, Yuval Shaia wrote:
> On Thu, May 30, 2019 at 12:37:18PM +0000, Michal Kalderon wrote:
> > > From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> > > owner@vger.kernel.org> On Behalf Of Yuval Shaia
> > >=20
> > > The virtual address that is registered is used as a base for any addr=
ess passed
> > > later in post_recv and post_send operations.
> > >=20
> > > On a virtualized environment this is not correct.
> > >=20
> > > A guest cannot register its memory so hypervisor maps the guest physi=
cal
> > > address to a host virtual address and register it with the HW. Later =
on, at
> > > datapath phase, the guest fills the SGEs with addresses from its addr=
ess
> > > space.
> > > Since HW cannot access guest virtual address space an extra translati=
on is
> > > needed to map those addresses to be based on the host virtual address=
 that
> > > was registered with the HW.
> > > This datapath interference affects performances.
> > >=20
> > > To avoid this, a logical separation between the address that is regis=
tered and
> > > the address that is used as a offset at datapath phase is needed.
> > > This separation is already implemented in the lower layer part
> > > (ibv_cmd_reg_mr) but blocked at the API level.
> > >=20
> > > Fix it by introducing a new API function which accepts an address fro=
m guest
> > > virtual address space as well, to be used as offset for later datapat=
h
> > > operations.
> > >=20
> > Could you give an example of how an app would use this new API? How wil=
l
> > It receive the new hca_va addresss ?=20
>=20
> In my use case an application is device emulation that runs in the contex=
t
> of a userspace process in the host.
> This (virtual) device receives from guest driver a dma address (in form o=
f
> scatter-gather list) along with guest user-space virtual address.=20

How do you handle the scatter-gather list?

Jason
