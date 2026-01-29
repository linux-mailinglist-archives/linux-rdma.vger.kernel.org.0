Return-Path: <linux-rdma+bounces-16175-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKEVELTqemkV/gEAu9opvQ
	(envelope-from <linux-rdma+bounces-16175-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 06:05:56 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AECABCB4
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 06:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7227F3017C10
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 05:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B929B2D5408;
	Thu, 29 Jan 2026 05:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sflcOEj9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A403273D8D;
	Thu, 29 Jan 2026 05:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769663148; cv=none; b=FFvnGMMG+lSkRtVBmtGzoIgGCl/X59lE8YoAJXhe9Pr0pAMaw4+6wYx7307/CToRsxxQ72WXc6e97jUUPV/Imfd9UhY7AdTTAyHce/fbaXWbpOFNjGNsksxmMOd6y7QcQfmUSlN07bKT3+0EJyygQ+1KOZYwQYcQlFU2oOLyH5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769663148; c=relaxed/simple;
	bh=2ycOZV/aDhv1dnoshKby9sCyEJ+atGbAFRg4hxsuMEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IH3IeRSi4zRMCzXVsZ3ISN1epgGt5QeNgxttEsvjpYrVf8KaLlFYu8fEm4NHptpEhd5PTsMe2eS1eFyJkREcU/gDmG1ZRRidTHMJZSFLmula/AKqxqEyKomQBPw18eXGgMbMIcL0y9oDtSk3cglh3/RY+9m2mAkmuf1Do6xu/vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sflcOEj9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6948FC116D0;
	Thu, 29 Jan 2026 05:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769663148;
	bh=2ycOZV/aDhv1dnoshKby9sCyEJ+atGbAFRg4hxsuMEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sflcOEj9/nPim/zo7LkculFDDGScNI4ST/uKk2IkNYuq8hZcBiQE5Cs3C1rwdtvSu
	 KjJtzByXZOlvYxJy9MZWaa6AHAfzW4sVHSJSdjxi+FiWX86Vl2S5Ucb/DME4XnBrVV
	 nNqCc+22j6RuxxJhzlh05DtPFgHCPnGuYz7IAVOQZtHLX7PH0yMKs+xp0c129AprpU
	 LOFomyq/NUjHNJ9ggFQOJmb1T947zjazWUeZxWjD2tJR3DF3as83h2lHNz42Gb3UDu
	 FQkeNWc+oZXOsa7+c0lZRpIJhS1hGBBgfKX3ytarqCvX3wr5UAl6PNWqd4rD8YuLZe
	 kHy01i3m3Cv9Q==
From: Jakub Kicinski <kuba@kernel.org>
To: achender@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	edumazet@google.com,
	allison.henderson@oracle.com,
	horms@kernel.org,
	linux-kselftest@vger.kernel.org,
	rds-devel@oss.oracle.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	linux-rdma@vger.kernel.org
Subject: Re: [net-next,v2,1/7] net/rds: new extension header: rdma bytes
Date: Wed, 28 Jan 2026 21:05:46 -0800
Message-ID: <20260129050546.374517-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128011351.78511-2-achender@kernel.org>
References: <20260128011351.78511-2-achender@kernel.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16175-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E9AECABCB4
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net/rds: new extension header: rdma bytes

This patch introduces a new RDS extension header RDS_EXTHDR_RDMA_BYTES
for RDMA byte accounting and refactors rds_message_add_extension() to
support multiple extensions per message instead of just one.

> diff --git a/net/rds/ib_send.c b/net/rds/ib_send.c
> index f9d28ddd168d..03afe3df902d 100644
> --- a/net/rds/ib_send.c
> +++ b/net/rds/ib_send.c
> @@ -577,11 +577,29 @@ int rds_ib_xmit(struct rds_connection *conn, struct rds_message *rm,
>  		/* If it has a RDMA op, tell the peer we did it. This is
>  		 * used by the peer to release use-once RDMA MRs. */
>  		if (rm->rdma.op_active) {
> -			struct rds_ext_header_rdma ext_hdr;
> +			struct rds_ext_header_rdma ext_hdr = {};
> +			struct rds_ext_header_rdma_bytes
> +				rdma_bytes_ext_hdr = {};
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
> +
> +			if (rds_message_add_extension(&rm->m_inc.i_hdr,
> +						      RDS_EXTHDR_RDMA_BYTES,
> +						      &rdma_bytes_ext_hdr)) {

The new rds_ext_header_rdma_bytes struct contains __be32 + u8 = 5 bytes
of data, but without __packed it will be padded to 8 bytes. This means
sizeof(struct rds_ext_header_rdma_bytes) returns 8, not 5.

With the h_exthdr space limited to 16 bytes, adding RDS_EXTHDR_RDMA
(1+4=5 bytes) plus RDS_EXTHDR_RDMA_BYTES (1+8=9 bytes) consumes 14 bytes,
leaving only 2 bytes available.

> +				/* rdma bytes ext header was added successfully,
> +				 * notify the remote side via flag in header
> +				 */
> +				rm->m_inc.i_hdr.h_flags |=
> +					RDS_FLAG_EXTHDR_EXTENSION;
> +			}
>  		}
>  		if (rm->m_rdma_cookie) {
>  			rds_message_add_rdma_dest_extension(&rm->m_inc.i_hdr,
>  					rds_rdma_cookie_key(rm->m_rdma_cookie),
>  					rds_rdma_cookie_offset(rm->m_rdma_cookie));
>  		}

When rm->rdma.op_active and rm->m_rdma_cookie are both set, could this
cause rds_message_add_rdma_dest_extension() to silently fail? The
RDS_EXTHDR_RDMA_DEST extension requires 9 bytes (1+8), but only 2 bytes
remain after the RDMA and RDMA_BYTES extensions are added.

The return value of rds_message_add_rdma_dest_extension() is not checked
here. If both conditions are true, the RDMA destination cookie would be
silently dropped without any indication to the caller.

Should the struct be marked __packed to use only 5 bytes on the wire, or
should there be handling for the case when extension space runs out?

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

Without __packed, this struct will be 8 bytes due to padding after h_rflags.
The other extension header structs (rds_ext_header_rdma, rds_ext_header_rdma_dest)
use only __be32 fields so they have no padding concerns.

