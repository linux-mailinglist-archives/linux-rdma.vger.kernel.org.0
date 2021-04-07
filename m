Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDCD1356A14
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Apr 2021 12:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbhDGKmV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Apr 2021 06:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbhDGKmU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Apr 2021 06:42:20 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB364C061756
        for <linux-rdma@vger.kernel.org>; Wed,  7 Apr 2021 03:42:10 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id mh7so16885665ejb.12
        for <linux-rdma@vger.kernel.org>; Wed, 07 Apr 2021 03:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aqJG/VYc1YAv4Kt1Bu+GcYBgqhNALjIo7C5+lsoCkt4=;
        b=aBm94YsablAAwrmIHi4MVDfuHpGVGd6Qvr8TlBT8zWhthfN98juzWNK0dlVYEdmqH7
         DxvuIjBz+UKsiAlZEzA1iJXbufh3Pwc1D1t4xsP65cj1UqyyjIiJm6OiZZyxQc64f9LZ
         LOcQ7pqYhlojfLKb5dplqpouBzgHR9NrRZaW/TCRKwysdAWv8TA3QttkKM3fErl+Ja8i
         ykjfh72Gr5Hrm0MA6X0yp3XRlNYcZis1090yRNaSzSnH2O25SNRSOBiiXdR4XRh37QGo
         sfMHTkV+tGF6GhZ86+thold++HFpIh9NDKiMuTX4dmtRs08Myr74MZbGsunbPJbzLtld
         TRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aqJG/VYc1YAv4Kt1Bu+GcYBgqhNALjIo7C5+lsoCkt4=;
        b=MwkHsRrXcazy0QIlSeXqRDWhQ/Wg9o6EOOvvrimUGopXs5U5QeQMpDND33N9nYhJe9
         kKpcAVKkUJp3EnuLQEEIb7D3vVOHYeQiFoRvkNpn1P/EKetxHL88nfd37GTJpOxrKPNL
         Al4WEoTTgKK95ID6CwPNwe3IrrRSVUZ0gbDNT07zYs/e2p+zsCsJKP9Q5x1zzCtdNc2w
         La0HT7PsJp2hVL6aWPFXODC9UFEkVcoIGYgPqJLuVUK0X8ud8y87W7UcCQ4G/sSHVmke
         X4qRhsJcO6G0vSgvHjYtUhkELEO3XrHLDtWEfPcA+sRYTwUsr/GRkFHWgxWxDCIgl/hL
         AcmA==
X-Gm-Message-State: AOAM533Gh4zUPmR0aYZrDA0hMDIbybmo913OjVf9VBinuXqW38L+IgRt
        8XU9wOaxrS/shpvtNywuQBKc9nsn4rR+xBfO
X-Google-Smtp-Source: ABdhPJyc3mpUoUe5hDoddN7G8SM6o8RAu29r0SkPuk0tGajSZC6xQyDnFELyyhgB43JAcvZq8Hg2Bg==
X-Received: by 2002:a17:906:f56:: with SMTP id h22mr2992602ejj.494.1617792129448;
        Wed, 07 Apr 2021 03:42:09 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id j1sm12359779ejt.18.2021.04.07.03.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 03:42:08 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv2 for-next 4/4] Documentation/ABI/rtrs-clt: Add descriptions for min-latency policy
Date:   Wed,  7 Apr 2021 12:42:03 +0200
Message-Id: <20210407104203.24792-5-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210407104203.24792-1-gi-oh.kim@ionos.com>
References: <20210407104203.24792-1-gi-oh.kim@ionos.com>
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

