Return-Path: <linux-rdma+bounces-20392-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFrOC0PTAWqokgEAu9opvQ
	(envelope-from <linux-rdma+bounces-20392-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 15:01:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2626150E7AE
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 15:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 62297300BCB8
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 12:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E4A3A3833;
	Mon, 11 May 2026 12:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPKTQvDP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D2236AB61;
	Mon, 11 May 2026 12:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778503835; cv=none; b=l5wj9aK0T55iBjWgvx7JbWBFoyv8iQPehkmIfiyMggEB99rF3fWbXiWUWPSHlnaW0/0U/BVFeckV5uzKGEcH4eXuM2v0at3WBMYvBWuSxvhZEiyVDia+FCu5iWI2KhWZrpExMuVpH/xiSp8d0XxlNgzok8QXgTgd/ug7q3+HrRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778503835; c=relaxed/simple;
	bh=1Twa6uesN0szXFlZCM6LGRSYEhaOeIwnikAIuueSnxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bU4zReSuW4nC74NjT1fupMSQQF//wzLRVhLYe5g3gjJj9UjUhk5sozv3xwQlV0YdHLEbDPrbRdjQ1nrNi8v89R8D3GJS9SO/EoQfDdYb3wsxTeLZVnjBXGI3M1nj/LRn0mUqwgIHDPQlZpu7uliBGfkQhD0ucC8kld5nLfYHRLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPKTQvDP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F817C2BCF7;
	Mon, 11 May 2026 12:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778503835;
	bh=1Twa6uesN0szXFlZCM6LGRSYEhaOeIwnikAIuueSnxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OPKTQvDPQ06IKRcxLVqHptCyh4gYE3VvZTq/AEd6CLK+37fVUzKExgAotrOPsvtXe
	 duQ5TYAERrWKHjQOxa/IQbLrzezsZyKS47I3pIo9QsyKxtPVMGtSITAX3IUEuaJEzu
	 r0VCeMYetQdy7i1HrkWIsvzH4+W8M3YG3T29t/I5XSVFqmz5xYMEjukAJJQfOSBLs2
	 ELHTPWSZWQsoQMzOx6ucrsKXbWLiXfF5rPCCQa+M4rio1EOoPefCD+r3wejRejAA9q
	 3AB9HzYBkBUCRDLdvI779OawzgorYhqDy28xQtgQPyAqP5NRboSZjjxOu0In1THcEC
	 LHa1gEIZoL1Ag==
Date: Mon, 11 May 2026 15:50:28 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc: jgg@ziepe.ca, brett.creeley@amd.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, allen.hubbe@amd.com, nikhil.agarwal@amd.com,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] RDMA/ionic: Support QP transport mode selection in
 create and modify
Message-ID: <20260511125028.GJ15586@unreal>
References: <20260430123931.3256130-1-abhijit.gangurde@amd.com>
 <20260430123931.3256130-4-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430123931.3256130-4-abhijit.gangurde@amd.com>
X-Rspamd-Queue-Id: 2626150E7AE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20392-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Action: no action

On Thu, Apr 30, 2026 at 06:09:31PM +0530, Abhijit Gangurde wrote:
> Allow userspace to specify the QP transport mode and number of
> reorder completion queue paths during QP creation and modification.
> 
> Extend ionic_qp_req with transport_mode, num_rcq_paths, and
> ionic_flags fields. The transport mode selects the firmware QP type,
> ionic_flags are forwarded in the upper bits of priv_flags during
> QP creation, and num_rcq_paths is passed to firmware during QP
> modify.
> 
> Co-developed-by: Allen Hubbe <allen.hubbe@amd.com>
> Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> ---
>  .../infiniband/hw/ionic/ionic_controlpath.c    | 16 +++++++++++-----
>  drivers/infiniband/hw/ionic/ionic_fw.h         | 18 +++++++++++++++---
>  drivers/infiniband/hw/ionic/ionic_ibdev.h      |  1 +
>  include/uapi/rdma/ionic-abi.h                  |  5 ++++-
>  4 files changed, 31 insertions(+), 9 deletions(-)

<...>

> +enum ionic_qp_transport_mode {
> +	IONIC_QPT_TRANSPORT_ROCE_V2 = BIT(0),
> +	IONIC_QPT_TRANSPORT_MRC = BIT(1),
> +};
> +
>  /* admin queue qp type */
>  enum ionic_qp_type {
>  	IONIC_QPT_RC,
> @@ -228,16 +235,21 @@ enum ionic_qp_type {
>  	IONIC_QPT_XRC_INI,
>  	IONIC_QPT_XRC_TGT,
>  	IONIC_QPT_XRC_SRQ,
> +	IONIC_QPT_MRC,
>  };
>  
> -static inline int to_ionic_qp_type(enum ib_qp_type type)
> +static inline int to_ionic_qp_type(enum ib_qp_type type,
> +				   enum ionic_qp_transport_mode tm)
>  {
>  	switch (type) {
>  	case IB_QPT_GSI:
>  	case IB_QPT_UD:
>  		return IONIC_QPT_UD;
>  	case IB_QPT_RC:
> -		return IONIC_QPT_RC;
> +		if (tm == IONIC_QPT_TRANSPORT_MRC)
> +			return IONIC_QPT_MRC;
> +		else
> +			return IONIC_QPT_RC;

We have historically treated vendor-specific QP types as special cases and
routed them through IB_QPT_DRIVER.

IB_QPT_RC represents a standard RC QP and is expected to follow the
specification.

Thanks

