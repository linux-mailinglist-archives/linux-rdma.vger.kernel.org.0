Return-Path: <linux-rdma+bounces-20545-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4N+5OhwRBGoMDAIAu9opvQ
	(envelope-from <linux-rdma+bounces-20545-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 07:50:20 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1CC52DC46
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 07:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1466F302B2F7
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 05:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8890E3AEF2A;
	Wed, 13 May 2026 05:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pfLs/kaC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011032.outbound.protection.outlook.com [40.107.208.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26B93ACA65;
	Wed, 13 May 2026 05:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778651413; cv=fail; b=h/CAXjXkXZMVgMLAfNauCt/OKeoZqkPPX9REheZM0cUc/hiQiqGNcrD7YgLNE2sV9t0Mi3oGIws4MMpQFIw6Fl2yke2n/c2sOUhp+grwpvXagwhbXRSEKIMd18N3ifMnnr89BlHE3SXkiwF2P8K0cMGzgblEs6ddvcHFECJL9ZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778651413; c=relaxed/simple;
	bh=pg0P1RxKPSoh1UHG1zz6Q0o4uC0KCUVitmq6SHAiWBc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gEhsXnel6DAErhBGYVAKsOJ61iaQRmbyN18NxgBOHn1EtHUS1yHR8emgCnK5jLN8Rteo9E47u8jOpNbZaFM7DjUVsqTyWX66I/nFOK3OF9PBVzVvMIDh9W9pdW/KabOdzfwaUHxVMnXSwFb8Jtq2BCqFvP+Ja+4Kn8df0fxH4Co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pfLs/kaC; arc=fail smtp.client-ip=40.107.208.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JJDuO9JkUMBZ0P7sVuoEL4+NYf5Mr3C9qZaRzh8fupBf2qi8VLGGQ9cDc+YM1WlS4JAvY5CA+4Hlf7wFCFewwpjx+Svt1vIVgO9QytlIDZY0z8xt03+R70kDg2P5w7MPhtl3kzpV3j+LjZeY94cdBTj9HXbQO84Mko7On8aj/J3pmgirH15HtqUeXqiRnd3jkGHFAF0fbskrmC1KnAN/32pj+gsxx0H7tJ6OmKIw2AeLpkDy4sLh98mhRAOWUOYaMufwa90wMnytUzPkUiSe7rj7QjbN9gG0Z5S3uW0VTjoJX6S3MFq30zDzCJ2U1/3FEGQrwCa8KaKt87OwOg788g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlsGmAnlhpQ1Gx7PrF/Dll1GWKAdwRz0B/07nneKeN8=;
 b=cm6X3+pXzocjV2OpHIuxPfh+jgYXCADXv1P6ZGfg09r2752a48JJ6k8DAywxPwLv0fHYImyfpNmKu4W60kjVq7MUW0A6Nr4e8q3+ecXYuuQaXIbX+AS0EFBd/Uq/5tReAD+8xfYbIX5fbj1WfDrLR6zva4+ux3oGAXMQEMr/epr7yOCsrKak4+u5KMLl3yhuj22GmJknChd7T8sovmrRdQLjXKKLihrStd3d97zrq0AgsFvR90AWR3x9P/HbiP4D28AxQph0JhKTrJSWYJWwOxbl3MzHmPXjU8HF+oWy1nZGGkNIP9e1faxDMw6fpKyc6o+fy4U1apf+8sz28+NilQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlsGmAnlhpQ1Gx7PrF/Dll1GWKAdwRz0B/07nneKeN8=;
 b=pfLs/kaCXmVfLjYA23yeiaVHY32jCFxu5gJhe4znHUSF+8kEiSl6nXTjhnw134SZ/UDsXfr7CbO1QA5fpscKaWs3L+s1yKjOuu4ImDBcCnAk7DGBawgwmqx/HXiBc2NYpIOKQK54rlCCqQZ3o8w+PrWwxB8ZJSSYVwn1ERPUaO/t1TuYUpP4WSInxZnKxvqC8OsEyF5bFdNGQnEv+NQTVr5ub96ahJfTuWVHVcWdA87xjE3HX5lTnkfO8BmK2xMbc4pIisuWYIQi2/AZ9/uniCIDi9KlODuef9d8FJECZUd8F6mECSddtob1WF6BfWgi/cmq1BVTMhqR6uuitLphrg==
Received: from DS7P222CA0030.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::10) by
 MW4PR12MB7165.namprd12.prod.outlook.com (2603:10b6:303:21b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 05:50:02 +0000
Received: from DS3PEPF0000C380.namprd04.prod.outlook.com
 (2603:10b6:8:2e:cafe::61) by DS7P222CA0030.outlook.office365.com
 (2603:10b6:8:2e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Wed,
 13 May 2026 05:50:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF0000C380.mail.protection.outlook.com (10.167.23.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 05:50:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 12 May
 2026 22:49:47 -0700
Received: from localhost (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 12 May
 2026 22:49:44 -0700
Date: Wed, 13 May 2026 08:49:38 +0300
From: Leon Romanovsky <leonro@nvidia.com>
To: David Ahern <dsahern@kernel.org>
CC: <stephen@networkplumber.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, David Ahern <dahern@nvidia.com>
Subject: Re: [PATCH iproute2-next v2 2/4] iplink: Drop pid fallback code for
 netns
Message-ID: <20260513054938.GA15586@unreal>
References: <20260512193412.32019-1-dsahern@kernel.org>
 <20260512193412.32019-3-dsahern@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260512193412.32019-3-dsahern@kernel.org>
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C380:EE_|MW4PR12MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: d06cc7ff-9b04-46a7-b7f4-08deb0b37999
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|11063799003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	IbILghGMVQg2+oQI5E26TBUHZpWlmlptNkZr5CsmDTzZVl8QecVEJ+ur89NR8QEZYTC+7tpciUwWBKfgmKN8pz7yy1GMQRw1DuVDQU8KR0wT83BtBUV4h22LXIV7COq9JhphnHdrIdVEnvA02PY4N/MIZhyp6JWpVPv//vc+awvgHi4teyUaDfBYDo22JdXCMV145r3gFa3Ot4xxzbzhkAOlYVCTina5PoaOh7l8xlGYpZ6emsoxXygscczq1SatTPtjJQ3cyzJ0sNfeJIfUWD/q7v2fDha87vM/2hV9CiOaFQMFx3EO01+IFu0hiyugQotNQZ804isC8qGxO7WLL2T6KEh/cJgo69VAIdG5sAWGkvHS6UjqjnMXTOvENCb12q4axs5nURDeQddrJ2tQ5bVQSIjODj9iLLvfjjNeN+gvoutnFntxjwf8d+PLBEqa9nxCq+HJSDW9F1xQxLHWNN81wVLXxC3RrhJKC0KnOVA4+bPWb01xVpfbfEkxqKMVJBv81KnRshAMBBm+YTLbLAsyYZ6q8T0AxRLyh31pdodbKAHFd+NovVocUSFbElg9tqnZO55EEAgWLGffbrxuRPUFokJSgePaoyi3mGNEFjWArBLzfnPAHDRPnzVtWfpoM15Ax1FQD6xsfx03tGp4ycTiFxoHb3zOHZsy0nPIjDZtxZi3bNyADHI0KWBZKC2iRihCiUB7Ho9V/TcDXmNNIifN9gD3JN9DXwzP0WudcXE=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(11063799003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Tq012aH7mttGj+OMe6bNtcxoNaeRsUVONaDBEh2tN08QUfzsqbLylbu5dNFYudU/oEpWLrXq5ryPHFtxyUSEZh8cmIal8bgJK8phxkH2lOpRX2YnBOSvTNez0FntVA1UGzhGNTX7My5IViqPq6qfVSHWEH3AgpZY+eGrLkmyQIlCUPqJTp9lsthivoE2fhcXv0wAc0P+X/hwM9v7dybYUw0Vi2Y+zBp5ULaeI4AU9xFnpQ54UV/CmP3d19mvm9hbnXtfRgnbIrzsw0+TlzRIKM2s+8qLWe902cFHDKJiPGKRDoM0yGXHuHOOXFubQke1yaffX7DIqrOIctsWc2D96BIPOTYwC7KwXMVNH9PeQg1NIaHaqTSGUgArRvlvzz+5uhmHRVO161Ud42swN1u43sE4GR4DjkRAHOma0UpksIAMpi2OFWMJhikICfvjiNfz
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 05:50:01.7445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d06cc7ff-9b04-46a7-b7f4-08deb0b37999
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C380.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7165
X-Rspamd-Queue-Id: EC1CC52DC46
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20545-lists,linux-rdma=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonro@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 01:34:05PM -0600, David Ahern wrote:
> From: David Ahern <dahern@nvidia.com>
> 
> Prior commit handles the fallback to pid, so remove
> the now duplicate code from iplink_parse.
> 
> Signed-off-by: David Ahern <dahern@nvidia.com>
> ---
>  ip/iplink.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

