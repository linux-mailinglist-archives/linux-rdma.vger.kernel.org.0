Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2D64B3E57
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Feb 2022 00:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbiBMXGs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 13 Feb 2022 18:06:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiBMXGs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 13 Feb 2022 18:06:48 -0500
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F362254BE0;
        Sun, 13 Feb 2022 15:06:41 -0800 (PST)
Received: by mail-pl1-f180.google.com with SMTP id w20so9160587plq.12;
        Sun, 13 Feb 2022 15:06:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qhMPRWNoyLemtcbWE/X7+rJB/VYvBTkzYdCumzI+F0g=;
        b=qlOkEyJnkxRMgJsNIhzSpSkFw2dWDgIiZPhIT0BY1zYY3OPLj7KGI9g5pSKtERrfg+
         sVLaAyqyPHMa3wrJ9T7LQXXE3UtnRASNXFj/ZLzBAvvxrSXC8vzyqASu7lX6KLkFKGYe
         uv3RzKL8lV1+tjPkd2UknEGcyuvlCpp3swfG4WFONwary+PEUIP/zbg8EN9jCIDLiR7+
         UzlTsTbblLMqIBIZQbPOnzXTy0CrkNA6vMWoJk+T1buEqelzPPneJVEiBiOvZ5Pxxi/y
         2Lyj8rr5JKn45swV4r0Kszi0yuvYPFsBKwayleb/Q9UDYp6jFZnBUy4R+JwtmQKL8KR5
         oAkQ==
X-Gm-Message-State: AOAM532nG3k1fY2efrr4pj7sDqwHgQMQIiizehQjeoKQEWx+4IxcPnhO
        ki33zzxrn88TAYGEAysZBko=
X-Google-Smtp-Source: ABdhPJynANFxwSs8kCyrzlxuncqnPsAFbwcV+rBe/poFe3AWsvnWVRzINRrykxGM/Y/VwLm6tp648g==
X-Received: by 2002:a17:902:d505:: with SMTP id b5mr11660635plg.113.1644793601272;
        Sun, 13 Feb 2022 15:06:41 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id 10sm33350391pfm.56.2022.02.13.15.06.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Feb 2022 15:06:40 -0800 (PST)
Message-ID: <aa2bf24e-981a-a811-c5d8-a75f0b8f693a@acm.org>
Date:   Sun, 13 Feb 2022 15:06:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [syzbot] possible deadlock in worker_thread
Content-Language: en-US
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        syzbot <syzbot+831661966588c802aae9@syzkaller.appspotmail.com>,
        jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
References: <0000000000005975a605d7aef05e@google.com>
 <8ea57ddf-a09c-43f2-4285-4dfb908ad967@acm.org>
 <ccd04d8a-154b-543e-e1c3-84bc655508d1@I-love.SAKURA.ne.jp>
 <71d6f14e-46af-cc5a-bc70-af1cdc6de8d5@acm.org>
 <309c86b7-2a4c-1332-585f-7bcd59cfd762@I-love.SAKURA.ne.jp>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <309c86b7-2a4c-1332-585f-7bcd59cfd762@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/12/22 09:14, Tetsuo Handa wrote:
> How can reviewing all flush_workqueue(system_long_wq) calls help?

It is allowed to queue blocking actions on system_long_wq. 
flush_workqueue(system_long_wq) can make a lower layer (e.g. ib_srp) 
wait on a blocking action from a higher layer (e.g. the loop driver) and 
thereby cause a deadlock. Hence my proposal to review all 
flush_workqueue(system_long_wq) calls.

Thanks,

Bart.
