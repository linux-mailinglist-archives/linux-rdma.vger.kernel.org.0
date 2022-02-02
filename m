Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B49D4A743E
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Feb 2022 16:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240866AbiBBPJB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Feb 2022 10:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243333AbiBBPJB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Feb 2022 10:09:01 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E476CC06173B
        for <linux-rdma@vger.kernel.org>; Wed,  2 Feb 2022 07:09:00 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id h7so66646297ejf.1
        for <linux-rdma@vger.kernel.org>; Wed, 02 Feb 2022 07:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VV101sObFDwM6CwC34YWNTNDIJq/LaiaC0PaOxVs9fU=;
        b=RszBdhlpFgl4g5UjvKN5JHDKCLOqsD5zE326I7tm92SDmNJBxphdsW1FQMkiGLH0Pv
         EWj+IO0s8nTLtSZPHc1Tlk9wu7IUvgV4nYCPk50V+fsCu0+6ims/r6D1wcrTddaN3CLp
         CiJVmbZJs6Hbq9H7fE/QajW5xTOw/MaqcsdpLq10YAIYmLgTmzBdt0+ag/CTIKzeLKHF
         DIp99TljyHdZ602cYYrbj4MQ2b0uNy5VTJNFIDGtcjOeZFCayxU8r6HbK93ukRKeJ4HW
         8YO3N1Ji25U7n+KUQYIky3usCC1S4rMeP9LzQWZFvHFt/YAt0gcc4/PmRxG9051zaxWT
         AVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VV101sObFDwM6CwC34YWNTNDIJq/LaiaC0PaOxVs9fU=;
        b=ErgFEyBf33Wf8H2u5nk5lGEK6FlJdfNT8roHcagG3lpalujTIz6CRjNzePCmUKYg/H
         52XgRYIJ+Kz5VPEz3uBYNh+JgcYB5t4wkCK5YZFCctaAakJoCH8nf9U8IM0QLykBGE3+
         qKimY8M44zkPi4cAqRuzXZJGjeAyxHWL+l9DzgS8Gi/cwTe/BA0W6WFZdCQ3LsiPWuXr
         MAZXGaSepYbip4qC+ZYAu18L8fBABCkffG2EdP/kY0WCr0EdsHfnJrBBJv5aWMtmjMdU
         sLQBqTAqR309CX4DtJVIFqf2FfwSolQvsP+C4/i/ED59YE+HWJHP/AaNQNI9b+Qyz8s0
         W3Og==
X-Gm-Message-State: AOAM533ECVFMvzZ2Y5KvDGBnbFMDbG8SwRn1L3kOcGjEYlPJ17S5u/t1
        xEiWimMkqKkCNVS7oxDzhP3/jzyqL2cTTg==
X-Google-Smtp-Source: ABdhPJw6k8/ce1uOTF+/e09MMXByO4CYsT2TpYH7jCea3cc+XYBuYQDrK2mwIleSpG+2UJidq3VbEg==
X-Received: by 2002:a17:907:3e9b:: with SMTP id hs27mr25744107ejc.72.1643814539420;
        Wed, 02 Feb 2022 07:08:59 -0800 (PST)
Received: from lb01533.fkb.profitbricks.net ([85.214.13.132])
        by smtp.gmail.com with ESMTPSA id j19sm4883625ejm.111.2022.02.02.07.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 07:08:59 -0800 (PST)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, jgg@ziepe.ca,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com
Subject: [PATCH 2/2] RDMA/rtrs-clt: Move free_permit from free_clt to rtrs_clt_close
Date:   Wed,  2 Feb 2022 16:08:55 +0100
Message-Id: <20220202150855.445973-2-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220202150855.445973-1-haris.iqbal@ionos.com>
References: <20220202150855.445973-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Error path of rtrs_clt_open calls free_clt, where free_permit is called.
This is wrong since error path of rtrs_clt_open does not need to call
free_permit.

Also, moving free_permits call to rtrs_clt_close, makes it more aligned
with the call to alloc_permit in rtrs_clt_open.

Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index d20bad345eff..c2c860d0c56e 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -2774,7 +2774,6 @@ static struct rtrs_clt_sess *alloc_clt(const char *sessname, size_t paths_num,
 
 static void free_clt(struct rtrs_clt_sess *clt)
 {
-	free_permits(clt);
 	free_percpu(clt->pcpu_path);
 
 	/*
@@ -2896,6 +2895,7 @@ void rtrs_clt_close(struct rtrs_clt_sess *clt)
 		rtrs_clt_destroy_path_files(clt_path, NULL);
 		kobject_put(&clt_path->kobj);
 	}
+	free_permits(clt);
 	free_clt(clt);
 }
 EXPORT_SYMBOL(rtrs_clt_close);
-- 
2.25.1

