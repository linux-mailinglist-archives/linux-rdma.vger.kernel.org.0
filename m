Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24BA214B5E
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 15:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbfEFN6O (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 09:58:14 -0400
Received: from mail-eopbgr150089.outbound.protection.outlook.com ([40.107.15.89]:53236
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725853AbfEFN6O (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 May 2019 09:58:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUq6yj6flqvZKDL+sQkW7SAffNb7Co9ZgYk8cdQsvrk=;
 b=WhfYXB5s4/vmjrB344sXcRcP0S22tm2n1CnvX4Q03ZR2Vud2KI/NyUiPl/2PqORsuWNmhb7pBNNecW2jtsMci8diNesqIrGt+fZSmY6sn15JOlU2oI18N41ExZ69sXf8BR9o9stmjsI5DDHPWHh9hxPyLeU4LpKEiXDWbcGdw2Q=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6622.eurprd05.prod.outlook.com (20.178.126.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Mon, 6 May 2019 13:58:08 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044%5]) with mapi id 15.20.1856.012; Mon, 6 May 2019
 13:58:08 +0000
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
Thread-Index: AQHVARLft6YhcNgq2U2bxKGl+U/wYaZZKheAgAAowYCAAt+4gIAASTIAgAEu2QCAAHqxgA==
Date:   Mon, 6 May 2019 13:58:08 +0000
Message-ID: <20190506135803.GD6186@mellanox.com>
References: <1556707704-11192-1-git-send-email-galpress@amazon.com>
 <1556707704-11192-11-git-send-email-galpress@amazon.com>
 <20190502181425.GA28282@mellanox.com>
 <7de52e1f-7d4a-354f-a0f6-b8f7eb13ce35@amazon.com>
 <20190503121947.GB13315@mellanox.com>
 <ed36cf91-7420-2533-9202-fa1126bd467b@amazon.com>
 <20190505123500.GA30659@mellanox.com>
 <b471d491-99bf-fbae-7859-05e7b652de2c@amazon.com>
In-Reply-To: <b471d491-99bf-fbae-7859-05e7b652de2c@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQBPR0101CA0072.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::49) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.49.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5fa89295-c0be-471e-39c7-08d6d22ade8e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6622;
x-ms-traffictypediagnostic: VI1PR05MB6622:
x-microsoft-antispam-prvs: <VI1PR05MB66225E7DCCFC140E61AEA413CF300@VI1PR05MB6622.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(366004)(136003)(199004)(189003)(6486002)(1076003)(6246003)(5660300002)(6436002)(66446008)(64756008)(66556008)(66476007)(73956011)(52116002)(8936002)(66946007)(229853002)(8676002)(81156014)(81166006)(14454004)(76176011)(25786009)(4326008)(86362001)(316002)(478600001)(6506007)(386003)(66066001)(53546011)(53936002)(2616005)(476003)(256004)(186003)(36756003)(486006)(33656002)(2906002)(305945005)(6916009)(99286004)(102836004)(3846002)(71190400001)(71200400001)(6116002)(26005)(54906003)(7416002)(68736007)(7736002)(446003)(6512007)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6622;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XknR6wUY1/y2IkfB3vUHKrB+vfBo7g/tdwc93bcMIKaIcRPfkUMtlfVitx8bQUMWjVNwmrRAJHVY6ISSZZ0HDB2WwD5jNZB02kuURj9H9P2QvPbmJJ49sOiR+jqw7wud1gK7+ua7NDJOEkUwTMrLZozF7339nb6M5cORnO69M7vj57I8dXSZJTZhnZFw2bWOJmsv2tN13MsjTxECFSIKZjJcMqj2dY/wefqBxBMgmFUGQ6A0pZ/4G4BI3r43LVIWiSNUG0YG6faD+/R7PlCq3ShYkj/KTkbaETWaOrtvQOa1WrmhmG6y7khTCY/86Nw47ooVg+KbYlnqxv1cUfD2Y/Y2Q77DMk6+dyP6+MAtXqAAILcOkt3m8sNgRPLXQqIXk5VGdZN64e9V+8HJ3wFbBHaFMf5VU2E7H5s10+MOKr4=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B4F144E34DBAE046A1B9697781F06231@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa89295-c0be-471e-39c7-08d6d22ade8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 13:58:08.7238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6622
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 06, 2019 at 09:38:56AM +0300, Gal Pressman wrote:
> On 05-May-19 15:35, Jason Gunthorpe wrote:
> > On Sun, May 05, 2019 at 11:13:01AM +0300, Gal Pressman wrote:
> >> On 03-May-19 15:19, Jason Gunthorpe wrote:
> >>> On Fri, May 03, 2019 at 12:53:55PM +0300, Gal Pressman wrote:
> >>>> On 02-May-19 21:14, Jason Gunthorpe wrote:
> >>>>> On Wed, May 01, 2019 at 01:48:22PM +0300, Gal Pressman wrote:
> >>>>>
> >>>>>> +/* create a page buffer list from a mapped user memory region */
> >>>>>> +static int pbl_create(struct efa_dev *dev,
> >>>>>> +		      struct pbl_context *pbl,
> >>>>>> +		      struct ib_umem *umem,
> >>>>>> +		      int hp_cnt,
> >>>>>> +		      u8 hp_shift)
> >>>>>> +{
> >>>>>> +	int err;
> >>>>>> +
> >>>>>> +	pbl->pbl_buf_size_in_bytes =3D hp_cnt * EFA_CHUNK_PAYLOAD_PTR_SI=
ZE;
> >>>>>> +	pbl->pbl_buf =3D kzalloc(pbl->pbl_buf_size_in_bytes,
> >>>>>> +			       GFP_KERNEL | __GFP_NOWARN);
> >>>>>> +	if (pbl->pbl_buf) {
> >>>>>> +		pbl->physically_continuous =3D 1;
> >>>>>> +		err =3D umem_to_page_list(dev, umem, pbl->pbl_buf, hp_cnt,
> >>>>>> +					hp_shift);
> >>>>>> +		if (err)
> >>>>>> +			goto err_continuous;
> >>>>>> +		err =3D pbl_continuous_initialize(dev, pbl);
> >>>>>> +		if (err)
> >>>>>> +			goto err_continuous;
> >>>>>> +	} else {
> >>>>>> +		pbl->physically_continuous =3D 0;
> >>>>>> +		pbl->pbl_buf =3D vzalloc(pbl->pbl_buf_size_in_bytes);
> >>>>>> +		if (!pbl->pbl_buf)
> >>>>>> +			return -ENOMEM;
> >>>>>
> >>>>> This way to fallback seems ugly, I think you should just call kvzal=
loc
> >>>>> and check for continuity during the umem_to_page_list
> >>>>
> >>>> I've considered using kvzalloc, but it doesn't really fit this use c=
ase.
> >>>
> >>> It does, you just check for continuity when building the pbl instead
> >>> of assuming it based on how it was created. It isn't hard, and driver=
s
> >>> shouldn't abuse APIs like this
> >>
> >> This is by no means abusing the API..
> >=20
> > It is, vzalloc isn't just kzalloc followed by vzalloc and you
> > shouldn't expec the two to be the same. Most likely the above has bad
> > behavior if it triggers reclaim.
>=20
> Is it OK to call kvzalloc and test for is_vmalloc_addr?

Yes

Jason
