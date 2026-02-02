Return-Path: <linux-rdma+bounces-16335-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGh4CRypgGmeAAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16335-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 14:39:40 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95592CCDFD
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 14:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9220C3066303
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Feb 2026 13:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03919369235;
	Mon,  2 Feb 2026 13:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SseO68sz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f100.google.com (mail-ot1-f100.google.com [209.85.210.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F9A36920F
	for <linux-rdma@vger.kernel.org>; Mon,  2 Feb 2026 13:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770039130; cv=none; b=jyyWnTFtFiP18cMH4hFZfb6+cc7bluu/lz0KJ0MnNqLH588pbzzJKEXZNWejVAHIGj8w72EYn0A4qRsJUGcpnGEwNMYjjzhRCICI9PWqjzu5p8d2KNFfL6wH6qeiBPbzggsnohxia3oobe7Wsi+UnAqbRwqS+WJkQF3Sxem7gKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770039130; c=relaxed/simple;
	bh=s9SMeCBIy5OHALS/2Qsmcxx9kO63PUBvELqIlT4pN5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=npZ1TI89Pju1NanBptR9YH+Ed1c6xT8zcDuvayQBq5ruywDKeKY2Opt0o/r0y0QNigM1CTIrsylsYcJq10V6MXf+oWdevy6LRNNuVsp9plHx5OQo/wz0JcwLcIp/tcSAeBfe/hltin4psxGkESEknQAO9zzyodwb1MAa6uB5DzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SseO68sz; arc=none smtp.client-ip=209.85.210.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f100.google.com with SMTP id 46e09a7af769-7d18d9503eeso3325263a34.1
        for <linux-rdma@vger.kernel.org>; Mon, 02 Feb 2026 05:32:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770039128; x=1770643928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9IvWcmc/rx7KaHrgU4HNIJiVjz2WDq/r/o3jl1SWxQ4=;
        b=ajg/a/VGd8iT7XAXQ91UUrHuYtO2cs3NVrsn7V+DSzWSITWArnM0jCOEd/JuwPaBX1
         d8lOIIROMigEelKo4SwS5IuGiRJbHgrXctzrv8Eyis6CYXY3LG+MIBxZDOApWWKUULrC
         hL/JMeJCH2L12ouscxeM+DKK3USRl75jHtyU5CAA2qIRODdkvMGBzWI5nAJWrRQE6Krn
         YkiFu5Mz0rP4uumB0NHjKhwaFx0uyblw4g/kERYRC6iHfhX5/KAlvkdNSVBLAz6o04Qa
         phpEHyZWeNv1drUVo5uTxPNEVnrt7bAOJRHgUH2KAAiuMNq461sCYPZKqEw2UVVrhALr
         NaDg==
X-Gm-Message-State: AOJu0YxulCujesKs1i8DUd2h/SnBwm/v8zhzQo1dA7m92jUzmeoUZZBG
	UDIHlcrpaH8k15TSlW7HNcqGaP5O6vO1IXXFD7odduHTn0nBuf79cXmAWHQTpC/OnvH/RyP7gzQ
	NWNL1OZh9y3L9WSNsYsOUYXnGtVmIP24ZfEBMcNmbTPwXzY5HN8giZNhcgxG0GoTYl4/cn9jchT
	o8A1O84+YoHPRGmZ7DNALa93JDGjJ0gxQ/XOQpXgcPeVcw7o6TURz10peToc59pKZ5edFzdL13E
	RqQ2EZD/LAJFNur3joozkWsUOk4nw==
X-Gm-Gg: AZuq6aLONSAkwhFiU+T2oB79EVVkUVkBAVMCKxFsNvFda9jm1UcIoXVWbSzKJviNRAS
	sNsdMnMbEon2ZFozAeLgW0gREf3iWE2hGt2F4bU9G2zj09+VgG3CIDjLdtQjeZ+q651veDiwOUX
	raLmAZA/w5y1m0LID4LMw9NN1M/z+74FEvHq6PoAv3WnAcoTc7u50FG7ZLIS5fsRXku8/fNWyMC
	ffU/+qOWuDV4ReFN4A0iwe8nMQ+bzd6Kj+zwSCwrW8VumJ2Mk9O4gwUZX7Oq7gnPE2d8dtihcI0
	L+uA0R87GbS46yrTrYHpKk+LGbd9wr8oS5TdEpbCwnET8LGzgol6Igs/hoYiT0QJyXbzU9ywiws
	m0+cEnST+kmWvMxFtvq3hUjnfLgqRAD3ROW6q5SCACH5aqKHtaVIo2p0FYdWurrKQrhV9OrVVwx
	OzxmogNg+7JEyTAF9Vog/hvkhUIT6cc328adgKn5nbhL1VIIvj9LzDY2e4a5jR
X-Received: by 2002:a05:6820:2d83:10b0:663:1239:9eae with SMTP id 006d021491bc7-6631239a275mr3571608eaf.54.1770039128210;
        Mon, 02 Feb 2026 05:32:08 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-409574df01dsm1668293fac.14.2026.02.02.05.32.07
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Feb 2026 05:32:08 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82317005ee6so2252178b3a.0
        for <linux-rdma@vger.kernel.org>; Mon, 02 Feb 2026 05:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770039126; x=1770643926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9IvWcmc/rx7KaHrgU4HNIJiVjz2WDq/r/o3jl1SWxQ4=;
        b=SseO68szke//RlPTXun/SngaFBGx038rVzzRYLRbyQdKXWsvf/0DQKSgo0AsCofo+I
         UG1+tT3AeHzOJK+dzUppmj7SEq6jxtnS48T0TwN1/2AFHietaHmJ6zOv8rwzsBf1ON2I
         87Uqyi5hz1D645bD9a+7IYtSdACVOFLvYZcUc=
X-Received: by 2002:a05:6a21:682:b0:361:2c56:fca8 with SMTP id adf61e73a8af0-392e0108c0bmr10475596637.50.1770039126433;
        Mon, 02 Feb 2026 05:32:06 -0800 (PST)
X-Received: by 2002:a05:6a21:682:b0:361:2c56:fca8 with SMTP id adf61e73a8af0-392e0108c0bmr10475572637.50.1770039126078;
        Mon, 02 Feb 2026 05:32:06 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353f61e0007sm18859382a91.12.2026.02.02.05.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 05:32:05 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH rdma-rext V4 4/5] RDMA/mlx5: Support rate limit only for Raw Packet QP
Date: Mon,  2 Feb 2026 19:04:12 +0530
Message-ID: <20260202133413.3182578-5-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260202133413.3182578-1-kalesh-anakkur.purayil@broadcom.com>
References: <20260202133413.3182578-1-kalesh-anakkur.purayil@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16335-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kalesh-anakkur.purayil@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 95592CCDFD
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


