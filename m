Return-Path: <linux-rdma+bounces-16463-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HjbNrQTgmkgPAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16463-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 16:26:44 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C32DB454
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 16:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B224303C63C
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 15:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DC93B8BCB;
	Tue,  3 Feb 2026 15:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="zuU8wOxT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E70342CA2;
	Tue,  3 Feb 2026 15:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770132340; cv=none; b=QH2NKRaTXjKTlq+l0iCqTyArlc/pOZsRHeKkFf8Urn9ig71UQjy5TByu9mLdP9y29mzeo3KV5L/3eNajpKgblgGq7in/jf0OVo3pr+ge4P1s4aPleEB1wSDQJhSQDWoYhhxNxURPU1H+Rumqnz2vj9b9UTdabdF9FMgMJ47oPgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770132340; c=relaxed/simple;
	bh=KpGFY1EFgTT3YdURkqZOy0mTfB/EVBem959UAQ9tkt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gmWfMykkniD+FrwYTOBgFFddTbi0jSlLxFurX3pHj6pP2XdwWxLgs3ED8MIoff0LqZ1qTW5+Gg9h9x6K1SF+nanGXAg35t7mYvayH5stt2wkMCFljqL8+yRbT85baqVxcwsKvCw4WUTWtEAwEEL2XcUVpFArXuKo5C1nFXWkmgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=zuU8wOxT; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=07aq2coEtVTvd2jUGzI08ZhoY3HMK59angzAN6vqB8k=; b=zuU8wOxT5mrtBVCwJZq2dcoCeR
	pOnKC1haIrejgsE4oOG2easo7df2AUzoATjjsF1tBDd62+zcaTyLqm6BxnRIRke1i9+BMxu23AR5r
	Fz4XycDldouWTJ+SNKfbulFLGwn2Zc9jYICKO6APBh7cA/N0psjzlxOSUtSACEtfKbjm5fb5YZk5j
	wUg2gSN1VV2UBaIeqOQdgG8ytD9vMQORZTqWe2Fn7XCGYz6bot19hMVGOPmVkGXT5nzqmL1/msHfn
	L8udJZZg8KQ7Aif57rfeMO7VGlh3jhdbHKxFOqfuYH0UfKZVYcRSw1//fTiOAC+6XTzAyUtfzh1u1
	jT3kzlk5X6Wv/0PcwCS1oulmuw4WRRe41R+QSYliKW+rvE+JhGD2bR0MzJL6rOH/dwVcrlvoAgZb9
	oZYpIwPqyXxvZMtqD+0dZvgfHQVniasQCMWutq42i49q+0sTkFsSemy6pntuWVAjdsdxEARxoT6WD
	/G37smQxvfrxpXGfFiBKU74M;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1vnIHX-00000003y9q-47yu;
	Tue, 03 Feb 2026 15:25:36 +0000
Message-ID: <1f77a9a6-9020-4d65-a6b9-fe68d4f6e46f@samba.org>
Date: Tue, 3 Feb 2026 16:25:35 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] RDMA/smbdirect: introduce and use
 rdma_restrict_node_type()
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, Jason Gunthorpe <jgg@ziepe.ca>,
 Steve French <smfrench@gmail.com>, Tom Talpey <tom@talpey.com>,
 Long Li <longli@microsoft.com>, Namjae Jeon <linkinjeon@kernel.org>
References: <cover.1769025321.git.metze@samba.org>
 <20260128141123.GG40916@unreal>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <20260128141123.GG40916@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samba.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[samba.org:s=42];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.samba.org,ziepe.ca,gmail.com,talpey.com,microsoft.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16463-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[samba.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[metze@samba.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samba.org:mid,samba.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 47C32DB454
X-Rspamd-Action: no action

Am 28.01.26 um 15:11 schrieb Leon Romanovsky:
> On Wed, Jan 21, 2026 at 09:07:10PM +0100, Stefan Metzmacher wrote:
>> Hi,
>>
>> for smbdirect it required to use different ports depending
>> on the RDMA protocol. E.g. for iWarp 5445 is needed
>> (as tcp port 445 already used by the raw tcp transport for SMB),
>> while InfiniBand, RoCEv1 and RoCEv2 use port 445, as they
>> use an independent port range (even for RoCEv2, which uses udp
>> port 4791 itself).
>>
>> Currently ksmbd is not able to function correctly at
>> all if the system has iWarp (RDMA_NODE_RNIC) interface(s)
>> and any InfiniBand, RoCEv1 and/or RoCEv2 interface(s)
>> at the same time.
>>
>> And cifs.ko uses 5445 with a fallback to 445, which
>> means depending on the available interfaces, it tries
>> 5445 in the RoCE range or may tries iWarp with 445
>> as a fallback. This leads to strange error messages
>> and strange network captures.
>>
>> To avoid these problems they will be able to
>> use rdma_restrict_node_type(RDMA_NODE_RNIC) before
>> trying port 5445 and rdma_restrict_node_type(RDMA_NODE_IB_CA)
>> before trying port 445. It means we'll get early
>> -ENODEV early from rdma_resolve_addr() without any
>> network traffic and timeouts.
>>
>> This is marked as RFC as I want to get feedback
>> if the rdma_restrict_node_type() function is acceptable
>> for the RDMA layer. And because the current form of
>> the smb patches are not tested, I only tested the
>> rdma part with my branch the prepares IPPROTO_SMBDIRECT
>> sockets.
>>
>> I'm not sure if this would be acceptable for 6.19
>> in order to avoid the smb layer problems, if the
>> RDMA layer change is only acceptable for 7.0 that's
>> also fine.
>>
>> This is based on the following fix applied:
>> smb: server: reset smb_direct_port = SMB_DIRECT_PORT_INFINIBAND on init
>> https://lore.kernel.org/linux-cifs/20251208154919.934760-1-metze@samba.org/
>> It's not yet in Linus' tree, so if this gets ready
>> before it's merged we can squash it.
>>
>> Stefan Metzmacher (3):
>>    RDMA/core: introduce rdma_restrict_node_type()
>>    smb: client: make use of rdma_restrict_node_type()
>>    smb: server: make use of rdma_restrict_node_type()
>
> The approach looks reasonable.

Thanks!

> Do you want me to take it through RDMA
> tree?

As I also have other smb patches on top changing/using
it I guess it would be easier if Steve would take them.

Steve, Leon what do you think?

Thanks!
metze

