Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05F42D1F3C
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2019 06:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfJJEJI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Oct 2019 00:09:08 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43246 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfJJEJI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Oct 2019 00:09:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id i32so2775527pgl.10;
        Wed, 09 Oct 2019 21:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:user-agent:date:from:to:cc:cc:subject:references
         :mime-version:content-disposition;
        bh=jtr03bGgZw5IslCdmLLhuzI0Kj9TNACGiJjgs4EHyo0=;
        b=ms9A6BOUvSQaVEbsd+9Uy6B+Udv9+NDhIth3UT3pqEnf2ZL9MYXJF6s04V4wb5ru/U
         VRWEhgxN0X5NiTj5LJdPZzJJRwB9O/w8Ay6fFRf5n3rBZT1Ga8SQ75wSWjTTu7u8XoT6
         5+g/DPhMJE7E/qRdPlmCnZVFAMw0iHOGQ/0ZGj9CUSPcJcR34f5Qkl4lCMHplOieJoaO
         OPpYiOMKMCHInGbwTOEJ0r6o37MS300G+6aqsAZoku+ZyRO/N4QMTsCAf4wWmWh40eZ9
         m7rBhSdQqaVRfhC9H2HeV9XSkhhvTKEsbWuHOSOhIEXa2K59S+ckl7QRCDPL6u4lL95c
         W0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:user-agent:date:from:to:cc:cc:subject
         :references:mime-version:content-disposition;
        bh=jtr03bGgZw5IslCdmLLhuzI0Kj9TNACGiJjgs4EHyo0=;
        b=bfk6FDIm93VrgCORZCupg+fCztp4Z+BRO2xfedjoA7SK0ZCsW9n/aGEgwULSc7G9xb
         YQXL/yKyWuMSdktlcW3Yi7G0nzq11fXqolCSr2R1Sp3Wdp7b0ccodRLXeGjvJAiulf1a
         WEsyxtiflFuItcL6RsNBoIBmOXtGCdTJd8DCggG2+VAiL2LcxEXr4wwWULg6Ae+tP09p
         M+oe0cfEeIk6BudJ8W6JYP3JwikYddr8yQkT+6B9qEACxlW1FuCKtrh+6cgEjDSgvNBj
         PUir5u3k0US4ORmbU8w4Y2ac5/va3kgySKBPxFuKYKS1dvvAxtQlKDxh2xfs41XCU9sk
         SMtQ==
X-Gm-Message-State: APjAAAUj3Ofc5912YOF0tWyRV4Lycm76PBwQKn9Ok1V2R8PmiKx/aDJ5
        kf1nqO6c4GYH9TLGSN8LfFTpxoIq
X-Google-Smtp-Source: APXvYqwnS0eEnyZTn9p9LOhjEFh54iOJk0m/C0M4ceNRQ792dyDgBUiOkFxnMuMkdOiLka0zhyDXdA==
X-Received: by 2002:a17:90a:246e:: with SMTP id h101mr8536804pje.133.1570680547437;
        Wed, 09 Oct 2019 21:09:07 -0700 (PDT)
Received: from localhost ([2601:1c0:6280:3f0::9ef4])
        by smtp.gmail.com with ESMTPSA id a11sm4697168pfg.94.2019.10.09.21.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 21:09:05 -0700 (PDT)
Message-Id: <20191010035239.950150496@gmail.com>
User-Agent: quilt/0.65
Date:   Wed, 09 Oct 2019 20:52:45 -0700
From:   rd.dunlab@gmail.com
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>, linux-doc@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 06/12] infiniband: fix ulp/srpt/ib_srpt.h kernel-doc notation
References: <20191010035239.532908118@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=011-iband-ulp-srpthdr.patch
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fix kernel-doc warnings (typos or renames) in ib_srpt.h:

../drivers/infiniband/ulp/srpt/ib_srpt.h:419: warning: Function parameter or member 'port_guid_id' not described in 'srpt_port'
../drivers/infiniband/ulp/srpt/ib_srpt.h:419: warning: Function parameter or member 'port_gid_id' not described in 'srpt_port'

Signed-off-by: Randy Dunlap <rd.dunlab@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: linux-doc@vger.kernel.org
---
 drivers/infiniband/ulp/srpt/ib_srpt.h |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- linux-next-20191009.orig/drivers/infiniband/ulp/srpt/ib_srpt.h
+++ linux-next-20191009/drivers/infiniband/ulp/srpt/ib_srpt.h
@@ -387,12 +387,9 @@ struct srpt_port_id {
  * @sm_lid:    cached value of the port's sm_lid.
  * @lid:       cached value of the port's lid.
  * @gid:       cached value of the port's gid.
- * @port_acl_lock spinlock for port_acl_list:
  * @work:      work structure for refreshing the aforementioned cached values.
- * @port_guid_tpg: TPG associated with target port GUID.
- * @port_guid_wwn: WWN associated with target port GUID.
- * @port_gid_tpg:  TPG associated with target port GID.
- * @port_gid_wwn:  WWN associated with target port GID.
+ * @port_guid_id: target port GUID
+ * @port_gid_id: target port GID
  * @port_attrib:   Port attributes that can be accessed through configfs.
  * @refcount:	   Number of objects associated with this port.
  * @freed_channels: Completion that will be signaled once @refcount becomes 0.


