Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C633B97DD2
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 16:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfHUO7U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 10:59:20 -0400
Received: from mail-eopbgr00044.outbound.protection.outlook.com ([40.107.0.44]:59735
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726530AbfHUO7U (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Aug 2019 10:59:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmNJxnSBVFXrEni7WAFlKtKCR0F5+weOvPJgPhDllYg09IOnXKopUg/Dhk7rE2yHY43RnB1WjhpAptW23xO9KVt1zsWFeHxK7x5qivfwDwuoDZD7DywFqrCwfYYElO5wnThDOfFflO3k0DaIEexts9iuwVKDq8CSQLnt16SkZJqGnYrdv/rX63OtoEvI146D8c35X7kf6xh2QguVEQD6iuJ0UQenuzgPkqLSfxPb6dri8OEM4ffqP2JFd8S0TYX643yvKiVjA07YkCH+RV6o+ohdWrd2eTLwkZHyDux13HEW5lqAb5A7frGJ6lBXu3gAifiddnXVbY8SB41UCZ4PWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EI9QepD4hwgCULfxM5ojE4/MMliQ5NUAPbw2PcLTauw=;
 b=kW2t0FLYfItspqXTV/a/2fEOfmGgEpQBkFCx6JScHTMovGpk8jOm4QAFf4OlLCWjMFM50Vp7UFcMpWclMX2W1PhhrU1Ye64tF/seWS+0ekcpLwq1bmxPBMsPQ9AEf8LgWavyIO0Qn1W1oPLaXth2g9GrIMG4RijOkPJKGz7d0OY6kTuUS6+g1V6DwB+nSh1PEnrhurw0Q9VORuF1FXMzaeHwN8Hx+pYQnciP5aONqjXdbA18pmRjkyWNci3T216f7gAdTe8ssLg17nUN2THYQOsTmbpgHZCzyDwRTRbYpxOKuS7ck8hInuoMQvXZNIclmC4NAJgHcjSpv0bJBPB3Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EI9QepD4hwgCULfxM5ojE4/MMliQ5NUAPbw2PcLTauw=;
 b=PiOWuL4bh0Va7fBGPAEh2uAItUhNzMC+7Lg9k5FpyCIBxHi5aOPcs07bcTspOZIZjzAVf2WQlHDPM/PzRgnDIojkLPzyPrduMOepxYXt/MQY1xpMlTtbEg9U/k57rHjVc70NCFySIgL5sJpmvPtr/I6B7Bb9Hp2pY1liXmviroc=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6254.eurprd05.prod.outlook.com (20.178.205.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Wed, 21 Aug 2019 14:59:15 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1d6:9c67:ea2d:38a7]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1d6:9c67:ea2d:38a7%6]) with mapi id 15.20.2178.018; Wed, 21 Aug 2019
 14:59:15 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Yuval Shaia <yuval.shaia@oracle.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        Moni Shoua <monis@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        "kamalheib1@gmail.com" <kamalheib1@gmail.com>,
        Mark Zhang <markz@mellanox.com>,
        "swise@opengridcomputing.com" <swise@opengridcomputing.com>,
        "shamir.rabinovitch@oracle.com" <shamir.rabinovitch@oracle.com>,
        "johannes.berg@intel.com" <johannes.berg@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        Michael Guralnik <michaelgur@mellanox.com>,
        Mark Bloch <markb@mellanox.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        Max Gurtovoy <maxg@mellanox.com>,
        Israel Rukshin <israelr@mellanox.com>,
        "galpress@amazon.com" <galpress@amazon.com>,
        Denis Drozdov <denisd@mellanox.com>,
        Yuval Avnery <yuvalav@mellanox.com>,
        "dennis.dalessandro@intel.com" <dennis.dalessandro@intel.com>,
        "will@kernel.org" <will@kernel.org>,
        Erez Alfasi <ereza@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Shamir Rabinovitch <srabinov7@gmail.com>
Subject: Re: [PATCH v1 08/24] IB/verbs: Prototype of HW object clone callback
Thread-Topic: [PATCH v1 08/24] IB/verbs: Prototype of HW object clone callback
Thread-Index: AQHVWCwKnN+kxRGak0yNVpmMZX2/eKcFsaCA
Date:   Wed, 21 Aug 2019 14:59:14 +0000
Message-ID: <20190821145909.GD8667@mellanox.com>
References: <20190821142125.5706-1-yuval.shaia@oracle.com>
 <20190821142125.5706-9-yuval.shaia@oracle.com>
In-Reply-To: <20190821142125.5706-9-yuval.shaia@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQXPR0101CA0002.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::15) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8e36130-928b-4f97-2a13-08d726482206
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6254;
x-ms-traffictypediagnostic: VI1PR05MB6254:
x-ld-processed: a652971c-7d2e-4d9b-a6a4-d149256f461b,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB625492FB44C794C528F600BDCFAA0@VI1PR05MB6254.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(199004)(189003)(33656002)(2906002)(316002)(7416002)(52116002)(5660300002)(8936002)(66446008)(64756008)(6436002)(66556008)(66476007)(6916009)(486006)(66946007)(6512007)(6246003)(8676002)(4326008)(81156014)(81166006)(66066001)(25786009)(36756003)(53936002)(305945005)(7736002)(99286004)(54906003)(1076003)(102836004)(256004)(446003)(386003)(6506007)(2616005)(478600001)(86362001)(76176011)(6486002)(26005)(186003)(3846002)(6116002)(14454004)(11346002)(229853002)(71200400001)(71190400001)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6254;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kRsscLjLpr5JzsaTt1/lOkcpekORagHwcL764dvpkBPF5ktWGMG1Fmiy9nz4Po38qUWHkKa4MmmvhESZm/cVpNDLWEF9Lsrm2UdWXMaJwCJBIOLKJUm0BaFCkZpf1282WkC7AZDXo8Ma6S5YZ6uZ6o9nPxhYm6jgO7qXFXp2yXRDswlXJ00Qpk+cxzuwWHqYHtfRlJ/fKYv6uAH7IIYeUem3fhWjlAxIZObU3sHrmtrmgkrGgHzhlE4nB4LRsGgz1cbhToheplXwHqgA6KaWWcLKyPgW7pCK8gtB5OTgv7DoprSrKKpTMfKxUWWH2QvBbKBtuMfIEByhyi6hgfZS6CJXL7aaZSdy1wMkDMcA7qCUv0Neb6iz3Cve49/USVE8JrzfmZFuew8JaslsMjweAw0mLdgbCiLT0+iht9jLfQo=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C0F0D3DF9B067D4F9FE0F89D1EE16A07@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e36130-928b-4f97-2a13-08d726482206
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 14:59:14.9103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1aqS6nA/BeEcwiRFX3nmx5AuuYeBukC96/9fj3BJSnxjnQNOJFxRaT3V7QU/lLp7BB+6WWgfmMWzpLx9bGKA2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6254
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 21, 2019 at 05:21:09PM +0300, Yuval Shaia wrote:
> From: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
>=20
> Define prototype for clone callback. The clone callback is used
> by the driver layer to supply the uverbs a way to clone IB HW
> object driver data to rdma-core user space provider. The clone
> callback is used when new IB HW object is created and every time
> it is imported to some ib_ucontext. Drivers that wish to enable
> share of some IB HW object (ib_pd, ib_mr, etc..) must supply valid
> clone callback for that type.
>=20
> Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
> Signed-off-by: Shamir Rabinovitch <srabinov7@gmail.com>
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
>  include/rdma/ib_verbs.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index 7e69866fc419..542b3cb2d943 100644
> +++ b/include/rdma/ib_verbs.h
> @@ -2265,6 +2265,18 @@ struct iw_cm_conn_param;
> =20
>  #define DECLARE_RDMA_OBJ_SIZE(ib_struct) size_t size_##ib_struct
> =20
> +/*
> + * Prototype for IB HW object clone callback
> + *
> + * Define prototype for clone callback. The clone callback is used
> + * by the driver layer to supply the uverbs a way to clone IB HW
> + * object driver data to rdma-core user space provider. The clone
> + * callback is used when new IB HW object is created and every time
> + * it is imported to some ib_ucontext.
> + */
> +#define clone_callback(ib_type)		\
> +	int (*clone_##ib_type)(struct ib_udata *udata, struct ib_type *obj)

Don't like the idea of clone at all.

If the userspace driver needs to learn information about a HW object
it just imported, like some HW specific PDN, then the correct verb for
that is QUERY not clone.

And we already have a wide ranging infrastructure for drivers to add
their own driver specific query interfaces.

Jason
