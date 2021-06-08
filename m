Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0354939EDB7
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 06:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbhFHEbT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 00:31:19 -0400
Received: from mail-oo1-f53.google.com ([209.85.161.53]:41914 "EHLO
        mail-oo1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhFHEbT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Jun 2021 00:31:19 -0400
Received: by mail-oo1-f53.google.com with SMTP id k21-20020a4a2a150000b029024955603642so2536935oof.8
        for <linux-rdma@vger.kernel.org>; Mon, 07 Jun 2021 21:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sl7T+fvX7qRvyWGHYu1l/KcviCGBWzjGLG+EJxkn4so=;
        b=YcPiyUlWVr3R8gBM+poEi9RP4JVu94V+iunM3ToPWQ2DkJK/P9pdWxIPKqCmQvqbTu
         BEkN9Xo3DPRqK64mm0q75co977KDFIna5rbIzplt+h66ZndELY5UnLR8Ni7RVbB29iBU
         xU9JW+aWpIwDXZw0pOB2ynGeiVJMkTot0cGwajrRCalyvKRqXfd0/OGVREg/if6SQWtr
         qqS8Te8tqovWv6Ezw62m1oRQ35u6TZ2+7M3WM2CKlf5v2FDC2/Lu2NbXgWF/vLhAwjn1
         WcECHbxvXTtTv36I7lI9ZlfKlWan/i35+ShnE1F94CUokckLs0Gwjm7RaTcZn4Alttgy
         aQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sl7T+fvX7qRvyWGHYu1l/KcviCGBWzjGLG+EJxkn4so=;
        b=IoaG7z95LuJFf05LqAdTlUA9L6XlRg74zuYMWC2usJ0nhWPrueWITsDUUXAfFyoif8
         qoIVcPT+oqdkFmNgZsjlSMKR2Hn6945hNEiNP3z1C7Z56H5h3WiDDcDfCITJm9oOthQA
         Iwe3GWw6yN3vpk4BfCMdv/olJynwE+zA0PKn4T7aWbApxDK9EymDmqQmeVfKDKVae+v7
         4IAuZ4/wZaZ3FzTShnoLTt6g/tQP3PcFT1kCewNeAi/ps5NfbTwNLHL1vZaSqAJCzhFP
         fdUwQFZjoew5X9KQfSq5/aC8zLKXw2SojfR8wS+M7KltUoKD5gBNrUe6u9T4zhqTseP/
         83pw==
X-Gm-Message-State: AOAM530a/2+kwgdt/ZU5Rq40uufnTVLl3BTN1xUZ75L1xPot0M7+qMx1
        KyZgiGva5F4gSoquRxkEonc=
X-Google-Smtp-Source: ABdhPJzL0GG6KpwI97ng5mKX/rBhmOwmCxF7OPjZeOJ+i50PO8YQ/7KFCdPZe8SjBiFaDkZioN3mBw==
X-Received: by 2002:a4a:ba87:: with SMTP id d7mr15853583oop.6.1623126495077;
        Mon, 07 Jun 2021 21:28:15 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-cb25-4f27-0965-41cc.res6.spectrum.com. [2603:8081:140c:1a00:cb25:4f27:965:41cc])
        by smtp.gmail.com with ESMTPSA id m23sm2505025otk.55.2021.06.07.21.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 21:28:14 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, monis@mellanox.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH v2 1/2] Update kernel headers
Date:   Mon,  7 Jun 2021 23:28:02 -0500
Message-Id: <20210608042802.33419-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210608042802.33419-1-rpearsonhpe@gmail.com>
References: <20210608042802.33419-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

To commit ?? ("RDMA/rxe: Disallow MR dereg and invalidate when bound").

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 kernel-headers/rdma/rdma_user_rxe.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel-headers/rdma/rdma_user_rxe.h b/kernel-headers/rdma/rdma_user_rxe.h
index 068433e2..e283c222 100644
--- a/kernel-headers/rdma/rdma_user_rxe.h
+++ b/kernel-headers/rdma/rdma_user_rxe.h
@@ -99,7 +99,16 @@ struct rxe_send_wr {
 			__u32	remote_qkey;
 			__u16	pkey_index;
 		} ud;
+		struct {
+			__aligned_u64	addr;
+			__aligned_u64	length;
+			__u32		mr_lkey;
+			__u32		mw_rkey;
+			__u32		rkey;
+			__u32		access;
+		} mw;
 		/* reg is only used by the kernel and is not part of the uapi */
+#ifdef __KERNEL__
 		struct {
 			union {
 				struct ib_mr *mr;
@@ -108,6 +117,7 @@ struct rxe_send_wr {
 			__u32	     key;
 			__u32	     access;
 		} reg;
+#endif
 	} wr;
 };
 
-- 
2.30.2

