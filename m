Return-Path: <linux-rdma+bounces-20924-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJ/LOSRCC2p5FAUAu9opvQ
	(envelope-from <linux-rdma+bounces-20924-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 18:45:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D6B571236
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 18:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A98AB30117A9
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 16:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E279D3F65FF;
	Mon, 18 May 2026 16:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=volta.cloud header.i=@volta.cloud header.b="X3OqSqTv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [178.154.239.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B913E409DE0;
	Mon, 18 May 2026 16:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779122677; cv=none; b=aeVcv10rtFVC+u2qnmiQd7x7xAKXT+XRkDgYhIrl6UHCf3UdDL/UKD0JnGqtTHR1CXCqQcygVHgavr8OHraklq0N0XM2ZF/kWErJMHz8V1OwSCGvcDBrztzzfEEOKjkOXnLTyAceQiEL0OanqST89vO7RCWnYiXKUAZaEqAot+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779122677; c=relaxed/simple;
	bh=odvWJL/abgNFeUV3FeS/I9Mjl5v7OKVfWA0y/ihaRl4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Xr0cfZNsQjkcJ8xRThWduiHiLfe7AoKqlAcbvmTGqRxJ6uJAH2FtLpWyY+FhRv7nfg7t1OE7UpRfsC5hPPveeyIuAsAA/Kd/XSAyMsZW8WCCtkdGM9/p1ckCRfe5FFgQuWd9t06T6f9HDzKPuSn3uwHeM1cKzbBtfPdA385Cy7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=volta.cloud; spf=fail smtp.mailfrom=volta.cloud; dkim=pass (1024-bit key) header.d=volta.cloud header.i=@volta.cloud header.b=X3OqSqTv; arc=none smtp.client-ip=178.154.239.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=volta.cloud
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=volta.cloud
Received: from mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:2a2c:0:640:49cf:0])
	by forward102a.mail.yandex.net (Yandex) with ESMTPS id 3A7BDC005E;
	Mon, 18 May 2026 19:44:27 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net (smtp) with ESMTPSA id MiTxBInRHKo0-B99ZpHGk;
	Mon, 18 May 2026 19:44:25 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=volta.cloud; s=mail;
	t=1779122666; bh=4IBrlqOCR7NjKAY0z+aKMBU0gduxXEdD8zMrqkaY3+E=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=X3OqSqTvfJnE0OFvaAdzqoXpwdFlhcgsYekhpeazeOBs+fORd3d72DWD7ezg0h/QH
	 HUuDMoyHlbChJGYtVqtWwN+f+Wvd++9uLcPRHdeZrp4jIbmWt2MrkMhky7lW7lXskW
	 W4/OfCdSZrYWy6R80fiM5Ll1sDl92qsEjr7xrbDU=
Authentication-Results: mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net; dkim=pass header.i=@volta.cloud
From: Max Makarov <makarov@volta.cloud>
To: netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, leon@kernel.org
Subject: [QUESTION] mlx5: format_select_dw_8_6_ext capability on ConnectX-7
Date: Tue, 19 May 2026 01:44:22 +0900
Message-ID: <177912266235.29998.14244693862353385829@volta.cloud>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[volta.cloud,none];
	R_DKIM_ALLOW(-0.20)[volta.cloud:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[volta.cloud:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20924-lists,linux-rdma=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[makarov@volta.cloud,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 97D6B571236
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Question about the cmd_hca_cap_2.format_select_dw_8_6_ext bit (introduced
into mlx5_ifc.h in v6.12-rc1).

On all three of our standalone ConnectX-7 SKUs (PSIDs MT_0000000838,
MT_0000000840, MT_0000000892, firmware 28.48.1000) this bit reads as 0 in
both GET_CUR and GET_MAX modes. The DPDK code at
drivers/net/mlx5/hws/mlx5dr_cmd.c reads it without any device-ID
conditional, so it appears to be exclusively firmware-controlled — yet
firmware reports 0 across all our CX-7 cards, including the latest
public release.

This blocks DOCA Flow CT pipe for IPv6 (which requires the 11-DW jumbo
STE format gated by this bit).

Two questions:

  1. Is the kernel's filter that rejects SET_HCA_CAP for cap_class != 
     MLX5_CAP_GENERAL intentional? If so, what's the rationale?

  2. From the NVIDIA side: is this capability hardware-fused on standalone
     CX-7 (BlueField-3 advertises it as 1), or could a future firmware
     release enable it on CX-7?

Thanks,
Max Makarov
Volta Cloud

