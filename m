Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E147CC9B2
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Oct 2023 19:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjJQRTa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Oct 2023 13:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbjJQRT3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Oct 2023 13:19:29 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2556BA;
        Tue, 17 Oct 2023 10:19:26 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3ae5a014d78so3588077b6e.1;
        Tue, 17 Oct 2023 10:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697563166; x=1698167966; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BO1qCSYMrCB4oF7MZ2vsazVrXjqry+wUmuJNldUMID8=;
        b=X/xlw5PUtV7YnHumR5JA1tpTgmMIO2iOZ4P5EWymxSEPQ+MQHxGlJhwqr2L9Z4AV1c
         X4CbXwyWPhkkFTeJEPZu3CyeD7U9dfuro0HIwAV0/ugGiZ9HwmiQwB/p9S2mZUfui5Er
         yCHQ2AVlJZMLwrgr82Zugy2wBS0wkvagz9PT27gjSlG/VS4KQBHVsyYLShbc8CZtikR+
         x2BsIItSFbVc7T3SvmZcnSclbmcFSs+JPwUnwnely0kj3JlvuJe1DI83heE70ZTK1KtE
         EcXOfy0j17Kribe4DwSbutR07NI+BSVo2VeLieP8FY+xwxNwaDmetAYPoNzRIGjbwN0b
         chZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697563166; x=1698167966;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BO1qCSYMrCB4oF7MZ2vsazVrXjqry+wUmuJNldUMID8=;
        b=rWr1WxuoL6j4Qmpsa90IXANtN3hZr9ksRO5XROaAi8fVlSEKPXaaKXjKSX7XozoDU1
         bbGrCPDOAL5ut8BW2NOpo2AWZKzfVKzkmeQUlcy98/33gT5a4FPU5hlLEh8CFOP4lwul
         +NQHOyHl7cxVXmYds4oWe2KWOMma5+HtvopQJDPtLdNmjYD6dMol7p15Qh9PGtb0Yo1Y
         nS84gs5m1WDKf766HZa3D1TTfCPp//TYC/hzzgX4eJf50yNJslkCbF9IPTKH/cqb5mOh
         Lm51x/9jfYY4rNwAt03ul+uYUEztegF7mZrqwrqdvZAYYDGVYWAdosLM5vmHxmSHQ9kj
         IlKg==
X-Gm-Message-State: AOJu0YzBtQ7TtaG6hHI7WSv79iURw0R4P9NHMuSgaM38sct7ow5uScqA
        vMxwkpEbkHQPOUFEciV4N8A=
X-Google-Smtp-Source: AGHT+IGZMaxHGHEuO+h0CSOcPKCJiNuqLl/bDDo2WWAjeythWniOhVMEMo0uNJt9fivFcDfiI2+EYQ==
X-Received: by 2002:a05:6808:288c:b0:3ad:e147:4b83 with SMTP id eu12-20020a056808288c00b003ade1474b83mr1210623oib.12.1697563166212;
        Tue, 17 Oct 2023 10:19:26 -0700 (PDT)
Received: from ?IPV6:2603:8081:1405:679b:4a90:522a:952e:515c? (2603-8081-1405-679b-4a90-522a-952e-515c.res6.spectrum.com. [2603:8081:1405:679b:4a90:522a:952e:515c])
        by smtp.gmail.com with ESMTPSA id x8-20020a544008000000b003adcaf28f61sm322300oie.41.2023.10.17.10.19.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 10:19:25 -0700 (PDT)
Message-ID: <11acd7e3-6a56-444d-827a-e06f00589b9c@gmail.com>
Date:   Tue, 17 Oct 2023 12:19:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] blktests srp/002 hang
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        'Rain River' <rain.1986.08.12@gmail.com>
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
        "leon@kernel.org" <leon@kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <dsg6rd66tyiei32zaxs6ddv5ebefr5vtxjwz6d2ewqrcwisogl@ge7jzan7dg5u>
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
 <OS7PR01MB118045AD711E93D223DCD6F17E5C3A@OS7PR01MB11804.jpnprd01.prod.outlook.com>
 <a3be5e98-e783-4108-a690-acc8a5cc5981@gmail.com>
 <fb4fae79-59a4-4fe2-93ab-24232ddbd784@acm.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <fb4fae79-59a4-4fe2-93ab-24232ddbd784@acm.org>
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

On 10/17/23 12:13, Bart Van Assche wrote:
> 
> On 10/17/23 10:09, Bob Pearson wrote:
>> I don't yet understand the logic of the srp driver to fix this but
>> the problem is not in the rxe driver as far as I can tell.
> Is there any information available that supports this conclusion? I
> think the KASAN output that I shared shows that there is an issue in
> the RXE driver.
> 
> Thanks,
> 
> Bart.
> 

Should have mentioned that the last set of tests in srp/002 have much longer
writes than the earlier ones which require a lot more processing and thus
time. My belief is that the completion logic in srp is faulty but works if
the underlying transport is fast but not if it is slow.

Bob
