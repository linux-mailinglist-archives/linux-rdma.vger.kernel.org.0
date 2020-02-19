Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5842E163897
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 01:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgBSAfm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Feb 2020 19:35:42 -0500
Received: from mail-eopbgr10085.outbound.protection.outlook.com ([40.107.1.85]:22624
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726488AbgBSAfm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Feb 2020 19:35:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KU7bwpAQybgXPzalhCfMwHXZGPOSyb3PU+ol8coMpey8n/ql0Mzbl7ZyZar+n0lkEenYi2AQvqLfP7Q4b4maKRS04YUP89xRF7VImnlY1MdmX79wVHI/5nQU7hsPZpkcJt/HacOZjjN5Q4rmalEav+KFwsTcGsRJgRg48Q60QMh4eOKKXLn9r/xrtuF6P71D1LEBBp9IEI5IFocDoJpyXgwetquLFpnCWUZogeSYMT7baJqh1yXbjl+e8FaAQ2rupyFPYpexYtz8os3hahA6WoTEVmxjFhorwntxnCfyAuZVwd4VfxJJpGtEK9LgZ/4cFvXJ7vpPt3DnyQju0Ps8jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKVnonazkHc3NljoeQGq9sIpf7yJKAFyXHWbKZAPVYI=;
 b=LdaSmmQR034XiCQLo8j/e8BukDe6H1WkaKA/kfja7tVIIU4APUj2Yh3q22UT5mXmdTgVseDXXFHtTI1CDz6OleAl1o4MFtNCIoTt44/S7m2Dy6jVOw1n6gKerctvtdI5mzXm62Z9iLdkdUADaFMddWFqZaEWGSGBiDQAfVneQ0VmAYFFX5IzES9HrG9trOnUiRT3IQWrb9BxZ//RNFLmasIILi3P2AmpjqNjkzcVdzkGcPHQwivAvRYTqs7CX+GvUJjxThS4syOibqPowV8ZomHFhGVYubXD1D0qM5Dl9XYEAqpQmy7XR147D/mL0eQNQ6vSCYtszFX9U/QM2fgxEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKVnonazkHc3NljoeQGq9sIpf7yJKAFyXHWbKZAPVYI=;
 b=JoB/WV9H3Wl5l79QkEVtxjrb9qjN7vcm68TqqZSCpqLj6XOlHnqVfENqAPdB7rUvHQjte7TRJ5LIB6WYb+8lpgyM9jD0nGJVyTBxYp/4fEGECMbLMIuxYIqQ4mIolMS6ZGoGjJ5K/WFoWbga0HUsOABQrKxya6ToAEOmj9hcayM=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB5726.eurprd05.prod.outlook.com (20.178.120.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.24; Wed, 19 Feb 2020 00:35:38 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 00:35:38 +0000
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR01CA0049.prod.exchangelabs.com (2603:10b6:208:23f::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22 via Frontend Transport; Wed, 19 Feb 2020 00:35:38 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1j4DKw-0003Vk-NX; Tue, 18 Feb 2020 20:35:34 -0400
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Max Gurtovoy <maxg@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA/core: Get rid of ib_create_qp_user
Thread-Topic: [PATCH] RDMA/core: Get rid of ib_create_qp_user
Thread-Index: AQHV4qJ6a1W+lZNe+0mmb8tDCVTkEKgdt6wAgAP8DQA=
Date:   Wed, 19 Feb 2020 00:35:38 +0000
Message-ID: <20200219003534.GE23930@mellanox.com>
References: <20200213191911.GA9898@ziepe.ca>
 <acbaf760-a3fe-f3c6-4b0b-e3e9a48cc876@mellanox.com>
In-Reply-To: <acbaf760-a3fe-f3c6-4b0b-e3e9a48cc876@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR01CA0049.prod.exchangelabs.com (2603:10b6:208:23f::18)
 To VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.68.57.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ce0b2ed2-5f10-44e6-e3e2-08d7b4d3a44b
x-ms-traffictypediagnostic: VI1PR05MB5726:|VI1PR05MB5726:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB57260BC6A4CD45C7A3D915B3CF100@VI1PR05MB5726.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(199004)(189003)(66946007)(64756008)(66556008)(66446008)(66476007)(6636002)(5660300002)(6862004)(86362001)(316002)(4744005)(36756003)(37006003)(4326008)(52116002)(8936002)(8676002)(9746002)(9786002)(2616005)(186003)(53546011)(81166006)(33656002)(81156014)(2906002)(478600001)(1076003)(26005)(71200400001)(26583001)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5726;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vzfuL7gn4P5rU62B6UcUsofUE5Ri0jxyU1PkWIhwWYSKZHbN1A77DM3edI4Z0NO1JA1h4gX38Rmkmt05d4G0l+x3nVznEBpPZgK55wH2wdDiHQBlR7Sw9TmDNcRyvDc//oyfqM1etsjbL/sXta6NioIb7HcFX8cm7W1cZGLYClaQVI+1Gtbg1jhvlZDyBl9b+awDxJI1TQvQ/241D56kVkijPt6jPGgNSPA4k5/Epb9uGR92DTHWVpLFJI6KJ7+KB7hWZDO4W/HVrFgBmwMzxM2jFEgOSB92JdAG24hD/GVTGtk5ySyd9hBYBFkAzEvDPJqRjRtok0rRUQOBBUR3K9h0g2q3VKQ9P8rz1/RMsyV98wTYx/anOeYf97kLKXLIdcwgxzqdw3vmS8cMsi00m9sFUShn/CUM9Y+LYTaeZZaDKumWJ1fRmCtg0iCONSaHvtzQxmwGuoOQgiX9NRSlNHrHMNpWqlyhxjoOKOMznhyKHhh3Z/OMLTkXCHDqHOFaX23rsjsMYskXtf09QDhzNg==
x-ms-exchange-antispam-messagedata: p9CoutK0lrffUz3K25hxG7FK40ha4U7/jwiDiwbaKtdavH9lbd+Q6oDj9iiDySjK6BF+8vMDHepCkdz71uKvitD2qNboBEDS+U4/wUaPzs+jbpIyEA6+mRBvm9gzr8TVbd4Q9ilLCquaQGtoDRZT4A==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2BF5CFED87C513498232037474C3AB33@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce0b2ed2-5f10-44e6-e3e2-08d7b4d3a44b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 00:35:38.4650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bCG6jkb/huBlHTwC5zfAJgkat47m0Jle2xLfr4UDXO0fZDm3elwPF8/2rKWltiKSW9mRLr9bjI/d8tzdukyRSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5726
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Feb 16, 2020 at 01:44:40PM +0200, Max Gurtovoy wrote:
>=20
> On 2/13/2020 9:19 PM, Jason Gunthorpe wrote:
> > This function accepts a udata but does nothing with it, and is never
> > passed a !NULL udata. Rename it to ib_create_qp which was the only
> > caller and remove the udata.
> >=20
> > Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
>=20
> Looks good,
>=20
> Reviewed-by: Max Gurtovoy <maxg@mellanox.com>

Thanks, and applied to for-next

> BTW,
>=20
> shouldn't ib_alloc_mr_user need also to be updated ?

How so? It passes the udata to the driver

Jason
