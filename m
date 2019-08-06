Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D03A28343C
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Aug 2019 16:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733043AbfHFOrE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Aug 2019 10:47:04 -0400
Received: from mail-eopbgr130087.outbound.protection.outlook.com ([40.107.13.87]:26750
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732037AbfHFOrD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 6 Aug 2019 10:47:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Do+BwNok/HHiYkAvv/ey/RxAOZ8+PDM3fhSX3ELaoK182KgNJj/nDW3L2WoiwJbsFU1GoRq8Wccor/pzjj0FdUKZY2qNStve8hQizzlFTuP77BXX7Mg3C1PBlLRHrlyxXrMG4JFtRivz1OYXHEo7ps3WzMkYD8ewNhhVsTZENQykaYqNNrwFEIAoGF/xCg7v0MEsae2qMdI5QhkMhPbD+2BJOJFTOQgXq/IHuwwBoNk4nZAWzsznK9Pz7meegyK65JklVvLZFN5JtfolXfEla1VOYPicoqbTN8QsgMUvt61h9MSyY3Cz2toNtVymETT7vw0jyH2QRNTB9gMH6iTynw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANlJ2JAN2KAMottifsVJOI5Fo9er3Kov+SpbOk5OGIA=;
 b=Vzelu782tsaYSo7vXgU59yyxGnluhdzvaI0cwLUkdUfzA+NC2KUPHMMQYYVXGuTZA8iOu/MCYnV5ldWmlHzoEqrBhjQonyibSDy1PKEB5iIGDPItX64ZpkEdWPA2CfjXkDdh0XzDxFOsyIDdU2EII5+tTyvbhm1TV8Mpzx/ANZgFQ3txXD19BgwZ9nLFBqp95Z1qYFj0ecpKIBH+hA2kI06JHcrDHnqIkgcpdyTMoe8W+W6NLUrUnGnRfC8eEiEZfL4Pq+3ZQhe7x5M0dhIVl2lqM9UjIYY60iVl1pJVHf8sgGOffTsgL2oak4ya6DLeQuToPvSaR7SFMrZ4WbVxRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANlJ2JAN2KAMottifsVJOI5Fo9er3Kov+SpbOk5OGIA=;
 b=cwOQj1oMiEO+Zy8oCU2rdyanXbdF6ztU7svyfvHSLU6tullfhxAXcKAJ2U9hZzkxrxxP9ygBGJE6DTFNFSo8aH7FlEkHd3mBdBxJJ1imM/tYwzgh76/uUKxYzwOcvh+K23/VC86n5V/B4I6cOLaWKUM7XVoHA+KHq19TeHN6DFI=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5101.eurprd05.prod.outlook.com (20.177.49.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Tue, 6 Aug 2019 14:46:58 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880%4]) with mapi id 15.20.2136.018; Tue, 6 Aug 2019
 14:46:58 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leonro@mellanox.com>
CC:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Mark Zhang <markz@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [PATCH rdma-next 0/2] Enable QUERY_LAG over DEVX
Thread-Topic: [PATCH rdma-next 0/2] Enable QUERY_LAG over DEVX
Thread-Index: AQHVR5S96BofU7cLsE+M/qJVn2ksr6bqrh8AgAOOSoA=
Date:   Tue, 6 Aug 2019 14:46:58 +0000
Message-ID: <20190806144653.GM11641@mellanox.com>
References: <20190731114014.4786-1-leon@kernel.org>
 <20190804082848.GF4832@mtr-leonro.mtl.com>
In-Reply-To: <20190804082848.GF4832@mtr-leonro.mtl.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTOPR0101CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::19) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38c6472a-1dbc-4eba-1176-08d71a7ceefe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5101;
x-ms-traffictypediagnostic: VI1PR05MB5101:
x-microsoft-antispam-prvs: <VI1PR05MB51018685FBA21A7C375DD77ECFD50@VI1PR05MB5101.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(39860400002)(366004)(346002)(376002)(199004)(189003)(4326008)(7736002)(256004)(36756003)(68736007)(81166006)(229853002)(26005)(305945005)(186003)(37006003)(486006)(53936002)(2616005)(476003)(6246003)(4744005)(52116002)(6116002)(102836004)(386003)(66446008)(11346002)(6862004)(6486002)(316002)(25786009)(6512007)(478600001)(6506007)(33656002)(446003)(66476007)(6436002)(2906002)(76176011)(81156014)(66556008)(8936002)(66066001)(8676002)(6636002)(99286004)(71200400001)(5660300002)(66946007)(71190400001)(107886003)(64756008)(1076003)(3846002)(54906003)(14454004)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5101;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: A4Lt0sQhs/3vWUoo+EiFQSlXCdppIHwDK2R+9XzozOp/r+1Fvs2BAD36YYsP7Rgox8X2IqxrD3kZtjRrEsXg/l998RQoiTRodRbPE7XZUNMELP8ZGHac5rav2tbuOAqtJUtY3ZrShL9TJP0B/y8W2ZTOGv2E95hQFNl0/cUNq8YVcml1hR7tnW35N/zS41YSgMbaudlIdd51LWAKRqD+/ycYHM8fVlq9oMFR6aP44Fw6OgU1dm8JsVfQqIoqbormiGDGngwe1FoTK/K+iWlQdU/FbLctCWSjaC/qeKQvBiB0sY9B7+ejQUIsqOpyk3mcx9A0mqq/4/bu5YFSByEnKcM6xkRoiXJiOvgoMgSG6TrwCiIBW6Mr1RMv9GTuo1I1MVvfPUUCRRM4m0ZW02FX87YxUVRqBW73/13opjLoocM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CB408D59CB581E468A36029D35455E26@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c6472a-1dbc-4eba-1176-08d71a7ceefe
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 14:46:58.5758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5101
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Aug 04, 2019 at 05:28:50AM -0300, Leon Romanovsky wrote:
> On Wed, Jul 31, 2019 at 02:40:12PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > Hi,
> >
> > Enable QUERY_LAG command over DEVX. That command was added to the mlx5_=
core,
> > but were not used and hence has wrong HW spec layout which is fixed in
> > first patch. The second patch actually makes this command available for
> > DEVX users.
> >
> > Thanks
> >
> > Mark Zhang (2):
> >   net/mlx5: Fix mlx5_ifc_query_lag_out_bits
> >   IB/mlx5: Support MLX5_CMD_OP_QUERY_LAG as a DEVX general command
>=20
> Both patches are applied to mlx5-next.

Why the second one?

Jason
