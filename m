Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB7D9B0F97
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Sep 2019 15:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731283AbfILNJo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Sep 2019 09:09:44 -0400
Received: from mail-eopbgr140075.outbound.protection.outlook.com ([40.107.14.75]:13633
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731786AbfILNJo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Sep 2019 09:09:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcgVBbaFfvbOCGo7tbC1n9hlgCJNmfLxAy775NnSBcper82B9YKyVt6aiHz21m/Eo8sul2S4TjflX/fP9HMH1UArCQISM43TjtSCynkOvoF77YUrpjTCRh14Xs3NWmChIbEV0sChh8UQCWxMgDbCsNMqyFe86hXDIxI1pnWXzW41ZyXrRuCtIVqttZhaYMcb4E+ztUXn74hcWefuph3UX7KqNgnsjUINv84ktVCEeQiC4Cy7zEazlltH3DB3e+Rwz+g/2xI8BklQMddhGuhb1yonjIWF3JP3sqhwllubM4r0vSIT6yYDC5i7jw0KiD4jour3KHtWSsFS7MtwHPzoPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uRjSHUqQhc/pPRpHQj/pgLndthsy06i1DR9UAeH/bw=;
 b=Hebng0ACZ8EOmKspY5AF3Y/MVv2dolZRMDYQN+pIeIqD1/k4OWLpqJG0dAremBndD83bd2jU4sfTM3fs3q2CVQ8xov+mTJGIf3sD0d97qp4EAY1LDId9vxMoOFu0w1skD3zJFGzzhyXnkFW372v7ZkjRldfEt7SqSJP8CEnxppv6Dx2YEnYIqPq0E5+XC62GVDb/NRtlHqpMTVOMeA5QD077czu38wUeRWVNGpYhDkL47lUs9EYThKfqn+1Y3+Kv9q1Ez4qbrAkVTWPpJlmiItbHCcdcFcKVU+V1JRbK+7gEW045kuhj7RA/2d+OAD3cZ3ARCCzofkgPpC7+eooA2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uRjSHUqQhc/pPRpHQj/pgLndthsy06i1DR9UAeH/bw=;
 b=WbRYKdOT2tYhHiWUDc1PUbspCgjX6rzJzY4n2pBUD1gtKe5mGbqa4paGSiZp7o5NTTsxN6535VTLCCRGLDYhMyhycQkLF1d9ieTtnWx3zvmuQ/cvXhD1L7AF1FvwFDvx5YJOm1JdqvkTngn3Z7ofhDvLCiIV8U2xmNqAAD+iR4I=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4655.eurprd05.prod.outlook.com (20.176.3.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.18; Thu, 12 Sep 2019 13:09:40 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f%7]) with mapi id 15.20.2241.022; Thu, 12 Sep 2019
 13:09:40 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Yuval Shaia <yuval.shaia@oracle.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "oulijun@huawei.com" <oulijun@huawei.com>,
        "xavier.huwei@huawei.com" <xavier.huwei@huawei.com>,
        "leon@kernel.org" <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Mark Zhang <markz@mellanox.com>,
        "swise@opengridcomputing.com" <swise@opengridcomputing.com>,
        "galpress@amazon.com" <galpress@amazon.com>,
        Israel Rukshin <israelr@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        "kamalheib1@gmail.com" <kamalheib1@gmail.com>,
        Denis Drozdov <denisd@mellanox.com>,
        Yuval Avnery <yuvalav@mellanox.com>,
        "dennis.dalessandro@intel.com" <dennis.dalessandro@intel.com>,
        Erez Alfasi <ereza@mellanox.com>,
        "will@kernel.org" <will@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "srabinov7@gmail.com" <srabinov7@gmail.com>,
        "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>,
        Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Subject: Re: [PATCH v3 1/5] RDMA/uverbs: uobj_get_obj_read should return the
 ib_uobject
Thread-Topic: [PATCH v3 1/5] RDMA/uverbs: uobj_get_obj_read should return the
 ib_uobject
Thread-Index: AQHVYOWQQm3wo9ztwUuHNYxa4mYmcKcoFMsA
Date:   Thu, 12 Sep 2019 13:09:40 +0000
Message-ID: <20190912130922.GA6674@mellanox.com>
References: <20190901165108.11518-1-yuval.shaia@oracle.com>
 <20190901165108.11518-2-yuval.shaia@oracle.com>
In-Reply-To: <20190901165108.11518-2-yuval.shaia@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM5PR1401CA0021.namprd14.prod.outlook.com
 (2603:10b6:4:4a::31) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.167.24.153]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a4ebc94-3012-48e2-5424-08d73782775e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4655;
x-ms-traffictypediagnostic: VI1PR05MB4655:|VI1PR05MB4655:
x-ld-processed: a652971c-7d2e-4d9b-a6a4-d149256f461b,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB465512ABC8A0BD546EB1D297CFB00@VI1PR05MB4655.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01583E185C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(199004)(189003)(51444003)(53936002)(71200400001)(71190400001)(76176011)(6506007)(52116002)(1076003)(386003)(26005)(5660300002)(3846002)(446003)(11346002)(6116002)(6512007)(7416002)(33656002)(102836004)(86362001)(8936002)(8676002)(2906002)(66066001)(305945005)(2616005)(7736002)(81156014)(81166006)(478600001)(229853002)(54906003)(4326008)(66446008)(66556008)(66946007)(25786009)(66476007)(64756008)(99286004)(36756003)(476003)(486006)(186003)(256004)(6246003)(6486002)(6436002)(316002)(14454004)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4655;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0jbi8jy5e7VN3Gt1iPfDAhW6uKp13s6wL2qOAxNjJkcDlcQx2Qc+Ko4pdgkPMARXQj2pVIWDqFmY32v3cXQvV5b3ZwqqSjgdZmjD4/SzyqvGuQbf9Exj1AvfEvVzj1lXO+T2oMQ6uLJdQROy24/krA2ZmIWrA+W1kVoJIEhIxbrW1KK5ARtZQMaSz8sxVo9nI9NlmEHjbQBdp7IK03joJI2xMu55zyOjaWsqS78ggGrL/Svf1uuKv3lDS7yUGe3pXScwL44lwmzn3XHf7zy2riPmbkHOryKg+10ld4GWcgqRIVeoZoF6AyZJ2JmpomDj79q4ur2KovQPoCVMM+HeEeDm2v1djvLsz1oSQW3ZjCMpYIwyl7aLi7JJ9S8uE7DZeP8fkoIos+ibbbM3JWaHwIZ6TG0BL/pv7DM9GbbOsbg=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D2697A446E62594D8046D128E1171645@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a4ebc94-3012-48e2-5424-08d73782775e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2019 13:09:40.0651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SOZZQ1sFUcx1Whqj3u4FqzekjBBLlNFhAdG+T5e3S6ef5OwAULXjTOabAD6ct7Mkm1LP/G1htiprJDtkW97LMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4655
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Sep 01, 2019 at 07:51:04PM +0300, Yuval Shaia wrote:
> From: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
>=20
> The uobject pointer will be removed from ib_x (ib_pd, ib_mr,...) objects.
> uobj_get_obj_read and uobj_put_obj_read macros were constructed with the
> assumption that ib_x can figure the uobject in mind.
>=20
> Fix this wrong assumption.
>=20
> Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
> Signed-off-by: Shamir Rabinovitch <srabinov7@gmail.com>
> ---
>  drivers/infiniband/core/uverbs_cmd.c | 125 ++++++++++++++++++++-------
>  include/rdma/uverbs_std_types.h      |   8 +-
>  2 files changed, 98 insertions(+), 35 deletions(-)

So, after the dicussion at LPC, I think this path might be a dead
end. Using refcounts makes it too easy to create situations where HW
objects cannot be destroyed and there seems no easy solution.

I suggest we instead use a parent/child scheme where there are no
refcounts. There is only one xarray owend by the parent FD.

The child FD holds a ref on the entire parent FD and maintains a list
of what objects are 'imported' and what objects are 'created', however
all objects always exist inside the parent xarray.

Upon child destruction the 'created' list is destroyed. If for some
reason those objects fail to destroy then they are sort of zombied
into the parent and will be cleaned when the parent is
destroyed. Applications should avoid creating conditoins where objects
can be zombied.

We need to modify the uobject create/destroy to know about
child&parent, but I think that should just be a bit more information
in the uverbs_attr_bundle

Make sense?

Jason
