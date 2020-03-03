Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9DE217763B
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Mar 2020 13:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgCCMmh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Mar 2020 07:42:37 -0500
Received: from mail-eopbgr80073.outbound.protection.outlook.com ([40.107.8.73]:26338
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727826AbgCCMmh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 3 Mar 2020 07:42:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fohMI+70btdxp0CjnxWj0kHmrp31SvuSSBTqs1oejVLK53tGGzIc3RmVStQBOEJyJ+GplpcA6hqmnJ/1XEMfcSMBgXW+Sihk/ExbjequXD9w/05tX1RHqMXUfJJA1hma9dcYr/pFNLaW6FivTRBAuKQ78dYeP9+gTv7kCvyZxrD5ic92rvO1n6J+Os3BsVXS+RRZVUcm6fSpejAzWvKH33P3I6lSwytqKfBubklV/G8MK07gkfZcRgYIoHKy8dIWKLQfsV87TRRpvw4ayGlj2acmhLj3OP4tTYhy/KM2h07HxIIgSqn0+zVFhvatlaPHupROBIjiEYljOD4LIwIlYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZQ/KXYyEtu5JOGr9NpXqqDzEzNAAM2mdXtXBXwTl1o=;
 b=XkQlAjMC42qTkTPBrUjYU0kTrZS9tXJEo1sP3gxNkACuEGZYHNnJLx6w2aZqeWlSqHpLlv3D9JcA+UewwRulV5749+MLe2OIzktGBM35oY9Hmzg7ZmubuKdyo/8bhLDr0z/i1ZtqBF+ij11jB+ku2onNjPTnTiMjcmMoBIam1wWE8NsklsxqNBUmzAAr4Eu8aVEDTP4WmST+gjT9WIIKno4PHoZSMZ7L8YSf8R082Lom69CHs7y/zAr5xCm000XdXSlXud/VaAEEdyl3YwpGVsV+ugByHbA9HvtVOge8IvfroeMfz6Ra8nzW5FbytFmKC1202FLlUZbTsMhs/bQO9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZQ/KXYyEtu5JOGr9NpXqqDzEzNAAM2mdXtXBXwTl1o=;
 b=AkZ255c1iI6qTJYCYDClWZHAai7U3Fa755Z1xUl+E6tnk/ruSESRC9Qr05YTlYXrAfsjnre0G/LTkUMMPcyluNTl9JUC2UEEHQ+sgQEEqmZEi0AzAT3bIj1xf/pOc79P9l3yFzisxTUoTkRUV0+B1pZiajmRzFtngmGgiuxXIs0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB4304.eurprd05.prod.outlook.com (52.134.31.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.18; Tue, 3 Mar 2020 12:42:33 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 12:42:33 +0000
Date:   Tue, 3 Mar 2020 08:42:29 -0400
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        nouveau@lists.freedesktop.org, Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH v2] nouveau/hmm: map pages after migration
Message-ID: <20200303124229.GH26318@mellanox.com>
References: <20200303010023.2983-1-rcampbell@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200303010023.2983-1-rcampbell@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR11CA0010.namprd11.prod.outlook.com
 (2603:10b6:208:23b::15) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR11CA0010.namprd11.prod.outlook.com (2603:10b6:208:23b::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend Transport; Tue, 3 Mar 2020 12:42:32 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1j96sX-00052m-Fn; Tue, 03 Mar 2020 08:42:29 -0400
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 932f4548-d333-4524-d9c2-08d7bf7057fc
X-MS-TrafficTypeDiagnostic: VI1PR05MB4304:
X-Microsoft-Antispam-PRVS: <VI1PR05MB4304D9D99272469C88E0B9D2CFE40@VI1PR05MB4304.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(189003)(199004)(2906002)(26005)(7416002)(498600001)(9746002)(9786002)(6916009)(36756003)(8676002)(81166006)(2616005)(81156014)(8936002)(52116002)(54906003)(66476007)(66556008)(33656002)(66946007)(5660300002)(186003)(4326008)(1076003)(86362001)(66574012)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4304;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sqUfKc9/lGC/B3dtqv2ERaiDJD/SIYB/tAv0oF3CVMnVEE+Kyq99++m/M5Gs2szBIvQr7vMVnDJFXhVPoM3ENwnHjdWn5I7vHvmmX5c126BpBS3aV4AmQWUcqKMCjj71Y4LeBoa4Sfw9MdBWw9UNznWdrVYeEk3DjqtvG+iVG/WfObc/lOgpn+Bd0k3yWoCHYXixQxhITTMSrQwX/l0s/FcFuiYN8Ufr35Jni08KgjYWwju1B6mzs8W25q7Wpe2oNmIlC0B41DG3Y0vSdxrhP06qVqVW0nuGRiVBkWANX07SshusIw4jBYqG1tPu0ng7H7cGGKVlZXiwFYMNw6Vcz78Kv+2eQ6TslgjoR3DiZNkZKWyzKlG0xfNbrJIqgRrTufd3ZS40FJFxmSXhBobJJ/6sNMkJJpAegLV7uQ9DNNZx0phgfBsaJAGotu+CJrIDoORhuv2tD2JH+xSgAF1Jo4eJueR75YccmycaM5/F5oJ1W0Ap+nDqVfVg1f1azdt8
X-MS-Exchange-AntiSpam-MessageData: BhMVWap8pTjYC7/WBNhXHjIZ7qtbW7ov+QPCU+iY0TbMWIf83UO8NQtWvndTX1w5rqKmrbVbHW14N6pTdLA+JaVWTcOFwSYPStd+1ogHkIXovkpTfT7oeynKtoieOrYB0RYN+lJMZnRS1XdRFhWZTg==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 932f4548-d333-4524-d9c2-08d7bf7057fc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 12:42:33.1434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cAL3WKQnCqcEhA6Hd332a2QVZzi5Aq6WkA9z4wJVHtuOJKxrduvyeCy/MPssTwko8UZaZMyRnwQRkRGCjfc6xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4304
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 02, 2020 at 05:00:23PM -0800, Ralph Campbell wrote:
> When memory is migrated to the GPU, it is likely to be accessed by GPU
> code soon afterwards. Instead of waiting for a GPU fault, map the
> migrated memory into the GPU page tables with the same access permissions
> as the source CPU page table entries. This preserves copy on write
> semantics.
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> Cc: Ben Skeggs <bskeggs@redhat.com>
> ---
> 
> Originally this patch was targeted for Jason's rdma tree since other HMM
> related changes were queued there. Now that those have been merged, this
> patch just contains changes to nouveau so it could go through any tree.
> I guess Ben Skeggs' tree would be appropriate.

Yep

> +static inline struct nouveau_pfnmap_args *
> +nouveau_pfns_to_args(void *pfns)

don't use static inline inside C files

> +{
> +	struct nvif_vmm_pfnmap_v0 *p =
> +		container_of(pfns, struct nvif_vmm_pfnmap_v0, phys);
> +
> +	return container_of(p, struct nouveau_pfnmap_args, p);

And this should just be 

   return container_of(pfns, struct nouveau_pfnmap_args, p.phys);

> +static struct nouveau_svmm *
> +nouveau_find_svmm(struct nouveau_svm *svm, struct mm_struct *mm)
> +{
> +	struct nouveau_ivmm *ivmm;
> +
> +	list_for_each_entry(ivmm, &svm->inst, head) {
> +		if (ivmm->svmm->notifier.mm == mm)
> +			return ivmm->svmm;
> +	}
> +	return NULL;
> +}

Is this re-implementing mmu_notifier_get() ?

Jason
