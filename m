Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 188693274D8
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Feb 2021 23:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbhB1WaI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 28 Feb 2021 17:30:08 -0500
Received: from mail-pf1-f172.google.com ([209.85.210.172]:34726 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbhB1WaH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 28 Feb 2021 17:30:07 -0500
Received: by mail-pf1-f172.google.com with SMTP id m6so10231600pfk.1
        for <linux-rdma@vger.kernel.org>; Sun, 28 Feb 2021 14:29:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=yX4pb7XOM1zbvL59pCSYykXPH+CYjxZe3CmUeHARrYM=;
        b=s8UTU16ZVqPrQU/AcifkhuKiuJ1/IYw++FbHODdBOfUS4u2P3+YgYmkTSFLndLzZLT
         iZUaUiggvKp4SjSoyzbdEyR22H0sdFA5Bdcj4ivjrvvXG0RlsMbA/vN2Zisj66fUgnoQ
         fcr9gBeRcma30uL6KBhlq7x2ujH5yzoyicYNi7/NSjWABtH00AEwhQ1EQX0LiZ+JSGm7
         C1GfllXf6mrgQk4bgDvUgtzuLYHO6BwOw5MGSaKDE1FppY6gqIN3aAqC5dipuJmuz/Ex
         Tz8lbg7P3miAIhVJIBhOBOyP52mYIhG6gWdAsTwqzJ19LfLLJ1Am+1nsO9t881K1+u7F
         gPvQ==
X-Gm-Message-State: AOAM531jOQ50LW8QQcgmd3t7BOJgdQXHvWwLYb7tzJqJG3KhD/8J5tra
        Sx4a01HuHyB2LRYZwRbaors=
X-Google-Smtp-Source: ABdhPJwuV4VEF7X4P7/5OvLVLmy9aI+iWyedhzmUKxg6Yyk/ofdFF+H5yf6qvJqLKEFX+iKBaDV6WQ==
X-Received: by 2002:a63:374f:: with SMTP id g15mr11299757pgn.212.1614551366996;
        Sun, 28 Feb 2021 14:29:26 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:33b2:579f:d8cd:be8a? ([2601:647:4000:d7:33b2:579f:d8cd:be8a])
        by smtp.gmail.com with ESMTPSA id i10sm16186661pfq.95.2021.02.28.14.29.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Feb 2021 14:29:26 -0800 (PST)
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>, jgg@nvidia.com,
        Yi Zhang <yi.zhang@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Regression in rdma_rxe driver?
Message-ID: <7aabe495-e844-df77-05ff-491f53963816@acm.org>
Date:   Sun, 28 Feb 2021 14:29:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

If I run the following command:

(cd ~bart/software/blktests && ./check -q srp/001)

against the for-next branch of the RDMA git repository (commit
7fad751c2062 ("RDMA/srp: Apply the __packed attribute to members instead
of structures") then the following appears in the kernel log:

Feb 28 14:24:04 ubuntu-vm kernel: WARNING: CPU: 5 PID: 84 at
drivers/infiniband/sw/rxe/rxe_comp.c:761 rxe_completer+0xdc5/0x10d0
[rdma_rxe]
Feb 28 14:24:04 ubuntu-vm kernel: Call Trace: [ ... ]
Feb 28 14:24:05 ubuntu-vm kernel: WARNING: CPU: 5 PID: 39 at
lib/refcount.c:28 refcount_warn_saturate+0x154/0x160
Feb 28 14:24:05 ubuntu-vm kernel: Call Trace: [ ... ]
Feb 28 14:24:11 ubuntu-vm kernel: WARNING: CPU: 5 PID: 1471 at
lib/refcount.c:19 refcount_warn_saturate+0xa8/0x160
Feb 28 14:24:11 ubuntu-vm kernel: Call Trace: [ ... ]
Feb 28 14:24:17 ubuntu-vm kernel: WARNING: CPU: 6 PID: 1501 at
drivers/infiniband/core/device.c:671 ib_dealloc_device+0x104/0x110 [ib_core]
Feb 28 14:24:17 ubuntu-vm kernel: Call Trace: [ ... ]
Feb 28 14:24:18 ubuntu-vm kernel: WARNING: CPU: 4 PID: 170 at
drivers/infiniband/core/device.c:493 ib_device_release+0xd3/0xe0 [ib_core]
Feb 28 14:24:18 ubuntu-vm kernel: Call Trace: [ ... ]

Is this a known issue?

Thanks,

Bart.
