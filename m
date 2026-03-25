Return-Path: <linux-rdma+bounces-18633-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GL2tBJL9w2lXvQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18633-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:21:54 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5B9327D23
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6DA2E31216D0
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 15:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8097F402440;
	Wed, 25 Mar 2026 15:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="RYDLxOdE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E87402421
	for <linux-rdma@vger.kernel.org>; Wed, 25 Mar 2026 15:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774450875; cv=none; b=EeFETlekaiKHc0egadEI8h5Gdq4r7Hz0J9SikxBIuG7GMMvmZ4gtz7i62D3w7j4dXGqPOBYXLWaQDsFELS+NcDtMzCEaUMT1be2wsIdLWXhbNsgWDfbcKk/7bTF/jOWjxlrklpdSr55UqFyAybk5ksAyhKDhA34J+wBSZKzQyMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774450875; c=relaxed/simple;
	bh=Xt/Dvivh+vDqqPRzhmuZnnm9gT81JR8M7K2cCVDtrFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Knv+IWZoHH9FpN/VyOo0f3bS1shSymUspAAphChwXJ4AbbQfhEt+q5FKeROUMmRH/ivKXnAQtA1DFEl9pk7lGv3bAsDhVpP58oh1T6j6qunrfYlhTNqlbMWjVOsShWp7gkRxLpGRG+6i98CS1xcRcZCrSmRAFwMa5X919fKgfks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=RYDLxOdE; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a27dddecb0so7349e87.2
        for <linux-rdma@vger.kernel.org>; Wed, 25 Mar 2026 08:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1774450872; x=1775055672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YglslCNUb/5vJzBxJxGmGGJ3+GP40hgXA3HfHnbNJs=;
        b=RYDLxOdEE6MYWMPwhnq0u3KHGx36L/HI4Bvy6PpAOv0hgAEOV1qdchJh9TFqW2QXgc
         FCOz78krLdelkk6FptcQPLu1GQg7Rq1beXNB7sxzkxZnN8omE0swH2NC6DwYd6yVRQhk
         pIjuaA2UvzU03msAQf48k81WSJieqTTlMzpyEc5aWDi+/GhfKNtC8zx9puKGgFgb/3B7
         HJAr5KIR4jJbbRyx8Ok6q3miY7WuU5ySgeWJV4vSEVyKOLfNTXPVp/0F0UQ30B7qGZLO
         kcdNSE58wmb4IFtiMcvnc3MLbyPg6I2Nk2AivsG8a/LBwdFH53TEYvRiWbjbF9TL+ild
         1ZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774450872; x=1775055672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5YglslCNUb/5vJzBxJxGmGGJ3+GP40hgXA3HfHnbNJs=;
        b=SLS3cBVhjfSm2aXBWwK66M+kZ5gyaOYavzOcI1HHzRddHHJDed0F7ANXsCqPjJ71TG
         6L+ZB4pvJ6gYuGkdhRuHUjxsPhNB6SRMnNeAjj0OXm3uvSIcOvg0xtQ1vaybsPWbsoui
         BrQpW7vb3w7KBN5YmFOc6mxckOz0eoJ6Pvv3HTVnOwfOX2A16W6gk1MxGT+U1aPYD54Q
         OZlBjlAZBpcHQrg6Oykddf+PPhxITCHB/u6Mgm4PMyMpa3HAf4LLADXTPIheJkzIk8gB
         USH96gYL0oPCJurcrMT9PwzBeHB6I78PFGkhIjwTZgnXoJ/64M+JltN7CWHHeCwEGjFk
         DiQw==
X-Gm-Message-State: AOJu0YzxnpAb5InREc3k6KSxAQ4y5pYYBmDZUNs8hJNNB66DkPB0q7oJ
	Xcay1klYqdAbggWh4oZ1nDUj+SbyEDo2BivhBps61vLGZx6XFDTnukO4tcsbSRerHBh/ihBzTGt
	9SALpX+s=
X-Gm-Gg: ATEYQzw7A6GUuiJ7unsrE2ko628Zt0ePAkupA74Opr3Jg3vJjRM1/h4/Qi5/FikgguY
	1I+7XbdcDxJkPRQVKCNz9FA5wv3nYp42KF18zAeUk/XY03Vc3CUiAFxIw8gdupUAT4WkpRiZxgB
	j+BgIJhMiXnFBAxqVZ+eI2huGdV5eIC6rVDJpYEcELP7d3vRA/w2pjQZsztnLXRGFA0MHeWiDD4
	QK0aUM/9KSAW4tETBrvvXrlaC4ugJbyFvQu6FAx8T/M/MByUliAx8p+fFxxGYJ/DJtnMncVhfjb
	hfV5HTd/zV3pb/BbwnF+LHtD+rux8634FmW0Hmb8zoI67tcj0l9f1Ov1uoeUTSazmWFOxlViSlT
	3tp3uHAr/pmQQy3tTIIArBstJmZoUG3zcaci0QEfEi3x2x2dvPL6xONNhX+NjfGIzDZ1ql0eyhu
	aMRkg5dpjbIa8LM/NgClUz44sQ
X-Received: by 2002:a05:6512:3b8e:b0:5a1:3b80:8c28 with SMTP id 2adb3069b0e04-5a29b975e3amr1457842e87.10.1774450871807;
        Wed, 25 Mar 2026 08:01:11 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919e708asm254965f8f.36.2026.03.25.08.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 08:01:11 -0700 (PDT)
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
	wangliang74@huawei.com,
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
Subject: [PATCH rdma-next 14/15] RDMA/uverbs: Add doorbell record buffer slot to QP umem_list
Date: Wed, 25 Mar 2026 16:00:47 +0100
Message-ID: <20260325150048.168341-15-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260325150048.168341-1-jiri@resnulli.us>
References: <20260325150048.168341-1-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18633-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[24];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 7C5B9327D23
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
2.51.1


