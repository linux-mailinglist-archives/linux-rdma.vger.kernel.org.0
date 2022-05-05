Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A21551B6AD
	for <lists+linux-rdma@lfdr.de>; Thu,  5 May 2022 05:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241620AbiEEDuI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 May 2022 23:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiEEDuH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 May 2022 23:50:07 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CF81A820
        for <linux-rdma@vger.kernel.org>; Wed,  4 May 2022 20:46:29 -0700 (PDT)
Subject: Re: Encountering errors while using RNBD over rxe for v5.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1651722387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g6nN2AtvqiLpCDn+2KFmJkMWa/bq722vK0yt4L7Y4Oc=;
        b=i1hSkdUykWsctSECIWimxymS5yE79TEeur28zqQcvx0h1Y4dLnyHLyEqPibq4aCD6FJw5F
        ki8/sgpMcbHEqs/WZBtNtF+MqYnj/Mr/xiJYK/IFhf+El/Jtmo7Y81mcHBV9+i6N2QDT8p
        Ti5Q8SNEhR0hW9tp4v3NuiISyP3gfFo=
To:     Haris Iqbal <haris.iqbal@ionos.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        yanjun.zhu@linux.dev, Jinpu Wang <jinpu.wang@ionos.com>
References: <CAJpMwygqY4qwXfHd88wYs+KdKDEB=z=CzFd7jTVos-S3XNT5Yg@mail.gmail.com>
 <95d12c5b-83bb-dce6-750a-3827118b9aaf@linux.dev>
 <CAJpMwyhuOOgub4xxd6nB64c37yC82ogZCX4LB6WkUb721odLjQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <df08efe8-5914-e64b-3c18-4b5f906fcea1@linux.dev>
Date:   Thu, 5 May 2022 11:46:24 +0800
MIME-Version: 1.0
In-Reply-To: <CAJpMwyhuOOgub4xxd6nB64c37yC82ogZCX4LB6WkUb721odLjQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 5/4/22 10:22 PM, Haris Iqbal wrote:
>
>>> We observe the following error,
>>>
>>> [Fri Mar 25 19:08:03 2022] rtrs_client L353: <blya>: Failed
>>> IB_WR_LOCAL_INV: WR flushed
>>> [Fri Mar 25 19:08:03 2022] rtrs_client L333: <blya>: Failed
>>> IB_WR_REG_MR: WR flushed
>>> [Fri Mar 25 19:08:03 2022] rtrs_client L333: <blya>: Failed
>>> IB_WR_REG_MR: WR flushed
>>> [Fri Mar 25 19:08:34 2022] rtrs_client L353: <blya>: Failed
>>> IB_WR_LOCAL_INV: WR flushed
>>> [Fri Mar 25 19:08:34 2022] rtrs_client L353: <blya>:*Failed IB_WR_LOCAL_INV: WR flushed*
>> I got similar message but I am not certain it is the same one, pls see
>> the previous report,
>>
>> https://lore.kernel.org/linux-rdma/20220210073655.42281-1-guoqing.jiang@linux.dev/
> I went through the emails, and the error looks similar but I am not
> sure if its related. The change to write_lock_bh was done after v5.14
> I think, and the code where I am seeing this error still has irq
> versions of those lock (e.g. write_lock_irqsave).

The lock is irrelevant, pls check

https://lore.kernel.org/linux-rdma/473a53b6-9ab2-0d48-a9cf-c84b8dc4c3f3@linux.dev/

and

https://lore.kernel.org/linux-rdma/3b6ddb23-6dfa-29e2-27fd-741c1e3e576d@linux.dev/

But I am not certain it is the same issue.

Thanks,
Guoqing
