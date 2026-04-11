Return-Path: <linux-rdma+bounces-19241-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YE5CI+1f2mlQ0wgAu9opvQ
	(envelope-from <linux-rdma+bounces-19241-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 16:51:25 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E16623E0732
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 16:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 561173074130
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 14:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3420F38757D;
	Sat, 11 Apr 2026 14:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="f/WJRjkY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFE4387361
	for <linux-rdma@vger.kernel.org>; Sat, 11 Apr 2026 14:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775918980; cv=none; b=mF4AiiQIPaW8j1Rm7B/A0/LZWBPOEClMHZsEY6gNmovgs7Zmx8lKkmqLWDQTegdfRWUMkvIgDrR32PWZ1+rf3Wlv5duneo2Dmy7TWFO0jchRbWRipQBFa8TFDwF5xI9f7Xbp+N0uHg+BNo/4hrJLA0Xk7r0GFOd+2W2c92sYOJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775918980; c=relaxed/simple;
	bh=LkdWNTecQ9o5BIJI2cen8XW3w7srsFFrQ4R64c+dKi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kNRFb0F6Tn/0w2bVmXVH14Af2BQBHza9WpG2c9/y+hqATxw7a/gh7Vb0DlZDy0lRTzOLdNPSYOKggjAUvxAB9i+43OxMwZJtF36y37ntXF4Y+PltpEgdMtZRDR6BbMSvBff8hci/31a58Fmkcw3dfOn8PWzrQ/xD1w/1UFaNylE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=f/WJRjkY; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso26873595e9.3
        for <linux-rdma@vger.kernel.org>; Sat, 11 Apr 2026 07:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1775918977; x=1776523777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zcLOzoHL+dyCuv8aTOE2LVWDYCXr6RvlVQlbVuDNAws=;
        b=f/WJRjkYtNzydMXr4XZUg1cJ/ZF0D0Wy55jCvCL4NRi+TEXm8ymgsEANXiex8sYKz8
         EI7O4prdJITaOaVoSejQsoDpnNsJWyXvFzlF4PSbEwxy/62XReCwGwji4UYc+RIuZFag
         l1b7llJdlIkQJd3CiFs1N4BoNstDyQTcnvniipwFBkCSFAcNl8i2J+C2uyd3lwZZzmyg
         hYopUb5/Mfd6q1mFdns0P49v6fT/ip1q24iImkaoK915ZncFTm1/ymMhl3WT8u0gO082
         cLizPV4iowhOgBl1g5FQUwDlsZVcBjLs1HwMUmG7H0CnGyrm5Ppk9JZTU4aUImnDUsH8
         dxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775918977; x=1776523777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zcLOzoHL+dyCuv8aTOE2LVWDYCXr6RvlVQlbVuDNAws=;
        b=hKqqLKws3knBv8Nlfrg5mOAA0f8uIe2leEFJf9f3baawCM3WyScKP+Znc9fv6SFQ3q
         CXEPsfeBE/wubltwRwhw0FuCcYhjx3Zp99Gb/NfsPWM8WEe0/2N/VquPrh8gV+BUiZFW
         axMeghrJjuDxQArebXbwDXeK0tlvAxhWPKGVEsiUFk8+/ljF/Qvsc9LFYt/BzB6VyZBn
         9fbB0wEMxKRuLXia9+kq+VVN9Uou/XXiyX6h7t1m6YduIdzpmierpacDcgB/hQnE6Tgc
         hIL9NHnlP3LS3u2n7OdBGKKMH+UPAMsxI632pV04s2VpXyZtDyIMzTuQLXNl5YDH2VVL
         6EOg==
X-Gm-Message-State: AOJu0YxA3/kpLhNrgj0OQb/gXhmSyv/OWS10ryuJGTZ3Gk2bTM86Pjw8
	6V+PrjNEar2qnPdi9QQPNDGHazd7MxE5Wa2dGD92vUOQ5DIbrU8P/iQ8vexV7gpdXbmDhVGewNH
	AWknA
X-Gm-Gg: AeBDieu8r7kbJzmE0mprIRcb4HU0qQBk1cTToLl7leGVNJorlvwdmYMzjarVRnXomId
	VMcbnMUixUBv9hpgBLikGMsGUjxpnytjTbaFoYKOoNIjXmWn5HkM/Q1y89I8E96AzURTvYrlqCM
	NLCPYHDt80W/xGYqY+zWnrahO2Pd6uQX6HAhoilhEK+M2V/rxBt9XmLIgfnGOncwSV2D7n7PKF7
	TkRKqMPqFHT2av0pgBTuKS6KXlCEKurzxOI5OrgrWaSX8woX8VpdNDpXOHW18KXU/WBJbvOUz+S
	y2IMffwl4KT7419HHrQCxA2/mbUPYLUacVWbqSFMMRvINNUEvBB8SFUF88Qi7oZ9BufcSM06YCR
	uck51JjB3v4Vuz90mtMqweVSD5nhaOPfY6r9+aQMtuho3EprnRmznBWvBhKBoFCd2A8X1H3CZvW
	+S94uo1vrdTt1rrJCprl1yuRFBOq6c6YYtXtXa6zZD/VU=
X-Received: by 2002:a05:600c:3b24:b0:480:2521:4d92 with SMTP id 5b1f17b1804b1-488d687adb3mr97332485e9.24.1775918977188;
        Sat, 11 Apr 2026 07:49:37 -0700 (PDT)
Received: from localhost (78-80-9-176.customers.tmcz.cz. [78.80.9.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e50289sm16829025f8f.28.2026.04.11.07.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 07:49:36 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	mrgolin@amazon.com,
	gal.pressman@linux.dev,
	sleybo@amazon.com,
	parav@nvidia.com,
	mbloch@nvidia.com,
	yanjun.zhu@linux.dev,
	marco.crivellari@suse.com,
	roman.gushchin@linux.dev,
	phaddad@nvidia.com,
	lirongqing@baidu.com,
	ynachum@amazon.com,
	huangjunxian6@hisilicon.com,
	kalesh-anakkur.purayil@broadcom.com,
	ohartoov@nvidia.com,
	michaelgur@nvidia.com,
	shayd@nvidia.com,
	edwards@nvidia.com,
	sriharsha.basavapatna@broadcom.com,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com
Subject: [PATCH rdma-next v2 14/15] RDMA/uverbs: Add doorbell record buffer slot to QP umem_list
Date: Sat, 11 Apr 2026 16:49:14 +0200
Message-ID: <20260411144915.114571-15-jiri@resnulli.us>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411144915.114571-1-jiri@resnulli.us>
References: <20260411144915.114571-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19241-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[23];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20251104.gappssmtp.com:dkim,resnulli.us:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: E16623E0732
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

Extend the QP buffer slot enum with UVERBS_BUF_QP_DBR, allowing
userspace to provide doorbell record memory via the generic buffer
descriptor infrastructure.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 include/uapi/rdma/ib_user_ioctl_cmds.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/rdma/ib_user_ioctl_cmds.h b/include/uapi/rdma/ib_user_ioctl_cmds.h
index 26c2e3b2125a..1a47942ca1a6 100644
--- a/include/uapi/rdma/ib_user_ioctl_cmds.h
+++ b/include/uapi/rdma/ib_user_ioctl_cmds.h
@@ -172,6 +172,7 @@ enum uverbs_buf_qp_slots {
 	UVERBS_BUF_QP_BUF,
 	UVERBS_BUF_QP_RQ_BUF,
 	UVERBS_BUF_QP_SQ_BUF,
+	UVERBS_BUF_QP_DBR_BUF,
 	__UVERBS_BUF_QP_MAX,
 	UVERBS_BUF_QP_MAX = __UVERBS_BUF_QP_MAX - 1,
 };
-- 
2.53.0


