Return-Path: <linux-rdma+bounces-22212-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Yz3PAmWaLmpa0QQAu9opvQ
	(envelope-from <linux-rdma+bounces-22212-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 14:11:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE2B681002
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 14:11:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=ldThn6ge;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22212-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22212-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E607300B75C
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 12:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3467939D3F1;
	Sun, 14 Jun 2026 12:11:08 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013021.outbound.protection.outlook.com [40.107.201.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BD829827E;
	Sun, 14 Jun 2026 12:11:06 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781439067; cv=fail; b=P4yev14xb5MZ9jEZeLtrI45JgronbvTZCcL0eLN+n73C4UUdryrrH0gfPQC5ffcugcB8DYnyeoxW0hruLHl7ujxgmDA7bvzmza3+iUkcVO+INVG5nTqHrHQZQhwn3dXuHkH5oYclfvZBYzhCC1FdVRlxd4k4aoINT93YDS63cYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781439067; c=relaxed/simple;
	bh=4jwruzzDh7QBhP4b4mfcpa5e+NzNAfQn9Ospl+mTAa0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bcIQM0sR8MOgfVk2j9TucToDXNHLBq6cLBTYd+H8m5dNJiE+3VimPvUIP+hr0GkmIuFhuC0h7eCEC/24vpRUcCyosT3myzPQ4KdUxriX1KDwWMTVjnExqrjA5eBCzKBbysO08ooJYyTwl77sImYnBKiHqiYFX2V1U93goR7MxkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ldThn6ge; arc=fail smtp.client-ip=40.107.201.21
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bzVQLaxDJs13Kbw2ByIkx90YQAJ1+ib1cosyDUe3+RJbPf79+DJ6gVhnsbuIO4tUkcw+xrwumnqoaDP+aJkuA7FjMybrlpov6WCJuO1fJpMg8vBgoWRtxD5q6xH3XifCuGEppUYW2AWYLcXYtuswcp3J2xt38uQW0YhSQuvWJCki6I/EYXs33IEFv4a9JiSr4j5/hjeE4wKz54AQwmD4YH+r2SFLon4VIzEYRQGEKw/S3ZD9kE7TyNVzHT/4Eb85gU0KO2GWphNpw1OffJWcgBhb7WoROpANPcbMiHK9tP3lg4ZXJ1Q+y1qkoMoe99+iEbjg9cmjJUw/bmRP7YoE9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0s1j+HoPahgSYzHmxzvm0qVH8oI+m+/rpRV7xxb9DE=;
 b=ZdPSFCD/Nq8O+IRcrBsHql9fz+YH9bPaRISolE78RdiilddmEA1sCxgtawENHeimIVtjEvlML8ZGWaHF6fPFM/mrvLjeAw+8k4pHdaJbB+XJXkUXltUw6tiP9Kevb98LYu4qWaoz7LlupoTpTqaKdXp1H4jHfcXcdnbRPk4LnFZxRdTj5dW5jFmJlYu4OjLJmvx9YSl6uCdqaejNYzQTQHHOyHXG2qMPOFPPCXwvlMFhl2eA202MextH/dONsvKUGBYh03qOCKCspSvn484RQhAczlV/ig0hJRCcKgI5Vn4BZZ0t5RDLt8uUdeK/kpoBKEfJ8qn5ccBZXS06J7mgDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0s1j+HoPahgSYzHmxzvm0qVH8oI+m+/rpRV7xxb9DE=;
 b=ldThn6geRCHE4vJcS9XGU5AuePP0QVd6NmPdAwSglZj7WKnuuFtmJhfXMzUxijRkahYAvt9+sKT4LkFJPcdep7fOBnf2aBbVsKgZ/G4UI1zEXZvnP/NkwMRozN7QVk2lpuUwG8pOxKssqcYa89XS5hvT6JstJqTABCJVXKnmEBpByHTumKtvpk5urtxWR59mXYbL9C3LlRyAtPEvNJxu4U50D1Lq4duaKfRzGA5ticIkOC+Pg/ITuex14uN+fTIb/mL4GJEcVhLhJauoDbis5jA4BmRomhRZcw4GIuIMmA8L38i5WhWp6RRE7+/tQqRYutuGLR159tlxuuwIeiwYAQ==
Received: from CY1PR12MB9558.namprd12.prod.outlook.com (2603:10b6:930:fe::13)
 by CY8PR12MB7148.namprd12.prod.outlook.com (2603:10b6:930:5c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Sun, 14 Jun
 2026 12:11:01 +0000
Received: from CY1PR12MB9558.namprd12.prod.outlook.com
 ([fe80::920f:8246:c48b:7ce9]) by CY1PR12MB9558.namprd12.prod.outlook.com
 ([fe80::920f:8246:c48b:7ce9%4]) with mapi id 15.21.0113.015; Sun, 14 Jun 2026
 12:11:01 +0000
Message-ID: <92decbe2-87bc-494b-bceb-b8306fa15c9d@nvidia.com>
Date: Sun, 14 Jun 2026 15:10:48 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next 7/7] devlink: add scope filter to resource
 show
To: David Ahern <dsahern@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>
Cc: Donald Hunter <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 Shuah Khan <shuah@kernel.org>, "Matthieu Baerts (NGI0)"
 <matttbe@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Carolina Jubran <cjubran@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
 Shay Drori <shayd@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Daniel Zahka <daniel.zahka@gmail.com>, Shahar Shitrit
 <shshitrit@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>,
 Cosmin Ratiu <cratiu@nvidia.com>, Parav Pandit <parav@nvidia.com>,
 Kees Cook <kees@kernel.org>, Adithya Jayachandran <ajayachandra@nvidia.com>,
 Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Petr Machata <petrm@nvidia.com>
References: <20260609053953.487152-1-tariqt@nvidia.com>
 <20260609053953.487152-8-tariqt@nvidia.com>
 <943b4932-17f4-4a52-af92-b9485a0e8c7a@kernel.org>
Content-Language: en-US
From: Or Har-Toov <ohartoov@nvidia.com>
In-Reply-To: <943b4932-17f4-4a52-af92-b9485a0e8c7a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0337.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::14) To CY1PR12MB9558.namprd12.prod.outlook.com
 (2603:10b6:930:fe::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9558:EE_|CY8PR12MB7148:EE_
X-MS-Office365-Filtering-Correlation-Id: c1d97184-3e3d-4116-50cc-08deca0dffd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|22082099003|18002099003|6133799003|56012099006|4143699003|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info:
	XvAci7iblHjPpsAgAo3ODwWiFukEtg4J7CyBVGnl2LCkczB0z8O832o/K2UZaZqoJnFITyaflCpudSrqZI7vcGIOh9XXVvN64urBpFC9hGTOHtJ75x8ejYIq54p8yRn6qUb8HzcsLuOfwHcOZWLAW3eKExBoDVtxUcxAwgbP8tQMH64/dq6p5Vm7X/DkGQYxL+N8co+hNQ5+6bbRvAVN9D1mYGTyPNRS6mtjiIpFmpetlc2P44ec47AnX8eew87T6dGarjfiFcgPD6ZLDO7zbNyMFydNHC5CJOOgvqmYhfVgR4+rTguvlUHPyzzd2/RVSvBmfWPXaDzj7gNBTHhBA2sfLepClNaJevRhq+C4rW1qdG1gqo5uLtqDLXCzsNi4qKwb2s8IU0t/+8sD8EFDwgpirNImFpxWg9ADXD9Fj9qBAqfknYy77XjcyLy8qoH/xSqAPADGcbaCa6/GrdXDRX2hlarrd4WYTUYETQaaxNzlwz/7wzg4y0YKBbYWduzQPGxRiFuOmnVWxIFq0amGi0/ExHcK9fpPz9/aYv1lax1ce5j9fcxFNt6LNNI8ICbTcqAnv2y+zTYzGO6QEsyO8zS1GqmwYnMzeILRCsL8O6a+ij2enSqtEZD698pH44xR0nRBwOtEeyq8kgTUn423DFdMrtFhNb/dciNaihNX7Yc5oy+Ht4uRY//rpoRyZWPp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9558.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(22082099003)(18002099003)(6133799003)(56012099006)(4143699003)(3023799007)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjQ1QWNmSmMyWjNqemkvWEZEYWplWExLOHhMOXVhajRTTGZSRFl0NDNUVVNz?=
 =?utf-8?B?Q3hKZkp4UktKTXJmN3JrZENOdGkvazlBN1FDTkVJVUlQSGpEUy9ZQlhFckdq?=
 =?utf-8?B?eUhTZ1JxcUM3SDB1SWlEeXIxUjdVNzB5VTQ2cDRLZVVMY2dWS04xWTUvZWly?=
 =?utf-8?B?SXlzMVdNQWN3MXowSW5ROUtWSkV6VEVwMUo5Y3YxUXkxaldQK1dLTVJSb3hG?=
 =?utf-8?B?STZOeUo2T2phRUM5b3JraW9XRWRLTmpTOFFFY2VOdlk3NGNmZmlyVnA5WHRB?=
 =?utf-8?B?akdhM3p3SnVXU3hDYkNRTVdNRW40dGo3Y25VTHROSUgxc1BDbGpCWVRPOVEv?=
 =?utf-8?B?UEd2QWp5dGV3bHdLR3ZQdGZYZnY4NXZmQzFtc2RITEpOZUdyN0JucG9KK0pl?=
 =?utf-8?B?bFlNdFZINFMrb3AwaVdLb1ZUZTNsZzkxSGFkNlRQUVVNRmw1M2UycVQ4S1NN?=
 =?utf-8?B?UEVFcFRyMzJTbzVmamZIeU1kWFVhVFhhbkF2YWVuY3ZNUW9kMTd2WWh4S3py?=
 =?utf-8?B?eU54RWIvclg5SkwwRGkzclVoaktRRG5tWThrMG9lWk9EbHBQMnJlN1Z2dGR0?=
 =?utf-8?B?aUVZOU83eWQ3U0xKMXQ0TS9RQy9hL0hpTng4b1BySDVqYjJDYVc2bDJxZ2dD?=
 =?utf-8?B?RWpTQk5HTGNZYW5MbWRkUWJlOEl3SURISHRmaFM2SmJiLytZMWt6RXprcGV1?=
 =?utf-8?B?d3QrY21KTlhmVTF5WTBaY1VDZXN3eWxPc1N0QnVldEFMbFcrSW5VU095djdD?=
 =?utf-8?B?Z1NRS0xwR2RKWFZDL3J1SitvZWRvZER0ZFRlRzRvM1JtcWx0R0hLV0JXYVdu?=
 =?utf-8?B?VHV5Zmc2UElTZUUwa3dDS2JocXVoOUxmNGx2M0lmQjhXV2p5dW9hN044aktI?=
 =?utf-8?B?QXhCODNWUGlpelE5ckhWVDZqVDdyWDVlNkRYWlB6SVlHN3F1QkVqcHFmQ25S?=
 =?utf-8?B?WHB3d3Y2OGduczFtS3p6UlZtRzhGYm9jMHdwdU52a3g3NmdrbFI5L3FhQWVj?=
 =?utf-8?B?L0FQY21BOG8vckhxZnRjL1NjaHo2RnVqNnBQZ2N4ODFuVnJsRWtnVUNIcFBI?=
 =?utf-8?B?NlM3NlNja3Uyd2NadHJFZ2hCSjBicDlxSEVQdWIzVTFSVEROZFFZYnNhTTk0?=
 =?utf-8?B?cXpueE1sUkVsRklPRi9lcDRIR1JVSm1rMWQrL3h3UldGd2x5bkhSYUEyL0Iy?=
 =?utf-8?B?QzNYWTNlVmNLbnY4aW56TlIvdUNoVmVEdFVXb3QydDRwMlpmOU1FUzVnZ2lM?=
 =?utf-8?B?cytBZU9DOHZ5MVlCcjdER0hUMkhYOVN5WExEUUovcmdhTHA1aWh5RElDbEpC?=
 =?utf-8?B?dGNiRmMxdmREK1hacUlIQUpJS1FUVU40OE1QRTA3Q1E3RlZzdTNtWFZya1ZS?=
 =?utf-8?B?aEtja083QlBaT2lUOTF2UVduQWNlZnlhVVdadDdqdElCVkhGVjlCeHAxbk5a?=
 =?utf-8?B?YlJyV2RmV2hNN1BWNEVyWjl2SFN2WjAvemZyWnh4ZUJjS0I3aVVTSjNOcGhK?=
 =?utf-8?B?WnA5VUZNS0JsaE1mK0NzdUhQL3YzWHMxbzhNYUhEZy9mV1N3Sy9oRDJjdTNu?=
 =?utf-8?B?TDhLbGVNUXRtTDFrK090bWVBQlFlZXl2bW5yTS9JQVZWekUycklJdGVMN0o4?=
 =?utf-8?B?bXhsb0YzS21EeWVCTE8vY2NMNzJjdGErU0lQdGUxWVFobVhBNnk5aTJmZWln?=
 =?utf-8?B?SmRHVTZJRG1xeGc3aytEb0lNaVV5WURsNDdWazVnZzdhai93cGZKVEY0a3lJ?=
 =?utf-8?B?ZTFGQmV6T1YySHRBMTFpZDdNRldVTmNoMFB0d1lzYytnLy9RcGQvQVdpbGV2?=
 =?utf-8?B?UDlPZkVBK3hUOVlRSW1lRlZBRnBNTkd1NXhBQ3FhQ1lZb3VKSTUxWXVSdW5M?=
 =?utf-8?B?QVdDU3J6K1dEUExZNFRodkNvV244SjlWSndScytQbi9HMFVnTkVnaVFCL0lC?=
 =?utf-8?B?VVRQMmg5UlVhdVFPclVCQnhHcmJmUVdBWldQR2Ezcjd2UXBxd3EvU0lLandx?=
 =?utf-8?B?NDZvaTlNNVE3Q0gycUorMm9wQjhRL0I0T0I5U01IR0JiViswS1BOM1k3UmZR?=
 =?utf-8?B?dEdOelpONGVrVyt3Sm8yRmlGK2J0M2lxYnZwck5IRHNwazI4TmZjKzN1enJz?=
 =?utf-8?B?ck5WY0M4cy8zZUtESnR3MWFaenlQa1VOZGVuZXBkaVkvNVIydXVoWjc5Risv?=
 =?utf-8?B?TDh2WnhCZnhLWThnLzlBNm40a09DU2FMUkNBSzJDZUZnOXhreU1xWGx3WGsz?=
 =?utf-8?B?RFkyTzMxV0tUaU5sVmI0YXZ5UFA4WWJUYjgrSEIzQXZKOHBSbVZldlRDNVRm?=
 =?utf-8?B?L2w4cHBsL2lpYm1HcXNLbi9ob2YzdHAySE1nN0VuY3dQTXRHVVRnQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d97184-3e3d-4116-50cc-08deca0dffd0
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 12:11:00.9197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k3eDi2KP74t7pUjCtnrswsl4i5mYKTkB0/Vw1JRrrbJP6x6fEpK9XnV/DzhYlyXLFgbuD0K0WAzRki99p4TRNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7148
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:tariqt@nvidia.com,m:stephen@networkplumber.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:horms@kernel.org,m:jiri@resnulli.us,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:saeedm@nvidia.com,m:leon@kernel.org,m:mbloch@nvidia.com,m:shuah@kernel.org,m:matttbe@kernel.org,m:chuck.lever@oracle.com,m:cjubran@nvidia.com,m:moshe@nvidia.com,m:shayd@nvidia.com,m:dtatulea@nvidia.com,m:daniel.zahka@gmail.com,m:shshitrit@nvidia.com,m:jacob.e.keller@intel.com,m:cratiu@nvidia.com,m:parav@nvidia.com,m:kees@kernel.org,m:ajayachandra@nvidia.com,m:danielj@nvidia.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:gal@nvidia.com,m:idosch@nvidia.com,m:jiri@nvidia.com,m:petrm@nvidia.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,m:danielzahka@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ohartoov@nvidia.com,linux-rdma@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22212-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,intel.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[40];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ohartoov@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ADE2B681002



On 11/06/2026 21:53, David Ahern wrote:
> 
> On 6/8/26 11:39 PM, Tariq Toukan wrote:
>> @@ -9010,13 +9029,29 @@ static int cmd_resource_show(struct dl *dl)
>>        uint16_t flags = NLM_F_REQUEST | NLM_F_ACK;
>>        struct nlmsghdr *nlh;
>>        struct resource_ctx resource_ctx = {};
>> +     struct dl_opts *opts = &dl->opts;
>>        int err;
>>
>> -     err = dl_argv_parse_with_selector(dl, &flags, DEVLINK_CMD_RESOURCE_DUMP,
>> -                                       DL_OPT_HANDLE | DL_OPT_HANDLEP,
>> -                                       0, 0, 0);
>> -     if (err)
>> -             return err;
>> +     if (dl_argv_match(dl, "scope")) {
>> +             const char *scopestr;
>> +
>> +             dl_arg_inc(dl);
>> +             err = dl_argv_str(dl, &scopestr);
>> +             if (err)
>> +                     return err;
>> +             err = resource_scope_get(scopestr, &opts->resource_scope_mask);
>> +             if (err)
>> +                     return err;
>> +             opts->present |= DL_OPT_RESOURCE_SCOPE;
> 
> Comment from Claude that seems legit:
> 
> Issue found: In cmd_resource_show, the scope path sets opts->present |=
> DL_OPT_RESOURCE_SCOPE without first clearing opts->present. In batch
> mode, dl->opts is shared across commands, and the non-scope path
> correctly resets opts->present via dl_argv_parse(). But the scope path
> bypasses dl_argv_parse(), so stale bits (e.g. DL_OPT_HANDLE from a
> previous dev show) remain. When dl_opts_put() runs, it writes the stale
> DEVLINK_ATTR_BUS_NAME/DEV_NAME attributes into the dump request,
> silently filtering to a single device instead of all devices. Fix: use =
> instead of |=
> 
> Are you ok with the suggested resolution?
> 

yes, thank you. let me know if I should resend.


