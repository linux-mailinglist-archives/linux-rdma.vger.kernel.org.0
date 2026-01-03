Return-Path: <linux-rdma+bounces-15275-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D376FCF00C8
	for <lists+linux-rdma@lfdr.de>; Sat, 03 Jan 2026 15:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7B9F301D5C4
	for <lists+linux-rdma@lfdr.de>; Sat,  3 Jan 2026 14:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CE7219A8D;
	Sat,  3 Jan 2026 14:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cwp7hIoa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012024.outbound.protection.outlook.com [52.101.43.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93E82BDC23
	for <linux-rdma@vger.kernel.org>; Sat,  3 Jan 2026 14:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767449515; cv=fail; b=cpSCh1kLwjqHr8bKJdeIXyxM6O6Ywexn6BGBPg+MWe6TSjhD5Mc1lCCxPVJZcRztBqsuwxuyXlxSRmSqPLUzfaKGLSlYGYtzoxVl/UXeRwuKMC8NU/coFMYyrgPkRTYEwZG86lPHw4qk9ORDmQVRroP9tmaPRk0HFvhE0jQQECw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767449515; c=relaxed/simple;
	bh=b6M43Vr377DFwbVJx1EfI7+OP0L7hjeW7Jfz5PeOJpk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fr9cujoKaE/ckaPEvg27XCzY+sXiTBlPad4apxDhuWVc7tijJN0iAjmvbNNA+eF+KcPQiep1sQ4/Q5aeKD30V9M4A/0ds+r8K3yU9Xibue50y1EADjHg4AhjgjXnuI+LzWz/PsODEqY/DobkDFtzDa65jXMeATyVxTFd/FRT3dY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cwp7hIoa; arc=fail smtp.client-ip=52.101.43.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VYLDyWv0kbyvJYsvOpZcQlM+K2PZHs7CeZ1D8wp4Fo60Nq/+PnnXVOeIXV1wi3Mo/AilW7SMU+RP0v1fUFKqtRextlt6ohnj6CYbVlXBMowBO1/B6Blr6FdQRl1B+3bLkJcagWMmgn0Z8MUBlYbbx846sh5UBsjtNTO/9iZRgEIXZE1zIJcNAx7pyTQ0D0El7knNyE8e21jl9e+WZ4pdV+dageI5F+EUzw2I1B5beBOgxsCVdr18fUX3Rpoo+VvSkCUp/X8/cqw0gT3fjEkds6T/aTRwXxNV8bWx1cfLDfCE01gvmY31oldMuMXPSRhLsNd6t9YbtZikpuA9zH/j6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6M43Vr377DFwbVJx1EfI7+OP0L7hjeW7Jfz5PeOJpk=;
 b=ALZYJfeFn32WO30EkPjwYv/BXlDmiA2pI4stgvy3d6WkkqRnsffHQLMpt0Mt/GsFszAWiQpXuHXZ/ghbKWpxFBQvuTdSVIL7QpS+AMg9vpRUqAN4zZX0qmGIULajDQuIhXt/8LJ2N/AAe6rUdXVBIpNKfymA44uvFO6SVa1z4soNNHbbCzA6PeAYGT/koLlE2n/hWbPRR4p/keDK78BYvJKch1sQ6L0JKJGG/YFbMl84Kr4xoICcx/8JKLdLbj9tAgUxrqBIJVPF7HJS8Tov9sObshrzbLeDLDIQBU7awQRv280vxVQ5gru+2pZbCirjmDMho2/6rkQn+wzaryYwZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6M43Vr377DFwbVJx1EfI7+OP0L7hjeW7Jfz5PeOJpk=;
 b=cwp7hIoaZ8/N9kZUMWDQw9Nrqdl9k3Fic8lVtcQtZ5Z1RT1xc85BxSCZnmlE9TAJ3xmghgTO0wms8bmY5ZEpb9fODrX4zvyOfQjJVOn/lgLjAXiSoVcqHvCB9kjUEZZfurzw+3qZ+ypNuqBj9GLkt2EDYgWm9yke8MIg3LCVtq1/jK9FBlAhLFjE1cjLwkLxY2isACdyZdllNOHiGayEStKW4h12MiPws8lu0NNuocUqG0Th69ZqPD5WaMgyN7fHO6luEBbhZD+EqYnuE7HUwp7p25KWlArjo9/YCEruw0CII8tsOKK/F33kJR7UPXcLkcAgbZ7+1EleNcT9ilisGQ==
Received: from SJ0PR12MB6806.namprd12.prod.outlook.com (2603:10b6:a03:478::7)
 by MW4PR12MB5604.namprd12.prod.outlook.com (2603:10b6:303:18d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 14:11:50 +0000
Received: from SJ0PR12MB6806.namprd12.prod.outlook.com
 ([fe80::99df:c2ad:bede:3eec]) by SJ0PR12MB6806.namprd12.prod.outlook.com
 ([fe80::99df:c2ad:bede:3eec%4]) with mapi id 15.20.9478.004; Sat, 3 Jan 2026
 14:11:49 +0000
From: Parav Pandit <parav@nvidia.com>
To: Etienne AUJAMES <eaujames@ddn.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
CC: Romain Fihue <romain.fihue@cea.fr>, Gael Delbary <gdelbary@ddn.com>
Subject: RE: [PATCH] IB/cache: update gid cache on client reregister event
Thread-Topic: [PATCH] IB/cache: update gid cache on client reregister event
Thread-Index: AQHcelsNETrXH1m3REa8uTq1nQRJXLVAgJuw
Date: Sat, 3 Jan 2026 14:11:49 +0000
Message-ID:
 <SJ0PR12MB680626630DE34A9FDA4DE8C2DCB8A@SJ0PR12MB6806.namprd12.prod.outlook.com>
References: <aVUfsO58QIDn5bGX@eaujamesFR0130>
In-Reply-To: <aVUfsO58QIDn5bGX@eaujamesFR0130>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB6806:EE_|MW4PR12MB5604:EE_
x-ms-office365-filtering-correlation-id: 385309b2-cc33-46f4-338b-08de4ad209af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?bFdVMm9jUGwrbmJERnR1Rlp0VmtHKzVpMllsOHdhL0xtOHNJdUUxb21KRXVD?=
 =?utf-8?B?R0lzcHlVVXhkbzlIWm5EK21rTzF1dC9EVWhXUG5raCtVRE5pUjVGOFdZcDk4?=
 =?utf-8?B?bWhlckZXWjBlek93Y05CVWc3ZUtKQjFpcXhVRHlPYi9QQS9HYTArMGxyTmR6?=
 =?utf-8?B?aVpBcS9SeFJQUWRXSXdvc0tPemFacGVFVlhuL1pZS2dEak10MVpDY3F4OVBU?=
 =?utf-8?B?anhTR3ZQYnFNdFMycGtMNUs3ajhvN0lTM2c5U0FLSktMU2o5VkZoUHlMblRm?=
 =?utf-8?B?Yjh6SWpKZElSSzRmbzk1Z3RKR3IwaGVKcnJWUVlOQURsMHFqRlVOZWoxWGNT?=
 =?utf-8?B?dS9Ea1FVb1BjV3dWUlFqMmMrWExJYnRLcHpQZE1xSU05Tkgwc3hFeko2V2Rt?=
 =?utf-8?B?U1d6WXgxWm5pQzlQVUE4aDJaZUpvOUlWd3kyMDhjSE9Cb0YwTlI1ZkJiY2cv?=
 =?utf-8?B?OWtLN2NzZFljSjB3Y2Z2NjdoRm5HdnAwSFYwUG5CazRObWtydlhhZUJ2YzBk?=
 =?utf-8?B?aU0vWTBQQndQOG9HeHZVcEtqTG1XMFAxMkE3R2NDSVhBL2N0SGkrZzRhQU1m?=
 =?utf-8?B?RU1lS1NLWFY1MGpwUkJyTVFJT0ZHMmNXOFNsTUVNdVVtR0d2LzZZdTBnODdL?=
 =?utf-8?B?NEhabnR4N3hQOCtvK3hBQkM3S0pWVkhsaldUaitaZ2hPRUlPT3pVcXJqM3JB?=
 =?utf-8?B?Tk43WmIzSWE5akRiaXN3cHZScGlZWVUxWSsvZWdyc3Bjb2FuY0h1dDdDYjYz?=
 =?utf-8?B?NHZjc3dCOHRIQnZscnNuUmJ3cjhIekFManVEV3c0WWdZTEgxcFFJT1RJcmJl?=
 =?utf-8?B?bWZQTTBiUUFEKzNicndiUWE4Y2laenQ5eEoyRU00U01nU3lLZ242aGhuTXds?=
 =?utf-8?B?c01TU21QcWY0Sll2SHlqRTd2dHA4STNwVkpvc01OTTBIY1ZzZTltRVkrMDBZ?=
 =?utf-8?B?TjdRMncweTFIaFVxZFY4WEVLeStvekptVHBXa3Jmclo3dXJmVXhIajkrcVdX?=
 =?utf-8?B?V0tVV3M3SUphWC95YnVzZ1lOcTEwUUwzSDFMdmFwVmI0QkxUQzdSWUFkQmls?=
 =?utf-8?B?RmNpRkdHYTV2cW5mOGJKem9PL1NOcExsU3o2NkZGNXpvb3h5WGJVdlQrYW9r?=
 =?utf-8?B?Y00zVElRbnlyUmxzR3pJT2xrdGhjNEVuK2lvWTlmaDBSSlRweVV0dEtvb3pr?=
 =?utf-8?B?aEtGK2MrdStmVHB0Z3krZEwrU3BKbGRmMHJ2aFZwWWRFOCtlZ1orb2hFQTFr?=
 =?utf-8?B?dmxacEVPcUN1aEtObzJ4dlcrR3VKbzlZRGtrSTJFSEF6Snk5cXF4TjJFRGZQ?=
 =?utf-8?B?Mkg2Q0IrWU9sRnV5UzdYdDhLWGZPZG5sRGl5WGY5dzVjUzhjTHlDanRvRUpL?=
 =?utf-8?B?aktPaXNicGk3STVuOTR4eXlFcEdXSXVRY1hrcDY4c1J2YUg5czRmUkxoRzVB?=
 =?utf-8?B?aE1SUDczdzBRR1pHM1lhS01CSlVQblZ2Y0ppYk1KTlYvekkrcWdZN091aDRk?=
 =?utf-8?B?c3V4ZWVaL1g0V2Y2RUh4czg5cWVuSU9ha0VuczVNcHpiNUdwUk1sVlduWTY5?=
 =?utf-8?B?aVBIaTByaWczVG1SaFVnVWJNQklvemxDenNVNGVEazhMemNZT0xETUUyMGpL?=
 =?utf-8?B?Vi84dDFSY3p3eEhrMzBaTzRtR0lwOENrdjlBWHZITWhwdUVyRXZxMFF4Q2ZY?=
 =?utf-8?B?QUxQUlhLdGMvWjM4QTZwZDhXZXBPa000T2RXSFp3Y2Rha1RIUzl3OGFTcDA0?=
 =?utf-8?B?VUZSU1I3N1hIWlloLzlrTHdZYlM1SC90V1FMVVZMYVFHYXVXdzJNakd6WW10?=
 =?utf-8?B?Z2s5SkN4Y1FDVnlTbm5aRktSL05wT2tJTkoyVGlPWnpaN3RMQ1BHcm42RVNP?=
 =?utf-8?B?WVBqMS9HNHNJTnl6UzBTdXB5dDRBNW1kYUtRbERYdTRRYjhwS29QVzdhYitu?=
 =?utf-8?B?Tk5UdFJSVUxHczZEalBSZnBYMjU5RkxucUxBTkZxMEpMSlpJejVFMWRYQnRp?=
 =?utf-8?B?Z1I3NEgvaGxiaVhzeFBidGkzanlVYUdTR2xXTjNGQ0ZHSXlJWlB0R0FucU5I?=
 =?utf-8?Q?xY35EA?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB6806.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V25JNS9kaHpuTWZKUVdpM1hqWEdUSXdKYVZWY2NrTlFRZmlHM3lyNWRBL0VH?=
 =?utf-8?B?cTFIRWhVVzJZQi9KakdST3JOMnV4OEdQcjF3d2p4OUhGYjR3OHFlT0ZJZU1B?=
 =?utf-8?B?Z0JnVE9UT0Z1UVc2YVBDR2NnYkdPVWFNbnNkaTFHWVpUM3dEbDZmeFZVaGtZ?=
 =?utf-8?B?SmRRTGV3YXg1SXdmMFZ1OWlmRVF3MmVwVWdPQUJtWklMOEE4VnFYeUFraUFo?=
 =?utf-8?B?MHlBSFJ6TDFmTVFGdW90MzJjb3FydGV3bFJseVBpbzJGSXNlVkl3OEpwb2Zo?=
 =?utf-8?B?LzdpSFZUOWVPTnJBeEEwOHo3RFl3dDNCeW1zMHczZXhWTEx1cWc2R1J4M2da?=
 =?utf-8?B?MHl1K1NNMHFpYUdUdU1MMXRBUnFlWkFsN2FWQmRVWkRYWVJrZFNlQStldTdM?=
 =?utf-8?B?VWMwaWpuaEM0L3Iwd2pIbktnUkl4bXg4alVYSzZ4MUlIWG8wSEhWSTFwL1Vy?=
 =?utf-8?B?TU5PYkNBdStOZDFvTjBIQ05TUTN5bG5WQVJQMHVvbStNNzB0eFVpNnhHb0Fx?=
 =?utf-8?B?Q2NPeUxYZlFJYWdyQXA1RUJUMTlDOW9pbXAxZ2dQdVlYRzF3cDJ1TjdJNFlD?=
 =?utf-8?B?allTZzdqYnlKZFh4SEtWa2gvWWh1WTMranRHMURxMDFjL3RsRTRFRHVDbTlQ?=
 =?utf-8?B?eGdSWVdVU3g0c2kyTWFuOVpPUlI0T0E3eFdGQ1dncUdrOE9KQ2RYamtmem84?=
 =?utf-8?B?QXovOExGM3V5eXEyOEJjVm9Fd28rS0hzNVVNL2w1STd5ZE8vcXdqVDhjU3pk?=
 =?utf-8?B?d1Awc1EzVUhQZWgvYXlMeUhScENJMy9oYmFVZ2tTNFB0SkY5d2NyaE8rWXAz?=
 =?utf-8?B?aFVCK0ZmNmFRcHZuL3Q0OHdQV3QwV1YzZkdnc2Y5ajZTT1NhRVpNL0Z2czFT?=
 =?utf-8?B?MWNhMFZrQStueXVVQ1RQMHA3N1NLV2d3ekpXMy82bnhsMm51djNkTVNnK2FG?=
 =?utf-8?B?NW9sS2VPaEs2cm1MVlh6Z243UmtrQmU0RG51Tk1MZmlaQjNWVFpCeE10eWV6?=
 =?utf-8?B?MkIwNTJ0MjA2MU5wNTNjQmF1dlAvZkZ4cmtxNWdVcERROUVtWTJmdi9xanVr?=
 =?utf-8?B?M3ZEaEhZNkc0VW9SQ29xMVlieDltOVZabVhyNCtIMEsveE84YThCSTZPMVJp?=
 =?utf-8?B?SWNramRIWlAveUhuU2hkS0c1dlFML0lnMm03UC82MWdHODM2YXV3UGdrWTYz?=
 =?utf-8?B?bEsvOGl0SlQ2clZwanRrcTRsSHRFNFRqVmFVZnI4S040ejhPUUNRcGIrOTVv?=
 =?utf-8?B?UDFjS25FTm1Nci9tSE8ycjAwSUxRaUZUZVBQSm85aFo0akdSWEJ4MGI5dzhM?=
 =?utf-8?B?VFBvVlI2aDI0MUc4K3hRRnhUY0U5cmlmVWZxeXp0RFJROVg2M2VLRUNvbEYr?=
 =?utf-8?B?b2s3b1ZpcVBjS1lIaXNzbzg4eXNFY0V2ek81MHRmN2V3bEdObGlVK3dqbDBa?=
 =?utf-8?B?cXRCUDdWcU92M1l5blBVZlY5cDZuU0VCekN4dThsTlQ5TytoRWdjMmdmVFUw?=
 =?utf-8?B?MThQdHA1YkQ0MDdMSEp1eWd3bUNRMmdyMWQ4ME1SVmNzMkJtaEFtYjIydWF0?=
 =?utf-8?B?Vy9rVWt1Uk85K2N6S1Z4eFB2UktoZ2s2YUgydm9pdFVMS3VSUDhqczVHa2dj?=
 =?utf-8?B?WW02TndTT1lXdnlhbnFEYlBlVTZxNlhjeWtsQ3dEMnF3WmF5aVM5d29mVFBV?=
 =?utf-8?B?ZVN1YnJVZXg5QlhxaUk3MVU1VFE3Q0FoZmNFV0ttdzZJT3pPaVNTU0FPYUJ1?=
 =?utf-8?B?ZWo5US9GLzdsS3lPOHJSeFEwNnhZWkhlUlVhQlFkU0NPRWc1cE5xR1N3RThh?=
 =?utf-8?B?QUtFS1hSMjBVR0dyNkEwQ2NoeHFMdXphR1AxbXRBMldkenExeHpCQll0aEZG?=
 =?utf-8?B?VFIwelRhSzY3UUVlK2RnQmEzMjBRb2JvSDkzTmhHbmhFMmJ0dHMzNjdyWGsw?=
 =?utf-8?B?dlhYOFNrNjhtcGQ3ZlZOVGpKdWtKRFdVTitjSlJwaTZXRy8yanZFZzA0eXFB?=
 =?utf-8?B?L3g5SE5RL1lxNkZOcEQzWDZzeTVkbUpXa2RjTC84K3RTbnhqeUV6RTFsYjE2?=
 =?utf-8?B?ZkdJbFQyWDNUZ3QveStYVGNSdkU5Szlia1NWRkV3Vm5URnV1TlhpdTgzZlRp?=
 =?utf-8?B?YlZwWFRvdnFpL3NHd1dJMHFyQzNGTW5pZ0UvTDZMU29FZm1GdFhqUEZaTDdL?=
 =?utf-8?B?aWdZSGt1SFFsZ0hzTlQ3dUIvTUc2MG5hOSs5eE11TTNmREM4c0tEemhRTjBP?=
 =?utf-8?B?bUVhcHlyeWQ3bGtzOW9QRDZOVlFXOHhTQTFNc2FScFRZMGxHK0NIQXJ3QTQ4?=
 =?utf-8?Q?dS1p82aE5PKL3DfoWc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6806.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 385309b2-cc33-46f4-338b-08de4ad209af
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2026 14:11:49.8823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sRs/mGNwHP3g7kRWsfXEZa5FskQwlWRWqkrCFuTslTMNMO0DeHwa7TrNNv4K03y0nVAxekj7G/9+s5Ne+sd7Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5604

DQo+IEZyb206IEV0aWVubmUgQVVKQU1FUyA8ZWF1amFtZXNAZGRuLmNvbT4NCj4gU2VudDogMzEg
RGVjZW1iZXIgMjAyNSAwNjozOCBQTQ0KPiANCj4gU29tZSBIQ0FzIChlLmc6IENvbm5lY3RYNCkg
ZG8gbm90IHRyaWdnZXIgYSBJQl9FVkVOVF9HSURfQ0hBTkdFIG9uDQo+IHN1Ym5ldCBwcmVmaXgg
dXBkYXRlIGZyb20gU00gKFBvcnRJbmZvKS4NCj4gDQo+IFNpbmNlIHRoZSBkNThjMjNjOTI1NDgs
IHRoZSBHSUQgY2FjaGUgaXMgdXBkYXRlZCBleGNsdXNpdmVseSBvbg0KPiBJQl9FVkVOVF9HSURf
Q0hBTkdFLiBJZiB0aGlzIGV2ZW50IGlzIG5vdCBlbWl0dGVkLCB0aGUgc3VibmV0IHByZWZpeA0K
PiBpbiB0aGUgSVBvSUIgaW50ZXJmYWNl4oCZcyBoYXJkd2FyZSBhZGRyZXNzIHJlbWFpbnMgc2V0
IHRvIGl0cyBkZWZhdWx0DQo+IHZhbHVlICgweGZlODAwMDAwMDAwMDAwMDApLg0KPiBUaGVuIHJk
bWFfYmluZF9hZGRyKCkgZmFpbGVkIGJlY2F1c2UgaXQgcmVsaWVzIG9uIGhhcmR3YXJlIGFkZHJl
c3MgdG8NCj4gZmluZCB0aGUgcG9ydCBHSUQgKHN1Ym5ldF9wcmVmaXggKyBwb3J0IEdVSUQpLg0K
Pg0KQ29tbWl0IG1lc3NhZ2Ugc2hvdWxkIGJlIHJlZmVyZW5jZWQgYXMgZDU4YzIzYzkyNTQ4ICgi
SUIvY29yZTogT25seSB1cGRhdGUgUEtFWSBhbmQgR0lEIGNhY2hlcyBvbnJlc3BlY3RpdmUgZXZl
bnRzIikuDQooaW5zdGVhZCBvZiBqdXN0IGFib3ZlIGNvbW1pdCBpZCkuDQpQbGVhc2UgY2hhbmdl
IHRoZSByZWZlcmVuY2UgdG8gZnVsbC4NCg0KPiBUaGlzIHBhdGNoIGZpeGVzIHRoaXMgaXNzdWUg
YnkgdXBkYXRpbmcgdGhlIEdJRCBjYWNoZSBvbg0KPiBJQl9FVkVOVF9DTElFTlRfUkVSRUdJU1RF
UiBldmVudCAoZW1pdHRlZCBvbg0KPiBQb3J0SW5mbzo6Q2xpZW50UmVyZWdpc3Rlcj0xKS4NCj4g
DQo+IEZpeGVzOiBkNThjMjNjOTI1NDggKCJJQi9jb3JlOiBPbmx5IHVwZGF0ZSBQS0VZIGFuZCBH
SUQgY2FjaGVzIG9ucmVzcGVjdGl2ZSBldmVudHMiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBFdGllbm5l
IEFVSkFNRVMgPGVhdWphbWVzQGRkbi5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9pbmZpbmliYW5k
L2NvcmUvY2FjaGUuYyB8IDMgKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL2Nv
cmUvY2FjaGUuYyBiL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2NhY2hlLmMNCj4gaW5kZXggODFj
ZjNjOTAyZTgxLi4wZmMxYzViY2UyZjAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFu
ZC9jb3JlL2NhY2hlLmMNCj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY2FjaGUuYw0K
PiBAQCAtMTUzNyw3ICsxNTM3LDggQEAgc3RhdGljIHZvaWQgaWJfY2FjaGVfZXZlbnRfdGFzayhz
dHJ1Y3Qgd29ya19zdHJ1Y3QgKl93b3JrKQ0KPiAgCSAqIHRoZSBjYWNoZS4NCj4gIAkgKi8NCj4g
IAlyZXQgPSBpYl9jYWNoZV91cGRhdGUod29yay0+ZXZlbnQuZGV2aWNlLCB3b3JrLT5ldmVudC5l
bGVtZW50LnBvcnRfbnVtLA0KPiAtCQkJICAgICAgd29yay0+ZXZlbnQuZXZlbnQgPT0gSUJfRVZF
TlRfR0lEX0NIQU5HRSwNCj4gKwkJCSAgICAgIHdvcmstPmV2ZW50LmV2ZW50ID09IElCX0VWRU5U
X0dJRF9DSEFOR0UgfHwNCj4gKwkJCSAgICAgIHdvcmstPmV2ZW50LmV2ZW50ID09IElCX0VWRU5U
X0NMSUVOVF9SRVJFR0lTVEVSLA0KPiAgCQkJICAgICAgd29yay0+ZXZlbnQuZXZlbnQgPT0gSUJf
RVZFTlRfUEtFWV9DSEFOR0UsDQo+ICAJCQkgICAgICB3b3JrLT5lbmZvcmNlX3NlY3VyaXR5KTsN
Cj4gDQo+IC0tDQo+IDIuNTEuMQ0KPg0KQXBhcnQgZnJvbSBhYm92ZSBuaXQsDQogDQpSZXZpZXdl
ZC1ieTogUGFyYXYgUGFuZGl0IDxwYXJhdkBudmlkaWEuY29tPg0KDQo=

