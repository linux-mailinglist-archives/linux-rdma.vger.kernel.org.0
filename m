Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA194B4076
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Feb 2022 04:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236741AbiBNDof (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 13 Feb 2022 22:44:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiBNDoe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 13 Feb 2022 22:44:34 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F3955BF7;
        Sun, 13 Feb 2022 19:44:27 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id qe15so13276318pjb.3;
        Sun, 13 Feb 2022 19:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L1T88FidLuaZlcuhS+PMTDghYDEh2W0752ZJLiUhucA=;
        b=oRxyDdDKJNDKc0H2K5Ch1WeXCfehy5G5ViIxcN4wos03w40Ja/IorqoHoAyXBeNe2z
         /rB2IezmwC2dUoUvaAXGatt/3SIYh/dn3AK70vcB/wbisaGlBOPEYEvnHIRPE03MpNpo
         9+wjVdTEH8b4SjisCIV/yI/TCFydTs731ZwyK4Rt3qhcZGIUcUdh1ADkoN6Hb1AS3I6t
         BOYQjM8NAmird84LvaTV6DShFzMbhUrN6fEyPj+V7zGoptFPMqzYlxbfCkUxTAwtwQNC
         25wauWx9mCDgORt2Dkq/CnB7UIzqqo4wutass3l9TfNAE4K5PxFs0RVMDMjHjA880T7q
         V2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=L1T88FidLuaZlcuhS+PMTDghYDEh2W0752ZJLiUhucA=;
        b=NiV+YMxVB5NL5jVdVvs3n7Q0LI9FxBA6RMloxM9wNsFieASubdWhk2t5kVLKh0PSBo
         tMULTHj9gzAwHeatjkRfF3NhIpLWAlh8cf22JeqBW5WNIx5ZEzCA8+iOlMhNd6IOZxM8
         smhWdRo688Q81I1/c8A8S6wdnVffeWwKND95J3AYDvn+gaKzmU28v4xTMAxQFET4GKE+
         neDQsKtim0P88VEmZKqZ9yjCXccm5t5kTX+5igMmMt5G6onDSfRP00jrkMs+diTQBL9t
         i7zZYIL+jRdkFTrETi/4k3FlIIqBme+THUKF2VcCoR6JXLS4ovSazv2mA5pdx3Bjp9uo
         XrTA==
X-Gm-Message-State: AOAM530bpo00tY6h9xUqqT0c5D3i2QunDOCkZCxCOXMFsFefqGQmkCcP
        yUXhycCcYUG7qCNQtAFtGB4=
X-Google-Smtp-Source: ABdhPJwq8SXlhmABICvW3k9U/ONzzfjpJ2DUO6Q3MF+Ohgc5gPzZIIqdL/Jda1nZYZ3MJFKNgeIk8Q==
X-Received: by 2002:a17:902:ce04:: with SMTP id k4mr12146212plg.62.1644810267263;
        Sun, 13 Feb 2022 19:44:27 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id ot10sm8971515pjb.3.2022.02.13.19.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 19:44:26 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 13 Feb 2022 17:44:25 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        syzbot <syzbot+831661966588c802aae9@syzkaller.appspotmail.com>,
        jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [syzbot] possible deadlock in worker_thread
Message-ID: <YgnQGZWT/n3VAITX@slm.duckdns.org>
References: <0000000000005975a605d7aef05e@google.com>
 <8ea57ddf-a09c-43f2-4285-4dfb908ad967@acm.org>
 <ccd04d8a-154b-543e-e1c3-84bc655508d1@I-love.SAKURA.ne.jp>
 <71d6f14e-46af-cc5a-bc70-af1cdc6de8d5@acm.org>
 <309c86b7-2a4c-1332-585f-7bcd59cfd762@I-love.SAKURA.ne.jp>
 <aa2bf24e-981a-a811-c5d8-a75f0b8f693a@acm.org>
 <2959649d-cfbc-bdf2-02ac-053b8e7af030@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2959649d-cfbc-bdf2-02ac-053b8e7af030@I-love.SAKURA.ne.jp>
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

On Mon, Feb 14, 2022 at 10:08:00AM +0900, Tetsuo Handa wrote:
> +	destroy_workqueue(srp_tl_err_wq);
> 
> Then, we can call WARN_ON() if e.g. flush_workqueue() is called on system-wide workqueues.

Yeah, this is the right thing to do. It makes no sense at all to call
flush_workqueue() on the shared workqueues as the caller has no idea what
it's gonna end up waiting for. It was on my todo list a long while ago but
slipped through the crack. If anyone wanna take a stab at it (including
scrubbing the existing users, of course), please be my guest.

Thanks.

-- 
tejun
