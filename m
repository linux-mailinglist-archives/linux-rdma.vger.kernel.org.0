Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9D95C87A5
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Oct 2019 13:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfJBL6Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Oct 2019 07:58:24 -0400
Received: from mail-eopbgr30074.outbound.protection.outlook.com ([40.107.3.74]:25643
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725875AbfJBL6Y (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Oct 2019 07:58:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RmVsW+5m6aGAr9xq72hFC0VdIpnrSfrIcchfSL5EMWsRtKO3/dzkPL0Pyd48LmsfQJGu+xcj6hHKC0dPR7unAfnP+nUVURq/Wffai3DbdoPhY9EjJ3AJtnfRKkxx3Vaz/xK2xf5qzeU12YunT9foinhXV1VvATPAuIqz2GHL0h+TShjG/HrIF/xmTW/qHnxilkpTWLOB08lP+RMb2aU6raa6tLv+EjTAWus1BP8Ga/XbTUtEtHcLpRJESjf35ryibhJYLpEd08aR4DhwL0F76AP3EqvpKeIsy44kfjN29Mb4TBiwdDiO8DZTxY1MFaFCHAbqpRvHDYOiITDD0kWWdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4r3d2SV6oIxqQi18uE/yr/XZ4tasBfXvxH2Vn7CILEY=;
 b=NQhved5k4RYDcpEcTv6E2wNaGbqK1Qgv+UogCRZWYYm+r5q3Pu3gyg6SmyFDddvQWYuj2sukJwKnGst9tZyJX8EV34esJsEUvlIB71qrzXDUS1fObshBXnt5fQjLitvb+wOP6tYI2cgMi+bjr/jxXf0O4DxCUd0d7D0tRt3XUI+gP3cXG0gVNSM60/7yz0V2VyKBXT1h/LrZ6AHkQbP/g9Rjy9J3wu4cw9tirj5jVIxUFs08ZBFHuxkk/QlFO0615KuBZ+wq433tvHdGdbhNpxXsWY1TjHY0TovIMfzDiINpWZRyyE2WVJckh7QKkA9YSZ3NBZ6Qw2eTsoL5P0iuGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4r3d2SV6oIxqQi18uE/yr/XZ4tasBfXvxH2Vn7CILEY=;
 b=VTZgAHMgln+Fr5R9ZQRdAqxX1LbSxlpWRbWU4BzaOsZ5gEwjxczQZ4GXMufQuYvvJVHrfyF6jF7IiRAQ8dc/WItxKOVJ2J4R7Y2AYRkPWonkbLLs6COeFtvBpDlV4dZreFOFzkWdl0fFBrEdDTImiwxYTGBh8JZUlZG74g9KyjE=
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com (10.171.188.155) by
 AM4PR05MB3331.eurprd05.prod.outlook.com (10.171.190.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Wed, 2 Oct 2019 11:58:20 +0000
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::dde1:60df:efba:b3df]) by AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::dde1:60df:efba:b3df%7]) with mapi id 15.20.2305.023; Wed, 2 Oct 2019
 11:58:20 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
CC:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Mark Zhang <markz@mellanox.com>
Subject: Re: [PATCH 1/4] RDMA/cm: Fix memory leak in cm_add/remove_one
Thread-Topic: [PATCH 1/4] RDMA/cm: Fix memory leak in cm_add/remove_one
Thread-Index: AQHVbF4M1BG7HW1qJEqd87E0thz0vadHWJ8A
Date:   Wed, 2 Oct 2019 11:58:20 +0000
Message-ID: <20191002115818.GC5855@unreal>
References: <20190916071154.20383-1-leon@kernel.org>
 <20190916071154.20383-2-leon@kernel.org>
In-Reply-To: <20190916071154.20383-2-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR02CA0030.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::43) To AM4PR05MB3137.eurprd05.prod.outlook.com
 (2603:10a6:205:8::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71c2ab32-aa28-4999-4f5f-08d7472fd1c2
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: AM4PR05MB3331:|AM4PR05MB3331:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM4PR05MB33319A58878A1507E6107733B09C0@AM4PR05MB3331.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:551;
x-forefront-prvs: 0178184651
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(346002)(39860400002)(396003)(366004)(376002)(136003)(189003)(199004)(478600001)(8936002)(64756008)(66946007)(6116002)(305945005)(476003)(186003)(486006)(33656002)(446003)(11346002)(14454004)(5660300002)(7736002)(25786009)(3846002)(8676002)(6636002)(2906002)(66066001)(81166006)(316002)(33716001)(256004)(71190400001)(1076003)(54906003)(107886003)(229853002)(81156014)(86362001)(110136005)(6246003)(4326008)(6506007)(102836004)(99286004)(66446008)(26005)(386003)(6436002)(76176011)(52116002)(71200400001)(66556008)(6486002)(9686003)(6512007)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR05MB3331;H:AM4PR05MB3137.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TBA7Er31K81vVoeifR/qGomUBVWvcPf/y4IpCm8qx2vcE2GG74wcOn1XrVfVaMlaCCq3qqUNo3hu7+11q04oqBz8GKLJlw6Ne21xA3uz+AW4OoULJbz2F+a01M9tcB2eUTunQS93uycH8gszgOJZAMa3qgddMlqIjh5P5tlyiRmBapIt56Yn3StRhYSJhTs1HSUpjuuATkOy5xJ/abb5RaJrlc8WA2Ooc3/HpU3ccqJTg2yVNEhqWBdRm7X8h407HpH9ouoeFjPWst+aX9iyQwCQIbLm8wNjEH/0FgpCs8CIU5UBsiDwIB1HPbzqonlImokfuYhct/qB12jA5CuZYEpKA5DtdOr/fXLfVmmSB3X788Tmvjp81rT4GYRd6QacUiXg86L8CUcJHpTtbqQ0xT0QuEo4Ru5lH9bXjV1xhTY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3EB5918116528C40B754A28884590BA5@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c2ab32-aa28-4999-4f5f-08d7472fd1c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2019 11:58:20.6081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DacHo8b05Nn7G1URt3KODJmEbufWtOcxwu+StVvKU/CLyuW4t86m0ukpfLAENelklF4aRsesd+5Hpo/vG8uGIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3331
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 16, 2019 at 10:11:51AM +0300, Leon Romanovsky wrote:
> From: Jack Morgenstein <jackm@dev.mellanox.co.il>
>
> In the process of moving the debug counters sysfs entries, the commit
> mentioned below eliminated the cm_infiniband sysfs directory.
>
> This sysfs directory was tied to the cm_port object allocated in procedur=
e
> cm_add_one().
>
> Before the commit below, this cm_port object was freed via a call to
> kobject_put(port->kobj) in procedure cm_remove_port_fs().
>
> Since port no longer uses its kobj, kobject_put(port->kobj) was eliminate=
d.
> This, however, meant that kfree was never called for the cm_port buffers.
>
> Fix this by adding explicit kfree(port) calls to functions cm_add_one()
> and cm_remove_one().
>
> Note: the kfree call in the first chunk below (in the cm_add_one error
> flow) fixes an old, undetected memory leak.
>
> Fixes: c87e65cfb97c ("RDMA/cm: Move debug counters to be under relevant I=
B device")
> Signed-off-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/cm.c | 3 +++
>  1 file changed, 3 insertions(+)
>

Can we take this patch till you will have time to debug better one?

Thanks
