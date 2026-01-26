Return-Path: <linux-rdma+bounces-16023-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id tn0aBXyod2nrjwEAu9opvQ
	(envelope-from <linux-rdma+bounces-16023-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 18:46:36 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B05418BA24
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 18:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEFDB3024150
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 17:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE4E1F4CBC;
	Mon, 26 Jan 2026 17:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOseg3Jk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0BA3C38;
	Mon, 26 Jan 2026 17:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769449588; cv=none; b=BIWqdVBN8YAbenBPz3h8B+8Us48FUYEtu0xjswpRyH0b4hVp1o1wtvj6Pfi2jOPZGrz68tXx6Pz/uB2t2E/b9IgDtFJdxRoN2gQqUjt1WkdM1ErZixXCy+grFGEw5R1FN4JWIbn3CuseTUAa22Vm1zIM8kU0/AaXl1OcvwDMjzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769449588; c=relaxed/simple;
	bh=MkMz063z61trmJHAkmyu5zxLK56OJbD+64xxAoF0lyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mcibjhi6xtXXggwT9Q2CUq07DJKG2gvrZJiFcht09kwO4EX8zLYh02DbWlIFSsgZf1mXEvz3tUhY9hBqRFnbkTnoh0zBJ+pzuzqij9IhQxtPcWCZNTQLuFZvI7KL0kyV8pcEPwizqtVu6fO04ygHOkUJTsg3u/ZSX8fcFBQMCes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOseg3Jk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B1FC116C6;
	Mon, 26 Jan 2026 17:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769449588;
	bh=MkMz063z61trmJHAkmyu5zxLK56OJbD+64xxAoF0lyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SOseg3JkwZQUiosWnMiF5Rk2nzbSn/o3iwAgcI+rQvimy01qGVka43UiXWDtKtp6U
	 PC7adp9+f8M+/1PVSRAU4HmB/uhOAr8IWxO1pLiqflEwHY7aX5gMTkg68ncNihMisL
	 CceSaESURC6KMPmkJKtOhD7KOBPCAP9sTt25O7jQt3ZeQzAm6SSvwk5aCAdPMyquYc
	 CK2KmSyb8hhMSKqVuPV4GV5bAfBvcYu2b5sS9g8mtby+4lUnmLKqEoLfyJyFPyPxq0
	 vqCWgc7Hv1B2qAnAg/hDRoAokmno/4AwGzw5rjdDxTuhooxdgFGjMMD7rzzq9v2ijT
	 pd3JVLG9fmqrw==
From: Simon Horman <horms@kernel.org>
To: achender@kernel.org
Cc: Simon Horman <horms@kernel.org>,
	pabeni@redhat.com,
	rds-devel@oss.oracle.com,
	netdev@vger.kernel.org,
	allison.henderson@oracle.com,
	edumazet@google.com,
	linux-kselftest@vger.kernel.org,
	kuba@kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [net-next,v1,1/7] net/rds: new extension header: rdma bytes
Date: Mon, 26 Jan 2026 17:46:20 +0000
Message-ID: <20260126174620.1393182-1-horms@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260125070651.207042-2-achender@kernel.org>
References: <20260125070651.207042-2-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16023-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: B05418BA24
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net/rds: new extension header: rdma bytes

This patch introduces a new extension header type RDS_EXTHDR_RDMA_BYTES
to allow RDMA initiators to exchange byte counts with their targets for
statistics and policy purposes. It also expands rds_message_add_extension()
to support multiple extensions per message.

> diff --git a/net/rds/rds.h b/net/rds/rds.h
> index 8a549fe687ac..cadfd7ec0ba9 100644
> --- a/net/rds/rds.h
> +++ b/net/rds/rds.h

[ ... ]

> @@ -258,6 +259,19 @@ struct rds_ext_header_rdma_dest {
>  	__be32			h_rdma_offset;
>  };
>
> +/*
> + * This extension header tells the peer about delivered RDMA byte count.
> + */
> +#define RDS_EXTHDR_RDMA_BYTES	4
> +
> +struct rds_ext_header_rdma_bytes {
> +	__be32		h_rdma_bytes;	/* byte count */
> +	u8		h_rflags;	/* direction of RDMA, write or read */
> +};

This struct has 5 bytes of actual data but sizeof() will return 8 bytes
due to alignment padding. The 3 padding bytes after h_rflags are not
initialized when this struct is used in rds_ib_xmit(). Since
rds_message_add_extension() copies sizeof(struct) bytes via memcpy(),
those uninitialized padding bytes get transmitted to the peer.

Should this struct be marked __packed, or should the declaration in
rds_ib_xmit() use a zeroing initializer like = {} to avoid leaking
kernel stack contents over the network?

> diff --git a/net/rds/ib_send.c b/net/rds/ib_send.c
> index f9d28ddd168d..8282ff61b0b3 100644
> --- a/net/rds/ib_send.c
> +++ b/net/rds/ib_send.c
> @@ -578,10 +578,27 @@ int rds_ib_xmit(struct rds_connection *conn, struct rds_message *rm,
>  		 * used by the peer to release use-once RDMA MRs. */
>  		if (rm->rdma.op_active) {
>  			struct rds_ext_header_rdma ext_hdr;
> +			struct rds_ext_header_rdma_bytes rdma_bytes_ext_hdr;
>
>  			ext_hdr.h_rdma_rkey = cpu_to_be32(rm->rdma.op_rkey);
>  			rds_message_add_extension(&rm->m_inc.i_hdr,
> -					RDS_EXTHDR_RDMA, &ext_hdr, sizeof(ext_hdr));
> +						  RDS_EXTHDR_RDMA, &ext_hdr);
> +
> +			/* prepare the rdma bytes ext header */
> +			rdma_bytes_ext_hdr.h_rflags = rm->rdma.op_write ?
> +				RDS_FLAG_RDMA_WR_BYTES : RDS_FLAG_RDMA_RD_BYTES;
> +			rdma_bytes_ext_hdr.h_rdma_bytes =
> +				cpu_to_be32(rm->rdma.op_bytes);

Here rdma_bytes_ext_hdr is declared on the stack without initialization.
Only h_rflags and h_rdma_bytes are assigned, leaving the 3 padding bytes
uninitialized. When rds_message_add_extension() calls memcpy() with
len = sizeof(struct rds_ext_header_rdma_bytes) = 8, those uninitialized
bytes are copied into the header and sent to the peer.

[ ... ]
-- 
pw-bot: cr

