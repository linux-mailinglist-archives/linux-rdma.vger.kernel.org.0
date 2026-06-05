Return-Path: <linux-rdma+bounces-21886-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q/JaCOtaI2oPqwEAu9opvQ
	(envelope-from <linux-rdma+bounces-21886-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 06 Jun 2026 01:25:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A96D664BCC8
	for <lists+linux-rdma@lfdr.de>; Sat, 06 Jun 2026 01:25:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=uR6CEqK3;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21886-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21886-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9111A302C147
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 23:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0903C1F3A;
	Fri,  5 Jun 2026 23:23:49 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E3B39098E
	for <linux-rdma@vger.kernel.org>; Fri,  5 Jun 2026 23:23:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780701828; cv=none; b=Ps9A2RDGm86SIMBJK/s/VfQVybNaoLrdkw/aou/KMzKNR60SjyiI+48zCvt279KlQtjQIVrpQM7HSvUdg2XSk92HYuketcexiwGdaLJHC5RByEz8VyzWxnOCs9NenIpqLd6Udls93pKX7znAbWub7EVJIu/9ysg2M+4Nid3kyQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780701828; c=relaxed/simple;
	bh=/Ea/aeIupKCEO4pO2KWHbZEpehfJpTKiLKJOUAan5ok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VrCqugzvFLVzxNLN/VdPqwaLE4PLzrpSO581Nef4v2ZwLYik/weqWCiQg6GXTJg9XPvVpa1wyiVWvSq7721Ex0EnmZ0E2S4+blDnAIryNp3e+qYXGJrZp3irLoL7j5N9aHHQS5vP9kiRBPsxqKTILxrnzcFdGzNwn7+9/Q7yBhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uR6CEqK3; arc=none smtp.client-ip=91.218.175.170
Message-ID: <a5830613-e905-413b-b654-4eebb37f3cf7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780701815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yuCTNxDecdcGFE4asUY4OVSF1SMCCc8v4lfYq3tvFAA=;
	b=uR6CEqK36bo8oqVc9ZIAUKBPhbxIZOihGM1OxC2zahDBiTOxNZbVuTTGu/rpTZit0N3zx3
	D61vU/XyFPWjhSlV3Rrq6T9Yq/k80jWEM0RqTrSfJvfykcv5Pp4xxEUVVp4m7Dv2Jjdk18
	50rFouE1aWvSK7jxSXFsCxklxbQ05kw=
Date: Fri, 5 Jun 2026 16:23:28 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 5.10/5.15 1/2] RDMA/rxe: Fix the error "trying to
 register non-static key in rxe_cleanup_task"
To: Vladislav Nikolaev <vlad102nikolaev@gmail.com>, stable@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Zhu Yanjun <zyjzyj2000@gmail.com>, Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Haggai Eran <haggaie@mellanox.com>,
 Kamal Heib <kamalh@mellanox.com>, Amir Vadai <amirv@mellanox.com>,
 Moni Shoua <monis@mellanox.com>, Yonatan Cohen <yonatanc@mellanox.com>,
 Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zhu Yanjun <yanjunz@nvidia.com>,
 lvc-project@linuxtesting.org,
 syzbot+cfcc1a3c85be15a40cba@syzkaller.appspotmail.com
References: <20260605171449.1760-1-vlad102nikolaev@gmail.com>
 <20260605171449.1760-2-vlad102nikolaev@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <20260605171449.1760-2-vlad102nikolaev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-21886-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,linuxfoundation.org,linux.dev];
	FORGED_SENDER(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:vlad102nikolaev@gmail.com,m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:yanjun.zhu@linux.dev,m:zyjzyj2000@gmail.com,m:dledford@redhat.com,m:jgg@ziepe.ca,m:haggaie@mellanox.com,m:kamalh@mellanox.com,m:amirv@mellanox.com,m:monis@mellanox.com,m:yonatanc@mellanox.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:yanjunz@nvidia.com,m:lvc-project@linuxtesting.org,m:syzbot+cfcc1a3c85be15a40cba@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,ziepe.ca,mellanox.com,kernel.org,vger.kernel.org,nvidia.com,linuxtesting.org,syzkaller.appspotmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,cfcc1a3c85be15a40cba];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,appspotmail.com:email,linux.dev:mid,linux.dev:dkim,linux.dev:from_mime,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A96D664BCC8

On 6/5/26 10:14 AM, Vladislav Nikolaev wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> commit b2b1ddc457458fecd1c6f385baa9fbda5f0c63ad upstream.
> 
> In the function rxe_create_qp(), rxe_qp_from_init() is called to
> initialize qp, internally things like rxe_init_task are not setup until
> rxe_qp_init_req().
> 
> If an error occurred before this point then the unwind will call
> rxe_cleanup() and eventually to rxe_qp_do_cleanup()/rxe_cleanup_task()
> which will oops when trying to access the uninitialized spinlock.
> 
> If rxe_init_task is not executed, rxe_cleanup_task will not be called.
> 
> Reported-by: syzbot+cfcc1a3c85be15a40cba@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?id=fd85757b74b3eb59f904138486f755f71e090df8
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Fixes: 2d4b21e0a291 ("IB/rxe: Prevent from completer to operate on non valid QP")
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> Link: https://lore.kernel.org/r/20230413101115.1366068-1-yanjun.zhu@intel.com
> Signed-off-by: Leon Romanovsky <leon@kernel.org>
> [ Vladislav: add the missing resp.task.func check and keep the cleanup
> order used by upstream after 960ebe97e523 ("RDMA/rxe: Remove
> __rxe_do_task()"). Moving rxe_cleanup_task(&qp->resp.task) after the RC
> timer cleanup is independent from that commit: timer deletion does not
> depend on the responder task cleanup, and placing all task cleanup after
> the timers matches the final upstream ordering while keeping this fix
> minimal for 5.10/5.15. ]
> Signed-off-by: Vladislav Nikolaev <vlad102nikolaev@gmail.com>

Thanks a lot. I am fine with this.

Zhu Yanjun

> ---
>   drivers/infiniband/sw/rxe/rxe_qp.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
> index 4c938d841f76..0532c446760d 100644
> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> @@ -760,15 +760,20 @@ void rxe_qp_destroy(struct rxe_qp *qp)
>   {
>   	qp->valid = 0;
>   	qp->qp_timeout_jiffies = 0;
> -	rxe_cleanup_task(&qp->resp.task);
>   
>   	if (qp_type(qp) == IB_QPT_RC) {
>   		del_timer_sync(&qp->retrans_timer);
>   		del_timer_sync(&qp->rnr_nak_timer);
>   	}
>   
> -	rxe_cleanup_task(&qp->req.task);
> -	rxe_cleanup_task(&qp->comp.task);
> +	if (qp->resp.task.func)
> +		rxe_cleanup_task(&qp->resp.task);
> +
> +	if (qp->req.task.func)
> +		rxe_cleanup_task(&qp->req.task);
> +
> +	if (qp->comp.task.func)
> +		rxe_cleanup_task(&qp->comp.task);
>   
>   	/* flush out any receive wr's or pending requests */
>   	if (qp->req.task.func)


