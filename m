Return-Path: <linux-rdma+bounces-13871-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0EEBDE516
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Oct 2025 13:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C49819C473B
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Oct 2025 11:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491A2322A29;
	Wed, 15 Oct 2025 11:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="i4/7zSlq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7BD322523;
	Wed, 15 Oct 2025 11:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760528698; cv=none; b=tZ0D9h5aThZ/rlBAm4lOWJawb8k5+NbpbZI+lBNzf0guGAhssLtfUMLCOuHjQpS1XqZn3cwT8D4c6djSv54U7NRQLtepZ15RgHaeS18k/NyCAddnAWbEsz+HujLpTGjXsUG/5WtKqsowh8KSqJmni89YxppznXBUHZZC1ANYWbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760528698; c=relaxed/simple;
	bh=+UYna7j626X3GstXLWaKHsufcJRW7DHMHxNOWyvJdgQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=A/O9Z0TdZ53FIpqiw40rX0Rx7wJVwQYuSOVTTKxbsl9hwtUABv916A0RLqPcXFNha9a3QQBJMgeA53xQcKtqooSuaKkCisPONeQfpdRl4SDofAxDh7LiUE9lK9mJ4ipwAbqe43Z1XJ1hs1z9fblyBqoeqY1xE7b66+RRhNEt0qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=i4/7zSlq; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760528688; x=1761133488; i=markus.elfring@web.de;
	bh=+UYna7j626X3GstXLWaKHsufcJRW7DHMHxNOWyvJdgQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=i4/7zSlq4OMKgthxdwDJQk8LqDvaMqv/yOT+YXE2znmgHHjzSDHLCkHzkxaRVy0W
	 GROOGZUPXO2UEGWpZqeDCp7XSmjK21G/at5+GL6U5IM+F/AAyE/WGiE+IUW1zrJqV
	 LcB3ql540JB1gOMD0jXkMSJyFXVHj0icySk+Rzwk+x4C2sdJyw3vRpkxhGFR7OTus
	 k1z+peex4SBwaxmB4H4H0LRZanjdZQXJAQVKau8HbbIMw67j47qZh9H1nIedobag+
	 yuHbYjpSATIeAM75LiUMN2Nb6OUCCYIXw+41lM38t1nkV2uB3Iko6xcD5r9JdTg9I
	 CoRnUoCxgvQV3FP+mA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.181]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MzTLI-1uMYAy2xf6-00vbzT; Wed, 15
 Oct 2025 13:44:48 +0200
Message-ID: <848585e2-9fa6-4a6e-b852-e99f37f47a5e@web.de>
Date: Wed, 15 Oct 2025 13:44:46 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cosmin Ratiu <cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Gal Pressman <gal@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 Moshe Shemesh <moshe@nvidia.com>, Paolo Abeni <pabeni@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>
References: <1760511923-890650-1-git-send-email-tariqt@nvidia.com>
Subject: Re: [PATCH net] net/mlx5e: psp, avoid 'accel' NULL pointer
 dereference
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <1760511923-890650-1-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:897SkDtkkGduIbV2Ns1XogGEesiu2+wH2lvQSyNJVYB+LdNc0oY
 krSAQfZWLJSH05l8ZlMIU5a7S+6BFqKpXYO/63mCtO/ITJixR0XGcqykiuSOdRtFdjpiQa+
 67PP33gKIN+5gtuXQs1Wt+kYxI6+Hi9iQOs1lQAX9h7v0rJ8YU4hTJqtlkV27k2AmU7ru3J
 GcCaAnEfrqKBhf7H9I6Uw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FfO4GWzkodg=;PU5jJUkAmxv2LbwtVGrYU3QcXRJ
 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
 +3gsw==

=E2=80=A6
> guaranteeing that 'accel' is never NULL. Also remove an unnecessary
> check from mlx5e_tx_wqe_inline_mode().

See also once more:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.17#n81

Regards,
Markus

