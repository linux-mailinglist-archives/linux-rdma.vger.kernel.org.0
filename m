Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53E8B258EC2
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Sep 2020 14:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgIAM62 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Sep 2020 08:58:28 -0400
Received: from mga11.intel.com ([192.55.52.93]:32279 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbgIAM6Z (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 1 Sep 2020 08:58:25 -0400
IronPort-SDR: pqaaEbBqU9SHpuEC/fckcbaJa/4cEFW9o00SmTJGA+SU9ykw1a6/xPZmBPM6WB2wGduY6q9ZJB
 cC3VVA5QJSRQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="154667439"
X-IronPort-AV: E=Sophos;i="5.76,379,1592895600"; 
   d="scan'208";a="154667439"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 05:58:21 -0700
IronPort-SDR: 4kXPbvOeXRtIxguQVgqQA1Cyw8GWOjZOztTfs9BSgyofckVG+BQ8kb3YqcjvKh6cirFkEcTy6t
 lRNb6VCU+Cbg==
X-IronPort-AV: E=Sophos;i="5.76,379,1592895600"; 
   d="scan'208";a="477189160"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.202.100]) ([10.254.202.100])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 05:58:20 -0700
Subject: Re: buggy-looking mm_struct refcounting in HFI1 infiniband driver
To:     Jason Gunthorpe <jgg@nvidia.com>, Jann Horn <jannh@google.com>
Cc:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Linux-MM <linux-mm@kvack.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Dean Luick <dean.luick@intel.com>
References: <CAG48ez2EFXnDEue=bOs6n01FHGa4rUnwET6hBVNjcKoMjR9Y_Q@mail.gmail.com>
 <20200901002109.GG1152540@nvidia.com>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <624472c4-b585-e950-78b2-eff860f24d64@intel.com>
Date:   Tue, 1 Sep 2020 08:58:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200901002109.GG1152540@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/31/2020 8:21 PM, Jason Gunthorpe wrote:
> On Tue, Sep 01, 2020 at 01:45:06AM +0200, Jann Horn wrote:
> 
>> struct hfi1_filedata has a member ->mm that holds a ->mm_count reference:
>>
>> static int hfi1_file_open(struct inode *inode, struct file *fp)
>> {
>>          struct hfi1_filedata *fd;
>> [...]
>>          fd->mm = current->mm;
>>          mmgrab(fd->mm); // increments ->mm_count
>> [...]
>> }
> 
> Yikes, gross.
>   
>> However, e.g. the call chain hfi1_file_ioctl() -> user_exp_rcv_setup()
>> -> hfi1_user_exp_rcv_setup() -> pin_rcv_pages() ->
>> hfi1_acquire_user_pages() -> pin_user_pages_fast() can end up
>> traversing VMAs without holding any ->mm_users reference, as far as I
>> can tell. That will probably result in kernel memory corruption if
>> that races the wrong way with an exiting task (with the ioctl() call
>> coming from a task whose ->mm is different from fd->mm).
> 
> It looks like this path should be using current and storing the grab'd
> mm in the tidbuf for later use by hfi1_release_user_pages()
> 
> The only other use of file->mm is to setup a notifier, but this is
> also under hfi1_user_exp_rcv_setup() so it should just use tidbuf->mm
> == current anyhow.
> 
> The pq->mm looks similar, looks like the pq should use current->mm,
> and it sets up an old-style notifier, but I didn't check carefully if
> all the call paths are linked back to an ioctl..
> 
> It doesn't make sense that a RDMA driver would do any page pinning
> outside an ioctl, so it should always use current.

I sort of recall a bug where we were trusting current and it wasn't 
correct. I'll have to see if I can dig up the details and figure out 
what's going on here.

>> Disclaimer: I haven't actually tested this - I just stumbled over it
>> while working on some other stuff, and I don't have any infiniband
>> hardware to test with. So it might well be that I just missed an
>> mmget_not_zero() somewhere, or something like that.
> 
> It looks wrong to me too.
> 
> Dennis?

I'll look at it closer and either send a patch or an explanation. Thanks 
for bringing it to our attention Jann!

-Denny

