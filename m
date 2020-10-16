Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D45290BFA
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Oct 2020 21:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403884AbgJPTAB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Oct 2020 15:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403821AbgJPTAB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Oct 2020 15:00:01 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B0DC061755
        for <linux-rdma@vger.kernel.org>; Fri, 16 Oct 2020 12:00:01 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id 67so5142762iob.8
        for <linux-rdma@vger.kernel.org>; Fri, 16 Oct 2020 12:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VyUcxuS+q3Ki2t27YEs5CSq4Bu05DRppkqJKzHXj8pU=;
        b=L7QY1qC5KzpxZDrE+afO/LgMISXbMAQNCh4zwIj7g6jORAm/qUibRFTJfy9Bf07qaI
         /01A1J/vBA0e63lBQaWfc4MpcMlvIW3jZLjWDBTzg90RclwyyI/YXg7FXSNZZSIswnC5
         sGMj1RrRyilLtu5/V4nU/BzY6hOETP4AtBYgR5pNecXQuPC2oDl8RjXZEEgy7ZQXMw+Q
         kvQ+pVZJYLKWAEkPiUt6aDxmHm5P8M/8732RkEjsMRLCi9H52Pi/R9a7xiUXnO2ne6KY
         Np0uPLBSA9ho1tZ1e67fLLb72mNdejO5gR++aDcBWl8bpm84W4qb0tGbsb9nrAhLSgsQ
         T9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VyUcxuS+q3Ki2t27YEs5CSq4Bu05DRppkqJKzHXj8pU=;
        b=Z9FVs6ZJ9tXswN2o6Csnh6q2hG0TwANfAPBTMGT9T8qMMOETNweVCvoPqKUkuwDBab
         CaPWxa+R1rLuaqVV+tMISvCXF20nXf4Vt/aNh59A1qx7kDiW6VDB3ynCm0ws6DQUywEh
         W57j53OtYoohVDgofoyAiDN0ioRcb4EXfTICpST0p3BRRqhgkEzK3UC/g73IIY1zNAm0
         K4YQUkctSzqJ4tcWecXh8otuymgll8UlTC0odIhTHa7LPFMtxXOoqQtgE/ohKHr7hmoh
         +BwDn1YEUcdSWXFSqCb0W43Tx3Xnv14Pyy9aEtqkS/FfjPlzdgQlNOhpa+iAuriI2Rks
         LCdg==
X-Gm-Message-State: AOAM5307XjVmReXrDkczOtyyXKtVLVk12OJ0RtwNO0mvlV6SXYO1+2jo
        AkciuwwYhZMitv9CirkLSC1Yp3wf8bEC7Q==
X-Google-Smtp-Source: ABdhPJzP4ehwc/PwReEFNRYC8BtVx3mqVAJi/bP+rFK4edA3NReIwy6akkcy+piEhBU03ujV74RkVA==
X-Received: by 2002:a6b:5019:: with SMTP id e25mr3685801iob.123.1602874800517;
        Fri, 16 Oct 2020 12:00:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id a21sm2710614ioh.12.2020.10.16.11.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 11:59:59 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kTUxL-000yqz-2O; Fri, 16 Oct 2020 15:59:59 -0300
Date:   Fri, 16 Oct 2020 15:59:59 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jianxin Xiong <jianxin.xiong@intel.com>
Cc:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH v5 1/5] RDMA/umem: Support importing dma-buf as user
 memory region
Message-ID: <20201016185959.GC37159@ziepe.ca>
References: <1602799365-138199-1-git-send-email-jianxin.xiong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602799365-138199-1-git-send-email-jianxin.xiong@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 15, 2020 at 03:02:45PM -0700, Jianxin Xiong wrote:

> +static void ib_umem_dmabuf_invalidate_cb(struct dma_buf_attachment *attach)
> +{
> +	struct ib_umem_dmabuf *umem_dmabuf = attach->importer_priv;
> +
> +	dma_resv_assert_held(umem_dmabuf->attach->dmabuf->resv);
> +
> +	ib_umem_dmabuf_unmap_pages(&umem_dmabuf->umem, true);
> +	queue_work(ib_wq, &umem_dmabuf->work);

Do we really want to queue remapping or should it wait until there is
a page fault?

What do GPUs do?

Jason
