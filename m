Return-Path: <linux-rdma+bounces-16666-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id zyeZCq6thmm2PwQAu9opvQ
	(envelope-from <linux-rdma+bounces-16666-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Feb 2026 04:12:46 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C077104C58
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Feb 2026 04:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 337A0301724A
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Feb 2026 03:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C6B3385A5;
	Sat,  7 Feb 2026 03:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyE5alpY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFD61F63D9
	for <linux-rdma@vger.kernel.org>; Sat,  7 Feb 2026 03:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770433960; cv=none; b=mgViP0IBR/mhTDRFkzDCRjToqKI+TzYV808tTnzXP+JZOBXjBDlxcDSIVpmyoA9b5bT+9/KX1tetmMZaiFklR+7xuZvcTtaemharnXrf7DcDdK61KTBeqWmkNoXKBpe2MZtr52SvDNFJAq5apzcQtc598bMmfQQhIA/mcxNqhR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770433960; c=relaxed/simple;
	bh=qx1Jl8fKbXVfQo+2LlM1C8vtQEmuPtK1SLpDqKvAMRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RDg4keePmEyBS7KllUbcyg8JglUS3GQZxlaAvAkD3zeEggOJXZFkQNIBxsvkWcdPN8+iAnA55vMYq0nrUxr2vNM4gBdQqbTKk691d0HdNQ0A0KUZZX79qs1Jku+T+SMbDd64oKUTx38ws7+7az/uzI0Q8i+tGICR3uFi+HWll18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dyE5alpY; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6594382a264so2412907a12.1
        for <linux-rdma@vger.kernel.org>; Fri, 06 Feb 2026 19:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770433959; x=1771038759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ML3AMg0Eja+zFme5wRXmPhd9dcxAi42x3kc/admjyJc=;
        b=dyE5alpY6+5z8c3LwqxWFe1yiudZ7rAhUhTi8HMY1cd5tIfSlzHCGL64Unfa/4RHa2
         Zu8/SxK3FipoYdrGEMb7RjHfzIPDX//AzgAWoDufD6T/P9Z8ro8SttDEPYCwZp0Nkwpd
         8ZXQesXeuLed1zCeURdl00coeRQvUTFQ6Zn445KiFD85hc/CYQBCrmTOpFO9wfUUT+7t
         VaDx0YIJsznfslw2bTs/XAHQOCUyhAItpsZzmkSmweZ0y5SHsImwy/1jtkg4xw0sAMTD
         AJAv9ZxWiynhx0XW+2gEAuX2gNfPL7J1Sy8JVE7FRZKtUD+KXv78xqGA3n8yDdZouOzK
         xWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770433959; x=1771038759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ML3AMg0Eja+zFme5wRXmPhd9dcxAi42x3kc/admjyJc=;
        b=jldjcv6lAPoXDGO0TLnqFiQdJGxyQXee9/hpalkv8syzilVTsQWjIPasyihwDI7fS9
         WY6rqCchfVu5T3C8MuE+EUYeaRzQqErIkVf7i5VevISrhPKn2tac8Zqn5CnD3lkxqsHu
         0kJVVc7VM+IVJR7Yi++3kBdZD6zvsIu7CTAM5E8jaSQ8MxoXHnLznXhjwR4WFX3JOojx
         2ZMZusodB2SWVKTvBa0vveVNGwid+Z2iDiRirVkP4jJHxDB5gHOVMvV8kd2/BIHTW9YQ
         xnL+1orF4oH1or8RmSOLwnn35Z3/wlItpVkUUPscHLB2PKcs0RZa4Dsq/mVnv9Gnp6+7
         I4+w==
X-Forwarded-Encrypted: i=1; AJvYcCVKbrNvznksp4q61BBXKzjqMBXDFChwNjvUX2YIeY6Q50VPp5W/rzBAs3udlLBw/xT+cWa5VZmwaXc7@vger.kernel.org
X-Gm-Message-State: AOJu0YyNs5yoLXozeeD5siHOVOYryvQuAARtbcYwyTyjEkO1YV82ygVv
	uEjVSjXoV07lexF9qRDh+N+kTHqbGOWwAN57v9Je/D+Lma9UEI+693LXMIQ3G7LC
X-Gm-Gg: AZuq6aKITtgnoK1Wjq7k9MmEExTwFM54aAReTrHM2/YfgtCfaE3Np0bwiZJHjWSnK/Y
	PYIjyJMM91dIo67Ku2UsCRWIY9Nbh+7lhZDV1LeGeCibeMwh6M38/LXXyCVi6woCuvV6fEpaQrC
	qpEP1xlF/V1nwF87DieCWxfJk9R4hVipzGzqfte0/FEmQ3WQ9yvVdgEdtGMnXdMgrdl8bQsWYj6
	0mzRtcYuemUpecKFycQhsEJETwY5SisCLHOTEeJEYWqLHk60b3IHQwgCo/0mLroopnZYVcEfkgC
	rj/1ySV6pUejassudUQFiyV1uu3XD0YXegQTmARDc8hUxbQkn0amxM1UR4eM07BmxoV26czYxCi
	4SLi7mrr99vgxIL13CMtDlLylvcceBYXXtAOFhxwq+2O4pEQJy/onsieOf3BqzNjM02+NiEU+D2
	2O5yft2pyl4IDr2Hm6hLI=
X-Received: by 2002:a05:6000:603:b0:436:19b1:c15a with SMTP id ffacd0b85a97d-4362933faadmr7048305f8f.21.1770428309770;
        Fri, 06 Feb 2026 17:38:29 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:72::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296b34d2sm10351343f8f.1.2026.02.06.17.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 17:38:29 -0800 (PST)
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
Date: Fri,  6 Feb 2026 17:38:26 -0800
Message-ID: <20260207013826.4030161-1-mohsin.bashr@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16666-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8C077104C58
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


