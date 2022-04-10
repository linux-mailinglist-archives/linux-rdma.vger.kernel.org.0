Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4522F4FAC7D
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Apr 2022 09:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbiDJHK3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 10 Apr 2022 03:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiDJHK2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 10 Apr 2022 03:10:28 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D988233EB2;
        Sun, 10 Apr 2022 00:08:18 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id p25so5242536pfn.13;
        Sun, 10 Apr 2022 00:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=HVWBsgmreVM7NWYIFYraUpWAz5bg5eNhLs14aCiVGc0=;
        b=k9PhERDb0On3yStvqqyKVL+kfQcIpVZBzBASw+Gp6PQSmtCQHgKlWS0nxQPpc7c7dr
         +prqxSG8V+QzxUZqntQhO06VnuMu+9mupVTNdZm8ZXUv/otsHo/2ds89gLOjZPyGyU+U
         sRjTMO5/eHL0zIoiYoKWcci3c+LQQijXlM6HZQnxSPcbuiipNe5AWOoxev6QdY+AHnfK
         ZUCo3YaRN6uFwANT6oyRbgEHuDZwW4e9FEP6b4PRq1mQWsdAkT8OZDcBGsiAQWmtj8Y6
         HGVlMgY1coxBNuYkXG+jWgPuCBHRVPVzCyD6s+goaw/A61qa1XWpgWBNcXu/eZqD1WIn
         gToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=HVWBsgmreVM7NWYIFYraUpWAz5bg5eNhLs14aCiVGc0=;
        b=jDxRpx6p030UCBQQHnALIaDtq19kEl+KxOVgQnm1FrF3sJV5AyWDH4xZ6syCc1acZW
         pni7bCm36GX4AWbHetrXVOqjjaNsTF9Kd3slbyR+wh6A7RvA/CN0cY0/V+nREgrw1nFN
         jV4H5wo4RjADeHYS7SUs0WB6P6Ta32t02io8MIsd+ymUrRgoERLeMhJNgUdTcKvCFfdh
         30grboAmGd2PuP3OrnMVpXsWmU/g/B0elnLsJ9ynI6fsct3Z4QJrPJe+mhauaw1UDTFM
         rT3x5BvcmmF2ONxH5RkYfMwkF9yo4hBynE72k3dx6B2I177LFcduty6aRd00Xb5keQMy
         tKSw==
X-Gm-Message-State: AOAM530ZigxigCiVvaGszDqsMg+5WOxCGiTzyJi49nYbF2NDOb3eJ+F/
        UE+djeCghWc9JJOj0IWC+9NUtY+Mwh8II6ij5Uv7bbPoLf0wPlI=
X-Google-Smtp-Source: ABdhPJzzrQAbQ4gE/xYri6oJag17XAmEBKxfSBlgZA9Nb2uXUnmhNRDno4cF5cyC5BCFlyrr3Z2OnquVKFambr031dQ=
X-Received: by 2002:a05:6a00:ad0:b0:4f7:a357:6899 with SMTP id
 c16-20020a056a000ad000b004f7a3576899mr27329756pfl.80.1649574498352; Sun, 10
 Apr 2022 00:08:18 -0700 (PDT)
MIME-Version: 1.0
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Sun, 10 Apr 2022 15:08:04 +0800
Message-ID: <CAMhUBjnc1rCoE5G8MPHO-nzMdQs=O3=YLH1QnuF7mbKbds2QMQ@mail.gmail.com>
Subject: [BUG] IB/hfi1: Warning when the driver fails to probe
To:     mike.marciniszyn@cornelisnetworks.com,
        dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

I found a bug at the init_one() function in the hfi driver.
When the function xa_alloc_irq() fails, the driver executes the error
handling function sdma_clean(), and this function uses the lock '
dd->sde_map_lock'. But this lock is initialized after executing the
function xa_alloc_irq(), which causes the following warning:

[   23.257762] hfi1 0000:00:05.0: Could not allocate unit ID: error 1
[   23.269915] INFO: trying to register non-static key.
[   23.270318] The code is fine but needs lockdep annotation, or maybe
[   23.270808] you didn't initialize this object before use?
[   23.271229] turning off the locking correctness validator.
[   23.273198] Call Trace:
[   23.274185]  register_lock_class+0x11b/0x880
[   23.274525]  __lock_acquire+0xf3/0x7930
[   23.275769]  lock_acquire+0xff/0x2d0
[   23.276053]  ? sdma_clean+0x42a/0x660 [hfi1]
[   23.276485]  ? lock_release+0x472/0x710
[   23.276789]  _raw_spin_lock_irq+0x46/0x60
[   23.277105]  ? sdma_clean+0x42a/0x660 [hfi1]
[   23.277530]  sdma_clean+0x42a/0x660 [hfi1]
[   23.277945]  ? trace_kfree+0x28/0xc0
[   23.278232]  hfi1_free_devdata+0x3a7/0x420 [hfi1]
[   23.278688]  init_one+0x867/0x11a0 [hfi1]
[   23.279090]  ? _raw_spin_unlock_irqrestore+0x3d/0x60
[   23.279482]  ? rcu_lock_release+0x20/0x20 [hfi1]
[   23.279930]  pci_device_probe+0x40e/0x8d0

Regards,
Zheyu Ma
