Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9487F7CCF1E
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Oct 2023 23:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344199AbjJQVXl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Oct 2023 17:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344026AbjJQVXc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Oct 2023 17:23:32 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63337C4;
        Tue, 17 Oct 2023 14:23:31 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1dcfb21f9d9so3791236fac.0;
        Tue, 17 Oct 2023 14:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697577810; x=1698182610; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fq+KvJbYkwgRFoRKWvtxgAKVht/e5ta3QaOcVsPqWm8=;
        b=JHoghUUOsnMX6Zm4QzYGsKeg/sdAfRV/xR6JKRJVAM6yTlO9AbvZIm80gPAXa4CD4X
         EyLH4Lonz+n/XCrJVy69zYhOp3Lh6idzZoznoKTISN7O7Lfp/HQZNrwCckobycD+TYLi
         n/QsC1/LivEkOErG9dZHUE7aOGt9CknA10C54yKv/JF3Y6khBAqyjRwtd9hUkvPOf2zk
         BcAL+JdDJEQCmvpNQjzGZdGTuT9wPYmoF4Qqrmh2O9e0Ty4YjHea8kETCacAeq0XASsi
         BIOMqclVcUWaeeBNeQG/lloSv3Z2QtSkYMk7CFh7rRbZpt9wMbDYPG6qY9LTBwsqKXpr
         ZjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697577810; x=1698182610;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fq+KvJbYkwgRFoRKWvtxgAKVht/e5ta3QaOcVsPqWm8=;
        b=GYiXBanQPAD664LA4eDtfCTsQKqrjAWteT52h7AbG4qE1mqJ/1xi1cEUyC+YlGjqni
         qx8LhZYz3PnRUjeaiAHZObjst9ojMrV179a+nTl1NIJbX0rwmMvw/vKxnX0/6HVHlwER
         RO4KNqmW124FiFmrOxBcO06+R6x3TpN0Si3jbKw3OGOdf6KlhXuRN+9aS+yaDax7+NRl
         +MLwob/lcOnw/leHTuAbq7W/vhSl8avkXxm86MJHDHJswYevyBCvXtB9ArWreoAEkXDu
         M/b0EIg1o7TqYr71BktueNxMF9N1gTgSTJipIXR7dHqCERtqUstgmFj6clbexAvZnL2r
         T7Lw==
X-Gm-Message-State: AOJu0Yx2cgTLHAu7P5K5HN8VPsfPmniHt5bel1baCER5zLuZvIYa1NYD
        5A/Zaw1tijgZi6WlVMtPO6U=
X-Google-Smtp-Source: AGHT+IEKi3AEwdBGrJ0jVFErrADz7areQwR5fvAOyp0/VBfPLkFJZ3I7tej+115l4OwPeFrXbyBTIA==
X-Received: by 2002:a05:6870:a40c:b0:1d5:b2ba:bc93 with SMTP id m12-20020a056870a40c00b001d5b2babc93mr4070080oal.13.1697577810707;
        Tue, 17 Oct 2023 14:23:30 -0700 (PDT)
Received: from ?IPV6:2603:8081:1405:679b:1392:8eda:4bf:b7e5? (2603-8081-1405-679b-1392-8eda-04bf-b7e5.res6.spectrum.com. [2603:8081:1405:679b:1392:8eda:4bf:b7e5])
        by smtp.gmail.com with ESMTPSA id eb42-20020a056870a8aa00b001e9c2edd8b7sm413469oab.17.2023.10.17.14.23.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 14:23:30 -0700 (PDT)
Message-ID: <5c6e69b3-f83b-461d-a08a-37bfbd82f995@gmail.com>
Date:   Tue, 17 Oct 2023 16:23:29 -0500
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
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <02cd10fd-fd4a-4ad7-9b1d-6d37b070aacf@acm.org>
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

On 10/17/23 16:18, Bart Van Assche wrote:
> 
> On 10/17/23 14:14, Bob Pearson wrote:
>> All the active threads are just the same and are all waiting for
>> an io to complete from scsi. No threads are active in rxe, srp(t)
>> or scsi. All activity appears to be dead.
> 
> Is this really a clue? I have seen such backtraces many times. All
> such a backtrace tells us is that something got stuck in a layer
> under the filesystem. It does not tell us which layer caused
> command processing to get stuck.
> 
> Bart.
> 

Not really, but stuck could mean it died (no threads active) or it is
in a loop or waiting to be scheduled. It looks dead. The lower layers are
waiting to get kicked into action by some event but it hasn't happened.
This is conjecture on my part though.

Bob
