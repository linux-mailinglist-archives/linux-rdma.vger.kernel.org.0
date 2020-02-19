Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDD2916503A
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 21:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgBSUuN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Feb 2020 15:50:13 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34350 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgBSUuN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Feb 2020 15:50:13 -0500
Received: by mail-ot1-f67.google.com with SMTP id j16so1548966otl.1;
        Wed, 19 Feb 2020 12:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NID/u0S4YSnbZSmhzBcTOVCgZLrtIaXULpx1S3tMLhg=;
        b=t/iI5eK3SoRwW28ZYoIuSkxdecJk337f+dZ+nWtWJUOO97LAjqI7We5LBWNtZAaXFj
         vLdRZ5lnIL97SNYbVZ/ABsje+U9iPcPjq6qTxGL/qbTDEG5RavsRWDopYkktmz3TD8fN
         MFeJiT60lE4f2bpRM9rNqtVDJ2kBHGA9s+dd40q3qsKvnmYgIKoFQ+pGmizK3ihc8utU
         6hVYYlmJ4ebY7+ltiGYuVdlSnjYmwqpp1P/PkhylVwJYM5gdMNp0VNo680Tm1pR1nMeS
         qC/FnbzIh4n+jNiTXlnkpjAyZ+LpvbBCH1TLJ80bSI+qYtM0jrnEfSSw6LaItQGFA/tm
         ie1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NID/u0S4YSnbZSmhzBcTOVCgZLrtIaXULpx1S3tMLhg=;
        b=QRM/iA0Y6GIS7sqrT4WcMZz3xdgSTUv7/uxvgr4Hw1o85Qa6ViNh6DuHZ/i4IyxS8U
         b68oQss5UC073tT5SEfYj7m2Ymyw1dUy8TWnnexkfve+eMAMpKFQCNi8AtCfygdb5qWE
         0N3jOO2aC5XMziAm8EcxrdRjvvB0LlDlMaIycLv9jy273SVptqAi4Y7CVv/eUPAkjcW4
         j0Mbquc2fI3OwX0yqzNzrOAPS+Lsy3ME9AgWjN0w4fSRQq27lea6zzA4k4PMUlNg7iww
         giyzxGZdxbGqmnhVIDfOEYstnGhwVnax1h1CyNGst1QWh2myp3j1ZVUfIGyASpyRyS2I
         Ux7A==
X-Gm-Message-State: APjAAAW4PgfUs8GoTa4s5Hw6Eslg1H20442Dsx77tr/Um2OI1O+lMgWe
        GENcgNlbUwH+leodgcD/WW3vop5i
X-Google-Smtp-Source: APXvYqxk08Kmq5SOz4sz8WC7zqLInpxFbiNuat1b8OPPCHT+wYu7xDK26I4cq3MhO4keGHdz2v5/pQ==
X-Received: by 2002:a9d:4d17:: with SMTP id n23mr21219507otf.85.1582145412623;
        Wed, 19 Feb 2020 12:50:12 -0800 (PST)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id b9sm289014otf.56.2020.02.19.12.50.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Feb 2020 12:50:11 -0800 (PST)
Date:   Wed, 19 Feb 2020 13:50:10 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] RDMA/core: Fix use of logical OR in get_new_pps
Message-ID: <20200219205010.GA44941@ubuntu-m2-xlarge-x86>
References: <20200217204318.13609-1-natechancellor@gmail.com>
 <20200219204625.GA12915@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219204625.GA12915@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 19, 2020 at 04:46:25PM -0400, Jason Gunthorpe wrote:
> On Mon, Feb 17, 2020 at 01:43:18PM -0700, Nathan Chancellor wrote:
> > Clang warns:
> > 
> > ../drivers/infiniband/core/security.c:351:41: warning: converting the
> > enum constant to a boolean [-Wint-in-bool-context]
> >         if (!(qp_attr_mask & (IB_QP_PKEY_INDEX || IB_QP_PORT)) && qp_pps) {
> >                                                ^
> > 1 warning generated.
> > 
> > A bitwise OR should have been used instead.
> > 
> > Fixes: 1dd017882e01 ("RDMA/core: Fix protection fault in get_pkey_idx_qp_list")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/889
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
> > ---
> >  drivers/infiniband/core/security.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Applied to for-next, thanks
> 
> Jason

Shouldn't this go into for-rc since the commit that introduced this was
merged in 5.6-rc2? I guess I should have added that after the PATCH in
the subject line, I always forget.

Cheers,
Nathan
