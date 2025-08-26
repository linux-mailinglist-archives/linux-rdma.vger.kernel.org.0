Return-Path: <linux-rdma+bounces-12934-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 486DBB35EA6
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Aug 2025 14:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C7884E41CD
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Aug 2025 12:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183CB29ACC5;
	Tue, 26 Aug 2025 12:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ViEhcs0r"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2086.outbound.protection.outlook.com [40.107.101.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6D925557;
	Tue, 26 Aug 2025 12:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756209660; cv=fail; b=kuZSniPDE+9hpbYsFNK9MDNKO+9nzFk+IKYAHW/Sfv/ZLyXJjePqoZfKDnA0AsDg71Uww0X1xxMH1pmKqUrg64BDE3q856N9lzl5IiY0NylTRdSklXstQRNq6PNkEUgXZf+4AblJvN6xV7o9ovpF3f42Q/Kmky00AykqouHnCbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756209660; c=relaxed/simple;
	bh=S+IILTkwYlDtf3uYYIZhYyY544LrzVsQLxM3TIYz/9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bJ1NuUzNqjJD+KaeGxu2o7iS/Y88wuoYMpXWL2883ut0LvaS7Qwd9+HsixyApYyplKQvWDoaU1wRVpTyVeFJtun1q1brA19cG6C19ClUkxwVXKAnAMlg4iblFE4j2VtzPtS4IwNU5Q7umlZ4PC2Tqyqkk8a7kafcqPenjG9lRMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ViEhcs0r; arc=fail smtp.client-ip=40.107.101.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uSpUNb12toch/JJlOyIjyKlHc055Yvp3rXQ72PmgAqbWnqpj2K57Ronh2bJkxCsZF5ezvzhZcIjLhm0zHChKFwEQLElu9POID7+UrWTxMr/+BQ4SsvXSlff+RO44jkIMIRwzn+stEcE9JRAYYUxwb4f5rBsqW6KGldny3K+SJYwu0pmVdUJb8gWUekuq+VIUgI8CN6RzGh3E36wLFJhVEmTgWkIBORwgdxDGuzmo3M55ZN8r7phMtFqI6JRSBJG0A5gqn0aD15CWJI0SeGg6so6NN6mzcEHRUeQDw2MICdSG9pmtANdaiz5EL0ePR57zbRi+7B8QoewHO2Id53fH1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WusdFnbXutZAdGmxFTqZqwQteKLzeLXEsjt4NVbzPg=;
 b=vXzjgVpjjuPuLTC45t1BQaziK2uwQlQaL/4fZaQ5qCPgfZ1vGfv2pXuJP7EdHfiDtFAsIUEZX3Ku8i0PhXTilSaWNyk68wnE7YQZIt0XYIGvQVFrtHevbTkoH/RWa0+GU7bqOHjaQ3gPFPFP9XjDdyxJn3bkL62thJubyJD+ah8r+mR/Pka0l7s1NRQbpXGXLSYlj6BbMOyZ5jR93mAjBXFV8VEUU5/uEq0zZT/zPkSQB1LWQyNkF1bVfyLaOnNGqL1m7Xqmfa5SD6J1VCFjULhIHd4rPCavlYEQ6lsy/QIzKccnww0hHDsxTRjWxxjnv6vc01h8CVULpBtOIdqvUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WusdFnbXutZAdGmxFTqZqwQteKLzeLXEsjt4NVbzPg=;
 b=ViEhcs0rVRDIWzyf0ZV5srmy6VBlidgEt8XEiW0AOV0eX1vi4uNxY4woDr5Ln+NZLZQAd/kLpEZ3xrAOalUNTIannVQI7D0ldNyuqmp0cD1FEFvD4ttpw7324xUtN2ZDtQXFucFGLtnXKrTY8CYvQBJd4C5iPKv/6nMkYW5vzrUEZPZignj0D21DwyrkiNIsuKjRbDS1DFIbAxr96xOY9UDoGcjlhPm7EJua9gNyQJ3h3X5tSdY+h3Ylq5sNk2tDMQG2QdZi0ZK8KBLw90bLo9tK4u6cRTFMz6DqZYSF9gO8Cw/9GqSlr53D48XjIkDCFC5Z7CIrdfbQf585iU6www==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB6085.namprd12.prod.outlook.com (2603:10b6:8:b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 12:00:53 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 12:00:52 +0000
Date: Tue, 26 Aug 2025 09:00:51 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] RDMA/cm: Avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <20250826120051.GC1970008@nvidia.com>
References: <aJxnVjItIEW4iYAv@kspp>
 <20250825172020.GA2077724@nvidia.com>
 <aa568cd4-3bfc-4eac-8a49-eb4cf7cf7331@embeddedor.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa568cd4-3bfc-4eac-8a49-eb4cf7cf7331@embeddedor.com>
X-ClientProxiedBy: YT4PR01CA0172.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::12) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB6085:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b45335a-efc2-475b-1e02-08dde49834a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Uzo3pcGQ4Sda9uPiKrEKO2FchtlAf8TpPaeLOmrGccmOy8y4TxXkqXJeO75L?=
 =?us-ascii?Q?HI9wV6KhBFF4Hx/rIchCPKWbSK1I7yvt6QWJGhqkrWcdA1glkinpv48gELVO?=
 =?us-ascii?Q?L9w3dML4oyGnj0+YnJ121SK2s9g+XUZxWytiGujDt7wvBx/D0dvBY2pkogyH?=
 =?us-ascii?Q?v010alYuaTiRuu3vk6Gky0StQBz3Akg+e6NUcYb26X1/CKcmraxibV110qEq?=
 =?us-ascii?Q?9XntZavGVXwLVg7EchCeD/fh8uEZcrZAGID+FMXwVnSjPGxScyxM485pM/QG?=
 =?us-ascii?Q?ZpcmG/cpjbCQLKprRrzyahX59rbGAE/2xeuCbld+qYfjsYeARrqrPjPDrSmA?=
 =?us-ascii?Q?6HvogKhmKYbIFANlZvnwFHupxfEYi/iNYlI+eKQ58+bJ8fAUEB6TDS2jiTfm?=
 =?us-ascii?Q?HsaZSXqh1tI9wP6qDSJ7bkych4f6P16UU/SmxopUt1wBltNwIf33z547nxBI?=
 =?us-ascii?Q?XK73Jn2OPSwjfL0s1yJGpuQIcTxwYU+s5dYkjqsTPMro5Dq2atNGtugZhUaM?=
 =?us-ascii?Q?VfevPsPbmL6i8Aw1Cs3xRyeFsua4IPuezz37jMQS8oDEDofVdjmxuvaNYui2?=
 =?us-ascii?Q?xe1Hcbor1gXUQRLek8ukECzLt8MF3I7WkyFyRn+JqbMvhXtQzPk5CXj1sL5P?=
 =?us-ascii?Q?PJB1cCXF8iS+yBJdt7OReDrdrOMGdp35MUDmamKxqldsK2DMQHil5KLM59I1?=
 =?us-ascii?Q?6hYyj3aTS9WS8qdMryDsRMAzvlDGhE8PUpKzMo3oCdVI953bv2rXox3+fUzM?=
 =?us-ascii?Q?EQmgfdt10DKYrhpjF4JUDKr0Iyu9eR5Taws5mOqyyG5iT7kzTFOHZyNwJtND?=
 =?us-ascii?Q?o81PwY5OAPFKoEWRhPiaKY/QCHYWj4n98kLK4EvPBZdzeJjeYXW6t9mxig/d?=
 =?us-ascii?Q?GfQg6xDcLMm6d2thc6oaKpz3bBd/d5HhVAbzhoTpW7riCpMDt4YeIyTo4iBY?=
 =?us-ascii?Q?WFvDQ02b1JiwzTAtCJnXNuIq9wyn8WPfHKFhCst50E5r5VRC28QGFT1XhtJE?=
 =?us-ascii?Q?GzOb7BxtDT2j6TS3fFXAf/svrQ8FZCfz2NkZ1RrC0JGGzSe3kjBXgBX1fXCV?=
 =?us-ascii?Q?OYae6uyTJ+AkB2FNeSxxFhZB/uADid5tnjWWO7cJuIWO5c9oIoi7C53ee5i3?=
 =?us-ascii?Q?gYeXy+DAgYpLLJCKglxvVKegHT2T1IzIq9Gz5Kv1t1B2K+fDU4IQaQQiN6Zu?=
 =?us-ascii?Q?Iw7th9DEf4YUAa0AF3GzWtDXwhdJnAHLWJCRl9q+hSDuQThiMhowZJ7lKOjf?=
 =?us-ascii?Q?kguf/y+sX5EexRqPZowvFyTXhe5sK5oNRzWR6W7OjQoyg0LL/jyZtG5cvwxg?=
 =?us-ascii?Q?ci6abILFJhlGxemcpH/rP/Zkf8W2j3xfI5qR3N6wdLo7qS4f8NjDyzkSpg4a?=
 =?us-ascii?Q?N6JGsiQcoyrmID0DAU730SYq9C39q4rW1VSM4hPP/SU9PMP1rHROk7vSCQMe?=
 =?us-ascii?Q?nwoKFamAcIw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NyMdFdS4Uq6XwScd+EtTxc1sLj8J6Hcwfevpew2YotGXpcLOaQn+w8R8SoVN?=
 =?us-ascii?Q?UcaB6Jw3b/5ttv8GXDzdUoO6zCEH1BLqGuVdhkI0nkQ2dO7yg8oqTwVlDCvG?=
 =?us-ascii?Q?klEyFNwcf6pvsTKDZ5j1BaQTKcTuBUDJ0YWP0lQj82TExx9dP+lUIAYFGqbn?=
 =?us-ascii?Q?qiwGnRahACU/METhbHAJHFnDXsF6HBsGun6OAlp8zX6drPAfzNPHN52THL2u?=
 =?us-ascii?Q?TKsk9zfZKAU9qmz5rVzi4jog80HZvoZ1AZfDF4ZCx83JMRTKkzwC8LFI+USK?=
 =?us-ascii?Q?VvRNwR+K0LHjySOO/7IobsM8XZ6Xr946HJEr15iFImjjSzzDqFpuLJ4mK0SC?=
 =?us-ascii?Q?KTpSrzacZBan1SDe+0z6H2iqODBlrCeLG6+Yh07JFt1TJUM7O7dqFzOR2GnR?=
 =?us-ascii?Q?FizLNNteMEIHYkJ8eKoOHqMHRNCTRmxH4ULOILVxFrpU2SrnfXusBU3I+b8u?=
 =?us-ascii?Q?glSMup4VhfLj9+IK4kApaZFb/r8XArtVnIl/Uy+rOlrqB8WMgGr0dSbxY5WC?=
 =?us-ascii?Q?so7EpHhgTQjBDxFFsAMDVPsXee8qP83zqzkKpNrAC+3MOPeGxLEVRmumFaam?=
 =?us-ascii?Q?sEk1lQGfhIUxZMQQ8nMUgy9E8Qb9xhGml4bJGY9KGnTyJGqatlvTQZ4Iv4Ye?=
 =?us-ascii?Q?cV3piEmO2Y/wASfhf4pjIisOiaTm/mS81oFNrSPJS4Y4adFadGwl5QYKDHpg?=
 =?us-ascii?Q?yh792FX0TLaczZtFJCNHzGbFkt+zRXpYMlQvZdics8JJ4yA/VKRq09sgPrKR?=
 =?us-ascii?Q?B527GgbA4/cljzH8kTnapLuw/YF6aoYVd4B+QLmu6gqODYdN9mOE/uAoD2HY?=
 =?us-ascii?Q?hp0rp7+d0Ad6rz5cSCYRycLmqCLXsAv+XVVrCdIMrqhQLQSJ5jndzWSS3av3?=
 =?us-ascii?Q?fiLfxw5MSXx5qLVUh/b/J68tghupEKGoeVG9xzmJWrM5ou8CHejeptL7yDq1?=
 =?us-ascii?Q?8hNFla1yDfos4wPAs00WtKY4302Ki6Bu77iKGehX+XaxDJGk3pnBz82ev/2I?=
 =?us-ascii?Q?S++f59ZSQm2L1ScV2GWeNUnDkO/Cy/V6VMVGW+H8rTfuRRUSywotklvkz/le?=
 =?us-ascii?Q?a2KNBHTw4XpRceHHQP0fOXUgxudKGGTqFCQTpjhISZpJ+qWMcrRMfbxntahJ?=
 =?us-ascii?Q?y81Q1y3bIrsNdT9IqZGysTyVt+aJlfjkKZhr/1fTe+leMDust23u5gAEy1s5?=
 =?us-ascii?Q?aSV80JTTG06MIXEc63ECl+36rRV+Ouyenps4ZmEpkvvDh7Iw8VIxccmsYnOo?=
 =?us-ascii?Q?7VsUKw7LYX2QksZGQY9JiSJV0gVrU26KBtqI5le8mKMbleFYOHT9LSOCiTkF?=
 =?us-ascii?Q?XgeaZDFY2TaXdwIblSfoqV3vLHsiHeQRixH4YiDH1PD9Z0QbMV3kkvgBkO+5?=
 =?us-ascii?Q?bj1XPP6mpxWSG2lsMSUeT3hoRlc0GP4DriB6iwbE/jPa/LvM9XM99K575Mx3?=
 =?us-ascii?Q?t3Eo76Iq2SyMWJSvHiYjO98MAMKraRVaIbfMwa/cqXCs5IxoBqNIzBF9XWCU?=
 =?us-ascii?Q?ALGNqizBAYohtwKeAJwH+BYSIQoH5WvnptSSkrUR9X/i5cn2IssgYMtEEY9B?=
 =?us-ascii?Q?OvvNmNfL9mAl9YB/xvY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b45335a-efc2-475b-1e02-08dde49834a2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 12:00:52.7978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S4DNAmG6JXkm3GACZQrdAVNSoe6+wjeLkOBlcRAstiZ9oAxYn/m0BLcLVthSJFvP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6085

On Tue, Aug 26, 2025 at 06:43:55AM +0200, Gustavo A. R. Silva wrote:
> 
> 
> On 25/08/25 19:20, Jason Gunthorpe wrote:
> > On Wed, Aug 13, 2025 at 07:22:14PM +0900, Gustavo A. R. Silva wrote:
> > 
> > > @@ -1866,7 +1872,7 @@ static void cm_process_work(struct cm_id_private *cm_id_priv,
> > >   	int ret;
> > 
> > I think if you are going to do this restructing then these lower level
> > functions that never touch the path member should also have their
> > signatures updated to take in the cm_work_hdr not the cm_work struct
> > with the path, and we should never cast from a cm_work_hdr to a
> > cm_work.
> > 
> > Basically we should have more type clarity when the path touches are
> > to be sure the cm_timewait_info version never gets into there.
> > 
> > And to do that properly is going to need a preparing patch to untangle
> > cm_work_handler() a little bit, it shouldn't be the work function for
> > the cm_timewait_handler() which has a different ype.
> > 
> > Also did you look closely at which members needed to be in the hdr?
> > I think with the above it will turn out that some members can be moved
> > to cm_work..
> 
> I was wondering if we could just move cm_work at the very end of
> struct cm_timewait_info, like this:
> 
>  struct cm_timewait_info {
> -       struct cm_work work;
>         struct list_head list;
>         struct rb_node remote_qp_node;
>         struct rb_node remote_id_node;
> @@ -204,6 +203,7 @@ struct cm_timewait_info {
>         __be32 remote_qpn;
>         u8 inserted_remote_qp;
>         u8 inserted_remote_id;
> +       struct cm_work work;
>  };
> 
> and then I found this commit 09fb406a569b ("RDMA/cm: Add a note explaining
> how the timewait is eventually freed")

Yeah, it is a messy thing :\

Jason

