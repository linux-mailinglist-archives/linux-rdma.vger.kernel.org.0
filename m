Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55ED7A1417
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Sep 2023 04:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjIODAC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Sep 2023 23:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjIODAB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Sep 2023 23:00:01 -0400
Received: from out-228.mta1.migadu.com (out-228.mta1.migadu.com [95.215.58.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7124926B8
        for <linux-rdma@vger.kernel.org>; Thu, 14 Sep 2023 19:59:57 -0700 (PDT)
Message-ID: <1c19cdc0-664e-514b-edd0-5cc6f899523b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694746795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MfFKAGYQM9dzrgcM/WOMG8JEwTGlan+/tFwrZF39G60=;
        b=Z0rjVKsJptCVUM09Iq68Ndz/kXMMX+5Ga5i5L8wGIS+TY0qrjwNQaDztObWl+vVEsTC2RI
        Uyh9TT5wtZhVOkY5u8ppfsLmP+3+69ZogQLj3oo9cF7wUgebL1DMbIPZEQJDZ+Z2C1tCWd
        NmFjep1Lg0MN3obplZ72WMPU0gvSOzs=
Date:   Fri, 15 Sep 2023 10:59:49 +0800
MIME-Version: 1.0
Subject: Re: newlines in message macros
To:     "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
References: <1fbe7ebb-6501-10c4-b9eb-8435661f6046@gmail.com>
 <20fb88a8-6c68-671c-7791-be1df6f708d6@linux.dev>
 <6a6c3491-5288-83ad-4a51-085797b2358c@fujitsu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <6a6c3491-5288-83ad-4a51-085797b2358c@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2023/9/15 9:38, Zhijian Li (Fujitsu) 写道:
> Yanjun,
>
> On 14/09/2023 07:12, Zhu Yanjun wrote:
>> 在 2023/9/14 4:50, Bob Pearson 写道:
>>> Li,
>>>
>>> I see that you removed the built-in newlines in the debug macros in rxe.h which is ok by me. But,
>> I made tests for many times about adding newline speeding up flush messages. With or without new line, I can not find out the difference on flushing messages. Not sure if Li Zhijian found this difference in a specific scenario or not.
>> And even without new line, after output the line, the message still goes to a new line. I suspect if a newline is appended in the PRINTK subsystem.
>
> When i'm using something like: `dmesg --follow` monitor the dmesg, I can notice that delay clearly.
> you will see that the timestamp is correct, but the messages don't appear until a next newline.

Thanks. To verify what you said, I made a simple tests. In my test, I 
output logs with several printk lines without newlines.

 From the test result, except the last printk line, the other printk 
lines can output logs correctly in time.

Perhaps kernel standards add newlines in the format strings. And the 
last printk without newlines can not output logs in time.

To fix this problem, I add a newline in the last printk line. Then all 
the printk logs can output correctly in time.

I think your commit and Bob's commit have added newlines in RXE.

Thanks.

Zhu Yanjun

>
> Thanks
> Zhijian
>
>
>
>> Zhu Yanjun
>>
>>> for some reason the rxe_xxx() macros all still have built-in newlines. Why shouldn't we be consistent
>>> and make them all the same. (Maybe they don't get used much or at all.)
>>>
>>> Bob
