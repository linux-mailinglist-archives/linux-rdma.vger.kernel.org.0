Return-Path: <linux-rdma+bounces-11034-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF93ACEFE1
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Jun 2025 15:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92E0C16FCF0
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Jun 2025 13:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605DD22F765;
	Thu,  5 Jun 2025 13:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IOCIQeVt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="woLlgr8h";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IOCIQeVt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="woLlgr8h"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CEB226177
	for <linux-rdma@vger.kernel.org>; Thu,  5 Jun 2025 13:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749128587; cv=none; b=GpN4u5r321wzgOQWNdHc86ZV5fNQu+4eopoOBKgBaJyu9WP61AbXXjEIfs1A06ZrBXxq5EhsP6pOU9B39qC7S9W2kUpT5KTTLPwH+7p5n7edamA1STTLiU4kAk6MQlUK1GtIV5/j4ll2UWeMf1Mx5W+jyAUOEg+2XiJupjSFPg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749128587; c=relaxed/simple;
	bh=8XhWz1uDUGpc2KEGsQPqoMFu9IbGsBJhR4oTTUhj1g8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQ7MdPuyc5JvjEvX900qkYJDEIT2aXHpnmgSJbJt56xp+D7cLUXaBXsQ2kYarc7X94wUHtWW1RIYuTCnpLfn4sZc+Qzb1kX1x0Df5YB2eqBtDO0/q92zTw9jhusipOjwZJ7w2bxhTr9Y8/L8ZcfFEckHUvH6qJM+FJVuhWwTJAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IOCIQeVt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=woLlgr8h; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IOCIQeVt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=woLlgr8h; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A51E3345B2;
	Thu,  5 Jun 2025 13:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749128583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FiQfaBUdLpG0izU+n3dwo6IxIx6W2D/15BOpRHmYH38=;
	b=IOCIQeVtn3JIpKgPBF/6Dud02iAzz3JWYtG2SdpHp+1qCcZ1m4nN0CbFVlF3wNu7NBFYni
	kEi3N/zmRcADp+nfkm1yMY4WcWZ/nNxKAecjLf0zM8AEd9yWHJy6o1lk16RfkXLLAvA8Cf
	Zne19P9ERQrlULg0r6jADX6SJDFzGvM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749128583;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FiQfaBUdLpG0izU+n3dwo6IxIx6W2D/15BOpRHmYH38=;
	b=woLlgr8ha1Iq6fu8KGJx6OA9UlIWNjM+gZNxEbET5dWYc3AqgyH5tsXsAiiUuZbC7TYyDg
	ed6hC/HX5zK53fDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IOCIQeVt;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=woLlgr8h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749128583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FiQfaBUdLpG0izU+n3dwo6IxIx6W2D/15BOpRHmYH38=;
	b=IOCIQeVtn3JIpKgPBF/6Dud02iAzz3JWYtG2SdpHp+1qCcZ1m4nN0CbFVlF3wNu7NBFYni
	kEi3N/zmRcADp+nfkm1yMY4WcWZ/nNxKAecjLf0zM8AEd9yWHJy6o1lk16RfkXLLAvA8Cf
	Zne19P9ERQrlULg0r6jADX6SJDFzGvM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749128583;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FiQfaBUdLpG0izU+n3dwo6IxIx6W2D/15BOpRHmYH38=;
	b=woLlgr8ha1Iq6fu8KGJx6OA9UlIWNjM+gZNxEbET5dWYc3AqgyH5tsXsAiiUuZbC7TYyDg
	ed6hC/HX5zK53fDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 87D2C137FE;
	Thu,  5 Jun 2025 13:03:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YuG/HoeVQWhxKQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 05 Jun 2025 13:03:03 +0000
Date: Thu, 5 Jun 2025 15:02:54 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, 
	"nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: blktests failures with v6.15 kernel
Message-ID: <7cdceac2-ef72-4917-83a2-703f8f93bd64@flourine.local>
References: <2xsfqvnntjx5iiir7wghhebmnugmpfluv6ef22mghojgk6gilr@mvjscqxroqqk>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2xsfqvnntjx5iiir7wghhebmnugmpfluv6ef22mghojgk6gilr@mvjscqxroqqk>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: A51E3345B2
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.51

Hi,

On Thu, May 29, 2025 at 08:46:35AM +0000, Shinichiro Kawasaki wrote:
> #1: nvme/023
> 
>     When libnvme has version 1.13 or later and built with liburing, nvme-cli
>     command "nvme smart-log" command fails for namespace block devices. This
>     makes the test case nvme/032 fail [2]. Fix in libnvme is expected.
> 
>     [2]
>     https://lore.kernel.org/linux-nvme/32c3e9ef-ab3c-40b5-989a-7aa323f5d611@flourine.local/T/#m6519ce3e641e7011231d955d9002d1078510e3ee

Should be fixed now. If you want, I can do another release soon, so the
fix get packaged up by the distros.

> #2: nvme/041 (fc transport)
> 
>     The test case nvme/041 fails for fc transport. Refer to the report for v6.12
>     kernel [3].
> 
>     [3]
>     https://lore.kernel.org/linux-nvme/6crydkodszx5vq4ieox3jjpwkxtu7mhbohypy24awlo5w7f4k6@to3dcng24rd4/

Is still on my TODO list. Sorry.

> #4: nvme/061 failure (fc transport)
> 
>     The test case nvme/061 sometimes fails due to a WARN [5]. Just before the
>     WARN, The kernel reported "refcount_t: underflow; use-after-free." This
>     failure can be recreated in stable manner by repeating the test case 10
>     times or so.
> 
>     I tried v6.15-rcX kernels. When I ran v6.15-rc1 kernel, the test case always
>     failed with different symptom. With v6.15-rc2 kernel, the test case passed
>     in most runs, but sometimes it failed with the same symptom as v6.15. I
>     guess the nvme-fc changes in v6.15-rc2 fixed most of the refcounting issue,
>     but still rare refcounting failure scenario is left.

The nvmet-fcloop changes for 6.16 should address this (fingers crossed).

Thanks,
Daniel

