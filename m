Return-Path: <linux-rdma+bounces-20384-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILhMIafAAWrKjQEAu9opvQ
	(envelope-from <linux-rdma+bounces-20384-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 13:42:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BBA50CF90
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 13:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 942C33007AF6
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 11:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC19371D1F;
	Mon, 11 May 2026 11:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJQtD5uC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EABA2F8E95;
	Mon, 11 May 2026 11:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778499361; cv=none; b=J9MjOTVVb01bQJEOUcgYYvzBG4zGRr1qxnzOhLp/qaEenEpYOO1t/I9xaKYK6dgjnilIVAsjHLLyXnYCBzlPUWQ8jKu5myihjb706jkEf5cQ9hnTQnlSxb2dkz4iVtwTMSaoppTZK6+cuS1rCt/xYWrCoHrPyqsL9sPtA9MmHCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778499361; c=relaxed/simple;
	bh=2y8tawGQ+aNx02LDAJiNOmgN3ENXXy/bdxiN1G9aqwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnsfn7L3o1FB6bo7+umm24BEdSHdgit0mDALeEDFtk+72ZE034APIB1ez+7As2a5Vzw+Ts5MGPyxqz1IdcCd41a7pJjTAapW5DGzLtwhjSAFkayHuFrSt2gV6XjsoO1haxyya8qILdGTopwPHU5oQiFKYraEy8oFlQ3c2y505DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJQtD5uC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD22DC2BCB0;
	Mon, 11 May 2026 11:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778499361;
	bh=2y8tawGQ+aNx02LDAJiNOmgN3ENXXy/bdxiN1G9aqwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jJQtD5uCbZF6QJCrq52ZMUPHce95fAqXff4DcWp/KbCgxmDjW+vG8wFgoATj8Q6I1
	 63gA8gfpdtREtlMHEuCBYncs7VsSozTqcetiFw9ItQTcsFrmerZZM3SQoyMyhff6Dj
	 7ZypIt59XR1UTfFOandi7M6j+J6m74U1JqxXyj9w1rndukIfQ/6D/y3ktR94xLeV9K
	 rYwJoqZ8dLDfQTdVVvdQPeXzS9ot9z+SjGsq6tXExBQpSTU2SoJ+yjQ+LwhN7X/LoD
	 O6lx6/2ZyB22HEecaslWh6i6n+7B5Jx0w5aiTIA4zQ57ODsXUMWgebxYL/ndFjdQ6E
	 SXifyoYZz/7Jg==
Date: Mon, 11 May 2026 14:35:56 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Vaishali Thakkar <vaishali.thakkar@ionos.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/rtrs: Fix use-after-free in path files cleanup
Message-ID: <20260511113556.GH15586@unreal>
References: <20260428105515.362051-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428105515.362051-1-lgs201920130244@gmail.com>
X-Rspamd-Queue-Id: D7BBA50CF90
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
	TAGGED_FROM(0.00)[bounces-20384-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, Apr 28, 2026 at 06:55:15PM +0800, Guangshuo Li wrote:
> Once kobject_put() is called on srv_path->kobj, the release callback may
> be triggered and srv_path may be freed. Therefore, srv_path must not be
> dereferenced after kobject_put(&srv_path->kobj).
> 
> However, both rtrs_srv_create_path_files() and
> rtrs_srv_destroy_path_files() call
> rtrs_srv_destroy_once_sysfs_root_folders() after
> kobject_put(&srv_path->kobj). The helper dereferences srv_path to get
> srv_path->srv, which can lead to a use-after-free.
> 
> Fix this by calling the sysfs root folder cleanup helper before
> kobject_put(&srv_path->kobj), so srv_path is still valid when the helper
> accesses it.

This sentence is unclear. The srv_path reference appears many lines after  
rtrs_srv_destroy_path_files(). What exactly is the issue you are addressing  
here?

Thanks

