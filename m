Return-Path: <linux-rdma+bounces-14677-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 834C5C77AFE
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Nov 2025 08:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3F5AB35FF5E
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Nov 2025 07:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3A6335BB2;
	Fri, 21 Nov 2025 07:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BdCQa8aS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB35422D7B6;
	Fri, 21 Nov 2025 07:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763709863; cv=fail; b=lCVELigIEAP7A37HUMQttRTORv+WBdcT1cq0e1tcMjTg69x9/CWl1NRCh+ei27eLU8POAvHpyEdtf8tk2i7PuqjDDc1B5AFGf+l+8Lz0KEGt3P7QgxUnl79ZV5dJ5fytfGbu/FXqmdAPW5Kt164Q8+B2jPCMgAvycByAoVxgowM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763709863; c=relaxed/simple;
	bh=i1nfHxSl3r/S7W+N07RVJxnT8ED7aavTgmBN3Z/rt8w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JFZkFb7wGCNKMhe8x/BYtnw5zFShHJIC0zEyqHmzt6w+RHexGj/LZgTxov6XQMVvNitqL5kQt5jgIfuHfEmlhgPOLijmgGFJl68BCfvtpZkvF+00UHel2/hafx8j/2OpoU0X/88ofH+2JJ77XHm301fXTpP0wP5Ue2r10Tb0+DI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BdCQa8aS; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763709861; x=1795245861;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=i1nfHxSl3r/S7W+N07RVJxnT8ED7aavTgmBN3Z/rt8w=;
  b=BdCQa8aSsoqA2GhIClHxXeCp9Hs1XXiwA1opL6WwtI6yra1PfovFE3+Z
   LkGB7GI+FQNlOaAbGAd+ve/BvvTRIUvOcq6Mx9zV4e2NrvQnPEFuLYv8i
   aKdkW5J0EAghaMDRKJc0PIvPKMawatIDyDevuPB0TROOQMGBpbxO0GLTi
   mazsDPy7vioBCMr5PO2bKq4s2Tz+DC9543itB4BvYpiR+KoKp969e8ax1
   Z5I6jTW6/Y+/ENr0FOS+XYh6BQ7p0UUNxeacimipWCzpTV125ZstQVErj
   +AACLy2+Q1Dwk4130ab/DoKnRmzZTxDjjudpDXOzHKtFJO3VQNzps4U7H
   Q==;
X-CSE-ConnectionGUID: +6vEZf0sSeuoZ+BawvbzcA==
X-CSE-MsgGUID: p/9eOFHpRCWPl56sNxEe2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="83420838"
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; 
   d="scan'208";a="83420838"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 23:24:21 -0800
X-CSE-ConnectionGUID: 5crExYjnQDKv+o1OH9z0YQ==
X-CSE-MsgGUID: CcWH2rqWQ1GKTB7dr27Kgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; 
   d="scan'208";a="195788697"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 23:24:20 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 20 Nov 2025 23:24:19 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 20 Nov 2025 23:24:19 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.68) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 20 Nov 2025 23:24:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bppcHFknLpGM9y9zdqgE7Brthvko7om4tbUDnV8UeRTf0X/PtTOfp3n8qJCB9vYVVfmAkyv7zvFzwyqxBoOuzLfQwumyo35BKD25scEDnn218wVUs1+eaZ6lCr4UnUsKnONueN7TUkCkyIPUYF9ekJOYYl1DaHCkhItJ8Db1Z9YenHld0Bv0Hy7jjUks84RqN2ooG9IXSMcMEZuqwlkN76mlQxN95Erh4MjoyRo5yQ8fsRREWxG6uqS95x0TJHwnKkDyOHnk1tRBs5RRa4M6WNFtW7Z60JKyWXCmC7tXmtaq1utm0nD9ILtrGTVUPdJ4qtEowl03OmN4NKtNP61vTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1nfHxSl3r/S7W+N07RVJxnT8ED7aavTgmBN3Z/rt8w=;
 b=r45AWs9vv/6iDzG5tgWJpzE3Puk+Ppr8OhWbFmC9qUJhRfuX8SY2NjK3xSWvbH2496Shu//aBkcJ8LHqQmk9CpWkC280FbzIchuAb1h3BuIB5rV3YKQYyq5HQNcAaq1DqHyRsnHt4qwUmXP2BX56MgBBizkKvQt4qE0QvqCSugzH38yOwGGp+OLX+F8B6NaGcXnupzaSTzQyWwZGZzLqAQiZeXx+/wfOIku/OWgUSf0NHeEQyDahn2vS7JWSMOD21tiKu6GXnTEHQMgWP6sz6pK4cu7Ts8eJla84x1YQ4WkKOLWj0dNj8RcV5jvVXV7ExavU/wfLnp4xEooz4TnsCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB6822.namprd11.prod.outlook.com (2603:10b6:806:29f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Fri, 21 Nov
 2025 07:24:15 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 07:24:15 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Christian Benvenuti
	<benve@cisco.com>, Heiko Stuebner <heiko@sntech.de>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Jernej Skrabec <jernej.skrabec@gmail.com>, "Joerg
 Roedel" <joro@8bytes.org>, Leon Romanovsky <leon@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>, "linux-sunxi@lists.linux.dev"
	<linux-sunxi@lists.linux.dev>, Matthias Brugger <matthias.bgg@gmail.com>,
	Nelson Escobar <neescoba@cisco.com>, Rob Clark
	<robin.clark@oss.qualcomm.com>, Robin Murphy <robin.murphy@arm.com>, "Samuel
 Holland" <samuel@sholland.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Chen-Yu Tsai <wens@csie.org>, Will Deacon
	<will@kernel.org>, Yong Wu <yong.wu@mediatek.com>
CC: Lu Baolu <baolu.lu@linux.intel.com>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, Vasant Hegde <vasant.hegde@amd.com>
Subject: RE: [PATCH v3 2/3] iommu/amd: Don't call report_iommu_fault()
Thread-Topic: [PATCH v3 2/3] iommu/amd: Don't call report_iommu_fault()
Thread-Index: AQHcWlZpt+W/iQ8GL0OIi49xXzUHj7T8uvVw
Date: Fri, 21 Nov 2025 07:24:15 +0000
Message-ID: <BN9PR11MB5276F59FE864DB7E6AE685C38CD5A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v3-e5d08e2d551e+109-iommu_set_fault_jgg@nvidia.com>
 <2-v3-e5d08e2d551e+109-iommu_set_fault_jgg@nvidia.com>
In-Reply-To: <2-v3-e5d08e2d551e+109-iommu_set_fault_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB6822:EE_
x-ms-office365-filtering-correlation-id: 92673248-67a5-4fdc-e869-08de28cefa1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|921020;
x-microsoft-antispam-message-info: =?us-ascii?Q?f8mMtiXTu3wkirVI1mGotjQ102jTiYs9Jv8G30iGJMrMnkvoElru3q2bACki?=
 =?us-ascii?Q?eXbuWwqhmvJD/3S4dlgb/u9lkb3KnmrIzhKL07eXCmDa5LsFyHDxpCINIHZs?=
 =?us-ascii?Q?4OXHxjaIqAl3I3lDN0HkNbkZzGBgcrRj0Pxjh/LYAxbb+VlAEH9BhpVynfoc?=
 =?us-ascii?Q?d6ln5bFFUJ9PptBXldWE24RtpAOHADML9jh73L2LiB4UKS81eEwIhlJc+hgX?=
 =?us-ascii?Q?RcVZj9iWZfCRktEMTTwUCDZmLJKSA8oXydZpIYze+w+zEbEG3S5bnfFXbitE?=
 =?us-ascii?Q?v2A9ebeYhshrGES43bQW5GX0iJp+BPfw+96FXBAQ9J76AdcOPYdtBOBs5Nrg?=
 =?us-ascii?Q?WtSnaq3iwzm2AIZqjCeWni59qO0OlqXXbDZci8HpY11xt92varlNIa8z9mY+?=
 =?us-ascii?Q?r2+z5A4M+fbAiqY9RX9575qju5Xt3T3SwZdjC1+9P7VyXct+T4SLw2on3nYB?=
 =?us-ascii?Q?wQUbpo1+JF9zT2VCxZOA8KUH7Y3AeM2H9+2guhjH7i8kVJaRShI8dIwElUTJ?=
 =?us-ascii?Q?y0UgECQw9h9DZb6Bq35jJ4t8TpbNKbTlfNHNpQ6wrK6QpBM4DRtixKyZU7mZ?=
 =?us-ascii?Q?9Ala4lhhyOxtohvEJSQfUNg4YufawGkonA0FIKqaKB9QC4xgCh6arEKR9rkx?=
 =?us-ascii?Q?F+MDMix5iJMROTSuMC6VemQqvVA3pWb1gzpKpJoItI8Ue+T3m8bIDGvumHzy?=
 =?us-ascii?Q?0qEyUEy57OA5/QzwqF7bg4mI9HSTYOjY2pR0UyA0bpzXhCK1tW2NFYe1TrWL?=
 =?us-ascii?Q?FvA2MEtJOW2oZPAoZiK7WaqthTj3/CxwMZoXwOt2RomqM+tP46SWRuZ4AYE2?=
 =?us-ascii?Q?hXRfaKLc4TWo/vrRvcN96mwOPHki2Phgm28qDF+J5tRrDQhMluFnIy2nKqzc?=
 =?us-ascii?Q?MdA5NgYF47cxyE/T+Hb1VsTG72veqf9HH1j9QaRvcFTqQcGUmZiJ7IHT29wC?=
 =?us-ascii?Q?BMYoQx704zKQIf3SmUoTAODGHMxzzZO4qQBZzoL9xF/BpIAwlKD24e/yzgZ2?=
 =?us-ascii?Q?QgO1VQYeQ9wBc8n3OWBW7HHGEr/kPcmAcnK6jMvBb48nKW1M23s3uvnQnhNB?=
 =?us-ascii?Q?9Pxi1rHqhwkIAt1SavFrRa8Eg6JThCKW+dagjumICmw8Lq+a1L7U3l5xKBp+?=
 =?us-ascii?Q?ybG8l1uVnct61iLimqeSKZE/ltTTbIBbNwUiyR/662UBe7KyFelf3p9kK0NK?=
 =?us-ascii?Q?FKuAMViiwNfpRX25WsVV0/jl1pfKJqEBiMG99WHwd6WHs99kFvghaLh/CsBL?=
 =?us-ascii?Q?XbpIimfdk0YuINTiAxI33/vi1kKpG4gcIl7I17463zU+KbdPhwzNGVuW6qyx?=
 =?us-ascii?Q?keqxvE9/CxtMCCi2ItoefE9ylz4moPqmuQ0XwZWFDmvHtsslfScQgl2FWE1B?=
 =?us-ascii?Q?qsBEE9Wi4OzIfzHsB7z1dcmaDaN+EuilZ71Gw458mIwGRe+lkZIiVlFISfCl?=
 =?us-ascii?Q?FwZLdj6ki3k9aF7m4tGyU19BjGa7ht1MvYy8PGjKm0giI/09zkJWbd3p6hZd?=
 =?us-ascii?Q?LYS5ljOQuNXg8TiPBSak3rQSNhXZXPvD6Tbr9Y+7yr2hb7koYSA1DqHPDw?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LZz99LWzvZL/N2eqxQ/QfbF/RyJhWXeH+j2sbb2TJiMYe3S19pCbpse3vQDC?=
 =?us-ascii?Q?gpvsxSTeqznEV6FW/iz4jZeEd2PhoDSirWjJQ7088xUstuedOqF2BwOfut3B?=
 =?us-ascii?Q?BHRRtOf5ovkXB2IHPw6sid0X2q3O0iKnyEVW6f1M1bWp9mT6eN2Ky5sGtVjI?=
 =?us-ascii?Q?eNxror5C8WYiSMqDEyHlwcvI6ozx+ucMak8riKRI2GdcqbFU1gB300nO5V2/?=
 =?us-ascii?Q?rmKm4dLB3MzdqiBAODy6ZXJ+rPw4FwuWZY/MONFO5DUNCQFgsG8XYaCYuy2u?=
 =?us-ascii?Q?7yLuNYpf1SiGUh+5hvh6HWWNJf1v4vb9lzt94TcgJAfm4wRCnSMJRTNTYS+b?=
 =?us-ascii?Q?+IFF3wAPMzpB9q994jg1EKOLZwXII0CX7yoVLrA5sTPzNLsFXciF0DnvyfR2?=
 =?us-ascii?Q?mdul0/gF5Smg67lenGfWDf/wQ9NPVBH/Onxod6xZq/jVIcSPkmh4+1QLBbah?=
 =?us-ascii?Q?8jYhXx7x2N/FqLwLQsr9AlEz9M/81ofUqo0jUOkSwoJMcLU5DTVhN2VxZU5a?=
 =?us-ascii?Q?EArBkXLhrsIjAhju9Sk/Co9teWBlx+HAaQY4JEORDmrbl0+kmLlkqQaBmzcY?=
 =?us-ascii?Q?2+ugqjvifPE0rsq9zPyUPdqAXfj5puQsIqTuOl4Ge4c3SnB9HPCu+3AdWtRt?=
 =?us-ascii?Q?HwS0vB3gFrGsIRjPc5KswLhDJ+VAaps/Qa3s1dGxmM75YCWGgJdvuwWw+86O?=
 =?us-ascii?Q?s1VSrPSk+HtDdzmgfqnaf5Oi79cbXT8WHiqpSw62kKJ/vZjbMRloMY7qttxl?=
 =?us-ascii?Q?mbBkgH2wIoGZZVIjAxx+Ti0xAb9KWfyMTS78SKr3Gi1xq27GVMWoo5frTyLJ?=
 =?us-ascii?Q?C1m82/L0Urxblf823dSJJZVMuIcND+6okIj5q3cZz541kMahwg1aQRIeRScE?=
 =?us-ascii?Q?ezYCflbIMLd6w55KgBUx3IRAjsA+343SeRxg+mety1PD194a7xTvIDJnmINh?=
 =?us-ascii?Q?kpD7kP4PNnaPbcHalBAz6AWsvXumJ8V/iUToeyhpH1bwdQpvLMDiI7t4Xm2z?=
 =?us-ascii?Q?35zso3rHWkXxNIY/00OWX8T8/q+MJitckqQBsU9JGAw0LNMU2dqIcYrgT9cc?=
 =?us-ascii?Q?nuzYvq1oiu1I7SoWKYlyA9Tf0WtYpvP02heYqMwQ4VmQu/Q7SryBwBxz5ECZ?=
 =?us-ascii?Q?s4+cU1kAdT4kEMt9OtJfug25qCodBe/PfHxbfW+ImuQmXxi/gh7q0IJzQLBS?=
 =?us-ascii?Q?ummFQ7ALXU8qW9vGMWNkq252dgPgLJlxqgwf+qlMUAil4mJLdcZ8nPomDRZ5?=
 =?us-ascii?Q?PfX6DIRwdHW1XeP7UZ3r7urMF8J4vfJlsGBvCgTuxmmfdDnvrkgRrn4ZGFQA?=
 =?us-ascii?Q?+FaeBVaZ1dQZOtIhkOrnNbGwgfmpeI3qLSWhYT17JvQfYUJhktsx/zdZDcHO?=
 =?us-ascii?Q?P6edGLquaTW2gJTUjIZmx+k6DJYGwd6/OsEQcccG+gKj2Rgrm2Xq+52A2JLp?=
 =?us-ascii?Q?JuospcaR2t4MDRg1+6uYYFV1Ptludsdo1ApfjgK0yI7uJR/TNVM/sgmS5ABx?=
 =?us-ascii?Q?T4UZ3lsWbslFd5zJqDhYae0/yNe2tlwOgy/JaZj8v/5g7PzBWQS+dVG0caFl?=
 =?us-ascii?Q?CJYvJpmLsiHGs57oa3yrr+6lFZUXpeSBHJsJHEiY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92673248-67a5-4fdc-e869-08de28cefa1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2025 07:24:15.7473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S++7zzImCOlgleIgrRTbh3UBWx+sLC7LBA1b5I0pkqlxaE2QOFgXrJKjWRxhH4aJXL3WF01U4750Wj++xVhkEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6822
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, November 21, 2025 3:46 AM
>=20
> This old style API is only used by drivers/gpu/drm/msm,
> drivers/remoteproc/omap_remoteproc.c, and
> drivers/remoteproc/qcom_q6v5_adsp.c none are used on x86 HW.
>=20
> Remove the dead code to discourage new users.
>=20
> Also remove the domain =3D=3D NULL print because it was intended to prote=
ct
> against a NULL deref inside report_iommu_fault() which is no longer
> possible.
>=20
> Just always print the fault in the same format if it could get a dev_data=
.
> There is no value to be gained by also printing if the domain is NULL. In
> today's kernel when the dev_data is populated the domain will be made
> !NULL very quickly during iommu device probing.
>=20
> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

