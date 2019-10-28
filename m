Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3A46E77FB
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 19:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732425AbfJ1SAB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 14:00:01 -0400
Received: from mail-eopbgr20068.outbound.protection.outlook.com ([40.107.2.68]:55268
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729738AbfJ1SAB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 28 Oct 2019 14:00:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lW6WhYLc3Hr/9dIG1L4AsWJqtskewmNt5eVSaB4x4ASO7ng/bp0L9pW4PJaUH5jflLGeB5M5DjwYAy8kNV1V7L1CRD5dTY4Gf9FPnjkIHYmsCkoF/mdbnEdspDu0VGQPwL++A6wTqz4XxFaFD+RDGOq6mXUF2b5avFRzHqUGNE8U5G+bisY0dYwxDwFpr+I1UHvoeTm/TV6u5rJZrxNOL5GwsC70jtliIHQ7qpOP2We742uerMhMfnThrDQ7lRoWSWThaqeIfEVkUXe7FdPCXepEbC4hYgmKBdyFeM2GzQ+HDI1bslNKkNtT+VFAvzcTxlaQFo0H5FVvknVSVZzi+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqu2FpyUTK1+F8cgXjgWSn1EkN06MpbIpLOTmRUuLno=;
 b=ZKWpfZUCUsfKtYvYd49vP+eZ3Rw2833M51/hSfioh4akLcJZqInTuzKPFu+HybyPsVPRIwsnWmkLkvJXrZbdEwelPUc5CBZW5KjJwNKm7jwPadk9xhZIfjPaSqUtdyB2XnVmeK8BM3aIe879pS1Q00//6Lrl/b4+0XCcOpT/iqDCcp4PKjLXqCYkqPu9XTmvWSp0AYjaPGvprSLsljHFUZuizXI0XzGyooWcaSUcyEcIIkGaXn911l5Wlqk82kUvhhBxVlCnz9buBf0kkLyBa3n6+bTq6B4SxwdWcFBM/pLxubxDfYku11lUYkWThL+c9z0boWYwYK/GPfqBC19mag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqu2FpyUTK1+F8cgXjgWSn1EkN06MpbIpLOTmRUuLno=;
 b=KXB4Ch48NbqtEbkv35w/7+ayo9oPBjuAJXl38h6aFlmJRrAyCRfHBR/0sypfQD3RxYjJS8rvlxmJz9TSkEBDqmpOgL0jj6rTzdoj169gGZr5z2BSd8AE+IlQ0zIR15Vz2Xr6L8pu/N6O6fwY7d2A096aA4AXP1cIAbFmSXRVayA=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB3422.eurprd05.prod.outlook.com (10.170.235.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Mon, 28 Oct 2019 17:59:56 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d%5]) with mapi id 15.20.2387.025; Mon, 28 Oct 2019
 17:59:56 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Or Gerlitz <gerlitz.or@gmail.com>,
        Doug Ledford <dledford@redhat.com>,
        Michael Guralnik <michaelgur@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next v1] IB/mlx5: Test write combining support
Thread-Topic: [PATCH rdma-next v1] IB/mlx5: Test write combining support
Thread-Index: AQHVjI71Izu0ilY3a0G1h+quMtG1H6dwEMWAgAAIHYCAAED/gA==
Date:   Mon, 28 Oct 2019 17:59:56 +0000
Message-ID: <20191028175953.GY22766@mellanox.com>
References: <20191027062234.10993-1-leon@kernel.org>
 <CAJ3xEMiV-ufcJST70i7J1UOkmx2tV=kc77GiRYKX8Yq4UyXpZQ@mail.gmail.com>
 <20191028140715.GJ5146@unreal>
In-Reply-To: <20191028140715.GJ5146@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR17CA0026.namprd17.prod.outlook.com
 (2603:10b6:405:75::15) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 92c0d236-2d9d-4b00-932e-08d75bd0a477
x-ms-traffictypediagnostic: VI1PR05MB3422:|VI1PR05MB3422:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB34221EB1C5AF74363E2D6085CF660@VI1PR05MB3422.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(199004)(189003)(256004)(26005)(1076003)(4744005)(11346002)(4326008)(6486002)(2616005)(81166006)(33656002)(64756008)(66946007)(66556008)(66476007)(66446008)(316002)(476003)(386003)(6506007)(486006)(8936002)(99286004)(36756003)(6116002)(3846002)(2906002)(478600001)(186003)(305945005)(71200400001)(25786009)(53546011)(6512007)(71190400001)(6436002)(5660300002)(446003)(66066001)(6246003)(102836004)(54906003)(86362001)(81156014)(6916009)(76176011)(14454004)(52116002)(229853002)(8676002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3422;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tcBYEpLVhgt0rWsdrolTa3g6n7Q3YZVTZiOT741hXOpSpMGeulPgIMt/r8onhWyPQUaHYQuehFtiB2QaoVWTU4fgdXTFOZ/L8HCw97Q++FgaTgJud6j8B+1jo4MRzwkbfC3+Os2FYNIrKPccObyXIvTLyxtKMoSzncIjg4hQouXEsbJcnziVJxL+fMBIIsyynfbz7HGPJ9wR30DLPGx8ZlQR27yszdMDfMgc2w522HLoaginGEpIkM5kICDgqvloaI6ZThXBE8yIHywunc4mPGNzcXw88xf0T4PuPx6xIZWv818pWRWfvNuXlOEC8ZX15h9J/nQqtNnX85b/r0O3NsFPaEDqu4KGe0wWEG7c/Qp5gjHAuDks56ppdSSwYT7nYSgvtH0tLrDyEtGQbruKNsSeKdshezQTXJXtW8cWTXea14P14RwqIC2im17kvu7P
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C04FD4422A1CAA46A13DD3017E3805CB@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c0d236-2d9d-4b00-932e-08d75bd0a477
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 17:59:56.9517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h1fUxw65x6i/lF3+tYx47vvoP/vpZbkoPo9XtCLOIZEPQ5F3xcspvSEWuhYo/ku8GY3xBUnVxRD7/aaccsTxHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3422
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 28, 2019 at 04:07:15PM +0200, Leon Romanovsky wrote:
> On Mon, Oct 28, 2019 at 03:38:13PM +0200, Or Gerlitz wrote:
> > On Sun, Oct 27, 2019 at 8:29 AM Leon Romanovsky <leon@kernel.org> wrote=
:
> > >
> > > From: Michael Guralnik <michaelgur@mellanox.com>
> > >
> > > Add a test in mlx5_ib initialization process to test whether
> > > write-combining is supported on the machine.
> > > The test will run as part of the enable_driver callback to ensure tha=
t
> > > the test runs after the device is setup and can create and modify the
> > > QP needed, but runs before the device is exposed to the users.
> > >
> > > The test opens UD QP and posts NOP WQEs, the WQE written to the BlueF=
lame
> > > is differnet from the WQE in memory, requesting CQE only on the BlueF=
lame
> >
> > nit: different
>=20
> Thanks, Jason/Doug should I resend?

No, I usually fix stuff like that anyhow

Jason
