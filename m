Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0160D1F38
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2019 06:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbfJJEI5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Oct 2019 00:08:57 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34909 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfJJEI4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Oct 2019 00:08:56 -0400
Received: by mail-pl1-f193.google.com with SMTP id c3so2122974plo.2;
        Wed, 09 Oct 2019 21:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:user-agent:date:from:to:cc:cc:subject:references
         :mime-version:content-disposition;
        bh=y0MaXs+mRSkOJcs8PQLgCvtSUgypU1y/hd5ONzhmwmU=;
        b=sTOQhqWerZyrK+5GgqwdITEWZ9EUYgBF03tFkJ5TT5124gdu9PNpGVJqigrHGo5JYf
         MYACv5wlFmAfnP1cqL73b6lYNaVaMGjXHMlYYnNbs9t2RpkeXXT01VXUdoEluu+GQFIm
         bqlUU5InSnElUgyVEYsISKE1JAyD0138FBGent7osLH0vc3mI9xGGU/S3kyn3490QQ0d
         +Vh1/AmL5nLld+iciLH5e5hrkEDNVVQTaDrs+UnE4sKqGMn4nvfOs8gT2dQSx5zcph+A
         +ISV8GMkn6O1Wqwu4DQDLjF0YItCtbrLZB5ykirRlUmxAzeS9xrOHj0cJCBRNzC5S/mI
         BcdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:user-agent:date:from:to:cc:cc:subject
         :references:mime-version:content-disposition;
        bh=y0MaXs+mRSkOJcs8PQLgCvtSUgypU1y/hd5ONzhmwmU=;
        b=AYGYp1a/sMMcVrjdiTbXyAEBJ7kVrblMjfkb81iq8sHkTvU6podtAi8wuPAcaduzaN
         x3XN3J95TM61nfBnMHUTuCPaRKvbygMHJ1b6rAVnuCXKTCwAiExKkYGxCNCBtHfhWF2O
         IY+iC8Va/CoXaupQGohXrflILNgE2s5ZEzRx9sQvmsKmt4hr07FM3JMEymZ+kQt88Slr
         WZHO9UgSCORCxgJEJ2N/1WkLCEjuXIDKCZD491rjBnvfJC3U4qGkHw8n5cEI3QtJTgzy
         VuT6V/Sj3S6RIuoo3NecGKS0vBbTdVA4H/XcmiaVMYK7LhRFQSzbC+IS3lDNnLRLJmBg
         /X4A==
X-Gm-Message-State: APjAAAUBV78RZYC9zxqoeYr/FEoX3+bQKTfYkqwCXYrSSEXSV75TAmNc
        Jt/JqtBjlYNBhI8Rrf4ffSf15Kz4
X-Google-Smtp-Source: APXvYqzjs/bXaxQGi2F4Fedc5VheBpH/xekpgV1adhQiNLJsTM3ZRZOswA7z7RMG+Bs37ojBjQYaoA==
X-Received: by 2002:a17:902:724b:: with SMTP id c11mr7057581pll.155.1570680535769;
        Wed, 09 Oct 2019 21:08:55 -0700 (PDT)
Received: from localhost ([2601:1c0:6280:3f0::9ef4])
        by smtp.gmail.com with ESMTPSA id u65sm4378733pfu.104.2019.10.09.21.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 21:08:54 -0700 (PDT)
Message-Id: <20191010035239.818405496@gmail.com>
User-Agent: quilt/0.65
Date:   Wed, 09 Oct 2019 20:52:43 -0700
From:   rd.dunlab@gmail.com
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>, linux-doc@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 04/12] infiniband: fix ulp/opa_vnic/opa_vnic_internal.h kernel-doc notation
References: <20191010035239.532908118@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=009-iband-opa-vnic-internalhdr.patch
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Remove kernel-doc notation on 4 structs since they are internal and
none of the struct fields/members are described.
This removes 45 kernel-doc warnings.

Signed-off-by: Randy Dunlap <rd.dunlab@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: linux-doc@vger.kernel.org
---
 drivers/infiniband/ulp/opa_vnic/opa_vnic_internal.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-next-20191009.orig/drivers/infiniband/ulp/opa_vnic/opa_vnic_internal.h
+++ linux-next-20191009/drivers/infiniband/ulp/opa_vnic/opa_vnic_internal.h
@@ -70,7 +70,7 @@
 
 struct opa_vnic_adapter;
 
-/**
+/*
  * struct __opa_vesw_info - OPA vnic virtual switch info
  *
  * Same as opa_vesw_info without bitwise attribute.
@@ -96,7 +96,7 @@ struct __opa_vesw_info {
 	u8   rsvd4[2];
 } __packed;
 
-/**
+/*
  * struct __opa_per_veswport_info - OPA vnic per port info
  *
  * Same as opa_per_veswport_info without bitwise attribute.
@@ -136,7 +136,7 @@ struct __opa_per_veswport_info {
 	u8   rsvd3[8];
 } __packed;
 
-/**
+/*
  * struct __opa_veswport_info - OPA vnic port info
  *
  * Same as opa_veswport_info without bitwise attribute.
@@ -146,7 +146,7 @@ struct __opa_veswport_info {
 	struct __opa_per_veswport_info    vport;
 };
 
-/**
+/*
  * struct __opa_veswport_trap - OPA vnic trap info
  *
  * Same as opa_veswport_trap without bitwise attribute.


