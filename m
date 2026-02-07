Return-Path: <linux-rdma+bounces-16667-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id BMz0AUqzhmnTQAQAu9opvQ
	(envelope-from <linux-rdma+bounces-16667-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Feb 2026 04:36:42 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5781F104CB1
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Feb 2026 04:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6957930185A2
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Feb 2026 03:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BB533DEE0;
	Sat,  7 Feb 2026 03:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T99Xo3Al"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5880E18BC3B
	for <linux-rdma@vger.kernel.org>; Sat,  7 Feb 2026 03:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770435395; cv=none; b=Pi4hRhihtLTFRPodLjdd8bD7YnqVEAdSCFBtaax1JvBhsbH4ruVJ2EfX+e9s9KECUxPk+5y2Qov5qOl6J7b2DI2HQ+s9vv20d3hZx1rXLZMHNpBNCqGkKPW4JCryNu8glHvjF0lUaymJA+eSftjnSPHA1JAdpS74GwDAdZa6wRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770435395; c=relaxed/simple;
	bh=F75+iwxlRTLyIzKuJzJ+ID7DQ02GZVbuxnZkr4FlfjY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sBWvJYSzOOxClddT+CTmdb6UrPIud2oT2KpjcpodgyzNuL4J32KN5cr5GCLhgxvUJ94rAHSgNykH8t0FFtdL5gUGvVjOekdr60biSpUX41uD51br1xBUhg98czICz9x3z8cwXW5ZcAyE4lLmqm0US+illieaKN9bzjJacROBBaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T99Xo3Al; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47ee3a63300so28909945e9.2
        for <linux-rdma@vger.kernel.org>; Fri, 06 Feb 2026 19:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770435394; x=1771040194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nV2/pR09fRCKiwS6HhA3KDDNoxylvhh0vYo9VwjMiO8=;
        b=T99Xo3AlOdOvHhHBTmTgeuXXnaK3A7Jnr16666BMuCxBsUGA7q+CSxfCO7tW0SzKos
         0DJM6j9/RF74845gprD0ctnPMSpDbSr0OcQIJXjI2+EDwogd3+npq+IEmJwJl8PFEDAg
         O5wvG4Y76ELcGEBDxD1WznKoDVQ11b+GdTskiclemB3sxDNjhvbvrbVHL61RP2piZ+fv
         DMxNHsAqlLqFCam/FXnzjj7a22jZndO5mPqdDb8js49ppb1AmtPjliLjM/hB9u+Go5cx
         ts6bUspDQ4ouN5g/M1nq7vLQ1zVCOBg3dQjTi8c6Jv66Abj3pKCKQBpfFTXtL0ETbNg7
         7wig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770435394; x=1771040194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nV2/pR09fRCKiwS6HhA3KDDNoxylvhh0vYo9VwjMiO8=;
        b=G+OsQmh7q/rbd1TwJX/gK6BlPeXKEdfM/ETpnnWA+7nCzayvr4pdVFUaH2j7jN1oYl
         b1sbdlw5dLMouEeDRuaDYRESe1gBGbiuD7mqJZwJpkWxg83cNkWVUqL+omjEJ4Rw+xfx
         V5n0FErdvlKzXCtHeYQ4CFfgWPKcdbX3M0Y7yfix3w01mBo2qNFUmzwuS3R7ElYJXHEP
         FWbgi9EnDAV6LsugXsnzH6EJo7uRjQwgnJmb56DqBplWFOU0tnKY/zpppRgIW5BUhUPK
         xU4JBB0B9heqEKKDycHPs4ypxTfsuIjcMc/cEaOZmFBuW5FFvJdYOq8S1iyQenBU8Ehz
         N/7g==
X-Forwarded-Encrypted: i=1; AJvYcCUrFxjZVUPwzifO4SA4t42YRjmoAx7BHsgLDwjYYylKVoV2eMXfiJnmnNZI7/Z/OyhEVqWCn3g7XmfJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxJe+x86usZPbVZzd+BGS9ZbChRzjAZWk6oyHlTtQemh5tctEgu
	+zWfV5xVcSWiKNPntKm81zJ5vMtBKjh8Zag6S5k8uhiYSeKynVQqcF/RZDQG8UwD
X-Gm-Gg: AZuq6aLMdT+p+Way14lUnUcCrndQxUONr4Kaz7473Ss4hM8RUzEGeh0PganPUER1V1r
	dq13Izr1VJ6FXPv8mIuOOddPlVT6CvafXtvUZ9BLrudbYPqXTUZYMfIzT4euXxkCN72XLDnE40r
	OaW/x0XrY5V6SxrftVDuMZE5343C1dNYZUzVabzboG8gyRHRsY8LcKrMsDIXEjMcsQ6Baf6D69J
	QLwRZ98yTDI7+ghsil2mUKCNJzkdweoW5MNcNmbPf0V2QsUEagD6/u37QzmvOPaXxtDF5MyYl9g
	OeACPNrtScz/plHTNwMmQmDeXJsjriHb+gWqqUJA8USzdXUATIooClhkiNttsErnSlfALd+JJ9Y
	tA1UnM39ZgiM2b1tClT5IkaZ23XJEn/9odI6UcNotGC1cIPujLxtXt5+Xzkf1mVMo5Uj8ZK0AZJ
	xgVMjfRS4=
X-Received: by 2002:a05:600c:8b6f:b0:477:7975:30ea with SMTP id 5b1f17b1804b1-48320236963mr61223265e9.29.1770428553506;
        Fri, 06 Feb 2026 17:42:33 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:7::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48320961701sm59340825e9.5.2026.02.06.17.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 17:42:33 -0800 (PST)
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
Date: Fri,  6 Feb 2026 17:42:30 -0800
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16667-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5781F104CB1
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


