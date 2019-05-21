Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D062B257EE
	for <lists+linux-rdma@lfdr.de>; Tue, 21 May 2019 21:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfEUTBa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 May 2019 15:01:30 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43890 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfEUTBa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 May 2019 15:01:30 -0400
Received: by mail-qt1-f196.google.com with SMTP id i26so21758168qtr.10
        for <linux-rdma@vger.kernel.org>; Tue, 21 May 2019 12:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LnEXBJn2HA2hl5jOoOjqQBgyQQh0DgVZU+/vhW2PzgE=;
        b=U3kCT/tWrgou2AeJHSb5e/mRMCzZve/y+O2TPSkou3PgN4WMX/lkxYgbh6NO4JukQY
         wJv8aWZo1g0fgp1XtNyWqpHFYEez28G+/+C22F6QL+P+PQIv5IxYJmBsUHbHvMB0bEcQ
         rVn0u4FiT+6Qr9l+yVDMuIs/fb9yLuG1KB9KL1xYXu2fQuPekPjpFKjB1qeZj6OerZwt
         yUl8Mzhecd6jm0YPI/xlaBZygV6aItXI+hNpHcSREvJ1XRwvf+UxGxPVDEVbYy/jFwfP
         MPUwE6NgjU1+tx/Pn5KKjRHcOrqrGXstsVdhCgDK5OlMEteEkON4azXzUzJgHuXowtty
         N5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LnEXBJn2HA2hl5jOoOjqQBgyQQh0DgVZU+/vhW2PzgE=;
        b=f7W6yOmyJVsJiJmFPXnsCL7XF5hU48Rb9wlm7PSd8o9fp6/HtXJRPsOWVi9pmRKYsP
         FjqBxhJN0VefkFeLBXcZYxs8H36cnCLpy2G+78CPluhCrRCXyULQna9CnlwfyR3lGPWo
         YZfdOiSrR8hz2vSErxBUV9Bje0VB03FNBHwylX2QHDEM+o55pSsdg6RQ6RhS7/fCSLLK
         YdXLfYbOQUGp0xZwk0KjFN7j+gcZK2xXvQKu4Wav2qDE7bgtRP0F9P8lZ0Rd7mg3aA9X
         ycb0ejEIP1OBWv20Wt+/W86udxK3ZteLvNr3ndqxTYnNJwNRope/Ho+z9mdPey+FeMuT
         CgJg==
X-Gm-Message-State: APjAAAVpekI7TSz58jWwaRAe3Qb3nxqtHQKzlVlqjatub1f63UsGucY4
        w6moLHrYuj9K6EtR2GzAe/InaD1dmfA=
X-Google-Smtp-Source: APXvYqyWs0kLIb0B4sVMmAHoDClg6Ag6Iq5a8uI7dYKGFBlDrA4uIzwONE+9PQJE9+oFSGOwIw5CgA==
X-Received: by 2002:a0c:9b94:: with SMTP id o20mr22488023qve.56.1558465289472;
        Tue, 21 May 2019 12:01:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id x206sm10175047qkb.71.2019.05.21.12.01.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 12:01:28 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hTA0t-0007Cj-Ve; Tue, 21 May 2019 16:01:27 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 1/7] ibacm: Fix format string warning on 32 bit compile
Date:   Tue, 21 May 2019 16:01:18 -0300
Message-Id: <20190521190124.27486-2-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190521190124.27486-1-jgg@ziepe.ca>
References: <20190521190124.27486-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

Need to use PRIx64 to print uint64_t's

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 ibacm/src/acm_util.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ibacm/src/acm_util.c b/ibacm/src/acm_util.c
index a1fe922b2fb7fd..1c6b9690430ce6 100644
--- a/ibacm/src/acm_util.c
+++ b/ibacm/src/acm_util.c
@@ -29,6 +29,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <inttypes.h>
 #include <net/if_arp.h>
 #include <string.h>
 #include <unistd.h>
@@ -207,7 +208,7 @@ static void acm_if_iter(struct nl_object *obj, void *_ctx_and_cb)
 	if (acm_if_get_pkey(rtnl_link_get_name(link), &pkey))
 		return;
 
-	acm_log(2, "name: %5s label: %9s index: %2d flags: %s addr: %s pkey: 0x%04x guid: 0x%lx\n",
+	acm_log(2, "name: %5s label: %9s index: %2d flags: %s addr: %s pkey: 0x%04x guid: 0x%" PRIx64 "\n",
 		rtnl_link_get_name(link), label,
 		rtnl_addr_get_ifindex(addr),
 		rtnl_link_flags2str(rtnl_link_get_flags(link), flags_str, sizeof(flags_str)),
-- 
2.21.0

