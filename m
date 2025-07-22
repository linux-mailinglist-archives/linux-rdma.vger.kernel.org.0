Return-Path: <linux-rdma+bounces-12391-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF41DB0D8CA
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jul 2025 14:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E6EA1889648
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jul 2025 12:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A06242D94;
	Tue, 22 Jul 2025 12:01:38 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23328243958
	for <linux-rdma@vger.kernel.org>; Tue, 22 Jul 2025 12:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753185698; cv=none; b=ralT4XigGkwC9sbWTGX63bx/xOLIuyEQcRDcOq9GEn6KTZyfK7RD3Cx/CId48zMs+SvQGD5mpPW9FJu+N93HEX1r5+t97za8Bh9UA+3/nfGqbAvU1Lbu5GPq+J63wfD1rAftFeqVbeAZeGeEnHt4Lcrymg333aBYR3vjorer+U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753185698; c=relaxed/simple;
	bh=n0Z4G3nc/AZZSoxQgQADjWlFDaIimmQ1VWwU2Zr37Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxnhyuWffq7AQcjbmQiHr2avip4njk6N8YwvM9x9mimsIS9MU0CruKHu2chWtcCk6xGanHira0XARPy29bDU/+Ut/jvs6TlMxNJj8Re4Big671Jtl6cjPhQ/Hm14AouPwUEvnqJ405mNGA7vCFTtDpxcD8FiESr0fcjW+1oIa/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 547C41F797;
	Tue, 22 Jul 2025 12:01:35 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 89D2413A32;
	Tue, 22 Jul 2025 12:01:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FnhVHp59f2hsUQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 22 Jul 2025 12:01:34 +0000
Date: Tue, 22 Jul 2025 13:01:32 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: kernel test robot <oliver.sang@intel.com>, 
	Bernard Metzler <bmt@zurich.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, 
	oe-lkp@lists.linux.dev, lkp@intel.com, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org
Subject: Re: [linux-next:master] [mm, slab] 5660ee54e7:
 BUG:KASAN:stack-out-of-bounds_in_copy_from_iter
Message-ID: <22ohbihitxnnvgugbp34x7tlsdlvcdrji7h6unlgpxqy3golrb@ha4ywpuyo5ro>
References: <202507220801.50a7210-lkp@intel.com>
 <jehx7y7mwer77d2rrx323qixc456ffod3qrcssemkebjotstbh@fpklsa72lzky>
 <05001622-737d-40e7-8adc-5dd23e6b9bcb@suse.cz>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05001622-737d-40e7-8adc-5dd23e6b9bcb@suse.cz>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 547C41F797
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Tue, Jul 22, 2025 at 01:32:09PM +0200, Vlastimil Babka wrote:
> On 7/22/25 12:52, Pedro Falcato wrote:
> > +cc dhowells
> 
> +Cc siw+infiniband maintainers too.
> 
> Thanks Pedro. Hope there can be either a hotfix for 6.16, or the fix is part
> of 6.17 merge window (and I tell Linus to merge slab only afterwards), or I
> get the blessing to include it in my tree preceding commit 5660ee54e798 (to
> be merged in 6.17 merge window).
> 
> Also would you submit the fix formally?

Yep, I'll send it out as soon as we figure out the tree situation
(I was also waiting for comments from David, if any).

-- 
Pedro

