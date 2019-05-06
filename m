Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD4314B3A
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 15:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbfEFNvU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 09:51:20 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:17369 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfEFNvT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 May 2019 09:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1557150678; x=1588686678;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=iFL0T7EEQ7ly0/MyjK4tLUGMa/31Jm03Jc0fnABXFB0=;
  b=ZNsbA0ctafASAlY2ga2UuyMAiCOrywF0ssQEyjkkfsa3JDD42DqWNvl2
   Eh23h81PFpp5RnZJJHgbOXw9Wg3anQ78sxpzs2CZ1q3ysQkHpwD5KZBOk
   Ul2vI3TZaMi25dhwaK3QWGn+K3OPCfK4DkpFOgQaq0EleHDZqDYHycC4A
   U=;
X-IronPort-AV: E=Sophos;i="5.60,438,1549929600"; 
   d="scan'208";a="400992335"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 06 May 2019 13:51:15 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id x46DpBtS112869
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 6 May 2019 13:51:14 GMT
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 6 May 2019 13:51:14 +0000
Received: from [10.218.62.23] (10.43.161.10) by EX13D19EUB003.ant.amazon.com
 (10.43.166.69) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 6 May
 2019 13:51:05 +0000
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
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <04fa3da6-4661-e319-61e3-a7083b81af62@amazon.com>
Date:   Mon, 6 May 2019 16:51:00 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190505123657.GB30659@mellanox.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.10]
X-ClientProxiedBy: EX13D25UWC001.ant.amazon.com (10.43.162.44) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 05-May-19 15:37, Jason Gunthorpe wrote:
> On Sun, May 05, 2019 at 11:06:04AM +0300, Gal Pressman wrote:
>> On 03-May-19 15:20, Jason Gunthorpe wrote:
>>> On Fri, May 03, 2019 at 12:37:13PM +0300, Gal Pressman wrote:
>>>> On 02-May-19 16:55, Jason Gunthorpe wrote:
>>>>> On Wed, May 01, 2019 at 01:48:20PM +0300, Gal Pressman wrote:
>>>>>
>>>>>> +static struct efa_comp_ctx *efa_com_submit_admin_cmd(struct efa_com_admin_queue *aq,
>>>>>> +						     struct efa_admin_aq_entry *cmd,
>>>>>> +						     size_t cmd_size_in_bytes,
>>>>>> +						     struct efa_admin_acq_entry *comp,
>>>>>> +						     size_t comp_size_in_bytes)
>>>>>> +{
>>>>>> +	struct efa_comp_ctx *comp_ctx;
>>>>>> +
>>>>>> +	spin_lock(&aq->sq.lock);
>>>>>> +	if (!test_bit(EFA_AQ_STATE_RUNNING_BIT, &aq->state)) {
>>>>>> +		ibdev_err(aq->efa_dev, "Admin queue is closed\n");
>>>>>> +		spin_unlock(&aq->sq.lock);
>>>>>> +		return ERR_PTR(-ENODEV);
>>>>>> +	}
>>>>>> +
>>>>>> +	comp_ctx = __efa_com_submit_admin_cmd(aq, cmd, cmd_size_in_bytes, comp,
>>>>>> +					      comp_size_in_bytes);
>>>>>> +	spin_unlock(&aq->sq.lock);
>>>>>> +	if (IS_ERR(comp_ctx))
>>>>>> +		clear_bit(EFA_AQ_STATE_RUNNING_BIT, &aq->state);
>>>>>> +
>>>>>> +	return comp_ctx;
>>>>>> +}
>>>>>
>>>>> [..]
>>>>>
>>>>>> +static void efa_com_admin_flush(struct efa_com_dev *edev)
>>>>>> +{
>>>>>> +	struct efa_com_admin_queue *aq = &edev->aq;
>>>>>> +
>>>>>> +	clear_bit(EFA_AQ_STATE_RUNNING_BIT, &aq->state);
>>>>>
>>>>> This scheme looks use after free racey to me..
>>>>
>>>> The running bit stops new admin commands from being submitted, clearly the exact
>>>> moment in which the bit is cleared is "racy" to submission of admin commands but
>>>> that is taken care of.
>>>>
>>>> The submission of an admin command is atomic as it is guarded by an admin queue
>>>> lock.
>>>> The same lock is acquired by this flow as well when flushing the admin queue.
>>>> After all admin commands have been aborted and we know for sure that
>>>> no new
>>>
>>> The problem is the 'abort' does nothing to ensure parallel threads are
>>> no longer touching this memory, 
>>
>> Which memory? The user threads touch the user allocated buffers which are not
>> being freed on admin queue destroy.
> 
> The memory the other thread is touching is freed a few lines below in
> a devm_kfree. The apparent purpose of this code is to make the other
> thread stop but does it wrong.

Are we talking about the completion context/completion context pool?
The user thread does use this memory, but this is done while the avail_cmds
semaphore is down which means the wait_for_abort_completion function is still
waiting for this thread to finish.
