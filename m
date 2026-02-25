Return-Path: <linux-rdma+bounces-17163-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QL37M/n6nmm+YAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17163-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 14:36:57 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 495AC1982B5
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 14:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D3C630C16E2
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 13:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B793C197A;
	Wed, 25 Feb 2026 13:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="xiSL6goO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329EB3C1978
	for <linux-rdma@vger.kernel.org>; Wed, 25 Feb 2026 13:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772026473; cv=none; b=D8FsN/FNd354BaD9zew/1f2ol5mhpwv/Ud3MVVrjep57Z02ZKoC13dxPWSyGA7AIVc2Gkulr/jreOy7Gpt9d0GPvl9AUzqofTshR8PpEp/UNxdmCP9lUyw5FX7u9UYpVf/AL1CZqz4y+6k9VbZKUtHV+eK8k6mNiEHduacEkLXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772026473; c=relaxed/simple;
	bh=cBdk7OS/MqJvfgCd8WjMOg+aNCv6O46a+gTZy5CXlts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BEiDfLxk3N1r8XfyxMuUvJLORXneLaB5S7WCEJPcZ5NrAjkEr6M/OF8jmbz9HlCMyPZSRuBiLsfudvk+kN1TF9U0MHffYQUzy+wx2eY9n+H5+39Du2e/X3xQtcqiPGoyWMPdZnSOUlq+iXMSlXDStLewhTJZSZsrBxvVAHJyDaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=xiSL6goO; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4836f363ad2so73699275e9.1
        for <linux-rdma@vger.kernel.org>; Wed, 25 Feb 2026 05:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772026471; x=1772631271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+zgEcbAzOtmZIjmk4/NTF6Huw5yR7HZ4LqFtC8QXVE=;
        b=xiSL6goO+ydywZ0fzuuyNAZq1mr+W3T+rXTnZaW85NBrwDG6raKJeZYgcNGPahmj8Z
         t7N86d5W0jiAt1mO5RM6jsIhTyDFR/mu5Jo9Fv6IMAmrLR3E0DBNqsY1ns+JwnTsdBKt
         0ZBjHt11fdIv82tXTu4UrNjqQVP8mH+sYTbSuy46ekEXtkCtkR3XN/ftgV0ClX06zHu2
         dBxUbUPq4d2ePWfZTZwHbIJsyBjO0+N8gv7bhmc33hKRb2PF1jIB691AdO9+Kj66ASqB
         dMvSZmrYuHsIo7o67ryn5C85snUmXazAPbFp8ccEGmcLFhlXdAgcgYr22PG0wV7vBSi6
         OgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772026471; x=1772631271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2+zgEcbAzOtmZIjmk4/NTF6Huw5yR7HZ4LqFtC8QXVE=;
        b=Fd90VlqE56VXoWx9dU3UeRaXDdAyypP4V2uNKQ90wDo1dSsh6m0fUtFyRpH9O/DXyD
         oySeZTuRuRPGTl0AA5Nl/MygsjXhAeqTzCUEpPvI0c7u9ZDSj+9rqRIxCveT3lOaR8Tm
         WqXY3or6/mRp8UmIMrvNVoasKZchFUnqBm2YT3BcFUUQFOGMcnfyVA/DqtLeShbr7Tlm
         kBdLkS37YOLaI0t+WYuTuTFDSSwsIWX0Y2F/mExf8NdYFlXWHGBAfVbQH06wz3RINoOG
         mSXxh6/X7D81v1KZo0Aza/nqTdVqwYzMMjLPzB8GPhJFwGntXFhuG+FvL3fB9X8PDo2z
         rbFA==
X-Forwarded-Encrypted: i=1; AJvYcCXrBJiW6BSJrh/eHZUd0JFPhjVwSePXk7QxjRfS4YHg2rvSclnOfCepWD17xnOGZX9ijvbyKeBntIMi@vger.kernel.org
X-Gm-Message-State: AOJu0Yywiy7HcJumJ++a1ZhnqIh04esP5fAFclMJm5k5VHdjjKyT0oog
	3uzFcDmIvWiuVo6k20UJxIE1ZG/yZFvU6BwJtcqRDOv4j1pBFOnQ1bOZ4ybqIHetZ+I=
X-Gm-Gg: ATEYQzykpbyPIKTnJIrjza7SY+TcFSQnFkmRbbVyIfK9aJqtZlZ17A0/uqB6bmBXyrF
	kHFZpUAj+kELrLKRWI7UUiefVVmOH5Cebl0jwvkGeMY4BOcIIv6lfZZOnX+FEw9DTrHbuGzCs1M
	PBaMniX4oFdSnDx1OJi/OPqnm3u4QdyFLwGoZD+RLFdn7J/0so8L/zvUI/HH+zk8GY8Yjn5uZM9
	gJVaeC1puXpO7pusfUOuwFQ8gkw4dOgAhuTcEPSpwRVohkgKlgVqMJD7jnPtGJq+ncHp6xkwpHq
	hGVco+z5dme3Q+HoKNvvFUCuUGannn3GAuwsCFJpbnpv8cHJzu3xmC3MinVeV3N4ZjGbdATv+BS
	c0QPjoxd0c9MGcn3WwK2/DaWsYe1R2SrybDnS3Y/kUxAhT9rHQf03SI1KErAY6zfHj83h0O8BY/
	s8kMd3SYse59jEWQ==
X-Received: by 2002:a05:600c:8716:b0:471:1717:411 with SMTP id 5b1f17b1804b1-483a95e9a7fmr276220965e9.24.1772026470590;
        Wed, 25 Feb 2026 05:34:30 -0800 (PST)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfba9566sm18237565e9.3.2026.02.25.05.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 05:34:30 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	przemyslaw.kitszel@intel.com,
	mschmidt@redhat.com,
	andrew+netdev@lunn.ch,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	chuck.lever@oracle.com,
	matttbe@kernel.org,
	cjubran@nvidia.com,
	daniel.zahka@gmail.com,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH net-next v2 05/10] devlink: support index-based lookup via bus_name/dev_name handle
Date: Wed, 25 Feb 2026 14:34:17 +0100
Message-ID: <20260225133422.290965-6-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260225133422.290965-1-jiri@resnulli.us>
References: <20260225133422.290965-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lwn.net,linuxfoundation.org,nvidia.com,intel.com,lunn.ch,goodmis.org,efficios.com,oracle.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[resnulli.us];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17163-lists,linux-rdma=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[26];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.978];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 495AC1982B5
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

Devlink instances without a backing device use bus_name
"devlink_index" and dev_name set to the decimal index string.
When user space sends this handle, detect the pattern and perform
a direct xarray lookup by index instead of iterating all instances.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- moved DEVLINK_INDEX_BUS_NAME definition here from patch #7
---
 include/uapi/linux/devlink.h | 2 ++
 net/devlink/netlink.c        | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 1ba3436db4ae..7de2d8cc862f 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -19,6 +19,8 @@
 #define DEVLINK_GENL_VERSION 0x1
 #define DEVLINK_GENL_MCGRP_CONFIG_NAME "config"
 
+#define DEVLINK_INDEX_BUS_NAME "devlink_index"
+
 enum devlink_command {
 	/* don't change the order or add anything between, this is ABI! */
 	DEVLINK_CMD_UNSPEC,
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index b73cec31089f..127f337489c0 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -200,6 +200,15 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs,
 	busname = nla_data(attrs[DEVLINK_ATTR_BUS_NAME]);
 	devname = nla_data(attrs[DEVLINK_ATTR_DEV_NAME]);
 
+	if (!strcmp(busname, DEVLINK_INDEX_BUS_NAME)) {
+		if (kstrtoul(devname, 10, &index))
+			return ERR_PTR(-EINVAL);
+		devlink = devlinks_xa_lookup_get(net, index);
+		if (!devlink)
+			return ERR_PTR(-ENODEV);
+		goto found;
+	}
+
 	devlinks_xa_for_each_registered_get(net, index, devlink) {
 		if (strcmp(devlink->bus_name, busname) == 0 &&
 		    strcmp(devlink->dev_name, devname) == 0)
-- 
2.51.1


