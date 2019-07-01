Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7445C32E
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2019 20:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbfGASn6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Jul 2019 14:43:58 -0400
Received: from mail-eopbgr150084.outbound.protection.outlook.com ([40.107.15.84]:36929
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726316AbfGASn6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 1 Jul 2019 14:43:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ko6PdYYUouwLZuvR5g+NQlzFBvnsqPIIb5pcyXRrd4M=;
 b=aAN1c7el1LuMaz0gd4siLiOQmCmd6kDjwkhR4AzHrk0wzg66WI5jeWYzGqmO7tQ6dR8zRqXRa3fHzXjfE/Lqy0kIhQwMFHW6wFYlSkRBgdjkXQmYlYr6LLpkVTZWrIx3fNiwL/ZwHMyS9p3C815XIj0OqTtL3Kszh85+Rdx/grY=
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com (10.171.186.14) by
 AM4PR05MB3235.eurprd05.prod.outlook.com (10.171.186.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Mon, 1 Jul 2019 18:43:55 +0000
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::bc5a:ba8b:1a69:91b6]) by AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::bc5a:ba8b:1a69:91b6%6]) with mapi id 15.20.2032.019; Mon, 1 Jul 2019
 18:43:55 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Jianchao Wang <jianchao.wan9@gmail.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
Subject: Re: RDMA on Mellanox ConnectX-4 Lx cannot work
Thread-Topic: RDMA on Mellanox ConnectX-4 Lx cannot work
Thread-Index: AQHVMAUU/CYhHZpaP0SKeH6S0DuWI6a2GYQA
Date:   Mon, 1 Jul 2019 18:43:55 +0000
Message-ID: <20190701184248.GM4727@mtr-leonro.mtl.com>
References: <13dde97d-77a7-7663-1766-068082342e05@gmail.com>
In-Reply-To: <13dde97d-77a7-7663-1766-068082342e05@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P194CA0022.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:90::35) To AM4PR05MB3137.eurprd05.prod.outlook.com
 (2603:10a6:205:3::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [37.142.3.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc235361-6686-4d13-5274-08d6fe5411f2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM4PR05MB3235;
x-ms-traffictypediagnostic: AM4PR05MB3235:
x-microsoft-antispam-prvs: <AM4PR05MB3235DDC3AFF32C437A952548B0F90@AM4PR05MB3235.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 00851CA28B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(199004)(51874003)(189003)(102836004)(53936002)(8676002)(66476007)(76176011)(1076003)(6116002)(99286004)(6486002)(3846002)(5660300002)(6916009)(6512007)(9686003)(52116002)(71190400001)(6246003)(8936002)(54906003)(81166006)(81156014)(186003)(316002)(14454004)(26005)(71200400001)(386003)(6436002)(6506007)(25786009)(4326008)(446003)(66066001)(256004)(478600001)(11346002)(476003)(66446008)(86362001)(558084003)(73956011)(66946007)(64756008)(66556008)(68736007)(486006)(7736002)(2906002)(33656002)(229853002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR05MB3235;H:AM4PR05MB3137.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xZ9W2ip8dLE1q40nbBOendjqTSAcVbtbLkohSAvsa5c9s1Hb8ORyFVlTPuofI45cXzvlvS4eXwgEPE6yaP+DWgHZZMY3mPCQXbH76RAUSa+wszIOWQ00x9CExZj7QMEwYTG/iznyyE/lufpVvlIRainZuFLvrqTIqOGLWoHnPry3hS68/3MMeTFU4f/5efeIUzQ/t76Zh/yQ0kzy1KnJeLx8f4Jmz0NJqRssyXjkCtgiv8H0so8gpUdKF1vn7Cv+MAdRKAoqa7DvpM8614ZxVRANfNIwZzQJ6SO2x3k7u14S+kxik71xn/UwL6/YuVT0ZnV8ebwxGIHGqrkmIIurIh492PcToSO7aOQjTXyDQR3SFC9YgLYP/b38w/AQ2KyRH85lpFIGeIQPU3eiZ+oANguMOWyG/gcCR9ELY8kG1jE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AD64AE0599EB4A49A95D5FC07D68694F@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc235361-6686-4d13-5274-08d6fe5411f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 18:43:55.5063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leonro@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3235
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 01, 2019 at 08:03:57PM +0800, Jianchao Wang wrote:
> Hi RDMA guys
>
> This is my first time to try to setup a rdma environment.
> Would anyone please give some comment here and many thanks in advance.

Please contact official Mellanox support channel.

Thanks
