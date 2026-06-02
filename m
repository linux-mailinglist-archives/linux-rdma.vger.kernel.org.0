Return-Path: <linux-rdma+bounces-21635-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IGnONPUpH2pGiQAAu9opvQ
	(envelope-from <linux-rdma+bounces-21635-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 21:07:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF406314C6
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 21:07:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=SQTSuLf0;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21635-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21635-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19BCE303B4D6
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2026 19:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263443A453C;
	Tue,  2 Jun 2026 19:07:15 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011020.outbound.protection.outlook.com [40.93.194.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA5739E18E;
	Tue,  2 Jun 2026 19:07:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780427234; cv=fail; b=sSvAkSt0gal76vhuC7uoViWF7L8xK34lSdrbaA9TIIGnOljmFHMu00evNZiMqgyxpQE1Gpt14BcHd/AUq+tLlLcNemDAu+ohoAdRh2O3R4qB/bj4MVEH+AYKK2TB0/lrZrA2N1KfoQWDPJNhd16tk5bfGWtJtWqhDO+Qw8iYM2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780427234; c=relaxed/simple;
	bh=GhakwcoqIy0EwJ166UZV8ObjP1dU/3g164ArUwGoNFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S8tEGp2bGnMAPCj0wDjEXBbc3hGe+4xb+YOThcWLM1CF4aIkpXB+Wx+9xv4peOtzWCIbrGBFkomMt8Xxm1TZcma0Knu3I+Vq+6+lS33b8c7tEK81k/smR11mhmirwQiaMS26HaYP8kA/t3iQvJxwq/WD+NY+GgRreKKavDo7la0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SQTSuLf0; arc=fail smtp.client-ip=40.93.194.20
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YUBm2C38U70Y2YOXoty7k1qHzQlnyfAhDmEqkPySk/yWJ99FR179xirUAi/5RqEO7qjSmvTFnBavY44q0wtc32HN4kda8kEU9H7iUTQ7mVhCJwpFvw7kwWofQI5cOb7gszsmM1geDespjxUNYmALGWp9pVrD5us7FDeTgNFkZOuCYitidTa/YoNDGx8qQVHbtAFcGg/9xLEDaMolDhs4fNZ7AfHR+vm7i1nFc0ZNIMm0YxHtmQiBFIySQXfZiQlGoSlj7O3igBBNZSaqTrcC1mnVzg1k/XuPhWIXTrdj5QV519y9Y4QJyRMTQplM3WVuhvHG5LVmPhnmYQXvj68O7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=enq0NzkH2xbSzOzw/UvYJwF/3OywQRy0GfT3hj54Mq0=;
 b=a0QrRM5TM+Q1s+fIcADXtiwV13UcPDQubYvBa8Jskz82QmdAlzluQbmofM45khDvEtir2f88wPvQJmwFMDvCx+fFV4KU3Usv5uZssarx4LkOl9PsR80yWtoDXkibNHNiHpWO/ehOI8EHTCWtNSE5Fhz3NTKPA2Wyvxo84UleognEy+pWBYawlNP+YaVkXy2Q0dbaDE8R7WyCj7+WxzbAEEE1CoJL7S4v+80f2SyKzRKyRNwGe9VJP2LOGXN9eRRo+MYMtYPCIuqImiHmWjqU1f1qL9jdO9a4+mN87p2PvHQFuVylYU4EVEbmG3WKp6ZgDup58yTNqZc+hgqYh62AuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enq0NzkH2xbSzOzw/UvYJwF/3OywQRy0GfT3hj54Mq0=;
 b=SQTSuLf0lqp7iQtOCRC0ghjTKVB7Lc4CzsTTlt2BYiTzhVeZzGB4A9gAujh/kWnGgLneVTgcgxLU5ayJiA7nIjkDq+646VtLFbu5Ld1VtuUxtkrwuHynJPObM/ysiank9Utizp6OtbyTwaSFqIcKbYuMA+VToRE+Zh52hneg2fffhg2HHFvlrEyXbX0HCUCgdKssivMZ4EWxzjaPC5AHGg0R5rDPvF/d18A3dR3i4cZAlKCZPmgeaa3z5UTwI2N3ozOzAYjerFp22YbELM4pfokMk95hUJ9u/VZxmWGP1ebKfkMjfCVb63OJ0twIzqHli9fSoiISbvIa1O8/sVsD1A==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB6398.namprd12.prod.outlook.com (2603:10b6:8:b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 19:07:08 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 19:07:08 +0000
Date: Tue, 2 Jun 2026 16:07:06 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
Cc: yishaih@nvidia.com, leon@kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, anand.a.khoje@oracle.com,
	manjunath.b.patil@oracle.com
Subject: Re: [PATCH] IB/mlx4: delete allocated id_map_entry while sending REJ
Message-ID: <20260602190706.GA1054315@nvidia.com>
References: <20260506090824.359239-1-praveen.kannoju@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506090824.359239-1-praveen.kannoju@oracle.com>
X-ClientProxiedBy: YT3PR01CA0065.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::33) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB6398:EE_
X-MS-Office365-Filtering-Correlation-Id: 907eff14-a151-4f91-3d1a-08dec0da248c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	zTO34Zf3SLjQrR8MUaLjSPG79T3KHqeBVg6VjWkOuyGB+Sxf0F5TLJRsEFswxhMSrIMB2h/lrDT6uA0o5SJ3zezAyrewUnPnQd7Ny/Z+LXRghYUcpASwcelkapKD7jWRaEQTbedWcTCzIILLIizq2q+OwwhY5aReiGJDKpQmw5rmqoAe3GbsKxGmof7j20sgYb00hxMoohm8Rt5KqX1IPEVKSNhtzC5EoTJZ9JpUQF2E/OvPuwY5oNfm0Jy7M056vhMsXYgGRDcEN65nGns8oiyKf/euz2QDPa3bmTub8p5qKPAhAaWogL6fuhReqznBCI1+Qqh2uzchM+sYts4kHuwZxkhZ2HZO5NNJZa0yQwrhzTUZ8RWgQLMn4d073EkmtsI8LUw9pr8R/zMSyu9rX2myuOm3Swpo2hQ2uEhI2K+VLM1B82e8DY07y/DV0q3gWXfS8kXipnkBvrqn6sOPS84Fjk70SpG7tW9f8seBtpl6U/ZC+ek/ExGxvCMgGrSs2dkcRSN3vaDSXktfrI5iQHUFmKSVFp30GoecCd+S4/u7s3o72eNtmXt/knOrG/PklMAbDFT99GmJtF2WD0k3sYtOJSuWGuLwDcN03iyCZ3OUnc/184rXrYwUAIerUpmRbEH/Tey9vvmXVuQSdWT4HQ+SqVBTkszw8fuyOmc+1nO24uvJ5ZyyUUW5xA2Xyna0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099006)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?udiZDaBH5sMUlv5b1Vf1+OJGoSvdgKfvXU7D74lEFkblm7pTlBTuuOYxbX/X?=
 =?us-ascii?Q?ykgAJeBzaR54IDq2VQUOuLx0tzuaRreiwX09WkTS7ZPjPWyfuSofAZztAEjC?=
 =?us-ascii?Q?JxYxCPmnmx3T2IR0pDA0vhxyGtOZQJELT9HlmnDbdkysbEVsJ54mq+9vlw8U?=
 =?us-ascii?Q?FstBpvm1VwAHXfN8S5L6Fd5onzq8WzT9JpqNtcQgUKbZcTZGZo4lK2DxPIBm?=
 =?us-ascii?Q?KTUWJfWKJKBuFwX0AqGskyx5RLDMUwnh5u7KX5L6iNzUK3xhfF/KLUnIRI7P?=
 =?us-ascii?Q?ugGrkqHRc58ppMa3CLSrp2cmKraDHOLLA5Y1W4asKWFvuZGcQgIJ9uz4bfza?=
 =?us-ascii?Q?8IsuiOAx1rIhKfz6Q/9Blwlmc1WaDoQ8XgIKtvQch0Te3pYKrU6bQPylC+7c?=
 =?us-ascii?Q?O6vCoLPtNWhQOa6La4p9ZbIB7tlVrX90zbDc1/qo8/y0hLj+0bRKp5icYkIG?=
 =?us-ascii?Q?jNTJ0qVU4o5zcUR4zT4BahMQy8rlxrcHW1Aai+CQbF7y8D+qIDTMN2G6nQwK?=
 =?us-ascii?Q?J3xN+DO7QWw+CYdkdf2jNEojCHuqmZAa7KlRqFMvQjg6A+SxrXKGtGS9FuC8?=
 =?us-ascii?Q?D0JRygxQeNTqlNevgJxtP/0vuuK5RpHUuLc9RaQcIxBWs4ZrXte8RkWDRItE?=
 =?us-ascii?Q?/nJS++A9TME78qbK41K5Ycl6jZVkLAt+SSmbSfvyBNMSqWsomgxEkZLEG5ql?=
 =?us-ascii?Q?N1fQ5QpZdenOzGreQWwenLz3/1XAF0I1Ygo0bb4PivpqbBtih3Z4SVR1PKsO?=
 =?us-ascii?Q?vD22YYmyqbbzj631nmlr02I/4nJHg+P1IM6kvZG0wC7t2PVcyxecaUrEw6oE?=
 =?us-ascii?Q?fMA8zmhvxt3+a+OuTpQaWHiCY8dr5dNrQu+YbIkYElxdlTBE2h1lXdZiDEsT?=
 =?us-ascii?Q?/Lt/9EAcJcJu2LEugojMTMErsUSGo11/NZz4m2do23hCTe9hdNR5+hPm8F8+?=
 =?us-ascii?Q?+rbCcJdqq0lpR9fka6V9BV/17rCDq3Xy8BNZdZaVtJj4R+jlrA5WOInd2JkZ?=
 =?us-ascii?Q?RNSJonJGTlIs+ZVga9honFSIhSQmfAKJ41xBkvFBQfd/dArlyqKe2Bf2BT/M?=
 =?us-ascii?Q?DEkC433NzrGZMvRlO31k9WOTfSPbgj9VkjPnNzzi075LUsyAfMNeXAUBDKjX?=
 =?us-ascii?Q?ttBGGVgoyZh97WYIxBonvJkKNb+XHFT9NlZx4jPCDKIcEtRoAPN/W4vYUYmL?=
 =?us-ascii?Q?kiaeXBakZFUc3aJpGmbzhgX0t5KsqaVUZ2gJBLgffKgAIOQyS1KDoXbx2Pif?=
 =?us-ascii?Q?UCg/lg9747KWt6DjEBbFHQkhDqZlzxTfRBvR2ClmcFhqO236kKfXj0J7M8Pb?=
 =?us-ascii?Q?Wt4Zd9QNW1zf4uLcnQtvkes4IcbAxlHXirvXALzYwro96Tzl8KKpLHSUkPcJ?=
 =?us-ascii?Q?1a1KKJdPaD8VpgIzKGOmlajQfsmi8yr5ZRjt0WxOGjfH++MTcnZrvicklLvS?=
 =?us-ascii?Q?niulyb88omrW1KEYMBp/2ubQ/WPLqFyMroCf16xmpP24ts2Ngrg3znF90Mzi?=
 =?us-ascii?Q?d94yFFKb9eQVd2jKbSR+Jx0WyLiPwbdQF0PHO9U2a6ZiN5fJA/U9/J3DXcUY?=
 =?us-ascii?Q?7pgxEMf81Fg/b0uE8xoqefMJD9hadS0wVJaV8E8Y5GrzdTAQSBuVpXSJ9uUD?=
 =?us-ascii?Q?37R9Z0pjoR1t3s2i/yCLAVXmEQuox5nQ6ilMMOpc3LsvyUKHFBJ/3NTqugGx?=
 =?us-ascii?Q?uVCiQuuG9QJkXFyZgRfP831ihzJuiC0K4WBokzbbMG18ticG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 907eff14-a151-4f91-3d1a-08dec0da248c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 19:07:08.3580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 84wEAwfwOM2Bjj1lbVffHXg67ITXr+AXgctZwZj119B6Uv9Udm7rVKQq/O7JK6Fb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6398
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21635-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:praveen.kannoju@oracle.com,m:yishaih@nvidia.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:anand.a.khoje@oracle.com,m:manjunath.b.patil@oracle.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:from_mime,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4AF406314C6

On Wed, May 06, 2026 at 09:08:24AM +0000, Praveen Kumar Kannoju wrote:
> During scenarios where a REJ is sent after a REQ or REP, the allocated
> is_map_entry remains in memory, resulting in a memory leak. Scheduling the
> entry for deletion during REJ handling, if it is not NULL, resolves the
> issue.

Well, the leak seems quite likely, but I'm not sure about this fix.

This code looks quite odd and it seems to have other races as well, so
IDK..

> Signed-off-by: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
> ---
>  drivers/infiniband/hw/mlx4/cm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx4/cm.c b/drivers/infiniband/hw/mlx4/cm.c
> index 63a868a3822f..21f2f401ed61 100644
> --- a/drivers/infiniband/hw/mlx4/cm.c
> +++ b/drivers/infiniband/hw/mlx4/cm.c
> @@ -321,10 +321,9 @@ int mlx4_ib_multiplex_cm_handler(struct ib_device *ibdev, int port, int slave_id
>  				__func__, slave_id, sl_cm_id);
>  			return PTR_ERR(id);
>  		}
> -	} else if (mad->mad_hdr.attr_id == CM_REJ_ATTR_ID ||
> -		   mad->mad_hdr.attr_id == CM_SIDR_REP_ATTR_ID) {
> +	} else if (mad->mad_hdr.attr_id == CM_SIDR_REP_ATTR_ID)
>  		return 0;
> -	} else {
> +	else {
>  		sl_cm_id = get_local_comm_id(mad);
>  		id = id_map_get(ibdev, &pv_cm_id, slave_id, sl_cm_id);
>  	}

What is this change for?

It does look like ignoring the rej isn't right, but then also why does
this rej just search and free but the rej in the prior stanza is
allocating too?

> @@ -338,7 +337,8 @@ int mlx4_ib_multiplex_cm_handler(struct ib_device *ibdev, int port, int slave_id
>  cont:
>  	set_local_comm_id(mad, id->pv_cm_id);
>  
> -	if (mad->mad_hdr.attr_id == CM_DREQ_ATTR_ID)
> +	if (mad->mad_hdr.attr_id == CM_DREQ_ATTR_ID ||
> +	    mad->mad_hdr.attr_id == CM_REJ_ATTR_ID)
>  		schedule_delayed(ibdev, id);
>  	return 0;
>  }

SIDR seems troubled as well.

AI pointed out the use of id like this is racey too.

But broadly this seems like it might be the right direction, but the
commit message should explain what this logic is alot better

Jason

