Return-Path: <linux-rdma+bounces-11876-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD25AF7ED2
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 19:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50EB93B04A3
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 17:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DF628937A;
	Thu,  3 Jul 2025 17:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="vCXHEhIW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA0D28934E
	for <linux-rdma@vger.kernel.org>; Thu,  3 Jul 2025 17:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751563660; cv=none; b=SLJBHzIgh0E7Kb9CITvfPoaUWQc4Vgb0ObOKgiN4Gqqsu0eSSbcXmFrRYro/EUDsWtrdF+1bKBtmRb8viOD3vrIne5KFH1nqReeoL9Zq2fzahu7qHLm9NmslG+YcC1Bpd4D57vjrULWwpnWS+C1ISgAen+Dguq2l8Kx4aI06jjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751563660; c=relaxed/simple;
	bh=tMfTDyBTRHw4bJGN8AwcUhXJgEVQps8McVk8OGJh0DQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kXgxYIM9awVC6VDugIzq1VCP7DwfTgeOsIfGtIybfrK05veo6sq+TM1YhFtjt21LwWQWMXC0E+yEgXzFt+Ssh9z8JClYklvh93Av/yZOJarEfe59qLwlzfnlzU/T47VOQkz5yK8WtJ1UrqZuOVjt3+1jskm7qrAv13rYsmCBlng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=vCXHEhIW; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-Id:Date:Cc:To:From;
	bh=BqV7j05xN+PB3e3oB5zAhpgyB48OJ9qA/0cGx6qt+0A=; b=vCXHEhIWCTB/HxCIhi1rTwp6bO
	OHhOjpAKAkiCVe8vzX2gSwVXuopoA54OprgGx1O2c8hgX3Lk9i++bK6aVjt6TYd0bebe5skWyewUt
	CnFlGUTlS2tLAMB+rICRdUTOlLopms7p+PCN0vouxUl2QjCz1dj4JaY0sJkHxoaruKjmno/1dMha9
	EkBOKPl8v6YQt3LryzxQvbsUmQOPf1B2v8sqwP4rH0XT35TMyFFZwTRk3ICDQ/dEqCyGRr2NsmLmL
	hGUBiM5vhhsG9Xh2jMICmdolr0pnETSVmh5zo08mgse6LO7lOkdul82cfRo2s0teZDqoSAnmUinrW
	rdK4ksxxC3DgANY7MaLzgbpazmmWX0C4TqeDNT2pGVBC4ieeIxIV6XI5BZV0hE3A+NKms8YPEALWM
	bVaV7uBTaCJf98oTJxU7S6VIoOpg7BoZyVmrVzrwt9YWVv3WvSMQMIlAkWtdYeQITVI54aMMpm3ax
	tHKvKiEL164RI22rLn7PzJXB;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1uXNih-00Dp30-0W;
	Thu, 03 Jul 2025 17:27:35 +0000
From: Stefan Metzmacher <metze@samba.org>
To: linux-rdma@vger.kernel.org
Cc: metze@samba.org,
	Bernard Metzler <bmt@zurich.ibm.com>
Subject: [PATCH 6/8] RDMA/siw: move rtr_type to siw_device_options
Date: Thu,  3 Jul 2025 19:26:17 +0200
Message-Id: <d6f473c5dea2bf633e628e4ec4a3be61913ba0d9.1751561826.git.metze@samba.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1751561826.git.metze@samba.org>
References: <cover.1751561826.git.metze@samba.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Stefan Metzmacher <metze@samba.org>
---
 drivers/infiniband/sw/siw/siw.h      | 1 +
 drivers/infiniband/sw/siw/siw_cm.c   | 6 +-----
 drivers/infiniband/sw/siw/siw_main.c | 6 ++++++
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index 4d8e1f857099..f42418f44c0d 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -77,6 +77,7 @@ struct siw_device_options {
 	bool crc_strict;
 	bool tcp_nagle;
 	bool peer_to_peer;
+	__be16 rtr_type;
 	u8 mpa_version;
 };
 
diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 9640450e1f87..c1c66ae1fa97 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -25,11 +25,6 @@
 #include "siw.h"
 #include "siw_cm.h"
 
-/*
- * Set to any combination of
- * MPA_V2_RDMA_NO_RTR, MPA_V2_RDMA_READ_RTR, MPA_V2_RDMA_WRITE_RTR
- */
-static __be16 rtr_type = MPA_V2_RDMA_READ_RTR | MPA_V2_RDMA_WRITE_RTR;
 static const bool relaxed_ird_negotiation = true;
 
 static void siw_cm_llp_state_change(struct sock *s);
@@ -1365,6 +1360,7 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	struct sockaddr *laddr = (struct sockaddr *)&id->local_addr,
 			*raddr = (struct sockaddr *)&id->remote_addr;
 	bool p2p_mode = sdev->options.peer_to_peer;
+	__be16 rtr_type = sdev->options.rtr_type;
 	bool v4 = true;
 	u16 pd_len = params->private_data_len;
 	int version = sdev->options.mpa_version;
diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index 954990278256..ff121f14d5b7 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -63,6 +63,12 @@ static const struct siw_device_options siw_default_options = {
 	 */
 	.peer_to_peer = false,
 
+	/*
+	 * Set to any combination of
+	 * MPA_V2_RDMA_NO_RTR, MPA_V2_RDMA_READ_RTR, MPA_V2_RDMA_WRITE_RTR
+	 */
+	.rtr_type = MPA_V2_RDMA_READ_RTR | MPA_V2_RDMA_WRITE_RTR,
+
 	/*
 	 * Select MPA version to be used during connection setup
 	 */
-- 
2.34.1


