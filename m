Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C098B676F
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Sep 2019 17:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731476AbfIRPrd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Sep 2019 11:47:33 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34282 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbfIRPrd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Sep 2019 11:47:33 -0400
Received: by mail-pg1-f193.google.com with SMTP id n9so91764pgc.1;
        Wed, 18 Sep 2019 08:47:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oQqmsAX0PVIpLRoY3clwlT+EXp5od60YczfAAqPHRl8=;
        b=kHRQ4SSvjUlG6pfi7slPOEcUCybyReQFpfCboANend8WpjwS03N9yabNBT2c+r+dQ8
         dKOETWz8nPb8KkLFOOZCJZFYifhpQY2QtGIZU/MZeptFdUwDmSAbUOrZvdV+f5GCN+s0
         V8nK7cwSthGGdFCRl0ZzjBL+AFC8nh5LmjGaDe7E/9FhAIBal6CRYZ35Vvat3uRZiUMx
         fwJSizdXPOtFS0fZNeCQ+L916UNr/l1R0o7fkfm1bpIjnv/PR25/5b89sLYzxcpNMD6e
         reu87fDWkpCJlz+WNKJ8znM6GZo3YAueQNlfh1UX7xLXQfA49TXDZQbCTHUaqnLmvt0g
         tjZQ==
X-Gm-Message-State: APjAAAX44u8DxCEi5gkC9qmC+MrZWDTQP7rWXRTIOcOSN31wG+6WvwSK
        6ISoLSARBkQoEVoOpHVB2SBJQG5dMzA=
X-Google-Smtp-Source: APXvYqz/hOIkACY30mdaUP8X1J9BLE/zihRsPDOOaRV0PaVUwQ0tC6/hxeZsJ8VQWiCIl73b3vY3pw==
X-Received: by 2002:a17:90a:aa82:: with SMTP id l2mr4652510pjq.73.1568821652079;
        Wed, 18 Sep 2019 08:47:32 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 193sm8520181pfc.59.2019.09.18.08.47.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 08:47:30 -0700 (PDT)
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
 <5c5ff7df-2cce-ec26-7893-55911e4d8595@acm.org>
 <CAHg0HuwFTVsCNHbiXW20P6hQ3c-P_p5tB6dYKtOW=_euWEvLnA@mail.gmail.com>
 <CAHg0HuzQOH4ZCe+v-GHu8jOYm-wUbh1fFRK75Muq+DPpQGAH8A@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <6f677d56-82b3-a321-f338-cbf8ff4e83eb@acm.org>
Date:   Wed, 18 Sep 2019 08:47:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHg0HuzQOH4ZCe+v-GHu8jOYm-wUbh1fFRK75Muq+DPpQGAH8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/18/19 12:14 AM, Danil Kipnis wrote:
> I'm not familiar with dm code, but don't they need to deal with the
> same situation: if I configure 100 logical volumes on top of a single
> NVME drive with X hardware queues, each queue_depth deep, then each dm
> block device would need to advertise X hardware queues in order to
> achieve highest performance in case only this one volume is accessed,
> while in fact those X physical queues have to be shared among all 100
> logical volumes, if they are accessed in parallel?

Combining multiple queues (a) into a single queue (b) that is smaller 
than the combined source queues without sacrificing performance is 
tricky. We already have one such implementation in the block layer core 
and it took considerable time to get that implementation right. See e.g. 
blk_mq_sched_mark_restart_hctx() and blk_mq_sched_restart().

dm drivers are expected to return DM_MAPIO_REQUEUE or 
DM_MAPIO_DELAY_REQUEUE if the queue (b) is full. It turned out to be 
difficult to get this right in the dm-mpath driver and at the same time 
to achieve good performance.

The ibnbd driver introduces a third implementation of code that combines 
multiple (per-cpu) queues into one queue per CPU. It is considered 
important in the Linux kernel to avoid code duplication. Hence my 
question whether ibnbd can reuse the block layer infrastructure for 
sharing tag sets.

Thanks,

Bart.


