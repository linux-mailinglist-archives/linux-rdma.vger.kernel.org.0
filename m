Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBE851ADA1
	for <lists+linux-rdma@lfdr.de>; Wed,  4 May 2022 21:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344363AbiEDTTW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 May 2022 15:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377645AbiEDTTR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 May 2022 15:19:17 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589F11FCC7
        for <linux-rdma@vger.kernel.org>; Wed,  4 May 2022 12:15:27 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id a21so2810017edb.1
        for <linux-rdma@vger.kernel.org>; Wed, 04 May 2022 12:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=66zjCBfJUj9PHvq+6szYYwk2RTr4tTdvt7RCophALwQ=;
        b=XNpl/sbvlkuhlGJQI/stROBpH5hoXW64lW5OcT4KjeFWlNxwvX9L1z13PyQydbLgM/
         h50pk2dvBXGS97veOqmKhPy8sKlEokCsYf2ehmBh65aeHUaMYpDxx7uDucIafROFZ3uE
         ZEksY7yf3S/Y8XqMoe9u8ulYng3yuGphE9ZCCrWS+iw//30NI8YikIr9n63vKv1h1tlj
         0x0++TNaNhs/LV88rRDvCUUPrtOPhhUvz43fehxIlF9yhSFKYqQxJzbPyRTgYskhHAVS
         fLvVSlvrTuy/CVsz6pmZmIOx58YLPGqg1VqFW4leFEBdcgPGZ822wP5JOO/Kr+tixYp5
         s0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=66zjCBfJUj9PHvq+6szYYwk2RTr4tTdvt7RCophALwQ=;
        b=Gx43/hhiVInViM9oxG0/2VbmiPUcfrREbtdZk2gAGLmJ8ixmG6mppSy7dYB5+nb8Cv
         Jfdp2H3alQeDZiaCpO3RqowjASQyFL3T2O+pn2mOv65ZEa40w+p4DOJrMPxnrWHdA9dA
         9k3ewp+z71+Hh11ClmctjwarwpnnYYgi1cSBw7Urk0agrl3onlhutL8f/R3cZmLXohEZ
         NZXf8FHibHYdJg4Gxzw8fkzrcCDh8xeVPBTF6exvUqQdPOE2t72XTDQ6cZuq3V9hTZxF
         7LmD9Wzwoow1y0z2wLFt0vMUiTFyW6t+GscZiR1ZH/1aVjXSQxsinxSSaxT1wnakvHDd
         AU7Q==
X-Gm-Message-State: AOAM533W426B+8qK1jF/2+/UvHwC9gn8/w3vqs+3NOWFVQ2yfZOXO917
        Yg0xBB1MkQlMpCQq/vlvy/Hbzgu72/hJnkSJwiHETsVL4HI=
X-Google-Smtp-Source: ABdhPJwmyoWf6uBw2xOs13MH+/UsYSndFYpGd9o3DZtTFGbknySnlbdYz/mo3j7tCcEuNPjru9tEJ35+ZXIoNXrG2Ns=
X-Received: by 2002:a05:6402:210:b0:41c:9ca7:7660 with SMTP id
 t16-20020a056402021000b0041c9ca77660mr25822446edv.145.1651691725208; Wed, 04
 May 2022 12:15:25 -0700 (PDT)
MIME-Version: 1.0
From:   Ryan Stone <rysto32@gmail.com>
Date:   Wed, 4 May 2022 15:15:13 -0400
Message-ID: <CAFMmRNyHUSg6_+af9W39e36aCx2a=_9WC8MB08W9XfnMKoYXAQ@mail.gmail.com>
Subject: Possible bug in ipoib_reap_dead_ahs in datagram mode
To:     linux-rdma@vger.kernel.org
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

I was reading through the IPoIB code and I think that I see a bug that
affects ipoib_reap_dead_ahs() when using datagram mode.

When sending a packet, if we aren't using the CM (which I assume means
that we are using datagram mode), we fall into the following case:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/infiniband/ulp/ipoib/ipoib_main.c#n1163

The AH for our neighbour has its last_send field set to the return
value from the RDMA driver's send function

If I look at how this is used in ipoib_reap_dead_ahs(), it compares
last_send to the current tail of the completion(?) queue.  I believe
that this is intended to check that the last outstanding WQ entry that
references the AH has completed.

However, if I look at the actual implementation in mlx5, the send
function always returns NETDEV_TX_OK:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c#n635

If my understanding of all of this is correct, this could lead to a
premature freeing of an AH and a use-after-free bug
