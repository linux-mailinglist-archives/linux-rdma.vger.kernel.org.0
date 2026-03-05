Return-Path: <linux-rdma+bounces-17560-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GI7xNVLVqWnbFwEAu9opvQ
	(envelope-from <linux-rdma+bounces-17560-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 20:11:14 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3750A217491
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 20:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 668D03161614
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2026 19:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFED303A32;
	Thu,  5 Mar 2026 19:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kILwkk68"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9EA3043DD
	for <linux-rdma@vger.kernel.org>; Thu,  5 Mar 2026 19:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772737674; cv=none; b=OHkKqTxmlcKIecS5rVWwQ22URkDfXFqQ99f3/AS2lJ7GG96cVzehdMCg1OmpvOXu9MKsGSw1X8NUeUPH6z6J/MPqEqAQR1FcADEK9xRKoL1NGJXiP0MFWQUSGczh6UF/pXnStKXflRPnI7sKL9NQ1xdt6HwP2IWr73d97JqQ9iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772737674; c=relaxed/simple;
	bh=p27mVjaEjAdBEF5GkfeH8SlV1G/ydclOHv0CwSzCIGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmIAKXlQmsn/JKw0PF6z2LSaZKyLao5Osfgo3bZGIIqoNvaFEWGtCrGahDYf/vdhom5UDP0nB5vNk7PL100fQ0Y/NhtinC2rgePNT5utDthCcednYxicVRfwH3LHH1Q9KnQfS0UuLclqL/4hHKnja95Pk0IVqIkj01dz847GYPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kILwkk68; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-506bad34f51so72349901cf.2
        for <linux-rdma@vger.kernel.org>; Thu, 05 Mar 2026 11:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1772737672; x=1773342472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p27mVjaEjAdBEF5GkfeH8SlV1G/ydclOHv0CwSzCIGU=;
        b=kILwkk68ldLF7bKvEN6W7RCUoXozx1NQ16pVB9a7Q2rEUQqfMEiBZD8EEtgeFM5IAb
         Pcyx3KuiEyFzRVWGQ7wglAS0i8XjevB8egWuX+n/LkdN7tmaGEaw2+ffL4paEty75ipW
         GlMosGd9uyYvRX04fHmkwksWo/fF3rjuhojf/nCiBm8CfLAi/91Z2LV+rKC2CEwFawNW
         3gm6gx7KkOQQE7h2ZvZOwQCe6/bXVl6ppjMOOBt9RIGeLd5T7FaQeACRoig9Sf20sZKl
         G2oyUkYIE40MPzNisHuzjnnYFdFM+fCNwuxwTDsjXASpz3vc26rOAYt/Agwysy3/0ra0
         u+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772737672; x=1773342472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p27mVjaEjAdBEF5GkfeH8SlV1G/ydclOHv0CwSzCIGU=;
        b=S4Wtj6qTwFaLYJGvYEzcEf9tE5zcN102s5Piyym/yiSwP4+VkGjpiJrPRe+r4cBIAh
         hZQgsXHmarBXONI1ml06Qb8xGDkV6A2SQGc142kWdoWS7yCUDINgPFxbRcvQ7iOTOSvT
         kkFTjlVPji05hI0qmSZo+hpnH9JoHbcJqQEFQUdpwg0DyEWds1fq5iI5MV43+uZjeud8
         M/f37cU6GEhl0k9PcKk6xeUb2AHKn/1OUnTyIfC2JPZoDn1rbnXyKUkLVrDpioscB6gZ
         +/2XagelLBGOGra8WDdxi5azSDsthNwT0d3qMgLdBUNBekHIxuPgYbsH4sEhDs2O8vHz
         s6Hg==
X-Forwarded-Encrypted: i=1; AJvYcCXkE0WSnh0gWGV2mKbSq5SfxrLimrFKVZ8I4fHwSW3+lC58+16i6xu+mLLoWranNP1b4GxkouWtPlKK@vger.kernel.org
X-Gm-Message-State: AOJu0YwYe+BSSJd2jN8qbIGWTXklOMCTqQqVNZFoecL+mYpGYjoCTLbM
	r3THXJUdXj4I+nYLaLSFXTI00utmOW8ByYGEe+2y1aG/TzlM6uO47MKuVXUX+O/n98E=
X-Gm-Gg: ATEYQzzqMFy9Kt8wHhP1ttv3Kt6uK0kMMvv5JDuO7sGscKI90HhYZJbPCLl/Z5A9huj
	3LSdy09XHRYjAM352L+h3NGL31sLIdrx1MtqSDb14hiT7dCQkToeM6i7mls3myqBbjhwVNxtYgK
	U0SsyAsjiCZ1z9ItsnI44Q+swgQGSAYgLLjYlK6ojSXoUaS/yL1Yg00ib/rBLoIR6B+UAT7nQnQ
	P28p4m84yCeOB6ps4VJsMDpYX+hZ3cecwmq1kdgkMXQ+W0Ef27IZw97es35P5Bo0ffkhYOsVhjJ
	5XxhrD9W+svBf6Ecdh6B8ozQuCwhPHNKPFcY02INBizsx19gtgo30z/cI7wsFoq9LPf34QqSXeg
	JL9qNjKQOUy8cOG+VjVMiXxMuM427I9BPZVH2vEqKDDR9PeUNUe9d2WA8ZonMVpP3FDlORFcC5r
	v6Qxgbmo9VvbBEztkWxV8nNyHqYpxNJzBIWCubbNvV0lGunvPnlj+8Xbt3/OOZOU5ABpexgf1us
	vDiRmPI
X-Received: by 2002:ac8:7f96:0:b0:502:a100:4054 with SMTP id d75a77b69052e-508db2aaedcmr88448991cf.23.1772737672031;
        Thu, 05 Mar 2026 11:07:52 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-507512559b2sm160559461cf.17.2026.03.05.11.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 11:07:51 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vyE34-000000077HO-2cQQ;
	Thu, 05 Mar 2026 15:07:50 -0400
Date: Thu, 5 Mar 2026 15:07:50 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	David Hildenbrand <david@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Huiwen He <hehuiwen@kylinos.cn>,
	Jerome Marchand <jmarchan@redhat.com>,
	Qing Wang <wangqing7171@gmail.com>,
	Shengming Hu <hu.shengming@zte.com.cn>,
	Linux-MM <linux-mm@kvack.org>,
	linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: [GIT PULL] tracing: Fixes for 7.0
Message-ID: <20260305190750.GA1687929@ziepe.ca>
References: <20260305103941.11f1b27d@gandalf.local.home>
 <CAHk-=wggaToeRYv6B5L9ob=wBdVW9_gFudYxH_WJDTuhyX_Ueg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wggaToeRYv6B5L9ob=wBdVW9_gFudYxH_WJDTuhyX_Ueg@mail.gmail.com>
X-Rspamd-Queue-Id: 3750A217491
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[goodmis.org,kernel.org,efficios.com,kylinos.cn,redhat.com,gmail.com,zte.com.cn,kvack.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-17560-lists,linux-rdma=lfdr.de];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 08:44:27AM -0800, Linus Torvalds wrote:
> Now, Debian code search does show some users (libfabric, libibverbs),
> and maybe they actually want the forking behavior for other reasons
> too.

DOFORK in libibverbs is a consequence of its automatic DONTFORK, is is
explcitily there to undo a prior DONTFORK only.

This is because the library wrappers would automatically DONTFORK
regions of memory based on library usage, and then DOFORK them back to
normal after the library is done with them.

This whole path is disabled on modern kernels in favour of the fixed
fork support.

I think your point that DOFORK should only take action on previous
DONTFORK is correct.

Jason

