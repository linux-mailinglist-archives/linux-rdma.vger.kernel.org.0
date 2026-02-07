Return-Path: <linux-rdma+bounces-16659-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLbcMAuQhmlwOwQAu9opvQ
	(envelope-from <linux-rdma+bounces-16659-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Feb 2026 02:06:19 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27464104685
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Feb 2026 02:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AB0C30342B4
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Feb 2026 01:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13AA23AB88;
	Sat,  7 Feb 2026 01:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAFj5el0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BD31B424F
	for <linux-rdma@vger.kernel.org>; Sat,  7 Feb 2026 01:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770426345; cv=none; b=mkYIUmRflupetWcT0+dycUHc/xOAeiulWPFvjmEzHmyOoHQ4L5MN4/Kn4rM4cEaN0Zyn5JEcSuOyNsws7NwHcEL1KzAf7lErgIEVSYu0iKy5k8W1nifihX96igxW2QyXqdQ7JR4yw5PZ4NDmCSDgHI2Fmx1d9CewuiMNuxd2TNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770426345; c=relaxed/simple;
	bh=vZyQ3W41tSgb9T96IHbpN0bBWRTE5A03rJTwTS0ByFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nbb6x6dekf2yTvpRsC98OiVnkvPnEtksFRc5Hbr0Lh9WH4F2FUwQ/r1W23AGCQT+vhvl86P8DhXZUB+t2nr2gz9MSn+Rw469b8XBUjYXJob99x9OU9uHPgGsmQ5+YSH4pwsM3eDnuEcODzGkX7NcXsgAFSwb0XEmDetrOS9BHIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HAFj5el0; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4806d23e9f1so31512715e9.2
        for <linux-rdma@vger.kernel.org>; Fri, 06 Feb 2026 17:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770426344; x=1771031144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ImzVK+GHh6j9+CDGxS1HgJoW/MDxeFyCyig7DxGVKaM=;
        b=HAFj5el0RHfmP93fmdgEhvUVnIHEEXPqTcVdrKkt2hh8mBahqsRIjaH4ChwlSaAlWe
         9Dr34CsbeaPRZJNltkTBJ7eRd7qzQ+U96loz/TWHd4obLgBVZ7yomDfClVHqxclHZpbJ
         yWnzDG9qRbAfQJMsvgqHHzDomV2yNMiL65JrLkpAqRLIhCr5Fz0VnRICWa/Sr+eYXkq4
         70QZc4a9YkgPY3OUCcPTj+muGs6a604cC4wScVMVeV9bf6K1hRmdIFs1FiX71XYxi1Ft
         EU5tbYXeaO4mDLLkAfjGiUxnLZ/JaANIJ4dH6oCBLvagbA9zAd/6wfOPygZhAGKbysGx
         jBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770426344; x=1771031144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ImzVK+GHh6j9+CDGxS1HgJoW/MDxeFyCyig7DxGVKaM=;
        b=n6KKLzwvG9lM3ahY8riBvvJ8xAPY3vzHDB7LBI19Y41O2z/aQgHSTUu7md2v3yol6T
         xdOB2KOo8cdT1YTPX6DoKIwF++SWzFbR8oKlFemKpPC6/qyVsA+/m6EoCPdzOn7xzvaY
         afmE34nDIaq8z8fqaohIVc2dLoHc+2wuDQw3Bj0uuinFi+ztD2jJ47D5qXcVXQfciNZu
         LqJPgE/EDCAJeLRloDFTwWtFG2f2UVRpQOHaqkCo/rVISK4YTc4XCnRH12AC58wBcjOP
         sE5JSQwgjisk5KFS/2nKvMHakC29CXGSTLEtDgDE6ahxms1Qb+i3fry6A2oFnhNVznFY
         r43w==
X-Forwarded-Encrypted: i=1; AJvYcCUeSzPE3hVIVOJDJn49t6/NXbyuREabrAfko/L0eETiVrkoXZCa5LxMR/WtYPSDd6KOAYuS/S92yZtI@vger.kernel.org
X-Gm-Message-State: AOJu0YxMLHeD/NSgrlPssBt8Gd28kfVilxWP0S36bzdbcA138OE+rULw
	D7j/qdtJAjnwTmT35qqoaHCPiddZSrURTy2QcSMOS6+RDIJ7GfUC/yr+
X-Gm-Gg: AZuq6aLMFpN/bzbCILFPXbHNDfBzwoa7zc2wn4S74Pe4QfqdCzQCqagNUslNkoJsq/Y
	8AZfCl9A1gvcqOP4Xf3SSxIoAL37pUECY14VQNZ9O30kcmmayKNtGH9BiOZclgmxOrPXV7NzCqM
	DhaBN2pRGKQ4q8LrcflIQzxLoujh2Od7AcxeHCT3bXBHjRxlZXf+3kxD/rkFDKZVdAqwWhdTmUy
	rzNnkJS5R6tarqV03vH/LXYAB9u1sEY2aUfsvre+Pg2DIDhkxdqMfnSbNOG7nqwdhIDJ520i8aA
	6na9zWIUj8XA+1fXRH8dD0KR1gRfO1no1UwacKKvnL01t01xM5bdITek1QR93ynA52ItdbvAayR
	RLfU31sGqZIZ+XCT2FMyI8nBWaTuo9If2SRC3ErIjDOk2inQ4my6uJK4osu8TTD6bTymH3vnL4X
	qevPRmq9nO
X-Received: by 2002:a05:600c:3b23:b0:480:1e92:dc65 with SMTP id 5b1f17b1804b1-4832022b9fcmr73276755e9.31.1770426343663;
        Fri, 06 Feb 2026 17:05:43 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:54::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d3e245sm165767315e9.8.2026.02.06.17.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 17:05:43 -0800 (PST)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	andrew+netdev@lunn.ch,
	andrew@lunn.ch,
	davem@davemloft.net,
	donald.hunter@gmail.com,
	edumazet@google.com,
	gal@nvidia.com,
	horms@kernel.org,
	idosch@nvidia.com,
	jacob.e.keller@intel.com,
	kernel-team@meta.com,
	kory.maincent@bootlin.com,
	kuba@kernel.org,
	lee@trager.us,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	linux@armlinux.org.uk,
	mbloch@nvidia.com,
	mohsin.bashr@gmail.com,
	o.rempel@pengutronix.de,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	vadim.fedorenko@linux.dev
Subject: [PATCH net-next V2 3/5] eth: fbnic: Add protection against pause storm
Date: Fri,  6 Feb 2026 17:05:23 -0800
Message-ID: <20260207010525.3808842-4-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260207010525.3808842-1-mohsin.bashr@gmail.com>
References: <20260207010525.3808842-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16659-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,lunn.ch,davemloft.net,gmail.com,google.com,nvidia.com,kernel.org,intel.com,meta.com,bootlin.com,trager.us,vger.kernel.org,armlinux.org.uk,pengutronix.de,redhat.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 27464104685
X-Rspamd-Action: no action

Add protection against TX pause storms. A pause storm occurs when a
device fails to send received packets up to the stack. When a pause
storm is detected (pause state persists beyond the configured timeout),
the device stops sending the pause frames and begins dropping packets
instead of back-pressuring.

The timeout is configurable via ethtool tunable (pfc-prevention-tout)
with a maximum value of 10485ms, and the default value of 500ms.

Once the device transitions to the storm-detected state, the service
task periodically attempts recovery, returning the device to normal
operation to handle any subsequent pause storm episodes.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
Changelog:
V2: Add pause storm watchdog timeout configuration via pfc-prevention-tout
   (P3)
---
 drivers/net/ethernet/meta/fbnic/fbnic.h       |  3 +
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   | 10 ++
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 43 +++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c   |  2 +
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c   | 95 +++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h   | 27 ++++++
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |  5 +
 7 files changed, 185 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index 779a083b9215..a760a27b1516 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -98,6 +98,9 @@ struct fbnic_dev {
 
 	/* MDIO bus for PHYs */
 	struct mii_bus *mdio_bus;
+
+	/* In units of ms since API supports values in ms */
+	u16 ps_timeout;
 };
 
 /* Reserve entry 0 in the MSI-X "others" array until we have filled all
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index b717db879cd3..e68c56237b61 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -230,6 +230,7 @@ enum {
 #define FBNIC_INTR_MSIX_CTRL_VECTOR_MASK	CSR_GENMASK(7, 0)
 #define FBNIC_INTR_MSIX_CTRL_ENABLE		CSR_BIT(31)
 enum {
+	FBNIC_INTR_MSIX_CTRL_RXB_IDX	= 7,
 	FBNIC_INTR_MSIX_CTRL_PCS_IDX	= 34,
 };
 
@@ -560,6 +561,11 @@ enum {
 #define FBNIC_RXB_DROP_THLD_CNT			8
 #define FBNIC_RXB_DROP_THLD_ON			CSR_GENMASK(12, 0)
 #define FBNIC_RXB_DROP_THLD_OFF			CSR_GENMASK(25, 13)
+#define FBNIC_RXB_PAUSE_STORM(n)	(0x08019 + (n)) /* 0x20064 + 4*n */
+#define FBNIC_RXB_PAUSE_STORM_CNT		4
+#define FBNIC_RXB_PAUSE_STORM_FORCE_NORMAL	CSR_BIT(20)
+#define FBNIC_RXB_PAUSE_STORM_THLD_TIME		CSR_GENMASK(19, 0)
+#define FBNIC_RXB_PAUSE_STORM_UNIT_WR	0x0801d		/* 0x20074 */
 #define FBNIC_RXB_ECN_THLD(n)		(0x0801e + (n)) /* 0x20078 + 4*n */
 #define FBNIC_RXB_ECN_THLD_CNT			8
 #define FBNIC_RXB_ECN_THLD_ON			CSR_GENMASK(12, 0)
@@ -596,6 +602,9 @@ enum {
 #define FBNIC_RXB_INTF_CREDIT_MASK2		CSR_GENMASK(11, 8)
 #define FBNIC_RXB_INTF_CREDIT_MASK3		CSR_GENMASK(15, 12)
 
+#define FBNIC_RXB_ERR_INTR_STS		0x08050		/* 0x20140 */
+#define FBNIC_RXB_ERR_INTR_STS_PS		CSR_GENMASK(15, 12)
+#define FBNIC_RXB_ERR_INTR_MASK		0x08052		/* 0x20148 */
 #define FBNIC_RXB_PAUSE_EVENT_CNT(n)	(0x08053 + (n))	/* 0x2014c + 4*n */
 #define FBNIC_RXB_DROP_FRMS_STS(n)	(0x08057 + (n))	/* 0x2015c + 4*n */
 #define FBNIC_RXB_DROP_BYTES_STS_L(n) \
@@ -636,6 +645,7 @@ enum {
 
 #define FBNIC_RXB_PBUF_FIFO_LEVEL(n)	(0x0811d + (n)) /* 0x20474 + 4*n */
 
+#define FBNIC_RXB_PAUSE_STORM_UNIT_RD	0x08125		/* 0x20494 */
 #define FBNIC_RXB_INTEGRITY_ERR(n)	(0x0812f + (n))	/* 0x204bc + 4*n */
 #define FBNIC_RXB_MAC_ERR(n)		(0x08133 + (n))	/* 0x204cc + 4*n */
 #define FBNIC_RXB_PARSER_ERR(n)		(0x08137 + (n))	/* 0x204dc + 4*n */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 11745a2d8a44..dc57519ebbe5 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -1638,6 +1638,47 @@ static void fbnic_get_ts_stats(struct net_device *netdev,
 	}
 }
 
+static int fbnic_get_tunable(struct net_device *netdev,
+			     const struct ethtool_tunable *tun,
+			     void *data)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+	int err = 0;
+
+	switch (tun->id) {
+	case ETHTOOL_PFC_PREVENTION_TOUT:
+		*(u16 *)data = fbn->fbd->ps_timeout;
+		break;
+	default:
+		err = -EOPNOTSUPP;
+		break;
+	}
+
+	return err;
+}
+
+static int fbnic_set_tunable(struct net_device *netdev,
+			     const struct ethtool_tunable *tun,
+			     const void *data)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+	int err;
+
+	switch (tun->id) {
+	case ETHTOOL_PFC_PREVENTION_TOUT: {
+		u16 ps_timeout = *(u16 *)data;
+
+		err = fbnic_mac_ps_protect_to_config(fbn->fbd, ps_timeout);
+		break;
+	}
+	default:
+		err = -EOPNOTSUPP;
+		break;
+	}
+
+	return err;
+}
+
 static int
 fbnic_get_module_eeprom_by_page(struct net_device *netdev,
 				const struct ethtool_module_eeprom *page_data,
@@ -1912,6 +1953,8 @@ static const struct ethtool_ops fbnic_ethtool_ops = {
 	.set_channels			= fbnic_set_channels,
 	.get_ts_info			= fbnic_get_ts_info,
 	.get_ts_stats			= fbnic_get_ts_stats,
+	.get_tunable			= fbnic_get_tunable,
+	.set_tunable			= fbnic_set_tunable,
 	.get_link_ksettings		= fbnic_phylink_ethtool_ksettings_get,
 	.get_fec_stats			= fbnic_get_fec_stats,
 	.get_fecparam			= fbnic_phylink_get_fecparam,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_irq.c b/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
index 02e8b0b257fe..1e6a8fd6f702 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
@@ -170,6 +170,8 @@ int fbnic_mac_request_irq(struct fbnic_dev *fbd)
 	fbnic_wr32(fbd, FBNIC_INTR_MSIX_CTRL(FBNIC_INTR_MSIX_CTRL_PCS_IDX),
 		   FBNIC_PCS_MSIX_ENTRY | FBNIC_INTR_MSIX_CTRL_ENABLE);
 
+	fbnic_wr32(fbd, FBNIC_INTR_MSIX_CTRL(FBNIC_INTR_MSIX_CTRL_RXB_IDX), 0);
+
 	fbd->mac_msix_vector = vector;
 
 	return 0;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
index 9d0e4b2cc9ac..be834983e981 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
@@ -143,6 +143,7 @@ static void fbnic_mac_init_qm(struct fbnic_dev *fbd)
 #define FBNIC_DROP_EN_MASK	0x7d
 #define FBNIC_PAUSE_EN_MASK	0x14
 #define FBNIC_ECN_EN_MASK	0x10
+#define FBNIC_PS_EN_MASK	0x01
 
 struct fbnic_fifo_config {
 	unsigned int addr;
@@ -420,6 +421,14 @@ static void __fbnic_mac_stat_rd64(struct fbnic_dev *fbd, bool reset, u32 reg,
 #define fbnic_mac_stat_rd64(fbd, reset, __stat, __CSR) \
 	__fbnic_mac_stat_rd64(fbd, reset, FBNIC_##__CSR##_L, &(__stat))
 
+bool fbnic_mac_check_tx_pause(struct fbnic_dev *fbd)
+{
+	u32 command_config;
+
+	command_config = rd32(fbd, FBNIC_MAC_COMMAND_CONFIG);
+	return !(command_config & FBNIC_MAC_COMMAND_CONFIG_TX_PAUSE_DIS);
+}
+
 static void fbnic_mac_tx_pause_config(struct fbnic_dev *fbd, bool tx_pause)
 {
 	u32 rxb_pause_ctrl;
@@ -434,6 +443,49 @@ static void fbnic_mac_tx_pause_config(struct fbnic_dev *fbd, bool tx_pause)
 	wr32(fbd, FBNIC_RXB_PAUSE_DROP_CTRL, rxb_pause_ctrl);
 }
 
+static void
+fbnic_mac_ps_protect_to_reset(struct fbnic_dev *fbd, u16 timeout_ms)
+{
+	wr32(fbd, FBNIC_RXB_PAUSE_STORM_UNIT_WR, FBNIC_RXB_PS_CLK_DIV);
+
+	wr32(fbd, FBNIC_RXB_PAUSE_STORM(FBNIC_RXB_INTF_NET),
+	     FIELD_PREP(FBNIC_RXB_PAUSE_STORM_THLD_TIME,
+			FBNIC_MAC_RXB_PS_TO(timeout_ms)) |
+			FBNIC_RXB_PAUSE_STORM_FORCE_NORMAL);
+	wrfl(fbd);
+	wr32(fbd, FBNIC_RXB_PAUSE_STORM(FBNIC_RXB_INTF_NET),
+	     FIELD_PREP(FBNIC_RXB_PAUSE_STORM_THLD_TIME,
+			FBNIC_MAC_RXB_PS_TO(timeout_ms)));
+}
+
+static void
+fbnic_mac_ps_protect_config(struct fbnic_dev *fbd, bool ps_protect)
+{
+	u16 timeout;
+	u32 reg;
+
+	ps_protect = ps_protect && fbd->ps_timeout;
+	timeout = ps_protect ? fbd->ps_timeout : FBNIC_MAC_PS_TO_DEFAULT_MS;
+
+	fbnic_mac_ps_protect_to_reset(fbd, timeout);
+
+	reg = rd32(fbd, FBNIC_RXB_PAUSE_DROP_CTRL);
+	reg &= ~FBNIC_RXB_PAUSE_DROP_CTRL_PS_ENABLE;
+	reg |= FIELD_PREP(FBNIC_RXB_PAUSE_DROP_CTRL_PS_ENABLE, ps_protect);
+	wr32(fbd, FBNIC_RXB_PAUSE_DROP_CTRL, reg);
+
+	/* Clear any pending interrupt status first */
+	wr32(fbd, FBNIC_RXB_ERR_INTR_STS,
+	     FIELD_PREP(FBNIC_RXB_ERR_INTR_STS_PS, FBNIC_PS_EN_MASK));
+
+	/* Unmask the Network to Host PS interrupt if tx_pause is on */
+	reg = rd32(fbd, FBNIC_RXB_ERR_INTR_MASK);
+	reg |= FBNIC_RXB_ERR_INTR_STS_PS;
+	if (ps_protect)
+		reg &= ~FBNIC_RXB_ERR_INTR_STS_PS;
+	wr32(fbd, FBNIC_RXB_ERR_INTR_MASK, reg);
+}
+
 static int fbnic_mac_get_link_event(struct fbnic_dev *fbd)
 {
 	u32 intr_mask = rd32(fbd, FBNIC_SIG_PCS_INTR_STS);
@@ -658,6 +710,7 @@ static void fbnic_mac_link_up_asic(struct fbnic_dev *fbd,
 	u32 cmd_cfg, mac_ctrl;
 
 	fbnic_mac_tx_pause_config(fbd, tx_pause);
+	fbnic_mac_ps_protect_config(fbd, tx_pause);
 
 	cmd_cfg = __fbnic_mac_cmd_config_asic(fbd, tx_pause, rx_pause);
 	mac_ctrl = rd32(fbd, FBNIC_SIG_MAC_IN0);
@@ -918,3 +971,45 @@ int fbnic_mac_init(struct fbnic_dev *fbd)
 
 	return 0;
 }
+
+int fbnic_mac_ps_protect_to_config(struct fbnic_dev *fbd, u16 timeout_ms)
+{
+	u16 old_timeout_ms = fbd->ps_timeout;
+
+	if (timeout_ms == old_timeout_ms)
+		return 0;
+
+	if (timeout_ms == PFC_STORM_PREVENTION_AUTO)
+		timeout_ms = FBNIC_MAC_PS_TO_DEFAULT_MS;
+
+	if (timeout_ms > FBNIC_MAC_PS_TO_MAX_MS)
+		return -EINVAL;
+
+	fbd->ps_timeout = timeout_ms;
+
+	if (!fbnic_mac_check_tx_pause(fbd))
+		return 0;
+
+	if (timeout_ms == 0)
+		fbnic_mac_ps_protect_config(fbd, false);
+	else if (old_timeout_ms == 0)
+		fbnic_mac_ps_protect_config(fbd, true);
+	else
+		fbnic_mac_ps_protect_to_reset(fbd, fbd->ps_timeout);
+
+	return 0;
+}
+
+void fbnic_mac_ps_protect_handler(struct fbnic_dev *fbd)
+{
+	u32 rxb_err_sts = rd32(fbd, FBNIC_RXB_ERR_INTR_STS);
+
+	/* Check if pause storm interrupt for network was triggered */
+	if (rxb_err_sts & FIELD_PREP(FBNIC_RXB_ERR_INTR_STS_PS, FBNIC_PS_EN_MASK)) {
+		/* Write 1 to clear the interrupt status first */
+		wr32(fbd, FBNIC_RXB_ERR_INTR_STS,
+		     FIELD_PREP(FBNIC_RXB_ERR_INTR_STS_PS, FBNIC_PS_EN_MASK));
+
+		fbnic_mac_ps_protect_to_reset(fbd, fbd->ps_timeout);
+	}
+}
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
index f08fe8b7c497..10f30e0e8f69 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
@@ -8,6 +8,30 @@
 
 struct fbnic_dev;
 
+/* The RXB clock runs at 600 MHZ in the ASIC and the PAUSE_STORM_UNIT_WR
+ * is 10us granularity, so set the clock to 6000 (0x1770)
+ */
+#define FBNIC_RXB_PS_CLK_DIV		0x1770
+
+/* Convert milliseconds to pause storm timeout units (10us granularity) */
+#define FBNIC_MAC_RXB_PS_TO(ms)		((ms) * 100)
+
+/* Convert pause storm timeout units (10us granularity) to milliseconds */
+#define FBNIC_MAC_RXB_PS_TO_MS(ps)	((ps) / 100)
+
+/* Set the default timer to 500ms, which should be longer than any
+ * reasonable period of continuous pausing. The service task, which runs
+ * once per second, periodically resets the pause storm trigger.
+ *
+ * As a result, on a functioning system, if pause continues, we enforce
+ * a duty cycle determined by the configured pause storm timeout (50%
+ * default). A crashed system will not have the service task and therefore
+ * pause will remain disabled until reboot recovery.
+ */
+#define FBNIC_MAC_PS_TO_DEFAULT_MS	500
+#define FBNIC_MAC_PS_TO_MAX_MS	\
+	FBNIC_MAC_RXB_PS_TO_MS(FIELD_MAX(FBNIC_RXB_PAUSE_STORM_THLD_TIME))
+
 #define FBNIC_MAX_JUMBO_FRAME_SIZE	9742
 
 /* States loosely based on section 136.8.11.7.5 of IEEE 802.3-2022 Ethernet
@@ -119,4 +143,7 @@ struct fbnic_mac {
 
 int fbnic_mac_init(struct fbnic_dev *fbd);
 void fbnic_mac_get_fw_settings(struct fbnic_dev *fbd, u8 *aui, u8 *fec);
+int fbnic_mac_ps_protect_to_config(struct fbnic_dev *fbd, u16 timeout);
+void fbnic_mac_ps_protect_handler(struct fbnic_dev *fbd);
+bool fbnic_mac_check_tx_pause(struct fbnic_dev *fbd);
 #endif /* _FBNIC_MAC_H_ */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index 6f9389748a7d..196820f38d58 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -220,6 +220,9 @@ static void fbnic_service_task(struct work_struct *work)
 
 	fbnic_get_hw_stats32(fbd);
 
+	if (fbd->ps_timeout && fbnic_mac_check_tx_pause(fbd))
+		fbnic_mac_ps_protect_handler(fbd);
+
 	fbnic_fw_check_heartbeat(fbd);
 
 	fbnic_health_check(fbd);
@@ -296,6 +299,8 @@ static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* Populate driver with hardware-specific info and handlers */
 	fbd->max_num_queues = info->max_num_queues;
 
+	fbd->ps_timeout = FBNIC_MAC_PS_TO_DEFAULT_MS;
+
 	pci_set_master(pdev);
 	pci_save_state(pdev);
 
-- 
2.47.3


