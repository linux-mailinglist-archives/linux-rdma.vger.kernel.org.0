Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E21E71638AE
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 01:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgBSAqz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Feb 2020 19:46:55 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43000 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgBSAqy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Feb 2020 19:46:54 -0500
Received: by mail-qk1-f195.google.com with SMTP id o28so20159810qkj.9
        for <linux-rdma@vger.kernel.org>; Tue, 18 Feb 2020 16:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZMEBp/FIyYzIdUidzd5M1TxlXnzr0Cw2+HcHGkfXJeY=;
        b=Fj9jmSDFqAGuMU1auAWb+Mue9xrvULtfZVipn1hNkagzwDHGalExJOFYwUbdRIrRkw
         qLrulVAlTkBo3yj5SgwnI2Gl29WkyM/FNNqyREI4vtKcLBZsLXSxKUBpSzxlR7mvHFsw
         pYWg2Xggp63D2t7pKCk4k38Hd02UvYSqX3SjwgV062VFSoKSkiBxsfjUSCU2ED4JfPGk
         65QymCs1QgDZn0Qk8wDLonS0hdCRYznDLWwVs+PkMXWsRFJRy0no1OL1g+sZgVwv+bZk
         j7DNSyMcWH/UlvPJn/mzGxkr7tGnqJOL9CeyUlf3zIB1y1SXxHm4QfFeeXVvZnDaTQR6
         MPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZMEBp/FIyYzIdUidzd5M1TxlXnzr0Cw2+HcHGkfXJeY=;
        b=j2jf90Cq512zRvxARHx8Ca5KUDgt93uol+23zuli2Dl8jjTl2QcOI6vd+fnHqAnNYL
         ueIL9o9g6LdBdL3EZErmV+j2qgWCmvZVQ22x8Uc/GxAvdBKW5F3wpGcSxyVW0VjS4eFS
         GmfEx+arnpYv9e3BpB3k2ZzwPrT9S77/l2gowKM/BhqtHOclP8mi717NvlK3cNEDGyrJ
         Bar7K7aMnWo8yYOaO9CA315VVh8RetbUH2WtoV42moC6VkhdBx/vvyY2NVj4PXDXcggX
         GDxBD2cY8VRKus65tgKlE/7IoyoAWVLyvrhIc9ff6xGr9Z1u0faBS4hkHb3FrgdRSuH6
         FPqw==
X-Gm-Message-State: APjAAAVL4wz5XmYu7DdX7Pge/ZlPQV2xR+q16zCnjvjSo/XfIFHyJlq5
        M2AcLBV8Ho/1MsLICY8Gz6nrYw==
X-Google-Smtp-Source: APXvYqxrj+dqY7EQNYu+mZe6u6s6dhFYTFHPrpyHsKVt9ulvTfQTvpARYEEPvZ4hROg+K+hcy5Tb9A==
X-Received: by 2002:a37:84e:: with SMTP id 75mr21572630qki.192.1582073213679;
        Tue, 18 Feb 2020 16:46:53 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id p135sm196620qke.2.2020.02.18.16.46.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Feb 2020 16:46:53 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j4DVs-0006SO-On; Tue, 18 Feb 2020 20:46:52 -0400
Date:   Tue, 18 Feb 2020 20:46:52 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next] RDMA/hns: Initialize all fields of doorbells to
 zero
Message-ID: <20200219004652.GA24788@ziepe.ca>
References: <1581759368-16700-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581759368-16700-1-git-send-email-liweihang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Feb 15, 2020 at 05:36:08PM +0800, Weihang Li wrote:
> From: Lang Cheng <chenglang@huawei.com>
> 
> Prevent uninitialized fields when new fields are added, and make code
> look simpler.
> 
> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 9 ++-------
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 5 +----
>  2 files changed, 3 insertions(+), 11 deletions(-)

This doesn't apply, please resend

Jason
