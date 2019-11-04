Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1543EE9F2
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Nov 2019 21:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfKDUko (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Nov 2019 15:40:44 -0500
Received: from mail-eopbgr50068.outbound.protection.outlook.com ([40.107.5.68]:28644
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728519AbfKDUko (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 4 Nov 2019 15:40:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrFmKXvEvOAGQApIKCtvQWkgR8Bp1tbndl2ro1VQ0W8tCPR6RhUTPSSvMvzwKMQDyk4MuAHy6GbfsjAv72Nm8rRyoSMT/bthr7W/dCdM3BShBcLVyjWR5rNsY95UzixtYWWD1ewuv2SzqKTzA+kt+ppy1ZKBH/VG0sGAT5lBTI6S6o0TG8RF2aBuu1mjLopHHjzW1sjD1k4FZKwxcm/3xvN7CmEumVIQMj3xMQcj9hLrtdIlLIHdJClAySFR6J8uI6YJMwkqb0tjyyYBOE8N2I3e453CtfZ1BzSCHCdv90VwrhqvIo9TPplG730ZY6cv85i5sTZvv7uOXsr87cBzeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yjOZ2muVLhUKzy/pkv6eId+JQmPd5ao6ccDg2ky/x8=;
 b=SZDB3GspfiTiLn6lWi2NQUolOKgEkcvmRA5RqAzQeq3v4d+nglK1dLv7t+IlFXbN/8VlFvugpcg9KHyxkOWED56NTR7hqZSSijDfrTpi6ThXloBA7PEg3bTlIxO6Dg/OfJMAmyFa+PtupQEl06pelUtECTZ1YZTVog2o1kj0hIgckwvg+W1JH9DtLRn7Sb3JvCm+CWxzlwpdZXbT8MN42gACVyujRHNisn7ftyjKu/tVDb/mxMvQ6RWKSCgXvBfwpC7h/1H93rz0AOkZsJ+M13dMXLfymx2ko+JOF2ODefH1TcMoHPucDKxnEVeRbKiDYwBPATH0lrMS5tQplkzCpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yjOZ2muVLhUKzy/pkv6eId+JQmPd5ao6ccDg2ky/x8=;
 b=c0q8QH4DQV5HmZlhbZCM9jUi1EcF+dpzpFkMKgf70YWNvPy9t/9A/OOYu05midQOmQPXAnY/OxOWhSsN4FtYedOJLoVad6S4Zb1Sj/TW5mUduDbC9XkwD5P3Uy8x0A+cm2UgW7iVn6at9MS2WBcru3h2SBw2SB8EyHAnwvNfDIs=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB4558.eurprd05.prod.outlook.com (20.176.3.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 20:40:40 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d%5]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 20:40:40 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        =?iso-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Petr Cvek <petrcvekcz@gmail.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 00/15] Consolidate the mmu notifier interval_tree and
 locking
Thread-Topic: [PATCH v2 00/15] Consolidate the mmu notifier interval_tree and
 locking
Thread-Index: AQHVjcvLcMrGmvTkCUuCiBG3ZcB8kKd20ZaAgASzCwA=
Date:   Mon, 4 Nov 2019 20:40:40 +0000
Message-ID: <20191104204036.GJ22766@mellanox.com>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <c2b67afe-cb32-14c9-6513-6cda6cd891d2@nvidia.com>
In-Reply-To: <c2b67afe-cb32-14c9-6513-6cda6cd891d2@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR01CA0017.prod.exchangelabs.com (2603:10b6:208:71::30)
 To VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2dbcd9f4-a65d-4d3f-a953-08d761674145
x-ms-traffictypediagnostic: VI1PR05MB4558:
x-microsoft-antispam-prvs: <VI1PR05MB45588E89980D7E011A5A0E89CF7F0@VI1PR05MB4558.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(189003)(199004)(229853002)(8936002)(81156014)(81166006)(99286004)(256004)(8676002)(6486002)(6246003)(33656002)(2906002)(6116002)(3846002)(71200400001)(71190400001)(25786009)(7416002)(4326008)(7736002)(305945005)(6436002)(6512007)(66556008)(66066001)(6916009)(86362001)(558084003)(102836004)(478600001)(26005)(316002)(76176011)(52116002)(6506007)(386003)(476003)(36756003)(14454004)(11346002)(486006)(2616005)(446003)(54906003)(1076003)(186003)(66446008)(5660300002)(66476007)(66946007)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4558;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uhAOSQq4UPPixbonKN57rpa085/AjAKzpIvyIsrk90mxd4hE/T9ugFN7TN8FWHpHFyYwVQcoPqOF90t0d5honRx2huhU/X6EDEsGPgDhi2f34i9nrmo+C8tfEX56bZ0j+SP8d6SeI5rvZVLluqqLGV8D7jx6B1I3rbKHoNFzas0lcjbToZpFy5W+6qQ5X45yD/D6cLZ0pxz/KhgfK0jCEExytwfFVSRdTGp1JjPKnJ8zKtcI9XNhSa9vCjdySfuw0CczQJvTsncTEyX0MfYSZLm1FSy1rrXZBRDP0J7eB1qa7Nz5ySJ5BV2XfSfaajoEBuN1ofysq9Nn+bcOOZi2JPSjsLrJVY1KAgXwd/LeDKr1Qyzh+NClraK5FMT+WZk8LWGw61AIRhwK8HHLBceUm6CpRBXTjo0bVGusBR8UHQ91y3dv+JnP86I6sP9M0NTM
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <20E8275A38048B43835498D8056B902F@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dbcd9f4-a65d-4d3f-a953-08d761674145
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 20:40:40.4182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: huZeQIXViZp4S02Wf5rDY5D7M+g+n+iTWOqeotChIUytr/K4gNDlnU6un0+gcw9hWnOpDSCp1sZC6zU0a1gctg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4558
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 01, 2019 at 01:54:45PM -0700, Ralph Campbell wrote:
> You can add my Tested-by for the mm and nouveau changes.
> IOW, patches 1-4, 10-11, and 15.
>=20
> Tested-by: Ralph Campbell <rcampbell@nvidia.com>

Got it, thanks

Jason
