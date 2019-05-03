Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65B7A12D61
	for <lists+linux-rdma@lfdr.de>; Fri,  3 May 2019 14:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfECMT5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 May 2019 08:19:57 -0400
Received: from mail-eopbgr10061.outbound.protection.outlook.com ([40.107.1.61]:22201
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726495AbfECMT5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 3 May 2019 08:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNlojQyC+mBel6dcSIQLj6ALnw3P/u8/wWh0WyF2uYc=;
 b=aTdi1HWEfILvmU1Gc3xCnvWtCfCB8ZWg2XAbE1ePrJMMie5hc33sLdqKZduHBX4MIVHj9FJ7qVY8dg/S8+qTAvi3CpRXATcDaQrJm3+CBf0Qy9t5LF3WrZQixtQ4/NAt8uwtQR52nIdnNedWGq7Nk5SNs4IGxTRynQlB3jQdhe0=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4958.eurprd05.prod.outlook.com (20.177.51.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Fri, 3 May 2019 12:19:52 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044%5]) with mapi id 15.20.1856.008; Fri, 3 May 2019
 12:19:52 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     Doug Ledford <dledford@redhat.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Alexander Matushevsky <matua@amazon.com>,
        Leah Shalev <shalevl@amazon.com>,
        Dave Goodell <goodell@amazon.com>,
        Brian Barrett <bbarrett@amazon.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Sean Hefty <sean.hefty@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Parav Pandit <parav@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Steve Wise <larrystevenwise@gmail.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: Re: [PATCH for-next v6 10/12] RDMA/efa: Add EFA verbs implementation
Thread-Topic: [PATCH for-next v6 10/12] RDMA/efa: Add EFA verbs implementation
Thread-Index: AQHVARLft6YhcNgq2U2bxKGl+U/wYaZZKheAgAAowYA=
Date:   Fri, 3 May 2019 12:19:52 +0000
Message-ID: <20190503121947.GB13315@mellanox.com>
References: <1556707704-11192-1-git-send-email-galpress@amazon.com>
 <1556707704-11192-11-git-send-email-galpress@amazon.com>
 <20190502181425.GA28282@mellanox.com>
 <7de52e1f-7d4a-354f-a0f6-b8f7eb13ce35@amazon.com>
In-Reply-To: <7de52e1f-7d4a-354f-a0f6-b8f7eb13ce35@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR20CA0021.namprd20.prod.outlook.com
 (2603:10b6:208:e8::34) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [65.23.217.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9eb2b132-5e0b-4768-4d14-08d6cfc1a4bb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4958;
x-ms-traffictypediagnostic: VI1PR05MB4958:
x-microsoft-antispam-prvs: <VI1PR05MB4958B51F83D1D055CE042D08CF350@VI1PR05MB4958.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0026334A56
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(39860400002)(396003)(136003)(199004)(189003)(26005)(102836004)(478600001)(2616005)(229853002)(305945005)(7736002)(52116002)(14454004)(11346002)(6506007)(186003)(53546011)(486006)(6436002)(476003)(68736007)(54906003)(25786009)(2906002)(256004)(6486002)(6246003)(316002)(76176011)(446003)(36756003)(386003)(6916009)(3846002)(6116002)(81156014)(81166006)(8936002)(8676002)(99286004)(7416002)(66476007)(5660300002)(71190400001)(71200400001)(33656002)(66556008)(64756008)(66946007)(86362001)(66446008)(6512007)(73956011)(53936002)(66066001)(4326008)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4958;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tZAO7gFxPsm4wNpn2sQESvyIB0zeE6p7uaa3gke1YkOkMfZzMc61mFLHyuDfAjlgDFxHZPgJIOqfzKaxbn2LYbxlIEgyJSytq+BSdMs7FpJxImtzZbaLDcdbS9m3C9ub6UI1EIDWKqe9qKaYUDYtiA+9Hx+TvfPnpgjIS5ELeNWDL4OwC/9ZxZbcdYveFBPxq70OaoFaEhi9/m9GahHC5j+u6ypKNvyxI961wznVfXA3v4l3TzkoQogf18XENviXPo5D4WvMZT57h4U/zVa+T0MSYGSzplQLbs1fp0V1dlOIW3WxE6VEZY9Todg7tKBARNZwDlRgYfunrLTcdpHhAuxA5Y0S4eivJ0PobCmlxY9b+xp2RirDM5pcMC8scZOlXjRWepnEsMVBULHOtD5ThdOayEofKf45x8mNwplmSek=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3F3507AAC7652941B234D352376D5F31@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb2b132-5e0b-4768-4d14-08d6cfc1a4bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2019 12:19:52.1381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4958
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 03, 2019 at 12:53:55PM +0300, Gal Pressman wrote:
> On 02-May-19 21:14, Jason Gunthorpe wrote:
> > On Wed, May 01, 2019 at 01:48:22PM +0300, Gal Pressman wrote:
> >=20
> >> +/* create a page buffer list from a mapped user memory region */
> >> +static int pbl_create(struct efa_dev *dev,
> >> +		      struct pbl_context *pbl,
> >> +		      struct ib_umem *umem,
> >> +		      int hp_cnt,
> >> +		      u8 hp_shift)
> >> +{
> >> +	int err;
> >> +
> >> +	pbl->pbl_buf_size_in_bytes =3D hp_cnt * EFA_CHUNK_PAYLOAD_PTR_SIZE;
> >> +	pbl->pbl_buf =3D kzalloc(pbl->pbl_buf_size_in_bytes,
> >> +			       GFP_KERNEL | __GFP_NOWARN);
> >> +	if (pbl->pbl_buf) {
> >> +		pbl->physically_continuous =3D 1;
> >> +		err =3D umem_to_page_list(dev, umem, pbl->pbl_buf, hp_cnt,
> >> +					hp_shift);
> >> +		if (err)
> >> +			goto err_continuous;
> >> +		err =3D pbl_continuous_initialize(dev, pbl);
> >> +		if (err)
> >> +			goto err_continuous;
> >> +	} else {
> >> +		pbl->physically_continuous =3D 0;
> >> +		pbl->pbl_buf =3D vzalloc(pbl->pbl_buf_size_in_bytes);
> >> +		if (!pbl->pbl_buf)
> >> +			return -ENOMEM;
> >=20
> > This way to fallback seems ugly, I think you should just call kvzalloc
> > and check for continuity during the umem_to_page_list
>=20
> I've considered using kvzalloc, but it doesn't really fit this use case.

It does, you just check for continuity when building the pbl instead
of assuming it based on how it was created. It isn't hard, and drivers
shouldn't abuse APIs like this

Jason
