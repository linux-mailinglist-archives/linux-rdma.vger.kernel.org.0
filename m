Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819EB4674A4
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Dec 2021 11:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379817AbhLCKWc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Dec 2021 05:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379807AbhLCKWc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Dec 2021 05:22:32 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5EDC06173E
        for <linux-rdma@vger.kernel.org>; Fri,  3 Dec 2021 02:19:08 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so4798348pja.1
        for <linux-rdma@vger.kernel.org>; Fri, 03 Dec 2021 02:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s2yls2b7iJS2EwDbhg02BaCZBKZhPk59/cyyu5iz39Q=;
        b=hcHOFlmz5pV9jJev/RycXOZgb9ZGzMt1b1V7t8wuGmIO2IOP4V5OUOesXdW/tSF2cM
         d54ofGlgUh+Gxq455j6JPnsq5MTozpB2ayj37kDpUY87GgHGal4Z88hSvLcJEyyX+/3a
         /f/F31b7KJI1gls71RlBSPvgNFVL4ef8847IORwLV9K24OwS/IX5PfLGn/jNHhHcwqK/
         NkTZc+FrWKNAwP/1idVadq5GcLJqd2tarplcWK4zOfKvyWYdYBLzgB5Wb/nts+hwHmiq
         7OJ+0JMRoSToteTwLYhKP0bwB4AHCh8G4GPHcgcnQim+LVRCqm0Ewm29DinSveZbEP4P
         dvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s2yls2b7iJS2EwDbhg02BaCZBKZhPk59/cyyu5iz39Q=;
        b=E3is8UC2LTrbKtciVO5U8/rfDvuk4VVZCCwIoQMJ+Q4QIshJRVwdU2QZ0Ilmn5mE/o
         mBHvGmrDCWhGq+a5Gia0IS2y0+f+th2WajikRmzttfIAMnA/RXYHNzJSqIAs/OaXDTsS
         mDjLzqwny59hZ8tBfeF8mp/U56V+obVbVfIJx0Bnjuqqrb4QsMyHagp7QRjrCEARBbri
         cQTZw3NoHj8ZgTPtrvYhk3zwVoAFGW95kAXDMi9zrb0XluN1BXWrtJx59d3YvF5mjKtm
         z+Lmo/OFuPHZHtjg9PbOY9J+QEWnBrDEUYSJE1xh/t+FAyAbNHz6Ziyj1E6jtPjFgB5o
         AXeg==
X-Gm-Message-State: AOAM532zHlMPjriLLf8ohmvsjDeJxt+xM+SpidhntzncGO2hJoJldb9x
        h9VAMl/OiXjfsmYATHMbt1afD9WV7fOwkw==
X-Google-Smtp-Source: ABdhPJwl0s5np06XQxBcNTloezwGcWXdwDYqHZyxRPIarDeT1Qy64gSTRrkZ4Z6zjJ3D02OwWGfoug==
X-Received: by 2002:a17:902:b20b:b0:141:a92c:a958 with SMTP id t11-20020a170902b20b00b00141a92ca958mr21902161plr.24.1638526747845;
        Fri, 03 Dec 2021 02:19:07 -0800 (PST)
Received: from baohua-VirtualBox.localdomain (47-72-151-34.dsl.dyn.ihug.co.nz. [47.72.151.34])
        by smtp.gmail.com with ESMTPSA id c5sm1869487pjm.52.2021.12.03.02.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 02:19:07 -0800 (PST)
From:   Barry Song <21cnbao@gmail.com>
To:     liangwenpeng@huawei.com
Cc:     jgg@nvidia.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v5 for-next 1/1] RDMA/hns: Support direct wqe of userspace'
Date:   Fri,  3 Dec 2021 18:18:55 +0800
Message-Id: <20211203101855.12598-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211130135740.4559-2-liangwenpeng@huawei.com>
References: <20211130135740.4559-2-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> +	switch (entry->mmap_type) {
> +	case HNS_ROCE_MMAP_TYPE_DB:
> +		prot = pgprot_noncached(vma->vm_page_prot);
> +		break;
> +	case HNS_ROCE_MMAP_TYPE_TPTR:
> +		prot = vma->vm_page_prot;
> +		break;
> +	/*
> +	 * The BAR region of direct WQE supports Early Write Ack,
> +	 * so pgprot_device is used to improve performance.
> +	 */
> +	case HNS_ROCE_MMAP_TYPE_DWQE:
> +		prot = pgprot_device(vma->vm_page_prot);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

i am still not convinced why HNS_ROCE_MMAP_TYPE_DB needs nocache and HNS_ROCE_MMAP_TYPE_DWQE needs
device. generally people use ioremap() to map pci bar spaces in pci device drivers, and ioremap()
is pretty much nGnRE:
#define ioremap(addr, size)             __ioremap((addr), (size), __pgprot(PROT_DEVICE_nGnRE))
#define ioremap_np(addr, size)          __ioremap((addr), (size), __pgprot(PROT_DEVICE_nGnRnE))

i am only seeing four places which are using nE in kernel:
   #   line  filename / context / line
   1    866  drivers/of/address.c <<of_iomap>>
             return ioremap_np(res.start, resource_size(&res));
   2    901  drivers/of/address.c <<of_io_request_and_map>>
             mem = ioremap_np(res.start, resource_size(&res));
   3     89  include/linux/io.h <<pci_remap_cfgspace>>
             return ioremap_np(offset, size) ?: ioremap(offset, size);
   4     47  lib/devres.c <<__devm_ioremap>>
             addr = ioremap_np(offset, size);

so i guess nGnRE is quite safe for pci device bar spaces. for config space, it is a different story
though which is the 3rd one in the above list:

#ifdef CONFIG_PCI
/*
 * The PCI specifications (Rev 3.0, 3.2.5 "Transaction Ordering and
 * Posting") mandate non-posted configuration transactions. This default
 * implementation attempts to use the ioremap_np() API to provide this
 * on arches that support it, and falls back to ioremap() on those that
 * don't. Overriding this function is deprecated; arches that properly
 * support non-posted accesses should implement ioremap_np() instead, which
 * this default implementation can then use to return mappings compliant with
 * the PCI specification.
 */
#ifndef pci_remap_cfgspace
#define pci_remap_cfgspace pci_remap_cfgspace
static inline void __iomem *pci_remap_cfgspace(phys_addr_t offset,
                                               size_t size)
{
        return ioremap_np(offset, size) ?: ioremap(offset, size);
}
#endif
#endif

Thanks
Barry

