Return-Path: <linux-rdma+bounces-20668-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNQpDE6ABWrjXgIAu9opvQ
	(envelope-from <linux-rdma+bounces-20668-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 09:57:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F6553EFD0
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 09:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 589E130269FB
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 07:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E0F3D8138;
	Thu, 14 May 2026 07:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UtZmSZkW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012058.outbound.protection.outlook.com [52.101.48.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017B13D8123;
	Thu, 14 May 2026 07:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778745415; cv=fail; b=HSghBSOTQhrF+JH7bSU4XqxmVVJDzz42WXfdD6UGCvnUG7rSzW6pywe+UMqRg8e/N6Mi7Mq05MXPZKGVOzZDqd9MkY9oHg3z9GZDm4eO1Nczu+Qd2PoSF6iMDurulpkuqMV17OLsASJzP4HmM93gXLZyQhmwRZVcWn6Z/tQzdrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778745415; c=relaxed/simple;
	bh=3GgyPGsla8VEI+JvmEFlddK+z1Kg6WvrNE3p/TuwTjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=V08zE8/MAvi46417FKZ7XezYC9GX7XcfqZ7F3HpfTNfj7u8+c/LFaikUiIxBbbbopBWxedn1dzW91+eum79JEOQPBmSbTm8KeLwFyo4Xd9OcS5iMWXgZYspNEeWkzV/Sp+/9LW1tTH9+lrHpnGfbFwcHHjqLjGfsxboGXIJYna0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UtZmSZkW; arc=fail smtp.client-ip=52.101.48.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CcOjE88pP2JstL1dlKVXcRBQ9zPlEGWe9wK8Sfig4BpxP3maBagp5/GpEEWAN50e8YxBu12NutosOkQzKyPcZm3FkbLk0VFyMOWMV9ARfZIWzrlntwLDyI9EEloZ0qk4O40Sf/457ETVyXu4B5A5Ge67LpU0+gpVeTtvyvcTiQSi9fXGHZhd1neNVKcSahqH3Ed3Jka7FrM/1KbZTPLrnbwMOhBIhLGkrY5DNXF5jeDoTDDHDJRHt4XoaITrCu67Q8k1dSenz4XYZAoAsl9ZiCUbmzQal/zXIgj+6nsp0+fbAgh+NKvTubPo8Upwi3AF1FURAq5CLv7JPVkVmY2UYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ik1Q5tKj+ixI87zjzlnw0M0nnS8tlghYPXyqs0dBUv8=;
 b=kygKWFMoliMAjl0nEraLClhRxB545C2QdCogjt91Bx0+waeNCliu76nXVYmBp5inJkpd9IntIJwXKpW+MU4DMYgeiYXeFoG4/PSoBGPl2q8ezzF/fNzwuYWlP3qH1aMMEz92qOz9DWXW32y4kPvgJQMBtR4AelPBvUhz9dJnCcFx6zQjpAeE88DxTPPJcxnnuwpLvHvOC2D6KICuA5/y/aXRPcw1FBCv7ekTGKf95aq/QJDwaQugdIBMBGENYszCwZrWp2oT1/052+p8gC1FqGSl9bk8MYSrby0cRESDKpcOkRAxgt+tkIWLju++3cueJ8V8V6es5t+P/0YlTnMNgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ik1Q5tKj+ixI87zjzlnw0M0nnS8tlghYPXyqs0dBUv8=;
 b=UtZmSZkWvVbZkYvjx78KwUnEW5dqqXhwzeJL+Hj1vZeTHyvIWDq8ZHYbOZq4pDHhlnbGm7HcDNt2ftrHJxRWZF7DINHDCUI4GpMg/Jbd2RTiNeFPzl+88w4bU98bSiTfzFURhmf+dVM3TT20ngh1je0ylxOUf3ivGUFMBZ+//kjw67oozljCF+30lcHDyu3eGGwacCiyGpIvN/NPIpst4AiqBk/2EmRkm8IqievUSBWhsZrds0J7Qiba8ISdyf62+jt0/6L8D3yNHVwXpxFsBE0uVMAIDJG+Oh744p5bqmcEQiiPPyZnD/WAXwzT3rinqK8q4PE0HxjsmvULdmyYoQ==
Received: from BL1PR13CA0246.namprd13.prod.outlook.com (2603:10b6:208:2ba::11)
 by SJ5PPF4C62B9E70.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::991) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Thu, 14 May
 2026 07:56:47 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::a2) by BL1PR13CA0246.outlook.office365.com
 (2603:10b6:208:2ba::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.18 via Frontend Transport; Thu, 14
 May 2026 07:56:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Thu, 14 May 2026 07:56:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 14 May
 2026 00:56:32 -0700
Received: from [10.242.158.108] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 14 May
 2026 00:56:28 -0700
Message-ID: <639580c8-f93f-4945-acfa-ff116b841f6a@nvidia.com>
Date: Thu, 14 May 2026 10:56:26 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/8] net/mlx5: Prepare eswitch infrastructure for
 satellite PF support
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
CC: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Mark
 Bloch" <mbloch@nvidia.com>, Akiva Goldberger <agoldberger@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
References: <20260510053448.326823-1-tariqt@nvidia.com>
 <20260513192539.7fd96592@kernel.org>
Content-Language: en-US
From: Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <20260513192539.7fd96592@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|SJ5PPF4C62B9E70:EE_
X-MS-Office365-Filtering-Correlation-Id: 0060d307-623a-40ca-95a9-08deb18e5958
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|4143699003|11063799003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	SWoCFL1vmokKmnVS59h3SS+XfO3mMvCzhMPmEWYZJdF6mSvJxfOXRwE5gbte6+YmkrNaMFi+veiRTbIMlxcSep5L53AU7oOM87gxEsAf4Tdi4BWLZZR1WS4L+xBD+N0wt3JXG9hhHmHqJFPUn5ULoX76KdzJjyLIk3z1bI6rq+6zEu8w/93Dxp0dJVKpYpa88zKaHuBlXcOTjwHRCXZfiPJn4tIh/ztGD8oo4F9mqc88OrY5CV3SZhgJHwrFrLoFuUbLV2WOcEevnDnx9Hwh2Vk01PXohh9uQmAz8NjV/AbZ3myqpQsas8EeTCmeQHPozKl3C1GsAy/cH6JfPZlhc4jA7B1kQoVuw/G/k2jEslfdu+8YdEQ22haL9z8N8jmC+pfZAFJZ//on7oRQWuKZzKJTwi7XqKd6DwzANWLm+l1Rw/DjSsQX/pN1T/cCgTdFo5uXwSwC7JLJLE2j78MyjxG/RdW/47mnJ4SugElNt6fgxwkGeO27usx7iKDwXS7Q9Ph55BcCsbBttgIUyEAQ09swLdCY7Yan5v3Qzu9gYL5JJlPVkq19MyJ9NZrY6uLrKYKPvZDVwiMVzxH2pT/TMfZXA8BbpcYRcK1gFoyCZ5AbEenXBttUKSEwQYJuvYymmj1JqPtatW0EInG1vpooAt8eXiZWHac5CWoc8X/pguGdXAqBXAYqMubqJKZym7W1E6Juw36JdGuu55A9vp28l+TPrTyTkslg3VfiJmqj8DU=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(4143699003)(11063799003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KjP1QHoklH3gkocNjJxSYvOUzvHEsqkAmPTpMvCAFAeRbwjx0Xz+4n/vuXq4m7agr57D135AbmnVuBdDvX6uDkWMM7ObZ6hc/xDBm6wx7xbMErvZ9Ql14MfwvGp8OiD1cXnGF1xrWnLjT8yKT7mE38k8nzR9PtVTMioJ7O9dxOcoS1fDCwkms+L6MHmfZkbNTwZX9TxqfENoILE/0MY4qcUoTw57ffML1Mh8nLqsFFMt07o05P4+v26CYF6Pu9C00jbWTJA1FtIG77su+CeqEwi0NIClnKhb+U7Kq7fMPfK/W28HRStJKzavJY+MV54m52K+OuzUSdLPFBqMV62RFFycf0IzsKVAg4NB6S50PaSad/5txK4JU/VswHRXDMBcjI6fbo+8M0YmRCbmAMvrOvPHY/NT0xLKeRYFKjHjNWHPWi6GTI0A1uisYe5MvZrQ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 07:56:47.3802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0060d307-623a-40ca-95a9-08deb18e5958
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4C62B9E70
X-Rspamd-Queue-Id: E5F6553EFD0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-20668-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moshe@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action



On 5/14/2026 5:25 AM, Jakub Kicinski wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Sun, 10 May 2026 08:34:40 +0300 Tariq Toukan wrote:
>> This series prepares the mlx5 eswitch command interface and vport
>> infrastructure for satellite PF support.
> 
> Could you perhaps start by explaining what "satellite PF" is?
> And how it differs from "socket direct"

Satellite PF is another type of Physical Function, its role and 
privileges are similar to the host PF, but unlike host PF the Satellite 
PF is on the DPU and not on another host. So it's kind of "Satellite" 
for the ECPF which is also on the DPU.

The next patchset will introduce the Satellite PF, while this patchset 
only does some preparations. Small changes to prepare the eswitch to 
manage another PF.

While Socket Direct is a hardware PCIe topology, that adds another PCIe 
link to the NIC, the Satellite PF is just logical entity, by firmware 
configuration, no hardware change.

Thanks, Moshe.


