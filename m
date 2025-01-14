Return-Path: <linux-rdma+bounces-7012-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C84A1114B
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jan 2025 20:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44A3F164AEF
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jan 2025 19:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695A120551A;
	Tue, 14 Jan 2025 19:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qp0XqWjq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61331F9F66
	for <linux-rdma@vger.kernel.org>; Tue, 14 Jan 2025 19:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736883736; cv=fail; b=t3DHYvY4f/vYKbbre5F7MzszD9n2aHL82r9L9H8DydwlrxT3GihJZBfLFHXi0Z9LkFZu3p/e7xwds4yW7a2j5/RJDJHp4cBvAY5IEYTRdQMPmAG0eXo1LCbNLCm36VVutiBdGms2l11ma0r7Nq9RMBM/opU4+v9r72cDEz22XnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736883736; c=relaxed/simple;
	bh=Bexp51rIHJYvneHFitEyIauIUAZ5zi1HuTIQ7ajsUIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f+mvqbvt4KsYF4R2W1tnuMUk60fi62i2iZTAF6ysLegkFpeGjfCpU3oMO6HsLzfKNIA6gc9LYNp1ew29Ch+BOT7IbmgMLq3bY3+b7wjQF6Znu3BaxLvS2bQ1tZRzgIc/ulJPKG1s0EnS19t/S+49JAajEm9CDB6YseHQE+hOkfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qp0XqWjq; arc=fail smtp.client-ip=40.107.102.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dqCNqMyHQLLOeBJc4En4TdPnQiCOep2VO3+v5evKfYCUaPH2CXFYZs1NCaBPSlVnrPHL55Z10GizUuzFTueUFkH1WGXOrsyDEQ6fgcw0KozPozWUAplfze3arRso+veYqlkj3BOLed7OBogg753nAb01/69Qn9sdAvyndbJV/EudgQ0mOsUbV0Sdo2slRz4S8+Yvrtekn4gawUGaL1IdYuyz+80yjfsSYOhFfVDx46cqiVv7Xem1iCawtO3d6dH2crRgHDI1ayXQnNwq/lE/UP4X7hAfdzJnJJoTfpxPuelY9jzBU/PHSIiHR/4A0IfX2CuU5PSQYczxYl/oQAIBsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXLfB8H1fex+4Ylv/H0w/CdaVn4JyxvllyzIaXRm42E=;
 b=WtVOqhx/iLZE2ScCiJHy10Zb2mM4kDTgFEEZMH3+51zR+OKsrbEhEO7YXsRtsmFuDB65bGabRWrrq0j1VBVkTzzAim/67ZHb5224X1/TmWPgljR1OELxVORzRy2T7x5jpmFZtJ3XU8ubCIKC3jGjvXPMSiQeXujceXH1/1wBhZcyuO5K9EavqHvFCSg68/nzQ5UWezRaNjgrIqGkeayDiACEg0ey9woUbYd2elpJKqeElkvF1KDXzDNDjMICxlvBCCcRqPeG88duFNM+sBOrIrSRuuWUU6pQs8yjYIa0vrQGzCohhsvsqpnJoMVwYTjod7KVYsNMJrU3vUEVgOxymA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXLfB8H1fex+4Ylv/H0w/CdaVn4JyxvllyzIaXRm42E=;
 b=Qp0XqWjq8IIVKRKugcyXrlWClhwEhafdyuGiF5kSSRXGNqZQXiei22AG24c8gDduntnv8ukRQP1OnuSJIoj7hIu2zxqivG9+5wsbnD9JRXAiWhV8Ye7UqBf3zabjG5HFTDqwWftkzy2r7qtvwst5n0wo5tb51BZ+3yeJoRTsfOgVa6yrh0zVPBUxC7iRx6Eu/VSg8C1d9++W4ajtPCSCZyFp8PxiQlWAYBoLpMGoPoEmFE6i/IK7tKOWsb8HBlg/TvYSsaz5HhLLv/6jU4w7GgE0lzAr6/19eqzVnaBEYci2SqJzXxQQtdBI+AZD2EMmC21FtRvHwYD+TNkUWa67tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB7040.namprd12.prod.outlook.com (2603:10b6:806:24f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 19:42:10 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 19:42:10 +0000
Date: Tue, 14 Jan 2025 15:42:08 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Or Har-Toov <ohartoov@nvidia.com>, linux-rdma@vger.kernel.org,
	Maher Sanalla <msanalla@nvidia.com>
Subject: Re: [PATCH rdma-next v1 1/2] IB/mad: Add state machine to MAD layer
Message-ID: <20250114194208.GF5556@nvidia.com>
References: <cover.1736258116.git.leonro@nvidia.com>
 <bf1d3e6c5eceb452a4fa4f6d08ea6b5220ab5cc9.1736258116.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf1d3e6c5eceb452a4fa4f6d08ea6b5220ab5cc9.1736258116.git.leonro@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0269.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::34) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB7040:EE_
X-MS-Office365-Filtering-Correlation-Id: 08acd43c-2ae0-4793-0bc9-08dd34d3890c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rybq3djHqUMvcAlSALGBJfkMTcnNDZoAuyXqchOP6RkQep6coRa9V3/9irk/?=
 =?us-ascii?Q?p2HEq/56bzfHPMuZ9yd245qYfBz9mtn4zSfkpzXTOSgW1mYN6PwHXom0RfBR?=
 =?us-ascii?Q?N4p3HPxupLzUE8Nkhq4PZcfhH8r8DsFwM1E6fc3uVAp0QUeBqK3LVgc7XFr/?=
 =?us-ascii?Q?y+0ZrMWsxw7SXan0Pr5ul1g5fShod4z+/S7K3j3mfv38Q4D78xzdOvlcdz6F?=
 =?us-ascii?Q?XPz4mf1TP15weO3MsEoYD7WFtZ8Pro0g6YAR2gI15wcOUXtbEARo/GMYFGgg?=
 =?us-ascii?Q?vFFnrXgCXISpnohJq/btqZVtGggD6oGfuddbRUf0AMVwOBukyQS2tiHi6HO6?=
 =?us-ascii?Q?UQW29Xxv/Jk1CH82JgueDP9JbaejLfCGxJwpDYEc8U/61CpBZdIXnKDCRtL3?=
 =?us-ascii?Q?3jz/nx658aDsjTH8AmFVp8sNXlnvERPJzlE0p1roAuT5k4TIbWgKmcaFKB5M?=
 =?us-ascii?Q?z1PMT20oyqznITlhhm5RSwXl+ol5hBC/DDlu/uTRDL5/0ofOw9APOhwqhTqt?=
 =?us-ascii?Q?+j1/emh7Lv2eDuH7llU15garm1NBsf4q3ptNPRMaoQmRE6XRtw7OmMsQ4lCs?=
 =?us-ascii?Q?6Ifw6J9wF0gi+sdH8Xe6POKVfZPomF0M/KTb6tmn89/KqIlBms+uvdcOhyPG?=
 =?us-ascii?Q?u0d6CnFu0cahkjmP878jlbHM3Xh4/EMH5A9beETGd9EOxAxL5ryDv2zqNkyc?=
 =?us-ascii?Q?pYj4KfioJ4Ei7oZlXSkdMNB0qvVbG/j4DNUkCQuuaWJ785rqLs2xpbfpAaEA?=
 =?us-ascii?Q?P1l/ea3dPEJRwSbrlUe8HRKk6yNQFbzJExFrlYpUbJjCv62V4xl8O3Du0WG/?=
 =?us-ascii?Q?C8MY6+REygw+HXR1bxVA3R6fe04lHO4LLRlOStWXslRnjNbY8bp2HzZrqjPH?=
 =?us-ascii?Q?AIywQkTmIRO4t0+aah1vzJ+cEfx7nJmRtmEl5PkLn15EnpM4QOwULr+njtl1?=
 =?us-ascii?Q?bEFfM/d7SbvQcNbaSr4ZjKwIoj2rzFJcz4lmtF9EIXgyq8hpLN8DPvuM35fy?=
 =?us-ascii?Q?ivj4wOkB3ZuaCc5M1hKgQKM3sDcP7fzUPGatbMd/dJomsy94i+QolWwzu7/N?=
 =?us-ascii?Q?SKOHxQwirxcLBYF/4he8Rg5H2DMcEerEb9uOLAhiepOrgRV4+dwQQJ1BwziA?=
 =?us-ascii?Q?kg/1IgTpb462nD6n4i97CknmNg5Q7IWn2w56Uc2mnvMFGwGzI9lTdYGAreU5?=
 =?us-ascii?Q?URND01eMXnL6FHS2VrfPuLaVGVOloOsw4GbwEjs0Y5ZynSWp+LNOmir4VnEX?=
 =?us-ascii?Q?kvHm+Em2niOZtOD2EJpKwk85PYjjk29jcXqR5iy+zsxG1AcAtGiAAI2bT3z9?=
 =?us-ascii?Q?74IPN9kdPTkDdff8+AWAXdSahoJI1iY+TQz5I2MF2Udb4eYptBGklzPW/cd+?=
 =?us-ascii?Q?x7jVgP/aU4ZWvXjmaiYIqjyZQ/U5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a70nLlQktC0LKHqeo0NFjPQ5X4MDroMgK5IERhBAFMgFkVlGYTNvv8XRjjRm?=
 =?us-ascii?Q?8x8YG45rLlRLp1zeQuQbkxpQj2jf12hYKWVBc17Qrshos5u8Rw3A6UYgM3zC?=
 =?us-ascii?Q?gOKwMjsCfxD4Qcf367b6eaV7lFSgGu9Dxb3oSkYzIcMBK4S/5BdBv+hTcrFU?=
 =?us-ascii?Q?/4Lq0k06JjdFMKScE83skhbfB27jFb1kN/qG9hEWtalBl7EpM91M1rvSFNpb?=
 =?us-ascii?Q?ucq4W9SqQMC2UdId98MzMeDBf11EwwNkSWTovSY18/gpPJfjbnCvTsQr9Z2X?=
 =?us-ascii?Q?6Jgi6CGx4oIe8PF9IbqWNmt6kZaQKTQs91CA+tgGEWdLkL6UwfCdF+Y8rixg?=
 =?us-ascii?Q?/FAxNESOMIo90xKTjr4shyFJ9KegJ/9anP7If2vJb9bYhK7E85LUGh6iPBcj?=
 =?us-ascii?Q?0Z7UoT/nj4698GPHUD+L1V1KDVbCm25wPRcSniB4pNWZ6XCs0cQvG91dj8xF?=
 =?us-ascii?Q?+V5XRoM3Mv504IX166fmeasahU5rXCWiN7OVeG2XmuWZbD0q+QRN2KP5mzct?=
 =?us-ascii?Q?A3qu/7GlmccrT4UFuTzzW+8ijMura1vGahfiYoYN1WMhZecSFJymnJbUyQw7?=
 =?us-ascii?Q?iHOG0hXXcAnsX//MJ6WOTALhGyl560lx6K/0gYlwOEq4lisxgNHP+mU9abhi?=
 =?us-ascii?Q?Pz2mVV0lKT1c+oXIsMxYAahk6gPwJ2hUnq8Qhb5jXoCxVkZ9mgPMEWt1L95w?=
 =?us-ascii?Q?JVUaA/lSJuEkGmbvlH2jGCPAyWR/ZS2BQBk7h+0Puy6NKxmVOBMDNDuXft6f?=
 =?us-ascii?Q?EDs4Zua6/UmMZrD6L0aNKrrAmJfYeOGFp0LgY4Ncvx4TABk+ulXN1xXnECqy?=
 =?us-ascii?Q?E4bBAUaJOqx/q15oxR6HD33rrK9QfT5g+auDhFsjzrrMOiK3j+9ZWzKcfu2N?=
 =?us-ascii?Q?HP0P9V+1jxHDIIvxDY1qdxo+0pPtFiz7BhqzjtPBRxtb7LaqxA+hW8uHHLi0?=
 =?us-ascii?Q?9taBB9sGPVI+7sDkspeLcW6y2X77hEzTa+YUpBEmLOHnETRF6lIXMgnDc/jW?=
 =?us-ascii?Q?6+6uyorXezS5ou5MiurbzuO8wNygg03xEiZGMfzeCkDp+iEY9HoFU2rIIoLZ?=
 =?us-ascii?Q?9u+7tEU6OiznOXcpsWQqJ2QKwykAl6BaLwJwU+L/hwrY8vez1DT3PVZd7Aei?=
 =?us-ascii?Q?gfLiXoRr4J8Tro/zTeG8nslewco8pfHcUwYiM059LMRk1CYfGrHB2NpQBCxI?=
 =?us-ascii?Q?egyquDrky1xOj5zx4IA+UONrHyzJVhk7iOCRZt8Z47lSPuxWrBcAAgbCqUWG?=
 =?us-ascii?Q?1XWR4I+Nypvf6q1uiVyxCaEw7eSP97nvgUIwtFRK8+W4f4AggtIkPBkQuOjd?=
 =?us-ascii?Q?ITmYpoHhdBd3evZ4Z729QT/np2X7URADhWYOdbU5OMnrKFF3f92COEv9jUke?=
 =?us-ascii?Q?nZat7J/9oMNWh+BIG9xgcf5WAj8MvrFniZ00aTxl7yE4+beRmwGoKSPWba/i?=
 =?us-ascii?Q?jpF2USnu1vGUrmYeS+c/3eSEhNNcmhAhVJFZ5ll0Q44phNuIkwHSdQjktBDJ?=
 =?us-ascii?Q?sSyKjqLhe2pI0ikmOZ5jFodeE3qtA/lfhAVMP1NqE50AazrIhJzUMpg3rwug?=
 =?us-ascii?Q?/mZp6PMOXPl3A4EadfJWIziZmhNAWa3MfQkDjNCx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08acd43c-2ae0-4793-0bc9-08dd34d3890c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 19:42:10.0033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GuwsBbqQgIBDmcc6mb4iv1jN2iSl5jbe+I2sfS7UJ+0TOR7h5hRaseAKrkWTVew8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7040

On Tue, Jan 07, 2025 at 04:02:12PM +0200, Leon Romanovsky wrote:
> +static void handle_send_state(struct ib_mad_send_wr_private *mad_send_wr,
> +		       struct ib_mad_agent_private *mad_agent_priv)
> +{
> +	if (!mad_send_wr->state) {

What is this doing? state is an enum, what is !state supposed to be? 0
is not a valid value in the enum.

> @@ -1118,15 +1209,12 @@ int ib_post_send_mad(struct ib_mad_send_buf *send_buf,
>  		mad_send_wr->max_retries = send_buf->retries;
>  		mad_send_wr->retries_left = send_buf->retries;
>  		send_buf->retries = 0;
> -		/* Reference for work request to QP + response */
> -		mad_send_wr->refcount = 1 + (mad_send_wr->timeout > 0);
> -		mad_send_wr->status = IB_WC_SUCCESS;
> +		mad_send_wr->state = 0;

Same, enums should not be assigned to constants. If you want another
state you need another IB_MAD_STATE value and use it here and above.

> +#define EXPECT_MAD_STATE(mad_send_wr, expected_state)                  \
> +	{                                                              \
> +		if (IS_ENABLED(CONFIG_LOCKDEP))                        \
> +			WARN_ON(mad_send_wr->state != expected_state); \
> +	}
> +#define EXPECT_MAD_STATE3(mad_send_wr, expected_state1, expected_state2, \
> +			  expected_state3)                               \
> +	{                                                                \
> +		if (IS_ENABLED(CONFIG_LOCKDEP))                          \
> +			WARN_ON(mad_send_wr->state != expected_state1 && \
> +				mad_send_wr->state != expected_state2 && \
> +				mad_send_wr->state != expected_state3);  \
> +	}
> +#define NOT_EXPECT_MAD_STATE(mad_send_wr, wrong_state)              \
> +	{                                                           \
> +		if (IS_ENABLED(CONFIG_LOCKDEP))                     \
> +			WARN_ON(mad_send_wr->state == wrong_state); \
> +	}

These could all be static inlines, otherwise at least
mad_send_wr->state needs brackets (mad_send_wr)->state

Jason

