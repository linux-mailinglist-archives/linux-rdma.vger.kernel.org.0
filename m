Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 474E068FA1
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jul 2019 16:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389060AbfGOOPs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 15 Jul 2019 10:15:48 -0400
Received: from mail-eopbgr40066.outbound.protection.outlook.com ([40.107.4.66]:6062
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389027AbfGOOPs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 15 Jul 2019 10:15:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6eSHBBOueHd/Hr8Bp9vKeDO2R4zJtVhtkCzB3ta7SltSwKJhL7gM0/fv0rK0jSgUlwqh8o6DVZac5EDOTmo5TJxf2zI4pf6Z2cUqOmYcIqAxNCP3fWTvmlotUaFJHnrXNJCi0As1gQi90TNyPpydGH4w6cwr232jlke/QoCig3yXF7D+Td9rF2HUmIJZ3cMfo7fD58uZvEBWAJlX0MODlQvKwfT9CNXiMCoI8HlVGTIeKcpPLtimPkKdh4IQr2dBjVFkdhSK72rO2PglNY5C9ufeWpICYkiQdw+vnc32EP6nK0swh81hJLycpjT+2DCKBnfWXaSptEYvBb77xn5Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VM4V/szzW8CCFyAtGRTrIjiCbyFTB4ZV/Ct97PiiDvI=;
 b=H0dE/1HY9m7Y4fYviG4/NPvMLlWdQEZeVMubIwjk1cYnSQdlrnr7hKerZnmhFYtUcvjMvLllQkDk9LLeAQ8d5U5oqqlwjR9XWQzkg1/UxOq4bvEQuEX5pw7shGZohMTjdlqoPTb5TnDg/rtrovo6AjQnuLuurZCxdEZfwfqOz+dDH+ueipmPz6P4MoNCD3ldOVfdBm8Y2nKB0DGdIK7vH+Jz4X8CVT/ijSlMMchrCbgZFKlcgdbQ1fFDiMyxq+TUCRWFauJgVBlCu1EoX5FxU/VHubRGqY5vgYYPQwt8QDhyEtaJiFsux3Cq+8DqAsC8edG3KloR+DCYV/70OuHhPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VM4V/szzW8CCFyAtGRTrIjiCbyFTB4ZV/Ct97PiiDvI=;
 b=ep9axi0e2+ePle7rtfAZKrEK7kMylIjaYYHD6vqz5IP1wVs8HK9JiohEXRl+aFg5bo8Cu4ZZ/v+ePleXJQNH52gyoDFY0NXCRO1JfROr4e4rjWk16NSB0qvT9Deai5UkJk2k94ZP9zobNr0t9P0QNsNNgi2qdrnzVez79iKgUuY=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5854.eurprd05.prod.outlook.com (20.178.125.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Mon, 15 Jul 2019 14:15:43 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2073.012; Mon, 15 Jul 2019
 14:15:43 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Yuval Shaia <yuval.shaia@oracle.com>
CC:     Yishai Hadas <yishaih@mellanox.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "mark.haywood@oracle.com" <mark.haywood@oracle.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v8] verbs: Introduce a new reg_mr API for virtual address
 space
Thread-Topic: [PATCH v8] verbs: Introduce a new reg_mr API for virtual address
 space
Thread-Index: AQHVOxeFpOSMFAeAn0SylCM6S7x2q6bLuV4A
Date:   Mon, 15 Jul 2019 14:15:42 +0000
Message-ID: <20190715141538.GC15202@mellanox.com>
References: <20190715141328.15872-1-yuval.shaia@oracle.com>
In-Reply-To: <20190715141328.15872-1-yuval.shaia@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR02CA0011.namprd02.prod.outlook.com
 (2603:10b6:208:fc::24) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1eb73497-0767-4fbd-8121-08d7092eebe6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5854;
x-ms-traffictypediagnostic: VI1PR05MB5854:
x-microsoft-antispam-prvs: <VI1PR05MB5854EFA3F254DD8780A30ADECFCF0@VI1PR05MB5854.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 00997889E7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(189003)(199004)(316002)(33656002)(4326008)(54906003)(68736007)(229853002)(6486002)(86362001)(6116002)(81156014)(7736002)(305945005)(81166006)(25786009)(8936002)(8676002)(2906002)(76176011)(256004)(102836004)(386003)(6506007)(66066001)(64756008)(99286004)(14444005)(476003)(486006)(14454004)(446003)(478600001)(6916009)(66556008)(6436002)(66946007)(66476007)(66446008)(52116002)(6246003)(36756003)(1076003)(71200400001)(71190400001)(6512007)(5660300002)(53936002)(2616005)(11346002)(26005)(3846002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5854;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: R/wVwk1oX/AuCGWRn6ZAfdLjn8jTKjNnokcAAmRD5nfAeanAKFoebhjCv9dVofH449zsts8qi40R5Dv7NJO0q+i+cawCfQSCcs/Zc8L54gNF/0yoMx6LkdCWUCTsai4WS+dTm86svuQZINx5C/1Tgx/vVADDN2l+n4tBuzdq7rcXDu+/ch7A5///xF6pn7N8pjneko66EN9eXjopJywlD3i0r4HZwStTwtRgn209bcyI5WP3lkqAQ0lFqg5hctu91y1BJvXmqA8FHcD3iIUio1vNm4yFgoJM2z/seMfvCY64cTBYUvoKR8tT3MTY1Zll+nM6wwn0QOhUQBQ7PrIEh4e2zLjZ2VoNGc7v9yyhnLF2BvRn+3iDZ4VHoOThZVc2jdLzEqvDZMB5uDHAyu9xMu27xELZ6XOHH5LllO4CGYU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F28AB14755C12647B56F5DD5ADD3986A@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eb73497-0767-4fbd-8121-08d7092eebe6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2019 14:15:42.9930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5854
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 15, 2019 at 05:13:28PM +0300, Yuval Shaia wrote:
> The virtual address that is registered is used as a base for any address
> passed later in post_recv and post_send operations.
>=20
> On some virtualized environment this is not correct.
>=20
> A guest cannot register its memory so hypervisor maps the guest physical
> address to a host virtual address and register it with the HW. Later on,
> at datapath phase, the guest fills the SGEs with addresses from its
> address space.
> Since HW cannot access guest virtual address space an extra translation
> is needed to map those addresses to be based on the host virtual address
> that was registered with the HW.
> This datapath interference affects performances.
>=20
> To avoid this, a logical separation between the address that is
> registered and the address that is used as a offset at datapath phase is
> needed.
> This separation is already implemented in the lower layer part
> (ibv_cmd_reg_mr) but blocked at the API level.
>=20
> Fix it by introducing a new API function which accepts an address from
> guest virtual address space as well, to be used as offset for later
> datapath operations.
>=20
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
> v0 -> v1:
> 	* Change reg_mr callback signature instead of adding new callback
> 	* Add the new API to libibverbs/libibverbs.map.in
> v1 -> v2:
> 	* Do not modify reg_mr signature for version 1.0
> 	* Add note to man page
> v2 -> v3:
> 	* Rename function to reg_mr_iova (and arg-name to iova)
> 	* Some checkpatch issues not related to this fix but detected now
> 		* s/__FUNCTION__/__func
> 		* WARNING: function definition argument 'void *' should
> 		  also have an identifier name
> v3 -> v4:
> 	* Fix commit message as suggested by Adit Ranadiv
> 	* Add support for efa
> v4 -> v5:
> 	* Update PABI
> 	* Update debian files
> v5 -> v6:
> 	* Move the new API to section in libibverbs/libibverbs.map.in
> 	  (IBVERBS_1.7) as pointed out by Mark Haywood
> v6 -> v7:
> 	*=20
> v7 -> v8:
> 	* Update also redhat and suse specfiles so now all CI checks in
> 	  github passed.
> 	* Leon, i have your r-b from v5, appriciate if you can take a look
> 	  again now, with all the latest changes
>  CMakeLists.txt                    |  4 ++--
>  buildlib/cbuild                   |  6 ++++++
>  debian/control                    |  2 +-
>  debian/libibverbs1.symbols        |  4 +++-
>  libibverbs/CMakeLists.txt         |  2 +-
>  libibverbs/driver.h               |  2 +-
>  libibverbs/dummy_ops.c            |  2 +-
>  libibverbs/libibverbs.map.in      |  5 +++++
>  libibverbs/man/ibv_reg_mr.3       | 15 +++++++++++++--
>  libibverbs/verbs.c                | 23 ++++++++++++++++++++++-
>  libibverbs/verbs.h                |  7 +++++++
>  providers/bnxt_re/verbs.c         |  6 +++---
>  providers/bnxt_re/verbs.h         |  2 +-
>  providers/cxgb3/iwch.h            |  4 ++--
>  providers/cxgb3/verbs.c           | 15 +++++----------
>  providers/cxgb4/libcxgb4.h        |  4 ++--
>  providers/cxgb4/verbs.c           | 15 +++++----------
>  providers/efa/verbs.c             |  4 ++--
>  providers/efa/verbs.h             |  2 +-
>  providers/hfi1verbs/hfiverbs.h    |  4 ++--
>  providers/hfi1verbs/verbs.c       |  8 ++++----
>  providers/hns/hns_roce_u.h        |  2 +-
>  providers/hns/hns_roce_u_verbs.c  |  6 +++---
>  providers/i40iw/i40iw_umain.h     |  3 ++-
>  providers/i40iw/i40iw_uverbs.c    |  8 ++++----
>  providers/ipathverbs/ipathverbs.h |  4 ++--
>  providers/ipathverbs/verbs.c      |  8 ++++----
>  providers/mlx4/mlx4.h             |  4 ++--
>  providers/mlx4/verbs.c            |  7 +++----
>  providers/mlx5/mlx5.h             |  4 ++--
>  providers/mlx5/verbs.c            |  7 +++----
>  providers/mthca/ah.c              |  3 ++-
>  providers/mthca/mthca.h           |  4 ++--
>  providers/mthca/verbs.c           |  6 +++---
>  providers/nes/nes_umain.h         |  3 ++-
>  providers/nes/nes_uverbs.c        |  9 ++++-----
>  providers/ocrdma/ocrdma_main.h    |  4 ++--
>  providers/ocrdma/ocrdma_verbs.c   | 10 ++++------
>  providers/qedr/qelr_main.h        |  4 ++--
>  providers/qedr/qelr_verbs.c       | 11 ++++-------
>  providers/qedr/qelr_verbs.h       |  4 ++--
>  providers/rxe/rxe.c               |  6 +++---
>  providers/siw/siw.c               |  4 ++--
>  providers/vmw_pvrdma/pvrdma.h     |  4 ++--
>  providers/vmw_pvrdma/verbs.c      |  7 +++----
>  redhat/rdma-core.spec             |  2 +-
>  suse/rdma-core.spec               |  2 +-
>  47 files changed, 154 insertions(+), 118 deletions(-)
>=20
> diff --git a/CMakeLists.txt b/CMakeLists.txt
> index b2613284..67112ae3 100644
> +++ b/CMakeLists.txt
> @@ -68,11 +68,11 @@ endif()
>  set(PACKAGE_NAME "RDMA")
> =20
>  # See Documentation/versioning.md
> -set(PACKAGE_VERSION "25.0")
> +set(PACKAGE_VERSION "26.0")
>  # When this is changed the values in these files need changing too:
>  #   debian/control
>  #   debian/libibverbs1.symbols
> -set(IBVERBS_PABI_VERSION "25")
> +set(IBVERBS_PABI_VERSION "26")
>  set(IBVERBS_PROVIDER_SUFFIX "-rdmav${IBVERBS_PABI_VERSION}.so")

'25' is still the current release-in progress.

Jason
