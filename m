Return-Path: <linux-rdma+bounces-21697-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mV7UOnJjIGr/2QAAu9opvQ
	(envelope-from <linux-rdma+bounces-21697-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 19:25:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E32AD63A245
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 19:25:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=acm.org header.s=mr01 header.b=Ma1X1GC3;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21697-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21697-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=acm.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 35513307F8EC
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2026 17:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5167A480321;
	Wed,  3 Jun 2026 17:13:46 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4813E51D8;
	Wed,  3 Jun 2026 17:13:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780506825; cv=none; b=ogAoPSVyXeUp8Ma5i58XPvvQjqZmEqTTnzpTlqIGwfMgYXGdBIN2QuR3vK84in4tOBoDJh9kbnJJ6l2v2ldMjkAR6ZUZ42ta1PgGjVmzNNFuNUZNievnSYHHsgkL+aQDt5k54ZRIpNgxwl6uKWony1B2DmOHe1eoHRUrHNxROrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780506825; c=relaxed/simple;
	bh=lozxlN6lkzVbQ8JT57fAyGwm/N4AkLjtyCMvkxJL880=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rpdVvcQ47yMXWe8CapGmLBukos5MqJFMYqZR4kbM9Cspke/HlUN/hnO+d25HApNp20tlELcjR1QLxMtEzZzctCzSR7CRco2bASMsYupeVoOURVZAFeRMTo4jNoHvf7XSkxw3U0EAikhQNyCLdsPCFl3dEn34G0tSfYX2Od6aJfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Ma1X1GC3; arc=none smtp.client-ip=199.89.1.16
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gVvRh2LZRzlfdvh;
	Wed,  3 Jun 2026 17:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1780506814; x=1783098815; bh=wZxkk5KcW6Nx0zG8/zJUN08G
	4adpyE5EGG+qQ7meMc0=; b=Ma1X1GC3oVcZVftTrLM5fcXhqXdBqJuAqRnWsQ9I
	aMLJX5r8fdsuPimCc1UAk22Q8ljWPQCy+UDPodTauzmxzR433L5Ulx54I4sPaXv+
	goCAu5rxzzhQ1CfPAvOme7yHSZ50pPG47vmXvdSzI/jBXmcl9l0ONXv1QpcrVsMP
	mcgkjLNmLXVCelWcOGOC899+IZh6OoPzOQ9jLmbcVjay5EshvbX/PDwG+F5dog2W
	rMRqpp8EYHU32ulqJlcmywwpby+GBLAFxL2CEUKzbdbn/bN5RlQsxSOrsz17A96q
	v6BjKOlsv6Uk6im4699m1dkhIWSZjqjxlRvFv/FE+Dme2A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 68BnNKBYN-Yt; Wed,  3 Jun 2026 17:13:34 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gVvRc5sfczlfpM6;
	Wed,  3 Jun 2026 17:13:32 +0000 (UTC)
Message-ID: <70bff043-26cc-41b3-9d50-48356f85fc29@acm.org>
Date: Wed, 3 Jun 2026 10:13:31 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] RDMA/srp: bound SRP_RSP sense copy by the received
 length
To: Michael Bommarito <michael.bommarito@gmail.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260602220457.2542840-1-michael.bommarito@gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260602220457.2542840-1-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21697-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,ziepe.ca,kernel.org];
	FORGED_SENDER(0.00)[bvanassche@acm.org,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:michael.bommarito@gmail.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[acm.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,acm.org:mid,acm.org:dkim,acm.org:from_mime,acm.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E32AD63A245

On 6/2/26 3:04 PM, Michael Bommarito wrote:
> +			if (sizeof(*rsp) + (u64)resp_len + sense_len <= byte_len)
> +				memcpy(scmnd->sense_buffer, rsp->data + resp_len,
> +				       min_t(u32, sense_len,
> +					     SCSI_SENSE_BUFFERSIZE));
The above min_t() probably can be changed into min(). Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

