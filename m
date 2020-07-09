Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAA8219F5A
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jul 2020 13:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgGILx1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Jul 2020 07:53:27 -0400
Received: from mail-bn8nam12on2045.outbound.protection.outlook.com ([40.107.237.45]:13121
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726387AbgGILx0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 9 Jul 2020 07:53:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DkLuehbbp+kOounCi8K1NJ3oFhcDP1LZgyh68T6pMWnoXmb06AZkDXNS+x/Tvj0FMQManyfbnH1ePKZejD6Fyhew5t4uR0QZQnnenUSOXpZpI7a7S7X+R2iTQMVfud/qMPFG4to/p9Q3itEib+WYXAjVvG5af3BzHZ2g/gVAUDHJc63w/0KrnrLLuL7DeULsUIrzG27jOXFQmva0n+/nY+0A19WfZ2EotVxkhR04yKa4DhFTqlnws2Lfu02SEjy2fRBH+jqRWE/WX1CnE4rIeoRCnznz2GlzFrVoT8gNm2Gl0aYjMdQHKGOt1LjrTDhnpM2x6EwmuaaP/XIf+EaRMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPkSK86JAufsatHmG+uaTatjWbVnSyvqW92eAHueuCo=;
 b=L1Uni2tT8AIgVZlEM91N5GY3BfwC8NPOwPhFxWNyEoDDQhEs7d8HTq27N4i59XBCg1MwsaFaTQTERjSDCXOITbL4DT2fSwlwqADWsa9SrMFoDd/mid2hURSxmFmE12EZZNehPlKtcojRA7cQLC2AjlZ0pt9PJsNQxQrnBloZjFBXkUyAufqmjvWiJYbKaZXPTXQRml7ux961BMsAkcIKTsMLkSocTvcs7W57N7NKKcfDkweh21BAfJMbLimgs2HUDMTJZPLRZQWHUrhepnttrhdeJNJH6V5ugZ4mH9zoArFOhd+Hpx3uD76YmOo18rrsDatpfFc55Z+VkpWBvZZHxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPkSK86JAufsatHmG+uaTatjWbVnSyvqW92eAHueuCo=;
 b=nV0+Ig1na28rSyESAe1qnH7ACpj5JpTZbPsDBG8k93L9DGk9+dXyKUUPf08dNEp6PZgcqJl4B/WiPHt/F4Zq1FuyoH9prqj9XO7xka68xdHV69mIsrmE+D9Od13xKWXNFdBrQ5yq5z0VE86JagLy6r8OykOoW+/BkzkPWtoWkmk=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2387.namprd12.prod.outlook.com (2603:10b6:207:44::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.28; Thu, 9 Jul
 2020 11:53:22 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3174.021; Thu, 9 Jul 2020
 11:53:22 +0000
Subject: Re: [PATCH 03/25] dma-buf.rst: Document why idenfinite fences are a
 bad idea
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-rdma@vger.kernel.org, Jesse Natalie <jenatali@microsoft.com>,
        Steve Pronovost <spronovo@microsoft.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        amd-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
 <20200707201229.472834-4-daniel.vetter@ffwll.ch>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <aede585d-6c3f-4559-c612-e8cb8a9e1f92@amd.com>
Date:   Thu, 9 Jul 2020 13:53:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200707201229.472834-4-daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR04CA0102.eurprd04.prod.outlook.com
 (2603:10a6:208:be::43) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR04CA0102.eurprd04.prod.outlook.com (2603:10a6:208:be::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend Transport; Thu, 9 Jul 2020 11:53:19 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9c230902-17c4-4045-247f-08d823fead98
X-MS-TrafficTypeDiagnostic: BL0PR12MB2387:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2387040353D05C2DF4F719D683640@BL0PR12MB2387.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 04599F3534
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XUwibyXEEy+6B4QprJPz7Kt8u7Y5fP+hRsw4VST4Hoygqk/95Rzb9g64mNIRSMRZdE9ovhHKE1bJ9EvJiASNAMW6fp6njjtrOQJomd5+M6HspV6AylWdxgt15urlcz4QxmsyOChuaI8OSeFNVYtojQLNtmOWd7g87UtDdzMKodZzAw4KLnEwS4Oj8nSgPaw6kHqEbr03D7G7fJ4rBlmOrwWkdl5VgTuJfW1EHJrNh7lOm9W6rvjxdo876Ym69gKF0rl3iITRPHQWXANuUk+ZHNKnDDzVtC1olHPEgVF3VfgDDLGhSH+j9Bp/LiXKb5bGh+jJLJCiGmfazHJ7zbBrqWol2I55CVUcEAcfKyxY8fMdy1YyTBA9giETyifhBGT/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(396003)(136003)(39860400002)(376002)(66574015)(45080400002)(36756003)(4326008)(2906002)(52116002)(186003)(54906003)(83380400001)(478600001)(31696002)(16526019)(6486002)(66946007)(8676002)(8936002)(66476007)(66556008)(2616005)(31686004)(6666004)(110136005)(5660300002)(7416002)(86362001)(316002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: IghPvu9u4v9x8w37eAIEtKB5ifUnsddPGtqUsMXnr3bzf4oxoXnalSUt8Ygf6lABDO+8eheXniNAptrOPOwOFWRJexz8yOqCF4FBOH6xaE1poa0YM6FB2AOJArTy8/IRodOtkiL+GrH0bLOq/M4ZieiPIF0kZtcDW76eY6RSyUzhOVLYRuFFKA3ACrwk2PUYJzLOb/z9kjZYwxQcxasfhkflYSsXRn20PCzQSeBXtE7oFD1nTkiL//TQpC/qk5NE9SylUQaxaWrR99whjjAMXMV1Gr4kfYgmJN4dUbGOdHVcjTWgnBINLW9r+Z+6aDkgeffHyOrx6Y/+UfHnCmIRPITZMxlW1x8D+mwY4AtgE/B6cvXeq++xZPRJvTpb2TWMSguuzAqbbW2nP7mUB6xfdqhM7x7dH/07WtgU75ejEMXSpnYxfqBmHvLhars04vgjLiuQKdEVjhPxgy7dI5z8o5JFFXVk1sJYcK80RnStM0ZnOufPaMRCTtYP6lD58BQXzDoNLmI8U04p63ybnkJE9PsHVt7pPe4w9TbSiYXhH4JpFZntp4dCABWyh3PvCqjc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c230902-17c4-4045-247f-08d823fead98
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2020 11:53:21.9266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fxQ6abcQfLtpyvB0eIMOuJJ36ma04Keq55wjn/N6CLrhyu2vuqryu2czf1Wl0QNG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2387
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Am 07.07.20 um 22:12 schrieb Daniel Vetter:
> Comes up every few years, gets somewhat tedious to discuss, let's
> write this down once and for all.
>
> What I'm not sure about is whether the text should be more explicit in
> flat out mandating the amdkfd eviction fences for long running compute
> workloads or workloads where userspace fencing is allowed.
>
> v2: Now with dot graph!
>
> Cc: Jesse Natalie <jenatali@microsoft.com>
> Cc: Steve Pronovost <spronovo@microsoft.com>
> Cc: Jason Ekstrand <jason@jlekstrand.net>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Mika Kuoppala <mika.kuoppala@intel.com>
> Cc: Thomas Hellstrom <thomas.hellstrom@intel.com>
> Cc: linux-media@vger.kernel.org
> Cc: linaro-mm-sig@lists.linaro.org
> Cc: linux-rdma@vger.kernel.org
> Cc: amd-gfx@lists.freedesktop.org
> Cc: intel-gfx@lists.freedesktop.org
> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   Documentation/driver-api/dma-buf.rst     | 70 ++++++++++++++++++++++++
>   drivers/gpu/drm/virtio/virtgpu_display.c | 20 -------
>   2 files changed, 70 insertions(+), 20 deletions(-)
>
> diff --git a/Documentation/driver-api/dma-buf.rst b/Documentation/driver-api/dma-buf.rst
> index f8f6decde359..037ba0078bb4 100644
> --- a/Documentation/driver-api/dma-buf.rst
> +++ b/Documentation/driver-api/dma-buf.rst
> @@ -178,3 +178,73 @@ DMA Fence uABI/Sync File
>   .. kernel-doc:: include/linux/sync_file.h
>      :internal:
>   
> +Idefinite DMA Fences
> +~~~~~~~~~~~~~~~~~~~~
> +
> +At various times &dma_fence with an indefinite time until dma_fence_wait()
> +finishes have been proposed. Examples include:
> +
> +* Future fences, used in HWC1 to signal when a buffer isn't used by the display
> +  any longer, and created with the screen update that makes the buffer visible.
> +  The time this fence completes is entirely under userspace's control.
> +
> +* Proxy fences, proposed to handle &drm_syncobj for which the fence has not yet
> +  been set. Used to asynchronously delay command submission.
> +
> +* Userspace fences or gpu futexes, fine-grained locking within a command buffer
> +  that userspace uses for synchronization across engines or with the CPU, which
> +  are then imported as a DMA fence for integration into existing winsys
> +  protocols.
> +
> +* Long-running compute command buffers, while still using traditional end of
> +  batch DMA fences for memory management instead of context preemption DMA
> +  fences which get reattached when the compute job is rescheduled.
> +
> +Common to all these schemes is that userspace controls the dependencies of these
> +fences and controls when they fire. Mixing indefinite fences with normal
> +in-kernel DMA fences does not work, even when a fallback timeout is included to
> +protect against malicious userspace:
> +
> +* Only the kernel knows about all DMA fence dependencies, userspace is not aware
> +  of dependencies injected due to memory management or scheduler decisions.
> +
> +* Only userspace knows about all dependencies in indefinite fences and when
> +  exactly they will complete, the kernel has no visibility.
> +
> +Furthermore the kernel has to be able to hold up userspace command submission
> +for memory management needs, which means we must support indefinite fences being
> +dependent upon DMA fences. If the kernel also support indefinite fences in the
> +kernel like a DMA fence, like any of the above proposal would, there is the
> +potential for deadlocks.
> +
> +.. kernel-render:: DOT
> +   :alt: Indefinite Fencing Dependency Cycle
> +   :caption: Indefinite Fencing Dependency Cycle
> +
> +   digraph "Fencing Cycle" {
> +      node [shape=box bgcolor=grey style=filled]
> +      kernel [label="Kernel DMA Fences"]
> +      userspace [label="userspace controlled fences"]
> +      kernel -> userspace [label="memory management"]
> +      userspace -> kernel [label="Future fence, fence proxy, ..."]
> +
> +      { rank=same; kernel userspace }
> +   }
> +
> +This means that the kernel might accidentally create deadlocks
> +through memory management dependencies which userspace is unaware of, which
> +randomly hangs workloads until the timeout kicks in. Workloads, which from
> +userspace's perspective, do not contain a deadlock.  In such a mixed fencing
> +architecture there is no single entity with knowledge of all dependencies.
> +Thefore preventing such deadlocks from within the kernel is not possible.
> +
> +The only solution to avoid dependencies loops is by not allowing indefinite
> +fences in the kernel. This means:
> +
> +* No future fences, proxy fences or userspace fences imported as DMA fences,
> +  with or without a timeout.
> +
> +* No DMA fences that signal end of batchbuffer for command submission where
> +  userspace is allowed to use userspace fencing or long running compute
> +  workloads. This also means no implicit fencing for shared buffers in these
> +  cases.
> diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
> index f3ce49c5a34c..af55b334be2f 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_display.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_display.c
> @@ -314,25 +314,6 @@ virtio_gpu_user_framebuffer_create(struct drm_device *dev,
>   	return &virtio_gpu_fb->base;
>   }
>   
> -static void vgdev_atomic_commit_tail(struct drm_atomic_state *state)
> -{
> -	struct drm_device *dev = state->dev;
> -
> -	drm_atomic_helper_commit_modeset_disables(dev, state);
> -	drm_atomic_helper_commit_modeset_enables(dev, state);
> -	drm_atomic_helper_commit_planes(dev, state, 0);
> -
> -	drm_atomic_helper_fake_vblank(state);
> -	drm_atomic_helper_commit_hw_done(state);
> -
> -	drm_atomic_helper_wait_for_vblanks(dev, state);
> -	drm_atomic_helper_cleanup_planes(dev, state);
> -}
> -
> -static const struct drm_mode_config_helper_funcs virtio_mode_config_helpers = {
> -	.atomic_commit_tail = vgdev_atomic_commit_tail,
> -};
> -
>   static const struct drm_mode_config_funcs virtio_gpu_mode_funcs = {
>   	.fb_create = virtio_gpu_user_framebuffer_create,
>   	.atomic_check = drm_atomic_helper_check,
> @@ -346,7 +327,6 @@ void virtio_gpu_modeset_init(struct virtio_gpu_device *vgdev)
>   	drm_mode_config_init(vgdev->ddev);
>   	vgdev->ddev->mode_config.quirk_addfb_prefer_host_byte_order = true;
>   	vgdev->ddev->mode_config.funcs = &virtio_gpu_mode_funcs;
> -	vgdev->ddev->mode_config.helper_private = &virtio_mode_config_helpers;
>   
>   	/* modes will be validated against the framebuffer size */
>   	vgdev->ddev->mode_config.min_width = XRES_MIN;

