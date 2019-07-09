Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDA063DF2
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2019 00:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfGIWne (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Jul 2019 18:43:34 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43806 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfGIWne (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 Jul 2019 18:43:34 -0400
Received: by mail-ed1-f66.google.com with SMTP id e3so53146edr.10;
        Tue, 09 Jul 2019 15:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Bh8QhLrIO3RugtTDXdyA4eZU0GwZc1k0MJ3m0NtHp+0=;
        b=V07aqRO7cutJ7h5lrp/xOkjNqw6+Crd9ahOx4DgfipJYZBmEKBZB2G/0EYpgqXVIQ7
         28Mn/hoVSkTh7TXIKDBYB+s4MEqdXC1PMsXdRGPVno/yRkTmQtSflVTTGbuGUaB06Yfa
         WyvIfMMpkfUqgUXPu6EYpXtP8lNzyPcBwmVWqPam0mrutFmx8baXiXa6C7XFUyMy6lg+
         KFBNqQpyfO8095HZllZmwvu9jqTGdlfrPKR6PFoTg9GoHYi4I4PJdGn4ZGohkP/wMbH9
         CW4UJ6tuwH+uLk2HGwAVK3qs93qxQJSwlyIeyxhgddrcLvwF5VfmBNA6YE6M2TWSnmaR
         zHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Bh8QhLrIO3RugtTDXdyA4eZU0GwZc1k0MJ3m0NtHp+0=;
        b=lpSheNKM85GDjkkhxTe2JYBOA/XfbyiolAG6i/rP7Mtl3vLuXFi9kEXqhdvVKpIebn
         cOe/R7KR4Gm+T6Ti1pBvmMBOBEJyAACwX5kEJ4Ma/UY0DfLTY5Sdf9wVNaJEP3aO7k/t
         iZ46eGvt+44iLzpgrCXemIAFW60XA0lB+wC6HuE1cDBtz+/sNDVhOSn1QHu4ZmJ4mSTR
         q7m+PsZwvwP4bcnN3We3ZAJUASiIuF94K9MBILos1MLP9PlzlL6i1wMqCdO5JIdWH1hE
         2ldId+Cij0buvb9qayBAZQfTeMJDIX2SIlCKfBkhWlhzvMRDbC00HMnFYrntA+BJcc+k
         rO7w==
X-Gm-Message-State: APjAAAUI9Wf+xXlL69oXC8t65CQ/9ASx2JNQ/hWXudmBzEojrHSWZACR
        UmNOBHuk/6vEkqs9zdlbdDA=
X-Google-Smtp-Source: APXvYqxyFmYhe/cDA4ymu6yfujv7LuLfSXIWy3ftDDzXWpSoAJ8P3tRXtxZLDdqCvB+FayC/Z+bDkA==
X-Received: by 2002:a17:906:1302:: with SMTP id w2mr23439213ejb.308.1562712212062;
        Tue, 09 Jul 2019 15:43:32 -0700 (PDT)
Received: from archlinux-epyc ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id d18sm97904ejh.2.2019.07.09.15.43.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 15:43:31 -0700 (PDT)
Date:   Tue, 9 Jul 2019 15:43:29 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kamenee Arumugam <kamenee.arumugam@intel.com>,
        linux-rdma@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] IB/rdmavt: Remove err declaration in if statement in
 rvt_create_cq
Message-ID: <20190709224329.GA26727@archlinux-epyc>
References: <20190709221312.7089-1-natechancellor@gmail.com>
 <CAKwvOdkXwD6Wvyt5tYWJP7f3YePqUe1_TvST2RMNb_tSEc3cEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkXwD6Wvyt5tYWJP7f3YePqUe1_TvST2RMNb_tSEc3cEQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 09, 2019 at 03:38:57PM -0700, Nick Desaulniers wrote:
> On Tue, Jul 9, 2019 at 3:13 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > clang warns:
> >
> > drivers/infiniband/sw/rdmavt/cq.c:260:7: warning: variable 'err' is used
> 
> Oh, !$*@, this is a tricky one.  While the if scoped `err` declared on
> L250 is initialized when used at L260, the function scoped `err`
> declared on L211 is not initialized when it is used on L310 when
> control flow enters the if on L249 then the goto on L255 or L261.  So
> this is a bug due to the if scoped `err` "shadowing" the function
> scoped `err`.
> 
> Maybe not important enough to send a v2, but I feel like the commit
> message should say something along the lines of `fix a potential use
> of uninitialized memory due to shadowing`.  Either way, this fixes a
> real bug, so thanks for the patch.
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Gah, shadowing was the word I was looking for. Knew the behavior, didn't
remember what it was called. I like the clarity of your explanation
better so I will clean up the message and send a v2 shortly with your
reviewed by.

Thanks for the review!
Nathan
