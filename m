Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4698191D20
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2020 23:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgCXWyb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Mar 2020 18:54:31 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34087 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbgCXWya (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Mar 2020 18:54:30 -0400
Received: by mail-qk1-f196.google.com with SMTP id i6so494234qke.1
        for <linux-rdma@vger.kernel.org>; Tue, 24 Mar 2020 15:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wrqH9GI8RFoG6Qilc6n6UaNfEynr1WYpcqlgEEEVGVo=;
        b=dtDjx3KtxVEnsEpaXZKHUZqLLTeBq81ynI35C3dFRfoFQ2l8nVJT/3p5TLd1hA5pcy
         l3eMfhYT0o3Wgv0DZkIU1Y0Zw3IZhaXSxZDU3xc93eqVy8LFijW/EbmUVyPdeXSHvppJ
         KqsbA+SxW3KJxbkqCfTzKcqvGUsME4GSfw64e2CCgjdSTFNVzHBcRpc1ZE7OgeLESVm+
         yOi39dNyoA5IQ0RUg7q9nlgaY8XOQXpes4qaQ/b81FSMdY+tZHEySY0/PK1H2c41n9x0
         oyWej5RNzDPH6Fh1XlvyuuTdVXI8gfpSIBjgzFD27LJo+B0tZLcmbPanob/nk+g/N+pV
         wDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wrqH9GI8RFoG6Qilc6n6UaNfEynr1WYpcqlgEEEVGVo=;
        b=Bsgl2N1B71XsFHj/fvnkmposu+tFw2s76ZnWjuUYCRhqfCRvG4k70ZoOvnYlgjDMIr
         976kjGAM16u4Jfllr8sgIeNhQOKM6bIQ/ot789ydssSwdSk52dGr955aT3QaMHeYycUF
         VyiOvNlWeoySM64c7hhdj8AkoMgOVg8piVYnYpezMLBojsZhILYeXxcablmI6YqT9uaf
         yQ/CPGkxMkoXYdWzomlLyokwrBT8YgbrolPhK2MjghxTt48fYw5BJ3yFhTnrVsm7IjRc
         8kgGAqCSwcBFD+9LLNVekJHxtNEiQcoK/WQEIPGN14xgUeEA0Ju9v6v0OarvnPC0HgY/
         U4Kw==
X-Gm-Message-State: ANhLgQ18rd7rrIes3KqqFrAWEBt7yJOo6AND9dH8ubz/xx1brVGok32Z
        jlTJVI0Rnj3mXJobG1g3DfUZh6KD/s/Y/g==
X-Google-Smtp-Source: ADFU+vtT/Ew/7eR5aUQcMgQBTPrgdxxOBcWh+nPfydxs3kyduVgJawPThtJARFUz/88yyGBWuJaABg==
X-Received: by 2002:a05:620a:1025:: with SMTP id a5mr200569qkk.365.1585090469612;
        Tue, 24 Mar 2020 15:54:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id o67sm13696589qka.114.2020.03.24.15.54.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Mar 2020 15:54:29 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jGsRI-0007b8-Ou; Tue, 24 Mar 2020 19:54:28 -0300
Date:   Tue, 24 Mar 2020 19:54:28 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/core: Insure security pkey modify is not lost
Message-ID: <20200324225428.GA29173@ziepe.ca>
References: <20200313124704.14982.55907.stgit@awfm-01.aw.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313124704.14982.55907.stgit@awfm-01.aw.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 13, 2020 at 08:47:05AM -0400, Mike Marciniszyn wrote:
> The following modify sequence (loosely based on ipoib) will
> lose a pkey modifcation:
> 
> - Modify (pkey index, port)
> - Modify (new pkey index, NO port)
> 
> After the first modify, the qp_pps list will have saved the pkey and the
> unit on the main list.
> 
> During the second modify, get_new_pps() will fetch the port from qp_pps
> and read the new pkey index from qp_attr->pkey_index.  The state will
> still be zero, or IB_PORT_PKEY_NOT_VALID. Because of the invalid state,
> the new values will never replace the one in the qp pps list, losing
> the new pkey.
> 
> This happens because the following if statements will never correct the
> state because the first term will be false. If the code had been executed,
> it would incorrectly overwrite valid values.
> 
> if ((qp_attr_mask & IB_QP_PKEY_INDEX) && (qp_attr_mask & IB_QP_PORT))
> 	new_pps->main.state = IB_PORT_PKEY_VALID;
> 
> 
> if (!(qp_attr_mask & (IB_QP_PKEY_INDEX | IB_QP_PORT)) && qp_pps) {
> 	new_pps->main.port_num = qp_pps->main.port_num;
> 	new_pps->main.pkey_index = qp_pps->main.pkey_index;
> 	if (qp_pps->main.state != IB_PORT_PKEY_NOT_VALID)
> 		new_pps->main.state = IB_PORT_PKEY_VALID;
> }
> 
> Fix by joining the two if statements with an or test to see if qp_pps
> is non-NULL and in the correct state.
> 
> Fixes: 1dd017882e01 ("RDMA/core: Fix protection fault in get_pkey_idx_qp_list")
> Reviewed-by: Kaike Wan <kaike.wan@intel.com>
> Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
> ---
>  drivers/infiniband/core/security.c |   11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)

Applied to for-rc, thanks

Jason
