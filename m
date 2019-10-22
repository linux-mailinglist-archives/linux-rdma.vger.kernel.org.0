Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 917E9E0C48
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2019 21:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732564AbfJVTMS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Oct 2019 15:12:18 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34631 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729696AbfJVTMS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Oct 2019 15:12:18 -0400
Received: by mail-qk1-f195.google.com with SMTP id f18so16748804qkm.1
        for <linux-rdma@vger.kernel.org>; Tue, 22 Oct 2019 12:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nysxb4NxOzc34BLE8aYpf5+rztCogoNfw8sxbZXLVf0=;
        b=c+ZppCOcCXkLqnSt1Af5JzQ/n2eRfVp476u86d5pkFQCcdqA5AJTSyjOedcMFbtjt5
         yrdUfYJ+mBAjWwiglQglsyMFst/wIy24oQ3kgFVsHYDk6tMsQy389iTzKZYzVr97jt96
         JEOJxXnyF4cUogJdBTXGTpWtkJTju+EFkaGLvKa6nhI5AS0YrQQyVJxlaywjd6nYtww6
         tECDcqYYfoqOeT+c3hoxOnYsSE9528TjKYBYRpjKjbER5Q2icHA0OwItQED1sZIUOb+v
         EM0btFnLkJfkq/0SFiqtll1lCisBvD8i44XtEJdIC+L9Vp9VFUk1Jr94fFL1cN7JWEk/
         C68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nysxb4NxOzc34BLE8aYpf5+rztCogoNfw8sxbZXLVf0=;
        b=llaiWJWjKUzSuwiLaapdW1jdZebVso8UU2Bp7GzIJJMsnuHNL1li0RH+kFUl4GLRKg
         QlFAaxm2unebKgfbTfbMEsSV9BPxKulv8I525JocUX6tE/LpiNhqRCU9xxYFtfGYQniU
         bSkecl3DjePgbn9l6sfxX3HLh6UQGf9y7uTJJWSNS/xNtj9R7uJuGnFBmhr8BZLmnut2
         3BRSAvpIoIJCsHloOdtQGdfxy6lyj3DDAp99/eaVnSFigewJdI/+aEfIW+nSGQtS1WbN
         xJ6rrEzC8b1n9Ja+HBre2hwTm5isgwAHCbRYkj4n4OFlG970vzlhfTT23nXho30Z/V+8
         ORZA==
X-Gm-Message-State: APjAAAUTrlFzf1OWuxZhFq/H8QApqc1lA37V7S6h87dWN3pi91EpYQKp
        yc67/gYFcqTomtkFRFKRYjtRXg==
X-Google-Smtp-Source: APXvYqyraFIgkVanyUK/zRQeSMtzlbZh+bvyY2t61gipfsOHgnqkFON4RBYL1xMqtXrGBQ8vl/LVeg==
X-Received: by 2002:a37:a709:: with SMTP id q9mr4552281qke.57.1571771537157;
        Tue, 22 Oct 2019 12:12:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id f10sm8527753qth.40.2019.10.22.12.12.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Oct 2019 12:12:16 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iMzZo-0002n5-7w; Tue, 22 Oct 2019 16:12:16 -0300
Date:   Tue, 22 Oct 2019 16:12:16 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/uverbs: Add a check for uverbs_attr_get
Message-ID: <20191022191216.GE23952@ziepe.ca>
References: <20191018081533.8544-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018081533.8544-1-hslester96@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 18, 2019 at 04:15:34PM +0800, Chuhong Yuan wrote:
> Only uverbs_copy_to_struct_or_zero in uverbs_ioctl.c does not have a
> check for uverbs_attr_get.
> Although its usage in uverbs_response has a check for attr's validity,
> UVERBS_HANDLER does not.
> Therefore, it is better to add a check like other functions in
> uverbs_ioctl.c.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>  drivers/infiniband/core/uverbs_ioctl.c | 3 +++
>  1 file changed, 3 insertions(+)

The call in uverbs_ioctl.c is safe as well, that code path checks that
the attribute exists.

Still, it make sense that this check should be present, so applied to
for-next with a clearer commit message

Thanks,
Jason
