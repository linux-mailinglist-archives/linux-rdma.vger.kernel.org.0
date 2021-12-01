Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC23464A2F
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Dec 2021 09:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242167AbhLAIzT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Dec 2021 03:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242123AbhLAIzT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 Dec 2021 03:55:19 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123C0C061748
        for <linux-rdma@vger.kernel.org>; Wed,  1 Dec 2021 00:51:59 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1638348717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jfQB64ECjiOYg+VLTzhoJZLe7atmvhjYnwpCdgwAhz4=;
        b=fdnXmBSPwsy4+NKqZDfGEHlSOG2WmYzb0V3mL0ofpbCGcmWnZHNJSTyOKbM78Pjg4XAgLP
        GwEXTtbZLa04Sr8/k6Ijag6o35aVBB+Y4UDMuyP4LsG+m9TtADJ6t+lm4KudNkIAt4YmzP
        epjaB5MIM5DTAl+0QM0bH5w/jA3TMxY=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: [PATCH V2] RDMA/rtrs: Call {get,put}_cpu_ptr to silence a debug
 kernel warning
To:     Jinpu Wang <jinpu.wang@ionos.com>,
        Christoph Lameter <cl@gentwo.org>
Cc:     haris.iqbal@ionos.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
References: <20211128133501.38710-1-guoqing.jiang@linux.dev>
 <alpine.DEB.2.22.394.2111301137560.294061@gentwo.de>
 <CAMGffEmE6789WiYbX4+XXt3ZwPCcx8AjLDDnhYJsSfb0Pu7oYg@mail.gmail.com>
Message-ID: <4d9cd15b-1adf-07aa-e115-a0da75f14a9d@linux.dev>
Date:   Wed, 1 Dec 2021 16:51:49 +0800
MIME-Version: 1.0
In-Reply-To: <CAMGffEmE6789WiYbX4+XXt3ZwPCcx8AjLDDnhYJsSfb0Pu7oYg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 11/30/21 7:03 PM, Jinpu Wang wrote:
> On Tue, Nov 30, 2021 at 11:40 AM Christoph Lameter<cl@gentwo.org>  wrote:
>> On Sun, 28 Nov 2021, Guoqing Jiang wrote:
>>
>>>        int cpu;
>>>
>>>        cpu = raw_smp_processor_id();
>>> -     s = this_cpu_ptr(stats->pcpu_stats);
>>> +     s = get_cpu_ptr(stats->pcpu_stats);
>>>        if (con->cpu != cpu) {
>>>                s->cpu_migr.to++;
>>>
>>> @@ -27,14 +27,16 @@ void rtrs_clt_update_wc_stats(struct rtrs_clt_con *con)
>>>                s = per_cpu_ptr(stats->pcpu_stats, con->cpu);
>>>                atomic_inc(&s->cpu_migr.from);
>>>        }
>>> +     put_cpu_ptr(stats->pcpu_stats);
>>>   }
>>>
>>>   void rtrs_clt_inc_failover_cnt(struct rtrs_clt_stats *stats)
>>>   {
>>>        struct rtrs_clt_stats_pcpu *s;
>>>
>>> -     s = this_cpu_ptr(stats->pcpu_stats);
>>> +     s = get_cpu_ptr(stats->pcpu_stats);
>>>        s->rdma.failover_cnt++;
>>> +     put_cpu_ptr(stats->pcpu_stats);
>> This is equivalent to
>>
>> this_cpu_inc(stats->pcpu_stats.rdma.failover_cnt);
>>
>> Which will also reduce the segment to a single cpu instruction.
> Thanks for your suggestion, Christoph.

Good suggestion!

> As the patch is already applied, I will send a new patch as suggested.

Thanks for it.

Cheers,
Guoqing
