Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28A1F2F87B4
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Jan 2021 22:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbhAOVcs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 Jan 2021 16:32:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbhAOVcr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 15 Jan 2021 16:32:47 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DC0C0613D3
        for <linux-rdma@vger.kernel.org>; Fri, 15 Jan 2021 13:32:07 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id y8so5365596plp.8
        for <linux-rdma@vger.kernel.org>; Fri, 15 Jan 2021 13:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=AtLBA7uuUFul/aJJJeBaxKdBMacDJCjx0Ir7LQX3mYc=;
        b=Gx2s55H4OyQ6I5P6Z0gQZgC+6oJYPmUh/sKQALNsp0CTNLcRISlxBdjIzlf+zYD73m
         2ju4LK328SVQ61G1Lhe1Ykg2u3nHrYzLmYiZ77udbABtvdlm/eZNlEN+IIRSW9NNBJoa
         VrzOshDpj52hgI45Hv6kSKnM64pKjXYGDuMFNlLZwizZzWrdmfopzkeeVuYlsIBQ12qX
         iVEjItG0Z/oqwMaHIjaMmIthMlx35KyYW5OBMEYy8ztZpQ8F4vZOG5cZO/1JQHsKfQa/
         eW2lVPhAxlMEsS9Ry2K9dBAXjvQ1C4HcsfwzRF/qV8dpvqDPx3Fcsl/mA1Z0Wzg4/VN9
         WmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=AtLBA7uuUFul/aJJJeBaxKdBMacDJCjx0Ir7LQX3mYc=;
        b=CGsi2l9eTB5IbHUGCArIzUv9B/1gNMySnN9C3JxQnkdMwtn1uc2rgoQDtYPvmV4XYB
         wwWa6siCh9wKd6cWIQHtAbC2wTLXXPSdpdhr0u6jKyNpMIUzLVgYDjyr2R1ND1oqy8Nk
         YXlj4YjeCGF80VUGP4sNbclRQjSAbVFM2JGczvpx8Qjoyr25xn+adjSePOPhFRsC74jC
         E/3Vus3Q2OR5fFS7adAsjVcwaL4HU+3R+HsnZbhf8ql7Imc2QqdtlEG0sn0bdxwG5CSV
         2nf5pf6KWd79lPYeL0Qhtts1vOpSswzoMwXl52966jwMxXhm3t2yxpkH+1Th1Lp4141Z
         sqRA==
X-Gm-Message-State: AOAM533J8D1Xeb2g/s69cDxT0u8qN3ii4NUgShK1SGlDR359ZPMn/876
        /yPNB/Na0HR5fHZuDzn501FrJ4zFR/aqGLd+OHba0Z0R65E=
X-Google-Smtp-Source: ABdhPJwHT3Asj6UZUelzxmU2SzmHOIlt2kkDRiQ9wnjoHqhFZpGtMO93/3H0FAzMRcQPucMm64ecvU+L1DqeuZGGeME=
X-Received: by 2002:a17:902:e98c:b029:da:cb88:f11d with SMTP id
 f12-20020a170902e98cb02900dacb88f11dmr14444574plb.17.1610746326812; Fri, 15
 Jan 2021 13:32:06 -0800 (PST)
MIME-Version: 1.0
From:   Ryan Stone <rysto32@gmail.com>
Date:   Fri, 15 Jan 2021 16:31:56 -0500
Message-ID: <CAFMmRNzVPd-3SV=LQb+cKFj4yBB-BEvV1d3bmKeLxjcswZtD0g@mail.gmail.com>
Subject: mad.c appears to use msec_to_jiffies incorrectly
To:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I'm looking at how MADs are timed out in drivers/infiniband/core/mad.c
and I think that the timeouts are just implemented incorrectly.  An
ib_mad_send_wr_private's timeout value is always initialized like
this:

mad_send_wr->timeout = msecs_to_jiffies(send_buf->timeout_ms);

This converts a timeout value in milliseconds to a relative value in
jiffies (e.g. if timeout_ms is 500 and HZ is 100, then msec_to_jiffies
returns 5).  However there are a number of places in mad.c that use
this as though it's an absolute jiffies value.  For example,
timeout_sends() compares the value to the current jiffies counter:

https://code.woboq.org/linux/linux/drivers/infiniband/core/mad.c.html#2853

This doesn't make any sense. In principle it should be fixed by
instead initializing timeout as follows:

mad_send_wr->timeout = jiffies + msecs_to_jiffies(send_buf->timeout_ms);

but there are also a number of places that check if timeout > 0 to see
if it's active and that needs to be fixed, possibly with a separate
active flag.

Am I missing something, or is this just broken?
