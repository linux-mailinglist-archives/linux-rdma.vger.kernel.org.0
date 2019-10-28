Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13A80E79BB
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 21:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbfJ1UKs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 16:10:48 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35858 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbfJ1UKs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Oct 2019 16:10:48 -0400
Received: by mail-qk1-f195.google.com with SMTP id y189so9776383qkc.3
        for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2019 13:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H/THPQGyz40LBFYEHcweT4lmD8Nqu8ZrqzmWM4HcCKs=;
        b=Q6k/mUFVxOBv3aTuq8oo7JDrjEauKE9HcDgFt84omZdU9K/XVboyEcdOWxaTkCBJ28
         h0r5uedPPYCRhOvIEi8rMBg+LxDQ1kJy7G2KvTYOl8k1ftSUoOMiMEEi9CN59pf6OuOz
         MkDtPlTPswGrs8e2T9pzn8MdFhY0MZ1R+E+e8/2U9m/8aBR9ebJ0DsvWpb0j8hwE9f1i
         UuJJWkpCmSjN3VETuju98bl50r4w0WLDME6cbun6/34JTiAY6IEaZyv4ggnF2jWvcBtU
         qyxdFQalzd9YBNgYiQZmA0WiFjG+it9BlIMayLu3aVh2wFRpwpxXSydrKKoYGdfkI+Dw
         /p1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H/THPQGyz40LBFYEHcweT4lmD8Nqu8ZrqzmWM4HcCKs=;
        b=URxecmBwNWe+84jc3BMOk0wsHmBRIwIc2uPrneE7kjIlMLXswinr5cZk65ki8UzLaG
         H9cNy/mtA1eFLPwGtxr+6SsLbwtc+0ekv9rlKiiohk+zA5xJKdKLBesUTrx+mleT13iw
         R+eIZ2Wd8TVrDefNe9jC8xNezwJy8l+SyWs5+RMk5XFEOMMeVgeKP30JH2zbpyQ9A9hz
         KJ20ZaTjaF/5SeuY6Hn7gOzv08RC3nJ/T+Aw4j9Q9IL36+Pto31K24bDk3GlJP+jm+ZL
         ItyS2xlclwJN49sMyHyuExXaAqS04Fc/RjHaOXtDXj2EA1BassRDJ8P9P6dVHXNGZW5l
         5NDQ==
X-Gm-Message-State: APjAAAXiqxjpcYBJi89JgTVtJKMgbJTugq7ajffA61J1+/Kt5XQ2kBBs
        2I61EswbtJp/m8MqjEK5XRC5Tg==
X-Google-Smtp-Source: APXvYqxsKzO+DlZf4GHZfVwOfUDUz0csib+6zwvHr9p6l/rK8t+hVqnPNQxoUohuqD3TYtVARBRFtg==
X-Received: by 2002:a05:620a:1410:: with SMTP id d16mr14987766qkj.284.1572293447562;
        Mon, 28 Oct 2019 13:10:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id q44sm8677492qtk.16.2019.10.28.13.10.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Oct 2019 13:10:43 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iPBLf-0001gk-DA; Mon, 28 Oct 2019 17:10:43 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-mm@kvack.org, Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Petr Cvek <petrcvekcz@gmail.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        nouveau@lists.freedesktop.org, xen-devel@lists.xenproject.org,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH v2 08/15] xen/gntdev: Use select for DMA_SHARED_BUFFER
Date:   Mon, 28 Oct 2019 17:10:25 -0300
Message-Id: <20191028201032.6352-9-jgg@ziepe.ca>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191028201032.6352-1-jgg@ziepe.ca>
References: <20191028201032.6352-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

DMA_SHARED_BUFFER can not be enabled by the user (it represents a library
set in the kernel). The kconfig convention is to use select for such
symbols so they are turned on implicitly when the user enables a kconfig
that needs them.

Otherwise the XEN_GNTDEV_DMABUF kconfig is overly difficult to enable.

Fixes: 932d6562179e ("xen/gntdev: Add initial support for dma-buf UAPI")
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: xen-devel@lists.xenproject.org
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Reviewed-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/xen/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index 79cc75096f4232..a50dadd0109336 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -141,7 +141,8 @@ config XEN_GNTDEV
 
 config XEN_GNTDEV_DMABUF
 	bool "Add support for dma-buf grant access device driver extension"
-	depends on XEN_GNTDEV && XEN_GRANT_DMA_ALLOC && DMA_SHARED_BUFFER
+	depends on XEN_GNTDEV && XEN_GRANT_DMA_ALLOC
+	select DMA_SHARED_BUFFER
 	help
 	  Allows userspace processes and kernel modules to use Xen backed
 	  dma-buf implementation. With this extension grant references to
-- 
2.23.0

