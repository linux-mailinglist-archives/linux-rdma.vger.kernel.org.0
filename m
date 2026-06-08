Return-Path: <linux-rdma+bounces-21986-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XGJaGD0yJ2rJtAIAu9opvQ
	(envelope-from <linux-rdma+bounces-21986-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 23:21:01 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7F565AA59
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 23:21:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=JRdn8rAD;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21986-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21986-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A6FE3028373
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jun 2026 21:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054943A1A26;
	Mon,  8 Jun 2026 21:20:50 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71CE3769EB;
	Mon,  8 Jun 2026 21:20:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780953649; cv=none; b=J1yxjog+p3SCdfn9w5gvJ8IQROKQiuCeKxi1At2o0BNcr7kaEgAoEMpe5ynmmvPaxk8oTthAtJJPDN9uuNlcwHGlKqNJm0zuKm9A52+jqBPLCkSki+0E2cT9qi8igk9VZgovxjokmD/PEor7oM+HIxNlH8EdhQiVxaiFqb/wZsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780953649; c=relaxed/simple;
	bh=xdXrA7WuZWOFV3zOKzTZwoFD9F+YW9X/LEhJKuP2uAI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YUVEGQ5miIFeoqkt4tMjpC7ra+xlpGk3yup0MRfjZiTWXjeGxwJNNMnmWHcC6xjQknoDXcv43nfs+GYO5g9Hoq5hlQNOCKJRcqUpp5ABmOhWAeQ1N3f1hmfArn7TyJIuLm2rc0ieaf6auV2cwgVCNrzQDXgrg5tmTnko2WmAA3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRdn8rAD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1603D1F00893;
	Mon,  8 Jun 2026 21:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780953648;
	bh=K8SFcbQD5TdWhbK/VoBNiPVzLEY9nk+UtISgZtbEMp0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JRdn8rADw7sfFQHPDSXGx3rlEOCMh4Qb5EVoW20Ysncbl3l7yAfELft2S3vrPBEjb
	 rlo2dokCX2C/lqUyYlzl4kFCSTEIgzNLThSMiwPYMfhEI0vXt4rtwnnUsOg2b7KwvV
	 zy7TnsCeFd//uNZdmStnk3n/ef3tLdv8l/ubOL9idmWO034BNXoP7I48rB7q6+2AIT
	 gYijpoYGfllhh5YjJc7SzU3ktWQqwbHvyjAvmQnltCPYXQajVXy7vnzUme4CeJpgJB
	 Lw7uZdiSNlRnDWvDy+53Sk1XhRj1GJ903HwC1SeDYsAbJB/w6D2zdgHn+Wba1DdkVD
	 8lwoBN8rXP/pQ==
Date: Mon, 8 Jun 2026 14:20:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc: <jgg@ziepe.ca>, <leon@kernel.org>, <brett.creeley@amd.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
 <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [for-next v3 0/5] ionic: RDMA completion timestamping support
Message-ID: <20260608142047.6deff079@kernel.org>
In-Reply-To: <20260606050003.3648306-1-abhijit.gangurde@amd.com>
References: <20260606050003.3648306-1-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21986-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:abhijit.gangurde@amd.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:allen.hubbe@amd.com,m:nikhil.agarwal@amd.com,m:linux-rdma@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dwmw2@infradead.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,infradead.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA7F565AA59

On Sat, 6 Jun 2026 10:29:58 +0530 Abhijit Gangurde wrote:
> This series adds RDMA completion timestamp support for ionic.
> 
> It enables PHC registration for RDMA timestamp capability, exposes a PHC
> state page for safe user-space reads, maps that PHC state through RDMA
> ucontext mmap, and extends the RDMA CQE format to carry completion
> timestamps.
> 
> With this, user space can read completion timestamps and convert them to
> wall time with low overhead.

please CC David Woodhouse <dwmw2@infradead.org> on future versions.
Since David is working on uAPI for clocks he may have some thoughts.

