Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E2B230356
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jul 2020 08:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgG1G4q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Jul 2020 02:56:46 -0400
Received: from mail-eopbgr760080.outbound.protection.outlook.com ([40.107.76.80]:15905
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726885AbgG1G4q (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 Jul 2020 02:56:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TsfTjbpobIZNIgzGCjY67TyDcapQYEy3yvFlbRBaEndJblUutlCxmGW1xYbefuytAIimB8fvAdD9V6VeLxQJjeZwo1xnW8sfNKTS0Pjl5IDqEUB19pWLmJGj1CcIpEjkeneMA3QCI3H/BVIXTnATg5ZaSW5Ff60T/4x9P+lIHl6yfYJocZ7nUpsfuI8mCWEITjPImPOEFv3YjkUj0G87aLRtn9ySIQ3yfRPn26AS4/+lOd5XsHmTPw2cJxUHtWkQlSZOAuEdL3nIuzXvu3OEvSXlImpgwVnrzirRbi0d/fMsxoKUpNah3Dv56f8JF0vP9hq48xRm081TCFRKOPFzaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkWADiYG8d5BSQMhIF0cqLu5QiFbDd3x67E2ayjtq6s=;
 b=nCj2SEj6sdMV8Er+oA9ABfhAfusicD39u/CgarKzDgMo/fZVU2ah83mnpA0yBzjvi35SXw4wakyrvnYffqBUkQ04t6ZGHFCG0V4eqxVDjZHq/qTRBLrShp6UCDc5oSsgQX/IL7qHSdilhz5ahtuA7i+OLnNdXJ2p0B6fUhvAk4xgYIDZpwTYv7xg8FyNzn+YUwwescZhjn1Ce4OxUzAO3h9T2W/hZLZQ6uS0MSgqO610KBy6DhEGtD1Na4vyIKeLg9GFe0/Hcn+T5DhrfFPtbHWeTQl5LuKPhIOxTIpppRLaPDvoEKFlyGwpWJT2UhCPdzoxFT6pRsWq0f90IFcfPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkWADiYG8d5BSQMhIF0cqLu5QiFbDd3x67E2ayjtq6s=;
 b=wH3w9+R7kgugUpLyhcnIzbGLsGsGGSwnJgeZhI8HN/YsEOcXUNYjLoBiVlo/JvuG802YNx7G/I00m9/X5Sqe9GJQGjY78+7vj+IT/3ZXiDLjvLJD+OM4lzHkSflp3qizCyCLVqFqaDPV9PCZzHNiyeeUhQP/K6a3IkApWW7DJdc=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3838.namprd12.prod.outlook.com (2603:10b6:208:16c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Tue, 28 Jul
 2020 06:56:42 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 06:56:42 +0000
Subject: Re: [PATCH] drm/amdgpu/dc: Stop dma_resv_lock inversion in
 commit_tail
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>
Cc:     linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        linux-rdma@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20200727213017.852589-1-daniel.vetter@ffwll.ch>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <d4e687e9-cf0b-384f-5982-849d0fa11147@amd.com>
Date:   Tue, 28 Jul 2020 08:56:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200727213017.852589-1-daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0018.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::28) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR10CA0018.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22 via Frontend Transport; Tue, 28 Jul 2020 06:56:40 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8222575c-e9db-4375-acc2-08d832c36271
X-MS-TrafficTypeDiagnostic: MN2PR12MB3838:
X-Microsoft-Antispam-PRVS: <MN2PR12MB383874905529E140F43DAFF383730@MN2PR12MB3838.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: etuWxKD+7FSURO5FPlbjT1kJJsu3f/cOqXh4VQVWX3utitJ+Z0vns5gmutSv3X2AFvCEZzZcpEAyZDMU5C+NVZjcM6ubsAUxMHHqXM9VNFt1p+pLix4P4HECw4lbdOkKxBL8vRHzh1t6ds+I7BhCaxIwYavsPbPPZ6kLtN0WnzrlIdVfgh8z8HqpwwLsTzJ4AdDo0n9efblzLJvzdZhmCBz8gYtUnjlZnN0RRLcLTp9z1ra5EpaXu3YvtnldNmSHyh8ZsdB+NUmE6cBsb7MGawlpQ0nszD2AbOIBp5SSNz6ZICIoPlD07iOgUa81Qnaabw/ylVhZ9WD3dLLEXMuthNoIhOJZstJaAPeX5D8nFNCD7b0GJpyEqR0q9VBz/E0HHqNKLZ/1mO1o7rjYdoMJS1CuQLWOzzRnGcMxCxbIoYWcfptK6QsoPE1NeyQ9mlM7Esm4QQOCtZwnZVSiua5xmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(6666004)(186003)(31686004)(16526019)(86362001)(66574015)(66476007)(66946007)(83380400001)(8676002)(478600001)(966005)(4326008)(45080400002)(66556008)(5660300002)(6486002)(8936002)(54906003)(31696002)(36756003)(2616005)(52116002)(7416002)(316002)(2906002)(110136005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: u5WKVduONTremJCVT9sGeouYFPpogtoU823m5Pr+jNMNOM/DUHLQ9Xs4KfB788cHAB4ZROn+8cH4Zhfn6GR0OvWPyNQZxuYqiZC8HeEzZ0mYYKScXdlZZsxHkKxTfUnoFwVVMsC8Bcm7wJMDAAGBlF6MsupbVYIp9+ejS8qD4HcZc6l6yBirriWSMJFvRGigs2OX84b5GboX0t8gQMZGAOEgzv+Bx23xxjIuDthcwxK3tE6mWlhxyCtKC/vZ5VAY0BnbpgcyH14RwxWLM/hnh0RVuNcADQePClpGluoRpLCfKVmr7Bk9BhJJrUaG2+doJmBHCL82314kFjk8GGyRgy+PBiCoiHYBvOorIW66tB8nquT7tkQDx7/lSC9Tisz3/Q0J8Q1IgyB30lIVTmID0GWIXtvdEgxFzr5HfzkcbDMnDsvVbHSKEeVdk+OIDG3hYtav0d1pPD9MY6y7efNPC/iHd7ThqcI64dVd3Y5ucQmrbBXNWGp1F6BljnkBTvRSmo4I38YmncLyBqFt2EyA1Zddxsdg9m//G8a0aZTmaq+KHgsh7oUBxVpQjMLFV8+W
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8222575c-e9db-4375-acc2-08d832c36271
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 06:56:42.5593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lX0potb1U9WL+HICjQxPAO4/1oIBFXhi7+LFJKsAasgFLvZJdlz6aIrNUKnMgu2L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3838
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Am 27.07.20 um 23:30 schrieb Daniel Vetter:
> Trying to grab dma_resv_lock while in commit_tail before we've done
> all the code that leads to the eventual signalling of the vblank event
> (which can be a dma_fence) is deadlock-y. Don't do that.
>
> Here the solution is easy because just grabbing locks to read
> something races anyway. We don't need to bother, READ_ONCE is
> equivalent. And avoids the locking issue.
>
> v2: Also take into account tmz_surface boolean, plus just delete the
> old code.
>
> Cc: linux-media@vger.kernel.org
> Cc: linaro-mm-sig@lists.linaro.org
> Cc: linux-rdma@vger.kernel.org
> Cc: amd-gfx@lists.freedesktop.org
> Cc: intel-gfx@lists.freedesktop.org
> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> ---
> DC-folks, I think this split out patch from my series here
>
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fdri-devel%2F20200707201229.472834-1-daniel.vetter%40ffwll.ch%2F&amp;data=02%7C01%7Cchristian.koenig%40amd.com%7C8a4f5736682a4b5c943e08d832747ab1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637314823145521840&amp;sdata=qd7Nrox62Lr%2FXWbJJFVskg9RYL4%2FoRVCFjR6rUDMA5E%3D&amp;reserved=0
>
> should be ready for review/merging. I fixed it up a bit so that it's not
> just a gross hack :-)
>
> Cheers, Daniel
>
>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 19 ++++++-------------
>   1 file changed, 6 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 21ec64fe5527..a20b62b1f2ef 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -6959,20 +6959,13 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>   			DRM_ERROR("Waiting for fences timed out!");
>   
>   		/*
> -		 * TODO This might fail and hence better not used, wait
> -		 * explicitly on fences instead
> -		 * and in general should be called for
> -		 * blocking commit to as per framework helpers
> +		 * We cannot reserve buffers here, which means the normal flag
> +		 * access functions don't work. Paper over this with READ_ONCE,
> +		 * but maybe the flags are invariant enough that not even that
> +		 * would be needed.
>   		 */
> -		r = amdgpu_bo_reserve(abo, true);
> -		if (unlikely(r != 0))
> -			DRM_ERROR("failed to reserve buffer before flip\n");
> -
> -		amdgpu_bo_get_tiling_flags(abo, &tiling_flags);
> -
> -		tmz_surface = amdgpu_bo_encrypted(abo);
> -
> -		amdgpu_bo_unreserve(abo);
> +		tiling_flags = READ_ONCE(abo->tiling_flags);
> +		tmz_surface = READ_ONCE(abo->flags) & AMDGPU_GEM_CREATE_ENCRYPTED;

Yeah, the abo->flags are mostly fixed after creation, especially the 
encrypted flag can't change or we corrupt page table tables. So that 
should work fine.

Anybody who picks this up feel free to add an Reviewed-by: Christian 
König <christian.koenig@amd.com>.

Regards,
Christian.

>   
>   		fill_dc_plane_info_and_addr(
>   			dm->adev, new_plane_state, tiling_flags,

