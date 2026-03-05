Return-Path: <linux-rdma+bounces-17562-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKksIbkOqmngKQEAu9opvQ
	(envelope-from <linux-rdma+bounces-17562-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 00:16:09 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5899219380
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 00:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 531BD30252A0
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2026 23:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223B336654B;
	Thu,  5 Mar 2026 23:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tAQvxj3e"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EF7366043
	for <linux-rdma@vger.kernel.org>; Thu,  5 Mar 2026 23:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772752566; cv=none; b=rDmq+QhOtZba9FQO18xUev+FPF5ncOOBw0HS5BxiL8WM11H01/931OPWrkaosozG/Af6AHlmGSwFE/S5OLnHLlInnLtmdoK+mmfVKig0vnH5JQ938VU4wGUUjN+Z6i8UPa02PxHy7F6vjHpLJ6GUA4hbjdXKne8eEz/pZCO7tTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772752566; c=relaxed/simple;
	bh=JalO4h6534DvpGJKp1h1y0VcsToDyjxuVIj0qDv3Sgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MiDXNwC1FZo6y2n+uZ5ckQlA0+Gf1IXkCWrw/lKaPVnpna3tsylL9InET/oxiNscwyTbQwx4qn5MAa5uZwmepR9xUYefwPbWLCZGRFKApr7GoQsm00e39rR93G/Xh87cno+qo9Rzm/ecdrsJn38xC7oGPMJhawAJIb1kNgOEBus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tAQvxj3e; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ba7d1501-4038-4542-836f-5eb71b806128@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772752561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/kb+9bihdWRcgwGSKS69WoFzGe88sa5Cx95U06JRxiQ=;
	b=tAQvxj3eEJtpoN0FFQgNBTsF16aZ9xHqnkQkbn21jbnI9mEbO020V/794enXbDWSYNcHET
	63hwHekNp8oPRWRRXGSA2wgYqxRcZekuGC1/BhCLM2RTHUE2RFzMzyi+5NVtmnf+KXM4/I
	Ogi2zkzlirfmOQWNRrAT1G2Ab9zUkx8=
Date: Thu, 5 Mar 2026 15:15:56 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCHv2 1/1] RDMA/rxe: Add the support that rxe can work in net
 namespace
To: David Ahern <dsahern@kernel.org>, jgg@ziepe.ca, leon@kernel.org,
 zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20260304041607.11685-1-yanjun.zhu@linux.dev>
 <28be84a9-ad21-4a29-8199-a155e63e4cd8@linux.dev>
 <c8170bb8-d031-4e43-86dd-633cc1269fcb@kernel.org>
 <f576b139-cf1c-423f-a8cd-f51c23f7e18d@linux.dev>
 <915d650f-ca19-4cd0-8d1a-74fa6a045528@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <915d650f-ca19-4cd0-8d1a-74fa6a045528@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: A5899219380
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[kernel.org,ziepe.ca,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17562-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:mid,socket_with_rxe.sh:url,rxe_ipv6.sh:url]
X-Rspamd-Action: no action


On 3/5/26 10:58 AM, David Ahern wrote:
> On 3/4/26 8:29 PM, Zhu Yanjun wrote:
>> The script has been added to tools/testing/selftests/rdma. The commit is
>>
>> https://github.com/zhuyj/linux/commit/0fa99629c1a656592b7b2011dc5cad16de2320fd
>>
>> It can be tested by running:
>>
>> make -C tools/testing/selftests TARGETS=rdma run_tests
>>
>> Please let me know if there are any additional concerns or suggestions.
>>
>
> Thanks for the enhancements to the testing.

“

# make -C tools/testing/selftests TARGETS=rdma run_tests

make: Entering directory '/root/Development/linux/tools/testing/selftests'
make[1]: Nothing to be done for 'all'.
TAP version 13
1..3
# timeout set to 45
# selftests: rdma: rping_between_netns.sh
# server DISCONNECT EVENT...
# wait for RDMA_READ_ADV state 10
ok 1 selftests: rdma: rping_between_netns.sh
# timeout set to 45
# selftests: rdma: rxe_ipv6.sh
ok 2 selftests: rdma: rxe_ipv6.sh
# timeout set to 45
# selftests: rdma: socket_with_rxe.sh
ok 3 selftests: rdma: socket_with_rxe.sh

make: Leaving directory '/root/Development/linux/tools/testing/selftests'

”

I ran the three test cases, and the output is shown above. I would like 
to confirm whether this output format looks appropriate for the RDMA 
selftests.

If the format is acceptable, I plan to keep it as is and continue 
expanding the RDMA selftests based on this structure.

Please let me know if there are any suggestions or preferred conventions 
for the output format.

Zhu Yanjun

>
> Progress and success / fail on what has been tested at each step would
> improve the user experience. See any number of test scripts under
> tools/testing/selftests/net/ from me - e.g.,
> tools/testing/selftests/net/fib_nexthops.sh walks through permutations
> of an API, tools/testing/selftests/net/icmp_redirect.sh is a much
> simpler example.
>

