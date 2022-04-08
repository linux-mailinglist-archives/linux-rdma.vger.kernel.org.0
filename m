Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBB24F9F7B
	for <lists+linux-rdma@lfdr.de>; Sat,  9 Apr 2022 00:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbiDHWMZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Apr 2022 18:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiDHWMY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Apr 2022 18:12:24 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67B2363B2E
        for <linux-rdma@vger.kernel.org>; Fri,  8 Apr 2022 15:10:18 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id a17-20020a9d3e11000000b005cb483c500dso7018641otd.6
        for <linux-rdma@vger.kernel.org>; Fri, 08 Apr 2022 15:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=KqPd1L46Bx5YXwgZgUXqUPVke+mmOawpUJoHNyOAfQU=;
        b=QZmGp8tphNC9Z9P/SCezVoN8iv3OTL10nyNJJN0YdR8RZTmQjG0W2P9aRi5ECxvVex
         ACsmA+A2cLco+jHalWT3QpuQj7ic4gsW/rZxTTYz+S0zQQXC9pOONonGq1idMsUyIJbS
         zqvP0BLIuZtxjV3PNreeJJvLuOJ8dL9mw0r/8bE9I4ZMQomY+GPMn9C2CSwAUb4kB3ue
         nG9vHGKmcloVjMSYLjkA63Ufk+/OSuaI/t3vhuCwDfnRIfBJ8S2jEIfE2qhHlT6P2kgz
         NqLf2OWP1FlOFBzF2waZHM2Soz8xP53khCnBPMru9xjIFNDRp6/UJzjv5Z3A7iOSHNds
         vQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=KqPd1L46Bx5YXwgZgUXqUPVke+mmOawpUJoHNyOAfQU=;
        b=xHc7JROSCTm8UYYSlrkPfqs7fdcCO3DWxZU80lRhDyXrbWXwOTwwfsct6NzQrYO38c
         0zuezh6kcKsBp81hqeHvA2IUQNEUqfbf7s/kgqEPPdnA2hXkCCnwh7HREZrl5i8l6qKV
         lFYen1krTj+iUAs1MrT38aMTUeb9KGplXhmQN6cnUzBLgyMbiLWKoMIQpodPYExwXn8n
         +g4Yi4TTbsQZm5M35RbbhDjgN5ql6cyu+E58nk62AqMzXxB9lP23BFi1ftVkmCfvwoZ6
         JHTVZRgV/7H1z5pcYSsM5gve74Tx7DlyDEEg0TK2ox9SQmjTtcbOd9iEGqptDp71p+Dj
         4CaQ==
X-Gm-Message-State: AOAM5317hSlo8TaBBYE3FQaJmqhxuYsCXQFL0g9w2aCkTIfVGWgi7G4H
        IdJ+nguje604Al2T5xBAm1kykfQuIxc=
X-Google-Smtp-Source: ABdhPJzAzbG8rKFKGIpdsgqvGGvmrtJQVGdREtZsymVAOBpHlGI/zgnB5ea+bk0h1E7MJ1LVRug+ug==
X-Received: by 2002:a05:6830:4410:b0:5cd:b315:636f with SMTP id q16-20020a056830441000b005cdb315636fmr7233593otv.236.1649455818209;
        Fri, 08 Apr 2022 15:10:18 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:d36a:c09a:7579:af8a? (2603-8081-140c-1a00-d36a-c09a-7579-af8a.res6.spectrum.com. [2603:8081:140c:1a00:d36a:c09a:7579:af8a])
        by smtp.gmail.com with ESMTPSA id s125-20020acaa983000000b002ecdbaf98fesm9059146oie.34.2022.04.08.15.10.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 15:10:17 -0700 (PDT)
Message-ID: <533dc3b0-e58a-0bc8-2f07-5dbfb3d1235e@gmail.com>
Date:   Fri, 8 Apr 2022 17:10:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Yi Zhang <yi.zhang@redhat.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Subject: blktest failures
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

Bart,

I finally was able to build a kernel with lockdep enabled correctly and saw the error that you and others reported.
I am not familiar with lockdep output but I am guessing that it is reporting a mismatch between a _bh spinlock
and a _irqsave spinlock (since those are the only two types used by the driver.)

I went on campaign a while back to replace all the locks with _bh locks because I figured they would be
faster than _irqsave locks and because the driver never touched a lock except from a verbs API call or from
a tasklet (softirq.) As it turned out some code makes verbs API calls while in hardirq context which broke
that assumption. So some of the locks were reverted back to irqsave locks which fixed those warnings.

Now it is happening again. I did an experiment and went through the rxe driver and replaced all spinlocks
with _irqsave locks. Now the lockdep splats have gone away and the srp/001 test reports success. BUT,
it hangs and doesn't finish. If I try to run all the tests I get warnings about unable to remove the
scsi_debug driver. I am able to remove the rdma_rxe driver and reload it. I am not seeing any errors in
the rxe driver.

Do you have any ideas what to look at next?

Bob
