Return-Path: <linux-rdma+bounces-17772-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDeeBd+srmntHQIAu9opvQ
	(envelope-from <linux-rdma+bounces-17772-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 12:19:59 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BD0237CA5
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 12:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68CDD3059F00
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 11:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9E139A05B;
	Mon,  9 Mar 2026 11:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrUouEkg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7E9393DCC;
	Mon,  9 Mar 2026 11:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773054928; cv=none; b=trSL2gAE71+lWfvPmVJDtkeRoxLt9frJpBERSdcCiinxiu14KPQjn08IeaaCVRPzpPD5woTgigRmoO642ueFWPSofmf+P7d22ryIf6CyYedw90Cf0IoEUvV8hc1h+sgCL1rLEMTayK/w0rGwo/LAVIpaMWnlDzlWyzYwIglro2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773054928; c=relaxed/simple;
	bh=PyyXNPAPNuylPisI8JICtfD+u/G8XW574ALIV0Myfm8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mKVOduNAkpD+WCL3xGh3l4bhB1OxNJse10P1uJ74hZxpSETb/bqW9Wo2IBH4m0PhfhuDGtL9rMUJkP9DGUCOkaAD0KUSgAswDI5YSoPUtgtz5Tk1pRo2iPrGTCdVTwvmB3mO41hfMQQI4+gPYh8pJi7R4Cwa4YRctykvJTF1UF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrUouEkg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E2F2C4CEF7;
	Mon,  9 Mar 2026 11:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773054927;
	bh=PyyXNPAPNuylPisI8JICtfD+u/G8XW574ALIV0Myfm8=;
	h=From:To:Cc:Subject:Date:From;
	b=TrUouEkgQMvUH+eJaUtmnBj/i/d+fW0GaxLbZPCn8DXQjI3xglfAfO/tp7FqoAfWe
	 Yvp6CH7doSzps4ggMLSjO49WdDSHno1MHG/JnzOwJ1PIfp1Q81bYoq+pM2jPRGIsCK
	 8gLqd8ju4VJb9rBGE8OeyXquWFcj9x9WcytOlC2HqHazNatXIoi3/enqitIUFPl/U9
	 AYCh4ruQXWC6HLv7ZYzi6NJP6M3Xz8Sz+55MVce6jyIJwQ9L+CPOi/sICK+3l2KuX4
	 BLLHByUkBPkmJOcGYqf2bfMithk5SIg53pVWmh1fePqB1cqi8qtPI8b6XTDwtN7mBC
	 2JW9WMQK1LTpg==
From: Leon Romanovsky <leon@kernel.org>
To: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Itay Avraham <itayavr@nvidia.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Chiara Meiohas <cmeiohas@nvidia.com>,
	Maher Sanalla <msanalla@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>
Subject: [PATCH 0/3] Firmware LSM hook
Date: Mon,  9 Mar 2026 13:15:17 +0200
Message-ID: <20260309-fw-lsm-hook-v1-0-4a6422e63725@nvidia.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260309-fw-lsm-hook-7c094f909ffc
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B3BD0237CA5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17772-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.931];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From Chiara:

This patch set introduces a new LSM hook to validate firmware commands
triggered by userspace before they are submitted to the device. The hook
runs after the command buffer is constructed, right before it is sent
to firmware.

The goal is to allow a security module to allow or deny a given command
before it is submitted to firmware. BPF LSM can attach to this hook
to implement such policies. This allows fine-grained policies for different
firmware commands. 

In this series, the new hook is called from RDMA uverbs and from the fwctl
subsystem. Both the uverbs and fwctl interfaces use ioctl, so an obvious
candidate would seem to be the file_ioctl hook. However, the userspace
attributes used to build the firmware command buffer are copied from
userspace (copy_from_user()) deep in the driver, depending on various
conditions. As a result, file_ioctl does not have the information required
to make a policy decision.

This newly introduced hook provides the command buffer together with relevant
metadata (device, command class, and a class-specific device identifier), so
security modules can distinguish between different command classes and devices.

The hook can be used by other drivers that submit firmware commands via a command
buffer.

Thanks

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
Chiara Meiohas (3):
      lsm: add hook for firmware command validation
      RDMA/mlx5: Invoke fw_validate_cmd LSM hook for DEVX commands
      fwctl/mlx5: Invoke fw_validate_cmd LSM hook for fwctl commands

 drivers/fwctl/mlx5/main.c         | 12 +++++++--
 drivers/infiniband/hw/mlx5/devx.c | 52 ++++++++++++++++++++++++++++++---------
 include/linux/lsm_hook_defs.h     |  2 ++
 include/linux/security.h          | 25 +++++++++++++++++++
 security/security.c               | 26 ++++++++++++++++++++
 5 files changed, 103 insertions(+), 14 deletions(-)
---
base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
change-id: 20260309-fw-lsm-hook-7c094f909ffc

Best regards,
--  
Leon Romanovsky <leonro@nvidia.com>


