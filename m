Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6C4173B8C
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Feb 2020 16:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgB1Php (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Feb 2020 10:37:45 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:33900 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbgB1Php (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Feb 2020 10:37:45 -0500
Received: by mail-qv1-f66.google.com with SMTP id o18so1530277qvf.1
        for <linux-rdma@vger.kernel.org>; Fri, 28 Feb 2020 07:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XEDCJRzT4pLTaGuFbPvk//mN5ESO+ob79LoyfXuFFjw=;
        b=Vk4hK7AJBh+tdIdgsHvPh+wh2ov2tSz+fABssD1L5GC9PKKxyxVmWoqT+SuKz1oqAS
         qVvwxbKOV+XPFtppHOPCH8yWQgeQCwO6hp9nTVnIL+tiOd5tZw6OclLFLFzpjNQN6jHK
         h7BDJb3+lXMoIXusGxmXnWg8gxmTzGk3IOSOC/h7PVNJVnaBX8IzMMoBxVARMnYkSGES
         YDzICVDZd5ImxOJdWBHK2Nf43x2KO+FX2UoELr8HSvoWfjpg76oofB6EiwFhxHbGxmGG
         Z6+uDJ0xnHtAesd5gUSBUsHt5HMxLOC2DuPmvtobA2Sp5wH3WsGKDlBAIWimT5b7PLyF
         W9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XEDCJRzT4pLTaGuFbPvk//mN5ESO+ob79LoyfXuFFjw=;
        b=fSR5LkVsgc1BO1c/fm5XfcdF1OG90A5ylHP4pGE45vqui8RycYk0VFnE+QD0jTQBZZ
         7NF0x1ON6l9zx4G9DdMysdR1NFxciVBAJF3kO58VMAQ5Ar5yVbLil5s1hPtVe1su7mpT
         3jX+Sssj5MfjypnhGX8uijWirFo5QP7zZ4UyUqESVyrnNpN31YmPjAiB0Pmk2+0+3eMP
         1rdyzJlsji4TKnJ0IEs0knStaa0CSm8qmM6iBaEYgDWxWR8nGWF3xeezu3AEHB4TK649
         P3jZfokvWbc6AITyjMhiUOVVTKpimmcUCj3A0vRz64Fxuh89uf+un3i82RXHjlrLfyEB
         Rupw==
X-Gm-Message-State: APjAAAWv4Tk3Q8qRupzHdXlkfGDrvz4v6riBNtlMVv6TbbNa8mOu+Fkc
        5pT8BoTxwVHAPWxWNTWrwVMOLw==
X-Google-Smtp-Source: APXvYqw2hWYB6qjJbxSJo2dDydv+tWo3BIHejUrtHPD5/RCgkvRtKT4rYCqNLAnFWfjqqIL82ojCzg==
X-Received: by 2002:a0c:e58e:: with SMTP id t14mr4173908qvm.131.1582904263013;
        Fri, 28 Feb 2020 07:37:43 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id j30sm5160899qki.96.2020.02.28.07.37.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Feb 2020 07:37:42 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j7hhu-00028D-1I; Fri, 28 Feb 2020 11:37:42 -0400
Date:   Fri, 28 Feb 2020 11:37:42 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next] RDMA/hns: Treat revision HIP08_A as a special
 case
Message-ID: <20200228153742.GA8161@ziepe.ca>
References: <1582363039-10714-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582363039-10714-1-git-send-email-liweihang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Feb 22, 2020 at 05:17:19PM +0800, Weihang Li wrote:
> From: Lang Cheng <chenglang@huawei.com>
> 
> Set revisions that equal to or higher than HIP08_B as default to maintain
> backward compatibility.
> 
> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)

Applied to for-next, thanks

Jason
