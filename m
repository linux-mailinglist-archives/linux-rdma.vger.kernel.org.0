Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC5413704C
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jan 2020 15:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbgAJOzB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 10 Jan 2020 09:55:01 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:38551 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728422AbgAJOzA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 10 Jan 2020 09:55:00 -0500
Received: by mail-qv1-f68.google.com with SMTP id t6so843899qvs.5
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jan 2020 06:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eqdBuQMonbSxQiNFPL1SEvEnhOLoHtuuNgfQWPDo/eY=;
        b=DaSw8QjSbZBiFhOSj0lsT4/B6aeQ65sfbPvjsLxsO7tRw14mOj4woO0/f1XzLbeoQi
         9rLGZJwWjQtSUN4bqiDY49jfxEGmyHTPpGDdOYRRuVCcAiRdI23BWgKtYxsw35oTkRYn
         naqgETboK9D3Wp/9CwvsDp6v+HaFMg5k5Rj/EyTSkEmvbVr/Zy67SAKOtE35+Uhc3VPD
         SzGjV0wmueHeOqfYgAycngz4QKaLKogEurt0kDof0redO7ajjd5yel14+a8r9xyxUrSy
         bDvf3LHAC502b0xuzjt9FbEELkkNwep7GiP2goew3ayJfwbd6GQJjD96cZwu4dr3gZ6g
         j6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eqdBuQMonbSxQiNFPL1SEvEnhOLoHtuuNgfQWPDo/eY=;
        b=M8JC1Y+Uqc2IyLIyZp04t6JOTbZy9j5E8VRa79VjUlItK+e6QkLoGWw20sVZiAdkhM
         kkJ7l1wWrdGRu7FUMBCV4pXWIn8H2vo4XZGZEppnzrkx4vSVtEVSu02aEguqfb2mzgPr
         Cqj/y37nkxmGpXVdT/Q7Z/i58ko9R71pK8vwXwQPattel9tLvj2t6agmQG9CUsoAnVFR
         HAqtBzpdbbnGV9LrVMOoaYEkah+VkbPBvys4Q/BG01IWaBkUMh+Ehy50Ni7SHX51EXGG
         TtCTOKKIMSjXFUK/FEGNYvKRGu9bENdwq3JMKLV0ZrrtVs1t4NP3N4b6g4xp0q3KFRRc
         Dl9A==
X-Gm-Message-State: APjAAAXg4QMivieTS32nUzgrzijmyaRFGPnG83MkqOy94L/uesU5nNIo
        NnWAn9QkINzOwolE9avRf+2mwQ==
X-Google-Smtp-Source: APXvYqwhYDIEvu0BaV6KPIwfxOTx00CqmxIr5R6XwDOSPQD3PdF7/o24+sjozgpCJmD/xfLS1PoABQ==
X-Received: by 2002:a0c:c24f:: with SMTP id w15mr3188012qvh.66.1578668099296;
        Fri, 10 Jan 2020 06:54:59 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id x3sm1105355qts.35.2020.01.10.06.54.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Jan 2020 06:54:58 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1ipvgg-0004d1-C6; Fri, 10 Jan 2020 10:54:58 -0400
Date:   Fri, 10 Jan 2020 10:54:58 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Yishai Hadas <yishaih@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, dledford@redhat.com,
        maorg@mellanox.com, michaelgur@mellanox.com
Subject: Re: [PATCH rdma-next 11/14] RDMA/core: Fix locking in
 ib_uverbs_event_read
Message-ID: <20200110145458.GA17728@ziepe.ca>
References: <1578504126-9400-1-git-send-email-yishaih@mellanox.com>
 <1578504126-9400-12-git-send-email-yishaih@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578504126-9400-12-git-send-email-yishaih@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 08, 2020 at 07:22:03PM +0200, Yishai Hadas wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> This should not be using ib_dev to test for disassociation, during
> disassociation is_closed is set under lock and the waitq is triggered.
> 
> Instead check is_closed and be sure to re-obtain the lock to test the
> value after the wait_event returns.
> 
> Fixes: 036b10635739 ("IB/uverbs: Enable device removal when there are active user space applications")
> Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  drivers/infiniband/core/uverbs_main.c | 32 ++++++++++++++------------------
>  1 file changed, 14 insertions(+), 18 deletions(-)

Applied to for-next instead of the version from Hakon

Jason
