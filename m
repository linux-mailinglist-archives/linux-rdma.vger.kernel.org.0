Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12EC5E0AD2
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2019 19:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfJVRlQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Oct 2019 13:41:16 -0400
Received: from mail-eopbgr140044.outbound.protection.outlook.com ([40.107.14.44]:45121
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725837AbfJVRlP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Oct 2019 13:41:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0Rk1ri2xvKXsWMmbcy6dGDabJuKSJ6MEoQJec5B0FQy4zWPgqismZqy82s7KvV4YqdCpbvtVIBOR8CGkoNJqxaCAPaU1ER6jIEOJpTXTDthL2B5aR2lqX2Ozxew/UHKUTyBb3eHOIotvmH64vSg8iAY1TsB/2maEp6BKXAI/RIoeSYLQ9iGY2q7biEl0lmR6xctdxZMbEemCgQQAbMNTtMxCymz8lp7ct99pXwwBxeD6TM8wVLSlWxK2dd/xkKNC/r1mRd2pzGocm+Kn5Vyucw8OurbhLufoh1tHEt76zJkf8iRsNuHlAbsACpr4vu90dXvZkJT/VCmDlyjFee3uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qyc59d9dNteTRCWbCPQgLLylaaWucixJ8GZlas6nxF8=;
 b=evYvajqk3iIm+DDH8Y5XQyFblTSM4aLVM4/yuGvMXJ2N9QwS5ZL4F9NavO8wSsWONzDsO/68Np2vLmMDmJgHNkgJthzJvEepIKk2R09mFIh9mluY0UHsP/5xmivy0bdc6DFwRdVSUxBOjj9DUcsKSpqZnTCEQjo4z9h8G5rHftQGnv1iJv+FCJXgMEJDfD2MOLPK1WtAgB1sXbM05EbkwwXrZyFzxynEL7Zwo+aPVJmMeP4fEkn7WSxHT3Z5MZQ2cxNvZtJy4tT4G+B1K6eeYSXWwW6Vl3cQ1wLQUEFBhf1fZy60Ru1Q/rwnlBTnYe7+bkfTRi6fsL9qjZ1nDF1zRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qyc59d9dNteTRCWbCPQgLLylaaWucixJ8GZlas6nxF8=;
 b=GVMGMYAGeliThMvQc6eFihCPerIHQvK+9jf/F9Jx8r+BLgsNUTr25pbQNj36g+2QdVJrfVbdIxjjyGmmhOlT/2cKrEFseiFWsJMD4qseHbF4gWM/s5WrODFik4M73nyNpxSY/jUCzDhnpV1T0CYwWSn4KGoxjK4jE9OocTiCURY=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB6223.eurprd05.prod.outlook.com (20.178.124.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Tue, 22 Oct 2019 17:41:12 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::75ae:b00b:69d8:3db0]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::75ae:b00b:69d8:3db0%7]) with mapi id 15.20.2367.022; Tue, 22 Oct 2019
 17:41:11 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Jerome Glisse <jglisse@redhat.com>
CC:     Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v2 2/3] mm/hmm: allow snapshot of the special zero page
Thread-Topic: [PATCH v2 2/3] mm/hmm: allow snapshot of the special zero page
Thread-Index: AQHVg5noYFRN6Uol1kOCsSoXbSSn1KdleVOAgAAi3oCAAGI6gIAAzpcAgAAh44CAAADFAIAABeoAgAAC/IA=
Date:   Tue, 22 Oct 2019 17:41:11 +0000
Message-ID: <20191022174107.GM22766@mellanox.com>
References: <20191015204814.30099-1-rcampbell@nvidia.com>
 <20191015204814.30099-3-rcampbell@nvidia.com>
 <20191021184927.GG3177@redhat.com>
 <95fa45cf-a2ce-fab8-588d-8d806124aef3@nvidia.com>
 <20191022024549.GA4347@redhat.com> <20191022150514.GH22766@mellanox.com>
 <20191022170631.GA4805@redhat.com> <20191022170916.GL22766@mellanox.com>
 <20191022173026.GB5169@redhat.com>
In-Reply-To: <20191022173026.GB5169@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR1501CA0009.namprd15.prod.outlook.com
 (2603:10b6:207:17::22) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7dc745f0-4bb3-4783-0814-08d75717076d
x-ms-traffictypediagnostic: VI1PR05MB6223:
x-microsoft-antispam-prvs: <VI1PR05MB6223D9460A9DACF3AFB0B0D8CF680@VI1PR05MB6223.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(199004)(189003)(6916009)(6246003)(2616005)(6512007)(11346002)(76176011)(7736002)(5660300002)(26005)(54906003)(71200400001)(71190400001)(476003)(6436002)(186003)(6116002)(3846002)(478600001)(305945005)(52116002)(316002)(81156014)(81166006)(99286004)(1076003)(4326008)(33656002)(229853002)(36756003)(2906002)(14454004)(486006)(4744005)(8936002)(66066001)(64756008)(66556008)(6506007)(66476007)(66446008)(386003)(66946007)(256004)(14444005)(25786009)(8676002)(86362001)(102836004)(6486002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6223;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /O/CO1YR/uqGacxfPNB5PjqvcSipYG4RfKucbTSoqzBUEs2JZGwMoLL5H2ErOfaAWTECmTb16KUJcs110D2glxRsT4NgYAD8OXzE6VoDBLrh2FgHyZE/s2n09ecnSqaYU736gAjkdZ6lnw7dX318X3kdhzkEUhatzoNs6ASsjKL/Yp48h6S73ZgIYlfzyU5eEQBdLTuPTKRiPC6ZVevzUChbhs9X5NVuZqoVHZnmjjtEcAWUOOgoEHlEbMaQVAem3YAPncn3obHmtjA4A8krGnToMhol8G9UdYwdmX+KmhseMMUoD9QQnWhgVKcGjMojC1Uo7qDzXaGqoSo5DjgId9B6G9iAyG0Y1OnM2LwwRyVxZrfbb48qxfFxPAi5IvZ8goN48UMOSzBu+Q6bSu4fDOOf21XK0j9YzDXKrpi11LreMFSTuMoiuPgaUJ3mjN6L
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C30660878EB2704D8C267A7630B14E34@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc745f0-4bb3-4783-0814-08d75717076d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 17:41:11.8543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sCgnVa8WMZjJUTVgr/YYva50C6fnTVNzeNwLhcWv7vHV8Y3O5g6AvdKgjzEHAIGtQOotGCOjgAy8yojhaTpHjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6223
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 22, 2019 at 01:30:26PM -0400, Jerome Glisse wrote:

> > Smart drivers can test somehow for pfn =3D=3D zero_page and optimize?
>=20
> There is nothing to optimize here, i do not know any hardware that
> have a special page table entry that make all memory access return
> zero.

Presumably any GPU could globally dedicate one page of internal memory
as a zero page and remap CPU zero page to that internal memory page?
This is basically how the CPU zero page works.

I suspect mlx5 could do the same with its internal memory, but the
internal memory is too limited to make this worth while.

mlx5 also has a specially 'zero MR' that always reads as zero (and
discards writes), but it doesn't quite fit well into the ODP flow.

Jason
