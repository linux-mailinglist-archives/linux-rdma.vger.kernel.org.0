Return-Path: <linux-rdma+bounces-20700-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFdaEOzeBWqjcwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20700-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 16:40:44 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB345434D9
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 16:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFC703110ED7
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 14:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE563E1CEB;
	Thu, 14 May 2026 14:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMc97asG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07E026A1CF;
	Thu, 14 May 2026 14:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778768791; cv=none; b=rPWv7MSNiDgcSKChwBu6GyX/qlZqwmBrutfnEbZJwtQZxwNRGM1rmMYUEWyPZEE+bKjmCaDGjKwrPtN0EbxH9jEbUkmAJhsemaa75kGLVMU9eoMl4u2JU/CQw4++9H/2iIPTYl6m/xQ+rvG0t7Eq891cETlgOC03lzaVpGI7NHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778768791; c=relaxed/simple;
	bh=MakjjHPiiWf8LipOqirfV6r1KF2OvJwCMBgR2HGJ4XU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X9UGlfiyAvVt69JZrxfyo1t5CAy24OTgBn3xiC/P9PfryE5eFHfaiHtsbdcDXmeBQ7mrQtX4e3EGqCpi+wbyBPlKI0YWjYaCjxL0PJQwuqyyEFT3fivgMYm8oFhYw//C8k+78C/mWg9d/Lvrr3YTtzN/2rLogDtYyQVcaAuc5Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMc97asG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C348C2BCB3;
	Thu, 14 May 2026 14:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778768791;
	bh=MakjjHPiiWf8LipOqirfV6r1KF2OvJwCMBgR2HGJ4XU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JMc97asG90iJghqwyxCL/Eja605bkCsXDh5sFE0Qgi0LuhhHxM9LBVf6ri6WtO3tX
	 LINsd+a1Tko4vKtbnmlxRXYQge53WhYZ4yvK9T/5P7g+2ICgvMlqnZiSJTrTk6vC5E
	 UG8Hbn1rCd+ogpsKnBlJHq8nwbnvV9LNUNcvDNF0JeeGxyscTtiYrxvTU2xN47cwBx
	 fgVn6Fck69sZtQGYxoBT2Khohvg3LrJPkTB9LRGsfOsRHFEJ6E0kta4wFhg8Y8d1a8
	 ijBRidFh+FY1L5vyeqzawtZ4xNuWE2CS8jIuSGPXjxqC3Pjiyz74MFxHf4DLBmalNZ
	 ynvtY/rhugm3g==
Message-ID: <200b3923-d794-4779-8f90-a8b858861d4c@kernel.org>
Date: Thu, 14 May 2026 08:26:29 -0600
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/nldev: add mutual exclusion in nldev_dellink()
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>, Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Edward Adam Davis <eadavis@qq.com>, akpm@linux-foundation.org,
 arjan@linux.intel.com, davem@davemloft.net, edumazet@google.com,
 hdanton@sina.com, horms@kernel.org, kuba@kernel.org, kuniyu@google.com,
 leon@kernel.org, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com,
 syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, yanjun.zhu@linux.dev, zyjzyj2000@gmail.com
References: <20260513234655.GW7702@ziepe.ca>
 <tencent_3CCD70788A6EAC2D356D4C9674E8D2EEEA0A@qq.com>
 <20260514115048.GX7702@ziepe.ca>
 <139794f1-80b8-49d9-829a-0629379def51@kernel.org>
 <20260514141409.GA7702@ziepe.ca>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260514141409.GA7702@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DBB345434D9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20700-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[qq.com,linux-foundation.org,linux.intel.com,davemloft.net,google.com,sina.com,kernel.org,vger.kernel.org,redhat.com,syzkaller.appspotmail.com,googlegroups.com,linux.dev,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,d8f76778263ab65c2b21];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/14/26 8:14 AM, Jason Gunthorpe wrote:
> 
> Edward, please come with a fixup on top of this since it was already
> applied
> 

Zhu Yanjun: As author of the patch that introduced the bug and
maintainer of the rxe code, why have you not addressed this problem? It
has been well known for many weeks now and multiple people have
attempted fixes. Seems like you need to step up and take care of it.

