Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46C3C71FF0
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 21:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbfGWTLf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jul 2019 15:11:35 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39216 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728935AbfGWTLe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Jul 2019 15:11:34 -0400
Received: by mail-qt1-f194.google.com with SMTP id l9so42951981qtu.6
        for <linux-rdma@vger.kernel.org>; Tue, 23 Jul 2019 12:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d94miwNGPDvNb/uhiZs6CZ6LScEv7LiX+m1CyRfT1yM=;
        b=nT4cZL5qEB/ulY4OPm9/Vip2DUh2JsolZ4WTdwgT5L1+qiFMYRUys7gdYMN3Z9/D+F
         8ES/naZfCkidbazC9yk6mylVX7AWvigXM6viyw8CpjmmSS2NpYvFKYJl7rcLMJLSxcjr
         S74XrD0znxHtGs7HG8iH1i+Kdpvd4HG0MDCFvqWWwwtAcBPqRFQEI2f79ZiNq/3WAvBl
         AQKUHzRGkq+kWgkbBKDJxJJq/fRmpC43zd1k5r6ZFrwnVQ+1ATikfhZisUV/NybtBSp3
         sKrFgM8l40G7wdySwPW9gr69tgIUUbocRmnmZm92Oql8CUvDYfMeJA3tQ3yoeVWSgZ/k
         ijgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d94miwNGPDvNb/uhiZs6CZ6LScEv7LiX+m1CyRfT1yM=;
        b=QdKH7aDxTn33a9+WOj/rSFtIjqyTGh+VK4CqSTu7wx8hvY3JOklEC4S7j7FEofS7H2
         WVDBIfZZb3gxhO/d8v98/+APWqJgVXw83MiaXllYCVqfY6CwEqP6CxvIbVPpeq8tzWqV
         Lg1+jagdDZHJ/5tDNiX21iYC1PYMRo1VRUWjBNuYkAr4ixNF+V3xS/IDwAiobAZuMj+j
         1pgLyPaTycgk8u0BdVxdDRZwCQcQKmCDW4bWKySm0tsYfovVg0WG72BWaQbbLwgHY+El
         oRgPx+1ntSCO9CK+/UFrRMFY7Abn1Y4xk3YHnFB6iNE59bHwacLgfaWO8ye8OPf/pq84
         BvHQ==
X-Gm-Message-State: APjAAAWHlEu8LYL9ar0PQZXw9VTuTI1aME1SQ5DwgXojQHhSY21NGXGU
        UsFEtZSEonhLmJM9JZPcHAgo9jP4UA5gbQ==
X-Google-Smtp-Source: APXvYqyru5U+Y6vnOeB90Pd7QNxecBHtwutaYfyBNNJ0clI+/58qzgiXP4LGSpZRQzg1tX/iUACimA==
X-Received: by 2002:a0c:afeb:: with SMTP id t40mr54737815qvc.28.1563909093527;
        Tue, 23 Jul 2019 12:11:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id f20sm17352184qkh.15.2019.07.23.12.11.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jul 2019 12:11:33 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hq02e-00044v-Oq; Tue, 23 Jul 2019 16:01:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 12/19] build/azp: Add Fedora 30 to the distro testing
Date:   Tue, 23 Jul 2019 16:01:30 -0300
Message-Id: <20190723190137.15370-13-jgg@ziepe.ca>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190723190137.15370-1-jgg@ziepe.ca>
References: <20190723190137.15370-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

Fedora represents the latest cutting edge upstream.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 buildlib/azure-pipelines.yml | 7 +++++++
 buildlib/cbuild              | 1 +
 2 files changed, 8 insertions(+)

diff --git a/buildlib/azure-pipelines.yml b/buildlib/azure-pipelines.yml
index 1d4e1f317bbe0f..7df483e3329534 100644
--- a/buildlib/azure-pipelines.yml
+++ b/buildlib/azure-pipelines.yml
@@ -13,6 +13,9 @@ resources:
     - container: centos7
       image: ucfconsort.azurecr.io/rdma-core/centos7:25.0
       endpoint: ucfconsort_registry
+    - container: fedora
+      image: ucfconsort.azurecr.io/rdma-core/fc30:25.0
+      endpoint: ucfconsort_registry
     - container: leap
       image: ucfconsort.azurecr.io/rdma-core/opensuse-15.0:25.0
       endpoint: ucfconsort_registry
@@ -149,6 +152,10 @@ stages:
               CONTAINER: centos7
               SPEC: redhat/rdma-core.spec
               RPMBUILD_OPTS:
+            fedora30:
+              CONTAINER: fedora
+              SPEC: redhat/rdma-core.spec
+              RPMBUILD_OPTS:
             leap:
               CONTAINER: leap
               SPEC: suse/rdma-core.spec
diff --git a/buildlib/cbuild b/buildlib/cbuild
index 6e9a9cec9cd6cd..1441a91a8427fd 100755
--- a/buildlib/cbuild
+++ b/buildlib/cbuild
@@ -184,6 +184,7 @@ class fc30(Environment):
     ninja_cmd = "ninja-build";
     is_rpm = True;
     aliases = {"fedora"};
+    to_azp = True;
 
     def get_docker_file(self,tmpdir):
         res = DockerFile(self.docker_parent);
-- 
2.22.0

