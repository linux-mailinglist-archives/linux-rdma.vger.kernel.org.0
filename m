Return-Path: <linux-rdma+bounces-19463-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGlbD1Rr6GlZKAIAu9opvQ
	(envelope-from <linux-rdma+bounces-19463-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2026 08:31:48 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2C34426FB
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2026 08:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 72072302A7EC
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2026 06:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2154F30F7F2;
	Wed, 22 Apr 2026 06:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AYnh6nBA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7FE611E;
	Wed, 22 Apr 2026 06:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776839488; cv=none; b=gOgztwyxRimW5ThvCxksf6qir5yruj2FJFcoQYiyKzpjVdcF6uHCbKdAFYyCKuiTsqpTrb+ou2vmgdSWmA6d1DRAWGbKmIJC2rKfziqx+2tbHTlGYSW9sIr2TiKRF/XU+8rIurldodlMmZKnUU2n7zcLq/i8Ld27lU9THi+p7+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776839488; c=relaxed/simple;
	bh=/JT1rsE/fdDROiyJO102hPNDshNNfAOJHHfQze3eg7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ka2BDknzoYu08Dchuci+7pHeJL3fQvQUH/ZBoIrBvO5Te2Xx9EH96Z3AbJ2UQHpurpxWCpzzeXUVOS2FulD/BWNC0VUgeNcxzcxy2TeQDaj5rLIla73VIIWPHWNlJAKYX7O97c/BugsnmcyELJl5UeAxOnOo1w7bjERUOhVzYbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AYnh6nBA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9KHfvF8nokltrExzeaFD2wVzc+NQpqCVu7IQeK1vLBU=; b=AYnh6nBAIEtRV/3Za0zvlwkc1e
	IizRdKc/IXPcB160FeEwYDKxNKGMlRRi69e+5aJmRrHQOKHERhKkys3t/zNnjgVNmMKBPDGX7zrPV
	xNMKq/cEOVF4FpEEH/IQDcO4ZykMN5gooB2TIso4lYXYLydSpwwOutjk685D+WLCytF4yt792GpIo
	nesjXd7MLcaX9s9KyPZ6XaT2ndG8SHI3QT1iIU4xZ/GFMbyd1FXhoITNNmY+HDd6zH043Ito4BJqO
	TPYi6BV5j9MQXm87kIA2Mse/1zhYRqrhySzrlQKqBhg4FXVRlnxhv6tk7qHf8Aim0jCA312NF8WWN
	6XKMnj5Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFR7P-00000009fKY-064M;
	Wed, 22 Apr 2026 06:31:27 +0000
Date: Tue, 21 Apr 2026 23:31:26 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Stefan Metzmacher <metze@samba.org>
Cc: linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Steve French <smfrench@gmail.com>, Tom Talpey <tom@talpey.com>,
	Long Li <longli@microsoft.com>, Namjae Jeon <linkinjeon@kernel.org>,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] smb: smbdirect: move fs/smb/common/smbdirect/ to
 fs/smb/smbdirect/
Message-ID: <aehrPuY60VMcYGU8@infradead.org>
References: <20260419192018.3046449-1-metze@samba.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260419192018.3046449-1-metze@samba.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.samba.org,linux-foundation.org,gmail.com,talpey.com,microsoft.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-19463-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,infradead.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AB2C34426FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> diff --git a/fs/smb/Makefile b/fs/smb/Makefile
> index 9a1bf59a1a65..353b1c2eefc4 100644
> --- a/fs/smb/Makefile
> +++ b/fs/smb/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  obj-$(CONFIG_SMBFS)		+= common/
> +obj-$(CONFIG_SMBDIRECT)		+= smbdirect/

Why is this not in net/smbdirect/ or driver/infiniband/ulp/smdirect?

As far as I can tell there is zero file system logic in this code.

> -#include "../common/smbdirect/smbdirect_public.h"
> +#include "../smbdirect/public.h"

And all these relative includes suggest you really want a
include/linux/smdirect/ instead.

While we're at it: __SMBDIRECT_EXPORT_SYMBOL__ is really odd.
One thing is the __ pre- and postfix that make it look weird.

The other is that EXPORT_SYMBOL_FOR_MODULES is for very specific
symbols that really should not exported.  What this warrants instead
is a normal EXPORT_SYMBOL_NS_GPL.


