Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1595A2FF2F3
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jan 2021 19:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733004AbhAUSKy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jan 2021 13:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbhAUJq6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jan 2021 04:46:58 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0012C06179C
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 01:45:32 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id m1so376950wrq.12
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 01:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V7Dz2i0KYPfhUGY0bW4v3Nhy8U/GbOrRWsydmH19RnY=;
        b=bHnr1u+duI3VWQLf6ohZQMMuc4rLFaL4D3Udr3/9VZK7Wg7PUZ1KmWp0hEbXlXvtCk
         50ILR2oioMdQVrhb54fFsC6XMvuQsHUu7R2/Y0K420RpiHcqxb3NYHHCGqSmKxX1KB9k
         s8aC+2im1z27D8J2yp0k/qNoDSaigAW8Q9VYlHVr+C+a0BashY8c490bEBrDjVzpjpLF
         o3VviIaHRH5CFP2AjlaouNc42bcNgaHqeaopCT3ba1fxt33kzk9JZTYYlCDFFg7qvNTj
         kZg1kKuyxQ0vpR/Nofrmyq+KtfiL7AyJKOLlAKUMw297lMqaGdVU2UQCnIM0lAKoHPr9
         HIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V7Dz2i0KYPfhUGY0bW4v3Nhy8U/GbOrRWsydmH19RnY=;
        b=fu1UsHjMcwse0OqTuHNdqDSYv9RNnx+x/O5957f1nm/5Te0OwMxla5P3bULntAsbS4
         wMBFciuFzxPvqqMDMRS93JkVMALZ7No7iqCU1Inlp5+TnPbu/QkATcW09S/R46jY1SGs
         mVGHzMUpyv3pzlf9gVNx9Z6o293Pp2av5JMwaBRP3JYrS1clvNkvF+4hINdaKJUVREhd
         2bOaRdQJvdM715ZXdQF/DV0bXQ/JTLMMYPmakdZiw4pbptmpa21qRmm68fx3TwlncaPC
         XYIyfL8iYrSlO9LpLPMZysgcrzWQ8tcJT5u7y1fETraPwYidZL4Nan3RdifkDR8m8kyR
         jnhw==
X-Gm-Message-State: AOAM5334QjVfdvjIJd4B6QrO3Eix06Z+X0lK7n+xrt7kR5I8SmRAvdoz
        C6dyQpsnqnm6bcZpto02RUXTbQ==
X-Google-Smtp-Source: ABdhPJxZBxAkgrWIZFohOrkk6WlUWMvrYdfizqnTD5tJzbCbVEFXrrl439o4R4oXxSa+y8k/grYMWg==
X-Received: by 2002:a5d:650f:: with SMTP id x15mr13366848wru.332.1611222331635;
        Thu, 21 Jan 2021 01:45:31 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id a17sm8185648wrs.20.2021.01.21.01.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 01:45:31 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 08/30] RDMA/hw/qib/qib_eeprom: Fix misspelling of 'buff' in 'qib_eeprom_{read,write}()'
Date:   Thu, 21 Jan 2021 09:44:57 +0000
Message-Id: <20210121094519.2044049-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121094519.2044049-1-lee.jones@linaro.org>
References: <20210121094519.2044049-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/qib/qib_eeprom.c:55: warning: Function parameter or member 'buff' not described in 'qib_eeprom_read'
 drivers/infiniband/hw/qib/qib_eeprom.c:55: warning: Excess function parameter 'buffer' description in 'qib_eeprom_read'
 drivers/infiniband/hw/qib/qib_eeprom.c:102: warning: Function parameter or member 'buff' not described in 'qib_eeprom_write'
 drivers/infiniband/hw/qib/qib_eeprom.c:102: warning: Excess function parameter 'buffer' description in 'qib_eeprom_write'

Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/qib/qib_eeprom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_eeprom.c b/drivers/infiniband/hw/qib/qib_eeprom.c
index 5838b3bf34b99..bf660c001b6df 100644
--- a/drivers/infiniband/hw/qib/qib_eeprom.c
+++ b/drivers/infiniband/hw/qib/qib_eeprom.c
@@ -47,7 +47,7 @@
  * qib_eeprom_read - receives bytes from the eeprom via I2C
  * @dd: the qlogic_ib device
  * @eeprom_offset: address to read from
- * @buffer: where to store result
+ * @buff: where to store result
  * @len: number of bytes to receive
  */
 int qib_eeprom_read(struct qib_devdata *dd, u8 eeprom_offset,
@@ -94,7 +94,7 @@ static int eeprom_write_with_enable(struct qib_devdata *dd, u8 offset,
  * qib_eeprom_write - writes data to the eeprom via I2C
  * @dd: the qlogic_ib device
  * @eeprom_offset: where to place data
- * @buffer: data to write
+ * @buff: data to write
  * @len: number of bytes to write
  */
 int qib_eeprom_write(struct qib_devdata *dd, u8 eeprom_offset,
-- 
2.25.1

