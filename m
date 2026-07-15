Return-Path: <linux-rdma+bounces-23262-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gTsEH01IV2pRIgEAu9opvQ
	(envelope-from <linux-rdma+bounces-23262-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 10:43:57 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C5175C004
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 10:43:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YH7veHY5;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23262-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23262-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2FE9301BC0D
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 08:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFB93CC7EC;
	Wed, 15 Jul 2026 08:41:17 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E06A3C5552
	for <linux-rdma@vger.kernel.org>; Wed, 15 Jul 2026 08:41:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784104877; cv=none; b=cAjfPpm1w3NgR4ltJikuWcJSAxmGsrxSQsY/rLl0esKDRSp0p3jSBijCS6PxWH+aCNw+AV8S0Trw5rBa4tLnht9g6OjgxaaILAzlvMyXtpJ5HLJ1+c+SxaPy4lePjw/XgMi9RvSHMCZb2N1dXpUrsP7z/+2fg84UKx5y93fCxhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784104877; c=relaxed/simple;
	bh=ccCCmlK/3XMCUipwXR6/Bjo1pCrl333P5WWuqCqM+5M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=V3GZu2v0y5RwPEwIGm9jM0sU5+SjVb/jhEBs0Q5L6KjC9qncOsk1R92SB/U7dzvDcaCoOgMuL5S/Z2Q0SzAJqAHtS558KKOGyk9KIHJc3eAwD2UNLDlJYtbhPnRNpxFKPOlPyPgH7sYUV8b10MCe3QBviZHjONMc9WXYhZsW/x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YH7veHY5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8641F1F000E9;
	Wed, 15 Jul 2026 08:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784104875;
	bh=QlI5Gge9cXOPSCp8EEvtBsmxoyswpIxAlbJ1kgGzSZI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=YH7veHY5KPTbsSUL2NIpcyg6nQJYGLh4zg4pW8/BmLgBPdXtT1qIyDBhdr4cjnwaM
	 kud60APyYkiJo3/rLI2sFuBd0PHt/Jc9cDVPSWc3R8+mwmCzsJrtJEJIaf4+u2JzMd
	 lqbRE5IAMWHZhtgJKJLxq/ToYRVSQhfL5wx0H0OAWV2u7QL+xofEDDe4eFCwOPUeFb
	 5QPIlNhZpl1uF8gu5JrHjyChlyDzDsP3TgEtLoF6u/sZ+5YsME9XJu5JiMzsVM97Tv
	 5mywyvKp1er5/1XG9GW4kdGeVBurH2wbRCIDbqNCqQOoCYEupZp6avp7Vw+f5sdHnn
	 u6X3jkIFJvMqA==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, weimin xiong <15927021679@163.com>
Cc: jgg@ziepe.ca, xiongweimin <xiongweimin@kylinos.cn>
In-Reply-To: <20260714024429.188276-1-15927021679@163.com>
References: <20260714024429.188276-1-15927021679@163.com>
Subject: Re: [PATCH] RDMA/addr: fix spelling of guarantees in comment
Message-Id: <178410487316.139394.7960269642151273540.b4-ty@kernel.org>
Date: Wed, 15 Jul 2026 04:41:13 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-18f8f
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-23262-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,163.com];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-rdma@vger.kernel.org,m:15927021679@163.com,m:jgg@ziepe.ca,m:xiongweimin@kylinos.cn,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 22C5175C004


On Tue, 14 Jul 2026 10:44:29 +0800, weimin xiong wrote:
> Correct "guarentees" to "guarantees" when describing work cancel.

Applied, thanks!

[1/1] RDMA/addr: fix spelling of guarantees in comment
      https://git.kernel.org/rdma/rdma/c/21680554a8d1c5

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


