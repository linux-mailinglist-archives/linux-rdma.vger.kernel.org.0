Return-Path: <linux-rdma+bounces-18032-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LxDFiHysWlVHQAAu9opvQ
	(envelope-from <linux-rdma+bounces-18032-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 23:52:17 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CB11F26AFE2
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 23:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F37130300F7
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 22:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE82A395DB7;
	Wed, 11 Mar 2026 22:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PRTaHnKE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5D62C21D8
	for <linux-rdma@vger.kernel.org>; Wed, 11 Mar 2026 22:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773269533; cv=none; b=o5HMcrJbWvFwcvbpN1FLA0YPmXWpOBr1M0SIXJsYcDrIjlCrk4/s3Sj5/PEP96WQTBYvP5gekMSStNtMtfGWBCt14KalhSGBJ+AcvT27Ch59eE1nNmsrGI1puuoQFBXh55KCjs3BHDQtAZMHaFFQ9g0oK2WM7DprwfD43boSdUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773269533; c=relaxed/simple;
	bh=BNgPwPNdRfG7AAZSM7vrwFEPrTaHE8eG6nOZX8dy+pI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FCYuZJqQAbQ89jCuTFMzWpRygGIihCs6oXWcZF+efpUB5kKwtla9fybwN8Vb1GVBZfvfaLwm8xknGyYh9v6KSUTFAZPcvsJ9Qmm3vcYkhNcv8377hFm7HsQPqQ/eJmiM+fsvpluM+ocfxgr8nsKl5gvqs6Oy7GM3aM4xkNeN1/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PRTaHnKE; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fd4b639f-be69-4b5a-bb05-e8302da8c87a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773269520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XF0zY5nxeMwHSaorzU3I/GigfgLaCZBP1WnpmhBNilM=;
	b=PRTaHnKEGQ4RBcMFvHgeZj58EHaduYeuRL5Fjg5HRt+vWS5lmJ/QifLrCOF/z0c4Pe6PPT
	Rl4C1rYUwvd1WXAQ6bUltQS/A7hyGLtHnRN7qIoVKWSKRwv40rRQHUTaogMhcSOgZ0XFu6
	h13Hmg1KqdESUZ6y/jdbR7RM5Gi4pv4=
Date: Wed, 11 Mar 2026 15:51:52 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 4/4] RDMA/rxe: Add testcase for net namespace rxe
To: Leon Romanovsky <leon@kernel.org>, Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: jgg@ziepe.ca, zyjzyj2000@gmail.com, shuah@kernel.org,
 linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org,
 dsahern@kernel.org
References: <20260310020519.101415-1-yanjun.zhu@linux.dev>
 <20260310020519.101415-5-yanjun.zhu@linux.dev>
 <20260310185308.GJ12611@unreal>
 <93c8c159-90f0-41f7-81d7-0f10fa7cf373@linux.dev>
 <20260311085108.GV12611@unreal>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <20260311085108.GV12611@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[ziepe.ca,gmail.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-18032-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid,bluecherrydvr.com:email]
X-Rspamd-Queue-Id: CB11F26AFE2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/11/26 1:51 AM, Leon Romanovsky wrote:
> On Tue, Mar 10, 2026 at 02:01:03PM -0700, Yanjun.Zhu wrote:
>> On 3/10/26 11:53 AM, Leon Romanovsky wrote:
>>> On Tue, Mar 10, 2026 at 03:05:18AM +0100, Zhu Yanjun wrote:
>>>> Add 4 testcases for rxe with net namespace.
>>>>
>>>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>>>> ---
>>>>    MAINTAINERS                                   |  1 +
>>>>    tools/testing/selftests/Makefile              |  1 +
>>>>    tools/testing/selftests/rdma/Makefile         |  7 ++
>>>>    tools/testing/selftests/rdma/config           |  3 +
>>>>    tools/testing/selftests/rdma/rxe_ipv6.sh      | 63 ++++++++++++++
>>>>    .../selftests/rdma/rxe_rping_between_netns.sh | 85 +++++++++++++++++++
>>>>    .../selftests/rdma/rxe_socket_with_netns.sh   | 76 +++++++++++++++++
>>>>    .../rdma/rxe_test_NETDEV_UNREGISTER.sh        | 63 ++++++++++++++
>>>>    8 files changed, 299 insertions(+)
>>>>    create mode 100644 tools/testing/selftests/rdma/Makefile
>>>>    create mode 100644 tools/testing/selftests/rdma/config
>>>>    create mode 100755 tools/testing/selftests/rdma/rxe_ipv6.sh
>>>>    create mode 100755 tools/testing/selftests/rdma/rxe_rping_between_netns.sh
>>>>    create mode 100755 tools/testing/selftests/rdma/rxe_socket_with_netns.sh
>>>>    create mode 100755 tools/testing/selftests/rdma/rxe_test_NETDEV_UNREGISTER.sh
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 77fdfcb55f06..bd33edf79150 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -24492,6 +24492,7 @@ L:	linux-rdma@vger.kernel.org
>>>>    S:	Supported
>>>>    F:	drivers/infiniband/sw/rxe/
>>>>    F:	include/uapi/rdma/rdma_user_rxe.h
>>>> +F:	tools/testing/selftests/rdma/
>>> This is wrong place in MAINTAINERS file.
>>> You need to add that line to "INFINIBAND SUBSYSTEM" and under RXE to add
>>> tools/testing/selftests/rdma/rxe* entry.
>> Hi, Leon
>>
>> "
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>>
>> index 77fdfcb55f06..3c6bc0e05fc0 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -24492,6 +24492,7 @@ L:      linux-rdma@vger.kernel.org
>>   S:     Supported
>>   F:     drivers/infiniband/sw/rxe/
>>   F:     include/uapi/rdma/rdma_user_rxe.h
>> +F:     tools/testing/selftests/rdma/rxe*
>>
>> "
>>
>> Is it OK?
> It is not sufficient. We also need to be CCed on changes to
> tools/testing/selftests/rdma/Makefile. For that reason, you should place
> tools/testing/selftests/rdma/ under the "INFINIBAND SUBSYSTEM" as well.

Got it. If I get you correctly, the final diff should be as below. If 
you agree, I will send out the latest commits out very soon.


"

diff --git a/MAINTAINERS b/MAINTAINERS
index 77fdfcb55f06..2aba0bf49053 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12551,6 +12551,7 @@ F:      include/uapi/linux/if_infiniband.h
  F:     include/uapi/rdma/
  F:     samples/bpf/ibumad_kern.c
  F:     samples/bpf/ibumad_user.c
+F:     tools/testing/selftests/rdma/

  INGENIC JZ4780 NAND DRIVER
  M:     Harvey Hunt <harveyhuntnexus@gmail.com>
@@ -24492,6 +24493,7 @@ L:      linux-rdma@vger.kernel.org
  S:     Supported
  F:     drivers/infiniband/sw/rxe/
  F:     include/uapi/rdma/rdma_user_rxe.h
+F:     tools/testing/selftests/rdma/rxe*

  SOFTLOGIC 6x10 MPEG CODEC
  M:     Bluecherry Maintainers <maintainers@bluecherrydvr.com>

"

Zhu Yanjun

>
> Thanks
>
>> Zhu Yanjun
>>
>>> Thanks

