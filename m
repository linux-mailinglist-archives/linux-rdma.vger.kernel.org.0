Return-Path: <linux-rdma+bounces-16664-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNNXOWOphmkEPwQAu9opvQ
	(envelope-from <linux-rdma+bounces-16664-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Feb 2026 03:54:27 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3DA104B73
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Feb 2026 03:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9F39301779D
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Feb 2026 02:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72193314B7;
	Sat,  7 Feb 2026 02:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTr9S2zV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5640C10F2
	for <linux-rdma@vger.kernel.org>; Sat,  7 Feb 2026 02:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770432864; cv=none; b=eb3HZCx/Q7PWM13h+UAddYRi70/ovqrL+fAKR+tuVKwjnkgUSUXl3bTwbX3C7gueddvi9Cvuy/c9VIgdgpAJGQ1WRWUmNo4Or9J3qltfg3fOS1mBz8p6t0sBUelDBsJdS+Iln486KFYtQr8QNZTdeyPu/EVymZSV8PLB1RZU6xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770432864; c=relaxed/simple;
	bh=F75+iwxlRTLyIzKuJzJ+ID7DQ02GZVbuxnZkr4FlfjY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K2ftdkBbOt4ZANkX0W4oLkMveZy76gshIv33nmjub3LobezxofNVswvJuSxa4WYv84H42gNBXyMpnxo4+wtpoofSJvLEF9qLZgampTLf5NgnjZ1UBbeZkLKtbsfwUGgktUXOaiI1dVa+CTzwtjQ7S6kTQo0H+l+YS2MymMYqCkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTr9S2zV; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4362c635319so955927f8f.2
        for <linux-rdma@vger.kernel.org>; Fri, 06 Feb 2026 18:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770432863; x=1771037663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nV2/pR09fRCKiwS6HhA3KDDNoxylvhh0vYo9VwjMiO8=;
        b=ZTr9S2zVhfNjdEP+oSogDVAG8me1pvOY0crJErAdvTr0dIJNxmDeTeYYY/85NU3AAd
         RutEg5dkvp1XMus/fSVC36fT6lqFKVtKuV70Gt5S9nC1OX5DQUw0iLGL94n/C59Tova3
         xvjSb4UC4q3tC8JejbjykLu2OcUGlWamlv4MXkepwtkfXDCi9V9jPIQNArvw4h/I7Co1
         hyLrz707iqo9928ShzBfZAQ42LZPDR78MTKWGfh/ewRWLe6Th46GTmrHJd/JnCTXhsXw
         RAKOa0ym6OOHTHzmua9b8dw11mr0wTyw64x/1nQSlDzVzBUUweeyWIIjTxeGSI8hItZ/
         y1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770432863; x=1771037663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nV2/pR09fRCKiwS6HhA3KDDNoxylvhh0vYo9VwjMiO8=;
        b=NW9nidG4WBuY5j/qQG49l+QbgKGsi+MNpTbzTbMH3577Ww0OKwBdMK9mZsNfOzpWSR
         qbTTL/yqRo0X4B+Rff0wh4o33YkCT0uRx4htqjSqy14m8ghfBukFPQiFPuYpP7YMhNGd
         SHnvTMp6hRUp4BobRLX0bM39Zj5JywckllxHHDRkQ5/aUltPcb+bT9LiQyIgs0CTj98j
         5cHBTeIrz08WvZte19Pny5NAXLyfd9K8w0tKj1nxlhZaiHJu2+ViOpQDatshprttI6D5
         wbfcHMDNDADsMXSC4pJqLAjR9oFCKs/la3g6FzVz/O7BE1G0VwukWmiyj9GHI5m/2F2R
         3plQ==
X-Forwarded-Encrypted: i=1; AJvYcCVv6chQbx7abssYVIuPu6UrFg+1HQ6zYH/o/u3KTdHmb+MKyqJWuw8NhIjOz36ZynGlS+F2jc8zHFUC@vger.kernel.org
X-Gm-Message-State: AOJu0Yy18r2ny0gjc+QO4rDSVKFJCYR0EtBOEuxu5SEvtBanRBhKEhTD
	ZNQb7XtSjunEdJF/OT6NeEppEwlK9BlZ4gZn3g5XnSVGg15pPKyklC8G
X-Gm-Gg: AZuq6aLeWhjryOyEgVAnugQTa4e3uSx1H3WU6w4fdXbAM5+AhWM9J60wVnNFSIKZs5K
	Phs6ikDauJEtlWmdLOxyuLdfnOFlPJcCoEiQLpATE4JiWTBVceiZK2sDpkvCyR6PoCSgEZ+o/st
	o4ADQUBB8DVQcWaRBwO2E5nn5woiH06eQ0980ll+MdHn3blFYqlX5USpOAufdYE3malMHQ21yKh
	Rtp4S5zaU5UcZGspUzrMzjD6SVTOkoAH1XTHSpzjnQx+c9ttMxTHDLt61TygbSjLCk6ZV6DXJET
	PFho+aBZhPyo2d3HVFOF8sSyi5d1pRWyFa9xlHCyTxPjsugS6AWuiJdq1cr9OTsxfv8FZe4ENEh
	35c9ejiEFwcDb8cCA/CC7cr/qNCn2h7lvuqbFnpC/VDTLv/KfeXZRUL6lkzt8tB9Q/xDw3R+1L5
	t32/QKgByI
X-Received: by 2002:a5d:5247:0:b0:436:34e8:e665 with SMTP id ffacd0b85a97d-43634e8ef4amr189103f8f.54.1770426329243;
        Fri, 06 Feb 2026 17:05:29 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:46::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296bd4a1sm9576013f8f.17.2026.02.06.17.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 17:05:28 -0800 (PST)
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
Subject: [PATCH net-next V2 0/5] net: ethtool: Track TX pause storm
Date: Fri,  6 Feb 2026 17:05:20 -0800
Message-ID: <20260207010525.3808842-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
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
	TAGGED_FROM(0.00)[bounces-16664-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4B3DA104B73
X-Rspamd-Action: no action

With TX pause enabled, if a device cannot deliver received frames to
the stack (e.g., during a system hang), it may generate excessive pause
frames causing a pause storm. This series updates the uAPI to track TX
pause storm events as part of the pause stats (p1), propose to use the
existing knob (pfc-prevention-tout) to configure storm watchdog (p2),
adds pause storm protection support for fbnic (p3), and leverages p1
to provide observability into these events for fbnic (p4) and mlnx5 (p5)
drivers.

---
Changelog:
V2:
 - Clarify pfc-prevention-tout applies to general pause, not just PFC
   (P2)
 - Add pause storm watchdog timeout configuration via pfc-prevention-tout
   (P3)
 - mlx5: Report device stall prevention events (errors) in pause stats
   (P5)

V1: https://lore.kernel.org/20260122192158.428882-1-mohsin.bashr@gmail.com/

Mohsin Bashir (5):
  net: ethtool: Track pause storm events
  net: ethtool: Update doc for tunable
  eth: fbnic: Add protection against pause storm
  eth: fbnic: Fetch TX pause storm stats
  eth: mlx5: Move pause storm errors to pause stats

 Documentation/netlink/specs/ethtool.yaml      |  13 +++
 .../ethernet/mellanox/mlx5/core/en_stats.c    |  25 ++++
 drivers/net/ethernet/meta/fbnic/fbnic.h       |   3 +
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  11 ++
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  46 ++++++++
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.h  |   1 +
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c   |   2 +
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c   | 110 ++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h   |  27 +++++
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |   5 +
 include/linux/ethtool.h                       |   2 +
 include/uapi/linux/ethtool.h                  |   2 +-
 .../uapi/linux/ethtool_netlink_generated.h    |   1 +
 net/ethtool/pause.c                           |   4 +-
 14 files changed, 250 insertions(+), 2 deletions(-)

-- 
2.47.3


