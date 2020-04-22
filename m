Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11041B4DFF
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2020 22:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgDVUJJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Apr 2020 16:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726002AbgDVUJJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 22 Apr 2020 16:09:09 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F75C03C1A9
        for <linux-rdma@vger.kernel.org>; Wed, 22 Apr 2020 13:09:09 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id v10so1623626qvr.2
        for <linux-rdma@vger.kernel.org>; Wed, 22 Apr 2020 13:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ct1ucQrnYE7E8GTLuvS+SblQW7GgmuL1r0dmFXZsgdE=;
        b=J0kutzviRC1kcmi54Yi1dWA0Lj1H+WDs4l3krDTLW5vI5F70zX9kjI66zz1W88jgi4
         hEtR2J9EQkXUNOhyi+x5Xzua0CyLXRmLryaA8m/ky7dgHh79373hCXMf2zzFprufYHUe
         h5FtLZfJwzUKGfWsNr2QuzDIA6qHsDdcfDOWhuYaWfr9MjTKsfqmp5mdqXLloNBu2ezP
         vOYDzGBOHT9cetafBvc3fdxfpUTQ73SUWQdpQfw4aR0HucwipH/RXrX/dMG4Rn1bgF/L
         FdW0FrOCmlSQX5tNaLti7Bc/KlOYA9CaIZnUPXcHiZExhorl5M9gV0E781IXOPLWsmZ3
         iqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ct1ucQrnYE7E8GTLuvS+SblQW7GgmuL1r0dmFXZsgdE=;
        b=K7N53QBm6rdPzQKn7HHsgP73Qgut8ghTOm21Vi38qEu4CP1q/5rYlskgjvr4bO5aor
         XH6sBa64tdHbx6r/47KtI1sz84O35oyyPFubYVZ8DHimZNbXiGmb6d9/pZ+OmaJUda5e
         XSBilCXk/cbWozdQ+1ALsp7MG2kPgzAnfnk49YISnIaShpMo7WElmIetpoVR9FDIpuiq
         bkYsh7lMMT7TFqewJDcTn9avwTY/5uVWmvBJZUASfzRxLF9XhHrFEF4VosbEMDALfkXL
         VlTg1X0Ld2ZRzwPlRQ4Ic15AWn8G/IPyZvbZ1u+rnAW9YBDs+g59ggxvHCbSTNWj1MDL
         /iiA==
X-Gm-Message-State: AGi0PubK6lXhu2kHy6ErbMck/ND3zurRn42CXJBaqZjbOMpKSzQ057Rf
        ky5LDqWezCyhn3ZZYmXb5ngcMg==
X-Google-Smtp-Source: APiQypIivOI7hVEFH1uajcwUksbnp5bTOIzW+63eu/5m9MPs3WZLEMoGg5uSMzPul3YjwFYeo2zVdA==
X-Received: by 2002:a0c:a68a:: with SMTP id t10mr684907qva.133.1587586148297;
        Wed, 22 Apr 2020 13:09:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id o33sm204428qtj.62.2020.04.22.13.09.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Apr 2020 13:09:07 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jRLgB-0005Ef-BZ; Wed, 22 Apr 2020 17:09:07 -0300
Date:   Wed, 22 Apr 2020 17:09:07 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: Re: [PATCH rdma-next] RDMA/bnxt: Delete 'nq_ptr' variable which is
 not used
Message-ID: <20200422200907.GA20095@ziepe.ca>
References: <20200419132046.123887-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419132046.123887-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Apr 19, 2020 at 04:20:46PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> The variable "nq_ptr" is set but never used, this generates the
> following warning while compiling kernel with W=1 option.
> 
> drivers/infiniband/hw/bnxt_re/qplib_fp.c: In function 'bnxt_qplib_service_nq':
> drivers/infiniband/hw/bnxt_re/qplib_fp.c:303:25: warning:
>    variable 'nq_ptr' set but not used [-Wunused-but-set-variable]
> 303 |  struct nq_base *nqe, **nq_ptr;
>     |
> 
> Fixes: fddcbbb02af4 ("RDMA/bnxt_re: Simplify obtaining queue entry from hw ring")
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/bnxt_re/qplib_fp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied to for-next, thanks

Jason
