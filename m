Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E10AC16B31
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2019 21:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfEGTUX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 May 2019 15:20:23 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34668 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfEGTUW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 May 2019 15:20:22 -0400
Received: by mail-qt1-f196.google.com with SMTP id j6so20434553qtq.1
        for <linux-rdma@vger.kernel.org>; Tue, 07 May 2019 12:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QQwUCta0uMmNtR24wX/kixo+6rMZC8Kc2quZm6czpIc=;
        b=e8gjfCyyjlLMUcK19Cb2Ch2xyouFzK/QgcKWt3c2PXSSomB5S/SFF5DaNnFMBh1Fms
         yDq8c5uhpi7rATJzlchPE0Jivs/i7GZeoqakM0cXNqJZczDmS3oi5Wpv+FUc+rOyOAOH
         9PYpTgllRKDdQ+JyRZxIvzTOS4QQWzwy3+0WJYoWpRbE8HCthlEmiPaHmvwDPiNMfiFk
         i1bSmIycl8IkNFCN2ls9W6SBf+hi7H7E0OKhIBHbyPh/qUVE/JxuYysqtWUDQspGURM/
         mAILUwrsB6q1ZkVc6WHbuJR1CFP5dWeAvgZuuvdfZbQggVK8DpXaZqSBOG+A+aKsJnFr
         GkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QQwUCta0uMmNtR24wX/kixo+6rMZC8Kc2quZm6czpIc=;
        b=ZPwVR3Nh9h1xAzV7Wbsq/pWE/t9vbT0cOjvCkM2gKhMwZfzzcdqVrB8cAxX+9N7b3I
         Xro/rT1yiN1Td7nU5fgmKhPeNDw/RTWZuabIyh/n+CofAf3ekYKPHXeJPa8M3EmbvHEr
         95V/uPGib+37o/dK9b6SRgu8X2fVxyt9M1+N6AleSlmEmM+0B42/J1Pvi/rSFkyjaOdd
         CMjfa9aaY++xQiH2RaZGuKSxMIUgSS3wsV9f9nK5Xg9d0NnuTqWgxyYbsXyAycMfrR0Z
         BOg2dEc/D3ueF9Q6oYJpTggtSbu7dakLN1+prW7YeRLC0bc4oW5DGP3QSXktWzSPz8fa
         /hGg==
X-Gm-Message-State: APjAAAX58pHMkyR1XAkDUolkWHJe9zr8WY2LJpUx5urNZMpZsClkrBul
        wpggOjvY5RIeOmpo1aYJguLeJOHQDI8=
X-Google-Smtp-Source: APXvYqyiPAh9gOqm3ah289vyR7VobNg3nazfV1xzp0NyfxKystZSX6IhAmq2thI6Ad31nOKjrS2i3w==
X-Received: by 2002:a0c:c165:: with SMTP id i34mr26548364qvh.6.1557256821877;
        Tue, 07 May 2019 12:20:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id y18sm7705478qtf.87.2019.05.07.12.20.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 12:20:20 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hO5dS-0001f3-RQ; Tue, 07 May 2019 16:20:18 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 0/2] Update rdma-core to Fedora Core 30
Date:   Tue,  7 May 2019 16:20:15 -0300
Message-Id: <20190507192017.6284-1-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

Now that it is released move up cbuild and fix the one warning the new gcc
detected.

Jason Gunthorpe (2):
  srp_daemon: Print the correct device name for error
  cbuild: Update to Fedora Core 30

 buildlib/cbuild         | 8 ++++----
 srp_daemon/srp_daemon.c | 3 +--
 2 files changed, 5 insertions(+), 6 deletions(-)

-- 
2.21.0

