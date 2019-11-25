Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 706B11090F4
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Nov 2019 16:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbfKYPXR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Nov 2019 10:23:17 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35716 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbfKYPXR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Nov 2019 10:23:17 -0500
Received: by mail-pg1-f194.google.com with SMTP id k32so7357346pgl.2
        for <linux-rdma@vger.kernel.org>; Mon, 25 Nov 2019 07:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=rpV8GeJ7bhv6dhEsFYSsjNIBrn9T/ar7rzhk6vUMg7k=;
        b=ysoDYKogWEXeHWovy13jZKYeM8qRAzcY+d4nhIeCoTH7nxsva1cyhld5swjX5s7m2U
         CQ260KJr0vLog7Xgm5eF0R5lnRSm9jp3LNo29ssEyjmTeT+/btwcnZ1u7uqV3wjlqSe9
         UkG4JbEmpD50/LN/040SeGp7RFsdJSCggfrTIKXDwzbeJu70Ims7vcNGpgt7wU56tErz
         Z1BrQHoy5L285hBeB5EQIM7vNlRLDnFOrSHWE5xqLxco8QGgpnzU3rsOKyNtPNnjn8dj
         zNbkuJh9PwgWPduAIe6xfaPGTe2px0SdeqjXSk1HXJdD0cxeAuvAM5NWi+bWiQKupU9x
         fCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rpV8GeJ7bhv6dhEsFYSsjNIBrn9T/ar7rzhk6vUMg7k=;
        b=PAIos3j6AHSt8ap4tWzwpheOpSemvQdlUFllpLCSFNGkluKQg/dZjUW6AnLUqjhQot
         nrwKcJlbh5DSOTVAuJrzTtRiPqpwzbNudc+UZxavOrABipCQsPysuEmPKtziZua6pI/r
         +Cn22zAIrL1ngYs5C/g/QxcFMGKjgIH7QemH2dmvJQ5+xhyCThn2H9FsVYiddWTIm3E0
         89rJN6u1ZbXIO+LwSs211d7U34DNQ74smOPt5NiEMLZgenepIhkVBromDhUSv83GAitS
         a2RfCpsCACsktm4MzztlkHd6UnUviYdJyabE4jZ0ndRXHYpOO7gTt4wVsiFusucRrXkJ
         RaMw==
X-Gm-Message-State: APjAAAWNSbyHGxHnYZzmPhmqLLUuXoRH245pXo6DE33r+hLeSh8A2SfM
        PIR2eESPM8muwJo0inv4wJFWnWS0HmaYiw==
X-Google-Smtp-Source: APXvYqwp0wXd7YbwdEFcSgwyeo/hRsDbBhdOjFEm33z2HY/cA4HNDa/LBDKpm1L5UGvLdRsDs6crYw==
X-Received: by 2002:a65:6149:: with SMTP id o9mr32824620pgv.228.1574695396490;
        Mon, 25 Nov 2019 07:23:16 -0800 (PST)
Received: from driver-dev1.pensando.io ([12.1.37.26])
        by smtp.gmail.com with ESMTPSA id p123sm9113662pfg.30.2019.11.25.07.23.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Nov 2019 07:23:09 -0800 (PST)
From:   Andrew Boyer <aboyer@pensando.io>
To:     linux-rdma@vger.kernel.org
Cc:     Andrew Boyer <aboyer@pensando.io>, allenbh@pensando.io
Subject: [PATCH] rdma-core: Recognize IBV_DEVICE_LOCAL_DMA_LKEY in ibv_devinfo
Date:   Mon, 25 Nov 2019 07:22:37 -0800
Message-Id: <20191125152237.19084-1-aboyer@pensando.io>
X-Mailer: git-send-email 2.17.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This bit is defined in the kernel but not displayed by ibv_devinfo.

Signed-off-by: Andrew Boyer <aboyer@pensando.io>
---
 libibverbs/examples/devinfo.c | 3 +++
 libibverbs/verbs.h            | 1 +
 2 files changed, 4 insertions(+)

diff --git a/libibverbs/examples/devinfo.c b/libibverbs/examples/devinfo.c
index bf53eac2..e3210f6e 100644
--- a/libibverbs/examples/devinfo.c
+++ b/libibverbs/examples/devinfo.c
@@ -220,6 +220,7 @@ static void print_device_cap_flags(uint32_t dev_cap_flags)
 				   IBV_DEVICE_RC_RNR_NAK_GEN |
 				   IBV_DEVICE_SRQ_RESIZE |
 				   IBV_DEVICE_N_NOTIFY_CQ |
+				   IBV_DEVICE_LOCAL_DMA_LKEY |
 				   IBV_DEVICE_MEM_WINDOW |
 				   IBV_DEVICE_UD_IP_CSUM |
 				   IBV_DEVICE_XRC |
@@ -260,6 +261,8 @@ static void print_device_cap_flags(uint32_t dev_cap_flags)
 		printf("\t\t\t\t\tSRQ_RESIZE\n");
 	if (dev_cap_flags & IBV_DEVICE_N_NOTIFY_CQ)
 		printf("\t\t\t\t\tN_NOTIFY_CQ\n");
+	if (dev_cap_flags & IBV_DEVICE_LOCAL_DMA_LKEY)
+		printf("\t\t\t\t\tLOCAL_DMA_LKEY\n");
 	if (dev_cap_flags & IBV_DEVICE_MEM_WINDOW)
 		printf("\t\t\t\t\tMEM_WINDOW\n");
 	if (dev_cap_flags & IBV_DEVICE_UD_IP_CSUM)
diff --git a/libibverbs/verbs.h b/libibverbs/verbs.h
index 7b8d4310..81e5812c 100644
--- a/libibverbs/verbs.h
+++ b/libibverbs/verbs.h
@@ -112,6 +112,7 @@ enum ibv_device_cap_flags {
 	IBV_DEVICE_RC_RNR_NAK_GEN	= 1 << 12,
 	IBV_DEVICE_SRQ_RESIZE		= 1 << 13,
 	IBV_DEVICE_N_NOTIFY_CQ		= 1 << 14,
+	IBV_DEVICE_LOCAL_DMA_LKEY	= 1 << 15,
 	IBV_DEVICE_MEM_WINDOW           = 1 << 17,
 	IBV_DEVICE_UD_IP_CSUM		= 1 << 18,
 	IBV_DEVICE_XRC			= 1 << 20,
-- 
2.17.1

