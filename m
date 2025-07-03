Return-Path: <linux-rdma+bounces-11877-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0565AF7ED3
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 19:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88A863B12A2
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 17:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2100F289E0B;
	Thu,  3 Jul 2025 17:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="oWfyVrMV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29214288C8E
	for <linux-rdma@vger.kernel.org>; Thu,  3 Jul 2025 17:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751563666; cv=none; b=hnEZyYG6P8fmqdfsjM4lvYRe5F3yedC7SM3eE3B8+z2O0g2Ulnxg9kmiH/zbZmEaGxNaLDRYA+UmJL73dHNjl4RlQ5Hfzwg5krrZNVPF9iqXxWcoC6SW9vVSy5EbfIokvHmAWRm4higdLETh1459cptxGNvI8/25GNd5dGDzcWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751563666; c=relaxed/simple;
	bh=MUKE9Ei5lsGEwsdyR7uLjK6wm5VGAiCiXmxVYtDoMZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LT4ijkil/nw9PQk9SNSRolo+ZFX4i4izDQNNpJZRBqfEhq9pfjljKBWZlLVkeuTKjX5pynYuYUk0zhpHuY/odIMoGPMOR5GyvoXRVBDSd1UFU9pItxR+kGCmq2GgzGH3gePW+1y/Rn0pf63+/wxg1wDxne8UZN5/jJ94PJIFpu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=oWfyVrMV; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-Id:Date:Cc:To:From;
	bh=gDI2W/LoDUG9ahO/dLhKNS5O7fttoBY2T3YGl8QgSlw=; b=oWfyVrMV3ImVkCg9p2wD7cZd+m
	S3JtThBeES4mInZ5ODGPsLLDjiKjgKw9XhbhIs5hgnq0dfkVqWsPWIRe4IoREQnUk2rgrObIVEqk0
	AzS5N7/IpTLLn+jXAii3/uY/uihek2yjPpLPOIhDJh/YDlK8SIueKEVy4QHJ49aqamHg8wXDvVkwF
	Ey3FwCs3TckCNaeLG3RiItKtHFvC9shLZKcXivKqKPZTCUNUjjwdvB/5h50gbjP+LET68932HnA16
	xoavJULE9J5LoiZQl/3NfW/TDZP2pARRskqIahIhRhELGF7MnNbYv82AM+0O982G96DnE319pa2WF
	Sid+p2WUVYCc19j6PX/xa3IWBBwyN4KLUtsiNd1UTiI4iITZcXP48xAU7CiCB2Hf1D+5IKaRSs7YU
	kQvhD1eMVhYs4LHzggzQTkTSrwplUq6iju887iQV9gbW4GJBWdiJ7bugr419Q/ui6dwoq4uDPea+e
	yKyECi//gGTcKk82TmHyiPLq;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1uXNio-00Dp3A-39;
	Thu, 03 Jul 2025 17:27:43 +0000
From: Stefan Metzmacher <metze@samba.org>
To: linux-rdma@vger.kernel.org
Cc: metze@samba.org,
	Bernard Metzler <bmt@zurich.ibm.com>
Subject: [PATCH 7/8] RDMA/siw: [re-]introduce module parameters to alter the behavior at runtime
Date: Thu,  3 Jul 2025 19:26:18 +0200
Message-Id: <208af7fbf8ddabf7b5f9a68cb9bef346edef09ff.1751561826.git.metze@samba.org>
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

During the out of tree development of the siw.ko driver it had module
parameters to change the runtime behavior. This got lost in the process
of bringing it upstream in order to reduce the complexity.

In order to interop with Chelsio iwarp cards (tested with T404-BT, T520-BT and T520-CR)
running from Windows in order to support smbdirect it is needed to
change some parameters:

echo 1 > /sys/module/siw/parameters/mpa_crc_required
echo 1 > /sys/module/siw/parameters/mpa_crc_strict
echo 0 > /sys/module/siw/parameters/mpa_rdma_write_rtr
echo 1 > /sys/module/siw/parameters/mpa_peer_to_peer

The T404-BT card also requires:
echo 1 > /sys/module/siw/parameters/mpa_version
(which will be supported in the next commit.

These only have an effect on following invocations of
'rdma link add siw_eth0 type siw netdev eth0',
which will make per device copy of the global parameters.

That means that each invocation of an
'rdma link add SIWDEV type siw netdev NETDEV'
can have its own set of values, which makes it
easy to test different settings on different interfaces.

Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Stefan Metzmacher <metze@samba.org>
---
 drivers/infiniband/sw/siw/siw_cm.c   |   2 +-
 drivers/infiniband/sw/siw/siw_main.c | 111 ++++++++++++++++++++++++++-
 2 files changed, 111 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index c1c66ae1fa97..7feed4a02d58 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1471,7 +1471,7 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	 * If MPA version == 2:
 	 * o Include ORD and IRD.
 	 * o Indicate peer-to-peer mode, if required by module
-	 *   parameter 'peer_to_peer'.
+	 *   parameter 'mpa_peer_to_peer'.
 	 */
 	if (version == MPA_REVISION_2) {
 		cep->enhanced_rdma_conn_est = true;
diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index ff121f14d5b7..c7d1e44ec8fa 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -29,7 +29,7 @@ MODULE_AUTHOR("Bernard Metzler");
 MODULE_DESCRIPTION("Software iWARP Driver");
 MODULE_LICENSE("Dual BSD/GPL");
 
-static const struct siw_device_options siw_default_options = {
+static struct siw_device_options siw_default_options = {
 	/*
 	 * transmit from user buffer, if possible
 	 */
@@ -75,6 +75,115 @@ static const struct siw_device_options siw_default_options = {
 	.mpa_version = MPA_REVISION_2,
 };
 
+module_param_named(zcopy_tx, siw_default_options.zcopy_tx, bool, 0644);
+MODULE_PARM_DESC(zcopy_tx, "Transmit from user buffer, if possible");
+
+module_param_named(try_gso, siw_default_options.try_gso, bool, 0644);
+MODULE_PARM_DESC(try_gso, "Try usage of GSO");
+
+module_param_named(mpa_crc_required, siw_default_options.crc_required, bool, 0644);
+MODULE_PARM_DESC(mpa_crc_required, "We try to negotiate CRC on, if true");
+
+module_param_named(mpa_crc_strict, siw_default_options.crc_strict, bool, 0644);
+MODULE_PARM_DESC(mpa_crc_strict, "MPA CRC on/off enforced");
+
+module_param_named(tcp_nagle, siw_default_options.tcp_nagle, bool, 0644);
+MODULE_PARM_DESC(tcp_nagle, "Control TCP_NODELAY socket option");
+
+module_param_named(mpa_peer_to_peer, siw_default_options.peer_to_peer, bool, 0644);
+MODULE_PARM_DESC(mpa_peer_to_peer, "Selects MPA P2P mode setup, if true");
+
+static int siw_rtr_type_set_bit(const char *val,
+				const struct kernel_param *kp,
+				__be16 bit)
+{
+	bool bval = true;
+	int ret;
+
+	/* No equals means "set"... */
+	if (!val) val = "1";
+
+	/* One of =[yYnN01] */
+	ret = kstrtobool(val, &bval);
+	if (ret != 0)
+		return ret;
+
+	if (bval)
+		*((__be16 *)kp->arg) |= bit;
+	else
+		*((__be16 *)kp->arg) &= ~bit;
+
+	return 0;
+}
+
+static int siw_rtr_type_get_bit(char *buffer,
+				const struct kernel_param *kp,
+				__be16 bit)
+{
+	bool bval = (*((__be16 *)kp->arg) & bit);
+
+	/* Y and N chosen as being relatively non-coder friendly */
+	return sprintf(buffer, "%c\n", bval ? 'Y' : 'N');
+}
+
+static int siw_rdma_read_rtr_set(const char *val, const struct kernel_param *kp)
+{
+	return siw_rtr_type_set_bit(val, kp, MPA_V2_RDMA_READ_RTR);
+}
+
+static int siw_rdma_read_rtr_get(char *buffer, const struct kernel_param *kp)
+{
+	return siw_rtr_type_get_bit(buffer, kp, MPA_V2_RDMA_READ_RTR);
+}
+module_param_call(mpa_rdma_read_rtr,
+		  siw_rdma_read_rtr_set,
+		  siw_rdma_read_rtr_get,
+		  &siw_default_options.rtr_type,
+		  0644);
+MODULE_PARM_DESC(mpa_rdma_read_rtr, "MPA P2P mode setup enable MPA_V2_RDMA_READ_RTR, if true");
+
+static int siw_rdma_write_rtr_set(const char *val, const struct kernel_param *kp)
+{
+	return siw_rtr_type_set_bit(val, kp, MPA_V2_RDMA_WRITE_RTR);
+}
+
+static int siw_rdma_write_rtr_get(char *buffer, const struct kernel_param *kp)
+{
+	return siw_rtr_type_get_bit(buffer, kp, MPA_V2_RDMA_WRITE_RTR);
+}
+module_param_call(mpa_rdma_write_rtr,
+		  siw_rdma_write_rtr_set,
+		  siw_rdma_write_rtr_get,
+		  &siw_default_options.rtr_type,
+		  0644);
+MODULE_PARM_DESC(mpa_rdma_write_rtr, "MPA P2P mode setup enable MPA_V2_RDMA_WRITE_RTR, if true");
+
+static int siw_mpa_version_set(const char *val, const struct kernel_param *kp)
+{
+	u8 uval = MPA_REVISION_2;
+	int ret;
+
+	ret = kstrtou8(val, 10, &uval);
+	if (ret != 0)
+		return ret;
+
+	switch (uval) {
+	case MPA_REVISION_2:
+	/* TODO case MPA_REVISION_1: */
+		siw_default_options.mpa_version = uval;
+		return 0;
+	}
+
+	return -ERANGE;
+}
+
+module_param_call(mpa_version,
+		  siw_mpa_version_set,
+		  param_get_byte,
+		  &siw_default_options.mpa_version,
+		  0644);
+MODULE_PARM_DESC(mpa_version, "Select MPA version to be used during connection setup");
+
 struct task_struct *siw_tx_thread[NR_CPUS];
 
 static int siw_device_register(struct siw_device *sdev, const char *name)
-- 
2.34.1


