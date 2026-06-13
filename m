Return-Path: <linux-rdma+bounces-22188-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S7qFAUboLGq+XQQAu9opvQ
	(envelope-from <linux-rdma+bounces-22188-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Jun 2026 07:19:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C1867DBD6
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Jun 2026 07:19:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=ODtuQhmv;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22188-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22188-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 956043110FC2
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Jun 2026 05:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA8938A700;
	Sat, 13 Jun 2026 05:14:55 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486541096F
	for <linux-rdma@vger.kernel.org>; Sat, 13 Jun 2026 05:14:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781327695; cv=none; b=B7oWNGumsgqcEu25B4JtVTg0LPDKu+GeuxySDdtxI6PhFKZguU1bZN7X+blmsC6jRlj88XlOCBQiWm33Oy9u9dELrXmy+s14mMzPueDqMpkdrM2B7pk1IFS7UbFGtzvUb9b7WH6c3PP+hPZZcJF6h7mS960BbtQOHmeBsnFlbEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781327695; c=relaxed/simple;
	bh=Dor4ljifA4VWZfST8YV7kDXjvoFlA1d+h+W+JrQ9GGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H7dLuRkgVTslB3tooF7pxMMAq7PRfC6wc7963T3CsUitKB8alSIQ8y7LeZn+r+aGtKc7dnoeJF4QCv1w8hPStvGrQoI1ZatH4f1Kn5s9vl+1HtqRJgy8ez5dI6ZnjSGoIBV8hEF9TG+WiamBDKQSi6PsXA2GN6qdVS+3zGZsBw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ODtuQhmv; arc=none smtp.client-ip=91.218.175.180
Message-ID: <6356ebf5-b89e-4769-ad0f-fcf0cf3e9d9f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781327682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=afBBSB2iLFaDldnxblbuC3l87jNvwkwANuq0N0nVW/I=;
	b=ODtuQhmvKO0yjS60gAFlZlCcrYvX+DZQQmoQ/S9B9QD0CUIplUjsRfTMUDO7Q3FN+OcPY6
	aHh+mxVgqTaEZ2kPMhUM+ASVoEml1/i79wu3CZXN0LbgOj8wEaJt52601q9ERuK6gQWIr6
	59ofAAz31qFlBevj1yZkMxxxEZf6ZWM=
Date: Fri, 12 Jun 2026 22:14:37 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mlx5: avoid frame overflow warning
To: Arnd Bergmann <arnd@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260612201611.4127750-1-arnd@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20260612201611.4127750-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22188-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:arnd@kernel.org,m:leon@kernel.org,m:jgg@ziepe.ca,m:yanjun.zhu@linux.dev,m:arnd@arndb.de,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime,arndb.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 52C1867DBD6

在 2026/6/12 13:15, Arnd Bergmann 写道:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Building mlx5 on s390 shows a rather high stack usage that can exceed
> the warning limit when that is set to a lower but still reasonable value:
> 
> drivers/infiniband/hw/mlx5/wr.c:1051:5: error: stack frame size (1328) exceeds limit (1280) in 'mlx5_ib_post_send' [-Werror,-Wframe-larger-than]
> 
> The problem here is 'struct ib_reg_wr' on the stack of
> handle_reg_mr_integrity(), which gets inlined into mlx5_ib_post_send()
> along with a number of smaller functions.
> 
> Keeping the inner function out of line like gcc does avoids the
> warning and reduces the total stack usage in other functions called
> from mlx5_ib_post_send(), though handle_reg_mr_integrity() itself
> still has the same problem as before.

IMO, it is just a workaround to this problem. To fix this problem, the 
function set_reg_wr should be rewritten.

Zhu Yanjun

> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Dynamically allocating ib_reg_wr would be another option, actually
> reducing the stack usage but adding a little bit of complexity
> from error handling.
> ---
>   drivers/infiniband/hw/mlx5/wr.c | 16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/wr.c b/drivers/infiniband/hw/mlx5/wr.c
> index 9947feb7fb8a..fca9e1d9d5e9 100644
> --- a/drivers/infiniband/hw/mlx5/wr.c
> +++ b/drivers/infiniband/hw/mlx5/wr.c
> @@ -840,13 +840,15 @@ static int handle_psv(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
>   	return err;
>   }
>   
> -static int handle_reg_mr_integrity(struct mlx5_ib_dev *dev,
> -				   struct mlx5_ib_qp *qp,
> -				   const struct ib_send_wr *wr,
> -				   struct mlx5_wqe_ctrl_seg **ctrl, void **seg,
> -				   int *size, void **cur_edge,
> -				   unsigned int *idx, int nreq, u8 fence,
> -				   u8 next_fence)
> +static noinline_for_stack int handle_reg_mr_integrity(struct mlx5_ib_dev *dev,
> +						      struct mlx5_ib_qp *qp,
> +						      const struct ib_send_wr *wr,
> +						      struct mlx5_wqe_ctrl_seg **ctrl,
> +						      void **seg,
> +						      int *size, void **cur_edge,
> +						      unsigned int *idx, int nreq,
> +						      u8 fence,
> +						      u8 next_fence)
>   {
>   	struct mlx5_ib_mr *mr;
>   	struct mlx5_ib_mr *pi_mr;


