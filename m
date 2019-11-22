Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9891075FF
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2019 17:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfKVQwN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Nov 2019 11:52:13 -0500
Received: from mail-eopbgr60049.outbound.protection.outlook.com ([40.107.6.49]:8141
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726620AbfKVQwN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 22 Nov 2019 11:52:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7VVXCIKIACVUdzZ6ueRI4caeQRjFRpfPg+Lj6imxPW9xWEmS4ktl+/h3n0FsUE+lCrhTiCa4ADVPDOZXmqyM/rSetaUZPlp3B/buv2izGcNi1+h3OsY1gRk1CW/gCzHT0qDp89tsDBA0E3aV3YzrJCtHCRkm6cVo7nL34L5uCgHnd0Ji5emwSvAjuy5l2GVXVGlhYV9CdqG/lwquxjvUbnz+QKY7wByKBe8kL/VtapbJTEo9+KKHnQjBEWtxwBn/rHxq3FIKNMFNEPviOO/CJ2MIOHnRSouIimxj5jh+QZ3GzALNnXJ8Fs5q3QMEbIcxgiMYW5AFSaU9fWze7xZcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsaqontZZwl7LT3cW7xYKhwquhkc3tt+yKiryVzb+/4=;
 b=QO/IxsZAsLfWhvpxtgqOg1CFl+Lv6GcyNlpbSZ08UnjR/Y3J+nxa1U/LkbKcwXV0CrI2/z7ulUsCB98381VrXkxG1WtOyFlDgfmPZZ7Qy+WmRul91eXqhU1tu8v+CjyNtON7hwBNlI6jX3BlnXuObgbEtMg9JYbnMKsPmw0qZ9JsQm1FEcTtr2z1w1s7y+09F3PyEmBJxtT6mlMB4O5/aUaT5aqloErw+3JBBgocJDN/w33HsEt8GIQbhNUvo/Nut99XwdjfETGUKAARD20Ppnx30CMn7aFgpWy4qaC5icMTb2vunGKXebDOZCGY4fxXpuCU7NA9QeTNuxufdJ25Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsaqontZZwl7LT3cW7xYKhwquhkc3tt+yKiryVzb+/4=;
 b=WINC55pe5U3482Myxxalo7AwCXN75WHlBwO6aJErxDSsydrXUeM0MZ+w9YNTOLn4wd6t79Rw8XSaCC8s2pyBzrDqy1aumQUTs5Yw9E86We8us1abWbqOL/gfisaoeKniDtMP3/4jc0jYeRfW/yKMc/sp7Tjmrbm2Ot75U8wLY8E=
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com (10.171.188.155) by
 AM4PR05MB3362.eurprd05.prod.outlook.com (10.171.187.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Fri, 22 Nov 2019 16:52:08 +0000
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::70c3:1586:88a:1493]) by AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::70c3:1586:88a:1493%7]) with mapi id 15.20.2474.021; Fri, 22 Nov 2019
 16:52:08 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
CC:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: Re: [PATCH rdma-next v1 04/48] RDMA/cm: Add SET/GET implementations
 to hide IBA wire format
Thread-Topic: [PATCH rdma-next v1 04/48] RDMA/cm: Add SET/GET implementations
 to hide IBA wire format
Thread-Index: AQHVoVUo/kr9vbiVpUaAUvWhClYcFg==
Date:   Fri, 22 Nov 2019 16:52:08 +0000
Message-ID: <20191122165200.GG136476@unreal>
References: <20191121181313.129430-1-leon@kernel.org>
 <20191121181313.129430-5-leon@kernel.org>
In-Reply-To: <20191121181313.129430-5-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR06CA0088.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::29) To AM4PR05MB3137.eurprd05.prod.outlook.com
 (2603:10a6:205:8::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [5.29.147.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c63ee284-9f96-485e-647d-08d76f6c4f8d
x-ms-traffictypediagnostic: AM4PR05MB3362:|AM4PR05MB3362:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM4PR05MB3362788C34FECD9604DA2424B0490@AM4PR05MB3362.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 02296943FF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(39860400002)(136003)(346002)(376002)(366004)(396003)(199004)(189003)(6636002)(305945005)(256004)(6436002)(6486002)(8936002)(102836004)(86362001)(186003)(7736002)(81156014)(446003)(11346002)(76176011)(5660300002)(14454004)(81166006)(52116002)(9686003)(26005)(3846002)(33716001)(478600001)(71190400001)(229853002)(64756008)(2906002)(66476007)(6116002)(33656002)(6246003)(66556008)(316002)(6512007)(8676002)(1076003)(386003)(6506007)(54906003)(4326008)(14444005)(25786009)(110136005)(66066001)(99286004)(66946007)(66446008)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR05MB3362;H:AM4PR05MB3137.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nZEdfLzEADYBD6CEGrd9SvLvh5wFTrMXfQEFudjKrrDS2XajmP06jJo6EYZYOXexx06M77ywu/Nm+RJI7IZYdriuQnTY4Shqz1JW7FFU+GEe/i55DEd9VoiDzG6hfIJfs3333TWhZZ+yxY0rDM1QG+Y6DT/D8yHKkS+wKAFTAPJt6vdgEb386N3dl3hlY0y4/vpqWC2bJ6g79dQZzG3yy74JjfHXrefTdZS92o6hAt18x6vtcnESBcLWrLwGoOwZdRPl9AqAHAkPPyVNxgshkV8CVR8yK6TLSBZmMeRBqnGij1w4ukk88w6kFwrxXMiKSlIn6pE3d64XjpsVCZQvTPtB9YP/sdFaUJyOAblS6NrxphTsK+oN0oYtFwn82Aut6e5tia1+BKAMoM4L9k1caYu5LHFoOTHUTxCTZ8XHwKW895h5FMxBUPOht/kgLLGI
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2D97B5E78CCCBC4F99B7C3F21756F8E3@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c63ee284-9f96-485e-647d-08d76f6c4f8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2019 16:52:08.2739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qkpSgTgY3+e11DGsdaxQ03WOM4KwRpWXPaCH+LckvGVtFrGLZY5riP0/i0TlPdXn3+cVzvtU0pieF94+uGjt+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3362
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 21, 2019 at 08:12:29PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
>
> There is no separation between RDMA-CM wire format as it is declared in
> IBTA and kernel logic which implements needed support. Such situation
> causes to many mistakes in conversion between big-endian (wire format)
> and CPU format used by kernel. It also mixes RDMA core code with
> combination of uXX and beXX variables.
>
> The idea that all accesses to IBA definitions will go through special
> GET/SET macros to ensure that no conversion mistakes are done.
>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/cm_msgs.h |   6 +-
>  include/rdma/iba.h                | 137 ++++++++++++++++++++++++++++++
>  2 files changed, 138 insertions(+), 5 deletions(-)
>  create mode 100644 include/rdma/iba.h
>
> diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/=
cm_msgs.h
> index 92d7260ac913..9bc468833831 100644
> --- a/drivers/infiniband/core/cm_msgs.h
> +++ b/drivers/infiniband/core/cm_msgs.h
> @@ -8,14 +8,10 @@
>  #ifndef CM_MSGS_H
>  #define CM_MSGS_H
>
> +#include <rdma/iba.h>
>  #include <rdma/ib_mad.h>
>  #include <rdma/ib_cm.h>
>
> -/*
> - * Parameters to routines below should be in network-byte order, and val=
ues
> - * are returned in network-byte order.
> - */
> -
>  #define IB_CM_CLASS_VERSION	2 /* IB specification 1.2 */
>
>  struct cm_req_msg {
> diff --git a/include/rdma/iba.h b/include/rdma/iba.h
> new file mode 100644
> index 000000000000..454dbaa452a7
> --- /dev/null
> +++ b/include/rdma/iba.h
> @@ -0,0 +1,137 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
> +/*
> + * Copyright (c) 2019, Mellanox Technologies inc.  All rights reserved.
> + */
> +#ifndef _IBA_DEFS_H_
> +#define _IBA_DEFS_H_
> +
> +#include <linux/kernel.h>
> +#include <linux/bitfield.h>

Got report from LKP, there is a need to add "#include <asm/unaligned.h>"
for sparc build.

Thanks
