Return-Path: <linux-rdma+bounces-22450-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mAwYMxURPGrLjQgAu9opvQ
	(envelope-from <linux-rdma+bounces-22450-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2026 19:17:09 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8DE6C0495
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2026 19:17:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=PYR3LznY;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22450-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22450-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A7DB3028E91
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2026 17:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219DE330675;
	Wed, 24 Jun 2026 17:17:05 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45AF265CDD
	for <linux-rdma@vger.kernel.org>; Wed, 24 Jun 2026 17:17:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782321424; cv=none; b=H4PYyTKPvb258Qg2FlbDm6uxZC3pwBEdGCbrSLJxBP7M+RU9suwungNw3j9f4gjiMoHLH9yloN67c2KQctNCMQfe3GkE0Jeq7sR/TTPDcpalzdqfnq+YnWzrCe7JSL8pxcAqOLd2KwICT2OnRMXLXiZ9CgxmmzhS6lFdq5ywO6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782321424; c=relaxed/simple;
	bh=Kb05kdShIuc+E7Uzru/2B+0gKdEyMYtbn+kwMUC0ZUk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RIwzXDv7tA6Z/uf3xko71YKBXRA2aJMGlzlEI99jVF9jmUFO0BhIXAcvx0vj7SE28uzIjpVbh5fcofwf+C9FXfpVJnbv6hSwZnyiPUUJgIJnpEiewud98WkYLcuKSUziQh0y/XP+wQMHrF2iwlIkPMcf6wzjyGAhnAo/biH/dgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PYR3LznY; arc=none smtp.client-ip=209.85.210.225
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-8423610ec93so1513317b3a.2
        for <linux-rdma@vger.kernel.org>; Wed, 24 Jun 2026 10:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782321423; x=1782926223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eyFBwcVILgIVPmyDlAUtHNWHENpOxGXV4IsNvHLlX+E=;
        b=ioZMDAn7AFmbe9Si2eVPIAlobdt4FROp6fq+38GU9fWLBikGpFQ+0FORnXotxfGdNs
         +S0tn/7I+UQQQfSlJpQnBzb5a6Bbbhs9ek/G1HJt03/e3F3JMCzh2EwGHV0kcT7BUgv0
         k/dEPHQ3oBDHVVJvqVvRWiZVhflz/g570AyQWSof7Wn6LruU2O1LKC+zEaE5m7sq7Hyy
         n5hogJKhPlO1Luir7oAyyF9+bXHqLQe5MRcjXL9RbA6EE+bVyLIQcHgjp5iwXBF1qj5r
         o0cP8PL1UrZiG4/MCPLycHRdRpj6bdg3NJnr6LxLyi/nmmDjBYknMQel8EBdI9woMm0j
         F0hw==
X-Gm-Message-State: AOJu0YyAjzvAHlbOSXGAxzgoBnLEcaEmG6v5q6K/9E6PATfckxQhlY5V
	T5rSHoDgaabSgapAaEYBNmnKLmXWi5T9Fl4FJI/DI/jVUSAJi8qfFz5SiTyorHZ93zrOu0bGa8F
	2FD5WBkjTOl7EDYL/30hqKZlMbjzhJE5o9zCCPxnoMx8h905QaX/GODkxO2faG4k7anE27HvJ0D
	ldv/wL3QSHupyyGIzNUSbXrwqky5RfwK525SNUTqumFzaGWN8VqrS6P4psIKxoKUfKqmVQ8Q+ge
	jLAH/VCHz6H95slMbDt
X-Gm-Gg: AfdE7cndt+Mvb2xK0osidyBI7qbyK2/PpTxlXBNEDd6B1nEEB8BGCD49qp1VlheiucR
	i/qHHGP83fQ/BOH9CLXtFzUf7BG6xBTHKX0WLz1JwtazdVqBZzSlyQvuYntWrndc5ott7fRYry1
	KLk+HJOZdLk6NKe1DyEYFahscFWufoiTdC+6rAqixrmgqOr8WMR5tv2e77XVmp+LbIzQsh8ySxO
	oJCpn6KmNClW9eltnRrs7/WTLYFE23drsGL79HQKh5IXtoEnXbJLrUE51WCoNA4ohk8aLY6dftJ
	qwml4186xeUTSJYHUEXbPCoUbOAdg1YGtO8yxa+SIgolg9NdH8WoFHuqH69WiAfEUfs7u4AHeGH
	+MRgjE7uYwsuu0KnllXGRVP2ZjmhwRI5KKHEVAQ87HDqFmf8LZnkXiHBMofTgCrIK/D02yudJnA
	Ybbl03FFvlye6+fm5l9o+O+C/2CcY2ANb/VfC7avqLiK/MWMc=
X-Received: by 2002:a05:6a00:b4a:b0:843:49f0:f5a0 with SMTP id d2e1a72fcca58-845a2caa198mr5332847b3a.32.1782321422835;
        Wed, 24 Jun 2026 10:17:02 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-23.dlp.protect.broadcom.com. [144.49.247.23])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-845a407d6ccsm296852b3a.4.2026.06.24.10.17.02
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jun 2026 10:17:02 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c6b7d5118fso19011525ad.0
        for <linux-rdma@vger.kernel.org>; Wed, 24 Jun 2026 10:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1782321421; x=1782926221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eyFBwcVILgIVPmyDlAUtHNWHENpOxGXV4IsNvHLlX+E=;
        b=PYR3LznYq31yTUt7M6NbFd5JMBQCxGnNaoq5KbTlVs/DonhlX74u5Phrr/6w1EpJTI
         QOEIbRL1ATXoireF1oKRC8ad9vtHwLc6u9qml/+Q1Npb0X1kXTmuwUewjhzDLROIDnjE
         lnAVkulExBtAIT6ulh2g40NujqMKmsWm1XtwI=
X-Received: by 2002:a17:903:2346:b0:2c7:f7e6:99f8 with SMTP id d9443c01a7336-2c7f7e69b08mr326385ad.9.1782321421141;
        Wed, 24 Jun 2026 10:17:01 -0700 (PDT)
X-Received: by 2002:a17:903:2346:b0:2c7:f7e6:99f8 with SMTP id d9443c01a7336-2c7f7e69b08mr325975ad.9.1782321420649;
        Wed, 24 Jun 2026 10:17:00 -0700 (PDT)
Received: from dhcp-10-123-156-114.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f5afbbd9sm3004965ad.28.2026.06.24.10.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 10:17:00 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v2 0/2] RDMA/bnxt_re: Update the toggle page handling of CQ and SRQ
Date: Wed, 24 Jun 2026 15:39:25 -0700
Message-Id: <20260624223927.521882-1-selvin.xavier@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22450-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,m:andrew.gospodarek@broadcom.com,m:kalesh-anakkur.purayil@broadcom.com,m:sriharsha.basavapatna@broadcom.com,m:selvin.xavier@broadcom.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3D8DE6C0495

Based on the suggestion from Jason (
https://patchwork.kernel.org/project/linux-rdma/patch/20260615224751.232802-5-selvin.xavier@broadcom.com/)
, adding the uverb object to retrieve the CQ an SRQ structures while getting the
toggle mem. To work with older rdma-core, retain the existing code with
modification.

The rdma-core pull request is here: https://github.com/linux-rdma/rdma-core/pull/1761

Please review and apply the series.

Thanks,
Selvin Xavier

v1->v2 :
    - Fix the error cleanup for SRQ and CQ create paths
    - Fix a synchronization issue for the legacy path which can cause a
      UAF

Selvin Xavier (2):
  RDMA/bnxt_re: Replace per-device hash tables with per-context XArray
  RDMA/bnxt_re: Add uverbs object handle path for CQ/SRQ toggle page

 drivers/infiniband/hw/bnxt_re/bnxt_re.h  |   6 --
 drivers/infiniband/hw/bnxt_re/ib_verbs.c |  91 +++++++++++++----
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |   5 +-
 drivers/infiniband/hw/bnxt_re/main.c     |   5 -
 drivers/infiniband/hw/bnxt_re/uapi.c     | 124 +++++++++++------------
 include/uapi/rdma/bnxt_re-abi.h          |   4 +
 6 files changed, 139 insertions(+), 96 deletions(-)

-- 
2.39.3


