Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6977CCCAF
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Oct 2023 21:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjJQTzc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Oct 2023 15:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJQTzb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Oct 2023 15:55:31 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3749E;
        Tue, 17 Oct 2023 12:55:29 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3b2b1b25547so2839660b6e.3;
        Tue, 17 Oct 2023 12:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697572529; x=1698177329; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AN+o8N8+ZrTyxanSVEh3rLah/9rM9L9OqBxebaPR13g=;
        b=JeCNeUukB4cHH312tEOhtSFlZtjVQI8AUc05VjcBRiNef2DoVhFHB+fdSlDfoIgWcB
         IfKl4e68Avprw1tL6CXyQbdLX0QkyFuUIywk/YBsi+quzJwspXDY+HCyVRESv0/UHLwF
         887yLXrv4uXBIilWP9RbkilWl9dcfhKehvvPxSHZnuve7fw8JjNT3d9kB+BVgUKXt/b9
         UhCSqs5vzucw8STL2GSDa9v4N1kGs3J8qtis82ZiDb+6jUkeYDc+ORtVNc4qrXZFQxnz
         vp77h38Wt5oWeOTj98Wpqu3RSbHpFcwQZdzlp8/4UYzA6vgG1y8wrB0LOq9RxeJwPfvW
         7n/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697572529; x=1698177329;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AN+o8N8+ZrTyxanSVEh3rLah/9rM9L9OqBxebaPR13g=;
        b=SM02PttFW5c+bLB8M7f4cmTVtb7FRYzTxBuo2UoOnrLnWtQNJ8xg6X2dQjjrWgs6qx
         vHW1Pqp+c5jVnmaav3JxWpAcnCnkDPEx4CVqdRdqkLsISLPZP5WfcK6lKpMU38meiTrh
         gae6sv0gMTDJWpSqnsOai6/Kalx/AVe9IbSNteoRYS4t+IC2WUGMGAZ1QjduM65EivMU
         wqWUchGu2bglTahJTbE5dbiC1rWaZvlxwmOGL0mC2qRyJHOe7TBA+km60ldVIrCT0OX2
         WgJJTXeFgw2Z/0e/n1XdlIRX0a6StT8koQ6SH+A5nYoffz8ZWbzC+iKUIrCCIzlzINDK
         HWig==
X-Gm-Message-State: AOJu0YwPzEIoSSkGtLZmlwDcxL5C1xGjWAmlslBq9oPq0NcEmbBc1nH9
        CESWE8OkQher4xyXlYYdquS0B61NVdU=
X-Google-Smtp-Source: AGHT+IFwm0r8NmN8dba8gFvUUDPRsXIzJavtCxAJ6oFIkTTm5s1yHfYL6tRm6nx9VZsnZnLxK5pUlg==
X-Received: by 2002:a05:6808:2a05:b0:3a7:1e3e:7f97 with SMTP id ez5-20020a0568082a0500b003a71e3e7f97mr3415502oib.4.1697572529022;
        Tue, 17 Oct 2023 12:55:29 -0700 (PDT)
Received: from ?IPV6:2603:8081:1405:679b:df16:3427:4702:c8fd? (2603-8081-1405-679b-df16-3427-4702-c8fd.res6.spectrum.com. [2603:8081:1405:679b:df16:3427:4702:c8fd])
        by smtp.gmail.com with ESMTPSA id bk39-20020a0568081a2700b003b2e3e0284fsm131128oib.53.2023.10.17.12.55.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 12:55:28 -0700 (PDT)
Message-ID: <c65f92b2-9821-4349-b1f5-7dc2a287946a@gmail.com>
Date:   Tue, 17 Oct 2023 14:55:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] blktests srp/002 hang
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        'Bart Van Assche' <bvanassche@acm.org>,
        'Rain River' <rain.1986.08.12@gmail.com>,
        Zhu Yanjun <yanjun.zhu@linux.dev>,
        "leon@kernel.org" <leon@kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <8aff9124-85c0-8e3b-dc35-1017b1540037@gmail.com>
 <3c84da83-cdbb-3326-b3f0-b2dee5f014e0@linux.dev>
 <4e7aac82-f006-aaa7-6769-d1c9691a0cec@gmail.com>
 <CAJr_XRCFuv_XO3Zk+pfq6C73CgDsnaJT4-G-jq1ds3bdg76iEA@mail.gmail.com>
 <OS7PR01MB1180450455E624D5CD977C461E5FCA@OS7PR01MB11804.jpnprd01.prod.outlook.com>
 <29c5de53-cc61-4efc-8e8d-690e27756a16@acm.org>
 <OS7PR01MB118045AD711E93D223DCD6F17E5C3A@OS7PR01MB11804.jpnprd01.prod.outlook.com>
 <a3be5e98-e783-4108-a690-acc8a5cc5981@gmail.com>
 <20231017175821.GG282036@ziepe.ca>
 <8801fc68-0e8e-4bb1-acaa-597bf72a567d@gmail.com>
 <20231017185139.GA691768@ziepe.ca>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20231017185139.GA691768@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/17/23 13:51, Jason Gunthorpe wrote:
> On Tue, Oct 17, 2023 at 01:44:58PM -0500, Bob Pearson wrote:
>> On 10/17/23 12:58, Jason Gunthorpe wrote:
>>> On Tue, Oct 17, 2023 at 12:09:31PM -0500, Bob Pearson wrote:
>>>
>>>  
>>>> For qp#167 the call to srp_post_send() is followed by the rxe driver
>>>> processing the send operation and generating a work completion which
>>>> is posted to the send cq but there is never a following call to
>>>> __srp_get_rx_iu() so the cqe is not received by srp and failure.
>>>
>>> ? I don't see this funcion in the kernel?  __srp_get_tx_iu ?
>>>  
>>>> I don't yet understand the logic of the srp driver to fix this but
>>>> the problem is not in the rxe driver as far as I can tell.
>>>
>>> It looks to me like __srp_get_tx_iu() is following the design pattern
>>> where the send queue is only polled when it needs to allocate a new
>>> send buffer - ie the send buffers are pre-allocated and cycle through
>>> the queue.
>>>
>>> So, it is not surprising this isn't being called if it is hung - the
>>> hang is probably something that is preventing it from even wanting to
>>> send, which is probably a receive side issue.
>>>
>>> Followup back up from that point to isolate what is the missing
>>> resouce to trigger send may bring some more clarity.
>>>
>>> Alternatively if __srp_get_tx_iu() is failing then perhaps you've run
>>> into an issue where it hit something rare and recovery does not work.
>>>
>>> eg this kind of design pattern carries a subtle assumption that the rx
>>> and send CQ are ordered together. Getting a rx CQ before a matching tx
>>> CQ can trigger the unusual scenario where the send side runs out of
>>> resources.
>>>
>>> Jason
>>
>> In all the traces I have looked at the hang only occurs once the final
>> send side completions are not received. This happens when the srp
>> driver doesn't poll (i.e. call ib_process_cq_direct). The rest is
>> my conjecture. Since there are several (e.g. qp#167 through qp#211 (odd))
>> qp's with missing completions there are 23 iu's tied up when srp hangs.
>> Your suggestion makes sense as why the hang occurs. When the test
>> finishes the qp's are destroyed and the driver calls ib_process_cq_direct
>> again which cleans up the resources.
>>
>> The problem is that there isn't any obvious way to find a thread related
>> to the missing cqe to poll for them. I think the best way to fix this is
>> to convert the send side cq handling to interrupt driven (as is the case
>> with the srpt driver.) The provider drivers have to run in any case to
>> convert cqe's to wc's so there isn't much penalty to call the cq
>> completion handler since there is already software running and then you
>> will get reliable delivery of completions.
> 
> Can you add tracing to show that SRP is running out of SQ resources,
> ie __srp_get_tx_iu() fails and that is a precondition for the hang?
> 
> I am fully willing to belive that is not ever tested.
> 
> Otherwise if srp thinks it has SQ resources then the SQ is probably
> not the cause of the hang.
> 
> Jason

Well.... the extra tracing did *not* show srp running out of iu's.
So I converted cq handling to IB_POLL_SOFTIRQ from IB_POLL_DIRECT.
This required adding a spinlock around list_add(&iu->list, ...) in 
srp_send_done(). The test now runs with all the completions handled
correctly. But, it still hangs. So a red herring.

The hunt continues.

Bob
