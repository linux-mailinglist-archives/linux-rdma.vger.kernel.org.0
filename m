Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71996E4C00
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Oct 2019 15:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394599AbfJYNX6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Oct 2019 09:23:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40072 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2394578AbfJYNX6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Oct 2019 09:23:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572009837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0O4a6zc1JTsovbufq82T9iZrsJZV4TRZ8krcut1tlBI=;
        b=Twdq4Jx78D0vkkqkI2LDNPb6rfE4GC6NgVH4YutxcFFRiz0S/KZjaezPBp5hqMIayimDvj
        XxW/SY7wbL8G6qL5sB9K/EJZ/z3i071l6wN4CVlvb3y82U0rVmfxjDzRd0Q/1U4Azmy2oA
        17Z2YpJz45WmD/4KpivPswzt+EvpWLg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-do_R0f2_OzCxZI92g7q-XA-1; Fri, 25 Oct 2019 09:23:53 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 095AA47B;
        Fri, 25 Oct 2019 13:23:52 +0000 (UTC)
Received: from dhcp-128-227.nay.redhat.com (unknown [10.66.128.227])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2FA3160BF4;
        Fri, 25 Oct 2019 13:23:49 +0000 (UTC)
From:   Honggang LI <honli@redhat.com>
To:     bvanassche@acm.org, dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, Honggang Li <honli@redhat.com>
Subject: [rdma-core patch v2] srp_daemon: Use maximum initiator to target IU size
Date:   Fri, 25 Oct 2019 21:23:43 +0800
Message-Id: <20191025132343.14086-1-honli@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: do_R0f2_OzCxZI92g7q-XA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Honggang Li <honli@redhat.com>

"ib_srp.ko" module with immediate data support use (8 * 1024)
as default immediate data size. When immediate data support enabled
for "ib_srp.ko" client, the default maximum initiator to target IU
size will greater than (8 * 1024). That means it also greater than
the default maximum initiator to target IU size set by old
"ib_srpt.ko" module, which does not support immediate data.

Signed-off-by: Honggang Li <honli@redhat.com>
---
 srp_daemon/srp_daemon.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/srp_daemon/srp_daemon.c b/srp_daemon/srp_daemon.c
index f0bcf923..7783b18f 100644
--- a/srp_daemon/srp_daemon.c
+++ b/srp_daemon/srp_daemon.c
@@ -402,6 +402,26 @@ static int is_enabled_by_rules_file(struct target_deta=
ils *target)
 }
=20
=20
+static bool use_imm_data(void)
+{
+=09bool ret =3D false;
+=09char flag =3D 0;
+=09int cnt;
+=09int fd =3D open("/sys/module/ib_srp/parameters/has_max_it_iu_size", O_R=
DONLY);
+
+=09if (fd < 0)
+=09=09return false;
+=09cnt =3D read(fd, &flag, 1);
+=09if (cnt !=3D 1) {
+=09=09close(fd);
+=09=09return false;
+=09}
+
+=09if (!strncmp(&flag, "Y", 1))
+=09=09ret =3D true;
+=09close(fd);
+=09return ret;
+}
=20
 static int add_non_exist_target(struct target_details *target)
 {
@@ -581,6 +601,19 @@ static int add_non_exist_target(struct target_details =
*target)
 =09=09}
 =09}
=20
+=09if (use_imm_data()) {
+=09=09len +=3D snprintf(target_config_str+len,
+=09=09=09sizeof(target_config_str) - len,
+=09=09=09",max_it_iu_size=3D%d",
+=09=09=09be32toh(target->ioc_prof.send_size));
+
+=09=09if (len >=3D sizeof(target_config_str)) {
+=09=09=09pr_err("Target config string is too long, ignoring target\n");
+=09=09=09closedir(dir);
+=09=09=09return -1;
+=09=09}
+=09}
+
 =09target_config_str[len] =3D '\0';
=20
 =09pr_cmd(target_config_str, not_connected);
@@ -1360,6 +1393,10 @@ static void print_config(struct config_t *conf)
 =09=09printf(" Print initiator_ext\n");
 =09else
 =09=09printf(" Do not print initiator_ext\n");
+=09if (use_imm_data())
+=09=09printf(" Print maximum initiator to target IU size\n");
+=09else
+=09=09printf(" Do not print maximum initiator to target IU size\n");
 =09if (conf->recalc_time)
 =09=09printf(" Performs full target rescan every %d seconds\n", conf->reca=
lc_time);
 =09else
--=20
2.21.0

