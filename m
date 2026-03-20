Return-Path: <linux-rdma+bounces-18474-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGNwMe/AvWmEBQMAu9opvQ
	(envelope-from <linux-rdma+bounces-18474-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 22:49:35 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D29D42E17CA
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 22:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73981302BA7C
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 21:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D223F1669;
	Fri, 20 Mar 2026 21:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tGLxuJ9p"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EED136BCE6
	for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2026 21:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774043372; cv=none; b=Ok0tgzKimrpz0ESxJqg4m9xv7DGZ3DFceRjqrxcyM/O4ahghs/1A+JPuNwyX3Jm/GYJirfLu/YNFk5/YHoA/sIzoCQV6QgihU9zzXu2KI4ZOwjb9LOlx0SF8M0Mi4+F7VIH3euxa0QEQnsGaXkcsv64Yr5pv/3fK/N2OztVTgJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774043372; c=relaxed/simple;
	bh=zrNNxZ/8GimuqANCW6vFmCyuozIHSNPlTpHP3NOiURk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qSSg1TY16MXbhOWsWg4JVKKC1LCYCvqsX6Vr0O/ua9VIqcQG8o31EEZUdnUMbHNohmG30Qxr+0doELRoHH4nf7qE2QucRKiX7ynxoY0T3nhRqBS1PjMXK1Rau+niZHeawukp4Z8KwEq2PLmY0+KOrtOPQtbNRaKuOSt9KO2omus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tGLxuJ9p; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bb9c825b-56e8-468b-b1d8-9b4aa1177d10@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774043368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MLeX4Y8SCLTKIb/PvuT5EBGEMn05LREgOszX6Hgg9/c=;
	b=tGLxuJ9pRE25OUEZoCv6QUkYNdLRNnNmt35EyuXFB9ydbkWk75jPZYIDVZfnul6GC7k+JY
	HwMQlneMurmw4u3f46q/TO3F6Q07a51Dz9W7615pgowRRpmHFMD7OzgQUVxcwLTMI9MQ2Z
	LZ8R47s9wn7IzW93RgjYxRdYNo+KrsM=
Date: Fri, 20 Mar 2026 14:49:11 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] [RESEND] RDMA/hfi1: use a struct group to avoid
 warning
To: Arnd Bergmann <arnd@kernel.org>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Arnd Bergmann <arnd@arndb.de>, Kees Cook <kees@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260320151511.3420818-1-arnd@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <20260320151511.3420818-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18474-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: D29D42E17CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/20/26 8:12 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> On gcc-11 and earlier, the driver sometimes produces a warning
> for memset:
> 
> In file included from include/linux/string.h:392,
>                   from drivers/infiniband/hw/hfi1/mad.c:6:
> In function 'fortify_memset_chk',
>      inlined from '__subn_get_opa_hfi1_cong_log' at drivers/infiniband/hw/hfi1/mad.c:3873:2,
>      inlined from 'subn_get_opa_sma' at drivers/infiniband/hw/hfi1/mad.c:4114:9:
> include/linux/fortify-string.h:480:4: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror]
>      __write_overflow_field(p_size_field, size);
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> This seems to be a false positive, and I found no nice way to rewrite
> the code to avoid the warning, but adding a a struct group works.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> resending as the patch did not get picked up last year
> https://lore.kernel.org/all/20250410075928.GN199604@unreal/
> ---
>   drivers/infiniband/hw/hfi1/hfi.h | 6 ++++--
>   drivers/infiniband/hw/hfi1/mad.c | 4 ++--
>   2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/hfi.h b/drivers/infiniband/hw/hfi1/hfi.h
> index 5a0310f758dc..ae17cea4e8c9 100644
> --- a/drivers/infiniband/hw/hfi1/hfi.h
> +++ b/drivers/infiniband/hw/hfi1/hfi.h
> @@ -878,8 +878,10 @@ struct hfi1_pportdata {
>   	 * cc_log_lock protects all congestion log related data
>   	 */
>   	spinlock_t cc_log_lock ____cacheline_aligned_in_smp;
> -	u8 threshold_cong_event_map[OPA_MAX_SLS / 8];
> -	u16 threshold_event_counter;
> +	struct_group (zero_event_map,
> +		u8 threshold_cong_event_map[OPA_MAX_SLS / 8];
> +		u16 threshold_event_counter;
> +	);
>   	struct opa_hfi1_cong_log_event_internal cc_events[OPA_CONG_LOG_ELEMS];
>   	int cc_log_idx; /* index for logging events */
>   	int cc_mad_idx; /* index for reporting events */
> diff --git a/drivers/infiniband/hw/hfi1/mad.c b/drivers/infiniband/hw/hfi1/mad.c
> index 585f1d99b91b..9154638e9ce2 100644
> --- a/drivers/infiniband/hw/hfi1/mad.c
> +++ b/drivers/infiniband/hw/hfi1/mad.c
> @@ -3869,8 +3869,8 @@ static int __subn_get_opa_hfi1_cong_log(struct opa_smp *smp, u32 am,
>   	 * Reset threshold_cong_event_map, and threshold_event_counter
>   	 * to 0 when log is read.
>   	 */
> -	memset(ppd->threshold_cong_event_map, 0x0,
> -	       sizeof(ppd->threshold_cong_event_map));
> +	memset(&ppd->zero_event_map, 0x0,
> +	       sizeof(ppd->zero_event_map));
>   	ppd->threshold_event_counter = 0;

Not sure if ppd->threshold_event_counter is also set to 0 in memset or 
not. If yes, this line "ppd->threshold_event_counter = 0;" can be removed?

Zhu Yanjun

>   
>   	spin_unlock_irq(&ppd->cc_log_lock);


