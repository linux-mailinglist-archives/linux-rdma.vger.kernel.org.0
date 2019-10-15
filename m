Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1A0D7E9A
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Oct 2019 20:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730499AbfJOSQR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Oct 2019 14:16:17 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34285 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbfJOSQR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Oct 2019 14:16:17 -0400
Received: by mail-io1-f66.google.com with SMTP id q1so48260488ion.1
        for <linux-rdma@vger.kernel.org>; Tue, 15 Oct 2019 11:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E5hGScokWqPgLdbBrk4RHza3Svxdrvt3RelMxzxNGX0=;
        b=IY7PaWcEoDxVF3RjzcFddJeqHnKCTQPHXfIpy/ZpttwuBMU0ukD62rv6NJn+q87jla
         IXutZA2u26Vor+s0oQSuxsRNrCPfLDsESVJ589Opd1LZ0R+URK4YBD+kFwmLrLBoPU6/
         QrUUkUIpST04E4tqDxJ+Jk1U4drJBIlnSZxYI4Bl4QDVhl0PK2MSM5oGR/kUL3z3tNDu
         6o4NOh44rhJyXMoM/uAh1nLdvonpdj8vdasf+naCfwSj0CId6hBhiy07gmILqk/KgFay
         UnZ7D83P4q5IJpWb+fT+I50stolQCQKdlumEuIxFdDr35X2DLJl56axpTHUNubqqx/HW
         iEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E5hGScokWqPgLdbBrk4RHza3Svxdrvt3RelMxzxNGX0=;
        b=K0Mtm2dbfadXiBBRYoMrIeik65mxu7ZR8fICxYei1GK/PMloCMHrxpRAlhUtLA+BEh
         edlkGopFIVjG/XNzJe0r341/GTcjBLb1oyCeE9tZ3RC9NoMEGywkEi1LgeEw2hshfN6V
         xwt5L6FxW25vLNds9vJ9kU8c1HLXkp6uXymn4aZjFElq0P0dC5/wEFoDuGFqiIHDVavC
         9iXbYRTm4ht01jYDpTBGqGVTKlIcmq7997mEfnu92NLzTHH084zOm/J+J/hEay5T10eC
         o+bHBMsH5HLSlAlp/7ZxvfahwAf7KmRbn8k6Nv6BOJaJwwI8G+9fgJ3KJX75nuxXLqew
         R7AA==
X-Gm-Message-State: APjAAAVsZp5DMUd56onyiXiE49n+1Tgavva+2Bi0K5YpDYSASSsHEPqb
        IOgV9ggg3fRu5ASnvxbF3MOQIA==
X-Google-Smtp-Source: APXvYqwCqiYZ3SkEMQblXOUCwi4JhQL5teRlUkU0KcRoGUDDLgO1heLLmHRP1RmYbHcG9FHn93aEFA==
X-Received: by 2002:a92:5a9b:: with SMTP id b27mr7441321ilg.180.1571163376436;
        Tue, 15 Oct 2019 11:16:16 -0700 (PDT)
Received: from ziepe.ca ([24.114.26.129])
        by smtp.gmail.com with ESMTPSA id b3sm2941671iln.42.2019.10.15.11.16.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Oct 2019 11:16:16 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iKRJT-0002CL-IH; Tue, 15 Oct 2019 15:12:51 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH hmm 08/15] xen/gntdev: Use select for DMA_SHARED_BUFFER
Date:   Tue, 15 Oct 2019 15:12:35 -0300
Message-Id: <20191015181242.8343-9-jgg@ziepe.ca>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015181242.8343-1-jgg@ziepe.ca>
References: <20191015181242.8343-1-jgg@ziepe.ca>
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

