Return-Path: <linux-rdma+bounces-20748-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGYRO2SGBmockgIAu9opvQ
	(envelope-from <linux-rdma+bounces-20748-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 04:35:16 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 940F0548C28
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 04:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 47D03302DCFE
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 02:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11983C09F6;
	Fri, 15 May 2026 02:35:13 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635E73BFE4C
	for <linux-rdma@vger.kernel.org>; Fri, 15 May 2026 02:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778812513; cv=none; b=n7lqltLZYMUlGU5eKJl6CNQ66cxyuz1J0xtadCXAeoLl5ECdC+WoUq3B98LktuxzISgCilvFjRS2w1hlum9ERp1KsgaGLrn6aipCmccfw1R+LG0c1zGriPsljidVNfl3IyRmcJRvZw/TyDA+wFsJi4hi/PqhSURQTsKTQvkcjSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778812513; c=relaxed/simple;
	bh=Plg4GfY5OEct04iVJf3ujXcV+BPqPQDlgKLByxcfJbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m/82g0+9VxE3egpBO9XPY1M7P4TEnKpwnPLTbYcTf63HkFqj0q4tpvGrXU7Z7D0v5vjvUjLIhDAIWdjtNluo8OQ42cJsy9RtYNBBJbzqGT3knuSSl/FtUxbNk1ma+S/vCNbE/rbL3Xu3ZdeQ8iXEh1KhfJFkumrWreppNj+de8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: af277e0c500611f1aa26b74ffac11d73-20260515
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:13471e05-c8ee-4673-b9b5-401bc50c09c9,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-20
X-CID-INFO: VERSION:1.3.12,REQID:13471e05-c8ee-4673-b9b5-401bc50c09c9,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-20
X-CID-META: VersionHash:e7bac3a,CLOUDID:451121b720c32f14fbe9ff76ad6401a7,BulkI
	D:2605141448004OK151BS,BulkQuantity:1,Recheck:0,SF:10|64|66|78|80|81|82|83
	|102|127|841|898,TC:nil,Content:0|15|52,EDM:-3,IP:-2,URL:0,File:nil,RT:nil
	,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BR
	R:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: af277e0c500611f1aa26b74ffac11d73-20260515
X-User: zhaochenguang@kylinos.cn
Received: from [192.168.111.102] [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhaochenguang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1418570460; Fri, 15 May 2026 10:35:06 +0800
Message-ID: <5108c3fb-5b20-42a6-a904-064786c75e41@kylinos.cn>
Date: Fri, 15 May 2026 10:35:18 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] IB/cm: unregister client groups when port registration
 fails in cm_add_one
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Sean Hefty <shefty@nvidia.com>,
 =?UTF-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>,
 Vlad Dumitrescu <vdumitrescu@nvidia.com>,
 Marco Crivellari <marco.crivellari@suse.com>, linux-rdma@vger.kernel.org
References: <20260511103204.1757106-1-zhaochenguang@kylinos.cn>
 <20260514064746.GL15586@unreal>
Content-Language: en-US
From: Chenguang Zhao <zhaochenguang@kylinos.cn>
In-Reply-To: <20260514064746.GL15586@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 940F0548C28
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	FROM_NEQ_ENVFROM(0.00)[zhaochenguang@kylinos.cn,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-20748-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Action: no action

Sorry, it's my mistake.

Thanks

在 2026/5/14 14:47, Leon Romanovsky 写道:
> On Mon, May 11, 2026 at 06:32:04PM +0800, Chenguang Zhao wrote:
>> If ib_port_register_client_groups() fails, jumping to error1 skips
>> ib_port_unregister_client_groups() for the current port because the
>> cleanup loop only runs for strictly smaller port indices after --i.
>> So jump to error2 to unregister the currently failed port.
> Why? There is no need to call ib_port_unregister_client_groups() for the
> current port. A failure in ib_port_register_client_groups() does not create
> any sysfs groups that would require cleanup.
>
> Thanks

