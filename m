Return-Path: <linux-rdma+bounces-21494-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YyH4BHSGGWqdxQgAu9opvQ
	(envelope-from <linux-rdma+bounces-21494-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 14:28:36 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2679D60244C
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 14:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D23EE3031F8B
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 12:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A713E00BA;
	Fri, 29 May 2026 12:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="aPrsjUKC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A06F3D1718;
	Fri, 29 May 2026 12:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780057468; cv=none; b=qRDTCfSynMZkg4NdHOiqSfG1XEHtDx8GpVwvauPqMnDVHky1gHHEbHzaoEIMaZst3hYBR9xq0RIVt2LVHocWEZWUfy1htgxX3+6/WPRouVH+cr7N08DXtYtzNBZUvvZVUyAHx3Ymxgtgvkyxfp+F76U+F04BrPJ8Bq/Mq8TK0m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780057468; c=relaxed/simple;
	bh=fjbO4t8XdyU8NOb41mG4ChhG+m/bzPP3BywWNtdYqoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=btjAgdJXyV/tFlF5kTRjcBnxVl8x2i0VKcfxQZncA2vlEIfD5E53s4OM9OZNzuATqLSHgY9RahokqelZKunFJL8YabHf+a2gW9dmCvoYttxsJAt4FmZtE1w+LLiy4DrY8OCTn4ghCLSwjB0hnO3fuAvZptwOp+kvWzK18bw3CFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=aPrsjUKC; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45FEC204C;
	Fri, 29 May 2026 05:24:20 -0700 (PDT)
Received: from [10.57.37.50] (unknown [10.57.37.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16BE13F632;
	Fri, 29 May 2026 05:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780057465; bh=fjbO4t8XdyU8NOb41mG4ChhG+m/bzPP3BywWNtdYqoA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aPrsjUKCk50s149VeWZk4F2Llmjdo90qP4DWtdM9ATKguxbUU6gRebVq07f2uJFK0
	 YVnIN2oOqMRDRFm11YWBgDWM/xTptKipB8Q9REDRnovKPHG2ooZaALp7Zti/C2KUQ+
	 b4qPfWs6v4eF/TgyfabaRYMbwAxOu8OUsO69761s=
Message-ID: <3a4e22fe-b8ce-4e62-9139-113e0cd4f16b@arm.com>
Date: Fri, 29 May 2026 13:24:02 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/16] psci: simplify hotplug_tests()
To: Yury Norov <ynorov@nvidia.com>, Andrew Morton
 <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Russell King <linux@armlinux.org.uk>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>,
 Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham
 <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>,
 Heiko Stuebner <heiko@sntech.de>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
 Moritz Fischer <mdf@kernel.org>, Yicong Yang <yangyicong@hisilicon.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Dan Williams <djbw@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Shuai Xue <xueshuai@linux.alibaba.com>,
 Will Deacon <will@kernel.org>, Jiucheng Xu <jiucheng.xu@amlogic.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jing Zhang <renyu.zj@linux.alibaba.com>, Xu Yang <xu.yang_2@nxp.com>,
 Linu Cherian <lcherian@marvell.com>,
 Gowthami Thiagarajan <gthiagarajan@marvell.com>,
 Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
 Khuong Dinh <khuong@os.amperecomputing.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Yury Norov <yury.norov@gmail.com>,
 Kees Cook <kees@kernel.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Ilkka Koskinen <ilkka@os.amperecomputing.com>,
 Besar Wicaksono <bwicaksono@nvidia.com>, Ma Ke <make24@iscas.ac.cn>,
 Chengwen Feng <fengchengwen@huawei.com>,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-perf-users@vger.kernel.org, linux-acpi@vger.kernel.org,
 driver-core@lists.linux.dev, linux-pm@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-fpga@vger.kernel.org,
 linux-rdma@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-cxl@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20260528183625.870813-1-ynorov@nvidia.com>
 <20260528183625.870813-2-ynorov@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260528183625.870813-2-ynorov@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,nxp.com,pengutronix.de,gmail.com,linux.ibm.com,ellerman.id.au,kernel.org,infradead.org,redhat.com,arm.com,linux.intel.com,google.com,intel.com,linaro.org,alien8.de,zytor.com,linuxfoundation.org,samsung.com,sntech.de,hisilicon.com,cornelisnetworks.com,ziepe.ca,linux.alibaba.com,amlogic.com,baylibre.com,googlemail.com,marvell.com,starfivetech.com,os.amperecomputing.com,linutronix.de,nvidia.com,iscas.ac.cn,huawei.com,lists.infradead.org,lists.linux.dev,vger.kernel.org,lists.ozlabs.org];
	DKIM_TRACE(0.00)[arm.com:+];
	TAGGED_FROM(0.00)[bounces-21494-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robin.murphy@arm.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[89];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nvidia.com:email,arm.com:email,arm.com:mid,arm.com:dkim]
X-Rspamd-Queue-Id: 2679D60244C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-05-28 7:36 pm, Yury Norov wrote:
> Switch to pr_info("... %pbl"), and drop the temporary buffer allocation.

I would say this is simply an improvement in its own right, regardless 
of whether cpumap_print_to_pagebuf() deserves to be removed or not. For 
the change itself, FWIW,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> This prepares for removing cpumap_print_to_pagebuf().
> 
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>   drivers/firmware/psci/psci_checker.c | 14 ++------------
>   1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/firmware/psci/psci_checker.c b/drivers/firmware/psci/psci_checker.c
> index e67ba9891082..ecd745bb90bf 100644
> --- a/drivers/firmware/psci/psci_checker.c
> +++ b/drivers/firmware/psci/psci_checker.c
> @@ -186,7 +186,6 @@ static int hotplug_tests(void)
>   {
>   	int i, nb_cpu_group, err = -ENOMEM;
>   	cpumask_var_t offlined_cpus, *cpu_groups;
> -	char *page_buf;
>   
>   	if (!alloc_cpumask_var(&offlined_cpus, GFP_KERNEL))
>   		return err;
> @@ -194,10 +193,6 @@ static int hotplug_tests(void)
>   	nb_cpu_group = alloc_init_cpu_groups(&cpu_groups);
>   	if (nb_cpu_group < 0)
>   		goto out_free_cpus;
> -	page_buf = (char *)__get_free_page(GFP_KERNEL);
> -	if (!page_buf)
> -		goto out_free_cpu_groups;
> -
>   	/*
>   	 * Of course the last CPU cannot be powered down and cpu_down() should
>   	 * refuse doing that.
> @@ -210,16 +205,11 @@ static int hotplug_tests(void)
>   	 * off, the cpu group itself should shut down.
>   	 */
>   	for (i = 0; i < nb_cpu_group; ++i) {
> -		ssize_t len = cpumap_print_to_pagebuf(true, page_buf,
> -						      cpu_groups[i]);
> -		/* Remove trailing newline. */
> -		page_buf[len - 1] = '\0';
> -		pr_info("Trying to turn off and on again group %d (CPUs %s)\n",
> -			i, page_buf);
> +		pr_info("Trying to turn off and on again group %d (CPUs %*pbl)\n",
> +			i, cpumask_pr_args(cpu_groups[i]));
>   		err += down_and_up_cpus(cpu_groups[i], offlined_cpus);
>   	}
>   
> -	free_page((unsigned long)page_buf);
>   out_free_cpu_groups:
>   	free_cpu_groups(nb_cpu_group, &cpu_groups);
>   out_free_cpus:


