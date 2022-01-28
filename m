Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC254A0018
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jan 2022 19:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346531AbiA1S3u (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jan 2022 13:29:50 -0500
Received: from mail-bn7nam10on2085.outbound.protection.outlook.com ([40.107.92.85]:1921
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233922AbiA1S3t (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 Jan 2022 13:29:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eae56ZcolKxzTm+rI7uWSCQ4tnzKF2tP+JtW5m0EsqGzO27WJdLq/teaGErlTzT+df+yGMcCPOvrbjS0V9Ap58rwVdIJVSV6FzEzu0DyxZ4CxP+BZ7fS4hG+lKlK+mws05UPMdSwG4H89rDgghlAlOHs5peCTi1j4Nk+o0pRJL8zb4hqWDifKroTwQvXLV2Btlp70Qo89sCc5zdhK89yIFYPJ6mO6l1lkp23U/j/pn+Etsr4bGQdcBfSIip/wYqN81tmvZyHahYKDK+xcHOv4giwsRP8FDU6OpxEb2QigYh2mjF1jc5n++RrozBj2wlsLl1Rv62sADlSil7MjlfLWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M6m31HduUei8+midlaYQCjbHsqOkB3NI93Am0gls1Zg=;
 b=ZjzURFJHdOkNFeZVJ22Sb7L0kX6j5fn6eqEIafM0p6zjGFZEq7rnRmTXdIMTOj5tKyGwdpgIvo/vpBiyJov/DDhgkba7Yrd3VIFPw5n2+r+13w/Cacl693H/mdmU4bBsXEFtaHQt4KyKKzkQLWAkH01NRzylncFMZYAcJHFVBpy1b6e9coTnfE6JgbHzHRGSHKxwmAUYxB46VQqw8MugYFj9dwasB41Vrh9REjeOfxs0j+SOHH57WZuwhlCHJN8fvjw0Fxxw6Cpgf4w7ZyuMSJr/4StQPp1GD4XQUEiY1bExa55vsv6BGgOC+5xE4VAbbCWdiZiUYC04FnRNWosWNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6m31HduUei8+midlaYQCjbHsqOkB3NI93Am0gls1Zg=;
 b=AIQXsSXsYlv+tb3G8jvxbN9o2Nm5obhsefWjnIoqsAcxQpJS0a/m9Af8pKEaWfmt97TD+9FMsh7VKhr0v/1ZUICpwISz0yalgYsPc2ujhB/UDL4ax2rjmSr68TWKAP487kd9uIdv6Q4N7StjPcBQNkbPd8ndgrlSGj0KHBMANDaH+4k8ecm+IouaUaqewGUO3mtPnXskwcjpHjJpwQHrRHwHXxNGgrJFe01zfLog4sV75IgQhYZDu0Zm/GzyZvhUQiK8GFBLZFiLEbcEt5a5pcXQUogI6GtkMRpAHOR2wt7WfD2ICyg1DnDzxkwv9czs3nutZ5ro6EC9bb38+Da4Vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CY4PR12MB1144.namprd12.prod.outlook.com (2603:10b6:903:3f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Fri, 28 Jan
 2022 18:29:48 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4930.020; Fri, 28 Jan 2022
 18:29:48 +0000
Date:   Fri, 28 Jan 2022 14:29:47 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [RFC PATCH v9 09/26] RDMA/rxe: Introduce RXECB(skb)
Message-ID: <20220128182947.GE1786498@nvidia.com>
References: <20220127213755.31697-1-rpearsonhpe@gmail.com>
 <20220127213755.31697-10-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127213755.31697-10-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BL0PR1501CA0022.namprd15.prod.outlook.com
 (2603:10b6:207:17::35) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c659fd5-ffb7-4f88-5a4c-08d9e28c2a0f
X-MS-TrafficTypeDiagnostic: CY4PR12MB1144:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB114486A0C982E788C13CD77AC2229@CY4PR12MB1144.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XoFDhLsqkhD9ivdC3l+ZkhZgNzG53iDG9H4P7ZUfH8p8iHuQkgBYRKp9swDTAEiY2b44nAxd/KUNshBnfVMzG6SX/1N03cK1aTX/EpOzPE+UNUJ6ncfpfmtqW20VuSwfSnjaI/69SlMo7lEq1leyXcyinTAoKgMAUHmh7SZO5SpCTkc+PQIU56LRoXIBf7/Aof/dFLIShgLtL2i4po2SxXo75ZS+h0owm/iTnEIGAaR/n6lwU6vhzJcIxzMWJumsz0pV1kF6Jm3lXWPp6ygNJ/cOu11x+IY0phS0CbqJl7sm4IVPpcNZ6vAdIfQdjc8+tpOk2cjQqGpmPZ7nmrX3D//s1jhBBllZf4mS4wX09OssYQLhXuPWKZHbda+locr6gns2U+U9gMH+cO7Q8fIUNhaO0xq8FapBFWekNDL82g/WRZbnAIvUqSPbCWSsk9mPijMyCoIM3DnRB5Q6XE8AdQnZnpaLv6FI1n1ClLz5V4VLO0tEiEsWQYe4TOHeVSb6A+/EW1Ct9sQtBHdytLrHkQ6FnsoEfqBx65z/DR0KyJUMVvFKbnvJeGD5xr6Dmn2el/NwQRGwYjnOBq6tEEyf+SkyMENmfkieQIHvY36gbtioo+i0TspXO52T3YpFJlHwsm8TKj76Ah8OP+ZBkgmwtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(38100700002)(86362001)(4744005)(4326008)(66476007)(316002)(33656002)(5660300002)(66946007)(186003)(83380400001)(1076003)(6506007)(6486002)(36756003)(508600001)(8936002)(8676002)(6916009)(2906002)(6512007)(2616005)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MzQVbFSaq4PuV6oeGJlsWVjXE5ShecrqbkiFqfjVhLZzdCShqu95v6qhVqdw?=
 =?us-ascii?Q?/bENFKmdhFpn2f8iDyLJ++DvDj/L/oejV5S/ekwnYyDW8gdy5DKtypb7A2pc?=
 =?us-ascii?Q?QMFGzmEIFiqvZZ0isBercHQUy8Rv00Lmuuv5eFhB72ojAXprYfX/CukocGkw?=
 =?us-ascii?Q?rAj4LOQ92kUTAsFYQjC48+ITnLeHvqYKvSRdXmkShpY+pGVvRAVfnFJPQQfH?=
 =?us-ascii?Q?uCCCLO9XIPoJTZs2fHsNbb0FxcAwXS31ovDWCW0A2+KMStzCV1cEvBAd2v9C?=
 =?us-ascii?Q?9NgMpyEfN0PiHy9IxiblCG47X+mCYTczrx8L3hxwF0qEtcgTW9Fl31IYdNF1?=
 =?us-ascii?Q?NMMHXMDtkExObt82dhOUavhTjyD0Ai+KjEhZa6hbuUwavhRR1MpdHbSoH9HX?=
 =?us-ascii?Q?x6kEecK9lt3y8BIM2OLGs5XllF6QbXw4GhJCsELlEbR+rb6Nf0M+H6BjTMvh?=
 =?us-ascii?Q?zxJQpcn4GjX/BMH3JA9oGDjmNbUCHheAkMBgGWiQoJEQpjkLi/S7g3flPkKD?=
 =?us-ascii?Q?0HpuOBpqEDs736olpWIscMidnzcUTxl/M1GglMet+fN4Hg2pHxnFvRt9/0Yj?=
 =?us-ascii?Q?pEJgnrWaCcG02IDNFXQkjw4SstwChGEG8fSeR6pUPuXnRqoQvPMQEwiaEavX?=
 =?us-ascii?Q?uGa3OVl1/qK9gAy//Ab9ePZs4iIjmQBSPF/N1UlVUmu/waZYGU6Cz4yTcXv3?=
 =?us-ascii?Q?YOxMWd31yBztfBUmDwmuGiuCHHBz9HgHLW0zPRv7lcH+xauH7d+NB1P//Hve?=
 =?us-ascii?Q?GizWcyxe7xpcD36aUIGXkAjwqrTFfsfiRnTMsnP9jMA1V8oC3wxNt6IHuqqf?=
 =?us-ascii?Q?cufRai2VbQMFb9afDM701yx2MgDMqmTcMwRy0xDux5i4WcVBYito43A7MRBK?=
 =?us-ascii?Q?UarWa101ALIHfyOlKwMoBvifqNlvbdlbFxisyqTXRBRZBPPq/sGcLbDL+9Tb?=
 =?us-ascii?Q?y9+biuMBSnGdJ8hIsgLGX6v8tm+U1JBkrxsTrJzZdv+snF0Jh9aOn/7EmN1+?=
 =?us-ascii?Q?PwNomJ5RijiqDNL+eqvVyOTE0Qhe0JVwuXHHhqrRU2R4HWxVHJhjRTMKqudp?=
 =?us-ascii?Q?v15LtDbgAIqyrfJ7+GMR8NtgwN30xq4Z+uc6nPuEOnHrixqDZ1mWZ5U3OodV?=
 =?us-ascii?Q?Fh0Hlnhd2BFVfQz746XY/gOP0X6c70xVkRnVojqGkANYshmTsbEIMU8tHf2v?=
 =?us-ascii?Q?NYEjEwnCJqbG2lB9IXhmf51PZaceOg1v0fiveBtZANEJ5GpKaGavJbAQg9NC?=
 =?us-ascii?Q?Lt/Wud22QCFDlTydZqq2UAZ6crdFDItJP5OlmhUy75Or2bVkF0JKanqIipRZ?=
 =?us-ascii?Q?fO9UX1t7MOxPPIa8dmnBF3c9L8nX5IVMszmRLeOmb33LGWrULMYnBRIfnIW4?=
 =?us-ascii?Q?45Siw11+BRhYwsIWEYL0XOWr2B6ChAfBxEhc6PBLnd0LQKJT2XfBxPEN8hPF?=
 =?us-ascii?Q?qVZ/r90mZHslA/svEXDoyWD/xylUJcioB2aS9QQDxG9cc2XC+SjCyXGKU6Pp?=
 =?us-ascii?Q?kXgYHt0m0OHvC+eIHqvTY/YrsNv1rmVSWZ6U7BCW0NKtVCBnj9LshXNnxEpg?=
 =?us-ascii?Q?CIBIsSHrUzjvUF0488U=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c659fd5-ffb7-4f88-5a4c-08d9e28c2a0f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 18:29:47.9989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BxruDaoVMD5wPSW3yIbZCWdR8mLGwdCa6zovPS8CrPas8o75tEiYlEWWzx492Nl1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1144
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 27, 2022 at 03:37:38PM -0600, Bob Pearson wrote:
> Add a #define RXECB(skb) to rxe_hdr.h as a short cut to
> refer to single members of rxe_pkt_info which is stored in skb->cb
> in the receive path. Use this to make some cleanups in rxe_recv.c
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>  drivers/infiniband/sw/rxe/rxe_hdr.h  |  3 ++
>  drivers/infiniband/sw/rxe/rxe_recv.c | 55 +++++++++++++---------------
>  2 files changed, 29 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_hdr.h b/drivers/infiniband/sw/rxe/rxe_hdr.h
> index e432f9e37795..2a85d1e40e6a 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_hdr.h
> @@ -36,6 +36,9 @@ static inline struct sk_buff *PKT_TO_SKB(struct rxe_pkt_info *pkt)
>  	return container_of((void *)pkt, struct sk_buff, cb);
>  }
>  
> +/* alternative to access a single element of rxe_pkt_info from skb */
> +#define RXECB(skb) ((struct rxe_pkt_info *)((skb)->cb))

May as well make this a static inline

Jason
