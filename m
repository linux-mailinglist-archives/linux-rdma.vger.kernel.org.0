Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0780516631
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2019 17:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfEGPEd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 May 2019 11:04:33 -0400
Received: from mail-eopbgr150081.outbound.protection.outlook.com ([40.107.15.81]:59360
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725843AbfEGPEc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 7 May 2019 11:04:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NpLqPOiQRU6VN/31kkL4I7hCD0JwkjdFxzX9JmM9yM=;
 b=eOCSljQgPoaQY+CNObAdoMn6dnCvWsb8cvt66bAdeMy6JBHw/jA630rzPdFbo1+hCKwqBkBt2lP0YP1e4hYOA4WJhVuWTb9XYx+2E7V0X8QJ/YofU+Wq/9ZaxDc5V9PRh7WUMxYKWV/aGee8amI4RZMoue1buCOBgfyhhxqsmos=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5296.eurprd05.prod.outlook.com (20.178.12.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Tue, 7 May 2019 15:04:28 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044%5]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 15:04:28 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Max Gurtovoy <maxg@mellanox.com>
CC:     Leon Romanovsky <leonro@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "hch@lst.de" <hch@lst.de>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        Israel Rukshin <israelr@mellanox.com>,
        Idan Burstein <idanb@mellanox.com>,
        Oren Duer <oren@mellanox.com>,
        Vladimir Koushnir <vladimirk@mellanox.com>,
        Shlomi Nimrodi <shlomin@mellanox.com>
Subject: Re: [PATCH 00/25 V4] Introduce new API for T10-PI offload
Thread-Topic: [PATCH 00/25 V4] Introduce new API for T10-PI offload
Thread-Index: AQHVBNo/qvTIRu6NOEydCCWllJ7Of6Zfq6qAgAADiQCAAAO8AIAAAqUAgAANBQA=
Date:   Tue, 7 May 2019 15:04:27 +0000
Message-ID: <20190507150422.GD6186@mellanox.com>
References: <1557236319-9986-1-git-send-email-maxg@mellanox.com>
 <20190507134217.GX6186@mellanox.com>
 <2e3d9da7-d4fa-e2fa-5d3b-e60c54e7f7ba@mellanox.com>
 <20190507140818.GZ6186@mellanox.com>
 <1378a723-81c8-63f3-c863-2e7b130eccd0@mellanox.com>
In-Reply-To: <1378a723-81c8-63f3-c863-2e7b130eccd0@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: QB1PR01CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::35) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.49.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34e8af55-cfd8-4903-03dd-08d6d2fd4ccb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5296;
x-ms-traffictypediagnostic: VI1PR05MB5296:
x-microsoft-antispam-prvs: <VI1PR05MB5296463BEC662D9AE999747ACF310@VI1PR05MB5296.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(376002)(346002)(136003)(189003)(199004)(66066001)(102836004)(11346002)(229853002)(2616005)(5660300002)(71200400001)(107886003)(71190400001)(186003)(52116002)(6246003)(99286004)(256004)(26005)(73956011)(6116002)(14444005)(3846002)(446003)(386003)(6506007)(6486002)(6862004)(6436002)(476003)(66476007)(6636002)(66556008)(64756008)(66446008)(53936002)(66946007)(53546011)(486006)(37006003)(7736002)(8676002)(25786009)(36756003)(305945005)(68736007)(6512007)(478600001)(4326008)(33656002)(81166006)(81156014)(2906002)(8936002)(86362001)(76176011)(316002)(14454004)(54906003)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5296;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ML7u+lwhhnLP1479y+NZ7q4oNMBrzaLoVY5b+t8VYLUJCSENxS26vfLWAVwLzLN+A8zu5YhR8ptw4Ep4EYq11Pl2ycFZs8NYh4sn6aJKZrSUXElCNiY9ISks7wAhzjkhTA0FJVy22E10qoyfur1kPY9vPMVqHMJK0rwduoO04vHkOFeuFTyFMO0wLIJQIww2Uu9S5Yc4Yhg1+QYBTcqNCtTGdtsxba8ilZ/9CsyfhfFXZS1DU38+Ssn9DwrlKj3co/MD2kojTfPj1uzHVOkfd55pWD8pi/hni+/7bFEcyfy2DpdBh0575g3mvwMoXts4vBJgNIH0GoY3yay721IOrVteT0bmddiGX6tlTkHDmIXIGQuPQtzHWbtQE3+zODxGsu/ZiVOOUjFwViezK8IZpZl+2agFcSBDfpXLuhduHpY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D4B00AAE85AE394182975F789877FE7E@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34e8af55-cfd8-4903-03dd-08d6d2fd4ccb
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 15:04:27.9317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5296
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 07, 2019 at 05:17:46PM +0300, Max Gurtovoy wrote:
>=20
> On 5/7/2019 5:08 PM, Jason Gunthorpe wrote:
> > On Tue, May 07, 2019 at 04:54:56PM +0300, Max Gurtovoy wrote:
> > > On 5/7/2019 4:42 PM, Jason Gunthorpe wrote:
> > > > On Tue, May 07, 2019 at 04:38:14PM +0300, Max Gurtovoy wrote:
> > > > > Israel Rukshin (12):
> > > > >     RDMA/core: Introduce IB_MR_TYPE_INTEGRITY and ib_alloc_mr_int=
egrity
> > > > >       API
> > > > >     IB/iser: Refactor iscsi_iser_check_protection function
> > > > >     IB/iser: Use IB_WR_REG_MR_INTEGRITY for PI handover
> > > > >     IB/iser: Unwind WR union at iser_tx_desc
> > > > >     IB/iser: Remove unused sig_attrs argument
> > > > >     IB/isert: Remove unused sig_attrs argument
> > > > >     RDMA/core: Add an integrity MR pool support
> > > > >     RDMA/rw: Fix doc typo
> > > > >     RDMA/rw: Print the correct number of sig MRs
> > > > >     RDMA/rw: Use IB_WR_REG_MR_INTEGRITY for PI handover
> > > > >     RDMA/core: Remove unused IB_WR_REG_SIG_MR code
> > > > >     RDMA/mlx5: Improve PI handover performance
> > > > >=20
> > > > > Max Gurtovoy (13):
> > > > >     RDMA/core: Introduce new header file for signature operations
> > > > >     RDMA/core: Save the MR type in the ib_mr structure
> > > > >     RDMA/core: Introduce ib_map_mr_sg_pi to map data/protection s=
gl's
> > > > >     RDMA/core: Add signature attrs element for ib_mr structure
> > > > >     RDMA/mlx5: Implement mlx5_ib_map_mr_sg_pi and
> > > > >       mlx5_ib_alloc_mr_integrity
> > > > >     RDMA/mlx5: Add attr for max number page list length for PI op=
eration
> > > > >     RDMA/mlx5: Pass UMR segment flags instead of boolean
> > > > >     RDMA/mlx5: Update set_sig_data_segment attribute for new sign=
ature API
> > > > >     RDMA/mlx5: Introduce and implement new IB_WR_REG_MR_INTEGRITY=
 work
> > > > >       request
> > > > >     RDMA/mlx5: Move signature_en attribute from mlx5_qp to ib_qp
> > > > >     RDMA/core: Validate signature handover device cap
> > > > >     RDMA/rw: Add info regarding SG count failure
> > > > >     RDMA/mlx5: Use PA mapping for PI handover
> > > > Max this is really too many patches now, can you please split this
> > > > up.
> > > >=20
> > > > Can several patches be applied right now as bug fixes like:
> > > >=20
> > > >      RDMA/rw: Fix doc typo
> > > >      RDMA/rw: Print the correct number of sig MRs
> > > >      RDMA/core: Remove unused IB_WR_REG_SIG_MR code
> > > >      RDMA/rw: Add info regarding SG count failure
> > > >=20
> > > > ??
> > > Yes we can. Except of "RDMA/core: Remove unused IB_WR_REG_SIG_MR code=
".
> > >=20
> > > Patches that also can be merged now are:
> > >=20
> > > "IB/iser: Remove unused sig_attrs argument"
> > >=20
> > > "IB/isert: Remove unused sig_attrs argument"
> > >=20
> > > what is the merge plan ?
> > >=20
> > > are we going to squeeze this to 5.2 or 5.3 ?
> > The 5.2 merge window is now open so it will not make 5.2
>=20
> Can we merge it to your for-5.3 branch after getting green light on this
> series ?

That branch will start only when rc1 comes out.

> > > which branch should we sent the 5 patches from above ?
> > It is probably best to repost this thing split up against 5.2-rc1 in
> > two weeks, I'll drop it off patchworks until then.
>=20
> Sure, but please approve it to avoid another review cycle.

Well you almost certainly will need to repost it after rebasing
it.. So I need new patches - both others can Ack your approach..

Jason
