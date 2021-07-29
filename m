Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143CF3D9DC5
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jul 2021 08:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbhG2Gmm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jul 2021 02:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbhG2Gmm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Jul 2021 02:42:42 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B99C061757
        for <linux-rdma@vger.kernel.org>; Wed, 28 Jul 2021 23:42:38 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 61-20020a9d0d430000b02903eabfc221a9so4912361oti.0
        for <linux-rdma@vger.kernel.org>; Wed, 28 Jul 2021 23:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/ANL8XkryTyFZKOTzhI1wDltzpeQc2KMP3Slba+WBzc=;
        b=JgeLSQJgy5wWGXvlOGCawCguc6VVlOvuEEGdl+dF7Uji54KnH/pY4BjkuZRMh1JDc2
         iFLnyo4UR9VryZXgDEBneLOL+AWipgbsAgZm3CaUQ7ah0LNnkuoiu3P0nh9tSuveZ6BJ
         nIIGV5NUjWRXEXa4Exsur5GY14rREdEm+oau68+xpNX/ao04qoTCVwWKOZ/32Tvzpuuz
         yNXoIT/dtXRgkci3onCmyr7GxnHOlcea4RDx7XrT48cHSVXr76/hoUmuxp0zc63GQaK7
         HhRs/FagPYBdpQyCN9VkKd9O/0gcLJojFG1QcVEEGbrhXx+y9SgV/22P80QdHl301it4
         TODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ANL8XkryTyFZKOTzhI1wDltzpeQc2KMP3Slba+WBzc=;
        b=M17tYX+p20iVrlcJ0NexA+be5/4Nyvo1lBqfc5/wh4tGbxG6bcLfs1VAI1sfL+p1G2
         3oXUBQ2gH2b6QKHH1Y2fNzDJM2a6im+tqd5fZNLS/3J6/SPEcV/okEYg69IoSGyh7Q1I
         KSmPT8+Sitcr9zP5jvfbJbxGO4w6MaLWMgWDivc4rqEye695Jo0uuNUkrJ3MWaxEZqNH
         nCaN5z2DWJz9gERvrh/TdQ+ffkZAiaeWb4krQ7iEOcioU7NPRUfoyEX8bHT00W5IrA1p
         6e26SudpcumzNPPZGZSimTr9JYGWHqsapk/oY0cyQX7sSd0pZuSiIkhNsH/kjvppVk4/
         LSCQ==
X-Gm-Message-State: AOAM530nfAggWITaQGHtY93RwDjIxBam7cXoSdt9nkxv85DZNCMP4Lc+
        ILOYbz/ADzpmyBRNO48Rir23OAydvPPp8Zh2LDQ=
X-Google-Smtp-Source: ABdhPJwgpkIY95/lhoCVAQPOGJajT/blEkebhvWl3J17N6mYF2tOJrg2RR2IroLiuZJ1sYyLpHA0v+LPqMoVb5sZrmA=
X-Received: by 2002:a9d:5f87:: with SMTP id g7mr2528643oti.278.1627540957647;
 Wed, 28 Jul 2021 23:42:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210718225905.58728-1-Rao.Shoaib@oracle.com> <54817f70-e7e5-d145-badf-268ba7533110@oracle.com>
 <20210727174144.GE543798@ziepe.ca>
In-Reply-To: <20210727174144.GE543798@ziepe.ca>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Thu, 29 Jul 2021 14:42:26 +0800
Message-ID: <CAD=hENdOrfyq2buP269LQVhq+QkZ=hpA3jpbZH+CAFt=CGLV-w@mail.gmail.com>
Subject: Re: [PATCH v3 0/1] RDMA/rxe: Bump up default maximum values used via uverbs
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Shoaib Rao <rao.shoaib@oracle.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 28, 2021 at 1:42 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Tue, Jul 27, 2021 at 09:15:45AM -0700, Shoaib Rao wrote:
> > Hi Jason et al,
> >
> > Can I please get an up or down comment on my patch?
>
> Bob and Zhu should check it

In my daily tests, I found that one host 5.12-stable, the other host
is 5.14.-rc3 + this commit.
rping can not work. Sometimes crash will occur.

It seems that changing maximum values breaks backward compatibility.

But without this commit, that is, 5.12-stable <-------> 5.14-rc3,
rping can work well.

Zhu Yanjun
>
> Jason
