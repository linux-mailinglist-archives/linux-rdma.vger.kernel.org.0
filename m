Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334C33AF9C2
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 01:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbhFUXvc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 19:51:32 -0400
Received: from mail-mw2nam10on2063.outbound.protection.outlook.com ([40.107.94.63]:45665
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231707AbhFUXvb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Jun 2021 19:51:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nm8lOwvdH6y7G11fJ4tvONZ6uPKa7lslUmnHk6IjCjcr7ZT11s4GR4lkLWS7r7E+wJ83AN6Pl+ejwQ5hiWCQWf1gHLJD9uCzuk4ygOtRq+WXYbqtxmb2mlIV6xX3N7Y5SlhEXebo08+MsMYE8f/Vf8PQLl+UH1FKR5NjY0FML8HS/uu3/YZxNi08TU5Xt30a1+d9qvK7nOPc9R2PxErrZAHi5tczSBXsIDAuA14o2kQ4IUhq+SNKDVENfTyLzlotp0uodwlWmNst3baDlGOUQsM7A7jax52sfy8uemR4IHsLWBNnBQINzKQ/KD89Wv667SWAzvGCL6KaC6iPp6glbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEKjMBkbERby8XUrjNK2t2B1bciC+XNCintcA/tC+Ns=;
 b=gKvftRo/xRCOv/vPlLYSGapuBnDcH8x/TIuUWSLpY4+w4ljZhLXpoh9bOchR5GO6B0ZK/TTD9p6xPT6Rn4t4vbludGby0acO91wwGEAEZN3s/dXCeAlxZqNrmdQzGh+fCL6HexegQi6Cpc3RIxXcdpTVOZ3yUERsKHFGB/AQLHOSqsODlzNr68geAzxwt4BfCfQIoAkK5QoUTj3fhXKpqWTMVGeYDACAY6L7Ypxup54kb8m9ykkYOi5ff+um/YxATCS0JkQv1VTtqoKYU1L+MHewz9c6008n0jRArx4+xSb6VOxfLe5XgwlKHUJLajZwRKIJXTy433HxKRkkcAFBsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEKjMBkbERby8XUrjNK2t2B1bciC+XNCintcA/tC+Ns=;
 b=GQXzYAQOBBjCq0miCVYeUt1br4RujViupVdUxdxsEVzjUfrhiY4591octSWOWOhWPVnCh5ukML4H3GZfU8Fva8lkSVvi8TAp+mkLHa83+ehrR4Hlr4LIF4TbBq0FLT8C8WZeJWy+o2cGivBDTVb7yXTy0Yr+dG8yAGg1lzoY4gDdbUup6b10trornhIyFGQ86+MrPhpuh2TxJ17zK9LQM95fKof96iY4oi38MZZ0tiUiRYnfKPCfy4y0/OSTbMSRipkGTJCpiNLhuLjQQsqdL5KRm2Y9k9xa3i5VWtsJQMHzAMxTnJJPvK5rqZjQkipPBhnzAcxhljv595tM8T7TAw==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5095.namprd12.prod.outlook.com (2603:10b6:208:31b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Mon, 21 Jun
 2021 23:49:15 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 23:49:15 +0000
Date:   Mon, 21 Jun 2021 20:49:13 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Anand Khoje <anand.a.khoje@oracle.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        dledford@redhat.com, haakon.bugge@oracle.com, leon@kernel.org
Subject: Re: [PATCH v5 for-next 3/3] IB/core: Obtain subnet_prefix from cache
 in IB devices
Message-ID: <20210621234913.GA2364052@nvidia.com>
References: <20210616154509.1047-1-anand.a.khoje@oracle.com>
 <20210616154509.1047-4-anand.a.khoje@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616154509.1047-4-anand.a.khoje@oracle.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR1501CA0007.namprd15.prod.outlook.com
 (2603:10b6:207:17::20) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR1501CA0007.namprd15.prod.outlook.com (2603:10b6:207:17::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend Transport; Mon, 21 Jun 2021 23:49:14 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lvTfF-009vB4-Vj; Mon, 21 Jun 2021 20:49:13 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfea36e1-1b00-44ce-eefd-08d9350f2d34
X-MS-TrafficTypeDiagnostic: BL1PR12MB5095:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5095EC9D621FA0FEFAE623A7C20A9@BL1PR12MB5095.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KS1QgqKLJVr0pFppHo0wl0M/Mw7Ym8pjVwHTVpjFRKyFcOUZueMLvSJRNiSOA2Iu0Mq5ypmK+gkNsOHouQGSPZGpZBFEve97dbbFdbhmY1ztwJDIr2XIx+wAjZ9adcRPXULP7zzMtcIky+uPVa05GG4H4aEj4PKY9Oy23rSogl0QsiVQGjoZzleAIqSQq8RjNmnIaaTZ68WeCyUaVSky1RJjl9cNYiJVWUQVS+7uSzYHm1x/xuxE9g/scZOgJ+1vKYDCNQQWwK2Iu8nTxOgwkPnYTYo44TQWOuUaw7G5/28kzY7fFRO/+NILVquR9JsWhzHmKIazHfSZ6gRNDbwJmzbCYXVSOt7h44hjp4hc2Ch+tSgNdrGzubmN7T8tjlFd/Vx1gTuIwuZApDki+aef/GVjXZZWan0xSWWf75esBPDCDKv7WwnERSeUqR+nJtymuTUERSUKGaL5b802elYI8ZYx7DgIOUb9vtkQj8J5E0iAe6gKxU+w4UVkdQHUsm5zDqL30u1mQUQQoLR6STGEOvrYm+K1qYjHwErtRfyPYpzY9lvhplDIFynIYNwrEBOwFEsF/lXbjPmmpNWscjxot9lM+kRpOz9+DHC8Tx8Bh9w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(33656002)(66476007)(478600001)(36756003)(9786002)(9746002)(86362001)(83380400001)(5660300002)(8936002)(38100700002)(66946007)(426003)(186003)(4744005)(2906002)(1076003)(26005)(8676002)(6916009)(316002)(4326008)(2616005)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ralf404JCuk4m0t2np2oOk9ele8nPVNobaBXAoCJbcrGjvzUCK9I6msnIxvU?=
 =?us-ascii?Q?53uTMhxAcWyjN9XD1fJbrA7jk28tUPDJeurlcGi6C/tzcXYnpSjqUaJs8W8w?=
 =?us-ascii?Q?NRnjZSx9/Wzt8bEpbcfAQJ9X6GAmaXpqWlUHSKfgVbQ/Y5va1R3iD9Ps0D3l?=
 =?us-ascii?Q?eMMb8MtVA15mupTCHAo4v/JXzKa1NPGpUUxYlHOyBlo3xUXUab2YyAPIIBaq?=
 =?us-ascii?Q?Zhu9Jqrw4efxeZ9SkJdqnw1qE1a8t3Y54hjeUumu+ITppFHFEyMd+vIl2iqR?=
 =?us-ascii?Q?iuq5obuMURHjZVrXo5TyzWSIn9Yfi/WP6jkdzpaWc/Sop419nOEoBf/67moA?=
 =?us-ascii?Q?lP8SyadknvGD+4uy+aUlldBDQb4k6V8bsA0XOU7s6rwOaIbYX0cB9+55yFx6?=
 =?us-ascii?Q?4hqaokMS0kNgYHhsYqG2CPL0b09RggHXbyB6oN7UIf/0xxBKjK3URXBthIvb?=
 =?us-ascii?Q?y9zRHTp5+DZeR2ekCczoQ4YhMq8dsmz+idxCjvBHz7i5K6dkGau4NpKZwiJe?=
 =?us-ascii?Q?dhzss4ZtM/byk2N2Cdc9H2P3Iv8PlibdLhsOcG4yr1cQzLyFgINiWqwDiYZc?=
 =?us-ascii?Q?ashgtGftfpeRj5f/PIeq7oQd0HzPmzzGXyzCDatZwxrRcfjZQX5eHRS8pa0O?=
 =?us-ascii?Q?TSlmI7j3Avp76XsLgsRh5JeTFzUh39gztk5gG0DoFE60fKNxHpxz3c7H5Ql1?=
 =?us-ascii?Q?x4MYYNX4Nnv4bOOzlVEtAwgVky/5XtUymAc2pqiAeR0J4RwjBu5Nxq00T+IC?=
 =?us-ascii?Q?GccPTcgE8ggvnIi1nGbvdsmkvUbf/T9+eMAQcyh4Mbtf5+V8sjjLBRodFuE3?=
 =?us-ascii?Q?YD6DvbXT+bTsPozOQT8/K+hLTtG0DCf5dmfUvf+j0Izwa5tu1yZxGb+VGlit?=
 =?us-ascii?Q?Y4k9rMVz7QpyOBZ1m3/klipCFeVxdMSoXazvFKJYeCY4fQs0nFHiavY4Iind?=
 =?us-ascii?Q?pIJ3bsmKPNnCvgjv10iyL50K5YWkzpAfPB/r8FsTOuc6MSfDkmpKRPX9397y?=
 =?us-ascii?Q?ZFvmXYfYi4WZWrpx6EXiBV045k1F1sU7dLkWZifX49Bpu8H6474VhOqrTvx+?=
 =?us-ascii?Q?nU9m9v0ySmpUsIeC3P6dWCaW9aIABNnM0LIiiSwDZ0hLt9Y8jXfhyPbbL8ck?=
 =?us-ascii?Q?RF64G7BrilI5HKjqmw9kl5q6ce9IMYN0w7LHJt6KOfyuizfl39E9447aK3MF?=
 =?us-ascii?Q?7N4rfeP2Qi637jnLGKlQsdcoFDVv/UNxR69uohfRO7qwvzwX4f1Hzrn5OBWQ?=
 =?us-ascii?Q?trJW6BL04sAIN5pDHR/aXU+nweV6mjrE1xwyLMGYQa05dGMme6KNX4ZDKE4U?=
 =?us-ascii?Q?nLU/sCLqeUO2BDt86Xt3q8wH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfea36e1-1b00-44ce-eefd-08d9350f2d34
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 23:49:15.0922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yFATcK9odzmwJ3dEFT5Wkd0RpCgNSqeZMtli6hCzu2Q90Vm00zhoV4YcONp0oOhp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5095
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 16, 2021 at 09:15:09PM +0530, Anand Khoje wrote:
>  
> @@ -1523,13 +1524,21 @@ static int config_non_roce_gid_cache(struct ib_device *device,
>  	device->port_data[port].cache.lmc = tprops->lmc;
>  	device->port_data[port].cache.port_state = tprops->state;
>  
> -	device->port_data[port].cache.subnet_prefix = tprops->subnet_prefix;
> +	ret = rdma_query_gid(device, port, 0, &gid);
> +	if (ret) {

This is quite a bit different than just calling ops.query_gid() - why
are you changing it? I'm not sure all the additional tests will pass,
the 0 gid entry is not required to be valid..

> @@ -1629,6 +1638,7 @@ int ib_cache_setup_one(struct ib_device *device)
>  		err = ib_cache_update(device, p, true, true, true);
>  		if (err)
>  			return err;
> +		device->port_data[p].cache_is_initialized = 1;
>  	}

And I would much prefer things be re-organized so the cache can be
valid sooner to adding this variable. What is the earlier call that is
motivating this?

Jason
