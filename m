Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E594760CF09
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Oct 2022 16:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbiJYOb3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Oct 2022 10:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbiJYOb2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Oct 2022 10:31:28 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E423FFFA2
        for <linux-rdma@vger.kernel.org>; Tue, 25 Oct 2022 07:31:27 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 101-20020a9d0bee000000b00661b54d945fso7768843oth.13
        for <linux-rdma@vger.kernel.org>; Tue, 25 Oct 2022 07:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KLM/X+tpHfZaOFo+/j47hSeOYbVF2gBPBAaaNV3adVM=;
        b=bVnztfLuZg9RAbo4q6d74a/8Zqg+IbFebzfscmF0L9KJJLlqwmQKmqjjk625UrQqlr
         mJRCpWUCYRF7Q8ncg2GrgPAnglb9lCNzhNLz7J4j3XmhDrAfLeOqQvp4mb8ooyU+OTuo
         lKv/AoQdWz6deCCO3p9gryo7PGTpIueBqSxiJGSG8a7SpKAWa1AgShbkCRngZXdA0NkO
         upa6aBaM1dEe1OPmcOXx6X+/L9z1dVXr+5Os3ejf4r3YOFjvlR7rpu9QAFnvI8IVPUgr
         nnDjaBNPdIh10UxK8CwYzwRzup1FFDOxOGk+oDfovlrTiBT+BNWPffytNZAmjwm2WmHM
         cEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KLM/X+tpHfZaOFo+/j47hSeOYbVF2gBPBAaaNV3adVM=;
        b=7ZzVJQrDm6+RicNCC+KpEwBZjRg636k3OCKRTOnimcZi6dIK92rm7V4zV0qMqpLTZF
         Yhci8AWtNZxcXSKa5bpb7Ggg2eEycSY7WKqf+N22VCBWLNw2PW3269oQlsAZTVo/+qRh
         zaMCagX+n5QzlkOeJbGnILDPA8xlSd/rqvTR4oIo1D2XBrN7udb1vjd9ZWzlVQBX6+vx
         bpWC8Ndr2wAOw+E03S7fOwMK5jXrDyfQHVNtMCWcGvr93s1arB06vJe/ecNHrb/6Prqj
         QwbDlyjYDXQcVn3yzB2o4+JVLBeHkcfQJirxpBwlRf0DCP6QrtUPmtJm6pNgfyU55RXC
         sxTQ==
X-Gm-Message-State: ACrzQf2LWirAqd9/FWqNYnMxx+Nc+8/I6nfGBB8YqRrXIU3D4TptuHbF
        THW4wEKDNT6NLulMWcs9xY/D7FZ9E6Y=
X-Google-Smtp-Source: AMsMyM5dng52jtuwBCVvqBJUwzAT2nHPyTJbuFC/IJW1B2skYOrCYfqK/tT+ebznxVqYmmtothy0mA==
X-Received: by 2002:a05:6830:558:b0:662:1f73:4df4 with SMTP id l24-20020a056830055800b006621f734df4mr13221431otb.46.1666708286829;
        Tue, 25 Oct 2022 07:31:26 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:5979:2555:99aa:7129? (2603-8081-140c-1a00-5979-2555-99aa-7129.res6.spectrum.com. [2603:8081:140c:1a00:5979:2555:99aa:7129])
        by smtp.gmail.com with ESMTPSA id q4-20020a05683022c400b00661a16f14a1sm1077430otc.15.2022.10.25.07.31.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 07:31:26 -0700 (PDT)
Message-ID: <d38b66a8-220e-811b-1d90-d0fa4598c695@gmail.com>
Date:   Tue, 25 Oct 2022 09:31:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH for-next v2 18/18] RDMA/rxe: Add parameters to control
 task type
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
Cc:     "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "jhack@hpe.com" <jhack@hpe.com>,
        "ian.ziemba@hpe.com" <ian.ziemba@hpe.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "haris.phnx@gmail.com" <haris.phnx@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20221021200118.2163-1-rpearsonhpe@gmail.com>
 <20221021200118.2163-19-rpearsonhpe@gmail.com>
 <TYCPR01MB845563BB1E56CFB317D4409BE5319@TYCPR01MB8455.jpnprd01.prod.outlook.com>
 <Y1fF7UcaIcwJegvH@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <Y1fF7UcaIcwJegvH@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/25/22 06:18, Jason Gunthorpe wrote:
> On Tue, Oct 25, 2022 at 09:35:01AM +0000, Daisuke Matsuda (Fujitsu) wrote:
>> On Sat, Oct 22, 2022 5:01 AM Bob Pearson:
>>>
>>> Add modparams to control the task types for req, comp, and resp
>>> tasks.
>>>
>>> It is expected that the work queue version will take the place of
>>> the tasklet version once this patch series is accepted and moved
>>> upstream. However, for now it is convenient to keep the option of
>>> easily switching between the versions to help benchmarking and
>>> debugging.
>>>
>>> Signed-off-by: Ian Ziemba <ian.ziemba@hpe.com>
>>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>>> ---
>>>  drivers/infiniband/sw/rxe/rxe_qp.c   | 6 +++---
>>>  drivers/infiniband/sw/rxe/rxe_task.c | 8 ++++++++
>>>  drivers/infiniband/sw/rxe/rxe_task.h | 4 ++++
>>>  3 files changed, 15 insertions(+), 3 deletions(-)
>>
>> <...>
>>
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
>>> index 9b8c9d28ee46..4568c4a05e85 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_task.c
>>> +++ b/drivers/infiniband/sw/rxe/rxe_task.c
>>> @@ -6,6 +6,14 @@
>>>
>>>  #include "rxe.h"
>>>
>>> +int rxe_req_task_type = RXE_TASK_TYPE_TASKLET;
>>> +int rxe_comp_task_type = RXE_TASK_TYPE_TASKLET;
>>> +int rxe_resp_task_type = RXE_TASK_TYPE_TASKLET;
>>
>> As the tasklet version is to be eliminated in near future, why
>> don't we make the workqueue version default now?
> 
> Why don't we just get rid of the tasklet version right away?
> 
> Jason

What time zone are you in? I thought you were out west.

There are several users out there who use rxe as a dev tool for other subsystems.
I don't want to make a big change that they can't control. By letting them decide
if and when to move that is avoided. I could back out the modparam and just let
people recompile but I'd end up putting it back in for our use because it is easier.

No matter what we decide to do here, there is a question I have about how to
surface tuning parameters to users. Not everyone can just recompile to make changes.
What is the preferred way to do this?

Bob
