Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9BDA3686EE
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Apr 2021 21:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbhDVTIx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Apr 2021 15:08:53 -0400
Received: from mail-mw2nam10on2051.outbound.protection.outlook.com ([40.107.94.51]:20065
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236058AbhDVTIw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 22 Apr 2021 15:08:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aCP0EnlR1FfBLWh1rJ0WtPaUPRklo/T9d7xertqSGAWCDmtqzvOkbzz4fZS09maIrhYqMkmhjFMrcfGR/5TpK10fHfncrIvcusFuLRTz/0ULlYkH3M6GGoIXTrq/UVnTm1VNnO9LyPUyXPuD6fi6LB4XSiAGgrQFS1ryUrbPVcUoQYAsmYeEfddzxyNyJ4Lq6yf84q2foH7bKh58xvbWS7ft4m4sjPltZhWPkzCcOoC+Mu3oIoKRdoSxTjvaLpDemJAQzmhQy5oPBKTe7P5kZLc8iE6zXodZNZyubmI/MWZ1Kr1i6Evw785yWQ/iYqf4aqlmdBP3YzB+9/nK9hvYYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcnmuuFctr1X6/McU3FbfG3RDX17X3HCEWnzbcXC6BY=;
 b=eDWiSGn9gsZVjyn0/xoJ4nbICWLsZTbmyh27oGtg47GfkV+6xydrCosav8ut7+HKbUSNYi3+OAJ7khxScsEFXJB3bhoWGVJQ4rgH84Z2loE/MeTuTPvIYmIwGOd8q+tZH0fqcpfCPM8Y8j+8msfogV0rLuFYKgZKGlPW+EpQrsuz8HIDWNKcQ7h1pJ3/hHPcQk7zSSmuqhXw83Dzcag8WIS/rTkB+7Shx2dK8fJ8jx5v/F9pP9bnGCcsnDHjvZo/qb1NDn+2523oaPbG9iTmUAKjj61F1BfoMHfEd1+gHelyWLBzb8uN2/7D3e6QkI8vVbekgYvZdxIh6XX/Q7lOvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcnmuuFctr1X6/McU3FbfG3RDX17X3HCEWnzbcXC6BY=;
 b=GlQvtdRs1mIXC3Uba21pIfSV1suFsGD675q97Nu2tTNqOlnSNkYWhz/jFErizJMVnS8sTU5HK3XlNjJwudq1xTM0QmjG2OsZKpF9eE1UYBODILsZYSqhCBpxenh+wH6zeT94OidSAGClEJGsHsLjbmoFWR7D73JXhgd+VRIF7D41SoErBzJRBdM9RYMDiWcDrFtj78iODQge296s6fMk8UlTCgdAoLesUjpuFK0zQLTorgwG7iWvcANuBszMIV0V/whyQKRlf6d8rn9zJJmeG66TzplepGVA62QEEs79DZGY0FGFSPv8+wv20xhiWENXUnUMzHeJ0iCU9241+EAemA==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2858.namprd12.prod.outlook.com (2603:10b6:5:182::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 22 Apr
 2021 19:08:15 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4065.023; Thu, 22 Apr 2021
 19:08:15 +0000
Date:   Thu, 22 Apr 2021 16:08:14 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Mark Zhang <markzhang@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v2 8/9] IB/cm: Add lock protection when access
 av/alt_av's port of a cm_id
Message-ID: <20210422190814.GA2451164@nvidia.com>
References: <cover.1619004798.git.leonro@nvidia.com>
 <a50fca26e37799491778e5efbf6b6ef21f1c3fbe.1619004798.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a50fca26e37799491778e5efbf6b6ef21f1c3fbe.1619004798.git.leonro@nvidia.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0189.namprd13.prod.outlook.com
 (2603:10b6:208:2be::14) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0189.namprd13.prod.outlook.com (2603:10b6:208:2be::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.16 via Frontend Transport; Thu, 22 Apr 2021 19:08:15 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lZegQ-00AHgR-7v; Thu, 22 Apr 2021 16:08:14 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c6a6062-11da-4639-97fc-08d905c1fb71
X-MS-TrafficTypeDiagnostic: DM6PR12MB2858:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2858C8D55AC429DD8131C2F6C2469@DM6PR12MB2858.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:22;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Ovbul2CPVRro2d3UXY6oDxhBmlvY3IQD/1l/9jSfVV44xBPD6UrTK2Vj548LgQ0quMbVN7s7xSYyLhldvtfs0TNeAYbXcXhfD0hG4/gkc2lEfWUFhlFWTx7FjdmmHhykQzb7JzwQGu4uZXz6ythri0n32fS0HEdwBDW/AFUOospVUKPDDxvANb1vcuBhc+yX/3v86SxyWBc/4g+yy5XN2/hrFWlZsHWSAQ6hJjM+107qIuRv8sD+qpjeLb17JTT1f464KkY1wER50gMYJDShUiY7bpEWUp+6vCOY1j8s8ifyISjaTVG6IRcePfiq8f4z/Gy8iOzm4GvGiLF0+pHPQAmW+u3eAlBQZmJBMIRocxrbX80jnU3sIPuV67bTZm3KwbD/Dwv3y0PxyVO50dN232XghJDq4jlvGyqgDtXZmF8IoeNYofVhTVTBka5NtdlnItRxEt/MfHwUJMNdTVoIYBP0u511SbguEFNneyqBwXwrSMcY2NuZYzidwxaWA4CRLxxnGHPQJJRUGsLLFAXoJyzctcrXSrDRbhHrApFLTZhN5HZWdSsV8mChmZuU+M1krvJ+Zz6Ko6hX0SLiwenG0q4cI+gnPBjftMRmUtpqXo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(498600001)(8676002)(36756003)(4326008)(66556008)(5660300002)(66946007)(426003)(8936002)(54906003)(2906002)(2616005)(186003)(38100700002)(26005)(9746002)(83380400001)(6916009)(33656002)(9786002)(1076003)(86362001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?TuAZKFY5BushoKRVYdcooXZ4GEje9Wt65XhhPtTda6PCxcFsueotPKOm0aTm?=
 =?us-ascii?Q?mWn/EHMb+zxfAElFV3s85P68Vvb4e5u8vOzhEJzbV1pspA2qYtdpkuPX11r2?=
 =?us-ascii?Q?efV6X9vkaPddrPD2Xen7YdRiN5Qhgb0NcO8jLl8PD3LcOWX2dyNeLgJ0p638?=
 =?us-ascii?Q?KWwZycnSczBn5rC9grKBFip/iaMjhSksK+hT2WMCb25/gIEsoCh+CYXG5asH?=
 =?us-ascii?Q?wtuLruzIzq3COzF0s1dS1yraC44WTIwm8dSaO6Sfyd2DupkNMrJj8b7eRkUX?=
 =?us-ascii?Q?W8WAXjYSERFPj/BS+nwFVwQ5PzfNxZ4NXUN3UYc0/C/DmaS4l413IQJhiGyE?=
 =?us-ascii?Q?ef2wfiGUvGesk3nghQOFrIY24S1pa55+FI7YGu05C27SqNZMbWD07bKJnACH?=
 =?us-ascii?Q?yCeKt/iQgHF00cytIM+7kJxsgThdHEqtw3G8d3LZn3bqNqHJ/R4VTS5NsdKc?=
 =?us-ascii?Q?saRSoGs6M1vVEfFfSpVAss4H1NI7uXTrHpOb0XLGo/mhb3Y9K1m0nUgJ8LON?=
 =?us-ascii?Q?GxA0ilrhMgFNYlUBu70xWcnsy/c/N+pguMGwecsI8UzUfoOOebVUCsKjdbPj?=
 =?us-ascii?Q?mUEPTr3VdZlhB8Y04YwkR7+QPAhzbCUIjFf9S6zls5yKAs50sO5CKPZSNTlH?=
 =?us-ascii?Q?3K3mpbB/SnqH3Zzawg4yRvScSR+3Fb/dK2BvhyQM6dgcCKU2HHvlpJ9TeOi7?=
 =?us-ascii?Q?SbzQNuP6dNYQKCyKas7QqhwIKXM35hCKtuJFfXCrrT49KXVZwWqQWZAq3HyC?=
 =?us-ascii?Q?tUk84KMVtfDZeaSb3HEz7lNqyfwnoSQpOm6eYxWIfSBLte03Fr0kiGeQcrsW?=
 =?us-ascii?Q?h+o7x/C6hFNHkF6VZU9jsCJmtnN21hMmHNcYQi7EvG06P/GUFmiDFe/R8KUZ?=
 =?us-ascii?Q?bWtO2xz8eB8qZL2d5ptZYH7jSeReolRUENVHVwicUXnZUM4y5u3jWzohxsK8?=
 =?us-ascii?Q?a3NGkEQkyovIy3dkLrhcUdTXx08G8/xHAQ9DPQ5XLp8Gi7HQjf8a6aLBe5UW?=
 =?us-ascii?Q?4YTy+/WXVBbAcuTpGM//ou4bENqNwHF/EOg1PoRZl4RiTqlXEvSiGHBw+v6U?=
 =?us-ascii?Q?GYZD5myPyvQ7g/dCRPrWcFwPpBLNBSQ8IgMeQmU6A1nnS9ESk8+SyIggIwZQ?=
 =?us-ascii?Q?4Z0hZF75Mbaguuvm1USokKtMDRwiOlPWLw1g7FdrCmcwq9lFpWP7iuYEe3uJ?=
 =?us-ascii?Q?oej+ZYXwfucM3b/FQWGJfolrjMSatZBEeuFcdY7tZl4BcuDJsk4hnLJt7JoH?=
 =?us-ascii?Q?xM6pFdSyqA4SxZEKKHX9VAH9gKf4i40QV4Pz7GOF/qe9zkbv5eOeL4XCC1vr?=
 =?us-ascii?Q?EFPLRpyagVIIJ4P/oQHDicR6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c6a6062-11da-4639-97fc-08d905c1fb71
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 19:08:15.6697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5VO4TtKw8RZl27umU8n1cE8aOKyIQ3q3pvtoMPEfwAZ+U96uCNAInoP8UAW+a50+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2858
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Apr 21, 2021 at 02:40:38PM +0300, Leon Romanovsky wrote:
> @@ -303,20 +304,37 @@ static struct ib_mad_send_buf *cm_alloc_msg(struct cm_id_private *cm_id_priv)
>  	struct ib_mad_agent *mad_agent;
>  	struct ib_mad_send_buf *m;
>  	struct ib_ah *ah;
> +	int ret;
> +
> +	read_lock(&cm_id_priv->av_rwlock);
> +	if (!cm_id_priv->av.port) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
>  
>  	mad_agent = cm_id_priv->av.port->mad_agent;
> +	if (!mad_agent) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
>  	ah = rdma_create_ah(mad_agent->qp->pd, &cm_id_priv->av.ah_attr, 0);
> -	if (IS_ERR(ah))
> -		return (void *)ah;
> +	if (IS_ERR(ah)) {
> +		ret = PTR_ERR(ah);
> +		goto out;
> +	}
>  
>  	m = ib_create_send_mad(mad_agent, cm_id_priv->id.remote_cm_qpn,
>  			       cm_id_priv->av.pkey_index,
>  			       0, IB_MGMT_MAD_HDR, IB_MGMT_MAD_DATA,
>  			       GFP_ATOMIC,
>  			       IB_MGMT_BASE_VERSION);
> +
> +	read_unlock(&cm_id_priv->av_rwlock);
>  	if (IS_ERR(m)) {
>  		rdma_destroy_ah(ah, 0);
> -		return m;
> +		ret = PTR_ERR(m);
> +		goto out;
>  	}
>  
>  	/* Timeout set by caller if response is expected. */
> @@ -326,6 +344,10 @@ static struct ib_mad_send_buf *cm_alloc_msg(struct cm_id_private *cm_id_priv)
>  	refcount_inc(&cm_id_priv->refcount);
>  	m->context[0] = cm_id_priv;
>  	return m;
> +
> +out:
> +	read_unlock(&cm_id_priv->av_rwlock);

This flow has read_unlock happening twice on error

Jason
