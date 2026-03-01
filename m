Return-Path: <linux-rdma+bounces-17346-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIEGKBx8pGkkiQUAu9opvQ
	(envelope-from <linux-rdma+bounces-17346-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 01 Mar 2026 18:49:16 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E42761D0E15
	for <lists+linux-rdma@lfdr.de>; Sun, 01 Mar 2026 18:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E54130166E8
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Mar 2026 17:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC783337BA4;
	Sun,  1 Mar 2026 17:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VV/smv1U"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F2521D3CC
	for <linux-rdma@vger.kernel.org>; Sun,  1 Mar 2026 17:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772387238; cv=none; b=a8I5SfTNma0CkhpIe5UWbaxmEmAP+YZfIraZkeRRyoGoIxs/7N1i7gsyd9YSLvRolDYVtlcv/gPdI11hK9TkprWszHwyDPzVj5ym4350AsF8GRH0fMML9oa850eEYd0ZOBsBL+zmhHnIxZChtlsZFCLwOMSSya3ZwI0eHoRq02s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772387238; c=relaxed/simple;
	bh=2v7Sp0ux7GofhBOEaGIa9Wneb4lcg0az/5cWU6qCb78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNvCRxOKM3NHQ9Y0Xj2oSHWvL56zPWVhcjlLVLVwkCkqR8oxpPU99jdgxP/ZKSIX2GMJT3NWt5wJ5q4OT7XYC6lhG8hEGaTmwN3+GZx26k97yGX3bpwxPZj/6xv6uyE+kta8x/MUc/VmCRHDV3QEXO3X7/OJUDCniiT0mDf4QDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=VV/smv1U; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-899e43ae2e1so8683826d6.2
        for <linux-rdma@vger.kernel.org>; Sun, 01 Mar 2026 09:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1772387236; x=1772992036; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9lFbj6rPM1ObLJw02K/1ZqIpK/Gy4ngZpNeCmXFIwVw=;
        b=VV/smv1UWbTnxvNlhM41SSbvxxncJstg3SC+Rxf7+PV24A+4CH6J1/poyqG8/rjpab
         EV0eu46L0kTFy1uU9bLsKNTXNrF+PWbqF+0o24gelBIQpSnYV3iBzPLivFE/zX3MQM5w
         GtSKUmdKHR6HU4/R/OFm4KZHKjtlP4KB7r176nQ4dJWcsnVicbeKiqNYIIbNLzDpg/SE
         b+/P2lrnjl0COenKqGZ5DDN/dbv1hEneEpFFh52+WMpva7BxhinwQ/wxBKzW4FqPxAB0
         7IQaXTSFfz3nEtd5uzqWp33MiO96/1bISsW7aXuigs9BNWji8joUAs/aJCmMlm+qqLBS
         Ftnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772387236; x=1772992036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9lFbj6rPM1ObLJw02K/1ZqIpK/Gy4ngZpNeCmXFIwVw=;
        b=BhTOtkMUTcRSwMh0RK+wfDDPohwofzNnc3mSsn5H0q1WYUT1whRMxLDnwBmZAoGpVz
         IkhgBLEgix0n5IEjHReCvJ2PRCin75Tf9KhZztna8xeoQ1Xt894KiwCSFSW/zRkj1raM
         iYABe+G6yEov40awYUPzIaqw+Ym8foH5NEGgMUJxyEC57GqJnfV10cLradyr8jNmr77o
         +Xj/FoN+k8gBUkwLplDFLM3ftF4iRqvHgUJLouxk8QUeVb/mbEPkm7+itTU7QwnXYCSk
         fkKo6S6IPYTsjpUjtKuCL8pDiRNpcvbkgXF7mdx/0pF6D8I40Il2gHfGw6r/m20qrHwa
         xcuA==
X-Gm-Message-State: AOJu0YzDjytSxJBdgjUmoVfXjnqUXOxDis95Rit4DKsVQkLvYmxkKAjJ
	jqBXl3UMHsTpGbNkSLqLWKPOWYBYqTJNTKU7o/sn9iEp+DRaSc4Mnv2eRVAqyFVnZfFF5KeqOlA
	EbhQFVpo=
X-Gm-Gg: ATEYQzzxY+iGeD3Um11x7PsFm8bOAsEGZI26+D8T0WPSxauu/4OKkdL9alTNY3GkHcO
	+yIH/cVFslCrq/2F2mY95hqqxlh1s1t+4f+zY3rljATsGU95BMiLNQI24VAK8ijkKe1IrsTTZns
	yiubVLfSlL4TTBhlH+p3owUetzzacrJxIu9kwkiXi9j+tPOqirLoFmd5P4UVoO6IKe00fo46LiU
	zdDDdNN6Wp6yHHv5oBE6zjm5UkTq7Ntvaq1wvcQ+LbQ49Jbirj03HaPoAKesQKe0OfR6pPU7yT6
	M0UM+or+n4QXac8nJUi0CVXjCTH91FcIb9oP9Kt15TrZ7CriaP4e0gL7Ej1xphTVNzxp3jdffKh
	DogWiBe2I6H01IOXViUXi23QL6xu6Zf6EBmpQOXBbNTII9Nhxbl+jz8DquFDo8KDphyMIPsXjPn
	YXIEPcCn8lu307IDGi/jZACpZjGgagzRBUHRaA/NdS7/SoKz2hMHsUpUeq36J4Ww1qMlxTQSvau
	qb1QXc0
X-Received: by 2002:a05:6214:f05:b0:895:4a14:28f4 with SMTP id 6a1803df08f44-899d1d847b5mr146432526d6.11.1772387235669;
        Sun, 01 Mar 2026 09:47:15 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf6730afsm1096911785a.13.2026.03.01.09.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 09:47:14 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vwkss-00000002b9K-0b9B;
	Sun, 01 Mar 2026 13:47:14 -0400
Date: Sun, 1 Mar 2026 13:47:14 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: OFED mailing list <linux-rdma@vger.kernel.org>,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [rdma] "rdma link del" operation hangs at wait_for_completion()
 when a file descriptor is in use.
Message-ID: <20260301174714.GS44359@ziepe.ca>
References: <cc96166a-a469-4bc9-bfbe-de6f40dffe97@I-love.SAKURA.ne.jp>
 <d800131b-d257-4dc7-adcf-7c35e7a223d2@I-love.SAKURA.ne.jp>
 <20260228164336.GQ44359@ziepe.ca>
 <68867ec9-28f4-4ec1-8639-0b970da148a4@I-love.SAKURA.ne.jp>
 <116c8183-64a4-4afd-8a5a-b9ee65610480@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <116c8183-64a4-4afd-8a5a-b9ee65610480@I-love.SAKURA.ne.jp>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17346-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E42761D0E15
X-Rspamd-Action: no action

On Sun, Mar 01, 2026 at 04:43:55PM +0900, Tetsuo Handa wrote:
> On 2026/03/01 7:35, Tetsuo Handa wrote:
> > On 2026/03/01 1:43, Jason Gunthorpe wrote:
> >> On Sat, Feb 28, 2026 at 03:07:29PM +0900, Tetsuo Handa wrote:
> >>> On 2025/12/04 17:26, Tetsuo Handa wrote:
> >>>> I found that running the attached example program causes khungtaskd message. What is wrong?
> >>>
> >>> I found that this is a deadlock caused by "struct ib_device_ops"->disassociate_ucontext == NULL.
> >>> If the thread which called ib_uverbs_remove_one() is unable to call ib_uverbs_release_file()
> >>>  from ib_uverbs_close() because it is blocked at
> >>> wait_for_completion(), it forms a deadlock.
> >>
> >> That doesn't sound right at all, the wait_for_completion is waiting
> >> for other threads to let go of the context before closing it. rxe/etc
> >> that syzkaller is testing don't support disassociate so they need to
> >> wait.
> > 
> > This issue was not found by syzkaller. Please see the reproducer.
> > 
> >>
> >> If the wait gets stuck that is a different issue.
> > 
> > My question is how we can support disassociate...
> > 
> 
> As of eb71ab2bf722 in linux.git, this problem is still reproducible.
> 
> If you add debug printk() like below, you will be able to confirm that
> ib_uverbs_remove_one() cannot return unless file descriptor is closed.

That's right - that is exactly how it designed to work.

Without disassociate support in the driver you *cannot* safely unload
the driver while FDs are open, to protect the kernel from UAF crashes
we sleep here.

I have no idea what it would take to add disassociate to siw or rxe,
they clearly should have it given how easy it is to trigger a "driver
unbind" through ip route..

Alternatively maybe we should make 'ip link del' fail early in these
case when a FD is open instead of infinite way.

Jason

