Return-Path: <linux-rdma+bounces-2259-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CAD8BBC70
	for <lists+linux-rdma@lfdr.de>; Sat,  4 May 2024 16:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6550B218A2
	for <lists+linux-rdma@lfdr.de>; Sat,  4 May 2024 14:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489D339ADB;
	Sat,  4 May 2024 14:31:48 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D00533D8;
	Sat,  4 May 2024 14:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714833108; cv=none; b=fIOSrXyCvh+bzsE24U5gFKFs5cktDHYBHMLfOsodDlurRZSEDcaoWzKdyGtYfS+3HQQvtzboZvs3FijgcxmC5pQ5oW87QQt6bR2qe8rN9ga1cKmsECQnVyBkg28Tt/5Abm7D2LwAC7SPF19TeZ0vHL2FZOsKVOapNZPR2Azrzbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714833108; c=relaxed/simple;
	bh=ocpnnfd8vO1ZXDw0k7uVLJrLdgKTWsFe7g9KPbqBpRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ymnk2TiepjKVtDuM+OFkYusALG5F8X0SZN7h4De88iU1XZxpa/fxM4q2xPZRVW+CkE+pUtzYNt0WdL98uXaFsDkffr+yLiRkcuKEn+3BMMv8TFgg1JDzz689S7tLvzdfnkbXVKB9QcCWSeDYnrckRek/htO6L9RiDK0YEBfRAH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 8667D300102B7;
	Sat,  4 May 2024 16:31:42 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 672E936599; Sat,  4 May 2024 16:31:42 +0200 (CEST)
Date: Sat, 4 May 2024 16:31:42 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
	Jean Delvare <jdelvare@suse.com>,
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
Message-ID: <ZjZGzg5LFU2AT3_D@wunner.de>
References: <cover.1713608122.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1713608122.git.lukas@wunner.de>

Dear Greg,

On Sat, Apr 20, 2024 at 10:00:00PM +0200, Lukas Wunner wrote:
> Introduce a generic ->show() callback to expose a string as a device
> attribute in sysfs.  Deduplicate various identical callbacks across
> the tree.
> 
> Result:  Minus 216 LoC, minus 1576 bytes vmlinux size (x86_64 allyesconfig).
> 
> This is a byproduct of my upcoming PCI device authentication v2 patches.
> 
> 
> Lukas Wunner (6):
>   driver core: Add device_show_string() helper for sysfs attributes
>   hwmon: Use device_show_string() helper for sysfs attributes
>   IB/qib: Use device_show_string() helper for sysfs attributes
>   perf: Use device_show_string() helper for sysfs attributes
>   platform/x86: Use device_show_string() helper for sysfs attributes
>   scsi: Use device_show_string() helper for sysfs attributes

This series hasn't been applied to driver-core-next AFAICS and the
merge window is drawing closer.

So far only patches 1, 2 and 5 have been ack'ed by the respective
subsystem maintainers.  If the missing acks are the reason it hasn't
been applied, would it be possibe to apply only 1, 2 and 5?

I would then resubmit the other ones individually to the subsystem
maintainers in the next cycle.

Thanks!

Lukas

