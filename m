Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5BBC35531F
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 14:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343679AbhDFMGJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 08:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbhDFMGI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Apr 2021 08:06:08 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AEFC06174A
        for <linux-rdma@vger.kernel.org>; Tue,  6 Apr 2021 05:06:00 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id e7so16221938edu.10
        for <linux-rdma@vger.kernel.org>; Tue, 06 Apr 2021 05:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aqJG/VYc1YAv4Kt1Bu+GcYBgqhNALjIo7C5+lsoCkt4=;
        b=MpenqTlyqdgVYWpaZANqOaiL86MxOBAVqcL0vVTqFesxrBOl958VdeZadFmHL/opiG
         f6duschcZqKUu7U1nxypZEJHP5lGrZeX1JSlF06w0fIDyYKM1mxgsxRLmc52vrA4u8ZV
         pfUuCWZHUN5tjOijm9qNElUuAZL6ksddSCcIsqnYuZrF5cRZhwofmxkfiQbarHlcx2NK
         y9H6D3awIOYSlJXjjYbqfudh6Wyc2yqaYJ1X6DwLPY4pmDBHZHHwF29BaFvSrAMNpDJi
         SOh3OW5rc/M61+5JgcqWVsmpVK7YkTuRz0HeAYhGzRH97qldsT+/dvFDVhjLXL2/WXOF
         Chug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aqJG/VYc1YAv4Kt1Bu+GcYBgqhNALjIo7C5+lsoCkt4=;
        b=hzR1365S25bCdLJg2p11hwPPfq+RMemlK+WyKJCKbS+ljx46pzjx3wJf3RFVtA5s/b
         HpiOTOLvIkE1QMrWBK06QzDWjsBMHX6X67j9mOsXOTWdQ+JNich5SKzboBpLecb3cxrl
         gojLpD1wXWKgbvKMBordJL9Gnt48mjWjscIjiwQJ+5SmVZz8MMA3fMaPxqThGkVETP6Z
         xz/MjtuCpTosF1MSXIJpGx3g46jeyFUF76+eb1J0qvMBDfUlrpJK2S4+ixdFhg21P7QE
         YjVTO3wCyVksV7QozZKaIyz85cgN7d21oVu3CAIx415mUBO4yy+DEEFK7nUHLmqonwQr
         dPGw==
X-Gm-Message-State: AOAM531tHdjmkwTbjeRzHiWeFwU30flo/AU/KF3Bl4KEOKSzQXzrXbKB
        +k1D0wHtMvQf9iEmFW9lCyatS9moGxvNqTl8
X-Google-Smtp-Source: ABdhPJxwCu/JBt076vRhxSQmtqFEHq9VFkm+8MsNGYrAB6Lq1rRHZK903u4nfuN+VFtljtm4cyCcFQ==
X-Received: by 2002:a05:6402:4407:: with SMTP id y7mr37575099eda.247.1617710758658;
        Tue, 06 Apr 2021 05:05:58 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id jj15sm10987694ejc.99.2021.04.06.05.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 05:05:58 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH 4/4] Documentation/ABI/rtrs-clt: Add descriptions for min-latency policy
Date:   Tue,  6 Apr 2021 14:05:53 +0200
Message-Id: <20210406120553.197848-5-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210406120553.197848-1-gi-oh.kim@ionos.com>
References: <20210406120553.197848-1-gi-oh.kim@ionos.com>
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

