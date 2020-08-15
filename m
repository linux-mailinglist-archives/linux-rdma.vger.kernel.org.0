Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE512245366
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Aug 2020 00:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbgHOWBQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Aug 2020 18:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728262AbgHOVvd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 15 Aug 2020 17:51:33 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E27C0612A1
        for <linux-rdma@vger.kernel.org>; Fri, 14 Aug 2020 21:59:41 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id h22so9245224otq.11
        for <linux-rdma@vger.kernel.org>; Fri, 14 Aug 2020 21:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bl+KzOl0h1ask77zaCl2Ubc4SzpRw3GKwaNcRyo1yz0=;
        b=fH0gyA3OygtpI4VQEyUgxucN0EgGZfo6h/VQP3nKoKfITsn5fYqbZeB5MNI0KCrNh7
         DeW3Z7dJnIjOP3pR4LNqZeVZEaHkodidBIKrbXB348D1sRqa+XPFM0401LA39O0MHF+s
         IiATMtPod9mf7mgMBd61RtmGgQUub4yX1kgnCIWVSw/gUj/clXZyYyz6Wg/0ffF5r0ad
         iJAMvoLmH8UGlt9tH8zaNvuTE+mYOL/kIFzqw6PzWmYZPnr4aqCqEzqgV17EP0I3tZVW
         OJgAidRa0z3ZJQlCvl1mu1K5guDhkzRED/J6YiaciUP4Fr3C5igNNmSDp3jEyv5TraYo
         naGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bl+KzOl0h1ask77zaCl2Ubc4SzpRw3GKwaNcRyo1yz0=;
        b=dYKY/XjTtjXrCLoRo80tJ4Hm6At43xbDLj4lW7DFi7Hj6vtYkLgwHiQZnhUFATRyz+
         CFGiZLMz4wJQ89sPWuvsslPWazaI9Vo+L1xZ6wj0J72nvzJpes+x6B1mno1ny7ZlxJSC
         IOB8A8pITYWtJJ6L6pqIUiNQIstiQ7G7+mSTZB+KsC8imhG0vcB41aV+A+CWJjUXETR8
         t9KKotdr0Ab0BxW8ULjjNzDdO5U1KWTXTjSgA76wN783pUvo0rVp+fFBE0NXRUjnVwmD
         0DD1+NcJQ0yJLIMi1f0g/1Ww0mU9kuZNxK9A81V6zRQhD9HfoQTgqY3HyYn6iAB9J8vy
         Fmjg==
X-Gm-Message-State: AOAM532QF3TMv51jUKVysvVGR509XWBdPZCYODOb+LlQIA6GXFBqg33A
        UGnm9LkceJ9rwPi6gn8Vv+qTgFHg3R5vig==
X-Google-Smtp-Source: ABdhPJzo5nkoRQJzG4xz9CnM0hzImTODI21ddPGzTULjOtxYIK1+ubxR1FLpru6YyjZSRJgr9LnXww==
X-Received: by 2002:a9d:25:: with SMTP id 34mr4068930ota.343.1597467581174;
        Fri, 14 Aug 2020 21:59:41 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:b453:c5f2:2895:a54c])
        by smtp.gmail.com with ESMTPSA id b17sm2098832otj.73.2020.08.14.21.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 21:59:40 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH 03/20] Added bind_mw parameters to rxe_send_wr.
Date:   Fri, 14 Aug 2020 23:58:27 -0500
Message-Id: <20200815045912.8626-4-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200815045912.8626-1-rpearson@hpe.com>
References: <20200815045912.8626-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is a first prototype version of the user/kernel ABI extension
to add memory windows functionality to the rxe driver. It evolves
later.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 include/uapi/rdma/rdma_user_rxe.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/uapi/rdma/rdma_user_rxe.h b/include/uapi/rdma/rdma_user_rxe.h
index aae2e696bb38..f88867d85c3f 100644
--- a/include/uapi/rdma/rdma_user_rxe.h
+++ b/include/uapi/rdma/rdma_user_rxe.h
@@ -93,6 +93,14 @@ struct rxe_send_wr {
 			__u32	remote_qkey;
 			__u16	pkey_index;
 		} ud;
+		struct {
+			__aligned_u64	addr;
+			__aligned_u64	length;
+			__u32	mr_rkey;
+			__u32	mw_rkey;
+			__u32	rkey;
+			__u32	access;
+		} bind_mw;
 		/* reg is only used by the kernel and is not part of the uapi */
 		struct {
 			union {
-- 
2.25.1

