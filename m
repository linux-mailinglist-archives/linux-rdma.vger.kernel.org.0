Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1420A7C428E
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Oct 2023 23:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbjJJV30 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Oct 2023 17:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjJJV3Z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Oct 2023 17:29:25 -0400
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA39E9E;
        Tue, 10 Oct 2023 14:29:22 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1bf55a81eeaso42545195ad.0;
        Tue, 10 Oct 2023 14:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696973362; x=1697578162;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qNoyW4WC52fOBWt2Af8kKNQcs1FacIUXQN9B8eKE2SU=;
        b=jVJeGbJBsDTkfg+lNIle65FbpGmvIY8+LntQVMJbG3UyYw72VKcnsnHZVrKhGsiRfo
         nqc8b7DGzFavXaOU17OFUCAMWEZK8JPryzq/vJ3ncQu7hO3Exk5VJYQOFSZoQx6MPs8W
         6s1vObO8xxFMg0koiodh8L5+yUkXZPzgsZACOZwF/mbpdVcBaD2VQAQKeVM00cZP6l6A
         ijNV5pA/2YqtBuTCrihyApSgzESFK0xWLQUNhX2CITuBsvsWwzBNtZ9hvzBWy561fkNI
         esd9Nfi6M53mOSjMrJjliS3wERVK74QGZO4c1UewFdcp/VUp/vwrD+RnUF+HzL944w4E
         AeqQ==
X-Gm-Message-State: AOJu0YxB9On7pcp0NdET2CE/b+bculZYvl3RNFlOQh8CkgohSWlXCbyM
        sb8k22+0TOzh0m3AKAGsEvU=
X-Google-Smtp-Source: AGHT+IEFgF0UhxBUfnoHx+/ZCxSrZHJ2FENboA9VLlJzd0To8wH0g9nKcrYoSw5++SgrtHNKZcEgHA==
X-Received: by 2002:a17:902:e5cf:b0:1c6:349e:fa43 with SMTP id u15-20020a170902e5cf00b001c6349efa43mr20837525plf.67.1696973361994;
        Tue, 10 Oct 2023 14:29:21 -0700 (PDT)
Received: from ?IPV6:2601:647:4d7e:54f3:667:4981:ffa1:7be1? ([2601:647:4d7e:54f3:667:4981:ffa1:7be1])
        by smtp.gmail.com with ESMTPSA id e1-20020a17090301c100b001c613091aeesm12184199plh.293.2023.10.10.14.29.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 14:29:21 -0700 (PDT)
Message-ID: <a4808fa6-5bd5-4a64-a437-6a7e89ca7e9f@acm.org>
Date:   Tue, 10 Oct 2023 14:29:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] Revert "RDMA/rxe: Add workqueue support for rxe
 tasks"
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
Cc:     'Zhu Yanjun' <yanjun.zhu@linux.dev>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Zhu Yanjun <yanjun.zhu@intel.com>
References: <b7b365e3-dd11-bc66-dace-05478766bf41@gmail.com>
 <2d5e02d7-cf84-4170-b1a3-a65316ac84ee@acm.org>
 <2fcef3c8-808e-8e6a-b23d-9f1b3f98c1f9@linux.dev>
 <552f2342-e800-43bc-b859-d73297ce940f@acm.org>
 <20231004183824.GQ13795@ziepe.ca>
 <c0665377-d2be-e4b6-3d25-727ef303d26e@linux.dev>
 <20231005142148.GA970053@ziepe.ca>
 <6a730dad-9d81-46d9-8adc-764d00745b01@acm.org>
 <a8453889-3f5f-49ff-89f2-ec0ef929d915@linux.dev>
 <OS3PR01MB9865F9BEB1A90DDCAEEBFC8BE5CDA@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <20231010160919.GC55194@ziepe.ca>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231010160919.GC55194@ziepe.ca>
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

On 10/10/23 09:09, Jason Gunthorpe wrote:
> On Tue, Oct 10, 2023 at 04:53:55AM +0000, Daisuke Matsuda (Fujitsu) wrote:
> 
>> Solution 1: Reverting "RDMA/rxe: Add workqueue support for rxe tasks"
>> I see this is supported by Zhu, Bart and approved by Leon.
>>
>> Solution 2: Serializing execution of work items
>>> -       rxe_wq = alloc_workqueue("rxe_wq", WQ_UNBOUND, WQ_MAX_ACTIVE);
>>> +       rxe_wq = alloc_workqueue("rxe_wq", WQ_HIGHPRI | WQ_UNBOUND, 1);
>>
>> Solution 3: Merging requester and completer (not yet submitted/tested)
>> https://lore.kernel.org/all/93c8ad67-f008-4352-8887-099723c2f4ec@gmail.com/
>> Not clear to me if we should call this a new feature or a fix.
>> If it can eliminate the hang issue, it could be an ultimate solution.
>>
>> It is understandable some people do not want to wait for solution 3 to be submitted and verified.
>> Is there any problem if we adopt solution 2?
>> If so, then I agree to going with solution 1.
>> If not, solution 2 is better to me.
> 
> I also do not want to go backwards, I don't believe the locking is
> magically correct under tasklets. 2 is painful enough to continue to
> motivate people to fix this while unbreaking block tests.

In my opinion (2) is not a solution. Zhu Yanjun reported test failures with
rxe_wq = alloc_workqueue("rxe_wq", WQ_UNBOUND, 1). Adding WQ_HIGHPRI probably
made it less likely to trigger any race conditions but I don't believe that
this is sufficient as a solution.

> I'm still puzzled why Bob can't reproduce the things Bart has seen.

Is this necessary? The KASAN complaint that I reported should be more than
enough for someone who is familiar with the RXE driver to identify and fix
the root cause. I can help with testing candidate fixes.

Thanks,

Bart.

