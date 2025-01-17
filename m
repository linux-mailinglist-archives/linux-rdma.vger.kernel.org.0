Return-Path: <linux-rdma+bounces-7072-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 314ACA15A2C
	for <lists+linux-rdma@lfdr.de>; Sat, 18 Jan 2025 00:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23F3F188B557
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Jan 2025 23:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82091DE3C8;
	Fri, 17 Jan 2025 23:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YRCxG/WM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4AD1B0F2C
	for <linux-rdma@vger.kernel.org>; Fri, 17 Jan 2025 23:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737157879; cv=none; b=kdVYoG4xcR1LCwPlRPdy5UnMDXYuaeXYMMkl6F2S4iOdfVU85h9iqUkrd34OHJ/aJKCEfMLplPjsKyiG417bf55hvzJX9cXZmvmSv/CAN2rDVFKHGEpbIG2ye6zR6SihYdlQt+8ZwMkAMPIRIh8Am+vMLk7MF8kZWgN96cw0ZKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737157879; c=relaxed/simple;
	bh=GS+eplDaO0zzBE8kd3f7WLgIU8qo0/W7A9RLNj9cN2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SbXbC7tzTj9K0+6H1EvRgUDBYX+PMoo5nnpmrqqLByEsj4hDSJAx/wbEiOO7gNHU0XWCMQB1+ShJB0Ols5IJGz+KPAWsmdizcrvOhjjY0ZMzSQxxWVqBYa7UGBwEijms6gKqwq1dXutqGc9U9l1djlKmpjOFRT4ez78FiSSCF4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YRCxG/WM; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <86948347-529b-433a-991d-0b298776db63@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737157864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ON6aq/S2ODX7ZKRZdnbNdkw0Pwc6gEEIJlkq4LjKrL8=;
	b=YRCxG/WM6HJkcW5AyJeqHEJUpJFfw50178ECRPL59g4zob3dT6hB54KooAGzbdCMLTdT3H
	ygQ5+t0eLkJoRFNk3Zp+s5F2mKCChLc8wKOOpQOOQtiYFZSR3ccUtZeeZ46ZRE4ybYTxjX
	EgpcwS3cSQEzqhsukBEUfubKDVmhesk=
Date: Fri, 17 Jan 2025 15:50:48 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 2/5] net/smc: Introduce generic hook smc_ops
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, pabeni@redhat.com,
 song@kernel.org, sdf@google.com, haoluo@google.com, yhs@fb.com,
 edumazet@google.com, john.fastabend@gmail.com, kpsingh@kernel.org,
 jolsa@kernel.org, guwen@linux.alibaba.com, kuba@kernel.org,
 davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org
References: <20250116074442.79304-1-alibuda@linux.alibaba.com>
 <20250116074442.79304-3-alibuda@linux.alibaba.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250116074442.79304-3-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/15/25 11:44 PM, D. Wythe wrote:
> diff --git a/net/smc/smc_sysctl.c b/net/smc/smc_sysctl.c
> index 2fab6456f765..2004241c3045 100644
> --- a/net/smc/smc_sysctl.c
> +++ b/net/smc/smc_sysctl.c
> @@ -18,6 +18,7 @@
>   #include "smc_core.h"
>   #include "smc_llc.h"
>   #include "smc_sysctl.h"
> +#include "smc_ops.h"
>   
>   static int min_sndbuf = SMC_BUF_MIN_SIZE;
>   static int min_rcvbuf = SMC_BUF_MIN_SIZE;
> @@ -30,6 +31,69 @@ static int links_per_lgr_max = SMC_LINKS_ADD_LNK_MAX;
>   static int conns_per_lgr_min = SMC_CONN_PER_LGR_MIN;
>   static int conns_per_lgr_max = SMC_CONN_PER_LGR_MAX;
>   
> +#if IS_ENABLED(CONFIG_SMC_OPS)
> +static int smc_net_replace_smc_ops(struct net *net, const char *name)
> +{
> +	struct smc_ops *ops = NULL;
> +
> +	rcu_read_lock();
> +	/* null or empty name ask to clear current ops */
> +	if (name && name[0]) {
> +		ops = smc_ops_find_by_name(name);
> +		if (!ops) {
> +			rcu_read_unlock();
> +			return -EINVAL;
> +		}
> +		/* no change, just return */
> +		if (ops == rcu_dereference(net->smc.ops)) {
> +			rcu_read_unlock();
> +			return 0;
> +		}
> +	}
> +	if (!ops || bpf_try_module_get(ops, ops->owner)) {
> +		/* xhcg */

typo. I noticed it only because...

> +		ops = rcu_replace_pointer(net->smc.ops, ops, true);

... rcu_replace_pointer() does not align with the above xchg comment. From 
looking into rcu_replace_pointer, it is not a xchg. It is also not obvious to me 
why it is safe to assume "true" here...

> +		/* release old ops */
> +		if (ops)
> +			bpf_module_put(ops, ops->owner);

... together with a put here on the return value of the rcu_replace_pointer.

> +	} else if (ops) {

nit. This looks redundant when looking at the "if (!ops || ..." test above

Also a nit, I would move the bpf_try_module_get() immediately after the above 
"if (ops == rcu_dereference(net->smc.ops))" test. This should simplify the later 
cases.

> +		rcu_read_unlock();
> +		return -EBUSY;
> +	}
> +	rcu_read_unlock();
> +	return 0;
> +}
> +
> +static int proc_smc_ops(const struct ctl_table *ctl, int write,
> +			void *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	struct net *net = container_of(ctl->data, struct net, smc.ops);
> +	char val[SMC_OPS_NAME_MAX];
> +	const struct ctl_table tbl = {
> +		.data = val,
> +		.maxlen = SMC_OPS_NAME_MAX,
> +	};
> +	struct smc_ops *ops;
> +	int ret;
> +
> +	rcu_read_lock();
> +	ops = rcu_dereference(net->smc.ops);
> +	if (ops)
> +		memcpy(val, ops->name, sizeof(ops->name));
> +	else
> +		val[0] = '\0';
> +	rcu_read_unlock();
> +
> +	ret = proc_dostring(&tbl, write, buffer, lenp, ppos);
> +	if (ret)
> +		return ret;
> +
> +	if (write)
> +		ret = smc_net_replace_smc_ops(net, val);
> +	return ret;
> +}
> +#endif /* CONFIG_SMC_OPS */
> +
>   static struct ctl_table smc_table[] = {
>   	{
>   		.procname       = "autocorking_size",
> @@ -99,6 +163,15 @@ static struct ctl_table smc_table[] = {
>   		.extra1		= SYSCTL_ZERO,
>   		.extra2		= SYSCTL_ONE,
>   	},
> +#if IS_ENABLED(CONFIG_SMC_OPS)
> +	{
> +		.procname	= "ops",
> +		.data		= &init_net.smc.ops,
> +		.mode		= 0644,
> +		.maxlen		= SMC_OPS_NAME_MAX,
> +		.proc_handler	= proc_smc_ops,
> +	},
> +#endif /* CONFIG_SMC_OPS */
>   };
>   
>   int __net_init smc_sysctl_net_init(struct net *net)
> @@ -109,6 +182,20 @@ int __net_init smc_sysctl_net_init(struct net *net)
>   	table = smc_table;
>   	if (!net_eq(net, &init_net)) {
>   		int i;
> +#if IS_ENABLED(CONFIG_SMC_OPS)
> +		struct smc_ops *ops;
> +
> +		rcu_read_lock();
> +		ops = rcu_dereference(init_net.smc.ops);
> +		if (ops && ops->flags & SMC_OPS_FLAG_INHERITABLE) {
> +			if (!bpf_try_module_get(ops, ops->owner)) {
> +				rcu_read_unlock();
> +				return -EBUSY;

Not sure if it should count as error when the ops is in the process of 
un-register-ing. The next smc_sysctl_net_init will have NULL ops and succeed. 
Something for you to consider.


Also, it needs an ack from the SMC maintainer for the SMC specific parts like 
the sysctl here.

