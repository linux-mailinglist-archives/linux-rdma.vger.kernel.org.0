Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A41DBF314
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Sep 2019 14:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbfIZMef (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Sep 2019 08:34:35 -0400
Received: from mail-eopbgr40086.outbound.protection.outlook.com ([40.107.4.86]:53895
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726001AbfIZMef (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 26 Sep 2019 08:34:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDAQytjOY9+ZTWMkUe9S+ZbKsPwyFBbJi0ku1RCDTB0fGf6//A+Km/Pqvlee6ld8Pf6cl28utPPS/CvkYY0bHkVnSm4vwqbVBzt2y2jqVvWkbHwLaqQQRBejufUe5/i6lMcMtOeEKgBTAhbGfm9HlmDgg2F/7Bmx7+FFXkfM5xYSMCqgZFqT2hbwkItoWSOahu/gTZjC1pCxyX9YsBdv2UKToKmh8g7dxnJketo2tQ83LDl1vQ+ks0ZV3/bREezhSCX4zvv3acThHbZJnFbpJQb40skcUs3rbx3gcbtt+4NdZFQ9UDFuo6mx93jE8O92t/KXf0Vv1GZahpdvtkoApg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MuUQ4PtWK5DKwctPzbTmgMlMmigaUyOisquGJmoYyKs=;
 b=TeMeNVRlYt1dTvForbxh716ww6JVbKHz94vTKogy6xMXZ/PfRdDjPBCM2OQECDgMk+UgTkg8U5nKUFKWRvlk3UVglprb7JnzxGvFou03dgZL26uJ2HpvC1NiPXletRQN0qgHxPyA+q/55LdvDzt4DPS/Ak9iblYTHNxE3jVdgTqlflMHgesjKD/+BsUW3MV/faXh4kqSsaxlWLnt9KoBP47xiVnqGORR+SNSZvTS2fTSxeF6Wwc9lsoa6aoJfXhAGDqT4IeDBwTWphIobgcdBpTav5DKQvdJCv6F5TlcMF2dddq6rBIbhMsGeHokLAFF7FcC4rrOGb8WKMtloBt0wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MuUQ4PtWK5DKwctPzbTmgMlMmigaUyOisquGJmoYyKs=;
 b=g9OLcxg4eRRH6PrktS/sBBQ2LdLtRHxRKGcIe9ri896TVkf/OXjugfgTUF7B2JKWX4d9yYRj4/5pH1wr4510vMfatw1TFsL0HV124KN0s1vP9Iqr6EIAzz1Fr/AlQLIYvHF+YpmVbIbUSDyUk/c2HShdMd/FHMen4WmT8gv9d34=
Received: from DB7PR05MB4138.eurprd05.prod.outlook.com (52.135.129.16) by
 DB7PR05MB4844.eurprd05.prod.outlook.com (20.176.236.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Thu, 26 Sep 2019 12:34:31 +0000
Received: from DB7PR05MB4138.eurprd05.prod.outlook.com
 ([fe80::502e:52c1:3292:bf83]) by DB7PR05MB4138.eurprd05.prod.outlook.com
 ([fe80::502e:52c1:3292:bf83%7]) with mapi id 15.20.2284.028; Thu, 26 Sep 2019
 12:34:31 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-core] kernel-boot: Tighten check if device is virtual
Thread-Topic: [PATCH rdma-core] kernel-boot: Tighten check if device is
 virtual
Thread-Index: AQHVdE7LmtT4Pt5d2kujr9uOMkraD6c95NqA
Date:   Thu, 26 Sep 2019 12:34:31 +0000
Message-ID: <20190926123427.GD19509@mellanox.com>
References: <20190926094253.31145-1-leon@kernel.org>
In-Reply-To: <20190926094253.31145-1-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTOPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::25) To DB7PR05MB4138.eurprd05.prod.outlook.com
 (2603:10a6:5:23::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.167.223.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf8cdfab-4fdb-415a-5a21-08d7427de155
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB7PR05MB4844;
x-ms-traffictypediagnostic: DB7PR05MB4844:|DB7PR05MB4844:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR05MB4844A8906A9DCCC578BAF0B0CF860@DB7PR05MB4844.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 0172F0EF77
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(136003)(346002)(396003)(366004)(39860400002)(376002)(199004)(189003)(36756003)(186003)(6916009)(6512007)(6486002)(33656002)(6246003)(5660300002)(102836004)(229853002)(2616005)(52116002)(66446008)(8936002)(476003)(6116002)(446003)(99286004)(3846002)(66476007)(66556008)(1076003)(486006)(66946007)(26005)(64756008)(2906002)(6436002)(4744005)(4326008)(25786009)(11346002)(71200400001)(81156014)(71190400001)(86362001)(76176011)(81166006)(316002)(66066001)(386003)(14454004)(8676002)(7736002)(256004)(305945005)(478600001)(54906003)(6506007)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR05MB4844;H:DB7PR05MB4138.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: a8xsGEq048osHip50JOOGj1xxVr3kuAPMe37EjTpx/mEwJ+SjyzCuCG/CJOJnVZFARJpyK1eRc4qGNGfc16NEy4lWk4IUEQh24vkHMrMLSJH3wnCN8+EtddlsneKQxOfLpFIk9jHbLphg7MjQc05gOKpNzYmnbqPg9sKCiwg1my2B41p48RdaNhf00pI10Qw2u3zA6In8M2MeFq3CjGQ2IV/Mu0JnbDr3E5l06bqgQy0SkFwX1GnFxZw86g2kvYms9/z9ZlBJ3NhMxMHCnVKnuh6+S2Fg/nBKU0ZCT+oP2sbh2pmnKc+QnsUIAaHgCfA9Zg1ZX0ySbS0P18JKNFJoxtCPUDy2Mqw2Po3DxHV2DXyaqeUj50y03IDhe4Zj/R6I5beEQ4xMnNu4RwT51ybs622tpm2VQr9pWDvdYXSAYc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8E6DD5B4EF53094795A7E89D8A8D9C1F@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf8cdfab-4fdb-415a-5a21-08d7427de155
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2019 12:34:31.6506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N6mpz+ohYW9GwyuppPjVBXRGt3K5P01Fsc8sNHXdMet0kZ8vUdRrKKKemaSJybgYex8ZeAXJgcND2gaBaACkVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB4844
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 26, 2019 at 12:42:53PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
>=20
> Virtual devices like SIW or RXE don't set FW version because
> they don't have one, use that fact to rely on having empty
> fw_ver file to sense such virtual devices.

Have you checked that every physical device does set fw version?

Seems hacky

Jason
