Return-Path: <linux-rdma+bounces-23075-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EfCHEzt6U2oQbQMAu9opvQ
	(envelope-from <linux-rdma+bounces-23075-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jul 2026 13:27:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA26874480D
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jul 2026 13:27:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=krV6uiyo;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23075-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23075-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C4D8303CE14
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jul 2026 11:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AF23909A9;
	Sun, 12 Jul 2026 11:26:56 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B7E3A874C;
	Sun, 12 Jul 2026 11:26:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783855616; cv=none; b=q1NRHy3Us1CIob9xbFsmM0XlmILk9RuZt3//KNwreNvTAaa/3Oce2szowK/8oS9l3krMMd/jRCxO+N5aeK9e+ZokOAw8ibfMrjSS4wt3UbaICS9jE5chu3DSWTKgbRIcG/zDvK1Pw2Ahg4y+MseeuzyLYtZnsDQ5cLuv60GR8FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783855616; c=relaxed/simple;
	bh=NJFmXhs56sl0Ki/0UiUrVlqQmLNmiAf2fTGNjZrlWcU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WTzlIa4LreHltfCouXkXu5X6HhlPNPRYJ3kq23Ot+0R3L6M98Z0INIWXaiLLUvQ09NRS+HqbENERyksYMNz8AnZDcp/uC6ZtZJ9pCoOBUce/1HYDMmv+PWE8dcX+yjIStpSNfp559EP470WSsLH6+hwWUC4fN3GNlx9y2S8hKZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krV6uiyo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855E41F000E9;
	Sun, 12 Jul 2026 11:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783855615;
	bh=uOxqoWTWI956EmPvMQ8dXeVRuoljNi7+z9lw6eF6Zpw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=krV6uiyonq/iKHDZYZW/XFK1kalPAauIYBhWbNaFXStu8u30WXYEKsjd9+peXkCPb
	 CwF1LIWpS8W5sWuCZIQ1D9LvVXyH5zNPxEYfydCRGy0kjZZd3AP1beggj357vowUYx
	 CyMSSzITzabn7vWI3+tb0pC2//JZiAHLH7RaqAqhDl7sqZLPwvIfUHyoEZaQ8Nvw0f
	 77Locj0Hw8Ekht3cNSqXw7qaBC6hEXmJRhTRnDE2ij/hQLb1B+OarCoaYdpKs3NwmN
	 gvdqwAfBmK5f7AdCq+bQqViAyGTqnK/8EeqXcsSV3Y6NaOIRqyYUWjzqhl1AH3nUbt
	 ggUl2CGgpi7tQ==
From: Leon Romanovsky <leon@kernel.org>
To: Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Allison Henderson <achender@kernel.org>
Cc: Bob Pearson <rpearsonhpe@gmail.com>, Ian Ziemba <ian.ziemba@hpe.com>, 
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260711165419.13486-1-achender@kernel.org>
References: <20260711165419.13486-1-achender@kernel.org>
Subject: Re: [PATCH for-rc] RDMA/rxe: don't re-execute the current packet
 after the QP moved to error state
Message-Id: <178385561233.1568177.12923180855822763346.b4-ty@kernel.org>
Date: Sun, 12 Jul 2026 07:26:52 -0400
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23075-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:zyjzyj2000@gmail.com,m:jgg@ziepe.ca,m:achender@kernel.org,m:rpearsonhpe@gmail.com,m:ian.ziemba@hpe.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,ziepe.ca,kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,hpe.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA26874480D


On Sat, 11 Jul 2026 09:54:19 -0700, Allison Henderson wrote:
> When do_complete() finds the QP in the error state it returns
> RESPST_CHK_RESOURCE.  Before commit 49dc9c1f0c7e ("RDMA/rxe: Cleanup
> reset state handling in rxe_resp.c") this was the flush loop:
> check_resource() had an error-state branch that fetched each remaining
> recv WQE and completed it with IB_WC_WR_FLUSH_ERR, without touching
> the current packet.  That commit removed the error-state branch from
> check_resource() (draining is now done at rxe_receiver() entry) but
> kept the do_complete() error-state return.
> 
> [...]

Applied, thanks!

[1/1] RDMA/rxe: don't re-execute the current packet after the QP moved to error state
      https://git.kernel.org/rdma/rdma/c/15ae32c4a3551c

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


