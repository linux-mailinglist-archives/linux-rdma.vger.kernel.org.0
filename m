Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C763113E04D
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 17:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgAPQj6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jan 2020 11:39:58 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40375 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgAPQj6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jan 2020 11:39:58 -0500
Received: by mail-qt1-f194.google.com with SMTP id v25so19366318qto.7
        for <linux-rdma@vger.kernel.org>; Thu, 16 Jan 2020 08:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kWYbBeaMjs0GnQZYUjR4f7NNZZLfx+/6BfTHxNRD/ug=;
        b=jHU+8/LZbbz69x1x7+hY1xxeq08tg0bbO7OnYvZpt0LUU/5LsKurj4JxdEynEtQabm
         k58CyGef+KJZP7OEqOoGAo+rexwc0EiFjiMaZT1gqCerzyWVX7peuaMx1BpkhMoydjIc
         chajO6JL/EUqDZCpQRKDceG7baUHU8TcwqIyw8JxvzT7O4ihHtYYgquKgPUbxYcN9E5m
         ZMop92Iw005iXm90Ww5zHUjSEf/wvKCflpyGqbccVVa5puRd1yiF1f3fRl5gLtEgMlg0
         sSHf4PSJV7ooXXczfYdSe7XGsfUkRQ8nRn/NZvOsjMs+kfx/8mUmZc94Bhdp26+D9W2R
         li2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kWYbBeaMjs0GnQZYUjR4f7NNZZLfx+/6BfTHxNRD/ug=;
        b=XT5FUUoJ4dGznsTV22vv9YT2mbNF4YLWbQQzL92IwS1uAM62KJWjUcZN7CoVrkBuKD
         RPb1fz0MKsMq5EV5m8qiuOh9ic/Ra+rYVNqTwT/dVHoN2sv4zfu5LEsMWChk3JESh0Ga
         HD+haj9Qvjr4pzZTkHqywD8jmVMvU1+2wYOCWAcJRlQcSkr1LTmJiHbLcBMPKY4snDG0
         Rxm809z0lz/kUTLcxG/mwnsRr3kYJqS/0LToLn9b3BYiiKcaxm5mMH6v/8RTRLQORejI
         CcDcTlgbe0kpONC6vETK4LXr/GRR/mainomC/1hP2wUFWJaLRfpSkF+BlNemgdLvej94
         6+iA==
X-Gm-Message-State: APjAAAVAc8jI+ii4GZOn8fzT5E1ioZONUbyU8IY/iNsCDgWyM2+VH4mU
        uzAyzCVew6xuoI1IYuHCzhtcUw==
X-Google-Smtp-Source: APXvYqzfns8ljtcO2JFCJbXZPLfVUE3/cIm6iWQjaO8uPfYNRqQtNCFlZrZCPQFtsUY9k/vw/Qrh2A==
X-Received: by 2002:ac8:ff6:: with SMTP id f51mr3262879qtk.60.1579192796991;
        Thu, 16 Jan 2020 08:39:56 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id u55sm11877069qtc.28.2020.01.16.08.39.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Jan 2020 08:39:55 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1is8BW-00072p-LF; Thu, 16 Jan 2020 12:39:54 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-mm@kvack.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 0/3] Rename variables in mmu_notifier.c
Date:   Thu, 16 Jan 2020 12:39:42 -0400
Message-Id: <20200116163945.26956-1-jgg@ziepe.ca>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

Linus has observed that the variable names here do not make a lot of sense,
revise them as discussed so the file has better readability.

The new names are:

  struct mmu_notifier_mm -> struct mmu_notifier_subscriptions
  mmu_notifier_mm or mmn_mm -> subscriptions
   The per mm_struct memory that holds all the notifier subscription list
   heads and interval tree

  mn -> subscription (of type struct mmu_notifier)
   A list based subscription to notifications

  mni -> interval_sub (of type struct mmu_interval_notifier)
   A VA interval based subscription to notifications

I had originaly thought to also change the struct names, and while they are
not ideal, it seems that the resulting tree wide churn is probably not
worthwhile considering the size.

This is intended to have no functional change.

Jason Gunthorpe (3):
  mm/mmu_notifier: Rename struct mmu_notifier_mm to
    mmu_notifier_subscriptions
  mm/mmu_notifiers: Use 'subscription' as the variable name for
    mmu_notifier
  mm/mmu_notifiers: Use 'interval_sub' as the variable for
    mmu_interval_notifier

 Documentation/vm/hmm.rst     |  20 +-
 include/linux/mm_types.h     |   2 +-
 include/linux/mmu_notifier.h |  86 ++---
 kernel/fork.c                |   4 +-
 mm/debug.c                   |   4 +-
 mm/mmu_notifier.c            | 585 +++++++++++++++++++----------------
 6 files changed, 375 insertions(+), 326 deletions(-)

-- 
2.24.1

