Return-Path: <linux-rdma+bounces-19905-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNv0M9JW+GnTtAIAu9opvQ
	(envelope-from <linux-rdma+bounces-19905-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 10:20:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BAB4BA191
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 10:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8402302FA95
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 08:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE4B322C67;
	Mon,  4 May 2026 08:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="pUB7nG6O"
X-Original-To: linux-rdma@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E813031960A;
	Mon,  4 May 2026 08:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777882645; cv=none; b=azkzeDemnZvK47Rxax8RUIlXIfxjaiYdOLZzr1Botl5mwyA7GRpFObBb3OUQN3qzi10v2Cf+BhCKeLbPa8QaJf+sCrPmjRQLtO+6D50jbxpb01HBJORcyCoJHKPAxlZ/0G7fNdCGQfpBUNpwPWlUETTgvdbanqYnNSEJRnwPCk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777882645; c=relaxed/simple;
	bh=EuniNuEYxBkkB4X2Bs7q/ODsykOGpqr01OM3SdcgJZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M0U365JlDc32/DDYfMpwO5hvP7xBNtXpNLabzxWCukO26qW3SonvPQ+tlNBcQFtzG8UqBhE1UbMcmVPup2PvIliWgt84hsH2t5KO1no2QgKS1OsSkmgnQY45qUPdWx6Qid2eyXIncUUmMROOiOcklXrPsg7uqLifVcaJrTIJBSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=pUB7nG6O; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4g8Dyq3d7YzlfwHM;
	Mon,  4 May 2026 08:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1777882639; x=1780474640; bh=mpd7W5RdFLDGCC27qqAHwVlZ
	/nB/+RSFRbleOhj5nxI=; b=pUB7nG6OpdF8FFiMfbiZVRUJhAZNkQUq/ebc6tfV
	JwUfH628/rXviZp2UFgLBPqE7x3OYjI83qNnc9BOl8V4uz8oSXqAKVGpqRArlClt
	S4GOI8rZz9P4ARI1ATSRITW+xEBeBEQJaV6ltzQezW2FEBNLCasTTT9fGI3h2fN9
	7nvTUnmrSBEFdopX2BwKAOd+/SNtbQBhPuuiyOLEicaUXR19kIeIlw6qDQ/dsuE4
	m9224UbZ0hHWJ8559/bp5PE3yB0qRFKt4+zFGd7sniAG2mITo5rUt7IsYIP8swNK
	ng67ccIUJ2vqEJ9PMUBkQtvNppZoIfmtvo3xwHF5YbfTlQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id cP0nCDE7TSY0; Mon,  4 May 2026 08:17:19 +0000 (UTC)
Received: from [10.211.8.56] (unknown [213.147.98.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4g8Dyh3yWxzlfvq4;
	Mon,  4 May 2026 08:17:15 +0000 (UTC)
Message-ID: <dbc57009-f563-4858-91f1-a63efe786d01@acm.org>
Date: Mon, 4 May 2026 10:17:13 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/srpt: fix integer overflow in immediate data length
 check
To: Sara Venkatesh <sarajvenkatesh@gmail.com>, jgg@ziepe.ca
Cc: leon@kernel.org, dledford@redhat.com, linux-rdma@vger.kernel.org,
 target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
 carlos.bilbao@kernel.org
References: <20260504080036.3482415-1-sarajvenkatesh@gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260504080036.3482415-1-sarajvenkatesh@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 61BAB4BA191
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19905-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,ziepe.ca];
	DKIM_TRACE(0.00)[acm.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 5/4/26 10:00 AM, Sara Venkatesh wrote:
> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
> index 9aec5d80117f..f66cfd70c263 100644
> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> @@ -1129,9 +1129,10 @@ static int srpt_get_desc_tbl(struct srpt_recv_ioctx *recv_ioctx,
>   		struct srp_imm_buf *imm_buf = srpt_get_desc_buf(srp_cmd);
>   		void *data = (void *)srp_cmd + imm_data_offset;
>   		uint32_t len = be32_to_cpu(imm_buf->len);
> -		uint32_t req_size = imm_data_offset + len;
> +		uint32_t req_size;
>   
> -		if (req_size > srp_max_req_size) {
> +		if (check_add_overflow((uint32_t)imm_data_offset, len, &req_size) ||
> +		    req_size > srp_max_req_size) {
>   			pr_err("Immediate data (length %d + %d) exceeds request size %d\n",
>   			       imm_data_offset, len, srp_max_req_size);
>   			return -EINVAL;

Do the srp tests from https://github.com/linux-blktests/blktests/ still
pass with this patch applied?

Thanks,

Bart.

