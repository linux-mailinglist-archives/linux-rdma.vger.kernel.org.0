Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4101E5C3
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 01:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbfENXtm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 May 2019 19:49:42 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38577 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfENXtl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 May 2019 19:49:41 -0400
Received: by mail-qt1-f193.google.com with SMTP id d13so1229649qth.5
        for <linux-rdma@vger.kernel.org>; Tue, 14 May 2019 16:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tsMTShzm/koB+U9S1nxSpT0oAMcFXUOyuXFGB0JtrOs=;
        b=Liahz+k2gNYSRs9RSKClpiyffK4DkpkxE1+9Ioc1xKB9awbvVeM6Rg6fSrteoCltgr
         pF35xFoeqDm0Kn48S6IgAtwyRVu7EuSyOB2VQLf5kcXAd5FtMqxX/o12FIOi9DmPHaT9
         kB7td2X6he8PzAYzf29ND37a4e/aMBuwELtB50MRl6U9lCyCRrkibyMRxV7S0GjwAd/J
         5dSjBCjUo/mzInbrFo0+C5F9OH8OVV9Jfxi+XJgG42z8gJxV5qWt7bTKVg+IoKby6NpI
         bdZy7U2KELuwNOoxPuisJ8IvDSul0avVOGpiU82QytgLjm1xn3sgp91uYF80XSyH4V0c
         qKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tsMTShzm/koB+U9S1nxSpT0oAMcFXUOyuXFGB0JtrOs=;
        b=YcnRWKHOFNtRunI7ZAGiQbLI9Hr1dcDSzN25rGfxboVK91flTlib6q9ROcaz3yFuux
         SDbmwNgNPtpNnH7KBE0oH75vNXCkIe44a5KRL0qZ9aNK/+NvryBd6reBMlLcjZhI8Ms9
         f4eC4ueBOtW3p3S8hnSVOZh0U4YI2BwVaMwLmfYtW3e6bfGEo1iglZzKu8iux9R27HLD
         dlVmmIYZF4ATDCF761jjVboVN4Sy4uQS8lf2HebKZQfxToLnDxcb/x2ocnKAY5mW56wN
         ItroJebPr4p361UAI0ru4drfShWADHvfq6InsTW2vqh9aeBHcc0iolTiR+uv/yiC42XV
         Zn+g==
X-Gm-Message-State: APjAAAU+5xrFWFNStgewmuCUiv8s9R+86z6aFxA5ae0AASBqN2gvu6tg
        bVTvBic8dL+Y6YQZF8hCO3absNabuL8=
X-Google-Smtp-Source: APXvYqyrBCxsXwhjtrvjOxVbw7CL3aeqQKR/5cLxXQLZ+q63cmHkFyoOFbEYOJf2vFp8V0aYEYj7vg==
X-Received: by 2002:ac8:8fb:: with SMTP id y56mr32516763qth.160.1557877780911;
        Tue, 14 May 2019 16:49:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id g9sm200605qtj.67.2019.05.14.16.49.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 16:49:39 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hQhAw-0001N7-Ra; Tue, 14 May 2019 20:49:38 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 05/20] ibdiags: Don't use __DATE__ and __TIME__
Date:   Tue, 14 May 2019 20:49:21 -0300
Message-Id: <20190514234936.5175-6-jgg@ziepe.ca>
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

This prevents the build from being reproducible.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 ibdiags/src/ibdiag_common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/ibdiags/src/ibdiag_common.c b/ibdiags/src/ibdiag_common.c
index a5056ad244c7c3..6b1a31f877e16d 100644
--- a/ibdiags/src/ibdiag_common.c
+++ b/ibdiags/src/ibdiag_common.c
@@ -83,8 +83,7 @@ static const struct ibdiag_opt *opts_map[256];
 
 static const char *get_build_version(void)
 {
-	return "BUILD VERSION: " PACKAGE_VERSION " Build date: " __DATE__
-	       " " __TIME__;
+	return "BUILD VERSION: " PACKAGE_VERSION;
 }
 
 static void pretty_print(int start, int width, const char *str)
-- 
2.21.0

