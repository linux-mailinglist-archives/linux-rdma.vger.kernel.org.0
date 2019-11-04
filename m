Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1B0EE043
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Nov 2019 13:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbfKDMnn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Nov 2019 07:43:43 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52573 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728138AbfKDMnn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Nov 2019 07:43:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572871423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=by0LJRZGbj39K8dHeEoPBdx+Y6mM9EbKDWT2TWm0iZo=;
        b=JisxScNlh0ra4gDMyzxLRczmS6q+lxU6Hjw334LN0v4rNpcNXFZt01kSQIdat6PXK3pwR9
        kQQ04FvD52phfW4QPNbIDaaVHyc4TrbIjHbAWgtRJspoFlxG9MU/9YEKceHh0vWGVLxbJw
        sA54Yc+OXy/X3ijbBFqEefXaljIg8/g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-U6HVbOMqNu-WA_nfEpHEwg-1; Mon, 04 Nov 2019 07:43:39 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A180D1005500;
        Mon,  4 Nov 2019 12:43:38 +0000 (UTC)
Received: from dhcp-128-227.nay.redhat.com (unknown [10.66.128.227])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 556275D6C8;
        Mon,  4 Nov 2019 12:43:35 +0000 (UTC)
From:   Honggang LI <honli@redhat.com>
To:     jlbec@evilplan.org, hch@lst.de
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        bvanassche@acm.org, Honggang Li <honli@redhat.com>
Subject: [PATCH] configfs: calculate the depth of parent item
Date:   Mon,  4 Nov 2019 20:43:22 +0800
Message-Id: <20191104124322.31226-1-honli@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: U6HVbOMqNu-WA_nfEpHEwg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Honggang Li <honli@redhat.com>

When create symbolic link, create_link should calculate the depth
of the parent item. However, both the first and second parameters
of configfs_get_target_path had been set to the target. Broken
symbolic link created.

$ targetcli ls /
o- / ............................................................. [...]
  o- backstores .................................................. [...]
  | o- block ...................................... [Storage Objects: 0]
  | o- fileio ..................................... [Storage Objects: 2]
  | | o- vdev0 .......... [/dev/ramdisk1 (16.0MiB) write-thru activated]
  | | | o- alua ....................................... [ALUA Groups: 1]
  | | |   o- default_tg_pt_gp ........... [ALUA state: Active/optimized]
  | | o- vdev1 .......... [/dev/ramdisk2 (16.0MiB) write-thru activated]
  | |   o- alua ....................................... [ALUA Groups: 1]
  | |     o- default_tg_pt_gp ........... [ALUA state: Active/optimized]
  | o- pscsi ...................................... [Storage Objects: 0]
  | o- ramdisk .................................... [Storage Objects: 0]
  o- iscsi ................................................ [Targets: 0]
  o- loopback ............................................. [Targets: 0]
  o- srpt ................................................. [Targets: 2]
  | o- ib.e89a8f91cb3200000000000000000000 ............... [no-gen-acls]
  | | o- acls ................................................ [ACLs: 2]
  | | | o- ib.e89a8f91cb3200000000000000000000 ........ [Mapped LUNs: 2]
  | | | | o- mapped_lun0 ............................. [BROKEN LUN LINK]
  | | | | o- mapped_lun1 ............................. [BROKEN LUN LINK]
  | | | o- ib.e89a8f91cb3300000000000000000000 ........ [Mapped LUNs: 2]
  | | |   o- mapped_lun0 ............................. [BROKEN LUN LINK]
  | | |   o- mapped_lun1 ............................. [BROKEN LUN LINK]
  | | o- luns ................................................ [LUNs: 2]
  | |   o- lun0 ...... [fileio/vdev0 (/dev/ramdisk1) (default_tg_pt_gp)]
  | |   o- lun1 ...... [fileio/vdev1 (/dev/ramdisk2) (default_tg_pt_gp)]
  | o- ib.e89a8f91cb3300000000000000000000 ............... [no-gen-acls]
  |   o- acls ................................................ [ACLs: 0]
  |   o- luns ................................................ [LUNs: 0]
  o- vhost ................................................ [Targets: 0]

Fixes: e9c03af21cc7 ("configfs: calculate the symlink target only once")
Signed-off-by: Honggang Li <honli@redhat.com>
---
 fs/configfs/symlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/configfs/symlink.c b/fs/configfs/symlink.c
index dc5dbf6a81d7..cb61467478ca 100644
--- a/fs/configfs/symlink.c
+++ b/fs/configfs/symlink.c
@@ -101,7 +101,7 @@ static int create_link(struct config_item *parent_item,
 =09}
 =09target_sd->s_links++;
 =09spin_unlock(&configfs_dirent_lock);
-=09ret =3D configfs_get_target_path(item, item, body);
+=09ret =3D configfs_get_target_path(parent_item, item, body);
 =09if (!ret)
 =09=09ret =3D configfs_create_link(target_sd, parent_item->ci_dentry,
 =09=09=09=09=09   dentry, body);
--=20
2.21.0

