Return-Path: <linux-rdma+bounces-18470-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJUuBYGMvWnY+wIAu9opvQ
	(envelope-from <linux-rdma+bounces-18470-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 19:05:53 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 947932DF25B
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 19:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A775B309E790
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 18:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236043126BF;
	Fri, 20 Mar 2026 18:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYgLdN6D"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16C330C37E;
	Fri, 20 Mar 2026 18:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774029695; cv=none; b=Tf4qcIE58DNmxpL6RRyjxDkRiYlfKA5MXH7OEjAnwjU/yvWgrU2rSrwMGtduNMdfgQu6LxomKty6+a+pWXiLq+oNygyyMW63YUxc1L6KZEeCkTMdSwURrZf+msOQs6t+KmkB1VObdB13UsYm05KmwIBWQJLoApXt5zy40jyfHyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774029695; c=relaxed/simple;
	bh=voOJxTIuc7syiB4KCb/UfinxouPOEg0BtSsyui5jF2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JSbz1TSSl46mPVQ6AY12Dslxs7eDo/PMDIQ51wthBLM+2WqyhsqcklkYA5rBO0hxy45I6x0Ex2ijVt3Wa6C5J2EJxvEBjwr797KY5S7djNLkTRs44wz8TgoQPMTP/QjqW6gD7JzKq49gkwXOGh/OeU8EN3mE+pVQq8RZiRVJom4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYgLdN6D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E401C4CEF7;
	Fri, 20 Mar 2026 18:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774029695;
	bh=voOJxTIuc7syiB4KCb/UfinxouPOEg0BtSsyui5jF2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LYgLdN6DaqOtN1QpV90HDcLIygWcTzJmFRs8CGWwyQJVp5FxL+tFgCr34nn4ZMWOW
	 m97SqIJTPO2diJKIc8fhnoZYz75+W5UvsFdXiig3Xe0d+uRiYkMwmVohNqN6Nm4eZS
	 ZmHCJZ/Du4B/AOEe+PWnPeN1DoiF0VCcYuCG4dHB1ntP0YUWgiKSFNJVPwqxfQJ2AC
	 7XQ5SVJmXx1PM39KgJC2e5KCjbj9E/t4yfkLfKawpZWub5HnshVKsBFV6eE4xL8mG6
	 F0+nGJlgUd5ZcQc6Tezaa/i2FEMnu6jMa9d20kflddAi3JUK+IOpIM4ZGmKthq90Tx
	 BnvCtDRBQim4g==
Date: Fri, 20 Mar 2026 11:01:35 -0700
From: Kees Cook <kees@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] [RESEND] RDMA/hfi1: use a struct group to avoid
 warning
Message-ID: <202603201101.CA57529EAD@keescook>
References: <20260320151511.3420818-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320151511.3420818-1-arnd@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18470-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kees@kernel.org,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 947932DF25B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 04:12:37PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> On gcc-11 and earlier, the driver sometimes produces a warning
> for memset:
> 
> In file included from include/linux/string.h:392,
>                  from drivers/infiniband/hw/hfi1/mad.c:6:
> In function 'fortify_memset_chk',
>     inlined from '__subn_get_opa_hfi1_cong_log' at drivers/infiniband/hw/hfi1/mad.c:3873:2,
>     inlined from 'subn_get_opa_sma' at drivers/infiniband/hw/hfi1/mad.c:4114:9:
> include/linux/fortify-string.h:480:4: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror]
>     __write_overflow_field(p_size_field, size);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> This seems to be a false positive, and I found no nice way to rewrite
> the code to avoid the warning, but adding a a struct group works.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

