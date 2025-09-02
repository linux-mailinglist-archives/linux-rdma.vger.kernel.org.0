Return-Path: <linux-rdma+bounces-13033-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC36CB3F6DE
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Sep 2025 09:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 399931A8227C
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Sep 2025 07:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3592E7646;
	Tue,  2 Sep 2025 07:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="t6pCIJSQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hYZJUdCz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="t6pCIJSQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hYZJUdCz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FEC2E762C
	for <linux-rdma@vger.kernel.org>; Tue,  2 Sep 2025 07:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756799107; cv=none; b=R+jlbm2lfMcmNpzOYfcn+hKig/SqirqtzVwXk3ASfZIPGsLtbz0sQdtgaievpFGmqgg34MNIa9uZR+Fq0CSvQGhY5UNdzx0l37wpR2Nc/gY4sXCObyPmD3P17noYY1JIkp32KDOzGFG79lK5gdNtDXjCIitvaiS5EH3MbnEOjVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756799107; c=relaxed/simple;
	bh=eFoCk84Mcf4f/qPeF56sFPxGV0d53+d1KYk8qAH0aLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tg4caqfN2i49Uz3NrFE7iWIXbHJFNz98YbuAI1mK6JQGzhpGdoKQnbiA4ec0cQ1Jfm+vAmWAg2b4iH4EmdQgtQ7vAJDe3sAoBKKNCDeNyOfk9O375NfyfwD8lVu+yy4cyBR5iQyM9vim+KVQp2CMyolLNo25Ie0xtrzyIP67Ugc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=t6pCIJSQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hYZJUdCz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=t6pCIJSQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hYZJUdCz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8E52B1F445;
	Tue,  2 Sep 2025 07:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756799103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=URGa8t5drl+ELX2V8kqt0UagmCmmkJrjqls7W38gxrM=;
	b=t6pCIJSQX3mRgy/0TSyST+5JYrWpXjgi5574pSBZgKMcrtNnjsTjWtq1cVf6idynlI7Fb6
	99KlqZHp2vszrSz9i8XJ9GeQSXCB6IWgH8zgTMEoA8wseOUBVc2UtdzZR2gIR2SPzkQheI
	iVxa0N2FDt7xEWElf9DNRjkWg/18O3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756799103;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=URGa8t5drl+ELX2V8kqt0UagmCmmkJrjqls7W38gxrM=;
	b=hYZJUdCz5rX52fRxqzTQTdPMhgyUUPyEMnzxUd18ameGZ+O/DZXPMlWrVXpO/0m6voEC6X
	HeGjl2xFHUqRybAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=t6pCIJSQ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hYZJUdCz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756799103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=URGa8t5drl+ELX2V8kqt0UagmCmmkJrjqls7W38gxrM=;
	b=t6pCIJSQX3mRgy/0TSyST+5JYrWpXjgi5574pSBZgKMcrtNnjsTjWtq1cVf6idynlI7Fb6
	99KlqZHp2vszrSz9i8XJ9GeQSXCB6IWgH8zgTMEoA8wseOUBVc2UtdzZR2gIR2SPzkQheI
	iVxa0N2FDt7xEWElf9DNRjkWg/18O3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756799103;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=URGa8t5drl+ELX2V8kqt0UagmCmmkJrjqls7W38gxrM=;
	b=hYZJUdCz5rX52fRxqzTQTdPMhgyUUPyEMnzxUd18ameGZ+O/DZXPMlWrVXpO/0m6voEC6X
	HeGjl2xFHUqRybAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C98913882;
	Tue,  2 Sep 2025 07:45:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +DEhHn+gtmhLZwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 02 Sep 2025 07:45:03 +0000
Date: Tue, 2 Sep 2025 09:44:55 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, 
	"nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: blktests failures with v6.17-rc1 kernel
Message-ID: <9eef8b8a-a186-4619-91e3-e888d1530c17@flourine.local>
References: <suhzith2uj75uiprq4m3cglvr7qwm3d7gi4tmjeohlxl6fcmv3@zu6zym6nmvun>
 <ff748a3f-9f07-4933-b4b3-b4f58aacac5b@flourine.local>
 <rsdinhafrtlguauhesmrrzkybpnvwantwmyfq2ih5aregghax5@mhr7v3eryci3>
 <6ef89cb5-1745-4b98-9203-51ba6de40799@flourine.local>
 <u4ttvhnn7lark5w3sgrbuy2rxupcvosp4qmvj46nwzgeo5ausc@uyrkdls2muwx>
 <629ddb72-c10d-4930-9d81-61d7322ed3b0@flourine.local>
 <7a773833-a193-4243-80f4-fc52243883a9@flourine.local>
 <ldr3xa4muogowu2xeh3uq3xcifljfftssydgnhjdarfre4kg4p@midqloza2ayz>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ldr3xa4muogowu2xeh3uq3xcifljfftssydgnhjdarfre4kg4p@midqloza2ayz>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 8E52B1F445
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

Hi Shinichiro,

On Tue, Sep 02, 2025 at 06:00:17AM +0000, Shinichiro Kawasaki wrote:
> > I'll to reproduce it and see if this patch does make a difference.
> 
> I applied the fix patch above together with the previous fix patch on top of
> v6.17-rc3, then I repeated nvme/061 with fc transport hundreds of times. I
> did not observed the KASAN suaf. The fix patch looks working good. Thanks!

Thanks for testing. I was not able to trigger the bug. Let me cleanup it
and post it.

Thanks,
Daniel

