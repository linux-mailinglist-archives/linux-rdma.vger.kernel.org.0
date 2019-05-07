Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F74716561
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2019 16:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfEGOIc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 May 2019 10:08:32 -0400
Received: from mail-eopbgr30088.outbound.protection.outlook.com ([40.107.3.88]:33439
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726340AbfEGOIb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 7 May 2019 10:08:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2GF8wqUF/ZHTdLGXUgZmbqEPdVrL+olEEvgtq/wHZY=;
 b=OzYOvvWO1yC+/v4jGvE/eSs6nQVlxYBNkAdAJWlZhpePvXL31tO0npsfGIrJGjF5YflBu/zb8b9JeIhI+p/mlkiBNs+/t0Frh/0Y5Z+a2tBFcY4ZCcLPFtBUA0EO4zMwAuMWsncHPgrjzDC/LXY5wdygHyMFu4JhasY2r9thKnI=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5934.eurprd05.prod.outlook.com (20.178.126.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Tue, 7 May 2019 14:08:28 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044%5]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 14:08:28 +0000
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
Thread-Index: AQHVBNo/qvTIRu6NOEydCCWllJ7Of6Zfq6qAgAADiQCAAAO8AA==
Date:   Tue, 7 May 2019 14:08:27 +0000
Message-ID: <20190507140818.GZ6186@mellanox.com>
References: <1557236319-9986-1-git-send-email-maxg@mellanox.com>
 <20190507134217.GX6186@mellanox.com>
 <2e3d9da7-d4fa-e2fa-5d3b-e60c54e7f7ba@mellanox.com>
In-Reply-To: <2e3d9da7-d4fa-e2fa-5d3b-e60c54e7f7ba@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTXPR0101CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::42) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.49.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67017a12-51d7-4533-c48d-08d6d2f57a20
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5934;
x-ms-traffictypediagnostic: VI1PR05MB5934:
x-microsoft-antispam-prvs: <VI1PR05MB5934C542BBD42EE71F84FE2FCF310@VI1PR05MB5934.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(136003)(396003)(376002)(189003)(199004)(2616005)(476003)(229853002)(11346002)(446003)(8676002)(86362001)(107886003)(6862004)(4326008)(486006)(54906003)(52116002)(6506007)(386003)(53546011)(37006003)(99286004)(33656002)(478600001)(14444005)(5660300002)(256004)(6486002)(6436002)(25786009)(36756003)(316002)(102836004)(68736007)(26005)(186003)(66066001)(66946007)(66446008)(6512007)(73956011)(66476007)(66556008)(64756008)(1076003)(76176011)(81156014)(6636002)(53936002)(8936002)(81166006)(14454004)(7736002)(6246003)(2906002)(305945005)(6116002)(3846002)(71200400001)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5934;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XKsMQA9dVeCNtglrHweUjty1U5NW6pilSp0aM6bFIOgFED7WqDik+nfYtvsO1JKS27lxLRYpVDLbM7qyLVSFlRqsTzyOA54mbY6btbLRQpx7pY8rYbE6vZG1BPqprRChg93uS9NbTX4XQYYKO+4Ki+5OqmflVVyMhI1tCEZENLETLyukuAYLlzCI+xmRpiKkfNBNhFGpSQNo+4FWswjWfwcwEBRrNlrHCrH/G9NIYeOWDEERC4zaXgxFtgh44S5/XPSsc14SuhXsjSrRfk83Vp6x2Clo6DGp3/MSuI8WNfHOj7hngqox7aPA1X5Cj7VC02I6c5s+o2UeHjmr/2qDR9jg4mUB4l+hpFb2AV6nto1Kz1DTMtPkokOEx2YJazcEWu+GKGVOzWahgZ7U+w6+XlgoHUY+KgR+li0mkal92as=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D25DC0CF761BD04591C23549E8CCCCC2@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67017a12-51d7-4533-c48d-08d6d2f57a20
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 14:08:28.0044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5934
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 07, 2019 at 04:54:56PM +0300, Max Gurtovoy wrote:
>=20
> On 5/7/2019 4:42 PM, Jason Gunthorpe wrote:
> > On Tue, May 07, 2019 at 04:38:14PM +0300, Max Gurtovoy wrote:
> > > Israel Rukshin (12):
> > >    RDMA/core: Introduce IB_MR_TYPE_INTEGRITY and ib_alloc_mr_integrit=
y
> > >      API
> > >    IB/iser: Refactor iscsi_iser_check_protection function
> > >    IB/iser: Use IB_WR_REG_MR_INTEGRITY for PI handover
> > >    IB/iser: Unwind WR union at iser_tx_desc
> > >    IB/iser: Remove unused sig_attrs argument
> > >    IB/isert: Remove unused sig_attrs argument
> > >    RDMA/core: Add an integrity MR pool support
> > >    RDMA/rw: Fix doc typo
> > >    RDMA/rw: Print the correct number of sig MRs
> > >    RDMA/rw: Use IB_WR_REG_MR_INTEGRITY for PI handover
> > >    RDMA/core: Remove unused IB_WR_REG_SIG_MR code
> > >    RDMA/mlx5: Improve PI handover performance
> > >=20
> > > Max Gurtovoy (13):
> > >    RDMA/core: Introduce new header file for signature operations
> > >    RDMA/core: Save the MR type in the ib_mr structure
> > >    RDMA/core: Introduce ib_map_mr_sg_pi to map data/protection sgl's
> > >    RDMA/core: Add signature attrs element for ib_mr structure
> > >    RDMA/mlx5: Implement mlx5_ib_map_mr_sg_pi and
> > >      mlx5_ib_alloc_mr_integrity
> > >    RDMA/mlx5: Add attr for max number page list length for PI operati=
on
> > >    RDMA/mlx5: Pass UMR segment flags instead of boolean
> > >    RDMA/mlx5: Update set_sig_data_segment attribute for new signature=
 API
> > >    RDMA/mlx5: Introduce and implement new IB_WR_REG_MR_INTEGRITY work
> > >      request
> > >    RDMA/mlx5: Move signature_en attribute from mlx5_qp to ib_qp
> > >    RDMA/core: Validate signature handover device cap
> > >    RDMA/rw: Add info regarding SG count failure
> > >    RDMA/mlx5: Use PA mapping for PI handover
> > Max this is really too many patches now, can you please split this
> > up.
> >=20
> > Can several patches be applied right now as bug fixes like:
> >=20
> >     RDMA/rw: Fix doc typo
> >     RDMA/rw: Print the correct number of sig MRs
> >     RDMA/core: Remove unused IB_WR_REG_SIG_MR code
> >     RDMA/rw: Add info regarding SG count failure
> >=20
> > ??
>=20
> Yes we can. Except of "RDMA/core: Remove unused IB_WR_REG_SIG_MR code".
>
> Patches that also can be merged now are:
>
> "IB/iser: Remove unused sig_attrs argument"
>=20
> "IB/isert: Remove unused sig_attrs argument"
>=20
> what is the merge plan ?
>=20
> are we going to squeeze this to 5.2 or 5.3 ?

The 5.2 merge window is now open so it will not make 5.2

> which branch should we sent the 5 patches from above ?

It is probably best to repost this thing split up against 5.2-rc1 in
two weeks, I'll drop it off patchworks until then.

Jason
