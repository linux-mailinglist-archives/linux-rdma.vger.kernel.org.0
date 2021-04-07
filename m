Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76B9E356B54
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Apr 2021 13:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351853AbhDGLfE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Apr 2021 07:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347357AbhDGLfA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Apr 2021 07:35:00 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2662DC061756
        for <linux-rdma@vger.kernel.org>; Wed,  7 Apr 2021 04:34:51 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id h10so20385552edt.13
        for <linux-rdma@vger.kernel.org>; Wed, 07 Apr 2021 04:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aqJG/VYc1YAv4Kt1Bu+GcYBgqhNALjIo7C5+lsoCkt4=;
        b=QLlLZv4b/BPogtO4UGbFz2hWhWbOjZVgeS+y2yVkJOYlRFp/I7Ff+K7MbhNxsbf6qm
         amf5NTqC99IA6aqhlL7UFXSnssNVXCBolrDhKlFQVX1d6Ei22OxZjmX4SvRNmK33jm32
         8Ozs9mmWq3y9aVzgTPZ9zQlBk5KYEoC0ogAk4Bi7fDWGrwTpI++/zPlei7q7BI81/t1v
         FsrfKZBvhPk06gT68ZMsbvkGvJuBiexUPd0MLhnJwEjd75mKSip587LRYXJuPPJgzCQ0
         cxR5fLWaCGpku66tLtbjn5MDNS47rNP4A0FR7ivYERxNsDUMxcl42dM3E0HNVEJrWuld
         QvgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aqJG/VYc1YAv4Kt1Bu+GcYBgqhNALjIo7C5+lsoCkt4=;
        b=VqErf/N/kgXXoqw5YOnGe2OWYGC34a9nCcfOsGJzzGVKeAW9loTk86mRKgvw+vooGk
         mPiB/dcy5aawTs2oYMOB29foLuNU2Mt/2Th9USL2tPIXo1jBv3+G/gFMdp//sl0mmcNU
         qXidknyPcxC59PIbPfkaPu9MjClaiofAHna4y/4BqfFbUgc3hU/eL8Ky9jkEKL9swW+y
         JT4HVHIrQnF5CrRJbF7OXRP3Fj6OLF/RjeKIphEGz4+7azUfe2cFuoBu6JhwpBKgMsq6
         7W0GfXcC7jJBynZvQn6v95tLiB2fQu1qcutYsLCCEAzVx/Rp2IUkNaipL+bmxB5c+Cd9
         ajzg==
X-Gm-Message-State: AOAM532Ls5fT4FiSQjTXSya/1yM0PMnRqkeWKFXRrC6jZsZfYGecJOBt
        wNk4c7GOLsnS0ghMyfNDLRoyXwM59nGb9BzQ
X-Google-Smtp-Source: ABdhPJz+sZ1thj31FJ/qRemVdDdWXeI2FqARVYoP0N/fqcDtgDgPlrJR+FwD0cMnm4zR+A1XosoXAA==
X-Received: by 2002:aa7:d397:: with SMTP id x23mr3942593edq.256.1617795289837;
        Wed, 07 Apr 2021 04:34:49 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id a9sm15491186eds.33.2021.04.07.04.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 04:34:49 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv3 for-next 4/4] Documentation/ABI/rtrs-clt: Add descriptions for min-latency policy
Date:   Wed,  7 Apr 2021 13:34:44 +0200
Message-Id: <20210407113444.150961-5-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210407113444.150961-1-gi-oh.kim@ionos.com>
References: <20210407113444.150961-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

describe new multipath policy min-latency of the RTRS client.

Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 Documentation/ABI/testing/sysfs-class-rtrs-client | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-rtrs-client b/Documentation/ABI/testing/sysfs-class-rtrs-client
index 0f7165aab251..49a4157c7bf1 100644
--- a/Documentation/ABI/testing/sysfs-class-rtrs-client
+++ b/Documentation/ABI/testing/sysfs-class-rtrs-client
@@ -34,6 +34,9 @@ Description:	Multipath policy specifies which path should be selected on each IO
 		min-inflight (1):
 		    select path with minimum inflights.
 
+		min-latency (2):
+		    select path with minimum latency.
+
 What:		/sys/class/rtrs-client/<session-name>/paths/
 Date:		Feb 2020
 KernelVersion:	5.7
@@ -95,6 +98,15 @@ KernelVersion:	5.7
 Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
 Description:	RO, Contains the destination address of the path
 
+What:		/sys/class/rtrs-client/<session-name>/paths/<src@dst>/cur_latency
+Date:		Feb 2020
+KernelVersion:	5.7
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:	RO, Contains the latency time calculated by the heart-beat messages.
+		Whenever the client sends heart-beat message, it checks the time gap
+		between sending the heart-beat message and receiving the ACK.
+		This value can be changed regularly.
+
 What:		/sys/class/rtrs-client/<session-name>/paths/<src@dst>/stats/reset_all
 Date:		Feb 2020
 KernelVersion:	5.7
-- 
2.25.1

