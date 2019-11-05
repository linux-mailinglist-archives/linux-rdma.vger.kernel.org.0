Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 113B6F003C
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2019 15:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbfKEOqf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Nov 2019 09:46:35 -0500
Received: from mail-eopbgr50080.outbound.protection.outlook.com ([40.107.5.80]:16506
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725385AbfKEOqf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 5 Nov 2019 09:46:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMl/KXrw1rmK1eOzwItELg4vhY6J2aBB0U25tEo5da8Thj47S8CE7oRrcL4gdDFkzt+sciEVRsaebF57Jm2JPKRimK01xBax6S259GLMS4fZaci5BFPsPQ8/A+PKBmhLgYptdxvc8Uf1C+dKqyGvtbd70dDqIQ/9blyPihZUhoNjqJCVxCoUibwwr9e1zupwGikspq0PBBqH6za3sHr39ivJ58nYJCB0Qxf3ZfhdSIcAMtJ4Ior+o8Vy8z4H+vPldPm/rQl6sjNvYL4OqfCYISftSHk9osXPOEQCuovI+lNL+AverPZcbl/n3x8tGaFqErmhtMhMDFTnnqilc2hzbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZJSTJO+mvXogrOIcwD7Vhqqj891e2xO12MxWraPXfA=;
 b=DTE08v7DbiGIxw8FNxI6UIs8ek8mw4h0XRDL9QnWFOb/iZsSLjFN7oBWuGGwMyKYVKulfPu5mMcYgLR/stxq2LG2LMULjcmD+rpL0e944bvjTsv7tkLsaU3dtC2LNF8CtYstL5RblpG+pFpjPJJ9vPwy5zGzrbDvLb8jcirkQEsrjua/P8un2y6lepHhJpWrFC/eJuqj0SOnaa4DMdic9NLUYcZL1NQT1jsawopUE3uTR60PzbhUaQcYGykuHei36TtvqOeodBUA5+fsZaqSpkTcN4bfN2JjwYhbzRUTCjc2SoIKe0P+n9AezhLAwdTqNn1lw3vtsnYzcqUqi4g7Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZJSTJO+mvXogrOIcwD7Vhqqj891e2xO12MxWraPXfA=;
 b=NobdJUVspqnlCMau3DXoJcuBhtkSVhx+Mr6LuWeK+x7yRnHXusUv+5cfmlm3Xv4CPpBAWOgj+Pqck4XQepF4TEEWssJGrHfChkItBAWFtgeXidmbSYZyKrdBZeA1cuBaTJG2Wi4fUkr7N5/4rQbDLfViLiuO4Khxiy431pzBP3s=
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com (10.171.188.155) by
 AM4PR05MB3457.eurprd05.prod.outlook.com (10.170.126.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 14:46:30 +0000
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::70c3:1586:88a:1493]) by AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::70c3:1586:88a:1493%7]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 14:46:30 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Benjamin Drung <benjamin.drung@cloud.ionos.com>
CC:     Noa Osherovich <noaos@mellanox.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Maxim Chicherin <maximc@mellanox.com>
Subject: Re: [PATCH rdma-core 1/5] pyverbs: New CMID class
Thread-Topic: [PATCH rdma-core 1/5] pyverbs: New CMID class
Thread-Index: AQHVkvvZnR+ij132JECSzDYENlw156d62tOAgAHO0IA=
Date:   Tue, 5 Nov 2019 14:46:29 +0000
Message-ID: <20191105144627.GI6763@unreal>
References: <20191104103710.11196-1-noaos@mellanox.com>
 <20191104103710.11196-2-noaos@mellanox.com>
 <148a5e07db186eb91d5a19bbd7a34bb8df193afd.camel@cloud.ionos.com>
In-Reply-To: <148a5e07db186eb91d5a19bbd7a34bb8df193afd.camel@cloud.ionos.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4P190CA0004.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::14) To AM4PR05MB3137.eurprd05.prod.outlook.com
 (2603:10a6:205:8::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8d1558ce-8377-497e-c3ee-08d761fef152
x-ms-traffictypediagnostic: AM4PR05MB3457:|AM4PR05MB3457:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM4PR05MB34572266074B86789AFEE61DB07E0@AM4PR05MB3457.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(376002)(136003)(396003)(366004)(39860400002)(346002)(189003)(199004)(66066001)(86362001)(4326008)(6246003)(9686003)(6512007)(81166006)(8936002)(81156014)(66946007)(14454004)(2906002)(14444005)(3846002)(6116002)(33716001)(33656002)(71200400001)(25786009)(71190400001)(6486002)(11346002)(478600001)(99286004)(54906003)(107886003)(256004)(229853002)(8676002)(5660300002)(64756008)(66446008)(386003)(6506007)(26005)(66476007)(66556008)(6916009)(102836004)(186003)(76176011)(52116002)(15974865002)(66574012)(476003)(1076003)(316002)(486006)(6436002)(305945005)(446003)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR05MB3457;H:AM4PR05MB3137.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LKE0YauH6WWhXXejsQV+VLEa/LZp6FMsEX8dPbPJNFnX+MjkQBWiSkee+/qA1l6EXFYxJXy6v4DWsbkvj5ls2hbNJR+sN2YhL46GO3MtK55F88wB8O12+IBP7k6HzcXJ/t9YjEK+DQLmyQJYDfFX65M9e2RzBGiqj9qW+uySEuTIHf1qZ5ebKMXzxMosX/YGLHuZCVay1n22KBfxjNs8qVXEQBjYNjwGVKoTCuNJWvXbcaRBt+b90Fo4RFMxJiEpCsaTuNmJGfLXLVEuHzomsKIgZFpXHcCllWSSJB8TwczmVMhx1AZBDPpaSnOSiMSdR8yDo0BmpvlTk7XCWq9Q/52vfs46fI5BZLN1Cba3ZBwxOEUIBOZ9u0MS+ahLvD1E+S8/zEqPc0IRYDYPidDeMFvfW8fpXYlLmby6TuwsAJuCMJVmd/f/RZrFNksNsIEfkHIwtJJ+miuWSe1agamKXYwrstp7w6ebQYVH40oVQ6w=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <4BD068EB54E38B438B22540C73FB5337@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1558ce-8377-497e-c3ee-08d761fef152
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 14:46:29.8862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XilTGGhe/yPGbrVyrQm2/pZYRD+PfEDbtvbqj9i1Aj1zuvOklwTkk0MH8+a+O6GbrFH/QDJ0dTAfX0oKFez7RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3457
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 04, 2019 at 12:09:59PM +0100, Benjamin Drung wrote:
> Am Montag, den 04.11.2019, 10:37 +0000 schrieb Noa Osherovich:
> > diff --git a/pyverbs/cm_enums.pyx b/pyverbs/cm_enums.pyx
> > new file mode 120000
> > index 000000000000..bdab2b585a1d
> > --- /dev/null
> > +++ b/pyverbs/cm_enums.pyx
> > @@ -0,0 +1 @@
> > +librdmacm_enums.pxd
> > \ No newline at end of file
> > diff --git a/pyverbs/cmid.pxd b/pyverbs/cmid.pxd
> > new file mode 100755
> > index 000000000000..56bc755daf42
> > --- /dev/null
> > +++ b/pyverbs/cmid.pxd
> > @@ -0,0 +1,25 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
> > +# Copyright (c) 2018, Mellanox Technologies. All rights reserved.
> > See COPYING file
> > +
> > +#cython: language_level=3D3
> > +
> > +from pyverbs.base cimport PyverbsObject, PyverbsCM
> > +from libc.string cimport memcpy, memset
> > +from libc.stdlib cimport free, malloc
> > +cimport pyverbs.librdmacm as cm
> > +
> > +
> > +cdef class CMID(PyverbsCM):
> > +    cdef cm.rdma_cm_id *id
> > +    cdef object ctx
> > +    cdef object pd
> > +    cpdef close(self)
> > +
> > +
> > +cdef class AddrInfo(PyverbsObject):
> > +    cdef cm.rdma_addrinfo *addr_info
> > +    cpdef close(self)
> > +
> > +
> > +cdef class ConnParam(PyverbsObject):
> > +    cdef cm.rdma_conn_param conn_param
> > \ No newline at end of file
>
> Please add newlines to the end of these files.

PR was updated.

Thanks

>
> --
> Benjamin Drung
>
> Debian & Ubuntu Developer
> Platform Engineering Compute (Enterprise Cloud)
>
> 1&1 IONOS SE | Greifswalder Str. 207 | 10405 Berlin | Germany
> E-mail: benjamin.drung@cloud.ionos.com | Web: www.ionos.de
>
> Hauptsitz Montabaur, Amtsgericht Montabaur, HRB 24498
> Vorstand: Dr. Christian B=F6ing, H=FCseyin Dogan, Hans-Henning Kettler,
> Matthias Steinberg, Achim Wei=DF
> Aufsichtsratsvorsitzender: Markus Kadelke
> Member of United Internet
>
