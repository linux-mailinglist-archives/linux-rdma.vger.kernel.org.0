Return-Path: <linux-rdma+bounces-16994-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OnZGz6DlWlrSAIAu9opvQ
	(envelope-from <linux-rdma+bounces-16994-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 10:15:42 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC6D154A39
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 10:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 684FB303C002
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 09:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7CE33508E;
	Wed, 18 Feb 2026 09:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FR7tZVRt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225FE3376BA
	for <linux-rdma@vger.kernel.org>; Wed, 18 Feb 2026 09:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771405978; cv=none; b=IZwEBGdKOi6gQk+acJcLBYxoIs9lICgCJ5e5I8oWPGjngh0yDEUpxTZEujDS8pt8QXVFUSDldNUOOhwAkv2xvztJ/W0DGOOFf8ciRvjlS9bN8E4CxOml+btv2/ZHhNfa2XICKAshCa9X0c72okLVkOAuC3eyDlRe15pdPqc0diQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771405978; c=relaxed/simple;
	bh=vye9CrsfIsLhE8iAbM5HhxVFlP5KpRKT+VXHs7Fyvkw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UYXVCEevJZDSwFH3M9HoloCfH02AcEbnKZ3WClkkxSCB3Xm1EGRJzZLV+aIAuUuHZsHRNCRSG2je4XzoGKI7RJOqX8H7CLJ2aGevAMBaeJjbgC5wbpYfBCh5lZyF+l5NqrMJsMsb+QJN9BIgKTgdQuaw0Ho0R1PfumQao1sadQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FR7tZVRt; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2a79998d35aso33393755ad.0
        for <linux-rdma@vger.kernel.org>; Wed, 18 Feb 2026 01:12:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771405975; x=1772010775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=USpd6PmB8jwi1LT3M9X1QvqOJuXTVw38k3crTjPAuNc=;
        b=A+t7+UsSGZ940Twv1KDufFAMkB9/pgfLgIs7zSzTG/oIravduSvz3Hkxn5sNWR30Uf
         G4P4fMhVIY+DX8qOPqFB3Tslbg/Us1TuSFi6NLucC/Vr5LX+ITAoYfbJmLR30b5Ke6+9
         AFp1zZ29wn0ctn4dKO4/uOz96+XTYj+UFYajsvEljNCjnL8LjB4GjdbIa0EOVhbGu2yp
         W0s7JwFjQUybG0eeYDBAp5BpclxKzKXuxVNN8Q7TvHmWoVKKpJ5gv5aulnL47sPemzFz
         QK3KSx+qEL9tMjbygr2WSlgkUVQL+UfD/NdzQNmrgJPkApDFQyBpNqUNiX30ZAXVEUQr
         Wijw==
X-Gm-Message-State: AOJu0YzCZ1bv8hNRH58ov5l5pVCLzwXzdOJlBdCsSzluV6m5YH42dHWl
	tY9+a2pJMCHWbbww+M7I+szqb2G/grAKYilFgmcuWAXk2B7Y+R+Udj45R1Rt5RXF4c+T3JvsFjt
	TTbOoaWQCPfCzkOuNuXZNg0rPpafcDnqZkOIY+t3aLdoZUj9U75X4WKhXy75oNjNEonBxUsySbT
	XlfLeHCn5adSopSI+97SmKo9PfDu6IXJ2IudHD4JlOMJfZsEQK4XVYXewJOee6S6zRLvxactWdy
	tQ7yaw+OiGtgl5XNA==
X-Gm-Gg: AZuq6aI2JARcvQeoKGzZujWJbm1LSiv/gBLYOQKoZyVeVyRAN+8yFwCiEAWq7AKlbwR
	hZAWTiIi7iujXobLDTliLZ4AJI8j5FeRd0glQcbjxgeL/wsJXhAM4Caswndt/gms1HaDBVqds7L
	J3TFWBc3YtnMf3DkZRCGIs0X/XB/H4ofVeJlfxaM/0rm7rK6l+RwsxTOmPYOOOTydd0DPveIGZo
	axNsUKuVkr4m5LlXrzHyQD3x3VZcquFU70IV/50bgKRwdKPvlvU4ii86ii+HCQyivJT9sWykqLK
	CV+z01WTm63BEQQNnVO7IKM9AXrbYcA/JXzuvs1FFa7H1Izzh+MaT8KCMrqKRMXrYXhBNr5kHW+
	bcNlCIjRva1tPBLXttgcFpZCvgPOJTwBYHL+GcvNP6STbJcNHHgiSMj5d10Ue4DZtRTAoYmcrFx
	ducWJ5jGte5ksNGrUvUejyD5vEPyvlSzYxA49b9OPJINwcFJaQrZcnrVBnMg==
X-Received: by 2002:a17:902:ce06:b0:2aa:d630:cd5d with SMTP id d9443c01a7336-2ad50f742d4mr12628795ad.44.1771405975143;
        Wed, 18 Feb 2026 01:12:55 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2ad1a8bf49csm16371825ad.55.2026.02.18.01.12.54
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Feb 2026 01:12:55 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-506ab115571so407494501cf.0
        for <linux-rdma@vger.kernel.org>; Wed, 18 Feb 2026 01:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1771405974; x=1772010774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=USpd6PmB8jwi1LT3M9X1QvqOJuXTVw38k3crTjPAuNc=;
        b=FR7tZVRtvKhiYRsZHT6hsIiaKdaIW8t+HA63DA2shLS9KyZCzsfXemf1UoJTdLecHK
         yM42we7pQPX73OaKgwkoOC4KzMSwdbPCWXXo2z4KiwV8g9FxWI1cAVlxuvUryPmz0p0F
         3qTZ/Ko4mEfvhWsJf7iEUYbOz9yJ/peQizofw=
X-Received: by 2002:ac8:57d4:0:b0:501:4e7f:fd03 with SMTP id d75a77b69052e-506e9216979mr15144571cf.48.1771405973951;
        Wed, 18 Feb 2026 01:12:53 -0800 (PST)
X-Received: by 2002:ac8:57d4:0:b0:501:4e7f:fd03 with SMTP id d75a77b69052e-506e9216979mr15144431cf.48.1771405973494;
        Wed, 18 Feb 2026 01:12:53 -0800 (PST)
Received: from S1-NIC-server-2.broadcom.net ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb4a395cf2sm1180245285a.18.2026.02.18.01.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 01:12:53 -0800 (PST)
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
To: leonro@nvidia.com,
	jgg@nvidia.com
Cc: linux-rdma@vger.kernel.org,
	Siva Reddy Kallam <siva.kallam@broadcom.com>
Subject: [PATCH v3 0/2] bng_re misc fixes
Date: Wed, 18 Feb 2026 09:12:44 +0000
Message-Id: <20260218091246.1764808-1-siva.kallam@broadcom.com>
X-Mailer: git-send-email 2.25.1
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16994-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[siva.kallam@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:mid,broadcom.com:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DBC6D154A39
X-Rspamd-Action: no action

This patchset provides fixes for below smatch warnings in bng_re.
drivers/infiniband/hw/bng_re/bng_dev.c:113
bng_re_net_ring_free() warn: variable dereferenced before check 'rdev'
(see line 107)
drivers/infiniband/hw/bng_re/bng_dev.c:270
bng_re_dev_init() warn: missing unwind goto?

1) Remove unnessary validity checks
2) Unwind bng_re_dev_init properly

======================================
v2->v3
Addressed the following comments by Dan Carpenter:
- Split the patch into two. one for unwind and other one
for removing unnessary validity checks.

v1->v2:
Addressed the following comments by Leon Romanovsky:
- provide proper commit message
- remove aux_dev check in bng_re_net_ring_free
- remove uncessary validity checks in driver paths
- remove uncessary NULL assignment to rdev->nqr in bng_re_dev_init.

Siva Reddy Kallam (2):
  RDMA/bng_re: Remove unnessary validity checks
  RDMA/bng_re: Unwind bng_re_dev_init properly

 drivers/infiniband/hw/bng_re/bng_dev.c | 56 +++++++++-----------------
 1 file changed, 19 insertions(+), 37 deletions(-)

-- 
2.25.1


