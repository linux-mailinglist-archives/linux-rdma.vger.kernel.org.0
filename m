Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1664E25738
	for <lists+linux-rdma@lfdr.de>; Tue, 21 May 2019 20:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbfEUSEZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 May 2019 14:04:25 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45690 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbfEUSEY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 May 2019 14:04:24 -0400
Received: by mail-qt1-f195.google.com with SMTP id t1so21546998qtc.12
        for <linux-rdma@vger.kernel.org>; Tue, 21 May 2019 11:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I/uthh+tbAzQdKNj8ngGDvQAYtYB/uSnuDu3bBoP7KQ=;
        b=ZITbPgLL/+4pJjMvjU0AIxlhg7tTmPtrJa++NCopHZOHNIfZiTIk6qm/OyhnLc/h1Y
         Pa0sPZebHv2z5KWoY4eKVmy9V9DNHldBphIpyL7riTfQC8V02RvJrnW7mhZiZbp3IQ4o
         RvydGT4ATDhNygkAyMBaT9lFjRsajkyC5bPDolAQrhWFf6s5Cz5YJBjgikoFl/is5IBr
         wAPgzMFuWx+zRyNYUO6DmqGtjNOb2e+3M7T9DAG0jpb1FiqDCQX6AwvBledIip/YbahJ
         qTbdc6cVO7bCdEi7AMnm9pCtt7r3zUDj65XpGCatpRCu8yjY9jtL/4lKE9otjmtxM8P0
         NANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I/uthh+tbAzQdKNj8ngGDvQAYtYB/uSnuDu3bBoP7KQ=;
        b=IuuQJMq4/LfD+SfJ1gKRforOrdq90us1s5fx/75NGj7bScQnyLcH6fN1or5QzN8dPN
         aoUdTOE6f6vzW8uN0AbMf7o3G/hbyV5VB7A/ddaSzNMl9kYcVInblZ3u2OVr+EvFIiz4
         TN0HQhEsICNep9TsWsSn4ZZjhlf4mFZkVzwdtEdq8yv32AEbxJySmy6pF3gHYwTkrcY0
         zI8Q76UA/A52d4/L4Y0UQ57IXGbPQ8muk3MdUwA8GqaIo0ipMMIaE9N6fIZZ8D7woeOF
         Hv4UearSbzZkaH5f7F8WaBGaBsegDVWKXO/a3HD8XIetOTsXMyTlB08xlpgV3GACd2NU
         MuNw==
X-Gm-Message-State: APjAAAUdCVeG87iTnhTZsYTuufj636Kd5QxU2z6gLTIfkzqnk1LNpNfI
        5aYapZu3203MB2Y3M/Vttt44AA==
X-Google-Smtp-Source: APXvYqxVmc7Qg2cqf1mIbes/JXf2YAzy8hlVmnBbFUwi0FDm/khBORx0ehp9aOKEDwjz0pvrEEyXUA==
X-Received: by 2002:ac8:ff6:: with SMTP id f51mr68929964qtk.116.1558461863905;
        Tue, 21 May 2019 11:04:23 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id f67sm3536477qtb.68.2019.05.21.11.04.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 11:04:23 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hT97e-0006Ld-Fs; Tue, 21 May 2019 15:04:22 -0300
Date:   Tue, 21 May 2019 15:04:22 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, leon@kernel.org, dledford@redhat.com,
        hch@lst.de, sagi@grimberg.me, israelr@mellanox.com
Subject: Re: [PATCH 0/7] iser/isert/rw-api cleanups
Message-ID: <20190521180422.GA24375@ziepe.ca>
References: <1557917371-8777-1-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557917371-8777-1-git-send-email-maxg@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 15, 2019 at 01:49:24PM +0300, Max Gurtovoy wrote:
> This series include small fixes/cleanups that were discovered during
> signature handover new API development.
> 
> Israel Rukshin (6):
>   IB/iser: Refactor iscsi_iser_check_protection function
>   IB/iser: Remove unused sig_attrs argument
>   IB/isert: Remove unused sig_attrs argument
>   RDMA/rw: Fix doc typo
>   RDMA/rw: Print the correct number of sig MRs
>   RDMA/core: Fix doc typo
> 
> Max Gurtovoy (1):
>   RDMA/rw: Add info regarding SG count failure

Applied to for-next, thanks

Jason
