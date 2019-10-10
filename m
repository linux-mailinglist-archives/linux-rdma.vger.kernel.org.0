Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08E2BD1F3E
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2019 06:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbfJJEJO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Oct 2019 00:09:14 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33724 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727619AbfJJEJN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Oct 2019 00:09:13 -0400
Received: by mail-pg1-f195.google.com with SMTP id i76so2800849pgc.0;
        Wed, 09 Oct 2019 21:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:user-agent:date:from:to:cc:cc:subject:references
         :mime-version:content-disposition;
        bh=Y+FVHOqhUm8QDHHuoPQucpS1KsR9NgT8uPWbfOd7pOo=;
        b=oiehsiEUdKsNnlPntnVez/z1zBPS+nuLR0N7okBvyQV5zz9XMa6lwh3dGZ6Swf+cbE
         phKOZfU24ILgBC6eiOnKyx133K1rHz1jA0ilgmyD/Qtd3zJ0NEXkVC/fo+FxUzCD/kvW
         WpX82CKS7r4nD6a2h6vb7MJP8VQh6u3aXHSEKpyFoLBs+wmK8lqvTgEs8ok8h9lMudJw
         bLeYE5VvVwcbTON1DiH06FIju86hOXKgcXIUP7sZ0/9/CWCMSdeeARm6N0pe1gUnUjaG
         ypNj7dNyNvUcVF/VSybadLIku47pLgmErXZ1j0cgyHxcoDu2ezY3Em6jZT1oYFEVcLOI
         y60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:user-agent:date:from:to:cc:cc:subject
         :references:mime-version:content-disposition;
        bh=Y+FVHOqhUm8QDHHuoPQucpS1KsR9NgT8uPWbfOd7pOo=;
        b=KJORAu6epU+75Qtk1X47euBDjSo4lHb21FwGGHrtDOlGR0nb3PZH1p4AP+hiId1RXh
         P7J/Nff9BNLqOTmdGoRyjxGuXxfZRik0FJwQR9Td2Lc10hCa1t9ZS9s8IW5rMa6dECYi
         G2hgNyY3fJ3QRx+7nMjDJilqIT1tZ1TgheFJBHSz6vRY6rwPdyf7Qi4d5omzt19SF0tQ
         75ZVC3/4w6f1bpcNGymE+Dr3PjzqfSKkVnLauGSW7YY0oR6c3Jk/keJcRA6jxrBBAa6C
         s7ySgYwdFNRDh80+TdMau6BA4nihbEyG5uAO6ZYrFWuNyJ0pSUhAgEIzOwQbl2qpkPhE
         Abxw==
X-Gm-Message-State: APjAAAW4Fwp/kAnKa9aKh5bvSmM7rjgyA8ParZ67Cv5hd77qw4Zz6tQY
        6EmIUtZUE0cRsqhtn1otO9NNcUW2
X-Google-Smtp-Source: APXvYqxjq9+s43ZTe9GdMaRoWRE/ZImZba2zbF8DUuSZgZcZIZswt+ahvQLO3mZSNdS5oKgf/mpM6g==
X-Received: by 2002:a65:5cc5:: with SMTP id b5mr8382017pgt.137.1570680552773;
        Wed, 09 Oct 2019 21:09:12 -0700 (PDT)
Received: from localhost ([2601:1c0:6280:3f0::9ef4])
        by smtp.gmail.com with ESMTPSA id 22sm3790501pfj.139.2019.10.09.21.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 21:09:11 -0700 (PDT)
Message-Id: <20191010035240.011497492@gmail.com>
User-Agent: quilt/0.65
Date:   Wed, 09 Oct 2019 20:52:46 -0700
From:   rd.dunlab@gmail.com
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>, linux-doc@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 07/12] infiniband: fix core/verbs.c kernel-doc notation
References: <20191010035239.532908118@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=012-iband-core-verbs.patch
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add missing function parameter descriptions:

../drivers/infiniband/core/verbs.c:257: warning: Function parameter or member 'flags' not described in '__ib_alloc_pd'
../drivers/infiniband/core/verbs.c:257: warning: Function parameter or member 'caller' not described in '__ib_alloc_pd'

Signed-off-by: Randy Dunlap <rd.dunlab@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: linux-doc@vger.kernel.org
---
This leaves a few Sphinx format warnings:

../drivers/infiniband/core/verbs.c:2510: WARNING: Unexpected indentation.
../drivers/infiniband/core/verbs.c:2512: WARNING: Block quote ends without a blank line; unexpected unindent.
../drivers/infiniband/core/verbs.c:2544: WARNING: Unexpected indentation.

 drivers/infiniband/core/verbs.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-next-20191009.orig/drivers/infiniband/core/verbs.c
+++ linux-next-20191009/drivers/infiniband/core/verbs.c
@@ -244,6 +244,8 @@ EXPORT_SYMBOL(rdma_port_get_link_layer);
 /**
  * ib_alloc_pd - Allocates an unused protection domain.
  * @device: The device on which to allocate the protection domain.
+ * @flags: protection domain flags
+ * @caller: caller's build-time module name
  *
  * A protection domain object provides an association between QPs, shared
  * receive queues, address handles, memory regions, and memory windows.


