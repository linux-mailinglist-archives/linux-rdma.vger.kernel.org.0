Return-Path: <linux-rdma+bounces-18229-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gE17NEWEuGltfAEAu9opvQ
	(envelope-from <linux-rdma+bounces-18229-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 23:29:25 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C532A1786
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 23:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DCE7B302FEA7
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 22:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3E337268C;
	Mon, 16 Mar 2026 22:29:15 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BAE20FAAB;
	Mon, 16 Mar 2026 22:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773700155; cv=none; b=c88IxG+I7qgsuaQ7dN3EWfc6xJ4oiF/Xx1JbILsWRTzaQoHZYj0s/Y5AtPUc2FFBpFu/D8p4a/pai2Vdh54+wER/lQvzxbgPwDxolKUozPzzBhTYsr+lPltuPd6q7TnPXYCEEvkIijv2GHX2mjfUi/fYSYV7dUe2i/gggkTQ6VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773700155; c=relaxed/simple;
	bh=1d1whyWo1pwBVSMBQ/mpBY2zLHUeCDIglmd5gzJ7AwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vg1ObBVEd3kSSBTS5ho1khsSn8xr6ywt96pBhlNeGbLNDEwpi8/Q0ES63SlJBzaw6eCvZXZEUX6OpGuHLBchrVM20QTKQJqMr8P2waTm9uMzm3NU7wklALXiHJ8BALMnPxRr9+VAqxxeZwvshZojYdSGV5iSEgs9mKPdOF5mBA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-16-69b884321b69
Date: Tue, 17 Mar 2026 07:29:01 +0900
From: Byungchul Park <byungchul@sk.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
	harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
	davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
	john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
	leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
	andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, horms@kernel.org,
	jackmanb@google.com, ziy@nvidia.com, ilias.apalodimas@linaro.org,
	willy@infradead.org, brauner@kernel.org, kas@kernel.org,
	yuzhao@google.com, usamaarif642@gmail.com,
	baolin.wang@linux.alibaba.com, almasrymina@google.com,
	toke@redhat.com, asml.silence@gmail.com, bpf@vger.kernel.org,
	linux-rdma@vger.kernel.org, sfr@canb.auug.org.au, dw@davidwei.uk,
	ap420073@gmail.com, dtatulea@nvidia.com
Subject: Re: [PATCH v4] mm: introduce a new page type for page pool in page
 type
Message-ID: <20260316222901.GA59948@system.software.com>
References: <20260224051347.19621-1-byungchul@sk.com>
 <aaCVzc2lexW0TiPf@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaCVzc2lexW0TiPf@cmpxchg.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA03Se0hTURzAcc69d/deR8vbcnZ6QLXeRlZS9IsyKhDOH/agKKIoG+2WK7XY
	1LQHrBIyaWZmYXOiTvId1iqdolLTLFeRrIzby6mVPSyLZea012ZF/ffhd8758vvj8LTSKRvH
	6+LiRX2cJkbNyhn5hxEFc8JS7Lp5LemhYKmsYKF8IAmKO+wy8Fa8psBSVoWgz/uUg5/1zQg+
	N91ioafRg6CwoJ8Gy/0UBr5UDtJQU/sawbvsiyy8au7ioNy2CtxF3QzUHa+moevUbRZMKUM0
	1Ht7OThqL/GFrxg5aK1Kl0HW4AUaqo0dHDyotbDQXvFTBt0OEwMt5lIGPp1tosGdvhya84Oh
	/857BE2V1RT0n8xloe18LQXX6ts4OOPKZ+FFihuBq7GLgbPfUlnIOZKOYGjAl+zN6JNBzs12
	bnkoOSJJLGl8/5EmV0sfU+RR9mmGSA1OitSYn3Mk35ZArpSEkDTJRRNb2QmW2DyZHHn2qI4l
	t7OHGFLTuZjU2D9TxHSsl12r2ixfqhVjdImifu6y7fLoM97TaF83l+Q0XmCN6JMsDQXwWFiA
	vz5uZ/467/sTzm9GmIavZWQNmxVmYEny0n4HCTOxy5rK+k0LPRzObAv3e7SwDjvNOcN3FAJg
	a0n1sJXCRpxdfvXPfBRuOf+S+f02BEs/3lJpiPd5PC7+wfvHAcJs/NX5hPJbJUzB16tu+Sz3
	rfaGx6mp9/7sORbfKJGYDCSY/8ua/8ua/2XzEV2GlLq4xFiNLmZBaHRynC4pdMfeWBvy/bCi
	w9+22JGndb0DCTxSj1BIMrtOKdMkGpJjHQjztDpIUdRUpVMqtJrkA6J+b5Q+IUY0ONB4nlGP
	UYT179cqhV2aeHGPKO4T9X9PKT5gnBFFnlup6ctdo1xoD/BMHBzpuTd60qnpkT2dgcpDpsvu
	OwOBHYXdJPdoToHV6mwkW4WnhoMJwVGqdbMmH3imjR85gKJWOCyqy0PfIy4tCnu49rlq08TI
	wK0qdR4659ydtXPChs7MF7Em16B21LaI7Svd4c4IVBjee/DukgZrdNfUutVqxhCtmR9C6w2a
	X6OfDq5dAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA03Se0hTcRQHcH737WhyW1aX9Yew6GWoFUXHnv5RdAmMKCiIIEdecuk0tpIZ
	RDOlTHM5H6h3WqZlppY055yvKF2+gh6GcTNzZqaZYZGmTk1zVuR/H77nfM9fh8EVZaSS0USd
	FXRR6kgVJSNkB7bH+29KcGg2POnygdzyMgpKJwxwt8dBgrtsAIPcEjuCUfc7GmbrmxCMOJsp
	GGr8gaDw1hgOuS8SCPhZPolDdc0Agi/Z9yn41NRLQ6k1BFxF/QTUXanCofd6CwUpCVM41LuH
	abjkKJ47XGGkoTGvlYSXdhMJGZN3cKgy9tDwuiaXgu6yWRL6G1IIaBXvEfA904mDyxQMTfnL
	YOzZVwTO8ioMxq7lUdCRU4NBZX0HDent+RR8THAhaG/sJSBzOpECS5wJwdTE3Mnh1FESLE+7
	6eBAPk6SKL7x6zect917i/Fvss0ELz1qw/hq8T3N51vP8RXFfnyS1I7z1pKrFG/9kUbzXW/q
	KL4le4rgqz8E8dWOEYxPiR+mDi47JtsRJkRqYgRd4K5QWXi624zO9NOGNuMdyoi+k0nIi+HY
	zdzNX520xwS7iqtMzZg3xa7hJMmNe+zDruXaCxIpj3F2iObSOnZ6vIQ9xLWJlvkdOQtcQXHV
	vBXsES671PY3X8y15vQRf7p+nDQziCUhZs4ruLszjCf2Ytdz422dmMdL2ZXcY3szlork4oK2
	uKAt/m/nI7wE+WiiYrRqTeSWAH1EeGyUxhBwMlprRXM/VHRh2uxAo6/3NSCWQapFcol0aBSk
	OkYfq21AHIOrfORFTrtGIQ9Tx54XdNEndOciBX0DWsEQquXy/UeFUAV7Sn1WiBCEM4Lu3xRj
	vJRGtDYnec/NWtcr8yXL/aGR6+mK+JBo17GDOtnpx84HfbbQzpata5KVtqzCFKX9pHfyN+XM
	bbvrYuW6YdE3wnfwcMVx8+eZvlqTELzNkhcmR+4ddkHhL9n2PL9yw1cbqE0zHcFqB70HHLtX
	25qzukoM/dzpy+Le8SUdp4L8DQ/F1SpCH67e6Ifr9Orf6sDPED8DAAA=
X-CFilter-Loop: Reflected
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[47];
	RCVD_COUNT_THREE(0.00)[3];
	R_DKIM_NA(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,vger.kernel.org,skhynix.com,oracle.com,kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,nvidia.com,lunn.ch,google.com,redhat.com,suse.cz,suse.com,linaro.org,infradead.org,linux.alibaba.com,canb.auug.org.au,davidwei.uk];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[byungchul@sk.com,linux-rdma@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.477];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18229-lists,linux-rdma=lfdr.de];
	DMARC_NA(0.00)[sk.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 55C532A1786
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Feb 26, 2026 at 01:49:49PM -0500, Johannes Weiner wrote:
> On Tue, Feb 24, 2026 at 02:13:47PM +0900, Byungchul Park wrote:
> > @@ -1416,9 +1413,15 @@ __always_inline bool __free_pages_prepare(struct page *page,
> >               mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
> >               folio->mapping = NULL;
> >       }
> > -     if (unlikely(page_has_type(page)))
> > +     if (unlikely(page_has_type(page))) {
> > +             /* networking expects to clear its page type before releasing */
> > +             if (unlikely(PageNetpp(page))) {
> 
> You can gate that on is_check_pages_enabled(), to avoid a new branch
> in the !debug case.

It's an unlikely condition so behaves already almost no branch.  Do we
need the additional effort?  No objection but I'm just curious.

I'm adding v5 patch with the request applied in this mail thread anyway.

	Byungchul

> Otherwise, the MM bits look good to me!
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

