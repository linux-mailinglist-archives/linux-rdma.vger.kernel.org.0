Return-Path: <linux-rdma+bounces-21595-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHMJLdfJHWrHeQkAu9opvQ
	(envelope-from <linux-rdma+bounces-21595-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Jun 2026 20:05:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F55623B31
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Jun 2026 20:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C54C630FF2BC
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jun 2026 17:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9303E2769;
	Mon,  1 Jun 2026 17:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBEcWjLV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765ED3E1224
	for <linux-rdma@vger.kernel.org>; Mon,  1 Jun 2026 17:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780336640; cv=none; b=t+dnfQtI5qgGMDdhUFwasXOkzkqUBcdq4k3NTW9fPWFEF3/Lan/60tTHfpI3Ad/6BsX1NEztK+swQkEOMncU5UwTHQ8CuTdF6ixsu9Gun4iFU6o31rMew7VRA7ZobZSupNNjri7LbLfwDlITi0+nC3sa4CWM9WwoYd2bySq4rcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780336640; c=relaxed/simple;
	bh=a8NNwl3gj28TdelJ2QDDl+HZA18Xikw2b26A8/RV0gM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dcfCCXCg6cEKiIzrldz2FrrcHWVt9W6xhhk4VE/9N5ePmttpEkRFU3ouKxn21PvMTRfZ/ldc9WBuwhcmIfWJnEBD7OpoGDqAm3nlpz21tIV1bFIW7xv4Km3ZNGZuhCV4IrV+2S4SE0fg5CyomJ1lbshCNZ/R5fpBbkCglE73rGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBEcWjLV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 151941F00898
	for <linux-rdma@vger.kernel.org>; Mon,  1 Jun 2026 17:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780336639;
	bh=Fs6zIa+oKHWvRltzPvd2mFdEu12rLJwaXHbNCVd0THk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=YBEcWjLVnMFNyhTH2clkn3SS4OxRe1EiT16jl+iPdqtWZ6g6WzL01QnGkF+WWRam7
	 w/ZcqoOJqRowf8oOS8Q6viCgpRJsyJiBa+d4C5wmKbJH7tJiJhiDb93cwLqYUlDKml
	 mHXcxS57F1wvpuoDi3TBhJTiWc6lIXFRC6DLn8uGUOMYBw6GaJOyoK2kyMIyoxNc7p
	 m4+++rUeb0vl0IzyXPwELbWx2Wf/A7WH/4TyR/wup0oelEBZRQeugazaRmmGov4zso
	 HRlSs7aOsYQJ+0QyGGCrz2ZQ3fQKmzgNOCSA6CE/MEXudplG9ukTFIS7NytFwxsJHx
	 +0+P15plzbwXw==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aa66893e9fso1831673e87.1
        for <linux-rdma@vger.kernel.org>; Mon, 01 Jun 2026 10:57:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/8Bjerwsno64VzjfrValZ0/qSTBVMcXeabfc0u2/IgddK/Tnv0epZtOQ3+6EZrJMQIlUre+wY70f4C@vger.kernel.org
X-Gm-Message-State: AOJu0YyW/9xIclkrO5UaQRmmZ6c4/t+ehK4psi0IzbVFOJ/2SrH/GCy3
	2lJyocu8IN++S5f6gR7kzfV7gmvGq8h5IuygBDsfO8/pV40knwQnYBmOM6W+uROGNpUrMa1k94K
	tSfxIeTlDzeA2+5RU5JUTPS9TlpnFH8Y=
X-Received: by 2002:a05:6512:8007:20b0:5aa:6395:f9c5 with SMTP id
 2adb3069b0e04-5aa73ee8720mr300250e87.27.1780336637107; Mon, 01 Jun 2026
 10:57:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528183625.870813-1-ynorov@nvidia.com> <20260528183625.870813-15-ynorov@nvidia.com>
In-Reply-To: <20260528183625.870813-15-ynorov@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 1 Jun 2026 19:57:04 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g4G9aJ1fjQxXmk1YHXh+xBojpFz207j_jz7HiLH1Lz1Q@mail.gmail.com>
X-Gm-Features: AVHnY4INVXbw7SKAZHG4Jnm8fXAHVwo_FKl3cnkJN8dTeVudl-a8v97e8VxcFA4
Message-ID: <CAJZ5v0g4G9aJ1fjQxXmk1YHXh+xBojpFz207j_jz7HiLH1Lz1Q@mail.gmail.com>
Subject: Re: [PATCH 14/16] powercap: intel_rapl: Use sysfs_emit() for cpumask show
To: Yury Norov <ynorov@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Russell King <linux@armlinux.org.uk>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Heiko Stuebner <heiko@sntech.de>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, 
	Moritz Fischer <mdf@kernel.org>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jic23@kernel.org>, 
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Dan Williams <djbw@kernel.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Shuai Xue <xueshuai@linux.alibaba.com>, Will Deacon <will@kernel.org>, 
	Jiucheng Xu <jiucheng.xu@amlogic.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Robin Murphy <robin.murphy@arm.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Linu Cherian <lcherian@marvell.com>, Gowthami Thiagarajan <gthiagarajan@marvell.com>, 
	Ji Sheng Teoh <jisheng.teoh@starfivetech.com>, Khuong Dinh <khuong@os.amperecomputing.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Yury Norov <yury.norov@gmail.com>, Kees Cook <kees@kernel.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Aboorva Devarajan <aboorvad@linux.ibm.com>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Besar Wicaksono <bwicaksono@nvidia.com>, 
	Ma Ke <make24@iscas.ac.cn>, Chengwen Feng <fengchengwen@huawei.com>, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-perf-users@vger.kernel.org, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-fpga@vger.kernel.org, 
	linux-rdma@vger.kernel.org, nvdimm@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-amlogic@lists.infradead.org, linux-cxl@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,rasmusvillemoes.dk,armlinux.org.uk,nxp.com,pengutronix.de,gmail.com,linux.ibm.com,ellerman.id.au,kernel.org,infradead.org,redhat.com,arm.com,linux.intel.com,google.com,intel.com,linaro.org,alien8.de,zytor.com,linuxfoundation.org,samsung.com,sntech.de,hisilicon.com,cornelisnetworks.com,ziepe.ca,linux.alibaba.com,amlogic.com,baylibre.com,googlemail.com,marvell.com,starfivetech.com,os.amperecomputing.com,linutronix.de,nvidia.com,iscas.ac.cn,huawei.com,lists.infradead.org,lists.linux.dev,vger.kernel.org,lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21595-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[90];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 39F55623B31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 8:37=E2=80=AFPM Yury Norov <ynorov@nvidia.com> wrot=
e:
>
> cpumask_show() is a sysfs show callback. Use sysfs_emit() and
> cpumask_pr_args() to emit the mask.
>
> This prepares for removing cpumap_print_to_pagebuf().
>
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>  drivers/powercap/intel_rapl_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/inte=
l_rapl_common.c
> index a8dd02dff0a0..b38d4a7799a8 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -1441,7 +1441,7 @@ static ssize_t cpumask_show(struct device *dev,
>         }
>         cpus_read_unlock();
>
> -       ret =3D cpumap_print_to_pagebuf(true, buf, cpu_mask);
> +       ret =3D sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpu_mask));
>
>         free_cpumask_var(cpu_mask);
>
> --

Applied (with adjusted subject and changelog) as 7.2 material, thanks!

