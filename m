Return-Path: <linux-rdma+bounces-12944-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F9DB37FBC
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Aug 2025 12:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91FB97A9CAE
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Aug 2025 10:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB985346A10;
	Wed, 27 Aug 2025 10:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Sx5RwQl4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IydAXml5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Sx5RwQl4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IydAXml5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CF730AD06
	for <linux-rdma@vger.kernel.org>; Wed, 27 Aug 2025 10:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756289966; cv=none; b=W3XwLDZZEH563Z4+y8w1AM1DsHyTPKMxkLNZ2rNNfp43FlOifgFeLy/5nH5fjIi3W1th7b7ZOKrcwVApo4Nttrnwg7Jl/tZczJ2mKpRwlvhgmj1JR103XAoEvfY3Ngo+XkYAsRQf/cMucQNyyASa784DWnuALqX8TtEopfo6/I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756289966; c=relaxed/simple;
	bh=dCfxmqI5NQievIDHdaUucZ8EXZqp2k9O4S3tudNYjfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hB2zXJ1cdpXcnR4Q0qTW4ULptZG4Ysb2aPm+CCxpB01Vbl6nrlzv1bdfejdiSxVWULxC7ykgkOzB/qrDj8boh8Vfp/5VHqnN/uX4oOlwDO4zDOPvewn17Q3Qgpi++KCawWGC32MTYHvWgsSc1rkGZtvCoFg6fWbHzzOOA59pgJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Sx5RwQl4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IydAXml5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Sx5RwQl4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IydAXml5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1304D22221;
	Wed, 27 Aug 2025 10:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756289427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NxE5rKnj5TjaBsXbpbII/rsOANqwX+dNrTnexSalI0E=;
	b=Sx5RwQl4mdrvGKXWphXUQ0hvtykvK3pbomkWvnnY3C/J3xN+x2ZHAOSBJLxC4GLt4+IHP6
	fhIb397Tjh7ZItBttJVZrcn5W6MbblkxSPnUuMkh2m4qZnlZylUmCvuzsNJNQDI/fgYDPT
	CxFKOH1aH8JG61b+9eFz6FNE5WZULgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756289427;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NxE5rKnj5TjaBsXbpbII/rsOANqwX+dNrTnexSalI0E=;
	b=IydAXml5RA8wO5fCwvDAMvtOzsuRqzJS78ZPyZQjET5bKCdXt3mdY6VsEVH2Z8wcR9Zny6
	ul1gwma8lALLX1Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756289427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NxE5rKnj5TjaBsXbpbII/rsOANqwX+dNrTnexSalI0E=;
	b=Sx5RwQl4mdrvGKXWphXUQ0hvtykvK3pbomkWvnnY3C/J3xN+x2ZHAOSBJLxC4GLt4+IHP6
	fhIb397Tjh7ZItBttJVZrcn5W6MbblkxSPnUuMkh2m4qZnlZylUmCvuzsNJNQDI/fgYDPT
	CxFKOH1aH8JG61b+9eFz6FNE5WZULgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756289427;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NxE5rKnj5TjaBsXbpbII/rsOANqwX+dNrTnexSalI0E=;
	b=IydAXml5RA8wO5fCwvDAMvtOzsuRqzJS78ZPyZQjET5bKCdXt3mdY6VsEVH2Z8wcR9Zny6
	ul1gwma8lALLX1Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 038D713310;
	Wed, 27 Aug 2025 10:10:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Z+iAO5LZrmg1JQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 27 Aug 2025 10:10:26 +0000
Date: Wed, 27 Aug 2025 12:10:26 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, 
	"nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: blktests failures with v6.17-rc1 kernel
Message-ID: <ff748a3f-9f07-4933-b4b3-b4f58aacac5b@flourine.local>
References: <suhzith2uj75uiprq4m3cglvr7qwm3d7gi4tmjeohlxl6fcmv3@zu6zym6nmvun>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <suhzith2uj75uiprq4m3cglvr7qwm3d7gi4tmjeohlxl6fcmv3@zu6zym6nmvun>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On Wed, Aug 13, 2025 at 10:50:34AM +0000, Shinichiro Kawasaki wrote:
> #4: nvme/061 (fc transport)
> 
>     The test case nvme/061 sometimes fails for fc transport due to a WARN and
>     refcount message "refcount_t: underflow; use-after-free." Refer to the
>     report for the v6.15 kernel [5].
> 
>     [5]
>     https://lore.kernel.org/linux-block/2xsfqvnntjx5iiir7wghhebmnugmpfluv6ef22mghojgk6gilr@mvjscqxroqqk/

This one might be fixed with

https://lore.kernel.org/linux-nvme/20250821-fix-nvmet-fc-v1-1-3349da4f416e@kernel.org/

