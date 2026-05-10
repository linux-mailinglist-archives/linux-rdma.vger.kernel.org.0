Return-Path: <linux-rdma+bounces-20302-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id E+JENTJkAGr5IQEAu9opvQ
	(envelope-from <linux-rdma+bounces-20302-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 12:55:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 518B6503AE6
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 12:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB2D5300BC91
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 10:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A64B365A0B;
	Sun, 10 May 2026 10:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCkFu7Lt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E048319EED3;
	Sun, 10 May 2026 10:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778410540; cv=none; b=sdLa+NN/Zuy78biPu313SV6TdjZh5gRQ8HBCu4nit6bWCW8kU1VHYAyKGdoVRlyKc3FU9nv6nnMD14iJ2rcxYTV4kbu/2WxPofqyf3n9D6Nlf0XqXyMzh8REts5MEEHMfXW8Jt88DSs25Pgc3Y06N3FJhJF0mY6JN3W8cqFqIGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778410540; c=relaxed/simple;
	bh=j5HsySVcF70zNJVNTswnKoGhsSWDStOXoEo5MwbBCaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5AjW8mBkLXBRYBSzW1fK5BojPCtM049G1tu9/8O7ICprSkGbsf+bNJ96q6b6KISDJezK3C6Wmoa2XVahQxtJv7ys2PkW4Ci8xb4HdgBoX03ktqyVu1WwWyr2Kr0mlEA/n7IsuFSF2g82W5oq746CuGLoP+3LNMN7BvKX4Y7YWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCkFu7Lt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB1D0C2BCB8;
	Sun, 10 May 2026 10:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778410539;
	bh=j5HsySVcF70zNJVNTswnKoGhsSWDStOXoEo5MwbBCaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YCkFu7LtIJ1f7PhsTQeSdZKD89eHX66t02RqK7TrNCh/f/wtm1fd8KXklKwlG882v
	 WPuQpP/JNAZqjkgGbFuTdDuF/Jd9ovjr6lVfieDXo+4sAxMCwv+pbbNSrGrjnOgtvy
	 I75st8FIj8wouzxhc6TBQSKcSF76rNTwjV/Lc7p423BYTBtaIr2qagoITBvRsOrwmq
	 Bl7lP71WA0YqZupl5AdWfV2C5Y1YmxEnGg9k839NqJ9bsCWUQouBVwSSSNIieJnZTs
	 gMlr+3JdvFRbMiXzxkRhhrUleg5Ulu4H3GyQZV+KJsN3K8olWd+3djW4TFkX/ThIXP
	 Vkx3/5eXQwfrA==
Date: Sun, 10 May 2026 13:55:31 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, dledford@redhat.com,
	haggaie@mellanox.com
Subject: Re: [PATCH v9 0/2] IB/mlx5: Fix loopback rollback and locking
Message-ID: <20260510105531.GD15586@unreal>
References: <20260410005219.5197-1-prathameshdeshpande7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410005219.5197-1-prathameshdeshpande7@gmail.com>
X-Rspamd-Queue-Id: 518B6503AE6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20302-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, Apr 10, 2026 at 01:52:16AM +0100, Prathamesh Deshpande wrote:
> This series fixes transport-domain rollback and loopback state
> consistency in mlx5 IB.
> 
> Patch 1 fixes TD rollback on mlx5_ib_enable_lb() failure, makes the
> success return path explicit, and initializes lb.mutex earlier.
> 
> Patch 2 serializes MP force-enable state updates with lb.mutex and
> implements capability-aware thresholds (td_base) to ensure correct
> loopback behavior on both TD-capable and no-TD hardware.
> 
> v9:
> - Address race/state issues around force_enable and enabled.
> - Fix TD leak on failure after successful allocation.
> - Implement hardware-aware thresholds via mlx5_ib_lb_td_base() to
>   handle both TD-capable and no-TD hardware correctly.
> - Serialize MP force-enable transitions under lb.mutex.
> 
> v8:
> - Resubmitted as a fresh, independent thread per maintainer request.
> - No functional changes since v7.
> 
> v7:
> - Split the series into two patches to isolate the return-value/mutex 
>   initialization fix from the refcounting logic.
> - Moved force_enable check after increments/decrements to fix leaks.
> - Updated hardware disable condition to a strict zero-check.
> 
> v1-v6:
> - Initial combined versions.
> - Added deallocation of tdn on failure.
> - Moved mutex_init to stage_init_init to prevent crashes on non-ETH.
> - Implemented atomic rollback in enable/disable paths.
> 
> Prathamesh Deshpande (2):
>   IB/mlx5: Fix transport-domain rollback and initialize lb mutex earlier

I agree that this patch is needed.

>   IB/mlx5: Serialize force-enable state and preserve loopback accounting

This change does not appear to be justified. The commit message provides no
clear explanation of why it is needed.

Thanks

> 
>  drivers/infiniband/hw/mlx5/main.c | 81 +++++++++++++++++++++++--------
>  1 file changed, 62 insertions(+), 19 deletions(-)
> 
> -- 
> 2.43.0
> 

