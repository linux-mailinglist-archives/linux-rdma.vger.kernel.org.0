Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F9F4C013F
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Feb 2022 19:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiBVS10 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Feb 2022 13:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234965AbiBVS1Z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Feb 2022 13:27:25 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7642B99EE2;
        Tue, 22 Feb 2022 10:26:57 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id w37so11343252pga.7;
        Tue, 22 Feb 2022 10:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=smWGMcLS0EGMpUTlbWLEiA/RqnX/pSuZiXWNoobMsws=;
        b=H3iGbmFDJxI0j3FIE3tq+tZHezV5s3YCwLyr6Lb8AlIU4+5MFgcQNYLJ6yc8Qgh+oC
         Bs5C7zJ1yDoQqvIXQ2tozvwg+Rc67IywAh3LZfVN7nP0Z5xiauPEJLaXWx3xPGE/G55I
         qjNhXMlPgAkMl6PE/bwGzJMGjVSRxXzp5LaTAIH9/3+LBe41q+60SQzzJOHClaIWdWPi
         5dy3kxaybfeEAx54E1v7FVSzkh4Q45PWFe7EYebFzTNjjBwR42SUo7vFfcE+pQBCiIVL
         zTj8gF9etN6mR6JNU5yGFbbyNrk9yV0fQ5X9YvuF6gVRNHlFxXV9uw+HQbjGKiFahdAZ
         aR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=smWGMcLS0EGMpUTlbWLEiA/RqnX/pSuZiXWNoobMsws=;
        b=WSksKDy+F9kDhTOB7YWlVfM9D4Z/ENN/whkzhHye667ghPVEBGOn82/OPqNC6jMZmj
         fkqRjMBehWk/9zxnz9MOJFnqcPDJmVnrRE1jQjhOTv5cptVQIN/iJsuxXWjwq5A2NzI5
         FiM0SxMzBluUFKxqOSwDQIB3dVyqQyLvT0BTf1tqTxO+TUZvMVqBXCf/7Xqz4N8g7C8f
         Lqtz8jquUESfY7xyhKohFhRQ4t2Qou2V4vpx7+zxSoKh28U5f8Lyn2au9RU0AKYKo3c/
         rLNXytfqWqbMXMJnPyqjqCOgeSNY9ukERBrL0uwf69FgibnB66qbyUanLZDxpbHU0yAg
         5WWQ==
X-Gm-Message-State: AOAM531/p09XFTA8PfUneqguOZF1S90/OgQV5w5vOnsxdTV/THms+Ok1
        Zcd8P1xV0n/0P21c5zxV3jc=
X-Google-Smtp-Source: ABdhPJw5vNJB4o+6asgzi6aVO4FwMfymHvmkDPUkDV6lJ3SqIfeipfJvMjWOo15xx0IouvWJ5TjO4g==
X-Received: by 2002:a05:6a00:88e:b0:4d2:4829:156c with SMTP id q14-20020a056a00088e00b004d24829156cmr26408344pfj.47.1645554416892;
        Tue, 22 Feb 2022 10:26:56 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id a17sm18430747pfv.23.2022.02.22.10.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 10:26:56 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 22 Feb 2022 08:26:55 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        syzbot <syzbot+831661966588c802aae9@syzkaller.appspotmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        LKML <linux-kernel@vger.kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [syzbot] possible deadlock in worker_thread
Message-ID: <YhUq70Y/tKGGNbR0@slm.duckdns.org>
References: <309c86b7-2a4c-1332-585f-7bcd59cfd762@I-love.SAKURA.ne.jp>
 <aa2bf24e-981a-a811-c5d8-a75f0b8f693a@acm.org>
 <2959649d-cfbc-bdf2-02ac-053b8e7af030@I-love.SAKURA.ne.jp>
 <YgnQGZWT/n3VAITX@slm.duckdns.org>
 <8ebd003c-f748-69b4-3a4f-fb80a3f39d36@I-love.SAKURA.ne.jp>
 <YgqSsuSN5C7StvKx@slm.duckdns.org>
 <a07e464c-69c6-6165-e88c-5a2eded79138@I-love.SAKURA.ne.jp>
 <76616D2F-14F2-4D83-9DB4-576FB2ACB72C@oracle.com>
 <fb854eea-a7e7-b526-a989-95784c1c593c@I-love.SAKURA.ne.jp>
 <1b70929f-1f73-c549-64c1-94cea2c1a36c@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b70929f-1f73-c549-64c1-94cea2c1a36c@acm.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 15, 2022 at 09:05:38AM -0800, Bart Van Assche wrote:
> On 2/15/22 04:48, Tetsuo Handa wrote:
> > I do not want to do like
> > 
> > -	system_wq = alloc_workqueue("events", 0, 0);
> > +	system_wq = alloc_workqueue("events", __WQ_SYSTEM_WIDE, 0);
> > 
> > because the intent of this change is to ask developers to create their own WQs.
> 
> I want more developers to use the system-wide workqueues since that reduces
> memory usage. That matters for embedded devices running Linux.

Each wq is just a frontend interface to backend shard pool and doesn't
consume a lot of memory. The only consumption which would matter is when
WQ_MEM_RECLAIM is specified which creates its dedicated rescuer thread to
guarantee forward progress under memory contention, but we aren't talking
about those here.

Thanks.

-- 
tejun
