Return-Path: <linux-rdma+bounces-16343-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAvJFH+5gGl3AgMAu9opvQ
	(envelope-from <linux-rdma+bounces-16343-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 15:49:35 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB8ECD995
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 15:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 63EF03009E00
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Feb 2026 14:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E1C372B46;
	Mon,  2 Feb 2026 14:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rl8pYOau"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012052.outbound.protection.outlook.com [52.101.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB5D372B33;
	Mon,  2 Feb 2026 14:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770043714; cv=fail; b=IgzF+MeytTKrmcywH67IQkqcUNbSMbPlawEzbLBrsPpYhxcosx0ys+YwX6dOgnnoXOMb81Fuc6F1GGDrzRf8Bh7zUZ93c9IHvl0JCgdWpKNtQKc/LK6wdlztUrOa2Q8jF32UxdhkaDw50p9kOprqS9DdW7GLweILxFXzOASaLmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770043714; c=relaxed/simple;
	bh=xuOdcOP+stm58ZKy1SNvY4Sa7NEAEUQzewiFeuGLsTQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VLoDKHehFYsKXthA3U6o13ap88fOG4UJFNYYIfEAqAKEgFhmSatEU0WO7eq/gbuSrpYZSO0qfqmLUDyrmtZJk9OYNqqaS8ftCUCAI+kxq+5+0OEgwINONcDkcmmgPYITGVs+OjsywS5YYkYPYEJ/8zbg7ipoPjOtVp5d1tN+ccg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rl8pYOau; arc=fail smtp.client-ip=52.101.43.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MYEk5rH2Dr61jm1SetRJt0zl63B9M6YAIy6eDK0bNTioMDJUV6D235RLuhf/yDnzQ9yoi7xcmo8drLR3RW7cBrORHzHmwbohyljP/B82vqZtvYPqL34wQkMBBhloU3rA6TT5VWmc6eWNbfCSwGKkU3OIwhFxpxksaPRDilZug9O3k6qGX0ELIqk63WESFbbTLjpYmnJO+nVqGtMfmIVic7JQr3WaKmjGkPWKd9YEom2OHD8X90PSKGDmnRTD21V7hByabJzcrtuTtl8HT/hSiJUU4/iaI3R6ylDPOHWkH5F5n7MYusW2JIKfbjGNJ3ps7Un8Z1nCWt0oCQy+zUNCSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xuOdcOP+stm58ZKy1SNvY4Sa7NEAEUQzewiFeuGLsTQ=;
 b=Qxj8Fb6txZrG2XuHs/phQf69XJDhWFfEFvkRW6BIvfWpHsnr5sUzl4U2cw7sLsubifqpJW9/ak3giHEeQ1LhfVjLmv8mRtKNeHz76/wr5KgkXJPlyUoVerHyAevmbZ11aX41T7MTstKCit9rNRp7r8emPOEYwSqMm8LJoSaECV4D34AsMtpERFJioQw4pThX+LrhfhORGSAjywuMdABqaoyVEL69O0kTN9vbXtisuJ4vdfl4iNMmdP7s2WQqtQBG3+VUw4oOxNuFH7ZQ1g+fHiHWsZs6STPYgRQ/TIZCdGUG6wSnzIIcMb6j+TCBKMRl8hqiymK/fEpk+FwRNENpHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuOdcOP+stm58ZKy1SNvY4Sa7NEAEUQzewiFeuGLsTQ=;
 b=rl8pYOauDRWL5SArVc0bZdTmFRHCd0ek1dAWmOYTrSbkKBC2wGSH0Ow1GuCN+uKcrQA4rT8VF1Z7X1XvLw71cQn7gv/Y9Kxg6JEJCGyXs/y3E6GbiJN+GqBiuJJxrGoEyeEMz48dbOLk6lK2uC6OL8cLFTuG9oBoLJ/atbHau+kXSld1Xhe5/9CG+jQEJZQWpwSLNWrrUfEvkkIzCLA4oQ4BVPPCuRvpHXoiWXFsZjxxFbLeX18eu/SMnPm861YvB3PgNLsbfPR6hVBhkLsPl/tA8BNq8KbbeXKGjtR14arEtzMB3zDWIQn6+2hI3flT1yB5I+luPapuWyToXcrLFA==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by PH0PR12MB7958.namprd12.prod.outlook.com
 (2603:10b6:510:285::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 14:48:29 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::8e88:51e7:15c9:25fd]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::8e88:51e7:15c9:25fd%6]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 14:48:28 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, Tariq Toukan
	<tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Moshe Shemesh <moshe@nvidia.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>, "leon@kernel.org" <leon@kernel.org>,
	"horms@kernel.org" <horms@kernel.org>
Subject: Re: [PATCH net V2 2/4] net/mlx5: Fix deadlock between devlink lock
 and esw->wq
Thread-Topic: [PATCH net V2 2/4] net/mlx5: Fix deadlock between devlink lock
 and esw->wq
Thread-Index: AQHcj2p4+z8li4woFESbbGRh3+CRZrVomGQAgABePACAANvSAIAFtLOA
Date: Mon, 2 Feb 2026 14:48:28 +0000
Message-ID: <75a38217239d4df76f53cd6c355c5179ffb97546.camel@nvidia.com>
References: <1769503961-124173-1-git-send-email-tariqt@nvidia.com>
	 <1769503961-124173-3-git-send-email-tariqt@nvidia.com>
	 <20260128205622.12e1f026@kernel.org>
	 <d52714243592921c08175aa742f32ae56e4f6651.camel@nvidia.com>
	 <20260129154024.3915c3bf@kernel.org>
In-Reply-To: <20260129154024.3915c3bf@kernel.org>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|PH0PR12MB7958:EE_
x-ms-office365-filtering-correlation-id: 0a887c53-7787-407e-74c4-08de626a20b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UFB0eUpOWmpYMUo2d1dTOS9hUGg0Nm1VaUtlRDl5UWtaQjhONWl2QTVMbWM2?=
 =?utf-8?B?dnlSSjFOS1hIdUdZdVI5L00raXhuZWJGOEV3LzdhK0ppcEU4QTZidS94R2Zy?=
 =?utf-8?B?YzFDQ0pNUHBoS3c1cC9WeVM3cnpza2VqYWRJMGIrWEhPYkVxRTdESUdZbG8x?=
 =?utf-8?B?TmRiYUxneWFzTFVhYnlmSW15bWpxTi9ybEIwQSsrVVdsSnZSMWllcDdPeWlx?=
 =?utf-8?B?TzJpQ01JR1lQcFFwdzF3ZXM5ekhkOURCMk85bGgvUW9QSUFzWE1YMW1OTnRt?=
 =?utf-8?B?S3dsUkhvWEVtTTdvc0RPN25DZW1VeXR0U0NPb3RwVTJnNk5QZGpZS2c2MWVj?=
 =?utf-8?B?QnNHUnFSc2ZtVGxnM09sdy9CM29GZ3V3V0l5RjdwZGtyOW1jMEdCQi8rNjlZ?=
 =?utf-8?B?N3J1VEZKdGhKdzN0Snl4K1kzT2dRTUQwdnlPUVFvVHNKWmFvMFo5RmV3Rk45?=
 =?utf-8?B?c1MyVDVRRnB3QWwxYmYrVWRibVFZZkk4aUo5TzdLN3pjMjN6VlFtMWZCRytQ?=
 =?utf-8?B?bDk3bWdEbzErckRlVHdBUExpdFVkNHlVYVgrSGlrS0M5Z2MxbFZscFNoRTRh?=
 =?utf-8?B?YktIcFpBcFhkRUhJcFg5QnJQMHovMTlHanhZZXlvTkRlV0R1eEQ2dDlQNEpP?=
 =?utf-8?B?Z0V6QndmRFdjOTlYVDVDemE0bW9Wc2tKVlorRUVMSzhNejY0dFZXNklEOW9T?=
 =?utf-8?B?SThvaUNtbzhyck4rQ3c1SGs2VUxwZm5HVVF1MzhIZ01TUWxXeWthbE42Q3U4?=
 =?utf-8?B?cGE5Y1Y1dVc3TkpneGk2MEFhTHJmMUtUZkpVbXFGa2RDbnEvbk9MTEhUVkJV?=
 =?utf-8?B?d21WTndBQmdHVEIyZGsyNkRJeUxqK3oxelBNVHhZMm9DT2pONGVaQU9oZ2xJ?=
 =?utf-8?B?dFVvOUNGaDVZdGgwUkg0V2l6VUNWaVh5UzErdTVpd3R0VWtCbStUS2FHVEJs?=
 =?utf-8?B?NGk1M2Y1Y0dROTc2WkkrWWt0M1ZZSmdqS2IvUGVCN0VUZjNaTjB2bUZVOTJq?=
 =?utf-8?B?U285cHFCa0VOOThtMDJuckZPaERLVDR4VkFxMFZXdzVmWmNPQi9FV3lGeWI5?=
 =?utf-8?B?ZU5NNC9HT2JTNFZwK21EUUI4d3RBazVpaTRMcS90cTRYeXJjNitnb3JrLzh0?=
 =?utf-8?B?WmZvc1lua0c5NkoydkNwY3h0cnFQVVRrZHdqSUJHM3I2V1NNelNEY0JqNjVi?=
 =?utf-8?B?YXFNZFlxTUpNNEVCbUpPQTI5aW1aT3BGM2owYTBxVndJN2hjak9PVWY1R0V3?=
 =?utf-8?B?ZC95THhaalpNaGR6UEQycVdGVW9oUStTYlZiNHJJTVVLbDg5d2JYSlZHenlW?=
 =?utf-8?B?b2hkdkE0bDgvb1RHbEUyVEZzWldDbllpM1BTNzdqOFgvcDlqWjVNRFlEcElD?=
 =?utf-8?B?TFJaWFEvYUxvV3hnRzlPZ2RJNHVDV3EwNmNzU1p1NENFeE40eXFVOFBWZVpB?=
 =?utf-8?B?eFZ3cXVMdkpNdkFKL2J0REZFSUdkd0hGbXFwbWJWb25pbGsxOFNsK3pVSWpC?=
 =?utf-8?B?Q3UrZnhLQy9TUzRpQUVrcGQ3YnZINTJTNTFYd25senoyTnFtTU5tZjg4VmVt?=
 =?utf-8?B?T3hpQkpDSmVpU1hScDdKSEJROUNrbzR1VEoySnZVMFozbFB3VytrSWFwUGVB?=
 =?utf-8?B?RitMM01UMUJaQ1BJcHIya09zKzlKSElCL0lIaFNza1J4aWV2ZFBQL3FOSnlE?=
 =?utf-8?B?N1NpQWdUOUN2MmhRQ1J1TXZNQkQzTFl4di9uOWp3dEN0YjR0ZFpwc00xVzdu?=
 =?utf-8?B?bVpCcmdGcG92SGhZenFwdXpGN0lnbGEvL242QmhlQ1VjQkZ3TjVsVmU3bDhS?=
 =?utf-8?B?eVdoZjJ0amx4YWs1eGdPTzQ2SFRHdkFHS3Z2dktMdkNFZlp3aFNWYk1LRWdt?=
 =?utf-8?B?cTVBOGdJSGRQVm9JL3hRUjJpRUxodmtzZXRmaHc4bUZlMUUycVZndW1XYSth?=
 =?utf-8?B?VFlRck1rYkcwcWROMGxudjc4a2VwOGh4VFF6azZhd1NLQXRGN084MTV4MXdz?=
 =?utf-8?B?UThxcjZUK3ZEY3ZKcWU5ZVpEQXVsWUlxUGFWOG5PUU9BeURaMzdISmVic0dR?=
 =?utf-8?B?VVNxOHdmSWdUSElKdjIxRTdubU9EMnpDbTN6WXBONjdpd2lDdDhndEFpU2Ru?=
 =?utf-8?B?WlNlbVpoZ2ZQRy90UC9ZSmpCSk1jWXVWaTZPdjdkeDFReXd5QlBLNTZvMGhX?=
 =?utf-8?Q?iCJAePwkYpqqtVwLlyU7NSE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RUppNmJKWTIzVGw2cVRhdlBnYWVoWFEyb25DdDJWWWpiRzBTOHR1bi80RWdo?=
 =?utf-8?B?UXVrS2sxdHZOY3dEQVdGN1NYbWNNUzNkRkY4UEhBN1hXOEpJNDZtZmt1WTRG?=
 =?utf-8?B?dEhsM1BTZW9mdVI2b2w5UlZ3a2swckI1SHd3V24xR2dGaFRqM3pIRFIrV0xH?=
 =?utf-8?B?cDJkQmRXSE1vZDhhNWthNFBBV0NEWWY2M1doQU91MkdYR29RazZlbjFGaEFl?=
 =?utf-8?B?NWN4TEdkNlpDYjVTVnhacllhTloxS0liWG9ob2NZTEcvZjRWOGt0Y1VRRTVx?=
 =?utf-8?B?bElBOVZ3TlJ3Yjh4dlUyOHNrV2FtS1VWV2VnNnlmeE5LNzA1bmxLTnVkUW1y?=
 =?utf-8?B?azJtMDBERW5KM1ZqdC9jM1ZITXdoRTRpdEZKc21aTHdic1VNVm82M0VUNFdw?=
 =?utf-8?B?ZUdIVmU4eERVVHR6ZWZ4VXp6aVFFcEFXZlhNRU5kRjJKUVpUMXBaUVpYcmdx?=
 =?utf-8?B?ZkVXc0RUb1QweGpXQVpDN1U2NnQ1cVgrajkxdHlYVFFUdThsQ1pIQXlUYmk5?=
 =?utf-8?B?bnoyS3RDR0d0bmRDWGxxaXlqU1dBVy85aFlHT3I0eXg3SWljZjU0M1kyUlR2?=
 =?utf-8?B?dWJOL3duRE5YU1lSYmV2N2tqaDdQM0lvbEcwazJlMlZaR0ZjWmlZaTZFdHEx?=
 =?utf-8?B?RnNYRjJJNURNNUJSN3RsZXRtaVNBS1ZVTkxTamQ1NnhoS1djRVE0eGxwQkRr?=
 =?utf-8?B?aU5xTkpUdXRpWnUzM0FjL2ovemNTSVNsN3gzTkxJemY4dFdqOENIK2xWc2VZ?=
 =?utf-8?B?Y3FNdnhMU0U4T0FKWHIyYUdWZ2VDMWVVaWxUaFJsK2NFU25ZWldBM1o4MTlY?=
 =?utf-8?B?MW53R3dEcnBuZmxnOGRpZUp3TDZ1QWVub0JDWkhXQU1FbFJIbDJyTHg5K1NJ?=
 =?utf-8?B?Z0VwNVlvWHBmVVR3VlpXRUJQV3l0N21Ob1hIZ1lNTjE5Yk1RTHRjMlp1eCtI?=
 =?utf-8?B?dzlBeEM4bG1KVzE5M2dvNERGamdIT1Y4ditCSS9ta2hrQ1A2M3I1RlpuTndh?=
 =?utf-8?B?d25tM0p3UWpvL2NzRkMzOWNKdzM5Uk1ZWnRXbmVMTWdWTUQrK0NkWHE5VkFY?=
 =?utf-8?B?bVpESDh0cnNDTlZxaGRvRlAwRnZLcjhHUEJhaGZDSEtid2MrSGNMREFManVV?=
 =?utf-8?B?NEVBUzJOTS9weVRzL2tvRUVzZ2JZT3c3VXQraFFxOU44VXBHSElNWFVaVXRp?=
 =?utf-8?B?U09IWEVSM3pldG5GR0ZLaWZxdkZPN2swY1JTY0ZRbEJPdHVLMzByS0sxR2FM?=
 =?utf-8?B?MUhla0xnZkdKU1kyTVh1T3loRDd0bkNzNHo1b1dHMXl4R0JIc011ZTNKbnJV?=
 =?utf-8?B?OU50SC9wblp0WTdlN2tGd0NFU0pzZFhRNzRzc0pKTVREL01sTkhIS05tWk40?=
 =?utf-8?B?K1V3SUdJU0tiaFpZdmI3WGs2SWNRWVBNZ1pESE1VUUdlS21pZkQvbXQvYVdY?=
 =?utf-8?B?bEVsNWVUMW9iZmpDSHVObk9TMWJ5amxWWmJuZmtyRVk0WXRvTDNqaG9va2dv?=
 =?utf-8?B?cThwc3FUQUt2V1RuQ3l2U240d2traE5OMWJXWks2cFpQaWoxTnpraW94bXdS?=
 =?utf-8?B?Q0MwU3ZxeFBJczJtR01YQ3o5TUN6ekIwZk5WYy96L2h4K2pxQk1CUEJLNE5G?=
 =?utf-8?B?czNVeGNOYXhKSDJGQ0RhZmk3emxNd0lrcW9TQzBiT2p2V3RVWHg5VnR5dUlu?=
 =?utf-8?B?NXBHTzFZV1VUWC90c2FIbVdsRVE5S09PZHVSeEI5RmxTME1ocGlLSEhsY3Nl?=
 =?utf-8?B?WnMwTnZSWWl6VmREL2NQSVdjRy9zVE0xTEtFRFhYcFAvRW1IOE5BUGtKL1ZY?=
 =?utf-8?B?YnMvVFNFMzRWcWllWHFMUnkraTBIMU5jQ1VPZ1ZGQjg5U3Q0aW00OTdtcDNq?=
 =?utf-8?B?MlZSMUprU0lMYjhaazk3Qk1STmRVSUx1ajM5cTBjMHFTMkg2UEcyTnJOVSta?=
 =?utf-8?B?bGxCUE5CY29icUxqOHhEc0plR3AwOGlxS3l1L1AyanhXdStrVkcvSitwbVgv?=
 =?utf-8?B?SHEwOWc3VGNiMHAxL0dxcDhsWmJhUlljODVyWFR1UjBMNVhRbE40TSs1Zk45?=
 =?utf-8?B?alNLQWVBWDVVeEt0NnJYbTV0akVoekFPKzJoMEVYdjJTWXBTRFBWNHRzeXht?=
 =?utf-8?B?MityT3FNNUovOE1WSmFHNmJoS21oU01rS2FRNHBKY3h6K1JZUk12M1JXMGI2?=
 =?utf-8?B?K0ZOelBwdlhkWUQvR3pKV0Z0ZWwrNXp0eExBT1VlQWRoWU1OMG9HNmZ6UEJH?=
 =?utf-8?B?NzRjc1ZNWEFDMmlGZmFrZ0IrK1JLK0xUMHhFN0w1T2hVMEx4VHpwemRxL1U4?=
 =?utf-8?B?R21uSmYydmlKRTNPVGdqOWMxenRNTWgvc0ZZQ08vVVhwczVhQzZwUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <411AA20A71850E499B80538CE59F86FF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF266051432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a887c53-7787-407e-74c4-08de626a20b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 14:48:28.7723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VtCdxfyFImhskxYJ/VnblPdMBfqu9tg4oOC0xRY5Ji+S9XWSUMq6rBMMzZHJzxTpsWzYwwRADV8hEo3IAFfhmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7958
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16343-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[cratiu@nvidia.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 6CB8ECD995
X-Rspamd-Action: no action

T24gVGh1LCAyMDI2LTAxLTI5IGF0IDE1OjQwIC0wODAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gVGh1LCAyOSBKYW4gMjAyNiAxMDozMzo0MCArMDAwMCBDb3NtaW4gUmF0aXUgd3JvdGU6
DQo+ID4gPiBUaGlzIGlzIHF1aXRlIGFuIHVnbHkgaGFjaywgaXMgdGhlcmUgbm8gd2F5IHRvIGF2
b2lkIHRoZSBmbHVzaA0KPiA+ID4gYW5kDQo+ID4gPiBsZXQgDQo+ID4gPiB0aGUgd29yayBkaXNj
b3ZlciB0aGF0IHdoYXQgaXQgd2FzIHN1cHBvc2VkIHRvIGRvIGlzIG5vIGxvbmdlcg0KPiA+ID4g
bmVlZGVkP8KgIA0KPiA+IA0KPiA+IE5vdCBwb3NzaWJsZSwgdW5mb3J0dW5hdGVseS4gSSBzdGFy
ZWQgYXQgaXQgZm9yIHF1aXRlIGEgd2hpbGUuIFRoZQ0KPiA+IHdxDQo+ID4gaXMgZmx1c2hlZCBi
ZWNhdXNlIHRoZSBlc3cgaXMgYmVpbmcgdW5jb25maWd1cmVkLCB3aGljaCByZW1vdmVzDQo+ID4g
ZGF0YQ0KPiA+IHN0cnVjdHMgdGhlIHdvcmsgaGFuZGxlciB1c2VzLiBGbHVzaGluZyB0aGUgd29y
ayBpcyByZXF1aXJlZCwNCj4gPiBvdGhlcndpc2UNCj4gPiB3ZSdsbCBydW4gaW50byB3b3JzZSBp
c3N1ZXMuDQo+IA0KPiBBbmQgaGF2aW5nIGEgcmVmb3VudCBvbiAoSSBwcmVzdW1lKSBzdHJ1Y3Qg
bWx4NV9lc3dfZnVuY3Rpb25zDQo+IHNvIHRoYXQgd29yayBjYW4gaG9sZCBhIHJlZiBpcyBub3Qg
YW4gb3B0aW9uPw0KPiBBcmUgeW91IHBsYW5uaW5nIHRvIHJldmlzaXQgdGhpcyBpbiAtbmV4dD8N
Cg0KQ3VycmVudGx5LCBtbHg1X2Vzd2l0Y2hfZGlzYWJsZV9sb2NrZWQgKHdpdGggdGhlIGRldmxp
bmsgbG9jayBoZWxkKQ0Kd2FpdHMgZm9yIGVzd192ZnNfY2hhbmdlZF9ldmVudF9oYW5kbGVyIHRv
IGZpbmlzaC4NClRoZSBldmVudCBoYW5kbGVyIG5lZWRzIHRvIGFjcXVpcmUgdGhlIHNhbWUgbG9j
ayBhbmQgbG9hZC91bmxvYWQgYWxsDQpWRnMsIHdoaWNoIHRvdWNoZXMgdGhlIGVudGlyZSBlc3cu
DQpJIGRvbid0IGN1cnJlbnRseSBzZWUgaG93IHRvIHVzZSByZWZlcmVuY2UgY291bnRpbmcgb24g
dGhlIGVzdyB0byBhdm9pZA0Kd2FpdGluZyBmb3IgdGhlIGhhbmRsZXIuDQoNCkJ1dCB3ZSBjYW4g
aGF2ZSBhIGRlZXBlciBsb29rIGFzIHBhcnQgb2YgYW4gaW50ZXJuYWwgdGFzayB0byBpbXByb3Zl
DQp0aGlzLiBGb3Igbm93LCBwbGVhc2UgYWNjZXB0IHRoZSBWMyBmaXggKGFib3V0LXRvLWJlLXNl
bnQpIHdpdGggdGhlDQpjdXJyZW50IGFwcHJvYWNoIGJlY2F1c2Ugd2UgY291bGRuJ3QgZmluZCBh
IGJldHRlciB3YXkuDQoNCkNvc21pbi4NCg==

