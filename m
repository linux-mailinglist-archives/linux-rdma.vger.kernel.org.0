Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA10D50C1E3
	for <lists+linux-rdma@lfdr.de>; Sat, 23 Apr 2022 00:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiDVV4J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Apr 2022 17:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiDVV4F (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Apr 2022 17:56:05 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EC51AFF41
        for <linux-rdma@vger.kernel.org>; Fri, 22 Apr 2022 13:38:25 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-e604f712ecso9784063fac.9
        for <linux-rdma@vger.kernel.org>; Fri, 22 Apr 2022 13:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=9Vja0gmvNhV4pxhmUvSgYknvyf0Bo4kUgxqwwnpsH+Q=;
        b=n0VuuUUjn/yN66EpN/GJIskzR/IB2c7moqC1SzcE+PXUnSk6u6pJPAY2wCcZQtznhM
         nHAW9nV4rbusmplBQjZRiiLBLTvHLTpa/a4xGjYEFlYV9ckkjHLTQuWgo6hLh0VZvSBz
         P4tOoLSwZkFi4HgGP0ewAvlu/fqrHKPUFjHkQUzw086tKGJVr+1POynuuSOPQQs0InFt
         h3pjogxPpNBNhQ3dz899pdes8K7U+p1AfH0KHWm8ooIjUTh+QcIGMCfliI9Sasi+6uCv
         6j0xBmLOsdh3HD9OYL2etNZxNGAdglH4mGSk/wl8R4xzf+WGZH7QI5GLM4dw72MpbY1m
         Oe+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=9Vja0gmvNhV4pxhmUvSgYknvyf0Bo4kUgxqwwnpsH+Q=;
        b=LlmusfWk2thGanFuwdM/UBNykISOgKZ3uj6Inipd9oG90Se7qXwLg7i2LwS2nx8ivb
         crfANt1TyLMcoXrIfLK0lZJpcCDI04fRGRtlxtdYSkpl1INc5g4z3HL6uTHpu0vy+Rn6
         ZJUjYF7zodUWuKXKgtGTkBgpkMflVdexh8No9EEWUYW+5no3RUn/60w5DSUr9ai+8UUX
         +XReh89exgaFRNhdZX1k9ZHE9dvMJD/f81LXhEYNodSTbD/5/nzceZzaUKOf56tTZtm8
         +FmjqUfEEou19bqmsW43VPMHd0gCoDsSD97z1ATgU7MRcWk/GRtxWugQIGbb4SDxl0p9
         O9DQ==
X-Gm-Message-State: AOAM531wvZe/z2h1pOsYqDVapWFS1Bz7/Wqi80ccwoNje2T4QAlctSqn
        casUCDqhMcywNU6/DJlaGcfkttQfvXM=
X-Google-Smtp-Source: ABdhPJx7XJJilclV/aR7jeNTUs58OltjKeB0g8POOAAuwvKlZ37fRuxFqEStJToioy0rTQwwPmGhlg==
X-Received: by 2002:a05:6870:15d3:b0:da:c49f:9113 with SMTP id k19-20020a05687015d300b000dac49f9113mr2601726oad.91.1650652345566;
        Fri, 22 Apr 2022 11:32:25 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:e508:94f4:5ee:8557? (2603-8081-140c-1a00-e508-94f4-05ee-8557.res6.spectrum.com. [2603:8081:140c:1a00:e508:94f4:5ee:8557])
        by smtp.gmail.com with ESMTPSA id t129-20020a4a5487000000b00329d2493f8esm1080246ooa.41.2022.04.22.11.32.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 11:32:25 -0700 (PDT)
Message-ID: <983bec37-4765-b45e-0f73-c474976d2dfc@gmail.com>
Date:   Fri, 22 Apr 2022 13:32:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Subject: much about ah objects in rxe
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Jason,

I am confused a little.

 - xa_alloc_xxx internally takes xa->xa_lock with a spinlock but
   has a gfp_t parameter which is normally GFP_KERNEL. So I trust them when they say
   that it releases the lock around kmalloc's by 'magic' as you say.

 - The only read side operation on the rxe pool xarrays is in rxe_pool_get_index() but
   that will be protected by a rcu_read_lock so it can't deadlock with the write
   side spinlocks regardless of type (plain, _bh, _saveirq)

 - Apparently CM is calling ib_create_ah while holding spin locks. This would
   call xa_alloc_xxx which would unlock xa_lock and call kmalloc(..., GFP_KERNEL)
   which should cause a warning for AH. You say it does not because xarray doesn't
   call might_sleep().

I am not sure how might_sleep() works. When I add might_sleep() just ahead of
xa_alloc_xxx() it does not cause warnings for CM test cases (e.g. rping.)
Another way to study this would be to test for in_atomic() but
that seems to be discouraged and may not work as assumed. It's hard to reproduce
evidence that ib_create_ah really has spinlocks held by the caller. I think it
was seen in lockdep traces but I have a hard time reading them.

 - There is a lot of effort trying to make 'deadlocks' go away. But the read side
   is going to end as up rcu_read_lock so there soon will be no deadlocks with
   rxe_pool_get_index() possible. xarrays were designed to work well with rcu
   so it would better to just go ahead and do it. Verbs objects tend to be long
   lived with lots of IO on each instance. This is a perfect use case for rcu.

I think this means there is no reason for anything but a plain spinlock in rxe_alloc
and rxe_add_to_pool.

To sum up once we have rcu enabled the only required change is to use GFP_ATOMIC
or find a way to pre-allocate for AH objects (assuming that I can convince myself
that ib_create_ah really comes with spinlocks held).

Bob
