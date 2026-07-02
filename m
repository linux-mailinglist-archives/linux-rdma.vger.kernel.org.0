Return-Path: <linux-rdma+bounces-22711-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qpWNHL+cRmqRaAsAu9opvQ
	(envelope-from <linux-rdma+bounces-22711-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 19:15:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B586FB2B0
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 19:15:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=ocucxLNH;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22711-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22711-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 037D13026ACE
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2026 17:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6660318EC5;
	Thu,  2 Jul 2026 17:07:03 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C782FC893
	for <linux-rdma@vger.kernel.org>; Thu,  2 Jul 2026 17:07:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783012023; cv=none; b=BPUlRF4MCVLvTSOO0hkSIYckJDddvE3qnOgvuF+6+06/JkZeHR7j3uTDVfpjgUHalanhPJPYf/6d4c1kbpmk2CXgucp1lU7A0dYAt8d2FiCjzBb2Jji49OLW0VHLgmU/280MbQqeC5V6qjEBnXzNyLCFbsSNitLvvmQNZjOTy1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783012023; c=relaxed/simple;
	bh=BynWh2JLY4P8cn7GbMIj3bEO3PRgJpvnxa73040W9Ss=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jP6z/Q/MaE0wdFvwHPFoFxy3HwM6ejS+RnFsHmH81bmeLXwAHMCHnr3DS+KU7qvxlfQZopuNX3qnP2Ftmj/ScvaysLWTKx4fBy63OTxTSjlalXGoV/cdCdVSfEY04OWITRS6HA0EW3BvaqiN7w7nLJem93ZpKhcgtoE/Ul4GY1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ocucxLNH; arc=none smtp.client-ip=209.85.219.74
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8eb8914e651so41558456d6.3
        for <linux-rdma@vger.kernel.org>; Thu, 02 Jul 2026 10:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783012021; x=1783616821; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EHcPrOG5kZykXgBl35CPNR3aqpykRINfRJuhwb2nlpw=;
        b=ocucxLNH41DERSXO8feFajVpXaP3ROLldmCkQGpOIIPyfdalTk0WaanW2wLy/zn73z
         yKgZyEUWGNHAx/R+1MMsBWsGTHJUNOuP1HO0vjnlRJLqfqhmV173X6eb/2bYqYrdgdzl
         u/VzKs1jjR5Ia7ejJfOA59RxBGx6bGp6EEGJhJr/B9l0uW0Zl+Pz8nniBsulApCRPjQ/
         Br46DtWhmIS7WjsHwXWp54r4qCiXlxmVkciqU4hv7IQV85MrXak+yxgvpRcrfK87d7gx
         voGKYb8rK79oLge4JGDcaQEEWO/hgnI9Ed+Wlw0h9sJnWVIi6ueBwwYcvVbRep9Tz0FZ
         JjEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783012021; x=1783616821;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EHcPrOG5kZykXgBl35CPNR3aqpykRINfRJuhwb2nlpw=;
        b=Ie+m3BdDZrks/AMD+GK0CF6nJxJNgxoT7hj5PdmrFQ0jUcG+m5EJG3PSP+aZBloGCc
         nD+DlZIrrah6wrnqUjO6Ks1R3TRdXDfUOVHdXlO+a+31t+Hfr6HTSQ7ob3gmZr1a5QeE
         QV0VDnyT9o+dSne7DGasu5lcM9MPrzGQXCcX68YTwaNrmMJ4P3UHTYFnaXVnm8ykIDLM
         enxLEtKUf3VvBydXKw8KtrKDKWIWf2zq7V7JrBFTFMkPEvT/JEi1IgPennJthlmZr/zm
         IV9SiHHuBMqtrjrYFYDiluAZa3Cq4nzFPoxGuMNWmoFZWu2kjq5rf9+xh0I3CPYzgfoW
         AH9A==
X-Gm-Message-State: AOJu0Yx0KnZj9HmNLjR4Dt1NHmcz4JcjJLZNqt0LGSl0Q9QBjtsUDMiY
	8CQd6cUyPt4Qqxeg6Pr2yXLNFRqcWOic55USmZn1PM4H+Pr+xiE3+USu+5/8mWK7XJYsc7uqzxw
	GLKIVrNvo9g==
X-Received: from qvqv16.prod.google.com ([2002:a0c:ed50:0:b0:8b5:874b:5f00])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6214:1d2f:b0:8ef:9806:ddaa
 with SMTP id 6a1803df08f44-8f424cb88d0mr90794666d6.49.1783012020911; Thu, 02
 Jul 2026 10:07:00 -0700 (PDT)
Date: Thu,  2 Jul 2026 17:06:46 +0000
In-Reply-To: <20260702170652.4159201-1-jmoroni@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260702170652.4159201-1-jmoroni@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260702170652.4159201-2-jmoroni@google.com>
Subject: [PATCH rdma-next v3 1/7] RDMA/core: Add ib_no_udata_io() helper
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
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
	TAGGED_FROM(0.00)[bounces-22711-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 59B586FB2B0

In many cases, a driver op accepts no input data and provides
no response. This helper can be used in those handlers to
adhere to the uAPI forward/backward compat rules by failing
early if invalid udata is provided (whether input or output).

Signed-off-by: Jacob Moroni <jmoroni@google.com>
---
 include/rdma/uverbs_ioctl.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/rdma/uverbs_ioctl.h b/include/rdma/uverbs_ioctl.h
index 24fd36213023..80f3ba6663d0 100644
--- a/include/rdma/uverbs_ioctl.h
+++ b/include/rdma/uverbs_ioctl.h
@@ -1151,4 +1151,24 @@ static inline int ib_respond_empty_udata(struct ib_udata *udata)
 	return 0;
 }
 
+/**
+ * ib_no_udata_io - Ensure no input data and zero fill the response buffer
+ * @udata: The system call's ib_udata struct
+ *
+ * Driver ops which do not accept any input data and do not provide any response
+ * data may call this at the beginning of their handler to fully adhere to the
+ * uAPI forward/backward compatibility rules.
+ *
+ * Return: Negative failure code if the op should be denied, 0 otherwise.
+ */
+static inline int ib_no_udata_io(struct ib_udata *udata)
+{
+	int ret = ib_is_udata_in_empty(udata);
+
+	if (ret)
+		return ret;
+
+	return ib_respond_empty_udata(udata);
+}
+
 #endif
-- 
2.55.0.rc0.799.gd6f94ed593-goog


