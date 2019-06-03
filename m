Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8BA33359
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2019 17:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbfFCPUN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jun 2019 11:20:13 -0400
Received: from mail-eopbgr70040.outbound.protection.outlook.com ([40.107.7.40]:25649
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729004AbfFCPUN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 3 Jun 2019 11:20:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRd7kqyNQJeS1m6XFe2CUArBzACs6FETH8uwaNLeODM=;
 b=bMj9wBadHKM0o2d8oNFIr9IWDrsgKsJa/cPSfnFXC52WzCIGr6D8NuPAqRb1kfwnQS942sROkC+ED4m+7UNKz/3Ee78oA6Vy/u5pIAie16t0OzskRvjj8zCqrsmwEJaP3vBANTtqj6BbKFwqTT0hwVO/4XyYCpG6FMf141AWHrU=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB3246.eurprd05.prod.outlook.com (10.170.238.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Mon, 3 Jun 2019 15:20:06 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1943.018; Mon, 3 Jun 2019
 15:20:06 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: try_module_get in hfi1
Thread-Topic: try_module_get in hfi1
Thread-Index: AQHVGh/SUm4t+70oBk2OjtaBN/WlUw==
Date:   Mon, 3 Jun 2019 15:20:05 +0000
Message-ID: <20190603152000.GG11488@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTBPR01CA0014.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::27) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 377dcf91-13af-4302-c82b-08d6e836f509
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB3246;
x-ms-traffictypediagnostic: VI1PR05MB3246:
x-microsoft-antispam-prvs: <VI1PR05MB324614264ADAC5A0357AB48DCF140@VI1PR05MB3246.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0057EE387C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(366004)(39860400002)(376002)(396003)(199004)(189003)(73956011)(66946007)(256004)(6916009)(71200400001)(71190400001)(6512007)(6436002)(1076003)(4744005)(66446008)(64756008)(66556008)(66476007)(68736007)(486006)(6116002)(81166006)(81156014)(4326008)(8936002)(8676002)(3846002)(2906002)(476003)(36756003)(7116003)(26005)(186003)(25786009)(2616005)(305945005)(7736002)(66066001)(99286004)(86362001)(53936002)(386003)(6506007)(52116002)(33656002)(102836004)(5660300002)(6486002)(316002)(14454004)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3246;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: j9wmyAD4eZIB4deg7eBVbvt/KGfQ3NXmo/brr/PgIAVSQnWpt1y0fGUVlj2xGE50+ly/dWfD5mG7dk5/kSPmPMC8XJ3gjP1g5LLQ+UFpcEAoa3SWzK1XZ4XdErqYDOQI3xfvOd9/cj/7uerRDy3GyceaYa1GyRTJVrtxI4CexdHjljV9NLA3WOVGvh+z3HVHwNMBo9OkqUGUP3otjOGqNUVLmQmfMyMnBSIwxUYiCe1ERtD+vyAWnTCqj7LZGGDs5e8v9AmRgbfsTe/TOE1yhhySENRwWtZRnch/mUYooj19KD8CJa6jwzPKHw5IbMXmTXVV9WHfp5F6j7u+ZOTI59jTHIsYi7BonEm8uiyT2U1b0PYWlxx9dfuM+AthNGrx4OO8IKxbLMRL7NZL2vGe1FszStiN98jTzC0EdbmKnNI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1EDAEDDDFD9E01489CDC9278376BF607@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 377dcf91-13af-4302-c82b-08d6e836f509
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2019 15:20:05.9639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3246
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Intel Guys,

I'm looking at code in hfi1:

static int __i2c_debugfs_open(struct inode *in, struct file *fp, u32 target=
)
{
	struct hfi1_pportdata *ppd;
	int ret;

	if (!try_module_get(THIS_MODULE))
		return -ENODEV;

Seems like nonsense to me.

I think it should be:

--- a/drivers/infiniband/hw/hfi1/debugfs.c
+++ b/drivers/infiniband/hw/hfi1/debugfs.c
@@ -1155,6 +1155,7 @@ static int exprom_wp_debugfs_release(struct inode *in=
, struct file *fp)
 { \
        .name =3D nm, \
        .ops =3D { \
+               .owner =3D THIS_MODULE, \
                .read =3D readroutine, \
                .write =3D writeroutine, \
                .llseek =3D generic_file_llseek, \
@@ -1165,6 +1166,7 @@ static int exprom_wp_debugfs_release(struct inode *in=
, struct file *fp)
 { \
        .name =3D nm, \
        .ops =3D { \
+               .owner =3D THIS_MODULE, \
                .read =3D readf, \
                .write =3D writef, \
                .llseek =3D generic_file_llseek, \


Can you fix it??

Jason
