Return-Path: <linux-rdma+bounces-18857-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFykCxwTzGkvOAYAu9opvQ
	(envelope-from <linux-rdma+bounces-18857-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 20:31:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AC82E36FFB8
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 20:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A8113081B01
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 18:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66ECE37C0F3;
	Tue, 31 Mar 2026 18:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mu1Dri5A"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D733A37BE6D
	for <linux-rdma@vger.kernel.org>; Tue, 31 Mar 2026 18:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774981581; cv=none; b=KPIoYLczie4pb+fF7DpSjrLcEEx7e+s4Pm8rbhmU8BZ034C8vMQxSR6S3fVqG1NAGNPTXoBjf5vSwWhZ2mzW2cCQKop6xWW1MWSsOAIjLeBNHGRx0yFSetFA0/y3TSmB+zUKFsqTRTp/0y4ZbtoNVSCSohGcjFr8ev438/E8GPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774981581; c=relaxed/simple;
	bh=mHiRyPCnLDjJVk9PoLWPprhk2YfclD7sCEPrI/pJ9ZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=loQnUqfb/3YzmFLztUPgUi3JwaeMelSkN/Sez6Rt7ztjvqxGA8oaJqafxyqnNkyuqnnHAh+1iSAcqVhf1ES2TRU2GKAZ4UjUNaJLSyUeSqLdwBoi+1IFYaU4N3lvf5dN8ASY1O+1JxXODvHPZUlBL27YVXLWLE+TRiEuaG0qf3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mu1Dri5A; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-486fba7ce4cso60647365e9.3
        for <linux-rdma@vger.kernel.org>; Tue, 31 Mar 2026 11:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774981578; x=1775586378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHiRyPCnLDjJVk9PoLWPprhk2YfclD7sCEPrI/pJ9ZE=;
        b=mu1Dri5AQn80g33OP8u3NqIqbWVCBbTRe4IcmWHkmAKun4JvZDs7O0hFnDSCCwbFHb
         qqj+VfHiwb00L2HyqXYtACJJEIDdU0J+9zO/H6aEzwqVbS1GNWTkgJn/2A9cPDA0MuYp
         bfrOpqfxbvcSRsQdTWq8RUBXmO+fACTNRodgIYcWlaE2eL+mFlectjM28nPhpDhcx63s
         D9AIYfpzw2GMIKPodULIaIMRAvRg09ZIbd8nCjr5GtRBfOLoXAPl8Z5jKKa5DsZtF2q2
         Hp0TJZQS/fy83i8GRn2UL0QdkwN2iRbiA7XtS2XmWzTtpRn5QtWdybLDTFFjA8LiFjxu
         Bplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774981578; x=1775586378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mHiRyPCnLDjJVk9PoLWPprhk2YfclD7sCEPrI/pJ9ZE=;
        b=nL+3OWEONsOxB5J6tzpfRAwZkLSdQ9YEpTYBh3Uvwa84hfJnMJX1e5uu3oZOA05/dA
         AMt7pTUJAd3nVrvj/sT200QAShIBpewWXBx5+VcsogSnL0Qe6yewY4t1f1OfGRXH4UFm
         NiiEhTJul2diH8CZNxucfn58gOqsaiAWaSEEVdJM40XglzqNCjO7qdgh6/icWHV19JEG
         Ni+LuX7JAfwkQCwqJY1M+TlR0X69uq8ix4msWVYX+QE8Au8XLh8gvqm6mXyrvCGzh1Av
         J/7yqUD7NbbW5rub06KwKO6cCNAUfe7Ky8YGsvsDXOluKGpM0D2EbL0EPCKehLu1BjAy
         ky2g==
X-Forwarded-Encrypted: i=1; AJvYcCUwWvmj9VAsKqhuCYnydO9kriGdlGdxiDvJhXa7MNDIJmJnieNvse6yiB925bRH0l7/rvk90vVwd4zV@vger.kernel.org
X-Gm-Message-State: AOJu0YzyThlB0PF7AaG2cpCjEDrxjk6tjOdd7oBcAsakd2CqrpNSrHf2
	3oPr89Pzu+YD9FyWZ+OsGpbyGTWpV2P7brpngggSMTSRw/9RVQVbFieK
X-Gm-Gg: ATEYQzw1wgWaTm2chNSiIz1jj8hjrYli6+T8Mt+VSgshCvENAOcRPzS62h+Bv4gLrJS
	+U7FartuTegH94SEw2RITGXU3od7ebdVsw/kyv2nJIwAXvHaE+Gxg048k/hiCsYDXli6otmQJlg
	zBk97IWfOOYu+5REQX8wjny6oa+6EtRWnevUIyat6CpyNOxgYFFXhH3r6BOWnS4HuUAcmSyq6wa
	jJ8kO6Xfk6T9ATv14MVMUToNITIXmKJhUNqMMc30IUM+gmFQpqgzZFXJ/aPC/Nj8OTI1y5x9/es
	77GFYWM8R1IOlo2OqKUkInWJQe+gTds1UvjrmvWrxeAc0v+Nubh80wZoLKvlzT787YOebDv68cg
	CDxEJyNr5gJMOvB3zf7QExiIS80h26ZMDqVnEWNXnnUUXPMkZC+dozv4jH51xlx0hXLC+MmwOgb
	L/rIxylZpxI+upK5c6lV2xQAewscK1Z3OdQ5aFf/9XKqeLFTZifc3cZH7gWhRpMsLxVpSYJ+3XE
	F1IpNxlUVb/hvBtAhKmPOUm9v9LDdXQLquksudAsBQHeIfG
X-Received: by 2002:a05:600c:a016:b0:485:3f30:6250 with SMTP id 5b1f17b1804b1-4888359d87amr7002765e9.20.1774981578028;
        Tue, 31 Mar 2026 11:26:18 -0700 (PDT)
Received: from DESKTOP-NQ2T5I7.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c884b5dsm20051105e9.18.2026.03.31.11.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 11:26:17 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: leon@kernel.org
Cc: dledford@redhat.com,
	haggaie@mellanox.com,
	jgg@ziepe.ca,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	prathameshdeshpande7@gmail.com
Subject: Re: [PATCH] IB/mlx5: Fix potential NULL dereference in query_device
Date: Tue, 31 Mar 2026 19:25:56 +0100
Message-ID: <20260331182615.16983-1-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331134955.GF814676@unreal>
References: <20260331134955.GF814676@unreal>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-18857-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,mellanox.com,ziepe.ca,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC82E36FFB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 04:49:55PM +0300, Leon Romanovsky wrote:
> On Tue, Mar 31, 2026 at 02:44:27AM +0100, Prathamesh Deshpande wrote:
> > Smatch reported an inconsistent NULL check for 'uhw' in
> > mlx5_ib_query_device(). While 'uhw_outlen' is checked at the end of
> > the function before calling ib_copy_to_udata(), 'uhw' is explicitly
> > checked for NULL earlier in the same function.
> >
> > If a caller provides a non-zero 'uhw_outlen' but a NULL 'uhw' pointer,
> > ib_copy_to_udata() will attempt to dereference 'uhw',
>
> How is it possible?

Hi Leon,

You are right that in the current uverbs paths, 'uhw_outlen' and 'uhw'
should stay in sync.

However, Smatch flags this as an inconsistency because 'uhw' is explicitly
checked for NULL earlier in this same function (at line 968). If the code
assumes 'uhw' could be NULL there, it is safer and more consistent to
check the pointer directly before passing it to ib_copy_to_udata() at
line 1357.

This prevents any future refactoring or unconventional kernel-space
callers from accidentally triggering a NULL dereference.

What do you think?

Thanks,
Prathamesh

