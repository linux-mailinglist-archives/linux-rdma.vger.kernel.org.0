Return-Path: <linux-rdma+bounces-14843-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 090ABC9653A
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Dec 2025 10:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7E67034441E
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Dec 2025 09:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50FF2FDC5A;
	Mon,  1 Dec 2025 09:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYSEDxxb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164F32F90EA
	for <linux-rdma@vger.kernel.org>; Mon,  1 Dec 2025 09:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764580074; cv=none; b=P1t0rNo4HYSArdNZj8XJC0h89/u784Z/cndeJf9vy1PCOywV2DIp71UKwmnedP3bMbqMqE6BqsB1PnGBpOBGa2eTqe5e4ZiteLqXHnKpjAj4l3GddjlN2eqvKu/3Q44Tf42m+N8D5mnBp7uSErN7uQgueUyRYSNBDSsfgxuQpJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764580074; c=relaxed/simple;
	bh=hFpoh+4KLKujfvVkJovsm9Fy1NIfmJfUCcw9DyAbbP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jgPco+Rc491XYmP/x5HUjYIDDT0miCp5Cj7A1EsMgu9+ARf9P/Ow3Xqp798A7F98C2tN/5cZqNOzQXuXpo6nux7Or6Auw00N0/SI8boB2B+QfO0HAt5M1yODONHgGqdG70xdsba8iqoblR6ZNztzVLA5KW7U62nqVRPw6TufqAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gYSEDxxb; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-bddba676613so2456463a12.2
        for <linux-rdma@vger.kernel.org>; Mon, 01 Dec 2025 01:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764580072; x=1765184872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oOfGslD6FpADHGJ9zJuTzDFQa1FBgdOpqbfefOYbpVg=;
        b=gYSEDxxbsfRT29g1So99PS/F/B76n+7munhv/cUyq5fwBMSAkXps0klHo6f1KVwAko
         x+2b8sT2yRMGzoA0lly2BhIh27HCq+AlekbW0SCtkxYzmWa6QoCXMGbAbfT+4LK4Ed40
         3yvGKecoOvBswh+PD4S2KeZGt279xwqvzxebIxLHoJQUDDbc+Dq3a7pNbjvJldqBm8KX
         6QN1whc89FHbOz9UM8tOXI+OFVBf93fcvKvlpkpq85zmwRtz1ZNUUwGrfdYaOeYUFD4e
         6nEo9GwWRBVm4J8pCJap66Naww92ISaHkpu5i2RpTGxSkU8jFZ/qaCHs5oKnh7T0pw7l
         buBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764580072; x=1765184872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOfGslD6FpADHGJ9zJuTzDFQa1FBgdOpqbfefOYbpVg=;
        b=bY0W39kgZslHKmJgBbWe247o1GgEs9r94V08TFlg+Twg6ru08zw1zjbZP3XlHDWmL0
         kISLK5ZQW8oaGVnd+HxI9B4uj5Rmc8wc6xYzjI7ft5Eq1PTY+/6ROzEmQA0inQTjh7wF
         F1Nu9sKkSCarC8FUkN5MUezAJmtr3+hpPyn4VGmsZ3X3K/qxNx31Si0PFhCIXmFr+r+F
         ipdFHYyRJmzXBB7gcTTFqoHry4c1WrLTitEX2VUD82livdp9vwnPk7EvgiKBxcn9oE6v
         vOc1QWWb3RrrxHEsE9CbKurR8IeySStfB3dc4JIsOAzQl6vKZRHeRd/8wBNYgZdjMhtM
         0WPA==
X-Forwarded-Encrypted: i=1; AJvYcCUVhel4Ur9aM+nuT8lHMm8WDADHvo3WbBcm0RMo9XSQ1hxkSZNGNkskrfVYaRPdmfvVvUQoaeUGEspx@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc+dOcEtCwd8tXQpuJSILJhXU3p1Fxa8unpZYVBI+RBCIW3mGY
	pCdihrX1xiqbHIWVvXUHsY9O/tneFIUo67EVWBDX4gSXFve9tRwH7a4hEF8IhapAFM4=
X-Gm-Gg: ASbGncuiSbkpWVmh80Q5KNe3gX+3Y6nDBdZnc6rXGFQMvWZWG+Lt0fdQwuzQ5XsjY18
	kaMRjZZTAoFxmqqbAkPuoTvYfIXrimBGZCEce0ducEGc8hfR63ZkXnu3+aowNSzmN/G8prHOggd
	GWH4hZDK15dawPyapciZFD5xCet7HbZzhT1C6lcwQMdOXZyoPh/4Yup1TM7knevKdqSPyd2Ricb
	5SLmIbFrDVw9v4vwskyjskjTCAmjrMNp5CIhvFPjcaJpv1ZmEYdw1Ng61oH7cWJVGF3Qm5UGNnJ
	K7OPGypOEXW291MnVHPToylJ9UFZ6kg9oYrElWCwOpilLziPuxFMagyFnWUarlBq/eR0bSmvZ1E
	Q9lu3Hj7W+r2ikY0TmMldNWRU2GE2bciHO5J3imGao4wyQH0fMQI2x5uwJQ2teVpiZdAWFpWSDB
	hkoj48ibHXwhXUyido8F3qfDZ41Albn7iY5WZuRzbgwtJl8w==
X-Google-Smtp-Source: AGHT+IHTmGQfng0rMYCLos6QdfyYuoGuoNcKnknPoKlzTqtyV2WqYOZ72IvcF099lFzZVR3jhak8nw==
X-Received: by 2002:a05:7300:7c0e:b0:2a4:87e2:bcca with SMTP id 5a478bee46e88-2a7194ef22emr27010718eec.13.1764580072125;
        Mon, 01 Dec 2025 01:07:52 -0800 (PST)
Received: from localhost.localdomain ([192.146.154.240])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcae73bedsm54932769c88.0.2025.12.01.01.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 01:07:51 -0800 (PST)
From: Gaurav Gangalwar <gaurav.gangalwar@gmail.com>
To: trondmy@kernel.org,
	anna@kernel.org,
	tom@talpey.com,
	chuck.lever@oracle.com
Cc: linux-nfs@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Gaurav Gangalwar <gaurav.gangalwar@gmail.com>
Subject: [PATCH] When following NFS referrals, the client always attempts RDMA first (if compiled in), even when the parent mount uses TCP. This causes unnecessary timeouts when the referral server doesn't support RDMA.
Date: Mon,  1 Dec 2025 04:07:32 -0500
Message-ID: <20251201090732.4608-1-gaurav.gangalwar@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify nfs4_create_referral_server() to check the parent client's
transport protocol. Only attempt RDMA if the parent is using RDMA,
otherwise use the parent's protocol (TCP/TCP-TLS) directly.

Add module parameter 'nfs4_inherit_referral_transport' (default: Y)
to control this behavior, allowing administrators to restore the
previous "always try RDMA" behavior if needed.

This eliminates connection delays for TCP-based referrals in
environments where RDMA is compiled in but not deployed.

Signed-off-by: Gaurav Gangalwar <gaurav.gangalwar@gmail.com>
---
 fs/nfs/nfs4_fs.h    |  1 +
 fs/nfs/nfs4client.c | 18 +++++++++++++-----
 fs/nfs/super.c      |  8 ++++++++
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index c34c89af9c7d..d8516fb8a711 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -548,6 +548,7 @@ extern unsigned short max_session_cb_slots;
 extern unsigned short send_implementation_id;
 extern bool recover_lost_locks;
 extern short nfs_delay_retrans;
+extern bool nfs4_inherit_referral_transport;
 
 #define NFS4_CLIENT_ID_UNIQ_LEN		(64)
 extern char nfs4_client_id_uniquifier[NFS4_CLIENT_ID_UNIQ_LEN];
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 3a4baed993c9..7fb39bf662af 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -1258,12 +1258,20 @@ struct nfs_server *nfs4_create_referral_server(struct fs_context *fc)
 	nfs_server_copy_userdata(server, parent_server);
 
 	/* Get a client representation */
+	/*
+	 * If nfs4_inherit_referral_transport is enabled (default), only try
+	 * RDMA if the parent client is using RDMA. This avoids connection
+	 * delays when parent uses TCP and referral server doesn't support RDMA.
+	 */
 #if IS_ENABLED(CONFIG_SUNRPC_XPRT_RDMA)
-	rpc_set_port(&ctx->nfs_server.address, NFS_RDMA_PORT);
-	cl_init.proto = XPRT_TRANSPORT_RDMA;
-	error = nfs4_set_client(server, &cl_init);
-	if (!error)
-		goto init_server;
+	if (!nfs4_inherit_referral_transport ||
+	    parent_client->cl_proto == XPRT_TRANSPORT_RDMA) {
+		rpc_set_port(&ctx->nfs_server.address, NFS_RDMA_PORT);
+		cl_init.proto = XPRT_TRANSPORT_RDMA;
+		error = nfs4_set_client(server, &cl_init);
+		if (!error)
+			goto init_server;
+	}
 #endif	/* IS_ENABLED(CONFIG_SUNRPC_XPRT_RDMA) */
 
 	cl_init.proto = XPRT_TRANSPORT_TCP;
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 72dee6f3050e..cb9618a0df0f 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1426,6 +1426,8 @@ unsigned short max_session_cb_slots = NFS4_DEF_CB_SLOT_TABLE_SIZE;
 unsigned short send_implementation_id = 1;
 char nfs4_client_id_uniquifier[NFS4_CLIENT_ID_UNIQ_LEN] = "";
 bool recover_lost_locks = false;
+/* Inherit parent transport for referral mounts */
+bool nfs4_inherit_referral_transport = true;
 short nfs_delay_retrans = -1;
 
 EXPORT_SYMBOL_GPL(nfs_callback_nr_threads);
@@ -1437,6 +1439,7 @@ EXPORT_SYMBOL_GPL(max_session_cb_slots);
 EXPORT_SYMBOL_GPL(send_implementation_id);
 EXPORT_SYMBOL_GPL(nfs4_client_id_uniquifier);
 EXPORT_SYMBOL_GPL(recover_lost_locks);
+EXPORT_SYMBOL_GPL(nfs4_inherit_referral_transport);
 EXPORT_SYMBOL_GPL(nfs_delay_retrans);
 
 #define NFS_CALLBACK_MAXPORTNR (65535U)
@@ -1486,6 +1489,11 @@ MODULE_PARM_DESC(recover_lost_locks,
 		 "If the server reports that a lock might be lost, "
 		 "try to recover it risking data corruption.");
 
+module_param(nfs4_inherit_referral_transport, bool, 0644);
+MODULE_PARM_DESC(nfs4_inherit_referral_transport,
+		 "Referral mounts inherit parent's transport protocol. "
+		 "If disabled, always try RDMA first (default=Y)");
+
 module_param_named(delay_retrans, nfs_delay_retrans, short, 0644);
 MODULE_PARM_DESC(delay_retrans,
 		 "Unless negative, specifies the number of times the NFSv4 "
-- 
2.43.7


