Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6143A55651
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2019 19:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfFYRuM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Jun 2019 13:50:12 -0400
Received: from mail-eopbgr150078.outbound.protection.outlook.com ([40.107.15.78]:39940
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726562AbfFYRuM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 Jun 2019 13:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HX7kYCbOVqv3CrzPtqEFRMZGwpaEcXXEgM7Ja8BFjCM=;
 b=FV1MIFUroP+KXfeKp4CLffATRJx9Sf+6kCOxKav5v1PAAICpeid5VBlM97bHTXDgaV0akTc7IuOXyNQjh+ErzPghuuYKl5MS8jToCpvyRc9VMJ7ybskN0Up7Hgektgt/85Gp3SR1fGKQIsZSxssdyWEFb361Tb4VBWss2MDd1uk=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4223.eurprd05.prod.outlook.com (52.133.12.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Tue, 25 Jun 2019 17:50:08 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2008.014; Tue, 25 Jun 2019
 17:50:08 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Lijun Ou <oulijun@huawei.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: Re: [PATCH V2 for-next] RDMA/hns: Cleanup unnecessary exported
 symbols
Thread-Topic: [PATCH V2 for-next] RDMA/hns: Cleanup unnecessary exported
 symbols
Thread-Index: AQHVK35tg4UoC4TObkqr5UkfVWe/IA==
Date:   Tue, 25 Jun 2019 17:50:08 +0000
Message-ID: <20190625175005.GA28358@mellanox.com>
References: <1560927647-15788-1-git-send-email-oulijun@huawei.com>
In-Reply-To: <1560927647-15788-1-git-send-email-oulijun@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR02CA0108.eurprd02.prod.outlook.com
 (2603:10a6:208:154::49) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [66.187.232.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2685a8ad-1865-45e3-28c4-08d6f995900f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4223;
x-ms-traffictypediagnostic: VI1PR05MB4223:
x-microsoft-antispam-prvs: <VI1PR05MB42230A7171E6F3580EE5AE5BCFE30@VI1PR05MB4223.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(346002)(376002)(396003)(189003)(199004)(102836004)(71200400001)(36756003)(6916009)(1076003)(71190400001)(81166006)(186003)(81156014)(6506007)(8936002)(229853002)(26005)(6436002)(52116002)(66066001)(76176011)(86362001)(33656002)(11346002)(446003)(4326008)(3846002)(6116002)(486006)(14454004)(256004)(476003)(6486002)(8676002)(386003)(6246003)(99286004)(2616005)(54906003)(7736002)(25786009)(68736007)(66946007)(73956011)(66446008)(66476007)(66556008)(53936002)(478600001)(64756008)(6512007)(5660300002)(316002)(305945005)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4223;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wDC3DmeZGK5TmpahP2GTseQrMmXYPQEdzKb/2sEmjFpLyAoQRD0RaBdvPsEGMAUrKsUvYO+Nxm8ECy+1UuatmtuVGqulDjI9GqK3PPW4tA2C3eXTFFYoftIjriPYlmh+K+tl/sfcH2RDBuPAaYdGLvj8IS6vHrj5zBtojSAkJuo61d8JFKtTpJsSiyxHYHoAn9t3d5UgN7Pq2rOxPVBa9kD5eJaYIvGRiU52FAW5uASxPPKKirRVMaWq9IlUxEZBgQq8GDAOsvEPI7xO6DoS8kDdPGMtBaLm8o76Qt4zfL9Pi6sQreeq21X2G07li3AfwTP+1neG+D/O93wGVCIRK4KCW8ERbpHeAIT8sDisACQcA8akGD26Zd6Ktbjhe9cdQoWctTffJrzT7A8oR0mvbgNX5jma/oLOpj/rQnOmQVg=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <036C3189E88F3945A814136E8683DFAC@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2685a8ad-1865-45e3-28c4-08d6f995900f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 17:50:08.4528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4223
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 19, 2019 at 03:00:47PM +0800, Lijun Ou wrote:
> This patch removes the hns-roce.ko for cleanup all the
> exported symbols in common part.
>=20
> Signed-off-by: Xi Wang <wangxi11@huawei.com>
> Signed-off-by: Lijun Ou <oulijun@huawei.com>
> ---
> V1->V2:
> 1.  Use the top level CONFIG_INFINIBAND_HNS tristate to control
>     whether hns_roce_hw_v1.ko and hns_roce_hw_v2.ko are both as
>     modules or both built in
> 2.  Add Signed-off-by
> ---
>  drivers/infiniband/hw/hns/Kconfig          | 15 +++++++--------
>  drivers/infiniband/hw/hns/Makefile         | 13 +++++++++----
>  drivers/infiniband/hw/hns/hns_roce_alloc.c |  2 --
>  drivers/infiniband/hw/hns/hns_roce_cmd.c   |  4 ----
>  drivers/infiniband/hw/hns/hns_roce_cq.c    |  5 -----
>  drivers/infiniband/hw/hns/hns_roce_db.c    |  4 ----
>  drivers/infiniband/hw/hns/hns_roce_hem.c   |  5 -----
>  drivers/infiniband/hw/hns/hns_roce_main.c  |  3 ---
>  drivers/infiniband/hw/hns/hns_roce_mr.c    |  3 ---
>  drivers/infiniband/hw/hns/hns_roce_pd.c    |  2 --
>  drivers/infiniband/hw/hns/hns_roce_qp.c    | 13 -------------
>  drivers/infiniband/hw/hns/hns_roce_srq.c   |  1 -
>  12 files changed, 16 insertions(+), 54 deletions(-)

Applied to for-next

Thanks,
Jason
