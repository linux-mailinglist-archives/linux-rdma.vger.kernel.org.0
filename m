Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86DD31E599
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 01:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbfENXae (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 May 2019 19:30:34 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33216 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfENXad (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 May 2019 19:30:33 -0400
Received: by mail-qt1-f195.google.com with SMTP id m32so1223581qtf.0
        for <linux-rdma@vger.kernel.org>; Tue, 14 May 2019 16:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6i64r1iNJCkpMBuRROpIwAHO04d2faEAsMedpd2t5V4=;
        b=PdK4ENHvIAwalz41bJ1Kxt1VmUIc/msmHwNDqtM6lJKkfD5tZdONUa4Pvv/gMxk8UT
         +WUpEeTniznzDLPdjprKM61+l3erC+25XGZ9YknIbc6JNvxGI2mYrzfbWGiFnNJadvai
         toq/stNLtAFTnhv/gT1hAH/nda9VbF8BHAffQl9CpGKcaqlUT6bBb7xnz7dKUgJqVwlx
         Fg1YtMB32s6Okdo+GXcYYy9FpZJa8L33a72gRFglmlUNJdqLkWEVXvdZB0QFmEbB7YCC
         qWNKRQiXfLjE/tJoUJy1l0xziRrBO8bu0yMKMQSXdqJaXk0q/o/UhUHcrtb3bdCB4ZIj
         aD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6i64r1iNJCkpMBuRROpIwAHO04d2faEAsMedpd2t5V4=;
        b=X/9KAPTwAt+cPdvl3Eq3bkbqWEiczix+j7uazQzP9fiAzEb+wx4pf4tVDfUGmsgjxU
         dMfNU7nbR3nejCl6YUKeRGkeSIH/Uf8wxwXSyDFTj8QlLQhXJQvvzLph3HQH3+0ng0dv
         gIfpqpyRgPI6EmZBosvcjgLHTmLrYEo88Qx2ZzJHJ6Fa+e6Wn01BEJoUSlVpc3Q4JCOt
         O0VJ/+7iu1qj/k9Pz9zZSOue6RWnB5tpDWWFpoCP5UBv5z7xOoEjmB/HbipLSPPbWCAQ
         eLjzyWM0babPAT8rXGb2CxJAZpHuOojFPH4gdJBijFiz4Cq4fOqiTd2qEBY35v8u7jb5
         Bkrg==
X-Gm-Message-State: APjAAAWK7E85BRB7wRv6+zi+0N0ex5ZA4ehyWgnQr/d0oEulhHTcbArn
        s2MmjZUmSy7DCicUBKdPx4uPMg66TeM=
X-Google-Smtp-Source: APXvYqzPkqEkIWSPjxML/xmXXDEnFY9AsNeNwjj68tS7v6wV6M9IzqGcGnjHu8MHhWnPAAI7gqCYIg==
X-Received: by 2002:a0c:fe43:: with SMTP id u3mr31168592qvs.52.1557876632620;
        Tue, 14 May 2019 16:30:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id y14sm243235qth.48.2019.05.14.16.30.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 16:30:31 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hQgsQ-00014W-Kx; Tue, 14 May 2019 20:30:30 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 5/5] build: Enable more warnings
Date:   Tue, 14 May 2019 20:30:28 -0300
Message-Id: <20190514233028.3905-6-jgg@ziepe.ca>
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

The format-nonliteral option makes sure that the input to a formatting
function is actually a format string and not something else.

date-time helps ensure reproducible builds

redundant-decls, nested-externs are just general cleanlyness other
projects tend to turn on.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 CMakeLists.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index beb8f4ec123876..31100e267f2150 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -185,6 +185,10 @@ RDMA_AddOptCFlag(CMAKE_C_FLAGS HAVE_C_WMISSING_DECLARATIONS "-Wmissing-declarati
 RDMA_AddOptCFlag(CMAKE_C_FLAGS HAVE_C_WWRITE_STRINGS "-Wwrite-strings")
 RDMA_AddOptCFlag(CMAKE_C_FLAGS HAVE_C_WFORMAT_2 "-Wformat=2")
 RDMA_AddOptCFlag(CMAKE_C_FLAGS HAVE_C_WCAST_FUNCTION "-Wcast-function-type")
+RDMA_AddOptCFlag(CMAKE_C_FLAGS HAVE_C_WFORMAT_NONLITERAL "-Wformat-nonliteral")
+RDMA_AddOptCFlag(CMAKE_C_FLAGS HAVE_C_WREDUNDANT_DECLS "-Wredundant-decls")
+RDMA_AddOptCFlag(CMAKE_C_FLAGS HAVE_C_WDATE_TIME "-Wdate-time")
+RDMA_AddOptCFlag(CMAKE_C_FLAGS HAVE_C_WNESTED_EXTERNS "-Wnested-externs")
 
 # At some point after 4.4 gcc fixed shadow to ignore function vs variable
 # conflicts
-- 
2.21.0

