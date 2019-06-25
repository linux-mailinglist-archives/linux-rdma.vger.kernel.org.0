Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF21557D0
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2019 21:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfFYTeg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Jun 2019 15:34:36 -0400
Received: from mail-eopbgr30058.outbound.protection.outlook.com ([40.107.3.58]:25430
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726393AbfFYTeg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 Jun 2019 15:34:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tzqa2ZxGdr1cYv6INDXAict2XLQRConadnG//yI8is4=;
 b=N7sVQFkspVaTlLpZjrBIu6/LyC4ERDCauFoRi+/CMgJna8IYNNgViYdi+1hGsJCH/0hInc5ms8IvgHsxJ7Aj87cRo7nTlK/97eoM0M3jVF1bdGImWK0uAirLtxEA08/vU4dYjmA8obpuSotJx8fqIBFjlcLJrx6NTU0hwQ2emQQ=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4255.eurprd05.prod.outlook.com (52.133.12.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.15; Tue, 25 Jun 2019 19:34:31 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2008.014; Tue, 25 Jun 2019
 19:34:31 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Colin King <colin.king@canonical.com>
CC:     Lijun Ou <oulijun@huawei.com>, Wei Hu <xavier.huwei@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] RDMA/hns: fix spelling mistake "attatch" ->
 "attach"
Thread-Topic: [PATCH][next] RDMA/hns: fix spelling mistake "attatch" ->
 "attach"
Thread-Index: AQHVK40CeQZumWLkfE+IGoRpjX/74A==
Date:   Tue, 25 Jun 2019 19:34:31 +0000
Message-ID: <20190625193427.GA13242@mellanox.com>
References: <20190624121649.3281-1-colin.king@canonical.com>
In-Reply-To: <20190624121649.3281-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR01CA0032.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:69::45) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [66.187.232.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f85ba75-0942-49df-5c28-08d6f9a42544
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4255;
x-ms-traffictypediagnostic: VI1PR05MB4255:
x-microsoft-antispam-prvs: <VI1PR05MB42553A4D112069EF7B11CEB6CFE30@VI1PR05MB4255.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(376002)(346002)(39860400002)(136003)(396003)(366004)(189003)(199004)(446003)(6512007)(256004)(1076003)(4744005)(6436002)(11346002)(486006)(476003)(2616005)(71200400001)(71190400001)(86362001)(4326008)(14454004)(229853002)(102836004)(33656002)(26005)(6506007)(7736002)(68736007)(6486002)(99286004)(186003)(386003)(305945005)(6116002)(14444005)(316002)(3846002)(36756003)(66066001)(66476007)(66446008)(8936002)(478600001)(66556008)(25786009)(5660300002)(81156014)(81166006)(64756008)(6916009)(8676002)(2906002)(6246003)(66946007)(53936002)(73956011)(54906003)(52116002)(76176011)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4255;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XyfTnPU+Ry54bSvAxaRz+GEhgyrR27kV4gCQ737f778s1vX+8E/wbqBrvsZL3IkzaF9jDy38GM2T+7Zr/NHZ57S51/jrXrcafzRyIO0tVEjt6/kn0pVoM5+TyJFH2kGOD2hpZWWxdvtpImi4G4goo4/FR9W4E5EbfVvHYnj1Q6QuQ+HM/M6koFM4gTCByZ9fpXkST8kqYc1udaq0LYx9iW6bnYZzUu/cXAKZATfwQ4fHJkx75CirZeHiwyT7WoCFeHSqVrcxIBjzAZp0139U8eO2+sHih98E5Ftjq+yKyobJU/8/2kWbHWW7S3WhwfoJr+ogewNd91p3IMLqSs6uU7h8dExD6s7sJ5eqlor37s+hjg8mmcXyRjMERr784jmA6dsjD6An5sNVTOi7wxl/Q8Stzzu1uj0/wvtgZnZ793A=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C058B1AA2CB2E74692648DB987484356@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f85ba75-0942-49df-5c28-08d6f9a42544
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 19:34:31.7761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4255
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 24, 2019 at 01:16:49PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> There is a spelling mistake in an dev_err message. Fix it.
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_qp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
