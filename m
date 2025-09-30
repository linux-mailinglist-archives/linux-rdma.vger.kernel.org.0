Return-Path: <linux-rdma+bounces-13746-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3E7BAE5E0
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Sep 2025 20:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D886A3AA2CC
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Sep 2025 18:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C38626B2AD;
	Tue, 30 Sep 2025 18:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n92tQfTK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2A12264CD
	for <linux-rdma@vger.kernel.org>; Tue, 30 Sep 2025 18:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759258482; cv=fail; b=UH+NutnGDJb44y3JSg4UiNqTBlYC5jr+46ouPbbnbxSzWGtysY0MaDUQhXVJ459UH/3GBP5F/2hr/+3qgmKB5ZFRTCSBcjNNp2Y0C1z7gxw2zn84GwjRdvNZr5GlSaaBjJ7q+QMOUePJHalZ+a9u76kvcC22Fl1m96RCwuv7Gwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759258482; c=relaxed/simple;
	bh=U9DrsFXEjqmHuizk1IXwnZfiQVL/KxBtTE7+Nq7X16k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GSbBVTXKgtgpcDzN7k00yXaon+URadycLUSqv/voYMmN0/FVEQwJReig6Rbcc7a/U27rHQf1HSD72jcuw7yUR2s9zd743KjpZ+aVm2hs6F/sSb0HYXP6IYlgPAr+dWuI2UpYJeKZWYkpk9nhRmWCF+KDnQP23GR4Sbw1DqM3Xys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n92tQfTK; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759258480; x=1790794480;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=U9DrsFXEjqmHuizk1IXwnZfiQVL/KxBtTE7+Nq7X16k=;
  b=n92tQfTKnJ82JlF/9zNoCmFepkhisim4gIhzXV3v76SU0D/DaGwIZtgX
   7P4nJHq45pafAH6fXpuSRzKfTsigzOcSmeGqGWqxrF3tIzvRG6tFytAZQ
   JlVWCyLzpVbkauFu8HvdYisykuRvoQ5x/jXrMDhmuuox//EhPJGQ2egkL
   HwYfjVPuEUPJ2rS/oF65ThTZ9mIR25hEqwdtkFBVvY+Fe26BjAm8mpDUI
   U/9CKaxJ5Wvt0lzwW2mtWhJQ6Q98dIMiRw3wSY1E5w/PcuPD2MjbZMMLt
   dVwnDuRDJ/SWYy1ufOPL9kFvrbTh+30e0hJVXPkmvZmEaqUhlwqRpFYes
   w==;
X-CSE-ConnectionGUID: fIeD/PwzRcSLbphcNfj1xQ==
X-CSE-MsgGUID: wxxTPcIVSeyi/20e/Ka94A==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="60559813"
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="60559813"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 11:54:39 -0700
X-CSE-ConnectionGUID: EJVBvn7pR8a+IaH6Hotw3w==
X-CSE-MsgGUID: 1lsKrxAdQJeBHpVTAHBXwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="177716071"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 11:54:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 30 Sep 2025 11:54:39 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 30 Sep 2025 11:54:39 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.38) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 30 Sep 2025 11:54:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sUIQThAtssIThjFJg+TIvnD6i/rgaW4Z0zLQ/o1538cq3QekA84DjvJ7c3twmJ60AyuOdSjLtFzt7se6rUtcmZcO81bEbJOcKLGAAXU/eEjmhwqecPYmeGR77Qazd/Z7Yvuo3fF8JIUhAw9BR2BYYWlAqMVKW43kdQ0xWcv+I8yheou8GgdtuCDPNbtQ/eK9YDpZ9je/nk6MZxuQt0HV0joSqOqe7nQZOLFKlVY0eu9d/3pC/PCVxAyJwsELxtK+lS0wC0pPiIlwGs3t50cXTnFZHvC/Hjik3K7l/3fA6lFNGNA6x8Xr2dD1rC5FZ8XBiUjceXGuid4RtkitkgoAcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9DrsFXEjqmHuizk1IXwnZfiQVL/KxBtTE7+Nq7X16k=;
 b=Vbp2sv774G/Em0pAIMMm8Y41jry6yChL8Qb12b2Nsy5Q+DMfyZ9p7JeoWuXggmJep1rJJZOV8xvXHZgFofUVSPzemUK4wScPYuebkD4gWohzrqiQLh/tVaS3IKufjUp6lDHAQ+bhFj0PrnXBqXGM9+vdJzMmD5qoHMHEOF/hJ50hdP5qtXWgNCyz4fw7dDUrfDuYk1/MAAy+zwxeYcdV8SfI4uFCdOoquSRVrbElQgf3CSjYX2coosVcvyyjf/s1ytAn5f++RCrnWaoA/LyUylAPIohD9jPxXnkiiqogOwPtB4vpdM53zg65PguWTvK+jUIk/R6F47oIDP4wov6vYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB7727.namprd11.prod.outlook.com (2603:10b6:208:3f1::17)
 by DS4PPF0442004E1.namprd11.prod.outlook.com (2603:10b6:f:fc02::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Tue, 30 Sep
 2025 18:54:37 +0000
Received: from IA1PR11MB7727.namprd11.prod.outlook.com
 ([fe80::763d:a756:a0e4:2ff7]) by IA1PR11MB7727.namprd11.prod.outlook.com
 ([fe80::763d:a756:a0e4:2ff7%5]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 18:54:36 +0000
From: "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>
To: Jacob Moroni <jmoroni@google.com>
CC: "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH rdma-next] RDMA/irdma: Set irdma_cq cq_num field during CQ
 create
Thread-Topic: [PATCH rdma-next] RDMA/irdma: Set irdma_cq cq_num field during
 CQ create
Thread-Index: AQHcLJXeLWW/nDTTnUGNJgD5gxlQG7SsHhIQ
Date: Tue, 30 Sep 2025 18:54:36 +0000
Message-ID: <IA1PR11MB77274574737DD9D8D12F7CF4CB1AA@IA1PR11MB7727.namprd11.prod.outlook.com>
References: <20250923142439.943930-1-jmoroni@google.com>
In-Reply-To: <20250923142439.943930-1-jmoroni@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB7727:EE_|DS4PPF0442004E1:EE_
x-ms-office365-filtering-correlation-id: 59e23fdd-7e38-4620-c168-08de0052cd8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?dEk2RUUvYmZHdldqY0ZkR1R6YkNHdUdRc3FFc20zNHQyUXltYWR4TXJ0M3o1?=
 =?utf-8?B?aVNMaU92VFlvMDhVWDhwbDRpS2xQT2dmZjBXY1JLZ1FTY25lUUNuc3pCOE1T?=
 =?utf-8?B?VFBlWmFxVytwQjFuM1B2eXNUTHV0aDBjZVg0T0pIWWU3bW5RYkt0TlhhSWw5?=
 =?utf-8?B?bDFPRVNtcjlEMi9CSkptMU5GK0srb2RzWVBKMHZZdStLR0wxazVicTNtQmQv?=
 =?utf-8?B?YUdLeEttYXJDeEhTcnlzRkM1cS8rekg2SWNtM2k0UlVWbUhBNzVNVXdua2dG?=
 =?utf-8?B?T2xKODEvK1ZWZFA1bitXOUQ5WVlORkRJeEVQSnArc2pzRzZUcXFybkFGWTdv?=
 =?utf-8?B?NCthZWNzVzlDT01TTU8rbW9lbEl4WmVMNVdPNVlSTlZsc2pEUjhxZGNuK0F3?=
 =?utf-8?B?SmRqY2cyUGJvRnZXbDJaVGlPdnUrWTVNMjdaNjg5Uk44N21Zby9ITWhkRWda?=
 =?utf-8?B?cFFzMGJkOVdJYUZ1SnV6K0lYZXJYa3o4d25raklxUDJ4U08rMGU0RzlsK0lT?=
 =?utf-8?B?ak9KYlQvcFRNMGkvYmEzVUpnTklFUFBScEpWNC9rSGhBUHJwM01oQldEUGFw?=
 =?utf-8?B?d2ZsK3NOOHp1UHgwNS9LTW1PNXJMQk1ScnQwSDBtb0drNE4rdm9GNHRuNmda?=
 =?utf-8?B?SVZZdE9hZTRNYjFSaVVRUUN1SkJ3WkR4cFV6VzVwYkU2cUpEWXVUZFdjbFEx?=
 =?utf-8?B?WW9RcGgxd0xGdGJqNFRHZHhZeUo5Wll1bkRZdDBHdEpQTmpHS1N6dWVLWVRx?=
 =?utf-8?B?VW53NzhIZG1taktCV3pBd29zNU8wWG96RURkTjhMWGVTTVIwTndnclY4WDVW?=
 =?utf-8?B?NTFidmdVSmVhejBKWGFjUXJTOE4wdGZSRFBPaVJmRGFhaUxLeGsrcWx4T2JY?=
 =?utf-8?B?VXpUd1NBVlhkVHRBYUFDRmNBQUtlYjZIWUl0dTFCVXJaekdyenBSeFR4cGFi?=
 =?utf-8?B?ekhHTDVQV2hVUFBZY1k2WEQ2YWtVTjNacTdCeE9tcThCcVJ0WUs3MUdBbzJN?=
 =?utf-8?B?TmdGeFo3WEZPdDBqdnBqQ2MrTWxwbEJlNWUxUmZ2Tld6ZnU1cGp6eEpIa1B2?=
 =?utf-8?B?Vi9EZEt3NEhleDhtbFNJWjFzM1hZSXEzNitvMm03YSttUzBDOTZEaXlZaHpr?=
 =?utf-8?B?VmtVcnBPUnNTVXFDdXczVU5VWmJGd0JJem9FdzQvNzRVcTRycnA2cllPMFN4?=
 =?utf-8?B?TWZYdUZoenZzZFhPRThTbHpVWDBDWkVMRnFQVDdpZGJNa2FkS0tRL3BjQzBB?=
 =?utf-8?B?RXhxTFY5MFV6MWdZN1oyT0x3YXAraVBCcFE1aFpZR1RpSkJrSnhFSFBuL0ph?=
 =?utf-8?B?WnZRb2N2R25FeURyT1lzbXVGY0lseEZkNDZ6V2ZIMk90VFJnT28xQkEyOVdK?=
 =?utf-8?B?azU1ZnFCNTg3ZHBKOWFPWjBMKy9CL1UxYmcvRU52K1pESGozb2Y2b3VxcWg0?=
 =?utf-8?B?OGM4dTM3MzFnZDRHQjdoNFZkMVBrajZFd0VSUTV4M04vNjZ5cHZjRUhtckNk?=
 =?utf-8?B?QStPNmV1M1MvdDJ3d2VZWWZzZDJqVG9abk5wcS9COWNOZGN6TFFSb0VFdVQ1?=
 =?utf-8?B?TDNxUzNvM1YvY000YnRLNjRJWnpiZTNmVzRyMWRwU0dCNXJqaFhSQW5WbXpO?=
 =?utf-8?B?YUFUOTBZaDcyWnhQdU9YWFF0SWdQaVAyeURaOUtpbUdwVmVDelgvQTJNQ1hu?=
 =?utf-8?B?LzRWMlVTMkFJUC9LV1RRQlVwdkNyVnlicGVGRWpiYlJsY2JQRUFqNC9XTWNi?=
 =?utf-8?B?aHh2ZkpuaEZuS2c0YXFPd2cvVjRVbmhIdklYRkZEbmVmU2Jzb054RVlOUm5W?=
 =?utf-8?B?ZC9FSGtHUVJNOStCU29xbTNPMXFKaSt0ejJJTG5iSWRxSEI4TlkvK2lldm9m?=
 =?utf-8?B?b0FWMFdCSzU2TFdqcUJTYk9od1M5T01TckFEMHltR1pvSFBMQTN6UjNYRDlz?=
 =?utf-8?B?MlZob3VrNTQ0MGdJVVlQMCtXUUh4TUk1YkdlTWtDOVhvL0hJc3VKUUY4NmZW?=
 =?utf-8?B?ZjFLVVBBRnZzd3VmbVhFMTh3MUVrVHZFY2F4clNOL0RWaDgyZmVXb0hWR2du?=
 =?utf-8?Q?uvdKuo?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7727.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0VvT0V6V25GRlNrWkx3cTRRY2gwcVFEeTVadlpMeXVKOEh1eUxHMmdoMG9Y?=
 =?utf-8?B?dmh2SEU3TGhuSEhUajV4L0tXbkJHaGRCbDF4TWZwWUZxaU5ZMEVPYkNLQW9G?=
 =?utf-8?B?djZmUElUMFVmY0h3Rnl3eG1Sa05ic09TSTN0MkVpbFFnanAvSzRYYW54TUlR?=
 =?utf-8?B?RWlONUlZdTQ0V2ZHY0t6cklOVXRyNXJmV1l0ZXVHTncwSHJTaFRCOUJwU2h0?=
 =?utf-8?B?UHJ5amdDNDFHN05MTGQ5S21aekh4V2J4RDM2djgzeW1Dajd4RFcyNCt3WXZj?=
 =?utf-8?B?V0VNQzhQRWcyRVVsQlFFY0RkVEZPWXJXOUFFSFVQL09IYkhvZEk4bDJjQlEr?=
 =?utf-8?B?TzcxODFoN0lOempIVVNINjFaTk1Sbzd1aDdOK1NVbnV3QUxvamJmV2RydHV2?=
 =?utf-8?B?K2Q5R3Q1Uk5jS1lXYi8zemg4RUhReDh0NXdNK2xhc2RpbzlwdlIzcU9FaHpa?=
 =?utf-8?B?TTI4bWd4Y0xXU2crcDlXdTF4eGZnUmRubVEzdlVzcGxKcENkbm1uYjlWYXA3?=
 =?utf-8?B?cXZWTjZ3NW5zcTVrNHZrcm9paElJVUJQV1dGNTNYRU43TVQ0TmxwMlpoYTdX?=
 =?utf-8?B?L3ZNbVphRGdrQnhURzdJaFZWNjd0ZHhOQjZOSStzcGF5RXpJR0lBTkoxaDVP?=
 =?utf-8?B?R3FhOElUeHlOa3EwWEpVMTc3c3pvTE1HdFYwWUFDTWRENTYrckRQSS9zeDNK?=
 =?utf-8?B?N2pZVlgvZm9uZ3JidFNtaWdIMUtvcnB4bFdyRVFxVW9QZWx4M3dXYy9xbkFu?=
 =?utf-8?B?M1J5a0drRzVoc0dhWnRXbmVKelhsZ2F3UDFyKzhONUM1RTBQbHRRRSt2b2Ev?=
 =?utf-8?B?Q3JTZDg4c0FadDcyYWhpbGVPM1BVditiWTRpRkpxaXdrMkpnS1BCdkF0alEy?=
 =?utf-8?B?MVpGYkdEMUkzdDh1c0RKdEU4UzBVOXNDK2JwbXlvWk5BVmwwSHFWMk1GcU9y?=
 =?utf-8?B?WVdmYjhTckJEQUNEY1VtbThKdDNaZnRxMEcrSTN3Mm53aS81OHVpUllMUTRm?=
 =?utf-8?B?dndwcUhDaUUyM1gzYzlwK1ZkRzJIQXgzTTdKOWRBcE90OG80VHFTZlgxc09M?=
 =?utf-8?B?blNMRm1wQjZiQmlwdy9jT1BWUE5GZUxWYnJCQVdGWEtnUG44R044TUdRQ1p6?=
 =?utf-8?B?djlFMkt2ZmkrM3lKNEx3T2pxK0czcUVBVUtMK0dMbENleXNmT2ExZWFyOGFj?=
 =?utf-8?B?R1ZWNzdIMHVhVk1iVXlxUXk2VUcyKzQ2Z1lKaUJLYk5RaWlmUTg1SlFPMHhy?=
 =?utf-8?B?MzdWbUxiOUVneTZ3VUY3SkxEK0dUNHRLWVhCdVpnUzBRYlZ6NW9mczdBTWVs?=
 =?utf-8?B?RXljemcwbFF5eHNmS2J5aHhKTVJwaXdWM250d0lhV0NKdkcvY0FZdklvL09k?=
 =?utf-8?B?S3lSZjc1YlBzdjVZeDFxQlBnQmxXdGQ3VWUzTEpWb3FoYVNmSkM0WFRQekk1?=
 =?utf-8?B?K29NcVlHWTB6VWVrZVFzekxPdDcvbHdzKzJpdmJzOWE1OWQyNHgyckpKNlRi?=
 =?utf-8?B?TmxTaGhIYzdYWE5LNHVjcnIyVkozL3Q2V2R4TDMweXFya3BleWxPOTU2aFl6?=
 =?utf-8?B?RXMwcllEOVBqS0w1T1BEQ0w1YUVlaE0raU02bFJTN2c2MlA3M1l0NFVqcVcx?=
 =?utf-8?B?Y243b0NuYlpGY29DRDBYRFllSmxNTlp4RkpPalgxdGJHOElyQitUdEl3bE9M?=
 =?utf-8?B?YTAvSm40b09JR3dUd0IxK1FyaFE2N1NVYjRXWHcyakRKaDZzeE4rRWFxTWM1?=
 =?utf-8?B?Vko5WWNOVGZEeXVTTmx4a0dzc2NKK3ZJSkJhQVJJQVJ2NDB6ZjUxWXc0bUVG?=
 =?utf-8?B?ZFhuN3dZUzQwdFlIVUhpVjZUK3FTOHpXTlJPdHhBVEl5bG1iemwrRThxM1F2?=
 =?utf-8?B?SllNaGlPTVJueURGZ1ZUNFNweFpwcHlrMHVjRHdjK2U2OVhBbUtmTVhUeXJ4?=
 =?utf-8?B?cEVhUDc4bERQYTNFM05mNWx3b043QXBHdFRTWHJ2MklneHRxY0lzbFBGSzg5?=
 =?utf-8?B?aUtFa0xMaEdJTy9lQnBJbFhaNkNpcWFXeU9pUW96bFloNXQySTZ1V2FWaGRC?=
 =?utf-8?B?R3R1R2tBOWg5Rm8wSUFTTDUwY3JhZURYS2dXZm0yb2pYemVCcWJCQXI0UTdq?=
 =?utf-8?B?VHUwQk9TWXpET1lyV0hKQ3hYRGUvaTZVVnF6ZnZpcWpPbmIySHVQdVc0blJN?=
 =?utf-8?B?S3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7727.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e23fdd-7e38-4620-c168-08de0052cd8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 18:54:36.8395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xiJVPSYWLBBExFPhOB9+qrKcr02HOvhlFPSTufAmT3RFcAbIQ0cug2APyeskbaaQ71DqEt1DuCR/GgCupnqi5RbTcWlGxXXP+0HC4rO5QgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF0442004E1
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFjb2IgTW9yb25pIDxq
bW9yb25pQGdvb2dsZS5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIFNlcHRlbWJlciAyMywgMjAyNSA5
OjI1IEFNDQo+IFRvOiBOaWtvbG92YSwgVGF0eWFuYSBFIDx0YXR5YW5hLmUubmlrb2xvdmFAaW50
ZWwuY29tPg0KPiBDYzogamdnQHppZXBlLmNhOyBsZW9uQGtlcm5lbC5vcmc7IGxpbnV4LXJkbWFA
dmdlci5rZXJuZWwub3JnOyBKYWNvYiBNb3JvbmkNCj4gPGptb3JvbmlAZ29vZ2xlLmNvbT4NCj4g
U3ViamVjdDogW1BBVENIIHJkbWEtbmV4dF0gUkRNQS9pcmRtYTogU2V0IGlyZG1hX2NxIGNxX251
bSBmaWVsZCBkdXJpbmcNCj4gQ1EgY3JlYXRlDQo+IA0KPiBUaGUgZHJpdmVyIG1haW50YWlucyBh
IENRIHRhYmxlIHRoYXQgaXMgdXNlZCB0byBlbnN1cmUgdGhhdCBhIENRIGlzIHN0aWxsIHZhbGlk
DQo+IHdoZW4gcHJvY2Vzc2luZyBDUSByZWxhdGVkIEFFcy4gV2hlbiBhIENRIGlzIGRlc3Ryb3ll
ZCwgdGhlIHRhYmxlIGVudHJ5IGlzDQo+IGNsZWFyZWQsIHVzaW5nIGlyZG1hX2NxLmNxX251bSBh
cyB0aGUgaW5kZXguIFRoaXMgZmllbGQgd2FzIG5ldmVyIGJlaW5nIHNldCwgc28NCj4gaXQgd2Fz
IGp1c3QgYWx3YXlzIGNsZWFyaW5nIG91dCBlbnRyeSAwLg0KPiANCj4gQWRkaXRpb25hbGx5LCB0
aGUgY3FfbnVtIGZpZWxkIHNpemUgd2FzIGluY3JlYXNlZCB0byBhY2NvbW1vZGF0ZSBIVw0KPiBz
dXBwb3J0aW5nIG1vcmUgdGhhbiA2NEsgQ1FzLg0KPiANCj4gRml4ZXM6IGI0OGMyNGMyZDcxMCAo
IlJETUEvaXJkbWE6IEltcGxlbWVudCBkZXZpY2Ugc3VwcG9ydGVkIHZlcmINCj4gQVBJcyIpDQo+
IFNpZ25lZC1vZmYtYnk6IEphY29iIE1vcm9uaSA8am1vcm9uaUBnb29nbGUuY29tPg0KPiAtLS0N
Cg0KQWNrZWQtYnk6IFRhdHlhbmEgTmlrb2xvdmEgPHRhdHlhbmEuZS5uaWtvbG92YUBpbnRlbC5j
b20+DQoNClRoYW5rIHlvdQ0K

