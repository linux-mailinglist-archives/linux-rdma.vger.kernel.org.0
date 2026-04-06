Return-Path: <linux-rdma+bounces-19008-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id DbmeN5NH02ngggcAu9opvQ
	(envelope-from <linux-rdma+bounces-19008-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 07:41:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1A23A1A1A
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 07:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 183F83007F55
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Apr 2026 05:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CCF31F982;
	Mon,  6 Apr 2026 05:41:34 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D8F281369;
	Mon,  6 Apr 2026 05:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775454094; cv=none; b=qgv+NZFSc3WkVvBcjY//7CM+Y5ypl26Vw32uL5kkyLVDbS7Fhnl0Ob6PLNfy1FtjSAZYn/fPwES2SZlNi7uDJqVWPxZAd9ni0dT5/e8jrfzNeTDF5xVdPn+GsfIOMtjLrlRhlFXb4duTun/eQFK0EL87/D1ZIXbtdEPVsV4H3+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775454094; c=relaxed/simple;
	bh=QNjLM5ADmcR/CvZE/zV9+Oy0hRi/d68OKV29zEfhLXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uSqtleJ10J53ZqeiboPOyhA9TZYl1fQw1UqoBCr5hxO818OSfWj5WrZqPgRXXeeVsNkisU169j5SZTJ/hR4X8mMvAWuipILPZ+Ljr/DxxZ3AFUHMO8z+Afs3SWGFM1q7Mikk1OvZUVt5Nz5h3AGwuZYENMehCWKK+gmjghlvtQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D17A868BFE; Mon,  6 Apr 2026 07:41:20 +0200 (CEST)
Date: Mon, 6 Apr 2026 07:41:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Shivaji Kant <shivajikant@google.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pranjal Shrivastava <praan@google.com>
Subject: Re: [RFC PATCH v2] nvme: enable PCI P2PDMA support for RDMA
 transport
Message-ID: <20260406054120.GA16443@lst.de>
References: <20260402073001.2039625-1-shivajikant@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402073001.2039625-1-shivajikant@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.954];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19008-lists,linux-rdma=lfdr.de];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:mid]
X-Rspamd-Queue-Id: 5D1A23A1A1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 07:30:01AM +0000, Shivaji Kant wrote:
> Enable BLK_FEAT_PCI_P2PDMA on the NVMe when the underlying
> RDMA controller supports it.

You can use up to 73 characters per line.
> 
> This patch depends on the PCI P2PDMA support added in this
> patch [1].

I don't think it actually does.  To support multi-path capable RDMA
controllers, and those the vast majority, you need the multipath
support.  But for non-multipath capable controllers your patch
just works.  So I'd suggest to drop this paragraph and reference
from the commit log.

Otherwise looks good.


