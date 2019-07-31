Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE4777C682
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2019 17:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbfGaP0b (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Jul 2019 11:26:31 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:53681 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbfGaP0a (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 Jul 2019 11:26:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1564586788; x=1596122788;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=gz+GNcnKATDhO9zuLmMkj0kZesBM9H6r9D/2NR5vRx0=;
  b=dEXqkGMc8MCgFOvTOrR/FJGFDHJvce9TqMbaCgo1Wf0qAsxupFMPHpqG
   wuxP717uD6/yhcaL9n/xxXLuauwNDA91Cs7QexRhFWKa0KWtxFXjYkS8n
   C0glznTgACDJ3NpLa7oeKF+1hzBgQYeZmZr1bCRwxYtDXYC+HmciCAPjF
   w=;
X-IronPort-AV: E=Sophos;i="5.64,330,1559520000"; 
   d="scan'208";a="689618508"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2a-53356bf6.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 31 Jul 2019 15:26:25 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-53356bf6.us-west-2.amazon.com (Postfix) with ESMTPS id 0BB2DA26DF;
        Wed, 31 Jul 2019 15:26:25 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 31 Jul 2019 15:26:24 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.162.197) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 31 Jul 2019 15:26:21 +0000
Subject: Re: [PATCH for-next 1/2] RDMA/core: Introduce ratelimited ibdev
 printk functions
To:     Leon Romanovsky <leon@kernel.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>
References: <20190730151834.70993-1-galpress@amazon.com>
 <20190730151834.70993-2-galpress@amazon.com>
 <20190730154148.GG4878@mtr-leonro.mtl.com>
 <dd2c23a3-1d92-56d4-933e-68ec37aebb65@amazon.com>
 <20190731074109.GL4878@mtr-leonro.mtl.com>
 <dfffaa13-3b1a-81ef-1922-68aacf085616@amazon.com>
 <20190731114609.GS4878@mtr-leonro.mtl.com>
 <df557f2a-24c2-1b7d-abc9-81c62b1cdf11@amazon.com>
 <20190731133309.GW4878@mtr-leonro.mtl.com>
 <4a767c0c-f1cb-3edf-3ad0-7adc07fd2c78@amazon.com>
 <20190731145022.GB4832@mtr-leonro.mtl.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <69346585-d3ff-94ed-21a8-8cbfdfe6bac3@amazon.com>
Date:   Wed, 31 Jul 2019 18:26:16 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731145022.GB4832@mtr-leonro.mtl.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.197]
X-ClientProxiedBy: EX13D12UWA002.ant.amazon.com (10.43.160.88) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 31/07/2019 17:50, Leon Romanovsky wrote:
> On Wed, Jul 31, 2019 at 05:19:41PM +0300, Gal Pressman wrote:
>> On 31/07/2019 16:33, Leon Romanovsky wrote:
>>> On Wed, Jul 31, 2019 at 03:56:55PM +0300, Gal Pressman wrote:
>>>> On 31/07/2019 14:46, Leon Romanovsky wrote:
>>>>> On Wed, Jul 31, 2019 at 01:51:05PM +0300, Gal Pressman wrote:
>>>>>> On 31/07/2019 10:41, Leon Romanovsky wrote:
>>>>>>> On Wed, Jul 31, 2019 at 10:22:42AM +0300, Gal Pressman wrote:
>>>>>>>> On 30/07/2019 18:41, Leon Romanovsky wrote:
>>>>>>>>> On Tue, Jul 30, 2019 at 06:18:33PM +0300, Gal Pressman wrote:
>>>>>>>>>> Add ratelimited helpers to the ibdev_* printk functions.
>>>>>>>>>> Implementation inspired by counterpart dev_*_ratelimited functions.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Gal Pressman <galpress@amazon.com>
>>>>>>>>>> ---
>>>>>>>>>>  include/rdma/ib_verbs.h | 51 +++++++++++++++++++++++++++++++++++++++++
>>>>>>>>>>  1 file changed, 51 insertions(+)
>>>>>>>>>>
>>>>>>>>>> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
>>>>>>>>>> index c5f8a9f17063..356e6a105366 100644
>>>>>>>>>> --- a/include/rdma/ib_verbs.h
>>>>>>>>>> +++ b/include/rdma/ib_verbs.h
>>>>>>>>>> @@ -107,6 +107,57 @@ static inline
>>>>>>>>>>  void ibdev_dbg(const struct ib_device *ibdev, const char *format, ...) {}
>>>>>>>>>>  #endif
>>>>>>>>>>
>>>>>>>>>> +#define ibdev_level_ratelimited(ibdev_level, ibdev, fmt, ...)           \
>>>>>>>>>> +do {                                                                    \
>>>>>>>>>> +	static DEFINE_RATELIMIT_STATE(_rs,                              \
>>>>>>>>>> +				      DEFAULT_RATELIMIT_INTERVAL,       \
>>>>>>>>>> +				      DEFAULT_RATELIMIT_BURST);         \
>>>>>>>>>> +	if (__ratelimit(&_rs))                                          \
>>>>>>>>>> +		ibdev_level(ibdev, fmt, ##__VA_ARGS__);                 \
>>>>>>>>>> +} while (0)
>>>>>>>>>> +
>>>>>>>>>> +#define ibdev_emerg_ratelimited(ibdev, fmt, ...) \
>>>>>>>>>> +	ibdev_level_ratelimited(ibdev_emerg, ibdev, fmt, ##__VA_ARGS__)
>>>>>>>>>> +#define ibdev_alert_ratelimited(ibdev, fmt, ...) \
>>>>>>>>>> +	ibdev_level_ratelimited(ibdev_alert, ibdev, fmt, ##__VA_ARGS__)
>>>>>>>>>> +#define ibdev_crit_ratelimited(ibdev, fmt, ...) \
>>>>>>>>>> +	ibdev_level_ratelimited(ibdev_crit, ibdev, fmt, ##__VA_ARGS__)
>>>>>>>>>> +#define ibdev_err_ratelimited(ibdev, fmt, ...) \
>>>>>>>>>> +	ibdev_level_ratelimited(ibdev_err, ibdev, fmt, ##__VA_ARGS__)
>>>>>>>>>> +#define ibdev_warn_ratelimited(ibdev, fmt, ...) \
>>>>>>>>>> +	ibdev_level_ratelimited(ibdev_warn, ibdev, fmt, ##__VA_ARGS__)
>>>>>>>>>> +#define ibdev_notice_ratelimited(ibdev, fmt, ...) \
>>>>>>>>>> +	ibdev_level_ratelimited(ibdev_notice, ibdev, fmt, ##__VA_ARGS__)
>>>>>>>>>> +#define ibdev_info_ratelimited(ibdev, fmt, ...) \
>>>>>>>>>> +	ibdev_level_ratelimited(ibdev_info, ibdev, fmt, ##__VA_ARGS__)
>>>>>>>>>> +
>>>>>>>>>> +#if defined(CONFIG_DYNAMIC_DEBUG)
>>>>>>>>>> +/* descriptor check is first to prevent flooding with "callbacks suppressed" */
>>>>>>>>>> +#define ibdev_dbg_ratelimited(ibdev, fmt, ...)                          \
>>>>>>>>>> +do {                                                                    \
>>>>>>>>>> +	static DEFINE_RATELIMIT_STATE(_rs,                              \
>>>>>>>>>> +				      DEFAULT_RATELIMIT_INTERVAL,       \
>>>>>>>>>> +				      DEFAULT_RATELIMIT_BURST);         \
>>>>>>>>>> +	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);                 \
>>>>>>>>>> +	if (DYNAMIC_DEBUG_BRANCH(descriptor) && __ratelimit(&_rs))      \
>>>>>>>>>> +		__dynamic_ibdev_dbg(&descriptor, ibdev, fmt,            \
>>>>>>>>>> +				    ##__VA_ARGS__);                     \
>>>>>>>>>> +} while (0)
>>>>>>>>>> +#elif defined(DEBUG)
>>>>>>>>>
>>>>>>>>> When will you see this CONFIG_DEBUG set? I suspect only in private
>>>>>>>>> out-of-tree builds which we are not really care. Also I can't imagine
>>>>>>>>> system with this CONFIG_DEBUG and without CONFIG_DYNAMIC_DEBUG.
>>>>>>>>
>>>>>>>> This is the common way to handle debug prints, see:
>>>>>>>> https://elixir.bootlin.com/linux/v5.2.1/source/include/linux/printk.h#L331
>>>>>>>> https://elixir.bootlin.com/linux/v5.2.1/source/include/linux/device.h#L1493
>>>>>>>> https://elixir.bootlin.com/linux/v5.2.1/source/include/linux/netdevice.h#L4743
>>>>>>>> https://elixir.bootlin.com/linux/v5.2.1/source/include/linux/net.h#L266
>>>>>>>
>>>>>>> I'm more interested to know the real usage of this copy/paste and
>>>>>>> understand if it makes sense for drivers/infiniband/* or not.
>>>>>>>
>>>>>>> Not everything in netdev is great and worth to borrow.
>>>>>>
>>>>>> DEBUG exists since the first commit in the tree, and is used in various parts of
>>>>>> the kernel (mlx5 as well). Do you think it should be removed from the kernel?
>>>>>
>>>>> It is gradually removed when it is spotted, I'll send a patch for mlx5 now.
>>>>
>>>> Was there an on-list discussion regarding removal of DEBUG usage? Can you please
>>>> share a link?
>>>
>>> Sorry, but no, I didn't know that I need to save all discussions I see
>>> in the mailing lists.
>>
>> Trying to understand whether "It is gradually removed when it is spotted" is a
>> well known guideline by the community, should checkpatch produce a warning for this?
> 
> I didn't see checks in checkpatch about tabs<->spaces mix either which you
> pointed for hns guys.

Ofcourse there are, this patch was full of checkpatch warnings.
But that's not the point, you're avoiding answering a simple question: is DEBUG
usage discouraged by the community?

> 
>>
>>>
>>>> If so, I agree the DEBUG part should be removed.
>>>>
>>>>>
>>>>>>
>>>>>> Regarding combination of both, I don't think DEBUG is related to
>>>>>> CONFIG_DYNAMIC_DEBUG. DEBUG is a generic debug flag (not necessarily to prints)
>>>>>> while CONFIG_DYNAMIC_DEBUG is specific to the dynamic debug prints infrastructure.
>>>>>
>>>>> I know exactly what DEBUG and CONFIG_DYNAMIC_DEBUG mean, but I'm
>>>>> asking YOU to provide us real and in-tree scenario where DEBUG will
>>>>> exists and CONFIG_DYNAMIC_DEBUG won't.
>>>>
>>>> What's any of this has to do with in-tree? This code and defines are part of the
>>>> tree.
>>>>
>>>> The use case doesn't matter, it's a valid permutation. Is there anything that
>>>> stops a user from building the kernel this way?
>>>
>>> Like everything else, nothing stops from you to do any modifications to
>>> the source code, before you will build. We are talking about in-tree
>>> builds and distro kernels.
>>
>> Last I checked turning on DEBUG doesn't require source code changes?
> 
> Exciting, how did you enable DEBUG without recompiling source code?

Recompiling source code != changing source code.
You can turn on DEBUG when compiling the kernel (i.e running make) with no
source code changes (again, last I checked, did this change lately?).

> Maybe you find a way to enable DEBUG on running kernel?
> 
> And how did it come that v5.3 kernel was compiled with DEBUG but
> without DYNAMIC_DEBUG?

Change CONFIG_DYNAMIC_DEBUG=n in your .config and pass DEBUG to make.
