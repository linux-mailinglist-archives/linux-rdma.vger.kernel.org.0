Return-Path: <linux-rdma+bounces-17625-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHLCMo1Hq2lcbwEAu9opvQ
	(envelope-from <linux-rdma+bounces-17625-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 22:30:53 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 472A3227F2B
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 22:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83445309E2BD
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Mar 2026 21:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470A01C8626;
	Fri,  6 Mar 2026 21:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YJWHRUqT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B825158DA3
	for <linux-rdma@vger.kernel.org>; Fri,  6 Mar 2026 21:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772832611; cv=none; b=Cj92Z6sZoDQRQwxUkYI3XinpII4+3g/rS0xHNqZpCnhqm1F4J51GIohaW4cocty8ngimJFQBHP6EXcKP9n9CqracrKB5O/zv219s5dvqH0Xx9VU9O/wUPQz27fcX0qnYakQEIF0cfdvTyTZKGEFDS6Oi4918lN8F+0cusguFlWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772832611; c=relaxed/simple;
	bh=OJ/COV4QvvRIO5mZmT/uhLn1k1iFO+//DTRoHXXeLrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kj9OjV0ZiwwYeITnQvIhUWil9Yl/t/opph6FK3z6+9YQ8ltWxmieKOf/KlXLTk4POLccfpwqEya5iRXAOOY694Ogh4t9La7E8rKv75k/74SLpTtGK+IGZ/1l+B24/76VAAFlAhiflobMPcaLqOSh/r9AHQCR2sHmbDAtEiUg420=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YJWHRUqT; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <191b1aae-4401-4078-9cb0-fde8940b7bf0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772832607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3pSPGX8PWw7Yg2vD/5DlycvuW23EwRCc/YbyZ1oIoK8=;
	b=YJWHRUqTrALZ44VrHjQ8ekXuT4tiH7mfYwwPsvi/GrJYfMrr01d4VHxqBYfQSjYiCYjlG+
	arTPBOGlpeOog2WMV8zfAu8jxZtrt4Ewh3N2WTQHPJ21xMEafyFwLMDHNtdKHYK6l6CbKc
	ULOrPBZSp/pk4Jbbvd8L7Gj10G3MsUs=
Date: Fri, 6 Mar 2026 13:29:55 -0800
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
 <ba7d1501-4038-4542-836f-5eb71b806128@linux.dev>
 <51db4f77-0835-4087-9ec3-ea851885aef9@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <51db4f77-0835-4087-9ec3-ea851885aef9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 472A3227F2B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[kernel.org,ziepe.ca,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17625-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.941];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Action: no action

On 3/5/26 3:41 PM, David Ahern wrote:
> On 3/5/26 4:15 PM, Yanjun.Zhu wrote:
>> I ran the three test cases, and the output is shown above. I would like
>> to confirm whether this output format looks appropriate for the RDMA
>> selftests.
>>
>> If the format is acceptable, I plan to keep it as is and continue
>> expanding the RDMA selftests based on this structure.
> 
> Having tests is the important piece. I pointed out the existing tests as
> a way of making things more user friendly. Simple output, easy to follow
> what was tested.

Thanks a lot. I will add more tests.

Zhu Yanjun

