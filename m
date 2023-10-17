Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474927CCF4D
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Oct 2023 23:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbjJQVbB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Oct 2023 17:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJQVa7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Oct 2023 17:30:59 -0400
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD20FA;
        Tue, 17 Oct 2023 14:30:58 -0700 (PDT)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-57f02eeabcaso3824795eaf.0;
        Tue, 17 Oct 2023 14:30:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697578258; x=1698183058;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vs4sJkjGIIvXlkiSuc3gAKR4kU2spfVYopwaIq3+a3E=;
        b=epNDPcEOVQgTuwKVaF0PCTT0G9svkC9O9nWO2suOdEdMYa9y6OQUJmj/Hj9qXUZt7+
         hKBqj3Dkj2chlqB5cKJtSTvYO99R7fHzVc/wcQysJdwdhqMpb8II0QnjnekOST5bUU+x
         bVJPKcJMBdahavCSqM340Zv+GUpjn1Q6qj+7Q34QQlxYTQwg0na0oVAyssgr32elFBqp
         aWRZbLQzX6rgTxiZUgqd00Z6uy5/C5qzWtuEzoI5+7qFtS6smJTmxEm+PNWz7UPS9uH5
         wZ3nzQni9meDb9mTlRjSPSGg4rlmS2mKrfAJlb+ZyrdEpOxKqQa7E7a9sx+B693WyJ3u
         /sTA==
X-Gm-Message-State: AOJu0YxCXaaz9iQemAnJbYp8+5TbkgTfzMuhhiVNJOTZoQ1GH7l/jcSI
        NQdVNvSRsjf1Gulz4HI9Nrs=
X-Google-Smtp-Source: AGHT+IHrKM1zHzHtAlNWxvRg248SwcQQpf39h84WOUd4c7UuoT+rUJaFCKpkF8lM5yJq+naU0STMDQ==
X-Received: by 2002:a05:6359:59d:b0:145:6433:8224 with SMTP id ee29-20020a056359059d00b0014564338224mr3566861rwb.18.1697578257597;
        Tue, 17 Oct 2023 14:30:57 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:8f02:2919:9600:ac09? ([2620:15c:211:201:8f02:2919:9600:ac09])
        by smtp.gmail.com with ESMTPSA id f15-20020aa7968f000000b006933f657db3sm1926286pfk.21.2023.10.17.14.30.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 14:30:57 -0700 (PDT)
Message-ID: <cad2fee4-9359-4614-b36b-c2599dc12358@acm.org>
Date:   Tue, 17 Oct 2023 14:30:55 -0700
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
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <5c6e69b3-f83b-461d-a08a-37bfbd82f995@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 10/17/23 14:23, Bob Pearson wrote:
> Not really, but stuck could mean it died (no threads active) or it is
> in a loop or waiting to be scheduled. It looks dead. The lower layers are
> waiting to get kicked into action by some event but it hasn't happened.
> This is conjecture on my part though.

This call stack means that I/O has been submitted by the block layer and
that it did not get completed. Which I/O request got stuck can be
verified by e.g. running the list-pending-block-requests script that I
posted some time ago. See also
https://lore.kernel.org/all/55c0fe61-a091-b351-11b4-fa7f668e49d7@acm.org/.

Thanks,

Bart.
