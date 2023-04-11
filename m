Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5856DDAEF
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Apr 2023 14:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjDKMe5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Apr 2023 08:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjDKMev (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Apr 2023 08:34:51 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFED2D6B
        for <linux-rdma@vger.kernel.org>; Tue, 11 Apr 2023 05:34:50 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id u4so5260572qvj.10
        for <linux-rdma@vger.kernel.org>; Tue, 11 Apr 2023 05:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681216490; x=1683808490;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ur12DoSsIGzsOCg41ViPfT8wXmkMN6/VVLHkfCMhToY=;
        b=AiIV/otYxS+DjHw9OfynunICMxoZwDLCd7pNleFVX1evGUFPHFrEtHRBZTvUigtgY4
         JmeOqiB8TeMWMsEnguevTGJ7FQfPh128/CYX/c3L61wI4cPcg1/jdQNfYR0hdpp/aDse
         OKKj4+4Npw15m6T0bCFiegxuMXkumaAGt4bUquVYcR/LwgdrBOQxxg9KjnBd8uovOW6d
         tkgcVwriwQBCzAJym5Syl0duZ6WsqnHoZzl6HMZZN8AcJB7E2oWu658zf9M/15iY/jAO
         nLOSQXoeRkF9fI6sXroXf3yyhZRt/d2NXcVv1ssQAGFMWJzPoRhD2KQEqZxyKTz0zhAB
         k0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681216490; x=1683808490;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ur12DoSsIGzsOCg41ViPfT8wXmkMN6/VVLHkfCMhToY=;
        b=ksb6hF0qIkJlTf+ntqOalFVB0JtfCc9nwVgCBLkitc6ytVhh3Ej1rcAZNMfzU85U0H
         3kJ4VVj6X9EWe4BA4siyMmchVWMRFFZbHZj9xNrR1I4eIOKDUQeIPoojBq9EoFfsPmnk
         B9KuxLeP+v49bVwfm72k08q/VzSOoStwknQpxShfj5phaIqpBcXTe7LGhE2tnYBIE71+
         L+E7934FGeRz5q9Fgs9Fp8lPQ/KgUe8qHKTKKJW6cZkBmnYmXMbDrxeyYPc5nASDfLC1
         a9+2clw4kgNb+CE8b2Ekfkq4dRfoMxnQbzUoB/W5DFJNSPI1RNublQCwGr6Try070yfJ
         ynrw==
X-Gm-Message-State: AAQBX9ewkwH3o34rRBHahDbWzfUdYd1Hef2s2KxsIhlnx9y8fhto6PVI
        dIB+ty0A97vlKrGAquBbqUA5NjXmx+k7UJByzteeM2OxMSI=
X-Google-Smtp-Source: AKy350bP1THbn5SVCTVXcSuhgKbe5rLuG0/IpYHkFRktFcZY+67+Uq3rOU1b3x7iz9EHgIIMxkS5TVZUfNjKzQmLo/M=
X-Received: by 2002:a05:6214:1863:b0:5ee:e59a:6a1e with SMTP id
 eh3-20020a056214186300b005eee59a6a1emr442095qvb.4.1681216489792; Tue, 11 Apr
 2023 05:34:49 -0700 (PDT)
MIME-Version: 1.0
From:   Mark Lehrer <lehrer@gmail.com>
Date:   Tue, 11 Apr 2023 06:34:39 -0600
Message-ID: <CADvaNzUaEw-7Ntie7vxdzyxa+cB8xPvAH6WV521iqVwixcAQbw@mail.gmail.com>
Subject: RoCEv2 + netns == Doom
To:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I'm trying to do a simple ib_send_bw test between two VMs that each
have a network namespace. Unfortunately, it seems like the netns layer
is dropping the RoCEv2 traffic.  The test works fine if I don't use ip
netns.  TCP also works perfectly.

I verified this using tcpdump on the bridge between the two test VMs.
I have tried both mlx4_ib and rdma_rxe and they both fail, though with
slightly different error messages.

I'm using Alma 9 and the elrepo ml kernel for my tests (6.2.10 currently)

It looks like rdma cm connections should work since rdma is in universal mode:

# rdma system
netns shared copy-on-fork on
# rdma link
link rxe_eth0/1 state ACTIVE physical_state LINK_UP netdev eth0

I tried the non-SMC suggestions in this thread but with no luck yet:
https://lore.kernel.org/netdev/20211228130611.19124-2-tonylu@linux.alibaba.com/T/

What should I try next?

Thanks,
Mark
