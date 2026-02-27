Return-Path: <linux-rdma+bounces-17283-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHhfOZA5oWlrrQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17283-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 07:28:32 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D64E1B33D0
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 07:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02E3D3037478
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 06:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D67361DDD;
	Fri, 27 Feb 2026 06:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZfeXs0w0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038B82FFDDE
	for <linux-rdma@vger.kernel.org>; Fri, 27 Feb 2026 06:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772173693; cv=none; b=ZINSWC/r0ZiIjeaYszLHyLwMcs5+YqACF1IOmeEPTIb7UVUC2aN3h81M11qGMVHztkh13ftGcsiO6D0dBW0QqOZ5kaelcoismgTT0QJO+rTRyffgmNXQTxqLEtEUWpczpbdyEl2r1abzPhRW8nMc0OIhFWetyobUs9y0oUBGOfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772173693; c=relaxed/simple;
	bh=JTZYr1uPWbNWeBD0GmnHfMUUlrtJyqU12HInMm0lKrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IHkylnbGj4wYM1DYOcyTKdqQoPNAchHyGczA0nkZRvFR9N+VXaM2IHBg47vL8+y2eS3wSo0bVEKb7noB/TtVD1xdbpPpc8rEhqOqdaMX1NrmMKFMNN975CAdiX3GBXKJ6hpfAlKKUjdPerRalt4bHvBwxUG5N1Qm/fgAXajxFms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZfeXs0w0; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <13d804be-0bef-41bb-b252-c31f62a0b4a0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772173689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eai6pgEn3MYtM0l+Ra/+NvcBqJj0hb6ZXfnitJS/Ofo=;
	b=ZfeXs0w02GTTNaeleXMRqdDCVgGfjE41R/6eqYerXtuZ8u7W30IIXaVlOpF5B5CFvAsK0B
	5rFq2/zqtb5GAMl92UnKXgAhhzev9EXIRYII/lqthjZ71ggihXk+g6NWOyn/qTyDHPP4e8
	RNENlYvJSv22IBqzyPBQHUBVHhzZxfQ=
Date: Thu, 26 Feb 2026 22:28:03 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: Add network namespace support
To: David Ahern <dsahern@kernel.org>, Leon Romanovsky <leon@kernel.org>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
References: <20260225172622.7589-1-dsahern@kernel.org>
 <e87e7871-d35e-4b91-a00f-1491ac5b6dab@linux.dev>
 <18ecbd06-baac-43ee-a455-6b34c716fdfe@kernel.org>
 <88b82e8b-40da-46cf-bb41-2c346bd28c70@linux.dev>
 <20260226064755.GA12611@unreal>
 <cfad2c5c-23a9-4034-ad71-2c1ea21ff597@linux.dev>
 <8ed32ed9-3931-4b2b-8f44-0023aa998b5c@kernel.org>
 <8098445a-c778-4b11-be88-6243aba98268@linux.dev>
 <c0887a43-f5ea-4e7b-8fb5-7322b76396a3@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <c0887a43-f5ea-4e7b-8fb5-7322b76396a3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17283-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 4D64E1B33D0
X-Rspamd-Action: no action


在 2026/2/26 18:05, David Ahern 写道:
> On 2/26/26 5:06 PM, yanjun.zhu wrote:
>> The patch link is: https://github.com/zhuyj/linux/tree/6.19-net-namespace
> please send the patches; I cannot give comments to a github tree.
>
> Scanning the patches, I think you have over complicated what needs to be
> done.
>
> 1. socket lookups are not free. If the rxe module is going to own the
> socket, let it own the socket. See my patch with the net_generic way of
> retrieving the socket per namespace. <several patches later> Oh, you
> also bring in net_generic, so why make this so complicated?

Thanks, I will use net_generic later.

> 2. current code creates the socket for init_net at module load time. My
> patch changes it to first rxe link create and then leaves it enabled
> until the namespace is deleted. Why? Well, any solution trying to track
> how many devices are in the namespace is overly complicated.  If an rxe
> is created once what are the odds it will be created again? This is a
> very specific type of workload. Besides, it makes the code very simple.
> I bet this is why my patch fails any test cases you have.

Yes. I will send out my commit very soon.

Thanks a lot.

Zhu Yanjun

>
-- 
Best Regards,
Yanjun.Zhu


