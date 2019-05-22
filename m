Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC74269DC
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2019 20:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbfEVScG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 May 2019 14:32:06 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39003 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729005AbfEVScF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 May 2019 14:32:05 -0400
Received: by mail-qt1-f196.google.com with SMTP id y42so3604864qtk.6
        for <linux-rdma@vger.kernel.org>; Wed, 22 May 2019 11:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=CaDjZ/LTZEWIV1k6jmaoesTLyIfde7eaoYVq6F0BEbE=;
        b=DOYEYXNFXZtj3Fxv6GkbcrmxU5qsq07byb5Z/nKMwy5d7BkU/5zXVjPqNAaD0l6xyH
         xlB+AdtKp1epaSxw5VkAKq4S8M3K7YgmevLZSH75UeUvXXQlWK90b5D/k+Nvf6ZKGqXj
         TWtBp1hiphibJFzUinRHHxjMNpCRyVDdIkY+DSX07WsbkGoHGI2pLPzK4+CAvsrMzAEx
         A30oAnOWmiUTpX+/9fNvXkEEyo1w3wikiXyWNCGgaJs+rdfODCsZexTq0hyq5k9GrnTa
         75hribAj3aj4O1x0Zhj+2Q/GjAJBxqGS0eU9LrDXGTcw9licqCzF5A1gt0CFtCJ74HM4
         1gSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CaDjZ/LTZEWIV1k6jmaoesTLyIfde7eaoYVq6F0BEbE=;
        b=qQ8SwhLXB2lR9Ijtd/lc91m/aqff2pXtn/OUB0PsXZdVByVUrryJ+AnuFCe9Sf62gT
         69ZSAes0S9dZ0HfgsrytcKnYQOmf2g6Wsck8AdvHEsc+K5n6/DmWzt3GPlMgd8N4LYOr
         tntjuK1UQQgSUwICa8O0ow8B1176zaM30LotMd+4s77c5eajjklkicjyBsDzvYAYSjjY
         pAqAe1qYKSU+C6HT2cmPr0zRb/kUeEVh4A+/jgGV3iEXY1Pa6x8E7XX5u3KJWQslz4TJ
         Oi8FiwoA2Hw7ttx+1/JOFTkJ833nu6dIfxO5yXYl4qR9CRa1g9nLw+31Kqy4c6ZOEEY/
         WwTQ==
X-Gm-Message-State: APjAAAXx1DFQUyBmFqGSnPhp+ZNGncOC3mx2CVxRuK02BRrdLTf36tvN
        Jsx4IjJJ4CtD8Y6C1pXKJ1veiQ==
X-Google-Smtp-Source: APXvYqzf05Cgzli4/sO/d45KwJM6VGf3KpJ+mO5Il0PMQODrgkuDAUi8F/XB67dWwlfl0xja9rPWRw==
X-Received: by 2002:ac8:18c2:: with SMTP id o2mr77676877qtk.165.1558549924824;
        Wed, 22 May 2019 11:32:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id g12sm11725833qkk.88.2019.05.22.11.32.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 11:32:04 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hTW1z-0005Gd-IY; Wed, 22 May 2019 15:32:03 -0300
Date:   Wed, 22 May 2019 15:32:03 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
Subject: Re: [PATCH v4 0/1] Use HMM for ODP v4
Message-ID: <20190522183203.GE6054@ziepe.ca>
References: <20190411181314.19465-1-jglisse@redhat.com>
 <20190506195657.GA30261@ziepe.ca>
 <20190521205321.GC3331@redhat.com>
 <20190522005225.GA30819@ziepe.ca>
 <20190522174852.GA23038@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190522174852.GA23038@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 22, 2019 at 01:48:52PM -0400, Jerome Glisse wrote:

> From 0b429b2ffbec348e283693cb97d7ffce760d89da Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>
> Date: Sat, 8 Dec 2018 15:47:55 -0500
> Subject: [PATCH] RDMA/odp: convert to use HMM for ODP v5
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Convert ODP to use HMM so that we can build on common infrastructure
> for different class of devices that want to mirror a process address
> space into a device. There is no functional changes.
> 
> Changes since v4:
>     - Rebase on top of rdma-next
> Changes since v3:
>     - Rebase on top of 5.2-rc1
> Changes since v2:
>     - Update to match changes to HMM API
> Changes since v1:
>     - improved comments
>     - simplified page alignment computation
> 
> Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> Cc: Leon Romanovsky <leonro@mellanox.com>
> Cc: Doug Ledford <dledford@redhat.com>
> Cc: Artemy Kovalyov <artemyko@mellanox.com>
> Cc: Moni Shoua <monis@mellanox.com>
> Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
> Cc: Kaike Wan <kaike.wan@intel.com>
> Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>
>  drivers/infiniband/core/umem_odp.c | 506 +++++++++--------------------
>  drivers/infiniband/hw/mlx5/mem.c   |  20 +-
>  drivers/infiniband/hw/mlx5/mr.c    |   2 +-
>  drivers/infiniband/hw/mlx5/odp.c   | 104 +++---
>  include/rdma/ib_umem_odp.h         |  47 +--
>  5 files changed, 233 insertions(+), 446 deletions(-)

The kconfig stuff is missing, and it doesn't compile in various cases
I tried.

The kconfig stuff for hmm is also really obnoxious, you can't just
enabe HMM_MIRROR, you have to track down all the little required
elements to get it to turn on..

Once I did get it to compile, I also get warnings:

mm/hmm.c: In function ‘hmm_vma_walk_pud’:
mm/hmm.c:782:28: warning: unused variable ‘pfn’ [-Wunused-variable]
   unsigned long i, npages, pfn;
                            ^~~
mm/hmm.c: In function ‘hmm_range_snapshot’:
mm/hmm.c:1027:19: warning: unused variable ‘h’ [-Wunused-variable]
    struct hstate *h = hstate_vma(vma);

Because this kernel doesn't have CONFIG_HUGETLB_PAGE

Please fold this into your patch if it has to be resent.. I think it
fixes the compilation problems.

diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index cbfbea49f126cd..e3eefd0917985a 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -63,7 +63,7 @@ config INFINIBAND_USER_MEM
 config INFINIBAND_ON_DEMAND_PAGING
 	bool "InfiniBand on-demand paging support"
 	depends on INFINIBAND_USER_MEM
-	select MMU_NOTIFIER
+	depends on HMM_MIRROR
 	default y
 	---help---
 	  On demand paging support for the InfiniBand subsystem.
diff --git a/include/rdma/ib_umem_odp.h b/include/rdma/ib_umem_odp.h
index e1476e9ebb7906..f760103c07349a 100644
--- a/include/rdma/ib_umem_odp.h
+++ b/include/rdma/ib_umem_odp.h
@@ -115,6 +115,16 @@ static inline size_t ib_umem_odp_num_pages(struct ib_umem_odp *umem_odp)
 
 #define ODP_DMA_ADDR_MASK (~(ODP_READ_ALLOWED_BIT | ODP_WRITE_ALLOWED_BIT))
 
+#define ODP_READ_BIT	(1<<0ULL)
+#define ODP_WRITE_BIT	(1<<1ULL)
+/*
+ * The device bit is not use by ODP but is there to full-fill HMM API which
+ * also support device with device memory (like GPU). So from ODP/RDMA POV
+ * this can be ignored.
+ */
+#define ODP_DEVICE_BIT	(1<<2ULL)
+#define ODP_FLAGS_BITS	3
+
 #ifdef CONFIG_INFINIBAND_ON_DEMAND_PAGING
 
 struct ib_ucontext_per_mm {
@@ -138,16 +148,6 @@ struct ib_umem_odp *ib_alloc_odp_umem(struct ib_umem_odp *root_umem,
 				      unsigned long addr, size_t size);
 void ib_umem_odp_release(struct ib_umem_odp *umem_odp);
 
-#define ODP_READ_BIT	(1<<0ULL)
-#define ODP_WRITE_BIT	(1<<1ULL)
-/*
- * The device bit is not use by ODP but is there to full-fill HMM API which
- * also support device with device memory (like GPU). So from ODP/RDMA POV
- * this can be ignored.
- */
-#define ODP_DEVICE_BIT	(1<<2ULL)
-#define ODP_FLAGS_BITS	3
-
 long ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp,
 			       struct hmm_range *range);
 
