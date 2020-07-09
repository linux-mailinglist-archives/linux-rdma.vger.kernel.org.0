Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5497D21A21A
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jul 2020 16:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgGIO2m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Jul 2020 10:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgGIO2l (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Jul 2020 10:28:41 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B17C08C5CE;
        Thu,  9 Jul 2020 07:28:41 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b6so2591844wrs.11;
        Thu, 09 Jul 2020 07:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=7tqZDmODxpfwBrZOHP4mWeKzffcGLgXr9vfeGZmKNBU=;
        b=UrpSVLa3i4fx+oUjE8nAxb4rXdCD53H/8bOIv4xQumhe0e7CQ8MSbyobjYuUDN+elj
         5ckDUsYJlUFwMBITNVVhAuDD1ntL6R5si8UkCbrFwBa1o23XClPoW3CKS4dWxyoxcntP
         dJqsDgcKZ7AO7FkD0aTnLTbBnG66j8oAWeBRelevedSmD8Zs032jXTG9snLK4ogose0T
         xszt4fue3yxbEy3JONwHirds5693uN2B9BDJL9fArtc7BMdD97zIbltXJ8ct7rLVTDTB
         mAZaIj2edOMdCqYTfAGZZGyWQ0m80neg9YFUm9WSoDmvWI989Ihja/q5tJJwk4C760/1
         ToVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=7tqZDmODxpfwBrZOHP4mWeKzffcGLgXr9vfeGZmKNBU=;
        b=YDX2afeudN8Im1/PInxF/yp8DldpG8q8RFnKL3z0R/wsXap+xcHsiYjlalATIAV3ef
         f9TSF7V61h8w6DrOiE+htTQcFZ53I/9UvnQG9t6kN3GMV4HBC2/PsCy7ur/w6UhaC2TH
         NF+e1GUyNzY60XcNqE+pTI1hYKaEW/3D5mHqUFdzDIIt3ci1zxR/2G9GV5/Xag2eMKYA
         ME+f/BSPem9dp1ZErgg3btPio7qpsozqUfnvCmd5XvRbdFXhxYLscPPP9ma5Ifliwn9H
         d+8WzA3qhCMYWIG6olw5IuYFXX0cAg/N0CaGeT0wY5JrsbxIGrLaqw437FdkxO9slu4y
         fW3g==
X-Gm-Message-State: AOAM530YCuHFnwqkgYbrBeejGgZ/4cdfZTu59nM6UigoN99M3QL+72kx
        2VH8x7uO22FvnEFq9kTFBSb9t/eV
X-Google-Smtp-Source: ABdhPJyn8DKog/l6kOIY+x27ufbwVcpLzTGrf++rITJqcgOZsb4u39XLOgBaVXLNO9Fzi5QL+9FCzw==
X-Received: by 2002:adf:f14c:: with SMTP id y12mr62667346wro.30.1594304919952;
        Thu, 09 Jul 2020 07:28:39 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id d28sm4735671wrc.50.2020.07.09.07.28.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2020 07:28:39 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [Intel-gfx] [PATCH 03/25] dma-buf.rst: Document why idenfinite
 fences are a bad idea
To:     Daniel Vetter <daniel@ffwll.ch>,
        Daniel Stone <daniel@fooishbar.org>
Cc:     Felix Kuehling <Felix.Kuehling@amd.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Steve Pronovost <spronovo@microsoft.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Jesse Natalie <jenatali@microsoft.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>
References: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
 <20200707201229.472834-4-daniel.vetter@ffwll.ch>
 <CAPj87rO4mm-+sQbP07cgM8-=b6Q8Jbh5G0FsV8rwYx2hnEzPkA@mail.gmail.com>
 <20200709080458.GO3278063@phenom.ffwll.local>
 <CAPj87rPtD04099=sBzL2jKN6NNFNnM-hH3qfOLL10nPoF==VbA@mail.gmail.com>
 <CAKMK7uG6T+86+11CKpRpEY8v6_Xrm=hWv01tzPPLHq_H7p-AuA@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <4f42300f-9733-5536-ef25-95ed8f25bcf8@gmail.com>
Date:   Thu, 9 Jul 2020 16:28:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAKMK7uG6T+86+11CKpRpEY8v6_Xrm=hWv01tzPPLHq_H7p-AuA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Am 09.07.20 um 14:31 schrieb Daniel Vetter:
> On Thu, Jul 9, 2020 at 2:11 PM Daniel Stone <daniel@fooishbar.org> wrote:
>> On Thu, 9 Jul 2020 at 09:05, Daniel Vetter <daniel@ffwll.ch> wrote:
>>> On Thu, Jul 09, 2020 at 08:36:43AM +0100, Daniel Stone wrote:
>>>> On Tue, 7 Jul 2020 at 21:13, Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>>>>> Comes up every few years, gets somewhat tedious to discuss, let's
>>>>> write this down once and for all.
>>>> Thanks for writing this up! I wonder if any of the notes from my reply
>>>> to the previous-version thread would be helpful to more explicitly
>>>> encode the carrot of dma-fence's positive guarantees, rather than just
>>>> the stick of 'don't do this'. ;) Either way, this is:
>>> I think the carrot should go into the intro section for dma-fence, this
>>> section here is very much just the "don't do this" part. The previous
>>> patches have an attempt at encoding this a bit, maybe see whether there's
>>> a place for your reply (or parts of it) to fit?
>> Sounds good to me.
>>
>>>> Acked-by: Daniel Stone <daniels@collabora.com>
>>>>
>>>>> What I'm not sure about is whether the text should be more explicit in
>>>>> flat out mandating the amdkfd eviction fences for long running compute
>>>>> workloads or workloads where userspace fencing is allowed.
>>>> ... or whether we just say that you can never use dma-fence in
>>>> conjunction with userptr.
>>> Uh userptr is entirely different thing. That one is ok. It's userpsace
>>> fences or gpu futexes or future fences or whatever we want to call them.
>>> Or is there some other confusion here?.
>> I mean generating a dma_fence from a batch which will try to page in
>> userptr. Given that userptr could be backed by absolutely anything at
>> all, it doesn't seem smart to allow fences to rely on a pointer to an
>> mmap'ed NFS file. So it seems like batches should be mutually
>> exclusive between arbitrary SVM userptr and generating a dma-fence?
> Locking is Tricky (tm) but essentially what at least amdgpu does is
> pull in the backing storage before we publish any dma-fence. And then
> some serious locking magic to make sure that doesn't race with a core
> mm invalidation event. So for your case here the cs ioctl just blocks
> until the nfs pages are pulled in.

Yeah, we had some iterations until all was settled.

Basic idea is the following:
1. Have a sequence counter increased whenever a change to the page 
tables happens.
2. During CS grab the current value of this counter.
3. Get all the pages you need in an array.
4. Prepare CS, grab the low level lock the MM notifier waits for and 
double check the counter.
5. If the counter is still the same all is well and the DMA-fence pushed 
to the hardware.
6. If the counter has changed repeat.

Can result in a nice live lock when you constantly page things in/out, 
but that is expected behavior.

Christian.

>
> Once we've committed for the dma-fence it's only the other way round,
> i.e. core mm will stall on the dma-fence if it wants to throw out
> these pages again. More or less at least. That way we never have a
> dma-fence depending upon any core mm operations. The only pain here is
> that this severely limits what you can do in the critical path towards
> signalling a dma-fence, because the tldr is "no interacting with core
> mm at all allowed".
>
>> Speaking of entirely different things ... the virtio-gpu bit really
>> doesn't belong in this patch.
> Oops, dunno where I lost that as a sparate patch. Will split out again :-(
> -Daniel
>
>> Cheers,
>> Daniel
>
>

