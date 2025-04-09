Return-Path: <linux-rdma+bounces-9307-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8D2A82C8C
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 18:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67E391B627AC
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 16:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FAB26FA73;
	Wed,  9 Apr 2025 16:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E6tU/yiB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385BF267B6B;
	Wed,  9 Apr 2025 16:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744216460; cv=fail; b=iLrPuhObwx//98ZdlPbAcGZS5CFDdpYSboDgUwJWNRn8N77+yd3397aIYyBxcMjCQ2SSYlEDP92H/bV5R+QQNaPR7gtbAbXJxeaEi+JrBydKMlUEiniu2MW37dt2KIvSLR9pxBc2otO3vu7/P3jVGz61zF4ybAK/a0fpy+ITVg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744216460; c=relaxed/simple;
	bh=8VbZEWW/lhfQ5F/qjI16SaCTW8wcjcvPeSleG+yXKi4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jYrKQNFa86AlTGbHCRZlfxMVnf09ihi+Itt6JeOzarzN2L+M0z5fvNALnskRTjSgPfEzLsY1IVUwMlIhuvEyt+iuPZsKzMZXZFVfgZGqD5v63LqOH2fTwo+tpSsqzq90r6KfLY7X0X3xwaTBMEHkZ5Q0pzsvEMsZpAkx3+Sl5jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E6tU/yiB; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744216458; x=1775752458;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8VbZEWW/lhfQ5F/qjI16SaCTW8wcjcvPeSleG+yXKi4=;
  b=E6tU/yiB4j/ZJyA13hwvFfoIhk+LEE5T/YD85Fp3TL+3ul+tYuo1bX4g
   glTMInlOOPrXDe76nF3ahUu1gA/RvpjK3ajp/pRtd5iOZ5aAydzo6Ryye
   Evs8a1wYf89BJ4wBgCbIVc47K4AU3A3fXyT7vGnnXo6+WLEftKUxurguc
   NNJl9AILwcJX6vNRRFSTPWc4CcIvWYN2Wb1SjxCN+A1mikF17srA6ZcUw
   vdZrysCd4oyGFK5oaX9VMpxmiluDqY2xXqQ1O06rqmvzSfqwNl7Ur02L8
   NwNljaWpnnur20s7Gql9bIEpgdtK7ozRmzHW9jd4KDTSawj8KNpdswPvH
   Q==;
X-CSE-ConnectionGUID: bj9V0nRiTHumcmJFt8EEYw==
X-CSE-MsgGUID: Iro8K3EUQzGX25GYl3LFpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="49547473"
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="49547473"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 09:34:17 -0700
X-CSE-ConnectionGUID: 6adq7e3sTc+keJnKwaQMVw==
X-CSE-MsgGUID: mY/9Blp0RGKmUmmLErSR2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="128553403"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 09:34:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Apr 2025 09:34:16 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 9 Apr 2025 09:34:16 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 9 Apr 2025 09:34:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=srPx6/53hr0+MIV5iEyxvXt1YcFv7uFgfpwOKaO5brs+FCa5TcYGsxe9lIcMJcb+4/gbScHod1sESCCouG2ZMTEwcLzS0xTXSWrb3kcKBgWHn4SGzt1CqRzq5mO4xZZ4PeiyJNGaDTRTimiovl2CvXPtjZ0GDgBBSRCa8GzYeaWdVm4XnP6Av+vJ4O8vkbHqNRcHPtHx1EQ6BOF4jAB3nT80hhpWs3L0rNVRDJZ4eZ9LzCt4XjXndBgGybSPJyyDl1augMD64tLUfl80m3mHBXVqiy/H51lRnoVincpS3Y6R22n0CeeJ7t640SK0RbgTEAId7EXMJ4idMvmMOabMSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Usq/Ey9PIbll2oejSDH6sv6f2he3h+ky8Jw0LXO/yQ8=;
 b=ScBfg7nYIG2Hseu703PGly090Y03tmKPOPTBhmgwx2j9toMj/OMEV4QGzsHkBf2bmcHjm7UaFOBWLgv+ESFQ+XGxivqPWOI2d7I7dk1qvL08RReK8/rgpRFHWMJOrgV0sWAXOzA2ZPtFyqEpqK2VU+Z0klTCmVIx3Tcde4VHXf8QdSHzSGlWO0hBTUB9BcgEX8/gBEezixX5Me06E1kid14e6aODnY6hm7h5ikHb6+Oz9E8mdwx/c9iYDsYQb/x3apny+fzFJvfO46Opm1a2NYplYRj7zvdkz2gxXGEblk1zj/31FA+O0yDahFmNzX25E56/xTs9jZ8dwynuje6rkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10)
 by CH3PR11MB8314.namprd11.prod.outlook.com (2603:10b6:610:170::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Wed, 9 Apr
 2025 16:34:12 +0000
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b]) by SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b%6]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 16:34:11 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "Dumazet,
 Eric" <edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "jiri@resnulli.us" <jiri@resnulli.us>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "saeedm@nvidia.com" <saeedm@nvidia.com>,
	"leon@kernel.org" <leon@kernel.org>, "tariqt@nvidia.com" <tariqt@nvidia.com>,
	"jonathan.lemon@gmail.com" <jonathan.lemon@gmail.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, "Olech, Milena"
	<milena.olech@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH net-next v1 2/4] dpll: pass capabilities on device
 register
Thread-Topic: [PATCH net-next v1 2/4] dpll: pass capabilities on device
 register
Thread-Index: AQHbqWSU1TG86yiU/UyHmBFzCZyYNrObh4zQ
Date: Wed, 9 Apr 2025 16:34:11 +0000
Message-ID: <SJ0PR11MB586650F17768DE5C90731275E5B42@SJ0PR11MB5866.namprd11.prod.outlook.com>
References: <20250409152558.1007335-1-arkadiusz.kubalewski@intel.com>
 <20250409152558.1007335-3-arkadiusz.kubalewski@intel.com>
In-Reply-To: <20250409152558.1007335-3-arkadiusz.kubalewski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5866:EE_|CH3PR11MB8314:EE_
x-ms-office365-filtering-correlation-id: 177482ef-f8b9-4bff-ccd0-08dd77845bb0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007|38070700018|921020;
x-microsoft-antispam-message-info: =?us-ascii?Q?Tz7AgtAWjJ1x+f849expG/IctehAYcLIqLGSmGB0AoxLqJeV7jm5CS5MKVUd?=
 =?us-ascii?Q?hQLuTVQFl8i3kBumV1neLpDPW66PqEipvqdErUsvtqHY4JW1elANtJcgmQtf?=
 =?us-ascii?Q?mC/pv1Stqh/KN+3ag6BEtd8Wp0bIzc6FxmKD4KE/z+E077FEiRBKWVCug0tP?=
 =?us-ascii?Q?PI/BMO4NHOEpeOqZdnvZOVsVpz9mQVn0//QzW/Biktubfidgeb1RViiqwvrH?=
 =?us-ascii?Q?1yXR1fPL8ih+VFq2LuueGpyYn93GD2KKTOdJm91d9/fiY+cC06pBiuFsLyKm?=
 =?us-ascii?Q?/70tNgpIcWjgZzjxT9KGlbEoGxaihcF1mXJjLhfRPbM2tHAiC5B0iwAr3iWz?=
 =?us-ascii?Q?/t2ObTkctzTOGb6e1LWcxeIAUQ/G3CGydJihGKxIIx58bHibWUwAK1c3s4yy?=
 =?us-ascii?Q?4dbyDy5ckwQVJELwyiGJr1vpjAb2MZyQi+0tsqETOBFiM9B7aHmVug7oOIsh?=
 =?us-ascii?Q?BpHz/JY0+H+T93v3TIMIZHqWfz+qecnhpZvV0oqexUAAdsSQ5Fr23mmbTGhb?=
 =?us-ascii?Q?zAdK+0EH6pWUBGHdw+hH1MepSyf7HB0+HMRN20K5SDYzfzvWoxU+KXuKz8PD?=
 =?us-ascii?Q?NYUj7lbdSLKHIcFn5zwG6C+Ytgub1GZmRN34pP9gXayAK2PAgON9vnQIAAN1?=
 =?us-ascii?Q?Waqy5d55PGQO6wwGI5F0zc5Ibs8LDbzuEpwTaH0qmjEfIW/zUPSrXaJBYZiz?=
 =?us-ascii?Q?dt5dLkqLsYQtQxLg1O2RxXrzzjMCSY+VfaygzNKfJZPXkTEe3SFIlbMCELET?=
 =?us-ascii?Q?1Fz2F2d4KSGBq9yVgERj4wCVxAHOMNcvgFsPBEm+87PB5Oyi0I/9+pE5C8X3?=
 =?us-ascii?Q?6ZGIyVb5vJtF069HHJK1UmgWqh8znrHsWK9g+BSvug1YTpLg7gQTjlW/F6vs?=
 =?us-ascii?Q?rwNATZQV46EIW0lVsg9Yprmvovk5dH4uEwdknsCkWjX2mA80FQJvqeOMUHtu?=
 =?us-ascii?Q?n2MqxnDadxkRutSzlxQX1dmOu7auKZLaOwA/bjRneUYv+SjHPiLYWy4ISMZS?=
 =?us-ascii?Q?q/u+L7m7xQei5CSD0tIIz3qxEwWMKZBJtAmw9O1t6r+Ak9saxoOu5tBec/hr?=
 =?us-ascii?Q?V1+K3R+Krnhkkx3z06z9zuTTh5ILW1xnlYnGJYFmjzZ15Bi5lJ5Lgco5VRvE?=
 =?us-ascii?Q?eBXpyN9Qk0ltCpCLw9DZJft4lLLw1gCXpmXwYZGm8t1JSjCC5qfuixWgXPED?=
 =?us-ascii?Q?XycFKhObMQtLa9+MAf/Pl/xfKb0gekESEIDiXi/KnrRPRDr2/yW3EWLpF8rA?=
 =?us-ascii?Q?uzzCUXdO+E23aiuQB/soOGykp6fJs6yOkvJ/dt6waDeuM6MGYHdk7UsOoqBX?=
 =?us-ascii?Q?tYaXih3zHwlO7kRZDvPCbFY10bMhFZ5O/ddN0PHugpcXSx4ZTD7pIXvPv0Wy?=
 =?us-ascii?Q?9WBtczv06ZbPPKftlGCDiCsAuILxLnOYicSZ2ntsKaxxX/npnA9xqMeQwYgu?=
 =?us-ascii?Q?oVYShWbjMuiT+kBkNLEQEdSQCb4niDwSmtZBhjQJAMo52qSpEhO1AC729bhq?=
 =?us-ascii?Q?+TuZh867DBME60k=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5866.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QDkc4yjOsUScd3+TN3fVe0rjNgI9Q1Pa8ox4sgPVLilI9mgDISWNr562wcqQ?=
 =?us-ascii?Q?VHbQlri/Pl6vVVFzyXgI2MDA/0Ay7Kxayt/mm4+EQ9Z0xPZT31xvhAcnNMFY?=
 =?us-ascii?Q?WoP3Agj5fnraDVqVVcjIW7D76y8BgpgEo1dzczBYR2vWXvGo2aKjR8yPwUi2?=
 =?us-ascii?Q?pb/09QfBlFN/41HHcfdigFVjBahpt9DXyyvPJOtrGJ6+Dn4FmDWKesPnoY9b?=
 =?us-ascii?Q?ntr1Ki+hVQSsEUtE2ggV7RlzvP19ZTnxVRhpZg2mvCB7FV1CQoUkXhFp6Y5Z?=
 =?us-ascii?Q?m0XtzGosK/jwlGq5VUWaTUOJ4j7GhVprLWc9opQVanVX//xd8TPJVprkstz6?=
 =?us-ascii?Q?HEiLJR02P6XFS/ZPVlYVHjp2K4sqV6deeAYSk734F/30HfEljnso0+DEuoWE?=
 =?us-ascii?Q?ptdetS9I1FLBE+D4tEy8Sxb7rO5LE0MqzZuf7Nd10mClZVdR8OakoX31cVDz?=
 =?us-ascii?Q?+KO+2OJ6MlbBYxyzSDw50cS4V7zQUuBe044SQvDi8I9qPPmQ3jloGgIwqP6G?=
 =?us-ascii?Q?gk3MLmTZTBYCqDc+1b85pKEilrL232IjG+3KjRH3c39GzFyQW7BzL29kQn9/?=
 =?us-ascii?Q?vmEQHzF0y3Y/4rg2LK7y8mjoTuKpbbQX+pusYSjJrUaAT7RW7dchAhsoyApV?=
 =?us-ascii?Q?2cO2x62f/fDZ+uwJZWlyx2/iq4wb+vHT2RhDLI7Dkx8054gn2umQ6Hyo4yiQ?=
 =?us-ascii?Q?NyzF6+4kOJlECzvuZLP+b3RFKpyB5Cu7DPreGJwM6ihICSOEPLllqa9lQmWG?=
 =?us-ascii?Q?AjZv1Xw3zOmQ+nCTa6vcO7zlqN+T27UejyGvUio9Qc2/+OnPStMI0hzIgy2c?=
 =?us-ascii?Q?/ovnSXTlpGHcoZVV+8wcVKYmav3XVDrw9QmXdDvQnvr8ns0l6YKtEMpLwsai?=
 =?us-ascii?Q?bmE2qBBq/8z060D7o3cHaYSt1IaPu2AvKzEkyBUMp/q/erL9rnj5MUe2lTh7?=
 =?us-ascii?Q?eRtu5kA8CtG6lDJXDVFVmj5bdPLABetxoaCO+wDu6CCpE19Rd3fRacLaxxrF?=
 =?us-ascii?Q?PXOsx0NJ8S2wp59qPgsWGRFLDmRJMb86StDxcGxD8/sKJ8TbsOAik33Sq9ka?=
 =?us-ascii?Q?mYHEY9PhvfLsJO31REMOkqwKgZrUelhLLT75olw+XDyc1XWY5Va3o4zm7vhy?=
 =?us-ascii?Q?QnHrxkj5HruShKkTL08ctjCtmSBCl8zIoq3hq/ruLJOLEjpZfVJ6zkm87akg?=
 =?us-ascii?Q?JjUMpVgWLgXvs6f6o+G2ZIdr1DbvvUcXuFSjfXkCWmSfNxo78yFa+UjdbXgi?=
 =?us-ascii?Q?x2aLOe6JIWF5PXdJrJZJH0P1JazWvXvQWE1eVF5/Aza13bpwKUdUFtGTUsZ7?=
 =?us-ascii?Q?nBdRLzDsoFIr6ueGdD4SC8K1c50Yk6rka5HyMgy3/8s0robikGTjKhsOgAf+?=
 =?us-ascii?Q?48K+MbHNStB4xVh3mqiZaAAZt7nEv985c4+wDFb7fczmTZYFKHgTdnCPRUue?=
 =?us-ascii?Q?A0DU70g0C1afXYkSOYC/blUKVFCCz0/fFfKGCGRnPQGQM8tW3HubUOCiIanM?=
 =?us-ascii?Q?ZaYnVgVVpYwFwK0eFggvjWMaJwmYflqjerM9g1jOOABabWqQnvqnHzCvxWhX?=
 =?us-ascii?Q?cCcZ/1Z6SYNdlYfKfI0OciDvkTw8rc69m7HHTGqkqISLV3lpR1QNs8bnouAN?=
 =?us-ascii?Q?yA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5866.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 177482ef-f8b9-4bff-ccd0-08dd77845bb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2025 16:34:11.3734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CHlGxopVDStAjBVKGKC0BG4j0p5YDGNCu7kIVN3S6rMZS1VwIBqGMDh2rt3DGJzeNjkQ9EXaUt67OBFDXn2HRpXQGapDX8EaAWwR+TZnTRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8314
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Kubalewski, Arkadiusz <arkadiusz.kubalewski@intel.com>
> Sent: Wednesday, April 9, 2025 5:26 PM
> To: donald.hunter@gmail.com; kuba@kernel.org; davem@davemloft.net;
> Dumazet, Eric <edumazet@google.com>; pabeni@redhat.com;
> horms@kernel.org; vadim.fedorenko@linux.dev; jiri@resnulli.us; Nguyen,
> Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> saeedm@nvidia.com; leon@kernel.org; tariqt@nvidia.com;
> jonathan.lemon@gmail.com; richardcochran@gmail.com; Loktionov,
> Aleksandr <aleksandr.loktionov@intel.com>; Olech, Milena
> <milena.olech@intel.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; intel-wired-
> lan@lists.osuosl.org; linux-rdma@vger.kernel.org; Kubalewski, Arkadiusz
> <arkadiusz.kubalewski@intel.com>
> Subject: [PATCH net-next v1 2/4] dpll: pass capabilities on device regist=
er
>=20
> Add new argument on dpll device register, a capabilities bitmask of featu=
res
> supported by the dpll device.
> Provide capability value on dpll device dump.
>=20
> Reviewed-by: Milena Olech <milena.olech@intel.com>
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/dpll/dpll_core.c                       | 5 ++++-
>  drivers/dpll/dpll_core.h                       | 2 ++
>  drivers/dpll/dpll_netlink.c                    | 2 ++
>  drivers/net/ethernet/intel/ice/ice_dpll.c      | 2 +-
>  drivers/net/ethernet/mellanox/mlx5/core/dpll.c | 2 +-
>  drivers/ptp/ptp_ocp.c                          | 2 +-
>  include/linux/dpll.h                           | 3 ++-
>  7 files changed, 13 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c index
> 20bdc52f63a5..563ac37c83ad 100644
> --- a/drivers/dpll/dpll_core.c
> +++ b/drivers/dpll/dpll_core.c
> @@ -342,6 +342,7 @@ dpll_device_registration_find(struct dpll_device *dpl=
l,
>   * dpll_device_register - register the dpll device in the subsystem
>   * @dpll: pointer to a dpll
>   * @type: type of a dpll
> + * @capabilities: mask of available features supported by dpll
>   * @ops: ops for a dpll device
>   * @priv: pointer to private information of owner
>   *
> @@ -353,7 +354,8 @@ dpll_device_registration_find(struct dpll_device *dpl=
l,
>   * * negative - error value
>   */
>  int dpll_device_register(struct dpll_device *dpll, enum dpll_type type,
> -			 const struct dpll_device_ops *ops, void *priv)
> +			 u32 capabilities, const struct dpll_device_ops *ops,
> +			 void *priv)
>  {
>  	struct dpll_device_registration *reg;
>  	bool first_registration =3D false;
> @@ -382,6 +384,7 @@ int dpll_device_register(struct dpll_device *dpll, en=
um
> dpll_type type,
>  	reg->ops =3D ops;
>  	reg->priv =3D priv;
>  	dpll->type =3D type;
> +	dpll->capabilities =3D capabilities;
>  	first_registration =3D list_empty(&dpll->registration_list);
>  	list_add_tail(&reg->list, &dpll->registration_list);
>  	if (!first_registration) {
> diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h index
> 2b6d8ef1cdf3..70bbafb9b635 100644
> --- a/drivers/dpll/dpll_core.h
> +++ b/drivers/dpll/dpll_core.h
> @@ -21,6 +21,7 @@
>   * @clock_id:		unique identifier (clock_id) of a dpll
>   * @module:		module of creator
>   * @type:		type of a dpll
> + * @capabilities:	capabilities of a dpll
>   * @pin_refs:		stores pins registered within a dpll
>   * @refcount:		refcount
>   * @registration_list:	list of registered ops and priv data of dpll owne=
rs
> @@ -31,6 +32,7 @@ struct dpll_device {
>  	u64 clock_id;
>  	struct module *module;
>  	enum dpll_type type;
> +	u32 capabilities;
>  	struct xarray pin_refs;
>  	refcount_t refcount;
>  	struct list_head registration_list;
> diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c in=
dex
> c130f87147fa..41aed0d29be2 100644
> --- a/drivers/dpll/dpll_netlink.c
> +++ b/drivers/dpll/dpll_netlink.c
> @@ -591,6 +591,8 @@ dpll_device_get_one(struct dpll_device *dpll, struct
> sk_buff *msg,
>  		return ret;
>  	if (nla_put_u32(msg, DPLL_A_TYPE, dpll->type))
>  		return -EMSGSIZE;
> +	if (nla_put_u32(msg, DPLL_A_CAPABILITIES, dpll->capabilities))
> +		return -EMSGSIZE;
>=20
>  	return 0;
>  }
> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c
> b/drivers/net/ethernet/intel/ice/ice_dpll.c
> index bce3ad6ca2a6..614a813c7772 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
> @@ -2012,7 +2012,7 @@ ice_dpll_init_dpll(struct ice_pf *pf, struct ice_dp=
ll
> *d, bool cgu,
>  	d->pf =3D pf;
>  	if (cgu) {
>  		ice_dpll_update_state(pf, d, true);
> -		ret =3D dpll_device_register(d->dpll, type, &ice_dpll_ops, d);
> +		ret =3D dpll_device_register(d->dpll, type, 0, &ice_dpll_ops, d);
>  		if (ret) {
>  			dpll_device_put(d->dpll);
>  			return ret;
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
> b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
> index 1e5522a19483..0e430f93b047 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
> @@ -444,7 +444,7 @@ static int mlx5_dpll_probe(struct auxiliary_device
> *adev,
>  		goto err_free_mdpll;
>  	}
>=20
> -	err =3D dpll_device_register(mdpll->dpll, DPLL_TYPE_EEC,
> +	err =3D dpll_device_register(mdpll->dpll, DPLL_TYPE_EEC, 0,
>  				   &mlx5_dpll_device_ops, mdpll);
>  	if (err)
>  		goto err_put_dpll_device;
> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c index
> b25635c5c745..87b9890d8ef2 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -4745,7 +4745,7 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct
> pci_device_id *id)
>  		goto out;
>  	}
>=20
> -	err =3D dpll_device_register(bp->dpll, DPLL_TYPE_PPS, &dpll_ops, bp);
> +	err =3D dpll_device_register(bp->dpll, DPLL_TYPE_PPS, 0, &dpll_ops, bp)=
;
>  	if (err)
>  		goto out;
>=20
> diff --git a/include/linux/dpll.h b/include/linux/dpll.h index
> 5e4f9ab1cf75..dde8dee83dc6 100644
> --- a/include/linux/dpll.h
> +++ b/include/linux/dpll.h
> @@ -171,7 +171,8 @@ dpll_device_get(u64 clock_id, u32 dev_driver_id,
> struct module *module);  void dpll_device_put(struct dpll_device *dpll);
>=20
>  int dpll_device_register(struct dpll_device *dpll, enum dpll_type type,
> -			 const struct dpll_device_ops *ops, void *priv);
> +			 u32 capabilities, const struct dpll_device_ops *ops,
> +			 void *priv);
>=20
>  void dpll_device_unregister(struct dpll_device *dpll,
>  			    const struct dpll_device_ops *ops, void *priv);
> --
> 2.38.1


