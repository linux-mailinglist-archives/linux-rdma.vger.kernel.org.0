Return-Path: <linux-rdma+bounces-19565-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4M+lIlIU7mkxqgAAu9opvQ
	(envelope-from <linux-rdma+bounces-19565-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2026 15:34:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D21A9469FD5
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2026 15:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 110FE300AB0F
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2026 13:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FC935F5FE;
	Sun, 26 Apr 2026 13:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwcdcPEg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EC419CCF5
	for <linux-rdma@vger.kernel.org>; Sun, 26 Apr 2026 13:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777210424; cv=none; b=ja9skgv5qJpQuWoTHbs3S/ZwGVCteA+px7csdjF3CVm4vRwf+EKfEpQGyN6MeVI910J9thdWy8llKJxUPQTyFmaDKE4pBVhH6JbkDIYFvmg+dd+mRjB2Rj3hQPiWIHqwz9ffu01OR1rU7RQiCqZqSgv6uIx9nRsS4WkT8GTapHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777210424; c=relaxed/simple;
	bh=GeEu6AP7RSVpatJkLiv/ocVI/gdxJEDtevb36X7eCX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iVjFtG6dNnqgf7j81zZUg7XMRoBziQQxCuJR/L+BKfeB7QHPpv6fhBO9mny+taYtr9bRSiWJ/IcGdgGtbOObCGZIS0N16xzExGbbPwRryzFwDIm6dSupZrSfSD8zbf29tCXFUlkYym+zZQQCPduIz2cWlhnwF4VC2ttfaH1hxTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwcdcPEg; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso65680385e9.0
        for <linux-rdma@vger.kernel.org>; Sun, 26 Apr 2026 06:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777210421; x=1777815221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crKkancr7sR8go7iy0R0NBV97WuE5NeC5bAHOLt78ko=;
        b=DwcdcPEgpAPEat812nfkIDJZEuidRhXrYnzWKT6W/iWrOpuqT1lcntLPAZsyaxdUJy
         ABiuXvv9EGdR0kzT9ptSd6+j2JTBgZh8/E2YGujIk6Sz99vZQQeDL9TV9w9+3TOAM5GW
         WDX3ZoSZNpoXa+FKhOpDtuSAWTkrw4Cy8bpBGxe+K2tXsl9mif28GEBG/Zg5cjfzdiq8
         ranPFvUFZQ98yOZjfcw55xYa4jSGqmM2cjFCcDCrCMHIVdVJ/WmscDjvDBu0SmjUIjjK
         cEtbfG2oyJApy3HYO81grDcZrJC7mGonDmWiilc2uto5+CLnDcejsAoc4YXWXOluwgdM
         0+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777210421; x=1777815221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=crKkancr7sR8go7iy0R0NBV97WuE5NeC5bAHOLt78ko=;
        b=gF4RljSzPdUmNUiaK5DRXJrxrobVBTWEyIIFtS47aEr6vpFNb3TvzCi0O0Tb6fYsmi
         Lkq4Thmsdn/t6Lr4qvbHq9B59lY7WlnQkHE+JuztBnU4bwaBOrl2zL46mkMtRv2Pk4TV
         EJERQ8fjX5K0CD4RcFTbnTIK42+iSv9hqRdlA51CayXnbkVkEJN5w9Q5WNJZp8gCbg3j
         IPQ1R8Uiqjdufgn9UCCaFhOTk2jQcD/BSsibVCNHncKeMQ9ofSF2jzUNsQA+ynxGsVz7
         HSsM7HNOZUH8wtda/ElSTuwp3+AF+1422abQ94HUmqHPFPfxkWRsYHmkPY3am/b374lY
         SAbQ==
X-Forwarded-Encrypted: i=1; AFNElJ9HkH+2cWrXukXjYqEcm3KGKZCg0l7sw4y+1Cm8curkolBbayl1wgyqiDx3e6noML5bltpb0qF4Xi8J@vger.kernel.org
X-Gm-Message-State: AOJu0YxwbpHOrkwilvnvY6VKMQRZCvqZX6PcA2Eb1hOHPstMkzRpbZSX
	MrZbZy0KePGG2E22JmxKxmQffU6XJMaMqLG3EB/TI8s/3TJLqg4CcKu7plZoYKjj
X-Gm-Gg: AeBDiesZgSGrZiOhvYszKwVyXl0/QrJPANdiiwNrslNNxuX/DM9FKr9u4fBtaakLWgC
	N3WZJJvFdj2pFJiYJh3UprJZLgAC7dR4tjYPdjNEX+OE0Azzv/4BqrRouxmHmFQ27ckdYoYR3lt
	wWBlLakmwQKw3sm1R8dZqY2dgga4IWt4+QgC0PR9qgSfHRhHxF5b8fWFrYiQRyPtZ3nLnx8e0vC
	sXVc3PBTrZVv7l2wDaW70pFUui6urkDPfgFTjPvlffY71eQ+To3UFJ0tF8E59MtuC4LWkLxGgnG
	H84ThNMDD1mYYrFDZC37ExypIrzqH5ikPXKfNTNw6lYIdlujXjmrpYu2dIHmaAMgYBV5QCpYqPJ
	oQLy8Eun97qE5JTol9QZFdh5Fdj13cUA39kUzouw7d32FILTkAqSi+WBEdppUHRJNRGkYy3wZ6A
	FhTST417LEBmAb715zO6kBRGI+VMS6JEwaT4bxccj+HDWRw930AmeLIOG/7b9KuOpZltOHUUns6
	uFI/qmIuU/RIwJW+C+w5+5hI51aFSkmxT9MJH5nJqV2AmSz2t3d
X-Received: by 2002:a05:600c:828d:b0:48a:568f:ae8a with SMTP id 5b1f17b1804b1-48a568fb048mr340987035e9.8.1777210421479;
        Sun, 26 Apr 2026 06:33:41 -0700 (PDT)
Received: from SD.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891cc7b2efsm299107815e9.0.2026.04.26.06.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 06:33:40 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: michaelgur@nvidia.com
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	prathameshdeshpande7@gmail.com
Subject: Re: [PATCH rdma v1] RDMA/mlx5: Fix UMR XLT cleanup on ODP populate failure
Date: Sun, 26 Apr 2026 14:33:12 +0100
Message-ID: <20260426133320.22378-1-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <77145fd5-25be-4791-973e-b9e111589763@nvidia.com>
References: <77145fd5-25be-4791-973e-b9e111589763@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D21A9469FD5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19565-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[ziepe.ca,kernel.org,vger.kernel.org,gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Sun, 26 Apr 2026 at 12:19:09 +0300, Michael Gur wrote:
> The loop already checks !err in its condition, so a 'break' is 
> sufficient here to avoid adding a new label.

Thanks for the feedback, Michael. I've sent a v2 with the 'break' change.

