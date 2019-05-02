Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF021228A
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2019 21:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfEBTTY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 May 2019 15:19:24 -0400
Received: from mail-eopbgr60071.outbound.protection.outlook.com ([40.107.6.71]:19431
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726126AbfEBTTY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 May 2019 15:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1r98+vowCgLknCN7vpr4bUaTL3CLzQ8LbyqE8misz4M=;
 b=F5VlSZmaPQaOsu2OgILGaK7KK+yqOAZ7F+fRHunSsq3U0vbCZk1a69ayL93FELnB2c8xKsD+sy0dc+5XkkFdbslqSIS7Jcp89nunLsaiacDREBDcp8lqPO5rZhHYNl3vFmTLWaucB+dHv/kivPgTJXxdoYV85hy6+9Cl+nSBs20=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5725.eurprd05.prod.outlook.com (20.178.121.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Thu, 2 May 2019 19:19:19 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044%5]) with mapi id 15.20.1856.008; Thu, 2 May 2019
 19:19:19 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Lijun Ou <oulijun@huawei.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: Re: [PATCH for-rc 1/2] RDMA/hns: Bugfix for releasing reserved qp
Thread-Topic: [PATCH for-rc 1/2] RDMA/hns: Bugfix for releasing reserved qp
Thread-Index: AQHVARvxOilSspY7Ik6qAlXwuvJAhg==
Date:   Thu, 2 May 2019 19:19:19 +0000
Message-ID: <20190502191913.GA29169@mellanox.com>
References: <1556204854-90092-1-git-send-email-oulijun@huawei.com>
 <1556204854-90092-2-git-send-email-oulijun@huawei.com>
In-Reply-To: <1556204854-90092-2-git-send-email-oulijun@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR1501CA0030.namprd15.prod.outlook.com
 (2603:10b6:207:17::43) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [173.228.226.134]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9fb3c726-d8ab-4280-53ee-08d6cf331359
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5725;
x-ms-traffictypediagnostic: VI1PR05MB5725:
x-microsoft-antispam-prvs: <VI1PR05MB5725A102A235411E298EB3C8CF340@VI1PR05MB5725.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0025434D2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(376002)(346002)(39860400002)(199004)(189003)(71190400001)(71200400001)(4744005)(7736002)(8936002)(66066001)(486006)(6916009)(6486002)(53936002)(99286004)(2616005)(11346002)(6246003)(476003)(6436002)(1076003)(229853002)(64756008)(66556008)(66446008)(66476007)(2906002)(14454004)(186003)(66946007)(73956011)(86362001)(68736007)(26005)(33656002)(76176011)(386003)(52116002)(316002)(446003)(4326008)(81156014)(478600001)(25786009)(36756003)(3846002)(6506007)(6116002)(102836004)(5660300002)(6512007)(256004)(14444005)(8676002)(81166006)(305945005)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5725;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CCvK1itleujahozaUyXFQAzdqx6auZfYAfGNpRT0XSZUt51Qy0Wz8B9PA2HlA8Hg8r1LEzrqQB9kApfH2BmUDqlVEcVrva30wUk+eNbSwr8Tv8pa/mY2uogd+fWq1ZSjPeZHSTMklCv2NNyexc4Adjo5d4/6nQPHYwJxI8nXT4RU1xx99/da/Nz1uThrPaUGH0/I+bkNM1Up9Ruf0kku4hMD2aNdqx6OoQyfCKdObr3HXMT5K+jqIjNotqyuF94OkKEQu7BddxxIZcoSuLmp2ZzrNsmeWbPqeaqNe1tX8qlq/ozXz7jxzvw9Z2PYT2fRWpOH7S4pg7KIeYCZLiLxntM0GxT0X90PCalxkZz4+lc3PI8av56uXpPhJmNMTpLij9z56nsBeRG01vlvE9wZUz4L8xtnjl1wJnfIG/tgvXs=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <43A4F1BE8CA1014BAEE4564C41A6C87B@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb3c726-d8ab-4280-53ee-08d6cf331359
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2019 19:19:19.7689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5725
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 25, 2019 at 11:07:33PM +0800, Lijun Ou wrote:
> Hip06 reserves 12 qps, Hip08 reserves 8 qps. When the QP is released
> based on hip08, the 8 to 11 reserved qp cannot released.
>=20
> Fixes: 926a01dc000d ("RDMA/hns: Add QP operations support for hip08 SoC")
> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> Signed-off-by: Lijun Ou <oulijun@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 1 +
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.h | 1 +
>  drivers/infiniband/hw/hns/hns_roce_qp.c    | 2 +-
>  3 files changed, 3 insertions(+), 1 deletion(-)

Applied to for-next

Thanks,
Jason
