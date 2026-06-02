Return-Path: <linux-rdma+bounces-21605-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEmqAGkmHmo9hgkAu9opvQ
	(envelope-from <linux-rdma+bounces-21605-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 02:40:09 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AB6626A67
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 02:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 492B5304704F
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2026 00:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8224430C37A;
	Tue,  2 Jun 2026 00:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IYQpzaft"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AECF2C21C7;
	Tue,  2 Jun 2026 00:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780360704; cv=fail; b=sq72g+yi+/U+hwGnCJAhhrPZeZkql+/mRP/iXU2c3dNYqanc/kaAg99vdXRztIajEAy0NgPrnljxwBVKD5Z/N8ODz1P/lGaBY7AO/M2x85fAHc/2ZBr4RPGFcnqWRuPsBnRVi4VBZ+YRRpLNJirsKmpLfSXNs93Qi4OT/pU+Wzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780360704; c=relaxed/simple;
	bh=fTiljwVBeiW401mW5FRnm4xud64LmHWyaejPXVWFYbU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PHZpx83S6fq5sociGDvXPIjWaZY09TEpWnZWAmdE+UXN1zdvme5jacrb8tEHXG1gwLSS/eS37KF4FrSlicqjCh0kyg9tDVctAb+IymNLgkyMVT8LI7xSt8AO/Zp7wpF4V5znF5fSuWJhPJlgDryGovr+w9moW2wzgBg7DoarbPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IYQpzaft; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780360702; x=1811896702;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fTiljwVBeiW401mW5FRnm4xud64LmHWyaejPXVWFYbU=;
  b=IYQpzafthBwbtkkFo9hdxwn/Lf/lfoxpx8NVHQ2eToSjLz+HZafghHEC
   y7YyY/HzbgTYvKL2CMecLezqowuIN4ORf9g85ztATw0H8JchwynwGYPwf
   nlDJDzht9xud91aMMXTtbBfrQE5lXiWgZ7rA37vIo3QR+Ordmb4ZKmH75
   CXhqn5uPftkji/uXYlDvzTaaGeRT1SWOUVrNGB29cAZRj5fAbOokaDm2S
   TtrWBKaKLBBQWiH6JsycY0s57DqWmvtjhCKh68pnvN2kx53lO44uK1mN2
   TfxJQWNVlFkl3tetA7V37c9GQriv0G2Ce3g3ItSWE5MNsmlB1JqzACmkz
   g==;
X-CSE-ConnectionGUID: N6uNzlRBTqSV170KZz2+Bg==
X-CSE-MsgGUID: Jm2vsdB5Qju1sdYTOExJDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="103795407"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="103795407"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 17:38:21 -0700
X-CSE-ConnectionGUID: zDwOpp9QSuiHpzPfkbQNTg==
X-CSE-MsgGUID: 4/IkjBTAQ/693SG5UXLUfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="243846351"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 17:38:20 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 17:38:19 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 1 Jun 2026 17:38:19 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.30) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 17:38:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PpmFNdyk5m0XmYSAGg+yABCnbiXQd9Y7pMdllN6x7LliMQBSKhz2caRNbetpnOHZA6yAJEvaABasURd2gHbmi3ixEbZuMlOQ8ZfsXeA+4rRL49Lr4ddfbLGTehBVedNHuPpUNgY5wORe7g7qKkbFhPhRboFVrqj01MZITZp0WQ2WyFketsmKLdS/aAiRV03Az0SDFCD43ccjvQdNolYtVFZ1CQP9X/tFhUGtSz2kfu+UNgxO4+XnoB/AE+nt/oqBl0UKT5Ll8oZzJyOKatTkJpKaW9mJ8HIs6jEY+my5S1AZ5uQSPgmgortCKAMT0TMkf6Z1PdX4WK1QyZSdil063w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1rhSdylRq+E8YdSKTGKi2/0N9HFUm1HSf04Oh5K+N0=;
 b=RbxdY/3Puejr0i2guVfXI2K3lz3bnhR1VoUyHGiQSXirR3cGZaVq8+RTUNEqtz8WCSAm4Vj05bJoFFF+xy5ru1urUTzWrCG/eOu0vgU9bbKglb4mP3vxKXtcwVNV/Ll8pKaMWv06Cv/2dPS26Q0YDMs9MMsouy7PLb8gnSNWNya5ZdyIl01NhkMODIcyQvPCi6cCouERn6XGVLphyFaACA+/eZV2QWsykiH8Pb9TmG5RhpMaxB92iMz0LzeQPPjDM3IHOkmILq+A+yagV6Er+lrE49/MPYgRLIm503HhcqS7xjedtuqB3tc8pd7b1Rsl0bq46Op5jPADCfHuwqYuyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DSVPR11MB9891.namprd11.prod.outlook.com (2603:10b6:8:45a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 00:38:13 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0071.010; Tue, 2 Jun 2026
 00:38:13 +0000
Date: Mon, 1 Jun 2026 17:38:03 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Yury Norov <ynorov@nvidia.com>
CC: Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Russell King <linux@armlinux.org.uk>, Frank Li
	<Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, "Pengutronix
 Kernel Team" <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"Madhavan Srinivasan" <maddy@linux.ibm.com>, Michael Ellerman
	<mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy
 (CS GROUP)" <chleroy@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo
 Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	"Alexander Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa
	<jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
	<adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, Thomas
 Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, Chanwoo
 Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>, Heiko Stuebner <heiko@sntech.de>,
	"Lorenzo Pieralisi" <lpieralisi@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>, Yicong Yang
	<yangyicong@hisilicon.com>, Jonathan Cameron <jic23@kernel.org>, "Dennis
 Dalessandro" <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Dan Williams
	<djbw@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang
	<dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, Bjorn Helgaas
	<bhelgaas@google.com>, Shuai Xue <xueshuai@linux.alibaba.com>, Will Deacon
	<will@kernel.org>, Jiucheng Xu <jiucheng.xu@amlogic.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, "Jerome
 Brunet" <jbrunet@baylibre.com>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, Robin Murphy <robin.murphy@arm.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>, Xu Yang <xu.yang_2@nxp.com>, "Linu
 Cherian" <lcherian@marvell.com>, Gowthami Thiagarajan
	<gthiagarajan@marvell.com>, Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	Khuong Dinh <khuong@os.amperecomputing.com>, Daniel Lezcano
	<daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, Yury Norov <yury.norov@gmail.com>, Kees Cook
	<kees@kernel.org>, Thomas =?iso-8859-1?Q?Wei=DFschuh?=
	<thomas.weissschuh@linutronix.de>, Aboorva Devarajan
	<aboorvad@linux.ibm.com>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Besar Wicaksono
	<bwicaksono@nvidia.com>, Ma Ke <make24@iscas.ac.cn>, Chengwen Feng
	<fengchengwen@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
	<imx@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-perf-users@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <driver-core@lists.linux.dev>,
	<linux-pm@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
	<linux-fpga@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<linux-amlogic@lists.infradead.org>, <linux-cxl@vger.kernel.org>,
	<linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH 11/16] nvdimm: Use sysfs_emit() for cpumask show callback
Message-ID: <ah4l6xM-ATjSvvSk@aschofie-mobl2.lan>
References: <20260528183625.870813-1-ynorov@nvidia.com>
 <20260528183625.870813-12-ynorov@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260528183625.870813-12-ynorov@nvidia.com>
X-ClientProxiedBy: BY5PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::18) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DSVPR11MB9891:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bcbcbd1-28df-45f1-52c6-08dec03f3aca
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|22082099003|18002099003|11063799006|6133799003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: KQ1+VpDYIF0Pi4fpUb2nBtQrMaaVmAHYB7Lyt+oazOF157DPzLEVpXjTY6HLM7AvOFfTyYNL7kGp2q08iNkoMm8HX4tcdaOgKW94y+OyvwccHrlH8FkXIEVcM6rJnp/lp8Y5bK5h9mTSl1PGrtvHFJ2h6EG9P3Pt+TH4j5Hnjn3vuwPXKUGefROnTRoKoRaxRrlho/vIB9HjLpCQTktt+zTlySW4M0tsb/B9MoGrB1oIxyE8zzIRDQQ93hQK0o3NZLZ3EwJHcdVWwI1lFgFEiYhTc19yt5NY6zCFv33NX+6nPKfFKulz/IX+VV9yPbW7o5YpsXuw6jL65yJS1iBNPTF3UbtlhrwS8h7qhzs26mMR23GZIocefFD1e4SbQ/nSMXhnwFhaky36x9gpQjQRZPvmjTZbz2hmpmIFacuShAiUIesVzmrwXLKw4MVFNzRiZ0CBdUikblmi4EcE9kBu+X3CHhePgjKm2SrtP8jWY7pWz+b6w5oOEaEppbo0XWRlmoTGtM6qxBsM6+IlHQXUBkvX8m55b+7m6YmwDx/XvUuvjJm4qkVqs0ci6vs+yxmFl8e10UurK3vzlGjTN+cQQ/+ZhDloXm2sDVygixiuWUgZsIulInZF1wUxCBqqWrfwY6ccLFS3orklmEFNtDw03UbKqhaYjusdHtlXcbUTQwfEJ7bOdMylYxPPkH/4VkiFcJcZkv9zoTQ3L1PqQq/4qQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(11063799006)(6133799003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?78/8YDM/olopjE5JW0ZbbD/spagF4djFMJjCrlh7xDnlEmir0VAyFVPHAefZ?=
 =?us-ascii?Q?sbHWAm+W3UCvnpSSsR9qGJgjS1yEAZiPyDMH6ZHtvTkScRqceoHQrs9DRDnj?=
 =?us-ascii?Q?4NTEixO2/uF1C6gLKsmt1sy+IZHnNTrEOUdy26ttvtc4zR02vgOljt+DFeqG?=
 =?us-ascii?Q?zxKQsd4gi5BStOcs+yjsf36xctgU+r6Z9gr2T+B0iFY+Da8Vw2chVx5sd0aX?=
 =?us-ascii?Q?lDTRJMO2XyiUHPm1UIOxm2JEjqhaRICY+UUZixbDX7svM0aNLimmuS3MvFy6?=
 =?us-ascii?Q?h4mpKSTm33+l/CIj1m+D+WKdpSyofGkg4nADcFMyZB0MetHvYo49uRDap2oD?=
 =?us-ascii?Q?zbpfZHrpvtTFm+W6ZEuhgiAVhJCI4GrtVzTvQI6ZRTBEMRMTUoBWBljvmL4X?=
 =?us-ascii?Q?lmAVhXUIl6uw+kPq94D+N7HNATVnwUdGccPExpyP1Y+xZisYl4StZanWfLf3?=
 =?us-ascii?Q?3YN0x947xVhMI7G3pP7ZTC1+91+sCrcMMOVw+1qorgE2aA+mYAjt0h5kchz9?=
 =?us-ascii?Q?RMPHc/SGTiT/GFUK5LA/AXxRpZM8yudZ7Jx61UdWkBd9JX6Zr9bcXe8UjOET?=
 =?us-ascii?Q?EVk7nR5ziF5dKVIpU+O+uiuqdr6KczrMP8Qvs7xqyFMwN3O4g5PFScZVJunZ?=
 =?us-ascii?Q?LgQs9RFDst9OCwN8DMOop2kzRCxWoxNoIOzD1VezVrjJqXCwUMOMFPMWgf9E?=
 =?us-ascii?Q?NtdriXqhGUU/3Y1szHudq+21PpTmpVsTrMN0BEx/xjfdqb5DBZuxr/5V0yHJ?=
 =?us-ascii?Q?QZ/I0LKegG9DSIi+vhqpqN4uHUHahhPtY/LqdVm/kWRLhjM3/d/2GDTEh+WR?=
 =?us-ascii?Q?ua4WFPbG7OpIixuH471PEOKUNaK55uU6eehaodLfkN996OMNIWFjvPY7f3zu?=
 =?us-ascii?Q?OJ7Mv8SUTx+7G84l4HUbQfAb9ZVCrRovbpODXHSIWtPhzFuqMMqsT9i8/IRj?=
 =?us-ascii?Q?i5FIWoulYtxnm+tJO4dTxRTUUYAwwVTNbbcJMoYjfxuZao4SSG01gf84AUhw?=
 =?us-ascii?Q?cioniR2h/HdROv+ypF0BTbPTvW8MXgx23nbjOTqFInR+VzL12YcP1CqeuShH?=
 =?us-ascii?Q?VThFtWRta3FY2rC1MfxPZ4XzEXDNMfDhtrsHBV0FIDDsJADbY+FcsypWCzVS?=
 =?us-ascii?Q?zHQd0guDyfoENV3tuCt4TeXhMBICJfADyWKsnMT/L+/GV1oXoUu6wXrv5tc1?=
 =?us-ascii?Q?L3lGtsVfJF10cGfsbb2GKcoi98I85Crvs7FZmuwMeORVCdvrlbst6kwVfiAO?=
 =?us-ascii?Q?CqBVs3P5F7s7r53KI0SOdmz+mvqp1obOfWwlGaKEnei05nlorVuaiemV40KT?=
 =?us-ascii?Q?yIo5K57AtX3QaEDbBpV53msEl54wXR5DCQI3oBTfSZ7BpWYgkuUnh25VL5Un?=
 =?us-ascii?Q?bzqWa/1QFiPb432ol+InH8WpFxvXrtJFH9KynvKajt30YUIqOEGF4OJuCkzF?=
 =?us-ascii?Q?II7/VJ14HTGvslRseKXajEOQ0FjcrsVEIaWW4KMHS/7bad7lUBw/xFG/rMo5?=
 =?us-ascii?Q?lwQAE1PQi8N0SIahLaPEkurdVUHwY1oZR+jZqtK/fk0Nn1xQgqY5isRIsjS4?=
 =?us-ascii?Q?pibWBIBhDR+3pGGT17coAG/XLALtXUNkHPT9oTMyozaIlj+lPh3vMZnw2ft4?=
 =?us-ascii?Q?R0AYqFfYuAhRrQ/YR9wXgep6snFgz04WiSi9Ne1WmJ16uGCWUu8ZKrXsQIH0?=
 =?us-ascii?Q?GPCaO180QGAlqZhKdvQNuZombOs41syCq0pB4zXw95ajQgxj8bvXB8zkDNTz?=
 =?us-ascii?Q?ermt8BKuoAD9aR8vErgiWcYU7LsrsRE=3D?=
X-Exchange-RoutingPolicyChecked: QfXcgt7n0dg7Wa+uSvxH/FIVVFU0oDOzEJr2Fv5cXJXZbatlt5aklCi3VHZtgz3VHEOfEBCWO9IHIUwl5H1ezh5u9rczWbnL9VYPj0e3ADB3aLaj1caEIwD/oa8Z6kE9IevE83ExC98IblAp089AwuJNTe2dvVc3p3uJ+7ypHYrJVs09xBE+4RYM9ejy0CbmZlH4rgDmF755zMN+mzDhiCv2dGdNrvkFb9496HTOODFRNrMBZdg/sauBpfza/OQkXEohleluEkoBqRXjTepY3FDySiFl8/mO3mHUeeMF7oLMTQe8oHS7VBEgqIIYP44i6RvP7CgytpuU2Kg8tqXx2Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bcbcbd1-28df-45f1-52c6-08dec03f3aca
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 00:38:13.6604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fRXYnvuxmK+/atYvcEzPg401c1ZA1/Dy2f1rWbx4VBBI00TCLfXH8Arew6BPh1ay/JhoUZEsARgh8l7OYElBtUXW6AKPngBimXTnGIJt0xc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB9891
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,rasmusvillemoes.dk,armlinux.org.uk,nxp.com,pengutronix.de,gmail.com,linux.ibm.com,ellerman.id.au,kernel.org,infradead.org,redhat.com,arm.com,linux.intel.com,google.com,intel.com,linaro.org,alien8.de,zytor.com,linuxfoundation.org,samsung.com,sntech.de,hisilicon.com,cornelisnetworks.com,ziepe.ca,linux.alibaba.com,amlogic.com,baylibre.com,googlemail.com,marvell.com,starfivetech.com,os.amperecomputing.com,linutronix.de,nvidia.com,iscas.ac.cn,huawei.com,lists.infradead.org,lists.linux.dev,vger.kernel.org,lists.ozlabs.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,intel.com:dkim,aschofie-mobl2.lan:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21605-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alison.schofield@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[90];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 78AB6626A67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 02:36:18PM -0400, Yury Norov wrote:
> nvdimm_pmu_cpumask_show() is a sysfs show callback. Use sysfs_emit() and
> cpumask_pr_args() to emit the mask.
> 
> This prepares for removing cpumap_print_to_pagebuf().
> 
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Thanks! Reviewed and applied to nvdimm/nvdimm.git (libnvdimm-for-next)
https://git.kernel.org/nvdimm/nvdimm/c/1e7afc906f2f


> 

