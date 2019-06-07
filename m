Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE61B3971F
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 22:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbfFGU5W (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 16:57:22 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44245 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729891AbfFGU5V (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 16:57:21 -0400
Received: by mail-lf1-f65.google.com with SMTP id r15so2586078lfm.11
        for <linux-rdma@vger.kernel.org>; Fri, 07 Jun 2019 13:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tny04mc/baghyNAFbwqZ/oFPlAWsvuYVsFUjkQqS22Q=;
        b=QNjqqGcbdGS6ZZ8Py7DrJaDT7cFcTNRm3NFiWdMD9IiJe7FR81nCaS4ldYhjYQaa3x
         pDZ5dtaQh4VtXRU/M4vMtz6V86TMfvWqfIOv3+xQ1BS3Pi/OO8O34PrdybxezwGLFnCA
         796+BWV1HccLI+fGw5gqheajIrNxGca1f6Uv38w0SnJb21LsBYtuvkgZh+7P53Wem6Jj
         v1LkfYLNkunt2AZr9uAea0s8kIG7tfsuyXHc6LOsqr0UjKu/sKW1okPNjSls4KDZ0RxL
         AyfSU2pULwfpv2onwyxRS9I+M50aNUxdHUI7kSVEx7UEAZ1INmBowgvS78Dnkqo8S+cx
         zMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tny04mc/baghyNAFbwqZ/oFPlAWsvuYVsFUjkQqS22Q=;
        b=dXsX4k/quQG9S+ZV+1lW5lPkzxzDei/cg87MNcWzp51Vc0l6+XynC5oVu+5HDoFOQh
         y7LaKpRSogVBqN8cntYZTDUvLzJg/ulmn1eRGYBHuOmK2nGPfBfGOnmcIZfkhN+QyodI
         DG1XYXtfJOI09SDrQe/68XMK3JeiaJwyYqyJMdwvm9UM2aHL0wGN/tmR56ITsjsBUZR2
         6yOIQcD19yRcoYu2E4JGN8BY4rka/3caAkrpHr5sEhD5LNyy5u/nnSOYr+3JFRE6C9Ta
         DDL4fIefOU+IJgAIRGZj/abQOTuhWfQ9mSQRQz/sbPF2nkTeAGgnXSbrtWAbhn7xEeZF
         T9Yw==
X-Gm-Message-State: APjAAAWTtQevjqUxqGMlu2hxupdlFESbx8Di9EnR0N43qvNzXkH6mYqk
        jFp8lrwLI47y9iyfGazHr8Pf/C8UVmdIMV712LQ=
X-Google-Smtp-Source: APXvYqxZe1mVzQxPGczygMJ7Uvjoz9hw+fjkiPEv98As/XW3kebMuog/DbkAruQO2q5Tc4hMSjsxYVTQBupk3BZEUnY=
X-Received: by 2002:ac2:4ac5:: with SMTP id m5mr4395351lfp.95.1559941039830;
 Fri, 07 Jun 2019 13:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190523153436.19102-1-jgg@ziepe.ca> <20190523153436.19102-9-jgg@ziepe.ca>
 <CAFqt6zakL282X2SMh7E9kHDLnT9nW5ifbN2p1OKTXY4gaU=qkA@mail.gmail.com> <20190607193955.GT14802@ziepe.ca>
In-Reply-To: <20190607193955.GT14802@ziepe.ca>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sat, 8 Jun 2019 02:32:23 +0530
Message-ID: <CAFqt6zZbQmPq=v9xtgHfc5QCy4Vk8pjWgTOY0+TyFgHmEnWTsg@mail.gmail.com>
Subject: Re: [RFC PATCH 08/11] mm/hmm: Use lockdep instead of comments
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jun 8, 2019 at 1:09 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Sat, Jun 08, 2019 at 01:03:48AM +0530, Souptick Joarder wrote:
> > On Thu, May 23, 2019 at 9:05 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > From: Jason Gunthorpe <jgg@mellanox.com>
> > >
> > > So we can check locking at runtime.
> > >
> > > Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> > >  mm/hmm.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/mm/hmm.c b/mm/hmm.c
> > > index 2695925c0c5927..46872306f922bb 100644
> > > +++ b/mm/hmm.c
> > > @@ -256,11 +256,11 @@ static const struct mmu_notifier_ops hmm_mmu_notifier_ops = {
> > >   *
> > >   * To start mirroring a process address space, the device driver must register
> > >   * an HMM mirror struct.
> > > - *
> > > - * THE mm->mmap_sem MUST BE HELD IN WRITE MODE !
> > >   */
> > >  int hmm_mirror_register(struct hmm_mirror *mirror, struct mm_struct *mm)
> > >  {
> > > +       lockdep_assert_held_exclusive(mm->mmap_sem);
> > > +
> >
> > Gentle query, does the same required in hmm_mirror_unregister() ?
>
> No.. The unregistration path does its actual work in the srcu
> callback, which is in a different context than this function. So any
> locking held by the caller of unregister will not apply.
>
> The hmm_range_free SRCU callback obtains the write side of mmap_sem to
> protect the same data that the write side above in register is
> touching, mostly &mm->hmm.

Looking into https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/tree/?h=hmm,
unable trace hmm_range_free(). Am I looking into correct tree ?
