Return-Path: <linux-rdma+bounces-17912-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKaSNM6GsGlbkQIAu9opvQ
	(envelope-from <linux-rdma+bounces-17912-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 22:02:06 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F6F258133
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 22:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B06203080FA8
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 21:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44067192D8A;
	Tue, 10 Mar 2026 21:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LlDSNmWe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5AE15CD7E
	for <linux-rdma@vger.kernel.org>; Tue, 10 Mar 2026 21:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773176523; cv=none; b=ZsH624Ukn6vGErFHbGx3Y3FvwPfJdq3S8toS4484XCkvU135+phqfGIcKUbrmRZC3en2DETjPMMg6/i6GXIDYuCbirFA4THiR6gAZaL9sTISYwHbKguVx39uhXME6YYG5qMzXwlXK8PLW1L3XtGRdNtuELCsvNyL1oVXJIo7/Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773176523; c=relaxed/simple;
	bh=7M6RqCa3r+Fvo1bJI1eG737qtJhnxGLFs/k1/7zJ9bo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LXUNncvs8lugjgJBVBEpK7P6NuiLRqqn3ecvGL4YVgjw9Ix/QHIy7XdCc8lmfEN4JYQbVvciKPv45+zSrt7umWd8C0TjtAdhYy9BLjIqC+xZ+yOqWiVdKMDwh1VLcYRt37tgh2iqJoe5WFNuNZk3KU7/iE4sL5iw9IWwlfyFVsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LlDSNmWe; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <93c8c159-90f0-41f7-81d7-0f10fa7cf373@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773176519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+aIqV5l3xpZUY9twg+Qr5r/jHLWap/WJiFLLxTmnRvQ=;
	b=LlDSNmWeurxYAd7Pp3bl/qtf2xPqaGOTcj6d4gpLkvD85kxFZFc4JRhecqkuphuk8BO8Fg
	YFzoOUVqqHYq3P8QP+ycMtMde937qw0c/L1zQNsAtcZD/5noPWtHFtSA6d8DNCht7kxLVH
	O1eCQhX+Qv/NHwhd63IKS+B57nKAUtw=
Date: Tue, 10 Mar 2026 14:01:03 -0700
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <20260310185308.GJ12611@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 07F6F258133
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[ziepe.ca,gmail.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-17912-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action


On 3/10/26 11:53 AM, Leon Romanovsky wrote:
> On Tue, Mar 10, 2026 at 03:05:18AM +0100, Zhu Yanjun wrote:
>> Add 4 testcases for rxe with net namespace.
>>
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>> ---
>>   MAINTAINERS                                   |  1 +
>>   tools/testing/selftests/Makefile              |  1 +
>>   tools/testing/selftests/rdma/Makefile         |  7 ++
>>   tools/testing/selftests/rdma/config           |  3 +
>>   tools/testing/selftests/rdma/rxe_ipv6.sh      | 63 ++++++++++++++
>>   .../selftests/rdma/rxe_rping_between_netns.sh | 85 +++++++++++++++++++
>>   .../selftests/rdma/rxe_socket_with_netns.sh   | 76 +++++++++++++++++
>>   .../rdma/rxe_test_NETDEV_UNREGISTER.sh        | 63 ++++++++++++++
>>   8 files changed, 299 insertions(+)
>>   create mode 100644 tools/testing/selftests/rdma/Makefile
>>   create mode 100644 tools/testing/selftests/rdma/config
>>   create mode 100755 tools/testing/selftests/rdma/rxe_ipv6.sh
>>   create mode 100755 tools/testing/selftests/rdma/rxe_rping_between_netns.sh
>>   create mode 100755 tools/testing/selftests/rdma/rxe_socket_with_netns.sh
>>   create mode 100755 tools/testing/selftests/rdma/rxe_test_NETDEV_UNREGISTER.sh
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 77fdfcb55f06..bd33edf79150 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -24492,6 +24492,7 @@ L:	linux-rdma@vger.kernel.org
>>   S:	Supported
>>   F:	drivers/infiniband/sw/rxe/
>>   F:	include/uapi/rdma/rdma_user_rxe.h
>> +F:	tools/testing/selftests/rdma/
> This is wrong place in MAINTAINERS file.
> You need to add that line to "INFINIBAND SUBSYSTEM" and under RXE to add
> tools/testing/selftests/rdma/rxe* entry.

Hi, Leon

"

diff --git a/MAINTAINERS b/MAINTAINERS

index 77fdfcb55f06..3c6bc0e05fc0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24492,6 +24492,7 @@ L:      linux-rdma@vger.kernel.org
  S:     Supported
  F:     drivers/infiniband/sw/rxe/
  F:     include/uapi/rdma/rdma_user_rxe.h
+F:     tools/testing/selftests/rdma/rxe*

"

Is it OK?

Zhu Yanjun

>
> Thanks

