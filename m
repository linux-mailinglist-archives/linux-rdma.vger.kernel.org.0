Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC4B61582CC
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2020 19:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbgBJSjq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Feb 2020 13:39:46 -0500
Received: from ale.deltatee.com ([207.54.116.67]:43758 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726816AbgBJSjq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Feb 2020 13:39:46 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1j1Dxz-0007VY-PE; Mon, 10 Feb 2020 11:39:33 -0700
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Stephen Bates <sbates@raithlin.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ira Weiny <iweiny@intel.com>, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Don Dutile <ddutile@redhat.com>
References: <20200207182457.GM23346@mellanox.com>
 <20e3149e-4240-13e7-d16e-3975cfbe4d38@amd.com>
 <20200208135405.GO23346@mellanox.com>
 <7a2792b1-3d9f-c921-28ac-8c2475684869@amd.com>
 <20200208174335.GL25297@ziepe.ca>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d43fb3e9-0cda-4a73-849d-813b62169a4c@deltatee.com>
Date:   Mon, 10 Feb 2020 11:39:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200208174335.GL25297@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: ddutile@redhat.com, dan.j.williams@intel.com, rcampbell@nvidia.com, jhubbard@nvidia.com, hch@lst.de, iweiny@intel.com, jglisse@redhat.com, sbates@raithlin.com, daniel.vetter@ffwll.ch, linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, lsf-pc@lists.linux-foundation.org, christian.koenig@amd.com, jgg@ziepe.ca
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [LSF/MM TOPIC] get_user_pages() for PCI BAR Memory
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2020-02-08 10:43 a.m., Jason Gunthorpe wrote:
> On Sat, Feb 08, 2020 at 05:38:51PM +0100, Christian König wrote:
>> Am 08.02.20 um 14:54 schrieb Jason Gunthorpe:
>>> On Sat, Feb 08, 2020 at 02:10:59PM +0100, Christian König wrote:
>>>>> For patch sets, we've seen a number of attempts so far, but little has
>>>>> been merged yet. Common elements of past discussions have been:
>>>>>    - Building struct page for BAR memory
>>>>>    - Stuffing BAR memory into scatter/gather lists, bios and skbs
>>>>>    - DMA mapping BAR memory
>>>>>    - Referencing BAR memory without a struct page
>>>>>    - Managing lifetime of BAR memory across multiple drivers
>>>> I can only repeat Jérôme that this most likely will never work correctly
>>>> with get_user_pages().
>>> I suppose I'm using 'get_user_pages()' as something of a placeholder
>>> here to refer to the existing family of kernel DMA consumers that call
>>> get_user_pages to work on VMA backed process visible memory.
>>>
>>> We have to have something like get_user_pages() because the kernel
>>> call-sites are fundamentally only dealing with userspace VA. That is
>>> how their uAPIs are designed, and we want to keep them working.
>>>
>>> So, if something doesn't fit into get_user_pages(), ie because it
>>> doesn't have a VMA in the first place, then that is some other
>>> discussion. DMA buf seems like a pretty good answer.
>>
>> Well we do have a VMA, but I strongly think that get_user_pages() is the
>> wrong approach for the job.
>>
>> What we should do instead is to grab the VMA for the addresses and then say
>> through the vm_operations_struct: "Hello I'm driver X and want to do P2P
>> with you. Who are you? What are your capabilities? Should we use PCIe or
>> shortcut through some other interconnect? etc etc ect...".
> 
> This is a very topical discussion. So far all the non-struct page
> approaches have fallen down in some way or another.
> 
> The big problem with a VMA centric scheme is that the VMA is ephemeral
> relative to the DMA mapping, so when it comes time to unmap it is not
> so clear what to do to 'put' the reference. There has also been
> resistance to adding new ops to a VMA.
> 
> For instance a 'get dma buf' VMA op would solve the lifetime problems,
> but significantly complicates most of the existing get_user_pages()
> users as they now have to track lists of dma buf pointers so they can
> de-ref the dma bufs that covered the user VA range during 'get'
> 
> FWIW, if the outcome of the discussion was to have some 'get dma buf'
> VMA op that would probably be reasonable. I've talked about this
> before with various people, it isn't quite as good as struct pages,
> but some subsystems like RDMA can probably make it work.
> 
>>>> E.g. you have memory which is not even CPU addressable, but can be shared
>>>> between GPUs using XGMI, NVLink, SLI etc....
>>> For this kind of memory if it is mapped into a VMA with
>>> DEVICE_PRIVATE, as Jerome has imagined, then it would be part of this
>>> discussion.
>>
>> I think what Jerome had in mind with its P2P ideas around HMM was that we
>> could do this with anonymous memory which was migrated to a GPU device. That
>> turned out to be rather complicated because you would need to be able to
>> figure out to which driver you need to talk to for the migrated address,
>> which in turn wasn't related to the VMA in any way.
> 
> Jerome's VMA proposal tied explicitly the lifetime of the VMA to the
> lifetime of the DMA map by forcing the use of 'shared virtual memory'
> (ie mmu notifiers, etc) techniques which have a very narrow usability
> with HW. This is how the lifetime problem was solved in those patches.
> 
> This path has huge drawbacks for everything that is not a GPU use
> case. Ie we can't fit it into virtio to solve it's current P2P DMA
> problem.
> 
>>>> So we need to figure out how express DMA addresses outside of the CPU
>>>> address space first before we can even think about something like extending
>>>> get_user_pages() for P2P in an HMM scenario.
>>> Why?
>>
>> Because that's how get_user_pages() works. IIRC you call it with userspace
>> address+length and get a filled struct pages and VMAs array in return.
>>
>> When you don't have CPU addresses for you memory the whole idea of that
>> interface falls apart. So I think we need to get away from get_user_pages()
>> and work more high level here.
> 
> get_user_pages() is struct page focused, and there is some general
> expectation that GPUs will have to create DEVICE_PRIVATE struct pages
> for their entire hidden memory so that they can do all the HMM tricks
> with anonymous memory. They also have to recongize the DEVICE_PIVATE
> pages during hmm driven page faults.
> 
> Removing the DEVICE_PRIVATE from the anonymous page setup seems
> impossible at the current moment - thus it seems like we are stuck
> with struct pages, may as well use them?
> 
> Literally nobody like this, but all the non-struct-page proposals have
> failed to get traction so far.

Yes, I agree with Jason. We need to be able to make incremental progress
on things that we can do today. We can't be stuck making no progress
because every time something is proposed someone pops up and says it
won't work for some significantly more complicated use case. Supporting
existing P2P DMA functionality in userspace is a use case that people
care about and we shouldn't be that far away from supporting with the
existing struct page infrastructure we have today.

Supporting buses the CPU has no visibility into is a separate discussion
for after we've made more progress on the easier cases. Or, until more
cleanup has gone into making struct page more replaceable with something
else.

Logan
