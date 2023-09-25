Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C907AE05D
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Sep 2023 22:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjIYUkV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Sep 2023 16:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjIYUkU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Sep 2023 16:40:20 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A813BE;
        Mon, 25 Sep 2023 13:40:14 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-57b6a7e0deeso3680798eaf.2;
        Mon, 25 Sep 2023 13:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695674414; x=1696279214; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zFWkW+GUbwj+UFJeUwl8WWtr5mj1eA4lD/2QQE/yfYo=;
        b=BKmBpb3QgftV6bfUncrW8tr4hIlaIK/e03ePzmnnYF5k4fsg5tyJw90ebpuEjJzpg+
         Fn/2jaP+KLaopldXYHjSBKE6QrlgY4AFB19eFmH/d/kv2fAvf5QgdEOb1dUEf6Ki7Tx7
         tHQESqI6SDymVupeFxeJ8GWYxYQuaNQoBZ2SXeKn04LT7WSVvZb1MCLRx5YxJ7uQp9ZS
         H21ATFQCJMHMaPoQMyy7ivXzR8sYdoaTyiJ54oqDK6tG1O9UciNcajYe3RSQyqz6wg0K
         YmCgm0BiW40pSox2DGaJUIM8Xk00Yd01WxyQs0a0hGqNXfTedupeaQcEqKJ3cheWAezN
         TLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695674414; x=1696279214;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zFWkW+GUbwj+UFJeUwl8WWtr5mj1eA4lD/2QQE/yfYo=;
        b=W7bnUfhu9HCWjLb/VOWEUPAFC3UsrlkkQbcuTd/0tFodv+632oDSfJ3SJ6W2f2C8HX
         Uey8njSeJI4UUGXK+1+4zbLdiZGqhbjLiI9Y8BN3chhEaaxe89+GzaoHBouX8AzPKrlw
         WYcMtZHdQhErvvYr2sSaRLMmj0RNNnPPUkSxZ7mAWKxBiiRscvK5k8KtzBb0VaytFpIY
         ZUeknex2Xoc3NxvxLR0Jyuw/1tO/nTnrOG7xpWnUTS4izpRSOlTvPrpWSrqq2IYQMAfu
         9++wYCuTeqV/nK90bHmzuyWbFM71GW3ToE+CSL+LBdQ1L9EEZjwgbJcPAMAvHvtVwPsK
         mBIw==
X-Gm-Message-State: AOJu0YwjoVijWDpTaH0MZboOR3zCKbgVABFtkQ4TY5Cl4fJodocQRTxQ
        CTzCwNIdqEeJYbLehxhdZW0=
X-Google-Smtp-Source: AGHT+IETd4eTp872isEprydmbYaHZ9mi9MsOy+ZFSk7PPmn/ZHC8QzVrIUkWfHZdUBwQMOPUh05TZw==
X-Received: by 2002:a4a:2511:0:b0:57b:82d2:8254 with SMTP id g17-20020a4a2511000000b0057b82d28254mr7631703ooa.3.1695674413786;
        Mon, 25 Sep 2023 13:40:13 -0700 (PDT)
Received: from ?IPV6:2603:8081:1405:679b:25ba:a435:5c4a:ae2f? (2603-8081-1405-679b-25ba-a435-5c4a-ae2f.res6.spectrum.com. [2603:8081:1405:679b:25ba:a435:5c4a:ae2f])
        by smtp.gmail.com with ESMTPSA id k6-20020a056830150600b006b9a98b9659sm1834494otp.19.2023.09.25.13.40.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 13:40:13 -0700 (PDT)
Message-ID: <98d598c3-8479-d86d-f16a-c649c8f70129@gmail.com>
Date:   Mon, 25 Sep 2023 15:40:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [bug report] blktests srp/002 hang
To:     Bart Van Assche <bvanassche@acm.org>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        'Rain River' <rain.1986.08.12@gmail.com>
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
        "leon@kernel.org" <leon@kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <dsg6rd66tyiei32zaxs6ddv5ebefr5vtxjwz6d2ewqrcwisogl@ge7jzan7dg5u>
 <5a4efe6f-d8c6-84ce-377e-eb64bcad706c@linux.dev>
 <f50beb15-2cab-dfb9-3b58-ea66e7f114a6@gmail.com>
 <fe61fdc5-ca8f-2efc-975d-46b99d66c6f5@linux.dev>
 <afc98035-1bb8-f75c-451a-8e3e39fb74aa@gmail.com>
 <6fc3b524-af7d-43ce-aa05-5c44ec850b9b@acm.org>
 <b728f4db-bafa-dd0f-e288-7e3f56e6eae8@gmail.com>
 <02d7cbf2-b17b-488a-b6e9-ebb728b51c94@acm.org>
 <b80dae29-3a7c-f039-bc35-08c6e9f91197@gmail.com>
 <CAJr_XRAy4EHueAP-10=WSEa46j2aQBArdzYsq7OqSqR93Ue+ug@mail.gmail.com>
 <8aff9124-85c0-8e3b-dc35-1017b1540037@gmail.com>
 <3c84da83-cdbb-3326-b3f0-b2dee5f014e0@linux.dev>
 <4e7aac82-f006-aaa7-6769-d1c9691a0cec@gmail.com>
 <CAJr_XRCFuv_XO3Zk+pfq6C73CgDsnaJT4-G-jq1ds3bdg76iEA@mail.gmail.com>
 <OS7PR01MB1180450455E624D5CD977C461E5FCA@OS7PR01MB11804.jpnprd01.prod.outlook.com>
 <29c5de53-cc61-4efc-8e8d-690e27756a16@acm.org>
 <114ecd0b-42b0-4c1d-8b58-280e670550be@gmail.com>
 <6bd73947-5383-4426-a932-7ef67bbaf9f1@acm.org>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <6bd73947-5383-4426-a932-7ef67bbaf9f1@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/25/23 15:33, Bart Van Assche wrote:
> On 9/25/23 12:57, Bob Pearson wrote:
>> Having trouble following your recipe. The git repo you mention does not seem to be available. E.g.
>>
>> rpearson:src$ git clone git://git.kernel.org/pub/scm/linux/git/rafael/linux-pm
>> Cloning into 'linux-pm'...
>> fatal: remote error: access denied or repository not exported: /pub/scm/linux/git/rafael/linux-pm
>>
>> I am not sure how to obtain the tag if I cannot see the repo.
> 
> As one can see on
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/,
> ".git" is missing from the end of the URL in your git clone command.
> 
> I think that you misread my email. In my email I clearly referred to
> Linus' master branch. Please try this:
> $ git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux-kernel
> $ cd linux-kernel
> $ git checkout 8018e02a8703 -b linus-master

what the email said was:

Please start with fixing the KASAN complaint shown below. I think the
root cause of this complaint is in the RDMA/rxe driver. This issue can
be reproduced as follows:
* Build and install Linus' master branch with KASAN enabled (commit
   8018e02a8703 ("Merge tag 'thermal-6.6-rc3' of
   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm")).

I found the reference to rafael/linux-pm confusing. I also tried with .git still didn't work.
Thanks for the clarification.

Bob
> 
>> If I just try to enable KASAN by setting CONFIG_KASAN=y in .config for the current linux-rdma repo
>> and compile the kernel the kernel won't boot and is caught in some kind of SRSO hell. If I checkout
>> Linus' v6.4 tag and add CONFIG_KASAN=y to a fresh .config file the kernel builds OK but when I
>> try to boot it, it is unable to chroot to the root file system in boot.
> 
> Please try to run the blktests suite in a VM. I have attached the kernel
> configuration to this email with which I observed the KASAN complaint on
> my test setup.
> 
> Thanks,
> 
> Bart.

