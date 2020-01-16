Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6D1E13F8EA
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 20:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437724AbgAPTVZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jan 2020 14:21:25 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:43299 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731107AbgAPQxl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jan 2020 11:53:41 -0500
Received: by mail-io1-f65.google.com with SMTP id n21so22607324ioo.10
        for <linux-rdma@vger.kernel.org>; Thu, 16 Jan 2020 08:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uAC/LLqL3olhNiYcI8mpq/Wk2UEcqBfRhXyaxNaKlbY=;
        b=ahDyw2WT+cLsDo1SVB0mkMITUwO84KVw9/mYTQ9xOkhJJwsLHrmDxb2ZAREcROshxl
         StiCzFwERoMqQz2HzuB6uc79yyjOviLoj0LC5CE9qYXdxgX+2kLnLqnkQ32XJ4tTJUpF
         6DZ6ocW8o73mUoZqbSs7PKbFrB867OUReK7HnEErI5VemxqAt5a5WKzatP1sA1osm1X3
         r6zh1l8EkSgtbRNBwAQ9+4qrjL+FIW48K0TXXDxnvyaSggLHWgBQgcpOvI2LlwWnF8Yr
         ZoFmdBKPMhU1YxJ6gfFxhfQFLfSnsN/wPoiVn5hzHWLwLf6gbqVcxXQXdRQ/xtEdBQK3
         HxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uAC/LLqL3olhNiYcI8mpq/Wk2UEcqBfRhXyaxNaKlbY=;
        b=UD+5Y9adk16S8vWDqDAkzVp3mYNYMJe5/gRcVSXk28JaI1nn7R5eq0uO1eL6sP8h01
         a+S7r7LU0kHS+2WO0H25/9w+MXAnVnuTAZiXe2Fzx7lsprOBdBwof84by/STsHFwBsc0
         vFfXBRO/ENxAtOlPOCpiIPNpRI3ZDl7h4huMz3kvP96DQIu7BACFDsWJDO2gWi8SBXUP
         GnZbmN/DG+9fomG2/tZr3r9os+QKzDcElRXFzS0EOA/zj1Q491pDClx1dPtCjiFPnugK
         K85nJ26wZXZt3k1kDMrrczq50lzcJpz5vcPIIXXIHwAZpm5RonnD0A3Ee2/LU7e9H/yw
         SmWg==
X-Gm-Message-State: APjAAAUGHGoUSchi+8e5k+KgwhGfUXwPNDudQZ9a09siloEU4wtsRqx0
        dJlCJqXCXkbEzO4JqB3PkPrMZ2tmalxOyfQaH/ED8g==
X-Google-Smtp-Source: APXvYqz/CMc1I7H9snlOYg+zymD+3AllbvT2PU+3zuT66eTV8reVm4lO++qYSVkX5siulLpKd/ZECwlTujdCrYgbavc=
X-Received: by 2002:a6b:ca43:: with SMTP id a64mr6547189iog.217.1579193620289;
 Thu, 16 Jan 2020 08:53:40 -0800 (PST)
MIME-Version: 1.0
References: <20200116125915.14815-1-jinpuwang@gmail.com> <20200116125915.14815-24-jinpuwang@gmail.com>
 <20200116144005.GB12433@unreal> <CAMGffEmaif+Gc-OT2Dmn+u06A3tryHA0bu52ekroHaixBFZKGg@mail.gmail.com>
 <20200116155903.GB18467@unreal>
In-Reply-To: <20200116155903.GB18467@unreal>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Thu, 16 Jan 2020 17:53:29 +0100
Message-ID: <CAMGffE=R81u1whK1AotCu4agAd4UwzTMEM177pHsJRLKoHNdkQ@mail.gmail.com>
Subject: Re: [PATCH v7 23/25] block/rnbd: include client and server modules
 into kernel compilation
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 16, 2020 at 4:59 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Thu, Jan 16, 2020 at 03:54:03PM +0100, Jinpu Wang wrote:
> > > > +obj-$(CONFIG_BLK_DEV_RNBD_CLIENT) += rnbd-client.o
> > > > +obj-$(CONFIG_BLK_DEV_RNBD_SERVER) += rnbd-server.o
> > > > +
> > > > +-include $(src)/compat/compat.mk
> > >
> > > What is it?
> > >
> > > Thanks
> > quote from Roman
> > "'
> > Well, in our production we use same source code and in order not to spoil
> > sources with 'ifdef' macros for different kernel versions we use compat
> > layer, which obviously will never go upstream.  This line is the only
> > clean way to keep sources always up-to-date with latest kernel and still
> > be compatible with what we have on our servers in production.
> >
> > '-' prefix at the beginning of the line tells make to ignore it if
> > file does not exist, so should not rise any error for compilation
> > against latest kernel.
> >
> > Here is an example of the compat layer for RNBD block device:
> > https://github.com/ionos-enterprise/ibnbd/tree/master/rnbd/compat
> > "'
> >
> > We will remove it also the one in the makefile for rtrs if we need to
> > send another round.
>
> Yes, remove it please.
>
> >
> > Thanks
ok, thanks
