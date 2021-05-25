Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307303902AD
	for <lists+linux-rdma@lfdr.de>; Tue, 25 May 2021 15:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbhEYNo1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 May 2021 09:44:27 -0400
Received: from mail-dm6nam12on2083.outbound.protection.outlook.com ([40.107.243.83]:49280
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233339AbhEYNo0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 May 2021 09:44:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OnHCrAhqMoC9qZgGlwTWE6XDcfyoNleEHe8oSfiJu+ouFUAGsVbc/ckp5hGoOr/G70CwjAdIjx68RsiGeaxczncW7UEBmZKS2QXRtgrhXx4Uk/NEDpV3g5UNOBlI5ZMboijgq5gh2lnpXGnWe3eX83iGpCozAbKoYW/YthTRaIJUJ/dTquXFHkpSat9jTGXOVu4DH+8SQvwXhQT3p/RDz9oecCERuOzVEZuBqEDaz/Jp6DZZB9O3JKiwl4isJvmNW0fB+nqaYbW9DyIX44JPC1B6StzKdZTkXoZCMX8IXyhy70p2pkdzfMf9lyef8c4KuuLVHT4NXTSfDCLkhFeKPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rshl823e/So1izvsYHeNGrjDdege7JT1PJPzUY0Hc/U=;
 b=Ha2nT91rhj1xQIUc2bRvwNyW5kcu5Qe/VRshATfmlOczJMAJCp1+rI0dGMVLBUGgK8UOZGeMzdbioau9ACDdLCz5UgjsJhdzLVq+g4A3E1bX/CFLUISPKsrSx0czP1TiN/Yzjtmmm7TZTd+N+ZOKM66O8fd1Atc26I4hPCIRZb6npRhy/eZOcbWBmEDVWugV3nTgR61Nzjs2WyxgUqyEczf6D0Ch6HtXLygD/HJMXFsXxOmwRjoPzOvji/wR370QouRP2UxcXwARMr7GSwhWr8g6SjMG9yGnSzGD8igrldCRQErlt9OXSswaua4t9/R060FIjMrAnYuzm4gw6hvWLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rshl823e/So1izvsYHeNGrjDdege7JT1PJPzUY0Hc/U=;
 b=MDESA4vD0jzxFJIGXGV5xHy+MRaBT6rfvosAyP96PeXdHQrSdICl2mewmtJzsha8LtEvRtZqEtlBHhAhCCN4pv9UBMT4HCnOO3H1gQeQirHCzzYchlwaiC0Ktw0VnadlLWdJ/2Euebi7KVKLDsRvx6GxQn3Vf9rLCU8rVjdEbzI/RQLOU1tSconf9f96Os4YkSuI5BNNaHZ6SRcD7I+NN1ddn4SbYnKZWsW355A+aIPqkN5W8ZXMs+5qDcYytVmPBWpl4LTq8DAC71OrP7Hmut2IiIYmLiwtjuHNJhnUxxaobil/oj2WG3XPhvF0Y+K3Vx9m/1cZ5vPRH4LLiiuzNw==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5223.namprd12.prod.outlook.com (2603:10b6:208:315::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.25; Tue, 25 May
 2021 13:42:55 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4173.020; Tue, 25 May 2021
 13:42:55 +0000
Date:   Tue, 25 May 2021 10:42:53 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>,
        Shay Drory <shayd@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH rdma-rc 4/5] RDMA/core: Simplify addition of restrack
 object
Message-ID: <20210525134253.GA3388071@nvidia.com>
References: <cover.1620711734.git.leonro@nvidia.com>
 <36cde3a62adc5d6aeb895456574c988cff7e42ac.1620711734.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36cde3a62adc5d6aeb895456574c988cff7e42ac.1620711734.git.leonro@nvidia.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: CH2PR02CA0025.namprd02.prod.outlook.com
 (2603:10b6:610:4e::35) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH2PR02CA0025.namprd02.prod.outlook.com (2603:10b6:610:4e::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.24 via Frontend Transport; Tue, 25 May 2021 13:42:55 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1llXKf-00EFDm-2f; Tue, 25 May 2021 10:42:53 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c6e5b1e-91b4-4766-38b6-08d91f82fffa
X-MS-TrafficTypeDiagnostic: BL1PR12MB5223:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB522396C4B2FC139955568FFAC2259@BL1PR12MB5223.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 638PPdReEGfL/euqwp1yEpPMhuF6XkKT/TGkQmFlGtL7txLCZTlclsnsgI4NBUZhmILJOi3q5qWbjNR8OfBhZSfxOp7RhcCyLEUpgKipp5rX7syjKP/otWlypSifbBWhtkQsYAPavY0RbhHDJxslQTE7DIDbE04jKvL6nz5sfPA18YyiBkXaSrYZb+fL0NqH7atQCRxL7aW8piO7G+vsbBl7B1yZ0QO8VNwXb4zlEWKJnmruownJsqFNmf2Lp4XwFgQfYGnGHp3+4Z0eWumOkVUzUvzgV/4B9Qxi2I3HtCb5MLf7stXCtu+6GEhPVauXF5Vnl75YjyFE+k0SgojxiVhpSRR1u55VpHkdKsf8xV8uLckXdSYgp1UsHEQemLJWiUn3tOMtmUGyjHo/H6lvcNQwUbOOmDxDv4evK1FqHE9nd2vBR7zTWlS11pmyyNafLGIny4cPNAvpdnm0w8+U7zJrVALAr2SSnuomFxyn018wn6kpGFiCKwtsvTi2PKblBk8wjGe0f6ZCCCZ30Jo2dkvFwXaSyC9d7Yve7klJYuQUl/3s4dz1hg2GgrfHLVpiq2NK6lU77wdfz5fqInyZM07acDtgXM6vW01sTd8zjCo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(426003)(4326008)(316002)(186003)(2616005)(38100700002)(54906003)(478600001)(83380400001)(8676002)(5660300002)(8936002)(86362001)(4744005)(66946007)(26005)(1076003)(33656002)(9746002)(36756003)(66556008)(2906002)(9786002)(6916009)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Zj7mpYlwP/+iIlQWYpBxdT8qBDRy8Djz+kB1+eWYwem65PcW9QPAnNmfMm5i?=
 =?us-ascii?Q?DdEPK8XuAbgMOczO3iNUK69f44HcT0iFnZc4W0Uew+E3CBFE9DQaQ/11YCdb?=
 =?us-ascii?Q?eVFO2T3tEz2gNebSEcJf0/wNcTuw8oqZW7vmHXl1u18OEZr5yZw9knJZ5D89?=
 =?us-ascii?Q?k00NcIhXBptV7/J3/WF9CS7KgQnpSX2lDm17TAmWtbSd5w8qw8TAQJR3t81O?=
 =?us-ascii?Q?IMTEH4xiJAN/PCaNTkJxczUuNCzjZRD/Gep7uN8XeWH2dyRFn9yKNGtL9KBR?=
 =?us-ascii?Q?l9zYAwmLNQYrBucJccF1dIIl2kROq1nIutJoeszFXWQz39vKORFhBWO8Cjx+?=
 =?us-ascii?Q?XskMHY852MdB7G5ZnAmMbU+FWcOxZKmvqz40gSKfRzB9Lkrknn1t0YiFF4KT?=
 =?us-ascii?Q?PrmhZxewWfeHIqIJikxPrr7knKNFEcV1TJlipifcxz4DGIpf8IcEMJXswdjM?=
 =?us-ascii?Q?6t1vbPUijBWwsfFKGtGisYAxMfXlE3rBAJDa+nZ0yokAtA9Ytv1xjeVHw78R?=
 =?us-ascii?Q?x2o4qNAi6vrHDJloCcYGkctYsykRV/uYyulPckfK8kLjOdRz2+73s/lZHd/i?=
 =?us-ascii?Q?lZhntzhKQEKxKOWbmmWwImEGXkiSTO9qQo96foBvyvL19RfrGbdRYFYAX3Sp?=
 =?us-ascii?Q?bl+XERy7gSf13whNxfKL4N3lBWxG8kwfOgpAdnkmPv2CjRabFbQcV/gKB73R?=
 =?us-ascii?Q?0+eKv8C64hE1wTutC89g2ErNFuCcVfatdJ/8pQt7UzTXtWRpE98pT3ScZ5+5?=
 =?us-ascii?Q?VlwLCpKrSDcXyRIgbyTNGIjUByL9EO0N8fEhQyIXIqVKSNmaC+FSzQw72tC3?=
 =?us-ascii?Q?q25I9srZ63506536lml7gv+uBCFnrD7IGrc8o3w4E5ryYnXga5zEc7Kfy357?=
 =?us-ascii?Q?n0A7GGR2UP0YCh/Mcg50iTVAFXq7yRxfFi4tXUty80QU/ilFIkaIQuZd1fIY?=
 =?us-ascii?Q?lA56kH8u5UU+rZOJ9iRSfDMBgGCyuNTR4Tqr1a8t4Og4SeIdijvxTSdMdqH6?=
 =?us-ascii?Q?QRQwVqEoRNL4OpGYya5nxC6QeVfIl+jfJrEjlhydg4InD+5jmrHTt3Zn7Cea?=
 =?us-ascii?Q?4FENJXZ0yHvJm2+jTlMt5K80uRexlhTP1e/f117TjujtZASCNNvbjWYvDPIj?=
 =?us-ascii?Q?Qm3zWeeYEu7krAi+3eK2nxxNhm60FOGvybtIu9av1b/jnvvaLuwLAACpvt6W?=
 =?us-ascii?Q?oIr6Cbw5DQGYEUhYH1kvITc84amnyOJaQ6100lJONqIeIy8pjaepl7fCx4By?=
 =?us-ascii?Q?qVCz3nPI9Y990YQJZD2779lZ2BU6iQEkplaruT4zw+nrFO4zcRm6tpI3Qaly?=
 =?us-ascii?Q?6ovokqHIlM1DT7/ynXt3973t?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c6e5b1e-91b4-4766-38b6-08d91f82fffa
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 13:42:55.1439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kSfD8N567SvgyHvPkfAnSpwEIbeGxupRUM4Fnm2aRUs9OwGZ0mYVZCwTVA8iP1eu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5223
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 11, 2021 at 08:48:30AM +0300, Leon Romanovsky wrote:

> @@ -3853,12 +3848,12 @@ int rdma_bind_addr(struct rdma_cm_id *id, struct sockaddr *addr)
>  	if (ret)
>  		goto err2;
>  
> -	if (!cma_any_addr(addr))
> -		rdma_restrack_add(&id_priv->res);
>  	return 0;
>  err2:
>  	if (id_priv->cma_dev)
>  		cma_release_dev(id_priv);
> +	if (!cma_any_addr(addr))
> +		rdma_restrack_del(&id_priv->res);

But this whole thing is reverting an earlier patch - the whole point
was to avoid the restrack_del().

Plus this is out of order the del has to be before the release, due to
the other recent patch.

Jason
