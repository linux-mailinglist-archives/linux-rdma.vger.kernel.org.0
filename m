Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAD89194800
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2020 20:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbgCZTz6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Mar 2020 15:55:58 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39747 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727446AbgCZTz6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Mar 2020 15:55:58 -0400
Received: by mail-qt1-f193.google.com with SMTP id f20so6607847qtq.6
        for <linux-rdma@vger.kernel.org>; Thu, 26 Mar 2020 12:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ywxRlnc74WP7S7kGXrbxaXKBruIB3phWQQN30Lmhsqs=;
        b=L3wWizNEjOS6uevlr5Q5bcylkJZe1dOYXYEweuaNjm28SCmQyGt1vvImxdEwqr5FT+
         e056bqxnWEGlbIa5J6XcmCbVtucwQ6WVDP1VBSre1MDHxqujkLou/Ptk5q+Ty2PGjd8Z
         nr4udYz9Pu/XJH+kDWMgJSSXhkr4GHYegTOzB2xq04rd3SLn2TbjN9WIceWImK0BeYjw
         fykScEcaKFGdOjVgwXDXBfltFZGjEaXg1TeIN+V2W4p+3QQDyhq7nUj1kzL/tol4ZSXk
         kRpid5aaVxuSu/iPBWKhnSR+bROkvbg+R9WhwhsSglKW3s6S6jfkNT2CXTB+tZKb5Wis
         zg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ywxRlnc74WP7S7kGXrbxaXKBruIB3phWQQN30Lmhsqs=;
        b=GLsMSWHJ1KP6ubIPXt0mubzymf5x+iixOZzo+HHUEc1LyQ5Zt2TOPnt762aJLd1tB/
         W2J3DsTp+s6FclSUC+pAsMuWvFl2035vrganmdL9mNnPsZej/0XCAVlmLtd8D6quLxA6
         hJg/stUA5oSUlJ4U7xPlOrl7ji+Y0wJWmCKLWQ5itS4AIu6SXRK5qrY2gNpuT1g4W09W
         ww3keMl28GjokO6GJdPKEJEuIsXZAp9RBjBMXhKlr+G6rENGV0rrP3YmWxvooZm2p25X
         R9tZ5WPGRliJpE4DPHkQv59Y6VKzvg0Q2wERvih6ppHf3tZFXamlvp5iyQLy46zOc1VO
         nTPw==
X-Gm-Message-State: ANhLgQ13szG5kOmMChCrXiWx3+7wCO1kJLIUw/lzm0tlikiFDtcKCaJt
        uTykC9rg0d73D6lR91ut57VdqA==
X-Google-Smtp-Source: ADFU+vtABENnmdw2LSsUHTp5Tm2X3VIyXkIzizzjoniUKhfflgHsVgcMefZ5xP6X4EcfXF/lgUc0hw==
X-Received: by 2002:aed:3225:: with SMTP id y34mr10356191qtd.19.1585252556621;
        Thu, 26 Mar 2020 12:55:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id x188sm2069480qka.53.2020.03.26.12.55.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Mar 2020 12:55:55 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jHYbb-0001gR-H4; Thu, 26 Mar 2020 16:55:55 -0300
Date:   Thu, 26 Mar 2020 16:55:55 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v2 for-next 00/10] RDMA/hns: Various cleanups
Message-ID: <20200326195555.GA6448@ziepe.ca>
References: <1584674622-52773-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584674622-52773-1-git-send-email-liweihang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 20, 2020 at 11:23:32AM +0800, Weihang Li wrote:
> This series contains some cleanups for the hns driver:
> - patch 1 unifies format of prints in hns_roce_hw_v2.c and hns_roce_pd.c.
> - patch 2 ~ 5 are some simple modifications.
> - patch 6 ~ 10 remove some dead codes.
> 
> Previous discussions can be found at:
> https://patchwork.kernel.org/cover/11447213/
> 
> Changes since v1:
> - Drop patch 3/11 from series v1 because it's wrong to use IS_ERR_OR_NULL
>   on a pointer returned by kmalloc().
> 
> Lang Cheng (4):
>   RDMA/hns: Simplify attribute judgment code
>   RDMA/hns: Adjust the qp status value sequence of the hardware
>   RDMA/hns: Remove definition of cq doorbell structure
>   RDMA/hns: Remove redundant qpc setup operations
> 
> Lijun Ou (2):
>   RDMA/hns: Unify format of prints
>   RDMA/hns: Optimize hns_roce_alloc_vf_resource()
> 
> Weihang Li (3):
>   RDMA/hns: Fix a wrong judgment of return value
>   RDMA/hns: Remove redundant assignment of wc->smac when polling cq
>   RDMA/hns: Remove redundant judgment of qp_type
> 
> Wenpeng Liang (1):
>   RDMA/hns: Remove meaningless prints

Applied to for-next, thanks

Jason
