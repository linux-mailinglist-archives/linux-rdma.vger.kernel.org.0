Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACD9C0501
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Sep 2019 14:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfI0MSJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Sep 2019 08:18:09 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42605 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbfI0MSJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Sep 2019 08:18:09 -0400
Received: by mail-ed1-f65.google.com with SMTP id y91so2116950ede.9
        for <linux-rdma@vger.kernel.org>; Fri, 27 Sep 2019 05:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=FKHeGQHPDqERmEIFxtVPQVkrwntjuPpxcT3RmSIpP3o=;
        b=HdrofhHQzBPK9v8Uo6SaER6UTr3ErMkOtpIMUvNAfRk3TsOnPbuZUuyzDLpriySmte
         SoF9tI5+/jTLLvfjl+U399goUWoufGPSSthoOvnAfh/8OD8i9WBqMC6tZsLN6LSvE5Zk
         9m3+kreK+0+6KaLuL35SO7qZNvzuC0iexA2pE/RHotailaByQjeWaqyVI8OD2J2MYj+1
         rik304UZpq+4QIF74Y4WXzaduvZaZUo5rxadnZY7tWJUYxnyHSvQd7k5ujOLIzXGCWcU
         bJb4nF0aGfEDv+rasjeCEjqiEJ3Rfsef0zm8uhvdWfXKw/5JmM7WoRTMJpfrpsHDOjk9
         8n+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=FKHeGQHPDqERmEIFxtVPQVkrwntjuPpxcT3RmSIpP3o=;
        b=m7u/9CqvsaDZAmi4+Zvjg3jc5VaPhkH+mhAp+kRk9q6gRswZtOqxhKvk2gfMaeDZ2z
         W4Fhh5wj4+81lMjQzuK4RpkF2GqGae7YHH/Vb3fimxeM4C+cIQJB6xRXab3ntDxwqARl
         nWAMpUVLNPDXjYCJG2VvlZNeRjCVfi96Gp7x57ovdLwqHxrLBafPnSgUkxr/C4c3s9V9
         pgIU4u27yk+4cWVim8jeU5Px0B0LMlS195Qkau9uuYTdB2mkttYLxvv0kHYMfP7QtJId
         dOW1hTxpByrfMmpoSsGwj3VNQ0bwkO/GPczcPogbyFN0BxK5cLdbj0ISdJUzMmZG5LM9
         guVQ==
X-Gm-Message-State: APjAAAWs3U601bxGK9bxd8jolkK/8RqLeP3UbAby6+LI0ZuT0M4Duz+t
        pYpQbtoBkTzfdb+YD6Ofw2In
X-Google-Smtp-Source: APXvYqy1JTYW4Su7MKrX0sOFsS3sjuB529ktql8CtIDV3FED1QGblp/9SVcsm2Y+sy5ezO3svyfbFw==
X-Received: by 2002:a50:91b1:: with SMTP id g46mr3998224eda.255.1569586686552;
        Fri, 27 Sep 2019 05:18:06 -0700 (PDT)
Received: from ?IPv6:2a02:247f:ffff:2540:251d:77f4:c17c:46f7? ([2001:1438:4010:2540:251d:77f4:c17c:46f7])
        by smtp.gmail.com with ESMTPSA id i7sm492490edk.42.2019.09.27.05.18.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Sep 2019 05:18:05 -0700 (PDT)
Subject: Re: [PATCH v4 17/25] ibnbd: client: main functionality
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     Roman Penyaev <r.peniaev@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
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
 <CAHg0HuwgPXtaY3XGv0=TjPbmRRdbmOsa7fRYa+n5fGf9K0_xRg@mail.gmail.com>
Message-ID: <b449137d-e986-4d2b-ed0a-0b931d8312e1@cloud.ionos.com>
Date:   Fri, 27 Sep 2019 14:18:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHg0HuwgPXtaY3XGv0=TjPbmRRdbmOsa7fRYa+n5fGf9K0_xRg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 27.09.19 11:32, Danil Kipnis wrote:
> On Fri, Sep 27, 2019 at 10:52 AM Roman Penyaev <r.peniaev@gmail.com> wrote:
>> No, it seems this thingy is a bit different.  According to my
>> understanding patches 3 and 4 from this patchset do the
>> following: 1# split equally the whole queue depth on number
>> of hardware queues and 2# return tag number which is unique
>> host-wide (more or less similar to unique_tag, right?).
>>
>> 2# is not needed for ibtrs, and 1# can be easy done by dividing
>> queue_depth on number of hw queues on tag set allocation, e.g.
>> something like the following:
>>
>>      ...
>>      tags->nr_hw_queues = num_online_cpus();
>>      tags->queue_depth  = sess->queue_deph / tags->nr_hw_queues;
>>
>>      blk_mq_alloc_tag_set(tags);
>>
>>
>> And this trick won't work out for the performance.  ibtrs client
>> has a single resource: set of buffer chunks received from a
>> server side.  And these buffers should be dynamically distributed
>> between IO producers according to the load.  Having a hard split
>> of the whole queue depth between hw queues we can forget about a
>> dynamic load distribution, here is an example:
>>
>>     - say server shares 1024 buffer chunks for a session (do not
>>       remember what is the actual number).
>>
>>     - 1024 buffers are equally divided between hw queues, let's
>>       say 64 (number of cpus), so each queue is 16 requests depth.
>>
>>     - only several CPUs produce IO, and instead of occupying the
>>       whole "bandwidth" of a session, i.e. 1024 buffer chunks,
>>       we limit ourselves to a small queue depth of an each hw
>>       queue.
>>
>> And performance drops significantly when number of IO producers
>> is smaller than number of hw queues (CPUs), and it can be easily
>> tested and proved.
>>
>> So for this particular ibtrs case tags should be globally shared,
>> and seems (unfortunately) there is no any other similar requirements
>> for other block devices.
> I don't see any difference between what you describe here and 100 dm
> volumes sitting on top of a single NVME device.

Hallo Christoph,

am I wrong?

Thank you,

Danil.

