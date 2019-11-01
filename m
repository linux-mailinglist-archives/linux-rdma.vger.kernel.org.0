Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD5D4EC8F2
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Nov 2019 20:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfKATRf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 1 Nov 2019 15:17:35 -0400
Received: from mail-eopbgr150058.outbound.protection.outlook.com ([40.107.15.58]:8342
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727551AbfKATRe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 1 Nov 2019 15:17:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L7aRjwc6kVYlnjJg0Ay/cisXSCZAkhS4snLwk92bt9BQSVIsZJJvzcFLRYkDHBIRuxpCaAqV2Yl553WuhbdaY0rDUp7VuYlwaKw5R/xHoflvztChddAZZnmK94Iwumvi+xAYvxFvVtSgaHeLuY+KTHWnYXq10Or+VfIyA9nLmIAAgSyCAQfCuCtRxtEY66QWOtUubLPxAqiybfO3oTJrUiN0HW2B0nb2yHZanMs0dnxjGZrWTdWuMqK0rQGRsFh0RDaSTwnw82rAGNXOIhlm9q2xKs2U5upHxcJfYZYUeGGX6aBldYmqxLJfNlc0ck3eRssk2wYUF34AkqypIjktFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vzaubDtUDNP/lIo74ytTn2jiceW13gp+6YIJsrIIhA=;
 b=XcawuRoZ8Eyr1QvyOAX64OEyWdHeveZRZgRBmVMuJs3rCwIORJwVE2OJ5yP5EqtLCVP6hXKfYdb6UiSo92ybKut2eXtcqnlecjNV4Uz6HjaqQLcnZJgyDv9sLj56DdkL1sZYb9J4At6xvPWdOLKqT2f6GyKrlrsd5bQOK/b9CUWrnGlb9GXugFBqX+gqmf56F0a/udLNPh/GCLD1keeN5D8hNxhN/wK07+ZJrsfeH0Ccx4jbNFg/4b9Ep7uEXwCBHiI/xlIshGDSWGIwWCSW+t9dIemtALOWCvUz+FSOm2Taa3uJngZUTrrLws+ZAs9S7l4+0re0UIyPOAZOH2bb9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vzaubDtUDNP/lIo74ytTn2jiceW13gp+6YIJsrIIhA=;
 b=MD6Q3Cf5eGFkd80S6c8Qp6q6E8MWwPWGCkbmN6wJzkr5lZuehFA5EGtV2tcUds3SONmqbte8CtNr/7r47QAPETMoh/zpIuRXTsKvsVfebu5HwpEJJcBddZcyy/a5XqfrLzOkOXVfhS5bqC0bxa730NtZD9FqMaJGSzpOkXsidZ0=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB3293.eurprd05.prod.outlook.com (10.175.244.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.25; Fri, 1 Nov 2019 19:17:27 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d%5]) with mapi id 15.20.2387.028; Fri, 1 Nov 2019
 19:17:27 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
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
Subject: Re: [PATCH v2 09/15] xen/gntdev: use mmu_range_notifier_insert
Thread-Topic: [PATCH v2 09/15] xen/gntdev: use mmu_range_notifier_insert
Thread-Index: AQHVjcvKV253DVP8r0WB5NYgPgZcBadzahyAgAMzaQCAABG1AIAAByiA
Date:   Fri, 1 Nov 2019 19:17:27 +0000
Message-ID: <20191101191723.GT22766@mellanox.com>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-10-jgg@ziepe.ca>
 <0355257f-6a3a-cdcd-d206-aec3df97dded@oracle.com>
 <20191101174824.GP22766@mellanox.com>
 <14f96c2e-ee04-5b1a-fc32-2db1487df399@oracle.com>
In-Reply-To: <14f96c2e-ee04-5b1a-fc32-2db1487df399@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR19CA0003.namprd19.prod.outlook.com
 (2603:10b6:208:178::16) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4ebc8093-78da-4744-13e7-08d75f0021dc
x-ms-traffictypediagnostic: VI1PR05MB3293:
x-microsoft-antispam-prvs: <VI1PR05MB32932D848D35EE73CDACEA5ECF620@VI1PR05MB3293.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(199004)(189003)(305945005)(6916009)(7416002)(186003)(64756008)(6436002)(6486002)(7736002)(66556008)(66946007)(2906002)(66476007)(2616005)(86362001)(229853002)(5660300002)(26005)(11346002)(476003)(446003)(102836004)(66446008)(8936002)(81166006)(486006)(81156014)(25786009)(8676002)(54906003)(33656002)(6246003)(5024004)(76176011)(14454004)(6512007)(71190400001)(66066001)(6116002)(99286004)(256004)(3846002)(4326008)(52116002)(1076003)(6506007)(53546011)(386003)(36756003)(14444005)(478600001)(71200400001)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3293;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fSlSY7hCY9Q7BmauGFQSMsk0zKjuAauK4ZzMstrTfQ3zJeGmEL4qhMRyS+4WkTdK3btWXPh04Lcj3U33mSYZPfYzGrOOFXUJWnPk9kBGm2PPxEy4AQjFMtQoMxvKsL12L+HrR1UCwqFmnGwT1shLo3uA5AYx8GG5gTI5yCZYRYPac4GCAlyj0eGQJRdhGz8SBAfrmXQmPVgvmWfccOi86lqQ3HnWHbIYkAzYM63I2Eri708M/f2439XARJPQlftr5+qt5YJ0MOd3mnq48YxcPA6Kj2ueYgiZE1aVRB8GGNu4XzBzp3PqczMPZbgk/Klsve0xbvoj/cgzFScCHEB74eZRV676vH9QYmQEqSq/t4fjUQ2rfU71arRZYipRAYMgVC+8aaCH9QKlGrvzTRVp6iRQRFDkN+SZQk4E3k5ycx7m6O2bULYq39Uf1NgUau0+
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <18553814D461244CA039C5C384EE49D3@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ebc8093-78da-4744-13e7-08d75f0021dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 19:17:27.1712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SxUeovUvghjC4HW/Rwc15VCds4SMw74yHkiedwxpYW6v2wfry4534u7+72twT6C5M8UUHnmLIolaKMtnXCAZpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3293
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 01, 2019 at 02:51:46PM -0400, Boris Ostrovsky wrote:
> On 11/1/19 1:48 PM, Jason Gunthorpe wrote:
> > On Wed, Oct 30, 2019 at 12:55:37PM -0400, Boris Ostrovsky wrote:
> >> On 10/28/19 4:10 PM, Jason Gunthorpe wrote:
> >>> From: Jason Gunthorpe <jgg@mellanox.com>
> >>>
> >>> gntdev simply wants to monitor a specific VMA for any notifier events=
,
> >>> this can be done straightforwardly using mmu_range_notifier_insert() =
over
> >>> the VMA's VA range.
> >>>
> >>> The notifier should be attached until the original VMA is destroyed.
> >>>
> >>> It is unclear if any of this is even sane, but at least a lot of dupl=
icate
> >>> code is removed.
> >> I didn't have a chance to look at the patch itself yet but as a heads-=
up
> > Thanks Boris. I spent a bit of time and got a VM running with a xen
> > 4.9 hypervisor and a kernel with this patch series. It a ubuntu bionic
> > VM with the distro's xen stuff.
> >
> > Can you give some guidance how you made it crash?=20
>=20
> It crashes trying to dereference mrn->ops->invalidate in
> mn_itree_invalidate() when a guest exits.
>=20
> I don't think you've initialized notifier ops. I don't see you using
> gntdev_mmu_ops anywhere.

So weird the compiler didn't complain about an unused static...

But yes, this is a mistake, it should be:

diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index 37b278857ad807..0ca35485fd3865 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -1011,6 +1011,7 @@ static int gntdev_mmap(struct file *flip, struct vm_a=
rea_struct *vma)
=20
 	if (use_ptemod) {
 		map->vma =3D vma;
+		map->notifier.ops =3D &gntdev_mmu_ops;
 		err =3D mmu_range_notifier_insert_locked(
 			&map->notifier, vma->vm_start,
 			vma->vm_end - vma->vm_start, vma->vm_mm);

Thanks,
Jason
