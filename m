Return-Path: <linux-rdma+bounces-1993-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 790118ABCF8
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Apr 2024 22:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ED9C1C20993
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Apr 2024 20:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0958D43ADA;
	Sat, 20 Apr 2024 20:01:39 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C953B299;
	Sat, 20 Apr 2024 20:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713643298; cv=none; b=HXR3zDGrOv3dBoHOO5eTsEe4aRLednpV1cWsPTxM/WYySkVaL74TccRtxDPPk/RItSJ9TbfLmuYC1HAydjvw2+VatgYiEg2Zat9MGkctpTqXXiKwtEbdAybdywM5TsxsdgMDFk6uSlnyc3XCyAbq1DOVGC0tw8gvDJNFIxAercs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713643298; c=relaxed/simple;
	bh=4xgw46KEtZnT9GMEWjwss10m249evoF6JijhofbNk+0=;
	h=Message-ID:From:Date:Subject:To:Cc; b=Z67eGNr4eGMEm2K2tzbuyzNSULCpORmXH9hP3d34hP/8JpRkd7dJ66N63V9BhRYin6Kj5TgE54h+veOjif/Fq/qREs3Fw96R9AgsRXO07cuu6Soy45HSk2ZnT/5RqCISFI5wag39h+ZNs6yVACzCV8oBQ0YhnfY6zo+HoDZh2LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id C6E382800C99F;
	Sat, 20 Apr 2024 22:01:24 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id BF393CC625; Sat, 20 Apr 2024 22:01:24 +0200 (CEST)
Message-ID: <cover.1713608122.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 20 Apr 2024 22:00:00 +0200
Subject: [PATCH 0/6] Deduplicate string exposure in sysfs
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org, Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, linux-rdma@vger.kernel.org, Shuai Xue <xueshuai@linux.alibaba.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, Yicong Yang <yangyicong@hisilicon.com>, Jijie Shao <shaojijie@huawei.com>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Khuong Dinh <khuong@os.amperecomputing.com>, linux-arm-kernel@lists.infradead.org, Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones" <luke@ljones.dev>, "Henrique de Moraes Holschuh" <hmh@hmh.eng.br>, ibm-acpi-devel@lists.sourceforge.net, Azael Avalos <coproscefalo@gmail.com>, Hans de Goede <hdegoede@redhat.com>, "Ilpo Jaervinen" <ilpo.jarvinen@linux.intel.com>, platform-driver-x86@vger.kernel.org, Anil Gurumur
 thy <anil.gurumurthy@qlogic.com>, Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>, Tyrel Datwyler <tyreld@linux.ibm.com>, Nilesh Javali <njavali@marvell.com>, GR-QLogic-Storage-Upstream@marvell.com, Don Brace <don.brace@microchip.com>, storagedev@microchip.com, "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

Introduce a generic ->show() callback to expose a string as a device
attribute in sysfs.  Deduplicate various identical callbacks across
the tree.

Result:  Minus 216 LoC, minus 1576 bytes vmlinux size (x86_64 allyesconfig).

This is a byproduct of my upcoming PCI device authentication v2 patches.


Lukas Wunner (6):
  driver core: Add device_show_string() helper for sysfs attributes
  hwmon: Use device_show_string() helper for sysfs attributes
  IB/qib: Use device_show_string() helper for sysfs attributes
  perf: Use device_show_string() helper for sysfs attributes
  platform/x86: Use device_show_string() helper for sysfs attributes
  scsi: Use device_show_string() helper for sysfs attributes

 arch/powerpc/perf/hv-24x7.c              | 10 ----
 arch/x86/events/intel/core.c             | 13 ++---
 drivers/base/core.c                      |  9 ++++
 drivers/hwmon/i5k_amb.c                  | 15 ++----
 drivers/hwmon/ibmpex.c                   | 14 ++----
 drivers/infiniband/hw/qib/qib.h          |  1 -
 drivers/infiniband/hw/qib/qib_driver.c   |  6 ---
 drivers/infiniband/hw/qib/qib_sysfs.c    | 10 +---
 drivers/perf/alibaba_uncore_drw_pmu.c    | 12 +----
 drivers/perf/arm-cci.c                   | 12 +----
 drivers/perf/arm-ccn.c                   | 11 +----
 drivers/perf/arm_cspmu/arm_cspmu.c       | 10 ----
 drivers/perf/arm_cspmu/arm_cspmu.h       |  7 +--
 drivers/perf/arm_dsu_pmu.c               | 11 +----
 drivers/perf/cxl_pmu.c                   | 13 +----
 drivers/perf/hisilicon/hisi_pcie_pmu.c   | 13 +----
 drivers/perf/hisilicon/hisi_uncore_pmu.c | 14 ------
 drivers/perf/hisilicon/hisi_uncore_pmu.h |  4 +-
 drivers/perf/hisilicon/hns3_pmu.c        | 12 +----
 drivers/perf/qcom_l3_pmu.c               | 11 +----
 drivers/perf/xgene_pmu.c                 | 11 +----
 drivers/platform/x86/asus-wmi.c          | 62 ++++++------------------
 drivers/platform/x86/thinkpad_acpi.c     | 10 +---
 drivers/platform/x86/toshiba_acpi.c      |  9 +---
 drivers/scsi/bfa/bfad_attr.c             | 28 +++--------
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c | 11 +----
 drivers/scsi/mvsas/mv_init.c             | 10 +---
 drivers/scsi/qla2xxx/qla_attr.c          | 11 +----
 drivers/scsi/smartpqi/smartpqi_init.c    | 11 ++---
 include/linux/device.h                   | 15 ++++++
 30 files changed, 85 insertions(+), 301 deletions(-)

-- 
2.43.0


