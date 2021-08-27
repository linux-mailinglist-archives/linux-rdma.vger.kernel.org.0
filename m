Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 118D83F9144
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Aug 2021 02:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243823AbhH0AQr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Aug 2021 20:16:47 -0400
Received: from esa11.hc1455-7.c3s2.iphmx.com ([207.54.90.137]:36156 "EHLO
        esa11.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229710AbhH0AQq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 26 Aug 2021 20:16:46 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Aug 2021 20:16:46 EDT
IronPort-SDR: tDlE7IzEo2sL2cEEhTEPSYXCrgJ4+R8QbYGMVwb7PIkkITzCrNEDrmfAfFwcxqhnXeLQXQS9kn
 B/3iAJOUl2jp0Fd9oHeFBIx1zI2RAXvzjsPfpx0kOrjB9KTIfN5Y2jfr+CFkNCbyN8meyJVXRD
 PdlqIoh3kIIyrDuN1/tqiR9LiRC8YkLVborwMLNTWwkYKWRTIpxGvF5nq54erPWH5X0/fxL5xr
 92VEeqcFfNyjZXvlCkxxNBKanbhMDA6qMtl+BsyC/aK6J5NWmq5hPbW6HPEZ3mIYZUWFUOpNMF
 hwtUlxbPsCIFj0oONAZi/tWz
X-IronPort-AV: E=McAfee;i="6200,9189,10088"; a="21570539"
X-IronPort-AV: E=Sophos;i="5.84,354,1620658800"; 
   d="scan'208";a="21570539"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP; 27 Aug 2021 09:08:47 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 2C683EB340
        for <linux-rdma@vger.kernel.org>; Fri, 27 Aug 2021 09:08:46 +0900 (JST)
Received: from m3051.s.css.fujitsu.com (m3051.s.css.fujitsu.com [10.134.21.209])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 87AC2C5561
        for <linux-rdma@vger.kernel.org>; Fri, 27 Aug 2021 09:08:45 +0900 (JST)
Received: from [10.28.62.240] (FCCLS0014044.g01.fujitsu.local [10.28.62.240])
        by m3051.s.css.fujitsu.com (Postfix) with ESMTP id 4AF24A1;
        Fri, 27 Aug 2021 09:08:45 +0900 (JST)
Subject: Re: [PATCH] RDMA/core: EPERM should be returned when # of pined pages
 is over ulimit
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Yasunori Goto <y-goto@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
References: <20210818082702.692117-1-y-goto@fujitsu.com>
 <20210819231053.GA390234@nvidia.com>
 <f784a0c6-27b7-5e30-b3ba-e1f4ebe95399@fujitsu.com>
 <e3cb3dee-9c32-8024-1396-8dfd975a7b23@fujitsu.com>
 <20210826133244.GQ1721383@nvidia.com>
From:   =?UTF-8?B?R290b3UsIFlhc3Vub3JpL+S6lOWztiDlurfmloc=?= 
        <y-goto@jp.fujitsu.com>
Message-ID: <484727f0-38c1-1fdf-8eb7-d9b39b1ed2b7@jp.fujitsu.com>
Date:   Fri, 27 Aug 2021 09:08:44 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20210826133244.GQ1721383@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2021/08/26 22:32, Jason Gunthorpe wrote:
> On Fri, Aug 20, 2021 at 05:45:54PM +0900, Yasunori Goto wrote:
> 
>> static struct page **sev_pin_memory(struct kvm *kvm, unsigned long uaddr,
>>     :
>>     :
>>          if (locked > lock_limit && !capable(CAP_IPC_LOCK)) {
>>                  pr_err("SEV: %lu locked pages exceed the lock limit of
>> %lu.\n", locked, lock_limit);
>>                  return ERR_PTR(-ENOMEM);
>>          }
>>
>> I think it is better than nothing. How do you think?
> 
> Unprivileged user space should not be allowed to cause the kernel to
> print messages.

Hmm... Ok. I see.

Thank you for your answer!

Bye,
---
Yasunori Goto

