Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38EDA34D8D6
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Mar 2021 22:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbhC2UHo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Mar 2021 16:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbhC2UH2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Mar 2021 16:07:28 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2C8C061574
        for <linux-rdma@vger.kernel.org>; Mon, 29 Mar 2021 13:07:28 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 68-20020a9d0f4a0000b02901b663e6258dso13420015ott.13
        for <linux-rdma@vger.kernel.org>; Mon, 29 Mar 2021 13:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=0r2rO/BRdURc/1jatPUHHm5RXDYyg0DyZ/NuxqiRdy8=;
        b=fMtzAQv/5ux+8He/xmmUaYyHbbcnkNI2bcKWqUfdRwo12BBj/VGaWH/Gg8p72kQWgC
         c2cKIF1nKglhwBXPhQnOie1QBz6VB9VAdlI3VIcibGO1Tsdyj7Np4ZWC+KOgpuVAVchr
         Mnl1F3ZCAWrAtcJzdVXnysNpt2Ss7UlOyEVZ+I7QAvnbWsSTkZUY5pq/Zjw0EPp9qwCT
         2IF3uKCMxnamSa5mSHEjfbZgNZZln5rUJ0Sp6iafVGH8M2/0vePk31F5raLdWaeQblZT
         IOOTpYLZZ14WTdKT3w/vCGEYKz1l81zvQu2vAK6IrHD7G4CxQnPYd86H0vL0GvfbJVo4
         SVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0r2rO/BRdURc/1jatPUHHm5RXDYyg0DyZ/NuxqiRdy8=;
        b=DurblIaKgmFTGgwyG+2QwTcsyGqnpo4FBPpZ34I4UFlkfWICPtBFT/QQrBOQs41mEf
         o+EMgrDJfrbcXPJEjitTDLELKrTgedBDSQiSf9Sp4iGdZpr19tHx8QztunkzVPpzwu2p
         2WnpmqeR6e7xlJRMJTx3Y51gFnFF4e+qisnxo59/h7KhlHzia4mnARkINSE6/K2+tjzO
         N0STi474HluDnK6K+lCMy/engM0ibsB3rNobwU8eoNreGk6Tf12Odvhpynvib4xvTHtJ
         mzyz7ry9fabWuENjTl//DmfxJcFNXuc1rjG9W0uij6sN8n0HN+ReLgsjcn9Ro8DKbky1
         xWMA==
X-Gm-Message-State: AOAM530G8Gr5CfRT1HEQzp6u7nYM6N8zuNeGaahTlo5hoGSQZb2KoNPC
        g2sPwKxPNITo/iZC22ImYlrZlU8AHCg=
X-Google-Smtp-Source: ABdhPJzTuzwdF3vLZ8bqzcRX2jU2IZxzh7wOyZenns679hJkRma94KnY8xNfmORupQNCDWUryp9ZJw==
X-Received: by 2002:a9d:5c0f:: with SMTP id o15mr23835637otk.279.1617048447251;
        Mon, 29 Mar 2021 13:07:27 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:94f8:22f6:1ac1:2329? (2603-8081-140c-1a00-94f8-22f6-1ac1-2329.res6.spectrum.com. [2603:8081:140c:1a00:94f8:22f6:1ac1:2329])
        by smtp.gmail.com with ESMTPSA id 3sm3946865ood.46.2021.03.29.13.07.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 13:07:26 -0700 (PDT)
Subject: Possible bug in test_mr_rereg_pd
To:     Edward Srouji <edwards@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <c143355e-954a-5953-c67c-c7a9bf451b7b@gmail.com>
 <edbf4d3f-08bc-31a0-a214-c098748697b5@gmail.com>
 <c8bf0e78-b2d5-2151-2b32-5386ff4566d2@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <4e79ae3d-401a-9ad0-2e7b-89c341e322d3@gmail.com>
Date:   Mon, 29 Mar 2021 15:07:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <c8bf0e78-b2d5-2151-2b32-5386ff4566d2@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



Edward,

In a later test (test_mr_rereg_pd) which is also failing, I get the following

======================================================================
ERROR: test_mr_rereg_pd (tests.test_mr.MRTest)
Test that cover rereg MR's PD with this flow:
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/home/rpearson/src/rdma-core/tests/test_mr.py", line 160, in test_mr_rereg_pd
    u.traffic(**self.traffic_args)
  File "/home/rpearson/src/rdma-core/tests/utils.py", line 653, in traffic
    poll(client.cq)
  File "/home/rpearson/src/rdma-core/tests/utils.py", line 524, in poll_cq
    raise PyverbsRDMAError('Completion status is {s}'.
pyverbs.pyverbs_error.PyverbsRDMAError: Completion status is WR flush error. Errno: 5, Input/output error

But, adding tracing to the kernel driver I see that that part of the test actually succeeded
after resetting the two QPs and reregistering the MR back to original PD. However, there were
some WQEs that got flushed when the QPs were reset but I don't see anything in the test to drain
the RCQs after the reset. So it is not surprising that the test sees the flush errors when it polls
the RCQ.

Since CQs are independent of QPs I thought it was correct to show these completions as flushed even
if the QP is reset.

Bob
