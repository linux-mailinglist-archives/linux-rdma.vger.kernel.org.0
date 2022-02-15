Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C07C4B761D
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Feb 2022 21:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244121AbiBOUh5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Feb 2022 15:37:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239085AbiBOUh4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Feb 2022 15:37:56 -0500
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB342D76C2
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 12:37:45 -0800 (PST)
Received: by mail-pl1-f179.google.com with SMTP id j4so103353plj.8
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 12:37:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=O+YHh2iQ80kBfiIM6bf0T+d9+CuEWK6vrYgMiNjoPms=;
        b=UWD06eEnOdFKoGSTE3feYXYw9wuOXYi7o/SmQSCOYHTfVOHQWLDFVBYUUoO0DiODDA
         0X/uzYdSIIuSW+IrJV2Bn/lf4QJpNXzyo81UUydTgc8AO6wlc7IOZyT9CIhrMXNKmVdl
         yzpQEvCntU6+0aoaCPQha2HZK8+3fiGq2w1BEroUoARpSULckEJu7WBHxoC2V5+LTMH9
         IXqU5myRPWWIzqZVQ8uW0ghH7fSubOD8tESL+ZrEzcq3ldX6Y43kwBOeb9VdxCjCq9Ub
         VXqk0q8JC6duLD75POeTDI273fHY8F6ZsD7C1vNnr/TbJ2rQGgco5ExJop0pyTUZ2R4X
         e4Ew==
X-Gm-Message-State: AOAM531zCbdtRjaelr5agMEMg1WlXgrPG9HLGFOX9nvNJlusLyFlSgtL
        1lN8oHn4eLaW9wl4gEwuab8=
X-Google-Smtp-Source: ABdhPJybqC8iHXAjQF3Ao9rXY7Ar31+OrL433GaSOuM/Yg9Ah35+4FTPoU8tyHZWKcBXZl6MEjs4MQ==
X-Received: by 2002:a17:903:32d1:: with SMTP id i17mr759730plr.55.1644957465211;
        Tue, 15 Feb 2022 12:37:45 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id nl8sm9971267pjb.18.2022.02.15.12.37.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 12:37:44 -0800 (PST)
Message-ID: <a281d1be-857e-be6a-0440-648bed837d4e@acm.org>
Date:   Tue, 15 Feb 2022 12:37:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 3/3] ib_srp: Fix a deadlock
Content-Language: en-US
To:     Leon Romanovsky <leonro@mellanox.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot+831661966588c802aae9@syzkaller.appspotmail.com
References: <20220215182650.19839-1-bvanassche@acm.org>
 <20220215182650.19839-4-bvanassche@acm.org> <Ygv2OkMeJYrTwdbi@unreal>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Ygv2OkMeJYrTwdbi@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/15/22 10:51, Leon Romanovsky wrote:
> On Tue, Feb 15, 2022 at 10:26:50AM -0800, Bart Van Assche wrote:
>> diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
>> index 2db7429b42e1..8e1561a6d325 100644
>> --- a/drivers/infiniband/ulp/srp/ib_srp.c
>> +++ b/drivers/infiniband/ulp/srp/ib_srp.c
>> @@ -4044,12 +4044,10 @@ static void srp_remove_one(struct ib_device *device, void *client_data)
>>   		mutex_lock(&host->target_mutex);
>>   		list_for_each_entry(target, &host->target_list, list)
>>   			srp_queue_remove_work(target);
>> +		list_for_each_entry(target, &host->target_list, list)
>> +			flush_work(&target->tl_err_work);
> 
> Sorry for my silly question, but why do you do flush and not cancel
> here? You anyway remove SRP device, so the result of flush is not
> really important, am I right?

That's a great question. It probably doesn't matter much whether 
flush_work() or cancel_work_sync() is called in this context since 
srp_queue_remove_work() indirectly cancels tl_err_work. See also the 
following code in srp_remove_target():
  	cancel_work_sync(&target->tl_err_work);

Thanks,

Bart.
