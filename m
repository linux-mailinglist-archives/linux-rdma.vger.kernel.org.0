Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 506A8257EF
	for <lists+linux-rdma@lfdr.de>; Tue, 21 May 2019 21:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbfEUTBb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 May 2019 15:01:31 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34061 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729293AbfEUTBb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 May 2019 15:01:31 -0400
Received: by mail-qt1-f196.google.com with SMTP id h1so21861263qtp.1
        for <linux-rdma@vger.kernel.org>; Tue, 21 May 2019 12:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=prOjJHwQAyQ/kIh4tusP6zHDdeXu+xuIEomT8Y6gQ9A=;
        b=HR+cPrBATijPiBYXvwcDbQlSnzdAI42qKxk2M8H8mqcqR/z9zv7HNkz2Pp8qhlCwLd
         p1nZpDxjWDHiKJbS+/O5VtGtuIND5Nl4KVzsmXi3JVE0PT5lVmuLgFahNzRVLCp81fuD
         tLy2Ek0LBA/tk38igjihhJnaequCvKPSckZjW73OCqtU1SUzQ3QWyYg7xTyYDDImlfFZ
         YwOVQbbmMnsY0vAkzuf/0MqGw617qUl6Wy9L5BC1URBt6F3LpsUqN1M1BP4iMV5nOgtd
         6+Mxuh5y3/HX6Vah0jAUBFEwfAgvpSDPLlPmZXvGm6bpMQ8M3kn+hgX1rA7wcpcUB100
         aEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=prOjJHwQAyQ/kIh4tusP6zHDdeXu+xuIEomT8Y6gQ9A=;
        b=NDLyfeX3KIfAU6ASRhAyRGOEOsBbk3jZs7MJP/2wrm882ocrM3EtO+TJJy4fprPx1Z
         xUVtYRtEoN3OkRQgKbifT8W0zd+q/izh0pzhOgllT4HQjoEcMWvw9PzY8O4uLDz8/Bf3
         udrk9dYUCvj8iB+YZWPbw+/b4rb07ikZA8bhbmYaiVcY5T6DQPPkUBeyi7vYcQy7+YEb
         FhOf5QQLKVovPbzZ3/LNG8QvhXUL28KWgp6ap5kYCMN8OdudkDqAefRVOjbjLMVeQK+5
         Xf1VPizBZ1ScMT1b0U1ziYHOJ1BChSah57pB8K9Abyej4S055VnLKXmfuw6rjhQ/3tFo
         oKbg==
X-Gm-Message-State: APjAAAVXVcKjN6EVlqNObMv3CtMqH/EEWqiRC7WFOcx5gIwnZsDoFgPF
        xMLqDsdbWxqdCZJe/6h4gdMnz+I82gU=
X-Google-Smtp-Source: APXvYqwywjDneJCgutFX++YX9SbG+VjSF+jbEmLEmoSBfv/ZigvytqcbAQQ2tp0D9j0gXOwh2w6Y0Q==
X-Received: by 2002:a0c:d985:: with SMTP id y5mr50322136qvj.130.1558465290049;
        Tue, 21 May 2019 12:01:30 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id n36sm13597574qtk.9.2019.05.21.12.01.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 12:01:28 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hTA0u-0007Co-1Y; Tue, 21 May 2019 16:01:28 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 2/7] hns: Remove unneeded malloc.h
Date:   Tue, 21 May 2019 16:01:19 -0300
Message-Id: <20190521190124.27486-3-jgg@ziepe.ca>
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

This header is only needed to access internal glibc stuff. Otherwise
it confuses sparse.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 providers/hns/hns_roce_u_hw_v1.c | 1 -
 providers/hns/hns_roce_u_hw_v2.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/providers/hns/hns_roce_u_hw_v1.c b/providers/hns/hns_roce_u_hw_v1.c
index dbe0a185d154f0..fceb57a549cccd 100644
--- a/providers/hns/hns_roce_u_hw_v1.c
+++ b/providers/hns/hns_roce_u_hw_v1.c
@@ -32,7 +32,6 @@
 
 #include <stdio.h>
 #include <string.h>
-#include <malloc.h>
 #include "hns_roce_u_db.h"
 #include "hns_roce_u_hw_v1.h"
 #include "hns_roce_u.h"
diff --git a/providers/hns/hns_roce_u_hw_v2.c b/providers/hns/hns_roce_u_hw_v2.c
index df1d9659ecb5a2..a9616022f0e655 100644
--- a/providers/hns/hns_roce_u_hw_v2.c
+++ b/providers/hns/hns_roce_u_hw_v2.c
@@ -33,7 +33,6 @@
 #define _GNU_SOURCE
 #include <stdio.h>
 #include <string.h>
-#include <malloc.h>
 #include "hns_roce_u.h"
 #include "hns_roce_u_db.h"
 #include "hns_roce_u_hw_v2.h"
-- 
2.21.0

