Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98AA7D1F42
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2019 06:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbfJJEJ0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Oct 2019 00:09:26 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39180 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727619AbfJJEJ0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Oct 2019 00:09:26 -0400
Received: by mail-pl1-f193.google.com with SMTP id s17so2111911plp.6;
        Wed, 09 Oct 2019 21:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:user-agent:date:from:to:cc:cc:subject:references
         :mime-version:content-disposition;
        bh=SY/nGzWCYMO/P34XA2avjPu6aFxEhpKNQ3s5FaNluPk=;
        b=cQkMp0aSJXswLcUsNxCtP9EiFMdZKD/q7ptWe5nX0LC5+tZ8N7yLNo/d3M+8b6IA+N
         pyVEmOKyk0Nw5dIuVKrFK06BgcgXVDxJQidQwj7zgNIkvH45YwMpn+d46QYzShnTp35a
         KcOzPoGd8UzIPbLdmOC/20VKMp8AyKSqsFttzExJNPxvf5D30CpC7Y/pL5oJO/Py9wv2
         aNGEviCRrO1dDww3C0Wc2iPsfvwmQ6aXFnLe0ixb0p4D5WuczBsd7GOwDB0AxV0GvNf/
         Gb1UrTVRpuNq5E/rnxrI2+T64fjw+4vXjS0EuYsZDWNGUgKpCY34wKkefL4VT/ICuR1X
         4VrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:user-agent:date:from:to:cc:cc:subject
         :references:mime-version:content-disposition;
        bh=SY/nGzWCYMO/P34XA2avjPu6aFxEhpKNQ3s5FaNluPk=;
        b=NJuBKp7L2Mjqz1JmGTE0YIcgzIGKtE/nUIXpjMeG1fVzIUq7zEJnI6QDROSNhPiakl
         n6vCc0R/THvYTpKuq/nC4exVxr/wyT2bQj24sh4XEgLs99/MufBaFhmn0SqdmJIsPpqM
         /TD705w8fWKEUK5Zd8/lcXdudWq+JZfdohqQrgyHkd41nBZbcHUCqIGmYxQNba6y+eUo
         WS59FnpTsbezXwOt4DilWvnj/59znao20xjkYKwjYbOtrg1nV0AhWAwMrwsutqh9/tJP
         C2jsUUAD59+Mm5jICZQHCoPrzteG1MbBZ4q6PBI+NoiQOOF03LIVPAwDR0Ht/5mMvpAM
         B00g==
X-Gm-Message-State: APjAAAXtpr7y2W8SLLD30RZxnbC7uhI1ezsecwpBiX+K+ZFaNzslOClP
        XkjDrfzAzKVYWslXpo8kEDqznjlN
X-Google-Smtp-Source: APXvYqyfmPxDaQnxejBdwcZ2JFgOX3SfT+8QQ518Tzm5EVoZr+TFNR56/IBqCQGG+3d7x3vOfVMzHg==
X-Received: by 2002:a17:902:9b92:: with SMTP id y18mr7064104plp.19.1570680564094;
        Wed, 09 Oct 2019 21:09:24 -0700 (PDT)
Received: from localhost ([2601:1c0:6280:3f0::9ef4])
        by smtp.gmail.com with ESMTPSA id w11sm3920340pfd.116.2019.10.09.21.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 21:09:23 -0700 (PDT)
Message-Id: <20191010035240.132033937@gmail.com>
User-Agent: quilt/0.65
Date:   Wed, 09 Oct 2019 20:52:48 -0700
From:   rd.dunlab@gmail.com
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>, linux-doc@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 09/12] infiniband: fix ulp/iser/iser_initiator.c kernel-doc warnings
References: <20191010035239.532908118@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=014-iband-iser-initor.patch
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add kernel-doc notation for missing function parameters:

../drivers/infiniband/ulp/iser/iser_initiator.c:365: warning: Function parameter or member 'conn' not described in 'iser_send_command'
../drivers/infiniband/ulp/iser/iser_initiator.c:365: warning: Function parameter or member 'task' not described in 'iser_send_command'
../drivers/infiniband/ulp/iser/iser_initiator.c:437: warning: Function parameter or member 'conn' not described in 'iser_send_data_out'
../drivers/infiniband/ulp/iser/iser_initiator.c:437: warning: Function parameter or member 'task' not described in 'iser_send_data_out'
../drivers/infiniband/ulp/iser/iser_initiator.c:437: warning: Function parameter or member 'hdr' not described in 'iser_send_data_out'

Signed-off-by: Randy Dunlap <rd.dunlab@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: linux-doc@vger.kernel.org
---
 drivers/infiniband/ulp/iser/iser_initiator.c |    5 +++++
 1 file changed, 5 insertions(+)

--- linux-next-20191009.orig/drivers/infiniband/ulp/iser/iser_initiator.c
+++ linux-next-20191009/drivers/infiniband/ulp/iser/iser_initiator.c
@@ -358,6 +358,8 @@ static inline bool iser_signal_comp(u8 s
 
 /**
  * iser_send_command - send command PDU
+ * @conn: link to matching iscsi connection
+ * @task: SCSI command task
  */
 int iser_send_command(struct iscsi_conn *conn,
 		      struct iscsi_task *task)
@@ -429,6 +431,9 @@ send_command_error:
 
 /**
  * iser_send_data_out - send data out PDU
+ * @conn: link to matching iscsi connection
+ * @task: SCSI command task
+ * @hdr: pointer to the LLD's iSCSI message header
  */
 int iser_send_data_out(struct iscsi_conn *conn,
 		       struct iscsi_task *task,


