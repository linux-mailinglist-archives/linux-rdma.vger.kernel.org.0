Return-Path: <linux-rdma+bounces-16665-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /1NfDQOshml3PwQAu9opvQ
	(envelope-from <linux-rdma+bounces-16665-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Feb 2026 04:05:39 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C96D104BDA
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Feb 2026 04:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E29FD301DBAA
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Feb 2026 03:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AF8332904;
	Sat,  7 Feb 2026 03:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Opse8FA7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9C9222582
	for <linux-rdma@vger.kernel.org>; Sat,  7 Feb 2026 03:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770433534; cv=none; b=Cn8JCUzD9SSteO90496jCOyOnMBYZMLOO+lMIgkbeFLbLd7d5x2LSaET0N8zKg9etYjrqCX603H6YbiVTPxhRpoDdjXevnq2qEjMgK/a0Ya7jTyUlHmMAfsEtyTsE6lx8NEaIaPq7bQlDID8Pz60hl4UHc17Ha56pmgu6Zf6TDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770433534; c=relaxed/simple;
	bh=qx1Jl8fKbXVfQo+2LlM1C8vtQEmuPtK1SLpDqKvAMRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KtaIs3fUWWdNfll9O4AsLfDfwyreca8ixV/QRWNGSjIw85CJZO19HMBxl7N82Po8IJxCpEhLjOjU3Xz2KD2NWPpgRfBmi3UdqGjiiXElzdiCSzoLBupA1zRNhnG8Q3kz81/ACLyK9MoJNgFwf4uxW2N4Lha7sz4aeRJRoohovt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Opse8FA7; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-65378ba2ff7so1761189a12.2
        for <linux-rdma@vger.kernel.org>; Fri, 06 Feb 2026 19:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770433533; x=1771038333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ML3AMg0Eja+zFme5wRXmPhd9dcxAi42x3kc/admjyJc=;
        b=Opse8FA7hZ8x+GM7GHAWKlegCJzL2WBS7u4WbMiLKlsCt8FSCYtc+/8nPfCdZMWEaK
         L6ftLUxAv0woznVNue9reBmgOyPd+QSfJ5aH20EJj8Bdi12Wjol+N8uNId6SKEplpIL0
         T4hvEs3zlCKqQEdsCVyKHJNKCwzCJg4dlmHKVK7zUpwI17fsRX0Dwu5WHdtN1v2cQ1l5
         gfLhnIORcAcDEh2iyv8k8g/oz2WVn2cvfwEO9OC18WVjtbvRFi0igwnMM/aYcMOS9cxz
         SSZ7TQdW1/TcXD1F0jRIKGBpZLvvx/wShLHoXRNFqS5Ol7ioHFT+Zu1MnFeG9r2B3cEs
         IeBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770433533; x=1771038333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ML3AMg0Eja+zFme5wRXmPhd9dcxAi42x3kc/admjyJc=;
        b=bt/a3SvIq1vVzXo0SxxfDJAjsHXVosGO3VEcCWK1iKaikCsJiKCb8r5rb/OZDTImSS
         OSXsga+NJHWj2sEFrYioLPMiw0A38a2n4xjY+TF4qokNxfxt7hccLMKH1khtdx0n/dVs
         QPUldkiGXYDzdmc/p0BkxdpHq3hQf4Ti7foJ80dArtH58SIqXuKsh5ZNpea0VvcJhSGv
         goyTWTuqIZpHwWRx8x8kOeXUt7QG6cypb1ZsDhk6jnCjAnTcU7ARwjFx8R/tM4Gt3GT5
         C+h+dX1qWWUV7qJ78ZPsvYv7I31uDvrUPnTppOSSpgf4kMx30+uejtRHHFitLq1pz/SV
         Idmw==
X-Forwarded-Encrypted: i=1; AJvYcCXFIjCplTDbg/FQIF5ncC+H27BBr8xBMKJBsDyNiOrMTg539oAzPmyYrfL4j1atKSTY3ZJoqKDOnlIH@vger.kernel.org
X-Gm-Message-State: AOJu0Yzme63hC9dm6LFbIpE26BrsU33D3q9yZj35TMMZmlINOQsF54Wq
	bUuCBOyiovhMDlfpf2EGFl8QDM85GUOcQdvcDWGugD377QKH2BHlNB8VfubTnBmJ
X-Gm-Gg: AZuq6aJV7QwurNt8bNEgNoqmQ4LZPdOBOabQpcm8RsjzmbxjG7zJCl8DEgVKzynOWyb
	EmE4ri9X36WjKDVX8ENj000P6Zn9xt1EC5QYYy6F+kzYIDrzfx3Bo2GdpDhLl0FbaSFEuWk70Lf
	LL7zZyLnZz1tUPLnkiGxGtlksP0a8PohbeqsBWM9ewoSkUCGzql8DZ8QPN3Q+/im26XRI+V6Vgj
	5DaExadRRXaErEXEg/wdEcMAj9R/jh4eKs3Xs8udKnglh6JP48MMZxwzSiteFtvOuNfCKg248AJ
	63MbCJ9X36VuHb9ztXh8Q76Fz7fi5ITmx7ERHI4vIunpagLzKDTIg0ZxHVorrxvflktBxdZZheB
	tY8Sw+b2SKTV9VzGBKRjZ9KPdffGT4TgewrIepRekZKqbanH8YJ1ouWvXrttXpCjTt6SghOkzH/
	mEvdlgUew=
X-Received: by 2002:a05:6000:1788:b0:431:16d:63d7 with SMTP id ffacd0b85a97d-436293bab38mr7154758f8f.47.1770426341018;
        Fri, 06 Feb 2026 17:05:41 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:5::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4362972fb81sm10293381f8f.20.2026.02.06.17.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 17:05:39 -0800 (PST)
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
Subject: [PATCH net-next V2 2/5] net: ethtool: Update doc for tunable
Date: Fri,  6 Feb 2026 17:05:22 -0800
Message-ID: <20260207010525.3808842-3-mohsin.bashr@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16665-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7C96D104BDA
X-Rspamd-Action: no action

ETHTOOL_PFC_PREVENTION_TOUT enables the configuration of timeout value
for PFC storm prevention. This can also be used to configure storm
detection timeout for global pause settings. In fact some existing
drivers are already using it for the said purpose.

Highlight that the knob can formally be used to configure timeout
value for pause storm prevention mechanism. The update to the ethtool
man page will follow afterwards.

Link: https://lore.kernel.org/aa5f189a-ac62-4633-97b5-ebf939e9c535@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 include/uapi/linux/ethtool.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index b74b80508553..1cdfb8341df2 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -225,7 +225,7 @@ enum tunable_id {
 	ETHTOOL_ID_UNSPEC,
 	ETHTOOL_RX_COPYBREAK,
 	ETHTOOL_TX_COPYBREAK,
-	ETHTOOL_PFC_PREVENTION_TOUT, /* timeout in msecs */
+	ETHTOOL_PFC_PREVENTION_TOUT, /* both pause and pfc, see man ethtool */
 	ETHTOOL_TX_COPYBREAK_BUF_SIZE,
 	/*
 	 * Add your fresh new tunable attribute above and remember to update
-- 
2.47.3


