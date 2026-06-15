Return-Path: <linux-rdma+bounces-22242-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DAEaJow1MGoMQAUAu9opvQ
	(envelope-from <linux-rdma+bounces-22242-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 19:25:32 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39886688D5E
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 19:25:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b="Yzg/AiM4";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22242-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22242-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A88B53010652
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 17:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12F5416CF2;
	Mon, 15 Jun 2026 17:25:28 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAF241325C
	for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 17:25:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781544328; cv=none; b=I2bLYnrnKjj4ql4GibKNgmlLYKtoEIUfceXeQV4sOFJHqhTKVzjtX0Rwg8iCQzMTY2bJZ58wm5Xmml+lQVgQfCxHuqx/9AfdxyK1UhEE92Q31oIIBUDx0BCgA96Rz0R8ivSc3LmiVWJWxHCa/5xUhBP2an3EbrowkPTwxNiBZQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781544328; c=relaxed/simple;
	bh=Zba5mrBeVQdo7XmkyKGoHJ/XhPm39Ld/v4lcQT8QgSg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=VfFfuj+ViryjNH4JnU0UhGSLtztm2h5MRFooqMqHlpY/Hbk7VmoFixTRt2+IN4MkqzJibdDDZ80B/7q7woU1l1ckRdV16ka+NBqvA0gjACBUyvEw2sFrKUN7zP60AKhpJWuQ6x8nodfIvF4EPA7FdxQ8CYag8QMnfEqHDUBhJ/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Yzg/AiM4; arc=none smtp.client-ip=209.85.216.100
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-36d8b644473so3160097a91.3
        for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 10:25:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781544326; x=1782149126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sqEinAete8nYHDwzHA1swrM0iqYY3bS8aKEMzjopnSY=;
        b=DIqD1MzdPFzHQh6hNU68xOaHZavvjjAjdoG32Y5MudnNAPW4p3GX5KMaayR6tyHSh8
         mAShZcvaAtfuwo+03wOhi1qHQ3eLscht0vuMP7rVmvoz3jcKhEFMHOWfkxXssq2bOv4F
         0PuopyzVpxIVeibTMN6nEygIYbBa+C+6KbdzW5a+2RKo2XNZpw5HvV+toOdgxFmM9vBD
         VvHO8WbrraHePeXRCVJpUzdaNs0HB709cWxlEhmBAHaY/JSbKPvOh7l8Azdcw26dV9dM
         5MPkgF2HN4CCJLSqLaxCT/1vr903CrXaVsDmY7dJa7QbzpoEN7J6pMEP2ExgOKqU9hkN
         HHOA==
X-Gm-Message-State: AOJu0Yyvo62NHsRmpkjMlD8sOAdGF3qt9oSl6tCCyK3poTwohHkz1ezC
	LsFzCdCj1pNcpZ+c0hZcUXOe5NTjk4CYRpxDJOSENMpAO/eNw14pIGc5LiLH7i7if8QoLtZEpsy
	MvFSu/yKBUJj+g2wiqVEjfHG2bUfA1HSFyQJ6qJJUZe764JjHdwgWl7+UeG/kb0cE9EwjndtvcU
	LI3/vlB2Zqz3zhyiRsOBmMk5CWhtZkSjrunhoQXTTXLsf4hondifUJi0FlKU+CDbV8SStes0gvJ
	kTSqxiK7zG0XNdqSA==
X-Gm-Gg: Acq92OFN8zXSHWNd9g67JDbFq0rMCozaBFS8GB8zhl1GftC/u1mBsWkt9pDh+EL0ev6
	NnsGixndhCrLouAC8s24dn1jTLrlzxAyIISbpqv7+PKKQX14ePFj1c815OCwZrYnfYz4JOILIzx
	iEq33kr0bXPZO2HO7cFbUjnaEDGz1yK8y620+3HIfhXxBjpwlQob51Y+nIrM4E+Il2CQWmrWOQG
	SqAquMUVAColn2J88FYhFPDM+QrTiPPmWqZ4YkTGA9s5+ysOYTttVIrFsfcKqSBxRmidl4SShoy
	GEw6OqoQbL06ChkKpaDp7MdUPHStLbqv5pEOBPM4cuBkkkDNm9GydplmsRtqhHVZfx2drxeE9pf
	6RlKIHHRxoIdSiSRQm/Vjpc2d5eqYFphx6ppFvL/WJ6JXDZaHUiTDsk9qvbYIMdxmgauqkH0Yh6
	cWfZiJVz/AHz4/58UP1OdwRHc/Gw3w9BUsmnXLzvGbK9AYKr7clcuhv/SptZb5
X-Received: by 2002:a17:90b:2d8e:b0:377:4a58:fe0b with SMTP id 98e67ed59e1d1-37c528398eemr254408a91.7.1781544326543;
        Mon, 15 Jun 2026 10:25:26 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-379c2e65e35sm360391a91.0.2026.06.15.10.25.26
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2026 10:25:26 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c0bf6904a6so59912775ad.1
        for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 10:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781544325; x=1782149125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sqEinAete8nYHDwzHA1swrM0iqYY3bS8aKEMzjopnSY=;
        b=Yzg/AiM4YEjOg5qvlB7CmVtIwZGjBe9jme7ma5tvX2DJIHFK19X7rcaR5KNNRAwVxr
         ZkmCMuNLUCo4AFZUyQ3K4khzhTYtDscSCfOlms+su9Rv9rMmXxkHstHAiXJnw9maCASY
         Jg26VI4YtbIYCGoxvsV/ZDUJu3Csb0aP5ouRI=
X-Received: by 2002:a17:902:f54a:b0:2bf:379b:53f4 with SMTP id d9443c01a7336-2c69a173131mr1604805ad.19.1781544324782;
        Mon, 15 Jun 2026 10:25:24 -0700 (PDT)
X-Received: by 2002:a17:902:f54a:b0:2bf:379b:53f4 with SMTP id d9443c01a7336-2c69a173131mr1604375ad.19.1781544324222;
        Mon, 15 Jun 2026 10:25:24 -0700 (PDT)
Received: from dhcp-10-123-156-114.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4328a43c9sm108289285ad.41.2026.06.15.10.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 10:25:23 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-rc v2 00/15] RDMA/bnxt_re: Generic driver fixes
Date: Mon, 15 Jun 2026 15:47:36 -0700
Message-Id: <20260615224751.232802-1-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	DATE_IN_FUTURE(4.00)[5];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22242-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,m:andrew.gospodarek@broadcom.com,m:kalesh-anakkur.purayil@broadcom.com,m:sriharsha.basavapatna@broadcom.com,m:selvin.xavier@broadcom.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,broadcom.com:dkim,broadcom.com:mid,broadcom.com:from_mime];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 39886688D5E

Includes fixes for few issues pointed by sashiko. Also, some
generic fixes found during internal code reviews.

Please review and Apply.

Thanks,
Selvin Xavier

v1 -> v2:
  - Added patches for SRQ/CQ resource teardown in HW before freeing the
    toggle page to avoid any access from NQ processing after the page is
    freed
  - Fixed synchronization issues pointer for Sasiko for the patch that
    handles multiple WC page allocation
  - Adding a cq and srq reference to avoid UAF
  - Add a zero check ureq->sq_slots
  - Adds a rollback code when ioremap fails
  - Handles request to getting toggle mem on devices that doesn't
    support the feature


Selvin Xavier (15):
  RDMA/bnxt_re: Initialize dpi variable to zero
  RDMA/bnxt_re: Free SRQ toggle page after firmware teardown
  RDMA/bnxt_re: Free CQ toggle page after firmware teardown
  RDMA/bnxt_re: Avoid any race while handling the hash list of CQ
  RDMA/bnxt_re: Avoid any race while handling the hash list of SRQ
  RDMA/bnxt_re: Add ownership check while getting the CQ toggle page
  RDMA/bnxt_re: Add ownership check while getting the SRQ toggle page
  RDMA/bnxt_re: Avoid displaying the kernel pointer
  RDMA/bnxt_re: Add a max slot check for SQ
  RDMA/bnxt_re: Proper rollback if the ioremap fails
  RDMA/bnxt_re: Avoid repeated requests to allocate WC pages
  RDMA/bnxt_re: Fix the cleanup upon error during SRQ create
  RDMA/bnxt_re: Fix the cleanup upon error during CQ create
  RDMA/bnxt_re: Fail DBR related page allocation UAPIs if the feature is
    disabled
  RDMA/bnxt_re: Reject GET_TOGGLE_MEM when toggle page was not allocated

 drivers/infiniband/hw/bnxt_re/bnxt_re.h   |  2 +
 drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 97 +++++++++++++++++++++--
 drivers/infiniband/hw/bnxt_re/ib_verbs.h  |  9 +++
 drivers/infiniband/hw/bnxt_re/main.c      |  4 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.c | 11 +++
 drivers/infiniband/hw/bnxt_re/qplib_sp.h  |  1 +
 drivers/infiniband/hw/bnxt_re/uapi.c      | 61 ++++++++++++--
 7 files changed, 169 insertions(+), 16 deletions(-)

-- 
2.39.3


