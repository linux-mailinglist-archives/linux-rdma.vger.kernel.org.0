Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B41351CFF
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Apr 2021 20:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237661AbhDASXN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Apr 2021 14:23:13 -0400
Received: from mail-bn8nam11on2059.outbound.protection.outlook.com ([40.107.236.59]:65412
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238842AbhDASPB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Apr 2021 14:15:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1X0yZSStn1Gdzu5s+kc68tHv/wjjdZA9nrbinwF5dkyMFZu0oXHWzMoGKICIJtsc+z04QwM0795CrDDb2l4+ExU5owMSsG0CnidYyM8T5vDcZPLAVGIJXBp+am6TcpSm43WTXlE/NoyjrHb2nJooOj9E45TmkWejqdeiJkaMeFOFYDe+a9ITBDfL3vpoEoneQLkBBRa3k+CnCEljz60X0PhMRDCrGHecWo7E0V6YNZgYMACB9iyeEjtWMqgoQg8ItxYMEUZvhWX5LT/C4rc+sODrqwcEadzQSo6tlWEEnYk2mxdcNf/9lAcuhVrFCXNgtUwVkKyjkwGKQwbsqf1xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvHtaskFfgkJ28J6H+KSW/fFlSAx3KuS/uY2lWymGho=;
 b=bF4LWf5Z/kH5k35Em3vA4Q0ZLFFCAewMKMQ89JiDtjUXg2ISCmLS1okY0d0nu7G9POZ6u8wEf3objxuJPN7XiYeViF8PtQ6943ELeAj0c59e1lO5EA1BnCrTSm1+Mf7qhptD5wjdanYUIo+w83lQQFkrXforsLW7gsBJmXy9Nuy6FU4lPwNiVjnR6sGHkMfcXhZjZuXL1hA3dM/9HZKZkbE/S7nppvHQjnXUzo+wBCeTJ/hSdT6WKzDFSQ156mcvkxtyneHsz41eVuC0dyjys9QAH/+ObKHbWwtzxX8ihZb0quMD5Q7lmaK8ieGfdBFREYWVGoTTh5F9kI6KfC+oSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvHtaskFfgkJ28J6H+KSW/fFlSAx3KuS/uY2lWymGho=;
 b=JHxqLFT0fo6w2kZCA1qslIKlO0o8dP0XRknMDRC5rNqIrJlmgEy1oh23Gh5h9X9zejqhXAfToOdtJrIAlVEDOFpOgaPiNoKeWmzMvw28575a5y8Us08w6JmoRR49/35w0SLhyGgZSdQkcd4qidiFra1/XGTOn4kvZ2uru0kq2hFcbC7sk5TOzCCTHAvBuVoU1iaKylak4rGHeF1A7ZgTq7W4vbUHW/6dopVo6InBk9tcxMPVIutLf717vMRKCM22v707tL12XH/4eLTVbCu4CarL4SbnuUL5vNyxG0WFk8+/b7GptWyuYYQfDVz6AGypF4fkuZNpHAYCETLQahbIKA==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Thu, 1 Apr
 2021 18:14:59 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 18:14:59 +0000
Date:   Thu, 1 Apr 2021 15:14:57 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     bvanassche@acm.org, dledford@redhat.com,
        linux-rdma@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] IB/srpt: Fix passing zero to 'PTR_ERR'
Message-ID: <20210401181457.GA1634722@nvidia.com>
References: <20210324140939.7480-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324140939.7480-1-yuehaibing@huawei.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:208:256::17) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0012.namprd13.prod.outlook.com (2603:10b6:208:256::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.8 via Frontend Transport; Thu, 1 Apr 2021 18:14:58 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lS1qL-006rIK-Af; Thu, 01 Apr 2021 15:14:57 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2bcd459-53e3-4905-98c0-08d8f53a0f4d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4340:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4340D4A6AC4A69A4E1562898C27B9@DM6PR12MB4340.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BGRoVscKEOrVtecm0pFuqfHEi61e7YYJZnAiK+2j5TuDF47rA3nzU/uuIfS8pw0LKRa1tDRjNPGuPL3rvDyaONW4IH+EcHAaBHOzykuPhJ6TIJE7UDaejKAKKepJ3z7IBLpjUaK8bfxB7t6wiPRJF8ouNopSpdeDxkSZmqRADHFChA/5lKh/Pa5ewOtCF6YWcu1rylG5nkOJcDluc2fbBUdamnAjvaDe0Xl+prlSMzjWIgZnIUPWSZHZcMd0z20NaQb6bIQ6PC+nqCYTxrWSKQ/WiSBGNgGEBbPDZr3Mpsc2IWvAgbDw8teBKrQeK9Mq8sQGe7hkYbQJ11MOWTN88USLRL0uG0v5INDTld9PiEXEgj6V3L+hYLMB+RuHsHc8nn3Ljg4cd84M+TrTGXvbWsFAQBbv/NaSHritBXq0QtnUS3sfIfpvgGbbAOTydkIl6XC7US1z9DF9gfne1vcB4BCS1ppVhjogNtLtVzi+Xp8reMVWpPOnBs7qBnPpOF5sApxfqJyD9NU6ak8jQiXtfiatJOb3rUAWh8C8bUby8BIJAtnPwnuGhtA/VRG+3qrY3H/AjuFXcGxt7ai7GDN9f1dShl1zq5/bWASXd0x5D7QRXCvbVt8iWulKspy+Bj+wwxPYjH/6zkLRR1F/iy6ZN80b6G8Ex4rhhiXEFUzG/Uk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(396003)(346002)(366004)(4744005)(2906002)(9786002)(1076003)(4326008)(5660300002)(66556008)(38100700001)(66476007)(66946007)(2616005)(36756003)(426003)(9746002)(8936002)(478600001)(83380400001)(26005)(33656002)(186003)(86362001)(8676002)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?daUX1ByD9SAStdedlH5ky3NgXEtemmEGMg0awTfF1etoYHMg+rHrmsjaKjRN?=
 =?us-ascii?Q?f1+ORVmsgxr5NFW4Vkbq7GGWmstEGWgMm1TPLZR/xZx7GOmFDARML/pB4VuQ?=
 =?us-ascii?Q?JnF7HfEolagvOH8M4Z0YFOx+g7iyJCfOQ6nBqTI9DaAq2hRTso4pKIhhtoIq?=
 =?us-ascii?Q?xZxmo/mPGSnAbpAgbDiOn0k4QaP4ucT+nM7XdcUTa7y1dlQTLB8BOhJn+AEV?=
 =?us-ascii?Q?pagTKMcO9LIvc6gWVgWgNICrN+EZ1te7GVEaoV90C2WlYKvk8Ez8Pu47VhK0?=
 =?us-ascii?Q?CKKE0PJEUtcLJaDuaUVUdFN0uFdpXjnLCyAcy8dQQy3wYvfEJjt3gwJW5aTu?=
 =?us-ascii?Q?JYJjie6IjCu6CDtB8UttzyZZoM25pxYe0+TaXIl9dxiid8rvvu9//dnEVr8m?=
 =?us-ascii?Q?4etU7zZ6DsEDUy4fFnbhKDVXEruNJyOKiohfsZHyKF/2F9+cKlk9npKiPlR7?=
 =?us-ascii?Q?A16Ol5BiIlGCBF7IhPLyJePEY0kdKAuUVhUp+wxl+HmN7HnrBNkY2Nq1RNnA?=
 =?us-ascii?Q?zGNatyKtdSBsh0NcGn9O/iW9OspXyeEVG5ZkFyb6NJFirKvYFt0mgk83zcXI?=
 =?us-ascii?Q?8TpMH/3TGYT37uKug2H4FLjfvSpQhdrPF3UI1vD/ZFWtgcdJE8LTRL57yWz0?=
 =?us-ascii?Q?N6GvnGH9sGPRbj4E1hhzmP+3pyd5Cz6JIDoooBMsfmB3Nl6/0WlorvZIpBWf?=
 =?us-ascii?Q?d8k8ygkiH/hVQXuyUN71+5eIv5mylXPtchHP1daDOEBTbkvxVGOYNwCoM3Ct?=
 =?us-ascii?Q?eJVD64K15MShJAEudW7GMyyJhmZTf6ICUKeXBZDgbhQbxe5VOcxzBtd9nS7T?=
 =?us-ascii?Q?+NpbWK3yFw7DDUjGUq2lDhkLe5EpK465k1YHdX7sNizfH+lOCqDqiHQdrGvX?=
 =?us-ascii?Q?TthrBLAZVR5Gvt5VqZk9zVH0CEI3EOTfNRXvjqUGugYDQvmcJ/okj7DRq6TW?=
 =?us-ascii?Q?TUBHX9+mLOlf3zEDfi8RHqdIuMnQZcxeU/rpd0SUZ/hwzurtGSbbWPtXLdcy?=
 =?us-ascii?Q?As9qIejPpTHf5lW2/JWyyZhUZCdOzQ/rKdBEteu32hUCS7mo1t0haoUH5rMH?=
 =?us-ascii?Q?3lSOGeFP2U20VGBU5L3rllprE1chjEhvYpq9hoyBxy9ler4d4LsGN/XQBOIf?=
 =?us-ascii?Q?BhecjWOa+crGXu06+ZX3nD/hQdMKgS5f4vEgq0wxZmL+Z3981RcbGar+YqmJ?=
 =?us-ascii?Q?VpOfoYg+N8SxVh34aWa3+yHBsNE2GZu9vUR4LbNZltynFRd+b2L5LuPOzscB?=
 =?us-ascii?Q?GkpZomygiMOJ8TBDMutaJKwPqezDMKWMBC9Vku/FEAC8/OIAnUCE/3TwTj0E?=
 =?us-ascii?Q?xhz5LubABT6Xwfz3m3N5vXGYvUMA8g+C9uRPcE379fWzQg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2bcd459-53e3-4905-98c0-08d8f53a0f4d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 18:14:59.7311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e/95U0URbYU8CP15EvTW2OlgLuW4rBSgW1gDLKPNz3vFYHPlABTUOxes5bQ2OAUp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4340
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 24, 2021 at 10:09:39PM +0800, YueHaibing wrote:
> Fix smatch warning:
> 
> drivers/infiniband/ulp/srpt/ib_srpt.c:2341 srpt_cm_req_recv() warn: passing zero to 'PTR_ERR'
> 
> Use PTR_ERR_OR_ZERO instead of PTR_ERR
> 
> Fixes: 847462de3a0a ("IB/srpt: Fix srpt_cm_req_recv() error path (1/2)")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>  drivers/infiniband/ulp/srpt/ib_srpt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
> index 6be60aa5ffe2..3ff24b5048ac 100644
> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> @@ -2338,7 +2338,7 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
>  
>  	if (IS_ERR_OR_NULL(ch->sess)) {
>  		WARN_ON_ONCE(ch->sess == NULL);
> -		ret = PTR_ERR(ch->sess);
> +		ret = PTR_ERR_OR_ZERO(ch->sess);

This whole flow is a mess, if someone fixes properly then fine, but
I'm not convinced returning 0 here is correct either.

Jason
