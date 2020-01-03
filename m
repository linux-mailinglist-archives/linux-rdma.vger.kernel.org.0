Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2466A12FDFF
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jan 2020 21:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgACUhC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Jan 2020 15:37:02 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40408 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727400AbgACUhB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Jan 2020 15:37:01 -0500
Received: by mail-qt1-f194.google.com with SMTP id e6so37753444qtq.7
        for <linux-rdma@vger.kernel.org>; Fri, 03 Jan 2020 12:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ncHLRVgNW/ChGTh4rBVPGegYhYAGDxMO6ko3rbsIu7Y=;
        b=TTeutwsnueGMJ73LWAHs5Tr0MQVsn3fLVaWOiNbMvgOKcacw0KK9UFIDjKXjEGf0on
         nA4F49kl68IslJ3zj4a8z9nz6eB8MerXDoxOw21OBEjzQCePJ+Dsaf9Mgt/Ic9LjFtlF
         FrrzqNquPqXxg+G2uKt0dVhzA+kArEkr9bSkj/YnxjSrM5DvGPswF/WO9HQnJLJlDZ1a
         pj+Z1c0Aldt+k1sjiYE2elH1gS7l4IN8/SLZx9rGXzvWRBSagDkTPXBfR46hq2k16lo9
         k2OiuKFwbqB4WEv/qFbDkGO3TRIS/3PT2CzaVmVT8LrXw8XC3PDFZUJHfZG3n9DeOrLU
         XQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ncHLRVgNW/ChGTh4rBVPGegYhYAGDxMO6ko3rbsIu7Y=;
        b=h9m0lPR7cjfhHrbKUdsUH9itsDTMmJTCKqBnGqzJf8ncOSzzpPyiCfUSj9QAG1Ckdm
         DMZCL5VUsCi8ru55k3cVnb+vsEaEqNPhgNfa4lMJJ36F328CsRgqamFS2n3dinaoiyYs
         N8lhdN+VWfHHOHxkz1dGoa5je799r9P8M1fXsdNAcqRGEA+JwDdE6r+jefXXLeMngStG
         TBwQBR5X3yDQTWSzL4GpBxdsPXvoxAyluwoet+hyxcRjDfLA0WzFENSNNI6VovvsGJ9c
         6GykCp94WTX4E4qStOblmnEnrhYzCBdidhpN/eu4gmzJmRnJ7FZetkLBJPoa2v/GvdwZ
         0O4A==
X-Gm-Message-State: APjAAAWO7aJpKu7x2/vqTazJv5Xmu1e7iLCexyR5dyDI5a/+TIOO1HTg
        8YGND/INiTreWV5lqmIw++hnhQ==
X-Google-Smtp-Source: APXvYqx7Jf/CDhkh6iN0CETNPeKqSXKHTLwA7z7euLkd7cQcbzG97IilINENtJS1gkoZ+NYLcIzXSw==
X-Received: by 2002:ac8:7a6c:: with SMTP id w12mr67372505qtt.35.1578083820919;
        Fri, 03 Jan 2020 12:37:00 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id l19sm18906898qtq.48.2020.01.03.12.37.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Jan 2020 12:37:00 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1inTgp-0007aM-V1; Fri, 03 Jan 2020 16:36:59 -0400
Date:   Fri, 3 Jan 2020 16:36:59 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Danit Goldberg <danitg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH rdma-next] RDMA/cm: Use RCU synchronization mechanism to
 protect cm_id_private xa_load()
Message-ID: <20200103203659.GA29125@ziepe.ca>
References: <20191219134750.413429-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219134750.413429-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 19, 2019 at 03:47:50PM +0200, Leon Romanovsky wrote:
> From: Danit Goldberg <danitg@mellanox.com>
> 
> The RCU mechanism is optimized for read-mostly scenarios and therefore
> more suitable to protect the cm_id_private to decrease "cm.lock"
> congestion.
> 
> This patch replaces the existing spinlock locking mechanism
> and kfree with RCU mechanism in places where spinlock(cm.lock)
> protected cm_id_priv xa_load.
> 
> In addition, deletes cm_get_id function and use cm_acquire_id directly
> with the correct locking. The patch also removes an open coded version
> of cm_get_id, and replaces it with a call to cm_acquire_id.
> 
> Signed-off-by: Danit Goldberg <danitg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/cm.c | 43 +++++++++++-------------------------
>  1 file changed, 13 insertions(+), 30 deletions(-)

Applied to for-next, thanks

Jason
