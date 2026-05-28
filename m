Return-Path: <linux-rdma+bounces-21464-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uESyADOdGGr+lQgAu9opvQ
	(envelope-from <linux-rdma+bounces-21464-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 21:53:23 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EBF5F75F0
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 21:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2A13D3010F11
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 19:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C9B3F6C2C;
	Thu, 28 May 2026 19:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VQsm8hMB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012048.outbound.protection.outlook.com [52.101.53.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1521631159C;
	Thu, 28 May 2026 19:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779997981; cv=fail; b=uYf+YjzaWyS+P196beYeTEnTsl2Yi9QQEZ6lCV/B3hRaMiAvougYLV8CiyQE8p8LS0tfffnf8m3CRhsmjP97/3qWVld7g4TJrEeRWjQwWU2Uqqsyoee59bFDrnHAwJB3p799j5pLe+n3UYa/AYdfmlhJLMqfkQSGm3PAY1M2Stw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779997981; c=relaxed/simple;
	bh=vWycOtwAfh+9oCPNwGyKJiQ9YWNFHbr7X/ZoAitB85I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DJt+4mh7bIhP5eBtAh2MnJtqdlIE2RGESBJ1tTPM2P5Xh5/2CE9fmCMFm7UMu3NPIlMg0FifLVpPG+ChBHxuusel2r7RhropjZlxwRRotoX3POdAdDIY3CVpeZt9HVsFSdg15YpbCkSyrQBQuhS6ys1EHauzEQ1datTMYokss4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VQsm8hMB; arc=fail smtp.client-ip=52.101.53.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CMgCJ2ZRexuwC/Fp6r792ahTrBiwW3DU83e880pWOCbO0tgOHblYPtPin9K+LSr5QrHfdNOXO1cmep4+U0W6ekmzrFcHbiAqzJUEW/0fAWCksPGVEn+WDRNaP+RBMDAlpbc8cBHSiZtYXbfFHPgrOpN089b7cweP75/uyIHvf58zs0uieqBDsEU4OPmMg3eWHk364V/tAboPTEiHgEx1mqPiAmN9Ws4ZzzaasRSNcHtxXB3KZJEmCco5oNL3D2ytrndaq1kDnNvDUlHO4JAQBRlddd3kMSngg3laU7aMImT67Yrz4yBBU9c0MO3Ld0nBXh2/mHiIszzh6r9foIxxaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D953EbN5WR5coQg1hVPQ2lQ6Z5sZqXmKMawPOkcfx78=;
 b=KBNfkhFx9UZjZQV8UzEpJ89Zm4rd8KxwqoUfoocieCihPtkr+29UQ/Na220JjzZgKZpuS5AcX82RNBqBQEveNK1nUXMOofq30do26ub9wJraZFrQF1ks7JCPJeneoP8XxQK5ZaGmPnBhqx7OmA4l10AvfhP+71AxuZRpq1C7Kp0M4T/V1H3MSaLtvGawP1YySWXVQTa2jiq3XXBfAuCo+NxFboNBHuLql2AMJEqwi7w4wT5sPROj77rhNBMaFyT13TOfz07mojI05jMogYw3OTwqgPByjPilmxMJcJjufPvappHdbkDQx/SG7pAcBC/fjxP/PkGXle3asisjp16LIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D953EbN5WR5coQg1hVPQ2lQ6Z5sZqXmKMawPOkcfx78=;
 b=VQsm8hMB/meDN4KYHpFRRUNcL18YjUaCAMpDxvN421BkyoZOIfSvyTS4WoH96+0ZgLPNN4pR+CoRBX4jNGaiZXfflcA0s+a1R2nrx5Cq/JERVqi9xzhTCww+ZtC4TdYqJDBXZ01GNk7iRRUvzaKmi4LlXIKVV3VXwan5P5vZrYSWY38GFk0bDG02TbqKcZI1zIccqPK/KtffwsvTrZOPtyH+tT3PsUs7EJlQQFyd6UcK3UuqKqDBjznHyPbpi4XB4v5j3Jsk2O1Ka+EesuwIhTCH2q3ZHCpkI+Z5r5JVeYslvq3b+5COz6uCs4f0vo5Ay3yIMedeGFzFvW77T2n6rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by DM4PR12MB7549.namprd12.prod.outlook.com (2603:10b6:8:10f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 19:52:41 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 19:52:37 +0000
Date: Thu, 28 May 2026 15:52:29 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Ian Rogers <irogers@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Will Deacon <will@kernel.org>,
	Jiucheng Xu <jiucheng.xu@amlogic.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Xu Yang <xu.yang_2@nxp.com>, Linu Cherian <lcherian@marvell.com>,
	Gowthami Thiagarajan <gthiagarajan@marvell.com>,
	Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	Khuong Dinh <khuong@os.amperecomputing.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Yury Norov <yury.norov@gmail.com>, Kees Cook <kees@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Besar Wicaksono <bwicaksono@nvidia.com>, Ma Ke <make24@iscas.ac.cn>,
	Chengwen Feng <fengchengwen@huawei.com>,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-perf-users@vger.kernel.org, linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-fpga@vger.kernel.org,
	linux-rdma@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-cxl@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH 00/16] lib/cpumask: get rid of cpumap_print_to_pagebuf()
Message-ID: <ahic_YusKJFaSDLU@yury>
References: <20260528183625.870813-1-ynorov@nvidia.com>
 <20260528121806.2b54606ba6e42f7f371d95c3@linux-foundation.org>
 <ahiW5LKLiPMC6il_@yury>
 <20260528122903.cf74cf905418ab2d144607c3@linux-foundation.org>
 <ahiYUr0dO_dhOHTU@yury>
 <CAP-5=fXXg+PqH7EZ8X599CKYFWCwQgyH2H-4-+5M3_b9w_dTNw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXXg+PqH7EZ8X599CKYFWCwQgyH2H-4-+5M3_b9w_dTNw@mail.gmail.com>
X-ClientProxiedBy: SJ0PR03CA0356.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::31) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|DM4PR12MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: cc33e445-b4a0-4d1c-ace0-08debcf2ab42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|10070799003|376014|1800799024|366016|11063799006|4143699003|56012099006|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	dy7zgLQjK/I4q1qquUPJAQpI0oQ2qfBzHkpz+7Igg2Z6YgM5RCSe6Od9p05jPOe0QS8+PBCLxblXZn02g0u3b7FTSj8Cr+gs7iQo+8dnEU4tBrTMKPJ042NRhmCeo3YqIS0qagjj6iPzNnZybCaZ9AbeQvFVPVAKR/aezMdHrmbgLgxygujha0te3Xf9aF4Si7ZJBKhebE3cbihIxonHvrXRSXdAsCS5LY0Xsvicbcy2bvaw7rNdrrAx++fBmAGfrFFj2SiYzYcrYoBn+JDsuq+azVr+JrGdtQeSvc25n5syKDmvs7i4uXCk6Bg1LXNSfIoX974RKxTy7PX4PLybvRZUZcZjGMSDuVggYcdYupnAGg3uSwdE8Q7EN9cN+8CWOMKLHynAYBx3SnqvGVR1XPZeQN/XBkZwFpnbpoS15EOQeyg0ZZckW1tOT1rKQIKcqSacaNFgCX3gHvfZG7Ue07WbDAav+SLCrkbPZ6vRGG7AcI7Ig9rRDCJ1zuTnNSHFH9Wd1HiQMPDihxaCQP8eC1uo6w7UrtMNFOttQ5bFEX7OSMZQMwUR7y5EnSzrVw5OuoTtKRbJLbfZQO2wyV+mr71lh3HTJE509W9R4nHTJ4w2hqPvPJAm5Bww0E0J/BPgKnunvDaiCCtsRKOVVRO6ApA+fyxLyPQLlPwhJYx7I/BWK1ZygoDabc1y1tcBHin0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(10070799003)(376014)(1800799024)(366016)(11063799006)(4143699003)(56012099006)(22082099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1V6OENIdkRiQ0hEbzZ6ZVBXZkJ6ZzZEYnBxZHlmeHltekpNcWVaM1NSWS9l?=
 =?utf-8?B?K3VqeVIrNlF4UmRGUlZCZW55c3NuMWR6QWJSSnBWUi94eStHTHhndzNqSmVJ?=
 =?utf-8?B?V3J6bkkrVGxpSG1FdzdkcHZYRWkzZ3dmc2hCZHAxdmlDcHM5WERwZGdhWTVE?=
 =?utf-8?B?M3lTbys0czVid1ptN0V3N2E5dTNERi94bWdpcHY3TFNBc1JyVVQxaHhSYnpI?=
 =?utf-8?B?S01HVjRKMkE1OG1nSlM5SFgxUkkyb1NxRlR3YTJZZmJJRU45b1NyVVdVOXVD?=
 =?utf-8?B?MCt6ZUR1Z1RTUmZWaUliZTZ4eitZKzFRMTZKVjRWaUZMRm1XckJDdHhmVGJv?=
 =?utf-8?B?QXhyeENGekhxbVpneDMxTzlmQlN3a2t1a2tab09RQThDMUdKN2JoWUNlTUpa?=
 =?utf-8?B?WGxZWDR2RlNEY0ovQitXZHdrT3dxMEdjM0ZVSHJtaW9PekpVb3UzQXN2UEp5?=
 =?utf-8?B?dnA3VlhJRHVoczdIL2NLempNMzZ4WjZtRmJZWVNqTzVLTytNcXVuWkpIR3VQ?=
 =?utf-8?B?Wi84aHV2ejBLeXRTMjd6cUVFWjNUWDNKR1Vsdjc1RzU3akh5WmN6Y0d1Ukhi?=
 =?utf-8?B?OHZxbEFLYm9wZnpxUExhSEhMNmIvMmVNS3hMQW9wNlljUnZoWkdjMzlKTGpa?=
 =?utf-8?B?ZnVLSlZMcmJFY2wwQU1BY0hUTi9oV3dNK1Y4YWhhaUNpQWFUM2cxazIwSERt?=
 =?utf-8?B?dmV0WUxDSHZtSkNNNXk0OVJBSVdIN0ZwcVZHWFFINzZNWGhMOGJwZnovSjk3?=
 =?utf-8?B?aTR0SFhtNDRqZCtJUWtpMzBRb3NnQWV2dkxwQjgxRnpNYUlmS1hyVnYrMUhp?=
 =?utf-8?B?b2swVkc2ZGsrNFhmNVZPUUI4Y203cHRtcWszUGJNSDBZSG94aDdrUmZjOEVZ?=
 =?utf-8?B?RzN0YldTNWpkZWdlbFZQNnJQMU1sdWRBd1J1bXRKTWlNYjlsU3gwcFRYS3pv?=
 =?utf-8?B?MktYSDEwc1pEWEFDYWthRHl5TjU4bWtCY1RJaUcvZVRTTXFJZFUydE9ZUjd1?=
 =?utf-8?B?RC9LckJZaWkxcTliZHdkbnVSK1Z2enBYSjgzamZuTGlVV0FhbEFHTDU0ZTV4?=
 =?utf-8?B?TzhzMURkbUdRNU1mMjUyVU81NG5maU5QbjE2YUhVUXNKby9TZS9zUGlqOW9j?=
 =?utf-8?B?dkkyaURTeHF1RldEQ0tnaGlSOFh5Y202cFRmRExxblRSOGRnTGZRb1A4WmdI?=
 =?utf-8?B?aGwzR0I1b2t5eGVGVWpkRkZLdFpELzQyNkh2ZGJXR2xtT1JlQmFGMU1SdU44?=
 =?utf-8?B?Y0c2Rmh0aUM0M0FXb1pWdTljN3pVanhYOGVUWjA4UzhGTzMzaEh2NWlEeHd0?=
 =?utf-8?B?RXNoZEwrOGkrRENFNUVKNGovTUU5eEFpL2NSOUJxVjZjRCsxRHhaR3FFclBW?=
 =?utf-8?B?cnBFMmRGa2hXS0xqSGJjaFlaZjRZR1JuU3pVcUx5T0Qwalkvb3NSL2h2dXht?=
 =?utf-8?B?cG9TL0JwbDlOckNXb29nV3VsNUY4cXlIcW80UEpnVDlZWTNLUkhzWUs0RjRO?=
 =?utf-8?B?QUdtOEdJd1I4RDBkVUg3TEFMWmNJR3kwZnlJU1F2cWxucjFCNnN4cGtQbkR5?=
 =?utf-8?B?NUFqeVkwYTF6dzZmYkpzWVYySTF2T1hSNVUwb3dtNUNSNTNQRldRUVVLUXNW?=
 =?utf-8?B?NFNtZ2cvM2Z5YjQ4TWFFcEFNSkRUUXhMcE1PdTl0bmhIT2hrSTRLNnhsdE1Q?=
 =?utf-8?B?RUZhZVpVdmFpR0xlWTRSRlBsUFk5ODRRc1FETWJ2Tmo4OTVWa21reXlablM4?=
 =?utf-8?B?c2tRQzZ0dmVGQjhaaVRoVmhXVFlaVjFuNjlFVDc5TERNMUZzU0g5RkZaS3M3?=
 =?utf-8?B?czl2aVEzRDhxQWVCNGdwVXZTVlZCMm9BOWhUcFh5cHF0Y3lGWmhlQVVoK3M1?=
 =?utf-8?B?MnRCSVhvdFBPWlRCd1ZDcG1IeWlydGM1TmVsUk9VbmlSdlBmMmE1U256NW96?=
 =?utf-8?B?WWpMS0lRcjFQdFE2cGhob1dvZWlYZmxLSE1Va04xcUFQUnVtZE1JZ0JYeEpn?=
 =?utf-8?B?S1lGbGN1OHl6ZDB0bzM0anF3YTdtc2ZmZEcrV1pqZWk2TEJVWXBPK1A2K0tQ?=
 =?utf-8?B?aGd2RDhOUGZQRmlGSk16ckgrd0dkQ25JZWh4WXhadU5aZWRDM1ZHbStxbDMw?=
 =?utf-8?B?eWEyZSt5eXZkUG1ibmVSc0ZLMzNmWTlEZllxOEsrUGhhVHNGYUtOTXAvcitu?=
 =?utf-8?B?SWNsbTdKN3kyK3IwVGJKNHBKdnB1dnd1RVVJWXV3eEozM3hIN2lla291U204?=
 =?utf-8?B?WHJMclRyUTlBcVdWTkVxUXlaeHhQdEpVOVJnd0RBajllcVBzYWtFdFNDdTRV?=
 =?utf-8?B?SmRzS29vSEQyUHAreTB0VXRzT3pjQVRVSjZpeTJLNWJkVEdQNys3K3YxVmpj?=
 =?utf-8?Q?XpVPUOSAS4fenAnbW5Mp9hFYfpRzFOGhZ3IkV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc33e445-b4a0-4d1c-ace0-08debcf2ab42
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 19:52:37.6543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2iQlUvyEqeqjpH8YzLED08KCblDIn2RL086B4FdB1c1RRtgJvkCz7U7qONOpWTcNDX8njZoS/JKruXvnOnElQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7549
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,rasmusvillemoes.dk,armlinux.org.uk,nxp.com,pengutronix.de,gmail.com,linux.ibm.com,ellerman.id.au,kernel.org,infradead.org,redhat.com,arm.com,linux.intel.com,intel.com,linaro.org,alien8.de,zytor.com,linuxfoundation.org,samsung.com,sntech.de,hisilicon.com,cornelisnetworks.com,ziepe.ca,google.com,linux.alibaba.com,amlogic.com,baylibre.com,googlemail.com,marvell.com,starfivetech.com,os.amperecomputing.com,linutronix.de,nvidia.com,iscas.ac.cn,huawei.com,lists.infradead.org,lists.linux.dev,vger.kernel.org,lists.ozlabs.org,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21464-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCPT_COUNT_GT_50(0.00)[90];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,sashiko.dev:url,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 11EBF5F75F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 12:44:15PM -0700, Ian Rogers wrote:
> On Thu, May 28, 2026 at 12:32 PM Yury Norov <ynorov@nvidia.com> wrote:
> >
> > On Thu, May 28, 2026 at 12:29:03PM -0700, Andrew Morton wrote:
> > > On Thu, 28 May 2026 15:26:28 -0400 Yury Norov <ynorov@nvidia.com> wrote:
> > >
> > > > On Thu, May 28, 2026 at 12:18:06PM -0700, Andrew Morton wrote:
> > > > > On Thu, 28 May 2026 14:36:07 -0400 Yury Norov <ynorov@nvidia.com> wrote:
> > > > >
> > > > > > cpumap_print_to_pagebuf() is the equivalent for the "&*pb[l]" notation
> > > > > > in printk-like functions. In some cases, it makes people to create
> > > > > > temporary buffers for the printed cpumasks, where it can be avoided.
> > > > > >
> > > > > > Get rid of it in a favor of more standard printing API.
> > > > > >
> > > > > > Each patch, except for the last one, is independent and may be moved with
> > > > > > the corresponding subsystem. Or I can take it in bitmap-for-next, at
> > > > > > maintainers' discretion.
> > > > > >
> > > > > > On top of bitmap-for-next.
> > > > >
> > > > > Sashiko doesn't attempt bitmap-for-next, so it couldn't apply this series.
> > > > >   https://sashiko.dev/#/patchset/20260528183625.870813-1-ynorov@nvidia.com
> > > >
> > > > OK... What should I do about that?
> > >
> > > Rebase onto something which Sashiko *does* attempt.  Mainline, a few
> > > mm.git branches.  Maybe linux-next.
> >
> > Is Sashiko a new mandatory requirement now? Documentation doesn't even
> > mention the bot.
> >
> > > Roman, is there a list of trees/branches which Sashiko tries to apply
> > > series to?
> >
> > Hi Roman,
> >
> > Can you add bitmap-for-next in the list?
> 
> Fwiw, you can see the list of branches attempted and the SHA they are
> at in the Baseline drop down:
> 
> Baseline Status Log
> tip/x86/core (0f61b1860cc3f52aef9036d7235ed1f017632193) Failed View Log
> powerpc/HEAD (6916d5703ddf9a38f1f6c2cc793381a24ee914c6) Failed View Log
> chanwoo/HEAD (7fd2df204f342fc17d1a0bfcd474b24232fb0f32) Failed View Log
> linux-arm/HEAD (dd6c438c3e64a5ff0b5d7e78f7f9be547803ef1b) Failed View Log
> linux-pm/HEAD (e7ae89a0c97ce2b68b0983cd01eda67cf373517d) Failed View Log
> linux-fpga/HEAD Failed View Log
> pci/HEAD (254f49634ee16a731174d2ae34bc50bd5f45e731) Failed View Log
> linux-pm/thermal (21c315342b81526874acfa311f11b3f72bed4e14) Failed View Log
> rdma/HEAD (67464f388d52ec172be62c99fc43697437ffa384) Failed View Log
> linux-next/HEAD (f7af91adc230aa99e23330ecf85bc9badd9780ad) Failed View Log
> HEAD (917719c412c48687d4a176965d1fa35320ec457c) Failed View Log

Thanks, Ian. Bitmap-for-next is tracked with linux-next.

