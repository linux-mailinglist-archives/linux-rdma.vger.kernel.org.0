Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542357CE7DF
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Oct 2023 21:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjJRTiv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Oct 2023 15:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjJRTiq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Oct 2023 15:38:46 -0400
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A6295;
        Wed, 18 Oct 2023 12:38:45 -0700 (PDT)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6b1e46ca282so5657027b3a.2;
        Wed, 18 Oct 2023 12:38:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697657924; x=1698262724;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c2R09yB3AceP/zzmxTFxjhidmeTBiWOsqmVEWs/2t2s=;
        b=qna8egyolOhHc8yIw3mMgZXuqxEXiVq133C+UA2ZAy4ItjTDx9gdrorkyMfMpRVEje
         65QRcP02H0gRobodDTFQ65sWrMcmLH0/YddwxC6USEap0Gvf5F0cnEkOQTFtML9dRMwM
         2/6rRWS4qgRjpRrlp6tEOJVv/9tr5J67EiAyGT4ZJ4E0jxCUq3yktFon9k1Q+rUefO/K
         d59r7lVI60tzMlKpk7s662zNOSZARrpNdB0LoLxxpp1mY2UZrtpTwUCTBqkwRStAN09i
         nHkIsV3YL2hS/UMLIFIcRrN9mB74iIycYcg70nJ+C2dP8PZhjWUlBwod98rnhAwrZMi4
         6zJA==
X-Gm-Message-State: AOJu0Ywa8zFveLH3hw5fV+PDv2QouShDRMt7Jgn+og13acdzI+/hHVzK
        at0Xht2OsNn5EOAa4ldKdgo=
X-Google-Smtp-Source: AGHT+IF/4hVopzL3eS8NlMWQ9n6U5qIfC1ZIKisL/gh/DQcxhaK4LHwMF9ikltpm/5q4Ko/Z05OVlw==
X-Received: by 2002:a05:6a20:12c1:b0:12e:4d86:c017 with SMTP id v1-20020a056a2012c100b0012e4d86c017mr199853pzg.10.1697657924502;
        Wed, 18 Oct 2023 12:38:44 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:66c1:dd00:1e1e:add3? ([2620:15c:211:201:66c1:dd00:1e1e:add3])
        by smtp.gmail.com with ESMTPSA id 19-20020a170902c11300b001c9d235b3a0sm315037pli.7.2023.10.18.12.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 12:38:44 -0700 (PDT)
Message-ID: <74e2e900-949e-41d8-967e-89057224958b@acm.org>
Date:   Wed, 18 Oct 2023 12:38:42 -0700
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
 <bf2705ff-716a-45b5-bcc4-8710ea0fb98e@gmail.com>
 <65b871ef-dd93-4bfb-bae9-c147a87c64d0@acm.org>
 <dbd9f019-693f-476c-aa4c-739746753d2b@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <dbd9f019-693f-476c-aa4c-739746753d2b@gmail.com>
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

On 10/18/23 11:29, Bob Pearson wrote:
> I now find that siw also hangs solidly on srp/002. This is another
> hint that we are seeing a timing issue.
I can't reproduce the srp/002 hang with the siw driver - neither with a 
production kernel nor with a debug kernel. Is anyone else able to 
reproduce the srp/002 hang with the siw driver?

Thanks,

Bart.

