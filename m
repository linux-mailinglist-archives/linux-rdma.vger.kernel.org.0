Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D42212602
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2020 16:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbgGBOTu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Jul 2020 10:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729579AbgGBOTt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Jul 2020 10:19:49 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5DCC08C5C1
        for <linux-rdma@vger.kernel.org>; Thu,  2 Jul 2020 07:19:49 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id e13so25756074qkg.5
        for <linux-rdma@vger.kernel.org>; Thu, 02 Jul 2020 07:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=MfSYbH3CqrfcLawlnBg2z+9LcQAWL5ZikKcaVFb07go=;
        b=D8to6Ry9hCUWNAgBymTwQHnNuZyX2KV4JmzwbCfOBLEhrYGIudZQo04AHDM4Q/zxGh
         FvMEPJPhlD5+UZHPSTymsrwJVZ2/xcPBtu/0sGFXCflRGJlRrP68tzbzEh1PlBzlD82x
         xFc47KKPAh3uqqtiCVYV/y6NJMAahkh2bWz/0gcIi0ToK0b1ntScSgxoFNc/aco4/EtN
         rJkeJYC+xHG9+1pgo7aMzzs2UT2CDL3HonQ+o6eK+IkZBEyIUlg5K1nQ4S5NeQEv15yo
         8x7cDl3tp0rUSeAi3wS3xRK3rCekZ3GsKnozG+O7SMtRQcy2A/nV5AMl1vbcgqJwmar1
         ZI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=MfSYbH3CqrfcLawlnBg2z+9LcQAWL5ZikKcaVFb07go=;
        b=CeHDPe426+DBe9N2tf4e+iqJ0vTizqasl2rqREarqnx6OfCD9hUghaQV/1FIfvmp82
         wKVXt3IBk4WMFxOjvJ77+q60p17Pc8VYddI2kwAUe9gaAAWMRoI6Q6FnYogXcchpKSf3
         /9gdnS5zQtHSJkJ3wxqOmLfwz+WCF5LiCc+1jWXFjEYAfq4SzJcxsJIrHgUcy7ZIolBr
         tEYXmLYhm/f3OdqRvBwwpw0G2QIUvq8dAzKP+EOh89Izn70lt8VpVO8aG5q5CuJ6V+dQ
         f+osKC5L3sye2prbTJCtFuUcngKgR0+7T374q4J2a/BOj/ievTeK8d2Z56z8Pj10ttNI
         4ljA==
X-Gm-Message-State: AOAM53254JNfWo6TM9NsmsERZRwzgfG0A/iX++iO+K7aHaGD06i6IY1t
        GvhSjmS2GjAcO/MIOsVMTwvJ6n60
X-Google-Smtp-Source: ABdhPJwr1rdDR1180Fh2slQ8ECF9EOSnkS2eNbJzLw8oG/74mI4O/mUayBJ4J2ry3o4V+zlgxx849w==
X-Received: by 2002:a37:c246:: with SMTP id j6mr29045648qkm.444.1593699588326;
        Thu, 02 Jul 2020 07:19:48 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id j16sm8143591qtp.92.2020.07.02.07.19.47
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jul 2020 07:19:47 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 062EJkrJ016640
        for <linux-rdma@vger.kernel.org>; Thu, 2 Jul 2020 14:19:46 GMT
Subject: [PATCH] RDMA/core: Clean up tracepoint headers
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org
Date:   Thu, 02 Jul 2020 10:19:46 -0400
Message-ID: <20200702141946.3775.51943.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There's no need for core/trace.c to include rdma/ib_verbs.h twice.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 drivers/infiniband/core/trace.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/core/trace.c b/drivers/infiniband/core/trace.c
index 6c3514beac4d..31e7860d35bf 100644
--- a/drivers/infiniband/core/trace.c
+++ b/drivers/infiniband/core/trace.c
@@ -9,6 +9,4 @@
 
 #define CREATE_TRACE_POINTS
 
-#include <rdma/ib_verbs.h>
-
 #include <trace/events/rdma_core.h>

