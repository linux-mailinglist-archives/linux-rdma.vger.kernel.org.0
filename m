Return-Path: <linux-rdma+bounces-8173-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C86E2A46C95
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 21:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96D283AEFC1
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 20:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58BB238D39;
	Wed, 26 Feb 2025 20:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fV8iNAC7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1552827561C;
	Wed, 26 Feb 2025 20:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740602334; cv=none; b=WQ4PmwmEnNIRTGDpcRIBQXd7wchdvHqpnXQJKsJBoFIxAJuz1qAd8tFYa0SJakHfdyIaBacXEo4G19eyT/sUjw0vSn3xf0Ypxg4beIUkVACZQZ4JS9mwNVpth8ciyTcMJOE1FLjneSPooaYdXb7clMXOYtPFJNpbm5PLFpV4PsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740602334; c=relaxed/simple;
	bh=7XYXLxmDs/g+GFsdMP00ShC9As4ZJdRFjOnafekKWK4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WgKiS3Iqan7ZZIsHFJI/HVGDUAWTs2KgNl4AJzVxc3fZwliMwyIOG7gEG8w8heSViu3Y9XlnSJztXB/IxcrsFZXY/wksy8RcAFA36vzq5g9lu+IKYEJMD1c6HhC9jI4k1cAeQvtMlv02GxEdrcPpMcsEba8BjgbzgzzGB3qyAv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fV8iNAC7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6862C4CED6;
	Wed, 26 Feb 2025 20:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1740602333;
	bh=7XYXLxmDs/g+GFsdMP00ShC9As4ZJdRFjOnafekKWK4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fV8iNAC7l4sOXlbbBPxr62ebH5w2CCdPAcSqIvutoYztu5oPQJIO+VleFuSaNJwgu
	 4XgUTLEITbZ/EXzbMYjOUaYvhSzh8lkiZR+OX0Og6mdEO8tbUqzELkCgiiGXTD8w+8
	 VA5I1aWrxf8HjtmXFunV8nM5CekAUj0+LkOLORow=
Date: Wed, 26 Feb 2025 12:38:51 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Mark Brown <broonie@kernel.org>
Cc: Easwar Hariharan <eahariha@linux.microsoft.com>, Yaron Avizrat
 <yaron.avizrat@intel.com>, Oded Gabbay <ogabbay@kernel.org>, Julia Lawall
 <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, James Smart
 <james.smart@broadcom.com>, Dick Kennedy <dick.kennedy@broadcom.com>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Ilya
 Dryomov <idryomov@gmail.com>, Dongsheng Yang <dongsheng.yang@easystack.cn>,
 Jens Axboe <axboe@kernel.dk>, Xiubo Li <xiubli@redhat.com>, Damien Le Moal
 <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, Carlos Maiolino
 <cem@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, Sebastian Reichel
 <sre@kernel.org>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig
 <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Frank Li
 <Frank.Li@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Shyam Sundar S K
 <Shyam-sundar.S-k@amd.com>, Hans de Goede <hdegoede@redhat.com>, Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, Henrique de
 Moraes Holschuh <hmh@hmh.eng.br>, Selvin Xavier
 <selvin.xavier@broadcom.com>, Kalesh AP
 <kalesh-anakkur.purayil@broadcom.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon
 Romanovsky <leon@kernel.org>, cocci@inria.fr, linux-kernel@vger.kernel.org,
 linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-sound@vger.kernel.org, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-spi@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org,
 ibm-acpi-devel@lists.sourceforge.net, linux-rdma@vger.kernel.org, Takashi
 Iwai <tiwai@suse.de>, Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [PATCH v3 00/16] Converge on using secs_to_jiffies() part two
Message-Id: <20250226123851.a50e727d0a1bfe639ece4a72@linux-foundation.org>
In-Reply-To: <79b24031-5776-4eb3-960b-32b0530647fb@sirena.org.uk>
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
	<79b24031-5776-4eb3-960b-32b0530647fb@sirena.org.uk>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 11:29:53 +0000 Mark Brown <broonie@kernel.org> wrote:

> On Tue, Feb 25, 2025 at 08:17:14PM +0000, Easwar Hariharan wrote:
> > This is the second series (part 1*) that converts users of msecs_to_jiffies() that
> > either use the multiply pattern of either of:
> > - msecs_to_jiffies(N*1000) or
> > - msecs_to_jiffies(N*MSEC_PER_SEC)
> > 
> > where N is a constant or an expression, to avoid the multiplication.
> 
> Please don't combine patches for multiple subsystems into a single
> series if there's no dependencies between them, it just creates
> confusion about how things get merged, problems for tooling and makes
> everything more noisy.  It's best to split things up per subsystem in
> that case.

I asked for this.  I'll merge everything, spend a few weeks gathering
up maintainer acks.  Anything which a subsystem maintainer merges will
be reported by Stephen and I'll drop that particular patch.

This way, nothing gets lost.  I take this approach often and it works.

If these were sent as a bunch of individual patches then it would be up
to the sender to keep track of what has been merged and what hasn't. 
That person will be resending some stragglers many times.  Until they
give up and some patches get permanently lost.

Scale all that across many senders and the whole process becomes costly
and unreliable.  Whereas centralizing it on akpm is more efficient,
more reliable, more scalable, lower latency and less frustrating for
senders.


