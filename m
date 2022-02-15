Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A5E4B78A2
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Feb 2022 21:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240516AbiBORFx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Feb 2022 12:05:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbiBORFv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Feb 2022 12:05:51 -0500
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13EE119F7D;
        Tue, 15 Feb 2022 09:05:41 -0800 (PST)
Received: by mail-pl1-f179.google.com with SMTP id w20so13546500plq.12;
        Tue, 15 Feb 2022 09:05:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=4XleEJH2PpPwterBCnSkkR/rDNNZHaszB5/lLGm5Jr8=;
        b=YKmxkeg86vq5E6cymgjlRtdMG5D6dpssYCjoegbIsVpE/2JlNnLl/J9tubFrO5Hyj1
         8dy5PBYZFHxib97TngQe/Sdbg4X4v9QYYwSZcLbf+/6ZCqRPBW8FwHfcgUjdtN3pSNYE
         qaESZmHIjD77qS9CcClAvqXGhvkuch5Voc2e/ewVjn0F8aqkRNiebLZzdQzUCVn9wHYH
         eYDf1iTVJi7NTD26NOyADrhG1rHkad2e/5Za3A+H6cbTqJuqN/fdilqEjO31CvU/JXe7
         EPgewtJk+gKXob9FtgOrXVsSR+qL7z4QYI5aSIHc/leX9mIIeO+q25FkNbBguWE+YkDM
         gkSA==
X-Gm-Message-State: AOAM533m8oqF4UzPUgCF45vKzCNEGRY2D3faipQJ8AQGgLk+OxkY+rKn
        R3VozphTJFXopjHHODevGnZKLmmV5XS0OA==
X-Google-Smtp-Source: ABdhPJyH++fmcBHWOXSUsKOkMW1j6B4LcjIc70lGuuPs7x7cKgQoWskWdeF3hKJdcYUo9xL4U90E4g==
X-Received: by 2002:a17:90b:1b0e:: with SMTP id nu14mr5451669pjb.233.1644944740896;
        Tue, 15 Feb 2022 09:05:40 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id j12sm35280608pfu.79.2022.02.15.09.05.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 09:05:40 -0800 (PST)
Message-ID: <1b70929f-1f73-c549-64c1-94cea2c1a36c@acm.org>
Date:   Tue, 15 Feb 2022 09:05:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Re: [syzbot] possible deadlock in worker_thread
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Tejun Heo <tj@kernel.org>,
        syzbot <syzbot+831661966588c802aae9@syzkaller.appspotmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        LKML <linux-kernel@vger.kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
References: <0000000000005975a605d7aef05e@google.com>
 <8ea57ddf-a09c-43f2-4285-4dfb908ad967@acm.org>
 <ccd04d8a-154b-543e-e1c3-84bc655508d1@I-love.SAKURA.ne.jp>
 <71d6f14e-46af-cc5a-bc70-af1cdc6de8d5@acm.org>
 <309c86b7-2a4c-1332-585f-7bcd59cfd762@I-love.SAKURA.ne.jp>
 <aa2bf24e-981a-a811-c5d8-a75f0b8f693a@acm.org>
 <2959649d-cfbc-bdf2-02ac-053b8e7af030@I-love.SAKURA.ne.jp>
 <YgnQGZWT/n3VAITX@slm.duckdns.org>
 <8ebd003c-f748-69b4-3a4f-fb80a3f39d36@I-love.SAKURA.ne.jp>
 <YgqSsuSN5C7StvKx@slm.duckdns.org>
 <a07e464c-69c6-6165-e88c-5a2eded79138@I-love.SAKURA.ne.jp>
 <76616D2F-14F2-4D83-9DB4-576FB2ACB72C@oracle.com>
 <fb854eea-a7e7-b526-a989-95784c1c593c@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <fb854eea-a7e7-b526-a989-95784c1c593c@I-love.SAKURA.ne.jp>
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

On 2/15/22 04:48, Tetsuo Handa wrote:
> I do not want to do like
> 
> -	system_wq = alloc_workqueue("events", 0, 0);
> +	system_wq = alloc_workqueue("events", __WQ_SYSTEM_WIDE, 0);
> 
> because the intent of this change is to ask developers to create their own WQs.

I want more developers to use the system-wide workqueues since that 
reduces memory usage. That matters for embedded devices running Linux.

Thanks,

Bart.
