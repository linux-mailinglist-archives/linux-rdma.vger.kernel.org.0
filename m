Return-Path: <linux-rdma+bounces-21330-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WB5xNmH0FWqzfwcAu9opvQ
	(envelope-from <linux-rdma+bounces-21330-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 21:28:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4941C5DBFC2
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 21:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EEF603042005
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 19:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E9E3C0A1B;
	Tue, 26 May 2026 19:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O04Ba32Q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC53813D503
	for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 19:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779823683; cv=none; b=TWGE0O4NcxEKdC07iwcMcwnvOHC6uYQE9g8chMWXagDnDvkY6/HJMBdXAqB9Jo15vV2zy05IOHxfz0OVovhA5Wz1ErtvKsbS1AbyKH3FqSbRQjcukOAMpEuBBbGe22C8vygmyv8c/rxr3AtCWzNA0J6zbeFBOa6xR3txOybeweM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779823683; c=relaxed/simple;
	bh=xUAoWSLbWrASDwg18GZxz7zMNTgn2lDvYuiIa/rNxIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uvQhDQPc1ReVMFJvce931lI3W0xST+pcyPsWMQqixzFWExjfRcl/UE7azIk3qFGU261IeKd+aEh/SuyluiZDD2RRNPiUz1sSzXJihJqcx+tJVIjyPpAzoyg4TGPffVKpwWT44GMHsBbXBFcpFYAssFBOYA+fNbKANm6iJ5RdZJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O04Ba32Q; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a5fc8913-6bbd-4ca6-a2f6-0608763e9956@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779823669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xRLQyvbnY2kn79VwA2enfCGq/cjTieTVnoX7r+6SeCI=;
	b=O04Ba32Q/XeyntRGi19d6r6JEQBIv0QYvO6DICNMtLRvvJes2FasQW9UWDC5r3Mj7HPVDt
	tXn0eiA65rMdsV3xl6vHz8N8J4vfnX7w0iMb+bFpdCXg1hEnHFM6Wj1lagMtL3akFLu9Df
	qnEfv60Z/ur7YaRDAlMd4+ErLlqtxNQ=
Date: Tue, 26 May 2026 21:27:39 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net/mlx5: Reorder completion before putting command entry
 in cmd_work_handler
To: Nikolay Kuratov <kniv@yandex-team.ru>, linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
 Akiva Goldberger <agoldberger@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 stable@vger.kernel.org
References: <20260526162932.501584-1-kniv@yandex-team.ru>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Haris Iqbal <haris.iqbal@linux.dev>
In-Reply-To: <20260526162932.501584-1-kniv@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21330-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haris.iqbal@linux.dev,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[yandex-team.ru:email,linux.dev:email,linux.dev:mid,linux.dev:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4941C5DBFC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/26/26 18:29, Nikolay Kuratov wrote:
> Assuming callback != NULL && !page_queue, cmd_work_handler takes
> command entry with refcnt == 1 from mlx5_cmd_invoke.
> If either semaphore timeout or index allocation error happens,
> it does final cmd_ent_put(ent). To avoid access to freed memory,
> notify slotted completion before cmd_ent_put.
> 
> This is theoretical issue found by Svace static analyser.
> 
> Cc: stable@vger.kernel.org
> Fixes: 485d65e135712 ("net/mlx5: Add a timeout to acquire the command queue semaphore")
> Fixes: 0e2909c6bec90 ("net/mlx5: Fix variable not being completed when function returns")
> Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>

Looks good:

Reviewed-by: Md Haris Iqbal <haris.iqbal@linux.dev>

> ---
>   drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
> index c89417c1a1f9..e2895972cc82 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
> @@ -1002,12 +1002,13 @@ static void cmd_work_handler(struct work_struct *work)
>   				ent->callback(-EBUSY, ent->context);
>   				mlx5_free_cmd_msg(dev, ent->out);
>   				free_msg(dev, ent->in);
> +				complete(&ent->slotted);
>   				cmd_ent_put(ent);
>   			} else {
>   				ent->ret = -EBUSY;
>   				complete(&ent->done);
> +				complete(&ent->slotted);
>   			}
> -			complete(&ent->slotted);
>   			return;
>   		}
>   		alloc_ret = cmd_alloc_index(cmd, ent);
> @@ -1017,13 +1018,14 @@ static void cmd_work_handler(struct work_struct *work)
>   				ent->callback(-EAGAIN, ent->context);
>   				mlx5_free_cmd_msg(dev, ent->out);
>   				free_msg(dev, ent->in);
> +				complete(&ent->slotted);
>   				cmd_ent_put(ent);
>   			} else {
>   				ent->ret = -EAGAIN;
>   				complete(&ent->done);
> +				complete(&ent->slotted);
>   			}
>   			up(&cmd->vars.sem);
> -			complete(&ent->slotted);
>   			return;
>   		}
>   	} else {


