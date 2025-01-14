Return-Path: <linux-rdma+bounces-7017-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BBCA11317
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jan 2025 22:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC5C188A7F5
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jan 2025 21:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16ABE212B0B;
	Tue, 14 Jan 2025 21:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="df9U6CIY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F921ADC82;
	Tue, 14 Jan 2025 21:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736890351; cv=none; b=AELoImY3NaAQLlk7Llo0CVqQCreo4Th0Ri+w+k5R9MhVAUO3JcVdtcFJIvJ4WmkL6CaNpntsITHbprMqeeLdxTlloUhtmHHh+3qGEin4yP5nRbya6tA3Y5rreQFufQTSzkpyys9SdGoO1Qrl7EDpk6VZX+enJsGDCW+otStMc5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736890351; c=relaxed/simple;
	bh=wpLWbQdu715XoabfkX+51VHxRtDq2ljWcOHLnLaZlk8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l1VvNK7YM3h0q+vlbOatrHSesaoX8QqT/g4PeKaM2lNPSLraCIpCqOBHrLEqqGSvMnjhozV4srUOQ5CcPVhQsoZOg+rX1/JJcTkVEMQCN65kVOrM9D4y0ETASPzELpDYxf6GnzlSE2uOVItGblIuQX3dm/Mhin5pTDMxBiu6J3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=df9U6CIY; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1736890347;
	bh=wpLWbQdu715XoabfkX+51VHxRtDq2ljWcOHLnLaZlk8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=df9U6CIY2xFgFUBZ0wIkojB43lHA1JScVlGJ2UCDtOkJ1Zzdwoab62BxEclZuaWzr
	 eVDWZ4XP06WozxzWM0cCr/WlTUcVw8qS4QW43MTkVetVjIZ4uHRNl1XwnfyTrR7Q8f
	 Q/D2RYLmXm0W5Yml9luc0eXxBbGvitTQE/YlKV8E=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 14 Jan 2025 22:32:13 +0100
Subject: [PATCH 1/2] RDMA/hfi1: Constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250114-sysfs-const-bin_attr-infiniband-v1-1-397aaa94d453@weissschuh.net>
References: <20250114-sysfs-const-bin_attr-infiniband-v1-0-397aaa94d453@weissschuh.net>
In-Reply-To: <20250114-sysfs-const-bin_attr-infiniband-v1-0-397aaa94d453@weissschuh.net>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736890346; l=2544;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=wpLWbQdu715XoabfkX+51VHxRtDq2ljWcOHLnLaZlk8=;
 b=tyXOvG9ANNpuFxCv+JQdpsunnRt0sjTI9c8tYEEq9VLYiJtsrant14P6Y421jsy5lS2e6vHv0
 WJC97M9boctDs/MPsrwkfOHU4qw3g3aRSD+w+3fk1Cwh0SdPvZqqKBi
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/infiniband/hw/hfi1/sysfs.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/sysfs.c b/drivers/infiniband/hw/hfi1/sysfs.c
index d62ba5fdd80c876eedf572bde408131202548e9d..d94216c7d576f6418140e0d096314633aa42ab3b 100644
--- a/drivers/infiniband/hw/hfi1/sysfs.c
+++ b/drivers/infiniband/hw/hfi1/sysfs.c
@@ -27,8 +27,8 @@ static struct hfi1_pportdata *hfi1_get_pportdata_kobj(struct kobject *kobj)
  * Congestion control table size followed by table entries
  */
 static ssize_t cc_table_bin_read(struct file *filp, struct kobject *kobj,
-				 struct bin_attribute *bin_attr, char *buf,
-				 loff_t pos, size_t count)
+				 const struct bin_attribute *bin_attr,
+				 char *buf, loff_t pos, size_t count)
 {
 	int ret;
 	struct hfi1_pportdata *ppd = hfi1_get_pportdata_kobj(kobj);
@@ -57,7 +57,7 @@ static ssize_t cc_table_bin_read(struct file *filp, struct kobject *kobj,
 
 	return count;
 }
-static BIN_ATTR_RO(cc_table_bin, PAGE_SIZE);
+static const BIN_ATTR_RO(cc_table_bin, PAGE_SIZE);
 
 /*
  * Congestion settings: port control, control map and an array of 16
@@ -65,7 +65,7 @@ static BIN_ATTR_RO(cc_table_bin, PAGE_SIZE);
  * trigger threshold and the minimum injection rate delay.
  */
 static ssize_t cc_setting_bin_read(struct file *filp, struct kobject *kobj,
-				   struct bin_attribute *bin_attr,
+				   const struct bin_attribute *bin_attr,
 				   char *buf, loff_t pos, size_t count)
 {
 	struct hfi1_pportdata *ppd = hfi1_get_pportdata_kobj(kobj);
@@ -93,9 +93,9 @@ static ssize_t cc_setting_bin_read(struct file *filp, struct kobject *kobj,
 
 	return count;
 }
-static BIN_ATTR_RO(cc_setting_bin, PAGE_SIZE);
+static const BIN_ATTR_RO(cc_setting_bin, PAGE_SIZE);
 
-static struct bin_attribute *port_cc_bin_attributes[] = {
+static const struct bin_attribute *const port_cc_bin_attributes[] = {
 	&bin_attr_cc_setting_bin,
 	&bin_attr_cc_table_bin,
 	NULL
@@ -134,7 +134,7 @@ static struct attribute *port_cc_attributes[] = {
 static const struct attribute_group port_cc_group = {
 	.name = "CCMgtA",
 	.attrs = port_cc_attributes,
-	.bin_attrs = port_cc_bin_attributes,
+	.bin_attrs_new = port_cc_bin_attributes,
 };
 
 /* Start sc2vl */

-- 
2.48.0


