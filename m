Return-Path: <linux-rdma+bounces-375-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F8A80D476
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Dec 2023 18:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82E6C1F219E2
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Dec 2023 17:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1FF4EB35;
	Mon, 11 Dec 2023 17:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N4Sz1OLj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA75C3
	for <linux-rdma@vger.kernel.org>; Mon, 11 Dec 2023 09:50:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORtrjpYy+Fa6Rr8w+vAlgIRXlvCxtwAzK+OWzStMo+OjyBvYgeAJr4zPSRMq6f7gWSA70gCSujW2PBnNx0vSipR1iTbuZjURJ5/h/9n85dBaXUUvid9J5RQ8jQoZWbvzocGhDJyWfU8nUbpnyw4GN1OUogOjUantU4ZXcxq/pran1edYviGcH+GZQNE7S4vbr/c+vrWMWNpV996ktUJ226dPyffVfDqfMMXpuxkM1jAs5K9osZYvajaT8X9I9J87rUkSy9ATffzKtsvca9Wr2nnyctVbG3ZNRZyK5RNWSmuoMFSBnWouBQ5C5Lc85cT919Lx8+CbaTJ+VPHvTutu/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZExjXhgRt001j0tR4EuiQdSHtJLkoDyIRm6z6s2dog=;
 b=Xk8z3cT5Ow53NshWGK5T25uNteWc9HYw/jdVnLPbMGtHt0BrK/3aFPV9q9lUJj9vgnmHdplJ8SZYI2UVVPIvMPc5xyfmslCAJtotKd6/6EQIfscyJ/EfKaCqkIp/bUE0ZGYrmbNSmOSihHen+A46Xu55OahlLOE+jUB/A96V0sWoPCLzbwO4Tz0/6phE0YC5INq0L25kcC6PTeBSMD95e9yPgBDChnffDLVoLdGAvXOCJ9r37kge8kG23oMFnCVOqIUXFSQHNpMRdUJM96ZuBDvq+6PKT5fYN6QTGvDuxKwjdiHIF3BUXWNGNuj8nt+DPmIeyx3PKXm7OG25JU5Hmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZExjXhgRt001j0tR4EuiQdSHtJLkoDyIRm6z6s2dog=;
 b=N4Sz1OLjwTm+ATQs6Ba0Gefaz0gFZr99v2GWNxZ+caoOFnuH7sUTt/Tza8JaPWbFb3BuUoWf05y2sCNk3THQGzjZ7BEBG/B6fEYb2CAgxWyeT78HKO10BqYm9qLwHrBU87FGJi/PR5HwryzvZ2gAG3gciKff7zxz8mN1gialyXTa/JJ7OlP5Gbcc8VArbstG7ZqwvHSTshGFQiJYkqLxAeDg1Wdc6xzpJ6PRVg2qSgp9rOliIEay3c8c2gB5eCydX+17I4JLAomg2srIg9+boWc/61rmIm80mSN82z8riy1t9vLWOxopdoI89yrQqlNZEQYPmIsklYFgHdMEEAhT4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA0PR12MB4544.namprd12.prod.outlook.com (2603:10b6:806:70::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Mon, 11 Dec
 2023 17:50:20 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 17:50:20 +0000
Date: Mon, 11 Dec 2023 13:50:19 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Margolin <mrgolin@amazon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, sleybo@amazon.com,
	matua@amazon.com, gal.pressman@linux.dev,
	Anas Mousa <anasmous@amazon.com>, Firas Jahjah <firasj@amazon.com>
Subject: Re: [PATCH for-next v3] RDMA/efa: Add EFA query MR support
Message-ID: <20231211175019.GK2944114@nvidia.com>
References: <20231211174715.7369-1-mrgolin@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211174715.7369-1-mrgolin@amazon.com>
X-ClientProxiedBy: BL1PR13CA0369.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA0PR12MB4544:EE_
X-MS-Office365-Filtering-Correlation-Id: 22b0a752-6fbd-4ed6-1b31-08dbfa71a4a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Se5BIwKe9mWM23HdRieptYXSiprRrWYYUVHO5BiHMiKWqXmwYWy1sdWVhYuzwPMVD8GFurorJPEkfbEeSTc6gs4YC9EggKO7QxTYs/A0bjTwI5vqtOzAsJ/fptsKXNx6DugqOMFPDLMRAhk9g+n5xZfSqwBeKIyo/9d7oy3EmkILnnML1dYxnl3RLtZp+GKNmmHzxRKOqd9mqfpa67cyg36zL1WYJ/r37x7K7ko9OZTs8ybm0qlaFbKvoDCvWr0NebnzPd6/Ex/YCprndNoohJ4N4GapoF1Q0juTeWy7dMb/cH1HoHA+tj2ybI+F3OJASnawACSegaY230gHSCe7Sw4mrxvXNXz98Q/XQ5IzNMpvY1o4YF+Xj01/ZoeOjEZSBWwrbwfkmuoZGXNpfFL5tB97oj91DGH/vqlXDVN40czfDJzTir9wHLU1HYF7kBaZYPF8L4vFy1yNK5FJGYzxzTr+jqij8UmYLvlDCf2ESBPJ+3vHxP7iNSnU3Ur3wejnMEezxusRaiEF3Lwg7Scgqg4AndD//Y+x/84APAj3yAl8RRQCDpTaSeR08zg5wTZi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(38100700002)(86362001)(316002)(33656002)(66556008)(66476007)(41300700001)(26005)(83380400001)(2616005)(1076003)(6486002)(6512007)(6506007)(36756003)(2906002)(478600001)(66946007)(6916009)(54906003)(8936002)(4326008)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nx/OvM5oL6CcBOwayzaUzrAPzeL2t2nTxDCk0FlB4TTeshBj4+Z5sD8Jhc4A?=
 =?us-ascii?Q?OT5xiI4Z1oAI4MvJyp++ls602CgRl1ku/HuRl/Fybxja2WsuQHN0NepxP59m?=
 =?us-ascii?Q?66PjCAzN3caN2xOcA+kiKOQ9STXI5jFEBZ++dTV6zuI8nihru0hbcCMnpjpH?=
 =?us-ascii?Q?LcBFWRkz+ctN17rUYiloJQsbcFp2IK9grUYvv2dpEBM+XHvOhA+1qYhcoZmT?=
 =?us-ascii?Q?AexkQvVg0IclMXvIzD42lOyn/ThYjF01q1lpZTPe8Y4Y0M6Q92P7gUpE4iYq?=
 =?us-ascii?Q?Grg72QH9gulPgA+XMjI3m7tblgajPLK1lbM3QVTom2h8c2uW0+SSfnBla3tA?=
 =?us-ascii?Q?hDckGy7SrPIMAkg8YIwxZgPZz9KeOhGMWx6MdZnyRAKc07a/yqOnwhSqhssw?=
 =?us-ascii?Q?rV1hUIkW7KAmNH75dVWT2KxVHyYRcBPGLnL0pkiRI/D95dtjrB0GD9bjo/3c?=
 =?us-ascii?Q?d/8SXCeSO1UoT5vrrZuWXAK4Ui6uR/ELJFjm4eNFUVnYht/nJkz4aG6YlYMb?=
 =?us-ascii?Q?rYkvNuqHFVLOhBqIvjn5LVTRHs6fmmaW5AA92A1b/OS20U1zIrtrI2fOlAd4?=
 =?us-ascii?Q?C6Typib/HzrzaAaQxqgoVO30LkKNE04Z7a6OYNEEkh+L8PFUMEYqxVK+Kr7M?=
 =?us-ascii?Q?ZPHi98qck5fyKj7fn+4BrKr3XXRrA75pcAQ3H8zWxfA6SyITr+6H1MrJwtP1?=
 =?us-ascii?Q?aUZxPAYUa/id5prd62rDtsRwecbnIMvc4W4bClIQeg73FprX/+/yDPerK+oo?=
 =?us-ascii?Q?3yWZ8CnZcRcymfw6n+KeSkzl1lxCluj+ji/5tYEErHhZACrnCxwo+F7UP7c8?=
 =?us-ascii?Q?ZLFlifhQO7p7UpAfQmy8nV4XF7NLsHJLykygRFz/7mxoQKa2ahAhVS2tyxI/?=
 =?us-ascii?Q?HpBuXgQ+ECCo2b74jDQ5rtsQdCckEtLlrnzQonx50LsbpFmZna8vkqcFHz0P?=
 =?us-ascii?Q?qO0FQSk0m/rrTEHRUVv2W0w2vDQss36rv+kqN3VZrm4+i6DMSXrGplMx0M7+?=
 =?us-ascii?Q?GpOqS1Hej/ujJviHOpihOrvBcKn7onTrybxyQK6wOOnByLyKPZ9KmH6f7LZQ?=
 =?us-ascii?Q?/owbrqzSy+mnkCqSreuAUdjkv/eC+wT2Uf6voDaRP9mA42wQvD+B+yVoULeW?=
 =?us-ascii?Q?zFuInZE1VhII/Dc8d3y1MykmIzaral7CrLCObd3AStRq2GnYFwgpTf82BQ4M?=
 =?us-ascii?Q?loKu4zg0SZA7S98WCPMM9f2aFqgltcNF/if9vF9NgkZ690EyRnWRAZKRzxdp?=
 =?us-ascii?Q?FejiaZnKGju8ocB42A41wE2QeiPfND9BZO3hod75ZHyClw8Ih6MgVqMtX2eh?=
 =?us-ascii?Q?/DxgH+9GRKcBvG9q5jLbl43e2nDZaGUmZF0AeqPAo/xVHVJQAj/DhH+IFdfJ?=
 =?us-ascii?Q?hhWfXGcszKLwgv14BqYEtNi56UIVurQgCZFZ63lOFHHa458fL77FCsgirQHW?=
 =?us-ascii?Q?N/XMThWL3iQCzfgVzzBHbYSocdp2tgahS0k3/DpQoF4dAdSe5KQSaYMSSMmE?=
 =?us-ascii?Q?GnZFiI/obq18qAI/9o+Sj2zX+orOE0ocrkzqqijlqoej9L+u7iE5r2b0qV17?=
 =?us-ascii?Q?oCjUDmAWxBohpadywHfYkOlqPf0PXwq6vDT6TIN3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22b0a752-6fbd-4ed6-1b31-08dbfa71a4a9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 17:50:20.5062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IgCQ8sb1zAZGa27DB0/lDVjxBA0IwWmoSa1eAAVCr+CXdx2e8XTlk9Pf6rZ9TY1Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4544

On Mon, Dec 11, 2023 at 05:47:15PM +0000, Michael Margolin wrote:
> diff --git a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
> index 9c65bd27bae0..597f7ca6f31d 100644
> --- a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
> +++ b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
> @@ -415,6 +415,32 @@ struct efa_admin_reg_mr_resp {
>  	 * memory region
>  	 */
>  	u32 r_key;
> +
> +	/*
> +	 * Mask indicating which fields have valid values
> +	 * 0 : recv_pci_bus_id
> +	 * 1 : rdma_read_pci_bus_id
> +	 * 2 : rdma_recv_pci_bus_id
> +	 */
> +	u8 validity;
> +
> +	/*
> +	 * Physical PCIe bus used by the device to reach the MR for receive
> +	 * operation
> +	 */
> +	u8 recv_pci_bus_id;
> +
> +	/*
> +	 * Physical PCIe bus used by the device to reach the MR for RDMA read
> +	 * operation
> +	 */
> +	u8 rdma_read_pci_bus_id;
> +
> +	/*
> +	 * Physical PCIe bus used by the device to reach the MR for RDMA write
> +	 * receive
> +	 */
> +	u8 rdma_recv_pci_bus_id;

What driver is bound to this other PCIe bus and how did the iommu get
setup for it?

Jason

