Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B305E8179
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2019 07:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfJ2Gw5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 02:52:57 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58862 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726566AbfJ2Gw5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Oct 2019 02:52:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572331975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=oZQfAcndGvdEDdCTHQjXI+RlVKWz9xFBBEp4bpMhrgE=;
        b=Iz/x4M12XLjO6n8mjrEpA/Z+1G/ZFdlA3oNZ72p6w7YkT0IfAY5sLp8EOyLVvo62nJs3Xw
        LJi7kdV3fOr2Ka1cpbzmCKLufV4JMvEdqLTBL8DxmqB08tygU7AhSyqLXe8PbV1bS5oUR6
        HGMz2/oJBlHve8i2i3al6gpomC17CAo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-MKFSOS6nPTGZrruiIG9Idg-1; Tue, 29 Oct 2019 02:52:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B697E800C80;
        Tue, 29 Oct 2019 06:52:50 +0000 (UTC)
Received: from dhcp-128-227.nay.redhat.com (unknown [10.66.128.227])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DD4BB60863;
        Tue, 29 Oct 2019 06:52:48 +0000 (UTC)
From:   Honggang LI <honli@redhat.com>
To:     bvanassche@acm.org, dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, Honggang Li <honli@redhat.com>
Subject: [rdma-core patch v3] srp_daemon: Use maximum initiator to target IU size
Date:   Tue, 29 Oct 2019 14:52:40 +0800
Message-Id: <20191029065240.24963-1-honli@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: MKFSOS6nPTGZrruiIG9Idg-1
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

Pass remote maximum initiator to target IU size as a login parameter,
when immediate data size greater than remote maximum initiator to
target IU size.

This patch fixes backward compatibility for "ib_srp.ko" with [1]
and old srp target does not support immediate data.

[1] 547ed331bbe8 ("RDMA/srp: Add parse function for maximum
initiator to target IU size")

Signed-off-by: Honggang Li <honli@redhat.com>
---
 srp_daemon/srp_daemon.c | 57 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/srp_daemon/srp_daemon.c b/srp_daemon/srp_daemon.c
index f0bcf923..b593e245 100644
--- a/srp_daemon/srp_daemon.c
+++ b/srp_daemon/srp_daemon.c
@@ -402,6 +402,50 @@ static int is_enabled_by_rules_file(struct target_deta=
ils *target)
 }
=20
=20
+static bool use_imm_data(void)
+{
+=09bool ret =3D false;
+=09char flag =3D 0;
+=09int cnt;
+=09int fd =3D open("/sys/module/ib_srp/parameters/use_imm_data", O_RDONLY)=
;
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
+
+static bool imm_data_size_gt_send_size(__be32 send_size)
+{
+=09bool ret =3D false;
+=09unsigned int srp_max_imm_data =3D 0;
+=09unsigned int remote_max_it_ui_size =3D be32toh(send_size);
+=09FILE *fp =3D fopen("/sys/module/ib_srp/parameters/max_imm_data", "r");
+=09int cnt;
+
+=09if (fp =3D=3D NULL)
+=09=09return ret;
+
+=09cnt =3D fscanf(fp, "%d", &srp_max_imm_data);
+=09if (cnt <=3D 0) {
+=09=09fclose(fp);
+=09=09return ret;
+=09}
+
+=09if (srp_max_imm_data > remote_max_it_ui_size)
+=09=09ret =3D true;
+
+=09fclose(fp);
+=09return ret;
+}
=20
 static int add_non_exist_target(struct target_details *target)
 {
@@ -581,6 +625,19 @@ static int add_non_exist_target(struct target_details =
*target)
 =09=09}
 =09}
=20
+=09if (use_imm_data() && imm_data_size_gt_send_size(target->ioc_prof.send_=
size)) {
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
--=20
2.21.0

