Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3EF3B3F32
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2019 18:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731624AbfIPQq0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Sep 2019 12:46:26 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33082 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbfIPQq0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Sep 2019 12:46:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id n190so338598pgn.0;
        Mon, 16 Sep 2019 09:46:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wEkeJ052ZX1ngLqI2odICGwwwz3h/3/oT5mtOI36tmM=;
        b=qPHwROhyHtgXkylFnO96XRstqPHM5aZLdIaBGeBwaaExn5DT1HWrFkQ7X6LEfvu1qM
         6Sssd12NaluA2uF/NxPdkGqHHOoj6stNLmombq61lr1040uvS6yXJa9dCRH+gmEWJA/h
         DlmrU79+TO1Nr6Tv7h4CNbEdutJX4d7mqSenKmdmtzAC+0TqjK6YpLytJjVVd7gYBX81
         cyqhVL/2Sn4OJL0UjMST5NbgizJPpDZeHn8yPAywQd9wTFsIfYuGVCayLYQ6ppTdrpue
         cDPZBUz8i5CPzgPxDmw/qtAj3lTcfhbHRJeLk/AAsAaJwV87WUVjBx/oawMKTWf/e6bx
         Hi8Q==
X-Gm-Message-State: APjAAAV18dpxvqsN5i2NDloHPoMgO97KtKFdqcodKJH3RpePb9BitOno
        uUIg5iDPJxpmC19hQ4nLJxY=
X-Google-Smtp-Source: APXvYqyy9sPBI2EU1kaxLg8ZrmSHsRE1OtaiYTIlBwjlTuHc11KgivHlm/nWhIF8aYg7uS5YZHy5Gg==
X-Received: by 2002:a17:90a:9f0b:: with SMTP id n11mr156821pjp.102.1568652384943;
        Mon, 16 Sep 2019 09:46:24 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id f128sm56403828pfg.143.2019.09.16.09.46.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2019 09:46:23 -0700 (PDT)
Subject: Re: [PATCH v4 17/25] ibnbd: client: main functionality
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, rpenyaev@suse.de,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Roman Pen <r.peniaev@gmail.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <20190620150337.7847-18-jinpuwang@gmail.com>
 <bd8963e2-d186-dbd0-fe39-7f4a518f4177@acm.org>
 <CAHg0HuwzHnzPQAqjtYFTZb7BhzFagJ0NJ=pW=VkTqn5HML-0Vw@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <5c5ff7df-2cce-ec26-7893-55911e4d8595@acm.org>
Date:   Mon, 16 Sep 2019 09:46:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHg0HuwzHnzPQAqjtYFTZb7BhzFagJ0NJ=pW=VkTqn5HML-0Vw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/16/19 7:17 AM, Danil Kipnis wrote:
> On Sat, Sep 14, 2019 at 1:46 AM Bart Van Assche <bvanassche@acm.org> wrote:
>> On 6/20/19 8:03 AM, Jack Wang wrote:
>>> +/*
>>> + * This is for closing devices when unloading the module:
>>> + * we might be closing a lot (>256) of devices in parallel
>>> + * and it is better not to use the system_wq.
>>> + */
>>> +static struct workqueue_struct *unload_wq;
>>
>> I think that a better motivation is needed for the introduction of a new
>> workqueue.
 >
> We didn't want to pollute the system workqueue when unmapping a big
> number of devices at once in parallel. Will reiterate on it.

There are multiple system workqueues. From <linux/workqueue.h>:

extern struct workqueue_struct *system_wq;
extern struct workqueue_struct *system_highpri_wq;
extern struct workqueue_struct *system_long_wq;
extern struct workqueue_struct *system_unbound_wq;
extern struct workqueue_struct *system_freezable_wq;
extern struct workqueue_struct *system_power_efficient_wq;
extern struct workqueue_struct *system_freezable_power_efficient_wq;

Has it been considered to use e.g. system_long_wq?

>> A more general question is why ibnbd needs its own queue management
>> while no other block driver needs this?
>
> Each IBNBD device promises to have a queue_depth (of say 512) on each
> of its num_cpus hardware queues. In fact we can only process a
> queue_depth inflights at once on the whole ibtrs session connecting a
> given client with a given server. Those 512 inflights (corresponding
> to the number of buffers reserved by the server for this particular
> client) have to be shared among all the devices mapped on this
> session. This leads to the situation, that we receive more requests
> than we can process at the moment. So we need to stop queues and start
> them again later in some fair fashion.

Can a single CPU really sustain a queue depth of 512 commands? Is it 
really necessary to have one hardware queue per CPU or is e.g. four 
queues per NUMA node sufficient? Has it been considered to send the 
number of hardware queues that the initiator wants to use and also the 
command depth per queue during login to the target side? That would 
allow the target side to allocate an independent set of buffers for each 
initiator hardware queue and would allow to remove the queue management 
at the initiator side. This might even yield better performance.

>>> +static void msg_conf(void *priv, int errno)
>>> +{
>>> +     struct ibnbd_iu *iu = (struct ibnbd_iu *)priv;
>>
>> The kernel code I'm familiar with does not cast void pointers explicitly
>> into another type. Please follow that convention and leave the cast out
>> from the above and also from similar statements.
> msg_conf() is a callback which IBNBD passes down with a request to
> IBTRS when calling ibtrs_clt_request(). msg_conf() is called when a
> request is completed with a pointer to a struct defined in IBNBD. So
> IBTRS as transport doesn't know what's inside the private pointer
> which IBNBD passed down with the request, it's opaque, since struct
> ibnbd_iu is not visible in IBTRS. I will try to find how others avoid
> a cast in similar situations.

Are you aware that the C language can cast a void pointer into a 
non-void pointer implicitly, that means, without having to use a cast?


>>> +static void wait_for_ibtrs_disconnection(struct ibnbd_clt_session *sess)
>>> +__releases(&sess_lock)
>>> +__acquires(&sess_lock)
>>> +{
>>> +     DEFINE_WAIT_FUNC(wait, autoremove_wake_function);
>>> +
>>> +     prepare_to_wait(&sess->ibtrs_waitq, &wait, TASK_UNINTERRUPTIBLE);
>>> +     if (IS_ERR_OR_NULL(sess->ibtrs)) {
>>> +             finish_wait(&sess->ibtrs_waitq, &wait);
>>> +             return;
>>> +     }
>>> +     mutex_unlock(&sess_lock);
>>> +     /* After unlock session can be freed, so careful */
>>> +     schedule();
>>> +     mutex_lock(&sess_lock);
>>> +}
>>
>> This doesn't look right: any random wake_up() call can wake up this
>> function. Shouldn't there be a loop in this function that causes the
>> schedule() call to be repeated until the disconnect has happened?
> The loop is inside __find_and_get_sess(), which is calling that
> function. We need to schedule() here in order for another thread to be
> able to remove the dying session we just found and tried to get
> reference to from the list of sessions, so that we can go over the
> list again in __find_and_get_sess().

Thanks for the clarification.

Bart.
