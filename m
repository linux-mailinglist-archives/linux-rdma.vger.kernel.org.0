Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A614F4C44F
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 02:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfFTAB0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jun 2019 20:01:26 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44420 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbfFTAB0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Jun 2019 20:01:26 -0400
Received: by mail-qt1-f195.google.com with SMTP id x47so1206921qtk.11
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2019 17:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Sqbwy91llQPefonvV8hojpIN0xcDDpBbbCse1JqIdUo=;
        b=QdbMA+elg5C6VGMvThUwpsLI7l/+4xPmhV/L6gRyX/b4I56fkeg6jJtXdG0WKu9TL/
         L9zoMssH5TQwzMNNyiwgTveuFidckERm+BsqjCxzdWGdWGGedErG6UJQPBfII53sE2Ux
         GRwrvH7f21aUV/AYqhnVDDaw3UL7MxAfg13r7Ky6Bf91XgHroqAAPx4Hvhg+rsfvKUHw
         z2sOdyFsZXcXhGiggW2BfgrlW0TgtimJQhB7xM0yAFP9Zui2NhHQ9cPDVgDOEhkkrmSV
         PxgK6MkWMFZOWv7xkgQec0wRwUuZ9aJN+aLPg2qqpg/j+dCDw3/hlfwhtpTNUL5rAo4H
         SLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Sqbwy91llQPefonvV8hojpIN0xcDDpBbbCse1JqIdUo=;
        b=Lq6Fvm+csK/zYBSkTKPqsSdA8aeJmPuA8UaWtkdo/hPyTjUub8/O5v0ZtQWROqNJcP
         X6XGGU/8wVi2RzJm8mEAOK5NdbXg5D9yfXpqFdyzLdJcXVgvqXqtn4E5BAy17LctLdfs
         u/z+f9EL2D+ysWvbY/v4Bn0LU6yiMlgelJKf/qGZflBSnBCg7/CjdTmt5rCDQwWtlfYb
         BxbR7n07WebKIt0raNpihR622thyadaz3UEhnbtfp7UY8JcANx1nRSal1Zn/D92k0lgB
         8fDcrLlUGdCVAitMIJP5zHY1u52G+MynV53EKhgXv+1deVY2N0Ctw+jrBHckYbEybYN1
         mT9Q==
X-Gm-Message-State: APjAAAWGhpm/p+0iRrt/k3X6PqBl3Fqnx4QPxEwANwRokTC5pkD/cmR6
        guBS9tESeOPDOlAERsRlxUOvTQ==
X-Google-Smtp-Source: APXvYqzKyx6zBYzXLykhmiJLriRApnAEv+DYrCe+kjfeKxPk/Zu0FXoLmY7SEvqmrQTEDWJyS3R1vA==
X-Received: by 2002:a0c:b163:: with SMTP id r32mr36768273qvc.169.1560988885408;
        Wed, 19 Jun 2019 17:01:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id d3sm9896526qti.40.2019.06.19.17.01.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2019 17:01:24 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hdkW4-0001Jm-Jc; Wed, 19 Jun 2019 21:01:24 -0300
Date:   Wed, 19 Jun 2019 21:01:24 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Honggang Li <honli@redhat.com>
Cc:     haakon.bugge@oracle.com, linux-rdma@vger.kernel.org
Subject: Re: [rdma-core ibacm v3] ibacm: only open InfiniBand port
Message-ID: <20190620000124.GA5039@ziepe.ca>
References: <20190611233325.3141-1-honli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611233325.3141-1-honli@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 11, 2019 at 07:33:25PM -0400, Honggang Li wrote:
> The low 64 bits of cxgb3 and cxgb4 devices' GID are zeros. If the
> "provider" was set in the option file, ibacm will fail with
> segment fault.
> 
> $ sed -i -e 's/# provider ibacmp 0xFE80000000000000/provider ibacmp 0xFE80000000000000/g' /etc/rdma/ibacm_opts.cfg
> $ /usr/sbin/ibacm --systemd
> Segmentation fault (core dumped)
> $ gdb /usr/sbin/ibacm core.ibacm
> (gdb) bt
> 0  0x00005625a4809217 in acm_assign_provider (port=0x5625a4bc6f28) at /usr/src/debug/rdma-core-25.0-1.el8.x86_64/ibacm/src/acm.c:2285
> 1  acm_port_up (port=0x5625a4bc6f28) at /usr/src/debug/rdma-core-25.0-1.el8.x86_64/ibacm/src/acm.c:2372
> 2  0x00005625a48073d2 in acm_activate_devices () at /usr/src/debug/rdma-core-25.0-1.el8.x86_64/ibacm/src/acm.c:2564
> 3  main (argc=<optimized out>, argv=<optimized out>) at /usr/src/debug/rdma-core-25.0-1.el8.x86_64/ibacm/src/acm.c:3270
> 
> Note: The rpm was built with tarball generated from upstream repo. The last
> commit is aa41a65ec86bdb9c1c86e57885ee588b39558238.
> 
> acm_open_dev function should not open a umad port for iWARP or RoCE devices.
> Signed-off-by: Honggang Li <honli@redhat.com>
> ---
>  ibacm/src/acm.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)

Applied to for-next, thanks

Jason
