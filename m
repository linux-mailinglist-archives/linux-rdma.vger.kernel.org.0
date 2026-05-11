Return-Path: <linux-rdma+bounces-20396-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANq2KPYBAmrknAEAu9opvQ
	(envelope-from <linux-rdma+bounces-20396-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 18:21:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A54D3511FF1
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 18:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9D7F130786D3
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 15:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF49421A05;
	Mon, 11 May 2026 15:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RL/1DKsh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6F041C31B
	for <linux-rdma@vger.kernel.org>; Mon, 11 May 2026 15:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778515119; cv=none; b=sngEeRRPtN2lh4ra1EwkcUMIeIR1Q1JWPN4yRA4zNfctffrmBN+ChJGAA+HDYyxdu6/qfsK32BC00Xo3+HycV7i68lcJhnpG5ynTvByfUboHcjvSM62L0N9ESNBPnzdiEMa7KHpAAnbNOYvSmFTDK5enI5IdTMYcPaWDzZyMhMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778515119; c=relaxed/simple;
	bh=0f733Z/TX/wx+L/uoTgJYtOAPWpuzndYa6v+JxLLAls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TRYFnPkP6B6Cd4UnPdPZ6h0+kxkh5dsfWul+Dw0721n72u5CHzpl4IZPURCPtRSgGuwghLbxznjytS+45tSBCOyQZMxWIl7lN/mPvCwgb5l8x315IMvIX4Cok0O7q6l2Cgt3nRPWM4LAIk1IcTyMGQYTGTPCa/OsXl18om8G7jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RL/1DKsh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778515117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PvBs0XuNqDi9m0Wooxh2TkMdEChLbJ5nV+4KSQ/yOts=;
	b=RL/1DKshFbWRTnx3ykgJftwbJqu2px3OVR89HLcR2mj+/Sf0ci9qWSIliaLxpIOYTlqgKm
	pkT8vXJJslHVIG+R0ib4gL1mkaajDT3Iv/xXEUaI/uP8T7lAp7mjzD17yaClzub0lqDVev
	6/ZsICCR4hjF4E1VDS/nxmBrF55C8bA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-XZzcg4T9MlydHuQCVRB6jg-1; Mon,
 11 May 2026 11:58:29 -0400
X-MC-Unique: XZzcg4T9MlydHuQCVRB6jg-1
X-Mimecast-MFC-AGG-ID: XZzcg4T9MlydHuQCVRB6jg_1778515106
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3236618002C9;
	Mon, 11 May 2026 15:58:25 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.49.148])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 24101180034E;
	Mon, 11 May 2026 15:58:17 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>,
	Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Pasi Vaananen <pvaanane@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Simon Horman <horms@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v4 0/2] dpll: rework fractional frequency offset reporting
Date: Mon, 11 May 2026 17:58:14 +0200
Message-ID: <20260511155816.99936-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Queue-Id: A54D3511FF1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,intel.com,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,lwn.net,nvidia.com,redhat.com,microchip.com,linuxfoundation.org,linux.dev,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20396-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Rework how the fractional frequency offset (FFO) is reported in
the DPLL subsystem.

Both fractional-frequency-offset (PPM) and
fractional-frequency-offset-ppt (PPT) attributes are now present at
the top level of a pin and inside each pin-parent-device nest. They
carry the same measurement at different precisions.

Introduce enum dpll_ffo_type and struct dpll_ffo_param to distinguish
FFO contexts: DPLL_FFO_PORT_RXTX_RATE for the RX vs TX symbol rate
offset at the top level, and DPLL_FFO_PIN_DEVICE for the pin vs
parent DPLL offset in the nest. Drivers declare which types they
support via the supported_ffo bitmask in dpll_pin_ops; the core only
calls ffo_get for opted-in types.

Patch 1 adds the type-safe FFO API, updates the YAML spec, netlink
handling, and documentation, and converts mlx5 and zl3073x drivers.

Patch 2 implements the nested FFO for zl3073x using the
dpll_df_offset_x register with ref_ofst=1, providing 2^-48
resolution. The old per-reference frequency measurement is removed
as it was redundant with measured-frequency.

Changes v3 -> v4:
- Replace dpll=NULL overloading with enum dpll_ffo_type and
  struct dpll_ffo_param (Jakub Kicinski)
- Add supported_ffo opt-in bitmask in dpll_pin_ops for fail-close
  driver validation (Jakub Kicinski)
- Add WARN_ON in dpll_pin_register for supported_ffo without
  ffo_get callback
- Use atomic64_t for freq_offset to prevent torn reads on 32-bit

Changes v2 -> v3:
- Keep both FFO attributes (PPM and PPT) at both levels instead of
  moving PPT under pin-parent-device only (Jiri Pirko)
- Unify attribute documentation to describe semantics at each level

Changes v1 -> v2:
- Minor commit message fixes

Ivan Vecera (2):
  dpll: add fractional frequency offset to pin-parent-device
  dpll: zl3073x: report FFO as DPLL vs input reference offset

 Documentation/driver-api/dpll.rst             | 20 +++++++++
 Documentation/netlink/specs/dpll.yaml         | 28 +++++++-----
 drivers/dpll/dpll_core.c                      |  3 +-
 drivers/dpll/dpll_netlink.c                   | 30 +++++++------
 drivers/dpll/dpll_nl.c                        |  2 +
 drivers/dpll/zl3073x/chan.c                   | 31 ++++++++++++-
 drivers/dpll/zl3073x/chan.h                   | 14 ++++++
 drivers/dpll/zl3073x/core.c                   | 45 -------------------
 drivers/dpll/zl3073x/dpll.c                   | 40 ++++++++---------
 drivers/dpll/zl3073x/ref.h                    | 14 ------
 drivers/dpll/zl3073x/regs.h                   | 15 +++++++
 .../net/ethernet/mellanox/mlx5/core/dpll.c    |  6 ++-
 include/linux/dpll.h                          | 16 ++++++-
 13 files changed, 154 insertions(+), 110 deletions(-)

-- 
2.53.0


