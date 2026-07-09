Return-Path: <linux-rdma+bounces-22940-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1aPILixmT2rufwIAu9opvQ
	(envelope-from <linux-rdma+bounces-22940-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 11:13:16 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F72F72EC26
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 11:13:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BQg1OTCU;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22940-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22940-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DB6A03096A67
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jul 2026 09:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33446404BCD;
	Thu,  9 Jul 2026 09:09:43 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC7B3FF889
	for <linux-rdma@vger.kernel.org>; Thu,  9 Jul 2026 09:09:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783588183; cv=none; b=kg8s2hUPLXu/+NbBzv+1LXnDLOiBZ10cWaWHltDkJiTJ5ZQIXAU5X6ucc3fHETESDwueOp2pA3FqEbXIxBdulUzskGzBoDSlrCH3Tg1UsZDNNHDthV9umZ9YCBsx3eexkq29t0AG+fqXYydsVNUwGDss4IkN4Gyx8Xxdg2Z4bGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783588183; c=relaxed/simple;
	bh=9thf/Ejhc35ynH9M61FWBd4ZmZ4cOOx2yKw+7ihsenk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aJo+4GpWpsfG0HsZBybuDHW3oW0Xkq7TFubFPF4gm3pbaYeDwqEwKq/VHqtCkvzb+oEwn5mJ/3hZogrzNhkG2WklPwOtil+O9LfdWro6YLoc/udMZlFrsyF3zOsp0xpl3qY/FlrAkMXPurYj6YqOPeg1ftR+N/0prqKMEckSE4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQg1OTCU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130FE1F000E9;
	Thu,  9 Jul 2026 09:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783588181;
	bh=YULGzDcHM1TLPJpT1xYVlD9gHE+0cZICsht6KLUJ/N4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=BQg1OTCU2Q8w8y2M92mZmF+irSVNmsg3ruh0qpb8eAcdWCKXEtGJUfU+Coq6qYz2n
	 dqmZ+gHoSXRD1ZeMxpD2iTTSqVEb8u2AQwsIKZrs8wCKDMZC/5nY/SCIKCkKzPW/tG
	 JiCEcn/QwjXB2NTxwrhtLyLbZl2H/7vOy5Y+khh7vc1Zeiwg5e1oT+4JQJXmwKAa8n
	 Yjg5Bd45GucJgSzkDOP/ZUv9GNmPNXPKxTc0xOOe46dbsYfFzwd9mmrtK82KVERK8/
	 Q3jO2OjxemfMeifu7+E4Q/6fgf97hLRDqz3MYG+ljdwegPIUw6i+ZZ67bxA20hZgx1
	 E2c36rlps4tMA==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, Kamal Heib <kheib@redhat.com>
Cc: Abhijit Gangurde <abhijit.gangurde@amd.com>, 
 Allen Hubbe <allen.hubbe@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>
In-Reply-To: <20260708210734.641411-1-kheib@redhat.com>
References: <20260708210734.641411-1-kheib@redhat.com>
Subject: Re: [PATCH rdma-next] RDMA/ionic: Remove duplicate IONIC_SPEC_HIGH
 definition
Message-Id: <178358817866.1471117.4445800976843457612.b4-ty@kernel.org>
Date: Thu, 09 Jul 2026 05:09:38 -0400
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linux-rdma@vger.kernel.org,m:kheib@redhat.com,m:abhijit.gangurde@amd.com,m:allen.hubbe@amd.com,m:jgg@ziepe.ca,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-22940-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5F72F72EC26


On Wed, 08 Jul 2026 17:07:34 -0400, Kamal Heib wrote:
> The macro IONIC_SPEC_HIGH is defined twice - remove it.

Applied, thanks!

[1/1] RDMA/ionic: Remove duplicate IONIC_SPEC_HIGH definition
      https://git.kernel.org/rdma/rdma/c/b21d9bf627dd41

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


