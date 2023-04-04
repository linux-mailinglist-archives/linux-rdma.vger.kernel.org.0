Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A574E6D5918
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Apr 2023 09:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbjDDHDc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Apr 2023 03:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjDDHDP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Apr 2023 03:03:15 -0400
X-Greylist: delayed 14194 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 04 Apr 2023 00:03:13 PDT
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25F922D72;
        Tue,  4 Apr 2023 00:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
        Content-Type; bh=hLbeGhYUN7RnG6++2RqONKQkGZVwfn8OaLboDI884hQ=;
        b=ZjTO67EfPOZHIeqnL6m+MPONfHpZAHvRG9KZP6VJqIuAtJ3vi7Ez5DLs+Ly7HK
        suGBNPgX3xeE0/wMXGeV+I0ywRm1UhD89xE/lgvBn+KFDrGSH7A/GIiDb/J/N/5D
        rojzmrs8irpchHUbN7oPXure5hos7Pss2Hrg51E1pLZrg=
Received: from [172.20.125.11] (unknown [116.128.244.169])
        by zwqz-smtp-mta-g0-1 (Coremail) with SMTP id _____wBnX89myytkEaGrAw--.283S2;
        Tue, 04 Apr 2023 15:01:59 +0800 (CST)
Message-ID: <940e1807-7e89-4de0-ee69-9346d231a59f@126.com>
Date:   Tue, 4 Apr 2023 15:01:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] RDMA/hfi: add a judgment on the availability of cpumask
To:     Leon Romanovsky <leon@kernel.org>
Cc:     dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linkui Xiao <xiaolinkui@kylinos.cn>
References: <20230404030525.24020-1-xiaolinkui@126.com>
 <20230404060522.GH4514@unreal>
Content-Language: en-US
From:   xiaolinkui <xiaolinkui@126.com>
In-Reply-To: <20230404060522.GH4514@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: _____wBnX89myytkEaGrAw--.283S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Gw1fKFW8Wry5CrW8uF1xXwb_yoW8JF4rpF
        4fWa1j9ay5Xay0ga1ktay3ArZ8tayfJ3yqyFyqyw18XF98X3ZrX345K3WF9r97Gr4ku3WS
        qF4DXFs0kF4xAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j17KsUUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/1tbiig9H1lpEDPhFrQAAsW
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Thanks for your reply.

When CONFIG_CPUMASK_OFFSTACK=y, "ret" will be false if diff==NULL.

However, when CONFIG_CPUMASK_OFFSTACK=n, these two are not necessarily 
equivalent.

Thanks

On 4/4/23 14:05, Leon Romanovsky wrote:
> On Tue, Apr 04, 2023 at 11:05:25AM +0800, xiaolinkui wrote:
>> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>>
>> When CONFIG_CPUMASK_OFFSTACK is n, cpumask may fail to allocate, cpumask may
>> be NULL, and performing a bitmap operation on cpumask may cause problems at
>> this time.
>>
>> Of course, this is a unlikely event.
>>
>> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
>> ---
>>   drivers/infiniband/hw/hfi1/affinity.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/hfi1/affinity.c b/drivers/infiniband/hw/hfi1/affinity.c
>> index 77ee77d4000f..3caa861f4d1d 100644
>> --- a/drivers/infiniband/hw/hfi1/affinity.c
>> +++ b/drivers/infiniband/hw/hfi1/affinity.c
>> @@ -1047,16 +1047,16 @@ int hfi1_get_proc_affinity(int node)
>>   	 */
>>   
>>   	ret = zalloc_cpumask_var(&diff, GFP_KERNEL);
>> -	if (!ret)
>> +	if (!ret || unlikely(!diff))
> Why do you think that check of "ret" is not enough?
> "ret" will be false if diff == NULL.
>
> Thanks

