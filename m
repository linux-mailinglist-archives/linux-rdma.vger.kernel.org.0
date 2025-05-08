Return-Path: <linux-rdma+bounces-10173-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CBDAB0673
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 01:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B22344A7651
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 23:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C83C228CAD;
	Thu,  8 May 2025 23:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l2NqBFmy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA7D72612;
	Thu,  8 May 2025 23:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746746428; cv=fail; b=Wgxq504FfBjI69+p7tBdOLW42Zm4ijls0Nw2PTQWJEifVQ6Kvp+J4eh56q0laU7OCdOnF46u4Vh6EouYEuC2972oU/9IXPDdEyrInAIGsME4cPOlUwEOP/yUoJ24hQ0dw56Kk/N20hv84dhDRQEFV8zg62CNC1yvJ3hckzjorNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746746428; c=relaxed/simple;
	bh=yugK5HnAsVmXz+I3vKm0ad6omorbVtZbJOrsbz9BIRQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sar5GYvLMxn2JB1je6N0Q/d5HyHAOKqIgOJq6i9kocb1uUz7bS1jyQUKFHXU7zktgmYskSzQNEEg67csaUAvJR9+R3SBo6JCzSYQ2aXJm3d0DUPIao8YT+fjYBZvz01xEFDrb9ONlF7rjCkwmpIbEr7mJR6TRSmnOXYRJStA1oI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l2NqBFmy; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746746426; x=1778282426;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yugK5HnAsVmXz+I3vKm0ad6omorbVtZbJOrsbz9BIRQ=;
  b=l2NqBFmySJGZeNjTHtWidecY20WYqwvaXVHoMbAqNqj5mR8lePvZU/VO
   IYNTtqIxOaDVRqNOUOA22XqNzB5LaZ7ruS1gEamrKVmfCNX2XlszVZlF9
   JDL7UsumRlpxYTCjMmTTHu68gDSsB/gx7XXr3rhY969XcEvg/SL2szyil
   ltFyaN3bRK8J9gzsuWH7ti+Dd3YNrkPjeLVCOsUH+XuISJajjWKY8VazK
   CPXKAd3xB328cqHzrjX6dGknme3dOgdnnt5+A9ZTT59pLqSdwqpok0pgr
   oolS1eyFS/+HR4kAroGd8ipMrmPb7zW67PCrCiAETaAEFNrzNGjGBiAG4
   w==;
X-CSE-ConnectionGUID: PiiztDOsTjauLmSSNkqCFA==
X-CSE-MsgGUID: 9hVcZqlqRMuxPxL27KCvqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="47814628"
X-IronPort-AV: E=Sophos;i="6.15,273,1739865600"; 
   d="scan'208";a="47814628"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 16:20:25 -0700
X-CSE-ConnectionGUID: Ykm+hVjvRdqn3uZFGgQF2g==
X-CSE-MsgGUID: 8bAx4JlVTs+ynLz5AlM1xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,273,1739865600"; 
   d="scan'208";a="136827952"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 16:20:25 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 16:20:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 8 May 2025 16:20:24 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 8 May 2025 16:20:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QIz3VHhkacWBD8V5o1m9NP2Ddd14vEsWm7XhSi/0LeD4Pz4mqKOG1dOVqzwQI2puG7R/Gb45iMhsSH56O6X7qg92lDJA7EW64JQkvpf/FRwepE5OSsjpVaitpnkMFrHktP03RyHe+yXDqY1/1vZSKEkQCPTHNESRbaXPDQN76z+5P1+3/EU0zn8aBiW1RQQ5WijyF5IbtvgkJJrp6JC3yMY5JUB5fNUsu/RPA5dlhs9WtDA6uCYFvpwRnlPUPb0s+wyCC97nir/ZVstlMESZcxSwQ5XCdlCeR7PKH649AR5B7rduI8wkgSZrwrkdpezWDMz3qBY0o5TTHZ2p22HwDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qI1zexCszhh1xLr0OxmVsOTG0lxKPL2rqBXH1WYSEoA=;
 b=gectbEn/eDjmhGUyWKD9qZqF1exRZeXC4UETEYewvwvNUc238cxtHCR3BDun5eAbn8IASEfA08r5AjsENvyTBfD3hOPgP9I+wZ3D9pq3xjXdL4aWmBo0PNKrg/BvgdX71FkdCEjUj7gevIK5RQUtUeuRgucPQEKg2dGESRBPhIBUoWucCP4K94C2csgIrxIOP2F/+caPS9+Vr4pHN5sHRjINoAYm584qCNYGPX2bIdftMv+2trnB3V17h07v/gx08CPa+JWSJ+Jv86/P/ck7TTbF6XeU3fXr98f0gRaizWsYSmTpEzwyC1dTzen8sujkaSh8rYeNtVqUIrHiKOXg0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6194.namprd11.prod.outlook.com (2603:10b6:208:3ea::22)
 by CH3PR11MB8315.namprd11.prod.outlook.com (2603:10b6:610:17e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Thu, 8 May
 2025 23:20:16 +0000
Received: from IA1PR11MB6194.namprd11.prod.outlook.com
 ([fe80::4fd6:580b:40b9:bd73]) by IA1PR11MB6194.namprd11.prod.outlook.com
 ([fe80::4fd6:580b:40b9:bd73%5]) with mapi id 15.20.8699.026; Thu, 8 May 2025
 23:20:16 +0000
From: "Ertman, David M" <david.m.ertman@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "edumazet@google.com" <edumazet@google.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nikolova, Tatyana E"
	<tatyana.e.nikolova@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [PATCH net-next,rdma-next 5/5] iidc/ice/irdma: Update IDC to
 support multiple consumers
Thread-Topic: [PATCH net-next,rdma-next 5/5] iidc/ice/irdma: Update IDC to
 support multiple consumers
Thread-Index: AQHbvgOdl8B3PHw3WUG0AIuOchNc77PICdUAgAFZRBA=
Date: Thu, 8 May 2025 23:20:15 +0000
Message-ID: <IA1PR11MB6194441ABE4D066DC8E0A4E4DD8BA@IA1PR11MB6194.namprd11.prod.outlook.com>
References: <20250505212037.2092288-1-anthony.l.nguyen@intel.com>
	<20250505212037.2092288-6-anthony.l.nguyen@intel.com>
 <20250507194308.26d31e9a@kernel.org>
In-Reply-To: <20250507194308.26d31e9a@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6194:EE_|CH3PR11MB8315:EE_
x-ms-office365-filtering-correlation-id: 719acf58-f0fb-438b-229c-08dd8e86e426
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?9eoVafRR2g87jvIg0/CyRbC+Mr+ROpx0Cryf2tzU6nRSjVYiFwJ3+Ur8A8Fr?=
 =?us-ascii?Q?TRtLlHBjUMXzOMNaRb4yR669igjBE+/Qmdf/GMBiTgslZq6gPyM+bSPH1pA/?=
 =?us-ascii?Q?TJQoeEKCUprh9urT9xyFOG14DD+YwbClR7MQt7LL/Ir2b0ULqZq9MPXRjybB?=
 =?us-ascii?Q?gKb53H4lftO8VWbzvp16rIG9eaLzVw4epqlN7ADfU6IRYso2zXhQoK1BAkOq?=
 =?us-ascii?Q?Qnyh3xRRRJQaYVpPm+UgZ87psdhWrJiaKbdgEO4XkTpD5NSCLxBbuC3fmdns?=
 =?us-ascii?Q?vwGRQ2HQsKJyG9CYwObkLah5YQstufE1cF1hQJ/3mM4A88Kd5NDfwqflcfSO?=
 =?us-ascii?Q?LPJ+624O3YcQHzPeQzbb0mZrDXtw3TR8bQ8aqV2A51IbAJhj5fJr2CrfR8tS?=
 =?us-ascii?Q?XcUP/DSBHfq1D8GXdYP2tAlB4vrez/x+oXvedY7WrckknQnot/3o+O9oqZkj?=
 =?us-ascii?Q?2AuALCJbIVznI0tpU6+F1xdOQxjRynYkewzW2/4KDa2mKJPkidV/2ynsue6D?=
 =?us-ascii?Q?5diz2rI40hbSfzgC7PTW+lz7y2GLh39ZvjTm8yjfcVinNHtGmt3sVWbA2qCu?=
 =?us-ascii?Q?5I42a8jiqpe7H2j1BRmumhkitRpfetrSD6ypzy6Kz+nk/pIfm3fwP+n44kyF?=
 =?us-ascii?Q?xXFKR8mwn2ciJ30Y8R9bBnqyuv/cjiHMcQjAJg7rjuh3HRVy5iIWs0VqtojB?=
 =?us-ascii?Q?469uvcyqHTq90QTXX0RBDW7TV0zx/3nCqKUOc9FK6nEvajLK/tYpdyeNFMfq?=
 =?us-ascii?Q?zCfXmf17O8WDG+sAbizCJAcf5KROZDJDHBFosQ1YVvYKivV/KpSl67/jkCnk?=
 =?us-ascii?Q?RN6/y8EJjmYSldz8JWHtisBe800nAuhoMIlmuJ2A9Y9CFzrUvinOMMXSZHxD?=
 =?us-ascii?Q?AOEhfrLuYnRnbUOux9Ei7KF7wlnck/Y4d8ie9ZmIDSVkcq1LsTULFMQ8nIYM?=
 =?us-ascii?Q?4kGEczeMOyP1D9vBT3FAWvdgj/GhQv0YIdX7ADZQRaBgFc3GIxVD66skTAaW?=
 =?us-ascii?Q?89aO4n++h0Rp/ATArGvOdJ+0wJUd1hZzpMc+ONEMvORMGBjn8lSSIi2KT6g9?=
 =?us-ascii?Q?9WeAKMb6SfiXNA7Vu/65++x6oyY7vszsKfaK2NsAik2ygYPxPWp7zfLq1cqN?=
 =?us-ascii?Q?XwpCG0nq63JEd0PTeLQTMkLbJn0Cw8I5io4s7TT372vXTS28AWwdCl3GmZIG?=
 =?us-ascii?Q?byEtbv+pe/pEG7CBZiexUPQcN4Inm/WehSiOGzt2oSmSQvhqUoMbxxqBz0Z7?=
 =?us-ascii?Q?5K0C1ZTdReBqauxlxYsVw0i2z7SxbwJm37nqiow3lsL9pQWbvpex4gcOoIxy?=
 =?us-ascii?Q?6jVX9cAq8fXZXxtE44KesGkG8WUbDwAGuTHYR2+XZO8zTuaGFvxnSg6K7e+0?=
 =?us-ascii?Q?PwmezuIk2xHrB1EItghah2eJXo4o7FuD9SPs+H0ntx2VDuHg3gcqBQI9DKlm?=
 =?us-ascii?Q?N81orOMkHo79uFUpKJZ6h8KSsBzPjbCkhPXmMTiZUJk2F4q4Sc1FRQ44OcTM?=
 =?us-ascii?Q?bNgwv0JArwlDtKg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6194.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7RUYLCqhCjtsJOOdVTx+wvVnKXAVFKRuHwaRcxsjqjpYb4BXNvbt0cQoPL8O?=
 =?us-ascii?Q?lbTJlenpOdc5GlTdQxmP/sYzR4XjJQSQi6N8NZh1S4Jn/fPo2k97SkoyqDkz?=
 =?us-ascii?Q?z1BLqkosuBiJuefW1ktHJM5z5X5CNrVAKBF1SoW52FoBvLXB39B6bAulan9w?=
 =?us-ascii?Q?f6h6DuNAsMt5MDgVMQcqH/8ee6g+0ivskr1fKS9Cgu9yYXLta1E842DrTguI?=
 =?us-ascii?Q?gl2dcZiYEiOeZYePduNyWtGJ/M6IbocX11sPSyu1YNQ4xtvN/Q23guXKHRlj?=
 =?us-ascii?Q?qJo/HNsKCA/PAgKLINUuQrDVqwf9a1zlD6xj65ojeQoUuJpGgxKNilzQ7fOD?=
 =?us-ascii?Q?o8btPebeNnm5RYuMa2s/1eOhf8EwUcDJdFRcgdUcAaHvl/KLWT/x6vZVjUzY?=
 =?us-ascii?Q?ZUHqg1ZylE8hnG8Kn0eF6LCvSf3GVcCFRNvUOTTqCAi7WRDYzgpbfmLX+p0J?=
 =?us-ascii?Q?gQb0UjVUrmtprFxlEClyG8/9fTL0SzHFxkNNjmo4UvrATyBb42jAGYB5klWK?=
 =?us-ascii?Q?SAKwRf20KnEQBiIuW4/TkUclRbi9eTgnpyH5wwcYLrQbFgIeFvjIbPc20oTv?=
 =?us-ascii?Q?g5irzY5YItcJA5DaBNhD8W30WfNoFL5wl47Mdl76QDODwNnkZEiqkyqtnBbq?=
 =?us-ascii?Q?AMg66zU3NalWfjqkBe8+z9++EISITFV7BvuXJLYF/j0tsrwItIJdFkx+expM?=
 =?us-ascii?Q?rI8tvf3FYHE37qwguX/Kpdk+M/RtxR+MFtL9DhRx58D/nSCX+cLOQxyoLxik?=
 =?us-ascii?Q?YKuCXkQ2mWVxaYH7asi98B7DXf4gwgS/KaaoPLZyrV0dRcwfXxMMyAVXnJZb?=
 =?us-ascii?Q?dijyzMN/aFaRuD2VjMYr2ZsEqE5Hk4Tz4VYfNRnIruzPgULzE6INJ2k4RGh9?=
 =?us-ascii?Q?YC8BeyX+SbY1aMpAYrpotPjs8o5VMLQyrYmBvRnstsaGL6GN8ImzXug8WzrC?=
 =?us-ascii?Q?f5e8iGpm+rbyidw2KN04f2tWVoDg8KSnp79W9vqYl11vDZBX/lb074j7l9IA?=
 =?us-ascii?Q?rgoblTXw0qGXIADB1eGIh0NmHepOb12dZtqHQG73f5ZkEv2tH5Pgv1LlguwU?=
 =?us-ascii?Q?afXqvbeiL3sEJV3zc6SB3jVN8chGAqaYhyYnFEyIk7Ma0ht4J5aqXeOCIHpq?=
 =?us-ascii?Q?89G2kw0eYy0Ww55YAc3GICkrRalJKFRop5SK3oKC7dy0/HUfUIFjQAwITc8d?=
 =?us-ascii?Q?t7LnAfaldtVgvVj4YcE5SRNuTe0dJXHF3PzYmasI8rJHzhCEj0wHL60gyKmB?=
 =?us-ascii?Q?rL4Wwx/Qid0uBWf6/MQ4MweGbMoSIfp7Qtt1besbwwf70OouOkoaHmWWZvPo?=
 =?us-ascii?Q?cb7tJdfbyq4CX8/uQdid+EyrDidvCu2JPlX59hGzLE+Gp1LNWxN4ylIjUyYd?=
 =?us-ascii?Q?3Ag+PkZr69uZadPP2ak2P+Gh1yEgJe1PJ+vXWnmI82uYa5JeVlPhys/EMS/E?=
 =?us-ascii?Q?fo17FzC2qsjlKudXk6vj01F6TlYfQT8t4Q99Ua7vnuPUbJwq2GJ9EE2vHode?=
 =?us-ascii?Q?SuFkQ75g/6fBHjzTt5cDiEf8z/TC+EmoZes2NZaTDzHMSg209Va2mMtFSgQK?=
 =?us-ascii?Q?08I0psqkdUw3BZtiKh0w+4rrj298JpiCULc1bXaT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6194.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 719acf58-f0fb-438b-229c-08dd8e86e426
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 23:20:16.0602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8A4jiiaRPZy4mHbUK8Zw2/6K6intul8qZO+YJltPtb7R+4i6DkOkijU51mQZBwMn30gs869UFgsMwhUzetal300V9anTF8/PS9YkMSj6T+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8315
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Wednesday, May 7, 2025 7:43 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
> Cc: davem@davemloft.net; pabeni@redhat.com; edumazet@google.com;
> andrew+netdev@lunn.ch; jgg@ziepe.ca; leon@kernel.org; linux-
> rdma@vger.kernel.org; netdev@vger.kernel.org; Ertman, David M
> <david.m.ertman@intel.com>; Nikolova, Tatyana E
> <tatyana.e.nikolova@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>
> Subject: Re: [PATCH net-next,rdma-next 5/5] iidc/ice/irdma: Update IDC to
> support multiple consumers
>=20
> On Mon,  5 May 2025 14:20:34 -0700 Tony Nguyen wrote:
> > -	pf->rdma_mode |=3D IIDC_RDMA_PROTOCOL_ROCEV2;
> > +	cdev->iidc_priv =3D privd;
> > +	privd->netdev =3D pf->vsi[0]->netdev;
> > +
> > +	privd->hw_addr =3D (u8 __iomem *)pf->hw.hw_addr;
> > +	cdev->pdev =3D pf->pdev;
> > +	privd->vport_id =3D pf->vsi[0]->vsi_num;
> > +
> > +	pf->cdev_info->rdma_protocol |=3D IIDC_RDMA_PROTOCOL_ROCEV2;
> > +	ice_setup_dcb_qos_info(pf, &privd->qos_info);
> >  	ret =3D ice_plug_aux_dev(pf);
> >  	if (ret)
> >  		goto err_plug_aux_dev;
> >  	return 0;
> >
> >  err_plug_aux_dev:
> > -	pf->adev =3D NULL;
> > +	pf->cdev_info->adev =3D NULL;
> >  	xa_erase(&ice_aux_id, pf->aux_idx);
> > +err_alloc_xa:
> > +	kfree(privd);
> > +err_privd_alloc:
> > +	kfree(cdev);
> > +	pf->cdev_info =3D NULL;
>=20
> Where do privd and cdev get freed on normal device removal?

I literally smacked myself in the head for missing this first time through.

Thank you very much for the catch.  This should exist in ice_deinit_rdma
and a new version will be incoming.

DaveE

