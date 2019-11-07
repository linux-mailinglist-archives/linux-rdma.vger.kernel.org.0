Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6C2F25EE
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2019 04:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733023AbfKGDUf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Nov 2019 22:20:35 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34108 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727751AbfKGDUf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 Nov 2019 22:20:35 -0500
Received: by mail-pg1-f194.google.com with SMTP id e4so917657pgs.1
        for <linux-rdma@vger.kernel.org>; Wed, 06 Nov 2019 19:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2oC3yJJXBDl4Wr0A5jeoRouH5CPSnlYcDExtnV2jGKQ=;
        b=j7FjqYqYchtyDbwjW7ryF1WpehF5qoKiuEYjAahXifGnYIAPnQfZmD1p6vxvfB6Xlj
         CrL4M5oduRqpQcWyDaO5DOqU+GIGt9NJQaatkqIuwJL+s0jVd+rZOh8+T7eWpZ/L3ELn
         VLACicXal+IJHmJUtphKMXgviaJXuETGgbjXkI+RZE8GtZMHKb61wYvecNrdr4CVTx0q
         FWg7Y2px83ntq+Y1F5gtjh15O5g0/As2XUQPDRBMLGMoY2bCu9iw+YbV2nC0A7RrmzKc
         8Y2Ms8pzDjl6Fpw/ySvXByeADgsCSIhG9qMrMhYALp0kIXnjXdbidxA6wB8M+NHjiONq
         7Kuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2oC3yJJXBDl4Wr0A5jeoRouH5CPSnlYcDExtnV2jGKQ=;
        b=d/kp5/HxHbks2Er5KnfxdoSQqXeLLrpW7d0bYST6VLZj3u67DRehGqUzDBRVU4O62+
         DFrnf/2kCCxv9SoobRJDYWzc9fZSry7JPkm5Ht882NuzDETeqea51rRitrMT1m/n/kYG
         Foqkzm1MwGwdrTzEh1lyqPe6eeF5QhjGiEuz2N6Yc240bxyNBC1KqmJUbtFaNhWmhNbl
         s6iWQlND/vDBq4r41H7lPc8UoPKOigE0Gp2rXZPd0361Sbbfw2CyDJFBSVIr6QdRfhtM
         jZ341IG1n8pqOcgdXN1FQqZ/pXuWwV2GH7Z3kAjoNAC44LBcGScD5Vbn/8N9wqE1iuDO
         yuuQ==
X-Gm-Message-State: APjAAAVWWMkjdMjVQ7XQRy4YALmSLjSMF58R02NbJMeEfZGbzRbTYqL4
        g0iMD1Ej1Iu9GeK2w+/Q+AkZuw==
X-Google-Smtp-Source: APXvYqz0puT+Kdua5STtrjcl24wC8akQcYeHP6/4jA+rq9BMZhcU+xIEkwN6yi7p0uDufuX966jCOA==
X-Received: by 2002:a17:90a:a598:: with SMTP id b24mr1989317pjq.46.1573096834829;
        Wed, 06 Nov 2019 19:20:34 -0800 (PST)
Received: from localhost ([122.171.110.253])
        by smtp.gmail.com with ESMTPSA id x20sm441541pfa.186.2019.11.06.19.20.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 19:20:34 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] IB/qib: Validate ->show()/store() callbacks before calling them
Date:   Thu,  7 Nov 2019 08:50:25 +0530
Message-Id: <d45cc26361a174ae12dbb86c994ef334d257924b.1573096807.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The permissions of the read-only or write-only sysfs files can be
changed (as root) and the user can then try to read a write-only file or
write to a read-only file which will lead to kernel crash here.

Protect against that by always validating the show/store callbacks.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/infiniband/hw/qib/qib_sysfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/infiniband/hw/qib/qib_sysfs.c b/drivers/infiniband/hw/qib/qib_sysfs.c
index 3926be78036e..568b21eb6ea1 100644
--- a/drivers/infiniband/hw/qib/qib_sysfs.c
+++ b/drivers/infiniband/hw/qib/qib_sysfs.c
@@ -301,6 +301,9 @@ static ssize_t qib_portattr_show(struct kobject *kobj,
 	struct qib_pportdata *ppd =
 		container_of(kobj, struct qib_pportdata, pport_kobj);
 
+	if (!pattr->show)
+		return -EIO;
+
 	return pattr->show(ppd, buf);
 }
 
@@ -312,6 +315,9 @@ static ssize_t qib_portattr_store(struct kobject *kobj,
 	struct qib_pportdata *ppd =
 		container_of(kobj, struct qib_pportdata, pport_kobj);
 
+	if (!pattr->store)
+		return -EIO;
+
 	return pattr->store(ppd, buf, len);
 }
 
-- 
2.21.0.rc0.269.g1a574e7a288b

