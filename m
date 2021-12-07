Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFFA46C34E
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Dec 2021 20:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240843AbhLGTH4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Dec 2021 14:07:56 -0500
Received: from mail-dm6nam12on2058.outbound.protection.outlook.com ([40.107.243.58]:45376
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231668AbhLGTHz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 7 Dec 2021 14:07:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xn5Pio8S2w71tWUNi1/tF8KL9z39DffVLK+a8aya7y5wFGeseOxS8SnCWYXPMzq5pg1VNYVnSJ4bg2bYzMhQduJSekusFbOCq4b0llMpZ/POnyCGnN0WUaOmEzqFzzx9UxnS0zIV/BDmuxotPer/y5RdPoJDRm9y+2EclZH3TynQbZjj/xq/qYQoxnk5nPDRDdKmG+N/IS59NKu93fELHgfbSC7Dh3XK9VnhL7ppR0PZAUx6Ss99AIArhSbehFUyh1M1MWbFFHg3zVCLsysj/zYtKy57dw7qFrD69M9f0XAR81csKNikg1ePlQ64l/nM94cFPq6dqMPjaRG+gKlNEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hqH89Pm43m2a2T3irVPz7stQ2pJiKrXhnjvvhpDWJC4=;
 b=QUvkvv2L5n0KdLi7K/LOSOEtQJfTLYv0ZLhLWlMNdeLvnprIeaHXUvEPQWHQygjw0sJFTY06uAt/+7bqpKa6oZ8rPZTVSwvhhau3PKIEAkGNeqLtRDIxH5TRWzCRQ12a+3yyltn/p09GtEqTqRfLXfSaR9lnrryLr9LuzP4ucyg2nW/z/QTUZA8GP2O4W5nbiWBIki7UybbCBFD4ul/sQNvRoEZw7AprPAr4iAQ/wG5hPJWC3qIK8jRl3dr/PTWML4dhgzRQ/PYzwzZq7Z3igY0Kki4C746Rrz6Hys5CMMZDhi2omhsMcp9UY8KDqWGHEEj8rRWsMpFn53De6bT5Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqH89Pm43m2a2T3irVPz7stQ2pJiKrXhnjvvhpDWJC4=;
 b=p2TEM/mcC8lcUeDuEcV0jpytOmVzVWaj5M8vS33yAbnFCHMmuMw6v6XCxsd1vC19MCx19l2FMMywBJqg7ZKaCoP7d0rb4FNj0Br6Xiat9V6r+FNpC33qR4idfrnrp6MSHhgDLtVmM9vbornv0FsHbjHihEBCErTTZAyqTnswCm1a08trs90qGtrcK3DKP4+oUAheU0BeTcUMWwf3nyAF7XyaF/2Jq6PA4tDduTdValy8D25x9PS1ZS8YiITLejmL/iOX93F5bKjX7+ULwkB/9v1OteK/q9dmJnM6zsoUGimmOk50HGkS4TCucoD2pZHwTRj7vcZB4Ybw8ANmvCeWBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5192.namprd12.prod.outlook.com (2603:10b6:208:311::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.22; Tue, 7 Dec
 2021 19:04:23 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%5]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 19:04:23 +0000
Date:   Tue, 7 Dec 2021 15:04:22 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>
Subject: Re: [PATCH for-next] RDMA/qedr: Fix reporting max_{send/recv}_wr
 attrs
Message-ID: <20211207190422.GA123490@nvidia.com>
References: <20211206201314.124947-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211206201314.124947-1-kamalheib1@gmail.com>
X-ClientProxiedBy: CH0PR04CA0060.namprd04.prod.outlook.com
 (2603:10b6:610:77::35) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by CH0PR04CA0060.namprd04.prod.outlook.com (2603:10b6:610:77::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14 via Frontend Transport; Tue, 7 Dec 2021 19:04:23 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1muflG-000W8X-5Y; Tue, 07 Dec 2021 15:04:22 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa313d46-1964-4fe3-1401-08d9b9b46194
X-MS-TrafficTypeDiagnostic: BL1PR12MB5192:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5192F13ECC93E1614A6947F6C26E9@BL1PR12MB5192.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QEeAQIRaMxMRNxS7j3Mp6HkNdfMPpdlT257VOnkAMpXeUnBX2F8RZXi6Zdb1LXfmw6GdaIBZQ9qs6fTEQ+Sf42rgJu3dEtl9G8fCdv/pKIlEhJPeipBvA7VC5PGEjs+EEqCvXp2TLgSJdNumJ3vDnMVFYcAlUqSZdFy2Mz57zhnTb+Jaq/UZGuQ7epL3+5rdu/hHo59q5R2mfNl66pGXsx1rjiU89P52TRvaXFsw03lXHLy82D655lCb9A8h4bNgBg+3pu6CNHc0qysbWll4Rfap8UwoDjE8eVoi5rHmmEwLFUPkcZSo1lenoi9xOrfRtQCHgK1eDNvWOj8wC6bDtH9+4qKp+D/saRxl5TtPo8bT3zm2WcUcHpt+fhzEBKrTkT4Ca6CGpktGC6gL9UA5hRqcTvNfZ+FfDCw12ojA1+v8hGYl4zFhh9A2u3p7tD87gnQzUFTcdU4Fk2dcy7HzqYQoRsd6ET8ukJlco/w+BGVcsNT+kRD1x1W4sOh53uOXQRwPAuI4hqvGtqQajQRu7QuPe6+TG1MZdgkJiyGWAfZHWlTrvdUrgO7ABCxWHHeXax5hnRt8gYudjlGjh+Ktq8aDCb+sC7c/Vazsy9J8QYJnltbPoFFE4EcQODSOu1ZsL3vNY2jyntXwpySAZaw9TtleIuCi8tekFBNjqP5/GFhlWdYMKmGYL4o2aIykVmHHpwHG1NBxb6yOppzmrrTc5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(4326008)(8936002)(54906003)(26005)(33656002)(66946007)(38100700002)(66476007)(66556008)(8676002)(426003)(2906002)(1076003)(2616005)(508600001)(6916009)(316002)(9786002)(9746002)(5660300002)(4744005)(36756003)(86362001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDZnTzdvRFdnRS9WSkxGaFA3d1pxS2Y5dkc5enBZa0NwZjVFMy9pUWN5RzM4?=
 =?utf-8?B?WDVqODFObmtpd3dCcTdpY2F6UWVGWllEdXpCWWV3c1l2Q3AyT1poSVpEa2k5?=
 =?utf-8?B?Q2h6SWhpZXNQc2VYVjhma2cySlZxYzZHR3lOK2JUcXBmUTZ5Um14c2xIc1ds?=
 =?utf-8?B?OE9jQkVrczJXMFNiUUQ0T3RlcVQyaFY1YWRvekRVbmRTMzROZ1JIcUhzOGhZ?=
 =?utf-8?B?bzVmMElzRU9UMW1VTWNNSEpvNzNNM2V1SlJKUWRaL0JZM01CbktQVXVhSTJi?=
 =?utf-8?B?RHFlRVJRRmFqaEpOa2pnN1pYejAwdEQ1NXVuRzJSZGNpTzBRZGp1Vm41eWZy?=
 =?utf-8?B?dlRpRzVLdWFaSElYallQQ2l5MndCZlAwV2t5a3pLN1VybUsvN2FablgxNVhn?=
 =?utf-8?B?VFRiNUFqMkt2aWtzL3FubTRYU0twTVdJRHNMeTZwVG1IWmlkTDQ4N0h0cVFn?=
 =?utf-8?B?aC9EZEhIaXcyV1RWRk5teklCMlpPQmVSOGcraUoxY1lZWnFja3ZyUTllWHFL?=
 =?utf-8?B?SU01Y0Q0bi85TENpd2JDb1hrU2NVdEE1RndrOGRaN2VOWjJtbkVxM01oUmNn?=
 =?utf-8?B?a3NrZ2dCa0NWeVNCdFpTVk5mVktlcWJtdW0zSzhpM1ZwYldWOHYzYWNBaHYx?=
 =?utf-8?B?VDZCL3VQb0pGNVdseWNhNFF3R3MwVEpTWXZ0bzFrQkNKN0U3V2JZdkFSS0hU?=
 =?utf-8?B?aFJrL2dseWdxb29QQ2prN2NkeldORXMrMmVtU3psVHBMZDNvcmxtVmVxSUIx?=
 =?utf-8?B?L3NYa0EvZFptdXdZT3hNRnFETXRxczBwaWhyWDFHNmZCSTRyNlUrZGJXOHYy?=
 =?utf-8?B?em9weUFPK0h0amhTUmpwWXVhQXg5RDNmVVN2R1NjdWgwcFRyYUE2amlBUG5l?=
 =?utf-8?B?eGtDUUtkUTlDeHlCUnlrRWdwaUdPaDF0cHBsNkRETm9Vc1N2OXlhbmp3RHoy?=
 =?utf-8?B?RVI1czZlK0VLczQ2VytmejVkR0hVeGdvaGk4QVplOGxzM1VSZjhjeG51a20r?=
 =?utf-8?B?b0NMRDR2WWNQTU93c01yblZ3dTRvVVE5T0Z1UENFWnZTaGJQdSs5dlRSVndv?=
 =?utf-8?B?T2l3dWlwMFJNYkZuWFRLSVBsRlNFd29ScEtzR2NUd2dPTVFmTDNNTUN6V1Jz?=
 =?utf-8?B?MkRHYmNWZGFJb2tJTG1IdVpqNkJzNlBDZEQ2NGlBbW1LZCtwNWI3UEFWRWZR?=
 =?utf-8?B?OHkrU0RuZHRKY0R6cm1kbjhDRENRdVlwbHArZDdrbUxPVDdvejh3ajNqNFRM?=
 =?utf-8?B?QWkvOCtQYlFjWmZWZEdadExTTWpHbkdHWHlERlV4c3JwZ1BSaUV0ZGhxL2lQ?=
 =?utf-8?B?SmFhYUh5M0FVNStHdzIvVlBLTFFGWm1JOWtRRTVBd0pUenZlY3RGalRlaUh2?=
 =?utf-8?B?TmVNMTdBREN6TjBRR1pENVRiR21LTTVoNlZPRzU4THQ2T3NHYzlRaTNVRnZR?=
 =?utf-8?B?MFlFQ2RMSkdUaWhRVWF3SWRKWjhnRVR2VXdRMi90dnc1RWdlelR0ZUt4bnNN?=
 =?utf-8?B?MmhYcWx3dzlnTnd5SEJvcHVGd2xGa0kxVkZQZW04cjNYVzFDaTk1SjJVekg4?=
 =?utf-8?B?RUpDNjBzNUh5bUl4T0JWQkNHbGNjS0dWcnVOQjcrM1VHS2RFRjNaYWk5QmFM?=
 =?utf-8?B?dnAwNUZQYlF3WGtjRnhUbzcwbVBHdFE2NlM1M092aGRvdnE1VjlFQWhwZFpL?=
 =?utf-8?B?NTczQ1puTzE5NGpXZHl2VXltZUMxU1FhUmtQU1AzSUFtT1JkY25Bd0dHMG56?=
 =?utf-8?B?M2d5cjMvNWFjV3ZzZnNPUjdMWXpZR00zdHhxcTJIV3A1MVlwTmovRjlnbTV0?=
 =?utf-8?B?RmZDbnZ0SDBENU44ZlRYT2JCTDJPZHhFT0dnelRFNGVCa2R6b0lDdGZ5Z1FN?=
 =?utf-8?B?bGNrbUhtNlYrblVDNHduTTdrVGxWQTJwNVA0NDZkeDV3UTB2OFVsc1FKVzdL?=
 =?utf-8?B?ZWo4MEE3ekVsVXY3c0pGM0dKTGZVZUdTc1JGU1htaXphZno1QlF2N3l4Q0ZL?=
 =?utf-8?B?d2ViSGZZVXNpT1JvRWdvTGRIU3FabHFZVndhaFpLTzFBUXFGdC9HdmNYZlVS?=
 =?utf-8?B?K3BWL0ZsQW1Qd0dENHpVNGZGU3N6MTdwbG94MkxuSWFZdmEzTkNYOVh5UlI1?=
 =?utf-8?Q?4MGU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa313d46-1964-4fe3-1401-08d9b9b46194
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 19:04:23.4012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rmravhojZTR96khlfY+MDLqTHHjQYOwnxENkFovZAPl5wbn82u5hBG/8sQXhx38j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5192
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 06, 2021 at 10:13:14PM +0200, Kamal Heib wrote:
> Fix the wrongly reported max_send_wr and max_recv_wr attributes for user
> QP by making sure to save their valuse on QP creation, so when query QP
> is called the attributes will be reported correctly.
> 
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> Acked-by: Michal Kalderon <michal.kalderon@marvell.com>
> ---
>  drivers/infiniband/hw/qedr/verbs.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied to for-next, thanks

Jason
