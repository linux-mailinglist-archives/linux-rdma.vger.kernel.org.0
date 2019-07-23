Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E83871FC4
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 21:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfGWTBo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jul 2019 15:01:44 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:39436 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbfGWTBo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Jul 2019 15:01:44 -0400
Received: by mail-qt1-f169.google.com with SMTP id l9so42919542qtu.6
        for <linux-rdma@vger.kernel.org>; Tue, 23 Jul 2019 12:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2yzymNMZxCXl94f0VDmBjPwjfmfMat7L7q7G2GioiEU=;
        b=Wa1syyNyYfGOOeUQekiIQjUF2Z/tFEN+Ya6Ea2YWyIM5FwLEw/T7ebDAwfngly9PKc
         pfj7BQj77apTsG8JYrmJPqjDmwx6o6wwilnlgU0o8Jy9NGc9VuPLQiz2kE9hNFBY8zOS
         6ukSapp7d4NrAz19qdB36DxFRn6kQ5iNnk/hZd3t1TxJ/inOZjXiM32oO/TQ5qDAgMtI
         G1BiRoz+NVI5MDrgOX/n2s1uVCAMcHuZDfUfwpT2tyiZQxtFzqmi/F87kSxp7NtRlI2m
         qC1uh9ugLIUI14wDBjQUvyujiF/6ePrKFSpE+6vdd3lVD0oMrtIsk90ADKDsAMt0Tion
         Dq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2yzymNMZxCXl94f0VDmBjPwjfmfMat7L7q7G2GioiEU=;
        b=UrqHL1Ez39W1lnLQ0+hmopjAhrad8RsCde+yi3san60DiQIy1424twceYar5a1yHd8
         sDVsPZDjWYMBTTUy3TiFPabknEuB30BlpERd19Vc6F1cMTdJxQTtgp7tVLx3zpx/aIlP
         aoxRRtDvKrzVoD2bAxk2uCkJYUwfDh0JMtFjTlESjJM+fIPTljrC6bzImukBcO2bVyYL
         EBzMlYXC3j3n2G4VFTkQbqwbIS0B3da4yAfRal1P6PrUU8E0VFrQRac78peJhFqXm8fG
         A59CAN0GvXHxFSh6Jg17CmrMs/DVvpLaaZf13KX864zCWlQukqSPuZR6CzPZu3BwcEHp
         tXvw==
X-Gm-Message-State: APjAAAXh6+ftbxrqdrMuz0uhAHwqi13eRFBCsAiLRmbmyJQQp6Ho4W2p
        qdTRnFC1ZBR/9HcMtEuQvbAQGfkyLJqYig==
X-Google-Smtp-Source: APXvYqyJRgnoOTAnfg39nqDyBn1JFaLzks/P94sCOyWFGuYsUqcJJLCUVnJ2+wmOzXAxCT/FLNEfMA==
X-Received: by 2002:ac8:2d69:: with SMTP id o38mr53824095qta.169.1563908502931;
        Tue, 23 Jul 2019 12:01:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id j8sm19535487qki.85.2019.07.23.12.01.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jul 2019 12:01:41 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hq02e-00043l-60; Tue, 23 Jul 2019 16:01:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 00/19] Complete the azure pipelines configuration
Date:   Tue, 23 Jul 2019 16:01:18 -0300
Message-Id: <20190723190137.15370-1-jgg@ziepe.ca>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

Now that it has been running with stability for a while lets finish the job.

This is mostly a grab bag of things to make AZP work properly:
 - Only use python3 so we can reduce the azp image size
 - Migrate functions over from travis so we don't see as many travis false
   failures until we retire it. Notably the problematic suse Leap is dropped
 - Build FC30 and Centos6 in AZP
 - Cross compile on PPC64 as well as ARM64
 - Version number the container images so that stable branches will continue
   to work forever.
 - Minor bug fixes to get clean compiles in all environments

This is a PR:

https://github.com/linux-rdma/rdma-core/pull/552

Jason Gunthorpe (19):
  rdmacm: Fix missing libraries on centos6 build
  util: Enable uninitialized_var on powerpc
  build/cbuild: Remove docker-gc
  build/travis: Do not build packages in travis anymore
  build/travis: Do not run checkpatch
  build/travis: Do not cross compile for ARM64
  build/azp: Use a version number for the docker images
  build/cbuild: Add push-azp-images
  build/azp: Use gcc 9.3 for building
  build/azp: Use clang 8.0 for building
  build/azp: Run a test compile on ppc64el as well
  build/azp: Add Fedora 30 to the distro testing
  build/azp: Update check-build to work with python3
  build/cbuild: Update cbuild to work with python3
  build/azp: Reduce the package list
  build/azp: Add centos6 to the test distributions
  build/azp: Run lintian over the bionic .debs
  build: Use the CMake variable -DENABLE_WERROR to turn on WERROR mode
  build/azp: Have Azure Pipelines create releases when tags are made

 .travis.yml                          |  27 ---
 CMakeLists.txt                       |   5 +
 buildlib/azure-pipelines-release.yml |  48 ++++++
 buildlib/azure-pipelines.yml         |  84 +++++----
 buildlib/cbuild                      | 248 +++++++++++++++++++--------
 buildlib/centos6.spec                | 109 ++++++++++++
 buildlib/check-build                 |  50 +++---
 buildlib/github-release              |   7 -
 buildlib/package-build-test          |  21 ---
 buildlib/travis-build                |   7 +-
 buildlib/travis-checkpatch           |  30 ----
 librdmacm/CMakeLists.txt             |   1 +
 util/compiler.h                      |   5 +-
 13 files changed, 421 insertions(+), 221 deletions(-)
 create mode 100644 buildlib/azure-pipelines-release.yml
 create mode 100644 buildlib/centos6.spec
 delete mode 100755 buildlib/github-release
 delete mode 100755 buildlib/package-build-test
 delete mode 100755 buildlib/travis-checkpatch

-- 
2.22.0

