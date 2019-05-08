Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9865170A3
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2019 08:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfEHGAf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 May 2019 02:00:35 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:7719 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfEHGAf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 May 2019 02:00:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1557295234; x=1588831234;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=5pvYqLb0Rb8MxGuLAtagbrchCWN1uzHNwg3FeTd9thY=;
  b=MLIzzRofAKYKeqDgxrRar6VHIjPjDJB250dUj9aBRtBnjw1y+og3y2ZP
   GXQOFOcGShLXSHzX2umjf2r80l/FgJVKHHxTmIpQUl1bUjmJlz2VFVY1J
   SA/mw2xPfCW1HcA7Xm4cOSsptEIYqQ0opdgGepO3RZ9ZXTrBDWvWB5t66
   o=;
X-IronPort-AV: E=Sophos;i="5.60,444,1549929600"; 
   d="scan'208";a="395630024"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-98acfc19.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 May 2019 06:00:33 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-98acfc19.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x4860TOK001176
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 8 May 2019 06:00:29 GMT
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 8 May 2019 06:00:28 +0000
Received: from [10.95.77.144] (10.43.162.38) by EX13D19EUB003.ant.amazon.com
 (10.43.166.69) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 8 May
 2019 06:00:21 +0000
Subject: Re: [PATCH for-next v6 08/12] RDMA/efa: Implement functions that
 submit and complete admin commands
To:     Jason Gunthorpe <jgg@mellanox.com>
CC:     Doug Ledford <dledford@redhat.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Alexander Matushevsky <matua@amazon.com>,
        Leah Shalev <shalevl@amazon.com>,
        Dave Goodell <goodell@amazon.com>,
        Brian Barrett <bbarrett@amazon.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Sean Hefty <sean.hefty@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Parav Pandit <parav@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Steve Wise" <larrystevenwise@gmail.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
References: <1556707704-11192-1-git-send-email-galpress@amazon.com>
 <1556707704-11192-9-git-send-email-galpress@amazon.com>
 <20190502135505.GA21208@mellanox.com>
 <639fc272-e2bf-9fb3-2599-0e4884c7546c@amazon.com>
 <20190503122042.GC13315@mellanox.com>
 <bbc3ff2b-797e-1b63-0c4c-2f74d782e0fd@amazon.com>
 <20190505123657.GB30659@mellanox.com>
 <04fa3da6-4661-e319-61e3-a7083b81af62@amazon.com>
 <20190506183112.GM6186@mellanox.com>
 <68f9242d-f2c2-a92d-270e-ad1af8f02d9f@amazon.com>
 <20190507125146.GS6186@mellanox.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <2d0cefd7-5cb9-1884-d7cd-ec42a3a43e11@amazon.com>
Date:   Wed, 8 May 2019 09:00:17 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190507125146.GS6186@mellanox.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.38]
X-ClientProxiedBy: EX13D02UWB004.ant.amazon.com (10.43.161.11) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 07-May-19 15:51, Jason Gunthorpe wrote:
> On Tue, May 07, 2019 at 03:38:21PM +0300, Gal Pressman wrote:
>> On 06-May-19 21:31, Jason Gunthorpe wrote:
>>> On Mon, May 06, 2019 at 04:51:00PM +0300, Gal Pressman wrote:
>>>>>>>>>> +static void efa_com_admin_flush(struct efa_com_dev *edev)
>>>>>>>>>> +{
>>>>>>>>>> +	struct efa_com_admin_queue *aq = &edev->aq;
>>>>>>>>>> +
>>>>>>>>>> +	clear_bit(EFA_AQ_STATE_RUNNING_BIT, &aq->state);
>>>>>>>>>
>>>>>>>>> This scheme looks use after free racey to me..
>>>>>>>>
>>>>>>>> The running bit stops new admin commands from being submitted, clearly the exact
>>>>>>>> moment in which the bit is cleared is "racy" to submission of admin commands but
>>>>>>>> that is taken care of.
>>>>>>>>
>>>>>>>> The submission of an admin command is atomic as it is guarded by an admin queue
>>>>>>>> lock.
>>>>>>>> The same lock is acquired by this flow as well when flushing the admin queue.
>>>>>>>> After all admin commands have been aborted and we know for sure that
>>>>>>>> no new
>>>>>>>
>>>>>>> The problem is the 'abort' does nothing to ensure parallel threads are
>>>>>>> no longer touching this memory, 
>>>>>>
>>>>>> Which memory? The user threads touch the user allocated buffers which are not
>>>>>> being freed on admin queue destroy.
>>>>>
>>>>> The memory the other thread is touching is freed a few lines below in
>>>>> a devm_kfree. The apparent purpose of this code is to make the other
>>>>> thread stop but does it wrong.
>>>>
>>>> Are we talking about the completion context/completion context pool?
>>>> The user thread does use this memory, but this is done while the avail_cmds
>>>> semaphore is down which means the wait_for_abort_completion function is still
>>>> waiting for this thread to finish.
>>>
>>> We are talking about
>>>
>>>      CPU 0                                          CPU 1
>>> efa_com_submit_admin_cmd()
>>>   	spin_lock(&aq->sq.lock);
>>>
>>>                                          efa_remove_device()
>>>                                              efa_com_admin_destroy()
>>>                                                efa_com_admin_flush()
>>>                                                [..]
>>>                                           kfree(aq)
>>>
>>>
>>
>> As long as efa_com_submit_admin_cmd() is running the semaphore is still "down"
>> which means the wait function will be blocked.
> 
> It is a race, order it a little differently:
> 
>       CPU 0                                          CPU 1
>  efa_com_submit_admin_cmd()
>                                           efa_remove_device()
>                                               efa_com_admin_destroy()
>                                                 efa_com_admin_flush()
>                                                 efa_com_wait_for_abort_completion()
>                                                 [..]
>    	spin_lock(&aq->sq.lock);
>  
>                                            kfree(aq)
> 
> Fundamentally you can't use locking *inside* the memory you are trying
> to free to exclude other threads from using that memory. That is
> always a user after free.
> 
> Which is why when I see someone write something like:
> 
> 	spin_lock(&aq->sq.lock);
> 	if (!test_bit(EFA_AQ_STATE_RUNNING_BIT, &aq->state)) {
> 		ibdev_err(aq->efa_dev, "Admin queue is closed\n");
> 		spin_unlock(&aq->sq.lock);
> 
> it is almost always a bug
> 
> And when you see matching things like:
> 
> [..]
> 	set_bit(EFA_AQ_STATE_POLLING_BIT, &edev->aq.state);
>         kfree(edev)
> 
> You know it is screwed up in some way.

Thanks for the detailed explanation, makes sense.

> 
>>> So, either there is no possible concurrency with the 'aq' users and
>>> device removal, in which case all the convoluted locking in
>>> efa_com_admin_flush() and related is unneeded
>>>
>>> Or there is concurrency and it isn't being torn down properly, so we
>>> get the above race.
>>>
>>> My read is that all the 'admin commands' are done off of verbs
>>> callbacks and ib_unregister_device is called before we get to
>>> efa_remove_device (guaranteeing there are no running verbs callbacks),
>>> so there is no possible concurrency and all this efa_com_admin_flush()
>>> and related is pointless obfuscation. Delete it.
>>
>> You're right, the "abort" flow was overcautious as there shouldn't be any
>> pending threads after ib_unregister_device.
>> I will remove this flow.
> 
> Send a follow up patch

Will do.
