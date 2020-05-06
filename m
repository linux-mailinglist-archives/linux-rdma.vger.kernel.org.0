Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AADD1C7B63
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2020 22:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbgEFUgS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 May 2020 16:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726093AbgEFUgS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 May 2020 16:36:18 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7721C061A0F
        for <linux-rdma@vger.kernel.org>; Wed,  6 May 2020 13:36:16 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c64so3605800qkf.12
        for <linux-rdma@vger.kernel.org>; Wed, 06 May 2020 13:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dQVf3eknE2BHn1HF7RMbSya9qicEGc03FeksdREc3Sg=;
        b=PC9o29D8x2ihTOV6i8H6wz1jeIe0ddwbXoJzwsbel/GCPzj3q9Y0QS2Cjwv41uMBPy
         SmkFB+YKoTPVc8TN92VF6U6TchAZai0wXC/sQa7oSlCokkHwd6rEXxvhs+M3qToO4a3L
         YrrrEjjUTLNv2k4fNrAXtG9NIAEDw/l5C8jaVaRlhgkiEUbf9vKM7KHtg7+dyWzumQ0e
         geDmr7YRs6FrOa28U/iI9O1DK6eXEHEzLogFthckAoQZPYZdV4qVCNYd8nOt/dY/Bd3O
         qPIUCZ/pM9ZEpZ28aPLCG2AQ/+VcqUE3L1pVT1xdpb73VVAG9EnQxNU5QDL7SNCDoUH5
         ToNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dQVf3eknE2BHn1HF7RMbSya9qicEGc03FeksdREc3Sg=;
        b=SLT2iabhBipDtfKcmTTnj/niSkANSn5U1KuFkCKYCxN6Cm/hUEpUKHy5M3FIfNmpdb
         EV/8KjqBoH4IyyG2bm7ZjqUeaAIWiih+b7hJAoImm6SL3iQa9bX0+GYRR/gU68Z+sxRc
         PgDcefRfv0oaqrftGSsO/emSTBBuPttd83iCEcR6zPSrridsiaHglki9QTN+1dbPJQ0C
         DNt4QC/DWqcaK2FOR20t4I95wiGMQFcY6eByadpZLDfTLyncdS9nNuhGKfHpsh25spVJ
         QfohGmtM0Z/RBRVgG5U8czXz6uAlnkE5IoKXPfW0c/fDOD9qzhO0j0/rYJAjFHALU/da
         V/iQ==
X-Gm-Message-State: AGi0PualPjLJBQbYL+pBlns/sVOvEKd70elp0JYjzq4AskvmZti+oBv7
        Q4Ub0/bVPxpIQgKL7qfmNZ3rBA==
X-Google-Smtp-Source: APiQypI+7qpAX5/IeWkQKLmtaP7EDObXah3Hi7rzXLUrIRyJhGplO+O4osGNXQWQnKPX09jWKdqwWg==
X-Received: by 2002:a05:620a:13f2:: with SMTP id h18mr10646492qkl.37.1588797376008;
        Wed, 06 May 2020 13:36:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 67sm2595797qkm.68.2020.05.06.13.36.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 May 2020 13:36:15 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jWQm7-0003xT-51; Wed, 06 May 2020 17:36:15 -0300
Date:   Wed, 6 May 2020 17:36:15 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 0/3] RDMA/hns: Misc cleanups
Message-ID: <20200506203615.GA15186@ziepe.ca>
References: <1588242691-12913-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588242691-12913-1-git-send-email-liweihang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 30, 2020 at 06:31:28PM +0800, Weihang Li wrote:
> Some tiny cleanups for hns driver.
> 
> Weihang Li (2):
>   RDMA/hns: Fix comments with non-English symbols
>   RDMA/hns: Adjust lp_pktn_ini dynamically
> 
> Wenpeng Liang (1):
>   RDMA/hns: Remove redundant assignment of caps
> 
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 8 ++------
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 7 +++----
>  2 files changed, 5 insertions(+), 10 deletions(-)

Applied to for-next, thanks

Jason
