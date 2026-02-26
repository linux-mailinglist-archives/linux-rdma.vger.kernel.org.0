Return-Path: <linux-rdma+bounces-17211-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KsQJ7MWoGlifgQAu9opvQ
	(envelope-from <linux-rdma+bounces-17211-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 10:47:31 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 163971A3B56
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 10:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B235C30BC5A6
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 09:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C35313E0A;
	Thu, 26 Feb 2026 09:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="PTuZuxEO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B96262FC0;
	Thu, 26 Feb 2026 09:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772098358; cv=none; b=ZlAB7cf6lbQpY/13L4s4WpxGq8rfBdaf2P6yHyVxIoRSzJ3IlqEpidhOsJCh3lCa403dpm2jHkXmWk5jnI7BYSkdBxMG5xMFtJmcL04ec4qwOMer5mGGRb3R3E6x6y7X5/f2/zvrKX5rj139zMTa746h2DwUpxQD3tn9fzRBkRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772098358; c=relaxed/simple;
	bh=tVQ1Tla0WZftYQlJplXdMjAqBqpf8EtLKK3BzXz5Szw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ngOQlRrea2/KWTL/PKYYoyokIrsvoYHvu+Fn523XvYSjFeJdmHLKki4lvzoTkwlcQbxffMpN5mxw6aijONg88eQNDhtKTtCFnWcVIdGpJNsuYK1btiSLPiZHwxT/cTQw0TBBW0R6eJVCVt5olIVYoQmoXWoITZS7xy12eMH48V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=PTuZuxEO; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=bgJobNO/XTwgsytGekJINzhShMgRvCBytOfe1cAppHs=; b=PTuZuxEOdvVMa+r5eevcZnDvx8
	89iGipJiGFZO+ZZKPzabeqGO9hTzTGwVi/EdNWVdssLD1pgtwy4gXMFIlXsyq8IkM4QfAsYxzt5iu
	pQnt8SXXEzCM+0ZrOoMUbIHwLNHCerns9rZLm2z3ggtWoFuI0M/Ih9FmJMcvX2LgUDX/LGy/MsBjY
	MOu3jchTK0BkTkyK9KJ2dEk7Pee90kQYGgB4ZW0A4PLEv24FU8UzcDa2MyalpteazW4x/g7rAtcc4
	MoXy7167REl7oNDJMIvVguLkQoQZn71VLjHCQhjnW5J3QehByQETOt/No677UGcMNlHsH7Jdqwtcw
	7RXNnEJh7yx9UgwHEPHtKRXZikowGZo/Klqy1lPA774sjFXfREKwi2Bj2EZKyHVHsOmlLe2r4JDr8
	Ayq1mncrUvuPjtowXeKiXzjqyyzQueaFwazCCXZxtcMQFtkykiypUrbfoHWC5gyecwoLA2kNKkKg2
	Mr7+0oven5BHA1YUdBQW9JKO;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1vvXjQ-00000008eKL-1e62;
	Thu, 26 Feb 2026 09:32:28 +0000
Message-ID: <a8d20762-e4f7-41fd-b67e-803858655aad@samba.org>
Date: Thu, 26 Feb 2026 10:32:27 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/core: check id_priv->restricted_node_type in
 cma_listen_on_dev()
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 Steve French <smfrench@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>,
 Tom Talpey <tom@talpey.com>, Long Li <longli@microsoft.com>,
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org
References: <20260224165951.3582093-2-metze@samba.org>
 <20260225125211.GE9541@unreal>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <20260225125211.GE9541@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samba.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[samba.org:s=42];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,ziepe.ca,gmail.com,kernel.org,talpey.com,microsoft.com,lists.samba.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17211-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[samba.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[metze@samba.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,samba.org:mid,samba.org:dkim,samba.org:email,ziepe.ca:email,talpey.com:email]
X-Rspamd-Queue-Id: 163971A3B56
X-Rspamd-Action: no action

Am 25.02.26 um 13:52 schrieb Leon Romanovsky:
> On Tue, Feb 24, 2026 at 05:59:52PM +0100, Stefan Metzmacher wrote:
>> When listening on wildcard addresses we have a global list for
>> the application layer rdma_cm_id and for any existing
>> device or any device added in future we try to listen
>> on any wildcard listener.
>>
>> When the listener has a restricted_node_type we
>> should prevent listening on devices with a different
>> node type.
>>
>> While there fix the documentation comment of
>> rdma_restrict_node_type() to include rdma_resolve_addr()
>> instead of having rdma_bind_addr() twice.
>>
>> Fixes: a760e80e90f5 ("RDMA/core: introduce rdma_restrict_node_type()")
>> Cc: Jason Gunthorpe <jgg@ziepe.ca>
>> Cc: Leon Romanovsky <leon@kernel.org>
>> Cc: Steve French <smfrench@gmail.com>
>> Cc: Namjae Jeon <linkinjeon@kernel.org>
>> Cc: Tom Talpey <tom@talpey.com>
>> Cc: Long Li <longli@microsoft.com>
>> Cc: linux-rdma@vger.kernel.org
>> Cc: linux-cifs@vger.kernel.org
>> Cc: samba-technical@lists.samba.org
>> Signed-off-by: Stefan Metzmacher <metze@samba.org>
>> ---
>>   drivers/infiniband/core/cma.c | 6 +++++-
>>   include/rdma/rdma_cm.h        | 2 +-
>>   2 files changed, 6 insertions(+), 2 deletions(-)
> 
> Applied, thanks.

Great!

Will this be scheduled for rc2?
Would be great as it fixes a regression in ksmbd
with iwarp.

Thanks!
metze

