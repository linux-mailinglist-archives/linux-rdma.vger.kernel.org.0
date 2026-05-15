Return-Path: <linux-rdma+bounces-20766-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCurGE3vBmrOowIAu9opvQ
	(envelope-from <linux-rdma+bounces-20766-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 12:02:53 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD00854CF2F
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 12:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7AEC30EC777
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 09:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5138343C07C;
	Fri, 15 May 2026 09:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lxMdVq3+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011007.outbound.protection.outlook.com [40.107.208.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD86341C2E9;
	Fri, 15 May 2026 09:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778837852; cv=fail; b=KrQKPlEdGjjsEhpqH0R+aA5dPMxQeBRi7xpX4Rwmd36exHmPC0bYzcicmYHnLqQSbyKfTulNDgIGnhbtdQNacY8u7dpqqaJCONvMQnZGDXH4fbfkQWfjDhsrHG9GKNfn4XMRkv+xjn9i86Z7VD9zhrwi2abWj3NsG9DZ8zJ7GMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778837852; c=relaxed/simple;
	bh=iolVlogE8OVUncd0zDjescS+Qsn9oreUVPPuxmEr+qs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DTqABJ3ia5zqeT74We2UHyBbyMAPtTRG0cluQcjqu8Y4h1x81cmlTV62yS1kpJhB80GaKccsg0FrKYRgiMCDwRAAD4owuuCrsDx5MIfRtZpdDTYumYT+M6ihHAz/Q7W+MKT6nn7OeuUaTnWJjUrE6EiTlITil0pHMnUbKOZAAW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lxMdVq3+; arc=fail smtp.client-ip=40.107.208.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GcbJ6YJIxktvcp5idwBpTi7t4IIMNHjSv7n2FfTzNpO5G64Tb2VeA9i/FIWtxwDSP0+xM31Ctr8n1lA/ZYxamwvesae2+wJh+KjpJBla6Ht9Fs++mNs0vhIxI7PsdrptcZa523J08riq57iqCu3QII8A/LwpNumVgCXv9YwDpmTnh3ZFe9kVfpQcLVboopJff9PIt3Iyh2nJ3SElwmYEyZaX0VICDx+spPnlRiOVJCLy0kUbTH75ztoZE+PRJs4YQ6k32cYoyVwAiNCnaz/cZc3OOQM4OKkOl2QPq0DF7wafk0KgjR6SLulngKzeuhmCI1/OWJpBK33Xo7eYf2l9hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5pUjtAEwWo7Clp2LrlCNgJnhV9jLsomaNaTo15P3lhg=;
 b=Rs3NPRpKBMRbgT3ttwH1C0ti/ukikBpmaCXE39jtFBRyDHziNCY2LdFyRjk8e0j4qObFur6nAOm8IrC1zUd69xbyzl7a7MI0FKtd3kvm1t5RETBAViPN8dLYATzLtFrtT2sbz5VPmbzoTlK0WWQgEANwMCkSJ0Jp44NAk/ZnvAg20cYA7WcmO3pzmKS/HaJcQ3bMHp5RWnW/Br6OVTsW2S79bY77d0AMpTxqzZFbCkYyWqKVk2zk+eDHgEGM4ELeExd64i4ZtyejKxWAGLrFq3/b+ghSVvDKMUHQOPNu5QxeVgn5bl57L5CpTRxEB5Tb2WfAHC1Id3sdo79dj0FRAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pUjtAEwWo7Clp2LrlCNgJnhV9jLsomaNaTo15P3lhg=;
 b=lxMdVq3+DRx3jJp36yBpJ0oE5Izpi/+Uy9CTt1wVZDzMtBx37jPmxjo8aNpA+e1avWvaTZue4nQzi2fUQpfyurzx1hqz99lMGk63+9Db3Q0GVmXXONp+7Jh56myPHtTNxfPrSFpBxgxKjOSO8+NPxS8dmPOETCk5RwrijFelZt2AKXSdf7yltWqwqaNmq6P6u2Mwucfhh74/LobPdQSLQN6s1BoagQeQ7DxokHdh3ixXU+nXldsnrGvHtTu0iRagBc92gylRK+L+ZcACd9C1gEiK8jEF0jignxluZRYtyvG0l6GMiVHrfnXnUFdx0BGjjVD34eEki96EpnGMvy9H4A==
Received: from BL1PR13CA0266.namprd13.prod.outlook.com (2603:10b6:208:2ba::31)
 by CH3PR12MB7570.namprd12.prod.outlook.com (2603:10b6:610:149::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Fri, 15 May
 2026 09:37:25 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::50) by BL1PR13CA0266.outlook.office365.com
 (2603:10b6:208:2ba::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.9 via Frontend Transport; Fri, 15
 May 2026 09:37:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Fri, 15 May 2026 09:37:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 15 May
 2026 02:37:02 -0700
Received: from [10.221.212.38] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 15 May
 2026 02:36:57 -0700
Message-ID: <e5e1ae53-a458-4248-87b9-aa1e1a241571@nvidia.com>
Date: Fri, 15 May 2026 12:36:50 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/8] net/mlx5: Prepare eswitch infrastructure for
 satellite PF support
To: Jakub Kicinski <kuba@kernel.org>
CC: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, "Akiva
 Goldberger" <agoldberger@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
References: <20260510053448.326823-1-tariqt@nvidia.com>
 <20260513192539.7fd96592@kernel.org>
 <639580c8-f93f-4945-acfa-ff116b841f6a@nvidia.com>
 <20260514161649.7a59a547@kernel.org>
Content-Language: en-US
From: Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <20260514161649.7a59a547@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|CH3PR12MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: f13094af-6787-4920-b1f5-08deb265913b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|56012099003|22082099003|4143699003|11063799003;
X-Microsoft-Antispam-Message-Info:
	qOx6UxUf0YTiuqWQitczDYpPtmXH4MA+W54BM3rvAGURL46SRzphff9m2yYmoygElE6gNmA8SqWLp7AySkYv/1bmrgnHLnPI6534HKdqDpe6xK6oUjXcVrTyNRuceSLpu+pvXT9iCTYLohEZb7FDhEXKG0sdktMTbszh9/VM0ZpSrZLcrxr6rjBxHXlsKV1eysJ72HlNkAmqVS4tJtP3naWjSCWq4t0Gs+0/rBgJwHM1EL6CiuH+Yd9/NqXYvTxP7pd2JH/tpPsUmZMvZFEzUFxX1Ypk9S+NQj74yhLXwlHTN0BnPo9T3InURwOBd+KGJ4Y/2g3l4++XW7LGD1nB24WFZCVY0xBHsOHA97BpEJ+qgjUz+cH5k3sFs6ES6bcKx9OBJHz3/BBzW1dySddRkJGSdD1q5gqxLdhFOKTiYW5SJKYj1EQ8Y5yPKtQMpcHhIGIoW6CcxZsACjfl02T7SinJL8uw25qJyWahZIJk0KuByTVQ5l6meuUbJZh51PCpjeA74+CEZanT+LfFM8XU1Zt1e+Ec+D/eF+cKQNImx1qLcRKIiv1XJD+rS3hMQ51CbnCR9uu6KMJxhFCsz6QnXypR3g7pRnbzD+SzxswAMevjl6fA24WzbiU8tzYqwxaHIZTLhdaoe0tODVI3msZDkjMmShaC0Doqs7oXcmkxqFX0oSJocwD0cku7lAW9q26edi1+KjTIIfQ4kfgrOc7MJDDXI8Y41ol5lhZnOTxdBF0=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(56012099003)(22082099003)(4143699003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TKrI10rAquoSb6kjwPD7DNV6PmDD3haCQR20LK4LIf+BEhHo4nlj9lqAkj+LK8mODzdpOj2LPrEVu6CIKxpoeNe5U1fHba35h5Kla0hkhCltyN8r4StRGkM67BA+iNl974sQ2hFplI8gbBR1dw74IDc+z5PE0XP4WOvRhhmnzpR0xLpyeqJmbYL4VuXtKE1s9ZL3gL/8Ou//AuX1f3U1N1IMalBuV638QtiD1K6QbuqGxGnbJeiNUq5HThvQueBNmStNVeeZLIlIHlVTVqY7+vIiU1U7xVbkUOvT9KGPHZNoOb3XAEWm6RjI4sb17/KrR7c8Iq7OQ2GRSE26LBot/wlL2BSb8/f6cOgWPeFwmdI6juxUdX8wRm4QGU4r0MPYQZG9y2Jf+GoqhurSATkVmzE/CCsty1QMMLct6APonNtQTsfLJPtSqvpbck0p4+ea
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 09:37:22.9203
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f13094af-6787-4920-b1f5-08deb265913b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7570
X-Rspamd-Queue-Id: CD00854CF2F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20766-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moshe@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action



On 5/15/2026 2:16 AM, Jakub Kicinski wrote:
> On Thu, 14 May 2026 10:56:26 +0300 Moshe Shemesh wrote:
>> Satellite PF is another type of Physical Function, its role and
>> privileges are similar to the host PF, but unlike host PF the Satellite
>> PF is on the DPU and not on another host. So it's kind of "Satellite"
>> for the ECPF which is also on the DPU.
> 
> Do you genuinely think these 2 sentences explain anything?
> 
> Maybe it's just me. If anyone reading this thinks Moshe's explanation
> clarifies things - please speak up..

OK, let me explain the idea of this feature:
Currently in Smartnic configuration we have 2 Physical Functions : one 
is the ECPF on the DPU, and it is the eswitch manager and page manager, 
while the other is the host PF on the external host and it doesn't have 
privileges of eswitch manager or page manager.

Now we have a new Smartnic configuration that adds another physical 
function, on the DPU, that is not eswitch manager and not page manager. 
The new PF can have its own SFs and the customer can passthrough this 
Satellite PF to a VM on the DPU and give it to a user that should not 
have access to the ECPF privileged function.
As will be shown in the next patchset, the ECPF handles the Satellite PF 
and the Host PF in a similar way, using the same management framework.


