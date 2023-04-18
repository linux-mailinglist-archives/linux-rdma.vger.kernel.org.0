Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131796E5EFA
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Apr 2023 12:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjDRKhL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Apr 2023 06:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbjDRKhJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Apr 2023 06:37:09 -0400
Received: from out-63.mta1.migadu.com (out-63.mta1.migadu.com [95.215.58.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4B3358C
        for <linux-rdma@vger.kernel.org>; Tue, 18 Apr 2023 03:37:05 -0700 (PDT)
Message-ID: <4cdbda13-3de2-8643-ff4b-1213321bd3a4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1681814223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hPZOwIpNZySZu3yJDMfJ6E5StvqjiLKJ3mVvgNAPn4A=;
        b=oOE9KcuH09RW4dlbHosl3FCft3YsCZ+goXxD5yr238KqRwUY+pTJb1fftSxVMxGBwhZtcU
        ZkMppE22CKkp8zW0B48ZJ46GY9h7qUiF2qewCe91GB6LEgquGaMchPp6lBBQJE2bvo+rz0
        o/IO7I6j446ax4rbz/TyMvdTutv/6VE=
Date:   Tue, 18 Apr 2023 18:36:54 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] RDMA/rxe: Add function name to the logs
To:     Leon Romanovsky <leon@kernel.org>,
        Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
References: <20230410102105.1084967-1-yanjun.zhu@intel.com>
 <20230418080807.GD9740@unreal>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20230418080807.GD9740@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2023/4/18 16:08, Leon Romanovsky 写道:
> On Mon, Apr 10, 2023 at 06:21:05PM +0800, Zhu Yanjun wrote:
>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>
>> Add the function names to the pr_ logs. As such, if some bugs occur,
>> with function names, it is easy to locate the bugs.
>>
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>> ---
>>   drivers/infiniband/sw/rxe/rxe.h       |  2 +-
>>   drivers/infiniband/sw/rxe/rxe_queue.h | 12 ++++--------
>>   2 files changed, 5 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rxe.h
>> index 2415f3704f57..43742d2f32de 100644
>> --- a/drivers/infiniband/sw/rxe/rxe.h
>> +++ b/drivers/infiniband/sw/rxe/rxe.h
>> @@ -10,7 +10,7 @@
>>   #ifdef pr_fmt
>>   #undef pr_fmt
>>   #endif
>> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>> +#define pr_fmt(fmt) KBUILD_MODNAME ": %s: " fmt, __func__
>>   
>>   #include <linux/skbuff.h>
>>   
>> diff --git a/drivers/infiniband/sw/rxe/rxe_queue.h b/drivers/infiniband/sw/rxe/rxe_queue.h
>> index c711cb98b949..5d6e17b00e60 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_queue.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_queue.h
>> @@ -185,8 +185,7 @@ static inline void queue_advance_producer(struct rxe_queue *q,
>>   	case QUEUE_TYPE_FROM_CLIENT:
>>   		/* used by rxe, client owns the index */
>>   		if (WARN_ON(1))
>> -			pr_warn("%s: attempt to advance client index\n",
>> -				__func__);
>> +			pr_warn("attempt to advance client index\n");
> Delete all if (WARN_ON(1)) pr_warn(...) in favour of plain WARN_ON().
> It will give you all information which you need.

Got it. Thanks a lot. I will fix it ASAP.

Zhu Yanjun

>
> Thanks
