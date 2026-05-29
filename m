Return-Path: <linux-rdma+bounces-21493-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAHhAH2BGWrVxAgAu9opvQ
	(envelope-from <linux-rdma+bounces-21493-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 14:07:25 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9220A602007
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 14:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0966F3071453
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 12:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1CF3DEAC8;
	Fri, 29 May 2026 12:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z02x2rEg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFEB3BCD19
	for <linux-rdma@vger.kernel.org>; Fri, 29 May 2026 12:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780056391; cv=none; b=aQYqdWg5pLNP83K4g7av603T2oDgYKnWeqYU/ymkbBhVhXD/qhjxg8wL8zo67bBFbPpg+5FTZdfnp2nG8olmcxG8tCSzhmLrqN6lIaixsXcmXKZUxc4b1wXWbCyWh02KVf48vm+oRNOIlZuuBAhGBjbqQUEhzfc290cjSrB5KrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780056391; c=relaxed/simple;
	bh=z5MeuZGbZL70SAzX/1/HK1UFdcBmRR3cc/7Ci8mb7kE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HXwmgg1j7HQxoO+ppgo4hQ9fGBPeN880CskhV9asNN3T1c9RqsCcaqau07pV7HC5HE4uOS0cTGsKpPc13PE0/03I3wkvMs9qKG55lR+FCTjltWUBBMu147+v20BSxp3ASzcPauDVz4VlR0lxox9/sh130dE80nwtzeHp+LGxsuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z02x2rEg; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4909def6a21so2684525e9.3
        for <linux-rdma@vger.kernel.org>; Fri, 29 May 2026 05:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780056386; x=1780661186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72jz4VASspyNfZwaO2ZoEBYiy1qSN0s6Nl9KPx8bbj4=;
        b=Z02x2rEgCDWdatK1QnxMA6qheKknn9AxNvRpHgdoC0x1/TtWm+lCJeO8YKriLuDFnd
         WPIK97JLSFykDVSZ7TmZ5VMXKhMg2+LcLm8QvHOaFHLVVf1TXcu9XJFSMBuDUmCMoZnS
         fGikNY3lXXrTBnAyEeU1p0Dcol+CCflg6OqYEXXccD5CDopnBB49GfMYCiKz4iJx2WWc
         Acn9i5phcYETuia9r+rPL8s1P3mspyFKk4nRiG3cGJ5HB6v8FryyxfBMtWMg3c4LwEIr
         Ic+RiHK7QFLOsONRFQVSKeIEkqbY+u2n7W0+RQ7Flm3GoBjgALHBs6Fv+I0nJXUizFv/
         CO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780056386; x=1780661186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=72jz4VASspyNfZwaO2ZoEBYiy1qSN0s6Nl9KPx8bbj4=;
        b=OHUs/mIaHa1rUWlYuzcU2Z77dKipGr8zWmQUcGqxh7uIufyaYu/xPcxxHQSm8h3cuH
         TiOyYYaTpDVEEPIhdQCi3aSG45uK7GcFhebnmq0MVPQ9paTioM/WtSbHyf+kcb/sd1vZ
         un2clWnxwrWpS6jlH/qOaIMo5mLFuZFaHHgzpj788o3JNbElY5QnnffApT+q3p9jFbpe
         UGxZkoAsV1FGPOvnle5OMZv5K4Wo1iOAL0O1RKDOFO16jD8Q2BDhxb6s323UNjZuSIwu
         P6mLZVMXEnUb/+qsWHaibYg4viqGImd96snPUo+3jS2fpU5ZwkPJSwRQV5qjlQ05Bydp
         s9Ng==
X-Forwarded-Encrypted: i=1; AFNElJ+9JNGSmWiK1chjEwXiZuUN73uI2RQDsGK8z++fqpyvWHUVJLrcXUvSexf9e7D7hGNKL6mA+pWmMnxJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/inxa5VpMWg7iC+IMAeWfGb0XB5mdt68tA6Y5Nyt6T2CZQU7d
	SVUtP6y5+UzU1upLBLj4efCxdY00CT9Z/FjY0bjeEFVWzf3fN4Ifc7H6
X-Gm-Gg: Acq92OGbf+enzVa4k8jFbLk4ICvkpHf6r9grmRgLBJcBWT0vZIhBQiS2YYIxBg8kbCQ
	x9IHcKITDtr1hNAUiMD9pdiJ9jb5mNCFN+bRkcrpXlwi6b2N8yU4aZduUH6LFO2t5nrMVA32oBp
	o0c8bQi/UBSSdFIZcOdwET9j+GP9k1dYD5/yV4NFbG/cQgBqIjvLoNlnO4o4xQF64lLuGiUXF1U
	N5ClXGe/a2QKmgg99EMfHva6oNF+lMqs8qQOHI4ULmg5KdWYHhwa0a3i1xkNA8c7S2tOSmLyfSt
	/9XPYpzNvHJlKDp5g+DYoxVWbUbe6HqD39bWl7zYbLpsJKAxBxhvRodJFkvKKdvEFj41AtySvWw
	pSZnjSnpoC6+ZbvofD8+1tkp5HcMmzs9kd9QRc9IDm/5vUaGMmP7YVk6DFPsjiIodUx9JhOfYw/
	aXJUxPkcHuPUybbTaH7hVa/OZR3NcodmYsO4kCvfrBiCSYuXBa3CnK3mNDVeSt3uG1ivtRJ/I=
X-Received: by 2002:a05:600c:1f93:b0:48f:e230:8cad with SMTP id 5b1f17b1804b1-4909ca8958dmr45994995e9.33.1780056385169;
        Fri, 29 May 2026 05:06:25 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909cab7b00sm40374125e9.14.2026.05.29.05.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 05:06:24 -0700 (PDT)
Date: Fri, 29 May 2026 13:06:19 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Yury Norov <ynorov@nvidia.com>, Andrew Morton
 <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Russell King <linux@armlinux.org.uk>, Frank Li <Frank.Li@nxp.com>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung
 Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, Thomas
 Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich
 <dakr@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham
 <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>,
 Heiko Stuebner <heiko@sntech.de>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Xu Yilun <yilun.xu@intel.com>, Tom Rix
 <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>, Yicong Yang
 <yangyicong@hisilicon.com>, Jonathan Cameron <jic23@kernel.org>, Dennis
 Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe
 <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Dan Williams
 <djbw@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang
 <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Shuai Xue <xueshuai@linux.alibaba.com>, Will Deacon
 <will@kernel.org>, Jiucheng Xu <jiucheng.xu@amlogic.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Jerome
 Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Jing Zhang
 <renyu.zj@linux.alibaba.com>, Xu Yang <xu.yang_2@nxp.com>, Linu Cherian
 <lcherian@marvell.com>, Gowthami Thiagarajan <gthiagarajan@marvell.com>, Ji
 Sheng Teoh <jisheng.teoh@starfivetech.com>, Khuong Dinh
 <khuong@os.amperecomputing.com>, Daniel Lezcano
 <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
 <lukasz.luba@arm.com>, Yury Norov <yury.norov@gmail.com>, Kees Cook
 <kees@kernel.org>, Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?=
 <thomas.weissschuh@linutronix.de>, Aboorva Devarajan
 <aboorvad@linux.ibm.com>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Ilkka Koskinen <ilkka@os.amperecomputing.com>, Besar Wicaksono
 <bwicaksono@nvidia.com>, Ma Ke <make24@iscas.ac.cn>, Chengwen Feng
 <fengchengwen@huawei.com>, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
 linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
 linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-fpga@vger.kernel.org, linux-rdma@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-cxl@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 13/16] perf: Use sysfs_emit() for cpumask show callbacks
Message-ID: <20260529130619.12f24264@pumpkin>
In-Reply-To: <7e980b99-1e4e-408b-8ebd-4d28116e7ad5@arm.com>
References: <20260528183625.870813-1-ynorov@nvidia.com>
	<20260528183625.870813-14-ynorov@nvidia.com>
	<7e980b99-1e4e-408b-8ebd-4d28116e7ad5@arm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,linux-foundation.org,rasmusvillemoes.dk,armlinux.org.uk,nxp.com,pengutronix.de,gmail.com,linux.ibm.com,ellerman.id.au,kernel.org,infradead.org,redhat.com,arm.com,linux.intel.com,google.com,intel.com,linaro.org,alien8.de,zytor.com,linuxfoundation.org,samsung.com,sntech.de,hisilicon.com,cornelisnetworks.com,ziepe.ca,linux.alibaba.com,amlogic.com,baylibre.com,googlemail.com,marvell.com,starfivetech.com,os.amperecomputing.com,linutronix.de,iscas.ac.cn,huawei.com,lists.infradead.org,lists.linux.dev,vger.kernel.org,lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-21493-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_GT_50(0.00)[90];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,arm.com:email,nvidia.com:email]
X-Rspamd-Queue-Id: 9220A602007
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 29 May 2026 12:05:08 +0100
Robin Murphy <robin.murphy@arm.com> wrote:

> On 2026-05-28 7:36 pm, Yury Norov wrote:
> > These callbacks are sysfs show paths.
> > 
> > Use sysfs_emit() and cpumask_pr_args() to emit the masks.
> > 
> > This prepares for removing cpumap_print_to_pagebuf().  
> 
> TBH, looking at this diff I think it only shows the value of having a 
> helper to abstract the boilerplate...
> 
> I'm not sure I agree with the argument of removing something entirely 
> just because it may occasionally be misused, but could we at least have 
> something like:
> 
> #define sysfs_emit_cpumask(buf, mask) \
> 	sysfs_emit((buf), "%*pbl\n", cpumask_pr_args(mask))
> 
> to save the mess in all the many places where the current 
> cpumap_print_to_pagebuf() usage _is_ entirely appropriate?

That has the advantage of letting you change how it is done (again)
without having to find all the callers.

-- David

> 
> Thansk,
> Robin.
> 
> > Signed-off-by: Yury Norov <ynorov@nvidia.com>
> > ---
> >   drivers/perf/alibaba_uncore_drw_pmu.c       | 2 +-
> >   drivers/perf/amlogic/meson_ddr_pmu_core.c   | 2 +-
> >   drivers/perf/arm-cci.c                      | 2 +-
> >   drivers/perf/arm-ccn.c                      | 2 +-
> >   drivers/perf/arm-cmn.c                      | 2 +-
> >   drivers/perf/arm-ni.c                       | 2 +-
> >   drivers/perf/arm_cspmu/arm_cspmu.c          | 2 +-
> >   drivers/perf/arm_dmc620_pmu.c               | 4 ++--
> >   drivers/perf/arm_dsu_pmu.c                  | 2 +-
> >   drivers/perf/arm_pmu.c                      | 2 +-
> >   drivers/perf/arm_smmuv3_pmu.c               | 2 +-
> >   drivers/perf/arm_spe_pmu.c                  | 2 +-
> >   drivers/perf/cxl_pmu.c                      | 2 +-
> >   drivers/perf/dwc_pcie_pmu.c                 | 2 +-
> >   drivers/perf/fsl_imx8_ddr_perf.c            | 2 +-
> >   drivers/perf/fsl_imx9_ddr_perf.c            | 2 +-
> >   drivers/perf/fujitsu_uncore_pmu.c           | 2 +-
> >   drivers/perf/hisilicon/hisi_pcie_pmu.c      | 2 +-
> >   drivers/perf/hisilicon/hisi_uncore_pmu.c    | 2 +-
> >   drivers/perf/marvell_cn10k_ddr_pmu.c        | 2 +-
> >   drivers/perf/marvell_cn10k_tad_pmu.c        | 2 +-
> >   drivers/perf/marvell_pem_pmu.c              | 2 +-
> >   drivers/perf/nvidia_t410_c2c_pmu.c          | 2 +-
> >   drivers/perf/nvidia_t410_cmem_latency_pmu.c | 2 +-
> >   drivers/perf/qcom_l2_pmu.c                  | 2 +-
> >   drivers/perf/qcom_l3_pmu.c                  | 2 +-
> >   drivers/perf/starfive_starlink_pmu.c        | 2 +-
> >   drivers/perf/thunderx2_pmu.c                | 2 +-
> >   drivers/perf/xgene_pmu.c                    | 2 +-
> >   kernel/events/core.c                        | 2 +-
> >   30 files changed, 31 insertions(+), 31 deletions(-)
> > 
> > diff --git a/drivers/perf/alibaba_uncore_drw_pmu.c b/drivers/perf/alibaba_uncore_drw_pmu.c
> > index ac49d3b2dad6..74786a5dd6a2 100644
> > --- a/drivers/perf/alibaba_uncore_drw_pmu.c
> > +++ b/drivers/perf/alibaba_uncore_drw_pmu.c
> > @@ -221,7 +221,7 @@ static ssize_t ali_drw_pmu_cpumask_show(struct device *dev,
> >   {
> >   	struct ali_drw_pmu *drw_pmu = to_ali_drw_pmu(dev_get_drvdata(dev));
> >   
> > -	return cpumap_print_to_pagebuf(true, buf, cpumask_of(drw_pmu->cpu));
> > +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(drw_pmu->cpu)));
> >   }
> >   
> >   static struct device_attribute ali_drw_pmu_cpumask_attr =
> > diff --git a/drivers/perf/amlogic/meson_ddr_pmu_core.c b/drivers/perf/amlogic/meson_ddr_pmu_core.c
> > index c1e755c356a3..f614aa3434a5 100644
> > --- a/drivers/perf/amlogic/meson_ddr_pmu_core.c
> > +++ b/drivers/perf/amlogic/meson_ddr_pmu_core.c
> > @@ -191,7 +191,7 @@ static ssize_t meson_ddr_perf_cpumask_show(struct device *dev,
> >   {
> >   	struct ddr_pmu *pmu = dev_get_drvdata(dev);
> >   
> > -	return cpumap_print_to_pagebuf(true, buf, cpumask_of(pmu->cpu));
> > +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(pmu->cpu)));
> >   }
> >   
> >   static struct device_attribute meson_ddr_perf_cpumask_attr =
> > diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
> > index 1cc3214d6b6d..f0ef0a679e74 100644
> > --- a/drivers/perf/arm-cci.c
> > +++ b/drivers/perf/arm-cci.c
> > @@ -1351,7 +1351,7 @@ static ssize_t pmu_cpumask_attr_show(struct device *dev,
> >   	struct pmu *pmu = dev_get_drvdata(dev);
> >   	struct cci_pmu *cci_pmu = to_cci_pmu(pmu);
> >   
> > -	return cpumap_print_to_pagebuf(true, buf, cpumask_of(cci_pmu->cpu));
> > +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(cci_pmu->cpu)));
> >   }
> >   
> >   static struct device_attribute pmu_cpumask_attr =
> > diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
> > index 8af3563fdf60..d5dcb4280434 100644
> > --- a/drivers/perf/arm-ccn.c
> > +++ b/drivers/perf/arm-ccn.c
> > @@ -538,7 +538,7 @@ static ssize_t arm_ccn_pmu_cpumask_show(struct device *dev,
> >   {
> >   	struct arm_ccn *ccn = pmu_to_arm_ccn(dev_get_drvdata(dev));
> >   
> > -	return cpumap_print_to_pagebuf(true, buf, cpumask_of(ccn->dt.cpu));
> > +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(ccn->dt.cpu)));
> >   }
> >   
> >   static struct device_attribute arm_ccn_pmu_cpumask_attr =
> > diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> > index f5305c8fdca4..2187ba763b72 100644
> > --- a/drivers/perf/arm-cmn.c
> > +++ b/drivers/perf/arm-cmn.c
> > @@ -1326,7 +1326,7 @@ static ssize_t arm_cmn_cpumask_show(struct device *dev,
> >   {
> >   	struct arm_cmn *cmn = to_cmn(dev_get_drvdata(dev));
> >   
> > -	return cpumap_print_to_pagebuf(true, buf, cpumask_of(cmn->cpu));
> > +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(cmn->cpu)));
> >   }
> >   
> >   static struct device_attribute arm_cmn_cpumask_attr =
> > diff --git a/drivers/perf/arm-ni.c b/drivers/perf/arm-ni.c
> > index 66858c65215d..03a1c6bf9223 100644
> > --- a/drivers/perf/arm-ni.c
> > +++ b/drivers/perf/arm-ni.c
> > @@ -239,7 +239,7 @@ static ssize_t arm_ni_cpumask_show(struct device *dev,
> >   {
> >   	struct arm_ni *ni = cd_to_ni(pmu_to_cd(dev_get_drvdata(dev)));
> >   
> > -	return cpumap_print_to_pagebuf(true, buf, cpumask_of(ni->cpu));
> > +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(ni->cpu)));
> >   }
> >   
> >   static struct device_attribute arm_ni_cpumask_attr =
> > diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> > index 80fb314d5135..e6292021f653 100644
> > --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> > +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> > @@ -305,7 +305,7 @@ static ssize_t arm_cspmu_cpumask_show(struct device *dev,
> >   	default:
> >   		return 0;
> >   	}
> > -	return cpumap_print_to_pagebuf(true, buf, cpumask);
> > +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask));
> >   }
> >   
> >   static struct attribute *arm_cspmu_cpumask_attrs[] = {
> > diff --git a/drivers/perf/arm_dmc620_pmu.c b/drivers/perf/arm_dmc620_pmu.c
> > index 4f6b196160f8..467147a05eec 100644
> > --- a/drivers/perf/arm_dmc620_pmu.c
> > +++ b/drivers/perf/arm_dmc620_pmu.c
> > @@ -237,8 +237,8 @@ static ssize_t dmc620_pmu_cpumask_show(struct device *dev,
> >   {
> >   	struct dmc620_pmu *dmc620_pmu = to_dmc620_pmu(dev_get_drvdata(dev));
> >   
> > -	return cpumap_print_to_pagebuf(true, buf,
> > -				       cpumask_of(dmc620_pmu->irq->cpu));
> > +	return sysfs_emit(buf, "%*pbl\n",
> > +			  cpumask_pr_args(cpumask_of(dmc620_pmu->irq->cpu)));
> >   }
> >   
> >   static struct device_attribute dmc620_pmu_cpumask_attr =
> > diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
> > index 32b0dd7c693b..bcbd19e075a5 100644
> > --- a/drivers/perf/arm_dsu_pmu.c
> > +++ b/drivers/perf/arm_dsu_pmu.c
> > @@ -157,7 +157,7 @@ static ssize_t dsu_pmu_cpumask_show(struct device *dev,
> >   	default:
> >   		return 0;
> >   	}
> > -	return cpumap_print_to_pagebuf(true, buf, cpumask);
> > +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask));
> >   }
> >   
> >   static struct attribute *dsu_pmu_format_attrs[] = {
> > diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> > index 939bcbd433aa..51ab6cc52ca0 100644
> > --- a/drivers/perf/arm_pmu.c
> > +++ b/drivers/perf/arm_pmu.c
> > @@ -570,7 +570,7 @@ static ssize_t cpus_show(struct device *dev,
> >   			 struct device_attribute *attr, char *buf)
> >   {
> >   	struct arm_pmu *armpmu = to_arm_pmu(dev_get_drvdata(dev));
> > -	return cpumap_print_to_pagebuf(true, buf, &armpmu->supported_cpus);
> > +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&armpmu->supported_cpus));
> >   }
> >   
> >   static DEVICE_ATTR_RO(cpus);
> > diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
> > index 621f02a7f43b..8ce34e6bb82b 100644
> > --- a/drivers/perf/arm_smmuv3_pmu.c
> > +++ b/drivers/perf/arm_smmuv3_pmu.c
> > @@ -537,7 +537,7 @@ static ssize_t smmu_pmu_cpumask_show(struct device *dev,
> >   {
> >   	struct smmu_pmu *smmu_pmu = to_smmu_pmu(dev_get_drvdata(dev));
> >   
> > -	return cpumap_print_to_pagebuf(true, buf, cpumask_of(smmu_pmu->on_cpu));
> > +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(smmu_pmu->on_cpu)));
> >   }
> >   
> >   static struct device_attribute smmu_pmu_cpumask_attr =
> > diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> > index dbd0da111639..9f786fd48cdd 100644
> > --- a/drivers/perf/arm_spe_pmu.c
> > +++ b/drivers/perf/arm_spe_pmu.c
> > @@ -343,7 +343,7 @@ static ssize_t cpumask_show(struct device *dev,
> >   {
> >   	struct arm_spe_pmu *spe_pmu = dev_get_drvdata(dev);
> >   
> > -	return cpumap_print_to_pagebuf(true, buf, &spe_pmu->supported_cpus);
> > +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&spe_pmu->supported_cpus));
> >   }
> >   static DEVICE_ATTR_RO(cpumask);
> >   
> > diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> > index 68a54d97d2a8..0735eb33f5f3 100644
> > --- a/drivers/perf/cxl_pmu.c
> > +++ b/drivers/perf/cxl_pmu.c
> > @@ -493,7 +493,7 @@ static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr,
> >   {
> >   	struct cxl_pmu_info *info = dev_get_drvdata(dev);
> >   
> > -	return cpumap_print_to_pagebuf(true, buf, cpumask_of(info->on_cpu));
> > +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(info->on_cpu)));
> >   }
> >   static DEVICE_ATTR_RO(cpumask);
> >   
> > diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
> > index 5385401fa9cf..291e776d6f6a 100644
> > --- a/drivers/perf/dwc_pcie_pmu.c
> > +++ b/drivers/perf/dwc_pcie_pmu.c
> > @@ -117,7 +117,7 @@ static ssize_t cpumask_show(struct device *dev,
> >   {
> >   	struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(dev_get_drvdata(dev));
> >   
> > -	return cpumap_print_to_pagebuf(true, buf, cpumask_of(pcie_pmu->on_cpu));
> > +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(pcie_pmu->on_cpu)));
> >   }
> >   static DEVICE_ATTR_RO(cpumask);
> >   
> > diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
> > index bcdf5575d71c..3760ebe02674 100644
> > --- a/drivers/perf/fsl_imx8_ddr_perf.c
> > +++ b/drivers/perf/fsl_imx8_ddr_perf.c
> > @@ -237,7 +237,7 @@ static ssize_t ddr_perf_cpumask_show(struct device *dev,
> >   {
> >   	struct ddr_pmu *pmu = dev_get_drvdata(dev);
> >   
> > -	return cpumap_print_to_pagebuf(true, buf, cpumask_of(pmu->cpu));
> > +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(pmu->cpu)));
> >   }
> >   
> >   static struct device_attribute ddr_perf_cpumask_attr =
> > diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
> > index 7050b48c0467..6fee5eb5087a 100644
> > --- a/drivers/perf/fsl_imx9_ddr_perf.c
> > +++ b/drivers/perf/fsl_imx9_ddr_perf.c
> > @@ -159,7 +159,7 @@ static ssize_t ddr_perf_cpumask_show(struct device *dev,
> >   {
> >   	struct ddr_pmu *pmu = dev_get_drvdata(dev);
> >   
> > -	return cpumap_print_to_pagebuf(true, buf, cpumask_of(pmu->cpu));
> > +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(pmu->cpu)));
> >   }
> >   
> >   static struct device_attribute ddr_perf_cpumask_attr =
> > diff --git a/drivers/perf/fujitsu_uncore_pmu.c b/drivers/perf/fujitsu_uncore_pmu.c
> > index c3c6f56474ad..a07877632d53 100644
> > --- a/drivers/perf/fujitsu_uncore_pmu.c
> > +++ b/drivers/perf/fujitsu_uncore_pmu.c
> > @@ -374,7 +374,7 @@ static ssize_t cpumask_show(struct device *dev,
> >   {
> >   	struct uncore_pmu *uncorepmu = to_uncore_pmu(dev_get_drvdata(dev));
> >   
> > -	return cpumap_print_to_pagebuf(true, buf, cpumask_of(uncorepmu->cpu));
> > +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(uncorepmu->cpu)));
> >   }
> >   static DEVICE_ATTR_RO(cpumask);
> >   
> > diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
> > index c5394d007b61..0f55d871c67e 100644
> > --- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
> > +++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
> > @@ -121,7 +121,7 @@ static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr, c
> >   {
> >   	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(dev_get_drvdata(dev));
> >   
> > -	return cpumap_print_to_pagebuf(true, buf, cpumask_of(pcie_pmu->on_cpu));
> > +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(pcie_pmu->on_cpu)));
> >   }
> >   static DEVICE_ATTR_RO(cpumask);
> >   
> > diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
> > index de71dcf11653..0ff2fdf4b3e2 100644
> > --- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
> > +++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
> > @@ -56,7 +56,7 @@ static ssize_t hisi_associated_cpus_sysfs_show(struct device *dev,
> >   {
> >   	struct hisi_pmu *hisi_pmu = to_hisi_pmu(dev_get_drvdata(dev));
> >   
> > -	return cpumap_print_to_pagebuf(true, buf, &hisi_pmu->associated_cpus);
> > +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&hisi_pmu->associated_cpus));
> >   }
> >   static DEVICE_ATTR(associated_cpus, 0444, hisi_associated_cpus_sysfs_show, NULL);
> >   
> > diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c b/drivers/perf/marvell_cn10k_ddr_pmu.c
> > index 72ac17efd846..8681e8715cb3 100644
> > --- a/drivers/perf/marvell_cn10k_ddr_pmu.c
> > +++ b/drivers/perf/marvell_cn10k_ddr_pmu.c
> > @@ -364,7 +364,7 @@ static ssize_t cn10k_ddr_perf_cpumask_show(struct device *dev,
> >   {
> >   	struct cn10k_ddr_pmu *pmu = dev_get_drvdata(dev);
> >   
> > -	return cpumap_print_to_pagebuf(true, buf, cpumask_of(pmu->cpu));
> > +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(pmu->cpu)));
> >   }
> >   
> >   static struct device_attribute cn10k_ddr_perf_cpumask_attr =
> > diff --git a/drivers/perf/marvell_cn10k_tad_pmu.c b/drivers/perf/marvell_cn10k_tad_pmu.c
> > index 51ccb0befa05..54909d0031b7 100644
> > --- a/drivers/perf/marvell_cn10k_tad_pmu.c
> > +++ b/drivers/perf/marvell_cn10k_tad_pmu.c
> > @@ -258,7 +258,7 @@ static ssize_t tad_pmu_cpumask_show(struct device *dev,
> >   {
> >   	struct tad_pmu *tad_pmu = to_tad_pmu(dev_get_drvdata(dev));
> >   
> > -	return cpumap_print_to_pagebuf(true, buf, cpumask_of(tad_pmu->cpu));
> > +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(tad_pmu->cpu)));
> >   }
> >   
> >   static DEVICE_ATTR(cpumask, 0444, tad_pmu_cpumask_show, NULL);
> > diff --git a/drivers/perf/marvell_pem_pmu.c b/drivers/perf/marvell_pem_pmu.c
> > index 29fbcd1848e4..cf1d8cdb1318 100644
> > --- a/drivers/perf/marvell_pem_pmu.c
> > +++ b/drivers/perf/marvell_pem_pmu.c
> > @@ -164,7 +164,7 @@ static ssize_t pem_perf_cpumask_show(struct device *dev,
> >   {
> >   	struct pem_pmu *pmu = dev_get_drvdata(dev);
> >   
> > -	return cpumap_print_to_pagebuf(true, buf, cpumask_of(pmu->cpu));
> > +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(pmu->cpu)));
> >   }
> >   
> >   static struct device_attribute pem_perf_cpumask_attr =
> > diff --git a/drivers/perf/nvidia_t410_c2c_pmu.c b/drivers/perf/nvidia_t410_c2c_pmu.c
> > index 411987153ff3..bff875f4f625 100644
> > --- a/drivers/perf/nvidia_t410_c2c_pmu.c
> > +++ b/drivers/perf/nvidia_t410_c2c_pmu.c
> > @@ -658,7 +658,7 @@ static ssize_t nv_c2c_pmu_cpumask_show(struct device *dev,
> >   	default:
> >   		return 0;
> >   	}
> > -	return cpumap_print_to_pagebuf(true, buf, cpumask);
> > +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask));
> >   }
> >   
> >   #define NV_C2C_PMU_CPUMASK_ATTR(_name, _config)			\
> > diff --git a/drivers/perf/nvidia_t410_cmem_latency_pmu.c b/drivers/perf/nvidia_t410_cmem_latency_pmu.c
> > index acb8f5571522..6c8e41598ec1 100644
> > --- a/drivers/perf/nvidia_t410_cmem_latency_pmu.c
> > +++ b/drivers/perf/nvidia_t410_cmem_latency_pmu.c
> > @@ -501,7 +501,7 @@ static ssize_t cmem_lat_pmu_cpumask_show(struct device *dev,
> >   	default:
> >   		return 0;
> >   	}
> > -	return cpumap_print_to_pagebuf(true, buf, cpumask);
> > +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask));
> >   }
> >   
> >   #define NV_PMU_CPUMASK_ATTR(_name, _config)			\
> > diff --git a/drivers/perf/qcom_l2_pmu.c b/drivers/perf/qcom_l2_pmu.c
> > index ea8c85729937..c0c522b10b72 100644
> > --- a/drivers/perf/qcom_l2_pmu.c
> > +++ b/drivers/perf/qcom_l2_pmu.c
> > @@ -638,7 +638,7 @@ static ssize_t l2_cache_pmu_cpumask_show(struct device *dev,
> >   {
> >   	struct l2cache_pmu *l2cache_pmu = to_l2cache_pmu(dev_get_drvdata(dev));
> >   
> > -	return cpumap_print_to_pagebuf(true, buf, &l2cache_pmu->cpumask);
> > +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&l2cache_pmu->cpumask));
> >   }
> >   
> >   static struct device_attribute l2_cache_pmu_cpumask_attr =
> > diff --git a/drivers/perf/qcom_l3_pmu.c b/drivers/perf/qcom_l3_pmu.c
> > index 66e6cabd6fff..c8d259dd1f80 100644
> > --- a/drivers/perf/qcom_l3_pmu.c
> > +++ b/drivers/perf/qcom_l3_pmu.c
> > @@ -663,7 +663,7 @@ static ssize_t cpumask_show(struct device *dev,
> >   {
> >   	struct l3cache_pmu *l3pmu = to_l3cache_pmu(dev_get_drvdata(dev));
> >   
> > -	return cpumap_print_to_pagebuf(true, buf, &l3pmu->cpumask);
> > +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&l3pmu->cpumask));
> >   }
> >   
> >   static DEVICE_ATTR_RO(cpumask);
> > diff --git a/drivers/perf/starfive_starlink_pmu.c b/drivers/perf/starfive_starlink_pmu.c
> > index 964897c2baa9..222a0a34e211 100644
> > --- a/drivers/perf/starfive_starlink_pmu.c
> > +++ b/drivers/perf/starfive_starlink_pmu.c
> > @@ -131,7 +131,7 @@ cpumask_show(struct device *dev, struct device_attribute *attr, char *buf)
> >   {
> >   	struct starlink_pmu *starlink_pmu = to_starlink_pmu(dev_get_drvdata(dev));
> >   
> > -	return cpumap_print_to_pagebuf(true, buf, &starlink_pmu->cpumask);
> > +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&starlink_pmu->cpumask));
> >   }
> >   
> >   static DEVICE_ATTR_RO(cpumask);
> > diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
> > index 6ed4707bd6bb..a69c02d2d874 100644
> > --- a/drivers/perf/thunderx2_pmu.c
> > +++ b/drivers/perf/thunderx2_pmu.c
> > @@ -254,7 +254,7 @@ static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr,
> >   	struct tx2_uncore_pmu *tx2_pmu;
> >   
> >   	tx2_pmu = pmu_to_tx2_pmu(dev_get_drvdata(dev));
> > -	return cpumap_print_to_pagebuf(true, buf, cpumask_of(tx2_pmu->cpu));
> > +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(tx2_pmu->cpu)));
> >   }
> >   static DEVICE_ATTR_RO(cpumask);
> >   
> > diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
> > index 33b5497bdc06..e9e4871db08d 100644
> > --- a/drivers/perf/xgene_pmu.c
> > +++ b/drivers/perf/xgene_pmu.c
> > @@ -595,7 +595,7 @@ static ssize_t cpumask_show(struct device *dev,
> >   {
> >   	struct xgene_pmu_dev *pmu_dev = to_pmu_dev(dev_get_drvdata(dev));
> >   
> > -	return cpumap_print_to_pagebuf(true, buf, &pmu_dev->parent->cpu);
> > +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&pmu_dev->parent->cpu));
> >   }
> >   
> >   static DEVICE_ATTR_RO(cpumask);
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 7935d5663944..61689d348abd 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -12657,7 +12657,7 @@ static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr,
> >   	struct cpumask *mask = perf_scope_cpumask(pmu->scope);
> >   
> >   	if (mask)
> > -		return cpumap_print_to_pagebuf(true, buf, mask);
> > +		return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(mask));
> >   	return 0;
> >   }
> >     
> 
> 


