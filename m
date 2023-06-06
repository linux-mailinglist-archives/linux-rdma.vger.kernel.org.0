Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AA6724E56
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jun 2023 22:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239072AbjFFUy3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Jun 2023 16:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238576AbjFFUy2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Jun 2023 16:54:28 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74401715
        for <linux-rdma@vger.kernel.org>; Tue,  6 Jun 2023 13:54:27 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6b2993c9652so614601a34.1
        for <linux-rdma@vger.kernel.org>; Tue, 06 Jun 2023 13:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686084867; x=1688676867;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXJLuXec3uEvhzufxd6vdkHLIO9wS/MfruQV7IEGIT0=;
        b=iMVF4ldzpTGzWyhb3NnUS+zfTND9biRQs5KRe+6HRxoG+XD/LWzFZsVKmhMQLQj7KW
         DUSv3cVHhtlVT8OYB/d3KjtXT1KPNtBlPUiwMJjBU8LiOhEhqcYcxnqp5Px54m52UIcx
         qo+COLFd0pwLCErtzpXlefHf3QUl993/yl1+vG6bXjOgwiUwzxAu+0H9aMfnmJLRzB9H
         PE/T2KUJlXjVxjgcTtdvwXPFgR6dPS2wdj7sMRP5xtKoeEMmuStDhVQVo1sR+kqBFIDC
         cvsQ2yfNee90OOvTFFLtzaOsnTvQGgS7pLbnsbMyS7q+WT1o+NyHxqsjSNWPbuVED+oE
         mr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686084867; x=1688676867;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SXJLuXec3uEvhzufxd6vdkHLIO9wS/MfruQV7IEGIT0=;
        b=RWyPyCQP5uJzXZ7FhbvsKyeQLwOaQ59IjAXvbUyIdKREyZDYsIrhp4EqcU7ZNHWA1q
         RCFfrhSAFL3i7eP9aDhJVVazPD289wPtNWLneP44FZx9CxfFDo45fjGBU92UicA5lrgr
         OfM+SPB/9x7Q3wGPNLGyQMcQfTNyCt/Qhdn8j5zF1Z24wbMjPot1OOJu1Vik6+N3O35I
         MaIJhxdShop4Bicdo7PHqL4LyTZWbSAVnrSSzMsHkSw9jxGnRAg8mkimqQUQR3qZDXVI
         FMLcii7Jp2rOAu7uj1hhbObhVCoOW6GAnnFdzp82xEIzrb5VOakwb6G40ETzXdrM32Dn
         bJJQ==
X-Gm-Message-State: AC+VfDwEJMrPOwPiaZEPjny6Tk0yzzyJ8fWMY8YZhXRkpP5Zlcqyh6xf
        5hJdO/W8LpL4ojQ3xm6ZI1Xtqeh1ZjM=
X-Google-Smtp-Source: ACHHUZ7qcOcju3tgCUjXGxPu5YUWUoZA2VbwrlAXqkXmkRf4wIUAT/tXEBlDw2bvfMdWYnLMbbsJug==
X-Received: by 2002:a05:6830:1d43:b0:6af:8e73:786b with SMTP id p3-20020a0568301d4300b006af8e73786bmr1895555oth.5.1686084867090;
        Tue, 06 Jun 2023 13:54:27 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:c75b:ceee:aadc:178b? (2603-8081-140c-1a00-c75b-ceee-aadc-178b.res6.spectrum.com. [2603:8081:140c:1a00:c75b:ceee:aadc:178b])
        by smtp.gmail.com with ESMTPSA id g1-20020a9d6b01000000b006b28edf195bsm1774769otp.78.2023.06.06.13.54.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 13:54:26 -0700 (PDT)
Message-ID: <ed01bad5-b63b-855c-b2da-d98718fa2b4d@gmail.com>
Date:   Tue, 6 Jun 2023 15:54:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Bart Van Assche <bvanassche@acm.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Subject: IB_POLL_DIRECT
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Jason,

Both the rxe driver and the siw driver running the blktests srp test suite exhibit failures on my machine
running the for-next branch. This has been true for months so I decided to try again to track it down.
After a lot of tracing, it looks like the problem is that the built in cq handling in core/cq.c is failing to
continue to process some completion queues.

The traffic is between the srp driver and the srpt driver. The srpt driver uses

	cq = ib_cq_pool_get(..., IB_POLL_WORKQUEUE) and

the srp driver uses

	cq = ib_alloc_cq(..., IB_POLL_SOFTIRQ) for receive cqs and
	cq = ib_alloc_cq(..., IB_POLL_DIRECT) for send cqs.

AFAIK the poll workqueue and poll softirq cqs are working correctly but the poll direct cq sometimes
loses the thread and just stops processing those cqs. The test cases sometimes recover after about
a 2 second delay and start processing again and eventually fail after about a 10 second delay and
cleanup and go home.

The failures feel like a race or at least are timing sensitive. If you run the test suite several times
various test cases will sometimes succeed and sometimes fail. But they always fail in the same way.

Looking at the mlxn drivers for inspiration, I don't see anything specific about IB_POLL_DIRECT except
that they have a private version of send_queue_drain which also calls a cqe drain function which calls
ib_process_cq_direct() in a loop until the cq is drained. But this is only during qp tear down. (No other
verbs driver does this but as far as I know no other driver is passing blktests.) This is only done for
IB_POLL_DIRECT, so I wonder, is this required to use that correctly?

I am still figuring out how IB_POLL_DIRECT works. It doesn't allow the driver to call cq->comp_handler so
I don't know how it figures out when there are new wcs to process.

Any ideas would be really helpful.

Bob



	
