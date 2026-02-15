Return-Path: <linux-rdma+bounces-16896-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBQcMnK4kWnPlgEAu9opvQ
	(envelope-from <linux-rdma+bounces-16896-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Feb 2026 13:13:38 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D1F13EA2B
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Feb 2026 13:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02F263011069
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Feb 2026 12:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F31D2EC0A2;
	Sun, 15 Feb 2026 12:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FOF5Uhje"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011039.outbound.protection.outlook.com [52.101.62.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98E12D6E6C;
	Sun, 15 Feb 2026 12:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771157599; cv=fail; b=b7yIGhRay9BABQLXwX/0farLFZqhelkXBrNkUHPlkTzdgtzXL2zkuxsQbwmeB1UpyxvtmgYDmBj8e9+kOFuJkxOPcxRdLJ90aZRTu8+qQJjde/sXkcCwYmixkAM+8/kkskJw0rlRAKcA30eOzsk0ArKN1TGXbg1cJF7VFw6MlAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771157599; c=relaxed/simple;
	bh=+ATwRWXxBfK+6nFMPOlq8M2ULqvKQYgKk6giSdgfugs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o5Uft8gfICq3aYQjm1T2RQhAM8AMZLAgJ2Ded+8FpDYvs3MH+X4ucXut+BNNslIr3sIn8T7Be6ruhfrzyHJ3kOmAU4W+YOVJHzoJC1X+1hXHgHJ6KqrdAqhSGooZJ1ByikcZtogXQNyKN8eXhqSElLvn8rCu3PkcoSzSm931eMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FOF5Uhje; arc=fail smtp.client-ip=52.101.62.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VjXPE71SZwnVk6pRZCmv72OdeiKfK5leIokZ09ySh4vHvg1pGfN69jFCRlQT2qHpGbOSRpQBalSX2p4JjGqldO2KlesBW3mLKXNLnOmcimSggcAt62Pno7aqshvjLScACLZPhnI8bLiz+Z4f3QFW501D5JA19LqcObwWeS4u8o5cfrNuOodnYRCB0csQTWHYoaTR5sTQ/jnx73VjR1lfBw9nM2NM0s/1u6y5RYgxSG60fiRu4AZzJq0RvgHOkxG6t7qtcLpNHkDj6u3NajLiEjsUNfLkZADQlDa70Lxw8c+cn1Jr3zNYHyJ2VFe0RSOIw1Z6TAC5bsAa2X+bTWv8xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UElSYgmlvg2YT9wyYgZ/73ySbcemq+aq6+NZDru8eMU=;
 b=Y253yafVZjzF/xFvBVissdmfCkCFkpNjUHxmRGf7HqPiYs61/FBQtrepllTYt47p4kxIY00Q0+ZDTZF+MWcOILMtkRbpU8Muxk7AZYrF28oflW72WYzJAJB5zqWM7iNrAXHuFxokhgHTqO40UO8yHGPnv27ssni9/X9TRQ9k8N37p6357RoF4asyxMjzBOYLSI9OjSMRehYZ4bYSAQ7IllCHkL6+be4/vI8DmcAQqF6JzomSCHQTGj/78+VVZcgvU15P+VrhZgfQt9283jS8VpUmRHWnGGYjOoOC2/hUlx4uMSkzGrfc0BnD2s9RNuwXKNrB0xuPfgFgXuuVRVsvVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UElSYgmlvg2YT9wyYgZ/73ySbcemq+aq6+NZDru8eMU=;
 b=FOF5UhjeaPsogDSKu44fW/S8eZW/rR7R7c9Eprl/Bww+8eWqUmF77MZjZwxFvJUqsNMzTkuyrt9km4Cf2aq7rfzz8o4qqcOEBlSz+ljQSZezFRY9xt/lT2Yzknh/FW93rEMkaHarjpSVwQgqRMxuIw9Am53IpVpXIjCeZf9zmLDNWku2CZaDZOk+4dK1nGj/zktfHiGOXsT9EWOZpTsBvIv8Y3zgejn+THqVfN5ubtGTPzenI8o5M+PZwL49WL9u+Hf+lOdP87xMZm5kdD5qEYeqAU8+01HtiKEiCKffSohtuzOSLgJWCEXe44oPXoPK+G2o2Eh069ogwtQ6HmWJFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB7003.namprd12.prod.outlook.com (2603:10b6:806:2c0::10)
 by IA1PR12MB7712.namprd12.prod.outlook.com (2603:10b6:208:420::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.15; Sun, 15 Feb
 2026 12:13:15 +0000
Received: from SA0PR12MB7003.namprd12.prod.outlook.com
 ([fe80::4099:396e:1f40:169b]) by SA0PR12MB7003.namprd12.prod.outlook.com
 ([fe80::4099:396e:1f40:169b%4]) with mapi id 15.20.9611.013; Sun, 15 Feb 2026
 12:13:14 +0000
Message-ID: <197ef473-b649-421f-bdd6-79f9df1d6dc7@nvidia.com>
Date: Sun, 15 Feb 2026 14:13:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/6] net/mlx5: Fix misidentification of write
 combining CQE during poll loop
To: Jacob Keller <jacob.e.keller@intel.com>, Tariq Toukan
 <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Moshe Shemesh <moshe@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>
References: <20260212103217.1752943-1-tariqt@nvidia.com>
 <20260212103217.1752943-3-tariqt@nvidia.com>
 <8d3b2da8-e13c-49f8-a8a6-3aa5b307dfe6@intel.com>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <8d3b2da8-e13c-49f8-a8a6-3aa5b307dfe6@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0167.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::15) To SA0PR12MB7003.namprd12.prod.outlook.com
 (2603:10b6:806:2c0::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7003:EE_|IA1PR12MB7712:EE_
X-MS-Office365-Filtering-Correlation-Id: c767ba6c-0080-48f3-08ee-08de6c8b9865
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDdnSlUySDZlVE1WZGNNZDFTVGdDTDltL0htcjROOTFYSEpreHYzT3I4TVAy?=
 =?utf-8?B?bXlKMDRwem05bkpDSnN6eWIyblJmc2FtalB6ZFBNaDY1UVMxcTVXQjFuMUVm?=
 =?utf-8?B?ZHpka1hXcjBHNDYwSUgzVm5BZ3NWU0RHczhPWlB6c2RpNVFDUVAzV25yTVJs?=
 =?utf-8?B?NEUzUGtkNzlBUlllU2FId3N0Zng1dllLUnhUa3VXUHN1NjhOSnUwcUpKV0V0?=
 =?utf-8?B?YWNTQm1MOCt2VGZjQUtBMlhyVktEcUhmS0tYSDhwc1VpR2d3L3JHdUpyS2R4?=
 =?utf-8?B?QmhyTWFCMmVYZ3lidkJCRmtrOUh5QWNUREwxMTJMVkllZ3dzWmlsS0duQTl5?=
 =?utf-8?B?VDdic1Q5bUJRaVVzbTZYOHVtUE1ZU0grQmxkM3ZUT0pHcTh3QURib21pcXRQ?=
 =?utf-8?B?QXIwbEx1NzJkcVQvZFFpajJlM05IZHpncXJKSnZjZ2pyNUY0RmJ4NEQ5K1BO?=
 =?utf-8?B?b0RGK1BPTjNnczZZMzNrSWtIZkpzV0hkSDNqS2pLS0ZmUFdwZFlCVU5QZlBI?=
 =?utf-8?B?cGx3MWpnNWVINHUrbmdvYk5EeC8wVFRUSEN6d0pCbTlsRFJtNlgwNTJFNlp6?=
 =?utf-8?B?SE5aakpqRG8rYi9ZcTBJL0tzTTVmYnNtSHlqU2FxSkZkd1ZBOVN1N29Da2JZ?=
 =?utf-8?B?UFAyU1ZLTndFN3dZYWd2V0tVZS9JbzNBdEhycGNhSlpENDR3V1FvbExtUW5i?=
 =?utf-8?B?V1F0cHVPQ0VEdjJvYnNZb3BVZzRmMVFVWW13cmQ3MjJxOFo4RnBjK2VZSFg4?=
 =?utf-8?B?ckpUNW5qNFdQeW0xbklrY2QzVXB4U3pHOXUxdU44WnArUWxkSlRhYTlzZ293?=
 =?utf-8?B?VXEwamQ3NVRyRTRkMFY4eVVCWWhjT1VMUEkwUFUrVC9uYUJvclhlcXZVNnJv?=
 =?utf-8?B?L0swTko1b2hNQmtRMkR5S2RyS05wM1k0NzhsUmE5dzdnZHRKYUQ5UHE4c3NN?=
 =?utf-8?B?Wm80bzg5MkFNeWlVbW1QcXFZY21LMTlQUFdXQXdPR1IvRW5IZFJWZy9Ec2I0?=
 =?utf-8?B?aktwc0liT1hURlEwWlJOMTl4ZG1JR2xxS2pDeW5JMEdCci9yQURlVGFpb1RT?=
 =?utf-8?B?emxPbndoYmNuclQvbXRzUGJMMkZoSXQxUnFySlVhL2pJaTVxejI0eGpqR1pl?=
 =?utf-8?B?QkNWTklvYjJreEZRTFdQYlc0UVVJUW9LVG9Valo1TmU1RWNpa1Zhbkp0OGFv?=
 =?utf-8?B?cko3T0JyRDRYR2hZRDNsSU5ETm9WM0FXVTdER3grdEtwbk5zZ1phZzJGNm1z?=
 =?utf-8?B?aEFwdW5ucy80Y1NEWUFzS0RVaVdXUDU1L0p3bXg2K2VKdW5SS1dGQSt1NmxG?=
 =?utf-8?B?REduNGNtdnRYTVpVZFhrRHd0VGl6UGIxZUlubm9vRjkxTW1RVU44UVYyV2Y5?=
 =?utf-8?B?bStYRTlURklUZWJ0YU9naTBmNG1ZM0x0QWx5WStXbHRpNXRmZWphMzUrTHJZ?=
 =?utf-8?B?TGwxTVorVXUyTWFxaU9UUGV4T3h5eEhGVmY3UGVQcm5kZ0xxNHkzQ2p1M2Zw?=
 =?utf-8?B?SWpKdHJFTTk3UkZwMzdORHp6aUp1Z1JzOTRFa2QwNnNGcnRkUDVPRjN4N0Vl?=
 =?utf-8?B?QTBFbTRFVlZ0MXhPSEFldWdvczNCQmw5TlU0bXhWaU5NU0xGVDU3TjMvaklO?=
 =?utf-8?B?VUd4dW5mYWJndTBVVlZ4OG1OeVRmNm85MUFlSTRWekViVWFxOTNEdCtxcm5P?=
 =?utf-8?B?RDQ4dnVkMkI4ViszVkJOR1JNMkFpSXI5Z3lQbjZjMzBYd0k5L3VtTnZqYXd5?=
 =?utf-8?B?NVBpUHRhWmZKbWJjK2tNMTZ4c1RROXB6cFBHSXFnK2IwdzlpSEdPWmpiUEg3?=
 =?utf-8?B?UE5rVXdRc0o0c2Z5QjJJZ2xKS3EyN3I4RzBlMDhqRVJqc2dwZlFia1ZnZUpy?=
 =?utf-8?B?MzEwQ2hsZFgxeGxRSTRjdlN1T2V2K29ickYxdDk2RUMwN09wakpjelRXZG80?=
 =?utf-8?B?YVc0UjkxZXZxUGdnUDNrSUJEbkJESkpzd1p2cGlKc3BrL2RheFZBM2R1SXBz?=
 =?utf-8?B?OFpIeEoyL0RYRTkxTVc2NklyaXZtVW91VjAzYWxyejNSUVJHL3BkWGZaRXRr?=
 =?utf-8?B?QnVJc2hySTRIQmlTQTJja1NIU3Evb2NoQm5nNlR5YWNWd21BVkFWeHpCQml6?=
 =?utf-8?Q?gKH8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB7003.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnQ3VGZBYmJpSWp1YkZRN3VUY3RrWFZUWWd3dTQ0M1l0cXkybnhxMkgrMXI2?=
 =?utf-8?B?VUJadUdLZ3VOYlJFRVQwZWgxMkxIV0thS0VsVEpWdzdCMndQQXc4TWJPMWV0?=
 =?utf-8?B?TzdaaXczUDB1bDI3ZjRKUW9DS0ZQY05XS2pzRjluNzNFa0FaWURzZDhwOFZr?=
 =?utf-8?B?V0FzcjRlNm9kSkg1cUQ0ajZJaWNnSDd1TzFXSmZoREhoeGsxRjhwTDM3MS8w?=
 =?utf-8?B?ZWdHTWtFVm0yZGZtWU0wOG9IQ2hyNC9JaEJRbTE0STJCWW5CM0tNYzJvMXJw?=
 =?utf-8?B?cFFVSm9jblNUb1lJMWJZVHZYajV4WG1aT0QyVFlJUFNvbnB0dXJXdEIxVVFv?=
 =?utf-8?B?eE9HaWphbFl4Mzd6NlRWZFhnNEYrRTd6L0NDRmJGTWlOb3ptNFBSeEF6OGVJ?=
 =?utf-8?B?dEdOQ2U0NHRUKzBpQmt2MWZ3K1N4WTEzeE9nb3RGWXJ1em1Pc0lGajdIVDV1?=
 =?utf-8?B?SXFGaExwY3BaQzdvdEtyL1Y4RnhPcFNrc2hha1NMeVNLZUhvWWxQdngwd1Rk?=
 =?utf-8?B?U2pjOU54bm9FNmRHU0JYc2lmeXJnclFzaGxGYWJaTjZkNENJc3JnUWF5Y285?=
 =?utf-8?B?bERxM0lrVCtTUi81d0grV0c1d3ZvWkxNS3c4Szl4Z0tKUlpRTzQrK1I0RnEv?=
 =?utf-8?B?Wkt6dGowb2Jma2s0cjVrako5ZFNEeVFkdzFJSkVvQU5CZXFpd2h2czJqMzNW?=
 =?utf-8?B?TEVGd1lFRzZlS2kxdm04b1J5dGZYVFFRdXZMc21tRDJ0Q0xTNVJoQlVNdC9K?=
 =?utf-8?B?dmFIYm5QdVQyeU9XNUU3Y1JmZnRyZ24wNFJrYzZRUE5sZ3Z5Y2dWbmxFekU3?=
 =?utf-8?B?S3dxRjFCNXFxUWFBbUpzdk52b2dLYlgydWdaS0JsQ2Jrd0l6SEFkeDU0Nmw3?=
 =?utf-8?B?ZGg3dHFIMVVySTlrUVNSSWN5RktVRXZaTFE0bjNwY0FoREUvb1ZyeFhCQWRI?=
 =?utf-8?B?cVZpZ3hSeGg0TFArSFd0Rk5PaHlOc1F3bFg1Rnk2UDVURGpab3FPMUJWcVlH?=
 =?utf-8?B?cnNMYXVMTC8rTStmMXFiQm9PV3N3RU9Hd1BxVEFmVkgvblI3bUpPakhBTUl5?=
 =?utf-8?B?bHpXK3ZsbS9uL05Ld3VpUVpHdEwwb2VyVklkelROQTg3WkhFRTRkRkJmSncr?=
 =?utf-8?B?NldMREltUmY3Z204bWZ1UGJ3TUF0UGVod3VIWDViRlJOTEd0MS8yUTFMSllK?=
 =?utf-8?B?aEgwcUZlWGc1Um9BU25DcnJuOEoySk1EZGljU1R6dmNMS2IwUEJLUDNpM2Ni?=
 =?utf-8?B?akwwTnFBVy9mVnI5TTVUQTBpdC9kaVpISGFHeGd2WkZaS2p3VmRybFRFV05a?=
 =?utf-8?B?cjAvN1F6anR2UDVzd0JLOTY2ZDFaUUYvU2NwaEFGUlRjTDBUalpydnlwOHNH?=
 =?utf-8?B?YnVVQmdKR29sVEw1dFNaTzFZcWtmYmdzQnd6TFl3c0JwWVZ4b1dCUlo0Q3JI?=
 =?utf-8?B?a3d6c0NWeENzK3YxK3IydUR0T2JxYy9veU1pT2x2b3JrWWxOZE54RWhBVXZa?=
 =?utf-8?B?WU01bEUxMEVuR1M1aHhBeHh3eUMwVWJGL3dOdU1odWpOam83bmZZbmphOGdN?=
 =?utf-8?B?QW1zajBuNWRKQk9teFlyWUEyNGtoN3NIbFdYU1E1Y3pIbE9lSXovOGlxQ3Jh?=
 =?utf-8?B?dVRmem93U3FGcDdUN05telpSbG9VcU1rRkNveTh6NVRVWkhBOWlPeDNNT3JD?=
 =?utf-8?B?SXd3aWJ0MG5CbmF5eVg2MDh0TWhhN0ZnUDhvd2NvY0grU2ZCTUlXc2lVOVRr?=
 =?utf-8?B?cEFJTDJzMDVDTTE4WnpTTVZsbElYYjJJVlhtTCtKSUM5b1Vvc2xwZ1ZVaVBi?=
 =?utf-8?B?YlBlZnZDdEdIaDA3bmMzSzdDR05CaXRzNEF0czZWTEVOWG85NU9JcVYrRUpV?=
 =?utf-8?B?UHBHZUU1NTB6MFJ6NnlmOWpzUFlxdGMzNE9GclBqZ0U4NTFocjkxbllJbUhu?=
 =?utf-8?B?S1lBNzlJUUZBZWM1Uk80SnJ0Y0E2a3ZHQ0QxZDVLNk1tTVpnWDE0cElrTFlk?=
 =?utf-8?B?MUw5WldQNk9DUXlLcXFoMVF4ZU9nZzlvVEt3K01jR0dPQ0dTbXprVXZCdXlR?=
 =?utf-8?B?enlKSnF0NU1IQVVYL05qWVlqMk5nc0NVemdGUjlPYmRrcldUeDk5NzA3ODRj?=
 =?utf-8?B?ZVZZdWh6VW5VTjhaUmErdC9MNHM5bFNhMzdWZGlidjlMREJ6NVFNYlp4OTNE?=
 =?utf-8?B?N20wN0ZYSmVIdVF6OWJ4Ui9BcEF6OGRaUDFVczNpOEVKdTc3TmtaeVBlUDJD?=
 =?utf-8?B?YWlHU1c5UC93cXU0L254WWZ3TXpFMkR3RW91UWFRZTQ2b0kxQnlEODQzMy9t?=
 =?utf-8?Q?ZuEGIXKMubDH1I9R3h?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c767ba6c-0080-48f3-08ee-08de6c8b9865
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7003.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2026 12:13:14.8754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AxofMfj0hd2D9E5fs+nS6r5/yCLfZWW8wpu73N0XWomM+528bcCGZY+2yeqonn4H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7712
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16896-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 35D1F13EA2B
X-Rspamd-Action: no action

On 13/02/2026 0:36, Jacob Keller wrote:
> 
> 
> On 2/12/2026 2:32 AM, Tariq Toukan wrote:
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/wc.c b/drivers/
>> net/ethernet/mellanox/mlx5/core/wc.c
>> index 815a7c97d6b0..29db15c4b978 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/wc.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/wc.c
>> @@ -390,12 +390,10 @@ static void mlx5_core_test_wc(struct
>> mlx5_core_dev *mdev)
>>       mlx5_wc_post_nop(sq, &offset, true);
>>         expires = jiffies + TEST_WC_POLLING_MAX_TIME_JIFFIES;
>> -    do {
>> -        err = mlx5_wc_poll_cq(sq);
>> -        if (err)
>> -            usleep_range(2, 10);
>> -    } while (mdev->wc_state == MLX5_WC_STATE_UNINITIALIZED &&
>> -         time_is_after_jiffies(expires));
>> +    while ((mlx5_wc_poll_cq(sq),
>> +        mdev->wc_state == MLX5_WC_STATE_UNINITIALIZED) &&
>> +           time_is_after_jiffies(expires))
>> +        usleep_range(2, 10);
>>   
> 
> This could be written with poll_timeout_us(), but I don't know if it
> warrants holding up the fix.

Wasn't aware of iopoll.h, will change, thanks Jacob!

