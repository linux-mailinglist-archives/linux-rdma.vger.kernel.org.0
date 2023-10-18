Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855D97CE672
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Oct 2023 20:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjJRS3Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Oct 2023 14:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbjJRS3V (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Oct 2023 14:29:21 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE36132;
        Wed, 18 Oct 2023 11:29:19 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3add37de892so3938119b6e.1;
        Wed, 18 Oct 2023 11:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697653758; x=1698258558; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aQOvZtuibLSkGmRbO42pWVDTIb0Cub+AQsJn2NWBZxQ=;
        b=YTmq0RnK3TUrHf2q/Q7k5MwTqMLFA9kWjgytFl6Vqzl14TMFogjtYDxjkI9ciIAtDQ
         J5zPbVBPNRGPK1kwh4p727pwu6m2ncJLtcEnc9RPhzR8/M1e4+DwI1hRX68vQqis7cZU
         hC7yS53PQVaiftokWyXKejq8a6F+UmlqAqtIBBhOZ9muzzIErXEVece+GTxY/Edg1Yfj
         EO19Pddl55OAmKHSgalV+fopYI7a7o3+5n6676ca8vSAP+OsdnAhFpSICWtxvKgmG8tz
         lYwSamShTi1/Woia+UVWfRDW7lLPqZTIgYXwPqpDozav7sakUflCss4brPapF9y920ke
         x47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697653758; x=1698258558;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aQOvZtuibLSkGmRbO42pWVDTIb0Cub+AQsJn2NWBZxQ=;
        b=NPz0KvpXzpEbLKeNha3INpSHYOtBIMx1CLAT43dccF7GppSTVz68MivGrZXsDOU5kG
         93SbM93Nw/B02e7gnBLHlA6Wmxbs7EVg8W4zM/KW9dMLDOmwv73d2Hy1jM29tCLDqTUq
         vGQmoxUJ/XC79yPCGhb3MVtKyeyEIizjllsGvMtcHbK2ER9yGVT77S9s/Ze2UiJRFA0K
         QO2KWl7s5HrR73Gx728ZN/6KlDWUosKiQ+kvsLlB9DoIvpmG05UsH4OF+zz9zeIdysWN
         7AKxMGLP9OZUvbo7+RA4RS7lKX03JfeAsR/qI0RnTBMzacV6qyfcDO6NlfpXfJqzxl0C
         /MPA==
X-Gm-Message-State: AOJu0Yy3uaGfIbki2eEDTEEmAusARRDwwLHo+9rZDpVyPNjFIfM3gN68
        x1bSfgUYNiY1X+Lg27f99qjE5OQSifE=
X-Google-Smtp-Source: AGHT+IE0Zipsf5Rf98DZ4PEcBJhTe/O42MPJ24DEEOGvQ7Ww0+IvSvWbg4we2PaTMDSZad1sGk4Maw==
X-Received: by 2002:a05:6808:1b12:b0:3b2:f5be:4fd5 with SMTP id bx18-20020a0568081b1200b003b2f5be4fd5mr1149oib.14.1697653758532;
        Wed, 18 Oct 2023 11:29:18 -0700 (PDT)
Received: from ?IPV6:2603:8081:1405:679b:c49f:728c:9f77:79f? (2603-8081-1405-679b-c49f-728c-9f77-079f.res6.spectrum.com. [2603:8081:1405:679b:c49f:728c:9f77:79f])
        by smtp.gmail.com with ESMTPSA id p12-20020a9d4e0c000000b006b1570a7674sm731827otf.29.2023.10.18.11.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 11:29:17 -0700 (PDT)
Message-ID: <dbd9f019-693f-476c-aa4c-739746753d2b@gmail.com>
Date:   Wed, 18 Oct 2023 13:29:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] blktests srp/002 hang
To:     Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
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
 <c65f92b2-9821-4349-b1f5-7dc2a287946a@gmail.com>
 <08a8d947-25b5-434c-9ba3-282d298b5bfd@acm.org>
 <e3d91c4f-b124-4031-9f92-fcb61973a645@gmail.com>
 <02cd10fd-fd4a-4ad7-9b1d-6d37b070aacf@acm.org>
 <5c6e69b3-f83b-461d-a08a-37bfbd82f995@gmail.com>
 <cad2fee4-9359-4614-b36b-c2599dc12358@acm.org>
 <bf2705ff-716a-45b5-bcc4-8710ea0fb98e@gmail.com>
 <65b871ef-dd93-4bfb-bae9-c147a87c64d0@acm.org>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <65b871ef-dd93-4bfb-bae9-c147a87c64d0@acm.org>
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

On 10/17/23 17:42, Bart Van Assche wrote:
> On 10/17/23 14:39, Bob Pearson wrote:
>> On 10/17/23 16:30, Bart Van Assche wrote:
>>>
>>> On 10/17/23 14:23, Bob Pearson wrote:
>>>> Not really, but stuck could mean it died (no threads active) or it is
>>>> in a loop or waiting to be scheduled. It looks dead. The lower layers are
>>>> waiting to get kicked into action by some event but it hasn't happened.
>>>> This is conjecture on my part though.
>>>
>>> This call stack means that I/O has been submitted by the block layer and
>>> that it did not get completed. Which I/O request got stuck can be
>>> verified by e.g. running the list-pending-block-requests script that I
>>> posted some time ago. See also
>>> https://lore.kernel.org/all/55c0fe61-a091-b351-11b4-fa7f668e49d7@acm.org/.
>>
>> Thanks. Would this run on the side of a hung blktests or would I need to
>> setup an srp-srpt file system?
> 
> I propose to analyze the source code of the component(s) that you
> suspect of causing the hang. The output of the list-pending-block-
> requests script is not sufficient to reveal which of the following
> drivers is causing the hang: ib_srp, rdma_rxe, ib_srpt, ...
> 
> Thanks,
> 
> Bart.
> 

Bart,

Another data point. I had seen (months ago) that both the rxe and siw drivers could cause blktests srp
hangs. More recently when I configure my kernel to run lots of tests (lockdep, memory leaks, kasan, ubsan,
etc.), which definitely slows performance and adds delays, the % of srp/002 runs which hang on the rxe driver
has gone from 10%+- to a solid 100%. This suggested retrying the siw driver on the debug kernel since it
has the reputation of always running successfully. I now find that siw also hangs solidly on srp/002.
This is another hint that we are seeing a timing issue.

Bob 
