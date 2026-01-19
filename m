Return-Path: <linux-rdma+bounces-15688-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 216ACD3A0A7
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jan 2026 08:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C079A305437B
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jan 2026 07:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E971337B8C;
	Mon, 19 Jan 2026 07:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NvK376Lq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D065D296BA8;
	Mon, 19 Jan 2026 07:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768809065; cv=fail; b=VhXQFan4duPBmOLvy3G2+RL/5y+/qJPXQawhLIYsuTfscMcafItutUUevs82TPKbp7rPXHIFxP9X1wzDkXlqrXcusN4jHDxPKo3oJN6+jACU9IzAAWDHNgjy3n6NcSLaLCA4jI63omaI2NTDFQa6azVmsn5ugO45M7z9BXOIRMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768809065; c=relaxed/simple;
	bh=/c+baDufZgmiuuAAksjecqc/jXOOSL34Hpo/TWNVnTk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X5z7KDmKVhm8dVCLNRVzUPaFz5CTRyI1HvabNXAItqUjIB6tMEiy5Qlzwgtv80f7jKbDLQPry8VT9e2kpIBbYNBvYvnIQzE7MovBlaos71oc7cEGs0yJPg8khT8wmQyYX5dur9y6tKTqnga5vXKsFdzuVe73pIjCD91HIcEmGNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NvK376Lq; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768809064; x=1800345064;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/c+baDufZgmiuuAAksjecqc/jXOOSL34Hpo/TWNVnTk=;
  b=NvK376Lq3C1eREkO2DGT40dH6kLz+3B1D3BIKix6wk0P+diTmSgGqC2s
   ENnYMCjESRhVZKEbqgAssGmuJNxO+0ciugHG0XyTmFUtwbhQj6ZiOLanX
   ZE3oqWITR6qQezkV8Kt1Daauh3AAif2Tul0vzwd3h4Aq7tD8ww17aajMA
   zZHG299h8qrnYjSvw1vtMaJ93LHwxcgxCJujUlM/6K7oaa4Vjjb0xriDs
   oLg901MnLu12Wmqm+zs6PS42Ul0XKbUc18noMpbTjF3Rd/R172I+Q1dMW
   zUjJEwHw0ZuYtQb/e7oyxCBr4cnRz82tjsCzBFpQXs2PEfWOArJ2Lr664
   Q==;
X-CSE-ConnectionGUID: 9h3OVngFSDaXMzWUc/n7ew==
X-CSE-MsgGUID: MAX1tf/wSqq2qJ6VHUzN4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="69917108"
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="69917108"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 23:51:03 -0800
X-CSE-ConnectionGUID: V42s4HIfTMOofokaW5iZwQ==
X-CSE-MsgGUID: 1UiXNpYOQ9Ck2+1ix5qJyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="243368633"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 23:51:02 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sun, 18 Jan 2026 23:51:02 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Sun, 18 Jan 2026 23:51:02 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.42) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sun, 18 Jan 2026 23:51:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SBA1Oxu/8fKyXtezlZzas9zkQq7w3wNH4haOhv8yefmB+Tcjd417tKdfG3KOQgCmw76bgoWjTHjF/9SJ+5oNF0RofB296dTJpl+RWFmBOdxj4aTd4lYs7T984zPd+FgmrVPRndaoAaCVE4l2p1UXxYif4lxOkHEsNx0DQ2Q34B2Ep1oF/wVrs87tWh+wZ6o9Puig0ZfvezTh3T8c0/SiLDSAwp9dHOjnPS4SkUbOXQcttJspj4OfIDhUXQOEFQHwWrFBhb+Z5Gh9y6eOFS0oKmSndq/G9A3C0jVNscQJseahVi0A74m4EuhAsDqsE/5f9gljGoE8kn8KKbBDcfaELA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbmrddQetUtWgRFr0sMCBg+7gEJlwZqdmB4JdjucJ6M=;
 b=Ns93Mawha+N1JUNjCYOzFzvF4NmPSk0kj+8ivCUVVQNmozlvygpqzF1n8z6qPDiY6XQj9mpX6L6QiDpVhU7FTV6/QMERmLWH65U70nNsSLwYZghijDvnInjk6J5wNcB0XYS/RN67KWtoLqCWO+paKwbyIr4wwr5VFuaBFkES6oAiw8t1xX8f4dl9HVcfdB8oblyCdPMpi90hO54NBD3CLx9nbmBcRHRfHVMp2WJ+u/Ka/vtsmzlg3l/b6l2JeoH519HvCjC7ymC85glsVmlP/ZtChG4o6Bu/akamcLX1u/CLOz6QRZLBJ5lmfAIrB/7Ak6X6lkZEYi1F92j3f1czzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SJ0PR11MB4813.namprd11.prod.outlook.com (2603:10b6:a03:2df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.9; Mon, 19 Jan
 2026 07:50:59 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9520.010; Mon, 19 Jan 2026
 07:50:59 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Vecera, Ivan" <ivecera@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Eric Dumazet <edumazet@google.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, Rob Herring <robh@kernel.org>, Leon Romanovsky
	<leon@kernel.org>, "Lobakin, Aleksander" <aleksander.lobakin@intel.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Conor Dooley <conor+dt@kernel.org>, Jiri Pirko
	<jiri@resnulli.us>, Richard Cochran <richardcochran@gmail.com>, "Saravana
 Kannan" <saravanak@kernel.org>, Prathosh Satish
	<Prathosh.Satish@microchip.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Mark Bloch <mbloch@nvidia.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Jonathan Lemon <jonathan.lemon@gmail.com>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "David S.
 Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH net-next v2 09/12] dpll: Prevent
 duplicate registrations
Thread-Topic: [Intel-wired-lan] [PATCH net-next v2 09/12] dpll: Prevent
 duplicate registrations
Thread-Index: AQHchximVfPv+C59ZEKQnvD4fxixy7VZIm4g
Date: Mon, 19 Jan 2026 07:50:59 +0000
Message-ID: <IA3PR11MB89864715B359F91E993BE0C6E588A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260116184610.147591-1-ivecera@redhat.com>
 <20260116184610.147591-10-ivecera@redhat.com>
In-Reply-To: <20260116184610.147591-10-ivecera@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SJ0PR11MB4813:EE_
x-ms-office365-filtering-correlation-id: 5ea52890-563f-4e5b-4095-08de572f7c49
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?W35DJHg3RcYvNbT0Kv+jN7+jaIA3d9RdIvIrvFXWezuezEjrfsEI8165WH1f?=
 =?us-ascii?Q?IeW1w5d38jtJvOxp2CM8ZGRFrqACpgQNcfi4gxZvGN4MCxe4sp7CxSFZhY7P?=
 =?us-ascii?Q?mgjUYLQKbrIvPF1GpnBKYkzk91F/H9MFVpcmUJMPJ+huDszoeeKJFBOGF9qK?=
 =?us-ascii?Q?mZPKrIezlhjNiE99ASMeMOrHrTIednpKV6ldMYOWdXbBjTBPL7GnfNygKc6g?=
 =?us-ascii?Q?p2jbcN0glD0sL+KOSxHJRyy3/1X3+h7vlw897CN9OeOM6Iijk4QnbE6Cfz5l?=
 =?us-ascii?Q?3IoNT7qcQx+ZfgzpukXRuz9N1tnsSqItX/4Vc9RelTe2sQr1ffwmkQpRK+H0?=
 =?us-ascii?Q?YpSCZebFdXeey+Cd7jjZxwxeuRIEbgO2Z0PK2q7UuLRdVe+8NOVRj0AdwqMk?=
 =?us-ascii?Q?P6cVHCAmLetWURgQ2sCNzSZ5cjFba/gPd2eJv8SblbKNBJNhnLEJyI7uuuYc?=
 =?us-ascii?Q?7xCIJyC+ewD5e3whHeEmmEMwhXytItjoFzTA+CU8o0IElHt8ytDYRb55o55H?=
 =?us-ascii?Q?UiyMmj3WzoaAQ76G9ioWoJ0cfAKZAyx/ErtqyybHstDbzwmuqQ+NfFScpCx7?=
 =?us-ascii?Q?E4kpehV2DwM1jj/2G5ATds3/gAZy4oCIW3nNBL7FJLzRPSz09ltsTmQWXisn?=
 =?us-ascii?Q?HD7+DkZLnK85Y+ioJr4IaHFB7Wza6WVrDsE7wmZnl4+AIBzFJ2J5Kbb5wbO3?=
 =?us-ascii?Q?LKsfDiHfc8fPsf096Okj6XtbHccXt5NFi/VzsWCRd5WgsHZaCrX/WMQlRRYV?=
 =?us-ascii?Q?2Y9Jj5bk1PYNj10xtkTr4hbX4/7bRMY0E7pjfdP1Jqz9N7rRzPu49Lfu/qSD?=
 =?us-ascii?Q?479cXeQywWfkqy1GmQO7wum4TuX1UWW3gehTjM6D54kroFV38n5deH5WgrCu?=
 =?us-ascii?Q?b6DLUrI7aRALvda5i3o69bmO44KEGap7fh3fYQkG4g7VAOMTYHoraa0ipCcZ?=
 =?us-ascii?Q?jNwa99d/hUO5noQP3zi2fuhNirGwz0uALatOBg2P2Wk1tdSa/lMY1UA2JB/D?=
 =?us-ascii?Q?rniq6fTz6CyGrf2CfTAh+31iCpFCOvXnBmgnQ1FFG3I9G0ELe56z+yq6yLvw?=
 =?us-ascii?Q?snlE4LzzqkgjAyTesUMfGlYoxtl/BWW3QD7W3qEdmIx6fREABruA1FaxnnND?=
 =?us-ascii?Q?U86H+W4awkz8l7PCMYjlewUcbV9VlrbMTVanWpCJE7D1N6T3B7KGZuHnPiNu?=
 =?us-ascii?Q?qfxd+gHlwlIHwqr9V3W8BqgTeYeniSL/I5JE4BR5V1RhSvvRNMKW1M3Eolaz?=
 =?us-ascii?Q?fnMsmv5h/mIaP4hDjXvEZxnOotQ+CKDs3npjNEpmOqEIjv7Dcl644bsozYxk?=
 =?us-ascii?Q?pEh5i5gpV+xQ6zezbBaAIO7pWmIGsaEmIEpcb7FiYtEU55svvxSIDqCyZ19/?=
 =?us-ascii?Q?hI4Xf3yvSiZTy0uRbuBHSeR7bwL2TL2kjuL8H9BfZd2094dC9MhbhUInYIWa?=
 =?us-ascii?Q?VbxiMuhjOgdliHGLzZlKURmhRRjs9Pqu8+m9BW64d3QhHg6RYv+F/tS2mAbI?=
 =?us-ascii?Q?CECCCGbgSRsYs/1RNGBUQhZ7Rs3nAKWhvgX/BozQUqnpNNpOUp27fPGA9vdP?=
 =?us-ascii?Q?sKkliBPAYhrSa96pnb7P3rLD52G4rggdSv4IMWjm9ATVOQ3LOSC4k/g/EBUt?=
 =?us-ascii?Q?JYusfCKDp3IkWdQXotyo9WI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iIXY6kmcf1PiCCGaCN7w31BIrlE0/kwP/BudPOZ9W2zOHg+bXnc4ym6WntmW?=
 =?us-ascii?Q?OO+SGpIrD4192aCQSE+A97M6Gipc+ciq9Tiw9odr6bBOzbPGdkxutTZjRNk6?=
 =?us-ascii?Q?ohvh96RDnaeNVsxZWQV8iRM1wbmwqW85GaoTHaKA5oqIkYNBu5fIEEuUnXIG?=
 =?us-ascii?Q?STf92VSFhAFhZp7TFSY5PKcKwY72Brs5YGTS0V6bFkImu+8j9lw8hwvVZ+b5?=
 =?us-ascii?Q?8IfUudumV7/KnMatPGeEjWJWDY7YRiGcQWL+/bB0B/Edw63ij5EI0fZDCLbf?=
 =?us-ascii?Q?8oTT6o0YEKB8eTNHQ5JhBNYf7kj1Db9v6zD/pfNylfvFK0PcxMSKJ6KZrs1I?=
 =?us-ascii?Q?HSsmQ4MsPK+17yfTJqvkVZKMg+RBOXD2NjLs06Pr+FNVIAa9Wt4gBclfTF83?=
 =?us-ascii?Q?1KpJP7lmrcNWzKroZSXV4koS16m2gC/9TlbWRbHqXVox1eW0tRr4X8VarqaV?=
 =?us-ascii?Q?I9Ufg7GLJb2RPeDs8M2yyHdW5JsqzqPkOvFSAOdBCYSIw+u16cnIt4NpbaB0?=
 =?us-ascii?Q?REFQvGN0uYpOvxwCmTY9CaN87msOOvosZf41TwZPaGJnto9PfpgeMPVxj93E?=
 =?us-ascii?Q?h/CJV6S84HoVbfc8mFrdkbyV/DAL66dbOlbX4tS6Xt9PCsDj88bbCZThd/wk?=
 =?us-ascii?Q?guBJ2ZNi9JlrTc0Eh1QS9CCvV1ScmCen1Dk726NL2lfX/ffuWjsmDXmg+HD9?=
 =?us-ascii?Q?bYFrw3wKH2T3qX0tiJ1nUbM/qv0e+8B0bGjVag+APLlhqEOivJ4ruZ1EUz7V?=
 =?us-ascii?Q?okuC6L5YcpPyDQZAYtGwStHa64ghS90mNHTZfrg+/C1uP0nKJ8b3xvBiUama?=
 =?us-ascii?Q?4cocdiXprTnCBW9C2yzCyT6ujJORbUI3gome0olsUvxJQ/WzVC3QEJlPtxEu?=
 =?us-ascii?Q?rbG6mNes/R7Gby1M+8Xh3KHIF7qYn3XfrWH4fAHSqKY3nGsKytqvISfsBOIR?=
 =?us-ascii?Q?Qd0rdovkKiT5q2fO4uz9uSySil1n6VsIzbYIKmkwNIq+Uq0cVS290os4vS2Z?=
 =?us-ascii?Q?G8u0Yd8QeOFcSr9HvmA7EHt3obiuDqLtt0uqQLikNg/nNhZIUACcQc2OmKay?=
 =?us-ascii?Q?ImaEd2cWd23xrRATLNLXiidgZgA2fimpGr8f5DqUKO6QO17M+wZlrkw/WKBf?=
 =?us-ascii?Q?h2RNlCZE3XZXqWPvSBSvi58l5zNyWSEdnXvAkOPoVn/jvsYLquts22/8/x9w?=
 =?us-ascii?Q?dVNPtHzodprZ21x7D2XFU3Tvqw4CCfWhs1ScGysE8USnBpWqko32b5OFvHX+?=
 =?us-ascii?Q?+wCPCiG0fgNXcgHb3vS1TsKtYXOMvCxv2bzTb8HXhenI58XicZv0c4Psmudv?=
 =?us-ascii?Q?NZ8eB740YB3G3hZOfg8tdAUOijslfGi6Q2aUY/g9DCHGcmy03DjRuWVen0jg?=
 =?us-ascii?Q?YjtFv2+mKLYGsb0mrST3x4vyCmtoAYBppFGhJGOWPVs/0t6jW/4iw70b+ApZ?=
 =?us-ascii?Q?fXEpktwag3w+zcZfn4fh9DHcjuhg/SPWaA7BmZV0o3Z3kd3GNnVuhL0tn7UX?=
 =?us-ascii?Q?FBpq/ffccAYzk5bo4wtHS0vfe9ZqO2qq+kGpv7X8/U24A0Ql2MMAP1aS6R+h?=
 =?us-ascii?Q?tJkQODkIVxYDYP0VTCaFLMU323jlWhEF5HofrWa5otmFxwz0ZVEzZxc9APEW?=
 =?us-ascii?Q?dmY08WhV68LqHMtxznQsUd4J+dZqGpxEa2jNspeQyftR53BcwV0BaXYHt/CJ?=
 =?us-ascii?Q?sJMJld3m8t9ib8kkz92vP6+LlaYe2TXDb8yTSSXp7ZynOhwKy3RmdV+FzoBB?=
 =?us-ascii?Q?VZiMFtV/IEdpzX/HieBAysDnnFuC4Vk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea52890-563f-4e5b-4095-08de572f7c49
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2026 07:50:59.2832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pnz8Vfvd4QjS4LWQFx7LBWo8R2lMr66MDiHp2zFrZFaPffZOMDBgGL/O1HVDjGTN9y1RAf4R9wzMtNWLESrDnN5qHp9wUAJFRmaNsZT/+WQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4813
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Ivan Vecera
> Sent: Friday, January 16, 2026 7:46 PM
> To: netdev@vger.kernel.org
> Cc: Eric Dumazet <edumazet@google.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Rob Herring <robh@kernel.org>; Leon
> Romanovsky <leon@kernel.org>; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; linux-rdma@vger.kernel.org; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Kubalewski, Arkadiusz
> <arkadiusz.kubalewski@intel.com>; intel-wired-lan@lists.osuosl.org;
> Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
> devicetree@vger.kernel.org; Conor Dooley <conor+dt@kernel.org>; Jiri
> Pirko <jiri@resnulli.us>; Richard Cochran <richardcochran@gmail.com>;
> Saravana Kannan <saravanak@kernel.org>; Prathosh Satish
> <Prathosh.Satish@microchip.com>; Vadim Fedorenko
> <vadim.fedorenko@linux.dev>; Mark Bloch <mbloch@nvidia.com>; linux-
> kernel@vger.kernel.org; Tariq Toukan <tariqt@nvidia.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; Jonathan Lemon <jonathan.lemon@gmail.com>;
> Krzysztof Kozlowski <krzk+dt@kernel.org>; Saeed Mahameed
> <saeedm@nvidia.com>; David S. Miller <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH net-next v2 09/12] dpll: Prevent
> duplicate registrations
>=20
> Modify the internal registration helpers dpll_xa_ref_{dpll,pin}_add()
> to reject duplicate registration attempts.
>=20
> Previously, if a caller attempted to register the same pin multiple
> times (with the same ops, priv, and cookie) on the same device, the
> core silently increments the reference count and return success. This
> behavior is incorrect because if the caller makes these duplicate
> registrations then for the first one dpll_pin_registration is
> allocated and for others the associated dpll_pin_ref.refcount is
> incremented. During the first unregistration the associated
> dpll_pin_registration is freed and for others WARN is fired.
>=20
> Fix this by updating the logic to return `-EEXIST` if a matching
> registration is found to enforce a strict "register once" policy.
>=20
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  drivers/dpll/dpll_core.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c index
> f2a77eb1b9916..8616d6285c646 100644
> --- a/drivers/dpll/dpll_core.c
> +++ b/drivers/dpll/dpll_core.c
> @@ -161,10 +161,8 @@ dpll_xa_ref_pin_add(struct xarray *xa_pins,
> struct dpll_pin *pin,
>  		if (ref->pin !=3D pin)
>  			continue;
>  		reg =3D dpll_pin_registration_find(ref, ops, priv,
> cookie);
> -		if (reg) {
> -			refcount_inc(&ref->refcount);
> -			return 0;
> -		}
> +		if (reg)
> +			return -EEXIST;
>  		ref_exists =3D true;
>  		break;
>  	}
> @@ -244,10 +242,8 @@ dpll_xa_ref_dpll_add(struct xarray *xa_dplls,
> struct dpll_device *dpll,
>  		if (ref->dpll !=3D dpll)
>  			continue;
>  		reg =3D dpll_pin_registration_find(ref, ops, priv,
> cookie);
> -		if (reg) {
> -			refcount_inc(&ref->refcount);
> -			return 0;
> -		}
> +		if (reg)
> +			return -EEXIST;
>  		ref_exists =3D true;
>  		break;
>  	}
> --
> 2.52.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


