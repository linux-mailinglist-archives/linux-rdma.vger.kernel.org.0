Return-Path: <linux-rdma+bounces-19643-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KO8NDT5v8Gn9TQEAu9opvQ
	(envelope-from <linux-rdma+bounces-19643-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 10:26:38 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 813CC48002D
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 10:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 840A7304BCB3
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 08:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6ED3D330A;
	Tue, 28 Apr 2026 08:20:37 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E6C3D1CB1
	for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 08:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777364436; cv=none; b=hlHJQ6Fx4X9WEm4j9acZyt+vCO6RT7MI8difGyHeRHeWuay4JK5VGd1dbKrxX2N42jZz1/1mD3EGLcHPCPV9U4V4g6X1JbsRP6oxw1uMGbY1tPPO+atlCp8z+DEpGVfjTdKmUztJzURXS3as5eLYwvrN6uuQxuIud+HpIAmieZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777364436; c=relaxed/simple;
	bh=Bry3OdUIPVJT+mPlGje/2I3PrEFztMu929+G773ylFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bvPGsuO+X50eahlDAKwdEO048ipmog+54cqRJXvYej8EYLBQqdStrq5lHE0hsRdR7K3JSmnd6x3FjdQq5XIbyR9eKzqJhYgLspRwmIVBS9q35Aks4JJdjDU5new/4ICCLNgPaRkvEMeSBBvpMWTvR2125jJfrywO9vfvTjZ40jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1d36b34242db11f1aa26b74ffac11d73-20260428
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:0cc552a9-f77f-4bc1-ba2f-438f18c3f889,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:15
X-CID-INFO: VERSION:1.3.12,REQID:0cc552a9-f77f-4bc1-ba2f-438f18c3f889,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:15
X-CID-META: VersionHash:e7bac3a,CLOUDID:3d0938ebe441c15fd8327da365924021,BulkI
	D:260426204238VAH4KHHD,BulkQuantity:2,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|127|841|898,TC:nil,Content:0|15|52,EDM:-3,IP:-2,URL:0,File:nil,RT:
	nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0
	,BRR:1,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1d36b34242db11f1aa26b74ffac11d73-20260428
X-User: cuitao@kylinos.cn
Received: from [192.168.108.130] [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 311302831; Tue, 28 Apr 2026 16:20:28 +0800
Message-ID: <9722fa3e-aee1-4fce-869f-8b2f9591539b@kylinos.cn>
Date: Tue, 28 Apr 2026 16:20:25 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] RDMA/nldev: add resource summary max values for usage
 rate display
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org
References: <20260423061352.359749-1-cuitao@kylinos.cn>
 <20260426124223.GF440345@unreal>
From: Tao Cui <cuitao@kylinos.cn>
In-Reply-To: <20260426124223.GF440345@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 813CC48002D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kylinos.cn:mid,kylinos.cn:email];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-0.986];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cuitao@kylinos.cn,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19643-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3]



在 2026/4/26 20:42, Leon Romanovsky 写道:
> On Thu, Apr 23, 2026 at 02:13:51PM +0800, Tao Cui wrote:
>> Add RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_MAX netlink attribute to expose
>> device resource limits (max_qp, max_cq, max_mr, max_pd, max_srq) in
>> the resource summary alongside the existing current count. This allows
>> userspace tools like iproute2's rdma to display resource usage rates.
> 
> Historically, we try to avoid duplicating functionality, and this already
> exists in ibv_devinfo. What is the reason for adding it to rdmatool as well?
> 
Thanks for your review.

You're right that ibv_devinfo exposes these limits via the verbs API.
The motivation here is not to duplicate ibv_devinfo, but to make the
existing `rdma resource show` output more self-contained.

Currently `rdma resource show` displays current resource counts (curr),
but not the maximum limits. To compute usage rates, a user must
cross-reference two separate tools using different interfaces
(ibv_devinfo via verbs vs. rdma via netlink). This is especially
inconvenient for monitoring and automation use cases that rely on
netlink + JSON output.

By adding max alongside curr in the same resource summary entry, the
rdma tool can present a complete picture in one query, and userspace
can compute usage rates without querying two different interfaces.

That said, if you feel this doesn't justify the addition, I'm happy
to withdraw or adjust the approach. For example, an alternative would
be to not add a new netlink attribute and instead let userspace tools
do the cross-referencing, though I think the single-query approach
provides better usability.

>>
>> The new attribute is optional and backward compatible - old userspace
>> tools will simply ignore it.
>>
>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>


