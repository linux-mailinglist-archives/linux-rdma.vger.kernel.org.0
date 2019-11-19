Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30C36102D69
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Nov 2019 21:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfKSUSq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Nov 2019 15:18:46 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:42625 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfKSUSq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Nov 2019 15:18:46 -0500
Received: by mail-qv1-f65.google.com with SMTP id n4so5606281qvq.9
        for <linux-rdma@vger.kernel.org>; Tue, 19 Nov 2019 12:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pqmH5KHePvJ9CX1Po+lKu+xExuHdsfhoF1iWXxcgUTE=;
        b=BuDMadrjGhA8eF50X3rrGq2dH3Xmzy+sLXkjJf8zuzK+kOkwm1CkVV8igDAFK0tl4E
         aGblD8oGdYXnDULgfcf3PfAYK8qqm00Wx3z6NQAc5XUOtcWszXizmE+JhsIOi+tsOtuc
         oRaI+KikvCnlFkRt89ix04/pvM3iZhzca7lrZH88O6U+RnZ3sa6oiofObprdqyZe6uC+
         R7uD3pJQqNgsKrHWe23RsKDhatsJOud+NkOD6k2OL+q10lL2qUht+PfQa53fr6D+Y2e/
         XUWhljX49EaDn9IVifw1aW/ysiFIB527ke4ErESbN7XY7dFArAxmFxpM4oCEZy27H6fB
         O/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pqmH5KHePvJ9CX1Po+lKu+xExuHdsfhoF1iWXxcgUTE=;
        b=SNl0WV01sw/VBm4IW2sDKmZojmQQvlqudn2arD8rGGQQiFIWq/ls6IKXCI7BbnAiUE
         1U3tzvffJn4veug+z+kMmx9H+gf6fjj7kSmJw8wNu3ioE7L3hPgcfOb5QBd0HHEXl7rI
         S5H+7/T+vINXjfiGCCcNMFva80xZEO2L4x8mL3Wwf/1F/PLi/k2cnWcqOZXZYXjDMqLn
         5eaPWyhO0KYL6CcMj+jWMJn9zw2q8RUHrDcvmIsTBARGAiAOQtsutNZygXIpYgpz0Jg/
         ++kLcIpMh4q/5QHUIybNRcHOHVfP/nECUjH7GE4SWcxsBHvC6ryJWpQ11BqhPnPGTbLi
         LoXg==
X-Gm-Message-State: APjAAAW5HZs6Ih7Ei8DfMVgH+gw+8OIAfOcWd60T2fN9S3bSly73mqMS
        Kt6+QMloblHeBRiHxEq6vzsbmg==
X-Google-Smtp-Source: APXvYqzEWYAE7iuESXZpwCL2tXB+D1eOkrvRiY+l+geuT2jlKs7BQBl+iWqrPgHt4096zwSZJRy79w==
X-Received: by 2002:a0c:802f:: with SMTP id 44mr10523143qva.116.1574194725603;
        Tue, 19 Nov 2019 12:18:45 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id u22sm13155947qtb.59.2019.11.19.12.18.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Nov 2019 12:18:44 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iX9xT-0001kz-VU; Tue, 19 Nov 2019 16:18:43 -0400
Date:   Tue, 19 Nov 2019 16:18:43 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Kalderon <michal.kalderon@marvell.com>
Cc:     dledford@redhat.com, ariel.elior@marvell.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/qedr: Fix null-pointer dereference when
 calling rdma_user_mmap_get_offset
Message-ID: <20191119201843.GA6720@ziepe.ca>
References: <20191118150645.26602-1-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191118150645.26602-1-michal.kalderon@marvell.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 18, 2019 at 05:06:45PM +0200, Michal Kalderon wrote:
> When running against rdma-core that doesn't support doorbell
> recovery, the rdma_user_mmap_entry won't be allocated for
> doorbell recovery related mappings.
> We have a flag indicating whether rdma-core supports doorbell
> recovery or not which was used during initialization, however
> some cases didn't check that the rdma_user_mmap_entry exists
> before attempting to acquire it's offset.
> 
> Fixes: 97f612509294 ("RDMA/qedr: Add doorbell overflow recovery support")
> Signed-off-by: Ariel Elior <ariel.elior@marvell.com>
> Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
> ---
>  drivers/infiniband/hw/qedr/verbs.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)

Applied to for-next, thanks

Jason
