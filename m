Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09AE33F994D
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Aug 2021 15:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbhH0NCO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Aug 2021 09:02:14 -0400
Received: from mail-mw2nam12on2079.outbound.protection.outlook.com ([40.107.244.79]:21984
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231271AbhH0NCJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 27 Aug 2021 09:02:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJRZG3dGPUEY3JS4HPt8ngUaRWWXYx/wRf80rp8mDw9Dh9pgAoB25xB4F0iAHuoPGbAdZoqecs8+3gbN2px5ivQ7TWHtDHsg14JlqjThxMRJGf3aBoSn3BvLrqmx4Bg1Oz9d5D1Zmvjfe72VzQdiAn9RsM+EJLSyYH7QfHpAGJNZc9ysMWMGGj0T0fjzhCaLwKPVUv/81c8+o9iREcXndxS2+/zGVhsxXOxkgMeEapWC0ROLuftOzPYo6ZXeJHpdh/CsUg5lleI/aXz4xMZRHTkpGPbfqw1+RExgC7azeOQ61pBeG+/WKObnI0X/GVCwyCZ4gcBKgiRNwa5wSKuivA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbCeGWLkxZlYrHbJlEUvBkDAsXt+vdMMcSe2D1jgTN4=;
 b=NU+1PB4EZodH0R3+tNcNHj8iz3RGkqU+9VPvHkI4oYUBidbY21U8KjfWnrJx3aydgP/UzJ0CgG2fMmVVwLFaBasioXDyGS0/ytXn3Z7EgnxlvWg4Lib8I+8VViBLHwmusTfbyauONhsRGUKF2dAGWTqJhKjnCpA6ZNxmgTJwp07/GHUe/lXWi5G0bPzfYIwGmqrhiFfGSTa7h8t7QJw8jq9vYquWNlH6LQtkTIJvwt+4StmdMh1prSDs3z3vCHKT4fW0tic3zgEXIcYAQiSWcoRB3Dwd5BZ+SOSv7tcZBspAwNAIeSEjBPSSvjdsPhc4lyoxDLVVukMUWyDa5+IixQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbCeGWLkxZlYrHbJlEUvBkDAsXt+vdMMcSe2D1jgTN4=;
 b=EMLCiLwB9NbkTO15ELMyzhuvBJg36C/dEEVGd3Cck50sLQDnmcaibir1+WpN2kZ3bqeOIj8dysKP7FouUiKHv8oOA5SEyKddUaVeq4L7NB4AZoJMMVSgFB71C1dmLNXTBlf29zRHKXzPucGxFSnu8oPKBI7/7dsi4oqpYwzUaznUAaxM9dX8u4wN3nuAT5/BaHgfqLlaULEFIFSfjxveX8pnJGDCo2Wvue9RVvCfb47ZHmPuGFmYY65gWnASGUaNvwTXTIs30l+Y/z2Xu16QZDKfPaWuX7qBbgMWF3QjtXUTeDijn8zIzRpWQjQ/kZbny4wTP9idMXi2BlZ9+VvSKg==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5520.namprd12.prod.outlook.com (2603:10b6:5:208::9) by
 DM4PR12MB5055.namprd12.prod.outlook.com (2603:10b6:5:38a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.20; Fri, 27 Aug 2021 13:01:19 +0000
Received: from DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::81bc:3e01:d9e0:6c52]) by DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::81bc:3e01:d9e0:6c52%9]) with mapi id 15.20.4436.024; Fri, 27 Aug 2021
 13:01:19 +0000
Date:   Fri, 27 Aug 2021 10:01:18 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 01/13] RDMA/rxe: Decouple rxe_pkt_info from
 sk_buff
Message-ID: <20210827130118.GA1354480@nvidia.com>
References: <20210729224915.38986-1-rpearsonhpe@gmail.com>
 <20210729224915.38986-2-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729224915.38986-2-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BLAPR03CA0089.namprd03.prod.outlook.com
 (2603:10b6:208:329::34) To DM6PR12MB5520.namprd12.prod.outlook.com
 (2603:10b6:5:208::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by BLAPR03CA0089.namprd03.prod.outlook.com (2603:10b6:208:329::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 13:01:19 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mJbTy-005gNO-D8; Fri, 27 Aug 2021 10:01:18 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33b91771-d100-4678-2a45-08d9695ac34c
X-MS-TrafficTypeDiagnostic: DM4PR12MB5055:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5055EBB32CF5E3AF9AF523FFC2C89@DM4PR12MB5055.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8B2oOqFbUaU3fXgPxrXlDyHCv7wtYYjS/lKuFL8lv7pYoALdFRD863cAEkt1vHyBjmgyuuAQqmtmr9wio8TyYZdbFL5xIscGrGzTOBxUMUsUByeGTtoIJhbFcTspTM27qsIKQ088QlSdTAp7H5NtSSmbtRoTpMG+XgKpYdKlaN4a7t5olZNLOMJB6UqyE+pDM/B1SM/1+Q48APsosebRbMgogQEIX2Nq8U11kPUKWvGksrbgx3kleq0BhRlJ08A9vKiyOlus2G86xBdGEwZv328/R1ZThG5h5MLeTTH9R1Qtt37L5ByxHmLVqgsCvjsdxWLST7v+RD3he+0TNvhdhOyALKWAEU4glTa6x5ikGQUopgQPec4qeZFrvJO0Z7FC3SUgu5UBLlMAzXpMH1mZGX35GYmFjeUgu7JwbS4v7vDy5XA6NWaL0XAMm2fWd1j6hzapZMVxpOzPuMPspAYHqQ4cm/Jz+w/zGXofwRUHLRjMmrp32spT15MD92R2qqWEsD4abqCC7Lh7XyihrcDum5Z6aUorsvpMmD5qamJ1L5UoX5En+qA66pb8waX0A8BNZo81ckOPkAQn8MqUx4nDPNZOtdont/UgxKOfbFK+Ot90GyEI/Lt4fMu3DLiQwwi/GoOUFGO/jOUCZcO6FlDt5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5520.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(66556008)(478600001)(66476007)(66946007)(186003)(6916009)(9746002)(426003)(26005)(1076003)(316002)(2906002)(4744005)(4326008)(9786002)(33656002)(36756003)(38100700002)(5660300002)(8676002)(8936002)(86362001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vwq6Rqe8qghh/+TFXGCD0L3dSCAnG//ncF1xuAAy8RR+2SZwOgyVRsvCSp89?=
 =?us-ascii?Q?e/G5GQPXBQu3NBC4VSdKeB0rnTHjgsXTMgku3sBBB1sl/ukgYE2rPujtdYqC?=
 =?us-ascii?Q?ME8ulldmZCA6UxVdUKAW/8IkdcOrEN/HnUSpeT2r00gnN/qdxcCwaY0jDCDx?=
 =?us-ascii?Q?/oNn9pxa+MF6iX5geiXeMI9YexXN2jepIJL/sFWVMWUORsAAmbKkIlkWzlnk?=
 =?us-ascii?Q?8cLlNhg5CqCK/O+S+okttDB+QDe4/a00rMVBeXvTO0hsyL67u3LI9BqsXMft?=
 =?us-ascii?Q?dmLqVag+2uZiBRt3AfhCyZtFDSW78PoXnszngfPsyGMGEGaVq1JAlpGwK9/2?=
 =?us-ascii?Q?CqHFeja0E6dViqj0Pufi9QUZv98/3jKuA4yCA2wwnClOlwTwR1rHG9LjqOHB?=
 =?us-ascii?Q?UOyJvIRStoWLb2LEqQrfBnin4tyleue+Cgow7D39E7iAgqXHvM9DMgjk7b5G?=
 =?us-ascii?Q?ETNLXu1G6jIU33wc4MzcI8PtwK5AR4/RRsPLOPwP0dzSEDxH+rr+oY10SrJr?=
 =?us-ascii?Q?AB2Eyjp+g1MFXO+eAqTWg7fSGLRcdAoaUAhIiTLDosBnhK1noB+YQVlncCHR?=
 =?us-ascii?Q?rXsUZWCyAX1X49Nkm3p+2gh8TO2v8ZrSCes93PpQmN9iDlz7eGO5jfRH5ApL?=
 =?us-ascii?Q?eZ84xRbRwAmDnFIsgChwGfCOwcDEwJr3mdQvUmmiZShyH+043r+K+ianSVtn?=
 =?us-ascii?Q?RHdZPEiyTRA+GatEOLeO3hfjfeRLId6XABzFjUP8cVeWFjvuVFZvPGu0Au6X?=
 =?us-ascii?Q?xfOWZir0umIToDF/qjT7iurQPs1zvNw0d6ys8G0et7kzNnFIVNLdVvQBFMFl?=
 =?us-ascii?Q?k1Iu8zERGiAvgwqUFnPE/oAVsMPykD96BW272yYN6tS5IKPavkRvbIXH83ua?=
 =?us-ascii?Q?pnGYQtpNGacJsuyIGncpbFaQwGq8I12jN+F6N557lWgV+4BWxd69vDQ77o5w?=
 =?us-ascii?Q?vs5qfD14Qi5vNMTpaAzNRy/erACxf/75/yHVFvj35VLhF2Y0pg4MluaSdytU?=
 =?us-ascii?Q?RYbK+0o480YRrQYV5rg5uphJsflWJEoDyU9tyCgjujKSx6xluvCQaZUs6U4t?=
 =?us-ascii?Q?5DAt4a5ayZgbrmH4Dwu27UKhoMFb8f3qNXOMfpHuvkhr7uio4T4KYPlyE+iw?=
 =?us-ascii?Q?wL701ybpvBXZcBDEgJjXCQ6K9wNJ+KptHJ7CsfBM6mn00MaKxmrFE6nsA/ED?=
 =?us-ascii?Q?kz2dYw1IxgoYIt/+vlGVLZVHh4OSqRDmQ4MveaLxHwOsAcvRoNcnPOLwfhpb?=
 =?us-ascii?Q?6jEJdsVr8xZtPkZMTkh3Zx5a3gfWVk8A70tns3dvu7OcgvNmLKIec7cQKXGG?=
 =?us-ascii?Q?38d5O9192J5i+Ulq8PRYb5jR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b91771-d100-4678-2a45-08d9695ac34c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5520.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 13:01:19.5730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WTyNMLTmbMU6dyW1L29u3fModJ6iOtHZ5sX6YvnWJNbFyoyQqcRda6l7bVEAtqcp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5055
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 29, 2021 at 05:49:04PM -0500, Bob Pearson wrote:
>  	return sizeof(struct rxe_recv_wqe) +
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> index 4f96437a2a8e..6212e61d267b 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -155,7 +155,7 @@ static int rxe_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
>  	struct udphdr *udph;
>  	struct rxe_dev *rxe;
>  	struct net_device *ndev = skb->dev;
> -	struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
> +	struct rxe_pkt_info *pkt;
>  
>  	/* takes a reference on rxe->ib_dev
>  	 * drop when skb is freed
> @@ -172,6 +172,10 @@ static int rxe_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
>  		goto drop;
>  	}
>  
> +	pkt = kzalloc(sizeof(*pkt), GFP_ATOMIC);
> +	RXE_CB(skb)->pkt = pkt;
> +	pkt->skb = skb;
> +

Isn't this a huge performance cost? Not even a kmem cache or something?

Jason
