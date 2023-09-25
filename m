Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC497AE027
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Sep 2023 21:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbjIYT5O (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Sep 2023 15:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjIYT5N (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Sep 2023 15:57:13 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032BD109;
        Mon, 25 Sep 2023 12:57:07 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6bd0a0a6766so4428814a34.2;
        Mon, 25 Sep 2023 12:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695671826; x=1696276626; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QoQR8sVnBTSW+x1TV0KYyE+v4HjgeuXZaKD4FJHjJSo=;
        b=a9KezzxbSYklS8CskGqU+Inf1LmQ4AyQ7+nsSEnbffIqCL4Qh7oajdWHM2mRtSnr26
         cFUcvXu5egueOWunrNRyb5AR7yWwBza49xkhRrYYqgUriH4IISKcnRqxQFJjM7GO2gi9
         nqMtJVwR0bExIDEbpZxjS+49p996Sw4dTTduUOFcE5Fa/++k+kjHW0KO3MAG6hZqxYwu
         L6/WGC3/O9R3Xs6wyTcemzGxztIYImRUPBD1FSIJya0rjG51ZSQJab4RlG5KfMIftfJO
         2fbTM4MsfxoaUrH7yxOc/WlY+Ge/wSbH+u8PbnFrPy9wyHaOpU4RRkJQRCcz+8SoyStb
         9u+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695671826; x=1696276626;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QoQR8sVnBTSW+x1TV0KYyE+v4HjgeuXZaKD4FJHjJSo=;
        b=NmVLcR9eVxZfYQX2uN3zqvPJqCc2Kp3KzbV3ZCzSOCU9X3FH2vxvp9GgpEh/vIu/V3
         JcnnxJTatRJMcHTZuPi7/S3S0a9CEMgsvpAXQJuuRNXUt0kb0IBF3siXljmJ6ma5dujL
         D6YSDpRRGYl3mTqi77VI68VbmxrDLh9WHxof6WppvMugrBv3pUVICsLQcWIsPWQYMPei
         zUP8ktsX3y2/JtVfXfAVR+2lZ4sKLyX+ltgRtN4jmLeq7F25TXTi9yk0w0njAhWu8Wwm
         IlzU+MtKSDyg7Al8UoFejPMsL6F3n7h7mZKv2jx8t1UBNWCx1OTFkh3x26ONJxZ4pNs9
         VdTw==
X-Gm-Message-State: AOJu0YzkRH8hys9wDO4WgeLWTcz2XE/r9xY2Mu0F674C6qOY+9DADJDO
        ie9xPCRiVvWvdfu1/wEBMNvQ5G3tagw=
X-Google-Smtp-Source: AGHT+IG/WgYat+X3VM/i5/tr0basS1RnErm9JyZT0zT8IOyp/Zd+u9HY/ZUxv4TWe638akcMM2loog==
X-Received: by 2002:a05:6830:14ca:b0:6c4:b4b0:c6c with SMTP id t10-20020a05683014ca00b006c4b4b00c6cmr8217450otq.3.1695671826203;
        Mon, 25 Sep 2023 12:57:06 -0700 (PDT)
Received: from ?IPV6:2603:8081:1405:679b:d60c:b4eb:7897:26a7? (2603-8081-1405-679b-d60c-b4eb-7897-26a7.res6.spectrum.com. [2603:8081:1405:679b:d60c:b4eb:7897:26a7])
        by smtp.gmail.com with ESMTPSA id a15-20020a9d74cf000000b006b8a0c7e14asm1819684otl.55.2023.09.25.12.57.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 12:57:05 -0700 (PDT)
Message-ID: <114ecd0b-42b0-4c1d-8b58-280e670550be@gmail.com>
Date:   Mon, 25 Sep 2023 14:57:00 -0500
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
 <d3205633-0cd2-f87e-1c40-21b8172b6da3@linux.dev>
 <nqdsj764d7e56kxevcwnq6qoi6ptuu3bi6ntfakb55vm3toda7@eo3ffzzqrot7>
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
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <29c5de53-cc61-4efc-8e8d-690e27756a16@acm.org>
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

On 9/25/23 10:00, Bart Van Assche wrote:
> On 9/24/23 21:47, Daisuke Matsuda (Fujitsu) wrote:
>> As Bob wrote above, nobody has found any logical failure in rxe
>> driver.
> 
> That's wrong. In case you would not yet have noticed my latest email in
> this thread, please take a look at
> https://lore.kernel.org/linux-rdma/e8b76fae-780a-470e-8ec4-c6b650793d10@leemhuis.info/T/#m0fd8ea8a4cbc27b37b042ae4f8e9b024f1871a73. I think the report in that email is a 100% proof that there is a use-after-free issue in the rdma_rxe driver. Use-after-free issues have security implications and also can cause data corruption. I propose to revert the commit that introduced the rdma_rxe use-after-rpearson:src$ git clone git://git.kernel.org/pub/scm/linux/git/rafael/linux-pm
Cloning into 'linux-pm'...
fatal: remote error: access denied or repository not exported: /pub/scm/linux/git/rafael/linux-pm
free unless someone comes up with a fix for the rdma_rxe driver.
> 
> Bart.

Bart,

Having trouble following your recipe. The git repo you mention does not seem to be available. E.g.

rpearson:src$ git clone git://git.kernel.org/pub/scm/linux/git/rafael/linux-pm
Cloning into 'linux-pm'...
fatal: remote error: access denied or repository not exported: /pub/scm/linux/git/rafael/linux-pm

I am not sure how to obtain the tag if I cannot see the repo.

If I just try to enable KASAN by setting CONFIG_KASAN=y in .config for the current linux-rdma repo
and compile the kernel the kernel won't boot and is caught in some kind of SRSO hell. If I checkout
Linus' v6.4 tag and add CONFIG_KASAN=y to a fresh .config file the kernel builds OK but when I
try to boot it, it is unable to chroot to the root file system in boot.

Any hints would be appreciated.

Bob

