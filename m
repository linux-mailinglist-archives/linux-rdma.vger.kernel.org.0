Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 257C81E5CB
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 01:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfENXtn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 May 2019 19:49:43 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44624 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfENXtm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 May 2019 19:49:42 -0400
Received: by mail-qt1-f193.google.com with SMTP id f24so1179140qtk.11
        for <linux-rdma@vger.kernel.org>; Tue, 14 May 2019 16:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=51BhS5jEUBebH+qPlsnkv6c6og+FKGG9kgVILpb77gM=;
        b=AcJhoKYFT5+0u90Xfd7ozmjqo3C3DGqJLogN6n9242vdJRLAHYsDn9O2K+JqcKNNPn
         6+2GXVRPkjQ18ngs4CbjI6dIY9PeKGXyyFVKjFvEvi7Ha6K8x4DJpTcjxA1RdjcvIcgl
         w7JDfcGT7OnvihjIMVQ1RnVPyk+wI3YjnokUeWF/0NEuGFjRos66UxF8LpPJZHVa5eq7
         ylIw20O5G9npelOslL23XJ7YGg3lGL+oqAbna4086fK2N1fStYW51mGtoeBS6BL1+Mhz
         KHoL7wYpp0CvKpakxq0UYUIBxH5SeHBYGBvQzCAT928FE0EDxgBaZNQUVJP5MlnyrYWP
         WXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=51BhS5jEUBebH+qPlsnkv6c6og+FKGG9kgVILpb77gM=;
        b=WZVWR4rXF16M30p98/cQ54q7TNvb1YZdEKRGa1KAjnEFL8j4M47LzdJ/42FMw+fIRr
         WntzhWxMcSdL7aEZUEmePD0+fMmTuLCfZ5EYpdDsilBptTNiEOpMwK+4prPQi1Kke/Zc
         o7KfGgkN8j5HiH2xgz8s7CuPhVb929+OCcOCkaQidFSwdgOSbEdjA036WGdm5rYpI55V
         l0G3/c2+QuVdYH0Kb66kAS8miE6xMQM8Pa7KYd3z4WoWCFTq5EvWk4q55qLrcRoTGQbU
         l5dEhqXuKygSgAZaB+cIybW+N8Txhu2oZC9+JK4sDMkGe41cm36aQ7Vdvd/lJBumY5iz
         DE5w==
X-Gm-Message-State: APjAAAWf29xy2zai4bvU9Cnnt0U10Y+zRTrUaNSyO6uq/0kn+oedtaix
        fyv23gKagOJR+Rskm5Y5luQeiUjQ6jg=
X-Google-Smtp-Source: APXvYqw9AYtnpxVaLUBSPruo0tBU7mTw4bVFEtEFStJvLglIHxWjE5Aag6yOm0R/y+RwBN+NQSQBGA==
X-Received: by 2002:a0c:ff0b:: with SMTP id w11mr30651894qvt.33.1557877781361;
        Tue, 14 May 2019 16:49:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id y18sm245275qty.78.2019.05.14.16.49.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 16:49:39 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hQhAw-0001Mv-Op; Tue, 14 May 2019 20:49:38 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 03/20] ibdiags: Remove unneeded HAVE_ checks
Date:   Tue, 14 May 2019 20:49:19 -0300
Message-Id: <20190514234936.5175-4-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190514234936.5175-1-jgg@ziepe.ca>
References: <20190514234936.5175-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 ibdiags/src/ibstat.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/ibdiags/src/ibstat.c b/ibdiags/src/ibstat.c
index 0e79f21c544c52..61c6611a05043e 100644
--- a/ibdiags/src/ibstat.c
+++ b/ibdiags/src/ibstat.c
@@ -193,9 +193,7 @@ static int port_dump(umad_port_t * port, int alone)
 	printf("%sSM lid: %d\n", pre, port->sm_lid);
 	printf("%sCapability mask: 0x%08x\n", pre, ntohl(port->capmask));
 	printf("%sPort GUID: 0x%016" PRIx64 "\n", pre, be64toh(port->port_guid));
-#ifdef HAVE_UMAD_PORT_LINK_LAYER
 	printf("%sLink layer: %s\n", pre, port->link_layer);
-#endif
 	return 0;
 }
 
-- 
2.21.0

