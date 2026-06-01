Return-Path: <linux-rdma+bounces-21589-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8N/tKJzFHWq9dgkAu9opvQ
	(envelope-from <linux-rdma+bounces-21589-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Jun 2026 19:47:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE9362371D
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Jun 2026 19:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94B443081E94
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jun 2026 17:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576423E0C5A;
	Mon,  1 Jun 2026 17:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjGRHh/A"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941983E168A
	for <linux-rdma@vger.kernel.org>; Mon,  1 Jun 2026 17:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780335919; cv=none; b=oMKl+Y7cU2XYxd91MGi8KKKJxUZg/NdQibjFDFsCq6vo+ukXnIhOtzxA27sknxM+QF/qBersfE1xAKYJ9zZieF3e9AwJbpDR8cZ+V+RirbbbcCQJaskZFqCqvGftJ0lvTk7KZSLXn3NuHCw1Chihm4jWlJxgjbMKRjuTvpDwClA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780335919; c=relaxed/simple;
	bh=EUaevAzgtzlvUB5/tuC/JSEZdio1mHCw6ZYwf4PCo8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t3vWZ5gKBg8zAtRj4k4VAJItT2mimg7l5vgXOEKQIDiuvwGdYee77kDRlfZ5KwKxRs73VpKBziXrmQq1T3qhy1qRPliYoefXSPnFmhP8xTxLyJPck+7vc3XDzhTXEhy+uuXAToeHX6P0GzcM3UZ/HYklGc8T9AQAx+y8297ojCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjGRHh/A; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EBDB1F00A0D
	for <linux-rdma@vger.kernel.org>; Mon,  1 Jun 2026 17:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780335916;
	bh=NQXET+HIwUHzkASejrWXITD/EhCJ1l5nthigBOUX5B4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=gjGRHh/AejulXxkNQAjfjV93VMiqgdq6wRmZ7BNSN1UHb97WguW4+/ZA+WuQC6Kll
	 yhn3UxrX6XHEvJlmkImSQf3opqad40WQNxo0e446ikygz1JQuNxXlxEupqUOOMotfi
	 QZ7zNwyi6Ev4WkeVDBku7OIdn6/NnCxDJfGGNtSBSMm42l8FYQ3sk4gJGLxT/hbqCe
	 K0vFWgCVQinuD4UcX6ltdXhdbZf0cM4k6OQ10FtXjpLK4tNUvA3GQZ7EyhXiE2tkMT
	 OVYBnp+ntfYpsvWr85EAbNEvk2fl/CVRUiYB0mkIo2usdhpYSJ7vIUPsX5pwj59Gzk
	 lW6qoYjQk8e7g==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aa68cfc182so1546666e87.0
        for <linux-rdma@vger.kernel.org>; Mon, 01 Jun 2026 10:45:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9b0lClnGaw9Qt8uZsBlPmbcFAzm17H4ODAMEKfbOB8nlkIU0405aUvO/6zBaTPzf7KH3Dxqq7xah0W@vger.kernel.org
X-Gm-Message-State: AOJu0YyagQyyDJGkm8RECUsrp/6iFL0RBpL8QqFiMv4382EnIvcCBpsj
	SzOw8AW1+k7JX3WB2r+mJbj/98rUALAoMeHnoVVQZCvx1TjPlk+hx1+V0b8pY+vGKUguYX0JoLN
	oscwFtH9VwUt2MERHPpwo8VcyxpCWNFM=
X-Received: by 2002:a05:6512:3b97:b0:5aa:6e86:55c8 with SMTP id
 2adb3069b0e04-5aa6e8657c0mr1302970e87.12.1780335912894; Mon, 01 Jun 2026
 10:45:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528183625.870813-1-ynorov@nvidia.com> <20260528183625.870813-6-ynorov@nvidia.com>
In-Reply-To: <20260528183625.870813-6-ynorov@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 1 Jun 2026 19:45:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gPZL7Cmi7Sm5pVN01AG7rb8NiwWkUJ9X6gwim67EUZPQ@mail.gmail.com>
X-Gm-Features: AVHnY4L1KYHIevdOf61kuP7a6ocAZfa6dkfv0T6IORvr_Om4IsQ3giCPU7iBHEE
Message-ID: <CAJZ5v0gPZL7Cmi7Sm5pVN01AG7rb8NiwWkUJ9X6gwim67EUZPQ@mail.gmail.com>
Subject: Re: [PATCH 05/16] ACPI: pad: Use sysfs_emit() for idlecpus show
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-21589-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,rasmusvillemoes.dk,armlinux.org.uk,nxp.com,pengutronix.de,gmail.com,linux.ibm.com,ellerman.id.au,kernel.org,infradead.org,redhat.com,arm.com,linux.intel.com,google.com,intel.com,linaro.org,alien8.de,zytor.com,linuxfoundation.org,samsung.com,sntech.de,hisilicon.com,cornelisnetworks.com,ziepe.ca,linux.alibaba.com,amlogic.com,baylibre.com,googlemail.com,marvell.com,starfivetech.com,os.amperecomputing.com,linutronix.de,nvidia.com,iscas.ac.cn,huawei.com,lists.infradead.org,lists.linux.dev,vger.kernel.org,lists.ozlabs.org];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[90];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 2EE9362371D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 8:36=E2=80=AFPM Yury Norov <ynorov@nvidia.com> wrot=
e:
>
> idlecpus_show() is a sysfs show callback. Use sysfs_emit() and
> cpumask_pr_args() to emit the mask.
>
> This prepares for removing cpumap_print_to_pagebuf().
>
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>  drivers/acpi/acpi_pad.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
> index ec94b09bb747..04d61a6cc95f 100644
> --- a/drivers/acpi/acpi_pad.c
> +++ b/drivers/acpi/acpi_pad.c
> @@ -334,8 +334,8 @@ static ssize_t idlecpus_store(struct device *dev,
>  static ssize_t idlecpus_show(struct device *dev,
>         struct device_attribute *attr, char *buf)
>  {
> -       return cpumap_print_to_pagebuf(false, buf,
> -                                      to_cpumask(pad_busy_cpus_bits));
> +       return sysfs_emit(buf, "%*pb\n",
> +                         cpumask_pr_args(to_cpumask(pad_busy_cpus_bits))=
);
>  }
>
>  static DEVICE_ATTR_RW(idlecpus);
> --

Applied (with a tweaked subject) as 7.2 material, thanks!

