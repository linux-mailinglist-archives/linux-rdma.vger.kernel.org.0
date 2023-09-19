Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783A27A5ABE
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Sep 2023 09:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjISHV0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Sep 2023 03:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjISHVZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Sep 2023 03:21:25 -0400
Received: from out-219.mta0.migadu.com (out-219.mta0.migadu.com [91.218.175.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAE2114
        for <linux-rdma@vger.kernel.org>; Tue, 19 Sep 2023 00:21:19 -0700 (PDT)
Message-ID: <0fc1eca0-edc2-1b23-de4f-0f792cfa861f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695108077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5KBrgL80kH4WGHtKDary01ptvnGdRGX/l/LFf5cUCYc=;
        b=bONMMKOHeLIjmZWaWDnnYhQGLm/z7dLvLKaG9czKDTcYXuEuE+k4HNsFDuB9z4D/bOUdLe
        g0dDHAWR7xQiVJpwYylH3YE/HvNTQ1Jq4hjyr3Ezpm3Xa4so9Mj8XIk6V+q2oEVOMQK+6o
        ueUNhj6jKqU27rK5YZ0R0yyLm5uboUA=
Date:   Tue, 19 Sep 2023 15:21:10 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] RDMA/rtrs: Require holding rcu_read_lock explicitly
To:     Leon Romanovsky <leon@kernel.org>,
        Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org
References: <20230918153646.338878-1-yanjun.zhu@intel.com>
 <20230919070941.GA4494@unreal>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20230919070941.GA4494@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2023/9/19 15:09, Leon Romanovsky 写道:
> On Mon, Sep 18, 2023 at 11:36:46PM +0800, Zhu Yanjun wrote:
>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>
>> No functional change. The function get_next_path_rr needs to hold
>> rcu_read_lock. As such, if no rcu read lock, warnings will pop out.
>>
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>> ---
>>   drivers/infiniband/ulp/rtrs/rtrs-clt.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
>> index b6ee801fd0ff..bc4b70318bf4 100644
>> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
>> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
>> @@ -775,7 +775,7 @@ rtrs_clt_get_next_path_or_null(struct list_head *head, struct rtrs_clt_path *clt
>>    * Related to @MP_POLICY_RR
>>    *
>>    * Locks:
>> - *    rcu_read_lock() must be hold.
>> + *    rcu_read_lock() must be held.
>>    */
>>   static struct rtrs_clt_path *get_next_path_rr(struct path_it *it)
>>   {
>> @@ -783,6 +783,11 @@ static struct rtrs_clt_path *get_next_path_rr(struct path_it *it)
>>   	struct rtrs_clt_path *path;
>>   	struct rtrs_clt_sess *clt;
>>   
>> +	/*
>> +	 * Assert that rcu lock must be held
>> +	 */
>> +	WARN_ON_ONCE(!rcu_read_lock_held());
> Let's use RCU_LOCKDEP_WARN(..) macro.

Got it. Will send v2 very soon.

Zhu Yanjun

>
> Thanks
>
>> +
>>   	clt = it->clt;
>>   
>>   	/*
>> -- 
>> 2.40.1
>>
