Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 744D6E8BDA
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2019 16:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389663AbfJ2Pdx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 11:33:53 -0400
Received: from mail-eopbgr60082.outbound.protection.outlook.com ([40.107.6.82]:63617
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389319AbfJ2Pdx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Oct 2019 11:33:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXCPZrCc1mPT/r/oj7jObSZCHP83SaBYIINFgxKzgj+ISqKGp4da1UcYAZCb1G9dMcSh7QSr7pLbTzq+sxIsQ+ux8e6iwwOcD5Qq6dGs9SgoLI2HbpMqy+oSwAs1EedUadiQUjaLOazy2W3oAxr7E/t1nCdgn0Dx7IP9PzNCF3czl6wjIJZ35Y3SH5JqGnT8RgM2NO9ilysKgrNdAPpZ+vnjwKEigCTJD+CQk6zTAER+FI16NXTCvGvYefmWOjwcpKkyi3FpIiQHn/Zz8izEaV7BVJG/ch6YfuIv2M7acv/+dzfmEfqtTUM1re8ehArm4onubFh6omnPtJNb7KMn5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZ9l6RurzCutGTTzCcPBCJMthn53QsUZ0APQIHmj1Js=;
 b=aFUJx4hAToRgV1WNZwYu1RnZ4vSezjggd/SAJUySHd7L5BncOENV76OoQRKqD7sgQS00SSB65E0ntVfdWj4EY4Ai6FnktIVnBB8Z432BlJ+QSsp2U5VKXas6gwOCRivX4nAA+1pomLCqKcpUBRU9Jmhy9U6kvouj1KsAdKaNyzxztketYtHdmdwsxv6Cjbrqac0wqQCkQGoGCTv3HSdHmRP7PPPp6n5OgTBE5ojMw2emvcgFJAapzsG0DhT3dSeF4Wi09KHaOf9U2oU+uGTxTV5h0gJ939u8y8gxClXmhiD4m9SUYWcmXoKOwg+HmcMD+5eBQDYy3RAHNKbnM2Ft8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZ9l6RurzCutGTTzCcPBCJMthn53QsUZ0APQIHmj1Js=;
 b=VG6OtGbGPe63VB3s8+9N1/K8RSWidy0ZQ/5ZCDRYO4FGxPugpchMrIzfqvH/l814R+X/fNxwDmUT3jM+fqYmhD3F9F4t2Pppfue1FXRE7rCroCeb02DsHjYttzNxlkdVRtcIFGKrx+os8NHTbVIoDBOmo4B7WnIhxopzZ7KaZRo=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB3248.eurprd05.prod.outlook.com (10.170.238.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.17; Tue, 29 Oct 2019 15:33:49 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d%5]) with mapi id 15.20.2387.027; Tue, 29 Oct 2019
 15:33:49 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Parav Pandit <parav@mellanox.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>
Subject: Re: [PATCH rdma-next v1 1/2] IB/core: Let IB core distribute cache
 update events
Thread-Topic: [PATCH rdma-next v1 1/2] IB/core: Let IB core distribute cache
 update events
Thread-Index: AQHVjk+ClBFC02EY0UK7mQp0UZzexadxvT6AgAACXACAAABHgA==
Date:   Tue, 29 Oct 2019 15:33:49 +0000
Message-ID: <20191029153345.GN22766@mellanox.com>
References: <20191029115327.16589-1-leon@kernel.org>
 <20191029115327.16589-2-leon@kernel.org>
 <20191029152419.GL22766@mellanox.com>
 <AM0PR05MB4866B01D2F20B82D341361BDD1610@AM0PR05MB4866.eurprd05.prod.outlook.com>
In-Reply-To: <AM0PR05MB4866B01D2F20B82D341361BDD1610@AM0PR05MB4866.eurprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR02CA0089.namprd02.prod.outlook.com
 (2603:10b6:208:51::30) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 88daf6bd-ae52-4866-ca91-08d75c85651a
x-ms-traffictypediagnostic: VI1PR05MB3248:|VI1PR05MB3248:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB3248E44CB9899B740A520EF6CF610@VI1PR05MB3248.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(189003)(199004)(99286004)(3846002)(6116002)(36756003)(4744005)(5660300002)(229853002)(6436002)(6862004)(8936002)(446003)(476003)(86362001)(486006)(11346002)(2616005)(25786009)(6506007)(386003)(102836004)(26005)(76176011)(71190400001)(71200400001)(52116002)(2906002)(186003)(1076003)(6636002)(64756008)(256004)(14444005)(66446008)(66946007)(33656002)(37006003)(54906003)(66476007)(66556008)(478600001)(6486002)(14454004)(305945005)(4326008)(6246003)(66066001)(7736002)(107886003)(8676002)(81166006)(81156014)(6512007)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3248;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w1KZ42bJExDxqU/50QGeSmZ7eE2LD42Uwqge2fgSmPcHYHMmlV7Oxsf7gnn6vnX+Yjf7W28C5mnfTWlqnGsazACLcZrgKiHypy+zgnSaIHuqGFvvpFomyEXNZWjCBAEyBQOQqS4x5i2TJXTkeV1VSWkU4rH3+jseUQpy94xQSEjL35podMIJ7lmxjhs4paQIKoPj0BJlCFQ77YJctTTbuZsYTwSsvKfh0SJFrZ7pk4KruJqQYbrAg8c5L1d0kQ91E6eZI2a/QhZEzHZnv0eT0CK0wYe5hkAnvR4N0xD5LHQj3Plm104pYYWwyKBOe3JlYYk5vLNI/A/6HAR99v4DDDNKSdUvyzlW6do8mpCbvltVElZYHML2gRlRCzOgJ8RbHzWhrUgLNHKdJS23J0XO364b3ap4qS1ATIbvYg9mhS5GPznA/9EWn1p6yW6ia9Zh
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8D391DA44BF4BE428AA2FBABA2CF5AE3@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88daf6bd-ae52-4866-ca91-08d75c85651a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 15:33:49.4384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o+acVRej1/O9gFFdcEPjvX4QGWVdoNKJG5kBYLJUmyA3vs7/hGZP4YqvDie77fQp49Df9wFRF+O7xSnyOhGphw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3248
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 29, 2019 at 03:32:46PM +0000, Parav Pandit wrote:

> > > +/**
> > > + * ib_dispatch_event - Dispatch an asynchronous event
> > > + * @event:Event to dispatch
> > > + *
> > > + * Low-level drivers must call ib_dispatch_event() to dispatch the
> > > + * event to all registered event handlers when an asynchronous event
> > > + * occurs.
> > > + */
> > > +void ib_dispatch_event(struct ib_event *event) {
> > > +	ib_enqueue_cache_update_event(event);
> > > +}
> > >  EXPORT_SYMBOL(ib_dispatch_event);
> >=20
> > Why not just move this into cache.c?
> >=20
> Same thought same to me when I had to add one liner call.
> However the issue was device.c has the code for the event registration/un=
registration and calling the handlers unrelated to cache.
> So moving ib_dispatch_event() to cache.c looked incorrect to me.

Well, maybe we can move the wq code from the cache.c into here?=20

It looks just as incorrect to have the one line call

Jason
