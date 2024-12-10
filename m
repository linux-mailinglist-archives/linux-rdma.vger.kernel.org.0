Return-Path: <linux-rdma+bounces-6392-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A6C9EB5C3
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 17:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CDC61885DCC
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 16:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219761D5172;
	Tue, 10 Dec 2024 16:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uJz78Qv/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3374423DEBB
	for <linux-rdma@vger.kernel.org>; Tue, 10 Dec 2024 16:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733847173; cv=fail; b=fLgVL7p+tiRIRVoc6TTeDamaA+ei53DGkvmKw5o2jk42eN7LDvQUwGV6B7F+53VoaTvIODI6JePabNkFVcYqVINbLqP78PgynfZ0GhwNPgkinjC1z/sU4XM9mJmQVmULplESHHd55Emuc+DgWcZS7bJAXBfYnRjtyuTJ+qP/GCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733847173; c=relaxed/simple;
	bh=mY4frR8hJbM1OGnyAa4LYjaCyQkUyuMfM6kybPAm82U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ehpUzjaqLUGqN4iYPVO7fF65Vq6eMeZpT2UAVbvcGjcWfmyO6n45xGZKTW4ii0JG/3fPI7qpr0ID0xBDo96EoVIGbe6MaG5Ds1ouys60E0TR7dxxUsLx4mC2Qy72G7sDeRjCAEii9WIPfntB+dm9Sue+7ot5bASZrR7fUk5k26Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uJz78Qv/; arc=fail smtp.client-ip=40.107.94.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bTQ11d1yIEuo73i+kiIr+IV/ROzc/eG1+eACxN8bABVDLPw7zlJ80xZW//M2322Nd/xcj1C8OE7oaHZfYn0qN8B0xY6Ofg0YOYUYQ4j85h5olMFmfN21CO9qL8IT2jhYVXB9m34UqALccz35IpjloIFeLrTSnNfQh6uyLHiUcmVwphWE5QO0DJ9WkAPSus7RReDJRMdYU++yBL76Eg/0S5bowoK98UMAqbzg0DvclGuI6C+xR2hk4XNuHEMkuOPNob1XGX9eIFyCGRTNlXc00OHafFRQdAbmzb1gMrle2tJQXwqXNjsz80pyMtiJQ8Xxu4P/2dSWbqrEkz1KzCaNWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5uk7bwTwtQxVcqzd7IlmE1BFxR7x5HALpBpPNRPXg1o=;
 b=sjWAmDNzws2S+W2xZrhEwjkJzAm2FDKfvxV/LZ339Ar5dL5FXb1RwtWMEayOKvBAdGBsLrT7Ylq5fFhXcxoQprg02n/SIeUEug41VmOGPfaAk038+NT3ObBn+5tMi5srDxf0PP2d8LbmGIfv5bdWRENlhFnpRTBwI3IbhCNFx7CB7hroqXKzRd4As+u2UPYqeSIH+LI0L4dZlbL16iUVGk2ckmelrKCUPnDeBZqfi3YRicCgWD7tmVmyoiFv/B6pagCYWWPDDrlR2yEAynP5MUvd9n+0h2xPPYq+5f7nlKylnkDaqnU5b2powVjsTKxoji5lowlQQHfPE4lRkdQUWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5uk7bwTwtQxVcqzd7IlmE1BFxR7x5HALpBpPNRPXg1o=;
 b=uJz78Qv/4cD5zey3QoARv8KnCVB1aGYpUSbJXYgZsc8zijL5idIf1Q3ZRFGwAV/YN3FUdQC3wBK7WJP/Z+Rh5VNO8JxqdsmbNoKN/jk6PoKmZ03W7+wC7u/FKHGL9B5HnQytVkZSAaEJB3sqm/Gh7/aky5rF3kPnHMrMMeGAOhjdjqtLjzAMsJDV50cV/EyN800W56OFE89DCDregoH0/HfvQ9H2euRD4owZMMguTZYcbjpSDvMEcaQa2f4jiLRiDvviiAJOf/NKeNio74YtZ2Cm5M4b4aQxFjvE4BCKDNF9phKkNjqSfZwIdsc2dfaTbykDiiMJKMKNs2MSDpvnmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN0PR12MB6295.namprd12.prod.outlook.com (2603:10b6:208:3c0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 16:12:43 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8230.010; Tue, 10 Dec 2024
 16:12:42 +0000
Date: Tue, 10 Dec 2024 12:12:41 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Or Har-Toov <ohartoov@nvidia.com>, linux-rdma@vger.kernel.org,
	Maher Sanalla <msanalla@nvidia.com>
Subject: Re: [PATCH rdma-next 1/3] IB/mad: Replace MAD's refcount with a
 state machine
Message-ID: <20241210161241.GJ2347147@nvidia.com>
References: <cover.1733233636.git.leonro@nvidia.com>
 <b6b991b75a7d8cce465a6c917ef0db1c264165bd.1733233636.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6b991b75a7d8cce465a6c917ef0db1c264165bd.1733233636.git.leonro@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0373.namprd03.prod.outlook.com
 (2603:10b6:408:f7::18) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN0PR12MB6295:EE_
X-MS-Office365-Filtering-Correlation-Id: 0920176c-005d-4003-d08d-08dd193579d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g1WPnh6fF7nC6m8OODD+7lKkzqm7SYM85aPxSZpcnElURVCV3CX64T9RtD+O?=
 =?us-ascii?Q?gSJFKOWTwrzkqrPpP45y/Wqjdan1RrpOolo7tmfhF7lYYBxlQL0nWVTnrpVD?=
 =?us-ascii?Q?1nkqhJ2DJN6+SnwvYb5sSqzOURyMV+UYsUCb2uENviKdl9FJ+Tob0hzyKS27?=
 =?us-ascii?Q?uYyu2AtNMkc+bchPpAguBRiRpx+lvNwY0yIpCkkQVqF/FaZp0GJR3JOUYXtc?=
 =?us-ascii?Q?slhMcWlj/3ZIsiouHxe5YexcCkX94qp9F2qlBNLEfENvlYUZVEkQsS19GWQA?=
 =?us-ascii?Q?C5JRj0bIfBPgQEt/8SRzUTlZrTm/j+eTcDLDJ00DFjbL0fJ1Op9Yh479xHG1?=
 =?us-ascii?Q?Sqn/pNhXY7PnlEUYXwiT2nsTS/597ORWwfBvfOJqYCZ4KDstkevnBQTpM8vm?=
 =?us-ascii?Q?p1kd1xgDP0ETMp2YPolE7oyzAkHn5I/h4lCgBx3a4k6pWOn9gN1vZNt9AX+M?=
 =?us-ascii?Q?IylaOru/rVUU5aV6S+G6aTWCR1H3QXXT3pSPTfaafHYGSXYj+oskGiaFgbtz?=
 =?us-ascii?Q?nScs9rcsLIZ+Pa4+tCbTFt6oiz8fjWvrWkJAq/YP/yL/Utkv9Y4xE7le+jaz?=
 =?us-ascii?Q?a3HC8K0UelnmyNU5tDzGkKId/H+z7EXCqSKw7qFnXPy6bfpkKPahRc+efqqd?=
 =?us-ascii?Q?iWsiFk+Qz+cJeY9DYl4z7ca3vcaJNdMl7EPTcNgA/7yPh38IFarhDv1HWvh3?=
 =?us-ascii?Q?sP4Lg7a6scX2ovHuoP+lkUnpDil0L0VkQvciknXGfa0LxIWuGJ+94Pr559fO?=
 =?us-ascii?Q?qTw/t7+r+njZU+YkRW9N20c8AYm4mIST8UnWlCrcPMp0CydT7sso6PW6bHTJ?=
 =?us-ascii?Q?7H5avK5BTuWVEGeFF7UU2L8BIp8vx1K7Es9JCv6+SnXYGXybWxXO1G1CcBjY?=
 =?us-ascii?Q?4u9j6AQU87msDo40jtc+FAXiPlQhhMnRcEDxkdsgSJ5lDbE9oAlCd96xcSYc?=
 =?us-ascii?Q?uRnmEgJzs8SwHncizPixzBQC0VAP+TFSyb2Q5517fRbYnmzKOwEl3MEbjZW2?=
 =?us-ascii?Q?uQgou05g8YBMEEFCCygY8msauay9DPVGr/BcLs0nc2krwTe1kUmb21VrgICw?=
 =?us-ascii?Q?LwpzKslCuGN/e0EcibRmSq6BJq69+NXZ6LSA1z8FaBkE9mnQoqDbXO9H9gNN?=
 =?us-ascii?Q?64l4gFlPv8StCbrhw6TxMY1EiaKefACZdOdpnRsJ3BA14DlEW4soAP3z/1yz?=
 =?us-ascii?Q?WOQ8ezTfTzcRGi9TIJdMnykRQWumetoCHQcP34ZIjozy2+ehEuf3ZovY3AJf?=
 =?us-ascii?Q?SNTRQxSLxuYoQa62P1lbuJKvjMJz9Lc5SPwgIV5M+XeEo/J0EXASe7KRrN8Z?=
 =?us-ascii?Q?HFmr1FaAncvf1LpAjGDh8uY5oqwer4SJxlf1gIja3fYv3g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TqRY5hyr64NRY57KecSXsVG/4r/GUFf5m85m0FWJ1c1cfKhzAF9xJuOqU+KG?=
 =?us-ascii?Q?YPDs5Jxj3v7DqWYrTSLat7fp96N/S8LMUTgE7kNiRDhFAMUpslHtMTLYIk1m?=
 =?us-ascii?Q?dj0iK6R4P2c7RaK9UE8fXP54UaRzCKrWBhLYpYqSt7esWddt9Hd0CaBPby29?=
 =?us-ascii?Q?8nTOIhVYOasE1H8+zRshUz37aITqfpyM6AILYcERPdtQAVBUl9CruBx1Gvvs?=
 =?us-ascii?Q?rhHXqsFNfj/J0DlOILrSAdTCnrP3KscBOnGMEskU4xqrw/t0fggBCnXp6Emf?=
 =?us-ascii?Q?Yr+orIdh5wtq5HkqpFRfJAxnCfsLv43bI8B0txTm9VE+KyOYmr8koB72uw1A?=
 =?us-ascii?Q?fJQGWPP2akfgQyYXGgfXCC4SRlfoJurMU7zFtZ7DsCFnd3gD4n04JTFI2TIS?=
 =?us-ascii?Q?QwXW5EV1Tx+c9KNYieExVaDWVlAP0BanoQdrZ/6KFBrIjc+YfLBVMx+jCUGm?=
 =?us-ascii?Q?ICYZY/RKtIG1Mk1wdxi71asCFId7/nV3KgohMSxDhsW0OsRlFy+JxR5Y7MDF?=
 =?us-ascii?Q?NFZ2ZAJYqjFn2k9apOaXftt6H2zqx/7neH5CHM1b4+ywD6qB2TB/a/x+qDYC?=
 =?us-ascii?Q?P9etombps2yxn1COLYBxX50RqqzMmljhp9CAqYjQiFS4iuK40ZVZ+O1OHwa2?=
 =?us-ascii?Q?FppS0S32Vhra7Pc3y2a99Je87UjWYpds3mTOsIAL4eypS0kDPky7IXV+fO+P?=
 =?us-ascii?Q?849fS9R5Gg759d6l7px/TinzKRkx80C1kUkLcI1WRI7scr6rBPQTbY8e0W+W?=
 =?us-ascii?Q?ty9CtyvhYAnXJU2RwCxWAIUlbUzf9xVO1aNFO0iV9vhhrySoHBFvD2sH78T2?=
 =?us-ascii?Q?X/UDxz6a9QQOCaN5RND5gH6cw8LYLm69j5ANRXUnpHzTw7ceWiMVYiajHBX7?=
 =?us-ascii?Q?R5eZOpMvJEx90sh5C4uhKUVJDHv81IvVTscJX/yRNt5/X/+Qs8UitMiOcxlU?=
 =?us-ascii?Q?/GI4fdPgrYhZuod7ZrgRX9gXxX07vk0eosRVAfYgM8d9D1OTJfRdaQzg6vCV?=
 =?us-ascii?Q?6cCDJDv6fuj9McxlV/+Ul0QdIHekzCbq+h351amBfpD52e2PmZQ+H0WElcsV?=
 =?us-ascii?Q?1XSUMgSu1GMY25kB4Jr0BuNaChTfWSlMZYaRoSoGU05dOk8omY9+Azs7LhUP?=
 =?us-ascii?Q?2Zovc/gWIpK+xhSET9WNQO5K3RBUAk+QfijGxNy9fdEmCoEP2xG6orJFByqz?=
 =?us-ascii?Q?lBF9w1flfU8QC+WznlUxjpCPDaSG8xDwEPdW34ex98Ny2MNF65QWzp3KcBre?=
 =?us-ascii?Q?Ki87u10ONKMIltfH7EvbEHoNSE3GVngQ1+wPpSDHXmiw+Pa0IIesqCTqij/v?=
 =?us-ascii?Q?WHbKva18zy7pfgY0j2e1NLHFdRcCcWdEoEKkqNAsAzT+t5SmiubRG+YlkRF3?=
 =?us-ascii?Q?QboR8oYoWwsTCuqaYvz0Vv4gnLrgCq7sFpVKxwmrP1C172SWRRpjDhnVdVNb?=
 =?us-ascii?Q?lydWbkELA5xnovwcB4z2qfGWt1DKQCemkz04NQUYn54DRrMCeXV7MTNNjwdF?=
 =?us-ascii?Q?GQHxZLSS3xoKtYDZSWv0y89SMIffKWSK8Wy59pRVWv8l4SMXm5VnQ1ZSHYIi?=
 =?us-ascii?Q?kkfGawSpo5+CIEburz4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0920176c-005d-4003-d08d-08dd193579d2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 16:12:42.6839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0rVTbbJKWcTaNu0x9n6vBJfdNY3Q8RFX//BwDQgfWPEXuXdszj9CE7fRu36yZn/3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6295

On Tue, Dec 03, 2024 at 03:52:21PM +0200, Leon Romanovsky wrote:

> Thus, replace with a state machine as the following:
>  * IB_MAD_STATE_SEND_START - MAD was sent to the QP and is waiting
>    for completion notification
>  * IB_MAD_STATE_WAIT_RESP - MAD send completed successfully, waiting
>    for a response
>  * IB_MAD_STATE_EARLY_RESP - Response came early, before send
>    completion notification
>  * IB_MAD_STATE_DONE - MAD processing completed

This is a good idea, that refcounting stuff is totally inscrutable.

> @@ -1773,9 +1772,13 @@ ib_find_send_mad(const struct ib_mad_agent_private *mad_agent_priv,
>  void ib_mark_mad_done(struct ib_mad_send_wr_private *mad_send_wr)
>  {
>  	mad_send_wr->timeout = 0;
> -	if (mad_send_wr->refcount == 1)
> +	if (mad_send_wr->state == IB_MAD_STATE_WAIT_RESP) {
> +		mad_send_wr->state = IB_MAD_STATE_DONE;
>  		list_move_tail(&mad_send_wr->agent_list,
>  			      &mad_send_wr->mad_agent_priv->done_list);
> +	} else {
> +		mad_send_wr->state = IB_MAD_STATE_EARLY_RESP;

Let's be even more explicit on all these transitions:

      	      WARN_ON(mad_send_wr->state != IB_MAD_STATE_SEND_START);

Maybe with some macro compiled out unless lockdep is on or
something. But there are clear rules here how the FSM should work,
lets document and check them.

Let me try to guess what they should be at each point..

>  static void ib_mad_complete_recv(struct ib_mad_agent_private *mad_agent_priv,
> @@ -2195,6 +2198,7 @@ static void wait_for_response(struct ib_mad_send_wr_private *mad_send_wr)
>  		list_item = &mad_agent_priv->wait_list;
>  	}
>  
> +	mad_send_wr->state = IB_MAD_STATE_WAIT_RESP;
>  	list_add(&mad_send_wr->agent_list, list_item);

      	WARN_ON(mad_send_wr->state != IB_MAD_STATE_SEND_START);

> @@ -2222,6 +2226,11 @@ void ib_mad_complete_send_wr(struct ib_mad_send_wr_private *mad_send_wr,
>  
>  	mad_agent_priv = mad_send_wr->mad_agent_priv;
>  	spin_lock_irqsave(&mad_agent_priv->lock, flags);
> +	if (mad_send_wr->state == IB_MAD_STATE_EARLY_RESP) {
> +		mad_send_wr->state = IB_MAD_STATE_DONE;
> +		goto done;
> +	}

     else
      	      WARN_ON(mad_send_wr->state != IB_MAD_STATE_SEND_START);


This flow doesn't seem to touch the agent_list? If we got to
EARLY_RESP then mad_done didn't remove it from the agent list and we
goto done which skips it? Seems like a bug?

> @@ -2232,14 +2241,10 @@ void ib_mad_complete_send_wr(struct ib_mad_send_wr_private *mad_send_wr,
>  	if (mad_send_wc->status != IB_WC_SUCCESS &&
>  	    mad_send_wr->status == IB_WC_SUCCESS) {
>  		mad_send_wr->status = mad_send_wc->status;

mad_send_wr->state = IB_MAD_STATE_DONE 

??

> -		mad_send_wr->refcount -= (mad_send_wr->timeout > 0);
> -	}
> -
> -	if (--mad_send_wr->refcount > 0) {
> -		if (mad_send_wr->refcount == 1 && mad_send_wr->timeout &&
> -		    mad_send_wr->status == IB_WC_SUCCESS) {
> -			wait_for_response(mad_send_wr);
> -		}
> +	} else if (mad_send_wr->status == IB_WC_SUCCESS &&
> +		   mad_send_wr->timeout &&
> +		   mad_send_wr->state == IB_MAD_STATE_SEND_START) {
> +		wait_for_response(mad_send_wr);
>  		goto done;
>  	}

This sequence looks a little off, if we got a EARLY_RESP then we skip
everything else. It is possible for the send WC to indicate fail even
if we got a matching response and all that checking got skipped.

Maybe like this:

	if (mad_send_wc->status != IB_WC_SUCCESS &&
	    mad_send_wr->status == IB_WC_SUCCESS) {
		mad_send_wr->status = mad_send_wc->status;
		WARN_ON(mad_send_wr->state != IB_MAD_STATE_EARLY_RESP &&
			mad_send_wr->state != IB_MAD_STATE_SEND_START);
	} else if (mad_send_wr->status == IB_WC_SUCCESS &&
		   mad_send_wr->timeout) {
		if (mad_send_wr->state == IB_MAD_STATE_SEND_START) {
			wait_for_response(mad_send_wr);
			goto done;
		}
		WARN_ON(mad_send_wr->state == IB_MAD_STATE_EARLY_RESP);
	}

	/* Remove send from MAD agent and notify client of completion */
	mad_send_wr->state = IB_MAD_STATE_DONE;
	list_del(&mad_send_wr->agent_list);

 
> @@ -2407,12 +2412,9 @@ static void cancel_mads(struct ib_mad_agent_private *mad_agent_priv)
>  
>  	spin_lock_irqsave(&mad_agent_priv->lock, flags);
>  	list_for_each_entry_safe(mad_send_wr, temp_mad_send_wr,
> -				 &mad_agent_priv->send_list, agent_list) {
> -		if (mad_send_wr->status == IB_WC_SUCCESS) {
> +				 &mad_agent_priv->send_list, agent_list)
> +		if (mad_send_wr->status == IB_WC_SUCCESS)
>  			mad_send_wr->status = IB_WC_WR_FLUSH_ERR;
> -			mad_send_wr->refcount -= (mad_send_wr->timeout > 0);
> -		}

That status check feels like it should be a state check? Should it be
a new state instead of storing status?

What states are valid here anyhow? IB_MAD_STATE_SEND_START and
IB_MAD_STATE_EARLY_RESP I guess?

> @@ -2459,7 +2461,6 @@ int ib_modify_mad(struct ib_mad_send_buf *send_buf, u32 timeout_ms)
>  	struct ib_mad_agent_private *mad_agent_priv;
>  	struct ib_mad_send_wr_private *mad_send_wr;
>  	unsigned long flags;
> -	int active;
>  
>  	if (!send_buf)
>  		return -EINVAL;
> @@ -2473,14 +2474,11 @@ int ib_modify_mad(struct ib_mad_send_buf *send_buf, u32 timeout_ms)
>  		return -EINVAL;
>  	}
>  
> -	active = (!mad_send_wr->timeout || mad_send_wr->refcount > 1);
> -	if (!timeout_ms) {
> +	if (!timeout_ms)
>  		mad_send_wr->status = IB_WC_WR_FLUSH_ERR;
> -		mad_send_wr->refcount -= (mad_send_wr->timeout > 0);
> -	}

Here again, should FLUSH_ERR be its own state? This is basically
canceling the mad right? Then why do we reset the timeout?

>  	mad_send_wr->send_buf.timeout_ms = timeout_ms;
> -	if (active)
> +	if (mad_send_wr->state == IB_MAD_STATE_SEND_START)
>  		mad_send_wr->timeout = msecs_to_jiffies(timeout_ms);
>  	else
>  		ib_reset_mad_timeout(mad_send_wr, timeout_ms);

So this else is IB_MAD_STATE_WAIT_RESP ?

> @@ -2607,7 +2605,7 @@ static int retry_send(struct ib_mad_send_wr_private *mad_send_wr)
>  		ret = ib_send_mad(mad_send_wr);
>  
>  	if (!ret) {
> -		mad_send_wr->refcount++;
> +		mad_send_wr->state = IB_MAD_STATE_SEND_START;

      	      WARN_ON(mad_send_wr->state != IB_MAD_STATE_WAIT_RESP);

?

Does the caller reliably ensure this?

> diff --git a/drivers/infiniband/core/mad_rmpp.c b/drivers/infiniband/core/mad_rmpp.c
> index 8af0619a39cd..dff264e9bb68 100644
> --- a/drivers/infiniband/core/mad_rmpp.c
> +++ b/drivers/infiniband/core/mad_rmpp.c
> @@ -717,13 +717,13 @@ static void process_rmpp_ack(struct ib_mad_agent_private *agent,
>  			ib_mad_complete_send_wr(mad_send_wr, &wc);
>  			return;
>  		}
> -		if (mad_send_wr->refcount == 1)
> +		if (mad_send_wr->state == IB_MAD_STATE_WAIT_RESP)
>  			ib_reset_mad_timeout(mad_send_wr,
>  					     mad_send_wr->send_buf.timeout_ms);

else
      	      WARN_ON(mad_send_wr->state != IB_MAD_STATE_SEND_START);

>  		spin_unlock_irqrestore(&agent->lock, flags);
>  		ack_ds_ack(agent, mad_recv_wc);
>  		return;
> -	} else if (mad_send_wr->refcount == 1 &&
> +	} else if (mad_send_wr->state == IB_MAD_STATE_WAIT_RESP &&
>  		   mad_send_wr->seg_num < mad_send_wr->newwin &&
>  		   mad_send_wr->seg_num < mad_send_wr->send_buf.seg_count) {
>  		/* Send failure will just result in a timeout/retry */
> @@ -731,7 +731,7 @@ static void process_rmpp_ack(struct ib_mad_agent_private *agent,
>  		if (ret)
>  			goto out;
>  
> -		mad_send_wr->refcount++;
> +		mad_send_wr->state = IB_MAD_STATE_SEND_START;

      	      WARN_ON(mad_send_wr->state != IB_MAD_STATE_WAIT_RESP);

?

>  		list_move_tail(&mad_send_wr->agent_list,
>  			      &mad_send_wr->mad_agent_priv->send_list);
>  	}
> @@ -890,7 +890,6 @@ int ib_send_rmpp_mad(struct ib_mad_send_wr_private *mad_send_wr)
>  	mad_send_wr->newwin = init_newwin(mad_send_wr);
>  
>  	/* We need to wait for the final ACK even if there isn't a response */
> -	mad_send_wr->refcount += (mad_send_wr->timeout == 0);

      WARN_ON(mad_send_wr->state != IB_MAD_STATE_WAIT_RESP); 
??

Jason

