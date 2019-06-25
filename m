Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23CF555017
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2019 15:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfFYNTT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Jun 2019 09:19:19 -0400
Received: from mail-eopbgr20073.outbound.protection.outlook.com ([40.107.2.73]:10486
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727124AbfFYNTS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 Jun 2019 09:19:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqW8mXs/egmq+6VjVchAJLm/CeTB6+pWTH+39SgH8HQ=;
 b=BuzjmLd0aU0CCxuLz/9agYS3aYlH1KhDwO9ByH7OHzm/ZHb7lujyyi5EHSIdaCLXLsOPjZs/6isvmHoqe/0xspWWq7nAO2VAoo/P7xGO9kSl5yrrzQccov8qOzMmFgzN/ltmfNqFXOYVMgiR1bwj5N9QT6F9ZXgFyMIpt3kuBXQ=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5790.eurprd05.prod.outlook.com (20.178.122.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Tue, 25 Jun 2019 13:19:15 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2008.014; Tue, 25 Jun 2019
 13:19:15 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Colin King <colin.king@canonical.com>
CC:     Lijun Ou <oulijun@huawei.com>, Wei Hu <xavier.huwei@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] RDMA/hns: fix potential integer overflow on left
 shift
Thread-Topic: [PATCH][next] RDMA/hns: fix potential integer overflow on left
 shift
Thread-Index: AQHVK1iWGDv1GJpJkk+255M1+vphrA==
Date:   Tue, 25 Jun 2019 13:19:15 +0000
Message-ID: <20190625131911.GA10878@mellanox.com>
References: <20190624214608.11765-1-colin.king@canonical.com>
In-Reply-To: <20190624214608.11765-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM3PR05CA0132.eurprd05.prod.outlook.com
 (2603:10a6:207:2::34) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [66.187.232.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82394f19-376c-4f25-318e-08d6f96fb861
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5790;
x-ms-traffictypediagnostic: VI1PR05MB5790:
x-microsoft-antispam-prvs: <VI1PR05MB57905DECE6891E4CB7B9CA23CFE30@VI1PR05MB5790.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(39860400002)(396003)(366004)(346002)(199004)(189003)(11346002)(2906002)(4326008)(446003)(26005)(102836004)(478600001)(3846002)(71200400001)(25786009)(6116002)(66946007)(8676002)(54906003)(71190400001)(8936002)(4744005)(186003)(305945005)(316002)(81156014)(81166006)(66476007)(66446008)(7736002)(64756008)(66556008)(1076003)(5660300002)(486006)(14444005)(229853002)(66066001)(86362001)(256004)(6486002)(476003)(73956011)(68736007)(6436002)(6512007)(53936002)(2616005)(6506007)(386003)(36756003)(14454004)(33656002)(76176011)(6916009)(99286004)(52116002)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5790;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rqkTtUT+H4lLpwVvMvAcMsSgUauoZsssZN8fEwcgqQ+i3LxAcqmbVGS2NQtw0hg3GSpj37/ooauD7P8FxpPAgZo8kwZ9bK5TdLGtFHD3UpS9BUYLceEhH3Nt22DEBw8G3irrTXgysn8Gbs4Ozn+EW6ukglWnRaIyrwU4hyh410fe7utEKg+vvPbK91ahoWExF80f+5laBtenwD41Qgtba5xjU8tqqnU+ezXGHzE4ye7VAuWMFnxD5rLaR1CheA+TBLUNGx3EF6p4exM6FIX+qE2jCzqjUa2tEvuJ4b5A4oYkaSWy8UwLWwKKSaWUCWVjDfxHTQK3hIfbwicvl13RcnPAnUrT8em1EqoGHHQ69/dVAK/58Sg2hyJ+NrN5O6DEJNU5/clTur9LvdNHOqWuuFjmE8Z+SnA++olM/qLRjO0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <62262B7684038143A1595B5CC61C0407@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82394f19-376c-4f25-318e-08d6f96fb861
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 13:19:15.4774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5790
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 24, 2019 at 10:46:08PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> There is a potential integer overflow when int i is left shifted
> as this is evaluated using 32 bit arithmetic but is being used in
> a context that expects an expression of type dma_addr_t.  Fix this
> by casting integer i to dma_addr_t before shifting to avoid the
> overflow.
>=20
> Addresses-Coverity: ("Unintentional integer overflow")
> Fixes: 2ac0bc5e725e ("RDMA/hns: Add a group interfaces for optimizing buf=
fers getting flow")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
