Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8158148ED61
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jan 2022 16:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242945AbiANPsI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Jan 2022 10:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242930AbiANPsH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 Jan 2022 10:48:07 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C203CC06173E
        for <linux-rdma@vger.kernel.org>; Fri, 14 Jan 2022 07:48:06 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id w26so6965216wmi.0
        for <linux-rdma@vger.kernel.org>; Fri, 14 Jan 2022 07:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E23q1MvkuTpRAVr5v2BSE74q9xA9Ne85f+Ym78b7elE=;
        b=Dps2dX6WRnNYU0n5vlKtAtr0Fi43lMYvq6MrvAucwcPx4ipo7a+5XoO5T/0PQEz/wT
         SlMyCR5trFZ7u3+3H/OldoZtv+nQDcHNKgoCDkmimm0sdsffjpDnlVMTahxMNk5jp181
         WBL0xuHEkyUwToSWwiLXbygU+QOWAr8KjuABB491/tX4LqKwKQgrgr6MpP2QxewnuSfl
         foD4woXzpI+M0p/u1kkwL8VQEjDo9kil1r5/qMrNvE2BzYROalT7yMhLJY1bDxKoumGi
         YsP7qz7zrpwsKVBYNh/lvhG+kBTZzTFh9KwH67+QMB4qjnCfLyCF1M8+nHj9vHk4Cwty
         EUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E23q1MvkuTpRAVr5v2BSE74q9xA9Ne85f+Ym78b7elE=;
        b=1nQqmOvwDCNvt6+0X/bsfr6ZIE+cWjd1AW5GPr/nrw+w8i7vbsjITNKk4miSZubymR
         6EQsHI2TD3+tZcyX6/fUQBV7eI4zLtF5pbz/z0k+XDOc6GgqS0kKkPU6OMfrCA7mMN9d
         v9RDBNRinbtZCWtWBiXGbQe/9E7eXiezG/hYpu3brz/ucfS5v9XPkrOugmnDc0AS2app
         N/muTO5hLATjJaWoz8uR08VJB7L1EmdVEQxD6B3Tapm2xnPEBzpDmtXti5cE7vHI/KgX
         oHrqzMUj8sEtjUcXY86luSoqmK5kzFXlGS/FbJAXdWX4MdoTfvJPpPtPLeVGNvZl9C4f
         KDRw==
X-Gm-Message-State: AOAM532wBFooh2wygN+/1E+vKk8zFWY1yGyeq9nJ35+n5UpKk87lAE9W
        9z2A4ZEFhlOZkbK6beBduLuplv5Zx3e9aA==
X-Google-Smtp-Source: ABdhPJzYZalQKlZ9XfUcWtQNI320SGTAx9GBsuHKRSVwNodyvDpH7ZUaRO5hX+NKoqYhlld4zXp6JQ==
X-Received: by 2002:a05:6402:2789:: with SMTP id b9mr9573665ede.329.1642175285366;
        Fri, 14 Jan 2022 07:48:05 -0800 (PST)
Received: from lb01533.fkb.profitbricks.net ([85.214.13.132])
        by smtp.gmail.com with ESMTPSA id x20sm2522028edd.28.2022.01.14.07.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 07:48:04 -0800 (PST)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 1/5] RDMA/rtrs: fix CHECK:BRACES type warning
Date:   Fri, 14 Jan 2022 16:47:49 +0100
Message-Id: <20220114154753.983568-2-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220114154753.983568-1-haris.iqbal@ionos.com>
References: <20220114154753.983568-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gioh Kim <gi-oh.kim@ionos.com>

fix "CHECK:BRACES: Blank lines aren't necessary after an open
brace '{'" warning from checkpatch.pl

Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
index 4da889103a5f..60fa0b0160f4 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs.c
@@ -479,7 +479,6 @@ static int rtrs_str_to_sockaddr(const char *addr, size_t len,
  */
 int sockaddr_to_str(const struct sockaddr *addr, char *buf, size_t len)
 {
-
 	switch (addr->sa_family) {
 	case AF_IB:
 		return scnprintf(buf, len, "gid:%pI6",
-- 
2.25.1

