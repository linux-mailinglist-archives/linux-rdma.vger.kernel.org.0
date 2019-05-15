Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E718A1E655
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 02:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfEOAeG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 May 2019 20:34:06 -0400
Received: from mail-eopbgr70050.outbound.protection.outlook.com ([40.107.7.50]:29633
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726195AbfEOAeG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 May 2019 20:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+Qdn/3XjScKwtXA3XU85Q5cO5eg7JzAM530DsfIYpc=;
 b=hzCWaktOJWBawFQwCUHmvSLf7VPIN/DmIqJpeeNxIh0AZ0oPrnjsEyud3z93AsqimeL4wV+7E4e1XvRDQyz3xcjUuocAoIOpVOj4em2KnXloVcerg7Mvs6tuCPTk60zUhlaogVep5a9R4EVzB3Qmxzt5YuE0KiUJ5ts0wEIZZUc=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6301.eurprd05.prod.outlook.com (20.179.24.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Wed, 15 May 2019 00:34:01 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1900.010; Wed, 15 May 2019
 00:34:01 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
CC:     Ariel Levkovich <lariel@mellanox.com>,
        Eli Cohen <eli@mellanox.com>, Mark Bloch <markb@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: undefined reference to `__aeabi_uldivmod' after 25c13324d03d
 ("IB/mlx5: Add steering SW ICM device memory type")
Thread-Topic: undefined reference to `__aeabi_uldivmod' after 25c13324d03d
 ("IB/mlx5: Add steering SW ICM device memory type")
Thread-Index: AQHVCrXk+svdC7ZGA0+cplzbz6uAcA==
Date:   Wed, 15 May 2019 00:34:00 +0000
Message-ID: <20190515003355.GB14522@ziepe.ca>
References: <20190514194510.GA15465@archlinux-i9>
In-Reply-To: <20190514194510.GA15465@archlinux-i9>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTBPR01CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::46) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.49.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 449c6bdc-9af5-4ad4-11bb-08d6d8cd0665
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6301;
x-ms-traffictypediagnostic: VI1PR05MB6301:
x-microsoft-antispam-prvs: <VI1PR05MB630101945A3301CF14616D03CF090@VI1PR05MB6301.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(376002)(136003)(346002)(199004)(189003)(81156014)(14454004)(68736007)(36756003)(6916009)(8676002)(81166006)(71200400001)(6246003)(478600001)(66066001)(5660300002)(53936002)(26005)(6116002)(186003)(3846002)(446003)(11346002)(9686003)(6512007)(86362001)(71190400001)(2906002)(256004)(8936002)(6486002)(486006)(6436002)(1076003)(73956011)(229853002)(386003)(66946007)(76176011)(66476007)(64756008)(66556008)(66446008)(6506007)(1411001)(7736002)(102836004)(316002)(33656002)(54906003)(476003)(99286004)(305945005)(4326008)(52116002)(25786009)(4744005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6301;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gpMz1T7fdkDlcvY9a65utpV0R5+dJbZDGGCEtNSmXeH4hn9cqNozQk9NnC0NSVtudXsZyPpnUH+WyKzK64IxrpdCuRWs+AnwE2HcSFpyi/RGY8uEMMDFGHp2bgZOPINBZASLwA0H0Ug4zuQXtIfJq6u49hPdDjmnj1NiCpdrytIuAmm7X4/P1FH2fnzm06jVfxhKUTJBKOB+GL4qq9H8+SA+aHDJZJjS0D0705r1RJmDaY08OoHdBOGblnmiPAglWtvryJhol7zPvIBZ3L0M5fSxQBrg9jsZd0T0aOdh0J57y2KFPRZ9BG6hh55h+682AhCofpAROcfGchFAVDJjN5gBIt2HBQ4PTCxdgV/fHrv1ueQ+LGURuHvDabtB2tu91nQlwdqvCJUNTIw8zkRrRUZZ3/+uOiYZ9dxvq72KVT8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3F636368DFC389429E2F9FABF9C45786@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 449c6bdc-9af5-4ad4-11bb-08d6d8cd0665
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 00:34:00.9624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6301
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 14, 2019 at 12:45:10PM -0700, Nathan Chancellor wrote:
> DIV_ROUND_UP is u64 / u32 in this case. I think DIV_ROUND_UP_ULL is
> needed but I am not sure if that has any unintended side effects so I
> didn't want to send a patch.

Hmm. Most likely those u64 length's should really be size_t.=20

Ariel?

Jason
