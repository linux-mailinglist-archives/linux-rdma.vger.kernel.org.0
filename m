Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B76939560D
	for <lists+linux-rdma@lfdr.de>; Mon, 31 May 2021 09:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhEaH1t (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 May 2021 03:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbhEaH1s (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 May 2021 03:27:48 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E95C061574
        for <linux-rdma@vger.kernel.org>; Mon, 31 May 2021 00:26:07 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id t10-20020a05683022eab0290304ed8bc759so10259777otc.12
        for <linux-rdma@vger.kernel.org>; Mon, 31 May 2021 00:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z7U7r6XxuJ9pEh2cunSx+B0xZSnt+VZSJs4LLn/f9js=;
        b=p3nai0ybDF5MIbgG2OniGn5a3byhzKqZNVfGdMqpjnHm/Gqpy/Tvnk9JUva3/brdtn
         mJ5xOaAsmGRr0rryLQAjj7stSQaiz+NxbfCW2pGR7NqFpsdSZFQxTt1CLKMOMixIK2yn
         z2PHqo6fjGFwEGQmGHEmETJn7sxiRrgJyRlqrlMSgIVZjPhz4zgq/Rmtfyg0II5o2SrA
         xvdN4gSkTJUpGtRFQs1l/jeC10B5XqCJ0VXLPHq1OsVqCRZ5OGvzw6tIZh7jqZqAVfu7
         i47uM5N+fJ6XKKpkxfMmYDjHPe3yz1X/QJM5zKwVgUVZq1IaPPvGREtK00ulPn/mJAzS
         SiKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z7U7r6XxuJ9pEh2cunSx+B0xZSnt+VZSJs4LLn/f9js=;
        b=pqgdT1HgUBu3dDTR9XLFIdsDNLq92acmR4M/dGP+5qEVQPFyXn+OGxrSMnLxtOglxg
         nVAjKy6lOp1HXXdXCPrTaZrfnK0TAqIMAPXke+w5PUBBZS3tktkL9qImQCFtJQtFnSjy
         cR9Eb8cgF3EC76e5hA0PXJVNNU1vqws+KKLAx2v3oh1mBa8OQhsFbPPUGsLzUXETwkQv
         l0B79OjMP7Wi4NKHiETpRLdNEqb3fPl5hJNrXVcoV9mLbKLHrIoL+qA3ZgBzXyzRM/So
         2Kyp8RXscc9yRSz8uKUJEx9owuFuqNwrGHScxXozvmXg8OA1AM4EiOGnMYoC6tw0tEZ6
         hnUA==
X-Gm-Message-State: AOAM5324WeeBNO6+F6BO114E03OXYIvEcTM4XaFu5Zd4Qa+cV5Acc7VA
        XYGJ3jwgGFQJbP/8XQgWVcb3awL0jaaQvyJeloo=
X-Google-Smtp-Source: ABdhPJyLVreorYlHDag7N47J1hPtWqlMv7Oqw4MI21s8YHXa3UsVfAsIyq8vhli7W2/zt7jDbeds+MmXmkJu80u0tLY=
X-Received: by 2002:a9d:4801:: with SMTP id c1mr6663236otf.278.1622445967358;
 Mon, 31 May 2021 00:26:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210527194748.662636-1-rpearsonhpe@gmail.com> <20210528202958.GS1002214@nvidia.com>
In-Reply-To: <20210528202958.GS1002214@nvidia.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Mon, 31 May 2021 15:25:56 +0800
Message-ID: <CAD=hENesGbOujMZ3TxCAqb9+epojOTKH2Xr0TgJqGORmEoto4g@mail.gmail.com>
Subject: Re: [PATCH for-next v3 0/3] Fix memory ordering errors in queues
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, May 29, 2021 at 4:30 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Thu, May 27, 2021 at 02:47:45PM -0500, Bob Pearson wrote:
> > These patches optimize the memory ordering in rxe_queue.h so
> > that user space and not kernel space indices are protected for loads
> > with smp_load_acquire() and stores with smp_store_release(). The
> > original implementation of this did not apply to all index references
> > which has recently caused test case errors traced to stale memory loads.
> > These patches fix those errors and also protect kernel indices from
> > malicious modification by user space.
>
> I didn't read it carefully, but I think this captures the basic
> solution

I made tests with rdma-core.

With or without changes of kernel-headers/rdma/rdma_user_rxe.h,
the previously mentioned 17 errors disappear.

So this patch series takes effect.

Zhu Yanjun

>
> Jason
