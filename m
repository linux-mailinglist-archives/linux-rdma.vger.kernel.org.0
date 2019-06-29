Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB875A80A
	for <lists+linux-rdma@lfdr.de>; Sat, 29 Jun 2019 03:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfF2Bds (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jun 2019 21:33:48 -0400
Received: from mail-eopbgr00068.outbound.protection.outlook.com ([40.107.0.68]:25152
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726643AbfF2Bds (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 Jun 2019 21:33:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=cKAc28GYlXE0D02y9oslnDlUfIlVRU8M34PMCSHP0EBXC1xaaONokUssef+1IbT9KsPHZFNzLW0AXxPC4v3B8s46aV0oWnXgnRAt8tg/97ufo+NdaCaZ5p7xNujHBcmY5cjeeJzt4gh4VKsCUGhirGI/tHaPgupGbbcQ4fxoZq0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRaMRkk+cC67Yh3EkDEhmpgHBZbvezoSSjnPlVNRNPI=;
 b=Lp9aOd7HI9w6h+zbEwK+or0eR5BAbd0j3ZzZH/6YprQZKy90XtJwscPkJ04NqThn+YAKzbIzW4Jn/VJujG+Bh2OfpXwhMIENMHB9aJzLCwrsb7BFy2Uhd9s1lXHw4XnGLeWn3LGxMw5JtXLDbBtvZaUUKrjXo3Vb6AcQxCGWbJ0=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRaMRkk+cC67Yh3EkDEhmpgHBZbvezoSSjnPlVNRNPI=;
 b=bVaEdsofxXDXTorzt1o+x05f/ClhwI7OOMVJXnj4Wrp2sbtmCW5wjbtgADvPsW16rXXlO01nZIwQ9UNq1H1iGPO0Makm+cEpwZ41jHYU4qXP6/hZ70DALbmFK3xmZz+gqze1R+s3TxoqnWkkeZqu5TFWf7ELXQaFpZ16iBSHDbU=
Received: from DB7PR05MB4138.eurprd05.prod.outlook.com (52.135.129.16) by
 DB7PR05MB5448.eurprd05.prod.outlook.com (20.177.123.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Sat, 29 Jun 2019 01:33:43 +0000
Received: from DB7PR05MB4138.eurprd05.prod.outlook.com
 ([fe80::9115:7752:2368:e7ec]) by DB7PR05MB4138.eurprd05.prod.outlook.com
 ([fe80::9115:7752:2368:e7ec%4]) with mapi id 15.20.2008.017; Sat, 29 Jun 2019
 01:33:43 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next v5 0/3] IB/hfi1: Clean up and refactor some CQ
 code
Thread-Topic: [PATCH for-next v5 0/3] IB/hfi1: Clean up and refactor some CQ
 code
Thread-Index: AQHVLhqv1yRZc+pmG0K5qH6ZejNIpQ==
Date:   Sat, 29 Jun 2019 01:33:43 +0000
Message-ID: <20190629013335.GA18055@mellanox.com>
References: <20190628180316.67586.73737.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20190628180316.67586.73737.stgit@awfm-01.aw.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTOPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::22) To DB7PR05MB4138.eurprd05.prod.outlook.com
 (2603:10a6:5:23::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [207.164.2.174]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9667ff4-a313-4ab1-e312-08d6fc31d22f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB7PR05MB5448;
x-ms-traffictypediagnostic: DB7PR05MB5448:
x-microsoft-antispam-prvs: <DB7PR05MB54483B503E721F8CBD803EEACFFF0@DB7PR05MB5448.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 0083A7F08A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(54534003)(189003)(199004)(11346002)(66066001)(36756003)(68736007)(25786009)(26005)(4326008)(71190400001)(446003)(6506007)(14444005)(33656002)(256004)(486006)(316002)(478600001)(2616005)(54906003)(102836004)(66556008)(99286004)(71200400001)(386003)(2906002)(66446008)(305945005)(73956011)(3846002)(64756008)(86362001)(476003)(8936002)(14454004)(66476007)(52116002)(6246003)(7736002)(229853002)(81156014)(6486002)(81166006)(53936002)(5660300002)(6916009)(8676002)(66946007)(4744005)(76176011)(6116002)(6512007)(1076003)(6436002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR05MB5448;H:DB7PR05MB4138.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vfh/WZCXLJJx/HmeRSEQBvi2KYN/T4jDT6A/TwTx0D0LDN37n5n/MxIkzM6RmwQBi8Ls0YeH+9bNNiv39EotAv1shth7ZTX4XMWn/2JvjxEfiMxv2ZXdlS7uP9z/YJu9ykLulawXXjnekAhkbye1px3kxdW5cb666H0sj4G/skOBDEWhBkHSeczw1veAUI584vMkef9K1RRpQx98y2vgCAtN8Q3q9hJ0VBqNZEmTg5NoAn4fzVOTW1lOUVEcCDozn01kWNgxxl2RoY//PvJ9Z6MB2/IT1x3hkEAZmqCgJjvcVEuaaMWEty/D02GskPhhlIQ36ddcLt3Xvnw5mWtvOwvQ/pP9TiT5aurFLgaBkFmX37Spb6ly/QY0Uv4df8ZNBkSpZF8ipAxDrMWUW2rDwg4jmadomjwKSXRWKaJ0Ejc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9286E08A3CFE1C43BDC73CB818BB7AB7@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9667ff4-a313-4ab1-e312-08d6fc31d22f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2019 01:33:43.3972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB5448
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 28, 2019 at 02:04:10PM -0400, Dennis Dalessandro wrote:
> Hi Doug and Jason,
>=20
> This is really a resubmit of some code clean up we floated a while back. =
The
> main goal here is to clean up some of the stuff which should be in the ua=
pi
> directory vs in in the driver directory. Then to break the single lock fo=
r=20
> recv wqe processing.
>=20
> The accompanying user bits should already be in a PR on GitHub.
>=20
> Change log documented below each commit message.
>=20
> This latest update is a rebase ontop of wip/for-testing also a small chan=
ge
> in the first patch to remove the open coded container_of in favor of the
> helper routine.
>=20
>=20
> Kamenee Arumugam (3):
>       IB/hfi1: Move rvt_cq_wc struct into uapi directory
>       IB/hfi1: Move receive work queue struct into uapi directory
>       IB/rdmavt: Fracture single lock used for posting and processing RWQ=
Es

Applied to for-next, thanks

Jason
