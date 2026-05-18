Return-Path: <linux-rdma+bounces-20910-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHyWHzMVC2o5/wQAu9opvQ
	(envelope-from <linux-rdma+bounces-20910-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 15:33:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EAB56DAF2
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 15:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 755013006B2A
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 13:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361BF3EEAED;
	Mon, 18 May 2026 13:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foTzNW2d"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7683FF1B4
	for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 13:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779111059; cv=none; b=P4d9KvTPZs8yVPhNiZT0RE0CLe3giUfd6CYeVEHPCnSWWGtwAbBKSS9dOK7Ax2kzWz4H3NarBPBMOJNOuSAJJQY6iHr8N6hfafZKjTKvxPvpYe7VGGvh70GEr3JdzLijTBxzgacrXlq4DIxT6omev+13VhRnKWKkRs7OgKq90kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779111059; c=relaxed/simple;
	bh=K7+3DEdyIVkpAkj1WUPRR53zfFegqvKtHC85qqPR9CA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E63meuW25G7ANBG9uvHSrhpyDH976ddNHNqMtCi+7TDQ7/bETpxRkGUzF3iE8khGB7qV2AGhQQ8Zy2H/oXqrOpv7XtcRnOmRVMMQNLzo/VLy3Vfapm5Z36VBXiEnEIPbsnEvL6iSZHDn288/nZ6AInuVIdicw6oqf8dZXr5Zb9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foTzNW2d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39F1C2BCB7;
	Mon, 18 May 2026 13:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779111058;
	bh=K7+3DEdyIVkpAkj1WUPRR53zfFegqvKtHC85qqPR9CA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=foTzNW2dQUaqMC3E/voXV6FC5uFZT2dYSJi4iaCP6YibdO3tlP4/1eZOKVdkWcu/v
	 awGkIYXazN4NTDXENsnulwzAjlycSZdIgMlxHE9HOVPb0RyVNlkyYJ0K7ohZCg6xdu
	 7dTENzttLVYXYUgu6ad/h1fvYMfQkbfTRCqNlnC4D0LWIXXufVXoQL4PWZfwj4DVSD
	 jHlhbB60MTPQSPqiuGWDsoXrQ8cE87slPDVqZSaXN7Fx/ZPo1g9qn6I8iPvEqeJgmW
	 nGsb9wKhHbMjKE15F1Uoch49iRByNQln/X6ng9JYaDdcXHfU7haYiPCH70UJfzjbFr
	 S87xwOFZk1OfA==
Date: Mon, 18 May 2026 16:30:54 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: linux-rdma@vger.kernel.org, jgg@ziepe.ca, mrgolin@amazon.com,
	gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com,
	mbloch@nvidia.com, yanjun.zhu@linux.dev, marco.crivellari@suse.com,
	roman.gushchin@linux.dev, phaddad@nvidia.com, lirongqing@baidu.com,
	ynachum@amazon.com, huangjunxian6@hisilicon.com,
	kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com,
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com,
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next v5 00/15] RDMA: Introduce generic buffer
 descriptor infrastructure for umem
Message-ID: <20260518133054.GU33515@unreal>
References: <20260517063006.2200680-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517063006.2200680-1-jiri@resnulli.us>
X-Rspamd-Queue-Id: 07EAB56DAF2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20910-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sun, May 17, 2026 at 08:29:51AM +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> This patchset introduces a generic buffer descriptor infrastructure
> for passing memory buffers (dma-buf or user VA) to uverbs commands,
> and wires it up for CQ and QP creation in the uverbs core, efa, mlx5,
> bnxt_re and mlx4 drivers.
> 
> Instead of adding ad-hoc per-buffer UAPI attributes for each new buffer
> type, each command declares dedicated UVERBS_ATTR_UMEM attributes that
> carry one buffer descriptor each. Each descriptor specifies a buffer
> type, covering both VA and dma-buf. A consumption check ensures
> userspace and driver agree on which attributes are used.
> 
> The patchset:
> 1-2,4. Plumbing: rename ib_umem_get() to ib_umem_get_va() and re-route
>    it through the new central ib_umem_get(); no behaviour change.
> 3. Introduces the core buffer descriptor infrastructure and UAPI.
> 5. Factors out CQ buffer umem processing into a helper.
> 6. Adds the CQ buffer UMEM attribute and driver wrappers.
> 7-10. Converts efa, mlx5, bnxt_re and mlx4 to use the new CQ helpers,
>    with drivers taking umem ownership.
> 11. Removes the legacy umem field from struct ib_cq, now that all
>    drivers use the new helpers.
> 12. Adds optional whole-QP, RQ and SQ UMEM attributes to QP creation.
> 13. Converts mlx5 QP creation to use the new attributes.
> 14-15. Adds mlx5 driver-namespace UMEM attributes for CQ and QP
>    doorbell records.
> 
> ---
> Based on top of: https://lore.kernel.org/all/0-v1-045258567bd6+9fe-ib_uverbs_support_ko_jgg@nvidia.com/

The overall approach looks sane to me.

I have a few minor comments, mostly related to how I expect the
ib_umem_get_*() helpers to be used:

1. We should hide the ib_umem_get() function and export only
   ib_umem_get_va(), ib_umem_get_attr(), and
   ib_umem_get_attr_or_va(). I do not want to see drivers relying on
   ib_umem_get() again.

2. Pass a struct uverbs_attr_bundle *attrs instead of struct ib_udata
   *udata to ib_umem_get().

3. Consider simplifying ib_umem_get() further by passing in the desc.
   I am not fully convinced it helps, but it could allow handling
   va_fallback outside of ib_umem_get().
 
Thanks

