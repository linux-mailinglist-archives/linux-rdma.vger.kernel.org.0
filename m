Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D580E48ED63
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jan 2022 16:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242899AbiANPsK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Jan 2022 10:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242930AbiANPsJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 Jan 2022 10:48:09 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2341C06173E
        for <linux-rdma@vger.kernel.org>; Fri, 14 Jan 2022 07:48:08 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id q9-20020a7bce89000000b00349e697f2fbso7607982wmj.0
        for <linux-rdma@vger.kernel.org>; Fri, 14 Jan 2022 07:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D/6OO29zOOdEfBttl6kPJAD668BKq3O8MGDv6y0XtGQ=;
        b=Xgvx7fcMqlgYsUhaX6BduchF43yhEDg56mnndR9/krOTzPVKY3Knc8i9sMuwcZ54+7
         DWemFXR0+PFdJ3TnWyOci/tEeTOVwwFw0J3OID3ZKGppMZb/JKp/Xv1I4aLuJ/sjGKCl
         GXiYPIHNf8Rp+kQWb/8oP7CwkFuy8wZ+KVjnfglZZ8VCwipJz+0SMEavu8+bz22K8+Fk
         CKhgwQcgutaaxLzYlxycHtgNhtHbDupPfdFZ0kHTVlB2YjjRIH5nCGQ8cXPbJCz6IpRf
         HdSC8Nh7kMnm8JwfVfrg/zmHCIo9oPcPsCCsdkyj5WjoiyWWAFF+yQDuJwFPnzxBqmSC
         IMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D/6OO29zOOdEfBttl6kPJAD668BKq3O8MGDv6y0XtGQ=;
        b=00yDkeOlTSKgilVJx2EkmORLloPyz8E0AX7StLrDI/P5K8EtlfNjMBNWVs2kjcE3OJ
         /0GLA9oX6PtOhYCv7nm2nxNtVveh8P2ygZwYCY/CrczfoZotdyTX422bn/lOo6cXY5J/
         w7fbMP1jbHQvvi2mp9DN2g3O4YjP0mbbV7d6SP7WrQYip76/1GaHvYQTOc1TOnAKI1Qq
         mLyAsxFz5Pf2OR/eDvFH9ZheE9UKHrEBkrmk3EqyYweKJ6FlA75J4dJq8blDpVczWB58
         wjvlrDLQVNVmWshIog+Mk3FuHsPOoGmr7cYK+cfzhsCUnRKAKSX/WPY06n4t928i+TcY
         EY6Q==
X-Gm-Message-State: AOAM530/gg/NGcpnWmTpMQND/UuJJ8XlvCEldYhfoxYOcjBOde70ZauC
        B9jVd7WGFXgIivjVPfBuqAUB6nU7PXpHSA==
X-Google-Smtp-Source: ABdhPJy4M/lELeiV2X2bYeY94109gDXlLWIXsHHCefQWD7SKFcfZ5FDRTzr4tx6kGbNGRt0eGESVJg==
X-Received: by 2002:a05:6402:424e:: with SMTP id g14mr9455290edb.399.1642175287025;
        Fri, 14 Jan 2022 07:48:07 -0800 (PST)
Received: from lb01533.fkb.profitbricks.net ([85.214.13.132])
        by smtp.gmail.com with ESMTPSA id x20sm2522028edd.28.2022.01.14.07.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 07:48:06 -0800 (PST)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 3/5] RDMA/rtrs-clt: fix CHECK type warnings
Date:   Fri, 14 Jan 2022 16:47:51 +0100
Message-Id: <20220114154753.983568-4-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220114154753.983568-1-haris.iqbal@ionos.com>
References: <20220114154753.983568-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gioh Kim <gi-oh.kim@ionos.com>

fix below warning
CHECK:OPEN_ENDED_LINE: Lines should not end with a '('

Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
index b4fa473b7888..d3c436ead694 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
@@ -156,8 +156,7 @@ static DEVICE_ATTR_RW(mpath_policy);
 static ssize_t add_path_show(struct device *dev,
 			     struct device_attribute *attr, char *page)
 {
-	return sysfs_emit(
-		page,
+	return sysfs_emit(page,
 		"Usage: echo [<source addr>@]<destination addr> > %s\n\n*addr ::= [ ip:<ipv4|ipv6> | gid:<gid> ]\n",
 		attr->attr.name);
 }
-- 
2.25.1

