Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE3B616B32
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2019 21:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfEGTUW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 May 2019 15:20:22 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]:37786 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfEGTUV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 May 2019 15:20:21 -0400
Received: by mail-qt1-f176.google.com with SMTP id o7so8455230qtp.4
        for <linux-rdma@vger.kernel.org>; Tue, 07 May 2019 12:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=naDoAZMKT6xQvkk3im6ZIOlckCtVGSc0SPTNVv3TXCk=;
        b=YdWwW7WquNHzlikQLMNPkL5dgf+KDxsAMnte5QptDMcB55bTCJnyNjAfatiYBnE5E+
         WiOE6CVuRngMhaWrlG+geC8bu/3Wfo+hgjcW3dfpxWyk80aGqDRlM23v93RtO/FdOb6e
         TXU4EcwaD2HOHEMk2VVCG11NhAJRutB8+ywu5O/Yy+XxFdfhRVcLb6FmxppzvHOjGzf/
         DQI7y62hTeH8XfsufpOkXmVdJdKY0+2Z3IZKB8++/TPXIeFEmt7rXY0sKMQH9L8ZApTl
         VpQAphPfMLWFH88So380XvjlvruFp4F41q4ET/aNSlsgtKnMMjCQSWNg6fkx7oD1RALR
         u4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=naDoAZMKT6xQvkk3im6ZIOlckCtVGSc0SPTNVv3TXCk=;
        b=DX+lsCFOxcAM7FTuvW59ZWKL6UFoN6Y8nGZJ7pegJTIxYWaXuFPVUwr7xkLJnqh6og
         Sc+A5yEgJiA9F8NE76BcwiGRq1bkMj+cMTFnqdeCHDpqylflO3w77MyFFGQNutzNzIIf
         9Dnl3vo4+uHwCSYlR9NejRB+8J31sZ1x4Wo+8dM0L+qwLPAJKS5iAStbQr9afatu2PoP
         MbxnSznEDf8omdn/WEWvPCGhLtznpJ4Jm+dQZ7ZojlbIoM4jdQVZ1K5frC+XV2ll1ARj
         8usgY8ysCAe9LHz0459anU39tp7H4iGRYLeURW5qXs6cD9sTcrG0RbzvjFAs1NkjD4Eh
         GcDw==
X-Gm-Message-State: APjAAAV91zLupnTAYquAF1iIQDqpiAl/rJSsPLaqYxdqFaW9JV5i3RyY
        p5H9Dc1aoM+twMcahuWONbjrUvbzGfk=
X-Google-Smtp-Source: APXvYqzDjEhjjtdvgnZwq2C3aM3TCGJaO7N0yRtt3ZLsGXkgRR1qqoApCW7HYw8DP6F8WJTqWErKfg==
X-Received: by 2002:ac8:93:: with SMTP id c19mr27582659qtg.92.1557256820450;
        Tue, 07 May 2019 12:20:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id m18sm3738893qki.21.2019.05.07.12.20.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 12:20:19 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hO5dS-0001f9-Ti; Tue, 07 May 2019 16:20:18 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 1/2] srp_daemon: Print the correct device name for error
Date:   Tue,  7 May 2019 16:20:16 -0300
Message-Id: <20190507192017.6284-2-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190507192017.6284-1-jgg@ziepe.ca>
References: <20190507192017.6284-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

gcc 9.1 says:

../srp_daemon/srp_daemon.c:682:3: warning: '%s' directive argument is null [-Wformat-overflow=]

The intention here was the print the input string not NULL.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 srp_daemon/srp_daemon.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/srp_daemon/srp_daemon.c b/srp_daemon/srp_daemon.c
index baf4957a618905..a004f6a407e08c 100644
--- a/srp_daemon/srp_daemon.c
+++ b/srp_daemon/srp_daemon.c
@@ -679,8 +679,7 @@ static int translate_umad_to_ibdev_and_port(char *umad_dev, char **ibdev,
 
 	umad_dev_name = rindex(umad_dev, '/');
 	if (!umad_dev_name) {
-		pr_err("Couldn't find device name in '%s'\n",
-			umad_dev_name);
+		pr_err("Couldn't find device name in '%s'\n", umad_dev);
 		return -1;
 	}
 
-- 
2.21.0

