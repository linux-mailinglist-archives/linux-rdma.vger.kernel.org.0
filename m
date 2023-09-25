Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6487ADB60
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Sep 2023 17:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbjIYP0Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Sep 2023 11:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbjIYP0G (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Sep 2023 11:26:06 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBC41AB;
        Mon, 25 Sep 2023 08:25:59 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3ae2f8bf865so2855534b6e.2;
        Mon, 25 Sep 2023 08:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695655558; x=1696260358; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8wpoCUgdoZFtwFT0b4ltHNG+sybs4t+IMJlmNFEJUmg=;
        b=IJuI4nbI/ZIKJKZJDAB09svW1B+4A2zaw2vxIFCFxbVa5heE/fWSZbxcSKL+7Nqr9m
         WIDB2bjXle9a+frE3q7MYhrzRY4MuQke7KZH6cJ+Wq2zg0/j+hwvTFjpIg8ph/ImuOJr
         wJcwXxjFjy2BQEjz3cU/joQoW+qml9d/iKpnkjB9XIeljHc77owXyOmBX410+zG0y5eb
         k7APyh7pZYE7Qe74n30dYVVBjzqX9zy8hGnQmyABMi5o6Ln2+kKgFiQSwTDs2b7IQ7b5
         ksupvbX30IHW6wQOX+7SR7gABrEEGUzXWAbyiRDmuAgDSVhxt7qxywayz6FVr/m2Tf4T
         wBYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695655558; x=1696260358;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8wpoCUgdoZFtwFT0b4ltHNG+sybs4t+IMJlmNFEJUmg=;
        b=v57K7SlI1BIXeN2lilwmWDwoOA892mwyE2PxThJX6FbOOJhKAEdfCX1mclMbyfDSod
         ysSlKfi4SpLYJoB+He2lX/Cc5gWOHKsNwIEp3B0wzE9PfPR6GNFOwjHx8AzCK77OIX92
         fFrCLwNmVnY4It3F/2mvRsIp7PGkBgHYnV7tfQ2GJcLu6f/87Qs3C1XVVZbVHpweLyTX
         oFxsSaCKD5uX6XPMODIqC/QsOyNF45p/M5edzSLKx7cPi6ZgGDnURSfiDyLL6QXV4Qql
         il7ggwD2ZVeW9MyVasXV87Na9IgusA8ueeGTbXuUcvK+sIVnH/wtWSmFDoWELM3ewgOE
         6V7w==
X-Gm-Message-State: AOJu0Yzc+9bJfjxvdgY9hJi3oEGsHBQjREU3eX8VQkGuAXgzhaN2fgCE
        p/kW4ibV0UxQt2A1HNc1+Hk=
X-Google-Smtp-Source: AGHT+IEMe4dIunhAhttYhNYdMsGIg8dZuPZBXRq+aXUvbWlOLolr6MzOtzlIhMQiVHOEu6TBuYkx0Q==
X-Received: by 2002:a05:6808:2122:b0:3ae:a81:55a9 with SMTP id r34-20020a056808212200b003ae0a8155a9mr10433561oiw.24.1695655558279;
        Mon, 25 Sep 2023 08:25:58 -0700 (PDT)
Received: from ?IPV6:2603:8081:1405:679b:740c:28cd:7fdb:8de1? (2603-8081-1405-679b-740c-28cd-7fdb-8de1.res6.spectrum.com. [2603:8081:1405:679b:740c:28cd:7fdb:8de1])
        by smtp.gmail.com with ESMTPSA id bd15-20020a056808220f00b003a75593746asm1510230oib.57.2023.09.25.08.25.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 08:25:57 -0700 (PDT)
Message-ID: <53244849-efeb-a56b-55e1-417a19d2000a@gmail.com>
Date:   Mon, 25 Sep 2023 10:25:56 -0500
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
> https://lore.kernel.org/linux-rdma/e8b76fae-780a-470e-8ec4-c6b650793d10@leemhuis.info/T/#m0fd8ea8a4cbc27b37b042ae4f8e9b024f1871a73. I think the report in that email is a 100% proof that there is a use-after-free issue in the rdma_rxe driver. Use-after-free issues have security implications and also can cause data corruption. I propose to revert the commit that introduced the rdma_rxe use-after-free unless someone comes up with a fix for the rdma_rxe driver.
> 
> Bart.

Thanks Bart, I missed that. This will give me a better target to try to track this down.

Bob
