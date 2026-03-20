Return-Path: <linux-rdma+bounces-18420-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNoZCI2ivGkI1wIAu9opvQ
	(envelope-from <linux-rdma+bounces-18420-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 02:27:41 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C76C72D4B93
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 02:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D3693031F3D
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 01:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78CC312814;
	Fri, 20 Mar 2026 01:25:19 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B6C304BA3
	for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2026 01:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773969919; cv=none; b=rTqdXtF7RX8C8k5TpuxAkiz9pUZtflwiA1SZtrNK1gH9MCwij+emfmVCaDHJs4QPPmNt/m83scaxxNlLoPm3fMa/U8CPuH/RRNLom3dwPnrGFDw4bVGWHpjyJxedSf4Etz+JZW4pGkZ0AyjejMGY9HqzqhpdEl1ApNI0PElQAVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773969919; c=relaxed/simple;
	bh=FkE3aEmYq3JFi5GpqJgM6OBmxi48BQXX3kwNVt8fzXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F3H/eHIznixNEiosj1NNXmAa4P6CKbvohW4cVKhpRgrikkzaXD7eAwuiq3cGw+mnREbH1D2csSxTCZIlDIvA7S3XLppMXCjenim2szqmIVqE4oLoXLOOD7kgJ2DLgD7Z+2H/e4YNmaRjhA8YS0dUS7J0uWVam1mxJFcFrxvX+14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2c0bb213b16so2614321eec.0
        for <linux-rdma@vger.kernel.org>; Thu, 19 Mar 2026 18:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773969916; x=1774574716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RnwqqwAxnRG8s2vaRYDrbUdfVznpcDcr1raRDlnvaSE=;
        b=Rf7uLv/zUCGna4eUWIkInprO1ewWi9VdKUO8MK526C03QpRxLklA5mY87NZh9KRzEU
         5IkXv9kvMnhw2KNq/dKiSBW+QlTsHq19tpS0yEUXFxvTkB0czTeTJRMeOCWLq85ach08
         7fy/zhKUdgDVd8Y9QX7wwt4MkMSMEOXDGLJ6JNejxuA/BQDtAlMxehx8RFx0gV4JbcJu
         7MZwW1pOt2bNeKi65o32npRYyWdR3TwDR5u23rVJFh6ZoSHsttvYnLnaK42yLbUgwoOB
         1UhueaZG3tuQxES6dQ573RXLc5qAK/KYNhy0Jyt+LAYugASaMrtMpDt4xthDfSzjX5Cm
         rwmg==
X-Forwarded-Encrypted: i=1; AJvYcCXE4EbIs0Ixq+rKoCGLodC3ppJXC5y8rdd4AF1FDCil3w1v5w2z/fxwBNLnG/OAxsjFYrubBiAjTFTC@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1z0F0vC7s6Z7nk1nesGVe6lNU4jhD/i1M55t+ZEJXniA/l0+e
	eVH6/e42NKPWehScWcPcQ90Ih7qu4bOrtzLhpWyIDw2meAqAEBjBbn4=
X-Gm-Gg: ATEYQzxtN0+BOzqZrBnIwHHTOQJ+pSuR+fM54qWFGx6SbHusKdTnJ4GmKoH9Y7gdspH
	Sqdulk6EEqkJ77EwNmnO81bR0/3Q3ZfSHKFXDkh5VBJkVQ0K9FMipuJxhctX+N1Cau50BGoBGrs
	7MDiyG/c0B88HxddZAy7C/Q6qCavmWP+A+Zlac1MfNNjH5oVb2q3FZ3TGv4VuFHwk2WeScU+mPt
	FsbT2mPoTDz1PllDd16aBExSb7NYnTIVlitYyIv4S0CzTr5bHJ5WukOAbXgJWvY/c0Flmdo2cXJ
	31zqRE8WI+Azu4WRModJxo8Q+p9FnOQFvseOHVCw/0KB3hQb2dlQNn5Nbsi1QGf+L6qZbBcxorX
	mibmAm+Hz9Xe7z2AFqYKQ2VuAGHaGh2fzijOp5FwY9GqKbgAROSDyznAzHv52rrEJAaSy2LA+Hi
	0RWoScdfpPEGqQWyv76Q67u5M7m9Rmuf8EiND10cB225eVsuSX5hwnBKGAXYK+s0RNMKy9IUqhA
	XsK//R8obBHoLmo9ZBYiI/BSQVX
X-Received: by 2002:a05:7301:4083:b0:2c0:cc90:a71 with SMTP id 5a478bee46e88-2c1095c78d8mr746759eec.8.1773969915768;
        Thu, 19 Mar 2026 18:25:15 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b1a88e5sm1421784eec.13.2026.03.19.18.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 18:25:15 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	andrew+netdev@lunn.ch,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	alexanderduyck@fb.com,
	kernel-team@meta.com,
	johannes@sipsolutions.net,
	sd@queasysnail.net,
	jianbol@nvidia.com,
	dtatulea@nvidia.com,
	sdf@fomichev.me,
	mohsin.bashr@gmail.com,
	jacob.e.keller@intel.com,
	willemb@google.com,
	skhawaja@google.com,
	bestswngs@gmail.com,
	aleksandr.loktionov@intel.com,
	kees@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	leon@kernel.org
Subject: [PATCH net-next v3 10/13] netdevsim: convert to ndo_set_rx_mode_async
Date: Thu, 19 Mar 2026 18:24:58 -0700
Message-ID: <20260320012501.2033548-11-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320012501.2033548-1-sdf@fomichev.me>
References: <20260320012501.2033548-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18420-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,fomichev.me,gmail.com,vger.kernel.org,lists.osuosl.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sdf@fomichev.me,linux-rdma@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.059];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCPT_COUNT_TWELVE(0.00)[37];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:email,fomichev.me:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C76C72D4B93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert netdevsim from ndo_set_rx_mode to ndo_set_rx_mode_async.
The callback is a no-op stub so just update the signature and
ops struct wiring.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/netdevsim/netdev.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 5ec028a00c62..9c9217792125 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -182,7 +182,9 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
-static void nsim_set_rx_mode(struct net_device *dev)
+static void nsim_set_rx_mode(struct net_device *dev,
+			     struct netdev_hw_addr_list *uc,
+			     struct netdev_hw_addr_list *mc)
 {
 }
 
@@ -641,7 +643,7 @@ static const struct net_shaper_ops nsim_shaper_ops = {
 
 static const struct net_device_ops nsim_netdev_ops = {
 	.ndo_start_xmit		= nsim_start_xmit,
-	.ndo_set_rx_mode	= nsim_set_rx_mode,
+	.ndo_set_rx_mode_async	= nsim_set_rx_mode,
 	.ndo_set_mac_address	= eth_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_change_mtu		= nsim_change_mtu,
@@ -664,7 +666,7 @@ static const struct net_device_ops nsim_netdev_ops = {
 
 static const struct net_device_ops nsim_vf_netdev_ops = {
 	.ndo_start_xmit		= nsim_start_xmit,
-	.ndo_set_rx_mode	= nsim_set_rx_mode,
+	.ndo_set_rx_mode_async	= nsim_set_rx_mode,
 	.ndo_set_mac_address	= eth_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_change_mtu		= nsim_change_mtu,
-- 
2.53.0


