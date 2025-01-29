Return-Path: <linux-rdma+bounces-7303-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E062A21A42
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jan 2025 10:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F21F11664E1
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jan 2025 09:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B744F1AF0C7;
	Wed, 29 Jan 2025 09:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i5Mwxy/R";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pmRhPydC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i5Mwxy/R";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pmRhPydC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C741CAB3;
	Wed, 29 Jan 2025 09:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738144024; cv=none; b=nwoMF9/YuZQIW6mkx4xw89czMem5HtKo+SNZi8LEppW1aPnBU6kJMIrnK42kryYfa9OUvLUvuhOn/vPaq20bj5Q9dEJrhhKPBY6lloXj9ic+DxJd3d6nS3ggcKQ7Wtb8hRvehBIhUm8n/RBB8uHrkVZ7CseTc5ushPfoarbzNc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738144024; c=relaxed/simple;
	bh=2tmtqzDlpvJYjOhymjjxXT2d5hZdqgkkSfR6apUc4LU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FqE/gwuVPySoE0WXAd2B3AmCF0OFoHbiceZE5nNcQU1543krnjXCSjXM5JpltQqGcP4Ww7iHcLUWlZf/PZ6VdLgNkN3SxnRDbLc4X1vBhJUxyFUnJmts/45la1LSg5cUwFr41mdkbuACjTTxjlOAVHG8rd1BoUm7GqtvXmfAa8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i5Mwxy/R; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pmRhPydC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i5Mwxy/R; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pmRhPydC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BC3B51F365;
	Wed, 29 Jan 2025 09:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738144014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5GnOF+VEY7TThX1eeQY6brGBNSRNv8obohwk3AJ667M=;
	b=i5Mwxy/RNBFOPwFWyefOclI67Mfl4LeClU7BnbzMU2Z49ioZnnFhEdIes2aDRWIG5Qpb0p
	rLBunYuvEC7qM4x5OkOhkaKWeK+V8WjsDgKTMLf0D51Ecutz5uFtjpJqDsgAbMqJDTQ7GK
	s83Yq9bri99hD1Q5u+s3qZtg9o5bDOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738144014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5GnOF+VEY7TThX1eeQY6brGBNSRNv8obohwk3AJ667M=;
	b=pmRhPydCZ+RgrhzOPZu1wdQVPJGdMmu2lFLf4y8etatrnARzlhrJMUPMdZgyI5WSug4evo
	LP9tmUY05JKAOgCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="i5Mwxy/R";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pmRhPydC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738144014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5GnOF+VEY7TThX1eeQY6brGBNSRNv8obohwk3AJ667M=;
	b=i5Mwxy/RNBFOPwFWyefOclI67Mfl4LeClU7BnbzMU2Z49ioZnnFhEdIes2aDRWIG5Qpb0p
	rLBunYuvEC7qM4x5OkOhkaKWeK+V8WjsDgKTMLf0D51Ecutz5uFtjpJqDsgAbMqJDTQ7GK
	s83Yq9bri99hD1Q5u+s3qZtg9o5bDOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738144014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5GnOF+VEY7TThX1eeQY6brGBNSRNv8obohwk3AJ667M=;
	b=pmRhPydCZ+RgrhzOPZu1wdQVPJGdMmu2lFLf4y8etatrnARzlhrJMUPMdZgyI5WSug4evo
	LP9tmUY05JKAOgCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6489C137DB;
	Wed, 29 Jan 2025 09:46:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C9NOFw35mWf7LAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 29 Jan 2025 09:46:53 +0000
Date: Wed, 29 Jan 2025 10:46:53 +0100
Message-ID: <87o6zq6jg2.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,	Yaron Avizrat
 <yaron.avizrat@intel.com>,	Oded Gabbay <ogabbay@kernel.org>,	Julia Lawall
 <Julia.Lawall@inria.fr>,	Nicolas Palix <nicolas.palix@imag.fr>,	James Smart
 <james.smart@broadcom.com>,	Dick Kennedy <dick.kennedy@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,	Jaroslav Kysela
 <perex@perex.cz>,	Takashi Iwai <tiwai@suse.com>,	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,	David Sterba <dsterba@suse.com>,	Ilya
 Dryomov <idryomov@gmail.com>,	Dongsheng Yang <dongsheng.yang@easystack.cn>,
	Jens Axboe <axboe@kernel.dk>,	Xiubo Li <xiubli@redhat.com>,	Damien Le Moal
 <dlemoal@kernel.org>,	Niklas Cassel <cassel@kernel.org>,	Carlos Maiolino
 <cem@kernel.org>,	"Darrick J. Wong" <djwong@kernel.org>,	Sebastian Reichel
 <sre@kernel.org>,	Keith Busch <kbusch@kernel.org>,	Christoph Hellwig
 <hch@lst.de>,	Sagi Grimberg <sagi@grimberg.me>,	Frank Li
 <Frank.Li@nxp.com>,	Mark Brown <broonie@kernel.org>,	Shawn Guo
 <shawnguo@kernel.org>,	Sascha Hauer <s.hauer@pengutronix.de>,	Pengutronix
 Kernel Team <kernel@pengutronix.de>,	Fabio Estevam <festevam@gmail.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,	Hans de Goede
 <hdegoede@redhat.com>,	Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,	Henrique de Moraes Holschuh
 <hmh@hmh.eng.br>,	Selvin Xavier <selvin.xavier@broadcom.com>,	Kalesh AP
 <kalesh-anakkur.purayil@broadcom.com>,	Jason Gunthorpe <jgg@ziepe.ca>,	Leon
 Romanovsky <leon@kernel.org>,	cocci@inria.fr,
	linux-kernel@vger.kernel.org,	linux-scsi@vger.kernel.org,
	dri-devel@lists.freedesktop.org,	linux-sound@vger.kernel.org,
	linux-btrfs@vger.kernel.org,	ceph-devel@vger.kernel.org,
	linux-block@vger.kernel.org,	linux-ide@vger.kernel.org,
	linux-xfs@vger.kernel.org,	linux-pm@vger.kernel.org,
	linux-nvme@lists.infradead.org,	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,	linux-arm-kernel@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,	ibm-acpi-devel@lists.sourceforge.net,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH 04/16] ALSA: ac97: convert timeouts to secs_to_jiffies()
In-Reply-To: <20250128-converge-secs-to-jiffies-part-two-v1-4-9a6ecf0b2308@linux.microsoft.com>
References: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
	<20250128-converge-secs-to-jiffies-part-two-v1-4-9a6ecf0b2308@linux.microsoft.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: BC3B51F365
X-Spam-Score: -2.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,intel.com,kernel.org,inria.fr,imag.fr,broadcom.com,HansenPartnership.com,oracle.com,perex.cz,suse.com,fb.com,toxicpanda.com,gmail.com,easystack.cn,kernel.dk,redhat.com,lst.de,grimberg.me,nxp.com,pengutronix.de,amd.com,linux.intel.com,hmh.eng.br,ziepe.ca,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,lists.linux.dev,lists.sourceforge.net];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_GT_50(0.00)[59];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, 28 Jan 2025 19:21:49 +0100,
Easwar Hariharan wrote:
> 
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

Acked-by: Takashi Iwai <tiwai@suse.de>


thanks,

Takashi


> ---
>  sound/pci/ac97/ac97_codec.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
> index 6e710dce5c6068ec20c2da751b6f5372ad1df211..88ac37739b7653f69af430dd0163f5ab4ddf0d0c 100644
> --- a/sound/pci/ac97/ac97_codec.c
> +++ b/sound/pci/ac97/ac97_codec.c
> @@ -2461,8 +2461,7 @@ int snd_ac97_update_power(struct snd_ac97 *ac97, int reg, int powerup)
>  		 * (for avoiding loud click noises for many (OSS) apps
>  		 *  that open/close frequently)
>  		 */
> -		schedule_delayed_work(&ac97->power_work,
> -				      msecs_to_jiffies(power_save * 1000));
> +		schedule_delayed_work(&ac97->power_work, secs_to_jiffies(power_save));
>  	else {
>  		cancel_delayed_work(&ac97->power_work);
>  		update_power_regs(ac97);
> 
> -- 
> 2.43.0
> 

