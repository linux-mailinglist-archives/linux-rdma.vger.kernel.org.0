Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B92783877
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Aug 2023 05:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjHVD0u (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Aug 2023 23:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjHVD0t (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Aug 2023 23:26:49 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252D3187
        for <linux-rdma@vger.kernel.org>; Mon, 21 Aug 2023 20:26:47 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RVF704Dw7zLp5Y;
        Tue, 22 Aug 2023 11:23:40 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 22 Aug 2023 11:26:43 +0800
Message-ID: <5e160eac-27f2-d020-42ba-42487bfb3ff4@huawei.com>
Date:   Tue, 22 Aug 2023 11:26:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next] RDMA/hfi1: Use list_for_each_entry() helper
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        <linux-rdma@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
References: <20230821133753.3131936-1-ruanjinjie@huawei.com>
 <d6e29395-020d-d185-9f73-c66a50bd56f1@cornelisnetworks.com>
Content-Language: en-US
From:   Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <d6e29395-020d-d185-9f73-c66a50bd56f1@cornelisnetworks.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2023/8/21 23:51, Dennis Dalessandro wrote:
> On 8/21/23 9:37 AM, Jinjie Ruan wrote:
>> Convert list_for_each() to list_for_each_entry() where applicable.
>>
>> No functional changed.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  drivers/infiniband/hw/hfi1/affinity.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/hfi1/affinity.c b/drivers/infiniband/hw/hfi1/affinity.c
>> index 77ee77d4000f..bbc957c578e1 100644
>> --- a/drivers/infiniband/hw/hfi1/affinity.c
>> +++ b/drivers/infiniband/hw/hfi1/affinity.c
>> @@ -230,11 +230,9 @@ static void node_affinity_add_tail(struct hfi1_affinity_node *entry)
>>  /* It must be called with node_affinity.lock held */
>>  static struct hfi1_affinity_node *node_affinity_lookup(int node)
>>  {
>> -	struct list_head *pos;
>>  	struct hfi1_affinity_node *entry;
>>  
>> -	list_for_each(pos, &node_affinity.list) {
>> -		entry = list_entry(pos, struct hfi1_affinity_node, list);
>> +	list_for_each_entry(entry, &node_affinity.list, list) {
>>  		if (entry->node == node)
>>  			return entry;
>>  	}
> 
> Why is this version better? Perhaps amend commit message to indicate why you are
> fixing this.

We can remove the pos var line. OK. Thank you! I'll update the message
to indicate it.

> 
> -Denny
