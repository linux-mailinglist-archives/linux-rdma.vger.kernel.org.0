Return-Path: <linux-rdma+bounces-21465-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLBXAYOgGGpAlggAu9opvQ
	(envelope-from <linux-rdma+bounces-21465-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 22:07:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 786525F7DD6
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 22:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A88C431BE58D
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 20:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEFC40C5A0;
	Thu, 28 May 2026 20:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="K3wJo6jw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF2533F5B4;
	Thu, 28 May 2026 20:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998536; cv=none; b=rqtsTFG71aBfxvdANif1WHbIaf3UVG3s6dtGwhxjwxNXbzdD2UdxnN4PbWP0fwxC4+y767o3cqZ75F6ALKk1fV3j6BwzcJgcWNxV1lw74vUM3RzRIyrgZEPVtNXigiD7TSAx+Ju3C9uFaOdwqjZzfa7X8t4MWTxzDi9zmfg91uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998536; c=relaxed/simple;
	bh=VSKIAt44qFXWhFnJo7CH2oGdwV4D03RmDAaUreplK1I=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fpQeOlqmEe3njAfUTd9xeZIVPH+lyBXFU/1YVQ9nCi0+AR8o6gJLYPSyZIaTKiouysEl75+anTXFFpNkjvrcDawhBRLM7w+jTEQsBKaNxmSGKcBTbKji1CnUA+DOSFy9s61kte0AqIPnVodVNWQX3ReAqMpWKxwKjqjDuBrEi7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=K3wJo6jw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9284A1F000E9;
	Thu, 28 May 2026 20:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1779998534;
	bh=sOdbbD7G7eTWO5JibIgZY1m2koWpPPdF6nvlH1ZT89M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=K3wJo6jw8qcEplqgtIkScPKA0RsLr1kFs7cucAKszlxSCQ18McSxCrghe3NioKpPq
	 C/fk+aaY8amLdNR5N4Q3s412wEETs+pEB8A9alDdZX2MZJf2CddHa6+WqND0wg0n9l
	 WgEPoOaDjPczHMoBWEQvjzjOIVL0dBxbHTAENBL0=
Date: Thu, 28 May 2026 13:02:11 -0700
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
 linux-arm-msm@vger.kernel.org, Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH 00/16] lib/cpumask: get rid of cpumap_print_to_pagebuf()
Message-Id: <20260528130211.54589cb876ca5e0d55caf117@linux-foundation.org>
In-Reply-To: <ahiYUr0dO_dhOHTU@yury>
References: <20260528183625.870813-1-ynorov@nvidia.com>
	<20260528121806.2b54606ba6e42f7f371d95c3@linux-foundation.org>
	<ahiW5LKLiPMC6il_@yury>
	<20260528122903.cf74cf905418ab2d144607c3@linux-foundation.org>
	<ahiYUr0dO_dhOHTU@yury>
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
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-21465-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[rasmusvillemoes.dk,armlinux.org.uk,nxp.com,pengutronix.de,gmail.com,linux.ibm.com,ellerman.id.au,kernel.org,infradead.org,redhat.com,arm.com,linux.intel.com,google.com,intel.com,linaro.org,alien8.de,zytor.com,linuxfoundation.org,samsung.com,sntech.de,hisilicon.com,cornelisnetworks.com,ziepe.ca,linux.alibaba.com,amlogic.com,baylibre.com,googlemail.com,marvell.com,starfivetech.com,os.amperecomputing.com,linutronix.de,nvidia.com,iscas.ac.cn,huawei.com,lists.infradead.org,lists.linux.dev,vger.kernel.org,lists.ozlabs.org,linux.dev];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_GT_50(0.00)[90];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,linux-foundation.org:mid,linux-foundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Queue-Id: 786525F7DD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 28 May 2026 15:32:34 -0400 Yury Norov <ynorov@nvidia.com> wrote:

> > > > Sashiko doesn't attempt bitmap-for-next, so it couldn't apply this series.
> > > > 	https://sashiko.dev/#/patchset/20260528183625.870813-1-ynorov@nvidia.com
> > > 
> > > OK... What should I do about that?
> > 
> > Rebase onto something which Sashiko *does* attempt.  Mainline, a few
> > mm.git branches.  Maybe linux-next.
> 
> Is Sashiko a new mandatory requirement now? Documentation doesn't even
> mention the bot.

It's early days and things are still evolving.

No, I'm not aware of any team having made it mandatory but boy it's
helpful.  Authors appreciate it because it finds bugs, and nobody wants
to add bugs to Linux.

