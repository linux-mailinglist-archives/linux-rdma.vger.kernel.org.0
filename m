Return-Path: <linux-rdma+bounces-18866-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAkqE7FDzGm+RgYAu9opvQ
	(envelope-from <linux-rdma+bounces-18866-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 23:59:13 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C61372425
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 23:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EE27306B163
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 21:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82F23EC2F4;
	Tue, 31 Mar 2026 21:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTZFMRjI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6699745348D
	for <linux-rdma@vger.kernel.org>; Tue, 31 Mar 2026 21:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774994269; cv=none; b=sP7uOSUKWo/1r/mxinDlHOS9am1+EMjKufDSrQdmJYb9+Giw4HeWWDXWGFhy9zIk9brPNCAGQmhUbCzijm7yOlTLfqiK/bk7drGdqY4hXgmZoCqvkWOuYGqiIajimxsggnIG7iC07l1iumUHcXgBT1An8yxVf9Kyc5KG5dNvHtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774994269; c=relaxed/simple;
	bh=niV1ii6af4nDBIeDr9Af/Z4k/iahNh7hfpkRVInzAvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U//JWzr+oR4v1ueooGEZz48tIpsu4eplcUkU1N6fZDm6qq99eSw2+rLQvCFlUZyb6R8KGN08/cxoF7JZQ1rGViZHRAtxTF39+cynX8w84iR+YDiWR1jYGxOxICLsBq2OFhaZ38ASO48x4wlwZAgax3L0vaTM1Qapv8IbQJUWVPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTZFMRjI; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-486fd27754bso60578915e9.3
        for <linux-rdma@vger.kernel.org>; Tue, 31 Mar 2026 14:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774994267; x=1775599067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=niV1ii6af4nDBIeDr9Af/Z4k/iahNh7hfpkRVInzAvk=;
        b=YTZFMRjIfs8AgAWLMM6S834OnJRnUGeUwBQnproxXX8Icjp7o55bFnktP9Ee3zUZch
         WBHkK1AZGv0D5/U9f8NFBZS3azElFdFIFwmzVeoelmMI6NY+fXYE+XGhdYUrNxQkuFGQ
         CR9GN+6MoR8p9h7ZYy69RjIdoHcBtSjtzYNqOkH9Y/+0WkuWvc1+TRRKRYI1k+DSQNqY
         F3a/Q2jETWFNvF7RX5vVHQ/r0g8s5Iu9mprsZjUktDAP6XxuegL0Jz+5TtT5XYOQjrup
         tS/0ytME8lKPilkUuT1Um59rDdN9i3FdoVi6UKWv34epeHCZOx9IrSFXkb3B5tIXRjdd
         bREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774994267; x=1775599067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=niV1ii6af4nDBIeDr9Af/Z4k/iahNh7hfpkRVInzAvk=;
        b=WN7VGcN5VYuJ2hu+AzUKl/sBSbHE7e4KC4mOjC0etqXQqnVVNnpy+BC02wZZ03Ftxq
         zG6dwScqYGkRSW3F4C7VOlTumeexcKaNa/TF78CdXH7hgEx/eNaIUaNbwqg/bOPgT6j5
         suLG6Dk/7KNeP8W/VR9grPh4LYhngcLZWUCTglFK5Xy0BHkkNHUAeXRA+3RmXCajmCfn
         wmd1BqIAVqb+zDELjU6KcA4Tx/qjG+yyk0J+dA6KTMxDqHOs25lCBxaH7G42GFA1X5gb
         LSeE87QAxeyt5148uqPhGzW5NxThNxdTdAP9/w4kEFmdEzoz1wIEVq62+y+MDXXCvCVD
         udjg==
X-Forwarded-Encrypted: i=1; AJvYcCUBxvnSyRStMPRKrK9uFdxe3UjEMQrKh2Cprl0s8E0PUPDPKsaY3nWTkERPTZIwE52iLl/VY9V7uU06@vger.kernel.org
X-Gm-Message-State: AOJu0YxG8d80GDtc1v4A1g8JA9vANdIcxTbAlEtxqpZSgMnEtmcRz5SW
	kZBwiozF6oPu/FqE6vk0GrIus03W4qXjyzKZg8Mzya50NVNrIZD5UxZ2ZocofqjG
X-Gm-Gg: ATEYQzwC74XLC4dwHv43ExDlIitWdVJSqqQv5wn59PJrbajHe00YKNT8ChoqltT61ZJ
	p0mZaTnGntwct5Pb5XmpVqGJMOGO411sKyVowkFZX2bp/BQ3BfsEQ4RborSqmyqhEy3fkeqiS4S
	74ebb374NZTelBmxpmmb05NdcXfPzISj54/Zul1Z+m959GfBXhAnGNPIbV8flfkiGWW6iyAm9O3
	bv/0hZAPdLEH3/uQ1NjtMfbgBDq0Cm/XfT1ey5HyIGPxZ7TtEq8SxedcCnGncPHPo794vhJc/ic
	ZOKej5wmCu3ZMyf7UFLtMqCuxMkrbWa6RtLKzbI5B5vmH+vjvKCEDm5y7+p0YTulMqdMI6gGSPF
	G8U9VFWq8EUi5kHNLMxElxE6S1rfpDynGSLCn+gO6s1/kBydMoC2npRZIRM1ykdMouimlCzauBQ
	xSbEFahiKHk5zuabgNi7hRRV4izcuR5M3W9Q6j1ldX1tgAO9RJr5t43hI+Rzzw3F1BaNyReUE7Q
	YaD2dW02KOhoxg+ogGC+F/P1sN8vfV/SHvVXW8C0tI8DXO6
X-Received: by 2002:a05:600c:828f:b0:477:6d96:b3e5 with SMTP id 5b1f17b1804b1-48883562a22mr18501875e9.7.1774994266592;
        Tue, 31 Mar 2026 14:57:46 -0700 (PDT)
Received: from DESKTOP-NQ2T5I7.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e843a55sm48777715e9.12.2026.03.31.14.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 14:57:46 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	prathameshdeshpande7@gmail.com
Subject: Re: [PATCH] IB/mlx5: Fix potential NULL dereference in query_device
Date: Tue, 31 Mar 2026 22:57:36 +0100
Message-ID: <20260331215744.17039-1-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <202603311604.GD814676@unreal>
References: <202603311604.GD814676@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[ziepe.ca,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-18866-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B1C61372425
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 10:04:00PM +0300, Leon Romanovsky wrote:
> Kernel-space callers don't use uverbs path. It is solely for the
> user-space access.

Hi Leon,

Understood. Smatch flags this as an "inconsistent NULL check" because
'uhw' is explicitly checked at line 967 (if (uhw && ...)).

If 'uhw' is guaranteed to be non-NULL in this path, would you prefer
a patch removing the redundant check at line 967 instead? This would
align the logic and silence the static analysis warning.

Thanks,
Prathamesh


