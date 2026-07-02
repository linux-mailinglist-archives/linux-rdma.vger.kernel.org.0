Return-Path: <linux-rdma+bounces-22717-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YLHvBp+cRmqIaAsAu9opvQ
	(envelope-from <linux-rdma+bounces-22717-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 19:15:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C706FB293
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 19:15:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=oXzgXsVZ;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22717-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22717-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F392530696C9
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2026 17:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3030533A6F2;
	Thu,  2 Jul 2026 17:07:24 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BB633BBCD
	for <linux-rdma@vger.kernel.org>; Thu,  2 Jul 2026 17:07:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783012044; cv=none; b=CNUQkUQ4yVhHkrR/h/jWFuGxgjnOSb3jhG6WJxRQyuHTCIJ8mS4LypGpRzyvJBGI6TJN/UGnvUxITru7wuV6WdihUymAzh7x3j2fgYN/pssNxRwXApO+5x1CyFvghBNpJictdafjPtq/2i4wyYpXz7sbVvELOGvlEXjitTamQXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783012044; c=relaxed/simple;
	bh=fTKwoA9mpT8BMOzys8v5E9z9suQrC2PwkoCINiWDc0E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dFomhHRp/5Qxm8Wi3Fu8tfEhZEp1OkOv6Kd2MiNXxOyFSkAPiz85vAzsMJVJhLoivbVdTREdgxjtgHogio6AJL/APSaIRIIihEYYs/Ztit7VzqZXwEDlZaYQxq7p48hyNosS1+vSAq7fT3gahC8mR19QydB3RczQdO4ViqHIUCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oXzgXsVZ; arc=none smtp.client-ip=209.85.222.202
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-92e8004d60eso173022285a.1
        for <linux-rdma@vger.kernel.org>; Thu, 02 Jul 2026 10:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783012042; x=1783616842; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gnC9Whs+b5LO8DpvowhIrVoV/wj31cv3J8vOLGiiotU=;
        b=oXzgXsVZgR66pWmOw/5H5DrVb5s1oD7euCmkybKm3+P9/L9tOzS8P7PY9xC20Ay6LK
         d0xsQmqSkJ0lNHLnbyFiXv2T5MooXx3p/X8mOyrbjYuOevxvQsV/rjrVhPKf2Rh9q8bb
         UoqNY75SDiPI+lFzAv/5Ta0/zoRdtmCUFaLh77gLpcNOZXbeITp4CLCZF/Bm++MBbaPS
         2mpGOZzkIdn3T7wTqPEKCcDyQCSZuAN5KnsqSqULvQGiLLHxSeXCirTU0x7ZB5OWDDEu
         L1v8uAY7+yEmgLuIbVr4A4bzkxLyEaRZACV+ZAzNeCeOV1p7DcSpCz3bsqHAxIkVncx/
         BMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783012042; x=1783616842;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gnC9Whs+b5LO8DpvowhIrVoV/wj31cv3J8vOLGiiotU=;
        b=WAE/2laequrIAaoPipaAykh6keH+woTQSkijuLrlxV3Wmt3C0ULIJsr8kglyh97O3/
         7epkwFJt702WVlIfRM6S3yWOtoUVzZD1mx3OVaF06PSYFylj3U1a33UVu2lhurAimnTy
         u79c2Bvu5UE25mAXDGrOgkngrfCxdW2L+7mOLeoGdfwyTXGq1ElUIPz5oCtnolMYwr0R
         2NvZTPjAYtFhxbPsdsIJ00iFlRP0gDZM/hlCqzk++FOnO1hwyv3VACB7O0ZlyFtXi5BU
         KHlTi2pfmUTMPyJVeTaLimOAOzRKy1wHpvg1AF2fVTMj9yRmVsRNkR6smB99x5yRYXUH
         a5Gg==
X-Gm-Message-State: AOJu0YxRRRBJPTWHdGEN3BJxzv4aNHKzxshGDrXi9ihq8X3EbHp11CdP
	s5X1SjPvfPpz4MKSIJveO6EHijemoKFHgk7QBS44zxpDrsQDmg+NDaUTAcoE+SryazLIk0BF7LW
	ZkthZgv1zhA==
X-Received: from qkntx6.prod.google.com ([2002:a05:620a:3f06:b0:921:953:afa9])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:1794:b0:92a:3679:7978
 with SMTP id af79cd13be357-92e7afd903amr826247285a.18.1783012041575; Thu, 02
 Jul 2026 10:07:21 -0700 (PDT)
Date: Thu,  2 Jul 2026 17:06:52 +0000
In-Reply-To: <20260702170652.4159201-1-jmoroni@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260702170652.4159201-1-jmoroni@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260702170652.4159201-8-jmoroni@google.com>
Subject: [PATCH rdma-next v3 7/7] RDMA/irdma: Enable uverbs_robust_udata
 compliance flag
From: Jacob Moroni <jmoroni@google.com>
To: tatyana.e.nikolova@intel.com, jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org, Jacob Moroni <jmoroni@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:tatyana.e.nikolova@intel.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:jmoroni@google.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22717-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 96C706FB293

The irdma driver has been audited to confirm that:

1. Methods which do not accept udata input perform an explicit
   check for no (or zero value) input.
2. Methods which do accept input perform the correct validation
   to ensure that additional udata beyond the kernel's current
   ABI definition is zero, and to enforce the required minimum
   length.
3. Methods which do not return udata responses use the proper
   helper.

Signed-off-by: Jacob Moroni <jmoroni@google.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index d8374f7afa87..99742e7c81f3 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -5555,6 +5555,7 @@ static const struct ib_device_ops irdma_dev_ops = {
 	.owner = THIS_MODULE,
 	.driver_id = RDMA_DRIVER_IRDMA,
 	.uverbs_abi_ver = IRDMA_ABI_VER,
+	.uverbs_robust_udata = 1,
 
 	.alloc_hw_port_stats = irdma_alloc_hw_port_stats,
 	.alloc_mr = irdma_alloc_mr,
-- 
2.55.0.rc0.799.gd6f94ed593-goog


