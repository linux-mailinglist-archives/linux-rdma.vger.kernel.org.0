Return-Path: <linux-rdma+bounces-22055-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9NqoGcXsKGpUNwMAu9opvQ
	(envelope-from <linux-rdma+bounces-22055-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 06:49:09 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE24665CEC
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 06:49:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=OTr1YT68;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22055-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22055-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 199F83043523
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 04:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3694340413;
	Wed, 10 Jun 2026 04:46:30 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f228.google.com (mail-qt1-f228.google.com [209.85.160.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4242DA749
	for <linux-rdma@vger.kernel.org>; Wed, 10 Jun 2026 04:46:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781066790; cv=none; b=gdXNERZoxE6uizX12+C3AbvxneqcBQ6/WTUgT3sSwlZ7zWBwU7xADkB8SV60Ebvuksz4+GfzF6wylxxBBcOvaaifM2mfrMyBaxE163MwE0rWpYN2NyVdZG/jTUpBLDVRQcf+JGZev3+Pah0u6MZYSFqevXi8PhVsGeduxGoDEMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781066790; c=relaxed/simple;
	bh=/iw/6gxmomCPLxHgeYJR5H+avUIr6uUrQa6hWfErnQk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pyf5DUJ1A1A25C7i+Ltt+F74ONElqbwAOtqksFuoXN+97UuVyEl9X3ruLMDBijgm02tpi8zQqJnnL7DZ4M4TNbwvWRkcQkHdwCpY4yUtHG6+EJfaqgB9x8Qz/GzyQJOKIRsmwCwUcIpIg5tbBhGGdXvmMJ6M96Dz9eK5/TFkxws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OTr1YT68; arc=none smtp.client-ip=209.85.160.228
Received: by mail-qt1-f228.google.com with SMTP id d75a77b69052e-5177945a279so67580631cf.0
        for <linux-rdma@vger.kernel.org>; Tue, 09 Jun 2026 21:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781066788; x=1781671588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PmPkwXBLPaEZUg+IhjUOjdi5r/O9RYxev+nCgo8cbH8=;
        b=HLiMVBGF8XKGK5wBEY9YnITlajIjCG+A43qGAvlEFVOfR1l8UduvLHMZOYP2yQoO7b
         0lPV8x3XdA/EFQmfEMKqbQLyqj727YroTRWlQDdkvKCSC4bQV65U2U1vwjoyXfAqHvfi
         RWXg1j3Fk+XWCdOB/d7c/esQWC+Yg0y7Ysn06edhwNAMNKnR4SxlSvTkOnML37j/jPSt
         11xtBrwzzZtO3Q/OA6K9iB2NJv2FT3SKAkBJQVskda0bhP6tPqislbj0iynZyC34gwCX
         OEGmp3YL9coR6zizl2Xq/fOtC6vJAR3K7GBodjOr4m+ZEMStE6NE3XimqL7sWwZpi8S6
         dsKg==
X-Gm-Message-State: AOJu0YwZndKZE7UBicuXHnMJnQtVoWlO3MbsYbuNfxcNQyItl6KQF5Sa
	vhghrUIlA0bjQCkeIlulwjZpE8RxoZxP7SuPkKmjH9kC2JgSELgjgSD9+50piVXXDTS5A8OuVxY
	Izm1GWHmNV2y8qNathIxar0smiK3ZnUGVguSCI86td6XzHXRyw4X8h+/zJI0LcCEF0vEEBvvFHL
	9fXXWbfzwo9lEZDrIMiX4GeioxGDupK/eYBs7astZ2pOIMWlJzSLiQw0o/lorjgObF7s2ayFmJQ
	eLaQE+u/oWAOq+2rg==
X-Gm-Gg: Acq92OFxu2iZj5qt5FhuXrubdPSZSCCv3ExKQPMlQFWmQNDkbew4+al6Yr3IQvPIWvy
	SZNtKVK83Zg8MYvIKBfxUEy8qFJBxCzeDrq71QASqzKa0NxwDyvd/rDnImTKXr7zktgTpCS+6QF
	WCRw7BHkmBxdDvB3o4dQGG67/q8bXxIeIin4szG0dLAPnW+TEoqElMd/3KME8hoxLZuEoJYK9tu
	g3ZCNHNJuPoAGK6kIn/e16EdAuQm2cCG07eAeu1LEfbRM2K/R5v2uXNe7M8iW2cX1inPnIn40aS
	AT0Frun7JOGhUFRgakj89W6iTBOU4bX/AZq5CM3B6K4QqgA/08EwhJ7zFTQe0q6c32TcvgAYJ20
	HsAbPkpiQCUoLct6UVlTQ9JTPOm8DGm8ilud9PouDt+cgoQ+9MzRuLCwUGNqEashNQI+zVZ/Elo
	VjJALNk0vz+VDjd4HW8ulRz3fwy3adrWbPqMJbiTi7V43KxRPhvfApJG9//Ye/1Xgg/mEf3po=
X-Received: by 2002:a05:622a:30d:b0:516:de71:e21b with SMTP id d75a77b69052e-51795b0a1a7mr330268951cf.9.1781066788230;
        Tue, 09 Jun 2026 21:46:28 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-51775bf7be3sm10272301cf.11.2026.06.09.21.46.27
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2026 21:46:28 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8428384f31fso4491646b3a.3
        for <linux-rdma@vger.kernel.org>; Tue, 09 Jun 2026 21:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781066787; x=1781671587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PmPkwXBLPaEZUg+IhjUOjdi5r/O9RYxev+nCgo8cbH8=;
        b=OTr1YT68nI3y0LBddNNUrv1W3G5Von5KGzW4z2N3eizFj3vAHiJnjBq7BXIV4Avcxp
         gBCqK7A+/dw9+LT2Y6j4s33h5z8M8wOYaR/DZPlZIgW7LtdnSIBrcR6P91S/e8sXsL0F
         e9lHO+at9sxrLgjvzd2WfS0Se15RRhOpkOE34=
X-Received: by 2002:a05:6a00:1da0:b0:842:377a:4dbf with SMTP id d2e1a72fcca58-842b0feef02mr22615645b3a.43.1781066786862;
        Tue, 09 Jun 2026 21:46:26 -0700 (PDT)
X-Received: by 2002:a05:6a00:1da0:b0:842:377a:4dbf with SMTP id d2e1a72fcca58-842b0feef02mr22615614b3a.43.1781066786417;
        Tue, 09 Jun 2026 21:46:26 -0700 (PDT)
Received: from dhcp-10-123-65-43.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282375f2dsm24532821b3a.19.2026.06.09.21.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 21:46:25 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH 00/11] RDMA/bnxt_re: Generic driver fixes
Date: Wed, 10 Jun 2026 03:08:44 -0700
Message-Id: <20260610100855.64212-1-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	DATE_IN_FUTURE(4.00)[5];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22055-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,m:andrew.gospodarek@broadcom.com,m:kalesh-anakkur.purayil@broadcom.com,m:sriharsha.basavapatna@broadcom.com,m:selvin.xavier@broadcom.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:mid,broadcom.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AFE24665CEC

Includes fixes for few issues pointed by sashiko. Also, some
generic fixes found during internal code reviews.

Please review and Apply.

Thanks,
Selvin Xavier

Selvin Xavier (11):
  RDMA/bnxt_re : Initialize dpi variable to zero
  RDMA/bnxt_re: Add ownership check while getting the CQ toggle page
  RDMA/bnxt_re: Add ownership check while getting the SRQ toggle page
  RDMA/bnxt_re: Avoid displaying the kernel pointer
  RDMA/bnxt_re: Add a max slot check for SQ
  RDMA/bnxt_re: Avoid repeated requests to allocate WC pages
  RDMA/bnxt_re: Avoid any race while handling the hash list of CQ
  RDMA/bnxt_re: Avoid any race while handling the hash list of SRQ
  RDMA/bnxt_re: Fix the cleanup upon error during srq create
  RDMA/bnxt_re: Fix the cleanup upon error during CQ create
  RDMA/bnxt_re: Fail DBR related page allocation UAPIs if the feature is
    disabled

 drivers/infiniband/hw/bnxt_re/bnxt_re.h  |  2 ++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 35 ++++++++++++++++++++++--
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |  2 ++
 drivers/infiniband/hw/bnxt_re/main.c     |  4 +--
 drivers/infiniband/hw/bnxt_re/qplib_sp.h |  1 +
 drivers/infiniband/hw/bnxt_re/uapi.c     | 19 ++++++++++++-
 6 files changed, 57 insertions(+), 6 deletions(-)

-- 
2.39.3


