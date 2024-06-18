Return-Path: <linux-rdma+bounces-3275-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F8190D7B5
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 17:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51C111C22E34
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 15:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D51D2C87C;
	Tue, 18 Jun 2024 15:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lb9qXHAw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39941D299;
	Tue, 18 Jun 2024 15:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718725727; cv=fail; b=Md3lpcDJIazOy+QJ5a6QLWqEiLxzfBEMz4+dNQ4AVVhIXkD2iJDcpmd1IkJw5Wds4EeXXqsTUXnLVBEMMYmJlOAA/er2OYt+l0XNcXqofCmxIO666j6kplLuICkKa1mMB74yraxulZ6DLZdVQTOxWt0SQVJkMmHcyJUO7X5bA/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718725727; c=relaxed/simple;
	bh=KIW7aE6A06Yd37h4q2rBXr+QyHJoKQZjXR+5aqu0N94=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g05RLCbXL/olAKuUfvfS7bHkGU29Htvkd8i8yse/PExebxw0QVVI7oY0UPkDtonQO6zjY3Q9bJTaqsQPd7exwnxP3V1cnmVN+vlLy/VUNK6UYjW5JPR4CWPwKnWHgU5KuqNSAtYAdK5/p7JtWoLRBWiwXvcohUMQvYHS9kfN+zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lb9qXHAw; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718725726; x=1750261726;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KIW7aE6A06Yd37h4q2rBXr+QyHJoKQZjXR+5aqu0N94=;
  b=lb9qXHAwFt3M/UGwK3HkPd3spO1Mu9ZxQAkrzP/JjRSU3CiDKc4MIJk8
   6cingdIPZtnRfIuiPSPNozQDJZNZLK/WQgt+/DGC6XlYnrjJF5XzgCZoT
   cUhn7K/i7Oq83HEkfT0G9l2Yn3cI1v/XIZuIhKAzZT6lXTVuhQ/hCGVlE
   P9//mGZ3Rg/8e56aAoU/ZSw9gq3gkYI269kjBIw8rsIWPO/rDDyZqbQj3
   kIJbD8BalrJI3LDRMtdDqnA7H6HBW7ggvUJBnCBxYLKtAwOwoORtSciFB
   MHDWqMJT6P/Euh6cZhtHRxY9jSMFlT2e+f/RjRK7mZr6lznG2+0sO2J/E
   g==;
X-CSE-ConnectionGUID: 3pesDNkDTRqLw1NDjpVHXg==
X-CSE-MsgGUID: MLUnGWpZTCS6ArPZKZkluw==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="15736001"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="15736001"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 08:47:26 -0700
X-CSE-ConnectionGUID: wf+6yBV4TZa3uPJ0ey/rhw==
X-CSE-MsgGUID: qa+TPEjyT3uPvLxiDnbYKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="72799191"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Jun 2024 08:47:24 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 18 Jun 2024 08:47:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 18 Jun 2024 08:47:24 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 18 Jun 2024 08:47:24 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 18 Jun 2024 08:47:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=naSHcmwwWrJFih2QhMdM2jPBdNydrwqY0l7Okx7suqT05m1HCEnL5X70RrUXalZEOjviszWyttBfg+WyohxFfXQMx8g8LrQyQgrweDG6DG4yrwB54WfJLn9ALc8yY6opdgkuhCb0K8WAPGXov4RwpuJxlkSuTugYPxfjlTk8BkvuoB0u4rsuenx+kT7qh3uC1yGO08ZlbdMK+46rxLchviISpdM25VZ0H7OkFJ2E/BS5Nyrwte6UflJMBA3Bun3Sd1rCNjvsPs0C1K09qIGVIp0OaxRlALPR5YsjaqL7fes1VnDJgdjHv0C2LRoP21jpW2pp5FZoYgf2WzaRbusFsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TC1vpU2wRKbAUKsEIAkbgdqb5RCAwRZOlZUIrpVqqzk=;
 b=Wh+M6oj/f8YdMm/Ye/i+5BVrS8XtrrVGoeelntsGkStsNal19sCDt8CpdPPFkaVHzRQY+kpM+B9RmA4jkGJf0QlLg24X/biQGYMmHdSe+F20lukq3RjD943K12ash75pykOgHJYT2BsT1sb4xMK38e2hA7OKoFKMKSFgDAHXNeRoFqeorLiwLx050yJ5zebOejkFHfNIVr8FsJIyu+h3CSDqlEZvNrwu7pjnDApZ1YeZncrWiEwFPkufJx9B9GWQx6lAbPyonjELNwQ++F/pjl519mrTDbz7c8A6r0H3BB6nrCgnlro3SDA9fTFh3rKn1XzetPHgR7z2qnZ0oATyWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA1PR11MB5876.namprd11.prod.outlook.com (2603:10b6:806:22a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 15:47:21 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.7698.017; Tue, 18 Jun 2024
 15:47:21 +0000
Message-ID: <ca97ec5b-9b46-4456-bf5b-37136aa7f1bf@intel.com>
Date: Tue, 18 Jun 2024 17:47:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 1/2] driver core: auxiliary bus: show
 auxiliary device IRQs
To: Shay Drory <shayd@nvidia.com>
CC: <rafael@kernel.org>, <ira.weiny@intel.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <leon@kernel.org>, <tariqt@nvidia.com>, "Parav
 Pandit" <parav@nvidia.com>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <gregkh@linuxfoundation.org>,
	<david.m.ertman@intel.com>
References: <20240618150902.345881-1-shayd@nvidia.com>
 <20240618150902.345881-2-shayd@nvidia.com>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240618150902.345881-2-shayd@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0019.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::14) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA1PR11MB5876:EE_
X-MS-Office365-Filtering-Correlation-Id: 77fbb545-e589-4baa-794a-08dc8fadf10b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|7416011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y25vRXBYTnNraVlRZE1BaUZQTFl2ZDhJdVlBVWdNS1BJbUVPaWd0M0xDSm5h?=
 =?utf-8?B?WHdSbEU5RzZZM0gvY1cwb25HVWdmaUtOM1hQbVZ5Nnpobzk5Vml3eGRsMmJm?=
 =?utf-8?B?aDQxWGZCWFNqUEd4R3VacGVDb3Rzc3d6c0Vpa0wxZEI5dGNnL0FnUnlQRk90?=
 =?utf-8?B?ZG4wdHoxZ1BxTFNkRnJLeTdMUTVKKytIUGZNR2pEZ1JZYmwvQ3VoTjRDYkxq?=
 =?utf-8?B?eFF2TkVtMVozS2NxaExPVmZUd2gwRVJJVWc4YjJ1L0QxNXE3QUlvd3p4eXRB?=
 =?utf-8?B?UmptbStRWEdCN2tYc3hXNmhXOWtxbDFycStoWjUvNnlvNGJXcHd0elRYcldO?=
 =?utf-8?B?ZUIrNk5CdXB2emFRMEhXREhrRFRqcWpMTlV2aEQwMk9aODNvUEt3Ynp0ay9L?=
 =?utf-8?B?Rk5WTTNSWGFLV3gyNDdYVlQxa3dmRzllVnE5a3NDaXVDR3lDZjA5SFJGbHhq?=
 =?utf-8?B?R05wYmlPUS9PbmhlaHg3ak9POGtFRjFUOFBGK0h4UnhGZXhKSGozSTFLME9R?=
 =?utf-8?B?a0hyOThwcUpKVlovRDFaeWNJTkZ5ODdtTkZEMHNFUCtGancyVFM0MllESk5Q?=
 =?utf-8?B?VFRyQ0kxSWxWSXdtcmU1M2tPZXFVS3VoZFhVcFZMbDZSWFZRenVjRUVhWjdn?=
 =?utf-8?B?bkxmSk8vOS9EdVpMYjNaVFc1TWg2am4xemZSREFuRFRhOFMyaVNveWNpdUt6?=
 =?utf-8?B?ZjByZ3l4N1RjenhtYUhXeVNsMlhrV25XZldzc2NmcU9oeHBhVTdHYkp2TTJX?=
 =?utf-8?B?dHYyMFFLaVlUTjd5d1F5ZnkwM21oU1Q1L0M5NU1IamI4SEtLdW5IZi9pNFlo?=
 =?utf-8?B?YTN0WXE2SGxPU2pjaEZxdFJzNk03V1Boc1VoS1VUakpucUwyRVJoRFJqSk42?=
 =?utf-8?B?eFo3dHp5bzBpMmZJMW1pYkhGNFJ3cVdtOW9nc1pwaC9IUmJTNFhKT1VlOGVS?=
 =?utf-8?B?QVM1bVd4ZEJ2M2NyeFRmVEc1dnlMam9Ha2FPVUF4aWFwRUpBNHcyYUFyQXph?=
 =?utf-8?B?SUpYdDlPTSszbXVoYjlTUDdpY3RHUUJiNWRqU2VZWDlkWWdmWUZUWmQ2QXhr?=
 =?utf-8?B?dlZEMFpoMC9oZGlCVW9aMUF0c25lT2hKTmlOUzIzMkhLK2NuOXpZM0tPaHA5?=
 =?utf-8?B?U01iYnFSRmpWYzFsWjZPVUZaTFhBSk1TdW85c3FtRW1IUWFpVnRLY2t2NzhU?=
 =?utf-8?B?Rmc5QmVNUTFzWEN3Uy9MKzVxU1NyMDFVY3RrcXZ4SEsvWHl2eE4zWXZ1YlFr?=
 =?utf-8?B?c2Z0QjNrRHVCeE4vMmVjZjlpUFhtNDd3MnlaNVlPL0czVVkvVmorVGRaTXBp?=
 =?utf-8?B?dEYyL3RFU3NKYmF6SjdNMy9UL0VTcVlsQVo0QXNyZ3A0d1RYbWZBdFNHN0V5?=
 =?utf-8?B?OENwSkxSNW5NYnRUNFh4dStCck1mWCtBbVdCVFdZbGN4NmVrSDVMUVB4Ny9E?=
 =?utf-8?B?RCtXa0VXQVRCYWlGVXd5QmVVeG1VbFFrUnhSelFMYkxPN1g1dFRYZ24xV201?=
 =?utf-8?B?TzJDU1UwQklPTnFaeXpBS1FuOGk1eUQ3a0ZkcUxoeHc5MkxQZEw0VFFPc2Z4?=
 =?utf-8?B?a0RIbkNWTE0xSS9JY2JvOVBaR1lHMlJPbG84ck5EbzUwQ0IrWDNUVEJaNFE1?=
 =?utf-8?B?U0xOYVQ0a3Z1RWRUV3BXR2U2OEpaUkZvQU5jUUZLSWhyWTQ2VnJqTEErb0xw?=
 =?utf-8?B?NUY0UC9xUlpNQUcyalVxM3NndjV3dnA4a1dpTEtWOWd2OWtWVktKb253dnBy?=
 =?utf-8?Q?VpL026CKzfkf6/iW/r6bAtekk5s2kSP/Lh++vFW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0dMcm1DSXAzWVhwWmpUcFV4MUF6SHpqbG5DemJJSzlBeFJpMG9GeGM4WkRL?=
 =?utf-8?B?YmxsMG9KZDdZdmFDYmdwN3dqL1JueUFqVGljVVhkQmF6UkZMdGpQVmhxdDk5?=
 =?utf-8?B?UnNKb1JqMW5pMk1HclJEb092R1pvNUlNQjZIYXBNZzFzZWpGRXRYaXJoVE5n?=
 =?utf-8?B?aW9XNTVVNHlsRUxwWit3Qmo5aG1BdkpqN3g2TkU0Slc0RVkzZEdyWStxV01G?=
 =?utf-8?B?dlZCbVEyaWIzRnhUR2tZbW5tSFRrejl2dDFGWG5CWXRlWkp3NzhsaytPV005?=
 =?utf-8?B?eW9ZSDFFajNoaDJ5MkowVCtxNitBVG5pcnQ4ejBRYUdGaFdZR3FGRXIvY0do?=
 =?utf-8?B?MmlOQ3Z6TllUWE9Dc0QwRXNhdllrV1N0TllkeTJxQmRJUXBycm5iMEtTRGts?=
 =?utf-8?B?RHRsVUhzYys1WkZsL3dnd2Y0dVRiLzJTYzNGUEYvRmNIRjNIdVlyRWxYenky?=
 =?utf-8?B?eGEwSU9jV0ZQOXo4N0EzZGRBQjdLRnJibVBQRnkweDdqaitVdG92ZGNJQWxK?=
 =?utf-8?B?cm1HaVFldFo4a2RQN0R1MStRS0pqN1p3S3VUaktRWmJrajFqQW5Fd3VQSjdW?=
 =?utf-8?B?dC8vZk52WTJ3bTB5Ti83bG8xZjhUbnc5ZGpwM21sTHlsU1JyVmR6ZTk2VWtx?=
 =?utf-8?B?VkpOOXB4NlppcUxkSWJJYk9samEwYW1RcW5CTDNPd2xLUjNML3FBR0x1cC9v?=
 =?utf-8?B?ZE1HNkVBS2JaMlJrdjJDOXJUQysraGxVOU5QRkhwclYzU0pIc0FDRWJBNTBt?=
 =?utf-8?B?QmpxL1JaQ3hCbXFNSURTZGthK1J1RVYrVit4SWhMR1BBVU1kSmFqd290QTRN?=
 =?utf-8?B?azVlTm9xajBHUWFKMDZhWVR6WUp0L1FzdldwMk9uZi9EbGJFWjBocDBBd2lW?=
 =?utf-8?B?R1IwSDNieXlQTWk2amxYdTdoOGZNR0c0RG8zanc0WjVFQ0ZRR3I5SVdEU0xX?=
 =?utf-8?B?RVc2aHFML0NBTTRGKytuUGd6eHlpcHZpa3ZUdUkvTkdoS3crYUdhblRPRDJ5?=
 =?utf-8?B?eWRHMjlYak44dVNqcHljdllBSW5HNDB3czFIbzJLWEFTUWx3UCtELzU0M3hG?=
 =?utf-8?B?eFRFajZIQUN0cENqTlNVQmZ4Z3FlUGxLOEx5dHVtemI5eVFXK3hVZ2h1RGdu?=
 =?utf-8?B?M3hjdjVTY1VDc2F5V3ZvRk1NSG5HTndKY09RQkJPM29xSE8yQlpKMHJIOVhF?=
 =?utf-8?B?ZU5hbU1jVjN4UDRXYXFQZERSQlcrQUlPTXY5T213azRlSFBmc2VKbG1SRU1N?=
 =?utf-8?B?MmNRSkpyd000ZjRDeU1jWkwwQ1JoZjJkY01YWW9oMU5vZEtUNXBLL1I5QStS?=
 =?utf-8?B?dGlJY2VPRlhEUE5jZXp3aW4yMTNpMTNvVHQ4dXdSVWhmRll1SlFMTjQ3SkdN?=
 =?utf-8?B?TmdMNmI4cHdaMXMyVFNiL2tqbjI2aTVMNEZvZ2F4L09yZkoydTJiUEQwNWVk?=
 =?utf-8?B?Tm44NEFFNmxiZG9ZbXA0UE82amJRQkIrMi8xTFZUbVFaanA1Y0lFSmx0VEli?=
 =?utf-8?B?NDNrK0lPaE83R2xvRnhiQWFLUzYxQXNnclA2TzFuTlVvTnk0ODJJcU03dHBt?=
 =?utf-8?B?VlMybGxNMmdqZVp4dGtiVVJ6U2NjeXlueTFDakJvMGNKNDBKZXVVcHdBQTZk?=
 =?utf-8?B?TFBqNzAyMnJ2bkM1ai9mOHE5UUxIMkhpbXNBYnEvRkF6RXViRkpSd2pGN0o3?=
 =?utf-8?B?UG5EclB0SHdIOHhHS0VZRkZkVDFERS82MEtWV0p3NzZMcExWaytGTjk5YXdx?=
 =?utf-8?B?MG9EZE9pd2hqbG5yb2tqRy9RbEcyVXBGMGdpZm40S2xOdVkvb0dwS2RUWFdq?=
 =?utf-8?B?UFlaVmdkYzQ4L1hvVzdyR21NY3QvQnZIanl4RDVHSWI0d3FvNzJVbjBuZVdS?=
 =?utf-8?B?dVFHZlMvSlIwY09FUHFZY3VVU2JpdHZVQTN6T1B5bi9tNGs5M0VnLzZLMHEx?=
 =?utf-8?B?VlZaUFkvV2V6bkh5L0E4MEN4SFcwTFQzZ3F2UDQyNVh0NFFXdHk3elBjeVp1?=
 =?utf-8?B?QVZxejc4WWMwd2FqV20yTlNKcXdxekJCbGsrcVFQaUd0a1BmNWxvMms5eEox?=
 =?utf-8?B?a2tQOWVsR3BKZ3d4d2crUGluZUpRQ1RhUmdML0dITGc3Y3E0RzZsN3gzcWlI?=
 =?utf-8?B?bEJOSk1SbzRWRk40RHBaazNRamVFdWNsNXNLbm1IN2d2YmxKMXg4dDZEVElM?=
 =?utf-8?Q?WTVl0ShLh/QnUZq0fZQ7fwc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 77fbb545-e589-4baa-794a-08dc8fadf10b
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 15:47:21.6905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SApqGfR7JDRiH8ZYneGX4K+7mEtjGWCZKaBBuyQEZe5giUEBC4UVINs/GO52H4lB09TXceNECxZD2JTNsaD87+jK2ccPCKSSgKXv8Wgsr1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5876
X-OriginatorOrg: intel.com

On 6/18/24 17:09, Shay Drory wrote:
> PCI subfunctions (SF) are anchored on the auxiliary bus. PCI physical
> and virtual functions are anchored on the PCI bus. The irq information
> of each such function is visible to users via sysfs directory "msi_irqs"
> containing files for each irq entry. However, for PCI SFs such
> information is unavailable. Due to this users have no visibility on IRQs
> used by the SFs.
> Secondly, an SF can be multi function device supporting rdma, netdevice
> and more. Without irq information at the bus level, the user is unable
> to view or use the affinity of the SF IRQs.
> 
> Hence to match to the equivalent PCI PFs and VFs, add "irqs" directory,
> for supporting auxiliary devices, containing file for each irq entry.
> 
> For example:
> $ ls /sys/bus/auxiliary/devices/mlx5_core.sf.1/irqs/
> 50  51  52  53  54  55  56  57  58
> 
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Signed-off-by: Shay Drory <shayd@nvidia.com>
> 
> ---
> v6-v7:
> - dynamically creating irqs directory when first irq file created (Greg)
> - removed irqs flag and simplified the dev_add() API (Greg)
> - move sysfs related new code to a new auxiliary_sysfs.c file (Greg)

[...]

> +static int auxiliary_irq_dir_prepare(struct auxiliary_device *auxdev)
> +{
> +	int ret = 0;
> +
> +	mutex_lock(&auxdev->lock);
> +	if (auxdev->dir_exists)
> +		goto unlock;
> +
> +	xa_init(&auxdev->irqs);

due to below error handling you could end up with calling xa_init()
twice (and this is a "library" code, so it does not matter how you
handle this error in the current sole user ;))

> +	ret = devm_device_add_group(&auxdev->dev, &auxiliary_irqs_group);
> +	if (!ret)
> +		auxdev->dir_exists = 1;
> +
> +unlock:
> +	mutex_unlock(&auxdev->lock);
> +	return ret;
> +}
> +

[...]

> --- a/include/linux/auxiliary_bus.h
> +++ b/include/linux/auxiliary_bus.h
> @@ -58,6 +58,7 @@
>    *       in
>    * @name: Match name found by the auxiliary device driver,
>    * @id: unique identitier if multiple devices of the same name are exported,
> + * @irqs: irqs xarray contains irq indices which are used by the device,
>    *
>    * An auxiliary_device represents a part of its parent device's functionality.
>    * It is given a name that, combined with the registering drivers
> @@ -138,7 +139,10 @@
>   struct auxiliary_device {
>   	struct device dev;
>   	const char *name;
> +	struct xarray irqs;
> +	struct mutex lock; /* Protects "irqs" directory creation */
>   	u32 id;
> +	u8 dir_exists:1;

nit: I would make it a bool, or `bool: 1` if you really want

>   };

[...]


