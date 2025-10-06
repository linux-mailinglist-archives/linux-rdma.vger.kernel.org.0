Return-Path: <linux-rdma+bounces-13786-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9C8BBE074
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Oct 2025 14:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F108E4EBD58
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Oct 2025 12:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7479E27F19F;
	Mon,  6 Oct 2025 12:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qYELF5GQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="crxqOEWA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i9FFLlfw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KLmWKvyW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C96F9C1
	for <linux-rdma@vger.kernel.org>; Mon,  6 Oct 2025 12:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759753845; cv=none; b=s2rJBAWmLEkq9+bXzQMTs8aFLHM/sT00t9P1hfFUulPDWhEbxC5hGz9HzT/dBbaIOa7ZIkNVItgD1w++WR7gND3BW6M/tXy8Kemy1dQGj4XPA5JDQmrjevc6p00YPrkqbfLzIbgjhoR4egSyfQL25OgaBaiZ2hd41zl+N8+mh2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759753845; c=relaxed/simple;
	bh=8WgKRqMJPSYfkRP5kOqAcrkJUwR6La9YOMWBWAGjIFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FfdbXIrgLCHgr6jml/PATRC0dVjMpNs8BSLZ2/sal2vysurQFyivGIqPheV9swewRQ9g3lUL7HdB4uX9faX77dZqeIV4CSTx52DFKczUXt9faEzgwwdV1Q3ScpfcXchR0WlGQIp5tU27vfs0OlQD1fmtIqh7Jc94Hr/RaDpTuMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qYELF5GQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=crxqOEWA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i9FFLlfw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KLmWKvyW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BDC4D336CB;
	Mon,  6 Oct 2025 12:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759753842; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DH/E8tdqQkikeQeW9VrxwMtlsxz2Qi0OG9Sx1VZcu7Q=;
	b=qYELF5GQ/fEzIt6b6U/00fnf8TZ4Am9FPXKWPtwfM2jNyOIHcAiJUmj6vTLEB1sTpsQBS5
	2RVl1SNqRt6kE+l0zwPAzWSBsbK6MVE69gUNxLrnsb80VLa6IUgECnqGq5mV5YFpQj2uiF
	k13SsPzszmzPE07BrK6HwwmEhEmdKz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759753842;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DH/E8tdqQkikeQeW9VrxwMtlsxz2Qi0OG9Sx1VZcu7Q=;
	b=crxqOEWAKQga4pFbqrJrAPtOIrT9lTPYsnddKqsPCPaB2cX/gIIm/zikz36s6JNoBnXr9/
	XlagKGba+KJdj1BQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=i9FFLlfw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=KLmWKvyW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759753840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DH/E8tdqQkikeQeW9VrxwMtlsxz2Qi0OG9Sx1VZcu7Q=;
	b=i9FFLlfwoi6YO3QSmRJX2BbkmHa/vi/HYrvDb8+80Z6+fo6dHWx6n4FU7Uhhreem7fvng/
	3XwvaEm1BuRvxMTLOfYUlf64xOjxyS2tRqcRPADMzDw76sKu3IO+R3BInbHhr1U1X9kbHV
	lAKIs/EYEmuOfnSzCIp1uhkBW6M9Jys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759753840;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DH/E8tdqQkikeQeW9VrxwMtlsxz2Qi0OG9Sx1VZcu7Q=;
	b=KLmWKvyW/TQznlozFKG995pOwzVwtAuHepkeU1dXa1VBokbG36OsFgtyjvepq6mXh9Xf2x
	fI7q0uXX/AqgndBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A451213995;
	Mon,  6 Oct 2025 12:30:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Uc4oJ3C242hwdwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 06 Oct 2025 12:30:40 +0000
Date: Mon, 6 Oct 2025 14:30:32 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, 
	"nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: blktests failures with v6.17 kernel
Message-ID: <6f615e86-d160-41a2-a078-478406e4c749@flourine.local>
References: <3bbujxlhhzxufnihiyhssmknscdcqt7igyvzbhwf3sxdgbruma@kw5cf6u5npan>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bbujxlhhzxufnihiyhssmknscdcqt7igyvzbhwf3sxdgbruma@kw5cf6u5npan>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: BDC4D336CB
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

On Thu, Oct 02, 2025 at 10:35:48AM +0000, Shinichiro Kawasaki wrote:
> #2: nvme/041 (fc transport)
> 
>     The test case nvme/041 fails for fc transport. Refer to the report for the
>     v6.12 kernel [4].
> 
>     [4] https://lore.kernel.org/linux-nvme/6crydkodszx5vq4ieox3jjpwkxtu7mhbohypy24awlo5w7f4k6@to3dcng24rd4/

Thanks for reminding me. I'll have to update the nvme-fc-sync series
This should finally allow to pass all tests for the FC transport. 

[1] https://lore.kernel.org/linux-nvme/20250829-nvme-fc-sync-v3-0-d69c87e63aee@kernel.org/

