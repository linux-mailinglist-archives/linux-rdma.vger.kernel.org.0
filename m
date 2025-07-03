Return-Path: <linux-rdma+bounces-11873-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E89AF7ECA
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 19:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31916583963
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 17:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3D5289343;
	Thu,  3 Jul 2025 17:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="j6oknhwi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C76288C9B
	for <linux-rdma@vger.kernel.org>; Thu,  3 Jul 2025 17:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751563631; cv=none; b=bRpK64E+jpuqX3mEUeFYxK8Z8ZE6RIC8P4t7u87Okh4lN8bO23oP0KLchlBhZlMCBDr5gWw5tXi9QruGXv6OHfJMT58lJ0TmPpIroqvXHpGD0eg/8nSWWoTOS6kRDC0GSpO0vseLdzcP5iX4lDGFxfXaTfr8NG+nzlHAhpjqCuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751563631; c=relaxed/simple;
	bh=tPgRib0WFB0ucWLHT/hlqavbUrPxaI/rIUSdB6nU4ug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ewFdv9R20yAyhdqGeh7RUDtaxUXP7VrZ6umbsdtw3kDgmW6DMCIR3Wprn70SvCaVuzzS1T/1WjJhWCZ6vwqtmqZCRQIJU5Z0UKD6cm8onOPlSVAGf7b0Zwv8yto1eSoJAU11GarSffkas+qrHovar4nFO+l1vKIDDlUcsQ4MXo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=j6oknhwi; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-Id:Date:Cc:To:From;
	bh=NDqDmBFwtQ0l1EbrqqVUzgqB2nX4R5fSTi+8iVSSUQ0=; b=j6oknhwiaBsrcoDxy6PFTBohtN
	O/yxMOszOvajcE+Qqp9nb8+DwS0rr3nEA4qLJlPFwn8pAp3MWq17GzUPLVmc8/MJHVdaSEa8nDeAT
	oPhcpu+rAfxP3F8AwfA+fhHWObku4M6rKYrH7kYpZGJDL10HGNdHQiwnuihlppxMgGtT05SMYUr7E
	3+45QKvIMOOaW2igejRz4XeR/ktAisONjTMumJb1O//Jvpy8TlTo29fwh3fr+q0cuJK7REUOpzDZh
	4oTRPkMtFaEboG7x8prWfy8m8rivg7N3t5sfvTQ4TBH5CXP/cOk6EEfRMIk0Ud1garSw2k4UgHYkW
	lgILzCTOOPO8icbRoIHbfBIUmAFt/cOhRl9tSHlGXzUXd5ZVWcA0/udJMwSmhyGhDoZlRYfjUS9hD
	6Z+wws5NAYFBsBs/BV5UDioQYexNfh487voE+LRUiv3mXC7lNYdOdE79iBiN6wjXKMpT65S8u1KY0
	RAfrSpEZEP12xNLryNHmQJ2V;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1uXNiF-00Dp2a-2N;
	Thu, 03 Jul 2025 17:27:07 +0000
From: Stefan Metzmacher <metze@samba.org>
To: linux-rdma@vger.kernel.org
Cc: metze@samba.org,
	Bernard Metzler <bmt@zurich.ibm.com>
Subject: [PATCH 3/8] RDMA/siw: add and remember siw_device_options per device.
Date: Thu,  3 Jul 2025 19:26:14 +0200
Message-Id: <9c8693e0a6d94b6c5c98608ee44d8bb65f1072c4.1751561826.git.metze@samba.org>
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

In future there should be a way to control these values
on a per device basis.

Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Stefan Metzmacher <metze@samba.org>
---
 drivers/infiniband/sw/siw/siw.h      | 11 +++++++++++
 drivers/infiniband/sw/siw/siw_main.c |  8 ++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index 3bdc17eedbe7..b38e78909c06 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -70,8 +70,19 @@ struct siw_pd {
 	struct ib_pd base_pd;
 };
 
+struct siw_device_options {
+	bool zcopy_tx;
+	bool try_gso;
+	bool crc_required;
+	bool crc_strict;
+	bool tcp_nagle;
+	bool peer_to_peer;
+	u8 mpa_version;
+};
+
 struct siw_device {
 	struct ib_device base_dev;
+	struct siw_device_options options;
 	struct siw_dev_cap attrs;
 
 	u32 vendor_part_id;
diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index ba238b0b43a3..bbec1442dfa1 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -324,6 +324,14 @@ static struct siw_device *siw_device_create(struct net_device *netdev)
 	/* Disable TCP port mapping */
 	base_dev->iw_driver_flags = IW_F_NO_PORT_MAP;
 
+	sdev->options.zcopy_tx = zcopy_tx;
+	sdev->options.try_gso = try_gso;
+	sdev->options.crc_required = mpa_crc_required;
+	sdev->options.crc_strict = mpa_crc_strict;
+	sdev->options.tcp_nagle = siw_tcp_nagle;
+	sdev->options.peer_to_peer = peer_to_peer;
+	sdev->options.mpa_version = mpa_version;
+
 	sdev->attrs.max_qp = SIW_MAX_QP;
 	sdev->attrs.max_qp_wr = SIW_MAX_QP_WR;
 	sdev->attrs.max_ord = SIW_MAX_ORD_QP;
-- 
2.34.1


