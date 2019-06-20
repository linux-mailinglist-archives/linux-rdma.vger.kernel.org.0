Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54CE44D181
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 17:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732078AbfFTPEN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 11:04:13 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44600 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732109AbfFTPEM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Jun 2019 11:04:12 -0400
Received: by mail-ed1-f65.google.com with SMTP id k8so5132138edr.11;
        Thu, 20 Jun 2019 08:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O+zl+CamckNzoH1pXa2JT0jH4nRQgR2JBCVTfXPCZss=;
        b=lPyOtGtQYJlzNXp5FVFU62OFDiKn/AMTDaW0WsDLI5SHaFYFIzLC8A0yxmOD3C5Fiq
         G/h1U3dgguoctw+VFfZ8/8NK9e9A8MrDfrXahUVx7IbWSsDnoEBqPJjEF27kiyH5WeuA
         K1bqWy1jfi+Rtu3+hvRXqnNbruFcWWGAFV1bsOvl85jI1Wyhd4YQ1cMwfwgivMq2wIJd
         dzHiHP3nIfTqxlH0GMd/tCexNgvVEsR6HsS7fXSWEgCQhv1BqHkZ/AmkgVzsTauYcS9k
         CgRCzlIcL09Xo0yXhkeOOu6upd6qFUMCoKvev8PkCf3/ZettMHb+/g0OHJko7giuc85+
         OaeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O+zl+CamckNzoH1pXa2JT0jH4nRQgR2JBCVTfXPCZss=;
        b=h4lJ+zP5RRnvaYoioJhMo1SY3FzFuN7EpaXLPadhWy2+ecVjx3+4VPkh6OlSWPrz3x
         kMAugZnCoJ3gDVeUUtEpEBaGluaYBnPzjKFDdae9aoLzMFRC2lNgwgOagVt5UFVjl1wi
         PxHgB5rscvl6fhBao76esmN+ygqg4rtD+HPfqsmIRMBW7mPcXHrKX3ERdu6d/5/n7Fis
         BoppIe8sOpPj8gZZFZAkrHxp7zd2me9RE+epu6aQm4rut6T6I0lNyYelU3V1xIxaGzbs
         erIMPbRQate7SiDauk2e3N3kUe66bnV0OCO9kNjTkXgHPZJeNis7ds42qtOLTlMVQK2t
         CJ4g==
X-Gm-Message-State: APjAAAUTS8J5KymPtCLXZ1te3GN8TxsledCKE14FOQuXBF9HuOpRuO36
        9tV95/hL4/c1BM3mPSRz693WvVzH7qk=
X-Google-Smtp-Source: APXvYqyNTnTxTvmC9KQ8/1uO8IJJ3qtUl/IOnO1TUG6mtR1we81wkeE3IZn/69GgquOjss1E1w8zNA==
X-Received: by 2002:a17:906:5cd:: with SMTP id t13mr5878666ejt.275.1561043050497;
        Thu, 20 Jun 2019 08:04:10 -0700 (PDT)
Received: from jwang-Latitude-5491.pb.local ([62.217.45.26])
        by smtp.gmail.com with ESMTPSA id a20sm3855817ejj.21.2019.06.20.08.04.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 08:04:09 -0700 (PDT)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, jgg@mellanox.com, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH v4 25/25] MAINTAINERS: Add maintainer for IBNBD/IBTRS modules
Date:   Thu, 20 Jun 2019 17:03:37 +0200
Message-Id: <20190620150337.7847-26-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190620150337.7847-1-jinpuwang@gmail.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Roman Pen <roman.penyaev@profitbricks.com>

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a6954776a37e..0b7fd93f738d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7590,6 +7590,20 @@ IBM ServeRAID RAID DRIVER
 S:	Orphan
 F:	drivers/scsi/ips.*
 
+IBNBD BLOCK DRIVERS
+M:	IBNBD/IBTRS Storage Team <ibnbd@cloud.ionos.com>
+L:	linux-block@vger.kernel.org
+S:	Maintained
+T:	git git://github.com/profitbricks/ibnbd.git
+F:	drivers/block/ibnbd/
+
+IBTRS TRANSPORT DRIVERS
+M:	IBNBD/IBTRS Storage Team <ibnbd@cloud.ionos.com>
+L:	linux-rdma@vger.kernel.org
+S:	Maintained
+T:	git git://github.com/profitbricks/ibnbd.git
+F:	drivers/infiniband/ulp/ibtrs/
+
 ICH LPC AND GPIO DRIVER
 M:	Peter Tyser <ptyser@xes-inc.com>
 S:	Maintained
-- 
2.17.1

