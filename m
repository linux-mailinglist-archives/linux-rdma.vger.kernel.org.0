Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59987CD013
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Oct 2023 00:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjJQWnC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Oct 2023 18:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJQWnB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Oct 2023 18:43:01 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9293DC6;
        Tue, 17 Oct 2023 15:43:00 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1c9d407bb15so52418135ad.0;
        Tue, 17 Oct 2023 15:43:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697582580; x=1698187380;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qA/CJbPoGdWoJZcG4YdRHMYpbxeSagOoqg60ZPsmRXs=;
        b=H/zkW6tiMehxTzAXE9q+AoUiVZgC9YM1YqKlmWtL+N0nIsWfo5RprxvOj+xMDISKlG
         MDA/9zv1WJteajvbYX8Yh751KLxNF6OJRPwNrllR3Eqxe/9ByyfIT2injKoLYSzAZy9A
         /7LZP+YbTMLmmtejokgCnw+WFb/r4qCHPQaQFdG1cWfX/jy8A+STYqEyDWkTni2UTS7G
         0yDuEam/Q60ELGtMp5u5SqKbj/ld7VNfVrtmM6roP/lK+L+yn7sUeX5nOnQH2w6Kia0H
         FmHaReafjnUTtlXecvv8S1ByxtiVlf0xrFJH6pOgE41LoJVAbGX9r9Y9A0/rteU5eai6
         nYNQ==
X-Gm-Message-State: AOJu0YwTgH27+4AhdtkfYnT+TrcbF29MY/k1c9xsYMNBw5GjIYoFxRi5
        HUXJFVnxPpHx8OUk2DLkFiU=
X-Google-Smtp-Source: AGHT+IGIThTl+39yky+2mrlw0uX5joN3+viEGcXHgW0bQJT3qH1zgyge2UZdGjwzXflo4klLC1k9yg==
X-Received: by 2002:a17:902:e401:b0:1c9:cc3a:7b3 with SMTP id m1-20020a170902e40100b001c9cc3a07b3mr3011840ple.54.1697582579800;
        Tue, 17 Oct 2023 15:42:59 -0700 (PDT)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id x4-20020a170902ea8400b001c3be750900sm2113447plb.163.2023.10.17.15.42.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 15:42:59 -0700 (PDT)
Message-ID: <65b871ef-dd93-4bfb-bae9-c147a87c64d0@acm.org>
Date:   Tue, 17 Oct 2023 15:42:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] blktests srp/002 hang
Content-Language: en-US
To:     Bob Pearson <rpearsonhpe@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>
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
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <bf2705ff-716a-45b5-bcc4-8710ea0fb98e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/17/23 14:39, Bob Pearson wrote:
> On 10/17/23 16:30, Bart Van Assche wrote:
>>
>> On 10/17/23 14:23, Bob Pearson wrote:
>>> Not really, but stuck could mean it died (no threads active) or it is
>>> in a loop or waiting to be scheduled. It looks dead. The lower layers are
>>> waiting to get kicked into action by some event but it hasn't happened.
>>> This is conjecture on my part though.
>>
>> This call stack means that I/O has been submitted by the block layer and
>> that it did not get completed. Which I/O request got stuck can be
>> verified by e.g. running the list-pending-block-requests script that I
>> posted some time ago. See also
>> https://lore.kernel.org/all/55c0fe61-a091-b351-11b4-fa7f668e49d7@acm.org/.
> 
> Thanks. Would this run on the side of a hung blktests or would I need to
> setup an srp-srpt file system?

I propose to analyze the source code of the component(s) that you
suspect of causing the hang. The output of the list-pending-block-
requests script is not sufficient to reveal which of the following
drivers is causing the hang: ib_srp, rdma_rxe, ib_srpt, ...

Thanks,

Bart.

