Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811DC327754
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Mar 2021 07:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhCAGCa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Mar 2021 01:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhCAGCa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 1 Mar 2021 01:02:30 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9A7C06174A
        for <linux-rdma@vger.kernel.org>; Sun, 28 Feb 2021 22:01:48 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id b8so15370959oti.7
        for <linux-rdma@vger.kernel.org>; Sun, 28 Feb 2021 22:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=enGD/Qc667jcQ5JXb32HXwXQJHFlS/BkCTEZ8T5kzfo=;
        b=sywGd1V/qUL7ww7n3z9zfFDKVuqPcfUj35G4OpikC+NzoMrkVzbO4aupDWJjIFnll9
         EMQq/cekB8xEo5xFJp7RtSwdmUtarTLjXyICh3gupWkF+lCkWt0ehJvP42wiF+x4ymW9
         jA/24lo9e8pPsn5gq/orpPWeFNtlDXjp1dFwAg7wtN3fdStp3tPFMZZwUFPPMCRUfjwK
         3yi8z56LG7KJUX0M1TdTl1dGlqZrhsEJULOo3g2/HkSau/gT4r/jluoGiggJs3wSj3yK
         3Arb6FzYauo+jZr32E3WBMBcGpxDpz2zVSF8njXjfDOj9ltgE5/tJxh3/Dm7Z5N7scJb
         2egg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=enGD/Qc667jcQ5JXb32HXwXQJHFlS/BkCTEZ8T5kzfo=;
        b=ry+FeDb/z8GEh0ljmj6pmeB5rG1RVjmvph3AUKOYoBCiHsabxs1YBT5G371nhHiOu6
         fjEwv6OT41S8jTtGq0prCYcsccqKYu3LYoivHCjGEHnoznzC1hPbzwrIbZzLAoDa47bo
         8MgOIjtL9XNsWbk3Cc6j+NWcfJbwRZCDIcImJNb+dIcE1YBTnwmJwDqQzz0P2vUENTBV
         34yBDNMx8G02nntg6bL+2ph9b1Y+GrZEYkfLeAufGnh9YqJ/LACjQ/ywyuckEnE+Miov
         qcAKDhvRatfpPDvG5yU3Fx4ZUXYYuDpeyKyl+OzkU+aD2doWCSLRcw2hWgnKRUkwwNI5
         +dlg==
X-Gm-Message-State: AOAM533P5gvWsUOFZ99Lq8gsIQpxnMagmbUC0K+9lLWTfbZ09PNafOmh
        WqArYZ5h6Cr3iyaDY2rrgsa7wiSw2hmgYgJNJG4=
X-Google-Smtp-Source: ABdhPJxjTC2FIcHelrsrvf2xtj1b92WPvQYw7oGn/yANsvkX4IjyZscwVEfN19LFC4Ww7Sd3ALQBiTxYoIN+sp/UZlo=
X-Received: by 2002:a05:6830:130d:: with SMTP id p13mr12265853otq.53.1614578507864;
 Sun, 28 Feb 2021 22:01:47 -0800 (PST)
MIME-Version: 1.0
References: <7aabe495-e844-df77-05ff-491f53963816@acm.org>
In-Reply-To: <7aabe495-e844-df77-05ff-491f53963816@acm.org>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Mon, 1 Mar 2021 14:01:37 +0800
Message-ID: <CAD=hENdFO_mf_Ksxikev=qiHZLYM+tbU4FtbG=FvJCcQA+0W4Q@mail.gmail.com>
Subject: Re: Regression in rdma_rxe driver?
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Yi Zhang <yi.zhang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 1, 2021 at 6:52 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> Hi,
>
> If I run the following command:
>
> (cd ~bart/software/blktests && ./check -q srp/001)

Can you show me how to reproduce this problem in my host?
I am interested in this problem. Thanks a lot.

Zhu Yanjun

>
> against the for-next branch of the RDMA git repository (commit
> 7fad751c2062 ("RDMA/srp: Apply the __packed attribute to members instead
> of structures") then the following appears in the kernel log:
>
> Feb 28 14:24:04 ubuntu-vm kernel: WARNING: CPU: 5 PID: 84 at
> drivers/infiniband/sw/rxe/rxe_comp.c:761 rxe_completer+0xdc5/0x10d0
> [rdma_rxe]
> Feb 28 14:24:04 ubuntu-vm kernel: Call Trace: [ ... ]
> Feb 28 14:24:05 ubuntu-vm kernel: WARNING: CPU: 5 PID: 39 at
> lib/refcount.c:28 refcount_warn_saturate+0x154/0x160
> Feb 28 14:24:05 ubuntu-vm kernel: Call Trace: [ ... ]
> Feb 28 14:24:11 ubuntu-vm kernel: WARNING: CPU: 5 PID: 1471 at
> lib/refcount.c:19 refcount_warn_saturate+0xa8/0x160
> Feb 28 14:24:11 ubuntu-vm kernel: Call Trace: [ ... ]
> Feb 28 14:24:17 ubuntu-vm kernel: WARNING: CPU: 6 PID: 1501 at
> drivers/infiniband/core/device.c:671 ib_dealloc_device+0x104/0x110 [ib_core]
> Feb 28 14:24:17 ubuntu-vm kernel: Call Trace: [ ... ]
> Feb 28 14:24:18 ubuntu-vm kernel: WARNING: CPU: 4 PID: 170 at
> drivers/infiniband/core/device.c:493 ib_device_release+0xd3/0xe0 [ib_core]
> Feb 28 14:24:18 ubuntu-vm kernel: Call Trace: [ ... ]
>
> Is this a known issue?
>
> Thanks,
>
> Bart.
