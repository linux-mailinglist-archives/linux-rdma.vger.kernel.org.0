Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4706C71FC6
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 21:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfGWTBp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jul 2019 15:01:45 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46095 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbfGWTBp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Jul 2019 15:01:45 -0400
Received: by mail-qt1-f193.google.com with SMTP id h21so42887924qtn.13
        for <linux-rdma@vger.kernel.org>; Tue, 23 Jul 2019 12:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dfl71m/NsNfbA8WM2LSOzoDmgIsqi5BgwE8JCMzyrSk=;
        b=RW7azUJziMmcZhJesmHWpu34IKQ/fJMc1JvkNVHTaNXLCyY5fR7r3uchFqOZmsgRyl
         xgSJ1+88F8k2tXTEHXY27L9z7mWrJ4gTt6KgGgbRVJQQ6UlEJBZXnT0Twl+dWupcCnU4
         aI1E/AvTAgipukkIvikuqiS6/MuMwaa0Bz4asSX3hc3WmtCZDFdk++tOYglvz+qN1ucn
         AsOaSts8ZI1/E+KakO/i/gR1hnEeoZKnHRMIEx+izpO4nRcmAlF5tetDQTtWqQsT62lj
         SxoGPV00nTy7KG2O23K8JZ0tVP1B9hLA8VNdERe/7IXs3Co6A0Lnr/ht8PjQjBNDS3AK
         e9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dfl71m/NsNfbA8WM2LSOzoDmgIsqi5BgwE8JCMzyrSk=;
        b=AYdkHtZ6ZoS+rPLNKlgGDIrTRe/r94gTlZhvqUUGR8XZV4rQunCBGTylA5FmuFdMOz
         AOf8DhU2bikyo1UsS5BsI/W2Dj8rswXmlGUeLloqduhTLQGMC4RJisw2BCyemn8dwsnt
         o19LLL6SJ7U0xOedbxeDfqgZl89q+PoZxgy5YvJlCKFSJYrevESE6HNySjBeVHdlrvgV
         rhcX4V6cPHs4mJKWjBwftUalrZxk0L/4u8/itI1V+zSuI5WU0Z5L1sYlFgkVmYFARLQS
         nrysPivLMoeEbvGqPnNpmgX4f0/pcUVUC2+q9ha61YWuc6UWvwaXyCATYpFLY8Oyi3Tv
         4+LA==
X-Gm-Message-State: APjAAAW2kd8TZoUNnmdj+UskFv+kui0bkUJwuSEo4RoMBhR6Q0awOFm1
        ATywRMSVEYoJ5UKa6a/GLFs2CODUw5ER8A==
X-Google-Smtp-Source: APXvYqz0kHT2VoJVq+hHfSt9oBwqeRAjnQgK0UI5SxfMNIvkw5A+9W45oVsI+XoJaknZ4b06S3G1Ww==
X-Received: by 2002:ac8:2a99:: with SMTP id b25mr54940841qta.223.1563908504034;
        Tue, 23 Jul 2019 12:01:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id c5sm27505525qta.5.2019.07.23.12.01.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jul 2019 12:01:41 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hq02e-00044X-K5; Tue, 23 Jul 2019 16:01:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 08/19] build/cbuild: Add push-azp-images
Date:   Tue, 23 Jul 2019 16:01:26 -0300
Message-Id: <20190723190137.15370-9-jgg@ziepe.ca>
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

Do a parallel push of all the Azure Pipelines images to the container
registry.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 buildlib/cbuild | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/buildlib/cbuild b/buildlib/cbuild
index 1c325c9fe7cbdf..9fd51cc750dcbb 100755
--- a/buildlib/cbuild
+++ b/buildlib/cbuild
@@ -161,6 +161,7 @@ class centos7_epel(centos7):
     ninja_cmd = "ninja-build";
     # Our spec file does not know how to cope with cmake3
     is_rpm = False;
+    to_azp = False;
 
     def get_docker_file(self):
         res = YumEnvironment.get_docker_file(self);
@@ -1059,6 +1060,29 @@ def cmd_build_images(args):
                      tmpdir]);
             docker_cmd(args,*opts);
 
+# -------------------------------------------------------------------------
+
+def args_push_azp_images(args):
+    pass
+def cmd_push_azp_images(args):
+    """Push the images required for Azure Pipelines to the container
+    registry. Must have done 'az login' first"""
+    subprocess.check_call(["sudo","az","acr","login","--name","ucfconsort"]);
+    with private_tmp(args) as tmpdir:
+        nfn = os.path.join(tmpdir,"build.ninja");
+        with open(nfn,"w") as F:
+            F.write("""rule push
+            command = docker push $img
+            description=Push $img\n""");
+
+            for env in environments:
+                name = env.image_name()
+                if "ucfconsort.azurecr.io" not in name:
+                    continue
+                F.write("build push_%s : push\n   img = %s\n"%(env.name,env.image_name()));
+                F.write("default push_%s\n"%(env.name));
+        subprocess.check_call(["sudo","ninja"],cwd=tmpdir);
+
 # -------------------------------------------------------------------------
 def args_make_dist_tar(parser):
     parser.add_argument("BUILD",help="Path to the build directory")
-- 
2.22.0

