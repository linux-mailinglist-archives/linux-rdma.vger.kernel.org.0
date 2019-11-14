Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB57FC7C1
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2019 14:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfKNNeB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Nov 2019 08:34:01 -0500
Received: from mail-eopbgr70088.outbound.protection.outlook.com ([40.107.7.88]:41349
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726374AbfKNNeB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 14 Nov 2019 08:34:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nfm4qZ0eclr45Rr6k0Xw36Sd5v8iz3wAH+nyR/5HjTW8AtvPY8wT6+GQpVeVNR9IsDJzz5PyXKUTT5trMEgEHABFf2PqHhFUIXoG4MBW2uJDUVGS/tDbgPE8nvivJOWY4/VrMFVJ4OBHypXheLou79/c3f9t+KUMacz5MHtqnTvvPvlDgvzC00IZgaUSSpVqLZn4NrnxiaqBO9HeajrolMYNTFNR7LF7pcCb/3aCNA7Ce78SL0HgJVBkpJZ88g3fzwQCAojyKY/t8eCKO4LimTjKBsV/3QWAniyCQnN0SavKuHpEG+IEiVetDe/BNDveUx3r/phxQQe3l/hxqJeCTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kfsUgDX2ANa4+h1VCSSvFO+28nSQNuCreayJu/tAks=;
 b=noW7sdL079FNREkYiT7188sS1JjyagfdiVS0nw5Ipkqbp+cTQOa6r/cFe3ptdspruZM3VCq4BqvXrc/7uELWa7uU8Sb/SDeeHSQ7dbfUfMH2O83M730bKJtddoci6IciFFYXFzoqSdZ/qyEGcgYjTS2hBR1dqYmEk8MBScc+J5BakseQ6FYvc79eVkj1TSnLvOQEOvbNB4/9qogztMVYO2bb0dcCNEKwF6+wxNec8DH+LxzlRMtWFzq3ZhoYdN1ORJGEKX/NQhel3zpoVH+R4V2PS0LSiXLKWNU7WxzfO3gtOaFRFrUduf3RUVhCcd+YpEoZQ6uacuFHBanuUgUC5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kfsUgDX2ANa4+h1VCSSvFO+28nSQNuCreayJu/tAks=;
 b=P52lXJZwLER+ykCYRi0T1dCKxPrpHdoQW18f08hvkKgI/TlhoToIm8MeeXGkS4+6TtKHRSU/iJzrCZ8P9tdp17A/+ciKWaFaTUyzBc6jcs8pPP3Coms5qVrC2KNRlJCUio8B7C/nmkmq87MQokQZmBzZmGzNzVbm70vg0GkA2Z0=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB3501.eurprd05.prod.outlook.com (10.170.239.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Thu, 14 Nov 2019 13:33:50 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d%5]) with mapi id 15.20.2430.028; Thu, 14 Nov 2019
 13:33:50 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Noa Osherovich <noaos@mellanox.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Edward Srouji <edwards@mellanox.com>,
        Daria Velikovsky <daria@mellanox.com>
Subject: Re: [PATCH rdma-core 1/4] pyverbs: Add memory allocation class
Thread-Topic: [PATCH rdma-core 1/4] pyverbs: Add memory allocation class
Thread-Index: AQHVms8rzs2wkDxYSUeydp5vKVoinaeKqqeA
Date:   Thu, 14 Nov 2019 13:33:50 +0000
Message-ID: <20191114133345.GS21728@mellanox.com>
References: <20191114093732.12637-1-noaos@mellanox.com>
 <20191114093732.12637-2-noaos@mellanox.com>
In-Reply-To: <20191114093732.12637-2-noaos@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN8PR12CA0010.namprd12.prod.outlook.com
 (2603:10b6:408:60::23) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5fa8479d-9034-4d86-f914-08d769074873
x-ms-traffictypediagnostic: VI1PR05MB3501:|VI1PR05MB3501:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB35011B00A96CC531AF9E52BDCF710@VI1PR05MB3501.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(189003)(199004)(37006003)(2906002)(14454004)(8936002)(229853002)(66066001)(107886003)(8676002)(81156014)(6862004)(81166006)(6246003)(6512007)(6116002)(6486002)(3846002)(4326008)(6436002)(36756003)(26005)(14444005)(186003)(256004)(102836004)(99286004)(6506007)(386003)(52116002)(305945005)(6636002)(33656002)(7736002)(476003)(2616005)(486006)(71200400001)(446003)(71190400001)(11346002)(5660300002)(64756008)(66556008)(66476007)(66446008)(478600001)(1076003)(25786009)(316002)(66946007)(86362001)(54906003)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3501;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N/ug4cB/09TIPQLa8ZISqE4BU098nwTdN8q6m7CbA+miYnt9OafJF9L455MzlAQNGPcWtdchaci2WOcymXr5pgpClntGtGbcl81Msd2pAL/MvtwcLaV9ia/ZZVA5VJbIcxV5CsMWqUVg/UyYDpZgBxJvRN1GwNgeNy4N6S8sxbr0/k4nArfy3J8L+k7MP/te+ve9nOUD/ULVsKTkjJTpWXwaj20KOBXoiV7oAytHgCwg951uaR8flpkAYF6yWtkkwI+sZDV8/N9BZRQt5IVJO/1iJWvAL2uGENjeUf1jnNlWdPbjjb3gZEDDRhpXlgzWGtAJhBjOshbEKT5vHaBADSHZ3mtLNcMCYD0xl6QL8pj4REXlO2aakdMP9O+YOZjJSz2f1iPC4zW42AhUubUzt1EdyHk9NhgZG34IQ7f2LJjAnWlvIX4tN21QiyCrLiro
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9148FD59D5FA664888328576256ACDDD@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa8479d-9034-4d86-f914-08d769074873
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 13:33:50.1809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qTZvyyNk5aEPZ4iJ/58IytMKFEnHbzeHBUnyVN/dWRnGRAsvCdXpOK94IC1w3uQJE9cwCf7VjYaGZXCSk4UvCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3501
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 14, 2019 at 09:37:45AM +0000, Noa Osherovich wrote:
> From: Edward Srouji <edwards@mellanox.com>
>=20
> Add new MemAlloc class which wraps some C memory allocation functions
> such as aligned_alloc, malloc and free.
> This allows Pyverbs' users to easily allocate and free memory in C
> style, i.e when the memory address must be passed to a driver API.
>=20
> Signed-off-by: Edward Srouji <edwards@mellanox.com>
> Reviewd-by: Daria Velikovsky <daria@mellanox.com>
> Reviewd-by: Noa Osherovich <noaos@mellanox.com>
>  pyverbs/base.pxd |  3 +++
>  pyverbs/base.pyx | 26 ++++++++++++++++++++++++++
>  2 files changed, 29 insertions(+)
>=20
> diff --git a/pyverbs/base.pxd b/pyverbs/base.pxd
> index e85f7c020e1c..e956a79915ff 100644
> +++ b/pyverbs/base.pxd
> @@ -9,3 +9,6 @@ cdef class PyverbsObject(object):
> =20
>  cdef class PyverbsCM(PyverbsObject):
>      cpdef close(self)
> +
> +cdef class MemAlloc(object):
> +   pass
> diff --git a/pyverbs/base.pyx b/pyverbs/base.pyx
> index 8b3e6741ae19..a41cfc748ad0 100644
> +++ b/pyverbs/base.pyx
> @@ -3,8 +3,14 @@
> =20
>  import logging
>  from pyverbs.pyverbs_error import PyverbsRDMAError
> +from libc.stdlib cimport malloc, free
> +from libc.stdint cimport uintptr_t
>  from libc.errno cimport errno
> =20
> +cdef extern from 'stdlib.h':
> +    void *aligned_alloc(size_t alignment, size_t size)

posix_memalign() is the correct function to use, and a cdef for it is
already in posix.stdlib

> +cdef class MemAlloc(object):
> +    @staticmethod
> +    def malloc(size):
> +        ptr =3D malloc(size)
> +        if not ptr:
> +            raise MemoryError('Failed to allocate memory')
> +        return <uintptr_t>ptr
> +
> +    @staticmethod
> +    def aligned_alloc(size, alignment=3D8):
> +        ptr =3D aligned_alloc(alignment, size)
> +        if not ptr:
> +            raise MemoryError('Failed to allocate memory')
> +        return <uintptr_t>ptr
> +
> +    @staticmethod
> +    def free(ptr):
> +        free(<void*><uintptr_t>ptr)

Why is this in a class?

Jason
