Return-Path: <linux-rdma+bounces-17205-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOPGGv/zn2kyfAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17205-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 08:19:27 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 200F01A1C19
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 08:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4C1CD30364E4
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 07:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80F7387599;
	Thu, 26 Feb 2026 07:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNb1bNdy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6092F1FDB
	for <linux-rdma@vger.kernel.org>; Thu, 26 Feb 2026 07:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772090357; cv=none; b=ZVY2HP5Yov0V+nrhCVNOKblg0o6Ek55lpOqq5RLWooBxCUxpXxc7FdRVu7FgqEHv/QR7KdxUj4o3QdrH/1gN4aJa0TkXiyFwcz8jRTumkLjwB4rn2DAKnT62Rc6Po45Vfv0RIKmagjFK4gazajUSxaYpZmxVMEnPq6y+OM2U4x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772090357; c=relaxed/simple;
	bh=HMg+i1WylRKqTTveRXRGiiACBPovax14TDQ9mtRJ8vA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NOkg438y48xGD/jy0/wWrj+1f9cvo0TZkwXjtUIx6aold/bGzG7/Cat/ziMPQykaY5wt/hjwBbJpJjFP+zkY4r4hiZIpmZ9Hj5sMs6SoysoHFHTuU5WJyHMiy0jvFFhp1DEvAWxDj+wagtiHKJeRAV0f6JfFC894LkE6AO0PU/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNb1bNdy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3EBDC2BC87;
	Thu, 26 Feb 2026 07:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772090357;
	bh=HMg+i1WylRKqTTveRXRGiiACBPovax14TDQ9mtRJ8vA=;
	h=Date:From:To:Subject:From;
	b=ZNb1bNdytJmLKx1e1mXb4qxPWy8uB4+rocXA0MXGbxCVgcPYab9r7jXHJvF2vLjju
	 ZvTE7QH1HDnpvd5OAxm0zXb9fGys0k7TY+BRZdncXJhJHnpZSc+eTKKGPGZkmpnMT0
	 fwpiGXJY3/6jX8s0mDb2VfUofcCoIaLTVGkQTO2ijtX1XHK8mSIxwLgDewtf3vBqPn
	 i7a0TESHptw6ssEQQbyzkPQlWGuAUy/ZWuOw5j0QMUd+Q9b2CN15i1f9i9ovxxt+8C
	 P9wMv8zszogWn2oeWmohEEvpcU6ghrjLaVp+AeuXz1bMEsm8c1MAV+2ZM/UVtA20ue
	 AYz8Es8/opz0w==
Date: Thu, 26 Feb 2026 09:19:13 +0200
From: Leon Romanovsky <leon@kernel.org>
To: RDMA mailing list <linux-rdma@vger.kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: New memory allocation API
Message-ID: <20260226071913.GD12611@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-17205-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 200F01A1C19
X-Rspamd-Action: no action

Hi,

Please be aware that v7.0-rc1 has two commits:
bf4afc53b77a ("Convert 'alloc_obj' family to use the new default GFP_KERNEL argument")
69050f8d6d07 ("treewide: Replace kmalloc with kmalloc_obj for non-scalar types")

Which changes old and well known kmalloc*() calls to kmalloc_obj():

    Single allocations:     kmalloc(sizeof(TYPE), ...)
    are replaced with:      kmalloc_obj(TYPE, ...)

    Array allocations:      kmalloc_array(COUNT, sizeof(TYPE), ...)
    are replaced with:      kmalloc_objs(TYPE, COUNT, ...)

    Flex array allocations: kmalloc(struct_size(PTR, FAM, COUNT), ...)
    are replaced with:      kmalloc_flex(*PTR, FAM, COUNT, ...)

    (where TYPE may also be *VAR)

    The resulting allocations no longer return "void *", instead returning
    "TYPE *".

Thanks

