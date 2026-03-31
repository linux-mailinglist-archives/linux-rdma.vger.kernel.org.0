Return-Path: <linux-rdma+bounces-18826-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGAjKCFiy2nCHAYAu9opvQ
	(envelope-from <linux-rdma+bounces-18826-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 07:56:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7AE364444
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 07:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B4FB7303B979
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 05:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BB5371071;
	Tue, 31 Mar 2026 05:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkYAQvBF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AE3611E;
	Tue, 31 Mar 2026 05:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774936606; cv=none; b=aOSHW2vGD21usnWjD+3fekpE68qZX5kFv6KPuN2j2YzxyIFSj6YkmiAu5PqR0siBW+LxRpNlUSXyiJsS+8pNDlw+5y/ObE7Qg+hwAnkPOYlivCJc1EohWynnR0t36Hp2/615kWM6PNf6wtWRHtMA+2+/BmMbjaWehUygLuavWxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774936606; c=relaxed/simple;
	bh=A2zYglo1Gfo+yff/OlPEexyVPm4pn2nuiVBrulA3KFg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n5jdx9W8g5iBOL1IN5BQxohV+9ANTdqO/3JZfiJOTkKG2CgQ5K6jbRmb+Soj8+zbNypT0dB8PhWv9ft8UEHNJ5AMXiCyXV/Tr1OI3dgx54GYiftwlqFuY3du1xhBxBTUnnJ1/dtQvJ7/jRiYqnZSgAtliwwmYEKibTWcaCkFhQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkYAQvBF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C34FC19423;
	Tue, 31 Mar 2026 05:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774936605;
	bh=A2zYglo1Gfo+yff/OlPEexyVPm4pn2nuiVBrulA3KFg=;
	h=From:To:Cc:Subject:Date:From;
	b=PkYAQvBFBpk21JSYN/aAbeuAzEoRKDShu47jqQB/sVWwdSsgAONuF3Wpyw5VRTcDF
	 K3NwNe0GTLJW8TJ2KlGTCRkTV4FBZIhUP96Km7pKextNbfn4v07BDlhqrNJn1i7l3t
	 X6nmgsRfphG2JPUhcAVR2vRjfNfdfnwgdONYt8W4qVks1ddIoZc92AS4WFyiMEmmSq
	 7Az3DBUMrnbOqULqe+gtqnDEWukPqGA5+jm6U8mYFYfoLzyIUP3AuHVRABZR4kBG3r
	 nvaXKUCTbMTtlP1l2WvXzjpsci0yVRfkw17xTNPl0+OC9AwVuwBdp8yctuiRtYntc2
	 PaWus3+/c/qug==
From: Leon Romanovsky <leon@kernel.org>
To: KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Itay Avraham <itayavr@nvidia.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Chiara Meiohas <cmeiohas@nvidia.com>,
	Maher Sanalla <msanalla@nvidia.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 0/4] Firmware LSM hook
Date: Tue, 31 Mar 2026 08:56:32 +0300
Message-ID: <20260331-fw-lsm-hook-v2-0-78504703df1f@nvidia.com>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18826-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,google.com,iogearbox.net,gmail.com,linux.dev,fomichev.me,ziepe.ca,nvidia.com,intel.com,huawei.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.975];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: 1A7AE364444
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From Chiara:

This patch set introduces a new BPF LSM hook to validate firmware commands
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
Changes in v2:
- Fixed style formatting issues pointed by Jonathan
- Added Jonathan's and Dave's ROB tags
- Implemented as BPF LSM hook instead of general LSM hook
- Added selftest to execute that new hook
- Removed extra FW_CMD_CLASS_MAX enum, it is not needed
- Link to v1: https://patch.msgid.link/20260309-fw-lsm-hook-v1-0-4a6422e63725@nvidia.com

---
Chiara Meiohas (4):
      bpf: add firmware command validation hook
      selftests/bpf: add test cases for fw_validate_cmd hook
      RDMA/mlx5: Externally validate FW commands supplied in DEVX interface
      fwctl/mlx5: Externally validate FW commands supplied in fwctl

 drivers/fwctl/mlx5/main.c                        | 12 +++++-
 drivers/infiniband/hw/mlx5/devx.c                | 49 ++++++++++++++++++------
 include/linux/bpf_lsm.h                          | 41 ++++++++++++++++++++
 kernel/bpf/bpf_lsm.c                             | 11 ++++++
 tools/testing/selftests/bpf/progs/verifier_lsm.c | 23 +++++++++++
 5 files changed, 122 insertions(+), 14 deletions(-)
---
base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
change-id: 20260309-fw-lsm-hook-7c094f909ffc

Best regards,
--  
Leon Romanovsky <leonro@nvidia.com>


