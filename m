Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25F831804C9
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2020 18:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgCJRaF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Mar 2020 13:30:05 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38358 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgCJRaE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Mar 2020 13:30:04 -0400
Received: by mail-qk1-f195.google.com with SMTP id h14so7565990qke.5
        for <linux-rdma@vger.kernel.org>; Tue, 10 Mar 2020 10:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5nAB2N8GmFzR7PVDAsDdIUbn/LQfI+kfDj1VjohmV6E=;
        b=J6WGG9LuD9kFifx2aQ7OE/dM1lDwYC00frgG78tYI9o597KU434g3EdPHu0SZIBZiE
         mGtQe8fvp5CDrxnOXtYvoe9PVAbHyt8HKd365F8FaPLhZuzE3Pnz5Ddy6UruLFsT0w5c
         +bGWsfSCouOlbYThMaI7ePtk9wwk/+WRoZkwhes/1tZACvThM+I6SEp+jPk59jC7DONd
         O6tTvuegrBK7m1cFzxFYbkVPVs9X2020LJtn5V/V4ubxoyKl25qpp1R2xEjW3yfc7fv4
         KNCRmmTLABL1p4Lh2iuRroGwxv3b/CCinJUKdb/cuEsOnwU86DaeKlzGkYIddCcfRZD6
         0OsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5nAB2N8GmFzR7PVDAsDdIUbn/LQfI+kfDj1VjohmV6E=;
        b=kJuWR3a6u9AKfGhAJVSvamg5LjAhbUwPbkbCGcZ/Ham4ZkAHelWlv9v4Meigxh+JLO
         INHbpVKInC5qcRDKuJWhbslB7BybEf5lesjce7OBJVEZmaWGhdxYnXeSUB4qpSJWIleM
         3JGfluZRjhXPPxfHyn0JDzQrwd8d5rPfDXMXDjwbKK67FpeHgaJ6yqsQ8q9Q3i2apSnX
         UXnrrNm+A7Ert8U/AqNDIeGr7BUGkzAV5yXlFmgSc30c1Haj0ZcG13qiVY4VomgpJZXJ
         vrbMi6ifxSS/VPuplwxV9dvvzqf5RA6C9IK67+U9kWif+uPdgwAUE7O02LetcrIUojPD
         GoYw==
X-Gm-Message-State: ANhLgQ3/gd+SFDtKHcv8jaiD6lLMWWVZ0xk4rnnODMwqHer0q58WQRCB
        d4OESB8xoUmCiJBt4D1RXjsYe/In3HU=
X-Google-Smtp-Source: ADFU+vt8f6n9I27O+MdVUmiifj1puGl5oS+pQtusAF0vhZGcIJSm0ewDzMNDZ5A3RD67lnCEz/907A==
X-Received: by 2002:a37:702:: with SMTP id 2mr17760695qkh.134.1583861403492;
        Tue, 10 Mar 2020 10:30:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id y197sm23964018qka.65.2020.03.10.10.30.03
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Mar 2020 10:30:03 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jBihe-0004EY-MG
        for linux-rdma@vger.kernel.org; Tue, 10 Mar 2020 14:30:02 -0300
Date:   Tue, 10 Mar 2020 14:30:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc] RDMA/odp: Fix leaking the tgid for implicit ODP
Message-ID: <20200310173002.GA16233@ziepe.ca>
References: <20200304181607.GA22412@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304181607.GA22412@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 04, 2020 at 02:16:07PM -0400, Jason Gunthorpe wrote:
> The tgid used to be part of ib_umem_free_notifier(), when it was reworked
> it got moved to release, but it should have been unconditional as all umem
> alloc paths get the tgid.
> 
> As is, creating an implicit ODP will leak the tgid reference.
> 
> Cc: stable@kernel.org
> Fixes: f25a546e6529 ("RDMA/odp: Use mmu_interval_notifier_insert()")
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  drivers/infiniband/core/umem_odp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc

Jason
