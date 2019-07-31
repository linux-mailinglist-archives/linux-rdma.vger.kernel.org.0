Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB3917BAA4
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2019 09:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbfGaHWz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Jul 2019 03:22:55 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:54640 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfGaHWz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 Jul 2019 03:22:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1564557774; x=1596093774;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=/T0RdOEbM8V53kt3bv8k2Nu/lS2ea4XvwJ6kJErbfS0=;
  b=hVLT86bOChCSoWM4HCJ48uttBW2lLzCAkccoRWBy9/0xpoYX38otnl4e
   yuQILPYsDXif1NoXXEIO/sp2OvjQaplmG9PRU+PRIW/1mxvs2Evrj252/
   Dgw96UjTlGa6oSshr/7mIQlz847Ksylj897UTC+Oiungt6HUvKzGb64T6
   c=;
X-IronPort-AV: E=Sophos;i="5.64,329,1559520000"; 
   d="scan'208";a="407397602"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-27fb8269.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 31 Jul 2019 07:22:53 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-27fb8269.us-east-1.amazon.com (Postfix) with ESMTPS id 1EABCA2690;
        Wed, 31 Jul 2019 07:22:51 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 31 Jul 2019 07:22:51 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.162.191) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 31 Jul 2019 07:22:47 +0000
Subject: Re: [PATCH for-next 1/2] RDMA/core: Introduce ratelimited ibdev
 printk functions
To:     Leon Romanovsky <leon@kernel.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>
References: <20190730151834.70993-1-galpress@amazon.com>
 <20190730151834.70993-2-galpress@amazon.com>
 <20190730154148.GG4878@mtr-leonro.mtl.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <dd2c23a3-1d92-56d4-933e-68ec37aebb65@amazon.com>
Date:   Wed, 31 Jul 2019 10:22:42 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730154148.GG4878@mtr-leonro.mtl.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.191]
X-ClientProxiedBy: EX13D21UWA004.ant.amazon.com (10.43.160.252) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 30/07/2019 18:41, Leon Romanovsky wrote:
> On Tue, Jul 30, 2019 at 06:18:33PM +0300, Gal Pressman wrote:
>> Add ratelimited helpers to the ibdev_* printk functions.
>> Implementation inspired by counterpart dev_*_ratelimited functions.
>>
>> Signed-off-by: Gal Pressman <galpress@amazon.com>
>> ---
>>  include/rdma/ib_verbs.h | 51 +++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 51 insertions(+)
>>
>> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
>> index c5f8a9f17063..356e6a105366 100644
>> --- a/include/rdma/ib_verbs.h
>> +++ b/include/rdma/ib_verbs.h
>> @@ -107,6 +107,57 @@ static inline
>>  void ibdev_dbg(const struct ib_device *ibdev, const char *format, ...) {}
>>  #endif
>>
>> +#define ibdev_level_ratelimited(ibdev_level, ibdev, fmt, ...)           \
>> +do {                                                                    \
>> +	static DEFINE_RATELIMIT_STATE(_rs,                              \
>> +				      DEFAULT_RATELIMIT_INTERVAL,       \
>> +				      DEFAULT_RATELIMIT_BURST);         \
>> +	if (__ratelimit(&_rs))                                          \
>> +		ibdev_level(ibdev, fmt, ##__VA_ARGS__);                 \
>> +} while (0)
>> +
>> +#define ibdev_emerg_ratelimited(ibdev, fmt, ...) \
>> +	ibdev_level_ratelimited(ibdev_emerg, ibdev, fmt, ##__VA_ARGS__)
>> +#define ibdev_alert_ratelimited(ibdev, fmt, ...) \
>> +	ibdev_level_ratelimited(ibdev_alert, ibdev, fmt, ##__VA_ARGS__)
>> +#define ibdev_crit_ratelimited(ibdev, fmt, ...) \
>> +	ibdev_level_ratelimited(ibdev_crit, ibdev, fmt, ##__VA_ARGS__)
>> +#define ibdev_err_ratelimited(ibdev, fmt, ...) \
>> +	ibdev_level_ratelimited(ibdev_err, ibdev, fmt, ##__VA_ARGS__)
>> +#define ibdev_warn_ratelimited(ibdev, fmt, ...) \
>> +	ibdev_level_ratelimited(ibdev_warn, ibdev, fmt, ##__VA_ARGS__)
>> +#define ibdev_notice_ratelimited(ibdev, fmt, ...) \
>> +	ibdev_level_ratelimited(ibdev_notice, ibdev, fmt, ##__VA_ARGS__)
>> +#define ibdev_info_ratelimited(ibdev, fmt, ...) \
>> +	ibdev_level_ratelimited(ibdev_info, ibdev, fmt, ##__VA_ARGS__)
>> +
>> +#if defined(CONFIG_DYNAMIC_DEBUG)
>> +/* descriptor check is first to prevent flooding with "callbacks suppressed" */
>> +#define ibdev_dbg_ratelimited(ibdev, fmt, ...)                          \
>> +do {                                                                    \
>> +	static DEFINE_RATELIMIT_STATE(_rs,                              \
>> +				      DEFAULT_RATELIMIT_INTERVAL,       \
>> +				      DEFAULT_RATELIMIT_BURST);         \
>> +	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);                 \
>> +	if (DYNAMIC_DEBUG_BRANCH(descriptor) && __ratelimit(&_rs))      \
>> +		__dynamic_ibdev_dbg(&descriptor, ibdev, fmt,            \
>> +				    ##__VA_ARGS__);                     \
>> +} while (0)
>> +#elif defined(DEBUG)
> 
> When will you see this CONFIG_DEBUG set? I suspect only in private
> out-of-tree builds which we are not really care. Also I can't imagine
> system with this CONFIG_DEBUG and without CONFIG_DYNAMIC_DEBUG.

This is the common way to handle debug prints, see:
https://elixir.bootlin.com/linux/v5.2.1/source/include/linux/printk.h#L331
https://elixir.bootlin.com/linux/v5.2.1/source/include/linux/device.h#L1493
https://elixir.bootlin.com/linux/v5.2.1/source/include/linux/netdevice.h#L4743
https://elixir.bootlin.com/linux/v5.2.1/source/include/linux/net.h#L266
