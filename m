Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8E4B2BB6C
	for <lists+linux-rdma@lfdr.de>; Mon, 27 May 2019 22:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfE0U3r (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 May 2019 16:29:47 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:45669 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfE0U3r (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 May 2019 16:29:47 -0400
Received: by mail-vk1-f196.google.com with SMTP id r23so4118301vkd.12
        for <linux-rdma@vger.kernel.org>; Mon, 27 May 2019 13:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KkOpwgVjpuHpaUCwLbM0Zs9RcrreAIj0RZB9CUWDAfQ=;
        b=SMsQmtlVuBipDGJbcIVE9Qr272g+1/JahpmdL1LNv8S7JvXfVHTo5HPaTVt6hQGXp/
         sGYebnmGjZ9ZSDKlZ1moef/VbXF4JE/2O4YBQ5ol2+X7oOk0NLl9tAySIMb1JrFjwRCf
         9YF9BbeOrMxvvbOVW2fChgJOhD7rF60/E7xAz9AqBZMLGfUBcxky48bbKDLqKG/yM5sX
         0VVCrg6oYIlLOiZLtRvK0T4Tp31QUlY8F7LYCnDJyPSc06qLiE8m/IjybCkxyqvhPRD7
         +V4GCrdvDCEtn9v1GtO5VbPJjo83o/qInFs9bpywL11z+FR4SVxLVbgDwv0J5vt1K6kM
         7oZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KkOpwgVjpuHpaUCwLbM0Zs9RcrreAIj0RZB9CUWDAfQ=;
        b=gws9AeE3L7QKcjnRJ7VrjeUwtTwdHkTA5DSEl3mwWKelzQtyouZpE2o8NspdsIjpsN
         bAW9ud5dGdQovDVhStobqM/NIX11Res/tSPKSf5QLO7DNmAlvlalQyWiFJsKdy0LwHQb
         7EuBFWsFdyhTfsNf6NkNM9ALkqBwdhAeELWvK4XNuPIQy60lkP843Wx3L+bmlUqGq98D
         AcPp6hop6ves8ZaDXdRZ7ew61BAHaj5yR45eSSR2dlfQeFNZDfy3+vdyjgJflzG+OKjA
         z7y1fu0gNUIvXkf6/hHTDDVpPx89E5zEyehj8t/qSibId+p2Re4kbYGjDV11Vhd7rDHV
         QHUg==
X-Gm-Message-State: APjAAAX5UWRdY0cz0/8ssLwSuO6D2sz0ZMOvvPWWGH0pdGP7jGl71NXC
        NFuiKdk2+DA961dnqH4c8m/l6g==
X-Google-Smtp-Source: APXvYqzKpA2WbMqr6YGngQwDxOMymmniH0R2P3fGtDPqh6EJbOJ4T3M9uOp+DLSwlFS3pRhXfQnpSw==
X-Received: by 2002:a1f:24c4:: with SMTP id k187mr21514959vkk.26.1558988986559;
        Mon, 27 May 2019 13:29:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id 142sm10463648vkp.56.2019.05.27.13.29.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 May 2019 13:29:45 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hVMFd-0003JV-3p; Mon, 27 May 2019 17:29:45 -0300
Date:   Mon, 27 May 2019 17:29:45 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Lijun Ou <oulijun@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH V2 for-next 0/4] Fixes for hns
Message-ID: <20190527202945.GA12710@ziepe.ca>
References: <1558683083-79692-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558683083-79692-1-git-send-email-oulijun@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 24, 2019 at 03:31:19PM +0800, Lijun Ou wrote:
> Here are two fixes patches for hip08 and hip06 as well as
> two updates for hip08. 
> 
> Lang Cheng (2):
>   RDMA/hns: Move spin_lock_irqsave to the correct place
>   RDMA/hns: Remove jiffies operation in disable interrupt context
> 
> Lijun Ou (1):
>   RDMA/hns: Update CQE specifications
> 
> Yixian Liu (1):
>   RDMA/hns: Remove unnecessary prompt message in aeq

Applied to for-next

Thanks,
Jason
