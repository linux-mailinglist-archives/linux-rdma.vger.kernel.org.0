Return-Path: <linux-rdma+bounces-20794-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CC7CL6+B2qYGAMAu9opvQ
	(envelope-from <linux-rdma+bounces-20794-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 16 May 2026 02:47:58 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FCC559994
	for <lists+linux-rdma@lfdr.de>; Sat, 16 May 2026 02:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C220300353F
	for <lists+linux-rdma@lfdr.de>; Sat, 16 May 2026 00:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27582236E3;
	Sat, 16 May 2026 00:47:52 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CBB2556E;
	Sat, 16 May 2026 00:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778892472; cv=none; b=EQza/AJp/IFvxbgIkEoldrhOOEwHwJtLW9X2/mGYXW/cEd1f7NiXgIR1Rd7AOatpHgQH5rZJVjh95wd2oOUCRFeDS1b5g6bxO+AXR5gKReAc12uomJyHIsoTnbud5dH35vMsE1w+9GyakTqhv7gx5uf5PaEfEa9aLP69UTQtJ/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778892472; c=relaxed/simple;
	bh=UvlHrH46vzsc5RaH9f9FrtHUELWltSASPe0q1qxZzr0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=oefH+ERfmnrqEhpPChzmFCaqqY3n7r0G0xEpIQXAWrlTOtr1+wawd0lFbIcf6LxyaHcnzzb5DDiIjEO+AW/+f9OvCuO3SeSeOEEtB2KIFfIvEnMBHBgNH+byFo6/C9AXz0ujM3Ah6zTp9ZwbqYXYzpGRqTm5PeDtM9Q4mXBm3Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 82A2492009C; Sat, 16 May 2026 02:47:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 7B02E92009B;
	Sat, 16 May 2026 01:47:41 +0100 (BST)
Date: Sat, 16 May 2026 01:47:41 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
    Leon Romanovsky <leon@kernel.org>
cc: Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
    =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: Export pci_parent_bus_reset() for drivers
 to use
In-Reply-To: <88ecd8d4-f3b4-4bdf-905f-a54c84ad8bce@cornelisnetworks.com>
Message-ID: <alpine.DEB.2.21.2605160145500.22700@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2605050042390.46195@angie.orcam.me.uk> <alpine.DEB.2.21.2605050051390.46195@angie.orcam.me.uk> <20260512090006.GQ15586@unreal> <alpine.DEB.2.21.2605121104560.46195@angie.orcam.me.uk> <20260514153927.GQ15586@unreal>
 <88ecd8d4-f3b4-4bdf-905f-a54c84ad8bce@cornelisnetworks.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: A2FCC559994
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20794-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[orcam.me.uk];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[macro@orcam.me.uk,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,angie.orcam.me.uk:mid]
X-Rspamd-Action: no action

On Thu, 14 May 2026, Dennis Dalessandro wrote:

> > >   Dennis, please clarify your position, and if you'd rather this change
> > > wasn't made, then I'll drop the patches from my local verification setup
> > > and won't offer them again.
> > 
> > Let me put on my RDMA maintainer hat.
> > 
> > Since hfi1 is the only user of this newly exported symbol,
> > and it resides within RDMA, please drop this patch.
> 
> I would agree there.

 OK, thank you both for the advice.

  Maciej

