Return-Path: <linux-rdma+bounces-15114-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CD7CD27E3
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Dec 2025 06:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CF9B30155C2
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Dec 2025 05:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A4F264627;
	Sat, 20 Dec 2025 05:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BgOgdBwd";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="TxCPRWSf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCD01F03DE;
	Sat, 20 Dec 2025 05:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766208038; cv=fail; b=hgnxH6DV882zbWVMs2hzF14b83SDdAjeDFO4wUgXOXnXg1P6WmOtyr2hWSmO9GvN7RqturpT02jFhSbQk1WcZm+AwYvrQL56LTyZc4qb/QOBSxbOqCEUm6EmSGGgoR+8A91nzfEHcli50FKNdKbFmrLEzaOs59sHtI0h4ghtm/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766208038; c=relaxed/simple;
	bh=0HFfdW+525lFvZy2UD3g8MHNB2dGD9dSnJAY32amzug=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=haOPLP/raRI+o87Us6N4m0Z26wCkDHdzjcxELdTz3+j8TbdGLfoQimiW8FthQ7eUZt38BVBSUjW7vezJg6TyyUC84ISmC2Z/QYIPl06Den345ZV/mTc/kZKvLCF+ipjKVPtPaCFPYPZP506z0bChPr5wyKEg+gu/i9CikCPLwwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=BgOgdBwd; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=TxCPRWSf; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1766208036; x=1797744036;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0HFfdW+525lFvZy2UD3g8MHNB2dGD9dSnJAY32amzug=;
  b=BgOgdBwdhTdFKGijfy4FwD+bQrWjkQZ17t6YseOvaxPFLC65tmMUUnxL
   HYARt7RYYNY/+QOcZ7og5CMy/JDNTOKVe+GwRoGG3/UuUj4eAqTKR/oxB
   SoGEvXmYpOyYk+YREitCwdLVbX1pOl5p6zaR5njHm3sRNn90jQ8o3whp1
   QCm9CmJPUYqaN7EMSo/sRE4Tw7eQWDq63mIqgE7iKBQFCX1nvuw8Frto1
   H3pvgtFcBNBXcP+vJfl6UR8kRI9snWUBHr3D+fqSwjGjLThStLc+LiyTY
   AKx+Mv0EXMbzNGd03Ls4r7kW9n2HYo7GFiWaYhHXfiVUWP0xSThAGxjGn
   w==;
X-CSE-ConnectionGUID: uXgR+UhoRT6Rkz0W6YvyQA==
X-CSE-MsgGUID: mcJLR/KiRIujMvIUUMT2+w==
X-IronPort-AV: E=Sophos;i="6.21,162,1763395200"; 
   d="scan'208";a="137465744"
Received: from mail-southcentralusazon11013044.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.196.44])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Dec 2025 13:19:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L/vQvXHlnC3pUFdMDMYASq4mv0Em240t8+l1tDDFuMvMl47J+xE2B0hSWvNiHX34ufaYH6Mv3L+uia/cbp+VTVRm9Ry7rxD4I7sTB8DlR7IhPwsJNxfh+STmFoifqYYCcuC3+VWVRw4VJXFfX1yQp2Aoyt2I9XWcCOjyO7cf0hrM5g5Ar2CZ5spLVeHKJh7DVQN7x0lC5YGBspwejzzaug5Fps8us//rgtZJwutr+KqrdeCGuauLx+lFJoELXF4vgUgXfon6pjkWr5vN5qDeiX5kIwml7WW4QqvZgWqA8nrUZCua4ie8lo3Qj6TsBpDFMCM/L0YQ5jMdswpotbDB5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0HFfdW+525lFvZy2UD3g8MHNB2dGD9dSnJAY32amzug=;
 b=wjJ3D3hADWrcaHEDI+AM0iA2XQnmu26JHh9CBJVbUtxNfs1aU8/3fhU2E8jt7SVF9RHyrxl0GYUMO1KGIG6yo4YC8bwMYWzjgQ+VSzkYgZVc7yYqAgmVwPmLa5optolMpy+vyum2F6yOqNJPFdGRrzAPZoipiykQ2nIT6/n5qcIwGSugT6R9ap+8tXobw9a/064hLVeqIsk0WzOVdjSccngXhbZkzQgxGXdtz7QCys2IKbem2CebNJ5lVAICiQAh8leMSHca8L7EKr3uEH5fCk9o+czHwB0UFIII2sUnGJ/05UDW5Ccb58ND8QeZHyQKcjcMgQ56Fwr1r5+Zj/KCTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HFfdW+525lFvZy2UD3g8MHNB2dGD9dSnJAY32amzug=;
 b=TxCPRWSf/YuKKCOBUKLju4B1WOJjV4pkEmnnWeih4uxXG3lLZdHwi/06yxtMwImT/u9YiackxY97xdNwyGvCiorJCk+2WWNyPsfctRbrwNRVIi2TRsjEx3iivE0ATD21hCKwKB3B+BE3dvQFjjUNjZRb9YJZUFaoMyloYe7lH90=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by MN2PR04MB6782.namprd04.prod.outlook.com (2603:10b6:208:1e6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Sat, 20 Dec
 2025 05:19:23 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9434.009; Sat, 20 Dec 2025
 05:19:23 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Stefan Metzmacher <metze@samba.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
CC: Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon
 Romanovsky <leon@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-cifs@vger.kernel.org"
	<linux-cifs@vger.kernel.org>
Subject: Re: [PATCH] RDMA/rxe: let rxe_reclassify_recv_socket() call
 sk_owner_put()
Thread-Topic: [PATCH] RDMA/rxe: let rxe_reclassify_recv_socket() call
 sk_owner_put()
Thread-Index: AQHccPBj2IOK/hjlRk+VlEDTAfzcibUp/oIA
Date: Sat, 20 Dec 2025 05:19:22 +0000
Message-ID: <94f0a1c1-df51-4515-a08f-1e90cfe34f31@wdc.com>
References: <20251219140408.2300163-1-metze@samba.org>
In-Reply-To: <20251219140408.2300163-1-metze@samba.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|MN2PR04MB6782:EE_
x-ms-office365-filtering-correlation-id: 7408d377-0071-4f5f-07aa-08de3f875602
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?RkNPZGxidWZYbmRmV1RkR3hxRDc1bWdML2RsdStOS1BwM3h4Q2RSMm42Yll6?=
 =?utf-8?B?MEFLRzZlYzkzMmw3VFhGZTEvY2NKalVycWhvZGI3WFhSN0FDckJPREYreG5x?=
 =?utf-8?B?TEhFYUl1MytrZGRBVzduWHcrSVh2dzZMN0dBNXJZYlZ6WktPL0tLQ2s2Nlhs?=
 =?utf-8?B?M1pKaDgwZGV4Q1A4VDZ1WDZubStFL3pEN21XaXNYbFNzRlFrSENyTXY4L00w?=
 =?utf-8?B?S3BhVCtkbE5PenZ2NDkweVhHM0svRWpaalJqSzJTYXdvTDkyZ0NRaWNpS0M3?=
 =?utf-8?B?c29jQTlYQXVYVkl1bXZOV01VbWx2SkZFQjFteERYa2RhZmtmK3d3cjQzZzBi?=
 =?utf-8?B?SkhTOTYyMi9CQUJHQjA0N2dYaGxJMUpGb2ZoMDFFQXQyc1RKUTNwWGM5ejlh?=
 =?utf-8?B?OHRVb0JYekpPMG9TRTJhd1ptWXA2V0lGT2k0aEJGdFpLYks2M1MzME5iY0hE?=
 =?utf-8?B?eENEd2tlenZXcVVrZTNYTDYyUmI3aERGOHp4K3h4WFF5cHZpZnY2Y01WWWFF?=
 =?utf-8?B?dFVxVVgvUVJVelN2RVVnS0lYVFlEQUZsOFMxeTcwV1E5bHZhUGFWSjdWUWl6?=
 =?utf-8?B?MjlBOHdhRERjWnJ6V0Zjd0I2eExJa2hyTGoyV09sMm9RQVNnSFpTWHhFcU4v?=
 =?utf-8?B?VWxQUHEvcUhtN2xZU0lyckUrWXEyYmUvcmJweXVCL0dlNlFuZWduM01KM1hr?=
 =?utf-8?B?RENRK3QzWmRBQUNqMk9DeVRvR3oyUEludGE4K2VOdTdaVllVOG54dkNKcS8x?=
 =?utf-8?B?bDlDYnlWMkJhd3ZxN2dUazlhU2lDcnNRV1RDTkIvZ1FZeWVLMldTVlh2R3E0?=
 =?utf-8?B?Ylcva1kvclRZMGw2MnJXNUpGTXdxRm44dC91Uzh1aHFwdzRsN2NVLytET0tR?=
 =?utf-8?B?bENPR3lSTnFsL0d3UUtiSEp3RU1jQk05YkJReXpQMFJjNUY0K3V0MlovRU5q?=
 =?utf-8?B?b1NVVTRYOTBVU1ZBTzkvSmNlcDF6cDZPRHlIQkp5R3IvMnkvUHlRODIzbHda?=
 =?utf-8?B?Q2NqK2RxZHdhNkZxMDcySDFxdE9rSitoWTJqNFJEcjE1MmVtRmkxNExKU1Ur?=
 =?utf-8?B?ZTF4U1dlVDNrR21MTXUzSGJ3Y1FoSENXVnVUY28yc0JybGlKWHVXMzZQMS9l?=
 =?utf-8?B?V05yTUhrbnlqYTd2cSt3TXFTUGNsS1FzY1lzcUtuK29sL2VxVVRwb0tXUDMr?=
 =?utf-8?B?U2tEdVNmY21lNkNYQnZmYnhPcHprQU1pMlhOcmtyZWVnTFhKNGkzZW1QTE4v?=
 =?utf-8?B?Sy84TFBZT0E5WGJ0ZGVoaDJsSFhUUnBtOUIyZVp3VEgwSFhFeVpBQmFSZXc4?=
 =?utf-8?B?dlZndHlQbm1yV1h4cWQ0SFFxSk45MDFKVHBzcXczZTlNUmFQeDRYR1FuMmEy?=
 =?utf-8?B?VEJQeGpjcERSR29zRkRxaFFkMFhIQjZGdm54OFhHVE9TZW5lZm1pcGV4ZW9t?=
 =?utf-8?B?VlZXYndxK1g2RGR6SkJtek9PWjlZNXF3d2dLeEN0YklDZEdDMXlKZ1lNeFVS?=
 =?utf-8?B?eDdaaFBGNWtsQ0JndWdqTjI0R1Bzc1pzVUNGSndaZlNQV1FCdWtOa2F5VFVV?=
 =?utf-8?B?Zzl4ek9HL0kzWEdpdGYwWXhNVXZFeWtNYzd1VmxlVzhqeXNYdkFUVUYvVnpN?=
 =?utf-8?B?UEhocHZRNCtiQXY4dWU1N21jVFY4NlF0bG41Nms0Ykx6bk1lZGUwNHZyR1Bj?=
 =?utf-8?B?cVFieE1LYlN1VTUyYUVHSmF1cHJ1K1JEcURLalBNN0VRbHZUZFdsckxmcHQ2?=
 =?utf-8?B?MlJqL0xHRmlOU1UxNkJXTVVKRzdoMGFyTXphVW8yUUFSNHZaT1h2UnNIb2Q5?=
 =?utf-8?B?bzNQN212VlRhcThhczNWbVFKWWJuanF2VmVNdnhFTE11cDlzL2hnd25oejdC?=
 =?utf-8?B?MWZrU0VEZW5RazJHeUYvRzFkOU1lMGVNRmQ1aW51M0l2WG9wbHByT1hZV1Fj?=
 =?utf-8?B?bzB4WmZTc2dqKzdjaHJIdDVjZHI1cHZIUlBrTlo4RHQySWVwVkJibkRuY0lr?=
 =?utf-8?B?c0dYL0U0Wm4rYVlLUHFpV0h2NTNGZnp6akpCUmt3TTl2MVBzck8xdmpNeE11?=
 =?utf-8?Q?YqSXVK?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Yk1PcmFsNXM2SHBURmU1bWNMU2pwSFd2RWIyMjNKMVJFckRxWS8xamVmU1NT?=
 =?utf-8?B?MDBpZzFpYURvdE8vc0JJc1VwWUU4TlNBNklhU0dLaEF5RGdDWHo2bzZiTXZL?=
 =?utf-8?B?OE9pV2o2SlUwK2dwK2xhMnVsQWxGZVlFRkZ4VzFVSEcvUlh1cDJkSGFJM1Fn?=
 =?utf-8?B?aG9oYWhKcDJNM0gvVGlRbGxtSWtjRG5VR2pTTy82ZGtoWllwWnJyRXZOSHdP?=
 =?utf-8?B?Wi9xM1dYUVg0bWVmMWNiVkR1ajB5bHNOQ2JWcDZiZ1RVWUxkOXlqOWlGTzh5?=
 =?utf-8?B?QUVzM0hZWVg1a1NaZkJWSXRUdDVUUlJMNmFJWkowL0owN1RGNEpUQ3dXRW1x?=
 =?utf-8?B?amRFUEhNcnRtaFRLYlZ6UkhLazVNVXArTmI5Y3B5NmlBZ2dLLzNaaEc0N01L?=
 =?utf-8?B?K0l0RldwNU9yZmhaV1gyVFk2V3FsUmZhSVZUT3hNTFlVU2ZwbTd5aWdacDhT?=
 =?utf-8?B?ZWlCWmZ2UFRVM2pTdHlVZEF1cmR3TFNBcUp5Qm5IYm5rUDBLcFlheWozd2pN?=
 =?utf-8?B?bm5jQjJsejhsUHo3REpnY2VLcnZLekQ0L3prNldoNjAxd3lqTmxxSTQ3Q1dp?=
 =?utf-8?B?SHF0S3VFNzcyQzNsM2grMTB4YXpXcFdUWStIejRGV2ZvcitURC9BWFlSU2t3?=
 =?utf-8?B?WmhqYzA4NUpnZWI5SDBrZDZJM2RPczA3elRsd25NSFAxWUkyQUlna3VrM1ZS?=
 =?utf-8?B?SDdCcG1tMGtZOTRIU3MxeExSeEJ4SEZ3VmtmMkhzaWszL09LaTcycmRydHJT?=
 =?utf-8?B?Sml1Y1dybGI5TW12SHFDS1FXT212bXI3aFAwYkNCY0g5L0YyUUV0eis5VE9T?=
 =?utf-8?B?QW0weVBiTUFOOWFtZFJrSHhZNVN2Z3RkSklLWFpReGZ0YTNiVUdFaVJhS2pu?=
 =?utf-8?B?ZEpaVEhFdk9sUGZTUzk4SVFtNDhYL3g2cUlYWmhZK1pFNkNWRU9RRk55YVZt?=
 =?utf-8?B?bWNrVlJiMzVSNjdVM1VzVVFrcFdzMWVVMGxZVTBkUm4yNVIvY3A5dEErUG1t?=
 =?utf-8?B?SUZQeFFXRlV4RlZpRVJmYmRVRS9Temx1VHVhRFFKR0IyRHhMNkhlWS9WSjl2?=
 =?utf-8?B?anZGODE0Vy83QlF6VTU4YzI5YTBhcllGMUhZd1NTV3l1Q2tWQ1Q0aDc1Y3J3?=
 =?utf-8?B?dEJsTDFjbW5ud2cxbVJMcWdJcEhKKzBWd2VFRDlQVE15bG5sS09kbU1URTF2?=
 =?utf-8?B?NHp0Z0N5NXJkVTYwaFVBUEt5NVZPTXd5dXBFcllmZWFiYzZGY0poQytoZ2J5?=
 =?utf-8?B?MTNNakcvVDl3QjJBTFJzRGwvLzhIcEdDQ0xJdGdQYTFmaUI1dnR5MVlENG51?=
 =?utf-8?B?cC9WZWFrLyszQzZPSms1RGVBT0U2S3U5NktLM2V6UWxPNk9GRjdRUWlpcEZW?=
 =?utf-8?B?S2FMZmxkSjBWSXlVVWtKMDdiRDAxaENINkRseE5tYng1Z2ZZQXc4dWFJQmpt?=
 =?utf-8?B?S3cxekpNUEoxVVJJOHNoSUJlbFlkU05jNmxuTGgvenYvbWhwVEdzS1NaVE9X?=
 =?utf-8?B?bUhTeTFGOUtvOS95NytQL0QxeXR5Ulp5d005c3JWbjFPM0ZxWUw3cHlWWlVP?=
 =?utf-8?B?OGJpSjVZQUpzeTNGeVNEK3RSeklvSlBWOFVtNlFHM0dYdFBTZzArSFBUOHVK?=
 =?utf-8?B?TFY3UjBqczQ0NDBXcUZuSDBNb0JsNzFvb3JUNHYyZ3dNd3JzcjJDek9rNDRC?=
 =?utf-8?B?UDVydis0My9Tc0RhaWhoRFlNTUdQOVZwV1JEZlBrOWRXQ0M5NlB3ODJoQmhs?=
 =?utf-8?B?Z2Y4YXhtdkhYMzVVa1Y4ZzhCaVNjM25KaXlwQmpEVk9KL2pPRFovWE0rMjQ0?=
 =?utf-8?B?R0V5cGg1SmhSSTJjY1h5OEFiM0tpUm40cG5xU2FvSmdydkdscVNSMS9TS2E5?=
 =?utf-8?B?djA1em5ZSWJ3aDREVlNzRlMxNnVGelo5YXR5c09BdFAyMzNpdmZwYjVsVTIy?=
 =?utf-8?B?dWJheFZ2WU1rRkxCTno0RExGajU0VkM3ZUF0dmgyLzFqaVhwdmFEQ3ByUkRT?=
 =?utf-8?B?V3U0UjdWTHI4YWwvZTJtc1VQTWNvUSsrbGY4Z1FpUE81dFN2UTViQU9IZXlz?=
 =?utf-8?B?RGdFYTVZVFJsQTlDZ2E2Yi9PazVybVBVeVg1cmphNUxTenYwOG50R2pIbVNy?=
 =?utf-8?B?dWRaU1BOU2Y5Syt4eGg2VytGQkRlWW9RczF5ajFobEtuN0tlTEYwelJGZzQy?=
 =?utf-8?B?RWhTRUZ5MFdhUlF2VXJ2ZDVvNXhwMm1mT1BHWVZRQmlUZEZXRmU1NEFCckp2?=
 =?utf-8?B?d3FqZzFDeXZOUEhNV3diOFBQOFIzaUc0QlhXbWZyNVdNc1ZJZ0U3M0NyVjJG?=
 =?utf-8?B?ZnNoSHQvK0x5alNGdHd0R0doTVh4R3RIRlU0NVZtakxlRkJjNFFsUXJUdzhL?=
 =?utf-8?Q?W0WxnMLX+nHPm3co=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0CB9A6C16562724382647169D40C2D29@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	st8bYLXKydGrD1lc/SRA7Vr8Y7fgyGIGzGSZzyeGkLM8YQ+I/GJkNrvNJohU/0TShkVEpBqdF+Pjoof/OtZMcLxDzhYKFUmbKbGhS2hYHg9LvRjhlJwV3LcXVJljz/2R/mVJcov95HEJ6rpjQrqUWfh03irlym5Q2waXmV4W075/fNPs+5tATa8ijVYNr2xD2PBka8dUWM7QRo5GLz/3G3m0RoYO2R7DU+mip22bW0W9NL64XEAbLygF2fjCZ/+GiwQraOryl3kVRr4gjZ6hukGzrq9jBIdQJDjo3cleXj1WrnOPHumrXPb9c4cxpvNX8Za4Ho3UHvodfLD1tJ7uVsTj6oIRib0U8XfbErXNXvyHmvUsmAu6EivxhMiQNWkOgwh4KDoXe0qojyZf+fY/HAVnPi6KU18OHovEnW4Fy3Vr0752h+kY7tIuazzeGoP+763SophrZFTl3E0EzDc+tOQwkHas7i5szxv5mYE7DdnR3+YCfZyKLiHO5mFMZL/Bai+nzJgIonSNuo/XI5H2xtLelSBWJrDOgA79hgchjZ219T0Gx3n0tU2bP4LMUSUkpPqda9Pzvl2xqDtXslNnUpWAZaaYJPo0VXUIsa2kbwa+7TmGina/yZCKu61492s/
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7408d377-0071-4f5f-07aa-08de3f875602
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2025 05:19:22.8182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KxxvTHPF/O/ERbfyQtofRVh8nAlAHtbcsXjJjHAAgSg2muFyL+4zgGSVu+2NAgTX9fcGwoOgL4DJ+dCD/vgpmFv5fiAIdCZWKk2LwYTCCY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6782

T24gMTIvMTkvMjUgMTE6MDQgUE0sIFN0ZWZhbiBNZXR6bWFjaGVyIHdyb3RlOg0KPiBPbiBrZXJu
ZWxzIGJ1aWxkIHdpdGggQ09ORklHX1BST1ZFX0xPQ0tJTkcsIENPTkZJR19NT0RVTEVTDQo+IGFu
ZCBDT05GSUdfREVCVUdfTE9DS19BTExPQyAncm1tb2QgcmRtYV9yeGUnIGlzIG5vIGxvbmdlcg0K
PiBwb3NzaWJsZS4NCj4gDQo+IEZvciB0aGUgZ2xvYmFsIHJlY3Ygc29ja2V0cyByeGVfbmV0X2V4
aXQoKSBpcyB3aGVyZSB3ZQ0KPiBjYWxsIHJ4ZV9yZWxlYXNlX3VkcF90dW5uZWwtPiB1ZHBfdHVu
bmVsX3NvY2tfcmVsZWFzZSgpLA0KPiB3aGljaCBtZWFucyB0aGUgc29ja2V0cyBhcmUgZGVzdHJv
eWVkIGJlZm9yZSAncm1tb2QgcmRtYV9yeGUnDQo+IGZpbmlzaGVzLCBzbyB0aGVyZSdzIG5vIG5l
ZWQgdG8gcHJvdGVjdCBhZ2FpbnN0DQo+IHJ4ZV9yZWN2X3Nsb2NrX2tleSBhbmQgcnhlX3JlY3Zf
c2tfa2V5IGRpc2FwcGVhcmluZw0KPiB3aGlsZSB0aGUgc29ja2V0cyBhcmUgc3RpbGwgYWxpdmUu
DQo+IA0KPiBGaXhlczogODBhODVhNzcxZGViICgiUkRNQS9yeGU6IHJlY2xhc3NpZnkgc29ja2V0
cyBpbiBvcmRlciB0byBhdm9pZCBmYWxzZSBwb3NpdGl2ZXMgZnJvbSBsb2NrZGVwIikNCj4gQ2M6
IFpodSBZYW5qdW4gPHp5anp5ajIwMDBAZ21haWwuY29tPg0KPiBDYzogSmFzb24gR3VudGhvcnBl
IDxqZ2dAemllcGUuY2E+DQo+IENjOiBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2VybmVsLm9yZz4N
Cj4gQ2M6IFNoaW5pY2hpcm8gS2F3YXNha2kgPHNoaW5pY2hpcm8ua2F3YXNha2lAd2RjLmNvbT4N
Cj4gQ2M6IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnDQo+IENjOiBuZXRkZXZAdmdlci5rZXJu
ZWwub3JnDQo+IENjOiBsaW51eC1jaWZzQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5
OiBTdGVmYW4gTWV0em1hY2hlciA8bWV0emVAc2FtYmEub3JnPg0KDQpJIGFwcGxpZWQgdGhpcyBw
YXRjaCBvbiB0b3Agb2YgdjYuMTktcmMxIGtlcm5lbCwgYW5kIGNvbmZpcm1lZCB0aGUNCmZhaWx1
cmUgSSBoYWQgcmVwb3J0ZWQgWzFdIGlzIG5vIGxvbmdlciBvYnNlcnZlZC4gVGhhbmsgeW91IDop
DQoNClRlc3RlZC1ieTogU2hpbidpY2hpcm8gS2F3YXNha2kgPHNoaW5pY2hpcm8ua2F3YXNha2lA
d2RjLmNvbT4NCg0KWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXJkbWEvMTcwZTMx
OTEtN2UxNS00YWY4LTk0OGYtMTQ5MDRmZTI2MGNjQHdkYy5jb20vDQoNCg==

