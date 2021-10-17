Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3EB43072D
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Oct 2021 10:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245043AbhJQIRk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 17 Oct 2021 04:17:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42511 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232530AbhJQIRk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 17 Oct 2021 04:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634458530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=ZVlVgQKPt6Z+S+JoXsal/iuedKSh1Uk0cEoZKdQzYRI=;
        b=XkuY+tNa1xF/KyyAZ/fzl9uq18hwXI/tvXGHCcaqA/W0Z2mAE8LQuyhWQux1fgLS3fb4w2
        dOjwkI0aCp6Mtg3VmEr8wOPOzhjsODXTwbjqKqJbUjv86rJ/sySSa1WkwPzJWppI6rz1mJ
        F5b6mVrIl8GRNo3H4bDT1Coooy+BRiI=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-xFeQFWamMTCfpDdYcQ0I4A-1; Sun, 17 Oct 2021 04:15:29 -0400
X-MC-Unique: xFeQFWamMTCfpDdYcQ0I4A-1
Received: by mail-yb1-f199.google.com with SMTP id b126-20020a251b84000000b005bd8aca71a2so16319445ybb.4
        for <linux-rdma@vger.kernel.org>; Sun, 17 Oct 2021 01:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ZVlVgQKPt6Z+S+JoXsal/iuedKSh1Uk0cEoZKdQzYRI=;
        b=0kZ3SBoyQMyXZYJyrZL+a6vrV7lR93AK+fnj33oX39uxFfozETC4yuBsltI0lgwsr8
         3mp6OXO+XJh3mJKHzkwtqRqoMJr6nDAx3P/uDpNKGVbo+WLahk4Ql6Jcy0YIX9qs+g6e
         b2oiMsBFozUXodL6e3uUo4L7bVXSN7+shCTFyGqSMQiehch5Vazp3fsCbCT8bdGEK/dA
         WLfCMx/pRMuEti++m6MHpdXBaK3z/sCjgkS5bxN5xJKqR8Qbrx8aHcxy9+j4WyvZLwjE
         LFvD/sfq5Cd6a+dm3pmAEsJiaYvmzLK6bCPn0NGflHtgfFgFEcA4oOkjWglPXZJcbpmh
         4nhw==
X-Gm-Message-State: AOAM5307mPzX6x6Yu7nEGjNdQ/7iX8wHuWTfhoGZYvwA92xpfpo4qHBL
        m8q4cPB7AFDC+YT0aa0Hm82iD52xzmkDktveuPBT1ht2WRIGErG6pO79NY2F0hwKS2UKI8oHNb0
        6Bo3LtxK8ERsDzMLqU7j76ZZIVbYxJDSf22VNVA==
X-Received: by 2002:a25:bd03:: with SMTP id f3mr21560313ybk.412.1634458528301;
        Sun, 17 Oct 2021 01:15:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwv+7jmnd4aKtaJG2iHTBu0mc9Le3M8FvRapdVBSnricARFJ5etiMt+qLyUdZ8H5U/nHx6i1cpDQuwSLkEzpc0=
X-Received: by 2002:a25:bd03:: with SMTP id f3mr21560304ybk.412.1634458528051;
 Sun, 17 Oct 2021 01:15:28 -0700 (PDT)
MIME-Version: 1.0
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Sun, 17 Oct 2021 16:15:17 +0800
Message-ID: <CAHj4cs9EuKWfTbRP2-4wqSBNd4K7XsqgHZ7WmztFhfHsVj8p1A@mail.gmail.com>
Subject: [regression]blktests srp/014 hang at "ib_srpt enP5p1s0f0_siw_1:
 waiting for unregistration of 128 sessions ..."
To:     RDMA mailing list <linux-rdma@vger.kernel.org>
Cc:     Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello

I'd like to report this regression issue which was introduced from
5.15-rc1, the blktests srp/014 hang there with dmesg[2].
I've copied the full log [3], and it cannot be reproduced on 5.14.

[1]
# use_siw=1 ./check srp/014
srp/014 (Run sg_reset while I/O is ongoing)                  [passed]
    runtime  34.907s  ...  35.560s

[2]
[  180.392856] ib_srpt:srpt_release_channel_work: ib_srpt
2620:0052:0000:10d6:0a94:efff:fe80:823f-246
[  180.392912] ib_srpt:srpt_release_channel_work: ib_srpt
2620:0052:0000:10d6:0a94:efff:fe80:823f-248
[  180.392959] ib_srpt:srpt_release_channel_work: ib_srpt
2620:0052:0000:10d6:0a94:efff:fe80:823f-250
[  180.393005] ib_srpt:srpt_release_channel_work: ib_srpt
2620:0052:0000:10d6:0a94:efff:fe80:823f-252
[  180.393052] ib_srpt:srpt_release_channel_work: ib_srpt
2620:0052:0000:10d6:0a94:efff:fe80:823f-254
[  180.393102] ib_srpt:srpt_release_channel_work: ib_srpt
2620:0052:0000:10d6:0a94:efff:fe80:823f-256
[  187.070176] ib_srpt enP5p1s0f0_siw_1: waiting for unregistration of
128 sessions ...
[  192.110402] ib_srpt enP5p1s0f0_siw_1: waiting for unregistration of
128 sessions ...
[  197.150568] ib_srpt enP5p1s0f0_siw_1: waiting for unregistration of
128 sessions ...
--snip--
[  207.230923] ib_srpt enP5p1s0f0_siw_1: waiting for unregistration of
128 sessions ...
[  212.271078] ib_srpt enP5p1s0f0_siw_1: waiting for unregistration of
128 sessions ...
[  217.311295] ib_srpt enP5p1s0f0_siw_1: waiting for unregistration of
128 sessions ...
[  222.351446] ib_srpt enP5p1s0f0_siw_1: waiting for unregistration of
128 sessions ...

[3]
https://pastebin.com/0UC0Q21z


-- 
Best Regards,
  Yi Zhang

