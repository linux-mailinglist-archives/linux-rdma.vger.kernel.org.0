Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E653D257F2
	for <lists+linux-rdma@lfdr.de>; Tue, 21 May 2019 21:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbfEUTBc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 May 2019 15:01:32 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37475 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729300AbfEUTBc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 May 2019 15:01:32 -0400
Received: by mail-qt1-f196.google.com with SMTP id o7so21836527qtp.4
        for <linux-rdma@vger.kernel.org>; Tue, 21 May 2019 12:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=shrd5wbEj8w59PT3J7ifykJp8tIdzkzFFSvkWfrrl58=;
        b=NoYwB3uTq7UkkZ7bTo3cGxUxmwlnUD7Jw50tzbhKaDPWUo5LrVL8NdewAPVAC5m9HR
         H8yxgyWq1t5arEd5uBjqN8UZIpbGJKwFg8ua8YDHrux8TWZS9RmSbzb+AywdsmmzPhJQ
         uzedysmXRVVn0eQasjkQyJUwYvkoxk/2vQKIPtKnvQ6U/gG27tvVaRJmUJhk9AQe0Gr1
         GxPVfZlmTJNY6IhQpdmh0vUPniVDDkZqz3T6peadPntO/DAaG0OASGHER+6TkjtWX4q6
         U0xmmmZmLxky7R3ZyqbtKG1Wt4tf+ZEaiMIjrRhBkeuCqfPWMIRQ3gKf6/KnjwdP0dKy
         mDxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=shrd5wbEj8w59PT3J7ifykJp8tIdzkzFFSvkWfrrl58=;
        b=R4eXeBlOFfLE+i0bA5IhhPvQAXjWeEIOzVDaswqsu1oMgSlB770nIGnMSe8X4qTh5d
         p26B6mm/m7onNDW45kQH92l3O7Ryrm2/m1rV9NG/8umD1SDDzd9KAFKUazt1OSd20aoc
         hg6HikScwLvIxEy4OsbRI8rZ45c9Wj2yeSyVvcJYSXpRYc7sKzMqlBX/Mcxngs3Yaqs0
         +OwW+gfviyBC53u72wg0t8oXiFSirNiUkIjbAncIUjKNCtqXPsUzbT84fbaePslR2SDN
         k7KGwkWrhqUxsVvcDDBCtTHVcwNt+8mTI7wbRO3tyIkB55BJ+SIZQ0peJEnoLJ7W+gCu
         K58A==
X-Gm-Message-State: APjAAAUEnEhMGJ/LA9JmQihFYqbQoigYmBqiGdy2UDjmX7hXBU1nTLLQ
        DKoFAj3o3fjkM2gUYDZw6jYurVP5Gx4=
X-Google-Smtp-Source: APXvYqyBd2/I0tXX4noU4lDQlZTLLHBmM8C+EZv5ncbqdM0aXTOSbeFwLexGIrRKRyYObsG7de6C4g==
X-Received: by 2002:a0c:ad02:: with SMTP id u2mr30430167qvc.90.1558465291570;
        Tue, 21 May 2019 12:01:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id r16sm7730095qkk.36.2019.05.21.12.01.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 12:01:29 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hTA0u-0007DE-7z; Tue, 21 May 2019 16:01:28 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 6/7] cbuild: Do not require yaml to always be installed
Date:   Tue, 21 May 2019 16:01:23 -0300
Message-Id: <20190521190124.27486-7-jgg@ziepe.ca>
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

We only need this for the travis related commands.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 buildlib/cbuild | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/buildlib/cbuild b/buildlib/cbuild
index a0b4a7e3e52117..2bd869cc28cbe1 100755
--- a/buildlib/cbuild
+++ b/buildlib/cbuild
@@ -52,7 +52,6 @@ import shutil
 import subprocess
 import sys
 import tempfile
-import yaml
 from contextlib import contextmanager;
 
 project = "rdma-core";
@@ -239,6 +238,7 @@ class travis(APTEnvironment):
     _yaml = None;
 
     def get_yaml(self):
+        import yaml
         if self._yaml:
             return self._yaml;
 
@@ -696,6 +696,7 @@ def copy_abi_files(src):
             shutil.copy(cur_fn, ref_fn);
 
 def run_travis_build(args,env):
+    import yaml
     with private_tmp(args) as tmpdir:
         os.mkdir(os.path.join(tmpdir,"src"));
         os.mkdir(os.path.join(tmpdir,"tmp"));
-- 
2.21.0

