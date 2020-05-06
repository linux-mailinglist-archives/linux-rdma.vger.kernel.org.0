Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E505B1C7B4B
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2020 22:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbgEFUcI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 May 2020 16:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728733AbgEFUcI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 May 2020 16:32:08 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0127DC061A0F
        for <linux-rdma@vger.kernel.org>; Wed,  6 May 2020 13:32:08 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id j2so2730538qtr.12
        for <linux-rdma@vger.kernel.org>; Wed, 06 May 2020 13:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rdFmNlXRLUtf3P408y1G7uci4bk3HSyTfGrbZmNqExw=;
        b=crTTa6AOuZxZBQ5i/8omouQZLEr0uo/w54uJXyLWdTtdF7jFSU1LVYTbokvlMoXFZp
         CPdAiiqeHTRZZ85ZIVhSAUDq4AJ7SSKeosZM8bpdEduHQIZH5hA1FidN4edrqaX7qpQo
         9M/+KwS8fTyLzg24KdBCP+XjLIQD+42Y1c6rvcKGOWhtGL2eGR7VWNscP+RMufZktSvN
         vtKX7w8HPlNTz4/Q3o85An5S+sxaNxRk3DtMDMzVgSZHexo3Xb2WCrMvm5nGR9KK2zZT
         Rv74huWFyf10Znc5kxbNfgHVWjVoTrLkUXyZcD56dG3/ktMcAY6MKPWsiKG/ciiBfJRL
         IU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rdFmNlXRLUtf3P408y1G7uci4bk3HSyTfGrbZmNqExw=;
        b=iNn8tfSchWFnbLvWgrOCVDrWb/+EvypoJIRfKtb0s/c6FZjA049s6KffXdNPmIU/Ng
         t0hfelQFS4CtDo5XL2DFvG6c5X/sHkqOGDmMi5hxKZKbk4cdWmQ6f/j4xHeUc6ugCujX
         vnI0moXJgnr91VhTf7yu9d8D1daA0FDLHhqC362UJ44659l2lpDifBhsqQTyeNKZXUk4
         hkAU2MPvdAgOQOdeXJEfDE+7/Oib+IUnWSi1zksLAkYetrPMLsNOF6/tXp7gpZMCilAS
         +CuF3p0+VcOqPqkelTjGbIiyrVbT9tYLri+EhetxLSjUiu1s8hpIKMbBk2j9EgxwpzlG
         Ftpw==
X-Gm-Message-State: AGi0PuaFeEnS5F6eX1HHtNoypYjHu/LZ3Dxq+c8DBoBuGYHLHyyaQhpc
        AGs/JEaKN62pUHalRGz1KNffMA==
X-Google-Smtp-Source: APiQypIkQLkIs6t32a4QU/eyPLaW4gBPy6dBYWX2oEREUVyVEoScQD8dXLeiQFU3Ks7hA3ZcKe4FNQ==
X-Received: by 2002:ac8:82f:: with SMTP id u44mr10164873qth.198.1588797127129;
        Wed, 06 May 2020 13:32:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id p24sm2704127qtp.59.2020.05.06.13.32.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 May 2020 13:32:06 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jWQi6-0002Oc-5A; Wed, 06 May 2020 17:32:06 -0300
Date:   Wed, 6 May 2020 17:32:06 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v4 for-next 0/5] RDMA/hns: Optimize PBL buffer allocation
 process
Message-ID: <20200506203206.GA9150@ziepe.ca>
References: <1588071823-40200-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588071823-40200-1-git-send-email-liweihang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 28, 2020 at 07:03:38PM +0800, Weihang Li wrote:
> Patch #1 and #2 aim to use MTR interfaces for PBL buffer instead of MTT,
> and after this, MTT can be removed completely. Patch #3 and #5 refactor
> buffer size calculation process for WQE and SRQ. #4 can be considered as a
> preparation for #5, which just moves code of SRQ together to a more
> suitable place.
> 
> This series looks huge, but most of the modification is to replace and
> remove old interfaces, and patch #4 also contribute a lot. Actually, the
> original logic is not changed so much.
> 
> Changes since v3:
> - Fix a sparce warning about a function that should be static reported by
>   kbuild test robot.
> 
> Changes since v2:
> - Just do a rebase to current for-next branch.
> 
> Changes since v1:
> - Remove meaningless judgment of count in some inline functions in #3.
> - Add more information into commit messages of #3 and #5.
> 
> Xi Wang (4):
>   RDMA/hns: Optimize PBL buffer allocation process
>   RDMA/hns: Remove unused MTT functions
>   RDMA/hns: Optimize WQE buffer size calculating process
>   RDMA/hns: Optimize SRQ buffer size calculating process
> 
> Yixian Liu (1):
>   RDMA/hns: Move SRQ code to the reasonable place
> 
>  drivers/infiniband/hw/hns/hns_roce_alloc.c  |   43 -
>  drivers/infiniband/hw/hns/hns_roce_device.h |  110 +--
>  drivers/infiniband/hw/hns/hns_roce_hem.c    |  105 ---
>  drivers/infiniband/hw/hns/hns_roce_hem.h    |    6 -
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |   45 +-
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  943 ++++++++++----------
>  drivers/infiniband/hw/hns/hns_roce_main.c   |   70 +-
>  drivers/infiniband/hw/hns/hns_roce_mr.c     | 1247 +++------------------------
>  drivers/infiniband/hw/hns/hns_roce_qp.c     |  313 +++----
>  drivers/infiniband/hw/hns/hns_roce_srq.c    |   16 +-
>  10 files changed, 767 insertions(+), 2131 deletions(-)

Good diffstat there..

Applied to for-next

Thanks,
Jason
