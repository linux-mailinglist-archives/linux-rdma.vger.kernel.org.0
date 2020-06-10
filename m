Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCCC41F5B10
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2020 20:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbgFJSVR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Jun 2020 14:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728786AbgFJSVQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 10 Jun 2020 14:21:16 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACED8C03E96B
        for <linux-rdma@vger.kernel.org>; Wed, 10 Jun 2020 11:21:16 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id g3so2884856ilq.10
        for <linux-rdma@vger.kernel.org>; Wed, 10 Jun 2020 11:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1lVHo5inHb2+n26ccr9Wy52YqM0oq6OGv36VNabzlt0=;
        b=XANv8mEivoCbM50569FsH74tQTlcaKGBVMJGPoMFvuO6ZpRipncYfD48G/gLkow0as
         LAlI6cMt0TjHa5k5T9AVuV04l00YPbur30Rak7EziKENJAfvf8/p/5xLiPYzeyOVvLcj
         4A81HeAeslbD4nYMlylL8hdZbsRqqBM6Gh0/34xMszEZN3FEecbRIoYPCbAZ6h7ySxPK
         Ef68kPaasSrBAQi/+VACby/kcVWfmrcIxOoA9AjUSd951XX+2pbK5itxjEqrKg9Pu+2i
         wXN+8jqfvw5pGsL5pNPnkULO/1h/qdvAvgZ6OZGMCy3jp1fRaF9P4In7n4bYr95bRzqf
         lKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1lVHo5inHb2+n26ccr9Wy52YqM0oq6OGv36VNabzlt0=;
        b=L/0L+yaMEcJ6gG5eUhLgvqBO9RrwEB2jbTuFnQYzkdWfrbxqoOGei4mky8x+sY4Jha
         o7ITxWNsYxbEWOmYj88fVv/H5ZRf8uHk8Y+Cui2bJB5ypRIQ8nz6aTtGWpMa3HE8wquh
         jsNp+3U7bZJrYHH/cnV1FqL3pG+Js297LJDQMPMImzPJyJe6XltCE0hKsckc5YqR1yCb
         LIZEy87IFboNprVjrCHEbTvUr+WoBJmOH2X7E6LpNQisiQHQYZZtEBaQ3E9T9pYuCxSs
         tSNi2HwALrHFsXqOMNHyALIbKHq6HIOrLYUrRujP4V3zatoaR+M11ghb+L9Kk75/EDVo
         +N5g==
X-Gm-Message-State: AOAM531Es90CCTgVTdj0nim2lUxthYjymkX/nOd+XZckDlxwFWdupGoM
        xZ5SJyCAxUlFWvgf438AzLRvcSRJLY6e/JG1nWc=
X-Google-Smtp-Source: ABdhPJyXNFR99xel3ynUKclMAfeRxCwiJqQDVjsx7C+mHxDT1uJXSeSGKJ7KKoVsZYrxHX0E63ORxG6h/q16gPGyGrc=
X-Received: by 2002:a92:c746:: with SMTP id y6mr4274801ilp.116.1591813275904;
 Wed, 10 Jun 2020 11:21:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200610174717.15932-1-tseewald@gmail.com> <20200610175008.GU6578@ziepe.ca>
In-Reply-To: <20200610175008.GU6578@ziepe.ca>
From:   Tom Seewald <tseewald@gmail.com>
Date:   Wed, 10 Jun 2020 13:21:04 -0500
Message-ID: <CAARYdbjd+eBKpe8E9vCYi13QgxgGf4Ur4WTzSJFP6KJL4hJGpQ@mail.gmail.com>
Subject: Re: [PATCH next] siw: Fix pointer-to-int-cast warning in siw_rx_pbl()
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 10, 2020 at 12:50 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> How is a dma_addr_t being cast to a void *? That can't be right?
> Bernard??

I was also confused about that, as I couldn't tell how/if it is able
to guarantee the bus address is the same as the cpu address. I just
assumed it was my lack of familiarity with the codebase.
