Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1A61D0395
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2020 02:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731399AbgEMA1W (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 May 2020 20:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731107AbgEMA1W (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 May 2020 20:27:22 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7676DC061A0C
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2020 17:27:22 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id b1so12034295qtt.1
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2020 17:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vQQlYV0mWhWFgdbtawFm7sLDmoe715+jr/GNcNFTAuo=;
        b=ZQ2krf+nZRjRXOmdZhPnYzJh0H0hrw1Iuhl0GBDpEfY16TX7MOJtFez44RVtD/vlMr
         MFOXWUg1V6sGoURmfJ92eWsK5PM8p13XGDlt1igUfabf7MUVVRojmQqzdmqSqrVMOazf
         pglAlxjS2RJ7zv1adVMF46nzL3ndoAT5bjQtngZTkFYerFPZRUpJLWP9OWyuEk3BO47P
         XespuqHuzZLxCesrrZDLU5mAnr67h1R0VHL/tGzEEtyh8fU/67arHez+06c3SNpMHYwS
         SObcd9Kqsgu/96g2DVNAOeItVQv7EavRbRguQFLteBgvnI0+/YM4dLNJQCp/7pBd+Am5
         OlGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vQQlYV0mWhWFgdbtawFm7sLDmoe715+jr/GNcNFTAuo=;
        b=tkH7kJesBrXrH88wUoLXq0vNMHiRZbXBQ+G1mf1mMjGklWosPu3CCglHsl1nkudksB
         lb22sfKxTI03iE5kcjWW2OpD4RGL0AmM23b3CR1M29cLgj2LN5cpMNwgu1aXGEJ0SO9M
         2KedsX9ObB0dERyyXu3c+4tCaI4SRPo1j35g8gaIqtjelsEU8TkwQIbPDxIV99lLu6ZX
         BPUHIy7PvSy6gbbuiV9GpoEBJZMVeB7nyvJ6vGNCV+CIl56ZAPsYLtDKT02vZc1WUmk3
         w+T1+9qCLo+r9jZEZCpH1352ij9SRqdc76As3sauxaeh1JA2MQn+XrAMQjThJXkmt/ZM
         Qzdg==
X-Gm-Message-State: AGi0PuY3HuuFiRkTbwSsoz1KRWurViftN0SIHDLccEZBRNsjBz86kJs3
        H/LPo5p1gqiB9B/p2+TJWu1umQ==
X-Google-Smtp-Source: APiQypLypGsvf49kgtlsARmEEgyy+o9YjQA++60MlG4L/OnytoeV/AQYLRXbIkGcTQb6qIs0FQm56Q==
X-Received: by 2002:aed:34c6:: with SMTP id x64mr25820808qtd.66.1589329641672;
        Tue, 12 May 2020 17:27:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id z18sm13348254qti.47.2020.05.12.17.27.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 May 2020 17:27:21 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jYfF2-0002Uu-Cy; Tue, 12 May 2020 21:27:20 -0300
Date:   Tue, 12 May 2020 21:27:20 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 0/3] RDMA/hns: Preparing for next generation of
 hip08
Message-ID: <20200513002720.GA6166@ziepe.ca>
References: <1588674607-25337-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588674607-25337-1-git-send-email-liweihang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 05, 2020 at 06:30:04PM +0800, Weihang Li wrote:
> Patch #1 add a macro HIP08_C for this new pci device, #2 and #3 adjust
> codes about flags.
> 
> Lang Cheng (1):
>   RDMA/hns: Combine enable flags of qp
> 
> Weihang Li (2):
>   RDMA/hns: Extend capability flags for HIP08_C

These two applied to for-next

>   RDMA/hns: Add a macro for next generation of hip08

This is just dead code, send it as part of something that uses it.

Thanks,
Jason
