Return-Path: <linux-rdma+bounces-23098-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id asiVLUKlVGrxogMAu9opvQ
	(envelope-from <linux-rdma+bounces-23098-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 10:43:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15051748DAC
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 10:43:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b="avwb4/bs";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23098-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23098-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79E2C303A262
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 08:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36843B3898;
	Mon, 13 Jul 2026 08:36:46 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E733B2FFD
	for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2026 08:36:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783931806; cv=none; b=cKnhJjv4e7brSjb6OYlbB4XQMbmImfdFJM6aEDXdmeSDVAhRgKrKeY/cgApfFmE+G4DMVN0+9IUa3S/QkoigxiWIezSUyu7k8sfc9zLekc1eWLgFf8uAN9gU7upIbikwvQYJeP7hMw4SQM+taxL38pv96veSdKXnsSua2esB40M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783931806; c=relaxed/simple;
	bh=HG+/qk28NkqEENH9vSIfpCPrNpYsek3dWwcck0jISjM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IPlJuPSSgq88TLE/rOKNSCxYF/vzbcpUSCaXevWRiCzolK7I1hFQm+JVKZgh/gPHTIh5iYTm3QcWJ5LSzDt4GxCalAcnW65SQRFckVXfE4uY16JZt6yiDTy7EQ1/9OQItclFGBz12ivj7Mj6sY4dM8cP6+TH7hf+1EjLVKHSZC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=avwb4/bs; arc=none smtp.client-ip=209.85.219.100
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-8e5be46f663so17583866d6.0
        for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2026 01:36:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783931804; x=1784536604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ladGK4bGXxd5ziYDhdNILHhc2GXSWCy3TRc/PfJYMck=;
        b=X4In6cu7+akHHxhOsYnAjK4kVgyGQoqfF6H0vNsJr6g+mS+2n0s3C/lxyvHJrAqajH
         xaWzIsveoN3psnCKjj9AEMJdG27FTYV33zbmYokG+8HS1SU83iFUvbLzRJcGRXEy0Br0
         H4BiKhm3h2Lupm4J5RnU/8Yq3QVMFpmCO62Tz/dQnKVG+9u2o7X9r111gQL8/f/ii7DI
         xFfPaTvornXJe4v/wNJldqQSZqIdpTIL8Ojiv3XExNlp8OicKDzaFtgjnOb6gBkdkD9D
         ApNrtUDxr90W7FSElaY+vWEGih4BIZRHHfmPrtp5RRW03uyDSUvwQ520lr/zeiDBwq8P
         DCiw==
X-Gm-Message-State: AOJu0YwjzkmzA+4ntTkTzW5/QcoZIEpUyHedNowhW0O33ILlbhPGCaUE
	O21MsFW5ggxRjocHQvJenZlaujgfX/2SLsMF2bxMQmEH/G8qeFbBRrmDbDk6ADrW1Udl3SKrpzO
	lQ9qlgXLMN2GfM1aR407njfYLuVrnUUcNicdbk6yHWwiPQYVChVA0b5gy5s/YJ5hwVQBc5a77nX
	wKtv7H9FORyv81NuW4qlRdbd0gc+bFfzZofMwizm7EbsN5L5Nw55Cq8xoVOmBOEiDYc8oUKJh2E
	XQntdNlFbGXMWojNQ==
X-Gm-Gg: AfdE7cnjzfjuQkZYmtoMaSqatgVMDieqar6Uc+ZyOIpQtgSHgrYkOO1qkc6jEHmeWU4
	7a6eFEnNGRuS7nqFtaRs0r5RCPgptMB6z3TEY8MBfRryZrILi0iBIkra+oXohkd0X357wJHHT/I
	tEPOPFm81O7Jd66UuTjTQsZ66zR2jvRLts+CRARkoioR7Ee0JUIKGvf/y7ZD8vxKf0FIyW10fC2
	ipTm4KHHndJAcg9ZGJzmgdT+DIj1MQMbyzYyA4DV9BlMlNCRvsYkg/N/bvLRMimBQNCAIKJw7OH
	8B+gQKwlocXX16Cs9GM4xUHu8PI8X0LSNGvz+3vFj+wKoLKn+m57pfD6xhyltBJh4AEIN7LEcbt
	5HFog5+v8t5Pfwkt4Kigxk/+YBnqP49wCbhQCEftifRJpxYAercTLkXB+t1DHKve0DXPDFcfX4x
	y8iyORCnR2navZ5AlSZR6iB1sIbuS3TU03XgTFnZLlDJHUNnUAzg==
X-Received: by 2002:ac8:7c56:0:b0:51c:555:7dea with SMTP id d75a77b69052e-51cbf0e196cmr82082391cf.30.1783931803849;
        Mon, 13 Jul 2026 01:36:43 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-116.dlp.protect.broadcom.com. [144.49.247.116])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8ffd5bbce4bsm6595906d6.2.2026.07.13.01.36.43
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jul 2026 01:36:43 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ca5d2474c7so82714955ad.2
        for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2026 01:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783931802; x=1784536602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ladGK4bGXxd5ziYDhdNILHhc2GXSWCy3TRc/PfJYMck=;
        b=avwb4/bselpZxa271ZcNzubqpDMGZM58LdDklK7xJtdUAjfhDIaFGbwRA30sSVeJ/h
         VUO6TLE/XvQdmIP/YHZMpOoWJo0/boybjwTYAzNAAQ9EzgQ5w1PkFXngqdLWkNp8RaXj
         UA7J+Po7D1EZPe9luG2FwV+P0SmapUh8FY9DA=
X-Received: by 2002:a17:903:388c:b0:2c9:e9c4:82c1 with SMTP id d9443c01a7336-2ce9ec0ef3amr81934675ad.26.1783931802518;
        Mon, 13 Jul 2026 01:36:42 -0700 (PDT)
X-Received: by 2002:a17:903:388c:b0:2c9:e9c4:82c1 with SMTP id d9443c01a7336-2ce9ec0ef3amr81934435ad.26.1783931801942;
        Mon, 13 Jul 2026 01:36:41 -0700 (PDT)
Received: from dhcp-10-123-156-114.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3bbaesm95005385ad.57.2026.07.13.01.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 01:36:41 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	alhouseenyousef@gmail.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v3 0/4]  RDMA/bnxt_re: Update the toggle page handling of CQ and SRQ
Date: Mon, 13 Jul 2026 06:58:26 -0700
Message-Id: <20260713135830.1934471-1-selvin.xavier@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,broadcom.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-23098-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,m:andrew.gospodarek@broadcom.com,m:kalesh-anakkur.purayil@broadcom.com,m:sriharsha.basavapatna@broadcom.com,m:alhouseenyousef@gmail.com,m:selvin.xavier@broadcom.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 15051748DAC

Based on the suggestion from Jason (
https://patchwork.kernel.org/project/linux-rdma/patch/20260615224751.232802-5-selvin.xavier@broadcom.com/)
, adding the uverb object to retrieve the CQ an SRQ structures while getting the
toggle mem. To work with older rdma-core, retain the existing code with
modification.

The rdma-core pull request is here: https://github.com/linux-rdma/rdma-core/pull/1761

Please review and apply the series.

Thanks,
Selvin Xavier

v2 -> v3:
 - Patch2 fixes toggle-page lifetime by making the rdma_user_mmap_entry
   the sole owner of the page
 - Patch 3 adds a reference to the uobject in the legacy path to avoid
   the usage of the page va after the resource destroy.

v1->v2 :
    - Fix the error cleanup for SRQ and CQ create paths
    - Fix a synchronization issue for the legacy path which can cause a
      UAF

Selvin Xavier (4):
  RDMA/bnxt_re: Replace per-device hash tables with per-context XArrays
  RDMA/bnxt_re: Defer toggle page free to rdma_user_mmap_entry teardown
  RDMA/bnxt_re: Fix toggle page UAF in GET_TOGGLE_MEM with mmap entry
    refcount
  RDMA/bnxt_re: Add uverbs object handle path for CQ/SRQ toggle page

 drivers/infiniband/hw/bnxt_re/bnxt_re.h  |   5 -
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 108 +++++++++++---
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |   8 +-
 drivers/infiniband/hw/bnxt_re/main.c     |   4 -
 drivers/infiniband/hw/bnxt_re/uapi.c     | 176 ++++++++++++++---------
 include/uapi/rdma/bnxt_re-abi.h          |   4 +
 6 files changed, 211 insertions(+), 94 deletions(-)

-- 
2.39.3


