Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03EB0257357
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Aug 2020 07:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725794AbgHaFhl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Aug 2020 01:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgHaFhh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Aug 2020 01:37:37 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F58EC061573
        for <linux-rdma@vger.kernel.org>; Sun, 30 Aug 2020 22:37:37 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id t9so3935758pfq.8
        for <linux-rdma@vger.kernel.org>; Sun, 30 Aug 2020 22:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=Tj3+c/5mu2y7NtUbu8Tmrv7qKc6My/jhDsNSLws4SGE=;
        b=iGJQuXAIrQKcTLN9qmoqnMey73N0Cb884uh10kHZjZ8jk6q8fEWnuuLV+3gYArnP+h
         3MWVjt5nUPgx5g/+VVxpLmZ/2qlhgcNFWtsMKqp5VwYTOfKk6mfCnlilRwwEN1dEBLbc
         24dyq0ZItXypV1EWsja1ve5XfNn0MrHrM5vAGyRN8MTI7GacvGxto8AfG9nvliFwA+6+
         pG23WFYVJQ8ZJ4ZNUFshOoJyf8/OEiyz4spKQdiT2T6+WgWBhoA9Dx7hfmI0BsNCYUS8
         MRGyRtEAdrc09+A0xwB7ijOLuqPFscmjq/wbE6DkO2Oib5AjK78tn936JDekzHedLCU0
         rjHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=Tj3+c/5mu2y7NtUbu8Tmrv7qKc6My/jhDsNSLws4SGE=;
        b=RR2Jc91sh6oCQC09CGVBaZUHVlYC9DooeOc179J05eNWsvWWj/9GOc9G6raCIZhgTD
         NddfenUxm4AmQL6vY3lXY6pgL5qDhY6Nrqq12Q1vcMQ1TkreQy5RET646OCjgoge+M9p
         d1laaX1SNn8OA5yqAZHi/mVw9q9x4PhXmmxWeL+Lhr9hQ7gVw8aS3LQ7pCVK3rvDhIP3
         U+ypxIbzT1HgFWUfcsp8Zk2U9//DYUY+HwdotTTw8TUfBUwdFeco0wOSJh+5nSEocUxC
         G56oou1ABmB8LURuy/g0kSPsKYG2RSZ42INKYhiFM5HGzsO/aRtj5IIgiXhjcOHRHDrG
         +odA==
X-Gm-Message-State: AOAM5331jS50Hmm/TA/Jcj/79bMsu2GSbjqdztgVbghgI6F159Ae2lKB
        okvlEb6uxFXXMSO8drYyhBOG0l57+sotQtGEPrw=
X-Google-Smtp-Source: ABdhPJzYOVE3kMVTg0kCHC31B/FlmJ0aQ58Z/VQONHYL6goAomRz8Qc67J15t/7mbqDu1n8QGHbFRbb49SuC8KtJ5HY=
X-Received: by 2002:a63:9d0f:: with SMTP id i15mr25391pgd.413.1598852256164;
 Sun, 30 Aug 2020 22:37:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200830103209.378141-1-sagi@grimberg.me> <20200831051453.GA13058@infradead.org>
In-Reply-To: <20200831051453.GA13058@infradead.org>
Reply-To: doug@easyco.com
From:   Doug Dumitru <dougdumitruredirect@gmail.com>
Date:   Sun, 30 Aug 2020 22:37:10 -0700
Message-ID: <CAFx4rwS-4VGvDr1bnhVuPitBREbZKDnn7SiYhMbOCxji28evbA@mail.gmail.com>
Subject: Re: [PATCH] IB/isert: fix unaligned immediate-data handling
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Sagi Grimberg <sagi@grimberg.me>, linux-rdma@vger.kernel.org,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Rust <srust@blockbridge.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Aug 30, 2020 at 10:14 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Sun, Aug 30, 2020 at 03:32:09AM -0700, Sagi Grimberg wrote:
> > Currently we allocate rx buffers in a single contiguous buffers
> > for headers (iser and iscsi) and data trailer. This means
> > that most likely the data starting offset is aligned to 76
> > bytes (size of both headers).
> >
> > This worked fine for years, but at some point this broke.
> > To fix this, we should avoid passing unaligned buffers for
> > I/O.
> >
> > Instead, we allocate our recv buffers with some extra space
> > such that we can have the data portion align to 512 byte boundary.
> > This also means that we cannot reference headers or data using
> > structure but rather accessors (as they may move based on alignment).
> > Also, get rid of the wrong __packed annotation from iser_rx_desc
> > as this has only harmful effects (not aligned to anything).
> >
> > This affects the rx descriptors for iscsi login and data plane.
>
> What are the symptoms of the breakage?

You don't get the same blocks back that you just wrote.

A simple program that tags sectors with sector numbers gets blocks
that are shifted by 72 bytes.  Shows up basically instantly.
Completely non-functional for pretty much any application.

I tested this on 5.4.61 with both Mellanox Connect X3 (ROCE) and
Chelsio T580 cards (iWarp).  Both required that ImmediateData be
turned off on the target side before the patch.  After the patch, it
works both ways.

This is from a thread that started late last year and went thru about
March.  Sagi then seems to drop it, until I pinged him on it a few
days ago.  He asked me to test the patch and then I did.  My tests
were only two systems and I did not dig into the patch.  I don't think
Sagi has the hardware to test this end to end himself.

I am not sure how much the ImmediateData hurts performance.  I get
wire speed either way on my single socket E5-1650 v3 server.

Doug Dumitru

[posting twice, forgot to turn plain text on, sorry]

-- 
Doug Dumitru
EasyCo LLC
