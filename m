Return-Path: <linux-rdma+bounces-19968-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id p7WTAeAz+Wl46gIAu9opvQ
	(envelope-from <linux-rdma+bounces-19968-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 02:03:44 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 755364C514C
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 02:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A05863008FFA
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2026 00:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126891B808;
	Tue,  5 May 2026 00:03:39 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C471540DFDA;
	Tue,  5 May 2026 00:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777939418; cv=none; b=KqtiqckcIiA9whGhr349N4Wet9VRbtO2iwPpmevWBupJbB8AWZUzYqbVltEpEjR9mcsjojcomMG6KqUKmA/fSC5BYeGNFyDvVFQ7Fd7jaNwvcnC97rL9CR2Q1kFzZykMIp5JsyrQ8/tdswa1S4AI/8Zh2buqcrsVmLyzbrE6H/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777939418; c=relaxed/simple;
	bh=8I/hVAxtgOoP2n2/kmLok5hTmrkCfguXUluau3/Oqr0=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=Nnsgvg+OTa5Nm1D8AFkmj0byImAKJ8Ujy9GH49uMD/Ae1siwkZd5mxsfZiakkRAGpFrl7NaGYjGUkPtp1QFAhUxWZcMUoo6HsYaTGohG9ZWz9xhV9IE87GtT78B72qsQP+S1KYb38EteZFP8tg3+s882s+dPxjDF4ZtxxZ37PMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 5196092009C; Tue,  5 May 2026 02:03:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 4A75792009B;
	Tue,  5 May 2026 01:03:34 +0100 (BST)
Date: Tue, 5 May 2026 01:03:34 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Bjorn Helgaas <bhelgaas@google.com>, 
    Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
    Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] PCI+IB/hfi1: Fold duplicate secondary bus reset
 code
Message-ID: <alpine.DEB.2.21.2605050042390.46195@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 755364C514C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19968-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[orcam.me.uk];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[macro@orcam.me.uk,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.912];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[angie.orcam.me.uk:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Hi,

 This v2 of the patch series addresses a documentation issue raised in v1.

 In the course of verifying my PCIe link training failure workaround (cf. 
<https://lore.kernel.org/r/alpine.DEB.2.21.2305310024400.59226@angie.orcam.me.uk/>) 
in the context of secondary bus reset handling I found a piece of code in 
the InfiniBand HFI1 driver that duplicates what we already have as private 
code in PCI core.  This patch series removes this duplication by exporting 
said private code and than making use of it in the HFI1 driver.

 As I have no means to run-time verify InfiniBand code I have only build 
these patches, for x86-64, with the HFI1 driver both built in and modular.
Please see individual change descriptions for further details.

 Please consider.

 Previous iterations:

- v1 at: <https://lore.kernel.org/r/alpine.DEB.2.21.2306200153110.14084@angie.orcam.me.uk/>.

  Maciej

