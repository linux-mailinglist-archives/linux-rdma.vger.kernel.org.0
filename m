Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1E23AC89
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2019 02:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbfFJAQJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 9 Jun 2019 20:16:09 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:5150 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfFJAQJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 9 Jun 2019 20:16:09 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cfda1490000>; Sun, 09 Jun 2019 17:16:09 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 09 Jun 2019 17:16:08 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 09 Jun 2019 17:16:08 -0700
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 10 Jun
 2019 00:16:07 +0000
Subject: Re: [RFC] mm/hmm: pass mmu_notifier_range to
 sync_cpu_device_pagetables
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Christoph Hellwig <hch@infradead.org>
CC:     Ralph Campbell <rcampbell@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20190608001452.7922-1-rcampbell@nvidia.com>
 <20190608091008.GC32185@infradead.org> <20190608114133.GA14873@mellanox.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <2be4987a-eede-c864-c69c-382698641d25@nvidia.com>
Date:   Sun, 9 Jun 2019 17:16:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190608114133.GA14873@mellanox.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560125769; bh=xcBhzlVW6R3gFNBTrQqz4x9pqkklyqjUIKM1o42kpyM=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=E6X87sdu/LBn60CmN02yYjx0e4LyL+XQ/EpyrSmFXI2fQ5Zb+Gh+JZPwwwFyhR9/T
         DR8oJjqqMJ9r+VrKVwUG2o3JczcXZgsbMi07n3RJ7p29qYbn9AWfErKW4mHKk2FRpv
         7+ufnoxySLzKTlkINeZdmFMs9VXRW0J/FG4cJKrSvuAOgP6EdI3FxQrq6Z4C9QnMCw
         zKTDzopKQehlzGuMNc9bmY5FRAUDEloQCDHXi95cyZWmUE2V0UpuPOonrNC/A7AMs4
         gdRNwHonTHKYQRUAtWc6IMPZ4/G46btrcTuhnh6Q5ec1u46swkktkF4Xs0TKPrStrX
         C0pK3ycdPHRrA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/8/19 4:41 AM, Jason Gunthorpe wrote:
> On Sat, Jun 08, 2019 at 02:10:08AM -0700, Christoph Hellwig wrote:
>> On Fri, Jun 07, 2019 at 05:14:52PM -0700, Ralph Campbell wrote:
>>> HMM defines its own struct hmm_update which is passed to the
>>> sync_cpu_device_pagetables() callback function. This is
>>> sufficient when the only action is to invalidate. However,
>>> a device may want to know the reason for the invalidation and
>>> be able to see the new permissions on a range, update device access
>>> rights or range statistics. Since sync_cpu_device_pagetables()
>>> can be called from try_to_unmap(), the mmap_sem may not be held
>>> and find_vma() is not safe to be called.
>>> Pass the struct mmu_notifier_range to sync_cpu_device_pagetables()
>>> to allow the full invalidation information to be used.
>>>
>>> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
>>>
>>> I'm sending this out now since we are updating many of the HMM APIs
>>> and I think it will be useful.
>>
>> This is the right thing to do.  But the really right thing is to just
>> kill the hmm_mirror API entirely and move to mmu_notifiers.  At least
>> for noveau this already is way simpler, although right now it defeats
>> Jasons patch to avoid allocating the struct hmm in the fault path.
>> But as said before that can be avoided by just killing struct hmm,
>> which for many reasons is the right thing to do anyway.
>>
>> I've got a series here, which is a bit broken (epecially the last
>> patch can't work as-is), but should explain where I'm trying to head:
>>
>> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/hmm-mirror-simplification
> 
> At least the current hmm approach does rely on the collision retry
> locking scheme in struct hmm/struct hmm_range for the pagefault side
> to work right.
> 
> So, before we can apply patch one in this series we need to fix
> hmm_vma_fault() and all its varients. Otherwise the driver will be
> broken.
> 
> I'm hoping to first define what this locking should be (see other
> emails to Ralph) then, ideally, see if we can extend mmu notifiers to
> get it directly withouth hmm stuff.
> 
> Then we apply your patch one and the hmm ops wrapper dies.
> 

This all makes sense, and thanks for all this work to simplify and clarify
HMM. It's going to make it a lot easier to work with, when the dust settles.

thanks,
-- 
John Hubbard
NVIDIA
