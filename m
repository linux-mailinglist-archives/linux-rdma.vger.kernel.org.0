Return-Path: <linux-rdma+bounces-7291-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74238A21237
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jan 2025 20:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0B453A6AC1
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jan 2025 19:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938251DFD9B;
	Tue, 28 Jan 2025 19:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="X7DzgIEI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gjs0esMU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y688SLY7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9Rahx42h"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5B01D61B1;
	Tue, 28 Jan 2025 19:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738092507; cv=none; b=l7YZFMKcCjRQvQY81vFJoelnz2e/BEBGbUvtBWEtUaaFD2soJvX2zhoJBVtXtGwivNIxXdrgRS3ii8HygqJsZso31H6WkPfxp+YrpS3JGIvOluSNWDwUSwIxC8MdbtUN+D7aMpC7+N7UtY2FTKjnroXZc2bKPth1PskBr6pHfYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738092507; c=relaxed/simple;
	bh=n5k+kdOWFCqZ0uk5hOxAOpLLJkFFgvcFWETQFqM2RQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UUu4eFR40zzSH2EXMOHiwYtJd/SzYn73s+RjzRZ/7+P6AwQam/46t/382j8Dpp7XbJyuFgrx/+aqAUdPd7HtzZKBw/a3V2bUcXQzEGSuYR8aBubgYv8NfhIAD17UD2adLGzFMNQHxk0KX6TiJJXRmqM1GmvqLpmiwE86SIaQVSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=X7DzgIEI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gjs0esMU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y688SLY7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9Rahx42h; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 40D7E210F9;
	Tue, 28 Jan 2025 19:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738092497;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cu5AW9e6LIlMe18vHX/cu2btQmvEuNdVbxSGH23BpgQ=;
	b=X7DzgIEIos5paB261Thz8Qi51sOVFwb5dSUTRRMycQLt/5T7754KjcgbjT+EPwV5fdLaaa
	cvSOk6TY2qEeLsUeC5G5KNg4CQMIkX2ooAejwo/XceW1/fc11wYZyhlGSl7Q8n+cEjO9OJ
	Ii8fxytnZFdNjyQYJ4iJxYMOiaYZluU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738092497;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cu5AW9e6LIlMe18vHX/cu2btQmvEuNdVbxSGH23BpgQ=;
	b=gjs0esMUPchB4K4RtIem58fDt+M6QJS4Mh5QJBMLR40KmpfdO9OR+d1oMn3UBKFmkmzEEt
	+M/96OKGcvLSGHBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=y688SLY7;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9Rahx42h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738092496;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cu5AW9e6LIlMe18vHX/cu2btQmvEuNdVbxSGH23BpgQ=;
	b=y688SLY7/DL5p8EccbkUszio2tZbA94boT4rwz+ACMq588fgH+Vf8EqkXANQNYWiQFG7DT
	anyf2Nx63Z/9IvWw9iThlkRnAXfe4qWQrFOQ8ghtd0mhYInrapGCBP4qDwcTlbxOa+r+Gv
	qtAW+mLbxCjg/w5prt5Mp5mE0k5zC1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738092496;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cu5AW9e6LIlMe18vHX/cu2btQmvEuNdVbxSGH23BpgQ=;
	b=9Rahx42hI6P64ZFl8I0lTTg8Zv21R573Kl+t/8z5GIP+ELkdKbRYFovpEy1CA3oSmAZSUq
	/XJL5V34JZcxoYCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B4BB313625;
	Tue, 28 Jan 2025 19:28:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MMhrK88vmWf/FgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 28 Jan 2025 19:28:15 +0000
Date: Tue, 28 Jan 2025 20:28:14 +0100
From: David Sterba <dsterba@suse.cz>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Yaron Avizrat <yaron.avizrat@intel.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	James Smart <james.smart@broadcom.com>,
	Dick Kennedy <dick.kennedy@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Ilya Dryomov <idryomov@gmail.com>,
	Dongsheng Yang <dongsheng.yang@easystack.cn>,
	Jens Axboe <axboe@kernel.dk>, Xiubo Li <xiubli@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, Carlos Maiolino <cem@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	cocci@inria.fr, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-sound@vger.kernel.org, linux-btrfs@vger.kernel.org,
	ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,
	ibm-acpi-devel@lists.sourceforge.net, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 05/16] btrfs: convert timeouts to secs_to_jiffies()
Message-ID: <20250128192814.GZ5777@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
 <20250128-converge-secs-to-jiffies-part-two-v1-5-9a6ecf0b2308@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128-converge-secs-to-jiffies-part-two-v1-5-9a6ecf0b2308@linux.microsoft.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 40D7E210F9
X-Spam-Level: 
X-Spamd-Result: default: False [-2.71 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,intel.com,kernel.org,inria.fr,imag.fr,broadcom.com,HansenPartnership.com,oracle.com,perex.cz,suse.com,fb.com,toxicpanda.com,gmail.com,easystack.cn,kernel.dk,redhat.com,lst.de,grimberg.me,nxp.com,pengutronix.de,amd.com,linux.intel.com,hmh.eng.br,ziepe.ca,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,lists.linux.dev,lists.sourceforge.net];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_GT_50(0.00)[59];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.cz:dkim,suse.cz:mid,suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.71
X-Spam-Flag: NO

On Tue, Jan 28, 2025 at 06:21:50PM +0000, Easwar Hariharan wrote:
> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
> secs_to_jiffies().  As the value here is a multiple of 1000, use
> secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplication.
> 
> This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with
> the following Coccinelle rules:
> 
> @depends on patch@
> expression E;
> @@
> 
> -msecs_to_jiffies
> +secs_to_jiffies
> (E
> - * \( 1000 \| MSEC_PER_SEC \)
> )
> 
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>

Acked-by: David Sterba <dsterba@suse.com>

