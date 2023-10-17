Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A534F7CCF63
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Oct 2023 23:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjJQVjm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Oct 2023 17:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJQVjm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Oct 2023 17:39:42 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F2AA4;
        Tue, 17 Oct 2023 14:39:40 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6c65d096c96so3215845a34.1;
        Tue, 17 Oct 2023 14:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697578780; x=1698183580; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n3xdp/ZSQK3Nv/gEEqmJto72JS6hZd7fcXkPOCgmNpc=;
        b=Ti1ulYFohFLcKc5Qc/pSb+N4eFc4WvmmsitZ0LsabviYRD0AtIaQhdTVOGqeh1qpIp
         sTY8dBStB4W29PMElJUQs+ZlwU3Uluyji1j5JwR9MvJzhlpfyz8RWHZb58sXsApTEHhs
         4WKfJwhY4AuvtDLG29lrAcXlMh/XF8OfqUqUWLYGA8U8UwJNFTOOreU7w5GHd6bZb6J3
         WetYGeEa2jOVSyzZhS2oXChAFas/OMo4b1wVnXmB+THTE0v6r7owDsEG8KnSpe1z8F7N
         uuS2/blptBICcvFzGhvhJCln4UpLNdj9+qOyIuF0CD4Gib9J6oGFAMrilrmP8xu8mufK
         SgNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697578780; x=1698183580;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n3xdp/ZSQK3Nv/gEEqmJto72JS6hZd7fcXkPOCgmNpc=;
        b=Zk3UYOLmpJ4fDgPP2A4nuJ6MGPu3kGGY28T8PJJPWvCnDzJ3Yg9DglU/gQXHV1WfoB
         dtnlzYwwiKos/taOQ2Nz2Q2dTAxrE29AkwGZX5kvtrWt5DuBMEi4xTwSICx4eN9Ge2Cj
         DKaMLnizZeUA8kRu9OgV1qGryFa5h1PMzNVzwgzuqrXHfmeogaK+xxdPyWLbrvALioso
         a+TMSQPRL44uhZ3Q+oz7eBic574fpTBwtxKpwpkUP9NYTtzbyxshYes28wk8d2JFY/XJ
         2jkz85tfRI/IMEa4r8atxyeSHfrJGusiRtam+1qJjC1XgK7wWIN6mZaKq3ZiAkQGhZQZ
         2FWQ==
X-Gm-Message-State: AOJu0YxL8LprBflJ9gWyQIPbcswYlzGYxJj3YfUKZ88Nw7m/ZNp1aP8Z
        kGY/B496/b12jcBjnAuUqZA=
X-Google-Smtp-Source: AGHT+IEc3GNADKeS3gDlFFVsA2zEoh7AthUIfOxc3NagYC3NpYqfJFEAzSwYdy8EBm63uCmDVO6Rfg==
X-Received: by 2002:a05:6830:33c9:b0:6bd:9e1c:93a6 with SMTP id q9-20020a05683033c900b006bd9e1c93a6mr1971032ott.0.1697578779859;
        Tue, 17 Oct 2023 14:39:39 -0700 (PDT)
Received: from ?IPV6:2603:8081:1405:679b:1392:8eda:4bf:b7e5? (2603-8081-1405-679b-1392-8eda-04bf-b7e5.res6.spectrum.com. [2603:8081:1405:679b:1392:8eda:4bf:b7e5])
        by smtp.gmail.com with ESMTPSA id h6-20020a9d3e46000000b006ba864f5b37sm406382otg.12.2023.10.17.14.39.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 14:39:39 -0700 (PDT)
Message-ID: <bf2705ff-716a-45b5-bcc4-8710ea0fb98e@gmail.com>
Date:   Tue, 17 Oct 2023 16:39:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] blktests srp/002 hang
Content-Language: en-US
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
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <cad2fee4-9359-4614-b36b-c2599dc12358@acm.org>
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

On 10/17/23 16:30, Bart Van Assche wrote:
> 
> On 10/17/23 14:23, Bob Pearson wrote:
>> Not really, but stuck could mean it died (no threads active) or it is
>> in a loop or waiting to be scheduled. It looks dead. The lower layers are
>> waiting to get kicked into action by some event but it hasn't happened.
>> This is conjecture on my part though.
> 
> This call stack means that I/O has been submitted by the block layer and
> that it did not get completed. Which I/O request got stuck can be
> verified by e.g. running the list-pending-block-requests script that I
> posted some time ago. See also
> https://lore.kernel.org/all/55c0fe61-a091-b351-11b4-fa7f668e49d7@acm.org/.
> 
> Thanks,
> 
> Bart.

Thanks. Would this run on the side of a hung blktests or would I need to
setup an srp-srpt file system?

Bob
