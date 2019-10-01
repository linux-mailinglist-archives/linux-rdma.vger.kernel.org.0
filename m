Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 609D4C3754
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Oct 2019 16:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfJAO3m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Oct 2019 10:29:42 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44251 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbfJAO3m (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Oct 2019 10:29:42 -0400
Received: by mail-qt1-f194.google.com with SMTP id u40so21841949qth.11
        for <linux-rdma@vger.kernel.org>; Tue, 01 Oct 2019 07:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W+r+etfv+drg92SZnh2+v1M1aGKblCz8nLkM1r6EXL4=;
        b=FFecNOUB6t4D3VeJbinLBrmUSl80zRq+K7nYaQFr1pfy22WUNd7t1an4ztOdhZUPPa
         M19fSwg6EAoCZ+3j1WDZ4pSmEjVMk3UKtNvO7zwAcSU597oZ4mLPThMvjZfheVnrAGOS
         KkCixwuX2LSVugwxQ17/WAlEAJof5Bj7qR1K5GJ1odteQN2tPHUbSKu80eCvrI3PLj+T
         AL2BErQnb0iAYYGBF2gdrsyVDvPsW5FhWxdClIWm2JiCyjhJ3NeD/Qe73OqxV29da7US
         Ss3MiioA4LoSwrhW4eb6R+eakzUMI9X3rDIYuvt+s5/EldaEj18Z8IYO8HsWyvf+xa3T
         d1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W+r+etfv+drg92SZnh2+v1M1aGKblCz8nLkM1r6EXL4=;
        b=nK3Cdb/eO5qf3cwPuNfySlxATp9ZfkrW+81/plM7FMUMm8EavwnZGb/jlDoNQfibY2
         pbqn3KPQk23Z7WmGq989WCu7XG4UohQ7x+y7j2MPe4TleifexFyzNapb5AW70/RqvJAz
         FV2G+CcDw0Rb9pjhWDF5NGJ8YavCou6KlzumvZGVFU/xiXj4HYqt7vIMeO80dojpMzia
         dPIOmnwZ583CbxU3ffVyUCkGTH1uq5d1Oh6y8x6nIxI7wamjr7UHno5eBiS4t82WJWbc
         svxDzhbYcMJGR2iX31qXxOAwuMF3xDhyHWuyS+UqQrwQFjq1BiRYHMw6QjiuIFn9chhU
         EgdA==
X-Gm-Message-State: APjAAAWAqA/a8wLmZKwUZYsY+5ohs/OcNJIpjNq2hu4Lzy6pzQ2iMD/y
        /RCge3xNwoFJm+PnjFLTT4MluA==
X-Google-Smtp-Source: APXvYqxGSU12kfsw65X5oXH9aBNlRiR97KRCNmQIY7pdCguh7LJwLJ49q14A8wQryoWz5AohruCT4Q==
X-Received: by 2002:a0c:fa85:: with SMTP id o5mr25676649qvn.183.1569940181678;
        Tue, 01 Oct 2019 07:29:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id o52sm11016873qtf.56.2019.10.01.07.29.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Oct 2019 07:29:41 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iFJ9o-0002yi-MF; Tue, 01 Oct 2019 11:29:40 -0300
Date:   Tue, 1 Oct 2019 11:29:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, dledford@redhat.com,
        leonro@mellanox.com, sagi@grimberg.me, martin.petersen@oracle.com
Subject: Re: [PATCH 1/1] IB/iser: bound protection_sg size by data_sg size
Message-ID: <20191001142940.GB11407@ziepe.ca>
References: <1569359027-10987-1-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569359027-10987-1-git-send-email-maxg@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 25, 2019 at 12:03:47AM +0300, Max Gurtovoy wrote:
> In case we don't set the sg_prot_tablesize, the scsi layer assign the
> default size (65535 entries). We should limit this size since we should
> take into consideration the underlaying device capability. This cap is
> considered when calculating the sg_tablesize. Otherwise, for example,
> we can get that /sys/block/sdb/queue/max_segments is 128 and
> /sys/block/sdb/queue/max_integrity_segments is 65535.
> 
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/infiniband/ulp/iser/iscsi_iser.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to for-next, thanks

Jason
