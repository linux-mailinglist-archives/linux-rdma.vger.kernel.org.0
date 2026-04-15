Return-Path: <linux-rdma+bounces-19363-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OkPBaLj3mklMAAAu9opvQ
	(envelope-from <linux-rdma+bounces-19363-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 03:02:26 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 827833FF6DB
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 03:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A0AC30B342F
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 00:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353EF28BAB9;
	Wed, 15 Apr 2026 00:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhYoFawZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F232C859
	for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2026 00:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776214772; cv=none; b=k5Fztdhuaz1c1EP9Wq8wGtueefD7TSlzZ0YiI2G31Mze+8ruAbE3d0g5gF4F8+TaPtdxmMfD0czvwUOrGcOUhGAx6bCdn6Wof1f3ShHI/guQUdVCGxyvq4+g+/xe8Dd5YXjD0jKW/yNVNWt2gMcRQrdyajVCVSCEMPFO/ctNSbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776214772; c=relaxed/simple;
	bh=hu8l1GA0uzru58Rmpw5PcMs/L5p5Q1/QcQv2mZVt8G0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qp8WWFmBwajsBfJQvdjaaOhfqxGDFehyxtczdi6KXjC+++5ipFxdV1DCWDv4f2W4hlakf4hzG+mUj58l3l3W1mbIjXcEFOxBJQZrZBxvMfbQWhsLF0s/aUuYNyoT9SHc0XcA7NzpKYXQ/5E0294tiasr+ijs17/Y9oovgXOHPSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhYoFawZ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488b8efed61so60890805e9.1
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 17:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776214769; x=1776819569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFmv1mKwMiFFTS4DkOvN//aBqX95elrSeV0jNqSLgrE=;
        b=WhYoFawZNTBO0wVAyFC+6MkS6Bpvfa3xuDeNiwxwvOdbN5WD55YlBEnGkKH7scKWcE
         LlDMO/dQI1pjjstK10jhiRfSct2nfPpVQ8kJzFZTp9U2lWGWzH2OsIZe3yTzE0hsIP3s
         44PVv8HWjJo38gxxgYuBFwbXfTks2xOOePPKJ1jghQxLg0XCoMEhhFAUd8hQP3ubyKrq
         sBcsu98FqaE188lP57PPPQfv/QuJzdIYyDdeEONrwZ+6pQ5oKex8redvP7YMGNJd8qGM
         qoV/yRxr8t8kjFvHHOpovjpUeXLjJPmgDkMu2BQAH6kOK0TtfdCmdwIZy7MA6fN/cUGb
         qRWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776214769; x=1776819569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CFmv1mKwMiFFTS4DkOvN//aBqX95elrSeV0jNqSLgrE=;
        b=qXGxl/lvLXOJ7UaLCfBgMcy4V/l6FPg8e3OU1m/SwPie8xkfqB1zdY7fv2YgmRBxEa
         mSEarblNehUNN1eWkoIsb0Fs5tLkhuJdQii8G3MH8LB/Y3gGSKELtFZzPJM4fEi4/usC
         ouXmQsbblulYWova1bA1NolYw6pJyZuM5dtfynOJ0Ghl4k6qjJPShIEceFalYkeH1qo+
         G1W+BA52mDpQqVnW1S5Vfon7VuHC0lcHO8FcRg/uipaJO0dAZcOX/HVZNnBDEJxoWJfw
         Ig+KJ8VeyWDcfJ0fNEjisLKvMQwXSsz/GjyMAW1LOAxynEBCmVuTrNnOX19hB8PMf1k5
         M0PA==
X-Forwarded-Encrypted: i=1; AFNElJ+DqDIB4pXAoS8uXQRnvC7jx8P4qwqT4vb6+d4gfFi+rPdqVXycoaH4W76O4sk0TnUVLaT3xzu4wJpB@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9PmZIiokGHYlTptBCOQdswlu7+SYk10wb1Wp9oR/nQBGqm76g
	aCfv7BjC8v3PGKhPgPspgUzRyZ3EuxLfgFZnwDRSIn1S8htYghkB4TiD
X-Gm-Gg: AeBDiesXMMGNY5pqdMNoNbj8QS9OxFPzBwPkxVPlbiKJjuRpuPWmb+gf9BDSALdZOQj
	BIFCOpwR61V7bS0xfnRjIHT8W/olRK6ej4Dt8+0d0Y6jm/Kd+wbSnIHKmfIuGHAbE/7V3sObivn
	CzpBZFAh6UFmxAiiLPoTxyTJSNOe7xDL3Nefh6pUzfAJwpI5Kr1G5fy0g9qm/PQhaRa5X6fte9T
	mD3h4R72VRJMv8E8HMqhb0SlKIle8rqOyrDDxdYx4hOX5MCj+NRKm/BiKqiqHdht+QeUsMZsOmr
	h33U4iUjRJl+w+pvffreub+nNUfzMaqQunDawVPPyaFe8J2LSex3a2uP8Ae12zcO6d3Zs0rPexS
	W/DntavZmBOb42hz168fVlKfrw21CX57X0rihJ+YEr179DajlXLH4788dHpVe8nvU5Iuqq7aqcp
	Dk4GwUH5hcMKMhlV/EZcjX+p6USr7yaB5wNdn/JDcADgpg2KobXLC19/3oivhbNjkyrgOMdeeNM
	Iz+FwaYnfY9Z70hJcizLtdM2loi7Z74mvnVFk1BXg==
X-Received: by 2002:a05:600d:8496:10b0:486:f893:56c6 with SMTP id 5b1f17b1804b1-488db8d16aamr140798965e9.10.1776214769130;
        Tue, 14 Apr 2026 17:59:29 -0700 (PDT)
Received: from SD.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f0e9a770sm5972445e9.19.2026.04.14.17.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 17:59:28 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dledford@redhat.com,
	haggaie@mellanox.com
Subject: Re: [PATCH v10 2/2] IB/mlx5: Serialize force-enable state and preserve loopback accounting
Date: Wed, 15 Apr 2026 01:58:53 +0100
Message-ID: <20260415005923.34808-1-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260413144155.GI21470@unreal>
References: <20260413144155.GI21470@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-19363-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 827833FF6DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 05:41:55PM +0300, Leon Romanovsky wrote:
> On Sun, Apr 12, 2026 at 02:18:50AM +0100, Prathamesh Deshpande wrote:
> > force_enable is shared between MP bind/unbind flows and regular loopback
> > enable/disable flows. MP helpers updated force_enable without lb.mutex,
> > while regular paths read it under lb.mutex.
> 
> Yes, this is intentional. During device probing, a device cannot be treated as
> both MP and regular at the same time.

Hi Leon,

Thanks for the clarification. I've addressed this in v11 by dropping the 
MP-related locking changes to keep the intentional behavior unchanged. 
The updated series has been submitted as a fresh thread.

Thanks,
Prathamesh

