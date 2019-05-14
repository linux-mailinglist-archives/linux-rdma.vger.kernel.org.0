Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 322DC1E597
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 01:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfENXad (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 May 2019 19:30:33 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36452 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfENXac (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 May 2019 19:30:32 -0400
Received: by mail-qt1-f193.google.com with SMTP id a17so1207395qth.3
        for <linux-rdma@vger.kernel.org>; Tue, 14 May 2019 16:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/mISwNsuQ949YKK+JnzvBLd3SKMUOksXlb/BRs8s7Ao=;
        b=OEaupTGLnu+sZwC1jmCUsgZytB+02Ab1Abj6iRilv35Vg57j94HvT7/YV0ExzTCyHn
         eEQDkvPYhN8DoEHqTnO1j/2yULMh4EVeNo0xyH4Z2BznfnMU7GBQYw8ZTBLa52k06aHX
         pvVRbLNW6otKMSyPL5SRtkwok+fIaE4uV8muj1lAwLvjOSKlPx8h1CkywM9YtGoU+07G
         5zhE3iVUp6y2UbLL3kKJRElr7P6K5rqk9Ned4ThsICO3sOC1mFEqe2mFYVlK+uJDytdK
         bWdjCczJbl+ncPy4o4GCXmPn0ZxaZrWe2AcmBjaXYdi2bohntzdRayfWBUFmtE+xR9l8
         KhFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/mISwNsuQ949YKK+JnzvBLd3SKMUOksXlb/BRs8s7Ao=;
        b=AGFeWgJuqFZbWK4SdQzMQuxq4wkypgQn5iIkeyDnw5rjhvMapARpkxHbwRTO5fdv/b
         i3h3nFzgn+wR11Xc5m10ndrDA+Tbd3fwBnWFsPNHZXBFl5g2b5K3J7fujW8SplTzWAKg
         ys3mtq+HHlkCNCCKCTktU9gXbnPU+DAlnT4ahJrFsyyaURSW3zpmE+1QZDmaUFYz3FjG
         84oqNyImzTT5beigBLy8oLAB9+wzJZlCLo22rwFG7tXxPmmOW31pqwlqwOtwR7qN410M
         q0dUKQp+cT5jFpmsqqQKkxNrVRteS2l9o6aWqEvyVDzavKA2aq9eqmparCZ8QYN0R3a3
         rIlA==
X-Gm-Message-State: APjAAAVr5paObYm1mfM3XknAH7IBlLo+b30/J+cGxZ2JXk9EM3tis62U
        exTRDiUSDbJIB+E7YnDq2TqosuiSt7E=
X-Google-Smtp-Source: APXvYqweyc+wTqvlaseOPVCZMdxXJDYVDlRPCr+a0PeLGrkp/n1VDpiVBvaq8jbQx+TJPQF3Kc66fw==
X-Received: by 2002:a0c:98ab:: with SMTP id f40mr22825913qvd.177.1557876631781;
        Tue, 14 May 2019 16:30:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id c32sm377992qte.2.2019.05.14.16.30.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 16:30:31 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hQgsQ-000142-Ew; Tue, 14 May 2019 20:30:30 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 0/5] Build system updates
Date:   Tue, 14 May 2019 20:30:23 -0300
Message-Id: <20190514233028.3905-1-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

Ran through all the build targets and tidied up a few things that were
failing.

This is a PR:

https://github.com/linux-rdma/rdma-core/pull/528

Jason Gunthorpe (5):
  cbuild: Make pyverbs build with epel
  cbuild: Remove ubuntu trusty
  cbuild: Use gcc-9 for debian experimental
  cbuild: Do not use the http proxy for tumbleweed
  build: Enable more warnings

 CMakeLists.txt  |  4 ++++
 buildlib/cbuild | 46 +++++++++++++++++++++++-----------------------
 2 files changed, 27 insertions(+), 23 deletions(-)

-- 
2.21.0

