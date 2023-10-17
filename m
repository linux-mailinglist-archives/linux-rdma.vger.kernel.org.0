Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E4E7CCDAA
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Oct 2023 22:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjJQUNm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Oct 2023 16:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjJQUNl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Oct 2023 16:13:41 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D766FAA;
        Tue, 17 Oct 2023 13:13:39 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6c7c2c428c1so3532456a34.0;
        Tue, 17 Oct 2023 13:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697573618; x=1698178418; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SyNuCTmDxruo10FzGNPlkd245oBKv5bpN0xadku2BrA=;
        b=UFceJ8/lfvE+ozNsg7WegCEzTbJhDClxaaSOpgtej+Py2x2PaY/de6/TP3gpad9W/a
         F37cZ5dBwzutAqvx5n46SsrJ0Ys81dz5Hd+ktguovXgvEOdte7/YIPDyUYKpczHg3dce
         8KZ3pgAlmzgDNuIvAEyTu2mX5MjYjZDyQkmrszyWf/07M70ysJmOCZMbLlNAMZ/Edppi
         1rtbr8W4aZeM4o47EvMtw94wz+adkxO0jrz9u/obxrSCpMptfPJw9dYaaFB63t01xUWq
         0rnheBI9G0kHpGumifNUBxX5pG8Nx4LcPQ1Ee0Uu02GGudAEwpwM5OgzV9TR1mIayih3
         9EKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697573618; x=1698178418;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SyNuCTmDxruo10FzGNPlkd245oBKv5bpN0xadku2BrA=;
        b=kBU1gyO8kQ/JWalIi4KQUGYR4QQJyGL7KZzboMsEgBx8VuDFjlb842Y0XxcWlO50Oz
         qACtd5kdBsMjh4gjTxsAcXbdjo45iqxvRpg5Cs1U8Ch//xCaHnedAAiNeArfmDE4+VA4
         4ihE13csokPmBDWbp/NsRpabo0nuJlOkfsUnN2VSMXVmWp+LsFWk+TzoFmz8yylgUc36
         JQOqUWoBiVQXBpoQ/pNvTFRPrlIaYNbGIbU9uXqDMC8Tzjs6swMKX4t3MDvcqBFw37ZY
         DF30htJZuGs25qVeamoPgaxW98XZLJU/cc7QCYxpJfCh9mp01oeo4L6NMnoju2J0wvWN
         o/IQ==
X-Gm-Message-State: AOJu0YxY2dVBuU1h842CbIpkWrlS2JxVWtQQ/8YwD/rJ9CcXmYUS4Eww
        6BYa0FMe6/nX12L8hlapolE=
X-Google-Smtp-Source: AGHT+IEIEqTvfVWZH0EYqqx5Ti9sCz00wMJpGTRHY/O4/ua+uA+/eJsB8Qn1NjjguFp250Qd+tjjvQ==
X-Received: by 2002:a05:6830:2695:b0:6bc:d5a5:c2f with SMTP id l21-20020a056830269500b006bcd5a50c2fmr1931840otu.9.1697573618648;
        Tue, 17 Oct 2023 13:13:38 -0700 (PDT)
Received: from ?IPV6:2603:8081:1405:679b:df16:3427:4702:c8fd? (2603-8081-1405-679b-df16-3427-4702-c8fd.res6.spectrum.com. [2603:8081:1405:679b:df16:3427:4702:c8fd])
        by smtp.gmail.com with ESMTPSA id e1-20020a056830200100b006c65f431799sm378130otp.23.2023.10.17.13.13.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 13:13:38 -0700 (PDT)
Message-ID: <1177045c-1d7d-4435-8a6d-1deefc78c197@gmail.com>
Date:   Tue, 17 Oct 2023 15:13:36 -0500
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
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <08a8d947-25b5-434c-9ba3-282d298b5bfd@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/17/23 15:06, Bart Van Assche wrote:
> On 10/17/23 12:55, Bob Pearson wrote:
>> Well.... the extra tracing did *not* show srp running out of iu's.
>> So I converted cq handling to IB_POLL_SOFTIRQ from IB_POLL_DIRECT.
>> This required adding a spinlock around list_add(&iu->list, ...) in
>> srp_send_done(). The test now runs with all the completions handled
>> correctly. But, it still hangs. So a red herring.
> 
> iu->list manipulations are protected by ch->lock. See also the
> lockdep_assert_held(&ch->lock) statements in the code that does
> manipulate this list and that does not grab ch->lock directly.
> 
> Thanks,
> 
> Bart.

Thanks. Saw that. I just added ch->lock'ing around the list_add. It
works if you don't call ib_process_cq_direct which was inside
the lock and use poll_softirq instead which runs on it's own thread.

Bob
