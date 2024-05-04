Return-Path: <linux-rdma+bounces-2262-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5048BBCC8
	for <lists+linux-rdma@lfdr.de>; Sat,  4 May 2024 17:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35F951F21A29
	for <lists+linux-rdma@lfdr.de>; Sat,  4 May 2024 15:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFCF4174C;
	Sat,  4 May 2024 15:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gOU9LDkG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950431EF15;
	Sat,  4 May 2024 15:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714836983; cv=none; b=E5Qo2Uwp7awEGE1Fk5ZI+NKg2fBV3X69YM8O/oXSrXXDtYrMdwGeK470YfUNtrNi97IsB5AF3m9u9cDkS6Qe8At2R4i2UFV6n0m3Eu8YyctVEd1F+n4q2q6s+PYEf3idkOTkGd08Ma8tNLJTjrcM/ERaeIMomJgjrMrH5HIfqUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714836983; c=relaxed/simple;
	bh=nwu87VDHK729eGU2R6RqtqlA5jPb1XtrfjcVNZX2UW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J21/PYB7qQ2+f0S3VyffdpUEX8AnVZuizU+THbuxGVAXkjodOpWl7hWWD3mzzgbjJgXgj48uUlR0AQL93hdqFivcEcW0NZbJzjUEaScPaoMkGfLsu1aAh3fN3JaTnRcMg9MBZXrMFKjBVCgm+7O+wdFiT9F2F2quwQOMPkUAeQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gOU9LDkG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92CBEC072AA;
	Sat,  4 May 2024 15:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714836983;
	bh=nwu87VDHK729eGU2R6RqtqlA5jPb1XtrfjcVNZX2UW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gOU9LDkGC/Nk0n7vDBEZnWdd/OxMBxqcUv0bWurd537fHJ4jcdyDDcv+QbZAK3nE/
	 ++E8Cs160Smi3bmrYhGFtE6q5sBfTKr4b7AubdwbVrdiO9sZW2n1rHLERpHgtLVwFL
	 eCOt84oekveT8FaBGhnj3Hf2FmZa93ZVT3j5PrVE=
Date: Sat, 4 May 2024 17:36:20 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org, Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	linux-rdma@vger.kernel.org, Shuai Xue <xueshuai@linux.alibaba.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Khuong Dinh <khuong@os.amperecomputing.com>,
	linux-arm-kernel@lists.infradead.org,
	Corentin Chary <corentin.chary@gmail.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	ibm-acpi-devel@lists.sourceforge.net,
	Azael Avalos <coproscefalo@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo Jaervinen <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	Anil Gurumur thy <anil.gurumurthy@qlogic.com>,
	Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
	Tyrel Datwyler <tyreld@linux.ibm.com>,
	Nilesh Javali <njavali@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	Don Brace <don.brace@microchip.com>, storagedev@microchip.com,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH 0/6] Deduplicate string exposure in sysfs
Message-ID: <2024050409-confident-delouse-a976@gregkh>
References: <cover.1713608122.git.lukas@wunner.de>
 <ZjZGzg5LFU2AT3_D@wunner.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjZGzg5LFU2AT3_D@wunner.de>

On Sat, May 04, 2024 at 04:31:42PM +0200, Lukas Wunner wrote:
> Dear Greg,
> 
> On Sat, Apr 20, 2024 at 10:00:00PM +0200, Lukas Wunner wrote:
> > Introduce a generic ->show() callback to expose a string as a device
> > attribute in sysfs.  Deduplicate various identical callbacks across
> > the tree.
> > 
> > Result:  Minus 216 LoC, minus 1576 bytes vmlinux size (x86_64 allyesconfig).
> > 
> > This is a byproduct of my upcoming PCI device authentication v2 patches.
> > 
> > 
> > Lukas Wunner (6):
> >   driver core: Add device_show_string() helper for sysfs attributes
> >   hwmon: Use device_show_string() helper for sysfs attributes
> >   IB/qib: Use device_show_string() helper for sysfs attributes
> >   perf: Use device_show_string() helper for sysfs attributes
> >   platform/x86: Use device_show_string() helper for sysfs attributes
> >   scsi: Use device_show_string() helper for sysfs attributes
> 
> This series hasn't been applied to driver-core-next AFAICS and the
> merge window is drawing closer.
> 
> So far only patches 1, 2 and 5 have been ack'ed by the respective
> subsystem maintainers.  If the missing acks are the reason it hasn't
> been applied, would it be possibe to apply only 1, 2 and 5?
> 
> I would then resubmit the other ones individually to the subsystem
> maintainers in the next cycle.

I'll just pick it up now, thanks!

greg k-h

