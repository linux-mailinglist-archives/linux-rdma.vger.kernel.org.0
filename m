Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 514803B4845
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jun 2021 19:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhFYRiB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Jun 2021 13:38:01 -0400
Received: from mail-mw2nam12on2048.outbound.protection.outlook.com ([40.107.244.48]:17761
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229531AbhFYRiA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 25 Jun 2021 13:38:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOoo4RmeeIXAoOcII0IICoNiDwH9H/gk77TZmTiTnLy5dP7PhL2n+luhyAMSAGiaMApUHqF0p/umv6oL+W8XLHJW5BF3Li13gEEMQ8Ciyn9c+1NYMMCzTlitFFAd0XauD6qV2oVCxbYNQK+WtxKa5WGdO9pa1xQ3xP/BVRv92eXM4Wiv6vbaDNXy5IPUB54zqltxZLfUwh88RaaO7p2OIjtRiPbwFQjltlu3ESFZGF5f8BI7vnSvDlyYZO44s5gFCN+SXGgwJCBpvxNBTmFezzAuwdPu/IbT47b/+q8MCAqS6pMAYb+ZkbkNOas1N/mUDApjSpYLNjTY9WCK4+wKZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4k01XGMHyV7jkOaA3VQvzQAQZD4vLk1/qxszrxw1mSI=;
 b=VJ18uA9m5ipq3d38/eBIwTcK72zokOqGFNuNyNv+5lroR2E0F0Zb6TN4HQ4STKMoskGTDbbtLsaR5147Wp0Qcc68GYAbQl3w8iVBVbvvLTKvhf5R3UxnY09alaA+Sg3h10EK59A95a76U6msgKk0l16BLsHOS7wrIZupG2sCHIVfIAPtMd5gjh+C8y2qEoHcHQb5n7fdhGrJsd2I7p1kMixiBqaD56dgkNUnPbWxI2lZnKU0/CVojbQ8RzRJGfvn5ui4pa8jxEWfIjKBuBZGWf7rrwqrd1uphUgrPt617IkZw+iej3HJQQhJnHc53dcsDedxCizmu8IxiR5tjypMxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4k01XGMHyV7jkOaA3VQvzQAQZD4vLk1/qxszrxw1mSI=;
 b=SuffxoceakPBh+sz8PrgZ5QMrTCvu3hONR8B0NgLJBRXgpxRxlQHrXqfie7BOh34vRSaMiyjovcCL4zdWEUF5/iZ7pUaOP4Pdshdc9ym4jazRVqEpDu3gqB4W75B/BurzN2JE1DudSJrRfpx2yBBsq/DnP8p4aN1PW2bO7Xvhs0bs9g07bV1VVS/jKEoQ0C/bpuFgxwlMwXYFDjnMXh1flkSYorfrTOoaCbzS2sEBtbAbHuomivfBw/6rZcRZs07c/2TvdfjX0vyRbu+gpyQUPcfzliJTTu02okLrCO5LhTKYA7jD58Oje7qcbmi7QABJCk7CXz+Sz83WEB75ox74Q==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5302.namprd12.prod.outlook.com (2603:10b6:208:31d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Fri, 25 Jun
 2021 17:35:38 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4264.023; Fri, 25 Jun 2021
 17:35:38 +0000
Date:   Fri, 25 Jun 2021 14:35:37 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        shiraz.saleem@intel.com, mustafa.ismail@intel.com
Subject: Re: [PATCH v2 rdma-next 0/2] irdma coverity fixes
Message-ID: <20210625173537.GA3049885@nvidia.com>
References: <20210625162329.1654-1-tatyana.e.nikolova@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625162329.1654-1-tatyana.e.nikolova@intel.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:208:91::20) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR05CA0010.namprd05.prod.outlook.com (2603:10b6:208:91::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.8 via Frontend Transport; Fri, 25 Jun 2021 17:35:38 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lwpjt-00CnQH-K2; Fri, 25 Jun 2021 14:35:37 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dba189c7-6fde-4b98-76c6-08d937ffa586
X-MS-TrafficTypeDiagnostic: BL1PR12MB5302:
X-Microsoft-Antispam-PRVS: <BL1PR12MB53023DEDAB6AFC940F5B09D4C2069@BL1PR12MB5302.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9v40bPUvjY5viPQgllXOMIrAsGXDc27PJh4FgMrJCBMPBnxk9AeF7gcNRY2m86zNRUrBISMwLlAAsvRksvJMVWVQukp+NhizoQ9mqMN7lPqhoJlvs8GNqNAqERj6WkPDV1cuXtDEmXQ47dPJfrT4RBTNf10gbwftxA3IgyLRHI9UjgIR1Y0iVpOdCcbcdc7N8f9cUQTJGVO0kbTAYr+IoTSxg/TG4m4lDkkEjdmagyzW12JGVvbPUZ9lPOpOzdAq0X/gI2gJxofnHcNtSV3hPx1Viffc/4bEnC6VZfKEmJ1MGlOClswMJYZktuA4Z5mks5SecXOjAjGZSQjoT3eaXqrB687Ys5HWACramAjVQ1jlBonYVOad/ELEHSqH6sZedISeT6mDIQACgndviSEATXaNAa/B9eTcb2dVpGCRBS1FRWEWwt7BHBm9U3NY00McV6tUP4ESvbB2wbVh0nMRvyFPsmAaUjApxjKy/j41qIL6A95GPopf6uuxEMgdmI+oCLjqtYfaGYUy13Bh+vVszfDOT/hIHAgyQzn0aieNA9znRIeLkgaKniLYZfLcMr0j9b56qi2jcn7I1eMX8qqql8GKPW/ll5abI1JNaK3UAjw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39850400004)(376002)(136003)(396003)(36756003)(86362001)(478600001)(8676002)(66556008)(4326008)(66476007)(66946007)(8936002)(2616005)(186003)(38100700002)(426003)(4744005)(26005)(5660300002)(6916009)(316002)(2906002)(1076003)(33656002)(9786002)(9746002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CTALK0TXvsHJMHGSjY6vsOvkatAlyEGoLnH7Ctc4K/pjOoVP61De7lvHSXsP?=
 =?us-ascii?Q?OzHbaEPpKMv3bkxit3TCkf2MiOdVtR7Le+DyG2KyY0ew2OIaPPLoS148S48G?=
 =?us-ascii?Q?tg505Hve3kLlJlwJ+UeRZcINw94y1MuvW7YENCPv5i5kxVc/ufrAC4weJshJ?=
 =?us-ascii?Q?jn9l7ftOrdOyH1qNTUiZNTla2jfRn3sA5R3M2S32kAGJQcpfGe8QlyBA5Gcx?=
 =?us-ascii?Q?dTA5N6L0SvYLUhM06N6h0HAE84Acg+AhkaIxbAnYWHXVNcTi19+m0cKYxbJV?=
 =?us-ascii?Q?iw1uX+dQt+rqpEqOEj5tVqqhUF14m1ZRW8Jcvy1YCsNnbYXeOT6DHeoa70wn?=
 =?us-ascii?Q?W0sgg+zzX/iegoEBQqJtVImLne5FGQ6q0FkOAIvbjnq5qR+3LXRYZ4BSVnlw?=
 =?us-ascii?Q?H2rqgqdsQW14kpI3GYYR0OBIUN7ykmNwjrTY0p0TKMQ6xIA00bTQQR772Ar2?=
 =?us-ascii?Q?xXgxhPAa9QWyULmoondGKCs4qIIYE4r/hhydYJSgzA9c3VLNmtrJrJ/q4FCO?=
 =?us-ascii?Q?RoLe9R9AD/Bxj1GW0p/ps7ygBB931+KHEykH7/l0Jzq7j4dw2M2KekUU1jbi?=
 =?us-ascii?Q?bdv1AaeMOOze4ciEBvtWjaC98BuLBRtW6sgyyauoFxrR7jtbA51mj0nmEZcx?=
 =?us-ascii?Q?VsQE2uSGuaSonf/wdHTIBUg1gyc5MOBb7lW56ZB3M6KJLTnthckKXZH5iTum?=
 =?us-ascii?Q?9CJT3Dqc/fszfteC8IACFWh3CQmUU+FWxznBuk26begh1Ks6NnLTZP/KfhL6?=
 =?us-ascii?Q?sGaFI6FXKc5QyQTBsiII/V/Fb4jYvGB9Egga3odWg6BAGBtPZ2HvtxtixtJi?=
 =?us-ascii?Q?NhT8wNTxWDYDZ/UYe67+nrtnxDmoJJhF4XO/twuVtqdXDQdLrZoZIjis27T4?=
 =?us-ascii?Q?CrNA+vMFkIrHF0PijuuUb3/QnkaZTJestB/0stkTBjNwAzNhrSRABZx/oDkw?=
 =?us-ascii?Q?bk92DG9R694uClRb+Oz2LGVWarzigGHqBED/ULu8V8WFeH4APxhNDC1Re8sN?=
 =?us-ascii?Q?Va3th1yJqKkP9JG+tnxMAbC+cOo3tgKmusiR9pzoyW1GLyW+koJmrqcPNwiW?=
 =?us-ascii?Q?T/Rdl5REcuAP2jY67YiZ0QigRQW9RRa7NR3pbMHewSeDGWeCdVpM/fWeQYDX?=
 =?us-ascii?Q?LMjaVQUlgjANn7me4IAekvY1z3lUQFO0qJI0yTao7pr7G6gwjLMafjoisrhY?=
 =?us-ascii?Q?KRTOwG9tM1eAPvgIp0xUvBHKXoOMZmhI9HKxckOMjxY5J1uLBelogDR7+KgD?=
 =?us-ascii?Q?RiOSU275mIHBCXqrjNeaCdDo9UI3naVsRsQkbI4djlsNOh2uMYGQBQ6H35i1?=
 =?us-ascii?Q?dz5IKKlbiegxk9Cx08yCguLl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dba189c7-6fde-4b98-76c6-08d937ffa586
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2021 17:35:38.4758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ETDE3MqZKqpYC4Yq0xgXPfUltgGLdCopgvwVr2VeG3WLs9uL5KFbnRXXX8Gvfhj8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5302
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 25, 2021 at 11:23:27AM -0500, Tatyana Nikolova wrote:
> This is a short series of coverity fixes for irdma.
> 
> Shiraz Saleem (2):
>   RDMA/irdma: Check contents of user-space irdma_mem_reg_req object
>   RDMA/irdma: Fix potential overflow expression in irdma_prm_get_pbles

Applied to for-next, thanks

Jason
