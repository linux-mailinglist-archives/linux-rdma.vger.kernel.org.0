Return-Path: <linux-rdma+bounces-16668-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id TNioLjbKhmmbQwQAu9opvQ
	(envelope-from <linux-rdma+bounces-16668-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Feb 2026 06:14:30 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F1C104FE4
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Feb 2026 06:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 558123008992
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Feb 2026 05:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABBA2ECEA3;
	Sat,  7 Feb 2026 05:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTc6uhM9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D09D217F27;
	Sat,  7 Feb 2026 05:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770441265; cv=none; b=DVqyu0XifG4GNTqoi5WvI4Q8WKS+N4qO1Tr1kl0v3B7j4WCzxDj90NksAe4oqk4txYLD6SaxPddhPJvRHWlUV5vs6JrSlw9ZHMcXMNtotzirZJlk2nbakPg2nFhQZWcjiWS7uSe/1mjkZuPd9WnVUKWDFLaW58+DcZrvc8OGtbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770441265; c=relaxed/simple;
	bh=WwBUxFFfKA66xrbBTVU0y6UWZ1GSe6yq1/Qw+mQnZSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TfzOavS7Q3vwfyjCiMAQQojYvmqaec+Pq+OauXteqH4VfsG1I667YWBWvpgVyG8bpgiF6AFWLj6N7gnygEu8//v4CfEFK7QggjhlXaSDXZpTfcnB8VYzUDGfFiD58jojfcU6b/kt0RGCEeKO5XiMF5BzINw6A/bNgekKfA70PZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTc6uhM9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3585C116D0;
	Sat,  7 Feb 2026 05:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770441264;
	bh=WwBUxFFfKA66xrbBTVU0y6UWZ1GSe6yq1/Qw+mQnZSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LTc6uhM9qhMvNRysnX84I7uo7w2+AujGVGzbVAYMRhKYuzf3d+/hnNHx7hK4tHbEZ
	 aaRvepLCi8VXZ/yn2ZJLhCJQztfdZc7S+sxYrANVnYUvcGiUqKAwqk60MlAxL1zTGc
	 +dTEXijN0FHzhVcbFr38HDpvdPD3tkN3Xq2VafxO4tvObQlxgI99sN/HzrQUAd9Vtb
	 4eXqhPbCpo9SuGf4qTdIzupgzzRpC3zLaZ1N5NuK+ZmL6vq8NU7vcVAF8Lypr2uZhk
	 B5RhBKCbbKQ2F6D0ZIKIx7c44XKaFWFjBDkXrJS4DRII3BAK8aB1o6XsnXN3dydCL1
	 s6WsnrDDD1LJg==
From: Jakub Kicinski <kuba@kernel.org>
To: vikas.gupta@broadcom.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	bhargava.marreddy@broadcom.com,
	siva.kallam@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	horms@kernel.org,
	jgg@nvidia.com,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	leonro@nvidia.com,
	edumazet@google.com,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	michael.chan@broadcom.com,
	ajit.khaparde@broadcom.com,
	rajashekar.hudumula@broadcom.com,
	pavan.chebbi@broadcom.com
Subject: Re: [net-next,v2] bnge/bng_re: Add a new HSI
Date: Fri,  6 Feb 2026 21:14:22 -0800
Message-ID: <20260207051422.4181717-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260206052614.1676580-1-vikas.gupta@broadcom.com>
References: <20260206052614.1676580-1-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-16668-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 44F1C104FE4
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
bnge/bng_re: Add a new HSI

This commit adds a new HSI (Hardware Software Interface) for the BNGE and
ThorUltra RoCE drivers. The HSI is automatically generated and shared between
firmware and driver, replacing the existing BNXT HSI references.

> diff --git a/drivers/infiniband/hw/bng_re/bng_roce_hsi.h b/drivers/infiniband/hw/bng_re/bng_roce_hsi.h
> new file mode 100644
> index 000000000000..1c4666eb0c87
> --- /dev/null
> +++ b/drivers/infiniband/hw/bng_re/bng_roce_hsi.h
> @@ -0,0 +1,6450 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2026 Broadcom */
> +
> +/* DO NOT MODIFY!!! This file is automatically generated. */
> +
> +#ifndef __BNG_RE_HSI_H__
> +#define __BNG_RE_HSI_H__

[ ... ]

> +};
> +
> +#endif /* _ROCE_HSI_H_ */
           ^^^^^^^^^^^^^^^^

This isn't a bug, but the include guard comment doesn't match the actual macro
name. The file opens with '__BNG_RE_HSI_H__' but closes with a comment
referencing '_ROCE_HSI_H_'. The closing comment should read
'/* __BNG_RE_HSI_H__ */' to match.

While this doesn't affect compilation, it creates confusion for developers.
Compare with the related include/linux/bnge/hsi.h which correctly uses
matching guards throughout.
-- 
pw-bot: cr

