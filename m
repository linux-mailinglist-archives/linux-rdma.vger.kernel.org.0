Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 216D2128987
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Dec 2019 15:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfLUO2H (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 21 Dec 2019 09:28:07 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:38727 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfLUO2G (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 21 Dec 2019 09:28:06 -0500
Received: by mail-io1-f65.google.com with SMTP id v3so12260437ioj.5
        for <linux-rdma@vger.kernel.org>; Sat, 21 Dec 2019 06:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Prd73x3m1oH2epmhiGL3DVbj6k1ituH6b/G8OUPXtR0=;
        b=CZdIRwnvAf8usj6GfyZc4kMlzNjW6Ln8nxKlXFcc/5q8nJCvtg+MkoS5x9+RyP9mr0
         UiEYlvsGcyFqTibPBI+qI+NTUDZe0j9dObsnkzsBi4hfmi45eTRrQsB2NRW33rDQuzql
         TxdxqGK+1NkTI6XaNgumky/VpPQLPnZjXXjzdVE/SAf5v9HRfLW/7ltUQYzUSR991I53
         P3OiuqU91y294hJqkoQnwbs7/4DXQV+pS0l0srOJIbBtQkMTnLZnqWPkZxEdKmiRt9vu
         qBTj3kfR1ttUVzHBNHKVpXZl+5hVo2ydTThCSzrPNrihWy+Jl7SMxfuHtxEU2NxmyoqD
         LL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Prd73x3m1oH2epmhiGL3DVbj6k1ituH6b/G8OUPXtR0=;
        b=TtrDEoexF4Umvxkyp+M9V9ZDqkDT28D/pPgDUzz+XPjotPXBKHqetmxIZxQTTggYr7
         7AXdF0xJ05iAHOv5HriKNfww0rVHXrQkWAChlUr8t2KbxJLc16KbzMR50zeLFKrPb7FI
         /q0OZ7ieRRPJks8Ch8Sc6ksxv5i0KFFuqXguD7IOVLPDR92nusrSb7J15Ss8bAPW7Wf3
         p7iyRDD5LiZ5zyiMAXf+ddDPfreUtt04gq82/fLQMyx5I8s5em2rXXaW0WBBidwvEgZC
         MPcTRJkuHmL6wvsKV66NecZMoXBSg7TqKQgV18qZi8AKEOQsRnivE48/INVbJXyF7GvT
         0R6A==
X-Gm-Message-State: APjAAAWQrgwRcGDtWnS/OirSaC0UC1rdf2tUdpTHtdv3Gi/nKJ6UaogV
        pVyhbyTKa2FQlMFIme1hxnfGUxR33lTQ+Q3mOOFfy58=
X-Google-Smtp-Source: APXvYqxCao/ASHWi/KROdKEZlBEBZwYnWwjdjl+mM9lQuL/kqN11QE/EHFHGWMmmndchgbHqo37EFHTtfekrGT1XWM8=
X-Received: by 2002:a5e:c314:: with SMTP id a20mr14285199iok.300.1576938485965;
 Sat, 21 Dec 2019 06:28:05 -0800 (PST)
MIME-Version: 1.0
References: <20191220155109.8959-1-jinpuwang@gmail.com> <20191220155109.8959-3-jinpuwang@gmail.com>
 <20191221101530.GC13335@unreal>
In-Reply-To: <20191221101530.GC13335@unreal>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Sat, 21 Dec 2019 15:27:55 +0100
Message-ID: <CAHg0HuxC9b+E9CRKuw4qDeEfz7=rwUceG+fFGfNHK5=H2aQMGw@mail.gmail.com>
Subject: Re: [PATCH v5 02/25] rtrs: public interface header to establish RDMA connections
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Leon,

On Sat, Dec 21, 2019 at 11:15 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> Perhaps it is normal practice to write half a company as authors,
> and I'm wrong in the following, but code authorship is determined by
> multiple tags in the commit messages.

Different developers contributed to the driver over the last several
years. Currently they are not working any more on this code. What tags
in the commit message do you think would be appropriate to give those
people credit for their work?

Best,
Danil
