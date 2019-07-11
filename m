Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B45D652F2
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2019 10:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbfGKIOk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Jul 2019 04:14:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38410 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728237AbfGKIOj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 Jul 2019 04:14:39 -0400
Received: by mail-wr1-f66.google.com with SMTP id g17so5216391wrr.5;
        Thu, 11 Jul 2019 01:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EBNvFukZ7/NgqmL3xXApO1AFyylxTtfZ1K1rGvSfK44=;
        b=prH0vyvv4OLNS3zAqZHn3+FYdgW9OjZ+S4TdQTdJkDjAnzMgDy1hx0JGJPrLdhQ9CI
         V2r9Y2mfQbNoxYPE66LHkFXmvI0Z3++qwhCYtAxfT001nWzpaVKBw28fZlnXoJkUBdv/
         wWVZvg18ANbFwmrMqej6a24AtPfFnboO4CJlpIrc3FKJgL0EGc7zYJE4LsnHtww82HMt
         whRYv2gXXhU293VdSfYcL6PIDjjkuYC5JX9oCYkM+x/pwHGJnuweRl0//W4ZBS+Kz8ZK
         aLtOaA7J62q2ctU79b7mC+pa6mkfSF49Wxd3wfFxaIbHg9LXXRe0bD8rNsG/hDADlCPH
         GMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EBNvFukZ7/NgqmL3xXApO1AFyylxTtfZ1K1rGvSfK44=;
        b=O/wLGAOgyBQ+i/qRZwpyige7++dgzq2w6LcGI3+z0xw0hzKwc/Y3n8uj4eX0fYHvGC
         li3aPB0W9sjVUn7A6xdsy9uctCFy2xdaIwtCcSR+gBaXj2b6Kl/H2KTjlTjEXUHEYc5n
         XJp7DiSC3Pgi/GyvUBU4avtieHz2y6S0vayUT/Ybpx0eVN6IFh/hBy6PbSL8fq9278th
         0mHKOwT/mNlK1SrW13ayGd2Nku44lerv1n+VufeOwenw82mN1BRAwLThAyues7xRbjdX
         L81GAMlyYjuh3LupDQjAlXr0pKZ9kSZXdPsGUOZz0MzdTxY79GsDqeu8Rnj2GvH+x0pE
         GwiQ==
X-Gm-Message-State: APjAAAVSU6e5KYTtYVqYN8NRuDxrB6UFeZKd7qaJ1BRrnkZzqQTQpu7h
        h3ZTaDs0oBzci7wviGmwumM=
X-Google-Smtp-Source: APXvYqzx6C/agFrZs2zKfV/BzdVwHzifwsFzqKKkGP1IEhFxy4LuEztUi6hwMa9M2mK74Kh/v25u+g==
X-Received: by 2002:adf:ebcd:: with SMTP id v13mr3314591wrn.263.1562832877025;
        Thu, 11 Jul 2019 01:14:37 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id x16sm3143957wmj.4.2019.07.11.01.14.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 01:14:35 -0700 (PDT)
Date:   Thu, 11 Jul 2019 01:14:34 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] rdma/siw: Use proper enumerated type in map_cqe_status
Message-ID: <20190711081434.GA86557@archlinux-threadripper>
References: <20190710174800.34451-1-natechancellor@gmail.com>
 <OFE93E0F86.E35CE856-ON00258434.002A83CE-00258434.002A83DF@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFE93E0F86.E35CE856-ON00258434.002A83CE-00258434.002A83DF@notes.na.collabserv.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Bernard,

On Thu, Jul 11, 2019 at 07:44:22AM +0000, Bernard Metzler wrote:
> Nathan, thanks very much. That's correct.

Thanks for the confirmation that the fix was correct.

> I don't know how this could pass w/o warning.

Unfortunately, it appears that GCC only warns when two different
enumerated types are directly compared, not when they are implicitly
converted between.

https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wenum-compare

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=78736

If it did, I wouldn't have fixed as many warnings as I have.

https://github.com/ClangBuiltLinux/linux/issues?q=is%3Aissue+is%3Aclosed+label%3A-Wenum-conversion

Maybe time to start plumbing Clang into your test flow until it can get
intergrated with more CI setups? :) It can catch some pretty dodgy
behavior that GCC doesn't:

https://github.com/ClangBuiltLinux/linux/issues/390

https://github.com/ClangBuiltLinux/linux/issues/544

Kernel CI has added support for it (although they don't email the
authors of patches individually) and 0day is currently working on it.
Feel free to reach out if you decide to explore it, I'm always happy
to help.

Cheers,
Nathan
