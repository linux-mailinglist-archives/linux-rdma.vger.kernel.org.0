Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB21C2A8B25
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Nov 2020 01:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731899AbgKFAIy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Nov 2020 19:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729162AbgKFAIy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Nov 2020 19:08:54 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C52C0613CF
        for <linux-rdma@vger.kernel.org>; Thu,  5 Nov 2020 16:08:53 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id f93so2496617qtb.10
        for <linux-rdma@vger.kernel.org>; Thu, 05 Nov 2020 16:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=78w6rDG7nYDKrfBll/YwQv2rf14yq6PqmoJY+j3GkfA=;
        b=oK9TeFz5Y2+oPNpu4vAkXNsgSeyj4dFFNDSfIlFeLkjR2+rMKoWVaHhcD1jWUep1iU
         O0kqqjjRr96bXm05qChk2aYsIt2gzPYEGmaBvBoI6kqYQ445yCwD5P7a5an/upxNV1de
         BKiubDGb77zjk6a2drr0W4dR7wKqarRg76H2mZLca//OYydPtrnht3n194Lu5XRE+pSF
         cdrnb9BmXRzhDsBMsSqcN2OjLyEVvWpM6dBJ6rhJ1j86CZ8X5ZRe5aaFeagn1H3fBe0a
         /5l8lRf/E4gMmWkyN1ZStf3HRZMEYUjJNBU4Me3bVqYrFht7zNigDLO5YnE9KGOBubHG
         u2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=78w6rDG7nYDKrfBll/YwQv2rf14yq6PqmoJY+j3GkfA=;
        b=qXGncQJWA0BYITpGHEzNGPRmzjO5b3d+Elw6QcRaB9QCBkpLw0qoAPjyZMsp90+Dnv
         iu/7WQYsEK/fUZ3HAMiNB2J2trBeUF0JxnfmsaykrA9CrlxtN5gdVeWvuS6vxaucvVJj
         +6EvPRN5gW6T6uTxDcpY7CeQ47jIkIMhwBh1aPHRRus7Cr6XV5L/JWySJwVlPrVaZljY
         KFdRCMvDTqkBOn1G8g44DaSFxnemNEH77wuKiWvdIv2CJCtRCPxa2mmBczUWOtr0Q+Vn
         IwZTLM77S3QaPyyXAYj6zBSy2cpt4p1A22qKLdeWA28km/mQnccJIDYMR1FY78CQE3gz
         39QA==
X-Gm-Message-State: AOAM532sN8oRjS/d6/sieTn/EbjUTWpGW/TvKpDnYiz3BisfkE+eVuji
        Jg3ffsMwPjrBWPnn/CXJo0vMfQ==
X-Google-Smtp-Source: ABdhPJy+gPuYXCviMw5rApuKiLeVIUfcEAbxylsl1vWQxlZWJBZzVkUWspauEUbEmOu6qlX4ZM956A==
X-Received: by 2002:aed:2843:: with SMTP id r61mr4611334qtd.166.1604621332628;
        Thu, 05 Nov 2020 16:08:52 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id d20sm2167345qkj.49.2020.11.05.16.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 16:08:51 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kapJD-000Yst-1D; Thu, 05 Nov 2020 20:08:51 -0400
Date:   Thu, 5 Nov 2020 20:08:51 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jianxin Xiong <jianxin.xiong@intel.com>
Cc:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH v8 1/5] RDMA/umem: Support importing dma-buf as user
 memory region
Message-ID: <20201106000851.GK36674@ziepe.ca>
References: <1604616489-69267-1-git-send-email-jianxin.xiong@intel.com>
 <1604616489-69267-2-git-send-email-jianxin.xiong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604616489-69267-2-git-send-email-jianxin.xiong@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 05, 2020 at 02:48:05PM -0800, Jianxin Xiong wrote:
> +	/* modify the sgl in-place to match umem address and length */
> +
> +	start = ALIGN_DOWN(umem_dmabuf->umem.address, PAGE_SIZE);
> +	end = ALIGN(umem_dmabuf->umem.address + umem_dmabuf->umem.length,
> +		    PAGE_SIZE);
> +	cur = 0;
> +	nmap = 0;
> +	for_each_sgtable_dma_sg(sgt, sg, i) {
> +		if (cur >= end)
> +			break;
> +		if (cur + sg_dma_len(sg) <= start) {
> +			cur += sg_dma_len(sg);
> +			continue;
> +		}

This seems like a strange way to compute interesections

  if (cur <= start && start < cur + sg_dma_len(sg))

> +		if (cur <= start) {
> +			unsigned long offset = start - cur;
> +
> +			umem_dmabuf->first_sg = sg;
> +			umem_dmabuf->first_sg_offset = offset;
> +			sg_dma_address(sg) += offset;
> +			sg_dma_len(sg) -= offset;
> +			if (&sg_dma_len(sg) != &sg->length)
> +				sg->length -= offset;

We don't need to adjust sg->length, only dma_len, so no reason for
this surprising if.

> +			cur += offset;
> +		}
> +		if (cur + sg_dma_len(sg) >= end) {

Same logic here

> +			unsigned long trim = cur + sg_dma_len(sg) - end;
> +
> +			umem_dmabuf->last_sg = sg;
> +			umem_dmabuf->last_sg_trim = trim;
> +			sg_dma_len(sg) -= trim;
> +			if (&sg_dma_len(sg) != &sg->length)
> +				sg->length -= trim;

break, things are done here

> +		}
> +		cur += sg_dma_len(sg);
> +		nmap++;
> +	}

> +	
> +	umem_dmabuf->umem.sg_head.sgl = umem_dmabuf->first_sg;
> +	umem_dmabuf->umem.sg_head.nents = nmap;
> +	umem_dmabuf->umem.nmap = nmap;
> +	umem_dmabuf->sgt = sgt;
> +
> +	page_size = ib_umem_find_best_pgsz(&umem_dmabuf->umem, PAGE_SIZE,
> +					   umem_dmabuf->umem.iova);
> +
> +	if (WARN_ON(cur != end || page_size != PAGE_SIZE)) {

Looks like nothing prevents this warn on to tigger

The user could specify a length that is beyond
the dma buf, can the dma buf length be checked during get?

Also page_size can be 0 because iova is not OK. iova should be checked
for alignment during get as well:

  iova & (PAGE_SIZE-1) == umem->addr & (PAGE_SIZE-1)

But yes, this is the right idea

Jason
