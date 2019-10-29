Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECC84E8FE7
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2019 20:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfJ2TZw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 15:25:52 -0400
Received: from mail-eopbgr20047.outbound.protection.outlook.com ([40.107.2.47]:23022
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725880AbfJ2TZw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Oct 2019 15:25:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SEZSMHh9SE0tPeJXvYNBS4mYzslk20pTMBXA47EBwGwQI25VbJp8pYidc7VqRVpLfkPkrWpneJL7hRHB938murGgvkp+CW7GmUnhGFvqI+N/u238de0IMHGfPx2ksYhsfrW9/TTC70+oSDmD6UDb9dJibAy96PKLzKRby0DLHSf+6OxIpLDzIeO+gYdioSIvnJob75+aOprpxoCCjLjzm8KpONRX+9xKiwhZRetAIM5+7D9l9ZPhrsmBOFAum53TCm8rFVCJ3f77kf4v45x0N0itmmF2lGRq48pLpJfu35ehRM4iUxaahrNCI63Kbdk1C5rOx2tmDrC7H8JRIyh3Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMpeA2fOZtpmPe5NbtaYCyZsCWnfQKc/kuxU18FWr0g=;
 b=YeDe9QYlMx6Oy070+e7POjtCvAbiDLvOq9wqi6m/2261JPg64whgVK+h0LyBvb00tYg8Kkr6R18rDENPHcezYPAk3YyyC5O2AiwNhavX4e1w4mhPZHOS1sQ6iWlhjzXSIofKB+AkWs1frHRADakXiU5KrtiwMhhe3IVnt3pxmQJYLdhCKQWyp3zGFPSlLA+aCVrSSC3IeSSgW0n3feO66wllfUrAuzVHM/OTTwhQlk2/d1lF1YYD8jsmLMC6WHgkdjzXy1D2vzcpAjNpsMY5UBz8VEfk98a2TronvR+ouuBBGfwT2pAouF+h1m+PT95k30zFGntrbkIHQ8Gka/JZww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMpeA2fOZtpmPe5NbtaYCyZsCWnfQKc/kuxU18FWr0g=;
 b=VgMlqJAbDwnqickPU6uslS99P9YeD/X0nFlhxxMd9dpyJYv1e2Bt/7TEt+P9WEFrFQd3IfUdji3WlxHLiDR/jERR4Sl0CY+KaK0/Qov9dAghAglPNGmzC0zo/KgIJqJtfrFnEaFjQ2J07hDkIn8z5FZAz49ZaeLLuAV39GsLFSQ=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB4686.eurprd05.prod.outlook.com (20.176.6.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Tue, 29 Oct 2019 19:25:48 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d%5]) with mapi id 15.20.2387.027; Tue, 29 Oct 2019
 19:25:48 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     "Yang, Philip" <Philip.Yang@amd.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        Juergen Gross <jgross@suse.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Christoph Hellwig <hch@infradead.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Petr Cvek <petrcvekcz@gmail.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH v2 14/15] drm/amdgpu: Use mmu_range_notifier instead of
 hmm_mirror
Thread-Topic: [PATCH v2 14/15] drm/amdgpu: Use mmu_range_notifier instead of
 hmm_mirror
Thread-Index: AQHVjcvOUfhzqykxXkO0v7SQaQq3BKdyANqAgAAA3wA=
Date:   Tue, 29 Oct 2019 19:25:48 +0000
Message-ID: <20191029192544.GU22766@mellanox.com>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-15-jgg@ziepe.ca>
 <a456ebd0-28cf-997b-31ff-72d9077a9b8e@amd.com>
In-Reply-To: <a456ebd0-28cf-997b-31ff-72d9077a9b8e@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR02CA0109.namprd02.prod.outlook.com
 (2603:10b6:208:35::14) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 979493e2-e42a-407c-39b9-08d75ca5cd5b
x-ms-traffictypediagnostic: VI1PR05MB4686:
x-microsoft-antispam-prvs: <VI1PR05MB468627A437392D50C53214BCCF610@VI1PR05MB4686.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(189003)(199004)(6246003)(4326008)(76176011)(14454004)(6512007)(36756003)(6436002)(52116002)(7736002)(386003)(6506007)(305945005)(86362001)(6486002)(25786009)(446003)(229853002)(66446008)(66946007)(2616005)(64756008)(66556008)(66476007)(11346002)(8676002)(81156014)(102836004)(99286004)(7416002)(81166006)(66066001)(8936002)(71200400001)(478600001)(71190400001)(316002)(476003)(256004)(33656002)(6916009)(5660300002)(4744005)(1076003)(26005)(186003)(486006)(54906003)(2906002)(3846002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4686;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HHlUO9xvJTjdZfcghyORf0sfHD7cUqkcT8S4N/0ThFFE6Xu3OxLnlOrzETPrNUzMLvHpWWKNV+of67pztMoyazPIgf/LL/aFtLPBMdGSVTzUHtboqHJJfObumx4RhYGAZEzSU0LDLRnAhxQkIXOhYoTYztXKBJVFK/wKTrDAohNWDJbG0MAdx3ji+WNLfGYhTi6Jnd/JtjieWmAohMAjxGiH3zglcTEgngM3IABAdiPTtuslbWTnvGVH+PRGW/z3ZWv4dhDCvNy9J+rennXppxXLVLAam4tj27DnTQWliHfK2wpDHDbenFZHakscJo/LtNmgImcStBE4vMWUDrRxrGKTUGSGg0Uc/tPpg0CRdC6/X2zviuNpCefUFbAqx3xPk+OvePZEoNhxRxr/U/gRGj1tk7HO3vyXO8eKf4dKz7kKZZmD8iPf1QRAd/i2i7FR
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F8CA839373A7664D9975C1FAC4028043@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 979493e2-e42a-407c-39b9-08d75ca5cd5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 19:25:48.2890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eA37CF4cFKLwzsQ/O+qV1f0nUQ3jjSvB+Dm8keuV91Mbh9nbSx48R8RZUwGM6u94ayjJW1Xzc9q0WXYqLT/p/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4686
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 29, 2019 at 07:22:37PM +0000, Yang, Philip wrote:
> Hi Jason,
>=20
> I did quick test after merging amd-staging-drm-next with the=20
> mmu_notifier branch, which includes this set changes. The test result=20
> has different failures, app stuck intermittently, GUI no display etc. I=20
> am understanding the changes and will try to figure out the cause.

Thanks! I'm not surprised by this given how difficult this patch was
to make. Let me know if I can assist in any way

Please ensure to run with lockdep enabled.. Your symptops sounds sort
of like deadlocking?

Regards,
Jason
