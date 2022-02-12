Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18444B3686
	for <lists+linux-rdma@lfdr.de>; Sat, 12 Feb 2022 17:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237474AbiBLQiD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 12 Feb 2022 11:38:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbiBLQiC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 12 Feb 2022 11:38:02 -0500
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3BB212;
        Sat, 12 Feb 2022 08:37:59 -0800 (PST)
Received: by mail-pj1-f46.google.com with SMTP id n19-20020a17090ade9300b001b9892a7bf9so2425062pjv.5;
        Sat, 12 Feb 2022 08:37:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lWvUkwk07Cqv8ZgRYz64+Y6IpvTasbWoniI+uoJ1w1A=;
        b=kb+MWWieieJ4S6teqZRTZK/Alw3g9agSrJRupSodtBsPXCxSvvG/m9uA2X6uQIsYAz
         dXxVxOKs+UPKdTqyqrdS4+VtN7bZ/l42kNwyOSWbIdv0wGiN5LbxwZj5KWEGQpm5jr9Y
         dYYgc546n3Zw5uHExMPych7JWpbd9YSA7vmx3rAermPM8H/xvYCRleDL6ZJIx0UQEnvD
         Qqua95Pp9VmPKY2uRLLFd22e04DZkACJ7s2Ah9pGF/3FB3msI2eaVbuJk9qJCPi3VFoL
         vHxBFY2nt8TrwSdXqS5Gtw//pST0ndSJlLMVNXfz4GvrGZ1aIW8kNMhF1LRdw5KQzt4L
         IUqg==
X-Gm-Message-State: AOAM531ds4FiZd5YpJM6XgC1V3hbPIGhjS/ICDwe+rD/OQWVrKuHa+GT
        56Mq4+jg+ysdfJzP2wC+SoU=
X-Google-Smtp-Source: ABdhPJyhIL2ILPjKpDpGa5afSF+31xQdglUdqqIFTa4eFiuVp5UuUKZgM5IE7j3FX+AOr1US7QWP6Q==
X-Received: by 2002:a17:902:d501:: with SMTP id b1mr6711030plg.120.1644683878329;
        Sat, 12 Feb 2022 08:37:58 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id c3sm536994pfd.129.2022.02.12.08.37.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Feb 2022 08:37:57 -0800 (PST)
Message-ID: <71d6f14e-46af-cc5a-bc70-af1cdc6de8d5@acm.org>
Date:   Sat, 12 Feb 2022 08:37:55 -0800
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
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ccd04d8a-154b-543e-e1c3-84bc655508d1@I-love.SAKURA.ne.jp>
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

On 2/11/22 21:31, Tetsuo Handa wrote:
> But this report might be suggesting us that we should consider
> deprecating (and eventually getting rid of) system-wide workqueues
> (declared in include/linux/workqueue.h), for since flush_workqueue()
> synchronously waits for completion, sharing system-wide workqueues
> among multiple modules can generate unexpected locking dependency
> chain (like this report).

I do not agree with deprecating system-wide workqueues. I think that all 
flush_workqueue(system_long_wq) calls should be reviewed since these are 
deadlock-prone.

Thanks,

Bart.
