Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC71256C8
	for <lists+linux-rdma@lfdr.de>; Tue, 21 May 2019 19:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbfEURfW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 May 2019 13:35:22 -0400
Received: from mail-eopbgr50052.outbound.protection.outlook.com ([40.107.5.52]:34736
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726900AbfEURfW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 21 May 2019 13:35:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SgvSA/IDIEc6eFwMZKwtKiEP7hjR42C1RZE0e3e1EOU=;
 b=YeO+NDLj38xOTfc3yB9zahZfEHQTfNXLAaLyPrKtmqTahNYNXtV9NB2/aztGLlhYvUmoKJky+h0UzXOmTvBVWQmSWvdso0l8ILRgx/LKMPYkvj52UDCNEBH7r2EtW4yMorR+b4O5CW0uMlzSj3q0LJyl6CR/Sd1ZcM/UIgg/dSQ=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5248.eurprd05.prod.outlook.com (20.178.12.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.24; Tue, 21 May 2019 17:35:18 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1922.013; Tue, 21 May 2019
 17:35:18 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Glenn Streiff <gstreiff@neteffect.com>,
        Steve Wise <swise@opengridcomputing.com>
Subject: Re: [PATCH rdma-next 04/15] RDMA/efa: Remove check that prevents
 destroy of resources in error flows
Thread-Topic: [PATCH rdma-next 04/15] RDMA/efa: Remove check that prevents
 destroy of resources in error flows
Thread-Index: AQHVDtjuQBBHO2HSKkGy9VmU4u8onqZz9GwAgAAIigCAABTggIABx5AA
Date:   Tue, 21 May 2019 17:35:18 +0000
Message-ID: <20190521173514.GH2907@mellanox.com>
References: <20190520065433.8734-1-leon@kernel.org>
 <20190520065433.8734-5-leon@kernel.org>
 <a3358e40-9be4-0a7c-dab5-96573b646ded@amazon.com>
 <20190520131000.GJ4573@mtr-leonro.mtl.com>
 <161ad83d-cb50-d02a-8511-938b2b3b7156@amazon.com>
In-Reply-To: <161ad83d-cb50-d02a-8511-938b2b3b7156@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR01CA0027.prod.exchangelabs.com (2603:10b6:208:71::40)
 To VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.49.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aef0a64d-4802-4f7a-0d54-08d6de12b123
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5248;
x-ms-traffictypediagnostic: VI1PR05MB5248:
x-microsoft-antispam-prvs: <VI1PR05MB52487A377EB231D35F53498DCF070@VI1PR05MB5248.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(39860400002)(366004)(396003)(199004)(189003)(73956011)(66946007)(64756008)(66446008)(66476007)(66556008)(446003)(76176011)(5660300002)(52116002)(476003)(316002)(2616005)(11346002)(26005)(1076003)(33656002)(478600001)(486006)(53936002)(25786009)(68736007)(36756003)(4326008)(14454004)(2906002)(6436002)(54906003)(99286004)(8676002)(81166006)(71200400001)(66066001)(386003)(6506007)(6512007)(81156014)(71190400001)(6116002)(6916009)(7736002)(3846002)(186003)(6246003)(14444005)(256004)(305945005)(8936002)(102836004)(229853002)(86362001)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5248;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lOAzWUFMErcgDidmyIhiTXztF7iqtTkvPzTFzW8tgitXVVvrec4h0U93DN0gRsauQ9VPVI0K8A9zIeDul1Y9oj14cZwkD6m/nDZmIDPTvHGmtRP9PKL0RVIMKJfb9Sl6GKE2p1gFhKKI2i/1Q05z9tgdCTu1sE4VR3ck8H1SQhJs+Mn8EL8VlIUgfMr6NAc8Mrv2XMgJ6ltiDmab5b2yeZ0X5d9Pb8DRGf2BlDVxCt5gDmQX7rlpOfrbXULc40rdGuCCx9lTo0EVd/cHCSo/bQU9Bh6TsytU8A+0ftLqLcBK8qn7K3s0hCcc00z2Jma8/3mVMzCFKo0p8331TcuRb+HgJIMFZOyNhAV+QR2dzHauzKmLc0Hg3+zPoKqPk+VZQTnN4q9ZNgwlWGjJZnBWFmRE14MzUr32G2Z0hOL8HKg=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <94EB2003560CE642AE2877A43C6A33E1@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aef0a64d-4802-4f7a-0d54-08d6de12b123
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 17:35:18.8482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5248
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 20, 2019 at 05:24:43PM +0300, Gal Pressman wrote:

> >>> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> >>>  drivers/infiniband/hw/efa/efa_verbs.c | 24 ------------------------
> >>>  1 file changed, 24 deletions(-)
> >>>
> >>> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniba=
nd/hw/efa/efa_verbs.c
> >>> index 6d6886c9009f..4999a74cee24 100644
> >>> +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> >>> @@ -436,12 +436,6 @@ void efa_dealloc_pd(struct ib_pd *ibpd, struct i=
b_udata *udata)
> >>>  	struct efa_dev *dev =3D to_edev(ibpd->device);
> >>>  	struct efa_pd *pd =3D to_epd(ibpd);
> >>>
> >>> -	if (udata->inlen &&
> >>> -	    !ib_is_udata_cleared(udata, 0, udata->inlen)) {
> >>> -		ibdev_dbg(&dev->ibdev, "Incompatible ABI params\n");
> >>> -		return;
> >>> -	}

Regardless of the issue of udata validity, these checks still cannot
be here.

We are moving the whole core to not return error codes from driver
object destroy - because destroy is not allowed to fail in many flows.

So, drivers do not have the option to validate the udata and fail
destroy at this point. If it ever comes up, then we will need to split
validation into another step on the uapi path that is done before
invoking the actual destroy function.

Generally speaking this means a driver should never use a classical
udata for destroy.

Instead its provider should call destroy via the new-style ioctl API
and the kernel should define a proper schema that is checked before we
even reach the driver.

Jason
