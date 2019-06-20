Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF114C46F
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 02:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfFTA3B (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jun 2019 20:29:01 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35401 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbfFTA3A (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Jun 2019 20:29:00 -0400
Received: by mail-qt1-f193.google.com with SMTP id d23so1347114qto.2
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2019 17:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EQv7U/+42zt5b8nOPF5NhYdyP4FJsGxh9RzZDxFOrjg=;
        b=PnDkZuoAAUQUM1cJfafxHJyq+d7n4FyVSURfyen9se2MGh0KR5gnD9gzy/477SztwV
         p57GTxG7up6ovDAKdXOm2/OQjGuhs9Hg/XFQF7/oUCxIkCXZn3IokCiOhHVYncquDisc
         lfHhVJzspyqCzKwM69uJU4WNMcw9Jk/9F9ZXrclLIRl4uEIc6z876O1R2FW1XlCn1UC0
         9EXRpolVIxvtRIYX7wUDyVXbplxS6CV3sXaT7Uuzs03uSzF02V2EYxeCSbc7amzgQdfl
         n18uid03zxuNPhT8z48eQJvHqcJDlTy72/6AtxLob9Xke4HM72CACzGcL99Yz7rQrURb
         hfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EQv7U/+42zt5b8nOPF5NhYdyP4FJsGxh9RzZDxFOrjg=;
        b=hR3cCsiV/19+h/QBS7rASYpCrBSqHUtBY7tAKdGd4EFXxXPUOVBxqWGicDbIPmiOxJ
         r0Yx5j7BdIEZfJA04gwOfd939z5tU0dkCkjQ1LOOQGopDPj8xDFod43Rtfg7NfJrbnEY
         Pg/RYqJOBRUeqPFni4thJlYF986R7ZFbrre/Jig0ICrNRl+otfyuA1LiEPJXto/Xxzjt
         dOycRKqcYtYPle3KOn2rh8JjWDbyWmyJ7k1XpxoNaI14IywVny8clyOwxqZfcZpjHUZL
         KkHCXFOuYXxZRF5kGlZlCRUfvSP+KLhFWRk6I0kN1mZXatJvGsGJk61VY9uK9se7WHOB
         yOMA==
X-Gm-Message-State: APjAAAXGNfAshhI2FmlSoeWsqs0+2xcrQmXNR6pL32uYthAigGunW2p2
        J/ecHfDOmsymcRuux+1mJw4x1w==
X-Google-Smtp-Source: APXvYqw1Pv0sR4CS1UCSphmCFGDQ+LzCb44tZQZNi+Jaxt02qUv63T3dqiVQ7OvS5KFrN9Ms5knmbw==
X-Received: by 2002:ac8:3ffc:: with SMTP id v57mr82333621qtk.277.1560990539802;
        Wed, 19 Jun 2019 17:28:59 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id t197sm11338715qke.2.2019.06.19.17.28.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2019 17:28:58 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hdkwk-0004CH-A9; Wed, 19 Jun 2019 21:28:58 -0300
Date:   Wed, 19 Jun 2019 21:28:58 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     leonro@mellanox.com, linux-rdma@vger.kernel.org, sagi@grimberg.me,
        dledford@redhat.com, hch@lst.de, bvanassche@acm.org,
        israelr@mellanox.com, idanb@mellanox.com, oren@mellanox.com,
        vladimirk@mellanox.com, shlomin@mellanox.com
Subject: Re: [PATCH 00/21 V6] Introduce new API for T10-PI offload
Message-ID: <20190620002858.GA16100@ziepe.ca>
References: <1560268377-26560-1-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560268377-26560-1-git-send-email-maxg@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 11, 2019 at 06:52:36PM +0300, Max Gurtovoy wrote:
> Hello Sagi, Christoph, Keith, Jason, Doug, Leon and Co
> 
> This patchset adds a new verbs API for T10-PI offload and
> implementation for iSER initiator and iSER target (NVMe-oF/RDMA host side
> was completed and will be sent on a different patchset).
> This set starts with a few preparation commits to the RDMA/core layer.
> It continues with introducing a new MR type IB_MR_TYPE_INTEGRITY.
> Using this MR all the needed mappings will be done in the low level drivers
> and not be visible to the ULP. Later patches implement the needed functionality
> in the mlx5 layer. As suggested by Sagi, in the new API, the mlx5 driver
> will allocate a single internal memory region for the UMR operation to
> register both PI and data SG lists and it will look like:
> 
>     data start  meta start
>     |           |
>     |d1|d2|d3|d4|m1|m2|m3|m4|
> 
> The sig_mr stride block would be using the same lkey but different
> offsets in it (offset 0 and offset d1+d2+d3+d4). The verbs layer will
> use a special mr type that will describe everything and will replace
> the old API, that enforce using 3 different memory regions (data_mr,
> protection_mr, sig_mr) and their local invalidations. This will ease
> the code in the ULP and will improve the abstraction of the HW (see
> iSER code changes). 
> The patchset contains also iSER initator and target patches that using
> this new API.
> 
> For iSER, the code was tested vs. LIO iSER target using Mellanox's
> ConnectX-4/ConnectX-5.
> 
> This series applies cleanly on top of kernel 5.2.0-rc4 tag plus patchest
> "[PATCH 0/7] iser/isert/rw-api cleanups" that was applied to for-next (Jason).
> We should aim to push this code during 5.3 merge window.
> 
> Next steps are:
>  - merge NVMe-oF/RDMA host side after merging this patchset
>  - Implement metadata support for NVMe-oF/RDMA target side with new API
> 
> Changes since v5:
> 
>  - Rebase the code over kernel 5.2.0-rc4
>  - Change return value of ib_map_mr_sg_pi() to success/fail
>    (patches 4, 6, 11 and 16 were changed - Sagi).
>  - Squash and refactor "Validate signature handover device cap" and
>    "Move signature_en attribute from mlx5_qp to ib_qp".
>    (patch 15/21 - Christoph)
>  - Split out helper function at RW (patches 16/21 and 17/21 - Christoph)
>  - Rename signature qp create flag and signature device capability
>    (patch 14/21 - Sagi)
>  - Added Reviewed-by signatures

It looks to me like we are done with this now, yes? I'll apply it
tomorrow then.

Thanks,
Jason
