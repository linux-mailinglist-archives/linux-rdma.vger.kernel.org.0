Return-Path: <linux-rdma+bounces-16913-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFXHAvbwkmlA0QEAu9opvQ
	(envelope-from <linux-rdma+bounces-16913-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 11:27:02 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A24142561
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 11:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BA553011113
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 10:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560932FFDD6;
	Mon, 16 Feb 2026 10:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mDwJoE6l";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5zJWdHoe";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mDwJoE6l";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5zJWdHoe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A122FF677
	for <linux-rdma@vger.kernel.org>; Mon, 16 Feb 2026 10:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771237614; cv=none; b=SK3VMhAqImZ2VkvdQHj2EWM/N7EPbB3P5iefZyTJ4d5/weAOS6r3E2wI6bWO3LW/WH9OWFWZaugEgsOQzn0GVMY/UIv4fQqt3d+mVWxcUba4iEwssqOSb6bqZWPSo9gxNmq2Hto8BKshdxZ+7o4mZWQlSKYdXC7nkEydzVgZqdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771237614; c=relaxed/simple;
	bh=VpS1jREeXNOktCV2b7BBtqTk78zhODwbK/VNIF5TEP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PuXS2A9g66P+tYn0/npFFtZTTMg6j/gCfoGZFqAkrrf7ANwFjUn1EmhLDLD8sxBJJFIoTJSHvOFIQRR7AUJDf4Z23tuY07lQkpExJPfahKwPjlsFQ4vxFj0ivv82CFjl2pUu61nK/ZXomvCDok1oYoBxUyZGr6Hdat6Dj8pX8qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mDwJoE6l; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5zJWdHoe; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mDwJoE6l; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5zJWdHoe; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 709F33E6EF;
	Mon, 16 Feb 2026 10:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771237611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jiR2ZjzsH+TbpZ8dWUKhjhEhCBp20SYV/pfGiHv004o=;
	b=mDwJoE6lYGSqy7KgYWfcFgECanCDZk3awgJswbfWfXzGi59AklgDKjf9QW7RgloTdY1gP0
	jg/HuBnUpslZvoOSNWDe0fvUtP5PSEPPs1dl9qW4OibFT8DyTuAWsR3vbywH1v7zxcCmiT
	FU51Fbigzoq1wo/fqnFsTSuN+6PTjyk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771237611;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jiR2ZjzsH+TbpZ8dWUKhjhEhCBp20SYV/pfGiHv004o=;
	b=5zJWdHoemC5WLO6iPVN83AklrTl41tBz+T3lk+62U+eCBTPwh373uShG+sfkVdNUVJzfil
	Ku810sqGtu8uucCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mDwJoE6l;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5zJWdHoe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771237611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jiR2ZjzsH+TbpZ8dWUKhjhEhCBp20SYV/pfGiHv004o=;
	b=mDwJoE6lYGSqy7KgYWfcFgECanCDZk3awgJswbfWfXzGi59AklgDKjf9QW7RgloTdY1gP0
	jg/HuBnUpslZvoOSNWDe0fvUtP5PSEPPs1dl9qW4OibFT8DyTuAWsR3vbywH1v7zxcCmiT
	FU51Fbigzoq1wo/fqnFsTSuN+6PTjyk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771237611;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jiR2ZjzsH+TbpZ8dWUKhjhEhCBp20SYV/pfGiHv004o=;
	b=5zJWdHoemC5WLO6iPVN83AklrTl41tBz+T3lk+62U+eCBTPwh373uShG+sfkVdNUVJzfil
	Ku810sqGtu8uucCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 54E743EA64;
	Mon, 16 Feb 2026 10:26:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Jqu0FOvwkmkONgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 16 Feb 2026 10:26:51 +0000
Date: Mon, 16 Feb 2026 11:26:42 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, 
	"nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: blktests failures with v6.19 kernel
Message-ID: <1a4f4064-8352-49c3-a7f5-3883c2c13025@flourine.local>
References: <aY7ZBfMjVIhe_wh3@shinmob>
 <6ad314f7-f3d2-495a-b1ef-a81a06498952@flourine.local>
 <f26001d6-062e-402b-8acd-46a737523e23@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f26001d6-062e-402b-8acd-46a737523e23@nvidia.com>
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16913-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dwagner@suse.de,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,flourine.local:mid]
X-Rspamd-Queue-Id: 65A24142561
X-Rspamd-Action: no action

Hi Chaitanya,

On Sat, Feb 14, 2026 at 09:19:47PM +0000, Chaitanya Kulkarni wrote:
> On 2/13/26 01:56, Daniel Wagner wrote:
> > nvmet_fc_target_assoc_free runs in the nvmet_wq context and calls
> >
> >    nvmet_fc_delete_target_queue
> >      nvmet_cq_put
> >        nvmet_cq_destroy
> >          nvmet_ctrl_put
> >           nvmet_ctrl_free
> >             flush_work(&ctrl->async_event_work);
> >             cancel_work_sync(&ctrl->fatal_err_work);
> >   
> > The async_event_work could be running on nvmet_wq. So this deadlock is
> > real. No idea how to fix it yet.
> >
> 
> Can following patch be the potential fix for above issue as well ?
> totally untested ...

Yes this should work. I was not so happy adding a workqueue for this but
after looking at nvme, this seems acceptable approach. Though, I'd make
nvmet follow the nvme and instead adding an AEN workqueue, rather have a
nvmet-reset-wq or nvmet_delete-wq.

Thanks,
Daniel

