Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49E01B100B
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Sep 2019 15:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731687AbfILNeD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Sep 2019 09:34:03 -0400
Received: from mail-eopbgr60051.outbound.protection.outlook.com ([40.107.6.51]:26094
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731283AbfILNeD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Sep 2019 09:34:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZpNxVRzbX1daP5Gu6kRGhdgznvzcxIPu+IvMnnuzTo2tBmy7L30Fgy62zqlASx8yBXR423ZWVh0tnT5lbM4FPlg4ApCaFx5AapW4A4BAyx276QmjXc46p+8Q7ab71HsBwRNCfD00maWBmJx6mUs8T03gjZobTD9EdeqNf5+Lp2nbxfYOa7eDBbPsygd59edy4Dujs/jHQvs3LLQUD6xJNZpnwSngr5NSNgkzwTB4D2PW+GZKEkTSny3X3r0ghNrkFJQYFeJ8KiOfMBySw03gzwrS1NwEpujWFS9DxHtCoPaxQSFfKiO4YS+sNAKJJANLgmcBJqHquv28Fa28HK9AiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwhcLkSHz5EqoKR5CKMYsi9927G2ByeLcmBIIjZm3aw=;
 b=obdCcCzm7PJGXfGQ4xFVXSZM2hOk25eu4jPub5bFUeDUF3MrBHBBhc+hS29Wy886ojIxsIVYRMREHil6b/32XX+ddmpFXq4uukBc7NsNgZvim7bbglJWvohc5bHAL68R8YOvg5wcEf5OBajluXDbpb+Iob/vXklpuO0KHxvbP5I7N/h2gEjXL5AkoRzoASL2HFZzD01bk4rKs8fN8dkqu5g+bF63WuBb2OibLxqQjPk9GQyOuG/SO6nndve050blIu6osIIFB6LYpKdBtW66EPH+4wP47sLItgFB5O26ZWR9anl2rkMz6DEBouGal/ZBYCtMliPv71Owo/kN/p1pAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwhcLkSHz5EqoKR5CKMYsi9927G2ByeLcmBIIjZm3aw=;
 b=ejfgE2HfM+hDo06czcerKUr1LJEBP4fLRVOMp/fvtRLo80EBJ0pHktYPPwC7SZZyNCvTq6MugeE01v3Hx88xBGfoFqyhIOBUTeAL/+oQBQn+Ap7B+a4n1ei2G/cP3m/dbszUSSUm0keCjz6eoSL6FUt8Ztr/8Nqg5XHBoYX28AQ=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5678.eurprd05.prod.outlook.com (20.178.121.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.14; Thu, 12 Sep 2019 13:33:58 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f%7]) with mapi id 15.20.2241.022; Thu, 12 Sep 2019
 13:33:58 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     YueHaibing <yuehaibing@huawei.com>
CC:     "oulijun@huawei.com" <oulijun@huawei.com>,
        "xavier.huwei@huawei.com" <xavier.huwei@huawei.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] RDMA/hns: use devm_platform_ioremap_resource() to
 simplify code
Thread-Topic: [PATCH -next] RDMA/hns: use devm_platform_ioremap_resource() to
 simplify code
Thread-Index: AQHVaW667lKcy6TDPE+jh2Hg5etsyQ==
Date:   Thu, 12 Sep 2019 13:33:58 +0000
Message-ID: <20190912133342.GA25365@mellanox.com>
References: <20190906141727.26552-1-yuehaibing@huawei.com>
In-Reply-To: <20190906141727.26552-1-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM5PR06CA0106.namprd06.prod.outlook.com
 (2603:10b6:4:3a::47) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.167.24.153]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5c2336d-de66-4f92-1e14-08d73785dd66
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5678;
x-ms-traffictypediagnostic: VI1PR05MB5678:
x-microsoft-antispam-prvs: <VI1PR05MB5678F7732E9902A9CB48963DCFB00@VI1PR05MB5678.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 01583E185C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(199004)(189003)(25786009)(6116002)(256004)(71190400001)(6916009)(4326008)(71200400001)(3846002)(1076003)(33656002)(36756003)(4744005)(6246003)(26005)(2906002)(7736002)(11346002)(102836004)(81166006)(476003)(186003)(86362001)(5660300002)(6506007)(386003)(81156014)(486006)(446003)(8676002)(478600001)(53936002)(8936002)(6436002)(6512007)(14454004)(54906003)(76176011)(2616005)(229853002)(305945005)(99286004)(6486002)(66476007)(66446008)(316002)(66066001)(52116002)(64756008)(66946007)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5678;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BQgR1yjR4OflZSwkowXyaODBA7FFBzF2dk4odBbVZ6qEOF0742n7K74dLFBsmoCoWQT0WywNUYa0ah3B03M9YyIiCKbljhaIDZpoNVNygqpXFIFfPgADmT2s+wEyCnApVpjGn7HtIxmwGI0jIllj7MI/3MXxymJ/YzNeStL8024VHn3tH1hCm0zFI39QLAhzGUsIPtC04j2iscoQ+XAhKw/fHkma/wM1RLbIMme46NdEOftO1TK2sjYWaPUz8mR4XgqqnjITdirC9Pr5AQoBlzsuhlppU4MMclw5wcF9DD9epr2BniGPpg6hFzvDnlqFIPPRk2EW4nhrxpxZPXZH/JftVpLI6tq5UdIpWSAOYEQJybNHw4oMoK/SMn8/ntP/e6SLwkfjFl7u+Wwvi0H7g6YRXwSlOQhWZA9BPRRJKsw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B6C28169A4C8254FA4A97DB6D91F566D@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c2336d-de66-4f92-1e14-08d73785dd66
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2019 13:33:58.4637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w6mrDxFZdUmmb1kZVbw3NkHzNmbRXK056epvEws9h9wvgUGKXuxx+xpNuriExG1Muvi3NOPygkb5m63FRcWYEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5678
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 06, 2019 at 10:17:27PM +0800, YueHaibing wrote:
> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied to for-next, thanks

Jason
