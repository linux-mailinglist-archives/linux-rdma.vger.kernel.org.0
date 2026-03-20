Return-Path: <linux-rdma+bounces-18434-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKw4KXv9vGn15AIAu9opvQ
	(envelope-from <linux-rdma+bounces-18434-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 08:55:39 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 662842D6DF2
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 08:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B677C300F1A2
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 07:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA39936166C;
	Fri, 20 Mar 2026 07:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lj3hNhGY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7626C3603C2;
	Fri, 20 Mar 2026 07:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773993331; cv=fail; b=LPPj8/Lrt+eVHDPmp99w4DPOq5yWBExTgP8QJtspIhjs8g3HKhRDDVAnbQRECb3QyTXNQWWkVOQyjBcWjih51A/BiNL57IE6gql6Ls2NR5Vj+2V/9m4QlkNNZWqoFPKPnrdDakxNetnTdJlbTmKOxCprcYl1i1SgC4g/TeNaEDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773993331; c=relaxed/simple;
	bh=OrGIOimVW7GXvFTRJeUgSE5RNlQv+eluFWMH3jc9Yi8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q1NnGddk929FUr07E9aDLQWC3hmlhPPnNA53sqm3aLyCnbs9a1qm5uUI9Spj2yd9EYEpCUCnBemTNvq9qi2R7V/bozVvORb6EbGQ89CDfSWmGP6PIdXDeEq9vJojOhOj2rldxOwDw5+nmMXpLJvlqb3cgGzlFavVW3VM8GDgIVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lj3hNhGY; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773993326; x=1805529326;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OrGIOimVW7GXvFTRJeUgSE5RNlQv+eluFWMH3jc9Yi8=;
  b=lj3hNhGYwQcas8mFZax9klC2Wt/l25eWOk/VkhPLtuq7CAvbbx4fngTZ
   Pmm7FY/+BAyv5PdW9Wy1EM5EE55W+s8jZi1l7EO6keAgzVkgAaTVt9B48
   gfAnlm/oRf94dAHOBBLaNy8W9WwZFoKJXFfOibEAfZHADqsy3DvKW6qev
   xTIB0zxEfTa0qjNph9+UZo1LUqmJ0uHcHYZxSRkLBEJmJJ29jbL3Wsksq
   fsfFfXWccsKXCBVHq+/2OmA1l0ldJ52V1vBQry4mYgOmw6c0khFbBPDOX
   yi02W6Tcib3POSNxOQsIjrWx8imzp0uiLJ3K1b4D0K3M+vy2YQC4OgUVr
   g==;
X-CSE-ConnectionGUID: 573vaflxR5qPr69hKgLtwA==
X-CSE-MsgGUID: j1VtLXvxQUiMk0diUw+AkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="92648931"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="92648931"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 00:55:24 -0700
X-CSE-ConnectionGUID: I+QFUtX8TnurMAs1oHPqug==
X-CSE-MsgGUID: H5sP1LaiSpeSCQoIc4byeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="222308746"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 00:55:24 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 00:55:22 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 20 Mar 2026 00:55:22 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.0) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 00:55:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N/XhzxkVCfkXFD7+JmkWptVOi7xaM745upgesu5wJS0hW4XzlqYhZWAMA/mf9Xgafrj6SNWBOMSc7j0eydKl7Bqs85u+09vNFUOU6VPOC7qPupeJ+ixRVuvtsjU6oWr1xWiGs3EoInS3HMeAJsTKbVFzXQ7nKXa7w/wvSk2EA/Z+Eq53fey7piNAgTJAz83zJBdYBeHDTDrW8ktSrMhzfyp3yrffGC72Ov8bcBJcbkXwGJ5/+TvXIaZdhRg8s27HvM+zbAHuVGPHuzSH6vrxqNUZptstZfIAkq9YmWjJmwhLsrboeqdGQFoo5QiEjG3V06CgJYS2aeV+5zIffzFD9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEZpGfNl+sAzWUfz2Boy6I0GjZK4Adin0PKLxSbQoPM=;
 b=d+PhgwoU2UInVDXx8cpVCduUHLkPR1lxmOZw3a+rqVDuqvwMXf70VLwK0vIonXmKMIrszQE4X+ZaqJIIsXJ6VCqCvtI1mk6AwaTMOziMT9/2dPx2mx1DAqARQ9eECKNnc5r/8lqUPTznLjG9OPuT9C0LCiueLWYScZlQhpnRiiRn87Z44ISUOSqvCKYW2xcEZx3t9tYf068orMgHtVg/ZIYBTMKdAAbUDMrn2940yN0EIyBc3JjL1JFeI7/H2qmGu8xWvC+FXurNcSF2hJGjZFm5+dR8Spc+OB8HC3UQ8tFDgjYnZSkRdwQVr7RlGM24H8TuXWGWmKsCOsrZrhJKKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CH3PR11MB7938.namprd11.prod.outlook.com (2603:10b6:610:12f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 07:55:13 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9723.006; Fri, 20 Mar 2026
 07:55:13 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Stanislav Fomichev <sdf@fomichev.me>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "michael.chan@broadcom.com"
	<michael.chan@broadcom.com>, "pavan.chebbi@broadcom.com"
	<pavan.chebbi@broadcom.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "saeedm@nvidia.com" <saeedm@nvidia.com>,
	"tariqt@nvidia.com" <tariqt@nvidia.com>, "mbloch@nvidia.com"
	<mbloch@nvidia.com>, "alexanderduyck@fb.com" <alexanderduyck@fb.com>,
	"kernel-team@meta.com" <kernel-team@meta.com>, "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>, "sd@queasysnail.net" <sd@queasysnail.net>,
	"jianbol@nvidia.com" <jianbol@nvidia.com>, "dtatulea@nvidia.com"
	<dtatulea@nvidia.com>, "mohsin.bashr@gmail.com" <mohsin.bashr@gmail.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>, "willemb@google.com"
	<willemb@google.com>, "skhawaja@google.com" <skhawaja@google.com>,
	"bestswngs@gmail.com" <bestswngs@gmail.com>, "kees@kernel.org"
	<kees@kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"leon@kernel.org" <leon@kernel.org>
Subject: RE: [PATCH net-next v3 12/13] net: warn ops-locked drivers still
 using ndo_set_rx_mode
Thread-Topic: [PATCH net-next v3 12/13] net: warn ops-locked drivers still
 using ndo_set_rx_mode
Thread-Index: AQHcuAhxLxV0+I1+hk+gEk6gdhgWJrW3DaGg
Date: Fri, 20 Mar 2026 07:55:13 +0000
Message-ID: <IA3PR11MB8986C8428A12288BDB1CBD3DE54CA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260320012501.2033548-1-sdf@fomichev.me>
 <20260320012501.2033548-13-sdf@fomichev.me>
In-Reply-To: <20260320012501.2033548-13-sdf@fomichev.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CH3PR11MB7938:EE_
x-ms-office365-filtering-correlation-id: b3bb27e0-026e-41cf-ea78-08de8656048d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info: EHaKwHKOT1FRn0OCYN1mBVOCxeRCmlLU+aiiAArX5759zK1G3UuvTJvmszvhIytutfqAL3u3LNAUUTdi1tnYBNFS5EiiqQjdobqNBRJKxJd0vygRjL9TE/OFQjw+jWrnIAH7kNbLPwT7xZnLY+44NLK8EUpM490gBdy4J8MID5oVZLf4ALTjMXhSU311Y3pNRCbZLthKs1J3eApM+KbgE27+IbktHoYImoZXfij/11KgfLgpKtdZ1wuzz9JPFTVoviiOqMaRojVfST790wY1MV0lIRcb9odf1UstYqfDialNFcqyZc71oPNDZ5i8p9fL5SV4R40vRcpfkb+qL7VtdIGM7E4dBG+yIhzLqQ1Jt9Ozd+niv+fvpXIHGmClKrfVabhtQ1JtXYO488/rhLJg6HejLiD39+57g/WJ5vhGXx2w0YAnz1or3nOnHvQcBLiyuPcMnZMoygfhyc/JqCP1yRs/pkrUOBFUHyPeFNSrzrn9Py70g4mjDsv1JtJ5t6EKDtKHazBiAFTudyeraqsTcH0XXtxIMhqOtSstDPrvN9YhgxsQ5nuulnDETs9UVLmLl4KA6/LUnAdNVTcQW6z3s0K5e9G7Yjusf8uWqiVJpG4NbmD4Z6LnFEkoiNiAFUXhFb19/Hf1rebZ88mbJ58LgZX9CTdJW7z9QRAmE3xspAR1xttCAwteE9Ay8SSjNmsI+gPXMAnNs1xYs+ZD9PMrrFM7skabrqOcaOIQfTarUfrOPf3BsW2MDfN8Hh5/0BtjH+BirqeDVc15JBZXapw7svFESrjHnn/lno1LSQEEBBo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007)(22082099003)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?djeMXjqSGyiTv1HC3j6HnopNhJzPaOPayb0M8Mqfq/xP3Y2VgBq28NTeMOp2?=
 =?us-ascii?Q?BU6h1BdYTZaElBMoxnlv+dEZ67njnMZDFKfKE48Yej7GPgFXfoTNMoqjBYlV?=
 =?us-ascii?Q?4OYwfVpXFkNOvJxQ0CXRkeQKdaoPL10sBcFLONabsc7C6y5+qbr8Ak6XitWe?=
 =?us-ascii?Q?JiLTthHJZdIQtpMV96WApDy9O6xSN2kTh3ICIFE3VVgMappwXCpXVqMzxtLM?=
 =?us-ascii?Q?4DkPHO41/Pe1OBBGqh+Hc1j2UElHKD8HJA83FKqFzHktJQjBsRAGxk42oNKn?=
 =?us-ascii?Q?swqJPE8EppEMQUzynfTLN8S0UvnKprEfRmR5BKYK1GfQuk5Q2AH0VPuT9k4Z?=
 =?us-ascii?Q?LRw2M30/druphRctePSSxpjPTrvoCX/zRLkBLp/z80F+Lvl2P94cZ5o6lLEr?=
 =?us-ascii?Q?j6eqtLSWDqaywYLTtwXeO4OuY097Lr3Wjup8YO/t2R6ymnxTKbTM2ulvpK2e?=
 =?us-ascii?Q?PjsjP1dbYMJDZEFCKpdoWSw25jGJDxC02pBHbnHAvyLMCOCp0jbST3267yF1?=
 =?us-ascii?Q?iPk82ItQnS3UfkkTxkPBhuU8JC8uZKZ7Op14jbGx30K6kx9oxqXDtk8vt5f0?=
 =?us-ascii?Q?yyhY6BMHkhm4HfBJI5uuFZi4oxp74Uw6mdl1KHuapndBRh1LJ8bs7v5PZn03?=
 =?us-ascii?Q?QCQNCBY8eF/vl+LcuGvcsli08eofZrApOy1QBbp+OQm4dsbfyS6Za9PNHRza?=
 =?us-ascii?Q?GpXRp1ksZoXkH36oTnY6HC6Xx8xEbg5V0LttSTYLwqNd6uhvV00aL84cXLWg?=
 =?us-ascii?Q?wqcc5V6laxm+EyTytiqRIdD019WCEfkakPwNUkvNUbjBCQu5x0OnTMWmwK8O?=
 =?us-ascii?Q?NuEfG80+SElEY3bgS3MgO7hND49poAmoy4TXaRUcjE+1zirmtvy6LDCBnNjS?=
 =?us-ascii?Q?sM0i/Z+w4d7MIS+fddTdJheSbJ4K88drkEqWqUBw5dZFMRP+jkhHIL4NIfEm?=
 =?us-ascii?Q?7JddhBLDKwIiQ5H/mgwVpD1IiumH1Zltu7G3nkMGzdhfjM2gj6NctJFSU+AQ?=
 =?us-ascii?Q?UVXfdxm+knOOeOnJQh6lIRTq6Qg4ltuv9KYLVSRQqLzSDNMssnNdaKynnj2O?=
 =?us-ascii?Q?n+7ztZ5bZHo47nqXlxx3xetUp7MFgKx8tUekvU+MvbBrVA5zL339yGjsZHG4?=
 =?us-ascii?Q?QMvoMjTdp/+ullGxF5oxJvLOhzScrJRi1LKbRktqjOli2Lz5wvtdlQkVlDGw?=
 =?us-ascii?Q?XRh+H9JI4wUmeutjFa4R4WYAUdAhyf9KWRC46/m7obdrd0fF5pJBbPKKILjT?=
 =?us-ascii?Q?yn5ZrU+WpEPufuvWETMm5RDE+3A+zE0et6y1LF48NTlXBUfmgxlGi0AKFUml?=
 =?us-ascii?Q?r2kiyCZMlnibTRU4a7/OKJlf5owdhneq0oPGCkOsNuX+UkVzoyJZeN/d/uDA?=
 =?us-ascii?Q?TMkso4sKobEgs77r7hiaimEL7dxpQq6nzPXGac0ZCe9c4qD2/SEZPu5rujI3?=
 =?us-ascii?Q?+8I9IUQtJf8MvpRFME7KAOjUNrkFuLMxG/WW4/ussS3LjGebiVH996AyJmML?=
 =?us-ascii?Q?BseyUvDN1XPoGKxvdbseKo1Oz+uHtwcewUFU6JCvRPntisQdm/lqZMaDAVft?=
 =?us-ascii?Q?5x4SJ8Vhr7kaeBnVG60I/RIRstb9++yqb1fn2tgItzjRNEBo/adV0Afp8BIL?=
 =?us-ascii?Q?VoKHxp9YC/peFVrWtTbiQDtSysgc8z3KVlfZ/zU3JRsEr6CAL2IfgHMdQMi/?=
 =?us-ascii?Q?49cSgfKjMBZgq6n3+zrfMhyZrdnqtsoDYb5MiWCDVUUJilCbmEzYg8o8UPgs?=
 =?us-ascii?Q?JgrHLKquCMPoUIeGQFp+lvLqL7jxg1g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lH/FEMT0osjQAyaOU85yvhrC8T8faHIJacfgIufrKgfzCM4TznYRHhcmrJnjLoobW2k2zJonWXNpCaSplUyrpwyGxFyXd9yh9SkogBiDJD8JREBYuRjBzKhIXIbGHyKGkQMANUmWxfwRba3aSxu0Rru/aV5wLs7W0BQZtdAua2ujYjv905XYfLYhcKYgegFdNAhZqOoCw5Vo1193hTMoH8F9cOVsWxb1WMzijQ9WQWkL4pn3AVxG0FPGdGbrD2jcPcaqMJh70wKdLuRF9gC5/ebyvDzKIrbPoYVxHYoJ+RzMbRLaalehz2a0jvAzO93CUW4ajA1zxxTi3NoIHhkv+g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3bb27e0-026e-41cf-ea78-08de8656048d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 07:55:13.4716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +34IpHdGtrKYDoBLlwKTt8vs8VrCRn5fIAM9QFxXY7i42r7yTW4ExnhaSLrhCD2L4KLG9V69FSFQgvffiBg1re+Gz2YW+0d8l8u64NIz0CU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7938
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[36];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18434-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,gmail.com,vger.kernel.org,lists.osuosl.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.951];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 662842D6DF2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Stanislav Fomichev <sdf@fomichev.me>
> Sent: Friday, March 20, 2026 2:25 AM
> To: netdev@vger.kernel.org
> Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; horms@kernel.org; corbet@lwn.net;
> skhan@linuxfoundation.org; andrew+netdev@lunn.ch;
> michael.chan@broadcom.com; pavan.chebbi@broadcom.com; Nguyen, Anthony
> L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; saeedm@nvidia.com; tariqt@nvidia.com;
> mbloch@nvidia.com; alexanderduyck@fb.com; kernel-team@meta.com;
> johannes@sipsolutions.net; sd@queasysnail.net; jianbol@nvidia.com;
> dtatulea@nvidia.com; sdf@fomichev.me; mohsin.bashr@gmail.com; Keller,
> Jacob E <jacob.e.keller@intel.com>; willemb@google.com;
> skhawaja@google.com; bestswngs@gmail.com; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; kees@kernel.org; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org; intel-wired-
> lan@lists.osuosl.org; linux-rdma@vger.kernel.org; linux-
> wireless@vger.kernel.org; linux-kselftest@vger.kernel.org;
> leon@kernel.org
> Subject: [PATCH net-next v3 12/13] net: warn ops-locked drivers still
> using ndo_set_rx_mode
>=20
> Now that all in-tree ops-locked drivers have been converted to
> ndo_set_rx_mode_async, add a warning in register_netdevice to catch
> any remaining or newly added drivers that use ndo_set_rx_mode with ops
> locking. This ensures future driver authors are guided toward the
> async path.
>=20
> Also route ops-locked devices through dev_rx_mode_work even if they
> lack rx_mode NDOs, to ensure netdev_ops_assert_locked() does not fire
> on the legacy path where only RTNL is held.
>=20
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  net/core/dev.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/core/dev.c b/net/core/dev.c index
> fc5c9b14faa0..f38ab254708b 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -9779,7 +9779,8 @@ void __dev_set_rx_mode(struct net_device *dev)
>  	if (!netif_up_and_present(dev))
>  		return;
>=20
> -	if (ops->ndo_set_rx_mode_async || ops->ndo_change_rx_flags) {
> +	if (ops->ndo_set_rx_mode_async || ops->ndo_change_rx_flags ||
> +	    netdev_need_ops_lock(dev)) {
>  		queue_work(rx_mode_wq, &dev->rx_mode_work);
>  		return;
>  	}
> @@ -11471,6 +11472,11 @@ int register_netdevice(struct net_device
> *dev)
>  		goto err_uninit;
>  	}
>=20
> +	if (netdev_need_ops_lock(dev) &&
> +	    dev->netdev_ops->ndo_set_rx_mode &&
> +	    !dev->netdev_ops->ndo_set_rx_mode_async)
> +		netdev_WARN(dev, "ops-locked drivers should use
> +ndo_set_rx_mode_async\n");
> +
>  	ret =3D netdev_do_alloc_pcpu_stats(dev);
>  	if (ret)
>  		goto err_uninit;
> --
> 2.53.0


Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


