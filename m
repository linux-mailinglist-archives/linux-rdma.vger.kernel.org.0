Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94C1B9DA0C
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2019 01:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfHZXif (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Aug 2019 19:38:35 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34093 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfHZXif (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Aug 2019 19:38:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id s18so16930047wrn.1;
        Mon, 26 Aug 2019 16:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aM/+n5EN1EUh4pevfHPaY7oT40AfQ2ygXNAKqa7gxvM=;
        b=VjcAQKEnmARWmtlqIfdWWRrefyW2kprN1qp9qyxEPgHMJ69fEh/BQOqZnapqN3l8t7
         FPGHU4xS5WR6WSLIRhY+F+NrT6oJbdLZh0sOPJgQ+hjwbSu9h2t/giiF/5NLugi+KHF0
         3qwzgVZZoXLpDDSnVkN0cNvYBeFjgEia+dXxL+zd3eV9M5caD9fziledp/DLxV+DbtT9
         tctKLZh/e/UmUQ/bL4KtlnOOSTvvgD2IovEXM0ymgIkRD2l1J9P/AXZkbHintt/VEreF
         YEpO/tJzi3jztjeh3fkH5WcShnlH1oElgPB+Pxo43zS+x1BK79zWfZrDZEZMCUeLZBCB
         X5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aM/+n5EN1EUh4pevfHPaY7oT40AfQ2ygXNAKqa7gxvM=;
        b=GM6/WLzKATBbp3TpE2IX8vDsdIWbzTVmVNtTgw5PqJuzJ2N0S/5jaBbbtJiwYT/izq
         aFO8idE8AZAPQE0so5gdnpU0WKWe4sEYIm7ks3gGsadohLUIdwKXoXbpDdeuJ+aEgERu
         gUxrxe2OVAUMLg55k5+FKpw5VpFx5JpSWoBgUqaOVd/tN5WO/ef1fGGv+fMthjl1KeBI
         iveAG7u+mOXtgoudXQDxhqNBPEEsokfFhqpDiIyKZVN82HEdqRGvNCJjx0B3ik47FV7o
         cohxXaBzrfwEBeDwmPV74x92HzBQBE4FNRl9K0M5LjphYBTVPnz3u8pFPlDaQuXktnno
         joXg==
X-Gm-Message-State: APjAAAW8A9imv2K2a6e93DzvQL/l5zYTd/L4S7CIJ8R3p8HNP5sDLMRI
        /SPcNlAxAEJPJcng/7YVSzA=
X-Google-Smtp-Source: APXvYqxdsftPy9ha8ksZ7+siReD1ahCjl93ZgmjE6632XAAvOJ7UiKiU2HS5SCrygRqvnylzEkr6mg==
X-Received: by 2002:adf:fe10:: with SMTP id n16mr25904248wrr.92.1566862711681;
        Mon, 26 Aug 2019 16:38:31 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id q24sm1415669wmc.3.2019.08.26.16.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 16:38:30 -0700 (PDT)
Date:   Mon, 26 Aug 2019 16:38:29 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Bernard Metzler <BMT@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] rdma/siw: Use proper enumerated type in map_cqe_status
Message-ID: <20190826233829.GA36284@archlinux-threadripper>
References: <20190710174800.34451-1-natechancellor@gmail.com>
 <OFE93E0F86.E35CE856-ON00258434.002A83CE-00258434.002A83DF@notes.na.collabserv.com>
 <20190711081434.GA86557@archlinux-threadripper>
 <20190711133915.GA25807@ziepe.ca>
 <CAKwvOdnHz3uH4ZM20LGQJ3FYhLQQUYn4Lg0B-YMr7Y1L66TAsA@mail.gmail.com>
 <20190711171808.GF25807@ziepe.ca>
 <20190711173030.GA844@archlinux-threadripper>
 <20190823142427.GD12968@ziepe.ca>
 <20190826153800.GA4752@archlinux-threadripper>
 <20190826154228.GE27349@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826154228.GE27349@ziepe.ca>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 26, 2019 at 12:42:28PM -0300, Jason Gunthorpe wrote:
> On Mon, Aug 26, 2019 at 08:38:00AM -0700, Nathan Chancellor wrote:
> > On Fri, Aug 23, 2019 at 11:24:27AM -0300, Jason Gunthorpe wrote:
> > > The latest clang-9 packages from apt.llvm.org do seem to build the
> > > kernel, I get one puzzling warning under RDMA:
> > > 
> > > drivers/infiniband/hw/hfi1/platform.o: warning: objtool: tune_serdes()+0x1f4: can't find jump dest instruction at .text+0x118a
> > 
> > Any particular config that I should use to easily reproduce this?
> 
> Sure, attached. With the clang-9 build for Bionic

This is reproducible with the kernel config attached and a tip of tree
build of LLVM.

$ make -j$(nproc) CC=clang O=out clean olddefconfig drivers/infiniband/hw/hfi1/platform.o
...
  CC      drivers/infiniband/hw/hfi1/platform.o
drivers/infiniband/hw/hfi1/platform.o: warning: objtool: tune_serdes()+0x1f4: can't find jump dest instruction at .text+0x117a

I ran creduce on that file and it spits out:

a() {
  char *b = a;
  switch (b[7] & 240 >> 4) {
  case 10 ... 11:
    c();
  case 0 ... 9:
  case 12:
  case 14:
    d();
  case 13:
  case 15:;
  }
}

to simply reproduce the warning. The original preprocessed file +
interestingness test are available here:

https://github.com/nathanchance/creduce-files/tree/4e252c0ca19742c90be1445e6c722a43ae561144/rdma-objtool

Looks like that comes from tune_qsfp, which gets inlined into
tune_serdes but I am far from an objtool expert so I am not
really sure what kind of issues I am looking for. Adding Josh
and Peter for a little more visibility.

Here is the original .o file as well:

https://github.com/nathanchance/creduce-files/raw/4e252c0ca19742c90be1445e6c722a43ae561144/rdma-objtool/platform.o.orig

Cheers,
Nathan
