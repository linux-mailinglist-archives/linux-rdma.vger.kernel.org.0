Return-Path: <linux-rdma+bounces-20476-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OL1gEw//AmrTzQEAu9opvQ
	(envelope-from <linux-rdma+bounces-20476-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 12:21:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 349E951E72C
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 12:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 753D0305BFA4
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 10:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE086349CF7;
	Tue, 12 May 2026 10:17:39 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9011A349CE5;
	Tue, 12 May 2026 10:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778581059; cv=none; b=mMtBleyae2Yd0xszi9jRI+w0K9hMlX2WHFKCVHvy3xqy/A8HIuTFP8i+bIBt9CSP1kP/Fo9G+hJHKmLaIPxT4Q+JvDaSEoDTQ17Qh0Rbbb850OxA5uNLNFxGJa93/xBK/5U61+yQnGcZrfQMeNlCvRT9u6NzB8PFSZ/jlVXruQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778581059; c=relaxed/simple;
	bh=hzU9k6HaHL1llKdrLAId26dy9cEGrc2zJdgulN8HJIo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RttAd058Bw7aKol0Q+amH2zXUS3PfGE99KdEtqbUQErnnriDCBmmpeazv+Yzo99JkA0nYGez50SuUY1KCv75BGxZso+99Sk2taVuKVq5oHkdL8BlComEDgScH6HNsdpo6ytQNAI66Hja4Rxte3YfEUY4TvLV3uQjzJyH8byT4tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 2286392009C; Tue, 12 May 2026 12:17:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 1D9D592009B;
	Tue, 12 May 2026 11:17:29 +0100 (BST)
Date: Tue, 12 May 2026 11:17:29 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Leon Romanovsky <leon@kernel.org>, 
    Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
    =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: Export pci_parent_bus_reset() for drivers
 to use
In-Reply-To: <20260512090006.GQ15586@unreal>
Message-ID: <alpine.DEB.2.21.2605121104560.46195@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2605050042390.46195@angie.orcam.me.uk> <alpine.DEB.2.21.2605050051390.46195@angie.orcam.me.uk> <20260512090006.GQ15586@unreal>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 349E951E72C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DMARC_NA(0.00)[orcam.me.uk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20476-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[macro@orcam.me.uk,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, 12 May 2026, Leon Romanovsky wrote:

> > Export pci_parent_bus_reset() so that drivers do not duplicate it.  
> > Document the interface.
[...]
> 
> I wouldn't recommend doing this solely for hfi1. The driver is likely to be
> removed or significantly changed soon.
> 
> https://lore.kernel.org/linux-rdma/177516078937.637585.1447184858924347033.stgit@awdrv-04.cornelisnetworks.com/

 Thank you for the pointer.  FWIW as per the cover letter I have no own 
interest in the driver and offered this cleanup as a general code quality 
improvement.

 Dennis, please clarify your position, and if you'd rather this change 
wasn't made, then I'll drop the patches from my local verification setup 
and won't offer them again.

  Maciej

