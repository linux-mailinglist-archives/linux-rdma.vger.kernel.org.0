Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC176CBD77
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Mar 2023 13:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjC1LY3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Mar 2023 07:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbjC1LYY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Mar 2023 07:24:24 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EC38695
        for <linux-rdma@vger.kernel.org>; Tue, 28 Mar 2023 04:24:21 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id f6-20020a17090ac28600b0023b9bf9eb63so12129851pjt.5
        for <linux-rdma@vger.kernel.org>; Tue, 28 Mar 2023 04:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1680002661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CSHdMTmorBCFdaBPfoygzEX0vM+tXnXrSc/Fnn5kP6w=;
        b=il+NWBuxJsyyCxgu10plOHWuEEgHEUnogYKupNfuv/26JrOn3OGild63KfpLjyv86e
         poc8XIfyddMd2HGPvSfHP5UX/k21E/QLeILZKpcrj335wUBa+X6K1tpSVjJeZcEp/9vi
         Zx05t8Ksfw6meg3cFfETSjWmtlY8G7n/xBtl1Uy3Rv0NlyhAz1RbhhLJMTcTkRp8AlVo
         zlnwl6JTUAtdPN+E+F5J052zzY6f7LrcrQVcZVcJ6Fm/04pk1mMhA4ahTG1zGF2P8HrX
         m7RvgI1qlF0rdXHedIEvVM6hCq2SrVZC9FV3htbRh6yE0+sulRK5Jvgzmw/FJjsHvdKH
         Z+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680002661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CSHdMTmorBCFdaBPfoygzEX0vM+tXnXrSc/Fnn5kP6w=;
        b=mTzUAt5Fm5/fPpSaZl/8aCJA2eFzVfgr4QG2g0LlQSaHxhE8ueooIOjgSYovG3baaR
         KQfaLBnSwjXjqUdyx+zMv2rZbHRYsF2JIhia+KYU3FjKFYZSkxdNkNx8bOVX8Uwemibo
         ErC9gpecDsk1m17BCNtCKGZcD66eXoEYKfk78drtAjsVTF67FWKUEk3B/hUEhp9XTwsS
         geuWhPzw7qOy/EP71OQiO2X8/BipyN5Uo4xsTDdcmlv9gO0SS3QxF2bfqP74CbYYhgsu
         v7tw6DELXZ4qXN9NgQp+4pWYOGLO60AtPsQXACzAFcjPkp3/rOYv590fgU68iyPTgZwK
         ufNg==
X-Gm-Message-State: AAQBX9dbGG/aCfaZivxiWe1N38rWz26likL9XyjkW8SFaMDzzMGV528V
        0z2q6T8pVWg7nplB/HSxJLMKp240dynhxLu0t78=
X-Google-Smtp-Source: AKy350bbrdsjQF5Autej7bQGSc6oBsiNRNAWVeYSf7Xk+I789zFCkbPaX+oWCiqB7obdA5qprEonhQ==
X-Received: by 2002:a17:902:daca:b0:19f:3d59:e0ac with SMTP id q10-20020a170902daca00b0019f3d59e0acmr18265312plx.44.1680002661333;
        Tue, 28 Mar 2023 04:24:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id jj11-20020a170903048b00b0019f1222b9f6sm20943134plb.154.2023.03.28.04.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 04:24:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1ph7R5-003ipc-62;
        Tue, 28 Mar 2023 08:24:19 -0300
Date:   Tue, 28 Mar 2023 08:24:19 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Bernard Metzler <bmt@zurich.ibm.com>,
        Leon Romanovsky <leon@kernel.org>,
        Ursula Braun <ubraun@linux.ibm.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA: don't ignore client->add() failures
Message-ID: <ZCLOYznKQQKfoqzI@ziepe.ca>
References: <0e031582-aed6-58ee-3477-6d787f06560a@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e031582-aed6-58ee-3477-6d787f06560a@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 28, 2023 at 07:52:32PM +0900, Tetsuo Handa wrote:
> syzbot is reporting refcount leak when client->add() from
> add_client_context() fails, for commit 11a0ae4c4bff ("RDMA: Allow
> ib_client's to fail when add() is called") for unknown reason ignores
> error from client->add(). We need to return an error in order to indicate
> that client could not be added, otherwise the caller will get confused.
> 
> Reported-by: syzbot <syzbot+5e70d01ee8985ae62a3b@syzkaller.appspotmail.com>
> Link: https://syzkaller.appspot.com/bug?extid=5e70d01ee8985ae62a3b
> Fixes: 11a0ae4c4bff ("RDMA: Allow ib_client's to fail when add() is called")
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  drivers/infiniband/core/device.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

This doesn't make any sense, you need to explain what "caller will get
confused" actually means

Jason
