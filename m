Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 871B47BEAB
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2019 12:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbfGaKvS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Jul 2019 06:51:18 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:54603 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfGaKvS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 Jul 2019 06:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1564570276; x=1596106276;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=D2uFtu23OnBV0hS+l+o18FiAzSgBCWpR8IEqt7lnPRk=;
  b=dMOZN/FGpC5A6TxfhHJOw7nJkmZJTezohQ+eXURz9W14pDFHfLTlliYW
   ynKiDYNPWdcQenHZ/p/o49H2+RXSrK0C1GfTuMqvDik+twvkWvAIv52kX
   IT7ZOjQIjIOHSH0GM0zW71f96gQbsb1RB4ww6mZM8VpEgA9LCaHZxcE4q
   4=;
X-IronPort-AV: E=Sophos;i="5.64,329,1559520000"; 
   d="scan'208";a="777049102"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 31 Jul 2019 10:51:15 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com (Postfix) with ESMTPS id 5C0EFA28B0;
        Wed, 31 Jul 2019 10:51:14 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 31 Jul 2019 10:51:13 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.162.67) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 31 Jul 2019 10:51:10 +0000
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
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <dfffaa13-3b1a-81ef-1922-68aacf085616@amazon.com>
Date:   Wed, 31 Jul 2019 13:51:05 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731074109.GL4878@mtr-leonro.mtl.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.67]
X-ClientProxiedBy: EX13D28UWB001.ant.amazon.com (10.43.161.98) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 31/07/2019 10:41, Leon Romanovsky wrote:
> On Wed, Jul 31, 2019 at 10:22:42AM +0300, Gal Pressman wrote:
>> On 30/07/2019 18:41, Leon Romanovsky wrote:
>>> On Tue, Jul 30, 2019 at 06:18:33PM +0300, Gal Pressman wrote:
>>>> Add ratelimited helpers to the ibdev_* printk functions.
>>>> Implementation inspired by counterpart dev_*_ratelimited functions.
>>>>
>>>> Signed-off-by: Gal Pressman <galpress@amazon.com>
>>>> ---
>>>>  include/rdma/ib_verbs.h | 51 +++++++++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 51 insertions(+)
>>>>
>>>> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
>>>> index c5f8a9f17063..356e6a105366 100644
>>>> --- a/include/rdma/ib_verbs.h
>>>> +++ b/include/rdma/ib_verbs.h
>>>> @@ -107,6 +107,57 @@ static inline
>>>>  void ibdev_dbg(const struct ib_device *ibdev, const char *format, ...) {}
>>>>  #endif
>>>>
>>>> +#define ibdev_level_ratelimited(ibdev_level, ibdev, fmt, ...)           \
>>>> +do {                                                                    \
>>>> +	static DEFINE_RATELIMIT_STATE(_rs,                              \
>>>> +				      DEFAULT_RATELIMIT_INTERVAL,       \
>>>> +				      DEFAULT_RATELIMIT_BURST);         \
>>>> +	if (__ratelimit(&_rs))                                          \
>>>> +		ibdev_level(ibdev, fmt, ##__VA_ARGS__);                 \
>>>> +} while (0)
>>>> +
>>>> +#define ibdev_emerg_ratelimited(ibdev, fmt, ...) \
>>>> +	ibdev_level_ratelimited(ibdev_emerg, ibdev, fmt, ##__VA_ARGS__)
>>>> +#define ibdev_alert_ratelimited(ibdev, fmt, ...) \
>>>> +	ibdev_level_ratelimited(ibdev_alert, ibdev, fmt, ##__VA_ARGS__)
>>>> +#define ibdev_crit_ratelimited(ibdev, fmt, ...) \
>>>> +	ibdev_level_ratelimited(ibdev_crit, ibdev, fmt, ##__VA_ARGS__)
>>>> +#define ibdev_err_ratelimited(ibdev, fmt, ...) \
>>>> +	ibdev_level_ratelimited(ibdev_err, ibdev, fmt, ##__VA_ARGS__)
>>>> +#define ibdev_warn_ratelimited(ibdev, fmt, ...) \
>>>> +	ibdev_level_ratelimited(ibdev_warn, ibdev, fmt, ##__VA_ARGS__)
>>>> +#define ibdev_notice_ratelimited(ibdev, fmt, ...) \
>>>> +	ibdev_level_ratelimited(ibdev_notice, ibdev, fmt, ##__VA_ARGS__)
>>>> +#define ibdev_info_ratelimited(ibdev, fmt, ...) \
>>>> +	ibdev_level_ratelimited(ibdev_info, ibdev, fmt, ##__VA_ARGS__)
>>>> +
>>>> +#if defined(CONFIG_DYNAMIC_DEBUG)
>>>> +/* descriptor check is first to prevent flooding with "callbacks suppressed" */
>>>> +#define ibdev_dbg_ratelimited(ibdev, fmt, ...)                          \
>>>> +do {                                                                    \
>>>> +	static DEFINE_RATELIMIT_STATE(_rs,                              \
>>>> +				      DEFAULT_RATELIMIT_INTERVAL,       \
>>>> +				      DEFAULT_RATELIMIT_BURST);         \
>>>> +	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);                 \
>>>> +	if (DYNAMIC_DEBUG_BRANCH(descriptor) && __ratelimit(&_rs))      \
>>>> +		__dynamic_ibdev_dbg(&descriptor, ibdev, fmt,            \
>>>> +				    ##__VA_ARGS__);                     \
>>>> +} while (0)
>>>> +#elif defined(DEBUG)
>>>
>>> When will you see this CONFIG_DEBUG set? I suspect only in private
>>> out-of-tree builds which we are not really care. Also I can't imagine
>>> system with this CONFIG_DEBUG and without CONFIG_DYNAMIC_DEBUG.
>>
>> This is the common way to handle debug prints, see:
>> https://elixir.bootlin.com/linux/v5.2.1/source/include/linux/printk.h#L331
>> https://elixir.bootlin.com/linux/v5.2.1/source/include/linux/device.h#L1493
>> https://elixir.bootlin.com/linux/v5.2.1/source/include/linux/netdevice.h#L4743
>> https://elixir.bootlin.com/linux/v5.2.1/source/include/linux/net.h#L266
> 
> I'm more interested to know the real usage of this copy/paste and
> understand if it makes sense for drivers/infiniband/* or not.
> 
> Not everything in netdev is great and worth to borrow.

DEBUG exists since the first commit in the tree, and is used in various parts of
the kernel (mlx5 as well). Do you think it should be removed from the kernel?

Regarding combination of both, I don't think DEBUG is related to
CONFIG_DYNAMIC_DEBUG. DEBUG is a generic debug flag (not necessarily to prints)
while CONFIG_DYNAMIC_DEBUG is specific to the dynamic debug prints infrastructure.
