Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409B57377FB
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jun 2023 01:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjFTXkn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jun 2023 19:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjFTXki (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Jun 2023 19:40:38 -0400
Received: from out-44.mta0.migadu.com (out-44.mta0.migadu.com [91.218.175.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0A61713
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jun 2023 16:40:33 -0700 (PDT)
Message-ID: <b117397c-2cc7-2c56-f54a-5ac8d7fd1ed6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687304430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IJFXHJYI+oUm5yQD5zUt28v9qr/UQqEutUwXGaX5VFI=;
        b=Iyh3VYR8wmswHn5P/bmWjZp9mC4HQomcPz4FxX2tFQTUfCyNkZwAt1qneFVHRuM3jak8Nq
        R9Umlg5nqS60neL15t5UhBQQnigQuhch1cTjhLesxhpEfZAItBDTpbzSi/W452PylP9APZ
        CsL/m6pGy9JDqdZXksQ19nNpxp5EMVY=
Date:   Wed, 21 Jun 2023 07:40:23 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v6.4-rc1 v5 1/8] RDMA/rxe: Creating listening sock in
 newlink function
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Zhu Yanjun <yanjun.zhu@intel.com>, zyjzyj2000@gmail.com,
        jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
        parav@nvidia.com, lehrer@gmail.com
Cc:     Rain River <rain.1986.08.12@gmail.com>
References: <20230508075636.352138-1-yanjun.zhu@intel.com>
 <20230508075636.352138-2-yanjun.zhu@intel.com>
 <677fb641-4b48-48d0-f4de-e42707e7eae3@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <677fb641-4b48-48d0-f4de-e42707e7eae3@gmail.com>
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


在 2023/6/21 1:16, Bob Pearson 写道:
> On 5/8/23 02:56, Zhu Yanjun wrote:
>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>
>> Originally when the module rdma_rxe is loaded, the sock listening on udp
>> port 4791 is created. Currently moving the creating listening port to
>> newlink function.
>>
>> So when running "rdma link add" command, the sock listening on udp port
>> 4791 is created.
>>
>> Tested-by: Rain River <rain.1986.08.12@gmail.com>
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>> ---
>>   drivers/infiniband/sw/rxe/rxe.c | 10 ++++------
>>   1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
>> index 7a7e713de52d..89b24bc34299 100644
>> --- a/drivers/infiniband/sw/rxe/rxe.c
>> +++ b/drivers/infiniband/sw/rxe/rxe.c
>> @@ -194,6 +194,10 @@ static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
>>   		goto err;
>>   	}
>>   
>> +	err = rxe_net_init();
>> +	if (err)
>> +		return err;
>> +
> If you put this here you cannot create more than one rxe device.
> E.g. if you type
>
> sudo rdma link add rxe0 type rxe netdev enp6s0
> sudo rdma link add rxe1 type rxe netdev lo
>
> the second call will fail. This worked before this patch. Maybe you will fix later but
> by itself this patch breaks the driver.

Hi, Bob

Thanks a lot for your code review.

I made tests. The followings are results. If we add the secode rxe1, the 
second rxe can be created.

# rdma link add rxe0 type rxe netdev eno12399np0
# rdma link add rxe1 type rxe netdev ens7f1np1
# rdma link

link rxe0/1 state ACTIVE physical_state LINK_UP netdev eno12399np0
link rxe1/1 state ACTIVE physical_state LINK_UP netdev ens7f1np1

And the followings are the port 4791 after rxe devices are created.

# ss -lun
State              Recv-Q Send-Q                            Local 
Address:Port                            Peer Address:Port             
Process
...
UNCONN             0 0 0.0.0.0:4791                                 
0.0.0.0:*
...
UNCONN             0 0 [::]:4791                                    [::]:*
..

# rdma link del rxe0
# rdma link del rxe1

After the rxe devices are removed, the port 4791 is removed.

# ss -lun | grep 4791
State              Recv-Q Send-Q                            Local 
Address:Port                            Peer Address:Port             
Process

Zhu Yanjun

>
> Bob
>>   	err = rxe_net_add(ibdev_name, ndev);
>>   	if (err) {
>>   		rxe_err("failed to add %s\n", ndev->name);
>> @@ -210,12 +214,6 @@ static struct rdma_link_ops rxe_link_ops = {
>>   
>>   static int __init rxe_module_init(void)
>>   {
>> -	int err;
>> -
>> -	err = rxe_net_init();
>> -	if (err)
>> -		return err;
>> -
>>   	rdma_link_register(&rxe_link_ops);
>>   	pr_info("loaded\n");
>>   	return 0;
