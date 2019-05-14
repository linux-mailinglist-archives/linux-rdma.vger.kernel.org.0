Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 129F61E598
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 01:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfENXae (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 May 2019 19:30:34 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44113 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfENXad (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 May 2019 19:30:33 -0400
Received: by mail-qt1-f195.google.com with SMTP id f24so1137558qtk.11
        for <linux-rdma@vger.kernel.org>; Tue, 14 May 2019 16:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ri6jG678a/rA3j+f5TWTyclsKQodnkQaN3DlWfEeVxA=;
        b=Z7QABZBe+haBTSrPQ3FvR9xnCmqL2+FzbI6a9MAF6inYjO5ctWygDecFwalNSaG+Qv
         8Yyq68z4hzdkBTrbf9P7dygYjyXqT43svJQ0bIposvegEmYhW4r8oRPmZb/K3KZ+hmi0
         C0bx8qHlV/xAVqr/wx5Mlz2BND12cVWuRuxZ5I2MEaiEkJ6TiWmK3BA4XjxRRAXdvsP7
         zQdKMeXiMmsLQpy7vSdrKdxSKA+RuFXyMlVTjTDT9MKK1Z8htbryDRxu3CmK041RVQNu
         0fCWuEKeHvfjFIyfCN1I98GkodDGBR1/ngvN0uluwtDK1rNIKKsnHyixSOmBxJIhSaN+
         G0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ri6jG678a/rA3j+f5TWTyclsKQodnkQaN3DlWfEeVxA=;
        b=T2puYcPjLemetnyzcW+yMeAOoijy0pRP+j1vEunaHXz6EhAvhwyj52Yc738vBjdWKW
         WW7a0VC/fK2Kj3fvcfpieT41RKpqWowgrpEu3XWV0SFAf2gaAoIiCDr6iS6U8gceOQp7
         C45Yncrz+BGQ5mUlV9hR7rA3kv7thdy26eB5DnCm6glCztSUSV+FfqE4HaPXDmXIVyh3
         /VoG6YkAmfQFHFwdAvBliNEJxHT/KMRu1Beu4hPpRQAab2kB7GhEQl2NOF0P6P9Zhv8Z
         WJWoapvE/RbajeUQWpEpeLWDTxij0Gm30hkzmKMMxOG39BAOFT044VqbGB9B3jC5iDt3
         tZJw==
X-Gm-Message-State: APjAAAXiUowVVVA72c4b31XLINPfCpOBEG1q7pgpJOsCRQG6Cx54rANR
        7x9ffOYu4b+Us5wa3MFUqhBx+Zd3uTs=
X-Google-Smtp-Source: APXvYqzV2cyON1Ng1CY5j5QFZLKXiDBMSGC6Utsk7S6R7zDAewQKcf3vCrHQHXgxS5q542AMB5EYjg==
X-Received: by 2002:a0c:9491:: with SMTP id j17mr10703520qvj.53.1557876632879;
        Tue, 14 May 2019 16:30:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id i7sm125163qkk.35.2019.05.14.16.30.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 16:30:31 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hQgsQ-00014K-IV; Tue, 14 May 2019 20:30:30 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 3/5] cbuild: Use gcc-9 for debian experimental
Date:   Tue, 14 May 2019 20:30:26 -0300
Message-Id: <20190514233028.3905-4-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190514233028.3905-1-jgg@ziepe.ca>
References: <20190514233028.3905-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

It is available now.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 buildlib/cbuild | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/buildlib/cbuild b/buildlib/cbuild
index 3035db9f375c1d..a659a77fc5bb74 100755
--- a/buildlib/cbuild
+++ b/buildlib/cbuild
@@ -219,7 +219,7 @@ class stretch(APTEnvironment):
 
 class debian_experimental(APTEnvironment):
     docker_parent = "debian:experimental"
-    pkgs = (stretch.pkgs ^ {"gcc"}) | {"gcc-7"};
+    pkgs = (stretch.pkgs ^ {"gcc"}) | {"gcc-9"};
     name = "debian-experimental";
 
     def get_docker_file(self):
-- 
2.21.0

