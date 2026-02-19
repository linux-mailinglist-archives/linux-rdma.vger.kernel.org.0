Return-Path: <linux-rdma+bounces-17013-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FSqCh8Kl2nvtwIAu9opvQ
	(envelope-from <linux-rdma+bounces-17013-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Feb 2026 14:03:27 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 885DA15ED69
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Feb 2026 14:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 356E93070DE4
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Feb 2026 13:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE74630ACEB;
	Thu, 19 Feb 2026 13:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nECaiRXQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9178133A713;
	Thu, 19 Feb 2026 13:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771506078; cv=none; b=Hp+5ucsCPwXj26nzjxkwzANM93UL3+y1/dI15KNrtdkbWOsoJWnWoMrz6pn80WHk1QQnYg354QQrHYHP52MlRQaEU+vqkqTQ6s+bht1lTziVXiFeMs1uT+sY8pFUpR+tzvrkg9rr+1T+Lhvzqzihz6hDrW9cveyZJFS9e1x1Ums=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771506078; c=relaxed/simple;
	bh=5Jcs61XxaPz2ZX7VjzJx1L9dXyxRoQTzSOywqI9uovM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q6NitppA2KFrR/jPtlcpzM5A4aNBO49Aw+0sxjHqC531ZLbP25p0V295qvYfzRFyWFaVT/OilkwlBsueQ75KMVCZR0niu9UKOG78mDe/x6EP0Ulx9s+ZS4W5IQK8V+tPMxg1MjLVbObrDkR7apKdYCMpwp+ui6cI184DosDUIR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nECaiRXQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F757C2BC86;
	Thu, 19 Feb 2026 13:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771506078;
	bh=5Jcs61XxaPz2ZX7VjzJx1L9dXyxRoQTzSOywqI9uovM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nECaiRXQ/cP0VkcuTPVgRfJoKECJTFMVsP8d6+kw18SM6WMNx9Vzq7e6e1o9PzD1n
	 AULRg2i3rL4eUoQY2lIHtDACHpLwADRtUy+563WjEW1xiQtj+QupgXyVtzE8vsTTxD
	 ckXomHvQxo03zJjyLHhuPcFWcLUdrKfLkiDLNrnWUYkZtAfdbMARDo3KUF82pbWeFn
	 No8zLxzQqy0Sl0/yYnAI7oTzLCJ/0YbVoPSP1Q6Y94yMxEU6ZmtAIFW7OETnWb4AzY
	 z1xL/LT2gV3qC8Rn4nG7ZVJhHWeRrHVczp+V4oV5OYdtBx7+01eriXNvREbNqCYxtZ
	 qGhfQCJgE4azQ==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: netdev@vger.kernel.org,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Michael Chan <michael.chan@broadcom.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [RFC net-next 3/4] ethtool: module: refactor fw flash init to reuse CMIS helpers
Date: Thu, 19 Feb 2026 14:00:44 +0100
Message-ID: <20260219130050.2390226-4-bjorn@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260219130050.2390226-1-bjorn@kernel.org>
References: <20260219130050.2390226-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.90 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.56)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17013-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,kernel.org,davemloft.net,google.com,redhat.com,nvidia.com,lunn.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 885DA15ED69
X-Rspamd-Action: no action

Simplify module_flash_fw_work_init() by reusing the module_is_cmis()
helper and ethtool_cmis_page_init() introduced in the loopback support
commit, replacing the open-coded CMIS type switch and manual EEPROM
page setup.

Remove the now-duplicate MODULE_EEPROM_PHYS_ID_I2C_ADDR define from
the firmware flash section since ethtool_cmis_page_init() sets the I2C
address internally.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 net/ethtool/module.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/net/ethtool/module.c b/net/ethtool/module.c
index 21d2f59985af..76e35dae1db2 100644
--- a/net/ethtool/module.c
+++ b/net/ethtool/module.c
@@ -486,7 +486,6 @@ static void module_flash_fw_work(struct work_struct *work)
 }
 
 #define MODULE_EEPROM_PHYS_ID_PAGE	0
-#define MODULE_EEPROM_PHYS_ID_I2C_ADDR	0x50
 
 static int module_flash_fw_work_init(struct ethtool_module_fw_flash *module_fw,
 				     struct net_device *dev,
@@ -501,31 +500,20 @@ static int module_flash_fw_work_init(struct ethtool_module_fw_flash *module_fw,
 	 * is located at I2C address 0x50, byte 0. See section 4.1 in SFF-8024,
 	 * revision 4.9.
 	 */
-	page_data.page = MODULE_EEPROM_PHYS_ID_PAGE;
-	page_data.offset = SFP_PHYS_ID;
-	page_data.length = sizeof(phys_id);
-	page_data.i2c_address = MODULE_EEPROM_PHYS_ID_I2C_ADDR;
+	ethtool_cmis_page_init(&page_data, MODULE_EEPROM_PHYS_ID_PAGE,
+			       SFP_PHYS_ID, sizeof(phys_id));
 	page_data.data = &phys_id;
 
 	err = ops->get_module_eeprom_by_page(dev, &page_data, extack);
 	if (err < 0)
 		return err;
 
-	switch (phys_id) {
-	case SFF8024_ID_QSFP_DD:
-	case SFF8024_ID_OSFP:
-	case SFF8024_ID_DSFP:
-	case SFF8024_ID_QSFP_PLUS_CMIS:
-	case SFF8024_ID_SFP_DD_CMIS:
-	case SFF8024_ID_SFP_PLUS_CMIS:
-		INIT_WORK(&module_fw->work, module_flash_fw_work);
-		break;
-	default:
-		NL_SET_ERR_MSG(extack,
-			       "Module type does not support firmware flashing");
+	if (!module_is_cmis(phys_id)) {
+		NL_SET_ERR_MSG(extack, "Module type does not support firmware flashing");
 		return -EOPNOTSUPP;
 	}
 
+	INIT_WORK(&module_fw->work, module_flash_fw_work);
 	return 0;
 }
 
-- 
2.53.0


