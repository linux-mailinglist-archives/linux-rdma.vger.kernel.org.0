Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E63A3495AD
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Mar 2021 16:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbhCYPdz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Mar 2021 11:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbhCYPdf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Mar 2021 11:33:35 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF81C061763
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 08:33:32 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id dm8so2913065edb.2
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 08:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aqJG/VYc1YAv4Kt1Bu+GcYBgqhNALjIo7C5+lsoCkt4=;
        b=DT8ZbPSeZBGEvlBAF24sUsMVgArOn73FihPSMUARWYJaCwNH/Elw28LVLf+psp1ibU
         eoWwHTh4n2Opd56UI8gnH715fMDGwbhaw8CVTIGo43YjOL0cwQxq3Kdkp3twiNOTbiHR
         feOA4WLZPJWi2ozI9YuOWgz6waKabraaq7ZqTpLCr+Yr64N03T455XhVNGc8WTAmirTs
         Ht2rgL8/1oD4D7Vg3nJaMtSlDMxK3rXO4/6PW1GAVGp5JMynB1F+vm3uzKKKnrXWzvLk
         iY9wMEtjEZQI5gg1nMuMSZlePO6v5KP74hHtbFVoYzNPTtltRJckWSqUbO9LTBQaDqtK
         u15Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aqJG/VYc1YAv4Kt1Bu+GcYBgqhNALjIo7C5+lsoCkt4=;
        b=S2QmdygwN3nfeELWSNLnr+OnQHy034KUuYv/+mEKHJtNRaftYxzawxOlxqq8KVbWjD
         NdJHEHQGvGZv2gb7EnOxckE3N6JWSPxICSXbDev66QeGeDFDgYeZFLwccyheTacxt7W9
         kHCPAw+YkmOKD5YIwnK7SVJyJRMzCHTwaEM35WEv0h5kZoWNtUqJqllNn5dZljH+SHLo
         J/MR4OuWNzuAika5p7ZucCQoTqDc48lPKjqZRp4gVWnsIY7iW0gSRCG6SaPwb+bDz8uv
         qNvalqpIp6ey/w6JZkLzOpg4waQpTlhKngwenBX28rgOqnNosy74SRaFhbJ6YClrbqf4
         0qDQ==
X-Gm-Message-State: AOAM533JiUqUpQ3Uy4HeImSuhhFhf/VhsDYW7cP1laRqcfC5ydv5e8ak
        fkoO/RcDwAhHCGqCl6lBUCamMa3DuT2V9/ga
X-Google-Smtp-Source: ABdhPJyvoG0pTqKS08k7O0ZJcmAiQTqCVC/9K1+f8F0LyVHVIifDsMPgUFG9BsUkcmYzGE7YsCIq5A==
X-Received: by 2002:a05:6402:13ca:: with SMTP id a10mr9754866edx.320.1616686410907;
        Thu, 25 Mar 2021 08:33:30 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id n26sm2854750eds.22.2021.03.25.08.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:33:30 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 22/22] Documentation/ABI/rtrs-clt: Add descriptions for min-latency policy
Date:   Thu, 25 Mar 2021 16:33:08 +0100
Message-Id: <20210325153308.1214057-23-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
References: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
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

