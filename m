Return-Path: <linux-rdma+bounces-22603-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EemDC5XpQ2rglQoAu9opvQ
	(envelope-from <linux-rdma+bounces-22603-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 18:06:45 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2375E6E6415
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 18:06:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=nNeRJk+S;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22603-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22603-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 584CE301DEDA
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 16:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC05146AF10;
	Tue, 30 Jun 2026 16:05:03 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466292F1FD0
	for <linux-rdma@vger.kernel.org>; Tue, 30 Jun 2026 16:05:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782835503; cv=pass; b=I9n4xq3AXcQlZDe5dsZI2d2rfEsQNdpRen/zz+gOVdWZQN3lF0Gx6t6PTyLLHXQV5bP2hOzdrN5kl3CEoLJNOowmdPkmpyikmy6XGCJqbrwOkEm4Bch66szTvkuZFAuCjR2UAtGPEN1i1hU85tEJcEfjJAEcf1qSb8U8eaLDYUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782835503; c=relaxed/simple;
	bh=ih6Ktml5cXP93WgMAvJK05C+fvNYLHTTNSxCgon9jFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B+Pgu3JlKOHlHJJfwXmehdh6R3mfSbfPeJmoP6xMUNcRsIccJCmH1D+9RkeQ0zqIMG2AJVRiEHxpRcRkgAilnkOi02tFVHLItyScARW5sG7fx5uqcp0XKDESzmHoFuCMuCndehwm+Dk7+5nEORd12f+n0LIf+y3YHMsZ+LiZZy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nNeRJk+S; arc=pass smtp.client-ip=209.85.161.49
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6a19a5691bbso272eaf.3
        for <linux-rdma@vger.kernel.org>; Tue, 30 Jun 2026 09:05:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782835497; cv=none;
        d=google.com; s=arc-20260327;
        b=rPv+40czmw8U5vk2FAUwK+T/KT1mRjPYfCLMK56HpUDXwUnE3/O8xTJXSmlBMmGrH4
         clK0FltYgSw+n9eU7zmsZltban6hXh1iLvr6BKQ3NyscuYu87vDNT9ifRmJ6vB82q5LA
         +7U6zEyhajogHoRFpMsnbE24tBO8RvV3YupkGcl2XgYxkvI08n/i+wtWMyuRKEUaKG+2
         pNxV1I6EkfnRR0KMGkD0bN2re7Iqsuk7fVn8osgDMBILeLvONywCk3Zfl9nzmxPjJdnF
         vrX+ylemGJYZsII2ZqeK8DsiMBmqFTRhkZzt4b/8P+Az15dovjtm0SLUktl4TkIKFP08
         kKvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ih6Ktml5cXP93WgMAvJK05C+fvNYLHTTNSxCgon9jFY=;
        fh=BaR7NKjiyk+TINhSvMQ1iNFrrigZGK+kmaX+mWPhSuQ=;
        b=CFD2Q6ne5fuxEMkIC7iatquZOt3JNqW5D5HhOqK/XnxSc7o3KA8y9G4DuE4vIHVUFT
         63lWHpVKXXH4SPFtR64WE4LPCKu0oJBHStkAYnz8Eow6W3Xx45r56rcJQJQL5vBwJluK
         djO+iLtsvmbc0KX83ZAhBT58UQOZ67959wupJrI4yOteuy7eOfX0Erk59qnF4AEKa2rz
         9/alfimDDrx2leqtzpr/SHko09gnJ8BgmuQs6njzBBLp8VFEjfVppI43PvPk/GxFYr2f
         OkdyrChqH7ESJ7jhgYABK/6sOkEPK7WzHL2HWRAqmxXyKEX6pxgdAuJdrpoK9g3PeoS6
         HKuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782835497; x=1783440297; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ih6Ktml5cXP93WgMAvJK05C+fvNYLHTTNSxCgon9jFY=;
        b=nNeRJk+Si1rgTxWxjuzJq0gKDzEABpX4rw0++C6GdUlZkKWdX5DF2Z8oyJOwNihLTF
         4Kg+yhI04atpfqzbrmpikrVt/AZ3sQ9GwJEtQoUCh8LfKd3zE3zCbXla9FIGvpY7H01T
         QbPVnXFVh2TFZlD3SxTg9OcTdGCtB3wWj+Os0UXy/Y7dx0HES+ozW1eEa3zqYjHU0cdP
         vI6+Qgp6vKNMTq6BUd4euH60b8lF2OJbKRYky4xGAhe25RrJrJduGbKkG5qhTxQqXN5U
         Um8dpUCQ9QAqbfx9z0aOLuFZ4NSxVl0msEddttpZBgCRcR2R8687NriTRozs+5UE25XN
         9Yfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782835497; x=1783440297;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ih6Ktml5cXP93WgMAvJK05C+fvNYLHTTNSxCgon9jFY=;
        b=mBdBIgSASAJSya27C7bwsTuhYTrcpwYa065ha8+dsoND29YR8Cd8+ZWgGRcvRYtbKv
         a+cGI6tUNXu1BC9UOuVJS+DwIK3YvXy/1+EoE6l1xwQ1eqnNE08UZYmYPNk3SwT7rT9N
         MEn5kxoaFjCx1noS78idecb/NLqhK+fSGUQ4EfHGf+ybblln/y5S961Zwo/8rzmnxBWt
         cDnddCLHoTODZaM1dzjCi7YlOPXodb6aYvRa+y6K29TOJvWKieD6aFx9MiwXEt6ox+Ns
         ahle44H2z41GUG3EOTPLmgGKCFTAQmhoMx4N73JaZ5KhimqgTw3wgHaXo2K+qJPLLirH
         SL2Q==
X-Forwarded-Encrypted: i=1; AFNElJ9foRTNetTUq9W8fEE2K6uMGo2njTOxVBOnUP3SwxEykr//allgv9cJZnaEEKZKYBTSab9Ldks2S/Fz@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9cInHEMHHp6wLhVst3SdKv0EqHGfaKyeQGq23/w9Ge7TuLuUc
	GovN8u9fnCgjlFQw0YDfUaG7SUtO3LadPnQR2Vgs8pI3yuaUY6Wgpry/Q+T6CYbpeaKSgCXesmg
	zip+FBvG+kZsxr/pNmL5WlSr/2AabzY6UHG1XIjChhzZqbxKCuyoyorP/uF4=
X-Gm-Gg: AfdE7cla/cXQHb3xx2WyW9HPmXfrslO/Pr05fW76qmAlUOSznyn06r5wGJcSDw77/Vq
	4JtLkxT7zfhyLX8Z6rVDSJuP0FXsPMHkqQ5hQWQpG25iLlStJ+4degarDoAnlTGTVB6/MhcCDz1
	z7r4rMH4qBAQZOqSXmsA6GE+ur6aDD+n5BYYPSvBNQnGLMtCy9I/2rfpOiJhetiyrG5XW5ba7ai
	Z4raf28GS4jl7DsYwC0NTi0v3HJa1BkEKsqoGICqmQpsxfdHnXeVfK+XrL7E4ivSJ8/G87khw==
X-Received: by 2002:a05:6820:210:b0:6a1:7f9f:c967 with SMTP id
 006d021491bc7-6a189058da3mr3317041eaf.2.1782835496482; Tue, 30 Jun 2026
 09:04:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630155505.1707193-1-jmoroni@google.com> <20260630155921.GH7525@ziepe.ca>
In-Reply-To: <20260630155921.GH7525@ziepe.ca>
From: Jacob Moroni <jmoroni@google.com>
Date: Tue, 30 Jun 2026 12:04:45 -0400
X-Gm-Features: AVVi8CeBonsbobszDNJdcStRrlII14U0Ju_S6svLklFkh7c8aW-lGHVal8fuq6Q
Message-ID: <CAHYDg1TOGxRGZrS69d4Y--Shj_DZv0nJuM73iHUBwBM70g_t3Q@mail.gmail.com>
Subject: Re: [PATCH] RDMA/mthca: Check for null udata during reg_user_mr
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22603-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2375E6E6415

For irdma at least, I was able to trigger it with a one-off test binary
that directly invokes the UVERBS_METHOD_REG_MR ioctl.

The handler in the kernel then calls ops.reg_user_mr with null as
the last argument.

drivers/infiniband/core/uverbs_std_types_mr.c#L366

Thanks,
Jake

