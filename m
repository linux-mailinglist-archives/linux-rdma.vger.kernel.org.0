Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF04E0A24
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2019 19:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732008AbfJVRK0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Oct 2019 13:10:26 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44527 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731061AbfJVRK0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Oct 2019 13:10:26 -0400
Received: by mail-qk1-f194.google.com with SMTP id u22so16922937qkk.11
        for <linux-rdma@vger.kernel.org>; Tue, 22 Oct 2019 10:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wfDHtgBLLd3aSUACOIL9atUVjOUL0pjcq5sjMjLi6+E=;
        b=obkVHmbPkNK2Cqh2B5lPCicdWo8rxN7nGLjC0zc4gqpPRdrli4qE5ykinZFWVUdAnp
         l9dUx0KIXihY6bAERcDYD7R0nbUToVOMtqja67U9d4hqeY/fawaMyjMxUbXUR3crTDsR
         SxRy7+a9BVSgh46Wcjxs6FIhpEhMknahxAoCkN1l9Ro0Ifz21n9e+kDca1r0Iit/XTwy
         BG6F/0J9kGMN4s5j0G6nEWwAXDBKT27aVAEKrPyCTM4ty1XVdxsV+Y2xKdx591C6HE9m
         NcFBB+tHXSXnLoHO0WBHBTBeGmgYly6k+Dquu1He6jb3QLpPsyFKcGQVxlwH4dQBnmEz
         L9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wfDHtgBLLd3aSUACOIL9atUVjOUL0pjcq5sjMjLi6+E=;
        b=qGwweZSZEyv5pbCcBsj9JvgBdcA/xsTsC86jLtzZZnsvFWvGI2PktrBxxCunXy9fGF
         bcWGCcQPtQn5MlzsQyMvaZT6eQJ+Zbn9mxTjrRhNI/s6BzBIJvO4UJfNbmOLlp/DBcWx
         c0D8PanKQxTVD36+iLfd3wG2jGr+QnW9nAe/kJcVjcRi7qnPGSbN/BzZPLztgVLoEMPa
         MAt3sJ8NwLDqUG4GH9VEr0LHkvNFg3QwzuT7oUBiqDh74LIzBiIHXp54bTDis5qkf6xY
         2TOZwYhGA6hVynoBcF+VpsWu4YFa86SpFEWjUcLS2TdFu1uIc6JiVANx0UrjXVgvqrRB
         oBeA==
X-Gm-Message-State: APjAAAUCiqhKVcy/9dRq4bPVs9efnderjhpApfFqE6abWp6Bx4WSV/sA
        yT91lf/NbEUJZcZOBXmR9EgojFObyUQ=
X-Google-Smtp-Source: APXvYqyOeSib/+YNTt86pXnO0VsbICkZNVPAa6GxZtlO1WBFqQRCY0QZIdHVDzBiKcKY+qdldEHhVA==
X-Received: by 2002:a37:a8d3:: with SMTP id r202mr3860614qke.405.1571764224053;
        Tue, 22 Oct 2019 10:10:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id h20sm1362030qtr.29.2019.10.22.10.10.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Oct 2019 10:10:23 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iMxfq-0006J4-UH; Tue, 22 Oct 2019 14:10:22 -0300
Date:   Tue, 22 Oct 2019 14:10:22 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, bharat@chelsio.com,
        nirranjan@chelsio.com, krishna2@chelsio.com, bvanassche@acm.org,
        leon@kernel.org
Subject: Re: [[PATCH v3 for-next]] RDMA/siw: Fix SQ/RQ drain logic
Message-ID: <20191022171022.GA24186@ziepe.ca>
References: <20191004125356.20673-1-bmt@zurich.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004125356.20673-1-bmt@zurich.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 04, 2019 at 02:53:56PM +0200, Bernard Metzler wrote:
> Storage ULPs (e.g. iSER & NVMeOF) use ib_drain_qp() to
> drain QP/CQ. Current SIW's own drain routines do not properly
> wait until all SQ/RQ elements are completed and reaped
> from the CQ. This may cause touch after free issues.
> New logic relies on generic __ib_drain_sq()/__ib_drain_rq()
> posting a final work request, which SIW immediately flushes
> to CQ.
> 
> Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
> Signed-off-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
> v2 -> v3:
> - Handle ib_drain_sq()/ib_drain_rq() calls when QP's
>   state is currently locked.
> 
> v1 -> v2:
> - Accept SQ and RQ work requests, if QP is in ERROR
>   state. In that case, immediately flush WR's to CQ.
>   This already provides needed functionality to
>   support ib_drain_sq()/ib_drain_rq() without extra
>   state checking in the fast path.
> 
>  drivers/infiniband/sw/siw/siw_main.c  |  20 ----
>  drivers/infiniband/sw/siw/siw_verbs.c | 144 ++++++++++++++++++++++----
>  2 files changed, 122 insertions(+), 42 deletions(-)

Applied to for-next, thanks

Jason
