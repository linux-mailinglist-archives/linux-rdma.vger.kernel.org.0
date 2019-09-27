Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84525C09AC
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Sep 2019 18:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbfI0Qho (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Sep 2019 12:37:44 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33797 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfI0Qho (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Sep 2019 12:37:44 -0400
Received: by mail-pf1-f196.google.com with SMTP id b128so1919389pfa.1;
        Fri, 27 Sep 2019 09:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rXUZjRv3sHDzWZRDkwglLtup/0FTFNbY7qU5xRDhJ5c=;
        b=ap4wwVeEwq7TqtHzAlPh3CZF+CERfSpKV3xZyOZ3wpl5a076H2K61qzKD7O26UvylM
         QteKCL+CXwvm+m0Ayb8M28ju3hbYYpUNPDMF3gRfnoqN6JcSbjfVKyjCB4X7wSoRtT90
         cIr+76ogDPBWnR6sNcO2AqLlJS+Q4O1jjKJICb6DDAsQlaejW5XBe4KCwPFrJDHaTg3x
         pAt4F5vhfT+aJ+Bc/YxBYSpzVg0WKrzjTXCpIKgDNu82LBNbils+S2ww05J9/s8ofon7
         wmFVDg0G15z6WN9+FzNlrdWPoe74yckXuq+mtJHyg/adtHmnWOoSzr7y3ehJuge6flfn
         oLOw==
X-Gm-Message-State: APjAAAVzw1WWFn+GCjUdUKxA0B9o7QeufKWY5Cxr54lxRCGj6J5HI3aT
        Br6IY1zzYSLMMdA6qVNtzpI=
X-Google-Smtp-Source: APXvYqxLnN/86RHL4Y9EPVBoV6SoixR70FwUVwgHVRklnvVwtmsE5rxAwcrrgqSyHe756UzwH9M7mA==
X-Received: by 2002:aa7:96ab:: with SMTP id g11mr5480651pfk.61.1569602263309;
        Fri, 27 Sep 2019 09:37:43 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id f128sm4641540pfg.143.2019.09.27.09.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2019 09:37:42 -0700 (PDT)
Subject: Re: [PATCH v4 17/25] ibnbd: client: main functionality
To:     Roman Penyaev <r.peniaev@gmail.com>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, rpenyaev@suse.de,
        Jack Wang <jinpu.wang@cloud.ionos.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <20190620150337.7847-18-jinpuwang@gmail.com>
 <bd8963e2-d186-dbd0-fe39-7f4a518f4177@acm.org>
 <CAHg0HuwzHnzPQAqjtYFTZb7BhzFagJ0NJ=pW=VkTqn5HML-0Vw@mail.gmail.com>
 <5c5ff7df-2cce-ec26-7893-55911e4d8595@acm.org>
 <CAHg0HuwFTVsCNHbiXW20P6hQ3c-P_p5tB6dYKtOW=_euWEvLnA@mail.gmail.com>
 <CAHg0HuzQOH4ZCe+v-GHu8jOYm-wUbh1fFRK75Muq+DPpQGAH8A@mail.gmail.com>
 <6f677d56-82b3-a321-f338-cbf8ff4e83eb@acm.org>
 <CAHg0HuxvKZVjROMM7YmYJ0kOU5Y4UeE+a3V==LNkWpLFy8wqtw@mail.gmail.com>
 <CACZ9PQU6bFtnDUYtzbsmNzsNW0j1EkxgUKzUw5N5gr1ArEXZvw@mail.gmail.com>
 <e2056b1d-b428-18c7-8e22-2f37b91917c8@acm.org>
 <CACZ9PQU8=4DaSAUQ7czKdcWio2H5HB1ro-pXaY2VP9PhgTxk7g@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <b31be034-eae0-77f7-aabf-92c8f8a984e5@acm.org>
Date:   Fri, 27 Sep 2019 09:37:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CACZ9PQU8=4DaSAUQ7czKdcWio2H5HB1ro-pXaY2VP9PhgTxk7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/27/19 1:52 AM, Roman Penyaev wrote:
> No, it seems this thingy is a bit different.  According to my
> understanding patches 3 and 4 from this patchset do the
> following: 1# split equally the whole queue depth on number
> of hardware queues and 2# return tag number which is unique
> host-wide (more or less similar to unique_tag, right?).
> 
> 2# is not needed for ibtrs, and 1# can be easy done by dividing
> queue_depth on number of hw queues on tag set allocation, e.g.
> something like the following:
> 
>      ...
>      tags->nr_hw_queues = num_online_cpus();
>      tags->queue_depth  = sess->queue_deph / tags->nr_hw_queues;
> 
>      blk_mq_alloc_tag_set(tags);
> 
> 
> And this trick won't work out for the performance.  ibtrs client
> has a single resource: set of buffer chunks received from a
> server side.  And these buffers should be dynamically distributed
> between IO producers according to the load.  Having a hard split
> of the whole queue depth between hw queues we can forget about a
> dynamic load distribution, here is an example:
> 
>     - say server shares 1024 buffer chunks for a session (do not
>       remember what is the actual number).
> 
>     - 1024 buffers are equally divided between hw queues, let's
>       say 64 (number of cpus), so each queue is 16 requests depth.
> 
>     - only several CPUs produce IO, and instead of occupying the
>       whole "bandwidth" of a session, i.e. 1024 buffer chunks,
>       we limit ourselves to a small queue depth of an each hw
>       queue.
> 
> And performance drops significantly when number of IO producers
> is smaller than number of hw queues (CPUs), and it can be easily
> tested and proved.
> 
> So for this particular ibtrs case tags should be globally shared,
> and seems (unfortunately) there is no any other similar requirements
> for other block devices.

Hi Roman,

I agree that BLK_MQ_F_HOST_TAGS partitions a tag set across hardware 
queues while ibnbd shares a single tag set across multiple hardware 
queues. Since such sharing may be useful for other block drivers, isn't 
that something that should be implemented in the block layer core 
instead of in the ibnbd driver? If that logic would be moved into the 
block layer core, would that allow to reuse the queue restarting logic 
that already exists in the block layer core?

Thanks,

Bart.
