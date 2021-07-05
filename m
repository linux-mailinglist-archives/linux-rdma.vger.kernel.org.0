Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D035D3BC1CF
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Jul 2021 18:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbhGEQzJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Jul 2021 12:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhGEQzG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Jul 2021 12:55:06 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9BBC061574
        for <linux-rdma@vger.kernel.org>; Mon,  5 Jul 2021 09:52:28 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id m13so3993230qvv.11
        for <linux-rdma@vger.kernel.org>; Mon, 05 Jul 2021 09:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TRW2liv0KvxRpEn1sZgxByQ6WPmBTh1GhCnSHVjnwbg=;
        b=jBFIqWpkHJUwhFRIEXpavqYg2lOBnFUgtfMCAa51Keo5p1e7uaLLRwx5ShUDeIlhdM
         2If2zjmjcfC5T6RoGkkweicUk3Qsx+2vRdseYI/0mJ+ciw96iBmUkpkVkiJE+86t8cyr
         2oJc7CwvfA5oUIWZzMzGPAFug62Z67fj3p3Z3WgSBFHsqz4/BWGoOCucw+iLuagpvAH1
         PpbSwCitf8MOcMx6/0YLotNGXe8rFb+KOw2NMKF5n5y/HAuQN75chVqThR99yPOEQKYA
         xDWvGJSbbwBNR2Hg29azK+xEHKNYDfvZIIv02WRktmpruBPJPenBbq+963N6aPphnsv4
         Bn7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TRW2liv0KvxRpEn1sZgxByQ6WPmBTh1GhCnSHVjnwbg=;
        b=GFitgwdX1GA5t7t2hIdzwI106pqx2FTh4iM9KW7CF/83baAwSBn1Tx6g4NFJ676UuC
         sNK34XR9Rf9doJDSp1krBIo7n29K1Wg7LRu9rMF9m+X+17/+yXvtepU9GbEZoyBNpkng
         sn8qXg91M4EIqzuvyb/JEXtC4Y0/0NU2bq/wvTmydFal/m6nrZWhGCjPNso92ASR2u6N
         dOiIYR8YlRQMrO0B25A/VNW8x8I0V/yBYirrgcSex5br5IrPW8Cx38ZahBgi9JYhb6tW
         QDvQlAqyJmgCwI2EXq/wu2/HPRQjbkCuOCJn4BrJFNOACRhDFqvpCQnXY0IGjIS/08U5
         Xndg==
X-Gm-Message-State: AOAM5306AfRbddHpNcxjICd3en4c/PWFYFzzEnTMoBOmQnkmTM1o954f
        ICBERmjlgUKZvPFWjjlzh7madQ==
X-Google-Smtp-Source: ABdhPJw/xzr3myWPCDkP4OYKH+JUqyzPcaaW7tJ0//CdDzso+M0bp2m0674/I/B/gC+TTQwFiqkSng==
X-Received: by 2002:a0c:ef51:: with SMTP id t17mr13560008qvs.14.1625503947734;
        Mon, 05 Jul 2021 09:52:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.113.94])
        by smtp.gmail.com with ESMTPSA id 82sm5694070qke.63.2021.07.05.09.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 09:52:27 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1m0Rpa-003sCS-IC; Mon, 05 Jul 2021 13:52:26 -0300
Date:   Mon, 5 Jul 2021 13:52:26 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        daniel.vetter@ffwll.ch, galpress@amazon.com, sleybo@amazon.com,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, dledford@redhat.com,
        airlied@gmail.com, alexander.deucher@amd.com, leonro@nvidia.com,
        hch@lst.de, amd-gfx@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, Tomer Tayar <ttayar@habana.ai>
Subject: Re: [PATCH v4 2/2] habanalabs: add support for dma-buf exporter
Message-ID: <20210705165226.GJ4604@ziepe.ca>
References: <20210705130314.11519-1-ogabbay@kernel.org>
 <20210705130314.11519-3-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705130314.11519-3-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 05, 2021 at 04:03:14PM +0300, Oded Gabbay wrote:

> +	rc = sg_alloc_table(*sgt, nents, GFP_KERNEL | __GFP_ZERO);
> +	if (rc)
> +		goto error_free;

If you are not going to include a CPU list then I suggest setting
sg_table->orig_nents == 0

And using only the nents which is the length of the DMA list.

At least it gives some hope that other parts of the system could
detect this.

> +
> +	/* Merge pages and put them into the scatterlist */
> +	cur_page = 0;
> +	for_each_sgtable_sg((*sgt), sg, i) {

for_each_sgtable_sg should never be used when working with
sg_dma_address() type stuff, here and everywhere else. The DMA list
should be iterated using the for_each_sgtable_dma_sg() macro.

> +	/* In case we got a large memory area to export, we need to divide it
> +	 * to smaller areas because each entry in the dmabuf sgt can only
> +	 * describe unsigned int.
> +	 */

Huh? This is forming a SGL, it should follow the SGL rules which means
you have to fragment based on the dma_get_max_seg_size() of the
importer device.

> +	hl_dmabuf->pages = kcalloc(hl_dmabuf->npages, sizeof(*hl_dmabuf->pages),
> +								GFP_KERNEL);
> +	if (!hl_dmabuf->pages) {
> +		rc = -ENOMEM;
> +		goto err_free_dmabuf_wrapper;
> +	}

Why not just create the SGL directly? Is there a reason it needs to
make a page list?

Jason
