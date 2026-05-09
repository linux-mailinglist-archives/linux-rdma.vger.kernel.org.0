Return-Path: <linux-rdma+bounces-20281-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NLINYi3/mmovQAAu9opvQ
	(envelope-from <linux-rdma+bounces-20281-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 09 May 2026 06:26:48 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4398E4FE0E7
	for <lists+linux-rdma@lfdr.de>; Sat, 09 May 2026 06:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ACC83301FCB7
	for <lists+linux-rdma@lfdr.de>; Sat,  9 May 2026 04:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3EA207DF7;
	Sat,  9 May 2026 04:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q1r4aB8s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E1ECA4E
	for <linux-rdma@vger.kernel.org>; Sat,  9 May 2026 04:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778300803; cv=none; b=NMUAb+4MnhwovxubUQUkayHT2cDvzlwwyePK0/zu4yXtSL9SbG2zjtnYigKZCMAwIFml/f+bc6DwJLk5svZYh7gReFpYk6LdPzvBeoUjIuessc+f86dvBNM2gsi6wBp+L26qzvfAwJj8nXphJrqLJLOsjO0sSQYFJ/YTM58u6L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778300803; c=relaxed/simple;
	bh=tK2qPdxJ8J9lHptKJTJxfGnMwGRH7Mir8Gy6FMeXp1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3+dcio5bq2iYaucScREzD3RL3yak2t2yXtj0vw+arr0QBjURexWn9Ead4CQp3GMHz5FU9TJ16HuJp2w0BHjdfr0oZib50H2GGwG+MWUoW0K7x2Nc+RhftHKMsTryovGoYc0odNPlaqza++1db+vARdqhLNrdkkPn9kRKFxlXPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q1r4aB8s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38FAFC2BCB2;
	Sat,  9 May 2026 04:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778300802;
	bh=tK2qPdxJ8J9lHptKJTJxfGnMwGRH7Mir8Gy6FMeXp1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q1r4aB8shNNNPJao1MF+WSXLkLIL9DiXN+Jqg4Ap8Uzlt4DA1/25h891qSuOA9Mny
	 7wjX0UVhQDxO+Q6ACEXWGUDD6zXSWtdR1FHrIUkg0wtbUKNq2nswyCL6BtCgnzIMeW
	 u/cYmz66Xbq35PSwotYOq0QUf7P6uNl9gLFRGokY=
Date: Sat, 9 May 2026 06:25:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Henrik Holmberg <pomzm67@gmail.com>
Cc: security@kernel.org, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com, linux-rdma@vger.kernel.org
Subject: Re: [security] RDMA/bnxt_re: kernel infoleak via uninitialised shpg
 shared page exposed to userspace
Message-ID: <2026050945-oversight-carefully-93e0@gregkh>
References: <CAOOd5ej7=KFT8+JO8D3g=QnnhJR2+V--a+JSKcpuxUt=tyGyZw@mail.gmail.com>
 <2026050818-divisible-unlocked-e1f7@gregkh>
 <CAOOd5egJUS5THB4_Rvkkd-SNyKeox2audsnuEm-mz3NEoPc2Og@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOOd5egJUS5THB4_Rvkkd-SNyKeox2audsnuEm-mz3NEoPc2Og@mail.gmail.com>
X-Rspamd-Queue-Id: 4398E4FE0E7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20281-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[checkpatch.pl:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,defensify.se:email]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 10:24:33PM +0200, Henrik Holmberg wrote:
>  Hi Greg,
> 
>   Reformatted as a real kernel patch per your request. checkpatch.pl --strict
>   reports 0 errors, 0 warnings, 0 checks against current torvalds/master.
>   get_maintainer.pl was run; full Cc list applied to this thread.
> 
>   Patch follows inline below.
> 
>   Best regards,
>   Henrik (Lord Ulf Henrik Holmberg)
>   Senior IT Security Researcher, Defensify
> 
>   ----8<--------------------------------------------------------------
> 
>   From: Lord Ulf Henrik Holmberg <henrik.holmberg@defensify.se>
>   Date: Fri, 8 May 2026 16:14:57 +0200
>   Subject: [PATCH] RDMA/bnxt_re: zero shared page before exposing to userspace
> 
>   bnxt_re_alloc_ucontext() allocates uctx->shpg via
>   __get_free_page(GFP_KERNEL). The buddy allocator does not zero pages
>   without __GFP_ZERO, so the page contains stale kernel data from
>   whatever object most recently freed it.
> 
>   The page is then mapped into userspace via vm_insert_page() under
>   BNXT_RE_MMAP_SH_PAGE in bnxt_re_mmap(). The driver only ever writes
>   4 bytes (a u32 AVID) at offset BNXT_RE_AVID_OFFT (0x10) inside
>   bnxt_re_create_ah(); the remaining 4092 bytes of the page are exposed
>   to userspace unsanitised, leaking kernel memory contents.
> 
>   Any user with access to /dev/infiniband/uverbsX on a host with a
>   bnxt_re device (typically rdma group membership) can read this data
>   via a single mmap() at pgoff 0 after IB_USER_VERBS_CMD_GET_CONTEXT.
> 
>   Other shared pages in the same file already use get_zeroed_page()
>   correctly:
> 
>     drivers/infiniband/hw/bnxt_re/ib_verbs.c
>         srq->uctx_srq_page = (void *)get_zeroed_page(GFP_KERNEL);
>         cq->uctx_cq_page  = (void *)get_zeroed_page(GFP_KERNEL);
> 
>   uctx->shpg is the only outlier. Bring it in line with the existing
>   convention by switching to get_zeroed_page().
> 
>   Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
>   Signed-off-by: Lord Ulf Henrik Holmberg <henrik.holmberg@defensify.se>
>   ---
>    drivers/infiniband/hw/bnxt_re/ib_verbs.c | 2 +-
>    1 file changed, 1 insertion(+), 1 deletion(-)
> 
>   diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> b/drivers/infiniband/hw/bnxt_re/ib_verbs.c

This is totally corrupted and can not be applied :(


