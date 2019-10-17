Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27164DA7D6
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Oct 2019 10:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439287AbfJQIys (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Oct 2019 04:54:48 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51954 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439155AbfJQIys (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Oct 2019 04:54:48 -0400
Received: by mail-wm1-f68.google.com with SMTP id 7so1675996wme.1
        for <linux-rdma@vger.kernel.org>; Thu, 17 Oct 2019 01:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Hmw4OwL9FqHb+jV8hLh1gJHi/QJcPAOSq/jTTk2K2mA=;
        b=NQe40YBxmG96f9TOt2lx2nu5yeOXIxxCZAt2XQ4UJNRC/70WHa4W3XT/bvDilI4+h8
         B0wNL6ov0qQEYZPgvU+KVwDDMAtWgOsYpRb8qbHhiW8s7Il0t4d5ZROl6Plmy2QWvIpe
         5LLee0ctnKCYPjSfOWUzNj3fbs3MjnU5KB/6XfHtXcA0z18t6ZtuuYL6abHh+QYPPFHU
         NMe4BKsJHV7wCBmKf2FuGN7qsm+r93+M0G1Qj3cgpNYdL2Bdny9VlzCdUMmGvTTAG2x1
         4kzSR+iWl7k73rIJNAOKvHu05m/5toXC/u7LCLrWXNmWdKxgwqIwK4JIGwfAmkq9+7ZJ
         N2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=Hmw4OwL9FqHb+jV8hLh1gJHi/QJcPAOSq/jTTk2K2mA=;
        b=FlMFdt7ZEdb6jgfVkNKdBYk/lPMFakJWZS7yGv4lPxm5rkM+oPZrw3yi0hKrsGVD9N
         E8+T7BZ5qzjtVxvXiua1AV8FGYQn05uB2R3lJUzjkNCW7ujaUzJ8Q+ZWSqgmCRIUAV/V
         P6wsJL3GqmyzUA3GRz3sRUfaUN6MMPqicsz+IVV2V0pmdGZuMQhT83Yc5RJAgnyxTczH
         DcSdWvKs/9/4JwJkUAfL60Y1WosOXW3X7RZsqNqbF4HJcuUN4Womstb/OD8LBpRzEPgJ
         AGO2uMFrkGdGPNhoFKEfI2P5QNkDSa3OrzOz5soRKRUuyhip4NN7B5xeNd5VfzBvO275
         0ILw==
X-Gm-Message-State: APjAAAVUSZrkh8NiEe4fLp35UJXMYNZXFREXoxIXejpOHCqBxqyJzlML
        PsGqx+RAhWTsJ1KvU8D/mkLwk3XU
X-Google-Smtp-Source: APXvYqzJi9+RvTSEwHzV3ur+tJTiN0DDJTk5yUlvOyd82uaG+4z5rZr2J2St19DvdGnPXph1nSYjMw==
X-Received: by 2002:a7b:c936:: with SMTP id h22mr1819751wml.1.1571302485776;
        Thu, 17 Oct 2019 01:54:45 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id c132sm1490101wme.27.2019.10.17.01.54.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 01:54:45 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH hmm 00/15] Consolidate the mmu notifier interval_tree and
 locking
To:     Jason Gunthorpe <jgg@mellanox.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Jerome Glisse <jglisse@redhat.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>
References: <20191015181242.8343-1-jgg@ziepe.ca>
 <bc954d29-388b-9e29-f960-115ccc6b9fea@gmail.com>
 <20191016160444.GB3430@mellanox.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <2df298e2-ee91-ef40-5da9-2bc1af3a17be@gmail.com>
Date:   Thu, 17 Oct 2019 10:54:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191016160444.GB3430@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Am 16.10.19 um 18:04 schrieb Jason Gunthorpe:
> On Wed, Oct 16, 2019 at 10:58:02AM +0200, Christian König wrote:
>> Am 15.10.19 um 20:12 schrieb Jason Gunthorpe:
>>> From: Jason Gunthorpe <jgg@mellanox.com>
>>>
>>> 8 of the mmu_notifier using drivers (i915_gem, radeon_mn, umem_odp, hfi1,
>>> scif_dma, vhost, gntdev, hmm) drivers are using a common pattern where
>>> they only use invalidate_range_start/end and immediately check the
>>> invalidating range against some driver data structure to tell if the
>>> driver is interested. Half of them use an interval_tree, the others are
>>> simple linear search lists.
>>>
>>> Of the ones I checked they largely seem to have various kinds of races,
>>> bugs and poor implementation. This is a result of the complexity in how
>>> the notifier interacts with get_user_pages(). It is extremely difficult to
>>> use it correctly.
>>>
>>> Consolidate all of this code together into the core mmu_notifier and
>>> provide a locking scheme similar to hmm_mirror that allows the user to
>>> safely use get_user_pages() and reliably know if the page list still
>>> matches the mm.
>> That sounds really good, but could you outline for a moment how that is
>> archived?
> It uses the same basic scheme as hmm and rdma odp, outlined in the
> revisions to hmm.rst later on.
>
> Basically,
>
>   seq = mmu_range_read_begin(&mrn);
>
>   // This is a speculative region
>   .. get_user_pages()/hmm_range_fault() ..

How do we enforce that this get_user_pages()/hmm_range_fault() doesn't 
see outdated page table information?

In other words how the the following race prevented:

CPU A CPU B
invalidate_range_start()
       mmu_range_read_begin()
       get_user_pages()/hmm_range_fault()
Updating the ptes
invalidate_range_end()


I mean get_user_pages() tries to circumvent this issue by grabbing a 
reference to the pages in question, but that isn't sufficient for the 
SVM use case.

That's the reason why we had this horrible solution with a r/w lock and 
a linked list of BOs in an interval tree.

Regards,
Christian.

>   // Result cannot be derferenced
>
>   take_lock(driver->update);
>   if (mmu_range_read_retry(&mrn, range.notifier_seq) {
>      // collision! The results are not correct
>      goto again
>   }
>
>   // no collision, and now under lock. Now we can de-reference the pages/etc
>   // program HW
>   // Now the invalidate callback is responsible to synchronize against changes
>   unlock(driver->update)
>
> Basically, anything that was using hmm_mirror correctly transisions
> over fairly trivially, just with the modification to store a sequence
> number to close that race described in the hmm commit.
>
> For something like AMD gpu I expect it to transition to use dma_fence
> from the notifier for coherency right before it unlocks driver->update.
>
> Jason
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

