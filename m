Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F155EC896
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Nov 2019 19:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfKASjm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 1 Nov 2019 14:39:42 -0400
Received: from mail-eopbgr30058.outbound.protection.outlook.com ([40.107.3.58]:60995
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726671AbfKASjm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 1 Nov 2019 14:39:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ID1czwKAJLJjyQE30wEVEYNJTUEtpI7Qkl24FrPbmXzaju2x222SlxL+11q/UDBdUsYq/Z2/UvM7LVb9kuBkmxRiPd+cG27JIs/5anPSLrc7aT3QaOrgcKpwM8i5z2Mu+VXBiwW83tEQNE5hJXvc+XrdZie0X3djGlK9VtdfANz/f9HA6j0tymIPobevmbRt5At9dvqKzmAlICQVL+C5KxnYAZUX1XsZDwxeeap+ii3cUXxe6a6LXB6Y9Z2CLEUZrgZfETf0RDCkTFrDGtTCi21B8u9CnCEWoplFgFw+ldPZqhwRHcWF5oC5uiLKC4BAedJEJltsMdcJCdpwIM9Ntw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXuOHTtipoYkfU5LykKoTmwF4/VlgjtrC3fuHXm5AjI=;
 b=Ua7vkWayi5JBuLpIWZDwMR6AU8/DU7mhA0xCZewXDuUeeom3QLuwm1csS/Ijbju+vpjF5akTq0bN0oEELJ/Kenn1bIACSln3frAm66Gi8wdxfLhRqTQ+N8LJ2dpvGazDJQ9x9GjhAtvjf0jWi9ZpO9RhsiChXpx2x0XeytZp+nweQxxTcQXG22ZsGL5xqq1RfQ6lSkx9Yu/VeSvwR2JR/7hDMR5ENG++Gq98I60v1tkMK9wUXyvj65jfuM/79MVATfvMzpRzm1WpRXaXg6xWxf5XH6Ldn86uJDqZtAtFu3WnXOsCN8l+OGWxqAgNf56bqEnegkHrJwtC6tD56Ps3+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXuOHTtipoYkfU5LykKoTmwF4/VlgjtrC3fuHXm5AjI=;
 b=SVt+wZWfddkHw40mdehiJvucDKT2KvzDlrQP55Ml/4rWjve2GuEe2xqxPo73B2fRqrFrHqK5bx8O/xIaihWeqPjCshAWTaYAbnXeNPUgKNFCym3gLpiowXTwCoZckm0xfZGrKXjiAUW/JE5DWbv0znRymHJP/wjis3b6AfDHIX8=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB4416.eurprd05.prod.outlook.com (52.134.123.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Fri, 1 Nov 2019 18:34:40 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d%5]) with mapi id 15.20.2387.028; Fri, 1 Nov 2019
 18:34:40 +0000
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
Subject: [PATCH v2a 14/15] drm/amdgpu: Use mmu_range_notifier instead of
 hmm_mirror
Thread-Topic: [PATCH v2a 14/15] drm/amdgpu: Use mmu_range_notifier instead of
 hmm_mirror
Thread-Index: AQHVkOMFaRcJHQRrK0S6ryutY4Fnpg==
Date:   Fri, 1 Nov 2019 18:34:40 +0000
Message-ID: <20191101183435.GR22766@mellanox.com>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-15-jgg@ziepe.ca>
 <a456ebd0-28cf-997b-31ff-72d9077a9b8e@amd.com>
 <20191029192544.GU22766@mellanox.com>
 <30b2f569-bf7a-5166-c98d-4a4a13d1351f@amd.com>
In-Reply-To: <30b2f569-bf7a-5166-c98d-4a4a13d1351f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN4PR12CA0013.namprd12.prod.outlook.com
 (2603:10b6:403:2::23) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7fd1dc84-23d9-4c30-3490-08d75efa27d3
x-ms-traffictypediagnostic: VI1PR05MB4416:
x-microsoft-antispam-prvs: <VI1PR05MB441655C7601F1FC6E1ADB682CF620@VI1PR05MB4416.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(199004)(189003)(36756003)(81156014)(86362001)(102836004)(54906003)(476003)(11346002)(446003)(14454004)(6916009)(6512007)(486006)(2616005)(99286004)(14444005)(6436002)(66066001)(256004)(6486002)(6116002)(2906002)(8676002)(25786009)(71200400001)(3846002)(4326008)(478600001)(71190400001)(33656002)(30864003)(5660300002)(66946007)(81166006)(8936002)(7736002)(52116002)(66556008)(66476007)(386003)(6506007)(1076003)(316002)(66446008)(186003)(305945005)(26005)(7416002)(76176011)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4416;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fWNQ+BZa7hfC/4uLDbkIzf190FXkgTVGRQKdPvrvbvJpoBtJPgrsM7NGgZQ1QolaRtrYNrap2uwCvyZBwc+s1RJrMJs0W4wt38pjuaPPJHfnwuNoqyOnrYlMsQwNybX+mi4Q5WE4Pg0wiaVGQDLKd/jzIznyDxANtLOIJkay4xVDUZuqQJg0ZJ5lwxg9w7eTS8jfnmflWgEN1kT2Vh17iuWWQZ3VwGzrMwd3SehhT5moiR+3hN8s058c3TYlgBggqYdEGdDYMmVxzwWbZ1hRnOtvnkbCjHalAFCEwBe2F4KYWoOr44uRyLV32bUbwHLWYknPvscKcWD2/FgOmTHQPiVPsk9o16OhK4JhXmP+uYkdvjkbZgWiPYIElS4dXYek7ygn7Xc0XKeD/JE/rH5lLTVBDLeo3+S2wC+qVP+/j2+4kf1uzHXjbfJLmDORfGdY
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B78E009015572D46BF74BF5D5DC8C6FA@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd1dc84-23d9-4c30-3490-08d75efa27d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 18:34:40.7437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6w7Cky8H25cOW4Dxqgj7Dr4BIQtw+qoZ/7TjiXWzab8P8ekkpF8unK6sBjda6ZrGlvHzuK1g8e6b2fcbAMO5Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4416
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Convert the collision-retry lock around hmm_range_fault to use the one now
provided by the mmu_range notifier.

Although this driver does not seem to use the collision retry lock that
hmm provides correctly, it can still be converted over to use the
mmu_range_notifier api instead of hmm_mirror without too much trouble.

This also deletes another place where a driver is associating additional
data (struct amdgpu_mn) with a mmu_struct.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Philip Yang <Philip.Yang@amd.com>
Tested-by: Philip Yang <Philip.Yang@amd.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |  14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c        | 150 ++----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h        |  49 ------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 116 +++++++++-----
 5 files changed, 96 insertions(+), 237 deletions(-)

Philip, here is what it loos like after combining the two patches, thanks

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 47700302a08b7f..1bcedb9b477dce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1738,6 +1738,10 @@ static int update_invalid_user_pages(struct amdkfd_p=
rocess_info *process_info,
 			return ret;
 		}
=20
+		/*
+		 * FIXME: Cannot ignore the return code, must hold
+		 * notifier_lock
+		 */
 		amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm);
=20
 		/* Mark the BO as valid unless it was invalidated
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_cs.c
index 82823d9a8ba887..22c989bca7514c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -603,8 +603,6 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser=
 *p,
 		e->tv.num_shared =3D 2;
=20
 	amdgpu_bo_list_get_list(p->bo_list, &p->validated);
-	if (p->bo_list->first_userptr !=3D p->bo_list->num_entries)
-		p->mn =3D amdgpu_mn_get(p->adev, AMDGPU_MN_TYPE_GFX);
=20
 	INIT_LIST_HEAD(&duplicates);
 	amdgpu_vm_get_pd_bo(&fpriv->vm, &p->validated, &p->vm_pd);
@@ -1287,11 +1285,11 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser=
 *p,
 	if (r)
 		goto error_unlock;
=20
-	/* No memory allocation is allowed while holding the mn lock.
-	 * p->mn is hold until amdgpu_cs_submit is finished and fence is added
-	 * to BOs.
+	/* No memory allocation is allowed while holding the notifier lock.
+	 * The lock is held until amdgpu_cs_submit is finished and fence is
+	 * added to BOs.
 	 */
-	amdgpu_mn_lock(p->mn);
+	mutex_lock(&p->adev->notifier_lock);
=20
 	/* If userptr are invalidated after amdgpu_cs_parser_bos(), return
 	 * -EAGAIN, drmIoctl in libdrm will restart the amdgpu_cs_ioctl.
@@ -1334,13 +1332,13 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser=
 *p,
 	amdgpu_vm_move_to_lru_tail(p->adev, &fpriv->vm);
=20
 	ttm_eu_fence_buffer_objects(&p->ticket, &p->validated, p->fence);
-	amdgpu_mn_unlock(p->mn);
+	mutex_unlock(&p->adev->notifier_lock);
=20
 	return 0;
=20
 error_abort:
 	drm_sched_job_cleanup(&job->base);
-	amdgpu_mn_unlock(p->mn);
+	mutex_unlock(&p->adev->notifier_lock);
=20
 error_unlock:
 	amdgpu_job_free(job);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_mn.c
index ac74320b71e4e7..f7be34907e54f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
@@ -50,28 +50,6 @@
 #include "amdgpu.h"
 #include "amdgpu_amdkfd.h"
=20
-/**
- * amdgpu_mn_lock - take the write side lock for this notifier
- *
- * @mn: our notifier
- */
-void amdgpu_mn_lock(struct amdgpu_mn *mn)
-{
-	if (mn)
-		down_write(&mn->lock);
-}
-
-/**
- * amdgpu_mn_unlock - drop the write side lock for this notifier
- *
- * @mn: our notifier
- */
-void amdgpu_mn_unlock(struct amdgpu_mn *mn)
-{
-	if (mn)
-		up_write(&mn->lock);
-}
-
 /**
  * amdgpu_mn_invalidate_gfx - callback to notify about mm change
  *
@@ -82,16 +60,20 @@ void amdgpu_mn_unlock(struct amdgpu_mn *mn)
  * potentially dirty.
  */
 static bool amdgpu_mn_invalidate_gfx(struct mmu_range_notifier *mrn,
-				     const struct mmu_notifier_range *range)
+				     const struct mmu_notifier_range *range,
+				     unsigned long cur_seq)
 {
 	struct amdgpu_bo *bo =3D container_of(mrn, struct amdgpu_bo, notifier);
 	struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
 	long r;
=20
-	if (!mmu_notifier_range_blockable(range))
+	if (mmu_notifier_range_blockable(range))
+		mutex_lock(&adev->notifier_lock);
+	else if (!mutex_trylock(&adev->notifier_lock))
 		return false;
=20
-	mutex_lock(&adev->notifier_lock);
+	mmu_range_set_seq(mrn, cur_seq);
+
 	r =3D dma_resv_wait_timeout_rcu(bo->tbo.base.resv, true, false,
 				      MAX_SCHEDULE_TIMEOUT);
 	mutex_unlock(&adev->notifier_lock);
@@ -114,15 +96,19 @@ static const struct mmu_range_notifier_ops amdgpu_mn_g=
fx_ops =3D {
  * evicting all user-mode queues of the process.
  */
 static bool amdgpu_mn_invalidate_hsa(struct mmu_range_notifier *mrn,
-				     const struct mmu_notifier_range *range)
+				     const struct mmu_notifier_range *range,
+				     unsigned long cur_seq)
 {
 	struct amdgpu_bo *bo =3D container_of(mrn, struct amdgpu_bo, notifier);
 	struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
=20
-	if (!mmu_notifier_range_blockable(range))
+	if (mmu_notifier_range_blockable(range))
+		mutex_lock(&adev->notifier_lock);
+	else if (!mutex_trylock(&adev->notifier_lock))
 		return false;
=20
-	mutex_lock(&adev->notifier_lock);
+	mmu_range_set_seq(mrn, cur_seq);
+
 	amdgpu_amdkfd_evict_userptr(bo->kfd_bo, bo->notifier.mm);
 	mutex_unlock(&adev->notifier_lock);
=20
@@ -133,92 +119,6 @@ static const struct mmu_range_notifier_ops amdgpu_mn_h=
sa_ops =3D {
 	.invalidate =3D amdgpu_mn_invalidate_hsa,
 };
=20
-static int amdgpu_mn_sync_pagetables(struct hmm_mirror *mirror,
-				     const struct mmu_notifier_range *update)
-{
-	struct amdgpu_mn *amn =3D container_of(mirror, struct amdgpu_mn, mirror);
-
-	if (!mmu_notifier_range_blockable(update))
-		return -EAGAIN;
-
-	down_read(&amn->lock);
-	up_read(&amn->lock);
-	return 0;
-}
-
-/* Low bits of any reasonable mm pointer will be unused due to struct
- * alignment. Use these bits to make a unique key from the mm pointer
- * and notifier type.
- */
-#define AMDGPU_MN_KEY(mm, type) ((unsigned long)(mm) + (type))
-
-static struct hmm_mirror_ops amdgpu_hmm_mirror_ops[] =3D {
-	[AMDGPU_MN_TYPE_GFX] =3D {
-		.sync_cpu_device_pagetables =3D amdgpu_mn_sync_pagetables,
-	},
-	[AMDGPU_MN_TYPE_HSA] =3D {
-		.sync_cpu_device_pagetables =3D amdgpu_mn_sync_pagetables,
-	},
-};
-
-/**
- * amdgpu_mn_get - create HMM mirror context
- *
- * @adev: amdgpu device pointer
- * @type: type of MMU notifier context
- *
- * Creates a HMM mirror context for current->mm.
- */
-struct amdgpu_mn *amdgpu_mn_get(struct amdgpu_device *adev,
-				enum amdgpu_mn_type type)
-{
-	struct mm_struct *mm =3D current->mm;
-	struct amdgpu_mn *amn;
-	unsigned long key =3D AMDGPU_MN_KEY(mm, type);
-	int r;
-
-	mutex_lock(&adev->mn_lock);
-	if (down_write_killable(&mm->mmap_sem)) {
-		mutex_unlock(&adev->mn_lock);
-		return ERR_PTR(-EINTR);
-	}
-
-	hash_for_each_possible(adev->mn_hash, amn, node, key)
-		if (AMDGPU_MN_KEY(amn->mirror.hmm->mmu_notifier.mm,
-				  amn->type) =3D=3D key)
-			goto release_locks;
-
-	amn =3D kzalloc(sizeof(*amn), GFP_KERNEL);
-	if (!amn) {
-		amn =3D ERR_PTR(-ENOMEM);
-		goto release_locks;
-	}
-
-	amn->adev =3D adev;
-	init_rwsem(&amn->lock);
-	amn->type =3D type;
-
-	amn->mirror.ops =3D &amdgpu_hmm_mirror_ops[type];
-	r =3D hmm_mirror_register(&amn->mirror, mm);
-	if (r)
-		goto free_amn;
-
-	hash_add(adev->mn_hash, &amn->node, AMDGPU_MN_KEY(mm, type));
-
-release_locks:
-	up_write(&mm->mmap_sem);
-	mutex_unlock(&adev->mn_lock);
-
-	return amn;
-
-free_amn:
-	up_write(&mm->mmap_sem);
-	mutex_unlock(&adev->mn_lock);
-	kfree(amn);
-
-	return ERR_PTR(r);
-}
-
 /**
  * amdgpu_mn_register - register a BO for notifier updates
  *
@@ -253,25 +153,3 @@ void amdgpu_mn_unregister(struct amdgpu_bo *bo)
 	mmu_range_notifier_remove(&bo->notifier);
 	bo->notifier.mm =3D NULL;
 }
-
-/* flags used by HMM internal, not related to CPU/GPU PTE flags */
-static const uint64_t hmm_range_flags[HMM_PFN_FLAG_MAX] =3D {
-		(1 << 0), /* HMM_PFN_VALID */
-		(1 << 1), /* HMM_PFN_WRITE */
-		0 /* HMM_PFN_DEVICE_PRIVATE */
-};
-
-static const uint64_t hmm_range_values[HMM_PFN_VALUE_MAX] =3D {
-		0xfffffffffffffffeUL, /* HMM_PFN_ERROR */
-		0, /* HMM_PFN_NONE */
-		0xfffffffffffffffcUL /* HMM_PFN_SPECIAL */
-};
-
-void amdgpu_hmm_init_range(struct hmm_range *range)
-{
-	if (range) {
-		range->flags =3D hmm_range_flags;
-		range->values =3D hmm_range_values;
-		range->pfn_shift =3D PAGE_SHIFT;
-	}
-}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_mn.h
index d73ab2947b22b2..a292238f75ebae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h
@@ -30,59 +30,10 @@
 #include <linux/workqueue.h>
 #include <linux/interval_tree.h>
=20
-enum amdgpu_mn_type {
-	AMDGPU_MN_TYPE_GFX,
-	AMDGPU_MN_TYPE_HSA,
-};
-
-/**
- * struct amdgpu_mn
- *
- * @adev: amdgpu device pointer
- * @type: type of MMU notifier
- * @work: destruction work item
- * @node: hash table node to find structure by adev and mn
- * @lock: rw semaphore protecting the notifier nodes
- * @mirror: HMM mirror function support
- *
- * Data for each amdgpu device and process address space.
- */
-struct amdgpu_mn {
-	/* constant after initialisation */
-	struct amdgpu_device	*adev;
-	enum amdgpu_mn_type	type;
-
-	/* only used on destruction */
-	struct work_struct	work;
-
-	/* protected by adev->mn_lock */
-	struct hlist_node	node;
-
-	/* objects protected by lock */
-	struct rw_semaphore	lock;
-
-#ifdef CONFIG_HMM_MIRROR
-	/* HMM mirror */
-	struct hmm_mirror	mirror;
-#endif
-};
-
 #if defined(CONFIG_HMM_MIRROR)
-void amdgpu_mn_lock(struct amdgpu_mn *mn);
-void amdgpu_mn_unlock(struct amdgpu_mn *mn);
-struct amdgpu_mn *amdgpu_mn_get(struct amdgpu_device *adev,
-				enum amdgpu_mn_type type);
 int amdgpu_mn_register(struct amdgpu_bo *bo, unsigned long addr);
 void amdgpu_mn_unregister(struct amdgpu_bo *bo);
-void amdgpu_hmm_init_range(struct hmm_range *range);
 #else
-static inline void amdgpu_mn_lock(struct amdgpu_mn *mn) {}
-static inline void amdgpu_mn_unlock(struct amdgpu_mn *mn) {}
-static inline struct amdgpu_mn *amdgpu_mn_get(struct amdgpu_device *adev,
-					      enum amdgpu_mn_type type)
-{
-	return NULL;
-}
 static inline int amdgpu_mn_register(struct amdgpu_bo *bo, unsigned long a=
ddr)
 {
 	DRM_WARN_ONCE("HMM_MIRROR kernel config option is not enabled, "
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c
index c0e41f1f0c2365..5f4d8ab76f1da0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -773,6 +773,20 @@ struct amdgpu_ttm_tt {
 #endif
 };
=20
+#ifdef CONFIG_DRM_AMDGPU_USERPTR
+/* flags used by HMM internal, not related to CPU/GPU PTE flags */
+static const uint64_t hmm_range_flags[HMM_PFN_FLAG_MAX] =3D {
+	(1 << 0), /* HMM_PFN_VALID */
+	(1 << 1), /* HMM_PFN_WRITE */
+	0 /* HMM_PFN_DEVICE_PRIVATE */
+};
+
+static const uint64_t hmm_range_values[HMM_PFN_VALUE_MAX] =3D {
+	0xfffffffffffffffeUL, /* HMM_PFN_ERROR */
+	0, /* HMM_PFN_NONE */
+	0xfffffffffffffffcUL /* HMM_PFN_SPECIAL */
+};
+
 /**
  * amdgpu_ttm_tt_get_user_pages - get device accessible pages that back us=
er
  * memory and start HMM tracking CPU page table update
@@ -780,29 +794,28 @@ struct amdgpu_ttm_tt {
  * Calling function must call amdgpu_ttm_tt_userptr_range_done() once and =
only
  * once afterwards to stop HMM tracking
  */
-#if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
-
-#define MAX_RETRY_HMM_RANGE_FAULT	16
-
 int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages=
)
 {
-	struct hmm_mirror *mirror =3D bo->mn ? &bo->mn->mirror : NULL;
 	struct ttm_tt *ttm =3D bo->tbo.ttm;
 	struct amdgpu_ttm_tt *gtt =3D (void *)ttm;
-	struct mm_struct *mm;
 	unsigned long start =3D gtt->userptr;
 	struct vm_area_struct *vma;
 	struct hmm_range *range;
+	unsigned long timeout;
+	struct mm_struct *mm;
 	unsigned long i;
-	uint64_t *pfns;
 	int r =3D 0;
=20
-	if (unlikely(!mirror)) {
-		DRM_DEBUG_DRIVER("Failed to get hmm_mirror\n");
+	mm =3D bo->notifier.mm;
+	if (unlikely(!mm)) {
+		DRM_DEBUG_DRIVER("BO is not registered?\n");
 		return -EFAULT;
 	}
=20
-	mm =3D mirror->hmm->mmu_notifier.mm;
+	/* Another get_user_pages is running at the same time?? */
+	if (WARN_ON(gtt->range))
+		return -EFAULT;
+
 	if (!mmget_not_zero(mm)) /* Happens during process shutdown */
 		return -ESRCH;
=20
@@ -811,31 +824,23 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo=
, struct page **pages)
 		r =3D -ENOMEM;
 		goto out;
 	}
+	range->notifier =3D &bo->notifier;
+	range->flags =3D hmm_range_flags;
+	range->values =3D hmm_range_values;
+	range->pfn_shift =3D PAGE_SHIFT;
+	range->start =3D bo->notifier.interval_tree.start;
+	range->end =3D bo->notifier.interval_tree.last + 1;
+	range->default_flags =3D hmm_range_flags[HMM_PFN_VALID];
+	if (!amdgpu_ttm_tt_is_readonly(ttm))
+		range->default_flags |=3D range->flags[HMM_PFN_WRITE];
=20
-	pfns =3D kvmalloc_array(ttm->num_pages, sizeof(*pfns), GFP_KERNEL);
-	if (unlikely(!pfns)) {
+	range->pfns =3D kvmalloc_array(ttm->num_pages, sizeof(*range->pfns),
+				     GFP_KERNEL);
+	if (unlikely(!range->pfns)) {
 		r =3D -ENOMEM;
 		goto out_free_ranges;
 	}
=20
-	amdgpu_hmm_init_range(range);
-	range->default_flags =3D range->flags[HMM_PFN_VALID];
-	range->default_flags |=3D amdgpu_ttm_tt_is_readonly(ttm) ?
-				0 : range->flags[HMM_PFN_WRITE];
-	range->pfn_flags_mask =3D 0;
-	range->pfns =3D pfns;
-	range->start =3D start;
-	range->end =3D start + ttm->num_pages * PAGE_SIZE;
-
-	hmm_range_register(range, mirror);
-
-	/*
-	 * Just wait for range to be valid, safe to ignore return value as we
-	 * will use the return value of hmm_range_fault() below under the
-	 * mmap_sem to ascertain the validity of the range.
-	 */
-	hmm_range_wait_until_valid(range, HMM_RANGE_DEFAULT_TIMEOUT);
-
 	down_read(&mm->mmap_sem);
 	vma =3D find_vma(mm, start);
 	if (unlikely(!vma || start < vma->vm_start)) {
@@ -847,18 +852,31 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo=
, struct page **pages)
 		r =3D -EPERM;
 		goto out_unlock;
 	}
+	up_read(&mm->mmap_sem);
+	timeout =3D jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
=20
+retry:
+	range->notifier_seq =3D mmu_range_read_begin(&bo->notifier);
+
+	down_read(&mm->mmap_sem);
 	r =3D hmm_range_fault(range, 0);
 	up_read(&mm->mmap_sem);
-
-	if (unlikely(r < 0))
+	if (unlikely(r <=3D 0)) {
+		/*
+		 * FIXME: This timeout should encompass the retry from
+		 * mmu_range_read_retry() as well.
+		 */
+		if ((r =3D=3D 0 || r =3D=3D -EBUSY) && !time_after(jiffies, timeout))
+			goto retry;
 		goto out_free_pfns;
+	}
=20
 	for (i =3D 0; i < ttm->num_pages; i++) {
-		pages[i] =3D hmm_device_entry_to_page(range, pfns[i]);
+		/* FIXME: The pages cannot be touched outside the notifier_lock */
+		pages[i] =3D hmm_device_entry_to_page(range, range->pfns[i]);
 		if (unlikely(!pages[i])) {
 			pr_err("Page fault failed for pfn[%lu] =3D 0x%llx\n",
-			       i, pfns[i]);
+			       i, range->pfns[i]);
 			r =3D -ENOMEM;
=20
 			goto out_free_pfns;
@@ -873,8 +891,7 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, =
struct page **pages)
 out_unlock:
 	up_read(&mm->mmap_sem);
 out_free_pfns:
-	hmm_range_unregister(range);
-	kvfree(pfns);
+	kvfree(range->pfns);
 out_free_ranges:
 	kfree(range);
 out:
@@ -903,15 +920,18 @@ bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt =
*ttm)
 		"No user pages to check\n");
=20
 	if (gtt->range) {
-		r =3D hmm_range_valid(gtt->range);
-		hmm_range_unregister(gtt->range);
-
+		/*
+		 * FIXME: Must always hold notifier_lock for this, and must
+		 * not ignore the return code.
+		 */
+		r =3D mmu_range_read_retry(gtt->range->notifier,
+					 gtt->range->notifier_seq);
 		kvfree(gtt->range->pfns);
 		kfree(gtt->range);
 		gtt->range =3D NULL;
 	}
=20
-	return r;
+	return !r;
 }
 #endif
=20
@@ -992,10 +1012,18 @@ static void amdgpu_ttm_tt_unpin_userptr(struct ttm_t=
t *ttm)
 	sg_free_table(ttm->sg);
=20
 #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
-	if (gtt->range &&
-	    ttm->pages[0] =3D=3D hmm_device_entry_to_page(gtt->range,
-						      gtt->range->pfns[0]))
-		WARN_ONCE(1, "Missing get_user_page_done\n");
+	if (gtt->range) {
+		unsigned long i;
+
+		for (i =3D 0; i < ttm->num_pages; i++) {
+			if (ttm->pages[i] !=3D
+				hmm_device_entry_to_page(gtt->range,
+					      gtt->range->pfns[i]))
+				break;
+		}
+
+		WARN((i =3D=3D ttm->num_pages), "Missing get_user_page_done\n");
+	}
 #endif
 }
=20
--=20
2.23.0

