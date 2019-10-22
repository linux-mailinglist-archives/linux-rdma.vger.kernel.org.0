Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9AFCE0CF2
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2019 22:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732972AbfJVUA1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Oct 2019 16:00:27 -0400
Received: from mail-eopbgr20056.outbound.protection.outlook.com ([40.107.2.56]:24078
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727851AbfJVUA1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Oct 2019 16:00:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4VzfhtuVe8i2gzLY7Y0VMEuxPO8i2aowJWP3om9WdOYWbs9mWcRAghMjh63gPAYTZ5bF1yaW23RIJ8don/6xGBX4NVwzw6v2P4LmM5wollz84jyyXpMlD1QVpJKWMluhf1I55Nja76Lr1ugWC+HxBuUr2GAXyEufR6q3DYQxbqeRa063x9hi9M8tYayy6jQv/ri8P96qZLXEOWDZ/uAvaMALrukDuIFdcDy3Ittr9v/9CmnQI+OhSQO7a4NAsJB9vj/t48PQLMwCjveYApnIigWgSySGM0wxHRUSw7MnC4MpvbW10cTz81oHNyU+PXVQxgSRP/RL2rBxGaygQIK4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FayrOVcr7IxEyFrM8Tj3QX0cLSJtXfW2R8otP+/I9hA=;
 b=RH6HbtINWqznpaeWSz/004dXgb5MMQDPx6hQCOPhjiKxFf1rBz1ZN6e/57skWOxqKCiYIQofi7O0BTRSlIshAtHE4F7ZK5NOH2R+SXdCJnemrbonXXKkNsHyvhPyy2HQHVxuFgniTu5X1imoxKR/pj3oCfzMV3lDTp2SQdGCEp7cNmiFZ5NOOFw9HHgbvlt2zhgXmeoUVfiAnZt/eFkVBlkgBBSwuA3Xs7wu/cakmRGtCxlgrtQvqZqaOZY+sNLlgN7ysz8D0PD0ro0pQrJqTAGy3pD426EUNDXvW+fbVSgFndhAHmMMzgVwNd5OdAPUYB0HyLZSmCEjaUgRKpXXDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FayrOVcr7IxEyFrM8Tj3QX0cLSJtXfW2R8otP+/I9hA=;
 b=T7GiICIqBQNziIRyiAwArAX3KpDVFFLDxsd/zwKcjzxnOygNChEB8Rl0ByDlIjiTus10cBh9BHKrOBorms5vBCEX4XgV0aLoQEXTB0Jgl2KSLkHaV+9dUEgUHpZNNk0KQ77HpweM1BHvdfnPxiopE42Q+6HEoblbx2jE0oI2f7I=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB6095.eurprd05.prod.outlook.com (20.178.204.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.20; Tue, 22 Oct 2019 20:00:23 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::75ae:b00b:69d8:3db0]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::75ae:b00b:69d8:3db0%7]) with mapi id 15.20.2367.022; Tue, 22 Oct 2019
 20:00:23 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Parav Pandit <parav@mellanox.com>
Subject: Re: [PATCH rdma-next 3/3] IB/core: Do not notify GID change event of
 an unregistered device
Thread-Topic: [PATCH rdma-next 3/3] IB/core: Do not notify GID change event of
 an unregistered device
Thread-Index: AQHVhxNCzMVT9+VT6k6Ez6PLAMRPf6dnGIKA
Date:   Tue, 22 Oct 2019 20:00:23 +0000
Message-ID: <20191022200019.GP22766@mellanox.com>
References: <20191020065427.8772-1-leon@kernel.org>
 <20191020065427.8772-4-leon@kernel.org>
In-Reply-To: <20191020065427.8772-4-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR16CA0005.namprd16.prod.outlook.com
 (2603:10b6:208:134::18) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7efbf016-f95b-40da-e2c5-08d7572a7957
x-ms-traffictypediagnostic: VI1PR05MB6095:|VI1PR05MB6095:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB609551FAEE1F09A131161C87CF680@VI1PR05MB6095.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(199004)(189003)(33656002)(76176011)(256004)(6246003)(316002)(186003)(229853002)(5660300002)(54906003)(476003)(6512007)(11346002)(446003)(486006)(6506007)(36756003)(2616005)(52116002)(107886003)(4326008)(4744005)(99286004)(66066001)(26005)(102836004)(386003)(66446008)(86362001)(6116002)(3846002)(66556008)(6486002)(7736002)(478600001)(1076003)(81156014)(71190400001)(81166006)(8936002)(71200400001)(305945005)(6436002)(8676002)(66476007)(25786009)(66946007)(14454004)(6916009)(2906002)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6095;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mLh1X4n/NsYvSmdaZ6U5zg+/vaZyHeNsdlMl9YUWu7dDKojl9sAo2spCsgLXi2clQ0QtwxkJF5SgtJDTB8GDuOSAHo9bqRuIn+bQh9/bkBH3Vr0rxNTae3f9YaOgfW5SajD18C585GTfrS5cTVzi7uzjlVPEEykyj8hPlAMG3VE+8vNkjOlRl7bAGYBs47MS6rtvXBfWALX1B6cIvqsCrsVFP4g+Nk118NNuCPSBg1MycyO5vj+8bRuf3SjFwIrMmZaDIqkwrarF/w0EIY+hbwq2CbJ167aN0eD3vcQTsrgVf9gecyNhPRk9T1OmhPYTb94VDCQDkz/kBPgKIu91VRUYhyswepRa4gv6JBLQShgAu8A/YQeci47k1Sb09Xi6sGVbu0NkQaW+MOsbc7ngPi3vDvBPxqMT2ORvLNTzRHxYrUQPTQxYekGeJQ0huAxA
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B9E943AB15B7484DADE329D2CAF30284@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7efbf016-f95b-40da-e2c5-08d7572a7957
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 20:00:23.4958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LwRyzD5Q2u6BfkVmRPwP03msvr9icOD3vQFXEz+or7jZa5x5q2v+OePOVRvZZmwsGSamg9TPNHRikwj+ya2lxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6095
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 20, 2019 at 09:54:27AM +0300, Leon Romanovsky wrote:
> From: Parav Pandit <parav@mellanox.com>
>=20
> When IB device is undergoing unregistration, GID cache is cleaned up
> after all clients are unregistered in below flow.
>=20
> __ib_unregister_device()
> disable_device();
>   ib_cache_cleanup_one()
>     gid_table_cleanup_one()
>       cleanup_gid_table_port()
>=20
> There is no use of generating a GID change event at such stage, where
> there is no active client of the device and device is unregistered
> state.
>=20
> Signed-off-by: Parav Pandit <parav@mellanox.com>
> Reviewed-by: Daniel Jurgens <danielj@mellanox.com>
> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/cache.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)

Yep, this is a consequence of the recent cleanups in device. Applied
to for-next

Jason
