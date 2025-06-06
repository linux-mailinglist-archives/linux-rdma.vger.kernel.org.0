Return-Path: <linux-rdma+bounces-11054-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD6EAD045C
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Jun 2025 16:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 316DE3A30BA
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Jun 2025 14:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE45288C15;
	Fri,  6 Jun 2025 14:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aGGGm7oJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YKa4Y/+G";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aGGGm7oJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YKa4Y/+G"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF5027E7CF
	for <linux-rdma@vger.kernel.org>; Fri,  6 Jun 2025 14:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749221923; cv=none; b=BVF/kDE7ikJKlwFn/JLGc2NaMhLQUPcrynsG25DJVnM4YITWRWxPQ+pWmD3jokMK9axh53bHIdGNp2aqdI/+vqG1sT4GDLTN9nerqFJ13QQ/41JTBFanpxJYy6kB64wM99ACq7TXUuiZuKJdjXtjWvd7HcqommiSgHYekdI1uAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749221923; c=relaxed/simple;
	bh=HN2SBWrsjtMR0cSd6DvYN94z+HGQ2n3JZvvJt6jAyW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEeGPO3qxWHDujWfh0rGiA1kJnuLV0oCAUB5jLAmIgenF1OnYAUztjsgURGPh/R8zjoeW1NcwOrZg+Cq+YQIiK1yIfnWtaQZRSbBBuWepzDqHdNf70PZeLx7tg3v79BjyEYGgbr/fhS4ohLr3JF+Bha9eRGnww2TDKqzurjEDZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aGGGm7oJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YKa4Y/+G; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aGGGm7oJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YKa4Y/+G; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0625F1F445;
	Fri,  6 Jun 2025 14:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749221920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ti/Py6dJ0naeNjX5F1k8KYleDnBdjDj8FiSaldxcGVE=;
	b=aGGGm7oJv6CPTBdNX4ovBls6qBfTQ91csqAs1c1CgwtR47QKMIDdgwpck0OQ/ZWWRI9vsZ
	/X5cNY8XqBTM+qbsTtGzXemcMucLr30vEplzjymcorvZlaJZ8lL8SKUmY+5MviFfTfFF2K
	flkJIRBgH62FUsKZblFfUTHnJkTlj8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749221920;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ti/Py6dJ0naeNjX5F1k8KYleDnBdjDj8FiSaldxcGVE=;
	b=YKa4Y/+GP/n6rSitlwQ7WRRkTtp3fu37O23sIYy/rr6BUKpsJAK7wHb7VqBl09QbKqu3NI
	91DG1q/c1x1DVVBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=aGGGm7oJ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="YKa4Y/+G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749221920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ti/Py6dJ0naeNjX5F1k8KYleDnBdjDj8FiSaldxcGVE=;
	b=aGGGm7oJv6CPTBdNX4ovBls6qBfTQ91csqAs1c1CgwtR47QKMIDdgwpck0OQ/ZWWRI9vsZ
	/X5cNY8XqBTM+qbsTtGzXemcMucLr30vEplzjymcorvZlaJZ8lL8SKUmY+5MviFfTfFF2K
	flkJIRBgH62FUsKZblFfUTHnJkTlj8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749221920;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ti/Py6dJ0naeNjX5F1k8KYleDnBdjDj8FiSaldxcGVE=;
	b=YKa4Y/+GP/n6rSitlwQ7WRRkTtp3fu37O23sIYy/rr6BUKpsJAK7wHb7VqBl09QbKqu3NI
	91DG1q/c1x1DVVBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E83E21369F;
	Fri,  6 Jun 2025 14:58:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NrRqOB8CQ2iHIAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 06 Jun 2025 14:58:39 +0000
Date: Fri, 6 Jun 2025 16:58:31 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, 
	"nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, 
	Tomas Bzatek <tbzatek@redhat.com>
Subject: Re: blktests failures with v6.15 kernel
Message-ID: <38a8ec1a-dbca-43f1-b0fa-79f0361bbc0b@flourine.local>
References: <2xsfqvnntjx5iiir7wghhebmnugmpfluv6ef22mghojgk6gilr@mvjscqxroqqk>
 <7cdceac2-ef72-4917-83a2-703f8f93bd64@flourine.local>
 <rcirbjhpzv6ojqc5o33cl3r6l7x72adaqp7k2uf6llgvcg5pfh@qy5ii2yfi2b2>
 <CAHj4cs8SqXUpbT49v29ugG1Q36g5KrGAHtHu6sSjiH19Ct_vJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHj4cs8SqXUpbT49v29ugG1Q36g5KrGAHtHu6sSjiH19Ct_vJA@mail.gmail.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0625F1F445
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.51
X-Spam-Level: 

On Fri, Jun 06, 2025 at 10:25:25PM +0800, Yi Zhang wrote:
> > As of today, CKI project keeps on reporting the failure:
> >
> >   https://datawarehouse.cki-project.org/kcidb/tests/redhat:1851238698-aarch64-kernel_upt_7
> >
> > Yi, do you think the new libnvme release will help to silence the failure
> 
> I've created one CKI issue to track the nvme/023 failure, so the
> failure will be waived in the future test.
> 
> > reports? I'm guessing the release will help RedHat to pick up and apply to CKI
> 
> Yes, if we have the new release for libnvme, our Fedora libnvme
> maintainer can build the new one for Fedora. I also created the Fedora
> issue to track it on libnvme side.

Sure; a stop gap solution, just don't build with liburing. In hindsight,
I should have set it to disabled per default, will do it now.

FWIW, the contributor for the io_uring feature, stated that it improved
the performance for some workloads. Though, I think the whole
integration is sub-optimal, as a new io_uring is created/configured for
each get_log_page call. So only for a large transfers there is going to
help.

I am currently working on libnvme 2 and I think we can improve this
quite a bit though. But for libnvme 1 I'd  recommend to disable
liburing.

