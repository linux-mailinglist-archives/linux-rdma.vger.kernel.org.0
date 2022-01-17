Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1F8490B3F
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jan 2022 16:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbiAQPPN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Jan 2022 10:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240385AbiAQPPM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Jan 2022 10:15:12 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B848C06161C
        for <linux-rdma@vger.kernel.org>; Mon, 17 Jan 2022 07:15:12 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id h15so15081524qtx.0
        for <linux-rdma@vger.kernel.org>; Mon, 17 Jan 2022 07:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vUlZkWsWLJnDypImpukWxrsz7vz7nBBsb+zvb/0ugXg=;
        b=H3bVBSKhMvNqq6uKvpCQWeFcBCw/L0SuQ8Y+z2HQRyk72+/7PbB6tabIP0v2UuXqPD
         bNIru04cDxOiPmQ+txpJ8nVBs33dbtwt43jo6UzZQhN4+srbz8Q7iW+j627aGsYtFLqV
         /IeQ0c2ZVj0qqCIv1uaL3DuFy1Y53BN3SndoGu3drXOhnDj/f0HBszUuc2PnmWWKIWRa
         AdXMwAcaqehUHOZKVuJXIWYTqEeYmPsGlkhRrI9BkDbqJHwDqbjamaG834uTB8RuUyKP
         OHCZiNoCC8ha95+epoYYLO/ejUXWwOCLEa+QdnMSiqlQ25tg5kVApI0pfSoq14zYnWxI
         0AxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vUlZkWsWLJnDypImpukWxrsz7vz7nBBsb+zvb/0ugXg=;
        b=P3wB7gv8L1X4dmaZbpKrQcsF/Sy7yHB9pHPv3yowkql5YnvFG3016OizIFxpOeXcc+
         CgjnRAi8vPGRjKcguK+bwddDBqCX0U8o3637+L1yva2huVUhPe8EydDrZZAisftEuhlr
         BGNVINvxpVW5aGA+pc1/a+LARO5IB9yde+n/rAiLTZPbE09VI41qTJi4VzTPGoSqBC2A
         doHda3Yitw/OfnTEqtmPdscrY1k4yAhzTsM/6ZADDp6Wo95xdN+suWg0qx8IcBD6kzBy
         DImU+Yeh1UqQg+extqTArc8IzgyC06ETc9MRgG3/xHdueHRxnq7aWzjEgodAzGOBlOi7
         SnhQ==
X-Gm-Message-State: AOAM532HzFyDQSRM6MhiALCs+hizU/CBLoYzuxgxDwP8k12dHiN0k9eO
        jmx/3UxIs05YWZV3H6goioTBGA==
X-Google-Smtp-Source: ABdhPJzppdfjyGm+RGEXf0MMnfLJKNmptkfdCZt19xITeePb6UVxf+57iWwrvrQd7pr94LvRzEFu4Q==
X-Received: by 2002:ac8:4e50:: with SMTP id e16mr8171494qtw.211.1642432511687;
        Mon, 17 Jan 2022 07:15:11 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id z11sm1302695qta.1.2022.01.17.07.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 07:15:11 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1n9Tiw-000MSj-51; Mon, 17 Jan 2022 11:15:10 -0400
Date:   Mon, 17 Jan 2022 11:15:10 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com
Subject: Re: [PATCH rdma-next v2 07/11] RDMA/erdma: Add verbs implementation
Message-ID: <20220117151510.GC8034@ziepe.ca>
References: <20220117084828.80638-1-chengyou@linux.alibaba.com>
 <20220117084828.80638-8-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220117084828.80638-8-chengyou@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 17, 2022 at 04:48:24PM +0800, Cheng Xu wrote:

> +	entry = to_emmap(rdma_entry);
> +
> +	switch (entry->mmap_flag) {
> +	case ERDMA_MMAP_IO_NC:
> +		/* map doorbell. */
> +		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);

This should be pgprot_device()

> +		err = io_remap_pfn_range(vma, vma->vm_start, PFN_DOWN(entry->address),
> +			PAGE_SIZE, vma->vm_page_prot);
> +		break;
> +	default:
> +		pr_err("mmap failed, mmap_flag = %d\n", entry->mmap_flag);

Audit this whole driver for prints:
 1) Do not ever print on user spcae triggered paths, like this
 2) Always use ibdev_dbg/err/etc

> +void erdma_disassociate_ucontext(struct ib_ucontext *ibcontext)
> +{
> +}

Does the driver really fully support device disassociation, including
support to recover from itin rdma-core? Don't define this function otherwise.

Jason
