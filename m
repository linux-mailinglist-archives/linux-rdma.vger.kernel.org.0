Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30216B3FA1
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2019 19:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730835AbfIPRhD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Sep 2019 13:37:03 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37527 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbfIPRhC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Sep 2019 13:37:02 -0400
Received: by mail-qk1-f194.google.com with SMTP id u184so838028qkd.4
        for <linux-rdma@vger.kernel.org>; Mon, 16 Sep 2019 10:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KqihZYusEoDXPDdbUnjj9b3nmScP5PAsRt0HIcG3BJo=;
        b=VYFK9Xvj5S7UF4bE+xJ7vxeUaeiKWy0/knxN54NdIePxP5FIvFm4J46YcFzkpWEhS0
         3yurat+4ygCBB8WuelCmaiHetiozkzI5VDT+zwXDzNZ9xRSxTloxiZ0v6Hol+ceXc5Jd
         7gyqXGOF2d+gfj6pKmlIXFQSOVBkKfpuAlv3VdWyRCzZfNYncpLylUmHapxVwkn2EjIC
         DotJcGX/mhvu1d24x166YuRNUbrOx5dIgCff2aYHPGJBSvMGOxqTCwsdxBrIcHRYh1aC
         VPJKS3inLXJxTNxe/3QjhsIQSbrFp0cm8yp+eIhRq0rHU39QUe1Fa9GpjkB5JdtEuwXv
         zpqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KqihZYusEoDXPDdbUnjj9b3nmScP5PAsRt0HIcG3BJo=;
        b=heYiBgIz++++c3LQ84SiVgKnJTZ9f2fS2rjA9GBbrMkcpB/1etfjH+SonaCUfP6fRu
         0wC3hmWh+z5Ek94F2XG8qAh4OeA4FvV4fdFW2GCWKZjM680ZFzn29gVS0FAd+uxUfiMy
         7Xih9mZRDDGo9eBo7Egp4n4ngy1gC0c4SuhrHMVKhxPKXjN0TSeik27dsIAmJGPPR0HL
         Rtykp5LbDYkSzlFbGSwXfc+K3JP9upPnKwJ8rbIGkCc0xVekCIC7v+pK4PNtdduIf244
         AFV38EolyvuY91eybz10tUTwNAALaUO7rXXKStBOdL4M6VxZmvXLYRMjYlQnzPv9FTac
         jKPg==
X-Gm-Message-State: APjAAAWjMQjWiUeB6CMM2KXEZpvfUDpLpYWJ7HLJCIICA4KzphaFGIcw
        y16Pbu9lj5D5kg4vJ/WxePpeOA==
X-Google-Smtp-Source: APXvYqw/Js5iEidU9/BJqgWSA3nDgSQHEfkZhc36g1ufgz+J9w16WHJG2JPJku9qibPiKX3skHao0w==
X-Received: by 2002:a37:9e0d:: with SMTP id h13mr1135336qke.473.1568655422028;
        Mon, 16 Sep 2019 10:37:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-223-10.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.223.10])
        by smtp.gmail.com with ESMTPSA id a4sm25100816qtb.17.2019.09.16.10.37.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Sep 2019 10:37:01 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i9uvs-0001he-LU; Mon, 16 Sep 2019 14:37:00 -0300
Date:   Mon, 16 Sep 2019 14:37:00 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Daniel Kranzdorf <dkkranzd@amazon.com>,
        Firas JahJah <firasj@amazon.com>
Subject: Re: [PATCH for-next 1/4] RDMA/efa: Fix incorrect error print
Message-ID: <20190916173700.GA6516@ziepe.ca>
References: <20190910134301.4194-1-galpress@amazon.com>
 <20190910134301.4194-2-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910134301.4194-2-galpress@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 10, 2019 at 02:42:58PM +0100, Gal Pressman wrote:
> The error print should indicate that it failed to get the queue
> attributes, not network attributes.
> 
> Reviewed-by: Daniel Kranzdorf <dkkranzd@amazon.com>
> Reviewed-by: Firas JahJah <firasj@amazon.com>
> Signed-off-by: Gal Pressman <galpress@amazon.com>
>  drivers/infiniband/hw/efa/efa_com_cmd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Safe enough to apply to for-next, thanks

Jason
