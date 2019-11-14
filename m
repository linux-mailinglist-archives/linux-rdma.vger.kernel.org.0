Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 404B5FCB3D
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2019 18:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfKNRAq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Nov 2019 12:00:46 -0500
Received: from mail-eopbgr130082.outbound.protection.outlook.com ([40.107.13.82]:41027
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726482AbfKNRAq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 14 Nov 2019 12:00:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDUwSt445QfEkRno9+7JNLKhlXsrkclembvq2cRG7K6c50zPBtcobXHVWJr8tKoO8Rtyv1+S8gIx+BODPvADlzu9E2qD83UyUq/WR6jY0nr38ZnswW/bs5TCD991JAZ6Q/HR8yQc1X54Fh48Eo1AkaGLQxUERZStszLSrTZeLgCYJvxHkgWF9oU/AkG7pCFhQ/EALb4Af4THPqhmF4bu5I782QZpbYjedPsQq87SFvvtSCIAZ7xbGclVrThYnsARVrFFr3lIQzucdyHxypyxUx0lNe/wZemjvkaAAl9Hhe2HLitogRgjMhCj+K1gIG8+MhnGvhWhOnQjB0SCKnx20w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vIgOJ9y1IaDErXUz5vy0ec8KV/QKyf7qyqO0a4J9Pg=;
 b=NYppn24W88EYsAaXIxla2QykWSCpLwva7Nk2v68ET2LyLcE19hjkuzYxPZRygL5AWgpb4ds/f7Dbu6hAY2rAhvfed5+GqTzO7dVXGAOOId6Gdi6UamHXjoKcs7KANQ1w564QJ3JYDvNWMwgaL63np66k5gPv2Y5iLuqgADb6wnBf4O6dG4mqGugS2xq7MiX8NQn68+1PsO1FW2Cy1d9t1S23Ebyt9Z/W6SvH8wMXXmjmnrlfDC59O9o2+SH9OeDPUo00YiwEFuMKC0R+j3R5QFqv7Q1QvREj2n8TDfDeKV7Cb7NDRHEUdG1E484pnbr0Qa4UHPRJwo+PZCPEerwQGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vIgOJ9y1IaDErXUz5vy0ec8KV/QKyf7qyqO0a4J9Pg=;
 b=DATutpGFAHJpNlYBPHvOPjaRRs16cEf6e7nkLoydgvWF8tOyjT0+s+pAUOkAv1Bp2TDZllbaRjDzbJjbVZvqqZ+nouskzvXPn1mbITjlSXr6ogRPzxwIgbSCAbRSszmYeTJY6PBl44Du9MIqEldfn45pke++XsOe/4MJKlH8NH0=
Received: from AM6PR05MB4152.eurprd05.prod.outlook.com (52.135.161.21) by
 AM6PR05MB6406.eurprd05.prod.outlook.com (20.179.6.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.27; Thu, 14 Nov 2019 17:00:00 +0000
Received: from AM6PR05MB4152.eurprd05.prod.outlook.com
 ([fe80::28c2:5ab:f383:fed]) by AM6PR05MB4152.eurprd05.prod.outlook.com
 ([fe80::28c2:5ab:f383:fed%3]) with mapi id 15.20.2451.024; Thu, 14 Nov 2019
 17:00:00 +0000
From:   Edward Srouji <edwards@mellanox.com>
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Noa Osherovich <noaos@mellanox.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Daria Velikovsky <daria@mellanox.com>
Subject: RE: [PATCH rdma-core 1/4] pyverbs: Add memory allocation class
Thread-Topic: [PATCH rdma-core 1/4] pyverbs: Add memory allocation class
Thread-Index: AQHVms8rzs2wkDxYSUeydp5vKVoinaeKqqeAgAA20EA=
Date:   Thu, 14 Nov 2019 17:00:00 +0000
Message-ID: <AM6PR05MB41529E366C190E52B0C58518D7710@AM6PR05MB4152.eurprd05.prod.outlook.com>
References: <20191114093732.12637-1-noaos@mellanox.com>
 <20191114093732.12637-2-noaos@mellanox.com>
 <20191114133345.GS21728@mellanox.com>
In-Reply-To: <20191114133345.GS21728@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=edwards@mellanox.com; 
x-originating-ip: [77.125.32.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6dba6bf0-dc84-48e7-7a18-08d769241609
x-ms-traffictypediagnostic: AM6PR05MB6406:|AM6PR05MB6406:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR05MB64065C4680BBCB1EC15D4D10D7710@AM6PR05MB6406.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(13464003)(199004)(189003)(14454004)(486006)(5660300002)(66066001)(7696005)(76176011)(52536014)(478600001)(26005)(107886003)(81156014)(6506007)(102836004)(81166006)(4326008)(8676002)(6246003)(55016002)(9686003)(186003)(25786009)(14444005)(256004)(76116006)(53546011)(6636002)(3846002)(6116002)(54906003)(33656002)(99286004)(71190400001)(86362001)(71200400001)(7736002)(74316002)(305945005)(110136005)(2906002)(229853002)(11346002)(8936002)(66946007)(66446008)(476003)(6436002)(64756008)(66556008)(66476007)(446003)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB6406;H:AM6PR05MB4152.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +8cZBdHYBlojfmb2M/da2iQQZWgBT5l/q/CttzZj0KAFhMcG1jk85VztTfskoqGOAtAipmM3Ts5GOPK6z5PgyDEAjIQ2fKPWlIVJN6MwWIxNDvhCbuEbXz9Arle9T+J0pzzxSSd8Vzpy/zcZRe0a7Fc1sHN4JsmO2GsgM7HdGDLPM2ZaV+Io/e+s7TbWUSDod6xO7PvpxFkuCjWuaP6WKtBxD/ZvLEQHKAyUK05flHY/s0I6xJPRr338gaYr9jt4j6PNREAEmxTaFxSSl93YVruwjjcUGN3lTDu6VkQPUq0N+PIzr6l0myp+8yW5PcYcKn0NBr09Hl90OUWtCY05r8YA0xotETXOCPJIdC/Ltaxb50ptxD6qXDO3yaL+DeuTVzfV66WQQciPWL/3Pg20XV8txjZ6ofmaW4Kg/UkGSI/NQGjO688w1a8KciLBIxon
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dba6bf0-dc84-48e7-7a18-08d769241609
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 17:00:00.2565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WVPdwXJbVBCf13m/knQSEIBQF2ozJVDtjfR/NjQ00yd23U8gsMRDAsXADboq+5t1IjP60s+pFSJ19BztCcDdOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6406
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I put the memory related functions under MemAlloc for multiple reasons:
- The methods won't be confused with the C functions
- The class is extensible with more memory related methods and functionalit=
y

I think the other option would be defining them in another, separate, modul=
e (outside "base" module - which I less preferred)

-----Original Message-----
From: Jason Gunthorpe <jgg@mellanox.com>=20
Sent: Thursday, November 14, 2019 3:34 PM
To: Noa Osherovich <noaos@mellanox.com>
Cc: dledford@redhat.com; Leon Romanovsky <leonro@mellanox.com>; linux-rdma@=
vger.kernel.org; Edward Srouji <edwards@mellanox.com>; Daria Velikovsky <da=
ria@mellanox.com>
Subject: Re: [PATCH rdma-core 1/4] pyverbs: Add memory allocation class

On Thu, Nov 14, 2019 at 09:37:45AM +0000, Noa Osherovich wrote:
> From: Edward Srouji <edwards@mellanox.com>
>=20
> Add new MemAlloc class which wraps some C memory allocation functions=20
> such as aligned_alloc, malloc and free.
> This allows Pyverbs' users to easily allocate and free memory in C=20
> style, i.e when the memory address must be passed to a driver API.
>=20
> Signed-off-by: Edward Srouji <edwards@mellanox.com>
> Reviewd-by: Daria Velikovsky <daria@mellanox.com>
> Reviewd-by: Noa Osherovich <noaos@mellanox.com>  pyverbs/base.pxd |  3=20
> +++  pyverbs/base.pyx | 26 ++++++++++++++++++++++++++
>  2 files changed, 29 insertions(+)
>=20
> diff --git a/pyverbs/base.pxd b/pyverbs/base.pxd index=20
> e85f7c020e1c..e956a79915ff 100644
> +++ b/pyverbs/base.pxd
> @@ -9,3 +9,6 @@ cdef class PyverbsObject(object):
> =20
>  cdef class PyverbsCM(PyverbsObject):
>      cpdef close(self)
> +
> +cdef class MemAlloc(object):
> +   pass
> diff --git a/pyverbs/base.pyx b/pyverbs/base.pyx index=20
> 8b3e6741ae19..a41cfc748ad0 100644
> +++ b/pyverbs/base.pyx
> @@ -3,8 +3,14 @@
> =20
>  import logging
>  from pyverbs.pyverbs_error import PyverbsRDMAError
> +from libc.stdlib cimport malloc, free from libc.stdint cimport=20
> +uintptr_t
>  from libc.errno cimport errno
> =20
> +cdef extern from 'stdlib.h':
> +    void *aligned_alloc(size_t alignment, size_t size)

posix_memalign() is the correct function to use, and a cdef for it is alrea=
dy in posix.stdlib

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
