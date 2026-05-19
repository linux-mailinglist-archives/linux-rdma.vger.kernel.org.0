Return-Path: <linux-rdma+bounces-20968-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOAlKPZwDGpKhgUAu9opvQ
	(envelope-from <linux-rdma+bounces-20968-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 16:17:26 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8645805FA
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 16:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA0B4306A370
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 14:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B578D3ED3C8;
	Tue, 19 May 2026 14:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="GANpHPK1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from black.elm.relay.mailchannels.net (black.elm.relay.mailchannels.net [23.83.212.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344603403FF;
	Tue, 19 May 2026 14:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779199652; cv=pass; b=fLd1u/KnBZuTjeOF+JaZLnmCV/wrKzX5Sn4EnHrxzb0DeZ/ra7Gw9yfJqf4w3U/Xr6M58TazJK4h0NlHdDoR6etWVhCG/wYwWLhgViDkq56GVCK1ruMN4B+xiTbDxVC3YzWlpre52L+5IecKaKQH1JAbqQaoggZMRS9LjPUtRO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779199652; c=relaxed/simple;
	bh=8d1tmTN66ShmrLNM2sDuVIt0qg0eod2NT5cirK0UbXc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QIG6V4+15Ie/hNNAo/3eHoVoSoPWTXmvEnBUhj7pFyQT6ePZrQawqc/OHHdU34i6WkwpUFi0srYnDgce++Eu6FDtww4tYSGgMrRLaGScVLDm+kYrtGxrP7l1mSBi3ypbtwszsTh/y6ZfJ+Dc2s7AmvPZ1H13MX+FuN3auMPObvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=GANpHPK1; arc=pass smtp.client-ip=23.83.212.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 59FA1720588;
	Tue, 19 May 2026 13:59:57 +0000 (UTC)
Received: from pdx1-sub0-mail-a247.dreamhost.com (trex-green-3.trex.outbound.svc.cluster.local [100.109.25.249])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id D270272188C;
	Tue, 19 May 2026 13:59:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1779199196;
	b=UICybyjvqK+9gv0mHnr3Gqt5yyQ41AwfyFNKuaHyAFZWBjzY1S0GSmM/PqEqyP0Wxk1lyl
	HR8GoiGWWIWNtNL4IAbEZtqV9YDqRxIbPBVsd8NzdXSpJXqRYrSB3Qn3cz1KvGrMzI5sP0
	HW6WsRGmSn32tjN4zawvVHJPtxef3NCbwmahK92Z34fbnfEQykVza6QIgBVkHHmlbiegq3
	2/kvmQ1+nGdBXfyVNLPgIUfAHy+H/WMTA5DZfOCgid+tooIxytYPPUsrV4PxImjL7j/CVj
	50rwhj9Fiw7+HIiQEDaMnaPU4ec7L1z5np2n2Onju1RVMpeyREKsJSU32UBwpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1779199196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 dkim-signature; bh=jFxOgosKVa9ofCbZHaIOL9XiRrG91n8Kyi+HJW0U5gA=;
	b=YF3O6HTiBeYsDs9TAua0xzSKfBmq1jG8uMce47Vd9uiFSM757zdeqv8cOqLOcn4rK0CmTN
	4zW+O2m8puIPFMWbWz86EkFniUyIbOguINu3GrROIxdQQHnlzDu9x7UJd8kCs+9K3a1O2C
	WPFerDcfhmOxzTNyyRoS5PJZo51XaW4WOpfJ6mRS+voqrbkJarySzfB6rC6tkAwembWxAp
	bkMEXDz8B8gYKI8e8TYpmyzJvxADZXr5/lPunHy8E7dP3Hq/pRoaHxPEU9IJrd+vEdlObC
	txdVKoJXBPxipiS/TkdXA+Q96r+JQCWo7PDBMS0LN6vfRkKrRW9Mx9DtDe/E/A==
ARC-Authentication-Results: i=1;
	rspamd-54674b4cbd-brtcq;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Attack-Hysterical: 249efd135791aa8f_1779199197226_80967156
X-MC-Loop-Signature: 1779199197226:4283785261
X-MC-Ingress-Time: 1779199197226
Received: from pdx1-sub0-mail-a247.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.109.25.249 (trex/7.1.5);
	Tue, 19 May 2026 13:59:57 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a247.dreamhost.com (Postfix) with ESMTPSA id 4gKbs82NT2z106M;
	Tue, 19 May 2026 06:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1779199196;
	bh=jFxOgosKVa9ofCbZHaIOL9XiRrG91n8Kyi+HJW0U5gA=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=GANpHPK1WffqqXdiP/4KXPQp/S+JFICRzsVSrF+yDVEy3EuzL+K48e96dZc7EYbvk
	 eF2c1F0bdwKRhSnyIjy8n1R6KpmRZCv1Z8pHdHrbgmzuo6RaODvbOQlpQU39ysefMq
	 5rICplTx/G8jRW72YZWANehMuhiQ4dlxJRg9Iw8y+hJvI4EG5lhBTpd7RrilwN7V+p
	 83mwfMOnP3HEn20Ln5MET6xzu3I2xSO/xnS105QjFksVslvms+gOkTTTmGED0PKQbk
	 ABx67NMAeMMfzgzCEmybcHUrio06+UM6VFY/jV/KLjDK6mpVc7TV0vnYaAgoc+49I1
	 rYHSPdJlNSCPQ==
Date: Tue, 19 May 2026 06:59:53 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: linux-cxl@vger.kernel.org, linux-mm@kvack.org,
	linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: djbw@kernel.org, jic23@kernel.org, dave@stgolabs.net
Subject: [ANNOUNCE CFP] Linux Plumbers 2026 Device Memory Microconference
Message-ID: <20260519135953.v74dnpyi4i62diyr@offworld>
Mail-Followup-To: linux-cxl@vger.kernel.org, linux-mm@kvack.org,
	linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
	djbw@kernel.org, jic23@kernel.org
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: NeoMutt/20220429
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[stgolabs.net:s=dreamhost];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[stgolabs.net:+];
	TAGGED_FROM(0.00)[bounces-20968-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,stgolabs.net:dkim];
	DMARC_NA(0.00)[stgolabs.net];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[dave@stgolabs.net,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BD8645805FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

Linux Plumbers Conference will be held Oct 5-7 2026 in Prague, Czechia,
and will host the Device and Specific Purpose Memory microconference[0] for a
second year in a row. Co-lead by Dan Williams, Jonathan Cameron and myself.

The call for proposals and topic submissions is now open. Please submit
your proposals by July 24th at:

        https://lpc.events/event/20/abstracts/

and select "Device and Specific Purpose Memory MC".

Examples of topics relevant to this microconference:

- NUMA vs Specific Purpose Memory challenges
- Core-MM services vs page allocator isolation
- CXL use case challenges
- Hotness Tracking and Migration Offloads
- ZONE_DEVICE future for Accelerator Memory
- ZONE_DEVICE future for CXL Memory Expansion
- PMEM, NVDIMM, and DAX "legacy" challenges
- Memory hotplug vs Device Memory
- Memory RAS and repair gaps and challenges
- Dynamic Capacity Device ABI
- Confidential Memory challenges
- DMABUF beyond DRM use cases
- virtiomem and virtiofs vs DAX and CXL challenges
- Peer-to-peer DMA challenges
- CXL Memory Pool Management
- Device Memory testing

You can get an idea of the format and accepted topics from last year's
session[1].

We look forward to your proposals, discussions and seeing you in Prague.

Thanks,
Davidlohr

[0] https://lpc.events/event/20/contributions/2331/
[1] https://lpc.events/event/19/sessions/238/

