Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C46F7D149C
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Oct 2023 19:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377794AbjJTRND (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Oct 2023 13:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjJTRNB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Oct 2023 13:13:01 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2435713E;
        Fri, 20 Oct 2023 10:13:00 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6ce2cc39d12so698027a34.1;
        Fri, 20 Oct 2023 10:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697821979; x=1698426779; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pdPGwaKRdGE/w4r8akBxgKi2XRVWEKZzBVOjcRG+JQo=;
        b=OrtITqKgqb/nTbaH5UQitjTv5tX65OFJzqzNl46TqxrOAni4hJ/sNLqMw8KYeBmf9u
         swAviiIvJIYDjxZeb4tigbRuKrzXOibdxjSVcPcWnQKiYL1cS2gXT3vcLDqZx5u1W74e
         +sD1+oWf5lfUGHnJA7km6OjKsnIM3Y6Ce67Jh4OCCiAkyPawEepQIpft1OXLEpR68xxi
         lNAksNToR/3h8L6lW8GOUAZF52SlcA0CFNeTEbSqfiqwpC0HVe/8imIPZb2SYYMZwt/C
         ZxqO2jLUwtm8FO1LzB262GPstqhIVq/RfmN9Q0q3UhA5Sg7EBvdDeW5yu75lIVtWNqi4
         u4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697821979; x=1698426779;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pdPGwaKRdGE/w4r8akBxgKi2XRVWEKZzBVOjcRG+JQo=;
        b=wypYn1tgfJUK5xRxPrkqfn5m/cWNor2/JkMIr9ZCNskbpdrG7rEdf7H1moyvwPQqoF
         6s8ZNzriC+pktxcAn6gGsQfV9nyPb3jTq1Ej0Sxc6c1/30CH2LHYPNNlI0Im1IAXvEfc
         wPhVc7yp4BXq5IuWUa8Jg6fZDzNziOXaJiWNZP7Eqvf5Oq4EUlmMUiAtAWURK0Ijy6wR
         nT12YieQWZ0u1L4krFKnZFyTJvjID5RKXl1R/mOVeDlFNV9Yf3CwvzURMtls3/b7f2zD
         32ClJ5U3V1jDY0/AJZSvZR+/UTXQDt8ag+9qFfJkLVbqsWE2cMdvFhLo6QbwUl4IGk0d
         uF2A==
X-Gm-Message-State: AOJu0YwGeDGfmn9jsLkTZ4AbxtM3W1JQefqwjIu+63xZt6QjDgACmFwZ
        5y/H4omeI+L5VdIxnI40IQ232xPgiFk=
X-Google-Smtp-Source: AGHT+IHGE29dCsXw3dqxk9C2KohpzikeIgfz6tB5sDeORx4q/lFRzKBZ+zJdt2nAzen0NW5s0OMkDw==
X-Received: by 2002:a05:6830:140e:b0:6ce:2c8e:79f0 with SMTP id v14-20020a056830140e00b006ce2c8e79f0mr2657813otp.21.1697821979346;
        Fri, 20 Oct 2023 10:12:59 -0700 (PDT)
Received: from ?IPV6:2603:8081:1405:679b:cc9c:918b:ea56:7dce? (2603-8081-1405-679b-cc9c-918b-ea56-7dce.res6.spectrum.com. [2603:8081:1405:679b:cc9c:918b:ea56:7dce])
        by smtp.gmail.com with ESMTPSA id s5-20020a056830148500b006b9443ce478sm384512otq.27.2023.10.20.10.12.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 10:12:58 -0700 (PDT)
Message-ID: <0d8cfab5-f956-4758-858c-2cc16082e64b@gmail.com>
Date:   Fri, 20 Oct 2023 12:12:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] blktests srp/002 hang
To:     Bart Van Assche <bvanassche@acm.org>,
        "Pearson, Robert B" <robert.pearson2@hpe.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        'Rain River' <rain.1986.08.12@gmail.com>,
        Zhu Yanjun <yanjun.zhu@linux.dev>,
        "leon@kernel.org" <leon@kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <20231017185139.GA691768@ziepe.ca>
 <c65f92b2-9821-4349-b1f5-7dc2a287946a@gmail.com>
 <08a8d947-25b5-434c-9ba3-282d298b5bfd@acm.org>
 <e3d91c4f-b124-4031-9f92-fcb61973a645@gmail.com>
 <02cd10fd-fd4a-4ad7-9b1d-6d37b070aacf@acm.org>
 <5c6e69b3-f83b-461d-a08a-37bfbd82f995@gmail.com>
 <cad2fee4-9359-4614-b36b-c2599dc12358@acm.org>
 <bf2705ff-716a-45b5-bcc4-8710ea0fb98e@gmail.com>
 <65b871ef-dd93-4bfb-bae9-c147a87c64d0@acm.org>
 <dbd9f019-693f-476c-aa4c-739746753d2b@gmail.com>
 <20231018191735.GC691768@ziepe.ca>
 <8e7dbd64-856d-47cc-9d2f-73aa101afa11@acm.org>
 <fb5f6da5-5017-440d-9cb5-38796554366c@gmail.com>
 <6f5ed2dd-3809-4805-8d31-de24f3f14486@acm.org>
 <MW4PR84MB2307BE5EEC6DF51918FCCDF1BCD5A@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
 <7ea5a4b0-26b8-4521-a53b-99cbdb02c594@acm.org>
 <eab9460f-d8ae-4479-ad42-ffdeb377c0d2@gmail.com>
 <5f8a5236-2a31-44b4-ae54-b723b229a7ed@acm.org>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <5f8a5236-2a31-44b4-ae54-b723b229a7ed@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/19/23 14:17, Bart Van Assche wrote:
> On 10/18/23 14:52, Bob Pearson wrote:
>> results are slightly ambiguous but I ran the command here:
>>
>> rpearson:blktests$ sudo use_siw=1 ./check srp/002
>> srp/002 (File I/O on top of multipath concurrently with logout and login (mq)) [failed]time  245.018s  ...
>>      runtime  245.018s  ...  128.110s
>>      --- tests/srp/002.out    2023-02-15 12:07:40.675530344 -0600
>>      +++ /home/rpearson/src/blktests/results/nodev/srp/002.out.bad    2023-10-18 16:36:14.723323257 -0500
>>      @@ -1,2 +1 @@
>>       Configured SRP target driver
>>      -Passed
>> rpearson:blktests$
>>
>> And while it was hung I ran the following:
>>
>> root@rpearson-X570-AORUS-PRO-WIFI: dmsetup ls | while read a b; do dmsetup message $a 0 fail_if_no_path; done
>> device-mapper: message ioctl on mpatha-part1  failed: Invalid argument
>> Command failed.
>> device-mapper: message ioctl on mpatha-part2  failed: Invalid argument
>> Command failed.
>> device-mapper: message ioctl on mpathb-part1  failed: Invalid argument
>> Command failed.
>>
>> mpath[ab]-part[12] are multipath devices (dm-1,2,3) holding the Ubuntu system images and not the devices created
>> by blktests. When this command finished the srp/002 run came back life but did not succeed (see above)
>>
>> The dmesg log is attached
> 
> Hi Bob,
> 
> Thank you for having shared these results. The 'dmsetup message' command
> should only be applied to multipath devices created by the srp/002
> script and not to the multipath devices created by Ubuntu but I'm not
> sure how to do that.
> 
> If the above 'dmsetup message' command resolved the hang, that indicates
> that the root cause of the hang is probably in user space and not in the
> kernel. Did you use the Ubuntu version of multipathd or a self-built
> version of multipathd? I remember that last time I ran the SRP tests on
> an Ubuntu system that I had to replace Ubuntu's multipathd with a self-built binary to make the tests pass.
> 
> Thanks for having shared the dmesg output. I don't think it is possible to derive the root cause from that output, which is unfortunate.
> 
> Thanks,
> 
> Bart.
> 

Bart,

The results from yesterday are from Ubuntu 23.04 which has multipath-tools at version 0.8.8.
Ubuntu 23.10 has version 0.9.4. Github has head of tree at 0.9.6. Do you recall which version
made it work when you were looking at this? It may be less risky for me to upgrade to
Ubuntu 23.10 than try and build multipath-tools from source.

Bob
