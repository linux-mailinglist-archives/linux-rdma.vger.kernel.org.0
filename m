Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC23F56F24
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2019 18:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfFZQvh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Jun 2019 12:51:37 -0400
Received: from mail-eopbgr150051.outbound.protection.outlook.com ([40.107.15.51]:9564
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726042AbfFZQvh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 26 Jun 2019 12:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPjeAQwMntUbAkTswmX2o0/2w7XGe83iRAt4K32thHg=;
 b=EU1anM8rg6p2tX6pHT1ZLGMFuRWzQlj7tdleYSB1QF6CS4ttdjWC2F90bcaHLXpCO+Qz6lTbaLG+9vNCoWKSkRt2wpYyFWydCIhK/XAE+3cFJsqHiQbbvig7t6h1FkofE0QZnET7zmSDh8ICznI0i8M7W/tw6Yc5127nBxy3FBo=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4222.eurprd05.prod.outlook.com (52.133.12.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Wed, 26 Jun 2019 16:51:34 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2008.014; Wed, 26 Jun 2019
 16:51:34 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next v4 0/3] Clean up and refactor some CQ code
Thread-Topic: [PATCH for-next v4 0/3] Clean up and refactor some CQ code
Thread-Index: AQHVK3vdFO1ecOcGo0ymGtnUdjnt0qauGbMAgAACL4CAAAOFgIAACGaA
Date:   Wed, 26 Jun 2019 16:51:34 +0000
Message-ID: <20190626165123.GA4092@mellanox.com>
References: <20190614162435.44620.72298.stgit@awfm-01.aw.intel.com>
 <20190625173144.GA27947@mellanox.com>
 <1e0ba685-5ae8-d97d-1555-e4832258cc91@intel.com>
 <20190626160843.GA8420@mellanox.com>
 <1cecef65-ea23-646c-d40b-191f58c6f8cb@intel.com>
In-Reply-To: <1cecef65-ea23-646c-d40b-191f58c6f8cb@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR11CA0061.namprd11.prod.outlook.com
 (2603:10b6:a03:80::38) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [24.114.41.48]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59ce8d55-36ef-43dd-e3b9-08d6fa568bd6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4222;
x-ms-traffictypediagnostic: VI1PR05MB4222:
x-microsoft-antispam-prvs: <VI1PR05MB422269BBA12006300685D446CFE20@VI1PR05MB4222.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 00808B16F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(366004)(136003)(396003)(199004)(189003)(66556008)(386003)(316002)(6506007)(81166006)(53936002)(81156014)(6246003)(8676002)(99286004)(76176011)(6916009)(11346002)(8936002)(2906002)(14454004)(6436002)(52116002)(73956011)(6486002)(229853002)(6116002)(64756008)(3846002)(66946007)(66446008)(33656002)(54906003)(66066001)(446003)(478600001)(1076003)(86362001)(71200400001)(2616005)(68736007)(5660300002)(71190400001)(36756003)(66476007)(6512007)(7736002)(305945005)(4326008)(26005)(102836004)(256004)(4744005)(486006)(476003)(186003)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4222;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Bmv06gM1oSDmoige4ZXge+1IHrtrKZAzhE6QoictCJEtwoRA+OKQx+SAuAQBbK5Eqlr+rA3wZzPdjUHIAsM3BCc5XBvW4l/DunUwdb80OyG/5l7VBeOYnByKalYpNjovjoOcSdVrQb3nrPUxlnPzBVvcETxQdT5szGvEH5HFkTdbHqgas6V7hJ6KdPigeJOpePwRfKS+95WzdkHbxEAI+lWbY5v8Eajir3Ie7+JEsCzjjh+RQnkP3iaH5vvax0Duy0OaJxO3tlL6/FtplSR5A1CdA16hK5qGxkj8XmPgkLQCFDjeFuZWCqOm6zZ5ni13+HeSzJjbElDCyVg8NibXWauSlBZDkXca2R4VwQ/Lgi+XDWBZLctliXSg+6rK0vMIy1wKqhCs2Lsueb7dVOgZJda4aq7UAo9Ws8ZFBlosCPM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6FF0312435C1B747B593A7D0C4625930@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ce8d55-36ef-43dd-e3b9-08d6fa568bd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2019 16:51:34.2989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4222
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 26, 2019 at 12:21:19PM -0400, Dennis Dalessandro wrote:
> Hmm... I'm not seeing it:
>=20
> Here they are in Doug's branch:
> $ git log --pretty=3Doneline -n 100 rdma/wip/dl-for-next include/rdma | g=
rep
> -e "Add new completion\|Convert to new"
> 4a9ceb7dbadf9e1435644b1f49720ee87431ce26 IB/{rdmavt, qib, hfi1}: Convert =
to
> new completion API
> f56044d686c82bd31713fc0398d68e322813dc62 IB/rdmavt: Add new completion
> inline
>=20
> Here is the for-testing:
> $ git log --pretty=3Doneline -n 100 rdma/wip/for-testing include/rdma | g=
rep
> -e "Add new completion\|Convert to new"
> awfm-01 $ echo $?
> 1

Ah the push got botched yesterday, fetch it again

Thanks,
Jason
