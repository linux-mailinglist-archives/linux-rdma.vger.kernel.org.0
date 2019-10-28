Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C560E77B7
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 18:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbfJ1RhX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 13:37:23 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44920 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfJ1RhX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Oct 2019 13:37:23 -0400
Received: by mail-qt1-f196.google.com with SMTP id z22so15722209qtq.11
        for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2019 10:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wja3Vs6QWDiXAd2S4I55Em/oYiSuB1cFrS7CT+YhOIA=;
        b=HBQClvQ3n5PDzpB+ycTqAd13zV7JccWCjgdoBsEz8jcAy7z1UuaKb7fwBZJFDP50jy
         vEzqHxGED0EbfCx4kEY4mH6Kr9dQiKTE7lc57+csFI+zHpc9Nt7kmSHLcHWBivHr0mxY
         D0VAwv5/RBU91gzVSShTZuzrF8JvMc6EOzAOEyb2fdXNC4TVxZZs0B4nrBbchSbP6l/+
         SjOkpVNt0JqDZJjOqZBmyjsLqrdIbHapW1jH/qAX3E3fxIF9dfSegYtHd77KjjmO/VAb
         hkO5bGPo41lqBfpX2tU/lyAglA7eh9Hk/7pqH7iRpE01ooa55RD3zIQ3PGvfh8n2wiui
         Bd4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wja3Vs6QWDiXAd2S4I55Em/oYiSuB1cFrS7CT+YhOIA=;
        b=XxEL6BDt71M4DyeeKgKLX3Ul+c2cZMpvk9eumxc7gub9x7SNtHz2GKxUvdGhxJp67c
         kQ26vZoxm8bElSjk3bKN3syC15jbyDcTpdqL84Q6e/suL4dU0KQo9eqt8qq+cRe8cJI8
         7uxLiUnVGcJcLQnPkiQU50d97rhxZ7sdAh/mNscOE9rcELWRWJvyxFr7a84cm3mQ+KXe
         dRg4bc5xunqaMZPWhf3KlHIM+2cBf2DwKh4Cchq5WqHkurI0PsoJWVzy94s/f0E0Cs80
         vPehRH42annFLJoSVfVWlnK8Quwn8xAC8OsVdXOhWRJ4ikVeP4J9YSIUlmsYfPvPMwTi
         i8hQ==
X-Gm-Message-State: APjAAAUCciVlocHCBSJqjBwaERrXaPKKlvWXgXKIjnYnak9ReM0rfG9g
        mCEsnJwa/Wq4p3SAIerXll/8RRjXNg4=
X-Google-Smtp-Source: APXvYqzFiUJbMONixUI6x+WG/t22QkSZHeRnEtDmPUvKAqeLIEFMJA96cqEHUl6wqzf+aeS3fOWOpw==
X-Received: by 2002:a0c:e5c1:: with SMTP id u1mr18260893qvm.206.1572284242752;
        Mon, 28 Oct 2019 10:37:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id o5sm5267607qtq.10.2019.10.28.10.37.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Oct 2019 10:37:22 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iP8xF-0005g6-Pj; Mon, 28 Oct 2019 14:37:21 -0300
Date:   Mon, 28 Oct 2019 14:37:21 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, dan.carpenter@oracle.com
Subject: Re: [PATCH for-next] RDMA/siw: Fix post_recv QP state locking
Message-ID: <20191028173721.GA21758@ziepe.ca>
References: <20191025142903.20625-1-bmt@zurich.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025142903.20625-1-bmt@zurich.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 25, 2019 at 04:29:03PM +0200, Bernard Metzler wrote:
> Do not release qp state lock if not previously acquired.
> 
> Fixes: cf049bb31f71 ("RDMA/siw: Fix SQ/RQ drain logic")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/sw/siw/siw_verbs.c | 1 -
>  1 file changed, 1 deletion(-)

Applied to for-next, thanks

Jason
