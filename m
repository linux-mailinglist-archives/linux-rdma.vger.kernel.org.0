Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 659C86355E
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2019 14:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfGIMEv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Jul 2019 08:04:51 -0400
Received: from mail-eopbgr20064.outbound.protection.outlook.com ([40.107.2.64]:14060
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726030AbfGIMEv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 9 Jul 2019 08:04:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w74PIkAyhY3XKkmg15CZFUzu5n5EF719VaPP9bTtq5w=;
 b=jvxsTlGgvNjRMbubetgaB++fE5oujMvHkRxWvLTLU+rh1puO+mAhcDlvkVUUrV049iWnV/N/X/3Gb06s9v6OL36ACZbYNQ049mupoOn2tv8ptcVUx5YYRKuoN16HRYRFOeYkF4559BJun0DUL4ancJItWAElCreo2ejvy/FyvvQ=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4974.eurprd05.prod.outlook.com (20.177.52.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Tue, 9 Jul 2019 12:04:46 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2052.020; Tue, 9 Jul 2019
 12:04:46 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>
CC:     Jack Wang <jinpuwang@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        Roman Pen <r.peniaev@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 00/25] InfiniBand Transport (IBTRS) and Network Block
 Device (IBNBD)
Thread-Topic: [PATCH v4 00/25] InfiniBand Transport (IBTRS) and Network Block
 Device (IBNBD)
Thread-Index: AQHVJ3lZV9PpgZHYIUmJKGJeUubTI6bCKc+AgAAkOoA=
Date:   Tue, 9 Jul 2019 12:04:46 +0000
Message-ID: <20190709120443.GA3436@mellanox.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <CAHg0HuzUaKs-ACHah-VdNHbot0_usx4ErMesVAw8+DFR63FFqw@mail.gmail.com>
In-Reply-To: <CAHg0HuzUaKs-ACHah-VdNHbot0_usx4ErMesVAw8+DFR63FFqw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR0102CA0022.prod.exchangelabs.com
 (2603:10b6:207:18::35) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 828b3d88-2d53-4904-c8af-08d70465a2e8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4974;
x-ms-traffictypediagnostic: VI1PR05MB4974:
x-microsoft-antispam-prvs: <VI1PR05MB4974D2FBAF787C6801D92F7ECFF10@VI1PR05MB4974.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0093C80C01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(189003)(199004)(76176011)(73956011)(52116002)(66066001)(68736007)(99286004)(4326008)(386003)(6506007)(36756003)(66946007)(66556008)(66476007)(66446008)(64756008)(107886003)(6916009)(11346002)(2616005)(6246003)(7736002)(486006)(81156014)(476003)(8676002)(8936002)(4744005)(14454004)(81166006)(5660300002)(1076003)(25786009)(256004)(33656002)(2906002)(53936002)(86362001)(71190400001)(6486002)(102836004)(26005)(305945005)(186003)(6116002)(54906003)(229853002)(6512007)(316002)(71200400001)(446003)(3846002)(6436002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4974;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eJRzXmiALd89U00OSTNTfL66sJlfMXl4UV7IYPUrkUDDDsozZ5ukv37dNrUna5X2p86j2FBNLHabxYU1wJJOJgYPP5C0NArYAQLRM7O7lrWh+NhZ9QpLN02MTm4BUPUamK5MLJOEgKw6+PlbF/LtpgVos/JcC8UgZvIZ1YQ2hJ0wpmlVxp4V1F2fXnv9GqnwG3TzAp4ajdwo9m/6QLI+l80A5KB4qBZe00P/gi4l+zetUwqnW4o3zRCUUQOh0avU9JgbDR8S75PPj/O2dWAHCNKHHvwpIC5Xdy0zgJXeGOHRctxuYXiu+Zl+w0//e7s2uQyfb6JLmuZ8InMu6/0HNVAUkXacQehgtx/8aliSCiL4KJwXfzF/2IzsYMHvTnK5m9Bpy5haNUx0Vtret1RZ5C26iAfM60iJI5hlbm9qUqM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <569BEEF6F97FCE4E8D00274A33717E56@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 828b3d88-2d53-4904-c8af-08d70465a2e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2019 12:04:46.9536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4974
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 09, 2019 at 11:55:03AM +0200, Danil Kipnis wrote:
> Hallo Doug, Hallo Jason, Hallo Jens, Hallo Greg,
>=20
> Could you please provide some feedback to the IBNBD driver and the
> IBTRS library?

From my perspective you need to get people from the block community to
go over this.

It is the merge window right now so nobody is really looking at
patches, you may need to resend it after rc1 to get attention.

Jason
