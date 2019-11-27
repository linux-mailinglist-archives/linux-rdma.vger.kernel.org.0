Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7578E10B6A2
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Nov 2019 20:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfK0TX0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Nov 2019 14:23:26 -0500
Received: from mail-eopbgr80054.outbound.protection.outlook.com ([40.107.8.54]:38534
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726593AbfK0TX0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 27 Nov 2019 14:23:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WB33nHUR0Zc5OITdAAaIVOrbOcYbeKLdELzgaMdaWbXELXtMySO8cpqNDYrRdI4ai6Tvl6sJeS2jNERhA9xR0huJM/GPGOAydhn2XjIPrxAYbzdlucXsgJ8oYEMHOlD8AUfUSQ5ZjF5/exxLqbOQKCxa0fgvUv/R8Hz8AvfynVyWOqjF5NViYaySC32DBu9DnjDO3KpwjpWK5T45pMNZ5YKqtH/uMfEcQrbFniIljKnq2TA0FZY39yajhu0wttdCyRrMtbHpMyHypXmowbBL2Hu+whqBHAGxzjCYun0OKT8N46EbGw78AhadTVUkB4MDFF+idBGAz1f1VmBLRYqYjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QerfRLXgovxYUgKnKYPFjD2dKNlF37N6oKL3+0xeMbc=;
 b=gnVyaxqp6rA5umFLH4G9A60km1vdxorzQ7LleytFFS4mZpTRUNrh2uHEVLk643jysD2sjtyjmaRHysgnWqyZ6gwZytFgi/Avd/58BXSi/uPNdS8n63L+NRR1J6dVe9GnbeZ5WP6ivqSSTKJgNQmbzt+DR+WTy6kHUn7OhoBQLMFzRc0Mo3y61rQQ/BAg0kaEEp7X9AKgekKzih7n/QRKNrCcf7wggJ8+cKk5j2R9hCOvRPf77pLC7zBxWjfoirSgGkyDwmvVgC1GKyUsQy52T7evvYBbTwuE46DY2l1MgSx3dMRFzMApRw23P1UhxEHjvpdiYrUDgRGaY6BHkl0dmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QerfRLXgovxYUgKnKYPFjD2dKNlF37N6oKL3+0xeMbc=;
 b=GqDXHTwknhQyn/ZwYoCpq2Y6KrH+sQhaxNpabWlqlH6LPjB6MroyOH8vGArJv7tRR4RPb9ra2dGly7MkQp2QiH6eH9uWEqOOXa/vy5kqWTHbMlthfHjkDFEUZ0AItZDOp56OoJPMg3PjMlDUIeK2Nos3ZcXjOxiaXcanwsxgRbQ=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB3295.eurprd05.prod.outlook.com (10.170.238.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Wed, 27 Nov 2019 19:23:22 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::18df:a0fe:18eb:a96b]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::18df:a0fe:18eb:a96b%6]) with mapi id 15.20.2495.014; Wed, 27 Nov 2019
 19:23:21 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
Thread-Topic: [GIT PULL] Please pull RDMA subsystem changes
Thread-Index: AQHVpLkPnC8STmq42Ee9zkHJq9D0u6efVRMAgAARtwA=
Date:   Wed, 27 Nov 2019 19:23:21 +0000
Message-ID: <20191127192316.GY7481@mellanox.com>
References: <20191127002431.GA4861@ziepe.ca>
 <CAHk-=whUhSMUfCoAmk9YsP-R28a7+_Lda780JOfeVTVeopa_Fw@mail.gmail.com>
In-Reply-To: <CAHk-=whUhSMUfCoAmk9YsP-R28a7+_Lda780JOfeVTVeopa_Fw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR15CA0012.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::25) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8832172d-bb0d-4ed6-4514-08d7736f43f7
x-ms-traffictypediagnostic: VI1PR05MB3295:
x-microsoft-antispam-prvs: <VI1PR05MB329512083188A542FB508393CF440@VI1PR05MB3295.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(189003)(199004)(2616005)(11346002)(446003)(14454004)(66556008)(66446008)(64756008)(99286004)(8936002)(81166006)(66476007)(81156014)(229853002)(478600001)(76176011)(66066001)(6512007)(6916009)(8676002)(66946007)(6506007)(256004)(53546011)(386003)(52116002)(54906003)(5660300002)(25786009)(7736002)(71200400001)(6116002)(3846002)(26005)(102836004)(305945005)(33656002)(71190400001)(36756003)(316002)(4326008)(1076003)(186003)(4744005)(86362001)(6486002)(6246003)(6436002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3295;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JPyzHqm7fs+tq3LCxoknOqbfUJurtwKwYz/RO6mlKNdkzNNgxprEYIq/aUixtuZZE8W/0cQb5JpTnGe38ii4pxg7i2ozL4zuTJbqSatZ9nkvd0AAkuQnTc7DtDYXdCbPxKySFaWhpLVxYV7d/c1XTbpFt+5FZmGsqUxpufi+J9PemySrneNNKRP8Tx76IQL57Lj1zxeHbJfekXSuuYdQgtNnfNsHSuuPnIbyl/RpNYvAeYIX/CHX3f+eHQekt9AQsyTqkT9KUKT/F2ZLDUEEtATSXvHjQazMBeejWrIYKSLKwu//6SsZxtFYtlcLnzI/waun1zrkhIy5tRjsiSDZ2rS/qca3OftI9N8ZbAcUnFePtBMHGhybkJ9Aq2qIwQ2CWtPO1tgKDjXF2Nf8M73Z7rD2J8BwHN5j/RAyzuNBMpmoGyTdNauwPmmbU2xBpPQo
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9D5D41DADCB7DF43A29A9155F19D9658@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8832172d-bb0d-4ed6-4514-08d7736f43f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 19:23:21.7475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mNIUsNYaBqtOx3Vw8hbWWAlTXTjlvQJiISqwu4rbrNMGMMVR5Dzp1Jfbif7AudETEH812eIE/0keJg7S8UdnUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3295
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 27, 2019 at 10:19:52AM -0800, Linus Torvalds wrote:
> On Tue, Nov 26, 2019 at 4:24 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
> >
> > There is one conflict with v5.4, the hunk should be resolved in favor o=
f
> > rdma.git
>=20
> Ok, so no need for the (now two!) xa_erase() calls to be the
> "xa_erase_irq()" one?

Two? Yes dropping the irq is right.

-rc still had the irq call xa_store, but that part was removed in
this code in -next.

This conflict is because the fixes sent to -rc accidently missed that
-rc still had the irq and had a wrong xa_store.

I wanted to include the combined diff here, but git doesn't want to
show it to me :\

$ git show -c for-linus-merged drivers/infiniband/hw/mlx5/mr.c
$ git show --cc for-linus-merged drivers/infiniband/hw/mlx5/mr.c

It looks OK in your tree, thanks

Jason
