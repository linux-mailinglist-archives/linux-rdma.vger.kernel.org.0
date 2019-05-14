Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B25A51E596
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 01:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfENXad (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 May 2019 19:30:33 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36729 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfENXac (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 May 2019 19:30:32 -0400
Received: by mail-qk1-f195.google.com with SMTP id c14so388853qke.3
        for <linux-rdma@vger.kernel.org>; Tue, 14 May 2019 16:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F8KXC1/Wtq8K3iX0J6V6Xu20q/lAlzVpRKHTX9OpEvs=;
        b=PbPtNJX+zaizX+Hndq92cCdMgO5vRvU9sFBjBiRK5NV6i5eLIa0lT+qXbhGOrvM6mk
         34AQeOQlDgPgAlxKv4aAMHgqCThS1WoLmvqq6WLTp0TXNTXZgbgzNWOuR2MOJeVh8aof
         5e3enGrZne/VxKfSqQRpi3cO2SOZWrl2xW+Ozps9DIi8VmPqMz3b31ftiDM2w+07DBxg
         KbliDYMskgYLc8vfvaomOlz54hemN6omlFLILFDiUIt5n0DqPIoKANfkvx8BmI+u7z5y
         kVttt1dnTaZ5QFghDlruDaJA9q0yGZfzYtoQQMsHe7W+NCQ2dk2h7uG/GzeXC+cgvPMv
         qvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F8KXC1/Wtq8K3iX0J6V6Xu20q/lAlzVpRKHTX9OpEvs=;
        b=W+GWMsgSfwA1ZPbZy1TILelg3oul6BDv90Vtp0h2jpdrbAWD/4seKpcYBUMOY2+oBG
         tSCscyqk8c/29tIZ/JIiQVGxXPonLcrlhw4UMVHdgjBzloFgkh0JvmReqZwjUw/vFd3P
         V3WzbYt3mGM8iJQB92BWB4/ztCNfrWg1b9BwRqC/7+niPe158oR1/rVRr0v+SYQv4vdD
         Hxb8qAROb5CYahpca3D14WPvyNyEEikLha1xP/lj3GvqEakRddU+S0Qs7L6MiVYVBI7G
         VTDyFgJ1Me60pSP1hqFWepAxgBuXgxuHlo9ZbkHw0FRbnU6SxVmlLF7v8gX8ffI2NXvl
         Uk5Q==
X-Gm-Message-State: APjAAAUJW3iKk47pOyJFxo/Y9WJqEwat0RXon7VvNhgp1SNCS5a79MIc
        k0CCzbiJFzcDcQir7TZx/6CnhzErH24=
X-Google-Smtp-Source: APXvYqwRaBYUAqY+MFGNfBilk61F8OzqFIxdSPgiGX9bxMKJKezjY31ddCYlvG2ZQ1U+NjcHdhKIRw==
X-Received: by 2002:a37:4a83:: with SMTP id x125mr31161660qka.146.1557876632035;
        Tue, 14 May 2019 16:30:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id x18sm95929qkh.87.2019.05.14.16.30.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 16:30:31 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hQgsQ-00014Q-JZ; Tue, 14 May 2019 20:30:30 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 4/5] cbuild: Do not use the http proxy for tumbleweed
Date:   Tue, 14 May 2019 20:30:27 -0300
Message-Id: <20190514233028.3905-5-jgg@ziepe.ca>
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

It also does not work with apt-cacher-ng because the server generates
redirects for some reason.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 buildlib/cbuild | 1 +
 1 file changed, 1 insertion(+)

diff --git a/buildlib/cbuild b/buildlib/cbuild
index a659a77fc5bb74..e012b08b5fbb76 100755
--- a/buildlib/cbuild
+++ b/buildlib/cbuild
@@ -360,6 +360,7 @@ class leap(ZypperEnvironment):
     aliases = {"leap"};
 
 class tumbleweed(ZypperEnvironment):
+    proxy = False;
     docker_parent = "opensuse/tumbleweed:latest";
     pkgs = leap.pkgs;
     name = "tumbleweed";
-- 
2.21.0

