Return-Path: <linux-rdma+bounces-9089-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D21D9A78065
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 18:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 875153B5497
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 16:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5472206BE;
	Tue,  1 Apr 2025 16:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uDllGOEk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E893820E70E
	for <linux-rdma@vger.kernel.org>; Tue,  1 Apr 2025 16:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743524295; cv=fail; b=N2GLlCwqzBFMzktdCxTS700GgruWpM9m+uUY1BndtJzs9amI5wp3TPz4e4jV94L+RiqpsYyF8UkhnzzvjoTkPfVRzMsN/w1sR06GS2kl6EEmVLaw2aK2wcyfxnCBeaFspjgbuXphxHShxv5slaDZeLPFuLvZYoYixVM8iO8SOD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743524295; c=relaxed/simple;
	bh=jI+ziQu2riwZ1UwJBTa0Cxt6PcJAHIE9b6PdhgbTMQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p9/RxG6I5MHBbL1G9ZY8AZMcckELdCvjBIhYRPDNBL4ItCxrVxxJUhKQ+l1XqzOXTSvDufSIU22PbDTVq//odNmf+BH1slc59BLp4aZL0pBtHYcA72pFz27Ns+/qqrUIDCWqhg6FIKUZROWMC1aNt8GUCrcHv2as3ewXs5nTXrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uDllGOEk; arc=fail smtp.client-ip=40.107.220.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5KNpG+LCCG33uigJYeTEpEA9Nd1r99QzMFcHWJubzkLzLwFeWGjcq6ErEImggWnWghZJidvHF6eofKLAm3ikfp2s6Xsu7DXj3a84Q86Gdsu1/37kZ6s+tof7Kw4UsWUOfzcO3r2BV4DKUOvJz+2NI/p8jPItpR7Yq//mgU2GoIvjMB5UNSSemI8HJEqRGbcrdZtBNPQOsj8J+gYfBF5DObHn6AS9k/YoJcax0I1wgoFv+wFkLaWcQKtzTuCSGa8SwnY1PH0nGAE+IMdf9JKrlfpZG99RIXmhPx1QZzQczK2IeqgZ1A516/63XUeoN58nEzs4bBaHyVcNjV7by/+uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nztx4Aq3Bz46uqMM4pwQ8pAJQK/7IreI90tNEpGBoDU=;
 b=cLD0oAORFI5GgplyD4ESmCR/K1N4oY7KEmTZoz7sYLCFdFVYOwm58ZgQKEXtTYUSPjUiSr+FTItTePz87SzLroWRlrTHWbxEr/N9X7mRlRqCqacoVrwkGzdB0Ked2rDJ1kpJP7zvI/vDkVUseueBdcYQZzQ1Ux4/qMFTF0eiW7aCT4Veizm8sUMXh+yxWAvv3vzfHeXo9UO+qPGMJ4KAIoTmKzBjno4nJWZtXbRKkpIMeeZi+JwDr+J2l6+kqCZtE07QzwmEQqQnsOtsIFS37s/SQyqPLzV8805WzpS0aX/JpIiA1srZGAV1atPr0DveN2Lfc9jrdj/3TjqquyuZ0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nztx4Aq3Bz46uqMM4pwQ8pAJQK/7IreI90tNEpGBoDU=;
 b=uDllGOEkb76p6yLP37uiEWa42U+/Mtxmuj29IJJqOXKYbuoQL5LdKR019jMM9+gpY1VJwXZza/UXeFk51DadxuzNlquaLoAAKd+6u8Pzk6xKES6qvZoTBXKv1Qk4GeWnw+2IcCSvMd7VqnryytabNzhStzUiv9EFpCdRZ9zn4i0tTEg/LCPxX/60xu5Il6RUmhg9QPK3lv8qdNcF9beFV39MSdJYYztXnyqpG8AfGjFkW7vM952beney9USqckfd4qe2QLoV5/jMqOgE3cfhbcStMGk6KVEyufkKwGAsVUnnoEd93ZG4oFK3nqCFLXinyN+J2/sp/djEElt8qNN81A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ2PR12MB8831.namprd12.prod.outlook.com (2603:10b6:a03:4d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.48; Tue, 1 Apr
 2025 16:18:10 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.043; Tue, 1 Apr 2025
 16:18:10 +0000
Date: Tue, 1 Apr 2025 13:18:06 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Moroni <jmoroni@google.com>
Cc: leon@kernel.org, markzhang@nvidia.com, linux-rdma@vger.kernel.org,
	edumazet@google.com
Subject: Re: [PATCH] IB/cm: use rwlock for MAD agent lock
Message-ID: <20250401161806.GA324422@nvidia.com>
References: <20250220175612.2763122-1-jmoroni@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220175612.2763122-1-jmoroni@google.com>
X-ClientProxiedBy: BN9PR03CA0514.namprd03.prod.outlook.com
 (2603:10b6:408:131::9) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ2PR12MB8831:EE_
X-MS-Office365-Filtering-Correlation-Id: 3feec086-6c56-40a3-d5c4-08dd7138cb59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r84+h4atSZvVInVWDpDlOqPyzSd49f5TmDZXUx6Bk94nleydJXXtyoNJ0zZe?=
 =?us-ascii?Q?LKKdcz4Kpv+8NsM/MA8H8mbmmkIw4VJ/c/mrut2KRj/dQRVw0Jk8MyzLute7?=
 =?us-ascii?Q?hDHQp4oxNrkeZgGJnWZ4+wrbn0VyWtZqrX9uP3EXWncYZUqN+/gyw1b7yxKC?=
 =?us-ascii?Q?kLXdyCyvQc6VddaI65R7N706xeI67kZX2n8kpfBko+hCDleBGEEwtScrT3ay?=
 =?us-ascii?Q?1T4nknY6rxhJF35JLpC7Hd05JhR9naRd35l5ys6cB0DU05n8Uuj16g2bSLnc?=
 =?us-ascii?Q?bC6Xkje7PadVxz5ENrvZDBMP93zblY3SCbavPJMdJkOQjtwNZKe3Jrrx/QC8?=
 =?us-ascii?Q?QfHKyoZClPjYUnTkHfKigTsidbCILFKjN8FyKiNr8hdACpjdujRjYscYUfN+?=
 =?us-ascii?Q?xtNbmS4WAiAlqae3RykZ/n6m5z0EImpjdgOj6GNGQZTPq+y9XQSxmWoVu4Vj?=
 =?us-ascii?Q?Tsn7Lv2q3Un4HzhggKgyY/ZZiB/Q0/pE2MdHW0mDNj8RrSlV1wfxCvbvrFZj?=
 =?us-ascii?Q?8kCTDcaUrqubeJNL+w/DF+VqiBxIjWo6k/+cpyfKWJYnCDC1hP6o994/AvMC?=
 =?us-ascii?Q?RuwX3mNeRJqYPF5XXiN5+SChZ7sC/hh9d/nn6ACINCiIZP4w3/qnLGo1d+TO?=
 =?us-ascii?Q?OvEMS0vYwaLwLe7dz05wHyimmpCrmIspuZujtcxKiYsNvVf7C/CWh0mWl/yY?=
 =?us-ascii?Q?Gd/NGZC6FjU0h1d0ndRD7+2GjNfl48Airuh2f5jexnFTQRihem0Ru4mE73/6?=
 =?us-ascii?Q?1bEa7q9gW2AmauQQzzfwyhSxjTKIvlzmQ/ikjS8zqbV5XuNiIJmDHzuI5Gbo?=
 =?us-ascii?Q?xXGE3KVbqcnRSTUhOeMmdFRnheSvD8SGSz7+2gLUTBUUMVBetaKg8Tcf0Rjb?=
 =?us-ascii?Q?LwIO13jC2M+sF39uWlg8VBXPYWkYDMFBbxOwcxAXzwKEKxzWWrHN9aUuwpqo?=
 =?us-ascii?Q?TykaWZioXYjMk8SKRWIu35Yxg6oWbXCyXs4r5I9j7VxEBQoMCqOZAEByVO6s?=
 =?us-ascii?Q?n2c5vH8+BSEb5hVsFc0M/U3KmC/D90y42TlPsglEuCdc44cmTIdM31piV/3F?=
 =?us-ascii?Q?+AEd8jZGOBP/KHxIb9uSMtheN3PPgr+EEVLWJVCXOws/ji2Q0RCFKwpF7UWC?=
 =?us-ascii?Q?A4PgKv1e3JtUrSoWGshfkVbcN+SDkY2f1gVjDEEdc4DmHKR9wh4ZYr0vhxxd?=
 =?us-ascii?Q?/qhAUSKlQkQLM9VSF2Q6V+ExshT/F/tWkUGDaRXnbsA/BMnn7fZoUKUOK4hA?=
 =?us-ascii?Q?xKREPQ2mJvCDJ2OEW1dr3vGKMq+ecDkq4RpTsFjOtcpDsXudWNHuv8kIajN+?=
 =?us-ascii?Q?wXHaHrptd9weJDB5X2suEQR77Ni+bQY/OuuOBQnJpk4eBDZPpKZVcBUvDXGh?=
 =?us-ascii?Q?SupzbN6hxz43FedNlEB49+gTCm2C4wKMtHo10aNmlBUf1UeELgIqQKegJsz4?=
 =?us-ascii?Q?XwxKE8v0Eyg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d1fDyJOFR2Qkw3p5WVDyQrZ/EWKt1LrGe0qscYB76ifZuyEFEgvLOkTC1ZyT?=
 =?us-ascii?Q?a82UO6i/JE5BCyCTACkuAi4w70hQWqIaT63cGP79xNOLJmj1T927XudsZwyE?=
 =?us-ascii?Q?Rivt69LpdvuEdX3XtuEfj6djAFCehSoDS4hEiccxOzUXYUTBJBcriXwfkOZ8?=
 =?us-ascii?Q?Lhqf6JRVIdWsVEGa1Q2vdC+oAezUENrKct4otrpgTDqWw27gAxvnyYMLmvII?=
 =?us-ascii?Q?la2tF3RV9LZE1rwghYRsJFFwxYEfRvW7XPomy6j1vTQOpf5Jljl/rvN9AmpJ?=
 =?us-ascii?Q?NzjszMKNDmsnOCI1HQoUjyDorWRFkqEcjIxi7dK8s48uaDwhgIn6NlFhTNEz?=
 =?us-ascii?Q?3mBIJz7wvNI98dF12Ff3OtVulY/MoR0C9e8dkffW5M2H+PNLwuMN5f7BJkHM?=
 =?us-ascii?Q?hnTczxbBOJe8rJUmZSmKFV9TeKyxCT2l1ZU/nreVkRm5+4Jm9KmkyFxzMiEq?=
 =?us-ascii?Q?OSaruYyuVHBSijsmNglz1AN7IsVafFXUiYjrqYRNFiuNnubLqxawbmopayUK?=
 =?us-ascii?Q?iwa2laRnZRR7DSegXrgBMi5N4cJ5Z2hf4sja9U9lIaTy3LEYKW7F7V445XS0?=
 =?us-ascii?Q?01TWzUeTzlqJ8MQ4zLXEqP3qJrOZQL4z7Y0kg3pxEJDYbJUWrOuZh1o4vjny?=
 =?us-ascii?Q?0swPFAt3qDS2aupNvlwxMQXUEASfTFwnq6LK8zQuFPrqmBzOIkyRlKw2AdwR?=
 =?us-ascii?Q?Av70h7/yyoVw9TYmwxY3DaS+VulXrK4Kab9iwlzh1/wAd/cuRRtuSkPJvt90?=
 =?us-ascii?Q?bE8v3txs5fil35haTpC9pP/4BKOqwfLK6D89kbESkMA12HwCxzpnh5CCkOcr?=
 =?us-ascii?Q?GgFAwK5C/xoHa7saJEpHC9WsALLzCrCkWCthvhR9/NWAsUQrvUCbpsRpdHlE?=
 =?us-ascii?Q?CkwAbVKYmn7okCOkm+g3Pw+NLfRpbNfwOH4ld4qsCOQlnz3iIrw7aHi9m//J?=
 =?us-ascii?Q?S/gK18l1iC+KAzoeIzBOemw9shbE8DKKXyg00zFfzmvFmE4OoAR0mL+gGDyV?=
 =?us-ascii?Q?KgTTaF1RQdtLHmCmYC1qZNCeuZ1+5biPAmmX6zwDnq35wXx/1X6dGfqmqACS?=
 =?us-ascii?Q?B16q2wsawdq1E4zXXdyHHTSNBju+PVOX2PXx5Pd9VDfh96k/StL8kzmFCdWF?=
 =?us-ascii?Q?dGUgi34wyQybrPQEyIgvbn4b3vZkOHuJVsAGm6TLBXNzHnpfkGauTI4mtYmE?=
 =?us-ascii?Q?ssPmykKct3fargQVBIwNi0SzzYwFTERSmU8dskfEXX6+r/I10P3kH0i860cE?=
 =?us-ascii?Q?hT+pVZ3jPK0h64qAmpEBD9zGIxYAT/O7Q5uVxdZoyFw0sPne4I6cJnl3AH+5?=
 =?us-ascii?Q?19fW7erVsTleYnO5iqRnRwBsXdcvJaZo/QktUQ3p+XF7BUo32t1P8CdA645X?=
 =?us-ascii?Q?X53Vbpj72FCu6qDV/fAa5Xrw5Sd6Z88qMfbWXhbi/jwe/XXvuD6weRNzrEyJ?=
 =?us-ascii?Q?53pyS9nGxVSGfqWcNG+3SU9MWWPW0eMSvvn4o3vindY/1/BmOr9LZZvp5NDq?=
 =?us-ascii?Q?La0Jix2ty+/NigUrTv9ew5oDFtpX8tQdROCiPBv0XnvG+ODB50g3ZDbjP6CB?=
 =?us-ascii?Q?7w5GhJD08TbovlugejAGSqFtQW+jvzwuqR9iWdxd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3feec086-6c56-40a3-d5c4-08dd7138cb59
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 16:18:10.4452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cSMa652o70VTtJD19lYfNvpI2X6Vb1B/2IxQ052EO3B6tsjSPup0SXYkMh3vsJBv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8831

On Thu, Feb 20, 2025 at 05:56:12PM +0000, Jacob Moroni wrote:
> In workloads where there are many processes establishing
> connections using RDMA CM in parallel (large scale MPI),
> there can be heavy contention for mad_agent_lock in
> cm_alloc_msg.
> 
> This contention can occur while inside of a spin_lock_irq
> region, leading to interrupts being disabled for extended
> durations on many cores. Furthermore, it leads to the
> serialization of rdma_create_ah calls, which has negative
> performance impacts for NICs which are capable of processing
> multiple address handle creations in parallel.
> 
> The end result is the machine becoming unresponsive, hung
> task warnings, netdev TX timeouts, etc.
> 
> Since the lock appears to be only for protection from
> cm_remove_one, it can be changed to a rwlock to resolve
> these issues.
> 
> Reproducer:
> 
> Server:
>   for i in $(seq 1 512); do
>     ucmatose -c 32 -p $((i + 5000)) &
>   done
> 
> Client:
>   for i in $(seq 1 512); do
>     ucmatose -c 32 -p $((i + 5000)) -s 10.2.0.52 &
>   done
> 
> Fixes: 76039ac9095f5ee5 ("IB/cm: Protect cm_dev, cm_ports and mad_agent with kref and lock")
> Signed-off-by: Jacob Moroni <jmoroni@google.com>
> ---
>  drivers/infiniband/core/cm.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Though I strongly encourage someone to change the spinlocks in this
area to mutex :)

Jason

