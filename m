Return-Path: <linux-rdma+bounces-18631-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBKIJ0f/w2lXvQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18631-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:29:11 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2A7327F83
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0E78E30F1812
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 15:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF22401A2A;
	Wed, 25 Mar 2026 15:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="LxObpqNB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B65A401A02
	for <linux-rdma@vger.kernel.org>; Wed, 25 Mar 2026 15:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774450871; cv=none; b=od8QmiK2+uvE+fgoOMUixyHwoxrQEhOqu/c7KvQeZK55fLHxZ7giUODSv6pFwKhONY4X2vq9oTMinzaITamTAdiduZj7ptaavYLuu/IMENFKbYIWz/kq/hUefoU+SEcpA1/bQoVDft/wcn/KxBKQxBGDOsYUJP3SWLAr7CQ6QaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774450871; c=relaxed/simple;
	bh=LlUo113iz8agJUJ6Xhm45uX5H6GnNIjny5QeiJh3l4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BaOvU/DYueooCskH87Pz/f+gqVrB8Pe/3/gCPir28vIDUl31I5T9ww8V21JygwCIK0mx0qo1l1aYgp/F0AcUR10aLNDKWSKYGGu8AG2bJ8dqzj1GUKwCtncmwhlQznQcjqhgLVkeRfbLyLBBUgBzf+XQqs3bK3uoEcv9zH/UAl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=LxObpqNB; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-486fe655187so64256795e9.2
        for <linux-rdma@vger.kernel.org>; Wed, 25 Mar 2026 08:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1774450869; x=1775055669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xplmfTNOL5i380HSIh42Z+xFSWDKbGcrEUYHY815/ZA=;
        b=LxObpqNBWAoYCMuyfAEeuOv02H/Ekqtz6xcQWn8KEes2xEOTxrDjwqOWtj9TPDyODR
         I/NSuf3xov3SrJujTV/do2jjOwN0u45jq+V8m+TTkxt6jPcAIDXWR4iK3bV2wbOmXMoJ
         HbRMebUW5vNfx/mPjCk76tONa2Pe2v37ZseCuN688SKCm87899pE8IwNhbU0tWx2EKC9
         iBIMaQ+2MGG76GsXvksygac68SjUTYAcf6t12P0z2NgghVDmmn374ZOf/r/TK2PaRMFI
         1aleIqP8IeJHM3CDkrrmhSND4j7JOgJWuCaMnZsLdSbeMev8TsW/U0WmFLLTLZ8GzU5m
         T2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774450869; x=1775055669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xplmfTNOL5i380HSIh42Z+xFSWDKbGcrEUYHY815/ZA=;
        b=HTwADiO96IruPoyo9KTvDd4vzLmrfHQIvRrLt3wJuLJYXjJDyW7k+3uk+XyC/3gSTT
         pvME4ifN6qI/ACmXWBZzfAwKxCV5NyhR9rB1lV1z9BVa8ijWRDV6DRSrNth3BqT8PLmW
         eAmQVZ85ch12P68QOQFYH/HEMwFH3xUsRGoEfcI0TMDeRtVWZU+GdPhg0BcOb8i38GJS
         naxLXUgD0f91uXlj1Bn8PbmhLnwGuR9UNy/xDDDS1qEAvxFdOfuhZEOOTviciEyQZ2KV
         i7U6iP6MH1lH0+1fc929fkora7hfWQzu+Yu51BPF8ufhHTHocZjk62UrngmvtoFsfqt5
         T3lA==
X-Gm-Message-State: AOJu0YzcbufRVds0Njxh34uHNo21v+y8dtNrKcI5t0Ydqysy3dFkwOqO
	d3eBBvpWAZ6/r+ITuoyHLQM8uD2wOQKv0KUmi1HcMpOoXLy5IKYkBiDGU7fxKnWOtpMWy1YrFlE
	iFna3CIE=
X-Gm-Gg: ATEYQzzsCB8Gb/mehN+H4asK/0NWwkzhXUXZtbhJcNZ6N80xSLyhaHh51XMoaPnbS/v
	bmMXyG1sdh+HcZbapm0JNjVL6Dn5qxxlFRYTwcfjPkOAbm9wEYrvUBi9fki4tC4hfXhYYmKmaxT
	l9yuYI21DjoCzOc6+qweGeVrQ144VG10I9ETMsa+glP1weaGwlhNxkEJur8u+xf146w6pBZJ4fK
	8k0iR/H32NTk6pD7dgIAtg93+3jojo9KsQRK0yAbvoLXHiWt77FDwqRg/8LXjXxCx/LZSYlME5f
	9c4fzw6J6f5YYPjF1QZijKNwMxdxc1DgGpUXHWI1LbGvpbJweAQX/ZIRML9DKWYwe4p48ZJN8RO
	nDwvxznuEbPb0AuIFsZt3e+tvkxpVGrxXbg9iDZxdKx9nSENk3qA6KwHtbZNHCGEMn7igTJDDUo
	4LrR0IpAYS91A+Hw==
X-Received: by 2002:a05:600c:1d1d:b0:486:ffa3:592 with SMTP id 5b1f17b1804b1-48716071b2amr57656865e9.24.1774450868791;
        Wed, 25 Mar 2026 08:01:08 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487116f173csm163200415e9.2.2026.03.25.08.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 08:01:08 -0700 (PDT)
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
Subject: [PATCH rdma-next 12/15] RDMA/uverbs: Add doorbell record buffer slot to CQ umem_list
Date: Wed, 25 Mar 2026 16:00:45 +0100
Message-ID: <20260325150048.168341-13-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18631-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[24];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 9C2A7327F83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

Extend the CQ buffer slot enum with UVERBS_BUF_CQ_DBR, allowing
userspace to provide doorbell record memory via the generic buffer
descriptor infrastructure.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 include/uapi/rdma/ib_user_ioctl_cmds.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/rdma/ib_user_ioctl_cmds.h b/include/uapi/rdma/ib_user_ioctl_cmds.h
index 9c5d3f989977..26c2e3b2125a 100644
--- a/include/uapi/rdma/ib_user_ioctl_cmds.h
+++ b/include/uapi/rdma/ib_user_ioctl_cmds.h
@@ -122,6 +122,7 @@ enum uverbs_attrs_create_cq_cmd_attr_ids {
 
 enum uverbs_buf_cq_slots {
 	UVERBS_BUF_CQ_BUF,
+	UVERBS_BUF_CQ_DBR,
 	__UVERBS_BUF_CQ_MAX,
 	UVERBS_BUF_CQ_MAX = __UVERBS_BUF_CQ_MAX - 1,
 };
-- 
2.51.1


