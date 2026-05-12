Return-Path: <linux-rdma+bounces-20502-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCVpGOBSA2pq4gEAu9opvQ
	(envelope-from <linux-rdma+bounces-20502-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 18:18:40 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8B452486B
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 18:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C7B71311D147
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 16:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A173CE0BB;
	Tue, 12 May 2026 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sdKYW8lQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011026.outbound.protection.outlook.com [52.101.62.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2193CDBD3;
	Tue, 12 May 2026 16:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778602390; cv=fail; b=KgvgXsPBvKt8QWYFCYNqNkKipP3tXKeIRuBTrb5zXljCuU/arQN/W+5VkcWOQnuAPeXZb/K8jNJ4j33BnrFEGxvYKqx04zp8vyZn0CONzX1OsN/5kxAwE3GJ7ckm4Y5XZgsnAWj78dYPnPo4H7pqeatqa6/ebmx8dWvlaXG7VzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778602390; c=relaxed/simple;
	bh=iWwSOmTvV9xbfkmLjsohgRMzTHf9AgvKdp7n39giBUk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0S6UolnGIeRiIrhbVnUxWpkIiQPOAP41XB36iOsQ/N4HPJu7jLixDcuOVIlVFiqR5ChdimKExa4lEvH6ORXG7mdMpQDC2RBI02lIKMd4E8yEwfWrkcZrmumKFSfqcLDeuwcTFoK16vO+G1NAOGtJ8zR42J11DeN0LqBe/2qvzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sdKYW8lQ; arc=fail smtp.client-ip=52.101.62.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VnmLpRisg+YOZEr/Se5a3BgpLp4gRNKoNKCtHFPpi5HlY4wL6NpN+lvnU9GTUkoUH5Sv2FE5bUqRWBVYaMHsNCXiq/WERNj6FJNm+LSQUToHQn3pHMpmuhzJLumIpj2uOn6yIW2oZOjAZvvPV1qiJAECHZ7sgz3fIPLpSYZsp/0bkY2g2sHRVKVXFVAeboTMQEL9Rv0zL21Tq6uzgcMOWukdj8JiLNzdjbb2aHrnELDKmnblllOVJ1ayjIHR+CVoDTwDC7Z+xItZBETuXgLlCkN9m4NJO+rYmiZELuEnzo0roClTnlywBXP015jo0u+rwxlJFSgkkISUGsOMA8P/yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szN0ooGA6bhEmh3lUHMngWyDmHbRqd9/gnaIrXRjavA=;
 b=lDFnhJvXbuSVzSVdLOwwDTeu+EYcUOJVbt/4ovCFT5mqztdqAZWgOwZoONlIn+3u/hd+IhRj587WC854hZlUE/jSLib03SSyGCfRu5dWqSUZrZp90ARbSFM7YN3b2uIYjuLeaZ4oqkHlVSMeIPKc5ZZJJEbuzcjssbdZJ/CWyKBLpZSSeIDuBap6ZOvJDfhln32AkFEURjCpaTfcg3Ah93Z0Wo5PlJ+QDmKT5pSYcR4nJZQsIyPxecYLwrizjvnLRqpTkMaPPfwat9zyRwMlrbFwfScAE3xOu7uY2j2nilor52JTcNgsDfowuldHWcp9EpxBt9O+2y2dDt2iNDnBCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szN0ooGA6bhEmh3lUHMngWyDmHbRqd9/gnaIrXRjavA=;
 b=sdKYW8lQkuWWlsGUK5QTrYswnjV7verxSPVRnUh5/DP9kMDZrImSYGnv+Jj0CP7AoLUueC89Gb50A5ArwwiQCmxPKPvykUcRxbh/YO3dLaUBADG60fVlr6U1K16HH0kyQikUdePCexJisyi4jReaGVbxXwyFV3K8IpwmM2qo0cvuX141vG6Tuex70YI4z2IADZhatEM1y/YlpjC64F4Wsd0BA0TN0v9OWohYJPB5xyffY1+U/qjX4Y7CTGsdfzoyC0BCfaHfCzn3YepExr4T5SkGBDtUQKVTuALhLh0J/3h3IV6IYMH4pzeB2fkJhdCYX2Hw7F3VNX44AGOBC7mPrA==
Received: from BN0PR02CA0002.namprd02.prod.outlook.com (2603:10b6:408:e4::7)
 by DM4PR12MB6472.namprd12.prod.outlook.com (2603:10b6:8:bc::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9913.11; Tue, 12 May 2026 16:13:00 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:408:e4:cafe::fb) by BN0PR02CA0002.outlook.office365.com
 (2603:10b6:408:e4::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.11 via Frontend Transport; Tue,
 12 May 2026 16:13:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 16:13:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 12 May
 2026 09:12:33 -0700
Received: from localhost (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 12 May
 2026 09:12:31 -0700
Date: Tue, 12 May 2026 19:12:24 +0300
From: Leon Romanovsky <leonro@nvidia.com>
To: David Ahern <dsahern@kernel.org>
CC: <stephen@networkplumber.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, David Ahern <dahern@nvidia.com>
Subject: Re: [PATCH iproute2-next 2/4] iplink: Update iplink_parse to use
 netns_get_fd_pid
Message-ID: <20260512161224.GW15586@unreal>
References: <20260507150836.28105-1-dsahern@kernel.org>
 <20260507150836.28105-3-dsahern@kernel.org>
 <20260510100148.GC15586@unreal>
 <14574ff8-128b-485e-af7e-34ebf00d2c8b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14574ff8-128b-485e-af7e-34ebf00d2c8b@kernel.org>
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|DM4PR12MB6472:EE_
X-MS-Office365-Filtering-Correlation-Id: c6d03d30-93fd-42fd-3328-08deb04156b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	AGPmOgn/9xShOe34CAfM9IwJj/Q6rbOWgQb8sT4NC4bfUiiclmdUf30IiM2rhnCjbatLjp5894V5g/m27wiQ3KIpazQaza1kSm+/Fpt2Bu7FiPKcaQCiW1e3JbWgtl8V/nsbCO+Hi8tf9Tly+iH45sWJBEAKVDGx9Fb3McdOzBpqNN9JZhaglODlQQxmMdwZIL/2+LfqsT6zs7aRpLmXnqDogALJMBkhX8BujL9krS11XXvYSic1OZ5UlPBWFnWVbWMAw6gY2VCaIkPLrF//Uix1yCTe+Pfpz7Ti0VNr+Wu7E2UV/Z3pNtPj5AXTxcjQpPwceRiu5JQIUl8EewF8Vp+35nB7DV5JQhGkdzCmsvg6iWOtctbkJA7tALN9znyFTLPz9wXwMGHF6veL3H6ZO9DDsshJiWzN3vvnPk7p6TbNg2ftAce9tYmt8Wvu/wBU21gFfxlYsdoF5cz3csYINuPSugPLjp8TRjdnlyLG1Los2DUDuN/e8GvsXPe9lBtvb/L2sYqWZlxKh+MnljmKYZVvKnnpPThbRAkWgB4vtystLWOrqu7KZWTlXTuDUkMcQDQ7DuUxMqbePXISKfuQRAaL5NHvb8ablAwez8BfqLhX33FFt0yindqT4oYpreeWeLO87HUgRSl66NFRigfw1Wx3+3WbNZMnGcvGrXHA/L8K/Qy3owbWVzd/kTFD9OaOFIfygB9cPWLW4KAEv1m4A/0uEaV9/gzYwcAOc9xWi2Q=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(22082099003)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	61LAF6t6RsZKSv314cEQr9Gov21ICHLN4t29PEf6hdSCLb9ffKLxE+fzOOVyNqQKUiIBhzjSjfdVse54ogD86mDVbvu3GGbTjK52xDk1QgbjAsnwmGL7f1Me9xhELI7gFJGOXGXzTWhvq/NRTGAIrt7cDmc9ksIA3UMyMsBVScJnfPwYb3MUo6+Y8hEE0HNlhttR3MW+6PI3nJDPkHTxHErD9JKJA9N/Q0LcoGBuJpOMxWsC6je1/S8MNQQgri1R6nW93et48BHWHD2slMxoD2IjLw7KNz5pdXNesjzAFyn07PCVprWaa6HH2JWGeRs64K9BOVP5j3HpEOT5UiD467PGSTMVNeYQ9cOM/ZxDaC7m8eEZs7fps1qVMTYT/h799+pe2CiC6ZMLXIW5MssffAsSf6HjLhTSqi3u3CZRaiYIIHkONyuN33XIrKC2bWdD
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 16:13:00.5082
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d03d30-93fd-42fd-3328-08deb04156b1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6472
X-Rspamd-Queue-Id: 1B8B452486B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20502-lists,linux-rdma=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonro@nvidia.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 09:23:52AM -0600, David Ahern wrote:
> On 5/10/26 4:01 AM, Leon Romanovsky wrote:
> >> diff --git a/ip/iplink.c b/ip/iplink.c
> >> index eae51438..6c4586ee 100644
> >> --- a/ip/iplink.c
> >> +++ b/ip/iplink.c
> >> @@ -650,19 +650,13 @@ int iplink_parse(int argc, char **argv, struct iplink_req *req, char **type)
> >>  			if (offload && name == dev)
> >>  				dev = NULL;
> >>  		} else if (strcmp(*argv, "netns") == 0) {
> >> -			int pid;
> >> -
> >>  			NEXT_ARG();
> >>  			if (netns != -1)
> >>  				duparg("netns", *argv);
> >> +			/* try by name then by pid */
> >>  			netns = netns_get_fd(*argv);
> >> -			if (netns < 0 && get_integer(&pid, *argv, 0) == 0) {
> >> -				char path[PATH_MAX];
> >> -
> >> -				snprintf(path, sizeof(path), "/proc/%d/ns/net",
> >> -					 pid);
> >> -				netns = open(path, O_RDONLY);
> >> -			}
> >> +			if (netns < 0)
> >> +				netns = netns_get_fd_pid(*argv);
> > 
> > It would be good to have a single function that handles the entire
> > netns_get_fd() → netns < 0 → netns_get_fd_pid() sequence internally. This
> > logic is used by at least iplink and rdmatool.
> > 
> 
> I considered that. devlink usage of netns_get_fd and its handling of pid
> vs name makes it a more complicated change.

You are not modifying devlink in this series, so rather than introducing
netns_get_fd_pid(), introduce netns_get_fd_fallback_pid() or another
appropriately named helper.

Thanks


