Return-Path: <linux-rdma+bounces-21459-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFNLMKSWGGqklQgAu9opvQ
	(envelope-from <linux-rdma+bounces-21459-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 21:25:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B215F7098
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 21:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B436318DC58
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 19:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C20403EAC;
	Thu, 28 May 2026 19:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="xeuAPYEZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021852EFD9B;
	Thu, 28 May 2026 19:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779995891; cv=none; b=YKEF77Mjf8BvXjxCw+2pEpZpMVHCYAp0JxaKgMgtXBvGAmku2O35KChWqB4j3YHvlhvi+jLG93XeBHRVDB2NCyiIbGftP2Z5/iO2KSlHBwAFVM5HP/TRUVvk4ANHnmhcPM4q07l/mwyU+MRnjYTgCdkrWSEWQBk+c5QFRoqSk1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779995891; c=relaxed/simple;
	bh=Onv23E/0vmhrIlHseGCGNslegQshHM9VZQaSHUI4LXI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dlz/WHeLkVAj8bc7LPi4Jwt22mK7BtYjtVEN7W8gNS562immTQz91DV2iPbT9+5w+veISEl6aJjY+wFBrz1z0pRDGw2/wX+dwzNZkrOyb2l2JXm2F+Y0L0w5MMOGb/eYlXAulWlB7kTYyDeCSm/L7K7lXe252hf31xwkZ+ASUOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=xeuAPYEZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 468F61F000E9;
	Thu, 28 May 2026 19:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1779995889;
	bh=Ir8iU0d381Bl8diafHd1bBGaGKtd10rJAv1XyjVdWDg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=xeuAPYEZUVLnSxRyYCz4I9aGX07le7zxUwEI88HQ0OzLXuz7PQD+jEo75ksqEWczO
	 KVuLk9KTY9ygfmH8DaX0v2cG2XsYKSxE0/FM8zHN+44tZszrU7LLWMR31TUGb+6lmK
	 gP6ik/Q/RUjqOh0z2IwvVSzOnVcXrshU7xNTe5fA=
Date: Thu, 28 May 2026 12:18:06 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yury Norov <ynorov@nvidia.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Russell King
 <linux@armlinux.org.uk>, Frank Li <Frank.Li@nxp.com>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
 Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung
 Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, Thomas
 Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Greg
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
 <martin.blumenstingl@googlemail.com>, Robin Murphy <robin.murphy@arm.com>,
 Jing Zhang <renyu.zj@linux.alibaba.com>, Xu Yang <xu.yang_2@nxp.com>, Linu
 Cherian <lcherian@marvell.com>, Gowthami Thiagarajan
 <gthiagarajan@marvell.com>, Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
 Khuong Dinh <khuong@os.amperecomputing.com>, Daniel Lezcano
 <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
 <lukasz.luba@arm.com>, Yury Norov <yury.norov@gmail.com>, Kees Cook
 <kees@kernel.org>, Thomas =?ISO-8859-1?Q?Wei=DFschuh?=
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
Subject: Re: [PATCH 00/16] lib/cpumask: get rid of cpumap_print_to_pagebuf()
Message-Id: <20260528121806.2b54606ba6e42f7f371d95c3@linux-foundation.org>
In-Reply-To: <20260528183625.870813-1-ynorov@nvidia.com>
References: <20260528183625.870813-1-ynorov@nvidia.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[rasmusvillemoes.dk,armlinux.org.uk,nxp.com,pengutronix.de,gmail.com,linux.ibm.com,ellerman.id.au,kernel.org,infradead.org,redhat.com,arm.com,linux.intel.com,google.com,intel.com,linaro.org,alien8.de,zytor.com,linuxfoundation.org,samsung.com,sntech.de,hisilicon.com,cornelisnetworks.com,ziepe.ca,linux.alibaba.com,amlogic.com,baylibre.com,googlemail.com,marvell.com,starfivetech.com,os.amperecomputing.com,linutronix.de,nvidia.com,iscas.ac.cn,huawei.com,lists.infradead.org,lists.linux.dev,vger.kernel.org,lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21459-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	DMARC_NA(0.00)[linux-foundation.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_GT_50(0.00)[89];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 30B215F7098
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 28 May 2026 14:36:07 -0400 Yury Norov <ynorov@nvidia.com> wrote:

> cpumap_print_to_pagebuf() is the equivalent for the "&*pb[l]" notation
> in printk-like functions. In some cases, it makes people to create
> temporary buffers for the printed cpumasks, where it can be avoided.
> 
> Get rid of it in a favor of more standard printing API.
> 
> Each patch, except for the last one, is independent and may be moved with
> the corresponding subsystem. Or I can take it in bitmap-for-next, at
> maintainers' discretion.
> 
> On top of bitmap-for-next.

Sashiko doesn't attempt bitmap-for-next, so it couldn't apply this series.
	https://sashiko.dev/#/patchset/20260528183625.870813-1-ynorov@nvidia.com

