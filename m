Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94D4BE4BFD
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Oct 2019 15:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394593AbfJYNXh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Oct 2019 09:23:37 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41930 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2394580AbfJYNXh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 25 Oct 2019 09:23:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572009816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/2bhEmaVPkFHaOQdT+uQ77PsPMjuxsk1XNqEdGagams=;
        b=NHFJJfkmRfiBbS22QsLxAgeZtp/fsHxcXLybHOdOQo3qAIzwvWt7T63YhaVRm5L/DHNHz8
        TFklWdBvWReiVMR5PkYNk/80oDX5gxdjN1cfbvhEQaLshFwtvjqWsWQe7QHkHj7eRvHop6
        4ebjDWKEfrHq4ejwObx1H1uxUtK8ra4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-k0Hr9pP2NxCjt4hmIvOW4Q-1; Fri, 25 Oct 2019 09:23:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C2881800DCA;
        Fri, 25 Oct 2019 13:23:32 +0000 (UTC)
Received: from dhcp-128-227.nay.redhat.com (unknown [10.66.128.227])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 418D35DAAF;
        Fri, 25 Oct 2019 13:23:30 +0000 (UTC)
From:   Honggang LI <honli@redhat.com>
To:     bvanassche@acm.org, dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, Honggang Li <honli@redhat.com>
Subject: [linux-next patch] RDMA/srp: add module parameter 'has_max_it_iu_size'
Date:   Fri, 25 Oct 2019 21:23:18 +0800
Message-Id: <20191025132318.13906-1-honli@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: k0Hr9pP2NxCjt4hmIvOW4Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Honggang Li <honli@redhat.com>

commit 882981f4a411 ("RDMA/srp: Add support for immediate data")
commit 547ed331bbe8 ("RDMA/srp: Add parse function for maximum
initiator to target IU size")

The use_imm_data kernel module parameter was introduced in kernel
v5.0 (882981f4a411). The max_it_iu_size will be introduced in kernel
v5.5 (547ed331bbe8).

We need the 'max_it_iu_size' for old SRPT, which does not support
immediate data.

The ib_srp module will emit a warning message of unknown parameter,
if we blindly append the 'max_it_iu_size' at the very end of login
string for kernel before 547ed331bbe8.

With this flag, srp_daemon will know the 'max_it_iu_size' login option
is available or not, by checking the file [1].

[1] /sys/module/ib_srp/parameters/has_max_it_iu_size

Signed-off-by: Honggang Li <honli@redhat.com>
---
 drivers/infiniband/ulp/srp/ib_srp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/s=
rp/ib_srp.c
index b7f7a5f7bd98..96434f743a91 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -74,6 +74,7 @@ static bool allow_ext_sg;
 static bool prefer_fr =3D true;
 static bool register_always =3D true;
 static bool never_register;
+static bool has_max_it_iu_size =3D true;
 static int topspin_workarounds =3D 1;
=20
 module_param(srp_sg_tablesize, uint, 0444);
@@ -103,6 +104,10 @@ module_param(register_always, bool, 0444);
 MODULE_PARM_DESC(register_always,
 =09=09 "Use memory registration even for contiguous memory regions");
=20
+module_param(has_max_it_iu_size, bool, 0444);
+MODULE_PARM_DESC(has_max_it_iu_size,
+=09=09  "Indicate the module supports max_it_iu_size login parameter");
+
 module_param(never_register, bool, 0444);
 MODULE_PARM_DESC(never_register, "Never register memory");
=20
--=20
2.21.0

