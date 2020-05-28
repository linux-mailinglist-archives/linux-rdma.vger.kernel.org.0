Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 496CA1E6E30
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2020 23:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436806AbgE1VyX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 May 2020 17:54:23 -0400
Received: from mail-eopbgr690058.outbound.protection.outlook.com ([40.107.69.58]:47172
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2436803AbgE1VyU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 28 May 2020 17:54:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ic9LXE2YJj/dPNptIe5JQgKjSBjkEuyC9vnR2rafckWqE/Z4qc2osKCuC8ae1Qw+NDBub9C2xnmgkfcNVRL5ERHXby2LeWmm945BoBzZyt16Ijtx3DgfN6qskevXDaEKegYis9ZYyyiysu/sVDjm8K6/A1DqxE1gbq1qYP6zDkPQo6UD9O07v9nXPTPSHYrcKhAvW2wPY9q0oZBdJ+sic+A9JGnD/W+mGEMeVOMhAAdEW67skhmqdoqU79xRpLEoj73MgKreNn/PJ5LyCj169XRoYkVuN4fDowzzY7B96o7GK6h/8lFAxfMO6cJQNa+djQbtz4/LSpWqYxDgHqaX9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HxYm9HNuLfIdFGomaF43IDxpcnGVvLFjzs5gZHXlM4=;
 b=bEfL3DWjDRY2hRNftnym3uhy2N6QBffAp4qecchULbCcpzXdTmRXruYnV1PFjfpnc5aC6cKySWCPbI45kpVk7VzjphvdXPFnvhAbanNrT7Qe4oz0z6WHYEni53JRZztu34nnyAHuMWZ8JdHs1GezWVBV8ig/qWEKY1NnJJZ7MvbR/GefZvKvQ8UWRp7n2qEE2j0KBoEihHDwiNbB2UEkglBUO8EsBS3LN+ynTY25LT0j7vDzShph0gxWEVD/cJ+22wfG/H51axthLj7Zzjw/HJgXxMAuD0lbqAyJAuflCvAJA8h0HVfHuvGB4ypSslGYLzZVTLamK3ovVOpXWpcTiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HxYm9HNuLfIdFGomaF43IDxpcnGVvLFjzs5gZHXlM4=;
 b=yNQLHCwC1zEIRESzo15kqJv1SeM3X8Ibgq/LUivu1laGvTMT1bNpRDQWjDCgQ4NHr5m+ex93j5P9cs5OcchU0ZP1FIDPI7aV/k1UalQHsLsXKvwp4jveNuZdKYiMY2sVKOY95vBzfijqFyxa6oHl+jJI3sOp3t/YLtyJM+9D9nY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26)
 by DM6PR12MB3707.namprd12.prod.outlook.com (2603:10b6:5:1c1::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Thu, 28 May
 2020 21:54:17 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::cd6e:7536:4dbb:aa85]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::cd6e:7536:4dbb:aa85%5]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 21:54:17 +0000
Subject: Re: [RFC 02/17] dma-fence: basic lockdep annotations
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>
Cc:     linux-rdma@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        linaro-mm-sig@lists.linaro.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        linux-media@vger.kernel.org
References: <20200512085944.222637-1-daniel.vetter@ffwll.ch>
 <20200512085944.222637-3-daniel.vetter@ffwll.ch>
From:   Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <190e5572-fc29-612d-87e0-a4f0151abcc6@amd.com>
Date:   Thu, 28 May 2020 17:54:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <20200512085944.222637-3-daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN6PR07CA0008.namprd07.prod.outlook.com
 (2603:10b6:404:8c::18) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.84.11) by BN6PR07CA0008.namprd07.prod.outlook.com (2603:10b6:404:8c::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.18 via Frontend Transport; Thu, 28 May 2020 21:54:15 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ebf1d0a0-45f9-4de4-1a55-08d80351aadc
X-MS-TrafficTypeDiagnostic: DM6PR12MB3707:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB37078C3B95FD6FB11FF55FFB998E0@DM6PR12MB3707.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CLwp+eL9+RAH7htIUsTk0UZRAh9v1WqJB6qqpt7vjP2AAB2J9T6cyipNMYa9pM3e1K6Jm7L+o2cRpz9qF9qwUZNlLzcFgdM3DYGA+s4hlm84Mq23NCO1LKNoZij8Cw9NTkovbp9H4OB/J6uVpR5lE6ZTZfC4bKAWYaMfaMO+DxBHCgexy1a72ecoSS4y2L++sxkJQGK6JSNAQYCzLJEWBRcJS4YLg1+Eun5URLJdxek1XRnuQi+sMEDnkIMv+RImC7zHt1jMCGhI5UB9xR7RJroIaVUagJmkK5fQHcALz95qs1xgd8zoZk9V7cmkZHKaCmo/p/+xcY8XfbYLIBN+BhJQh32LPuTwgmXHK+SDiIvdXGTgJLel9KMampVPx7eT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(86362001)(186003)(8676002)(36756003)(8936002)(52116002)(66476007)(66946007)(956004)(2616005)(66556008)(44832011)(31686004)(31696002)(316002)(26005)(110136005)(7416002)(53546011)(4326008)(16526019)(6506007)(54906003)(66574014)(478600001)(5660300002)(83380400001)(6512007)(2906002)(6486002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: zzmFnDaYx1GzJ1tm9uwrLPMa+bBfzJb0rKXp8+DsiDfdk60SuWKqX0ZkSJckh7bmCE8QQEB9P3OXN0t9mFmPT2GVyTpMr8Oq5Gq9+d+4nk1F6y6uqXG3j0coLs4uOUHDYA7QIgn+PLGulw6CLMpRi9baFGtfKEhEPmhcah4b/WJS8CZFzhez3u56OFeVQtW+VG660ZoUeOwQ2UgtzyWbfl9ceX2qo8m5NDNd79r2e51s9dZRTbCXgnlKYcJcMXOlCi4ttl9GiztF6TvfE3qy8sadD+w16VG0kilyu8EWc8kY1VH2TjkBrX70ytT/0xBFwAcOcyks6ttlyoHzZBh6/gINqhiuJT0MfIf7dmq5OLvbx7B/o6v/ZNY46tYzWnkr2FEQXLAn5EEzvWz7bTD28mgk6uEhT91Co/i43A3kqoTdTwTsv6trTS6sItJwSJeY4pTfdS9PB+/m/MHhZneEDCDbwgbJvtFn+ePhS3RTu5A=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf1d0a0-45f9-4de4-1a55-08d80351aadc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 21:54:16.9669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xWGT1RUXkSqYh3FHzmLHI4BzIboSA4vlo2wNeeNXs5qTZbj3GC5FhqQTbvl+L4d1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3707
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-05-12 4:59 a.m., Daniel Vetter wrote:
> Design is similar to the lockdep annotations for workers, but with
> some twists:
> 
> - We use a read-lock for the execution/worker/completion side, so that
>   this explicit annotation can be more liberally sprinkled around.
>   With read locks lockdep isn't going to complain if the read-side
>   isn't nested the same way under all circumstances, so ABBA deadlocks
>   are ok. Which they are, since this is an annotation only.
> 
> - We're using non-recursive lockdep read lock mode, since in recursive
>   read lock mode lockdep does not catch read side hazards. And we
>   _very_ much want read side hazards to be caught. For full details of
>   this limitation see
> 
>   commit e91498589746065e3ae95d9a00b068e525eec34f
>   Author: Peter Zijlstra <peterz@infradead.org>
>   Date:   Wed Aug 23 13:13:11 2017 +0200
> 
>       locking/lockdep/selftests: Add mixed read-write ABBA tests
> 
> - To allow nesting of the read-side explicit annotations we explicitly
>   keep track of the nesting. lock_is_held() allows us to do that.
> 
> - The wait-side annotation is a write lock, and entirely done within
>   dma_fence_wait() for everyone by default.
> 
> - To be able to freely annotate helper functions I want to make it ok
>   to call dma_fence_begin/end_signalling from soft/hardirq context.
>   First attempt was using the hardirq locking context for the write
>   side in lockdep, but this forces all normal spinlocks nested within
>   dma_fence_begin/end_signalling to be spinlocks. That bollocks.
> 
>   The approach now is to simple check in_atomic(), and for these cases
>   entirely rely on the might_sleep() check in dma_fence_wait(). That
>   will catch any wrong nesting against spinlocks from soft/hardirq
>   contexts.
> 
> The idea here is that every code path that's critical for eventually
> signalling a dma_fence should be annotated with
> dma_fence_begin/end_signalling. The annotation ideally starts right
> after a dma_fence is published (added to a dma_resv, exposed as a
> sync_file fd, attached to a drm_syncobj fd, or anything else that
> makes the dma_fence visible to other kernel threads), up to and
> including the dma_fence_wait(). Examples are irq handlers, the
> scheduler rt threads, the tail of execbuf (after the corresponding
> fences are visible), any workers that end up signalling dma_fences and
> really anything else. Not annotated should be code paths that only
> complete fences opportunistically as the gpu progresses, like e.g.
> shrinker/eviction code.
> 
> The main class of deadlocks this is supposed to catch are:
> 
> Thread A:
> 
> 	mutex_lock(A);
> 	mutex_unlock(A);
> 
> 	dma_fence_signal();
> 
> Thread B:
> 
> 	mutex_lock(A);
> 	dma_fence_wait();
> 	mutex_unlock(A);
> 
> Thread B is blocked on A signalling the fence, but A never gets around
> to that because it cannot acquire the lock A.
> 
> Note that dma_fence_wait() is allowed to be nested within
> dma_fence_begin/end_signalling sections. To allow this to happen the
> read lock needs to be upgraded to a write lock, which means that any
> other lock is acquired between the dma_fence_begin_signalling() call and
> the call to dma_fence_wait(), and still held, this will result in an
> immediate lockdep complaint. The only other option would be to not
> annotate such calls, defeating the point. Therefore these annotations
> cannot be sprinkled over the code entirely mindless to avoid false
> positives.
> 
> v2: handle soft/hardirq ctx better against write side and dont forget
> EXPORT_SYMBOL, drivers can't use this otherwise.
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
>  drivers/dma-buf/dma-fence.c | 53 +++++++++++++++++++++++++++++++++++++
>  include/linux/dma-fence.h   | 12 +++++++++
>  2 files changed, 65 insertions(+)
> 
> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index 6802125349fb..d5c0fd2efc70 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -110,6 +110,52 @@ u64 dma_fence_context_alloc(unsigned num)
>  }
>  EXPORT_SYMBOL(dma_fence_context_alloc);
>  
> +#ifdef CONFIG_LOCKDEP
> +struct lockdep_map	dma_fence_lockdep_map = {
> +	.name = "dma_fence_map"
> +};
> +
> +bool dma_fence_begin_signalling(void)
> +{
> +	/* explicitly nesting ... */
> +	if (lock_is_held_type(&dma_fence_lockdep_map, 1))
> +		return true;
> +
> +	/* rely on might_sleep check for soft/hardirq locks */
> +	if (in_atomic())
> +		return true;
> +
> +	/* ... and non-recursive readlock */
> +	lock_acquire(&dma_fence_lockdep_map, 0, 0, 1, 1, NULL, _RET_IP_);
> +
> +	return false;
> +}
> +EXPORT_SYMBOL(dma_fence_begin_signalling);

Hi Daniel,

This is great work and could help a lot.

If you invert the result of dma_fence_begin_signalling()
then it would naturally mean "locked", i.e. whether we need to
later release "dma_fence_lockedep_map". Then,
in dma_fence_end_signalling(), you can call the "cookie"
argument "locked" and simply do:

void dma_fence_end_signalling(bool locked)
{
	if (locked)
		lock_release(&dma_fence_lockdep_map, _RET_IP_);
}
EXPORT_SYMBOL(dma_fence_end_signalling);

It'll be more natural to understand as well.

Regards,
Luben

> +
> +void dma_fence_end_signalling(bool cookie)
> +{
> +	if (cookie)
> +		return;
> +
> +	lock_release(&dma_fence_lockdep_map, _RET_IP_);
> +}
> +EXPORT_SYMBOL(dma_fence_end_signalling);
> +
> +void __dma_fence_might_wait(void)
> +{
> +	bool tmp;
> +
> +	tmp = lock_is_held_type(&dma_fence_lockdep_map, 1);
> +	if (tmp)
> +		lock_release(&dma_fence_lockdep_map, _THIS_IP_);
> +	lock_map_acquire(&dma_fence_lockdep_map);
> +	lock_map_release(&dma_fence_lockdep_map);
> +	if (tmp)
> +		lock_acquire(&dma_fence_lockdep_map, 0, 0, 1, 1, NULL, _THIS_IP_);
> +}
> +#endif
> +
> +
>  /**
>   * dma_fence_signal_locked - signal completion of a fence
>   * @fence: the fence to signal
> @@ -170,14 +216,19 @@ int dma_fence_signal(struct dma_fence *fence)
>  {
>  	unsigned long flags;
>  	int ret;
> +	bool tmp;
>  
>  	if (!fence)
>  		return -EINVAL;
>  
> +	tmp = dma_fence_begin_signalling();
> +
>  	spin_lock_irqsave(fence->lock, flags);
>  	ret = dma_fence_signal_locked(fence);
>  	spin_unlock_irqrestore(fence->lock, flags);
>  
> +	dma_fence_end_signalling(tmp);
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL(dma_fence_signal);
> @@ -211,6 +262,8 @@ dma_fence_wait_timeout(struct dma_fence *fence, bool intr, signed long timeout)
>  	if (timeout > 0)
>  		might_sleep();
>  
> +	__dma_fence_might_wait();
> +
>  	trace_dma_fence_wait_start(fence);
>  	if (fence->ops->wait)
>  		ret = fence->ops->wait(fence, intr, timeout);
> diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
> index 3347c54f3a87..3f288f7db2ef 100644
> --- a/include/linux/dma-fence.h
> +++ b/include/linux/dma-fence.h
> @@ -357,6 +357,18 @@ dma_fence_get_rcu_safe(struct dma_fence __rcu **fencep)
>  	} while (1);
>  }
>  
> +#ifdef CONFIG_LOCKDEP
> +bool dma_fence_begin_signalling(void);
> +void dma_fence_end_signalling(bool cookie);
> +#else
> +static inline bool dma_fence_begin_signalling(void)
> +{
> +	return true;
> +}
> +static inline void dma_fence_end_signalling(bool cookie) {}
> +static inline void __dma_fence_might_wait(void) {}
> +#endif
> +
>  int dma_fence_signal(struct dma_fence *fence);
>  int dma_fence_signal_locked(struct dma_fence *fence);
>  signed long dma_fence_default_wait(struct dma_fence *fence,
> 

