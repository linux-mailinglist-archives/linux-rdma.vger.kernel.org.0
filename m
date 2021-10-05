Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09260423404
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Oct 2021 01:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236974AbhJEXDS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Oct 2021 19:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237059AbhJEXDM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Oct 2021 19:03:12 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E5DC061793;
        Tue,  5 Oct 2021 16:01:20 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id j11-20020a9d190b000000b00546fac94456so848205ota.6;
        Tue, 05 Oct 2021 16:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0YL6VWajjTGQ1GgtkINChYvgF1AEvaNuFX3QoY8zTxs=;
        b=jwmbRbXRHVHU+kk1NzJqRMosaE3RGbpCbon7EvbvZSfk1N1fm2rpB+1k7RWn+z9+in
         FpeJvYAUrkZptWrlgmxj6dBw2egzSwHTzsNYwJjCt/nmEFom6xV5RbP59GD9Z/BwLS3V
         O4+pCfpoaWMyIOx0/y9DwbOJhNOeUCdwwT0asI2UBRVnSPmc1kEu9l7Z2D1VnSI0R5jj
         C7j7dZ0XGkZU8YezFo22odkvW9nBV0u/C8iCkHawzG4iDAUh4nJ130IwROZ9jqmKMxys
         jDtMZPu5vv4Cd+bd187sBYZta1COMfT9gIFda3UUgj5ZCTgOEHJ+8JMvOM9yyD5qaFVn
         brtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0YL6VWajjTGQ1GgtkINChYvgF1AEvaNuFX3QoY8zTxs=;
        b=cF2/w2zgCoDAH1W362bQWoyMn0JvNsM23GkOUzlMzxEYUZtWym9Cfo0ggtbS104mhb
         PGz+xZhQxo300kK96w+MiTtnlrOOPhyXMcenOh2p2rwdJ1cojn2dEEIAWCK5bvkV6Wio
         4dyc/e+yhr+XvrKBVhZYrC8UeA59zdo8HA8ztfhqcujBGagT0TMK6R4z81dPtwqUkL14
         b2N8GNSQee7+gJo4NhfecyOUEiX4v9q+5mJMp4941MKVmm4VUcgt4L6m3piErzdjR5Y/
         9/yhH7h0LZr7mG2JFFYFBJFnEcY4nkxTxhP3RBWRrZ1JP5MQJc0X7TVfuWPvG3jl4anE
         dVIw==
X-Gm-Message-State: AOAM532yALp4hTNH0AFJzk6aZ8x8zkl1vhlw5xgXacZLBN7rZb77ettc
        kNnLMNr4IUNnP4pQ+dGqYxk=
X-Google-Smtp-Source: ABdhPJxIGOdFpVbucv9WmwxH811ywlzWNVKxf0pA9mFuEeXpbU6Fe/IFqtyr17ygo5niN4VC91IQFQ==
X-Received: by 2002:a9d:6396:: with SMTP id w22mr16385771otk.26.1633474879522;
        Tue, 05 Oct 2021 16:01:19 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:1df4:5ddc:54c4:9e0f? (2603-8081-140c-1a00-1df4-5ddc-54c4-9e0f.res6.spectrum.com. [2603:8081:140c:1a00:1df4:5ddc:54c4:9e0f])
        by smtp.gmail.com with ESMTPSA id u6sm3794283ooh.15.2021.10.05.16.01.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 16:01:18 -0700 (PDT)
Subject: Re: [syzbot] BUG: RESTRACK detected leak of resources
To:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        syzbot <syzbot+3a992c9e4fd9f0e6fd0e@syzkaller.appspotmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
References: <0000000000005a800a05cd849c36@google.com>
 <CACT4Y+ZRrxmLoor53nkD54sA5PJcRjWqheo262tudjrLO2rXzQ@mail.gmail.com>
 <20211004131516.GV3544071@ziepe.ca>
 <CACT4Y+bTB3DCGnem7V2ODpwgmiQdGuJae+h93kfniYn1Pr_x2g@mail.gmail.com>
 <4F4604B1-6EF7-4435-BB12-87664EF852C3@oracle.com>
 <CAD=hENdbCdjPCEnfz0-to81qGGAN4ONkHdrhQEPc1bC+-peYMQ@mail.gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <50f592c2-38e8-19ce-c0d1-c16683bc4eb8@gmail.com>
Date:   Tue, 5 Oct 2021 18:01:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAD=hENdbCdjPCEnfz0-to81qGGAN4ONkHdrhQEPc1bC+-peYMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/5/21 8:11 AM, Zhu Yanjun wrote:
> On Tue, Oct 5, 2021 at 1:56 AM Haakon Bugge <haakon.bugge@oracle.com> wrote:
>>
>>
>>
>>> On 4 Oct 2021, at 15:22, Dmitry Vyukov <dvyukov@google.com> wrote:
>>>
>>> On Mon, 4 Oct 2021 at 15:15, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>>>>
>>>> On Mon, Oct 04, 2021 at 02:42:11PM +0200, Dmitry Vyukov wrote:
>>>>> On Mon, 4 Oct 2021 at 12:45, syzbot
>>>>> <syzbot+3a992c9e4fd9f0e6fd0e@syzkaller.appspotmail.com> wrote:
>>>>>>
>>>>>> Hello,
>>>>>>
>>>>>> syzbot found the following issue on:
>>>>>>
>>>>>> HEAD commit:    c7b4d0e56a1d Add linux-next specific files for 20210930
>>>>>> git tree:       linux-next
>>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=104be6cb300000
>>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=c9a1f6685aeb48bd
>>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=3a992c9e4fd9f0e6fd0e
>>>>>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>>>>>>
>>>>>> Unfortunately, I don't have any reproducer for this issue yet.
>>>>>>
>>>>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>>>>> Reported-by: syzbot+3a992c9e4fd9f0e6fd0e@syzkaller.appspotmail.com
>>>>>
>>>>> +RESTRACK maintainers
>>>>>
>>>>> (it would also be good if RESTRACK would print a more standard oops
>>>>> with stack/filenames, so that testing systems can attribute issues to
>>>>> files/maintainers).
>>>>
>>>> restrack certainly should trigger a WARN_ON to stop the kernel.. But I
>>>> don't know what stack track would be useful here. The culprit is
>>>> always the underlying driver, not the core code..
>>>
>>> There seems to be a significant overlap between
>>> drivers/infiniband/core/restrack.c and drivers/infiniband/sw/rxe/rxe.c
>>> maintainers, so perhaps restrack.c is good enough approximation to
>>> extract relevant people (definitely better then no CC at all :))
>>
>> Looks to me as this is rxe:
>>
>> [ 1892.778632][ T8958] BUG: KASAN: use-after-free in __rxe_drop_index_locked+0xb5/0x100
>> [snip]
>> [ 1892.822375][ T8958] Call Trace:
>> [ 1892.825655][ T8958]  <TASK>
>> [ 1892.828594][ T8958]  dump_stack_lvl+0xcd/0x134
>> [ 1892.833273][ T8958]  print_address_description.constprop.0.cold+0x6c/0x30c
>> [ 1892.840316][ T8958]  ? __rxe_drop_index_locked+0xb5/0x100
>> [ 1892.845864][ T8958]  ? __rxe_drop_index_locked+0xb5/0x100
>> [ 1892.851424][ T8958]  kasan_report.cold+0x83/0xdf
>> [ 1892.856200][ T8958]  ? __rxe_drop_index_locked+0xb5/0x100
>> [ 1892.861761][ T8958]  kasan_check_range+0x13d/0x180
>> [ 1892.866780][ T8958]  __rxe_drop_index_locked+0xb5/0x100
>> [ 1892.872164][ T8958]  __rxe_drop_index+0x3f/0x60
>> [ 1892.876850][ T8958]  rxe_dereg_mr+0x14b/0x240
>> [ 1892.881381][ T8958]  ib_dealloc_pd_user+0x96/0x230
>> [ 1892.886566][ T8958]  rds_ib_dev_free+0xd4/0x3a0
>>
>> So, RDS de-allocs its PD, ib core must first de-register the PD's local MR, calls rxe_dereg_mr(), ...
> 
> int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
> {
>         struct rxe_mr *mr = to_rmr(ibmr);
> 
>         if (atomic_read(&mr->num_mw) > 0) {
>                 pr_warn("%s: Attempt to deregister an MR while bound to MWs\n",
>                         __func__);
>                 return -EINVAL;
>         }
> 
>         mr->state = RXE_MR_STATE_ZOMBIE;
>         rxe_drop_ref(mr_pd(mr));
>         rxe_drop_index(mr);            <-------This is call trace beginning.
>         rxe_drop_ref(mr);
> 
>         return 0;
> }
> 
> struct rxe_mr {
>         struct rxe_pool_entry   pelem; <-----A ref_cnt in this struct.
>         struct ib_mr            ibmr;
> 
>         struct ib_umem          *umem;
> 
> struct rxe_pool_entry {
>         struct rxe_pool         *pool;
>         struct kref             ref_cnt;        <-------This ref_cnt may help.
>         struct list_head        list;
> 
> Zhu Yanjun
> 
>>
>>
>> Thxs, Håkon
>>
>>
>>>
>>>> Anyhow, this report is either rxe or rds by the look of it.
>>>>
>>>> Jason
>>

It looks like not all the objects are getting freed before the CA is deallocated.
If this happens the pool cleanup code issues the warning that the pool is being
cleaned up with some objects still in the pool. It then goes ahead and frees the
index table for indexed objects (like MRs). If the MR is later freed it tries to
remove its index in the index bit map which has already been freed causing the oops.
The MR not getting freed in time is the cause of the late deallocation of the PD
which was noticed by restrak. I am not sure if these late deletions are just the
normal flow of the program or caused by rdma core trying to clean up afterwards.

Normally MRs get a reference taken when they are created and dropped when they are
freed. Additionally references are taken when an lkey or rkey is looked up an turned
into a pointer to the MR object. These are normally dropped when the key goes out
of scope. If an error occurs it may be possible that the key goes out of scope without
dropping the reference to the MR which would cause what we are seeing. In this case
in order for the late deletion of the MR someone would have to call dereg mr a second
time to remove the lost ref count.

It would be helpful to have a test case to trigger this oops.
