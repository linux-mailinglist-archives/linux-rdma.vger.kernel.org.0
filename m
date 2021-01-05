Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9E52EAC0E
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Jan 2021 14:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbhAENk1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Jan 2021 08:40:27 -0500
Received: from smtp-fw-9103.amazon.com ([207.171.188.200]:46168 "EHLO
        smtp-fw-9103.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729766AbhAENk0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Jan 2021 08:40:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1609854026; x=1641390026;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=be3XDbtLBzOjQ/QikBjjhDTkQi9aohtTmQBso0h3LwM=;
  b=CrexbVkPWYzxQvqNiixIDiVe6I60A0OBfl3c7rhsTveni0fCbb5E7t0q
   ymUXhX2by8SkAu4it9IlMfyL5or2oqCWfU+crV96IcW+V7DmGyWKNGyk1
   jB7Q8pQsW+GjGRhgFfyA85pIkrm7HbG41eg6FmVYo3qsrm8VOh7Onf+49
   o=;
X-IronPort-AV: E=Sophos;i="5.78,477,1599523200"; 
   d="scan'208";a="908284033"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-456ef9c9.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9103.sea19.amazon.com with ESMTP; 05 Jan 2021 13:39:38 +0000
Received: from EX13D19EUB003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-456ef9c9.us-west-2.amazon.com (Postfix) with ESMTPS id 26D4BA7B81;
        Tue,  5 Jan 2021 13:39:36 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.160.27) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 5 Jan 2021 13:39:31 +0000
Subject: Re: [PATCH for-next 1/2] RDMA/efa: Move host info set to first
 ucontext allocation
To:     Leon Romanovsky <leon@kernel.org>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Leonid Feschuk <lfesch@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
References: <20210105104326.67895-1-galpress@amazon.com>
 <20210105104326.67895-2-galpress@amazon.com> <20210105112150.GR31158@unreal>
 <4f3de61c-55dc-e6e3-6a14-de5be10e3ecd@amazon.com>
 <20210105124044.GS31158@unreal>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <66799680-56c5-31a1-8d32-bc3289bffca6@amazon.com>
Date:   Tue, 5 Jan 2021 15:39:27 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210105124044.GS31158@unreal>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.27]
X-ClientProxiedBy: EX13D10UWA003.ant.amazon.com (10.43.160.248) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 05/01/2021 14:40, Leon Romanovsky wrote:
> On Tue, Jan 05, 2021 at 02:22:23PM +0200, Gal Pressman wrote:
>> On 05/01/2021 13:21, Leon Romanovsky wrote:
>>> On Tue, Jan 05, 2021 at 12:43:25PM +0200, Gal Pressman wrote:
>>>> Downstream patch will require the userspace version which is passed as
>>>> part of ucontext allocation. Move the host info set there and make sure
>>>> it's only called once (on the first allocation).
>>>>
>>>> Reviewed-by: Firas JahJah <firasj@amazon.com>
>>>> Reviewed-by: Leonid Feschuk <lfesch@amazon.com>
>>>> Signed-off-by: Gal Pressman <galpress@amazon.com>
>>>> ---
>>>>  drivers/infiniband/hw/efa/efa.h       | 7 +++++++
>>>>  drivers/infiniband/hw/efa/efa_main.c  | 4 +---
>>>>  drivers/infiniband/hw/efa/efa_verbs.c | 3 +++
>>>>  3 files changed, 11 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
>>>> index e5d9712e98c4..9c9cd5867489 100644
>>>> --- a/drivers/infiniband/hw/efa/efa.h
>>>> +++ b/drivers/infiniband/hw/efa/efa.h
>>>> @@ -45,6 +45,11 @@ struct efa_stats {
>>>>       atomic64_t keep_alive_rcvd;
>>>>  };
>>>>
>>>> +enum {
>>>> +     EFA_FLAGS_HOST_INFO_SET_BIT,
>>>> +     EFA_FLAGS_NUM,
>>>> +};
>>>> +
>>>>  struct efa_dev {
>>>>       struct ib_device ibdev;
>>>>       struct efa_com_dev edev;
>>>> @@ -62,6 +67,7 @@ struct efa_dev {
>>>>       struct efa_irq admin_irq;
>>>>
>>>>       struct efa_stats stats;
>>>> +     DECLARE_BITMAP(flags, EFA_FLAGS_NUM);
>>>>  };
>>>
>>> Why do you need such over-engineering?
>>> What is wrong with old school "u8 flag"?
>>
>> The main reason is for the atomic test_and_set_bit() usage, otherwise it would
>> be an atomic flag, not u8 flag.
> 
> But efa_dev can be opened with different applications and they can have
> different user space versions, but you are setting this info for the
> first caller only. How will it help for the debug?

Right, it is possible for the userspace version to change between contexts, but
that's a tradeoff we're willing to take for the meantime so we don't have to
send a host info command for each ucontext allocation.

We can change that in the future if that won't prove to be reliable enough.
