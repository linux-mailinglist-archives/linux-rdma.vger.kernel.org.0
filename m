Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 611B01633CB
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2020 22:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgBRVEm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Feb 2020 16:04:42 -0500
Received: from mail-eopbgr70082.outbound.protection.outlook.com ([40.107.7.82]:47656
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726352AbgBRVEm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Feb 2020 16:04:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6kzSB66zxZh4PFHgslkROxvxkdhdv2NJClU5RbdCHL6rRw+MdI+2fXymlLF+yPDS/Vxbcz9686Pi8Ev5DSeQ01RqhcOpWyT2FIqyIPv4Qdw2TZRUUcTT7CRXYeZbdDo3m5bXToPKXO5BPOXmD2Tz8BKXa5MUfAfnK985IGSX1nlIJIWOLLRrkvbd5HuOX/noxHVLBf2p21q52X9C58L84y5wRKC0gUrS47RP7LraFlsWrO4vdDRIdQLQGd4mrvEe+2Nb9eLt8IrXYsagKrouYp0xFmI07qVGoblRP+zaYAAw9IWO1pwOInpbyN46C374Q+MFcW9VywtSmekjdLmhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msO1/DJzMnUuLZ+Yg8LQUFgdZ5ymLzXXBCyRTKmsgBI=;
 b=GHpZOhVEoQseOW0uqaCK2BQoLgUzZWHDP/gy2rqm46CH7dCV+PGvc0Kdp4U6K/kqtQbO1S0k0ipaTi2YICt2IvqHEIxeSd5Cp0I7MhGm+1xBXTNQh40vP/++bSqhmjCwHHuIXy2HdTA8CjrOawvPOoEN2QEUqqAp0Rp8NEOgg9poCPHP8opdFNI12Mtdfy66h5sMTRE1DRKulcHG64lsDsePCaTIGE3jzEBjtHTXE29GABf/lPwmFPVpCT7zOAniEO0p94z9aiAckSeMmTM8IKyqj9XnYLsveLDJx2/6Afido7ZOsG5FsrHKzsXZ2mPtqQRUsd/Q3RBBu9+7dV927g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msO1/DJzMnUuLZ+Yg8LQUFgdZ5ymLzXXBCyRTKmsgBI=;
 b=izgWS38dp6YeUZ1G4TiVdDANrEihAm6eW9icqNBIfA5EcAmWnAHL+LCblAT9apljLXSAOL4q4aSBvSLcOGmDsmPXq+Nt6cCEYfcUPZSIj+Av3ZcYbxZXcQ8DZZmqrCwDSZnwR+y7vo2fG9CDydTFi0yHdw5GRKy/wiMtyVH87cM=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB6205.eurprd05.prod.outlook.com (20.178.122.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.31; Tue, 18 Feb 2020 21:04:37 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 21:04:37 +0000
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR06CA0018.namprd06.prod.outlook.com (2603:10b6:208:23d::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.25 via Frontend Transport; Tue, 18 Feb 2020 21:04:36 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1j4A2i-0008Sj-VQ; Tue, 18 Feb 2020 17:04:32 -0400
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>
CC:     "syzbot+adb15cf8c2798e4e0db4@syzkaller.appspotmail.com" 
        <syzbot+adb15cf8c2798e4e0db4@syzkaller.appspotmail.com>,
        "syzbot+e5579222b6a3edd96522@syzkaller.appspotmail.com" 
        <syzbot+e5579222b6a3edd96522@syzkaller.appspotmail.com>,
        "syzbot+4b628fcc748474003457@syzkaller.appspotmail.com" 
        <syzbot+4b628fcc748474003457@syzkaller.appspotmail.com>,
        "syzbot+29ee8f76017ce6cf03da@syzkaller.appspotmail.com" 
        <syzbot+29ee8f76017ce6cf03da@syzkaller.appspotmail.com>,
        "syzbot+6956235342b7317ec564@syzkaller.appspotmail.com" 
        <syzbot+6956235342b7317ec564@syzkaller.appspotmail.com>,
        "syzbot+b358909d8d01556b790b@syzkaller.appspotmail.com" 
        <syzbot+b358909d8d01556b790b@syzkaller.appspotmail.com>,
        "syzbot+6b46b135602a3f3ac99e@syzkaller.appspotmail.com" 
        <syzbot+6b46b135602a3f3ac99e@syzkaller.appspotmail.com>,
        "syzbot+8458d13b13562abf6b77@syzkaller.appspotmail.com" 
        <syzbot+8458d13b13562abf6b77@syzkaller.appspotmail.com>,
        "syzbot+bd034f3fdc0402e942ed@syzkaller.appspotmail.com" 
        <syzbot+bd034f3fdc0402e942ed@syzkaller.appspotmail.com>,
        "syzbot+c92378b32760a4eef756@syzkaller.appspotmail.com" 
        <syzbot+c92378b32760a4eef756@syzkaller.appspotmail.com>,
        "syzbot+68b44a1597636e0b342c@syzkaller.appspotmail.com" 
        <syzbot+68b44a1597636e0b342c@syzkaller.appspotmail.com>
Subject: [PATCH] RDMA/ucma: Put a lock around every call to the rdma_cm layer
Thread-Topic: [PATCH] RDMA/ucma: Put a lock around every call to the rdma_cm
 layer
Thread-Index: AQHV5p8H4E9FGayyZkeKKgj/ShDofg==
Date:   Tue, 18 Feb 2020 21:04:36 +0000
Message-ID: <20200218210432.GA31966@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR06CA0018.namprd06.prod.outlook.com
 (2603:10b6:208:23d::23) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.68.57.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 35c5b9ef-d40e-4a52-62ea-08d7b4b62952
x-ms-traffictypediagnostic: VI1PR05MB6205:
x-microsoft-antispam-prvs: <VI1PR05MB6205DB988D6FC0F99723352FCF110@VI1PR05MB6205.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 031763BCAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(366004)(396003)(136003)(346002)(189003)(199004)(66946007)(66476007)(66556008)(1076003)(66446008)(64756008)(7416002)(9686003)(186003)(52116002)(5660300002)(4326008)(26005)(2906002)(54906003)(316002)(36756003)(9786002)(9746002)(8936002)(8676002)(110136005)(81166006)(81156014)(86362001)(478600001)(71200400001)(33656002)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6205;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lgw89vLi4TvnyzSHsstOA6sIalU+MRN7QgJUPzjGkQxGyFhKuXBlkceISHDxC9Y4hWWhmJD46oYtm9bDzD3EwCl7Gc5wvEcpvhlOtRZNzl1svSNGh3uhO1UL/ohTw8CgYKMto2Z+pyEEfS1kr4sQhNvJNm0CObuQzSeYGYkS5c4VykArRBkOUjgdKpw/OaXQEIQflyu+8P3bsuNkuxJzsEvLXue59AiKlSPqo73wYvLN34WbFqkt8YBYGmhjeW5H1X+cvFlYABdQf0ZiPpxy349EY2QKgGpmmAzvWJAgzcmafjTqLq7VoVWNnZNXDGS/2lmWWO4/Da5ulyVa13E7Qe/1CytIvUjUskiY7/0v1/HKrPvoQf3QAzvPY/aBqGmEvk+Z9qKRfn7V8hsHzCN1euGtAT2kuyuPxzjEAkKcg06g5VpZYdW7z7VGU+QlrUKdDkGupSXuK2gPBu2XtOkaLdgwTCbAVN3KfsLpd6DyhI/C874MgmOGZHJPx/jwkyYJ
x-ms-exchange-antispam-messagedata: MAdSMqeQ7iOwAkeTYLAm/8VlLlddgZyXNHTIK3KKsn0cwfRYjZb5QZDEc1IkmeT9r+UloUTb3NqRKW59bjQvfjz0zjd/vU5OsIrhX7nRW02K4IWYo81XLbpIrdAIJd8p1WCn/xT8V5zBq7rrSCwTHA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1484282F0BE9C745B0286AEDCDE5BF1D@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c5b9ef-d40e-4a52-62ea-08d7b4b62952
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2020 21:04:36.9505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B8Em344LugMXpOBoQispNPm/Te0hDHjmPpmEuJa56+pOY1XzdtktKwt5lITJcG/MGGABcdhx2qyG4waOmug/7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6205
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The rdma_cm must be used single threaded.

This appears to be a bug in the design, as it does have lots of locking
that seems like it should allow concurrency. However, when it is all said
and done every single place that uses the cma_exch() scheme is broken, and
all the unlocked reads from the ucma of the cm_id data are wrong too.

syzkaller has been finding endless bugs related to this.

Fixing this in any elegant way is some enormous amount of work. Take a
very big hammer and put a mutex around everything to do with the
ucma_context at the top of every syscall.

Fixes: 75216638572f ("RDMA/cma: Export rdma cm interface to userspace")
Reported-by: syzbot+adb15cf8c2798e4e0db4@syzkaller.appspotmail.com
Reported-by: syzbot+e5579222b6a3edd96522@syzkaller.appspotmail.com
Reported-by: syzbot+4b628fcc748474003457@syzkaller.appspotmail.com
Reported-by: syzbot+29ee8f76017ce6cf03da@syzkaller.appspotmail.com
Reported-by: syzbot+6956235342b7317ec564@syzkaller.appspotmail.com
Reported-by: syzbot+b358909d8d01556b790b@syzkaller.appspotmail.com
Reported-by: syzbot+6b46b135602a3f3ac99e@syzkaller.appspotmail.com
Reported-by: syzbot+8458d13b13562abf6b77@syzkaller.appspotmail.com
Reported-by: syzbot+bd034f3fdc0402e942ed@syzkaller.appspotmail.com
Reported-by: syzbot+c92378b32760a4eef756@syzkaller.appspotmail.com
Reported-by: syzbot+68b44a1597636e0b342c@syzkaller.appspotmail.com
Cc: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/core/ucma.c | 50 ++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-=
rc

Lets see if I told syzkaller about this properly..

EricB: If there are other rdma_cm related hits in syzkaller besides
these 11 lets include them as  well. I wasn't able to find a way to
search for things, this list is from your past email, thanks.

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.=
c
index 4b72a3f7c134b2..0e8846ab86b5b6 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -91,6 +91,7 @@ struct ucma_context {
=20
 	struct ucma_file	*file;
 	struct rdma_cm_id	*cm_id;
+	struct mutex		mutex;
 	u64			uid;
=20
 	struct list_head	list;
@@ -216,6 +217,7 @@ static struct ucma_context *ucma_alloc_ctx(struct ucma_=
file *file)
 	init_completion(&ctx->comp);
 	INIT_LIST_HEAD(&ctx->mc_list);
 	ctx->file =3D file;
+	mutex_init(&ctx->mutex);
=20
 	if (xa_alloc(&ctx_table, &ctx->id, ctx, xa_limit_32b, GFP_KERNEL))
 		goto error;
@@ -589,6 +591,7 @@ static int ucma_free_ctx(struct ucma_context *ctx)
 	}
=20
 	events_reported =3D ctx->events_reported;
+	mutex_destroy(&ctx->mutex);
 	kfree(ctx);
 	return events_reported;
 }
@@ -658,7 +661,10 @@ static ssize_t ucma_bind_ip(struct ucma_file *file, co=
nst char __user *inbuf,
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
=20
+	mutex_lock(&ctx->mutex);
 	ret =3D rdma_bind_addr(ctx->cm_id, (struct sockaddr *) &cmd.addr);
+	mutex_unlock(&ctx->mutex);
+
 	ucma_put_ctx(ctx);
 	return ret;
 }
@@ -681,7 +687,9 @@ static ssize_t ucma_bind(struct ucma_file *file, const =
char __user *inbuf,
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
=20
+	mutex_lock(&ctx->mutex);
 	ret =3D rdma_bind_addr(ctx->cm_id, (struct sockaddr *) &cmd.addr);
+	mutex_unlock(&ctx->mutex);
 	ucma_put_ctx(ctx);
 	return ret;
 }
@@ -705,8 +713,10 @@ static ssize_t ucma_resolve_ip(struct ucma_file *file,
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
=20
+	mutex_lock(&ctx->mutex);
 	ret =3D rdma_resolve_addr(ctx->cm_id, (struct sockaddr *) &cmd.src_addr,
 				(struct sockaddr *) &cmd.dst_addr, cmd.timeout_ms);
+	mutex_unlock(&ctx->mutex);
 	ucma_put_ctx(ctx);
 	return ret;
 }
@@ -731,8 +741,10 @@ static ssize_t ucma_resolve_addr(struct ucma_file *fil=
e,
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
=20
+	mutex_lock(&ctx->mutex);
 	ret =3D rdma_resolve_addr(ctx->cm_id, (struct sockaddr *) &cmd.src_addr,
 				(struct sockaddr *) &cmd.dst_addr, cmd.timeout_ms);
+	mutex_unlock(&ctx->mutex);
 	ucma_put_ctx(ctx);
 	return ret;
 }
@@ -752,7 +764,9 @@ static ssize_t ucma_resolve_route(struct ucma_file *fil=
e,
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
=20
+	mutex_lock(&ctx->mutex);
 	ret =3D rdma_resolve_route(ctx->cm_id, cmd.timeout_ms);
+	mutex_unlock(&ctx->mutex);
 	ucma_put_ctx(ctx);
 	return ret;
 }
@@ -841,6 +855,7 @@ static ssize_t ucma_query_route(struct ucma_file *file,
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
=20
+	mutex_lock(&ctx->mutex);
 	memset(&resp, 0, sizeof resp);
 	addr =3D (struct sockaddr *) &ctx->cm_id->route.addr.src_addr;
 	memcpy(&resp.src_addr, addr, addr->sa_family =3D=3D AF_INET ?
@@ -864,6 +879,7 @@ static ssize_t ucma_query_route(struct ucma_file *file,
 		ucma_copy_iw_route(&resp, &ctx->cm_id->route);
=20
 out:
+	mutex_unlock(&ctx->mutex);
 	if (copy_to_user(u64_to_user_ptr(cmd.response),
 			 &resp, sizeof(resp)))
 		ret =3D -EFAULT;
@@ -1014,6 +1030,7 @@ static ssize_t ucma_query(struct ucma_file *file,
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
=20
+	mutex_lock(&ctx->mutex);
 	switch (cmd.option) {
 	case RDMA_USER_CM_QUERY_ADDR:
 		ret =3D ucma_query_addr(ctx, response, out_len);
@@ -1028,6 +1045,7 @@ static ssize_t ucma_query(struct ucma_file *file,
 		ret =3D -ENOSYS;
 		break;
 	}
+	mutex_unlock(&ctx->mutex);
=20
 	ucma_put_ctx(ctx);
 	return ret;
@@ -1068,7 +1086,9 @@ static ssize_t ucma_connect(struct ucma_file *file, c=
onst char __user *inbuf,
 		return PTR_ERR(ctx);
=20
 	ucma_copy_conn_param(ctx->cm_id, &conn_param, &cmd.conn_param);
+	mutex_lock(&ctx->mutex);
 	ret =3D rdma_connect(ctx->cm_id, &conn_param);
+	mutex_unlock(&ctx->mutex);
 	ucma_put_ctx(ctx);
 	return ret;
 }
@@ -1089,7 +1109,9 @@ static ssize_t ucma_listen(struct ucma_file *file, co=
nst char __user *inbuf,
=20
 	ctx->backlog =3D cmd.backlog > 0 && cmd.backlog < max_backlog ?
 		       cmd.backlog : max_backlog;
+	mutex_lock(&ctx->mutex);
 	ret =3D rdma_listen(ctx->cm_id, ctx->backlog);
+	mutex_unlock(&ctx->mutex);
 	ucma_put_ctx(ctx);
 	return ret;
 }
@@ -1112,13 +1134,17 @@ static ssize_t ucma_accept(struct ucma_file *file, =
const char __user *inbuf,
 	if (cmd.conn_param.valid) {
 		ucma_copy_conn_param(ctx->cm_id, &conn_param, &cmd.conn_param);
 		mutex_lock(&file->mut);
+		mutex_lock(&ctx->mutex);
 		ret =3D __rdma_accept(ctx->cm_id, &conn_param, NULL);
+		mutex_unlock(&ctx->mutex);
 		if (!ret)
 			ctx->uid =3D cmd.uid;
 		mutex_unlock(&file->mut);
-	} else
+	} else {
+		mutex_lock(&ctx->mutex);
 		ret =3D __rdma_accept(ctx->cm_id, NULL, NULL);
-
+		mutex_unlock(&ctx->mutex);
+	}
 	ucma_put_ctx(ctx);
 	return ret;
 }
@@ -1137,7 +1163,9 @@ static ssize_t ucma_reject(struct ucma_file *file, co=
nst char __user *inbuf,
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
=20
+	mutex_lock(&ctx->mutex);
 	ret =3D rdma_reject(ctx->cm_id, cmd.private_data, cmd.private_data_len);
+	mutex_unlock(&ctx->mutex);
 	ucma_put_ctx(ctx);
 	return ret;
 }
@@ -1156,7 +1184,9 @@ static ssize_t ucma_disconnect(struct ucma_file *file=
, const char __user *inbuf,
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
=20
+	mutex_lock(&ctx->mutex);
 	ret =3D rdma_disconnect(ctx->cm_id);
+	mutex_unlock(&ctx->mutex);
 	ucma_put_ctx(ctx);
 	return ret;
 }
@@ -1187,7 +1217,9 @@ static ssize_t ucma_init_qp_attr(struct ucma_file *fi=
le,
 	resp.qp_attr_mask =3D 0;
 	memset(&qp_attr, 0, sizeof qp_attr);
 	qp_attr.qp_state =3D cmd.qp_state;
+	mutex_lock(&ctx->mutex);
 	ret =3D rdma_init_qp_attr(ctx->cm_id, &qp_attr, &resp.qp_attr_mask);
+	mutex_unlock(&ctx->mutex);
 	if (ret)
 		goto out;
=20
@@ -1273,9 +1305,13 @@ static int ucma_set_ib_path(struct ucma_context *ctx=
,
 		struct sa_path_rec opa;
=20
 		sa_convert_path_ib_to_opa(&opa, &sa_path);
+		mutex_lock(&ctx->mutex);
 		ret =3D rdma_set_ib_path(ctx->cm_id, &opa);
+		mutex_unlock(&ctx->mutex);
 	} else {
+		mutex_lock(&ctx->mutex);
 		ret =3D rdma_set_ib_path(ctx->cm_id, &sa_path);
+		mutex_unlock(&ctx->mutex);
 	}
 	if (ret)
 		return ret;
@@ -1308,7 +1344,9 @@ static int ucma_set_option_level(struct ucma_context =
*ctx, int level,
=20
 	switch (level) {
 	case RDMA_OPTION_ID:
+		mutex_lock(&ctx->mutex);
 		ret =3D ucma_set_option_id(ctx, optname, optval, optlen);
+		mutex_unlock(&ctx->mutex);
 		break;
 	case RDMA_OPTION_IB:
 		ret =3D ucma_set_option_ib(ctx, optname, optval, optlen);
@@ -1368,8 +1406,10 @@ static ssize_t ucma_notify(struct ucma_file *file, c=
onst char __user *inbuf,
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
=20
+	mutex_lock(&ctx->mutex);
 	if (ctx->cm_id->device)
 		ret =3D rdma_notify(ctx->cm_id, (enum ib_event_type)cmd.event);
+	mutex_unlock(&ctx->mutex);
=20
 	ucma_put_ctx(ctx);
 	return ret;
@@ -1403,6 +1443,7 @@ static ssize_t ucma_process_join(struct ucma_file *fi=
le,
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
=20
+	mutex_lock(&ctx->mutex);
 	mutex_lock(&file->mut);
 	mc =3D ucma_alloc_multicast(ctx);
 	if (!mc) {
@@ -1427,6 +1468,7 @@ static ssize_t ucma_process_join(struct ucma_file *fi=
le,
 	xa_store(&multicast_table, mc->id, mc, 0);
=20
 	mutex_unlock(&file->mut);
+	mutex_unlock(&ctx->mutex);
 	ucma_put_ctx(ctx);
 	return 0;
=20
@@ -1439,6 +1481,7 @@ static ssize_t ucma_process_join(struct ucma_file *fi=
le,
 	kfree(mc);
 err1:
 	mutex_unlock(&file->mut);
+	mutex_unlock(&ctx->mutex);
 	ucma_put_ctx(ctx);
 	return ret;
 }
@@ -1513,7 +1556,10 @@ static ssize_t ucma_leave_multicast(struct ucma_file=
 *file,
 		goto out;
 	}
=20
+	mutex_lock(&mc->ctx->mutex);
 	rdma_leave_multicast(mc->ctx->cm_id, (struct sockaddr *) &mc->addr);
+	mutex_unlock(&mc->ctx->mutex);
+
 	mutex_lock(&mc->ctx->file->mut);
 	ucma_cleanup_mc_events(mc);
 	list_del(&mc->list);
--=20
2.25.0

