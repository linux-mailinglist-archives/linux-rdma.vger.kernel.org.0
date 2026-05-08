Return-Path: <linux-rdma+bounces-20223-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLVeLwWo/Wl0ggAAu9opvQ
	(envelope-from <linux-rdma+bounces-20223-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 11:08:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E5C4F40E6
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 11:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C896302A7E6
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2026 09:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8823750B9;
	Fri,  8 May 2026 09:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KfY9skSQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f102.google.com (mail-ot1-f102.google.com [209.85.210.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FFF2F8EA9
	for <linux-rdma@vger.kernel.org>; Fri,  8 May 2026 09:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778231293; cv=none; b=uTtVxY23ogEt04kcO0t5C9sYoLGk3uBh0KyqpuH7LZdUKoBpD1QipgPTk8eiv9xw1HrJUpcMVyjF1kYKrnztGqugMdE629Uce6wnlwruGYHppc9o7tXSrdutFA85iAUKZKXVbCmXSk1PctLWZol7rUgcfJqWxZPy/O/mUB0DhQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778231293; c=relaxed/simple;
	bh=6AdemSepMaxR+NjBnEDXKipIWntrI7I6pmp1uz14at0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=egYE4YCMWFX7VMqauI1YN8RoxX1Vr1/GR4ZpVLVmJGm7px8u3UdsEnsQfw0iCjYdp+jKG61rR/xjyQSk+H2X2swOes+QqT7JiDIQgjhpZP0j3YkVGBtAHwy45EIDFfhY0HL14VxxBe/UJPNkHej+18Y157Zq5bjNO1lbAUKinEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KfY9skSQ; arc=none smtp.client-ip=209.85.210.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f102.google.com with SMTP id 46e09a7af769-7dbe437b072so874236a34.2
        for <linux-rdma@vger.kernel.org>; Fri, 08 May 2026 02:08:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778231290; x=1778836090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YIH8xKWkzje/+egWcUnFD3SF3JmRJhHwI5rbv/wDQnM=;
        b=MUFTzFSdKb2cVVK4WxCztH9f2NzMVHsIAGwCBgLoe5Aaw25BaPcgQVoVoDEVuzkTnc
         462i4c/Wjv+YtzMy8b8T5OwJKOqMuCc9SW5K6RRVs8u+Zbhuj0P3vWyUkdtFqVkX1XX1
         NG1GM1dzf/0I21t/3vtz01zqqTmxslgGNziGWQC70E+8AdtFHkL5SMzODlWOC8zi4KS+
         GMn3UyTVmFQ1wObziBjj9QQ4JCyyZIpc2KcNPjbNOUvfZveSJQbyLPsbZQt0YliyuWKE
         8lcmPTsFFfJN/z9iePJJdDk75/eCT3zG25Y4FRzEV0jgNWUHXqEx5F5PsoHSFyQx/eMD
         RboQ==
X-Gm-Message-State: AOJu0YwJTcmNA7gcNagk8QF+vLKUXSQDYEeHa15t7RN19fz+GdjQOKUc
	4ktDGz4AZ22pxL1xSCs9qOP8k9xIQ73aDcLypZOEvs+mmM804pVsSganeKGKP/xBqihlf969Ak8
	ZtDhK2Kpwfu3XS2+CZFb/KLZn7q0BBezuORMocE5ARhdRIptU+BR4JNY1Tu5DNXHTsJDPXzOTgq
	EFkNirj38YE4bU1G13z5YYOXE3B4Yigl0wOLXkYvu7V8X5T5y7WeAl37J6K3j74AEcFKbVbxE1r
	2e2AwukVdEO6cZeoPwdETE8zyifiFM=
X-Gm-Gg: AeBDieubEVSN1Elbku1p+twA70QzM63wyVKI77mt8ViZ6oydpfZNJ/kAZF/5XOndPEN
	A+m3HpFxgCuxAY5K0G7I3FAsScCrWkpvCxPDbFLQFjfIpF4nv8PoaHt3+7eyAyGoWjX7sZl476Q
	55LDvonGQ9eAon7JwVGwo/Fx1SinqtoW6mr1N2C9MwrHGYnwY2J6PTXIid1S49IDP6zryspbYGo
	qSqChjqyeMTjI0LZScjNFk2F6ug3pdCwgGPs7nJGvUjN8R3Wb76ZxuUithCbuUlUgXnWwzrQW8c
	NzTjWBLJrqJwbFJeH8r7GD2RkwJxbwa7vMW2aDcO0P6s/llMLPmgWgCGFQYkldtUhPiYZOMfIjl
	ydwSaWQc9TlDRNMk6q0GqMiHwuL5tDu6ALlP2SePdbD0apmNDvnC3EK+bNBeKmNZrgCJZSFwhwc
	vdVu3LDBJqppcho6AI
X-Received: by 2002:a05:6830:3905:b0:7dc:cd0b:58b0 with SMTP id 46e09a7af769-7e1ded2b16fmr7339996a34.3.1778231290416;
        Fri, 08 May 2026 02:08:10 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7e367be2072sm85098a34.1.2026.05.08.02.08.09
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2026 02:08:10 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c823549b1fcso2298492a12.0
        for <linux-rdma@vger.kernel.org>; Fri, 08 May 2026 02:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778231288; x=1778836088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YIH8xKWkzje/+egWcUnFD3SF3JmRJhHwI5rbv/wDQnM=;
        b=KfY9skSQhJerrQQqcK1DfzAzJen0mcQ0G02G+GBd6rT36kfCbFdV4BCMTmWZdgYalq
         qgyTmFon10BXDAKuNHS7waUGyN1qJq3piEtPP0Wy/9RI3aDre2CeWaOjURIJuHvveZkJ
         a3LRhSFQJEgUgZWUbJ7o+FA48KDNMsna6zY+E=
X-Received: by 2002:a05:6a21:9992:b0:3a2:ecb8:56d8 with SMTP id adf61e73a8af0-3aa5aaee2d5mr12904951637.31.1778231288317;
        Fri, 08 May 2026 02:08:08 -0700 (PDT)
X-Received: by 2002:a05:6a21:9992:b0:3a2:ecb8:56d8 with SMTP id adf61e73a8af0-3aa5aaee2d5mr12904910637.31.1778231287875;
        Fri, 08 May 2026 02:08:07 -0700 (PDT)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839679c80e7sm14419052b3a.31.2026.05.08.02.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 02:08:06 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v4 0/7] RDMA/bnxt_re: Support QP uapi extensions
Date: Fri,  8 May 2026 14:28:51 +0530
Message-ID: <20260508085858.21060-1-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 44E5C4F40E6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20223-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:mid,broadcom.com:dkim];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

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

uAPI changes in this series:
- Patch#4: new uapi parameter 'sq_npsn' in bnxt_re_qp_req.
- Patch#6: new driver specific attribute 'DBR_HANDLE' for doorbell region.
- Patch#7: new comp_mask 'FIXED_QUE_ATTR' in bnxt_re_qp_req.

Patch#1 Refactor bnxt_re_init_user_qp()
Patch#2 Update rq depth for app allocated QPs
Patch#3 Update sq depth for app allocated QPs
Patch#4 Update msn table size for app allocated QPs
Patch#5 Update hwq depth for app allocated QPs
Patch#6 Support doorbells for app allocated QPs
Patch#7 Enable app allocated QPs 

Thanks,
-Harsha

******

Changes:

v4:
- Rebased to latest for-next tree (Linux 7.1-rc1, commit: 254f49634ee1).
- Renamed QP req comp_mask: APP_ALLOCATED_QP_ENABLE -> FIXED_QUE_ATTR.

v3:
- Removed umem patch from the series, that is dependent on uverbs support.
- Patch#7: Process DBR_HANDLE attr regardless of app_qp comp_mask.

v2:
- Rebased to umem_list uverbs patch series:
  https://patchwork.kernel.org/project/linux-rdma/cover/20260325150048.168341-1-jiri@resnulli.us/
- Deleted Patch#9; create_qp_umem devop is not supported.

v3: https://lore.kernel.org/linux-rdma/20260415054957.36745-1-sriharsha.basavapatna@broadcom.com/
v2: https://lore.kernel.org/linux-rdma/20260327091755.47754-1-sriharsha.basavapatna@broadcom.com/
v1: https://lore.kernel.org/linux-rdma/20260320135437.48716-1-sriharsha.basavapatna@broadcom.com/

******

Sriharsha Basavapatna (7):
  RDMA/bnxt_re: Refactor bnxt_re_init_user_qp()
  RDMA/bnxt_re: Update rq depth for app allocated QPs
  RDMA/bnxt_re: Update sq depth for app allocated QPs
  RDMA/bnxt_re: Update msn table size for app allocated QPs
  RDMA/bnxt_re: Update hwq depth for app allocated QPs
  RDMA/bnxt_re: Support doorbells for app allocated QPs
  RDMA/bnxt_re: Enable app allocated QPs

 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 270 +++++++++++++++--------
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |   1 +
 drivers/infiniband/hw/bnxt_re/uapi.c     |  18 ++
 include/uapi/rdma/bnxt_re-abi.h          |   6 +
 4 files changed, 206 insertions(+), 89 deletions(-)

-- 
2.51.2.636.ga99f379adf


