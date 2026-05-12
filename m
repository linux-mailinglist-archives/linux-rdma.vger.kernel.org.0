Return-Path: <linux-rdma+bounces-20499-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +J1+DstOA2r63gEAu9opvQ
	(envelope-from <linux-rdma+bounces-20499-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 18:01:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB3C524429
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 18:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FDFC3208FE3
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 15:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA7037F013;
	Tue, 12 May 2026 15:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgEkxsfF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFFD28B4FD;
	Tue, 12 May 2026 15:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778599433; cv=none; b=vB7sZ8uNq/o8naGKZtqm6GNYNQEPeOMWI2tAawuLZMJ3LxWfv4r7Xdfj2B/8nEggD1NzXi3Ho6R5tCY3HLybD4NKbjiTaaC9CllJkk2Hc0SSfAQaSeYPi5cwaufvj2eDgKicZomuqlLEslqyh9IVlJZyo9Q/4CJ87t5tRY3M/xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778599433; c=relaxed/simple;
	bh=Yakw83TzgA48i1OAMvYgx0XSE6u/jLchM1KKSHRUmy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=brD+4k0SNtv+e+mNj71kDmdKvUqQPNpYdJAj38uG2kR3VRNjnFM84X7kk9YFac6YFYd+HwO8XcQR88XtJLq3MbPUiTNV5JLVD8viZM8glpzxP4gKawsDdCxqMfnYmLMKcMXKrRdWbCt2KItSBrPdbiyhE4zGUkd+qEDvQwrT8vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgEkxsfF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B30C2BCB0;
	Tue, 12 May 2026 15:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778599433;
	bh=Yakw83TzgA48i1OAMvYgx0XSE6u/jLchM1KKSHRUmy4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VgEkxsfFWir3Zxs/yowj/L3bsqTRtyRZ1oLmTzQ58/fuCebZXs+NJcJauYl+bZcUT
	 dJY25lurrwls+W5vlbS4Ew4YtQaExy/plovO2eIUDZabDaLmo2XbYdtVGfP0P9wVr1
	 dQlKM7plC6/yItGITlrX4xusb9kG0qdpYJpeHZxVcJtVPCGeIEJ9/AHBMeQ7SDTk6T
	 WUvp3rYVIGxM9bhpswqInNIGi5mjsA8xIGlwgvB3O9XaJe63/oswdq7PPEInPCQOKO
	 7CqYKCKg5Ttx3FMpgJPwm4njLqyROYOfMiLkjjixPdkFlXlB+n4+LWO+fGrtIKflwr
	 QRzIH5+BQVc4g==
Message-ID: <14574ff8-128b-485e-af7e-34ebf00d2c8b@kernel.org>
Date: Tue, 12 May 2026 09:23:52 -0600
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next 2/4] iplink: Update iplink_parse to use
 netns_get_fd_pid
Content-Language: en-US
To: Leon Romanovsky <leonro@nvidia.com>
Cc: stephen@networkplumber.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, David Ahern <dahern@nvidia.com>
References: <20260507150836.28105-1-dsahern@kernel.org>
 <20260507150836.28105-3-dsahern@kernel.org> <20260510100148.GC15586@unreal>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260510100148.GC15586@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8DB3C524429
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20499-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/10/26 4:01 AM, Leon Romanovsky wrote:
>> diff --git a/ip/iplink.c b/ip/iplink.c
>> index eae51438..6c4586ee 100644
>> --- a/ip/iplink.c
>> +++ b/ip/iplink.c
>> @@ -650,19 +650,13 @@ int iplink_parse(int argc, char **argv, struct iplink_req *req, char **type)
>>  			if (offload && name == dev)
>>  				dev = NULL;
>>  		} else if (strcmp(*argv, "netns") == 0) {
>> -			int pid;
>> -
>>  			NEXT_ARG();
>>  			if (netns != -1)
>>  				duparg("netns", *argv);
>> +			/* try by name then by pid */
>>  			netns = netns_get_fd(*argv);
>> -			if (netns < 0 && get_integer(&pid, *argv, 0) == 0) {
>> -				char path[PATH_MAX];
>> -
>> -				snprintf(path, sizeof(path), "/proc/%d/ns/net",
>> -					 pid);
>> -				netns = open(path, O_RDONLY);
>> -			}
>> +			if (netns < 0)
>> +				netns = netns_get_fd_pid(*argv);
> 
> It would be good to have a single function that handles the entire
> netns_get_fd() → netns < 0 → netns_get_fd_pid() sequence internally. This
> logic is used by at least iplink and rdmatool.
> 

I considered that. devlink usage of netns_get_fd and its handling of pid
vs name makes it a more complicated change.

