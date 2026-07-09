Return-Path: <linux-rdma+bounces-22953-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xaXyDbFwT2oNgwIAu9opvQ
	(envelope-from <linux-rdma+bounces-22953-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 11:58:09 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A75072F388
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 11:58:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=GI+x+lL8;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22953-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22953-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E60E307862A
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jul 2026 09:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348E0403E89;
	Thu,  9 Jul 2026 09:56:09 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F337403B15
	for <linux-rdma@vger.kernel.org>; Thu,  9 Jul 2026 09:56:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590969; cv=none; b=IeoEQgPY5bZD8TSQP+65ttYM4/xybdeQWNtKzN7iEnFMdxGWKpMmKWLRjbeIFWG8k2sUif0ycTxKGRzqOoBY5y9OZ3wUTZVCHGdBl5R25A6iY86cMlyMEdbafLgxG0GcGxKGoEgEF4A/Gll6xx9kq3WP2E9hnWL5QzYdVoi2g6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590969; c=relaxed/simple;
	bh=BtV4YlWqSeeVkZLMl7O/Z8uUv5IQpghIyehpmENCIJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aGlh34t8ndcUPmSUG82SfS2HoTNa6Lmtiz079q7mcW1dH9rgWdF//NN6257LzOJUANcu5mYo6t+lSxfAprhVVNhVmdCE8S7UqZiEzl7NSTKHWxcj2CmfeP74eXKfwMHyTnJE5/kC0ii35zl1IYKtJn2nuDPQT82p3ujHzHPu3Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=GI+x+lL8; arc=none smtp.client-ip=209.85.128.47
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493b27c7451so9032725e9.0
        for <linux-rdma@vger.kernel.org>; Thu, 09 Jul 2026 02:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1783590966; x=1784195766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FMAXl1cpFneAc8qw41p6eJ7Eq0JeDqgZ4KunEwtw9x4=;
        b=GI+x+lL8sq0CkxXuBnv0Cu1jA9kMWZ1Be8D5Z6yYyqffjpsE6H8buIGveFfzQvQo5I
         kOschQwaJRUU4taSyUeZB9PvIqFsA1wN0Q8PWWg3yp1EqdDrxLwE0kHXlh0zMnbSiZ+l
         Dr0wPMcBCdOQvz2h9Ut4yIlcl7T+CSPowbYTZR9Jzv9ox1zyIuKrW8b4mFIWJD02oWaY
         kRt+uqCVIG1jVHd74eIvyCk2h6KWQpHFM0V2gqKAj0FUKCBG0wmTbA3uxsuk/FbsYCId
         2NbZr2C8FpmGhLC1jT0+aidmMp+Pv0Qr+y1wrY6N63VNXyODWLRQ1SGZ88b4pe7g2zlY
         PQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783590966; x=1784195766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FMAXl1cpFneAc8qw41p6eJ7Eq0JeDqgZ4KunEwtw9x4=;
        b=qvOJkxjP6aixbwA7nTMDsQKgPaDjgJ9fymWrNydteE185KSI+8D1oI0AZlJ2j+ZrpS
         WEwFpAVjVD0nhLXsjVArZm6MNE2TJ/oDn5QmIydpUWBA41SXvmDfMQAkaNR4sbD6WwHK
         IwH8zF3/Fye2Axo7NVBUj1HyDRWe4JpVWagcMDMjnSY71y01pxT4CMcUsCh3D5Mk1vjp
         IFWEtA1sSkTsUw6gWuHlSMcKxNyiRQX9Y+iAHt9ITZ3OEGKMbdrvzCNgSwTyGjcxKFUG
         9u2gG7ielqgeUmNRMsu8OePMIbtuLbKLysQthP41e+/aqS/gVyI6Y/a47VzlmQmABeCg
         VGWA==
X-Gm-Message-State: AOJu0Yw0MSyw2YyfoItzCTOLp2LJc7LISBV6ayum9UtttR6aGIzcFmZc
	tKQsm6MCh1+h9t8YrcZRE3eXw8YeD3hBddsgQ+tg10jTPUij+ri0hXlDbUnRYPJYADwKVm1uyyB
	BbB34
X-Gm-Gg: AfdE7ck5nhP3cUc058nvxZBLcibq4Lqve/lh9KYnyXIfFWmFyJDJkXEcbweiGMijhLP
	AuyNIrgAxBcSIU3ROUNuPd3FlpcoXtjK/IXaILF4t/xVhDRJcQBO14J34EclTZUQzbqZVKkLD+D
	dwZVuotzwAos1ZC1mQEQwVH++LiC/e/mjwxrDSwv4kpKPUzJQK0N6TsrEaud0ystt+mgMVQdTpp
	jNvKkUD0Qnk8NV49Fe2J+uKQmEwsI4BPu8CFl4y7qZ2s5U6JBr9GaFpeD6gN55T+bSJg+Clu+VM
	QPxSkBzQku3N3fFiwsslkDGJg1sbVJXSsLNj+Y2yIQ9jRbMeK9tpRe6RvB06hmKiK4a0rGReX7X
	wGumFqrqMRtEalsS7WG0IlYUGvyM9CQiyRIMz5e3JaKsGshLU/SoXNhV5vlqajxtIXsL+fvllfW
	0MSgJZCUSbvt0QlXUCMqATpw==
X-Received: by 2002:a05:600c:3ba2:b0:493:e542:ffd5 with SMTP id 5b1f17b1804b1-493ec65ecf7mr22790365e9.5.1783590965776;
        Thu, 09 Jul 2026 02:56:05 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6f16cfsm51734255e9.12.2026.07.09.02.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:56:05 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: cgroups@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	jgg@ziepe.ca,
	leon@kernel.org,
	parav@nvidia.com,
	mbloch@nvidia.com,
	cmeiohas@nvidia.com,
	roman.gushchin@linux.dev,
	bvanassche@acm.org,
	zyjzyj2000@gmail.com,
	shuah@kernel.org,
	tj@kernel.org,
	mkoutny@suse.com,
	hannes@cmpxchg.org,
	alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com
Subject: [PATCH rdma-next 09/13] RDMA/cma: Document that CM configfs cannot be net namespace scoped
Date: Thu,  9 Jul 2026 11:55:28 +0200
Message-ID: <20260709095532.855647-10-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709095532.855647-1-jiri@resnulli.us>
References: <20260709095532.855647-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22953-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,ziepe.ca,kernel.org,nvidia.com,linux.dev,acm.org,gmail.com,suse.com,cmpxchg.org,linux.alibaba.com,linux.ibm.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-rdma@vger.kernel.org,m:cgroups@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-s390@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:parav@nvidia.com,m:mbloch@nvidia.com,m:cmeiohas@nvidia.com,m:roman.gushchin@linux.dev,m:bvanassche@acm.org,m:zyjzyj2000@gmail.com,m:shuah@kernel.org,m:tj@kernel.org,m:mkoutny@suse.com,m:hannes@cmpxchg.org,m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[21];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20251104.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,resnulli.us:mid,resnulli.us:from_mime,nvidia.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9A75072F388

From: Jiri Pirko <jiri@nvidia.com>

Document the rdma_cm configfs limitation: configfs is global, so same-named
RDMA devices in different net namespaces cannot both be represented there.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/ABI/testing/configfs-rdma_cm | 4 ++++
 drivers/infiniband/core/cma_configfs.c     | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/ABI/testing/configfs-rdma_cm b/Documentation/ABI/testing/configfs-rdma_cm
index 74f9506f42e7..739f7b6a1259 100644
--- a/Documentation/ABI/testing/configfs-rdma_cm
+++ b/Documentation/ABI/testing/configfs-rdma_cm
@@ -12,6 +12,10 @@ Description: 	Interface is used to configure RDMA-cable HCAs in respect to
 		for this HCA has to be created:
 		mkdir -p /config/rdma_cm/<hca>
 
+		Note: configfs has no network namespace support, so this
+		interface cannot represent two devices that share a name in
+		different network namespaces (possible in exclusive netns mode).
+
 
 What: 		/config/rdma_cm/<hca>/ports/<port-num>/default_roce_mode
 Date: 		November 29, 2015
diff --git a/drivers/infiniband/core/cma_configfs.c b/drivers/infiniband/core/cma_configfs.c
index 891e52afb8f4..c389d4e37b6b 100644
--- a/drivers/infiniband/core/cma_configfs.c
+++ b/drivers/infiniband/core/cma_configfs.c
@@ -65,6 +65,10 @@ static struct cma_dev_port_group *to_dev_port_group(struct config_item *item)
 	return container_of(group, struct cma_dev_port_group, group);
 }
 
+/*
+ * configfs is not net namespace aware, so a name shared by devices in
+ * different namespaces resolves to the first match here.
+ */
 static bool filter_by_name(struct ib_device *ib_dev, void *cookie)
 {
 	return !strcmp(dev_name(&ib_dev->dev), cookie);
-- 
2.54.0


