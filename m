Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD87471FEF
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 21:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbfGWTLd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jul 2019 15:11:33 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]:37982 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728935AbfGWTLd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Jul 2019 15:11:33 -0400
Received: by mail-qt1-f172.google.com with SMTP id n11so42966741qtl.5
        for <linux-rdma@vger.kernel.org>; Tue, 23 Jul 2019 12:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F+7An6ChOa8ZnFVYb7cHZW+1mye1pJH1wLwrfaJrMB0=;
        b=Bg/UYAseTfS5bemsVA4fcn6KTAC8eXwpacb49bZqTcJCynp5/rUOxUS+wD3ldIUq13
         WM4TqE8Ta7oe1DR1wQPaQuMtbQK1/zi6CWx2NUNfQoWmVh3YgMntjkVzDA3UgeU1J9ra
         PXawUXkq8QDaC/4cYeXOk6oufQUcKSSicMiv6gMio4dDI6Dmcxi2FdTxFdMJMHZP5HHI
         JP1RCLSOUittqgrcoZB7bO90tPMf2/j0nkF0wj2+WrkEEQ+/HIPd5liRNfweHuXFLR1t
         mzSCZVVdUDYYq8+9edpwT9zNXNS9JN62ULQQJfYE1Jar6WGMfHCeWgQEEWFjjT1z3kgC
         7YnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F+7An6ChOa8ZnFVYb7cHZW+1mye1pJH1wLwrfaJrMB0=;
        b=eD18BRVo+MbbfVQGawFKDk0BZTot5RSc+FNcLOkPCV3zuPiNQQmwo0uW/Z00QQm2f/
         SNGnjBYLPHTyjQkahDCNRKBqyEfPFKt2wPjW5S2Hh/WjyI6icMrxzWyhP13EcX83uX1x
         HbDg5/CDzrfG+3T1dnHvPb6eDUsZA2jNSWAm8iB6POSxl0EaLVBEb9tPi1PtMws/HPSP
         Q3SIakumVAnzFkeCIHCE2FdjybHynmyUA/MdM+HV0tLgi7C9W2tYTr5Ij8AtfRCKXuhC
         ZMqr5yDZCwas6wTqDlrTVBiyci2pSaukOH6BKEGqZp16XyjRRGotKzyH85jhiIr/m3d9
         Xu2g==
X-Gm-Message-State: APjAAAUwLUkANZqEVCPnGXVJv/V/Wsi8R3OgHhJgBgNxPeGUdm2BfYkz
        IavLBVwdPP2QkNtXxzH/lFGBLZUza1h/Kw==
X-Google-Smtp-Source: APXvYqy0n0lNRhjAL+JGOyziFE6LJHuSQ5q2NLEp/CrDS+0Fyl20WsZ96SktznVzlY3Np10egwVD0w==
X-Received: by 2002:ad4:498b:: with SMTP id t11mr57333813qvx.139.1563909092511;
        Tue, 23 Jul 2019 12:11:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id v17sm25287534qtc.23.2019.07.23.12.11.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jul 2019 12:11:31 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hq02e-00045P-UU; Tue, 23 Jul 2019 16:01:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 17/19] build/azp: Run lintian over the bionic .debs
Date:   Tue, 23 Jul 2019 16:01:35 -0300
Message-Id: <20190723190137.15370-18-jgg@ziepe.ca>
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

Lets look for errors as we go.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 buildlib/azure-pipelines.yml | 4 ++++
 buildlib/cbuild              | 1 +
 2 files changed, 5 insertions(+)

diff --git a/buildlib/azure-pipelines.yml b/buildlib/azure-pipelines.yml
index 6a69e940a5b19e..153d437d8e81e9 100644
--- a/buildlib/azure-pipelines.yml
+++ b/buildlib/azure-pipelines.yml
@@ -119,6 +119,10 @@ stages:
               set -e
               fakeroot debian/rules binary
             displayName: clang 8.0 Bionic .deb Build
+          - bash: |
+              set -e
+              lintian ../*.deb
+            displayName: Debian Lintian for .deb packages
 
       - job: SrcPrep
         displayName: Build Source Tar
diff --git a/buildlib/cbuild b/buildlib/cbuild
index e7065e3e7d8d2d..c9522841dc1b8e 100755
--- a/buildlib/cbuild
+++ b/buildlib/cbuild
@@ -451,6 +451,7 @@ class azure_pipelines(APTEnvironment):
         "libnl-route-3-dev",
         "libsystemd-dev",
         "libudev-dev",
+        "lintian",
         "make",
         "ninja-build",
         "pandoc",
-- 
2.22.0

