Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1DF23F2420
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Aug 2021 02:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbhHTAhc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Aug 2021 20:37:32 -0400
Received: from esa3.hc1455-7.c3s2.iphmx.com ([207.54.90.49]:19409 "EHLO
        esa3.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233644AbhHTAhb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Aug 2021 20:37:31 -0400
IronPort-SDR: MM1HAYNZlwxV8LIpjdsj81CEmEXtAtRxmqhtIFZdOniJXe0wlgTiGG0kOhaHclYqQrDNxugRKS
 H0TrwzADzoOtSlmaXfr3K6gHpS5nK9wWskxK99clz4m+p0Rh12j3lOZaQDZo3heIM+yzXR1qsr
 jFJh144+4idQRFlI3jVrZOaQBMza293K9zzJwLiU3LRpOUnMyYYDUU8TSjqi8oQD6smQmTBXQ2
 DjyRKCncrOjEYTDjlOIwDRiDyXOhsYJo082KW7XClLihFFvFbZx6Ty322+3VFpxl/7A3OmEiXU
 H27/oYEt6Awm20m5t3sMumJF
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="40997238"
X-IronPort-AV: E=Sophos;i="5.84,336,1620658800"; 
   d="scan'208";a="40997238"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP; 20 Aug 2021 09:36:54 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 23264EB344
        for <linux-rdma@vger.kernel.org>; Fri, 20 Aug 2021 09:36:52 +0900 (JST)
Received: from m3051.s.css.fujitsu.com (m3051.s.css.fujitsu.com [10.134.21.209])
        by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 5D8C0C9CD5
        for <linux-rdma@vger.kernel.org>; Fri, 20 Aug 2021 09:36:51 +0900 (JST)
Received: from [10.133.114.24] (VPC-Y08P0560251.g01.fujitsu.local [10.133.114.24])
        by m3051.s.css.fujitsu.com (Postfix) with ESMTP id 4C07C9E;
        Fri, 20 Aug 2021 09:36:51 +0900 (JST)
Subject: Re: [PATCH] RDMA/core: EPERM should be returned when # of pined pages
 is over ulimit
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
References: <20210818082702.692117-1-y-goto@fujitsu.com>
 <20210819231053.GA390234@nvidia.com>
From:   Yasunori Goto <y-goto@fujitsu.com>
Message-ID: <f784a0c6-27b7-5e30-b3ba-e1f4ebe95399@fujitsu.com>
Date:   Fri, 20 Aug 2021 09:36:50 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20210819231053.GA390234@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2021/08/20 8:10, Jason Gunthorpe wrote:
> On Wed, Aug 18, 2021 at 05:27:02PM +0900, Yasunori Goto wrote:
>> Hello,
>>
>> When I started to use SoftRoCE, I'm very confused by
>> ENOMEM error output even if I gave enough memory.
>>
>> I think EPERM is more suitable for uses to solve error rather than
>> ENOMEM at here of ib_umem_get() when # of pinned pages is over ulimit.
>> This is not "memory is not enough" problem, because driver can
>> succeed to pin enough amount of pages, but it is larger than ulimit value.
>>
>> The hard limit of "max locked memory" can be changed by limit.conf.
>> In addition, this checks also CAP_IPC_LOCK, it is indeed permmission check.
>> So, I think the following patch.
>>
>> If there is a intention why ENOMEM is used here, please let me know.
>> Otherwise, I'm glad if this is merged.
>>
>> Thanks.
>>
>>
>> ---
>> When # of pinned pages are larger than ulimit of "max locked memory"
>> without CAP_IPC_LOCK, current ib_umem_get() returns ENOMEM.
>> But it does not mean "not enough memory", because driver could succeed to
>> pinned enough pages.
>> This is just capability error. Even if a normal user is limited
>> his/her # of pinned pages, system administrator can give permission
>> by change hard limit of this ulimit value.
>> To notify correct information to user, ib_umem_get()
>> should return EPERM instead of ENOMEM at here.
> 
> I'm not convinced, can you find other places checking the ulimit and
> list what codes they return?

Hmm, OK.

I'll investigate it.

-- 
Yasunori Goto
