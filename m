Return-Path: <linux-rdma+bounces-8763-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 481AEA661E2
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 23:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B70B177D96
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 22:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE9F204C35;
	Mon, 17 Mar 2025 22:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GgLl9uRm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F93EAC6;
	Mon, 17 Mar 2025 22:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742251316; cv=fail; b=VbSU1QjnGPXrQpYUINMWMKuJswHRXxfuirpxflSAeTXMNehsSnne/gCBm5/ISqN3eG5GxEeCaA3SZxkk20pd7B1hiSoeUV3NRJhej18papOspcwQakb59B4Qqw5HVI4zH/OvvHSJvKYZ0iRyNOGnpOo3FUQi62zfRrj1UQn54lY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742251316; c=relaxed/simple;
	bh=wl/X75vHSrd6el/hQKVFCQLAkJO5JlW0iCln8XK5e/Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fzOTqkf9Y7Xtlmm1PuXBjl4Ly9DgpGjGdwqZCktCWH88nZw2e6eXUwONoO8iCb5y01F84kMikCuWpl3PvRIxrDU+JQMaMU0rE8JwxNOYtNb/Bby05Xs0uE2/YyYiCkZfEN0NuufFtooFLcCS5JsT+tB9KxxtZ0ZqyMMVBl/Y4mE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GgLl9uRm; arc=fail smtp.client-ip=40.107.94.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJALVTB/mGYHEFBB9lJp2ujXB3B/ZbUnYgfukGIX75t0SwCgG1pO3SZu01KDa5xt57BUj7PEjMcznklW0vaV2iO+cjIYeWUxnsVu/0q5hikCIhPI8XDnmDmqEZeFPN1cVM8pKP+zYc65KQD1b+6UQlfFDFiaZLcOLSvcYQMtdYbGrQshU6eSPWTPyXFlVE+0kx3EBVsK/WpRIFmblFAOXX+F7txyVHcS9gSrzvAEmWWfuKAfVW7bzgG81LuHumiIK+lp2n9ieBYxlmT/HRQ32stglNSO0JI+4NybZD2UmDUwaDl09Yvjwf/pGzgV+PZcmv/q3lfKSmBQ5CaHlCymTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5j1FPiF4gXWSiDx3aEub0HE0LS4W+V8xNRUavOVSgwo=;
 b=n4JhPwsM3auwPzW5D2Dft7v8IZRT3bHYmGnAICcmk3WAAlyC/ABXMyeNlvrAzv9mQS8yrvv/1QitAOmKRZIU/yAPcTc9uRQdcXLf60uPfTxGYlafKiOcK2NCYajGhC1oWs+D0MeCsS5ErNMu4IUDj3X9kP9LR3Ue6xIFVKXFDSTd65iExYT2ZHCnPAy7TBkdAe57bfpcqP5qkk5eEB9HUGORuBQU8uX2YGMbKIBQ1hqLx3GS32VOe0iIwVnq0FYqqnpqd1qwX3lMQerhPBTdqNl+5ued69TLsinZpKNEHc1uiyQmih1GUlOqJ2+cmyEodVJ3CDwTVe7HNu32qA8FIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5j1FPiF4gXWSiDx3aEub0HE0LS4W+V8xNRUavOVSgwo=;
 b=GgLl9uRmurvNRXPNmgKtC1FaIkYJLwGkM3HwvLYdEYaktxYsmt3BPAqH+T4me9thG3EczjPZx3DyWxqEPlhzi3wGrTm+Ia35X5iQiJj53gVFpDjKkOxaBMVtGVpJAlU/HsuoMRQ3QfAGaA1ryzcGv4K6H9qvz/B5Vw4f6sfx+i0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 DM4PR12MB7551.namprd12.prod.outlook.com (2603:10b6:8:10d::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.33; Mon, 17 Mar 2025 22:41:52 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 22:41:52 +0000
Message-ID: <9696e96a-704d-475a-b7fe-645c9086c3a1@amd.com>
Date: Mon, 17 Mar 2025 15:41:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] pds_fwctl: add Documentation entries
To: Dave Jiang <dave.jiang@intel.com>, jgg@nvidia.com,
 andrew.gospodarek@broadcom.com, aron.silverton@oracle.com,
 dan.j.williams@intel.com, daniel.vetter@ffwll.ch, dsahern@kernel.org,
 gregkh@linuxfoundation.org, hch@infradead.org, itayavr@nvidia.com,
 jiri@nvidia.com, Jonathan.Cameron@huawei.com, kuba@kernel.org,
 lbloch@nvidia.com, leonro@nvidia.com, linux-cxl@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, saeedm@nvidia.com
Cc: brett.creeley@amd.com
References: <20250307185329.35034-1-shannon.nelson@amd.com>
 <20250307185329.35034-7-shannon.nelson@amd.com>
 <ce0c9c98-c507-40c1-8bd5-5fe37ba624f6@intel.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <ce0c9c98-c507-40c1-8bd5-5fe37ba624f6@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0390.namprd03.prod.outlook.com
 (2603:10b6:610:119::14) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|DM4PR12MB7551:EE_
X-MS-Office365-Filtering-Correlation-Id: 03e7e0d8-cd6b-47b2-2d2a-08dd65a4e99d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXM0VTlvdGJhZ3E0SkNmQXpQWkZtSFZjUzVtUFFGaTltdExzVzJQTGxxR0FS?=
 =?utf-8?B?d0QzaFBLcFhUTVdTZC9yMzJsZS9MM05wVjlsQ0pYMWZuODhFRHQwYWY5T0RZ?=
 =?utf-8?B?UWNjanZMU2pORTMwRWhSR05LU2JEdmlnL25MUCs2ZSs0aHlRaDJOdWo1amxW?=
 =?utf-8?B?dWx2bnhXY3ZiQjE5UnlMY3J5RGg4L2xiMXNOa0VOYlJyQWtNcFo5RWFCeXZQ?=
 =?utf-8?B?VXJLSUN2T3p6bXJCVEZybzl4SStPTWdWeUpTV3Btazl2KzJEeEZZVlZHU1Y4?=
 =?utf-8?B?a3FEblhoYmJmUXpnbi9Zc3JMSk1XZGpqK3UyN3VyU1RkYVlmeFpPSStiQjBX?=
 =?utf-8?B?MzhhUWFyY0dSQ21Ob0UvS0ZtVVBKSzVwYzVNNmoxSjBmZ2tVeWM1alE4Vlp0?=
 =?utf-8?B?dGlVZUlPazNZdzlnMnBqd2ZMTjA2TkNnRzgyMkJ0YVhtM1c4NnJ5Q1dITkV1?=
 =?utf-8?B?eS9td2xKMFFQMTRweWpRL1dxczF4Um1GOUxQSSs1OVloVzA2ckc3dG9uWEx6?=
 =?utf-8?B?UW1ua2wxNVZVaUFQcGxVb0xlQWVIN2ZoTGU4dzZjV2t0azZWdHU1MngwZUZu?=
 =?utf-8?B?SzhBMTdVOUYrclVGWk1hakNQSnJOMm43OWRyenBaZytTdnRTa3JNMTY0dUpn?=
 =?utf-8?B?Y2lNWkNRYXVuVkVMYVViOWd6UFYyTytKVmJaL1Y4U09CK3RWVDhXS2xuZ3B6?=
 =?utf-8?B?Skl5TGthYnlQQkU3TERXQmR3V2dKNFdoOGVORGZHUEcrbDJ5OUlNSFVCWDUr?=
 =?utf-8?B?YmE5MituOFh5Qno4elZnbXl6eEJCNWhIQzl4MUFNYjBBQi84TXppdTJnTXVp?=
 =?utf-8?B?Q1d3TEJ1ZlJ0QmM3N2J4MUJ5VnBYSXRFRDdJZzJ4VDNzRHNNM2Zac0JGQ3hr?=
 =?utf-8?B?bzJhR1RqSGtOUlJTQWkrNHBLbjAxVFBBbEZTdFNad1BUd0g2Sk5kSzRtSDB6?=
 =?utf-8?B?Tis1OS9mMTB5YjF4S1Y2VGcvTWtiWVduWEJsYmJOUjZuc0tqZjZCdlU0Sktn?=
 =?utf-8?B?Vm9TeHUxbDcva1RYaElMb005MXBhS2pYaXFTZ2FsZDF3eWJ3YnJycjJQQTJG?=
 =?utf-8?B?cXdZVlhCUWM3dHVrVVRFM3M1cEtKb2orSTRBRTlTUy9wMnUycHpWeGJMOWRK?=
 =?utf-8?B?SUNkSm81WkxqUWhlZzNuTlU2RFF6OWE0bnhxeVN6UFZwNEF4NllFdkhDaDhF?=
 =?utf-8?B?SkE0SEwxSGtmNS8yV1ZQRzZibmZxMlhab2RheVF2ajNnSkRkSlJodmE0Tncr?=
 =?utf-8?B?a2RmQkQyY1BQRG1zc2ZHU3Iya28wRlJ1NDVwVXJTY3FydnBneG90SlNMa1Vj?=
 =?utf-8?B?RmdGZEhVcnl1aEhWUWZaS3NjWHpkajlMM3VUblpiQ1ZpVUtzbm9vcFhWeFJp?=
 =?utf-8?B?Q0JZUzBkNUlEanczNmE1Q21xdHNJOTIyVUZpaURXcDZuSFZmcVQ2aW5CS2da?=
 =?utf-8?B?bW1tVWpSUW9nZHpCTTAxOUt3cEJvNE44Z3NheFdDZGk1WlhIWVZIa0NFdDF6?=
 =?utf-8?B?ODRUWFBYcVBRR2tvL2RnRnFWSXkydEZMYm1zOTNZYi92TWZvYWYzUm9LRjN1?=
 =?utf-8?B?QVlGT0JVbnV6TVo4TytJbk4ydENBekNtNjJwakhGQmpHS3ovWlppdDFmVGJu?=
 =?utf-8?B?N3hWQTJWNXJSVytKbm9LZ2dweEFZMTh2bWJLNDl1SVdvZXl2bFpOT05ObTZX?=
 =?utf-8?B?ZmR6eFJLam1xWS9kK0RUc3hXTytqN3p3U2lPNmNqbWx3bGpNZG9FeWo4NXMx?=
 =?utf-8?B?djNyYloxdnBxeDdYWjg2Z3JkVW13cEdzOU9SS1dJLzZEang5VkhsZkM4aFI3?=
 =?utf-8?B?U05rcTF6dHp5d3h2NnN0V1VQNGIxTXRqN2hpTnViZWQ5a1FFdVRXNFc2cksy?=
 =?utf-8?B?cGZ5OEU4KzlKdU8wbjNVbUFyNFd3ZjUvUnYxcUFuN2Y2VmtjWCtkTVpsUTUx?=
 =?utf-8?Q?vFVQPUIEPo8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjRJWndkc3RMdHcyRVNwZEl4WThVL2tIUjN1UThSdXhjTkNGK3hiUHpIMU0r?=
 =?utf-8?B?dnhxRmlBR09kSFZTcUREUkF5WXVpcVhiZ2tTOUl2VWpUbHBmNUFjQU1yK0dW?=
 =?utf-8?B?b2d0ZXZGWWUzSzRnSmpHOHV0emZMclZialZmWW5CcEhHeWEzSUsxZXFucTFx?=
 =?utf-8?B?VWJjOHA0eDhtd0RWdDFkTjh3VmtjeFZzcnR3RWdNZVdnWkRtem42eHo4Vi95?=
 =?utf-8?B?dmo0Yml4OFpwL0RpYlB0L0ZsbzROUHh1YVZKOHN1UW1hQmd3bjFIU3B5VzRJ?=
 =?utf-8?B?RDBHaklVb0RtV1Z3VGxOSXV1NnRDYS9uOUp3dnZJalZaL2k5Sll5NlZZWWo2?=
 =?utf-8?B?Tkc3TWZyM084ZmNRQ2dybVlaaDdIaG9teFBtUHdLQncxME1xM1BmLytBMGQ5?=
 =?utf-8?B?ZWYrZW9USUZDOE0vM010aGNNK3pGZ2NkNmpZVnJ3VmhSZ1lnNnlTVlFtL2Mz?=
 =?utf-8?B?NkhDRml5OHBCajljRjJJV01ZZUF0MDRHNHlRQzJ3cVR1UTkyd2NiMHpsZ1Zp?=
 =?utf-8?B?dkJtL3hwdDk4QkRoUGJUbVhyMkRFbmVPM2V4ZTllejlZSnNUSGdRVVBwN1B5?=
 =?utf-8?B?eitJeE52aVFDVlNEZjdpYUVBTUxITlIvaUtXR3JQR1dBSzNZR2gzRGxBd1Fm?=
 =?utf-8?B?RHp3dTdWdWdPcnUxaUVUb0U4UzJqQUxaTUlCM3lOZUN1OTZTSUdEQlJqMTRC?=
 =?utf-8?B?QXhNWGI2dGVxbTkwYzBDLzZ1VEw2SlhZeldPNXNCL1R3UjVId1phVlNQYVYr?=
 =?utf-8?B?VSsrOWFaSHBnTDN2dTBPdzNSUlpLVHphc05Kell6VHRmNFB1QTZTTHZOQy9K?=
 =?utf-8?B?RTVFcGc4dnNDUldNT3dNNlp3Y1NFWDlac0VQRXVYTXNxMWpyZEdJd0RRME9W?=
 =?utf-8?B?YS9wSUt6dm01b2EyVW5jT0lVUkdvenpUSGtvQk4xMlZZemhRNXJMY3k0cUdy?=
 =?utf-8?B?VzFXOWhZbXJyTXRkYm8zZ3dPMThsODhGMWZtMTluNTlZcGpPRUxOakR3azhu?=
 =?utf-8?B?QWhEdkhtRlkwZnBMcGRmQyt2UHZ0OGVQR1R3b2JBWm92SmJzcHR0MHY1L3RB?=
 =?utf-8?B?TnV2bTNYcWVrc1h5R0RoeDFQZ09PR3lmcVhPUytFYW0rdml2UGJYN1VEVDBE?=
 =?utf-8?B?VzByVEQvMWZGSndLeWJxMC94dUErSURuK2d0NmgrNHdQc0NSZGlLRUZVc1FH?=
 =?utf-8?B?SUxkV1JEdGxPbnRVVE5rbzkzbDZTWUg0ZUFGYVpRRStGK3c1bW50RkJpZ3Bk?=
 =?utf-8?B?U09NdUVDdGtnZWpNa3ZWaUExQW5CZ3BMZGc0Ui9FY3hkUHZBanJLUkxoS29L?=
 =?utf-8?B?Z1FrNURta2VJR3RmK1pIK05pTmxkdjMyWmdKVUZyRXo1SlRFdHNyZE9FT0NK?=
 =?utf-8?B?ekdKWkFCdkRabGJyMys1blNLVlQ5OEs5ZngwTTNCdEYzNnk4Z1NvdWFET1NK?=
 =?utf-8?B?MjZYbkpoTWNpUWpmMWZBUlZESHI0SE9DM1pxN1ExWDVicWVncHEwczd6NmRq?=
 =?utf-8?B?SHFiWnhFbnNlQ2xvQXk5MU9zNjhuWHB4WXcyL1JTTzlwTldhVWd6YldMU0dy?=
 =?utf-8?B?Y0txN3pnQlNWSkpiZU9lVkxMY3gyU1liWWlVcmgyN2VXaFJLV3ZzWVd2bzBZ?=
 =?utf-8?B?eHhtQmlFemxDcS9SbWg3cWdjRVEzV0s4UDRTdHZ2VGUrUERVaUJhSXhXajZX?=
 =?utf-8?B?TURxdU1GMVQ2YmREVHVQbldtek1hN21qZmVDdjFwM1NWcjVFajJyOVVpek9z?=
 =?utf-8?B?SE9hT0NuNFczRmttQ25TblA1RUw5N2xnOHQxK3Q0K3J2cllweFpXdm1CV2hl?=
 =?utf-8?B?TzZTMDk3eFpaZFBkanhnODNpZmNCVFB3c2g3Y2d0UGlrblJkazl4YWwxUFg1?=
 =?utf-8?B?L0VtdnRuNDRhV0JnNmZFSTJBUFV2VDJzbWl1VkdMdlVXempJQi9WNExPS01o?=
 =?utf-8?B?aWE4Tlo2WW5hMmRZNDRFMFZvL3FPSHpNTkZuM1JzNlZOTkpXS3BNMWZJYWpk?=
 =?utf-8?B?QTNBdGdITmF4VVNYQ0dJOFJSV1JURFFhcDNTcEhEaGJET0RGMFBobDFkb09n?=
 =?utf-8?B?Snpoais0dGphM2MvWlJOejdyTFpVNGtEbmVJcyt6WUNkbHZjSHhyWUdIZTdI?=
 =?utf-8?Q?ALdNs8bAONSF6BfyXpulRmxFv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e7e0d8-cd6b-47b2-2d2a-08dd65a4e99d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 22:41:52.6191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: leZYMfcmO2TsP3z3U2I8N0vA0/tObnMkdFMolxcwU1w7192CojtwYf8P9dyvoBrTtllPpRN+ClkJ6Etv5zxIJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7551

On 3/10/2025 1:27 PM, Dave Jiang wrote:
> 
> On 3/7/25 11:53 AM, Shannon Nelson wrote:
>> Add pds_fwctl to the driver and fwctl documentation pages.
>>
>> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
>> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
>> ---
>>   Documentation/userspace-api/fwctl/fwctl.rst   |  1 +
>>   Documentation/userspace-api/fwctl/index.rst   |  1 +
>>   .../userspace-api/fwctl/pds_fwctl.rst         | 40 +++++++++++++++++++
>>   3 files changed, 42 insertions(+)
>>   create mode 100644 Documentation/userspace-api/fwctl/pds_fwctl.rst
>>
>> diff --git a/Documentation/userspace-api/fwctl/fwctl.rst b/Documentation/userspace-api/fwctl/fwctl.rst
>> index 04ad78a7cd48..fdcfe418a83f 100644
>> --- a/Documentation/userspace-api/fwctl/fwctl.rst
>> +++ b/Documentation/userspace-api/fwctl/fwctl.rst
>> @@ -150,6 +150,7 @@ fwctl User API
>>
>>   .. kernel-doc:: include/uapi/fwctl/fwctl.h
>>   .. kernel-doc:: include/uapi/fwctl/mlx5.h
>> +.. kernel-doc:: include/uapi/fwctl/pds.h
>>
>>   sysfs Class
>>   -----------
>> diff --git a/Documentation/userspace-api/fwctl/index.rst b/Documentation/userspace-api/fwctl/index.rst
>> index d9d40a468a31..316ac456ad3b 100644
>> --- a/Documentation/userspace-api/fwctl/index.rst
>> +++ b/Documentation/userspace-api/fwctl/index.rst
>> @@ -11,3 +11,4 @@ to securely construct and execute RPCs inside device firmware.
>>
>>      fwctl
>>      fwctl-cxl
>> +   pds_fwctl
>> diff --git a/Documentation/userspace-api/fwctl/pds_fwctl.rst b/Documentation/userspace-api/fwctl/pds_fwctl.rst
>> new file mode 100644
>> index 000000000000..e8a63d4215d0
>> --- /dev/null
>> +++ b/Documentation/userspace-api/fwctl/pds_fwctl.rst
>> @@ -0,0 +1,40 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +================
>> +fwctl pds driver
>> +================
>> +
>> +:Author: Shannon Nelson
>> +
>> +Overview
>> +========
>> +
>> +The PDS Core device makes an fwctl service available through an
> 
> s/an fwctl/a fwctl/
> 
>> +auxiliary_device named pds_core.fwctl.N.  The pds_fwctl driver binds to
>> +this device and registers itself with the fwctl subsystem.  The resulting
>> +userspace interface is used by an application that is a part of the
>> +AMD/Pensando software package for the Distributed Service Card (DSC).
>> +
>> +The pds_fwctl driver has little knowledge of the firmware's internals,
>> +only knows how to send commands through pds_core's message queue to the
> s/ , only/. It only/
> 
>> +firmware for fwctl requests.  The set of fwctl operations available
>> +depends on the firmware in the DSC, and the userspace application
>> +version must match the firmware so that they can talk to each other.
>> +
>> +When a connection is created the pds_fwctl driver requests from the
>> +firmware a list of firmware object endpoints, and for each endpoint the
>> +driver requests a list of operations for the endpoint.  Each operation
>> +description includes a minimum scope level that the pds_fwctl driver can
>> +use for filtering privilege levels.
> 
> Maybe a bit more details on the privilege levels?
> 
>> +
>> +pds_fwctl User API
>> +==================
>> +
>> +.. kernel-doc:: include/uapi/fwctl/pds.h
>> +
>> +Each RPC request includes the target endpoint and the operation id, and in
>> +and out buffer lengths and pointers.  The driver verifies the existence
>> +of the requested endpoint and operations, then checks the current scope
> s/then/and then it/
> 
>> +against the required scope of the operation.  The request is then put
>> +together with the request data and sent through pds_core's message queue
>> +to the firmware, and the results are returned to the caller.
> 
> May be a good idea to touch on each of the ioctls being exported as well as maybe provide some sample user code on how to perform the RPCs. This documentation should serve as a guide to an application programmer on how to write the user application that accesses the fwctl char dev.
> 

Thanks, I'll work on this doc a little more.
sln


