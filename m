Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91D17E4B2F
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Oct 2019 14:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438895AbfJYMe5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Oct 2019 08:34:57 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41350 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfJYMe4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Oct 2019 08:34:56 -0400
Received: by mail-qt1-f193.google.com with SMTP id o3so2927136qtj.8
        for <linux-rdma@vger.kernel.org>; Fri, 25 Oct 2019 05:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WWwBtHjsd9lFK9D6vD0wMnwL9mUJq3RPftczSuLJ2I0=;
        b=TWGvI2GMAVijXXj+eBPSywdCDzB18HkFJ8gnyt/1mwNx3Q60U+F/F+8K1OleLkIw49
         8s2m3eVQTVxrjj5kyWN4jEkZbobuucHcrobvXn8IgHlAjgkwvtYciNmk1bJDz+tX14ED
         iDK/KRpqCyuNDXGJkueJO5HnIOFCqr/n6awBNc5ygGrRWWdkQm23CA9+PAmZksojRPVf
         eeLZWOWjXStfeC+wiozR/UjPY33sqgy6t2rJ7aI3byqUtUnd5BYGuIP3emWrozN2rFjP
         XpJEPYGSwY9Q5peQwK8DVY0JSao8fgsfnTcWkT5Dh/9YDwl6bhGFdDILJxWHKIEj3Dfz
         PzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WWwBtHjsd9lFK9D6vD0wMnwL9mUJq3RPftczSuLJ2I0=;
        b=G4Z2wQhG01Ad8k0FIDtXa3U2rJ657pjNPkCXvCdlCQqFBbpyz/LgAh0w+cA1Rj4Zmz
         ESMB3jv1ASDTc4bCfjRpxF2KDeHr/fE6F4RA7lecdS36ntS5knQJnOUtKKIfUo2G/bKV
         /G/gLZzgIy9aksUJWZLsCaBBMK60QiQQAliZ8Q6Y3mu5Wcv4UMzexGAn6PmKt7SR/awm
         KNCI0+qCRkFkHNJhRYIPEZt0ImZdStOkICfFTBC/tcH+LycFrfugWV/rxGnPLfZcvZvN
         sOa5R8x6yBXT0s6tGARsmF0mwIENSQKwrWl7OWvYrlm+VOvZ0GRXoPhGMkOFAX/BMngc
         HZwA==
X-Gm-Message-State: APjAAAUqEt1pfCSleoUWjFSfEt3vf1eneoQY0V4x97+CYU2EB8WmmqMs
        owfy3rIIwdXKK4bYYUnxeThsYQ==
X-Google-Smtp-Source: APXvYqzvP5ARM6Tnd+DqSoCLMChDyjg2X8wNHEXs6O1yU+w+Pi0Gkayt+PZFGJ2EJLDrnYB5yWxORQ==
X-Received: by 2002:ac8:1c03:: with SMTP id a3mr2700562qtk.31.1572006895166;
        Fri, 25 Oct 2019 05:34:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id z17sm1480301qtj.95.2019.10.25.05.34.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Oct 2019 05:34:54 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iNynu-0004zW-3m; Fri, 25 Oct 2019 09:34:54 -0300
Date:   Fri, 25 Oct 2019 09:34:54 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [bug report] RDMA/siw: Fix SQ/RQ drain logic
Message-ID: <20191025123454.GH23952@ziepe.ca>
References: <20191024203841.GA7912@mwanda>
 <OF9EE3BDCA.84D0CB33-ON0025849E.002C56C0-0025849E.002D6F03@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF9EE3BDCA.84D0CB33-ON0025849E.002C56C0-0025849E.002D6F03@notes.na.collabserv.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 25, 2019 at 08:16:15AM +0000, Bernard Metzler wrote:
> 
> >To: bmt@zurich.ibm.com
> >From: "Dan Carpenter" <dan.carpenter@oracle.com>
> >Date: 10/24/2019 10:39PM
> >Cc: linux-rdma@vger.kernel.org
> >Subject: [EXTERNAL] [bug report] RDMA/siw: Fix SQ/RQ drain logic
> >
> >Hello Bernard Metzler,
> >
> >The patch cf049bb31f71: "RDMA/siw: Fix SQ/RQ drain logic" from Oct 4,
> >2019, leads to the following static checker warning:
> >
> >	drivers/infiniband/sw/siw/siw_verbs.c:1079 siw_post_receive()
> >	error: locking inconsistency.  We assume 'read_sem:&qp->state_lock'
> >is both locked and unlocked at the start.
> >
> >drivers/infiniband/sw/siw/siw_verbs.c
> >   978  int siw_post_receive(struct ib_qp *base_qp, const struct
> >ib_recv_wr *wr,
> >   979                       const struct ib_recv_wr **bad_wr)
> >   980  {
> >   981          struct siw_qp *qp = to_siw_qp(base_qp);
> >   982          unsigned long flags;
> >   983          int rv = 0;
> >   984  
> >   985          if (qp->srq) {
> >   986                  *bad_wr = wr;
> >   987                  return -EOPNOTSUPP; /* what else from
> >errno.h? */
> >   988          }
> >   989          if (!qp->kernel_verbs) {
> >   990                  siw_dbg_qp(qp, "no kernel post_recv for user
> >mapped sq\n");
> >   991                  up_read(&qp->state_lock);
> >                        ^^^^^^^^^^^^^^^^^^^^^^^^
> >The patch changes the locking so this isn't held here and should be
> >released.  Should it be held, though?
> 
> Yes, this is a BUG. Thanks very much! There is no qp spinlock to 
> be held here. I moved that down to state checking. No need to
> hold the qp lock before. 
> 
> Shall I re-send, or can we just amend the patch,
> removing that single 'up_read()' line?

You need to send a new patch against for-next to fix this

Jason
