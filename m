Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F46892583
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 15:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbfHSNub (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 09:50:31 -0400
Received: from mail-eopbgr00062.outbound.protection.outlook.com ([40.107.0.62]:9278
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726987AbfHSNub (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Aug 2019 09:50:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7FsozP8d5Y1UuS9AhAEi2AOia8uvrcozXD4DtVrptT0vkX7Kwf6S92GDVVXUgvJZSqfSrms96GQz/S4gEdw4o4en9udE8sW1e0qKjH7WskqGQY1z+tZpzRvsnGzQrrpRJwXWTJTFjNSF0CJUyDpjiWcjYH5JdcG0ZwOi7DIXrWJNpEtfwQz690vj5cYgp1QXvzY6PIGdAMNGaaB6Jgx1sZ8Z4BeAzmlqam/i17+PhwVe3XjdWIVZDgHreAFMb1RUllL3LzMoiBbm854POlEJW2IMmy6vVyNsSLdKumJ7jEpqRVmGPV+JAn5S9PG2h57m89KQD7CErkuqsg7d2qv4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6U7j5+qLA2p7ponSLGYqP5wY7h4dT6HfCN7UWeWhZ0U=;
 b=ZiB4sSa1BMlySwjncQAACBZ8qC5+2rEaLa8rMMRByD4QqTrlTee2s626jyBFZ+Tzaoi2t5p4ul9i+iPhjEeS08NMMlYL1iyrriORNhpy9fmp126zyaj37fmylWobT3/YvQ6QZRn4iyAMJ+QxHBTg4Sp1kbeNPLg4IYVf33foNyaG7bKqXeR482H9xRpBfW7Xvsor3Y9YyvpICGEJf+uCHcqWch/XhtkLKzY4S6ixBWXPIhJovbSIRthD9H4PJlZxyTi/tcjIsGiXQy/eQIMjcwK+6vKzHw2SfP1ynugLuG8HGwqhNuKAEyywoelfry6wQqpyra5UjYwjpv4BuImxGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6U7j5+qLA2p7ponSLGYqP5wY7h4dT6HfCN7UWeWhZ0U=;
 b=Opn8bZnnRbwLurC2NHD1s//vA2L+ooU6OnqRW2KFtwv4Gq8utDA1XxGCp+3r7r8twwn7Re88rm5lkmFmtb++eiACtKbKJYbs17kqf19msHcjH+xan5aX7L90Rao9c5IQGHHlKE9oL1ujN3IJyW4boDdvVBFiz/HfWWBCR1uc3OI=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6350.eurprd05.prod.outlook.com (20.179.25.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Mon, 19 Aug 2019 13:50:25 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1d6:9c67:ea2d:38a7]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1d6:9c67:ea2d:38a7%6]) with mapi id 15.20.2178.018; Mon, 19 Aug 2019
 13:50:25 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Noa Osherovich <noaos@mellanox.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-core 03/14] build: Add pyverbs-based test to the
 build
Thread-Topic: [PATCH rdma-core 03/14] build: Add pyverbs-based test to the
 build
Thread-Index: AQHVVluS1gyMnCV6Q06tSLNUVr8RuacCfVyA
Date:   Mon, 19 Aug 2019 13:50:25 +0000
Message-ID: <20190819135019.GF5080@mellanox.com>
References: <20190819065827.26921-1-noaos@mellanox.com>
 <20190819065827.26921-4-noaos@mellanox.com>
In-Reply-To: <20190819065827.26921-4-noaos@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQXPR0101CA0072.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::49) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 826a4e90-b72e-4af9-053e-08d724ac2fc5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6350;
x-ms-traffictypediagnostic: VI1PR05MB6350:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB6350023BCEE3C2BDAD82D8B6CFA80@VI1PR05MB6350.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(199004)(189003)(36756003)(256004)(33656002)(54906003)(71200400001)(6862004)(7736002)(305945005)(37006003)(86362001)(4326008)(5660300002)(6506007)(26005)(71190400001)(102836004)(6636002)(4744005)(99286004)(25786009)(76176011)(66066001)(186003)(2616005)(476003)(52116002)(446003)(11346002)(8936002)(6436002)(386003)(486006)(2906002)(1076003)(8676002)(478600001)(81166006)(81156014)(6512007)(6246003)(64756008)(66556008)(66476007)(66946007)(66446008)(316002)(53936002)(3846002)(6116002)(14454004)(229853002)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6350;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ekKBO8sr0ZuM7maMD1BF+rQN1pgbbTWycFAn6oUbgPfHEEydc3vTeMNkCPQszOXffWgpKAHCnR6DflURRCqUnmQIoHXYlaZZfevBzpJzfyhp8a4mHjOlCbfstecNJ+qKjrZoGy7qb6vZm8GqOs8oA6lWDiiYrMJ/68iz1E2OHlunNfsc807Nw54SMGhW1zWY9+uGawgXt/hGf8KoosfZhWAXsUWue941GURBOyFdeUn63B5Qal0HlMBqRnnhNOUYkmiU8VnP4X/LwThtT6jwK0fRVeA4c1C8v+P21BnnM8dSaVjhbi/u4x9KSs+tl4gzlhn5tuuOgRo8QlqZ/lns5wqs7CQRdL8EdNtjMg1c2BdJsPzqetjL3IywOUVp3omgxzr6LQy1EIaqAwvAx8QzokkiDEen4faH8fMAqXJ+3DE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <64AB072AFF889D49BED3017A5B3221BF@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 826a4e90-b72e-4af9-053e-08d724ac2fc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 13:50:25.2909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KDndsJ3d9wVDkDUXy6kxu9bAlUOKiK4Ieg+Vi79PTxyN9aWGFQuR6ZRRV1Isr8zAKBm614OYVIrOY+ZIx6Lkjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6350
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 19, 2019 at 09:58:16AM +0300, Noa Osherovich wrote:
> Have the tests installed separately from pyverbs as they're not a
> part of the package. They will now be placed under
> /usr/share/doc/rdma-core-{version}/tests.
> The tests can be executed as follows:
> python3 /usr/share/doc/rdma-core-{version}/run_tests.py
>=20
> Signed-off-by: Noa Osherovich <noaos@mellanox.com>
>  CMakeLists.txt                       | 11 +++++++++++
>  buildlib/pyverbs_functions.cmake     |  7 +++++++
>  debian/python3-pyverbs.install       |  2 ++
>  pyverbs/CMakeLists.txt               | 17 -----------------
>  redhat/rdma-core.spec                |  2 ++
>  pyverbs/run_tests.py =3D> run_tests.py |  0

I'd prefer run_tests to be in the tests directory..

Jason
