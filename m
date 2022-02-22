Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935474C014D
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Feb 2022 19:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbiBVSau (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Feb 2022 13:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbiBVSau (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Feb 2022 13:30:50 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707E4EDF15;
        Tue, 22 Feb 2022 10:30:24 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id v8-20020a17090a634800b001bb78857ccdso388250pjs.1;
        Tue, 22 Feb 2022 10:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qclEmu0/kZyWj9B9ipQfb3U9hghb5b6YJZMCgpxSD2c=;
        b=VSpwqCe6mavUR44cINWjLg3fWnwTzhYp2zfykWb1LV0THR7uDIDC9r/1GKRUXUJ5Am
         nMDLFtHjh/2wU3Y2dfAZwilx1/dLUQ7UMVoq4tQVqkdwcem7VvtVrAkelAEIHjaxeSlY
         KinquAYuzb8A8qBEfMQnsqX2a48QkICt35IPBFF4OV6X/J5zQ1mDl6xKGMumAtpiQ0+H
         na3A8O9Ty69WavB0fHym8toOB+lxb+5SvBCZB7cHC9czdE5xmmwX5l9KkHQk9wXw1QbK
         dY7Z9fxJeH0AUCAYmYB8y8xlAePD2VO9uLMErkh0KaB3sNuRwj1K9inily++F5Ggjb0V
         acbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=qclEmu0/kZyWj9B9ipQfb3U9hghb5b6YJZMCgpxSD2c=;
        b=L53eXPn332MtwnVgVAosawhjcWkHB/Z4TW18ykRwXFLYrxkfm+ltnNjuXZ5BuWjTzO
         0RvjocMY+8yDtq6MQiPrXN8T4mJrALTx2zOUdnq1J9RlJIq+7ELz55cL4jM2WEi09QgD
         OZL44TBgLfjo4ljP5Rvx062e/WdyIs3TlDvuMJezn/N9XZxb9SZfbD2pfQ/hoXWAIa3X
         1H+gWVByLUJ4xtF0a0jZTUZgtWePtLekkiweiKRacauyBWzCp/9G9+sVHmNthqR2qeLV
         IQXr0xcCwRZWw7wbXghFtdz1amQUOOaa0QjvFpGOElEZ3/Ne5EzQbFQGasivkEjiPEN6
         UtXQ==
X-Gm-Message-State: AOAM532GhFx57FPhIPzwIoVQJ6T7cTZkU0ZF9pUQzLcKh7kFTQYCyHF/
        2GGd1HyteiGqu4MS3lmPXAE=
X-Google-Smtp-Source: ABdhPJzi4b6YPzrR9UQihIFYuKrOwHgi3BMDmT0yBQV+eEmF4vUqDqD6UP0rpcUUF0QKijJzzGO+Cg==
X-Received: by 2002:a17:902:bd4a:b0:14f:92ac:fa43 with SMTP id b10-20020a170902bd4a00b0014f92acfa43mr14992504plx.27.1645554623761;
        Tue, 22 Feb 2022 10:30:23 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id s15sm22022937pgn.30.2022.02.22.10.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 10:30:23 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 22 Feb 2022 08:30:22 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller-bugs@googlegroups.com,
        Bart Van Assche <bvanassche@acm.org>,
        syzbot <syzbot+831661966588c802aae9@syzkaller.appspotmail.com>,
        jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [syzbot] possible deadlock in worker_thread
Message-ID: <YhUrvpwkH07Yr2sW@slm.duckdns.org>
References: <0000000000005975a605d7aef05e@google.com>
 <2959649d-cfbc-bdf2-02ac-053b8e7af030@I-love.SAKURA.ne.jp>
 <YgnQGZWT/n3VAITX@slm.duckdns.org>
 <4168398.ejJDZkT8p0@leap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4168398.ejJDZkT8p0@leap>
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

Hello,

On Thu, Feb 17, 2022 at 01:27:08PM +0100, Fabio M. De Francesco wrote:
> Just to think and understand... what if the system-wide WQ were allocated as unbound 
> ordered (i.e., as in alloc_ordered_workqueue()) with "max_active" of one?
> 
> 1) Would it solve the locks dependency problem?

It'll actually make deadlocks a lot more prevalent. Some work items take
more than one work to complete (e.g. flushing another work directly or
waiting for something which must be completed by something else which may
involve a system work item) and system wq's max active must be high enough
that all those chains taking place at the same time should require fewer
number of work items than max_active.

> 2) Would it introduce performance penalties (bottlenecks)?

I'd be surprised it wouldn't cause at least notcieable latency increases for
some workloads.

Thanks.

-- 
tejun
