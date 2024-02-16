Return-Path: <linux-rdma+bounces-1033-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A828D8578C0
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Feb 2024 10:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 566D3282444
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Feb 2024 09:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEFF1B95D;
	Fri, 16 Feb 2024 09:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QUcAhf7+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52F714AA0;
	Fri, 16 Feb 2024 09:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708075346; cv=none; b=QlYRZ2To9mT083fihakIvmf/OaiadneLQEVTE+KUwN7dfws36O/CsOOdb0P64AV+MVD8NbWn0KUgzm8zoGPrLXslnZFouY8wH3sr2RTVshPSSTb608p7KcfSOGf4LvLbLQ3BTtlE7v8IGEFFP7d+s0KSQd0iQOIskaRmNINgdfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708075346; c=relaxed/simple;
	bh=oPvDzzQc5vWK+p/SmqjSqNC1Wjp/9w/PnlwOfrdbPXU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=M/XavO+X1l0buUzHhT1HirRGQO7lh/7LqeUnRN6m07BsovxS1dEySAs3WN84QNnI+6kncxbITxcEnHgHGHgZD1KcV5zLmfGhl574YBYdv3FTt+JHdOf8UFygG8c4OwhOY+h2X/o3qJ26xa4xRTZauJOzG93u/GljIZ6VxfvREho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QUcAhf7+; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708075345; x=1739611345;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=oPvDzzQc5vWK+p/SmqjSqNC1Wjp/9w/PnlwOfrdbPXU=;
  b=QUcAhf7+uIWOhbeg4Rppu3xvzdsDA2jlRDybBrRqmcoH2HWJgWDpslYs
   AinGZzaxmTqSTSW8NE4+70AkdbpqkkKVTXSbtZ0/gQDIvYl+1lHQsljTl
   TuxHMz6JSG9OSgW0ZdE+S6mtHR1WTVzxia/pcZg5j0A85vFdzcjGWuajB
   7lkwotGVTcgYzhuUxhbsSFl1iKEQ8A7sjF1dVzIzGzw2YT3Mnc4QA5pOS
   c9XJg3I3AeLO1I2SQrh2IKoOf57LLuuQld9j8i2nPOZohJgwbSiFetDz6
   /BeMG9Nqqt6Sv1VB7HpllYp8fyiFHPtU+bd2/vRvUv1Kpw6UJYYdDY9n2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2348349"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="2348349"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 01:22:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="41282469"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.94.248.234])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 01:22:19 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 16 Feb 2024 11:22:13 +0200 (EET)
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
    Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
    Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
    "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
    Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
    "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, 
    "Pan, Xinhui" <Xinhui.Pan@amd.com>, 
    "Koenig, Christian" <Christian.Koenig@amd.com>, 
    Lukas Wunner <lukas@wunner.de>
Subject: RE: [PATCH 1/3] drm/radeon: Use RMW accessors for changing LNKCTL2
In-Reply-To: <BL1PR12MB51440761895B3DF935840BF0F74D2@BL1PR12MB5144.namprd12.prod.outlook.com>
Message-ID: <dd2da980-d114-e30e-fa91-79ff9ec353e7@linux.intel.com>
References: <20240215133155.9198-1-ilpo.jarvinen@linux.intel.com> <20240215133155.9198-2-ilpo.jarvinen@linux.intel.com> <BL1PR12MB51440761895B3DF935840BF0F74D2@BL1PR12MB5144.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1671545761-1708075333=:1097"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1671545761-1708075333=:1097
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 15 Feb 2024, Deucher, Alexander wrote:

> [Public]
>=20
> > -----Original Message-----
> > From: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > Sent: Thursday, February 15, 2024 8:32 AM
> > To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
> > gfx@lists.freedesktop.org; Daniel Vetter <daniel@ffwll.ch>; David Airli=
e
> > <airlied@gmail.com>; Dennis Dalessandro
> > <dennis.dalessandro@cornelisnetworks.com>; dri-
> > devel@lists.freedesktop.org; Jason Gunthorpe <jgg@ziepe.ca>; Leon
> > Romanovsky <leon@kernel.org>; linux-kernel@vger.kernel.org; linux-
> > rdma@vger.kernel.org; Pan, Xinhui <Xinhui.Pan@amd.com>; Koenig, Christi=
an
> > <Christian.Koenig@amd.com>
> > Cc: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>; Lukas Wunner
> > <lukas@wunner.de>
> > Subject: [PATCH 1/3] drm/radeon: Use RMW accessors for changing LNKCTL2
> >
> > Convert open coded RMW accesses for LNKCTL2 to use
> > pcie_capability_clear_and_set_word() which makes its easier to understa=
nd
> > what the code tries to do.
> >
> > LNKCTL2 is not really owned by any driver because it is a collection of=
 control
> > bits that PCI core might need to touch. RMW accessors already have supp=
ort
> > for proper locking for a selected set of registers
> > (LNKCTL2 is not yet among them but likely will be in the future) to avo=
id losing
> > concurrent updates.
> >
> > Suggested-by: Lukas Wunner <lukas@wunner.de>
> > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>=20
> The radeon and amdgpu patches are:
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>=20
> Are you looking for me to pick them up or do you want to land them as=20
> part of some larger change?  Either way is fine with me.=20

Hi,

You please take them, I intentionally took them apart from the BW=20
controller series so they can go through the usual trees, not along with=20
the BW controller. (I don't expect the BW controller to be accepted during=
=20
this cycle).

--=20
 i.

--8323328-1671545761-1708075333=:1097--

