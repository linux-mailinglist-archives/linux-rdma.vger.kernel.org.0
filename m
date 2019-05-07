Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3600916406
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2019 14:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfEGMxI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 May 2019 08:53:08 -0400
Received: from mail-eopbgr60049.outbound.protection.outlook.com ([40.107.6.49]:22918
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726000AbfEGMxI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 7 May 2019 08:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8C4mB8Cr0eeODlb7eOHWXWNl8yVPqMMYtOr851Dfl8=;
 b=fPzxHrWZX26x2amHGOKSDsO6KgbgamONOvijkKQfRTAfeNqaoBCEOtwXV8w6I1Xt9kUsV3gyTH9tUjWUugxmfM7HdopMxKf6nsx1w5q/Flan46t9HjQ1sm3/JlY8wI/HfrGwRegeocDYg9+/+PIDYoBKYfGCSoBmtHC40tnNvHE=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4125.eurprd05.prod.outlook.com (10.171.182.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Tue, 7 May 2019 12:53:04 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044%5]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 12:53:04 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Adit Ranadive <aditr@vmware.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>
Subject: Re: [PATCH] libibverbs: Expose the get neighbor timeout for dmac
 resolution
Thread-Topic: [PATCH] libibverbs: Expose the get neighbor timeout for dmac
 resolution
Thread-Index: AQHVBJQ03rON3H5UMUmK3O/KPKwCrqZfnnCA
Date:   Tue, 7 May 2019 12:53:04 +0000
Message-ID: <20190507125259.GT6186@mellanox.com>
References: <20190507051537.2161-1-aditr@vmware.com>
In-Reply-To: <20190507051537.2161-1-aditr@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQBPR0101CA0050.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::27) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.49.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d9df7b7-1337-4bb2-5f6e-08d6d2eaf1ff
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4125;
x-ms-traffictypediagnostic: VI1PR05MB4125:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR05MB41251A03B75B99F5C0DAF4D9CF310@VI1PR05MB4125.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(366004)(136003)(189003)(199004)(11346002)(446003)(4326008)(6512007)(26005)(6306002)(186003)(99286004)(76176011)(316002)(52116002)(6486002)(6916009)(66066001)(2616005)(478600001)(36756003)(476003)(486006)(86362001)(53936002)(2906002)(966005)(3846002)(6116002)(6246003)(14454004)(25786009)(5660300002)(1076003)(7736002)(6506007)(386003)(102836004)(229853002)(68736007)(305945005)(66476007)(66446008)(71190400001)(6436002)(73956011)(66946007)(54906003)(66556008)(8936002)(81166006)(81156014)(71200400001)(256004)(64756008)(33656002)(14444005)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4125;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TjsNWGXCfkMt7ybnkNg1MXrME6paMKwMdmb71Ft4C01UVjM9oV6xxWU1Xn/8/QzeaJKyrCvR41mYlNPbzjp2s2qUhiurLkObYzw30x2Kimc6UntQHAg5s5/ZUjU9QSzP1n7BbRllbZ5VMfGOeQxb03P7TzojDBKgknlBthJdXa78rcbPcAOF9DVFecHyDbY5CTpM0P5Q6X5p3Z2TZDkgv2Di1xyCDMA6k0J5sd9NE0QWcqoxqjzhGyJpwafkGIi9YcBRc8HdiEEW+OtrvU0pyug//oRFsuap7SBBk4xJQf4wowausmhiBFI25ZvRmhnrY3nUkfshzp3xAqUdYtMOKZCCl3hWG272i+1n5WMXZJyCrc6NPexmUCnZzQQO/T2V/j7jt1YIDJ5RP69nOWCsfsjVsRJlucIsR0rzEyUlSH4=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C7033A2356F08A4FB187195E81AFE225@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d9df7b7-1337-4bb2-5f6e-08d6d2eaf1ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 12:53:04.6731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4125
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 07, 2019 at 05:17:45AM +0000, Adit Ranadive wrote:
> This allows the neighbor timeout to be configured while building
> rdma-core using the extra cmake flags.
>=20
> Reviewed-by: Jorgen Hansen <jhansen@vmware.com>
> Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
> Signed-off-by: Adit Ranadive <aditr@vmware.com>
> ---
>  CMakeLists.txt       | 6 ++++++
>  buildlib/config.h.in | 2 ++
>  libibverbs/verbs.c   | 1 -
>  3 files changed, 8 insertions(+), 1 deletion(-)
> ---
>=20
> Here is the PR:
> https://github.com/linux-rdma/rdma-core/pull/524
>=20
> ---
> diff --git a/CMakeLists.txt b/CMakeLists.txt
> index beb8f4ec1238..8dbdd2b807f4 100644
> --- a/CMakeLists.txt
> +++ b/CMakeLists.txt
> @@ -45,6 +45,8 @@
>  #   -DNO_PYVERBS=3D1 (default, build pyverbs)
>  #      Invoke cython to build pyverbs. Usually you will run with this op=
tion
>  #      is set, but it will be disabled for travis runs.
> +#   -DNEIGH_GET_DEFAULT_TIMEOUT_MS=3D3000 (default)
> +#      Set the default timeout for lookup of neighbor for mac address.
> =20
>  cmake_minimum_required(VERSION 2.8.11 FATAL_ERROR)
>  project(rdma-core C)
> @@ -84,6 +86,10 @@ if (IN_PLACE)
>    set(CMAKE_INSTALL_INCLUDEDIR "include")
>  endif()
> =20
> +if ("${NEIGH_GET_DEFAULT_TIMEOUT_MS}" STREQUAL "")
> +  set(NEIGH_GET_DEFAULT_TIMEOUT_MS 3000)
> +endif()
> +
>  include(GNUInstallDirs)
>  # C include root
>  set(BUILD_INCLUDE ${CMAKE_BINARY_DIR}/include)
> diff --git a/buildlib/config.h.in b/buildlib/config.h.in
> index 0754d2494234..590e70162d1e 100644
> --- a/buildlib/config.h.in
> +++ b/buildlib/config.h.in
> @@ -61,6 +61,8 @@
>  # define VERBS_WRITE_ONLY 0
>  #endif
> =20
> +# define NEIGH_GET_DEFAULT_TIMEOUT_MS @NEIGH_GET_DEFAULT_TIMEOUT_MS@

Extra space..

> +
>  // Configuration defaults
> =20
>  #define IBACM_SERVER_MODE_UNIX 0
> diff --git a/libibverbs/verbs.c b/libibverbs/verbs.c
> index 1766b9f52d31..2cab86184e32 100644
> --- a/libibverbs/verbs.c
> +++ b/libibverbs/verbs.c
> @@ -967,7 +967,6 @@ static inline int create_peer_from_gid(int family, vo=
id *raw_gid,
>  	return 0;
>  }
> =20
> -#define NEIGH_GET_DEFAULT_TIMEOUT_MS 3000
>  int ibv_resolve_eth_l2_from_gid(struct ibv_context *context,
>  				struct ibv_ah_attr *attr,
>  				uint8_t eth_mac[ETHERNET_LL_SIZE],

Really compile time configurations are not so useful, what is the use
case here?=20

Why does this timeout even exist?

Jason
