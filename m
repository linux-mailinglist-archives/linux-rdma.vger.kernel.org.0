Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6155213E62
	for <lists+linux-rdma@lfdr.de>; Sun,  5 May 2019 10:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfEEIGX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 May 2019 04:06:23 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:29099 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbfEEIGW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 5 May 2019 04:06:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1557043581; x=1588579581;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=vyEZaV4L+bVKMeKeR7dVVbpAKXdMgjoOgI2sLMbqRNs=;
  b=Y8nQOjILtaJ4SObmWKsSSq+GCHJnOcVFNJw0gEtJjYFUfCr/lNY4naNv
   iAL6AkS1PuGug+3oF84JbKmYVzqnZ//NFkqKRfIPV96Vv3dVEwrjrd7IO
   uY0YIH+dHUndFR5xohGmGgt7HM+dRw9o49hzdPGw7ZpBuIiS4HBVvC9mU
   E=;
X-IronPort-AV: E=Sophos;i="5.60,433,1549929600"; 
   d="scan'208";a="400851962"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 05 May 2019 08:06:20 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x4586GHh088903
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Sun, 5 May 2019 08:06:17 GMT
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 5 May 2019 08:06:16 +0000
Received: from [10.218.62.21] (10.43.162.53) by EX13D19EUB003.ant.amazon.com
 (10.43.166.69) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Sun, 5 May
 2019 08:06:09 +0000
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
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <bbc3ff2b-797e-1b63-0c4c-2f74d782e0fd@amazon.com>
Date:   Sun, 5 May 2019 11:06:04 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190503122042.GC13315@mellanox.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.53]
X-ClientProxiedBy: EX13D25UWB001.ant.amazon.com (10.43.161.245) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 03-May-19 15:20, Jason Gunthorpe wrote:
> On Fri, May 03, 2019 at 12:37:13PM +0300, Gal Pressman wrote:
>> On 02-May-19 16:55, Jason Gunthorpe wrote:
>>> On Wed, May 01, 2019 at 01:48:20PM +0300, Gal Pressman wrote:
>>>
>>>> +static struct efa_comp_ctx *efa_com_submit_admin_cmd(struct efa_com_admin_queue *aq,
>>>> +						     struct efa_admin_aq_entry *cmd,
>>>> +						     size_t cmd_size_in_bytes,
>>>> +						     struct efa_admin_acq_entry *comp,
>>>> +						     size_t comp_size_in_bytes)
>>>> +{
>>>> +	struct efa_comp_ctx *comp_ctx;
>>>> +
>>>> +	spin_lock(&aq->sq.lock);
>>>> +	if (!test_bit(EFA_AQ_STATE_RUNNING_BIT, &aq->state)) {
>>>> +		ibdev_err(aq->efa_dev, "Admin queue is closed\n");
>>>> +		spin_unlock(&aq->sq.lock);
>>>> +		return ERR_PTR(-ENODEV);
>>>> +	}
>>>> +
>>>> +	comp_ctx = __efa_com_submit_admin_cmd(aq, cmd, cmd_size_in_bytes, comp,
>>>> +					      comp_size_in_bytes);
>>>> +	spin_unlock(&aq->sq.lock);
>>>> +	if (IS_ERR(comp_ctx))
>>>> +		clear_bit(EFA_AQ_STATE_RUNNING_BIT, &aq->state);
>>>> +
>>>> +	return comp_ctx;
>>>> +}
>>>
>>> [..]
>>>
>>>> +static void efa_com_admin_flush(struct efa_com_dev *edev)
>>>> +{
>>>> +	struct efa_com_admin_queue *aq = &edev->aq;
>>>> +
>>>> +	clear_bit(EFA_AQ_STATE_RUNNING_BIT, &aq->state);
>>>
>>> This scheme looks use after free racey to me..
>>
>> The running bit stops new admin commands from being submitted, clearly the exact
>> moment in which the bit is cleared is "racy" to submission of admin commands but
>> that is taken care of.
>>
>> The submission of an admin command is atomic as it is guarded by an admin queue
>> lock.
>> The same lock is acquired by this flow as well when flushing the admin queue.
>> After all admin commands have been aborted and we know for sure that
>> no new
> 
> The problem is the 'abort' does nothing to ensure parallel threads are
> no longer touching this memory, 

Which memory? The user threads touch the user allocated buffers which are not
being freed on admin queue destroy.

> it just plays with locks in a racy way
> for the above.

Sorry, I don't understand what that means.
