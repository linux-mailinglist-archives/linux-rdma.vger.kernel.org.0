Return-Path: <linux-rdma+bounces-16013-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJNkOw41d2nhdAEAu9opvQ
	(envelope-from <linux-rdma+bounces-16013-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 10:34:06 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 583B186112
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 10:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59FC8304D962
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 09:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226EE325739;
	Mon, 26 Jan 2026 09:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="sJfyLMAz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A698325725;
	Mon, 26 Jan 2026 09:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769419827; cv=none; b=ma96oAZufXJ8kRjSaodnp5FLsCwuH2z41sP008ZVvACBOBlMnCTXbssm0IfkAMnb0dzFx6o/lHqoykzKZCCp+weKuKjVFCNHPiIRuhOSAoB5R1Z+xvX1HCPvTea74feMi7hMONgD6djxMqSACW5L4AD7SUw3HTr8V0IqJo3Mj/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769419827; c=relaxed/simple;
	bh=dl2KoUrKq1HdQPf/PSPykf+JtaJD7LzxOYpmANhehHQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=i3Rvueje+LUp5bBVHjDvktwwcGty/akvhD4GboXPi2GWaYYCeaD6szpg8fJhlKIznaEyTokiKVjjTmrue0MzJnq3TOu0Jgqckf13o2WeMN1TQkCrnZcn0db1UvjwgXYPiljeijyk8RH+H2d74W4qdZLBYCO69fEK5ZDc2+D6oow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=sJfyLMAz; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1769419818; x=1770024618; i=markus.elfring@web.de;
	bh=dl2KoUrKq1HdQPf/PSPykf+JtaJD7LzxOYpmANhehHQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sJfyLMAz7Lp4flnFmngrbD8Krh7T6vExfyI54D+1qgeMm1Yx9ITBGP6LJtZIQ5xG
	 mMpwpVf17CHArvzeW5+syZRdCP0YtT4O4e4aVxeQif0CU560h4wNBShHbjChZ8JKN
	 r6kQPQVtwc71SMGiQZg9if8oQ5KTmtFg5ZcosF+5F0muKlXgrv4+pP4zcmHkYGCBW
	 LQMmPKjxVCp1ECcOZCsco2DuQoaWI5JEli1BqCQUQ1V3fOhauNhQ8CBarDBBzGGu8
	 LlGlSYaCnzseATK0sk4gFHbbBF/4B81ZaHnQWL3i8PRSFbUi3M5ClRbhA/gd294qY
	 cNJH5n8iIjzv080rhg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.253]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MfKtb-1wGbs90efD-00mKPy; Mon, 26
 Jan 2026 10:30:18 +0100
Message-ID: <62c4934a-5db0-45c0-a600-fce2530b50ae@web.de>
Date: Mon, 26 Jan 2026 10:30:16 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zilin Guan <zilin@seu.edu.cn>, linux-rdma@vger.kernel.org,
 Leon Romanovsky <leon@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Jianhao Xu <jianhao.xu@seu.edu.cn>, Yishai Hadas <yishaih@nvidia.com>
References: <20260126074801.627898-1-zilin@seu.edu.cn>
Subject: Re: [PATCH] RDMA/mlx5: Fix memory leak in GET_DATA_DIRECT_SYSFS_PATH
 handler
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260126074801.627898-1-zilin@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V/y1oAhnARbkC3wcCCo18CNX10dJUtmoMBefsXsrm6vf/E8GXcG
 r/iI0T13EmockuULAXzpWKUWDfURZUs2u/OU4hGNIVAsk6xfafrcnawr+nzhNPtnTrTuOOB
 jcaatoW734eEkfKSc9wpwV/ea4WpoDGGSGllRHHwdt43gNiaHCS/VfrUl7MXQkrAKku9rqO
 XMhF44eg6+mqHsYnjG6Fw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:luA5YFx9phk=;Hx6yMyZtm6SKs38N1BoHD+zuFvN
 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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16013-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[web.de:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[web.de]
X-Rspamd-Queue-Id: 583B186112
X-Rspamd-Action: no action

=E2=80=A6
> Add a kfree() call to the error path to ensure the allocated memory is
> properly freed.
=E2=80=A6

How do you think about to use an additional label in the affected if branc=
h instead?
https://elixir.bootlin.com/linux/v6.19-rc5/source/drivers/infiniband/hw/ml=
x5/std_types.c#L189-L231
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv6.19-rc7#n526

See also once more:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/stable-kernel-rules.rst?h=3Dv6.19-rc7#n34

Regards,
Markus

