Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3AB1177B86
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Mar 2020 17:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbgCCQEN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Mar 2020 11:04:13 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36364 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729898AbgCCQEN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Mar 2020 11:04:13 -0500
Received: by mail-pg1-f195.google.com with SMTP id d9so1743172pgu.3;
        Tue, 03 Mar 2020 08:04:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=euo4YPxmByto1gTLSe2jceYFkERa+IMhPO4TSr6zMf0=;
        b=Fx+SfjlhIG3XSy0gQC1k/+n2C02H+o65Pgd2b2h0auafJm2+uNjpucPmB6NHNQEePn
         4YI2KMC4AcDcSVGCrwIZMnNDFWwFAdEzOoa5t8prPO2cqqP4mXNqITvERXqyDnubrPnE
         9A06Vt7hCtFJBtH913HmtZJ/N41Y7UDfjgOy2y1zaXlNDXOQc5wdeIriS/qo7d/kjJ9U
         18bZ/qu2HvVfSrHG7zQt0TOO4X0HV+XaggHJBY4WUhY7z6qF62aHnNdaV6IrvmfYeC55
         /rv0fB+UJfgXIX92cMYUSZyDDxmdArW10v0VRfCCRFTqMhUdHZMkLtwFpALbhbANOvd4
         KHxg==
X-Gm-Message-State: ANhLgQ1UWIeHg5yYYS3lZzELZhtXPMEdGkPy/oHuOTEqpPaO6jDcL7Rb
        luIBFORvW+B2B+xIXPao8wUR5/zK
X-Google-Smtp-Source: ADFU+vugYbAlUlHPJ53/WNaszsOX40G6x58wUWQfs8wwQQTmhis4kfLCRsxRDgyATM3ef/oAdljKRg==
X-Received: by 2002:a05:6a00:2b7:: with SMTP id q23mr4711260pfs.43.1583251451713;
        Tue, 03 Mar 2020 08:04:11 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id u41sm25595487pgn.8.2020.03.03.08.04.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 08:04:10 -0800 (PST)
Subject: Re: [PATCH v9 06/25] RDMA/rtrs: client: main functionality
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com
References: <20200221104721.350-1-jinpuwang@gmail.com>
 <20200221104721.350-7-jinpuwang@gmail.com>
 <c3c8fbcc-0028-9b23-8eff-3b5f1f60e652@acm.org>
 <CAHg0HuxJgjQca3Vy7nbcVKs0bUoj=-Uqoa5DOzYoqRHQ6Vph7A@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <597777e7-ac5a-5fc4-c1f7-3ffa5876a6f2@acm.org>
Date:   Tue, 3 Mar 2020 08:04:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAHg0HuxJgjQca3Vy7nbcVKs0bUoj=-Uqoa5DOzYoqRHQ6Vph7A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/2/20 5:20 AM, Danil Kipnis wrote:
> On Sun, Mar 1, 2020 at 2:33 AM Bart Van Assche <bvanassche@acm.org> wrote:
>> On 2020-02-21 02:47, Jack Wang wrote:
>>> +static struct rtrs_permit *
>>> +__rtrs_get_permit(struct rtrs_clt *clt, enum rtrs_clt_con_type con_type)
>>> +{
>>> +     size_t max_depth = clt->queue_depth;
>>> +     struct rtrs_permit *permit;
>>> +     int cpu, bit;
>>> +
>>> +     /* Combined with cq_vector, we pin the IO to the the cpu it comes */
>>
>> This comment is confusing. Please clarify this comment. All I see below
>> is that preemption is disabled. I don't see pinning of I/O to the CPU of
>> the caller.
> The comment is addressing a use-case of the driver: The user can
> assign (under /proc/irq/) the irqs of the HCA cq_vectors "one-to-one"
> to each cpu. This will "force" the driver to process io response on
> the same cpu the io has been submitted on.
> In the code below only preemption is disabled. This can lead to the
> situation that callers from different cpus will grab the same bit,
> since find_first_zero_bit is not atomic. But then the
> test_and_set_bit_lock will fail for all the callers but one, so that
> they will loop again. This way an explicit spinlock is not required.
> Will extend the comment.

If the purpose of get_cpu() and put_cpu() calls is to serialize code 
against other threads, please use locking instead of disabling 
preemption. This will help tools that verify locking like lockdep and 
the kernel thread sanitizer (https://github.com/google/ktsan/wiki).

>>> +static int rtrs_post_send_rdma(struct rtrs_clt_con *con,
>>> +                             struct rtrs_clt_io_req *req,
>>> +                             struct rtrs_rbuf *rbuf, u32 off,
>>> +                             u32 imm, struct ib_send_wr *wr)
>>> +{
>>> +     struct rtrs_clt_sess *sess = to_clt_sess(con->c.sess);
>>> +     enum ib_send_flags flags;
>>> +     struct ib_sge sge;
>>> +
>>> +     if (unlikely(!req->sg_size)) {
>>> +             rtrs_wrn(con->c.sess,
>>> +                      "Doing RDMA Write failed, no data supplied\n");
>>> +             return -EINVAL;
>>> +     }
>>> +
>>> +     /* user data and user message in the first list element */
>>> +     sge.addr   = req->iu->dma_addr;
>>> +     sge.length = req->sg_size;
>>> +     sge.lkey   = sess->s.dev->ib_pd->local_dma_lkey;
>>> +
>>> +     /*
>>> +      * From time to time we have to post signalled sends,
>>> +      * or send queue will fill up and only QP reset can help.
>>> +      */
>>> +     flags = atomic_inc_return(&con->io_cnt) % sess->queue_depth ?
>>> +                     0 : IB_SEND_SIGNALED;
>>> +
>>> +     ib_dma_sync_single_for_device(sess->s.dev->ib_dev, req->iu->dma_addr,
>>> +                                   req->sg_size, DMA_TO_DEVICE);
>>> +
>>> +     return rtrs_iu_post_rdma_write_imm(&con->c, req->iu, &sge, 1,
>>> +                                         rbuf->rkey, rbuf->addr + off,
>>> +                                         imm, flags, wr);
>>> +}
>>
>> I don't think that posting a signalled send from time to time is
>> sufficient to prevent send queue overflow. Please address Jason's
>> comment from January 7th: "Not quite. If the SQ depth is 16 and you post
>> 16 things and then signal the last one, you *cannot* post new work until
>> you see the completion. More SQ space *ONLY* becomes available upon
>> receipt of a completion. This is why you can't have an unsignaled SQ."
> 
>> See also https://lore.kernel.org/linux-rdma/20200107182528.GB26174@ziepe.ca/
> In our case we set the send queue of each QP belonging to one
> "session" to the one supported by the hardware (max_qp_wr) which is
> around 5K on our hardware. The queue depth of our "session" is 512.
> Those 512 are "shared" by all the QPs (number of CPUs on client side)
> belonging to that session. So we have at most 512 and 512/num_cpus on
> average inflights on each QP. We never experienced send queue full
> event in any of our performance tests or production usage. The
> alternative would be to count submitted requests and completed
> requests, check the difference before submission and wait if the
> difference multiplied by the queue depth of "session" exceeds the max
> supported by the hardware. The check will require quite some code and
> will most probably affect performance. I do not think it is worth it
> to introduce a code path which is triggered only on a condition which
> is known to never become true.
> Jason, do you think it's necessary to implement such tracking?

Please either make sure that send queues do not overflow by providing 
enough space for 512 in-flight requests fit or implement tracking for 
the number of in-flight requests.

Thanks,

Bart.

