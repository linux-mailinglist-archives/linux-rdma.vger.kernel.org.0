Return-Path: <linux-rdma+bounces-16320-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GGLJ+UsgGlZ3wIAu9opvQ
	(envelope-from <linux-rdma+bounces-16320-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 05:49:41 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B98C8383
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 05:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA450301302C
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Feb 2026 04:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000C22C17A1;
	Mon,  2 Feb 2026 04:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SY6eLd1d"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vk1-f228.google.com (mail-vk1-f228.google.com [209.85.221.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1B622F16E
	for <linux-rdma@vger.kernel.org>; Mon,  2 Feb 2026 04:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770007754; cv=none; b=Wru4caWdFbgaxHddsSV6JyX8oiUwBfZzcg8q4TecH2tJsCbio1GCXCI1eLltoXMzgrU4PD/6LtT8UC7QBceMxeXYd5CprVI7/Dxi3K+2t0IzgWxXi2K1XoPbX3LS2pxr4mGQltcIHwP0oG9UlbiYzHfhNgXsgEJY2e3JxbBLfAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770007754; c=relaxed/simple;
	bh=s9SMeCBIy5OHALS/2Qsmcxx9kO63PUBvELqIlT4pN5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=is9GupXMWv8GhrChTMLaX44nypeOuXk9MCD3pe52b9ofyoXclxMlFc7FRxFJLiHn4HyTNw6rS5EXdWwmTX4qT6DrZgo9wFuhbbCjBTQOQDDJhYLSjMTATDaqzLtsj4+ciWEvHrPFiNqZdoUzBes1EG4NcaTnJYXhBpCrmPO3Nrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SY6eLd1d; arc=none smtp.client-ip=209.85.221.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f228.google.com with SMTP id 71dfb90a1353d-56636dc53a6so1059587e0c.2
        for <linux-rdma@vger.kernel.org>; Sun, 01 Feb 2026 20:49:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770007752; x=1770612552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9IvWcmc/rx7KaHrgU4HNIJiVjz2WDq/r/o3jl1SWxQ4=;
        b=GoZtNoQvHzChAyBk4HUSWxB9ElUE/vhuhNibLrAfO47/rBXNo2dFZKCRbzzT9jax63
         cpxl+XUtYPmSvoFw50XmgOgN8j00aEKSPobpwSnSgSJDMxsXToKM2sJO4nCIb1/Rc4EK
         hJfFlChMZ9iLGZnWYrvOIh514UjE+9YRAQiALiq8W4+qOz6OlRngeLD132hnBHGUPKFO
         UwwU3+vI+q8IjsvYvYXCxW6e0kSrnFYHSvFIKTtHSMxoBJm00jxy/7zBKmdS9WSle9ty
         HGX9G0NCaEGwQwz+3qgq9pwOTLX+MGyb1Y9PRD7xep6xZdUMib8DK3fEi75ML68x6JU6
         sF/g==
X-Gm-Message-State: AOJu0YwQp0ZaUaR2CJ2AqXyZcwvIX8sTXwAeiN8/Szd328iYbngThDvR
	ORwLoXdupzFvFKjttZUqJ1f1wiBa+7BvZHbU5a+8LJTlEwLCvH0NQg3bXzndxvxoyljZ8mn/YF3
	LyoDxijZlYgKOAXNOxo+31uEr0IUyRoUXipL/ODx7XPCs+pUK2JvaXLIqHYwdRVEiK+l0waTaK7
	OVvLlNz6jvGHvoc3WmqqliwZDChxSH8GWyq/C8JixzzxmCyIR3RzjX3ZlUtehmKvzla04EuzoWV
	0Fww/P9Gf97e/4Henyu9Fk+pID9LA==
X-Gm-Gg: AZuq6aKWKlYq/NTe+2lOm9foaxPMNHQPym3L7FhmLZkfBGascQomTXa076lsAzuRlRJ
	Hj5ivvdkbbma0JRSBKPSbVYb3z8GuhGvNk98A9pNNdPX0dwYKgyGlXp37NIS5m809csJC4b/84A
	ObNf58zEEIQpfDq0jvkA9SCgb2mUCykpVVNPgaA0LAuD+G1M3DusDlXtyCDrELP5yoe200LaxaQ
	iTdXlZ/WOrYL3BpBanIt6cJcCZR80SIUWm7DufsE5sfl1C32YwXRpiV42HzvkVCZEHv212y+Y1D
	l4/2oMnStzSluK1nGuIDUcmJoJNVEnQmsad1P7J1A1pHQ9btrVcm7haqffPGACgHTFSWdgIx50W
	vwRz4R/V/wxkDLY0BsH9IQ7vVkdpOgqQ1TjQdLikAMZiptGUAExC8mH3pY1OT2ZRuoYgLvH6nvx
	PoB8qKARbz8ivazOZSsLIp234q+yKGSAdGTmFfqkvVLzbSXm3zyLYtZTU=
X-Received: by 2002:a05:6122:d85:b0:566:22d8:fd11 with SMTP id 71dfb90a1353d-566a00347d6mr2991572e0c.1.1770007752508;
        Sun, 01 Feb 2026 20:49:12 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-56685afbe3csm1988053e0c.1.2026.02.01.20.49.12
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Feb 2026 20:49:12 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c634b862fcfso2467259a12.2
        for <linux-rdma@vger.kernel.org>; Sun, 01 Feb 2026 20:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770007751; x=1770612551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9IvWcmc/rx7KaHrgU4HNIJiVjz2WDq/r/o3jl1SWxQ4=;
        b=SY6eLd1dHgEt3ruIMUNeYRLmXucvijeJiH3vd9yEkQv88MWGhjS719VG9GHevx9ndY
         5mDECp8b2n/s9dakbqd+i9B7dJR3AeWmMrsb+eOhAqfzkiK0lHIRJV6rcEydF/A5MYYC
         bborIXS3lMghdA1eWBs/7WLjnLZcjdCoE0NnM=
X-Received: by 2002:a05:6a21:3991:b0:38c:4344:fe8 with SMTP id adf61e73a8af0-392e005a7d0mr9400555637.26.1770007751368;
        Sun, 01 Feb 2026 20:49:11 -0800 (PST)
X-Received: by 2002:a05:6a21:3991:b0:38c:4344:fe8 with SMTP id adf61e73a8af0-392e005a7d0mr9400550637.26.1770007751019;
        Sun, 01 Feb 2026 20:49:11 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353f61dfac1sm20282135a91.9.2026.02.01.20.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 20:49:10 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH rdma-rext V3 4/5] RDMA/mlx5: Support rate limit only for Raw Packet QP
Date: Mon,  2 Feb 2026 10:21:19 +0530
Message-ID: <20260202045120.3139712-5-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260202045120.3139712-1-kalesh-anakkur.purayil@broadcom.com>
References: <20260202045120.3139712-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16320-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kalesh-anakkur.purayil@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:dkim,broadcom.com:mid];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 37B98C8383
X-Rspamd-Action: no action

mlx5 based hardware supports rate limiting only on Raw ethernet QPs.
Added an explicit check to fail the operation on any other QP types.
The rate limit support has been enahanced in the stack for RC QPs too.

Compile tested only.

CC: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 69af20790481..0324909e3151 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -4362,6 +4362,11 @@ static int __mlx5_ib_modify_qp(struct ib_qp *ibqp,
 	optpar |= ib_mask_to_mlx5_opt(attr_mask);
 	optpar &= opt_mask[mlx5_cur][mlx5_new][mlx5_st];
 
+	if (attr_mask & IB_QP_RATE_LIMIT && qp->type != IB_QPT_RAW_PACKET) {
+		err = -EOPNOTSUPP;
+		goto out;
+	}
+
 	if (qp->type == IB_QPT_RAW_PACKET ||
 	    qp->flags & IB_QP_CREATE_SOURCE_QPN) {
 		struct mlx5_modify_raw_qp_param raw_qp_param = {};
-- 
2.43.5


