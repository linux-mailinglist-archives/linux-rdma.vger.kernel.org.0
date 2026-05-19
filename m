Return-Path: <linux-rdma+bounces-20942-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GM6JDUWwC2q2LAUAu9opvQ
	(envelope-from <linux-rdma+bounces-20942-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 02:35:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96089575928
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 02:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE9B53028801
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 00:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A9823BD05;
	Tue, 19 May 2026 00:35:08 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCD1DDCD;
	Tue, 19 May 2026 00:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779150908; cv=none; b=abnKAplLXNGcMjvc0RmzyzrHE2mAFRDl9bEwoqZMF377TSXSyM859SiexXv0KcIeGqWyauXptxG7yTmta3KxNLjaS0Gjcz94f4Ylire4Nbpf7PNaI3ibMaPxYrpXDeZUP8BoPZnP1Jd2xeFg+uftt05M9q2HfiaZGEc85uv3VK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779150908; c=relaxed/simple;
	bh=llOseHKEpby43UkCqR3XrnLEq/JiXWiXToO9f8DJ9gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZN5jBg2NVicJ0gvchYeK5tTm2wPIUmuYA61cRLGda//+EMw6PttripUbnVoYxQJJIRiXtK8+d9a0NQPqamBegYJkxIjyKVsCQYA+ZGAxDOiB2BVjpraoWFaBE+Yb6BZnlXWelZlFuk3fwFM60kHEliigGSfeLcNQjaCCxSQWNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-cb-6a0bb02fa827
Date: Tue, 19 May 2026 09:34:50 +0900
From: Byungchul Park <byungchul@sk.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, kernel_team@skhynix.com,
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
	sdf@fomichev.me, saeedm@nvidia.com, leon@kernel.org,
	tariqt@nvidia.com, mbloch@nvidia.com, andrew+netdev@lunn.ch,
	edumazet@google.com, pabeni@redhat.com, david@kernel.org,
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, horms@kernel.org,
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
	ilias.apalodimas@linaro.org, kas@kernel.org, willy@infradead.org,
	baolin.wang@linux.alibaba.com, asml.silence@gmail.com,
	toke@redhat.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] Revert "mm: introduce a new page type for page pool in
 page type"
Message-ID: <20260519003450.GA46041@system.software.com>
References: <20260515034701.17027-1-byungchul@sk.com>
 <agruFy80Ag3uIab0@lucifer>
 <20260518173119.f3348ec4cc66b793fed4cccf@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518173119.f3348ec4cc66b793fed4cccf@linux-foundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+Z9zdnacLY7L6p9GH1ZRLLQSpTcSM7twSKLoApFRDT3kbF7a
	1JoUWI1Mc8uu5FqysMxWqcy8omZLZxfMey0tLaeZ4qUbI2dorgv17QfPw+95P7wMKckR+DCK
	uEReFSdXSmkRJRqZccNveZFnzIqubF8wFt6j4fa7cgEYzaUIvo13CWGq2obga10DDbk3nCQY
	m7QUDJS4EPTbeoVw17IFqtLKSOg994QGnXaChOrxUSGcLM8nwFicKoTmUr0ALrlukVDwzEpD
	W6WRhu57UwL4YNVRMOzYBJ8u15HQow8Fm2kOOJ8PI6grLCPAmXmdho7sSgIutppocGh7ELQ+
	7qXgzGAPBRPfpz3X6ruFoYu5x8NjJPfgzmuCs9c8I7gKw1shZ7IkccX5Mi7D3kpyFnM6zVm+
	XBByb15W0dyTqxMUV/F+NVdR/pXgdKdGaW6spoPmCh90UNu89oiCo3ilIplXLQ85IIpu/3Af
	JXyeebRGV4xSUbdnBvJgMBuI7efL6L+cOXmacjPFLsbG3MvIzTS7BNvt46SbvVk/bB6onGYR
	Q7J5NDZc+Sh0B7PY3dhYlPlLJGYBV/QP0e6ShL2I8KvOwT+BF36a3fdrgWRl2D45SGQgZpp9
	8e1Jxo0ebDgecUW4G7PZhbi2tIFwazBby+AXAy/J34fOw4/y7VQWYg3/WQ3/WQ3/rCZEmpFE
	EZccK1coA/2jNXGKo/6R8bEWNP01ecd/RJSjL807rIhlkHSGOHRKFCMRyJPVmlgrwgwp9RZP
	FnrESMRRck0Kr4rfr0pS8mor8mUo6VxxgPNIlIQ9KE/kD/F8Aq/6mxKMh08qmu0XdDhIpFwX
	5pUbtLRks8pqq90gOOdIz5qfsHFnSGv1Vsf32FONLh31OazFN8VVdS2yVq/VnBjfd6yvaVF4
	fXDaw+0tpx0FidmyR5JDeREpJn18qP++LI25cdnQqDk8a29H2M22nF3qNVrv/rN9rG19/6rg
	mPbOleTIWv2CgIQcKaWOlq+UkSq1/Cd1NIzAMQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA03SWUwTURQGYO/M9M5QKI616ASNDyWiIbJoNB7j1hf0usbEB9dEG51I2cRW
	CGgwRAgqUnCPlhJbUTZBsMhSFEIKshoXEK2goCgIBhUEWRWkRqNvX/Kf/5yXw9HyGIk7pwk9
	KmpD1cFKLGWkW1fGevvmOwf6mRtcwZiXgyHjbYkEjNlFCAZHW1mYLKtGMFBVgyHNPESD8Ukc
	Ax8LxxB0VnewcNuyBR6cKqahI7kWgz5unIay0S8snCzJpMBYEMNCZWqdBJ4WJUng0tgtGu7U
	2zA0lRoxtOVMSqDLpmeg9/066LtcRUN7kgqqTbNgqKEXQVVeMQVDiakYmq+VUnCx0YThfVw7
	gsbKDgZO97QzMD4ytSflYRur8iSVvV9pci/rFUXs5fUUsRresMRkCScFmV4kwd5IE0v2GUws
	3y6w5PWLB5jUXh1niPXdCmItGaCIPvYLJl/LmzFJ6+6jtsl3S1cdFIM1EaLWd81+acDzrlwU
	1u8aWa4vQDGozTkBOXECv1RInIhnHGb4+YIx7TJyGPMLBLt9lHZYwXsL2R9LpyzlaD4dC4Yr
	3awjmMnvFIz5idhhGQ+CtfMTdgzJ+YtIeNnS8yeYIdRd+/D7As17CfaJHioBcVOeI2RMcA46
	8ZuEz2N7HBNuvIdQUVRDnUMyw39lw39lw7+yCdHZSKEJjQhRa4KX+eiCAqJCNZE+Bw6HWNDU
	X6RH/zhfggab1tsQzyGli0w1KQ2US9QRuqgQGxI4WqmQTeQ5BcplB9VRx0Tt4X3a8GBRZ0Nz
	OEY5W7Zxh7hfzh9SHxWDRDFM1P5NKc7JPQbpupTPcgo6H632Pv5JN8OkqNU+PqKqu+G6PGdo
	2l3fn2XJCr9CfdNjbTxZcsmtukrSEuZ2U7V70y7/4ftylxObnwQVJqsXhSxvyUoZnkftnVsX
	uX1663E3O9MS7kGarVEKpXfmBtZzYa05+bu/JZfKTK/ov45HutamnzW7JBafjVYyugD1Yi9a
	q1P/Ap8yzS8TAwAA
X-CFilter-Loop: Reflected
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[38];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	R_DKIM_NA(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,skhynix.com,iogearbox.net,davemloft.net,gmail.com,fomichev.me,nvidia.com,lunn.ch,google.com,redhat.com,infradead.org,suse.com,cmpxchg.org,linaro.org,linux.alibaba.com,vger.kernel.org,kvack.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[byungchul@sk.com,linux-rdma@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20942-lists,linux-rdma=lfdr.de];
	DMARC_NA(0.00)[sk.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 96089575928
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 05:31:19PM -0700, Andrew Morton wrote:
> On Mon, 18 May 2026 12:00:11 +0100 Lorenzo Stoakes <ljs@kernel.org> wrote:
> 
> > Maybe worth putting [PATCH mm-hotfixes] just to make it clear this should be an
> > urgent hotfix?
> >
> > On Fri, May 15, 2026 at 12:47:01PM +0900, Byungchul Park wrote:
> > > This reverts commit db359fccf212e7fa3136e6edbed6228475646fd7.
> >
> > Maybe 'this reverts commit db359fccf212 ("...") and partially reverts commit
> > 735a309b4bfb9e ("...") <details>'?
> >
> > >
> > > Netpp page_type'ed pages might be used in mapping so as to use
> > > @_mapcount.  However, since @page_type and @_mapcount are union'ed in
> > > struct page, these two can't be used at the same time.  Revert the
> > > commit introducing page_type for Netpp for now.
> >
> > Yikes!
> >
> > >
> > > The patch will be retried once @page_type and @_mapcount get allowed to
> > > be used at the same time.
> > >
> > > The revert also includes removal of @page_type initialization part
> > > introduced by commit 735a309b4bfb9e ("net: add net_iov_init() and use it
> > > to initialize ->page_type"), which will be restored on the retry.
> >
> > As above maybe mentioning at top of commit msg, as right now this reads as a
> > pure revert of db359fccf212.
> 
> I did

Oh great!  Thanks.

	Byungchul

> : This reverts commit db359fccf212 ("mm: introduce a new page type for page
> : pool in page type") and a part of 735a309b4bfb9e ("net: add net_iov_init()
> : and use it > to initialize ->page_type").
> 
> > >
> > > Reported-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > Closes: https://lore.kernel.org/all/982b9bc1-0a0a-4fc5-8e3a-3672db2b29a1@nvidia.com
> >
> > Fixes tag?
> 
> I assume db359fccf212 ("mm: introduce a new page type for page pool in
> page type") is close enough.  Both that and 735a309b4bfb9e are new in
> 7.1-rcX.

