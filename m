Return-Path: <linux-rdma+bounces-22708-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AdzDL2OSRmogYwsAu9opvQ
	(envelope-from <linux-rdma+bounces-22708-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 18:31:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FBB6FA349
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 18:31:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=GRc4kSDX;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22708-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22708-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F9BB31AD63D
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2026 16:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599D1342CB3;
	Thu,  2 Jul 2026 16:22:12 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A53F33A9E1;
	Thu,  2 Jul 2026 16:22:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009332; cv=none; b=thgZTdVY3hEPaWj4Jj+N/b9y7zwQK04CDXvi73qcB5Ulb6i/oHft43wevjO79Fmxfbl3jvxN0G6jxgaq2W0WDQej42uai33TZk3/kcsgzQHcSVDPZWGr7mqOds2nfaKHB0svZ9HygT9rcUrmjbgwCb/I9o16VdduL8hob/ff0aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009332; c=relaxed/simple;
	bh=dedt7S3SqbSEiETQH7cipB4qBY+o8fHl8c2Z5oG/hp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aK4WV5sDCORI/Lg54Ug3c5A9vW98Ifsgaz+0C5y/LJkUBuitsN8rQVJpPVvxsyr+FyrEmv6hB4/u4Az79zxAPfqACmtiOYKSdHdVPG+TWilDb+ZCx9ou5bjsDGLG2FNkK/HuFAeRj1fRN/ojPvXTBkJB5XfHCJ8gjMBjVFXII8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=GRc4kSDX; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6ADAD35B7;
	Thu,  2 Jul 2026 09:22:03 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C8AA83F673;
	Thu,  2 Jul 2026 09:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783009327; bh=dedt7S3SqbSEiETQH7cipB4qBY+o8fHl8c2Z5oG/hp4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GRc4kSDXbaqu6JiOSv76bj27qJ9ortBWlr3ojdBbpBo8FW3vBkrenRjGnRNmfps9v
	 60NpcVTsqQwgLuW4sS338Nd8sYCTILiq1Hy0mRaRAENRywFqF280DM3t40hbd0slvW
	 BRYD1AkbHbD5BWmcaoC7dYxVsER3YutFK/hCdo2U=
Message-ID: <969eda20-bc93-4fc6-83b9-b3c85684aa4c@arm.com>
Date: Thu, 2 Jul 2026 17:21:49 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/11] perf: Use sysfs_emit() for cpumask show
 callbacks
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>,
 MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, Heiko Stuebner <heiko@sntech.de>,
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
 Moritz Fischer <mdf@kernel.org>, Yicong Yang <yangyicong@hisilicon.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
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
 Yury Norov <yury.norov@gmail.com>, Kees Cook <kees@kernel.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>,
 Ilkka Koskinen <ilkka@os.amperecomputing.com>,
 Besar Wicaksono <bwicaksono@nvidia.com>, Ma Ke <make24@iscas.ac.cn>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Ritesh Harjani <ritesh.list@gmail.com>, Yushan Wang
 <wangyushan12@huawei.com>, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
 x86@kernel.org, driver-core@lists.linux.dev, linux-pm@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-fpga@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-cxl@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20260702154725.185376-1-ynorov@nvidia.com>
 <20260702154725.185376-11-ynorov@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260702154725.185376-11-ynorov@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[armlinux.org.uk,nxp.com,pengutronix.de,gmail.com,linux.ibm.com,ellerman.id.au,kernel.org,infradead.org,redhat.com,arm.com,linux.intel.com,google.com,intel.com,linaro.org,alien8.de,zytor.com,linuxfoundation.org,samsung.com,sntech.de,hisilicon.com,cornelisnetworks.com,ziepe.ca,linux.alibaba.com,amlogic.com,baylibre.com,googlemail.com,marvell.com,starfivetech.com,os.amperecomputing.com,linutronix.de,nvidia.com,iscas.ac.cn,huawei.com,lists.infradead.org,lists.linux.dev,vger.kernel.org,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22708-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[robin.murphy@arm.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:ynorov@nvidia.com,m:akpm@linux-foundation.org,m:linux@rasmusvillemoes.dk,m:linux@armlinux.org.uk,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:kernel@pengutronix.de,m:festevam@gmail.com,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:peterz@infradead.org,m:mingo@redhat.com,m:acme@kernel.org,m:namhyung@kernel.org,m:mark.rutland@arm.com,m:alexander.shishkin@linux.intel.com,m:jolsa@kernel.org,m:irogers@google.com,m:adrian.hunter@intel.com,m:james.clark@linaro.org,m:tglx@kernel.org,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:rafael@kernel.org,m:gregkh@linuxfoundation.org,m:dakr@kernel.org,m:cw00.choi@samsung.com,m:myungjoo.ham@samsung.com,m:kyungmin.park@samsung.com,m:heiko@sntech.de,m:yilun.xu@intel.com,m:trix@redhat.com,m:mdf@kernel.org,m:yangyicong@hisilicon.com,m:jic23@kernel.org,m:dennis.dalessandro@cornelisnetworks.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:bhelgaas@google.com,m:xueshuai@linux.alibaba.c
 om,m:will@kernel.org,m:jiucheng.xu@amlogic.com,m:neil.armstrong@linaro.org,m:khilman@baylibre.com,m:jbrunet@baylibre.com,m:martin.blumenstingl@googlemail.com,m:renyu.zj@linux.alibaba.com,m:xu.yang_2@nxp.com,m:lcherian@marvell.com,m:gthiagarajan@marvell.com,m:jisheng.teoh@starfivetech.com,m:khuong@os.amperecomputing.com,m:yury.norov@gmail.com,m:kees@kernel.org,m:thomas.weissschuh@linutronix.de,m:aboorvad@linux.ibm.com,m:ilkka@os.amperecomputing.com,m:bwicaksono@nvidia.com,m:make24@iscas.ac.cn,m:fengchengwen@huawei.com,m:ritesh.list@gmail.com,m:wangyushan12@huawei.com,m:linux-arm-kernel@lists.infradead.org,m:imx@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-perf-users@vger.kernel.org,m:x86@kernel.org,m:driver-core@lists.linux.dev,m:linux-pm@vger.kernel.org,m:linux-rockchip@lists.infradead.org,m:linux-fpga@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-amlogic@lists.infradead.org,m:linux-cxl@vger.kernel.org,m:li
 nux-arm-msm@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[arm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robin.murphy@arm.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_GT_50(0.00)[80];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,arm.com:dkim,arm.com:email,arm.com:mid,arm.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 44FBB6FA349

On 02/07/2026 4:47 pm, Yury Norov wrote:
> These callbacks are sysfs show paths. Use sysfs_emit() and
> cpumask_pr_args() to emit the masks.
> 
> This prepares for removing cpumap_print_to_pagebuf().

FWIW,

Acked-by: Robin Murphy <robin.murphy@arm.com>

I'm now working on a way to remove all of these entirely (other than the 
core one), so I declare myself not particularly fussed any more :D

Cheers,
Robin.

> Link: https://lore.kernel.org/all/akANJ-AT7nHpRMq-@yury/
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>   drivers/perf/alibaba_uncore_drw_pmu.c       | 2 +-
>   drivers/perf/amlogic/meson_ddr_pmu_core.c   | 2 +-
>   drivers/perf/arm-cci.c                      | 2 +-
>   drivers/perf/arm-ccn.c                      | 2 +-
>   drivers/perf/arm-cmn.c                      | 2 +-
>   drivers/perf/arm-ni.c                       | 2 +-
>   drivers/perf/arm_cspmu/arm_cspmu.c          | 2 +-
>   drivers/perf/arm_dmc620_pmu.c               | 4 ++--
>   drivers/perf/arm_dsu_pmu.c                  | 2 +-
>   drivers/perf/arm_pmu.c                      | 2 +-
>   drivers/perf/arm_smmuv3_pmu.c               | 2 +-
>   drivers/perf/arm_spe_pmu.c                  | 2 +-
>   drivers/perf/cxl_pmu.c                      | 2 +-
>   drivers/perf/dwc_pcie_pmu.c                 | 2 +-
>   drivers/perf/fsl_imx8_ddr_perf.c            | 2 +-
>   drivers/perf/fsl_imx9_ddr_perf.c            | 2 +-
>   drivers/perf/fujitsu_uncore_pmu.c           | 2 +-
>   drivers/perf/hisilicon/hisi_pcie_pmu.c      | 2 +-
>   drivers/perf/hisilicon/hisi_uncore_pmu.c    | 2 +-
>   drivers/perf/marvell_cn10k_ddr_pmu.c        | 2 +-
>   drivers/perf/marvell_cn10k_tad_pmu.c        | 2 +-
>   drivers/perf/marvell_pem_pmu.c              | 2 +-
>   drivers/perf/nvidia_t410_c2c_pmu.c          | 2 +-
>   drivers/perf/nvidia_t410_cmem_latency_pmu.c | 2 +-
>   drivers/perf/qcom_l2_pmu.c                  | 2 +-
>   drivers/perf/qcom_l3_pmu.c                  | 2 +-
>   drivers/perf/starfive_starlink_pmu.c        | 2 +-
>   drivers/perf/thunderx2_pmu.c                | 2 +-
>   drivers/perf/xgene_pmu.c                    | 2 +-
>   kernel/events/core.c                        | 2 +-
>   30 files changed, 31 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/perf/alibaba_uncore_drw_pmu.c b/drivers/perf/alibaba_uncore_drw_pmu.c
> index ac49d3b2dad6..74786a5dd6a2 100644
> --- a/drivers/perf/alibaba_uncore_drw_pmu.c
> +++ b/drivers/perf/alibaba_uncore_drw_pmu.c
> @@ -221,7 +221,7 @@ static ssize_t ali_drw_pmu_cpumask_show(struct device *dev,
>   {
>   	struct ali_drw_pmu *drw_pmu = to_ali_drw_pmu(dev_get_drvdata(dev));
>   
> -	return cpumap_print_to_pagebuf(true, buf, cpumask_of(drw_pmu->cpu));
> +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(drw_pmu->cpu)));
>   }
>   
>   static struct device_attribute ali_drw_pmu_cpumask_attr =
> diff --git a/drivers/perf/amlogic/meson_ddr_pmu_core.c b/drivers/perf/amlogic/meson_ddr_pmu_core.c
> index c1e755c356a3..f614aa3434a5 100644
> --- a/drivers/perf/amlogic/meson_ddr_pmu_core.c
> +++ b/drivers/perf/amlogic/meson_ddr_pmu_core.c
> @@ -191,7 +191,7 @@ static ssize_t meson_ddr_perf_cpumask_show(struct device *dev,
>   {
>   	struct ddr_pmu *pmu = dev_get_drvdata(dev);
>   
> -	return cpumap_print_to_pagebuf(true, buf, cpumask_of(pmu->cpu));
> +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(pmu->cpu)));
>   }
>   
>   static struct device_attribute meson_ddr_perf_cpumask_attr =
> diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
> index 1cc3214d6b6d..f0ef0a679e74 100644
> --- a/drivers/perf/arm-cci.c
> +++ b/drivers/perf/arm-cci.c
> @@ -1351,7 +1351,7 @@ static ssize_t pmu_cpumask_attr_show(struct device *dev,
>   	struct pmu *pmu = dev_get_drvdata(dev);
>   	struct cci_pmu *cci_pmu = to_cci_pmu(pmu);
>   
> -	return cpumap_print_to_pagebuf(true, buf, cpumask_of(cci_pmu->cpu));
> +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(cci_pmu->cpu)));
>   }
>   
>   static struct device_attribute pmu_cpumask_attr =
> diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
> index 8af3563fdf60..d5dcb4280434 100644
> --- a/drivers/perf/arm-ccn.c
> +++ b/drivers/perf/arm-ccn.c
> @@ -538,7 +538,7 @@ static ssize_t arm_ccn_pmu_cpumask_show(struct device *dev,
>   {
>   	struct arm_ccn *ccn = pmu_to_arm_ccn(dev_get_drvdata(dev));
>   
> -	return cpumap_print_to_pagebuf(true, buf, cpumask_of(ccn->dt.cpu));
> +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(ccn->dt.cpu)));
>   }
>   
>   static struct device_attribute arm_ccn_pmu_cpumask_attr =
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 6e5cc4086a9e..ff8bbf07c94e 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -1327,7 +1327,7 @@ static ssize_t arm_cmn_cpumask_show(struct device *dev,
>   {
>   	struct arm_cmn *cmn = to_cmn(dev_get_drvdata(dev));
>   
> -	return cpumap_print_to_pagebuf(true, buf, cpumask_of(cmn->cpu));
> +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(cmn->cpu)));
>   }
>   
>   static struct device_attribute arm_cmn_cpumask_attr =
> diff --git a/drivers/perf/arm-ni.c b/drivers/perf/arm-ni.c
> index 66858c65215d..03a1c6bf9223 100644
> --- a/drivers/perf/arm-ni.c
> +++ b/drivers/perf/arm-ni.c
> @@ -239,7 +239,7 @@ static ssize_t arm_ni_cpumask_show(struct device *dev,
>   {
>   	struct arm_ni *ni = cd_to_ni(pmu_to_cd(dev_get_drvdata(dev)));
>   
> -	return cpumap_print_to_pagebuf(true, buf, cpumask_of(ni->cpu));
> +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(ni->cpu)));
>   }
>   
>   static struct device_attribute arm_ni_cpumask_attr =
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> index 80fb314d5135..e6292021f653 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -305,7 +305,7 @@ static ssize_t arm_cspmu_cpumask_show(struct device *dev,
>   	default:
>   		return 0;
>   	}
> -	return cpumap_print_to_pagebuf(true, buf, cpumask);
> +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask));
>   }
>   
>   static struct attribute *arm_cspmu_cpumask_attrs[] = {
> diff --git a/drivers/perf/arm_dmc620_pmu.c b/drivers/perf/arm_dmc620_pmu.c
> index 4f6b196160f8..467147a05eec 100644
> --- a/drivers/perf/arm_dmc620_pmu.c
> +++ b/drivers/perf/arm_dmc620_pmu.c
> @@ -237,8 +237,8 @@ static ssize_t dmc620_pmu_cpumask_show(struct device *dev,
>   {
>   	struct dmc620_pmu *dmc620_pmu = to_dmc620_pmu(dev_get_drvdata(dev));
>   
> -	return cpumap_print_to_pagebuf(true, buf,
> -				       cpumask_of(dmc620_pmu->irq->cpu));
> +	return sysfs_emit(buf, "%*pbl\n",
> +			  cpumask_pr_args(cpumask_of(dmc620_pmu->irq->cpu)));
>   }
>   
>   static struct device_attribute dmc620_pmu_cpumask_attr =
> diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
> index 32b0dd7c693b..bcbd19e075a5 100644
> --- a/drivers/perf/arm_dsu_pmu.c
> +++ b/drivers/perf/arm_dsu_pmu.c
> @@ -157,7 +157,7 @@ static ssize_t dsu_pmu_cpumask_show(struct device *dev,
>   	default:
>   		return 0;
>   	}
> -	return cpumap_print_to_pagebuf(true, buf, cpumask);
> +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask));
>   }
>   
>   static struct attribute *dsu_pmu_format_attrs[] = {
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index 939bcbd433aa..51ab6cc52ca0 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -570,7 +570,7 @@ static ssize_t cpus_show(struct device *dev,
>   			 struct device_attribute *attr, char *buf)
>   {
>   	struct arm_pmu *armpmu = to_arm_pmu(dev_get_drvdata(dev));
> -	return cpumap_print_to_pagebuf(true, buf, &armpmu->supported_cpus);
> +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&armpmu->supported_cpus));
>   }
>   
>   static DEVICE_ATTR_RO(cpus);
> diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
> index 621f02a7f43b..8ce34e6bb82b 100644
> --- a/drivers/perf/arm_smmuv3_pmu.c
> +++ b/drivers/perf/arm_smmuv3_pmu.c
> @@ -537,7 +537,7 @@ static ssize_t smmu_pmu_cpumask_show(struct device *dev,
>   {
>   	struct smmu_pmu *smmu_pmu = to_smmu_pmu(dev_get_drvdata(dev));
>   
> -	return cpumap_print_to_pagebuf(true, buf, cpumask_of(smmu_pmu->on_cpu));
> +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(smmu_pmu->on_cpu)));
>   }
>   
>   static struct device_attribute smmu_pmu_cpumask_attr =
> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index dbd0da111639..9f786fd48cdd 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
> @@ -343,7 +343,7 @@ static ssize_t cpumask_show(struct device *dev,
>   {
>   	struct arm_spe_pmu *spe_pmu = dev_get_drvdata(dev);
>   
> -	return cpumap_print_to_pagebuf(true, buf, &spe_pmu->supported_cpus);
> +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&spe_pmu->supported_cpus));
>   }
>   static DEVICE_ATTR_RO(cpumask);
>   
> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index 68a54d97d2a8..0735eb33f5f3 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -493,7 +493,7 @@ static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr,
>   {
>   	struct cxl_pmu_info *info = dev_get_drvdata(dev);
>   
> -	return cpumap_print_to_pagebuf(true, buf, cpumask_of(info->on_cpu));
> +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(info->on_cpu)));
>   }
>   static DEVICE_ATTR_RO(cpumask);
>   
> diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
> index 5385401fa9cf..291e776d6f6a 100644
> --- a/drivers/perf/dwc_pcie_pmu.c
> +++ b/drivers/perf/dwc_pcie_pmu.c
> @@ -117,7 +117,7 @@ static ssize_t cpumask_show(struct device *dev,
>   {
>   	struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(dev_get_drvdata(dev));
>   
> -	return cpumap_print_to_pagebuf(true, buf, cpumask_of(pcie_pmu->on_cpu));
> +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(pcie_pmu->on_cpu)));
>   }
>   static DEVICE_ATTR_RO(cpumask);
>   
> diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
> index bcdf5575d71c..3760ebe02674 100644
> --- a/drivers/perf/fsl_imx8_ddr_perf.c
> +++ b/drivers/perf/fsl_imx8_ddr_perf.c
> @@ -237,7 +237,7 @@ static ssize_t ddr_perf_cpumask_show(struct device *dev,
>   {
>   	struct ddr_pmu *pmu = dev_get_drvdata(dev);
>   
> -	return cpumap_print_to_pagebuf(true, buf, cpumask_of(pmu->cpu));
> +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(pmu->cpu)));
>   }
>   
>   static struct device_attribute ddr_perf_cpumask_attr =
> diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
> index 7050b48c0467..6fee5eb5087a 100644
> --- a/drivers/perf/fsl_imx9_ddr_perf.c
> +++ b/drivers/perf/fsl_imx9_ddr_perf.c
> @@ -159,7 +159,7 @@ static ssize_t ddr_perf_cpumask_show(struct device *dev,
>   {
>   	struct ddr_pmu *pmu = dev_get_drvdata(dev);
>   
> -	return cpumap_print_to_pagebuf(true, buf, cpumask_of(pmu->cpu));
> +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(pmu->cpu)));
>   }
>   
>   static struct device_attribute ddr_perf_cpumask_attr =
> diff --git a/drivers/perf/fujitsu_uncore_pmu.c b/drivers/perf/fujitsu_uncore_pmu.c
> index c3c6f56474ad..a07877632d53 100644
> --- a/drivers/perf/fujitsu_uncore_pmu.c
> +++ b/drivers/perf/fujitsu_uncore_pmu.c
> @@ -374,7 +374,7 @@ static ssize_t cpumask_show(struct device *dev,
>   {
>   	struct uncore_pmu *uncorepmu = to_uncore_pmu(dev_get_drvdata(dev));
>   
> -	return cpumap_print_to_pagebuf(true, buf, cpumask_of(uncorepmu->cpu));
> +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(uncorepmu->cpu)));
>   }
>   static DEVICE_ATTR_RO(cpumask);
>   
> diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
> index c5394d007b61..0f55d871c67e 100644
> --- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
> @@ -121,7 +121,7 @@ static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr, c
>   {
>   	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(dev_get_drvdata(dev));
>   
> -	return cpumap_print_to_pagebuf(true, buf, cpumask_of(pcie_pmu->on_cpu));
> +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(pcie_pmu->on_cpu)));
>   }
>   static DEVICE_ATTR_RO(cpumask);
>   
> diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
> index de71dcf11653..0ff2fdf4b3e2 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
> @@ -56,7 +56,7 @@ static ssize_t hisi_associated_cpus_sysfs_show(struct device *dev,
>   {
>   	struct hisi_pmu *hisi_pmu = to_hisi_pmu(dev_get_drvdata(dev));
>   
> -	return cpumap_print_to_pagebuf(true, buf, &hisi_pmu->associated_cpus);
> +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&hisi_pmu->associated_cpus));
>   }
>   static DEVICE_ATTR(associated_cpus, 0444, hisi_associated_cpus_sysfs_show, NULL);
>   
> diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c b/drivers/perf/marvell_cn10k_ddr_pmu.c
> index 72ac17efd846..8681e8715cb3 100644
> --- a/drivers/perf/marvell_cn10k_ddr_pmu.c
> +++ b/drivers/perf/marvell_cn10k_ddr_pmu.c
> @@ -364,7 +364,7 @@ static ssize_t cn10k_ddr_perf_cpumask_show(struct device *dev,
>   {
>   	struct cn10k_ddr_pmu *pmu = dev_get_drvdata(dev);
>   
> -	return cpumap_print_to_pagebuf(true, buf, cpumask_of(pmu->cpu));
> +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(pmu->cpu)));
>   }
>   
>   static struct device_attribute cn10k_ddr_perf_cpumask_attr =
> diff --git a/drivers/perf/marvell_cn10k_tad_pmu.c b/drivers/perf/marvell_cn10k_tad_pmu.c
> index 51ccb0befa05..54909d0031b7 100644
> --- a/drivers/perf/marvell_cn10k_tad_pmu.c
> +++ b/drivers/perf/marvell_cn10k_tad_pmu.c
> @@ -258,7 +258,7 @@ static ssize_t tad_pmu_cpumask_show(struct device *dev,
>   {
>   	struct tad_pmu *tad_pmu = to_tad_pmu(dev_get_drvdata(dev));
>   
> -	return cpumap_print_to_pagebuf(true, buf, cpumask_of(tad_pmu->cpu));
> +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(tad_pmu->cpu)));
>   }
>   
>   static DEVICE_ATTR(cpumask, 0444, tad_pmu_cpumask_show, NULL);
> diff --git a/drivers/perf/marvell_pem_pmu.c b/drivers/perf/marvell_pem_pmu.c
> index 29fbcd1848e4..cf1d8cdb1318 100644
> --- a/drivers/perf/marvell_pem_pmu.c
> +++ b/drivers/perf/marvell_pem_pmu.c
> @@ -164,7 +164,7 @@ static ssize_t pem_perf_cpumask_show(struct device *dev,
>   {
>   	struct pem_pmu *pmu = dev_get_drvdata(dev);
>   
> -	return cpumap_print_to_pagebuf(true, buf, cpumask_of(pmu->cpu));
> +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(pmu->cpu)));
>   }
>   
>   static struct device_attribute pem_perf_cpumask_attr =
> diff --git a/drivers/perf/nvidia_t410_c2c_pmu.c b/drivers/perf/nvidia_t410_c2c_pmu.c
> index 411987153ff3..bff875f4f625 100644
> --- a/drivers/perf/nvidia_t410_c2c_pmu.c
> +++ b/drivers/perf/nvidia_t410_c2c_pmu.c
> @@ -658,7 +658,7 @@ static ssize_t nv_c2c_pmu_cpumask_show(struct device *dev,
>   	default:
>   		return 0;
>   	}
> -	return cpumap_print_to_pagebuf(true, buf, cpumask);
> +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask));
>   }
>   
>   #define NV_C2C_PMU_CPUMASK_ATTR(_name, _config)			\
> diff --git a/drivers/perf/nvidia_t410_cmem_latency_pmu.c b/drivers/perf/nvidia_t410_cmem_latency_pmu.c
> index acb8f5571522..6c8e41598ec1 100644
> --- a/drivers/perf/nvidia_t410_cmem_latency_pmu.c
> +++ b/drivers/perf/nvidia_t410_cmem_latency_pmu.c
> @@ -501,7 +501,7 @@ static ssize_t cmem_lat_pmu_cpumask_show(struct device *dev,
>   	default:
>   		return 0;
>   	}
> -	return cpumap_print_to_pagebuf(true, buf, cpumask);
> +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask));
>   }
>   
>   #define NV_PMU_CPUMASK_ATTR(_name, _config)			\
> diff --git a/drivers/perf/qcom_l2_pmu.c b/drivers/perf/qcom_l2_pmu.c
> index ea8c85729937..c0c522b10b72 100644
> --- a/drivers/perf/qcom_l2_pmu.c
> +++ b/drivers/perf/qcom_l2_pmu.c
> @@ -638,7 +638,7 @@ static ssize_t l2_cache_pmu_cpumask_show(struct device *dev,
>   {
>   	struct l2cache_pmu *l2cache_pmu = to_l2cache_pmu(dev_get_drvdata(dev));
>   
> -	return cpumap_print_to_pagebuf(true, buf, &l2cache_pmu->cpumask);
> +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&l2cache_pmu->cpumask));
>   }
>   
>   static struct device_attribute l2_cache_pmu_cpumask_attr =
> diff --git a/drivers/perf/qcom_l3_pmu.c b/drivers/perf/qcom_l3_pmu.c
> index 66e6cabd6fff..c8d259dd1f80 100644
> --- a/drivers/perf/qcom_l3_pmu.c
> +++ b/drivers/perf/qcom_l3_pmu.c
> @@ -663,7 +663,7 @@ static ssize_t cpumask_show(struct device *dev,
>   {
>   	struct l3cache_pmu *l3pmu = to_l3cache_pmu(dev_get_drvdata(dev));
>   
> -	return cpumap_print_to_pagebuf(true, buf, &l3pmu->cpumask);
> +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&l3pmu->cpumask));
>   }
>   
>   static DEVICE_ATTR_RO(cpumask);
> diff --git a/drivers/perf/starfive_starlink_pmu.c b/drivers/perf/starfive_starlink_pmu.c
> index 964897c2baa9..222a0a34e211 100644
> --- a/drivers/perf/starfive_starlink_pmu.c
> +++ b/drivers/perf/starfive_starlink_pmu.c
> @@ -131,7 +131,7 @@ cpumask_show(struct device *dev, struct device_attribute *attr, char *buf)
>   {
>   	struct starlink_pmu *starlink_pmu = to_starlink_pmu(dev_get_drvdata(dev));
>   
> -	return cpumap_print_to_pagebuf(true, buf, &starlink_pmu->cpumask);
> +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&starlink_pmu->cpumask));
>   }
>   
>   static DEVICE_ATTR_RO(cpumask);
> diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
> index 6ed4707bd6bb..a69c02d2d874 100644
> --- a/drivers/perf/thunderx2_pmu.c
> +++ b/drivers/perf/thunderx2_pmu.c
> @@ -254,7 +254,7 @@ static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr,
>   	struct tx2_uncore_pmu *tx2_pmu;
>   
>   	tx2_pmu = pmu_to_tx2_pmu(dev_get_drvdata(dev));
> -	return cpumap_print_to_pagebuf(true, buf, cpumask_of(tx2_pmu->cpu));
> +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(tx2_pmu->cpu)));
>   }
>   static DEVICE_ATTR_RO(cpumask);
>   
> diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
> index 33b5497bdc06..e9e4871db08d 100644
> --- a/drivers/perf/xgene_pmu.c
> +++ b/drivers/perf/xgene_pmu.c
> @@ -595,7 +595,7 @@ static ssize_t cpumask_show(struct device *dev,
>   {
>   	struct xgene_pmu_dev *pmu_dev = to_pmu_dev(dev_get_drvdata(dev));
>   
> -	return cpumap_print_to_pagebuf(true, buf, &pmu_dev->parent->cpu);
> +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&pmu_dev->parent->cpu));
>   }
>   
>   static DEVICE_ATTR_RO(cpumask);
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 954c36e28101..d2539cdb9212 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -12694,7 +12694,7 @@ static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr,
>   	struct cpumask *mask = perf_scope_cpumask(pmu->scope);
>   
>   	if (mask)
> -		return cpumap_print_to_pagebuf(true, buf, mask);
> +		return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(mask));
>   	return 0;
>   }
>   


