Return-Path: <linux-rdma+bounces-22022-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Uo1FJbIsKGpB/gIAu9opvQ
	(envelope-from <linux-rdma+bounces-22022-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 17:09:38 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E75366618CC
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 17:09:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=C5yxa8tU;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22022-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22022-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E4A93056FD2
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jun 2026 14:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75683283FDD;
	Tue,  9 Jun 2026 14:56:58 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FB142982C
	for <linux-rdma@vger.kernel.org>; Tue,  9 Jun 2026 14:56:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781017017; cv=none; b=Gltuvp2/bHvm6dqQDxiPJvPUHmJJDJjL9RruFkoLtGaYmFmA6NeDsI1rhAB+mPDgRJS6YsRErx+i9iqorEVeVDNL+/Jmi6XdunmzSDdXQc1ttkPukhSuYCmeRXmnDgBpyqUoizuXbTSmJglWgTMVkHHwQM8xRnnpO1muAUDPXgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781017017; c=relaxed/simple;
	bh=GIDLiSB6/bfR2KCnN6EIAmwRNYS/DkRKAGn1xuQZ2/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VkfErtf+gYSGT+XuUFWUhm4VyhEFYlgH4PCSt7oKWcjxb9DyPCUMQ5gPpal4zcspp1Jwc7BSXjL+7MVKPmwavDEfWLWtF1hPDXqm4IK7JGVluavB9b6xcOz0j9r9ruyYwS6cyC15BziBkItU+9CUPwjlWvRyGv0mYKNQ7mb4/3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5yxa8tU; arc=none smtp.client-ip=209.85.167.54
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aa66893e9fso6699476e87.1
        for <linux-rdma@vger.kernel.org>; Tue, 09 Jun 2026 07:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781017010; x=1781621810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlcJ5nf2UKqYYECLIi9kaBUS8dEwUkuhF8Ti5HDx8Jc=;
        b=C5yxa8tUZ4smXhKNmm9i9pfwrTRsdTwOyaaVC2sKzAMXQVrUY0PZZaACuWUjs/b0Bw
         sJPPIXnVuwXq5RhP25Fcn5l/NESfQBDDgmGXV+h5fGVs8FKxKeJqwBSxCK/aC/DZseIF
         Dquk9g6PTgwai9RyofY+oB13hxQkYWK9MNg045BMbR8WTtJl/5S1LH+Wrj9cSBfwlV4U
         j54ias3xU/5Misiku4mNgTu/vopEo4HQfCYJDsfMeXf+91LU/uL7ZHx2IPMqKY2Y7XF6
         OPtVa6bpj+lz29pMx9EdJUhPy1PbWbsMG0ONFg+pm/En77CQWXiuYL0XjXh569ApHUbO
         //fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781017010; x=1781621810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vlcJ5nf2UKqYYECLIi9kaBUS8dEwUkuhF8Ti5HDx8Jc=;
        b=aDRTbd4EZsH3QRxhM0M0UVLdi7s9DFW5qMPAhfafQ39wvZzDOwhOfNI1Lz9eJzAy81
         9EK2mFcGrIVvtMPWgwDAtlxP3j86th3ZyVYL2EofapUoRmNhn2uFigDizmsxpWLSxTs1
         PBr0Hqr2HVRO2aXNgYPSnmOT1GZXAnCLNS1nN2yl04aw/pBqCSOOniBoeHWl2SdE7Lbq
         nsWwrGqCgGNwvIg5m2c6uEIlTxd0qAe523DF6NszKthdjQFPfB0H9zrDlE7WlkcdtwaQ
         BlSJ/YryjHNdo63l40aHhNmA/5FYb2Kz5YgGKn95akBe11qhQi9LmbpWcozMcXZye3cl
         L6KQ==
X-Forwarded-Encrypted: i=1; AFNElJ+GbCDaW0IHv6weO0XDgXl7t6+a0C1QDwxHnKt8/RvTBW22lNlVTxxGacOr9J3X+C/phY1k7wpZcp4S@vger.kernel.org
X-Gm-Message-State: AOJu0YzhJNm1c4eyF46iG+deqtbVbxfWEPwuxJdzRdNksPl90i+ZxYIM
	SMVV6ADSEPvh7cXtwva/y2DRHTbCUeSDG+4/BVtL6tnRVoU7nkG/gHhH
X-Gm-Gg: Acq92OHJKuVRZBZpjbb3d6rD7Marw9HTsbx8L1UuPEdT3gPUIyqyNUuluiFU6kxmUwU
	Qa7zTPtQo0TG+kq8ZOM8mWx0weAZh5E7QwDN1gP6GTIBEOCsrUSo1v7eUTCCd0a3d6vaUPUepz8
	K0BibCIk5tn9pOQDbWbFvBaBafsBIsvP0Sw0nD6uLzIvC72D1OVzcblFFKWAKB90flLSzB9TdrB
	jrw8HfVpPWUF0Ozq1PhlXEUEHbQS2E0Itq7siQLwKTDcv4q2wnXGfpXnePZiiktZgHA5eY+ByOk
	SCMP3PnOghSsPCfRgqna/+4caYW+aO1tVDIEVYBi016d2xSu6upv/FPemEhmNdSqX3FJHqxkrbR
	I35tzEyzPR8vR5GJiOqTd92MqhI1lhBJyrR1NzvllrcmjLDBveOw+TfzgFV3SnoestZmCDVShE2
	5MRLARzBYvA2/QZJiwfKhQCRT0CkRcqYVS8UDlR4HrPRqw5JjkVRwrjgZgpYU3i6ev62p2
X-Received: by 2002:a05:6512:a93:b0:5a4:496:5bac with SMTP id 2adb3069b0e04-5aa87bd5171mr5971444e87.36.1781017009987;
        Tue, 09 Jun 2026 07:56:49 -0700 (PDT)
Received: from c0624c666cc5.devsec.astralinux.ru ([93.188.205.42])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8ed8f6sm4644476e87.6.2026.06.09.07.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:56:49 -0700 (PDT)
From: Vladislav Nikolaev <vlad102nikolaev@gmail.com>
To: Sasha Levin <sashal@kernel.org>
Cc: Vladislav Nikolaev <vlad102nikolaev@gmail.com>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Doug Ledford <dledford@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Haggai Eran <haggaie@mellanox.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH v2 5.10/5.15] RDMA/rxe: Fix the error "trying to register non-static key in rxe_cleanup_task"
Date: Tue,  9 Jun 2026 17:56:27 +0300
Message-ID: <20260609145638.1849-1-vlad102nikolaev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605-stable-reply-0021@kernel.org>
References: <20260605-stable-reply-0021@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,linuxfoundation.org,redhat.com,ziepe.ca,mellanox.com,kernel.org,ispras.ru,linuxtesting.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22022-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[vlad102nikolaev@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:sashal@kernel.org,m:vlad102nikolaev@gmail.com,m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:zyjzyj2000@gmail.com,m:dledford@redhat.com,m:jgg@ziepe.ca,m:haggaie@mellanox.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:pchelkin@ispras.ru,m:lvc-project@linuxtesting.org,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vlad102nikolaev@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E75366618CC

On Fri, Jun 05, 2026 at 03:37:28PM -0400, Sasha Levin wrote:
> I'm dropping this for now; it isn't right for either branch as submitted:
>
>  - 5.15.y: the bug doesn't exist there -- the task locks are already
>    spin_lock_init()'d on the QP-create error path.
>  - 5.10.y: mis-targeted -- it patches rxe_qp_do_cleanup(), but the 5.10
>    error-unwind path doesn't call rxe_cleanup_task() there.

Thanks for checking this.

I rechecked the 5.10.y and 5.15.y code paths, and I agree with your
assessment. This is not a correct backport for these branches.

Sorry for the noise.

