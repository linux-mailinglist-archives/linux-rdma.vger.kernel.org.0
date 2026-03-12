Return-Path: <linux-rdma+bounces-18070-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEqjOqZKsml7LQAAu9opvQ
	(envelope-from <linux-rdma+bounces-18070-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 06:09:58 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DA326D4CF
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 06:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A374309CC9F
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 05:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C333A169F;
	Thu, 12 Mar 2026 05:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OzxwKAzK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE1636D4FD;
	Thu, 12 Mar 2026 05:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773292160; cv=none; b=pBoVGY+9UK5YFeO+aT7zj3HWvIXx/wtWkByRN5JcxbpLZfw5DjwFXEbT2kSik9ZBGqiQIyQG/31BRLL8vUZ+rMDfaxkQv8YGoSZNbYPygGUmfuRLTkqX/fl8Z5XxbMbqDwaO6ZkZak/pJtLfTENe0A9otcGNtKrrQqHxc/H+5jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773292160; c=relaxed/simple;
	bh=61bM1dGRtflgjhd7CA1L36YvIDrvruy/oC2IgohJNm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=anDAP+Cqhkc0MmcoCcaQlv3pfNR/QDKoFmz7MNmdbj2bXepJ7w/jNBR67MCeUGzcUkVtiWNxFvSkoYj2k6GFCbTjiFNLEi74LTUynL0rWsJne9C4MAvV+KGKSk+5F8MvABRNRi9nukRtxiZInvFeEWX+8CLLDnzolMKjqBOspzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OzxwKAzK; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <434a9a8c-f369-435a-b8bf-d9ae85558c8e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773292155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q+sCxcvOZ4JJqPc6t51Nhtj+5M0ZfUINwSFsj4CHAPM=;
	b=OzxwKAzKeUX5tvzKQ5wWRaUPgV4XD+n9rDUb8MfKoTIi4g1RytJKNM0A/OmmpJPr7mxewq
	kN8T3WqBJlLn8P7YJwAOFkR6hE9GHQK1JmkGo/00RSxBJqiEI4DPSOocwOiAqLKH/tooeQ
	B5lgF6NtFOPUyVLAXE8waK88IRdKzW8=
Date: Wed, 11 Mar 2026 22:09:09 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 1/4] RDMA/nldev: Add dellink function pointer
To: David Ahern <dsahern@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
Cc: jgg@ziepe.ca, zyjzyj2000@gmail.com, shuah@kernel.org,
 linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260310020519.101415-1-yanjun.zhu@linux.dev>
 <20260310020519.101415-2-yanjun.zhu@linux.dev>
 <20260310190140.GL12611@unreal>
 <5700c718-d10e-4b23-adfc-c14ee1930b18@linux.dev>
 <20260311085434.GW12611@unreal>
 <6a8b0983-a198-470a-8125-b0133ccb7032@linux.dev>
 <b5c2053c-f911-4e0d-8589-4d969bd580a4@kernel.org>
 <e8e1fc5b-7772-40c5-8214-b4f9d4a10d98@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <e8e1fc5b-7772-40c5-8214-b4f9d4a10d98@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18070-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[ziepe.ca,gmail.com,kernel.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 99DA326D4CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


在 2026/3/11 20:59, Zhu Yanjun 写道:
>
> 在 2026/3/11 19:04, David Ahern 写道:
>> On 3/11/26 4:01 PM, Yanjun.Zhu wrote:
>>
>>> Got it. The commit log explains how the netdev_notifier mechanism is
>> netdev notifiers are the NETDEV_UNREGISTER and friends. This dellink
>> handler is not related to that; this is an IB stack thing when the rxe
>> link is removed.
>>
>>> used to clean up the related resources.
>>>
>>> In the source code, additional comments have been added to explain how
>>> the dellink operation for rxe is triggered. For iWARP, this change
>>> should not make any difference because iWARP does not implement the
>>> dellink function.
>>>
>>> The commit is shown below. Please take a look and share your comments.
>>> If you agree, I will send out the latest commits out very soon.
>>>
>>>  From c05038dcdf69c5985837736a8926ba76d9f3e8e4 Mon Sep 17 00:00:00 2001
>>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>> Date: Fri, 23 Sep 2022 16:52:45 +0000
>>> Subject: [PATCH 1/1] RDMA/nldev: Add dellink function pointer
>>>
>>> The newlink function pointer was previously added to support
>>> dynamic RDMA link creation. In the RXE driver, this path creates
>>> a transport socket listening on port 4791. Consequently, a dellink
>>> function pointer is required to ensure these sockets are properly
>>> closed when a user administratively removes a link via rdma link
>>> delete <dev>.
>>>
>>> Furthermore, RXE does not rely solely on this nldev path for resource
>>> management. It also monitors the underlying net_device state via a
>>> registered netdev_notifier. The rxe_net_event callback serves as a
>>> fallback mechanism to ensure that transport sockets are forcibly closed
>>> and all resources are released even if dellink is not explicitly called
>>> (e.g., if the parent NIC interface is removed or the driver is 
>>> forcefully
>>> unloaded).
>> IMHO, this explanation belongs in the patch that implements dellink 
>> for rxe.
>>
>> This patch adds the handler to allow link implementations to cleanup any
>> resources created by newklink as needed.
> Thanks for the feedback. I agree that the detailed explanation of 
> RXE's resource management (like sockets and notifiers) is more 
> appropriate for the subsequent patch that implements the RXE dellink 
> handler.
>
> I will update the commit message for this patch to focus solely on the 
> addition of the dellink infrastructure in the RDMA core, and move the 
> RXE-specific details to the next patch in the series.

Hi,

I would like to use the following as the commit log. It seems simple and 
direct.

"

Add a dellink function pointer to rdma_link_ops to allow drivers to 
clean up resources created during newlink.
"

Thanks,

Zhu Yanjun


>
> Zhu Yanjun
>
>>
-- 
Best Regards,
Yanjun.Zhu


