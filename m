Return-Path: <linux-rdma+bounces-15235-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E59CE5FA5
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Dec 2025 06:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5881B3005480
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Dec 2025 05:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8B91F5858;
	Mon, 29 Dec 2025 05:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="iEIXbgSs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011062.outbound.protection.outlook.com [40.107.74.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59E1C2EA;
	Mon, 29 Dec 2025 05:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766987362; cv=fail; b=udoVNDcYWRYBu6eslMf9OF0Y4a/9rzfN+CcejOa+jJfhuOaBx2Fq2zZc6h7ZdQVxrIwtE4lHUDEOS/cEer+y8RmM6vNo1JFay841td+mBnH1P8sT5hIuat9WfT6eVTo8FQxCl1L7pWb48r2XRShOXdUlMHkYk4sT5I2g2kk0JYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766987362; c=relaxed/simple;
	bh=pZ4UO0qRG9zsCGxAFctIMh+1u5fSWwTPTKUb0GEOqgo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iKWgiPD0k9WeR4DvgNhnpzKQT6MP7i7JQqFzJ+sHLm8OAGzn3JFmKQMpWhpEZCHzGG2h8cDLdyP7UZ05d4DP44qdFDFuzVQYCKfeKglqHuLbn/k98YkyIGq2hNdr8pznbDhz6TpjwpuK/HELpaPkhbuSuZJx2zc5ZzGFLQ7fNDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=iEIXbgSs; arc=fail smtp.client-ip=40.107.74.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I1T2Drfysn0OHR2hmFYXiSX/gqW5zCCcGTE62SlCNnMbxr2ZgLlp5PtZU3d1L61ZW1a+KWhSalAf0B+kUmNKKtxrahwNEZPqJff669S19FIPy5GHyNMkH5fKhsfOjlT9bKXmgvsQLEzppkSFfmn9UY7rKwmUacpH/QWwNhS/VyukBf6iVAvq3lFnKW3Fnql/03FeOsyJfzlxsznd8diIExT0uGx0Bd6HP4tSuQkNAGw2a/lULDv7sbo2cWFmtf2xjRl8shaFgzK9HI7K7jkRend++61ZiFLNmuCgCoHU94B0eDGJOxdFWA6cmJbSJXeB3eM1STYQ4x1HrnKWO0gUUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZ4UO0qRG9zsCGxAFctIMh+1u5fSWwTPTKUb0GEOqgo=;
 b=QevuG21ajkoCc5I2DVcKHIY+0/qfq8K2sGAQ0KqpSb6nxQFcD85+gn7eUnHMF2sPjFQ9/DMP3WFQZpazeUxqu7ku9CiycQ2Y3NOJv1XtwcZ/hIf4VYlK/Opo8dnudJ7XKkTzmkBp2HVKVTXarf6mm2xu8G1QsedntVdPCl1Yjfb+rFEd/BBl/b0ROmAcKnzEnHbxfqZpcU/AWewqVrab5LI7Wi8OwQ7wqsrHG+a3FbE4YSoXRffNED8+kplkk119umfeF/B2MThkkIiCyu7Qk2Q89uTjgBNfD/LfqEJMAnMMuRsTvwzHzgpE1pmUvepHDQJFofV1NjKOSiaCjxSWxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZ4UO0qRG9zsCGxAFctIMh+1u5fSWwTPTKUb0GEOqgo=;
 b=iEIXbgSs9Bszo7ClPkMtOGVxP8fd8l4xN/LcnVIJgdNtX5DEuHitqZlB8SIkYISEni6XpU8NNDnYz9GGDlPRrixfVMlSMYK9HHq9v9HiZO/9ymHIp6fuutvyykYInCsB7e9Pd56hytajStOHsV8nfJEA9Rg2Ke4fRRRSXXRZztsYNG3v9GY5DHpKHW77gtb4zxTXnoIoE6ovCG4MdlcCdjQhCuX/32fpYr+sDY/TSQlBC4MoSgzl133Q2Muy3CEvRMuu/lXBWS1XuBKJQr8Z/YjLBqnhV6+CnY7dYi4TSE/aKh21npvtDhzfYn1AH+I7ADNVNSJC0etmzrPLgGTEyg==
Received: from OSZPR01MB7100.jpnprd01.prod.outlook.com (2603:1096:604:11a::13)
 by TYRPR01MB13146.jpnprd01.prod.outlook.com (2603:1096:405:118::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 29 Dec
 2025 05:49:17 +0000
Received: from OSZPR01MB7100.jpnprd01.prod.outlook.com
 ([fe80::392e:5cfe:7cd5:92af]) by OSZPR01MB7100.jpnprd01.prod.outlook.com
 ([fe80::392e:5cfe:7cd5:92af%7]) with mapi id 15.20.9478.004; Mon, 29 Dec 2025
 05:49:17 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"leon@kernel.org" <leon@kernel.org>
Subject: Re: [PATCH] RDMA/rxe: Remove unused page_offset member
Thread-Topic: [PATCH] RDMA/rxe: Remove unused page_offset member
Thread-Index: AQHcdkvo56+NMTLdgUScOuLDOphst7U090UAgAMp3oA=
Date: Mon, 29 Dec 2025 05:49:17 +0000
Message-ID: <706b7917-28b4-4f54-8c5a-7d67729a62aa@fujitsu.com>
References: <20251226094159.3042935-1-lizhijian@fujitsu.com>
 <20a9c8d2-1151-4318-8e77-3cced4040128@linux.dev>
In-Reply-To: <20a9c8d2-1151-4318-8e77-3cced4040128@linux.dev>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7100:EE_|TYRPR01MB13146:EE_
x-ms-office365-filtering-correlation-id: 8daedcb4-d9e3-41f9-e816-08de469e014d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?TGtSN2Mvb0F3dm92NWlGdUNYdzRkb0dVZmFxbkdhbGlZZk03OVlwRzNhU01z?=
 =?utf-8?B?enQrN3l4a3k1R0c1Y00vMmw3U2hwYUlKUnp5NGtTRC9RWkh5YXZyZkpWaElD?=
 =?utf-8?B?eW9KV0RLN2k4WExoR3VCNWlMc2dCTDhJRzBkRlovNTFaRHcyaE5pcURiVFpQ?=
 =?utf-8?B?RlJpb3NJOG5EVUpPcU9ySEpIbUU0SG4wUkhxVGdoYzdxYVlEQkFCZEY3QTlO?=
 =?utf-8?B?bjg5NEkyVEk2TzdHME5DMTRCK2NrVWxDSDVIYW9ScDVzV2w0TTNXVzVEdm03?=
 =?utf-8?B?U2xrZ1dLdmdocC9CRDIxbFgzaXNPNDF0UnIxOFJRS2ZCMElCWGxSNm1Ma0RC?=
 =?utf-8?B?SWtsbVlvMThCazB5K1Y1bEE0T2JEbEliQXRIV09adVAxMnZrZHE0QXJyQjd3?=
 =?utf-8?B?OFdqbzFXVXNlMzhDRmU5YVBLSVY5ZjdmcGl5NGx6SnFISW96UVJENm9CMkFB?=
 =?utf-8?B?SWVDL21iaWFvZi93czRzSm54K1NnbkE2REd0S1kxOGxmaVZ5ZnhpSDA5YkFI?=
 =?utf-8?B?WnNrVzNGOTBKbEU3cHpub251Z3d2YzMrS2ZNYkVEbEhhMklEdkN4RnVGQWN4?=
 =?utf-8?B?bDJac2l6TFVuSlFVd3dpc0dBV05nVHdKRDBrSTJNcHFXcHIxT1BPZDZBTFo4?=
 =?utf-8?B?cVJucld2QUtjaUU0SHB2bkxEL1hCUlRoS1F4K0ZzcnZEenM4V3FyQWFEMkpi?=
 =?utf-8?B?Q29Pc083NDM4dXFFa0xvY1lTc3FwbkNyeFoxUzN4UTZOUWcvaG4vbTUyaWNH?=
 =?utf-8?B?cUtiZHB4YkQ1MllISTRzaXN0WlhQU1hlaHVkNlRld0pndEpVUTdwOXZLODFQ?=
 =?utf-8?B?NmNKV0haOEJLSm4rMzhpSUZDUmRTUmxmMndyYzhtaDQyNVBqaG50Y2tNbENa?=
 =?utf-8?B?ZGVwSGx2ak5MSzFWTWc4T2gvdHY1OG5YSVQ0UGZ0d0ZCc0pSOVFvTitzdGpy?=
 =?utf-8?B?WUoycS9pdU5hMFQwUTJqRlVNSTUrSDJ3eko1U1ZrMVhkd2FTVUpvZzdLUyt0?=
 =?utf-8?B?WHdoOUsyYkFySkNYcjlSZnBqb1M1WWFONTZ5eXQvUmhlaFVlWmMzZEtYaFY1?=
 =?utf-8?B?QkJrSlk5aWttMnQwSTlteTNucVp2eW1lc3BhU2xORDZFNjN4Z3h1MmQveHF0?=
 =?utf-8?B?NEsvbG1aVDlwME0rcHBqYWJMQUsyY0gxNlBJZGNRWDZtUWFVdWdDaFdTTy9v?=
 =?utf-8?B?cTQ1bWNESFhzMGNBM21aR1o0OXh0SGpsYm8xaDhabHdFeUsyTThOOGtsTHRD?=
 =?utf-8?B?SDJPMkVhakVuM2s4aUZlQlQyWGtsN1UyZm1ORFpZam9udGtPVjRVeHVVTGlj?=
 =?utf-8?B?Rk5vWGJoQkpmdEh4bmRxRVZFK2xJblBOUEdURFdjYXdWbGV2UGhkcEMzUUhR?=
 =?utf-8?B?SUhCY0QyT04rMWdQQlFsY0cxQlVmaTU5Q2NvaXZMcEZRRlNYRU5FMUM3bXVi?=
 =?utf-8?B?VnZvREZLUzMwanZXVXlLOHY0NzZYdXpCSGxwOFhURTZNdVQ4ZGI0MDNRTUVr?=
 =?utf-8?B?aS90ZjhWUU91N20zakw4UEVoK0Z0VVQ3K0lxeEQ4THhhcG5HbUJodVduK0xI?=
 =?utf-8?B?ck8vUnc4eVZJK1J0N053RkFIQlFaMFAyajZ1SVNoNzNKZm1CbkZGSC83Qnda?=
 =?utf-8?B?NzNjVFpFSWdybGxERU1Ia2daOGRpY0todG9VbVJmRnpKbU1sUENobUNFRHQ1?=
 =?utf-8?B?ZzMwc3o0ZHYyZVhiZVpYTFNZY09GWTFZLzY0Um55YWF3am1mL2VSVkFVaE1t?=
 =?utf-8?B?akxDVldtNGhFR0t5MEhxdHc5R0NwS3psYlVBbGRzZkJhT2VudjRWRDVGNFFm?=
 =?utf-8?B?ZFZwWHl0TktJZzR4YXlCMG9iVXU2cVFyTjRZTVUreXdKOTRLa2NONWpVb0pH?=
 =?utf-8?B?N1BvRU5TQmR6YlJRVmcyTWFhRncxYlh3TkljUGcxOFFTVW1aTjBjYWc2YTFu?=
 =?utf-8?B?MWJzcDJ2TXozUUNmWnhqMFBwZlVNV0E5MlV2RERLSkU5dVM1THFkMzgzY2pY?=
 =?utf-8?B?Ny93eTdIdzZGTS9hbzFQSmpvbWxnR2t4K0dWNFBTQmwzNjUrZHlPbnp2WFVp?=
 =?utf-8?B?bW1veWJteW9JYzFGYnVnVnY3WVlLenRMa0x4K1Q2NlBQVnNnMDA3TFZXUzdt?=
 =?utf-8?Q?gOCI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7100.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Zy9wcE1JalI5eFAvMGdMdzlYZ2xhWWp2b0RZQnlvU1B2UVJFQU1BUmVzTWFS?=
 =?utf-8?B?NDROQUE1dzhGMzBidkVVSExNUEVxZEJMQWZxVC9wVzExeU1IemM2NDAvQ2RR?=
 =?utf-8?B?bjRmK29YYm5SQ01LY2M5KzB3eWdqejFPTkJuc2I0Y3JVZityRW9YQ2JUdjdP?=
 =?utf-8?B?MlFGK09aN3BreExIVjEzRU5nd01xeENEcjhmQWZnaVVnVUcrN3g0S0dpcjRY?=
 =?utf-8?B?NDMvUW4rMHNrVEd1ajl0RG9OZlU4cE96Y1NoK3ZOU0xVRytGaHB2a1czamdL?=
 =?utf-8?B?Qk55dm0zTDg2WC9HQkV6M29LbENibm1iMG1MYjlIS2dlS2loV0NXMTA1azFC?=
 =?utf-8?B?LzRzcVl4L3EwNUFJbGVYZEJOOXZqSEFPM1FrekJUYzRDdTdlemo5R3lvdVh5?=
 =?utf-8?B?ZFpkSFJOQllVcldkdE9EYy9ZcmZENzlhcGpsZjVLNW1tc1JRS1g1RjZDdzA3?=
 =?utf-8?B?N0piZHRWYmthc2JRQ2JwQUxOZ0RNWG8xZ0JQazJsQWFZa0lRb1hsUHFtdkRJ?=
 =?utf-8?B?KzNRa05TVmN5R09DeFBObHFrTFphVGIxUWxuQlE3VU1kTWJwT1JVYXl0dFBK?=
 =?utf-8?B?QVdyeWFTbUZZY2RWQzF6NU9QV0JjVWVSdXcxOXRNUktLeWp2ZWZmeFdMSi9u?=
 =?utf-8?B?ZkJxYmw5L3NkN09Id1ZKb0wydU5DeFpweFN3ejVKa3hGQ2JBQnorZGQ1UzZB?=
 =?utf-8?B?OUhWNFk3akZQWW4vSklBRnFabVZpZEVkV2krWE14VlphcHdoMGFWNGhaSFpI?=
 =?utf-8?B?dGZuMUpFdVRDTzZZY3FtS2FYaERhTmNNWUE4T2szZEJVVU9uaG8xYmJSMGNn?=
 =?utf-8?B?T2h2WHpRMFZiMkZzRmNxYkcxZVlUMk9nRzhZek1PNTBoV29HaDlKVXorZkhz?=
 =?utf-8?B?aFpBS0Rzd0l5VWYxWmpONHpvQmcwQ0N5amFUaTFtWXFGN3RPcThYVDBQOGZV?=
 =?utf-8?B?OWNFRHlsbFpUbGtJMFpCM2JPcWlTNzlGYkxpbWgyUWE0OHNSd2lHcjk4OGtk?=
 =?utf-8?B?WEZ0ZkFEbDJRWmFVVUdWOVZnQ0o2WEl2d1d4MEV0bm9Cbzg2Ynp3ci8xdWhB?=
 =?utf-8?B?SlZDOWhJMGkvODArR0FLUXAyMUd2eHBMdEJpeXd4NHRjTFlzZXVPaVozNDlM?=
 =?utf-8?B?U0V4QzJsQWdScU5VTEVyRTVVaFhPQ1pYVlBHcDBFMjAzMmJRc0J1ay85UWpt?=
 =?utf-8?B?dW9pQlRLVGFLbGF4RVQxU1RXSm11d3ZFWWFnbW5BbVdSM3U3UmRLNjEreFgv?=
 =?utf-8?B?S0JoOWZCaWJPOE1kL1FRUU5qKzFGS0s4dTdHK0h4L2Jrc1FrUjVFbmJxT0dv?=
 =?utf-8?B?a3IyOXE5QU1tenE5NkN4a3lNR29abngxa0h0dUN0cnE1aDB3dmpodm95OXBz?=
 =?utf-8?B?Sk52SVNheGFpOUc4NlNnTkhIZ2xiMHFjSCsydGpwQzhnQmg2UThqckwrN0RF?=
 =?utf-8?B?Y1RhdG51TlVkaXBYZ1pTS3pvN0R1RVZ4RHhxZ2NUdVFLM0t2YXdSV3JjanZX?=
 =?utf-8?B?SVlEa0ZqUFRjN2hvSzAzTzdkV3BxQ01HZFI5TkZJcVIyT25Dd2NBdk1GbVpT?=
 =?utf-8?B?NWZ5TEd5a0lzQ0gyeWlwenlSejkyNGNQMVhWWTgvVHhiMjhtd0ZpK2o1MVBr?=
 =?utf-8?B?YUh2Rmp2dGJmaWkxYTBDWWpMRHhubmZHYVdndWhQdll6U2l1SlJtWGpXMFNI?=
 =?utf-8?B?Y1IzUHlHM0s2dDBQNjRkTjB1Z3ptaXlSK094WFA0K1MvUDV2aDhmeEVzbXVp?=
 =?utf-8?B?VENzRmhDeW1nZEtTUTliVm5hZ2c5QlVZdVljTjdlRjdBeHRucGxBc2xFNllR?=
 =?utf-8?B?RzZsYmZFU01Bd1c3TktkVHRUZUxwRmxFUlNTNjFZNE5BSWF0Unk0dStOSjly?=
 =?utf-8?B?Z1QzUnc1VCswUXpzQXVEMVRwRUtkalcvVHBFSW1qczhWNy9YTjZ0ZVl3RDdu?=
 =?utf-8?B?Y1dKdno5TTBKWTk2VS9ISElmbU9McWhPZFdkN0Qwb1dwa0lBMHI5SnlIdWpF?=
 =?utf-8?B?SUU2SHhPMWJXVGN4c2pYSThPeDEwZk1GUE9WREh5R1VadXlDdUFQMWs5RWU5?=
 =?utf-8?B?Y2g4RFliY04rcjYrb0hadnlSRWZVd0lmQWJZaFZsdWN0UjVpOTkyZXhMN2da?=
 =?utf-8?B?ZHdHYk96WmttQVVzckY1SkUzYXp2eEhtRlY3K3VSekl1dHFseGNXcHNvUEg3?=
 =?utf-8?B?ekVUY2lZb3lqcUIzdFBTUTZKZmp4R0lWbnZCV2tBOW5zRDhiVkg5Zlo1MTFE?=
 =?utf-8?B?ZHRjeHpaNExzZXEzQVlkWFV4dkNwTG9GNkQyazFGR0k0aDA0MWg2R2JXM3ZT?=
 =?utf-8?B?VTh0RDN1MHVKVnJiL0xISlZSS2lJd1FTaGNRK1BMeDRIeVVkSytXdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5EA0C0C896B99F4C8B2116298A6F1EFA@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7100.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8daedcb4-d9e3-41f9-e816-08de469e014d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2025 05:49:17.3730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QI4+zRlV4c2eZnd8uIWdx28N+W7px8bmDIvKfzj6ccAR54ZmzZNYtghx2FBNqnemdoSnMv9UR7NLdsW0zQ8bVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13146

DQoNCk9uIDI3LzEyLzIwMjUgMTM6MzAsIFpodSBZYW5qdW4gd3JvdGU6DQo+IOWcqCAyMDI1LzEy
LzI2IDE6NDEsIExpIFpoaWppYW4g5YaZ6YGTOg0KPj4gVGhlIGBwYWdlX29mZnNldGAgbWVtYmVy
IG9mIHRoZSBgcnhlX21yYCBzdHJ1Y3Qgd2FzIGluaXRpYWxpemVkIGJhc2VkIG9uDQo+PiBgaWJt
ci5pb3ZhYCwgd2hpY2ggYXQgdGhlIGluaXRpYWxpemF0aW9uIHBvaW50IGhhZG4ndCBiZWVuIHBy
b3Blcmx5IHNldC4NCj4+DQo+PiBDb25zZXF1ZW50bHksIHRoZSB2YWx1ZSBhc3NpZ25lZCB0byBg
cGFnZV9vZmZzZXRgIHdhcyBpbmNvcnJlY3QuIEhvd2V2ZXIsDQo+IA0KPiBIaSwgWmhpamlhbg0K
PiANCj4gV2h5IHBhZ2Vfb2Zmc2V0IHdhcyBpbmNvcnJlY3Q/IENhbiB5b3UgZXhwbGFpbiBpdCBh
bmQgYWRkIHRoZSBleHBsYWluYXRpb25zIGludG8gY29tbWl0IGxvZz8NCg0KDQo+PiBUaGUgYHBh
Z2Vfb2Zmc2V0YCBtZW1iZXIgb2YgdGhlIGByeGVfbXJgIHN0cnVjdCB3YXMgaW5pdGlhbGl6ZWQg
YmFzZWQgb24NCj4+IGBpYm1yLmlvdmFgLCB3aGljaCBhdCB0aGUgaW5pdGlhbGl6YXRpb24gcG9p
bnQgaGFkbid0IGJlZW4gcHJvcGVybHkgc2V0Lg0KDQpUaGUgcmVhc29uIGlzIHN0YXRlZCBpbiB0
aGUgbGluZSBhYm92ZS4NCg0KQXJlIHlvdSBzdWdnZXN0aW5nIHRoYXQgSSBzaG91bGQgYWRkIG1v
cmUgZGV0YWlscyBhYm91dCB3aGVuL3doZXJlDQpgaWJtci5pb3ZhYCBpcyBjb3JyZWN0bHkgaW5p
dGlhbGl6ZWQ/IElmIHNvLCBJIGNhbiBjbGFyaWZ5IHRoYXQgaXQNCmlzIGFzc2lnbmVkIGl0cyB2
YWx1ZSBpbiB0aGUgaWJfc2dfdG9fcGFnZXMoKSBmdW5jdGlvbi4NCg0KDQpUaGFua3MNClpoaWpp
YW4NCg0KDQo+IA0KPiBCdXQgcmVtb3ZpbmcgcGFnZV9vZmZzZXQgc2VlbXMgY29ycmVjdC4NCj4g
DQo+IFRoYW5rcywNCj4gUmV2aWV3ZWQtYnk6IFpodSBZYW5qdW4gPHlhbmp1bi56aHVAbGludXgu
ZGV2Pg0KPiANCj4gWmh1IFlhbmp1bg0KPiANCj4+IHNpbmNlIGBwYWdlX29mZnNldGAgd2FzIG5l
dmVyIHV0aWxpemVkIHRocm91Z2hvdXQgdGhlIGNvZGUsIGl0IGNhbiBiZSBzYWZlbHkNCj4+IHJl
bW92ZWQgdG8gY2xlYW4gdXAgdGhlIGNvZGViYXNlIGFuZCBhdm9pZCBmdXR1cmUgY29uZnVzaW9u
Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IExpIFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNv
bT4NCj4+IC0tLQ0KPj4gwqAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfbXIuY8KgwqDC
oCB8IDEgLQ0KPj4gwqAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfb2RwLmPCoMKgIHwg
MSAtDQo+PiDCoCBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV92ZXJicy5oIHwgMSAtDQo+
PiDCoCAzIGZpbGVzIGNoYW5nZWQsIDMgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX21yLmMgYi9kcml2ZXJzL2luZmluaWJhbmQv
c3cvcnhlL3J4ZV9tci5jDQo+PiBpbmRleCBiY2I5N2IzZWE1OGEuLmIyOGI1NmRiNzI1YSAxMDA2
NDQNCj4+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX21yLmMNCj4+ICsrKyBi
L2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX21yLmMNCj4+IEBAIC0yMzcsNyArMjM3LDYg
QEAgaW50IHJ4ZV9tYXBfbXJfc2coc3RydWN0IGliX21yICppYm1yLCBzdHJ1Y3Qgc2NhdHRlcmxp
c3QgKnNnbCwNCj4+IMKgwqDCoMKgwqAgbXItPm5idWYgPSAwOw0KPj4gwqDCoMKgwqDCoCBtci0+
cGFnZV9zaGlmdCA9IGlsb2cyKHBhZ2Vfc2l6ZSk7DQo+PiDCoMKgwqDCoMKgIG1yLT5wYWdlX21h
c2sgPSB+KCh1NjQpcGFnZV9zaXplIC0gMSk7DQo+PiAtwqDCoMKgIG1yLT5wYWdlX29mZnNldCA9
IG1yLT5pYm1yLmlvdmEgJiAocGFnZV9zaXplIC0gMSk7DQo+PiDCoMKgwqDCoMKgIHJldHVybiBp
Yl9zZ190b19wYWdlcyhpYm1yLCBzZ2wsIHNnX25lbnRzLCBzZ19vZmZzZXQsIHJ4ZV9zZXRfcGFn
ZSk7DQo+PiDCoCB9DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9y
eGVfb2RwLmMgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9vZHAuYw0KPj4gaW5kZXgg
ZjU4ZTNlYzYyNTJmLi44YjZhOGIwNjRkM2MgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2luZmlu
aWJhbmQvc3cvcnhlL3J4ZV9vZHAuYw0KPj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4
ZS9yeGVfb2RwLmMNCj4+IEBAIC0xMTAsNyArMTEwLDYgQEAgaW50IHJ4ZV9vZHBfbXJfaW5pdF91
c2VyKHN0cnVjdCByeGVfZGV2ICpyeGUsIHU2NCBzdGFydCwgdTY0IGxlbmd0aCwNCj4+IMKgwqDC
oMKgwqAgbXItPmFjY2VzcyA9IGFjY2Vzc19mbGFnczsNCj4+IMKgwqDCoMKgwqAgbXItPmlibXIu
bGVuZ3RoID0gbGVuZ3RoOw0KPj4gwqDCoMKgwqDCoCBtci0+aWJtci5pb3ZhID0gaW92YTsNCj4+
IC3CoMKgwqAgbXItPnBhZ2Vfb2Zmc2V0ID0gaWJfdW1lbV9vZmZzZXQoJnVtZW1fb2RwLT51bWVt
KTsNCj4+IMKgwqDCoMKgwqAgZXJyID0gcnhlX29kcF9pbml0X3BhZ2VzKG1yKTsNCj4+IMKgwqDC
oMKgwqAgaWYgKGVycikgew0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9y
eGUvcnhlX3ZlcmJzLmggYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV92ZXJicy5oDQo+
PiBpbmRleCBmZDQ4MDc1ODEwZGQuLmY5NGNlODVlYjgwNyAxMDA2NDQNCj4+IC0tLSBhL2RyaXZl
cnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3ZlcmJzLmgNCj4+ICsrKyBiL2RyaXZlcnMvaW5maW5p
YmFuZC9zdy9yeGUvcnhlX3ZlcmJzLmgNCj4+IEBAIC0zNDcsNyArMzQ3LDYgQEAgc3RydWN0IHJ4
ZV9tciB7DQo+PiDCoMKgwqDCoMKgIGludMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYWNjZXNzOw0K
Pj4gwqDCoMKgwqDCoCBhdG9taWNfdMKgwqDCoMKgwqDCoMKgIG51bV9tdzsNCj4+IC3CoMKgwqAg
dW5zaWduZWQgaW50wqDCoMKgwqDCoMKgwqAgcGFnZV9vZmZzZXQ7DQo+PiDCoMKgwqDCoMKgIHVu
c2lnbmVkIGludMKgwqDCoMKgwqDCoMKgIHBhZ2Vfc2hpZnQ7DQo+PiDCoMKgwqDCoMKgIHU2NMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgcGFnZV9tYXNrOw0KPiANCg==

