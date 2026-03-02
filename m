Return-Path: <linux-rdma+bounces-17403-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FdjAjYYpmmeKQAAu9opvQ
	(envelope-from <linux-rdma+bounces-17403-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 00:07:34 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 721261E64F5
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 00:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3DFF03035031
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2026 23:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7841310655;
	Mon,  2 Mar 2026 23:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8XewL92"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4792DB790
	for <linux-rdma@vger.kernel.org>; Mon,  2 Mar 2026 23:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772492516; cv=none; b=okbLf2MgXBCaZJweaREWIdbi8UsQgn+Im3XPHu2PTPTuhQs8kG/cUt86YRxXwBHFKU5U1aMMh4mmVpv0IEMbiRuf4fhxcU5qECEZBfSPUpthIooHdf/ycvhz2J9HL65iMxdoq5ZjNISOtXWU6mgbavP3PIm16mxdsUxr6VKaCxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772492516; c=relaxed/simple;
	bh=Z/aZeYO2oArPKJ0qd5XfE+4I22GqCcXgGJizvM7r3Vo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E1BdwNAOoD0w9iVeBEH+8JOwpMxTBSJZYdSFx5gxkyF2SFOGisfzEvI3V7TZh005CDj8oS90H+cEi8Pjq1yxnW2NQ67sdlc+WjuqNgOzxyLsnUokDSDJRGGWKohjQcDYry9q4OeicmMVgIQl0JXj2Z7QXJEzBxQ2mZ1sroCIB00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8XewL92; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4837907f535so43534865e9.3
        for <linux-rdma@vger.kernel.org>; Mon, 02 Mar 2026 15:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772492514; x=1773097314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WvEd2KF0bVK+blm9zxi0baLV35fCzKlSXCd8TlmuSeE=;
        b=g8XewL921avGRVl3OPuuy7qwdcO2RMGHvDmHiHdky1FzXROizhME+/r74ciM4zBrds
         zIO08QWGNKubUSDDbm5Q34eXwri3uitR/owgrUC+u+eo5e+VcPcSPoTGagScRZRGgGtn
         syVeaGbQ2sTDyM2du9c8C9O9zy2qOKYMJyi8NW69NCcC1goCeZqTSoLPC0uDkNIEvJC8
         Mj/DecwpKKh4keno6SudS9OOvH0GH3jqd2Z6GRN9TKET6IjlHqPU7ETc9TcPHuWKGb+r
         gHQLhs9iRgyGsAPnErdO7wUuilPMYhXhptq23oDSipsAPXXgOaQ+YbiOTYXjV2vxpx3R
         LUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772492514; x=1773097314;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvEd2KF0bVK+blm9zxi0baLV35fCzKlSXCd8TlmuSeE=;
        b=MXeRSsIfursR4cRAIEFg+NY+FzR0UhOMjjtext2qX4RdtxVpD93LzlZ1xDj1Fk0c/x
         cj3wK6THtQ80Q7meCJNL/mLkImc0oYTh51BJUZraRb7D2Du+nEb4SpI4ly114MbuP11Z
         55VMvXBbOPBYa8FgqrcpdbJNGCx5sf5BT7t8tzqR41vvwpHRolfxxDNTMeuL3m4T9qAZ
         SdFkt4JIbcYYLHdQZXNU5oopwRmhftZXfE/brTUvmMc9vNiX3TfpF9zjVbOa2yCldOC6
         iChO7cmTaFh0C9jA0vK7LmhoGfJkHpCtwxAtwn3Z6Les/RqgN/mgcJlTZCNdB2Pe5GPm
         72vg==
X-Forwarded-Encrypted: i=1; AJvYcCW2ksom295wK+SWFBVM7tXUB6rTpvuq87cGClnG2OiUz4iIzdsiI+KOF3l/NeQ283q5HRBSTdOQc99j@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4w123UdP8OUPPIlZwsYCqNRUHSm407+Pn579a3ceh60RtARFG
	+S4fjVeHY0hRX0J88i3r8lIknsSFTsNHVCr7xwAI3qHCecbFKW3ujNSe
X-Gm-Gg: ATEYQzxcFknHhTG6TcnLkZ8/6Jc4awuQdyVCfgvmJfn7jgpz/2bDTn35s6sk1ocYxAc
	Pg8qrY7VIYwRKMi0Bt/IWsJV+R7tE2wKTzzcpsKdRJcGTOK0+XU/tIeRU+TYg+QKQdJ8lR+LPvd
	ybUMkFD5J8lHdoONweg8yHAfT83efnIZ3eszjyLcW2icVck9GjC1bcmk0cKxCLnh2ejrrsM7DAO
	aKEjfom3Uk9rdgk7GRChmTRlJ5vAiqZ6N7dUS9UD10hhB1QjbQGDqRQLEIKiMVwFxCHj/aq5RRa
	YDkK1mcOIxixUNtn+05O4vLHbRsAQen7w3gB32WR3D8AqCK6FRZGT6fuuWq5wo10QaLdFQq8cyu
	MmwDLg/XvS1fisROHO+3VH81rd+N/H8L+V//Lck2X/FoOuM9hXveoJYecwSlB4OW7U1okuh8wnY
	KRz+hPQciLApSpLicK0XWHRyYy2p5NeVs=
X-Received: by 2002:a05:600c:a0a:b0:483:7813:90d8 with SMTP id 5b1f17b1804b1-483c9b94296mr221431575e9.1.1772492513269;
        Mon, 02 Mar 2026 15:01:53 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:4f::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd70e6c9sm382969055e9.8.2026.03.02.15.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 15:01:52 -0800 (PST)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	alok.a.tiwari@oracle.com,
	andrew+netdev@lunn.ch,
	andrew@lunn.ch,
	davem@davemloft.net,
	dg573847474@gmail.com,
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
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux@armlinux.org.uk,
	mbloch@nvidia.com,
	mike.marciniszyn@gmail.com,
	mohsin.bashr@gmail.com,
	o.rempel@pengutronix.de,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	vadim.fedorenko@linux.dev
Subject: [net-next V4 0/5] net: ethtool: Track TX pause storm
Date: Mon,  2 Mar 2026 15:01:44 -0800
Message-ID: <20260302230149.1580195-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 721261E64F5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17403-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,oracle.com,lunn.ch,davemloft.net,gmail.com,google.com,nvidia.com,kernel.org,intel.com,meta.com,bootlin.com,trager.us,vger.kernel.org,armlinux.org.uk,pengutronix.de,redhat.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[29];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

With TX pause enabled, if a device cannot deliver received frames to
the stack (e.g., during a system hang), it may generate excessive pause
frames causing a pause storm. This series updates the uAPI to track TX
pause storm events as part of the pause stats (p1), proposes using the
existing pfc-prevention-tout knob to configure the storm watchdog (p2),
adds pause storm protection support for fbnic (p3), and leverages p1
to provide observability into these events for the fbnic (p4) and mlx5
(p5) drivers.

Changelog:
- V4: Drop RFC. No feedback received on V3.

- V3(RFC):
https://lore.kernel.org/netdev/20260223174914.74461-1-mohsin.bashr@gmail.com/

- V2:
https://lore.kernel.org/20260207010525.3808842-1-mohsin.bashr@gmail.com/

- V1:
https://lore.kernel.org/20260122192158.428882-1-mohsin.bashr@gmail.com/

Mohsin Bashir (5):
  net: ethtool: Track pause storm events
  net: ethtool: Update doc for tunable
  eth: fbnic: Add protection against pause storm
  eth: fbnic: Fetch TX pause storm stats
  eth: mlx5: Move pause storm errors to pause stats

 Documentation/netlink/specs/ethtool.yaml      |  13 ++
 .../ethernet/mellanox/mlx5/core/en_stats.c    |  30 +++++
 drivers/net/ethernet/meta/fbnic/fbnic.h       |   3 +
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  11 ++
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  46 ++++++++
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.h  |   1 +
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c   |   2 +
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c   | 111 ++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h   |  27 +++++
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |   5 +
 include/linux/ethtool.h                       |   2 +
 include/uapi/linux/ethtool.h                  |   2 +-
 .../uapi/linux/ethtool_netlink_generated.h    |   1 +
 net/ethtool/pause.c                           |   4 +-
 14 files changed, 256 insertions(+), 2 deletions(-)

-- 
2.47.3


