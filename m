Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7C97ADC68
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Sep 2023 17:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbjIYPy5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Sep 2023 11:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIYPy4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Sep 2023 11:54:56 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8DEFF;
        Mon, 25 Sep 2023 08:54:49 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3ae0b0e9a68so4328731b6e.0;
        Mon, 25 Sep 2023 08:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695657289; x=1696262089; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nDBWJ5qIfhgcDJRMeFqq9dX2YjSZjr1KhMt1SfqJ0lk=;
        b=YXzioI12t4Q250HfrDvesK1l0FnsJwEwUtZXckZ2T9S9ym1zJ0SLrIjWAa/6YgFiLl
         5SMf4Yi41OkBFQMD8Pkq9gnZ1yBdXllq30lDIxM2Fwm56/wRBStCAhjDvaIqNAVU3gfa
         YbCSBTlw645p5hpqGjpHVcOTRIjkG4vNDjiLFhE9Dqs0EawzUEQTUJWoQ2qA6pZldw73
         vVtOCHqQB+bUzM0PzktJe2nCVaQsg7eVHZuUNPeGgCjEw1pwMGUlysgPXDy3u8It7TlQ
         xcYcOk0tuc0D8sVbwm81GeF438gN3WC6UaCXgNOMwBrp2u8hRvc9k9GCs5nI7EyFFA32
         4ecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695657289; x=1696262089;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nDBWJ5qIfhgcDJRMeFqq9dX2YjSZjr1KhMt1SfqJ0lk=;
        b=jrWaNkpZv1mRRzCftuSW8F6HP+tjNsuNnKDF+BYaUH1HM7opcDkCj4ePdModGERmB1
         wd5lmNx4o/vk6Sh2xeqyYz5yOs4ynm303QhZGRrHBC+7itgkPMcX2O1+KPtmaUzkPwNU
         lkmxjvCOCIwnpVzTHx6k/ZKiDT+GvSH6aPc+QSMLlAPShG5BpHGGw6Df41jOZXoPkjR9
         U4Q6V3Lln2LgSVUMkbvHk6U3Pq5qbkV2dmptcXYcEcWY553BniEuq0TkW57kAF430QuC
         NC6ZFSsGV1spZnF7otjbKjGSQmfV5SPHlNvPNWwFpVkS7Y7US/12IfwCpatBABmXAPke
         8veQ==
X-Gm-Message-State: AOJu0YxN1auO6JINqbaaVfxws8CzmVgDRs+tuZpQcL8pfeu187op02NT
        VY73+Y3LWp9ZxpRwk/mWw3E=
X-Google-Smtp-Source: AGHT+IF1XHKYpEIGDvo3tVyCp8uqlj5XNeBAOldVMfSqbQnRafls4xOrZnIW9J4S7cQlc/SpDtjfWQ==
X-Received: by 2002:a05:6870:290:b0:1be:f7d8:e7a2 with SMTP id q16-20020a056870029000b001bef7d8e7a2mr9088420oaf.21.1695657288973;
        Mon, 25 Sep 2023 08:54:48 -0700 (PDT)
Received: from ?IPV6:2603:8081:1405:679b:740c:28cd:7fdb:8de1? (2603-8081-1405-679b-740c-28cd-7fdb-8de1.res6.spectrum.com. [2603:8081:1405:679b:740c:28cd:7fdb:8de1])
        by smtp.gmail.com with ESMTPSA id ef19-20020a0568701a9300b001dd0ff401edsm719073oab.51.2023.09.25.08.54.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 08:54:48 -0700 (PDT)
Message-ID: <f2ebde46-3db0-3736-1c03-2b6947af87e5@gmail.com>
Date:   Mon, 25 Sep 2023 10:54:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [bug report] blktests srp/002 hang
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        'Rain River' <rain.1986.08.12@gmail.com>,
        Zhu Yanjun <yanjun.zhu@linux.dev>,
        "leon@kernel.org" <leon@kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <b728f4db-bafa-dd0f-e288-7e3f56e6eae8@gmail.com>
 <02d7cbf2-b17b-488a-b6e9-ebb728b51c94@acm.org>
 <b80dae29-3a7c-f039-bc35-08c6e9f91197@gmail.com>
 <CAJr_XRAy4EHueAP-10=WSEa46j2aQBArdzYsq7OqSqR93Ue+ug@mail.gmail.com>
 <8aff9124-85c0-8e3b-dc35-1017b1540037@gmail.com>
 <3c84da83-cdbb-3326-b3f0-b2dee5f014e0@linux.dev>
 <4e7aac82-f006-aaa7-6769-d1c9691a0cec@gmail.com>
 <CAJr_XRCFuv_XO3Zk+pfq6C73CgDsnaJT4-G-jq1ds3bdg76iEA@mail.gmail.com>
 <OS7PR01MB1180450455E624D5CD977C461E5FCA@OS7PR01MB11804.jpnprd01.prod.outlook.com>
 <29c5de53-cc61-4efc-8e8d-690e27756a16@acm.org>
 <20230925155222.GL13795@ziepe.ca>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20230925155222.GL13795@ziepe.ca>
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

On 9/25/23 10:52, Jason Gunthorpe wrote:
> On Mon, Sep 25, 2023 at 08:00:39AM -0700, Bart Van Assche wrote:
>> On 9/24/23 21:47, Daisuke Matsuda (Fujitsu) wrote:
>>> As Bob wrote above, nobody has found any logical failure in rxe
>>> driver.
>>
>> That's wrong. In case you would not yet have noticed my latest email in
>> this thread, please take a look at
>> https://lore.kernel.org/linux-rdma/e8b76fae-780a-470e-8ec4-c6b650793d10@leemhuis.info/T/#m0fd8ea8a4cbc27b37b042ae4f8e9b024f1871a73.
>> I think the report in that email is a 100% proof that there is a
>> use-after-free issue in the rdma_rxe driver. Use-after-free issues have
>> security implications and also can cause data corruption. I propose to
>> revert the commit that introduced the rdma_rxe use-after-free unless someone
>> comes up with a fix for the rdma_rxe driver.
> 
> I should say I'm not keen on reverting improvements to rxe. This stuff
> needs to happen eventually. Let's please try hard to fix it.
> 
> Jason
I'm digging into Bart's kasan bug. Hope to find something.

Bob
