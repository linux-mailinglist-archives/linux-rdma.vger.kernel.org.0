Return-Path: <linux-rdma+bounces-20908-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKnINdkGC2r4/QQAu9opvQ
	(envelope-from <linux-rdma+bounces-20908-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 14:32:25 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4100F56CB54
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 14:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A86330A7F51
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 12:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB453FDBE1;
	Mon, 18 May 2026 12:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BNuQud3Y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE9C403152
	for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 12:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779106981; cv=none; b=GR6OaeSKBBSNqjVjUG9N2W4+V13ssE3iVFO41cDsPFGz4ZxTvoDpBXIcIc2cSiMoRSEk4Epf6oiF92DF7XXoArUnsq+GaoT9LrTPOXsCH7gzwa5jwa3k25l8qWekSHPa4ThUEB4IbIVzrL4NhNDSTQFEVRcaM8jBfRfBsqu4hbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779106981; c=relaxed/simple;
	bh=ZPpiEoOHi4UR0O4sGVxYsoYWl16jAuULKjGn3X1wZA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Q8lsePx7I5DP/GxKoHJUDEC2PvwXtrZC800Ca3tGlFnBfrfYtvgQQva14DL+OQ4rmd1FI3Q9IpWxQQsdhrH+VxWuJ4JbjVeuN7CzSUDeKDZ3uQqiMP98jAR2JsK5SCjC8wO0/3YllriJAna2uzmdhTotKYiDNgoNmZh0joR+19k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BNuQud3Y; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779106973; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=+mFjTrbvAC3ugZb8Q62bl8pO0TQZImbGWJ4hDZUs2oM=;
	b=BNuQud3YVBhtsdai22pV3sKLdq2V4DsG8mvLXz7RgkLoWw3CrKlJmEVvq+OjmsCAgz2gT4QrY/0IUr9w4oykECI3R0jqW6UfYiHfAw8Hw65yBAsafw9FXWMxEx3u9sZxjrXnjw6xWRDKG0gKOnH0Sp2DWLEdOnfChjkRWtzCfOk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=boshiyu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X390mz9_1779106972;
Received: from 30.221.149.10(mailfrom:boshiyu@linux.alibaba.com fp:SMTPD_---0X390mz9_1779106972 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 18 May 2026 20:22:52 +0800
Message-ID: <a79dc9cb-9fd4-46d9-b6e2-f06d09725669@linux.alibaba.com>
Date: Mon, 18 May 2026 20:22:52 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next 3/3] RDMA/erdma: Implement
 erdma_reg_user_mr_dmabuf
To: Leon Romanovsky <leon@kernel.org>
References: <20260507053437.46211-1-boshiyu@linux.alibaba.com>
 <20260507053437.46211-4-boshiyu@linux.alibaba.com>
 <20260513141221.GF15586@unreal>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, chengyou@linux.alibaba.com,
 kaishen@linux.alibaba.com
From: Boshi Yu <boshiyu@linux.alibaba.com>
In-Reply-To: <20260513141221.GF15586@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4100F56CB54
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20908-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boshiyu@linux.alibaba.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Action: no action


On 2026/5/13 22:12, Leon Romanovsky wrote:
> It appears Sashiko has some feedback:
> https://sashiko.dev/#/patchset/20260507053437.46211-1- 
> boshiyu@linux.alibaba.com
> 
> The comments regarding ib_umem_find_best_pgsz() seem worth addressing.
> 
> Thanks

Hi, Leon,

Thanks for your review. I’ll add validation for the return value of 
ib_umem_find_best_pgsz() in the next version.

Thanks,

Boshi YU

