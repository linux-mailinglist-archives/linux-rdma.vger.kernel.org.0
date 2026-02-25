Return-Path: <linux-rdma+bounces-17173-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CHpJwYFn2mZYgQAu9opvQ
	(envelope-from <linux-rdma+bounces-17173-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 15:19:50 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5DF1989D3
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 15:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B7C3130142A6
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 14:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44ED53B8BB0;
	Wed, 25 Feb 2026 14:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRBVqjNc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D2D34E769;
	Wed, 25 Feb 2026 14:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772029183; cv=none; b=lsGsaGqhsHg55wLlZI+LLyIuHe1cZRPvS+eMEPYDicETKXFRofLCV3prRTPEUr5uegLF399mmegkTkYA4HqUa+Mm/ttC8zK5jEVAzoRDAxQkU+Z0ZfJ82dJRSxlRww+0VK2JzH8uQc0sDNDGNm0nb8oCa83NIlQNl6MLchVDUow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772029183; c=relaxed/simple;
	bh=NHWyWK18Fa54m6O4DE1TWSIRPGgP6gnkdAKYGtUOmoI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X8bNRB0c3zI9pABuIyPUWeit6lVesgrYhbDuBsiEsi3kTVtzZeL9ccmkfXZ8Ca1aTwwrDhiFn87atffzmvOGSmv0QtESosOMR8eFS9Fp/ONt13rTOKP8ndgFLq/sqsHGs8RzyWWqFso3FOvYapBzLjsvEgCkcz89dOpCvvi9qZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRBVqjNc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D4C5C116D0;
	Wed, 25 Feb 2026 14:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772029182;
	bh=NHWyWK18Fa54m6O4DE1TWSIRPGgP6gnkdAKYGtUOmoI=;
	h=From:To:Cc:Subject:Date:From;
	b=eRBVqjNcfc0VGeAg97aCkrR8XyR//4k8UQQnV7gozfX33G/6WSDtd3/p4GHYYIK39
	 cc95xqUuIFkc7fQRrszBOvuR0IFbiTRp+1o/uKIVcPBo7xOd2ky6+w5l9Zc3IyPSFl
	 KJAbvgpRlin5dQ3WFCHumGQzJZubpZlwu11SVTp8XyerAIS8HVH1l2NGojXe53yq3+
	 wONgt6gVDL++CVc1U4MdkuQQHjdwNIwByQ9qt+hifzPN163vhYXnsg4d8p6223djH1
	 ZKuy7MxIk8yfZODgRz6rr9aDOizyRUhliZDN9p22PKZ+7yyNgUumhmEXhn3mJdtJVz
	 OtBhTpj56yTaQ==
From: Leon Romanovsky <leon@kernel.org>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maher Sanalla <msanalla@nvidia.com>
Subject: [PATCH rdma-next 0/6] Add support for TLP emulation
Date: Wed, 25 Feb 2026 16:19:30 +0200
Message-ID: <20260225-var-tlp-v1-0-fe14a7ac7731@nvidia.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260225-var-tlp-93de10adedb8
X-Mailer: b4 0.15-dev-47773
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_MATCH_TO(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17173-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE5DF1989D3
X-Rspamd-Action: no action

This series adds support for Transaction Layer Packet (TLP) emulation
response gateway regions, enabling userspace device emulation software
to write TLP responses directly to lower layers without kernel driver
involvement.

Currently, the mlx5 driver exposes VirtIO emulation access regions via
the MLX5_IB_METHOD_VAR_OBJ_ALLOC ioctl. This series extends that
ioctl to also support allocating TLP response gateway channels for
PCI device emulation use cases.

Thanks

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
Maher Sanalla (6):
      net/mlx5: Add TLP emulation device capabilities
      net/mlx5: Expose TLP emulation capabilities
      RDMA/mlx5: Refactor VAR table to use region abstraction
      RDMA/mlx5: Add TLP VAR region support and infrastructure
      RDMA/mlx5: Add support for TLP VAR allocation
      RDMA/mlx5: Add VAR object query method for cross-process sharing

 drivers/infiniband/hw/mlx5/main.c              | 196 ++++++++++++++++++++-----
 drivers/infiniband/hw/mlx5/mlx5_ib.h           |   8 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw.c   |   6 +
 drivers/net/ethernet/mellanox/mlx5/core/main.c |   1 +
 include/linux/mlx5/device.h                    |   9 ++
 include/linux/mlx5/mlx5_ifc.h                  |  23 ++-
 include/uapi/rdma/mlx5_user_ioctl_cmds.h       |   9 ++
 include/uapi/rdma/mlx5_user_ioctl_verbs.h      |   4 +
 8 files changed, 218 insertions(+), 38 deletions(-)
---
base-commit: 58409f0d4dd3f9e987214064e49b088823934304
change-id: 20260225-var-tlp-93de10adedb8

Best regards,
--  
Leon Romanovsky <leonro@nvidia.com>


