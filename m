Return-Path: <linux-rdma+bounces-18451-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAdCJL9UvWlr8gIAu9opvQ
	(envelope-from <linux-rdma+bounces-18451-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 15:07:59 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBF92DB973
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 15:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A3EC30136B1
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 14:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C00B3148CF;
	Fri, 20 Mar 2026 14:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZRp0Xe1v"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f232.google.com (mail-pg1-f232.google.com [209.85.215.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A3E375AA2
	for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2026 14:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774015420; cv=none; b=Tgdv9hIyMRT9DP2DDnYoPAdIkBjZMAlaMcVZIQhEbk1Zre3hN3+MGFDuFK126J0jvKcyKHDPJFEGZ3+yI5eZzVSijJ0fpSfl5F36s61PSkICt5DoPnVBJWC7yQzXrjvULZSnT/P33pPY/Jo3g3TbbgvypF4Zw8p3UrFMt+w15ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774015420; c=relaxed/simple;
	bh=xjqaPCfpm5pkCOSbc/2QgKLxKwQnPqXFSkHmrAh1fCA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dObvioJ56GIGcVAiD5qeVbob1lpt1Aj8t/KxNg0wd4vlFBOMkXO0qHWZIygAYbY70yVTR+9yiiBD2Y+qprx2LFSq8FCQ9npTh1/w/+kTWQYN76IJAMOarWeKBQKEFPmhfHvP8rCIoi6a7sMeYcfNdkJTcw4mcVK6RTZzo9FxZO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZRp0Xe1v; arc=none smtp.client-ip=209.85.215.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f232.google.com with SMTP id 41be03b00d2f7-c7358a7a8d1so1418600a12.3
        for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2026 07:03:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774015415; x=1774620215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nO0BVHZ4NKsVjW2FYX9y53xHgFsn91SscXBPTXF24kk=;
        b=GcvhpZa5IsTLHKPeAC0PQlt5TpD1MScH6bA3QVIkFCrSBUj900GYdCiqEGoLokxxaV
         KFuFBpFHIMZCACHrfTXzzvilNU1Uk8g7nLp+I3t90IcwMUGs59dUxBAgwBp9kdJZoINu
         uOT7uK/uqUii337KbSDXeXHpDGFInwzBJOhrBYS4QNQMuPDm7+Uhh6kfVXHtM9+296Oz
         IHiIuv/W5SjCU4dEPeJOSUyRZJf9tb/ENDBA34KSZBuyb1y1lwAJGKNdE7HJmn7v4zPO
         CNZjVbP2FIGE0M52mTT+RTOPN0Ld2bjNlO0VwutX8hPdW5b1VvDrNx/OZ6XfQUlj734a
         Ki8Q==
X-Gm-Message-State: AOJu0Yy+fPp06mzyDpfq+YAdnzcdwuRfBM/ASDJsM1aymwXerO+MUGOk
	9Jrnb+0B1IegdRxPq2mHZF4Wqnb44T2aK9H8lF8j+gApT+nkK1ZgvE6xZzTM8uaofZJB57JbqfW
	1jdnLO8lIbEjodFmeqi0B+hU+1+dDaWoFcWap3fTtKKGw3ppy1d7U1Oge17GOpmiiKs1xe0PrmK
	CPPGORmzFWlUMxL8gg2mzGEQbhmV2c/kcCJo5QnF8e/DkRrPNyc1/iW2j+X5AcaYvv6NTTbtr7K
	5te8YMHB7ejRKbg/BQOP2bpKxVKpjc=
X-Gm-Gg: ATEYQzzfI4ecqmiXKm6E2H7fhH7D1VGLWnutDuPXVFnukxXRurndimbkFgUObzTrijm
	OkAYwa4mOu65XpFrRx7M+Oe3AmAkPWWBxm2T2VTdLE/xF9NugTzFcTKV78dqSVcs0wwZovQ6yU1
	KmSOZNYHB6FIGCVBKSU7ZXBzhkQF5Cd025pG0NX5/DwWHxXBjax0YwLJjkPSWsjKrMraM2sKtjJ
	Yo8hwQQfCCNSPVV8fJpllMId2MiHRs5dN1achJuA47DRtZzsUiD9rC2F2aETo1B4A9KRqoGb+WP
	hdxK2J7wkC9wI+5wv6i1yh8JbuAkBbdsMyTvt9n0c55U8DEmtjOUlM5DpHczZqEJ7ujv4qghX4L
	P4h4v5DtDtZ2oririDpX2s+IB1Eq38yU+TsM4TtJZSU6SL1i6gGLhzwf4twAjoj0l+t13bUCn9F
	DRqmaNEIVIq2qRhTjAtLoGjOnKmIKli6eTGS88OmMua2YHViPBkR7gsR/wRhF2bG/osBLMG/0=
X-Received: by 2002:a17:90b:510a:b0:359:f3b1:6811 with SMTP id 98e67ed59e1d1-35bd2bd5ceamr2555052a91.1.1774015415064;
        Fri, 20 Mar 2026 07:03:35 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-35bd24df91dsm143335a91.0.2026.03.20.07.03.34
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Mar 2026 07:03:35 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82a8afb2d0aso5097846b3a.1
        for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2026 07:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774015412; x=1774620212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nO0BVHZ4NKsVjW2FYX9y53xHgFsn91SscXBPTXF24kk=;
        b=ZRp0Xe1vF+y/1HPRnF9+ZQpSm/Isg6pcf8X47wkSYir/Bsim3PeJrCVlpcd222PqrU
         2BphIZkdBdRzxF/bVZMAAoC4S0FTa5kRR7YnXhysyN2NN1ByPuKmrbldvwz19fmIkoCq
         T8qpSo4i/NYEtd1+WyDXegMs1WfJBElp5jq78=
X-Received: by 2002:a05:6a00:ad89:b0:829:7e6d:cf20 with SMTP id d2e1a72fcca58-82a8c361309mr2571414b3a.58.1774015412377;
        Fri, 20 Mar 2026 07:03:32 -0700 (PDT)
X-Received: by 2002:a05:6a00:ad89:b0:829:7e6d:cf20 with SMTP id d2e1a72fcca58-82a8c361309mr2571363b3a.58.1774015411364;
        Fri, 20 Mar 2026 07:03:31 -0700 (PDT)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b040da3dfsm2136099b3a.45.2026.03.20.07.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 07:03:30 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next 0/9] RDMA/bnxt_re: Support QP uapi extensions
Date: Fri, 20 Mar 2026 19:24:28 +0530
Message-ID: <20260320135437.48716-1-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18451-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: ECBF92DB973
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This patchset adds QP uapi extensions to the bnxt_re driver.
This is required by applications that need to manage some of the
RDMA HW resources directly and to implement the datapath in the
application.

This series supports application allocated memory for QPs.
The application takes into account SQ/RQ ring sizing constraints
(extra entries, rounding up etc) while allocating this memory.
The driver should avoid duplicating this logic while creating
these QPs.

The ring buffers provided by the application are pinned by the
uverbs layer before they are passed (as ib_umem) to the driver.
The uverbs changes are in review:
https://patchwork.kernel.org/project/linux-rdma/cover/20260203085003.71184-1-jiri@resnulli.us/

uAPI changes in this series:
- Patch#5: new uapi parameter 'sq_npsn' in bnxt_re_qp_req.
- Patch#7: new driver specific attribute 'DBR_HANDLE' for doorbell region.
- Patch#8: new comp_mask 'APP_ALLOCATED_QP_ENABLE' in bnxt_re_qp_req.
- Patch#9: new devop 'create_qp_umem' for sq/rq_umem buffers.

Patch#1 Refactor bnxt_re_init_user_qp()
Patch#2 Update rq depth for app allocated QPs
Patch#3 Update sq depth for app allocated QPs
Patch#4 Update umem for app allocated QPs
Patch#5 Update msn table size for app allocated QPs
Patch#6 Update hwq depth for app allocated QPs
Patch#7 Support doorbells for app allocated QPs
Patch#8 Enable app allocated QPs 
Patch#9 Support create_qp_umem() devop

Thanks,
-Harsha

******

Sriharsha Basavapatna (9):
  RDMA/bnxt_re: Refactor bnxt_re_init_user_qp()
  RDMA/bnxt_re: Update rq depth for app allocated QPs
  RDMA/bnxt_re: Update sq depth for app allocated QPs
  RDMA/bnxt_re: Update umem for app allocated QPs
  RDMA/bnxt_re: Update msn table size for app allocated QPs
  RDMA/bnxt_re: Update hwq depth for app allocated QPs
  RDMA/bnxt_re: Support doorbells for app allocated QPs
  RDMA/bnxt_re: Enable app allocated QPs
  RDMA/bnxt_re: Support create_qp_umem() devop

 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 318 +++++++++++++++--------
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |   5 +
 drivers/infiniband/hw/bnxt_re/main.c     |   1 +
 drivers/infiniband/hw/bnxt_re/uapi.c     |  18 ++
 include/uapi/rdma/bnxt_re-abi.h          |   6 +
 5 files changed, 245 insertions(+), 103 deletions(-)

-- 
2.51.2.636.ga99f379adf


