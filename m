Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3AA2637F5E
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Nov 2022 20:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiKXTGB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Nov 2022 14:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiKXTGA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Nov 2022 14:06:00 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2085.outbound.protection.outlook.com [40.107.102.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B4FD2346
        for <linux-rdma@vger.kernel.org>; Thu, 24 Nov 2022 11:05:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dt48eUa8ABIalr4FyE+Sc75bcYzSJ+S/PrMC6Ce9oA238CL3Ng4ZgaTPIwFoMSYXYx71BvJykoGahe4tAP9u1/Ovr0mcpCQq+nDPIdBCYxzYdl7He9rqpQHdUEz9VJ2fzL/u1u+9LhtJbG21AXWxIO6hHwcKCP1uuoWXyuS2G4R49/AQ/IEYXL8yEYx/K11MNaNed98V1mxCSzDSTc6CqgfzQUdIbYN7qlLDq0YOrdR4mm34puemGvsMFa/ftR0hP3TgNnMS8NLDE+0oIecmTZptLDL7pG2bSL23sg6ZUqIL2aiT3Fm3iOF/GhQ8yrJosCX9lpFYxTKtSQaH/6fpYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4H4zOulf8oLciN47lOugelt7ZEaTSJto5gGJUdwP2wc=;
 b=UZjrVXpPspTmKopL+NHmPLfPRAkFvNKcphmXHEd84nmtIIsGVp5Q99+OhiN/L4BzLCK+eTozU830wLwV0QGGZxr4YY4MzdwYOlXnBGa4jPBWee4jcPRiwFo8vPabROLKEe+jaDD5YuMiPDZLJavslBCVNy/+8Sz+JIXbZ7c1DWKakYjL+OeV3o3MO7cpioe+CqCfhhWXn8579fhG+SV3vWJybrKKLQaE0jv8hnw0dO0RhjuOq4/KXS+1jncHto/cLOHd6wYNZ3zQEJJNvdRmnop50OvMbyXUzLSPsFrQwXSzH90r//TNL36rPkaqwxnZj0jfsXsratDk64yiTTTekA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4H4zOulf8oLciN47lOugelt7ZEaTSJto5gGJUdwP2wc=;
 b=kUGcg7mcXqQVQDuiXjT4UIwgCx9J8YDAXVENGa42viHIK9JmSlyUtPKFwvGEvzUxy8bLY1bB+fbrHQxgh63/j0hjAx1IDXT2LyzdccyOGg88SHKlFyzCKjkhdQptmMQfoJBbVavAoMvW9MAEhHJIRGGaIlHZ5gGHp9EiMB2O7hGeXqg5EjCFcB1PFgZCIbXcZUUQCqyrrVQIbpLwymgKunjC/IaePrBjAa7SMvfN7yeeFKVi5vlwtE6YuYcMm3Y+DyzjLcGP0/u7MoPpaQ49mm+Vrubt52OPwWMAcBKqB0Iv6W1kblbqs1jOXtdujuxeioHrHoC9tSAht3YuHwW77g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH2PR12MB4264.namprd12.prod.outlook.com (2603:10b6:610:a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.18; Thu, 24 Nov
 2022 19:05:54 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5834.015; Thu, 24 Nov 2022
 19:05:54 +0000
Date:   Thu, 24 Nov 2022 15:05:53 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     leon@kernel.org, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v2 05/18] RDMA/rxe: Add sg fragment ops
Message-ID: <Y3/AkYDe/Cs9FeX0@nvidia.com>
References: <20221031202805.19138-1-rpearsonhpe@gmail.com>
 <20221031202805.19138-5-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031202805.19138-5-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR01CA0064.prod.exchangelabs.com (2603:10b6:208:23f::33)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH2PR12MB4264:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ccb0555-9fa5-45b7-bba8-08dace4ee986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Eq8ybuecTMkvbn5QVnmsZQYF3oc8D8FU8qvkPk+8gg2nbGLBP48dojPcQ8Ebydz45RrTLQM59UI9uYfTlr8WqAI17xi9kFXcDjUYqmeWDcfyFoL2Rqmw9+I0RX/ZPNevhppVcMNR21r4MPbWfoS+yyTEp2yp2G9xMYwmFmTc/2pfrSNU74zaFQQg4sr2BMsBA8Yd2ZVPjhwEdcgLgU+X/G8WTrMRth7YEKUJwqzEVyXOpa2AnF/UPBhTnMXiyRi2Vl79J3hBDskHoiwCMoAWtlUiOmA4DhOm7hw7w/Yr5Y+K3I5IHQW7rugdUGxPY7Ut1jZu24Z0Gr9SLmtXO0Xr5hDB+O0sZks5a3RIbqY44aCvWORl7MzMqbBJktcGFe9X+COO+gyVUc3QQ+s+45j5KKxeRZ95VINLkFvLR7amhcSGj/Gp7PhTutO8CSzjOMpUHBzqkb0b8Tdk6uer4zCTf7om/j5gBZ3UafFaNj9qu4s65hob6bn2RDb9yPeQmekoovhaV58hhCnOd5JnU8MP/FlSIhhh5BDCERTTr5Dau0MeeLfiCt5BvDIdT/meu9ivc6hOrt23VTMsuTF0nJBz82jKvOZYQYIH9842NbUncZyenBQe0AtJNps5ZIa88I32wikx/D7TLbk1fR+YbknAzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199015)(41300700001)(5660300002)(4744005)(66556008)(4326008)(66476007)(8936002)(66946007)(8676002)(2906002)(36756003)(6916009)(6486002)(478600001)(316002)(26005)(86362001)(186003)(2616005)(38100700002)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5dqzQzFQURbJBE8w0gPHxxOixwGCx5sD4G6ND39c9MDtUVIRjCOmiLUJuHZM?=
 =?us-ascii?Q?IBZ61tz7sE2jse3RhvzoulGDWLXz/02AIVZyXRoRNhnvBWHBhblpbkSZfs1l?=
 =?us-ascii?Q?VcfKkUICpC+ii10TO/CAywZToOEndcU6DkdhgOIAB8ANWiDodpGPBcX3TYZP?=
 =?us-ascii?Q?s5/xkNdtr9wbXSXZnImalPrAGRpRKjZjVx4cD1HH95klpNBvrlLMMSh4vTMh?=
 =?us-ascii?Q?AIzz5Tc3vsQzFXmAqJIVDp62BuXHLAlcOSCGeTDhhmF4zGyW85AERifPyKet?=
 =?us-ascii?Q?wWII0IbHMJvM9R3iAzWGQNv30jsweR5a99lxmaunnXivi+XRFf6L1U6qLbiu?=
 =?us-ascii?Q?qDYjAiR4zUM5iPzzcZTf9uGUNMgZ64KsR8uYjt0Dt1LMA2J9RWZC6iiP4iTw?=
 =?us-ascii?Q?9XY8yU0xAwk3VhMVOO9g0lkuHqE+3jeD6El/2WDeoP4DAdnpKdvDPC2fSwMg?=
 =?us-ascii?Q?fXtexysXxoTxKf3At6b/FWJkYUtZ98DAC72rqP4llSp2CIKSzvYnH2C6FJsq?=
 =?us-ascii?Q?JvrQd416/pMJQB2sBYqVODu5mESsSApykfJFDRhyOad0ts/pzMGS9E9QD6fQ?=
 =?us-ascii?Q?wnvPEnUPMUuBEqjV/ps+gVou63nBkwAY97BHGW9eIMdZGcB/jxwVxJ1jTu4/?=
 =?us-ascii?Q?OM6xT8NCTH50v6vNY5Z6daExGAPGWfa+I4qo8gXZdpqd6r7+/Y7r4aWDPuAD?=
 =?us-ascii?Q?kWgLPC8ODQsN0vIlp8IOK9zOQ6ah+Wd8vm8FgdRYhaixzcpCz9otPhnWhx/t?=
 =?us-ascii?Q?13dKGkFDf4ahTF48lAQeuGnIb20mLv/BDBCbPhPTaZH7jcdmeMK7PY+QNYKt?=
 =?us-ascii?Q?Fg9Bk83hrqfj4x09qeg1uSzvk+2fpzFSjtV9uB5Z25/mvuk8BhJcVvEWQad+?=
 =?us-ascii?Q?XM3Hrq0DQZeWFVjVXeGGUnIGpxqgvgUGWhmFcyklsRNhIx/kBSjGgOrHs2/o?=
 =?us-ascii?Q?DZWxi1NoHh1MmZwyxi0uKM8Op5HJ+TQ8xHWZPm3hHXOPa288TakSOBH6g8/Q?=
 =?us-ascii?Q?VEA+yZcI8wtF8aHfISxxUvUwSaBP7ZuIV8JtaFuU1Kaio/ipQNoSq53NpQkO?=
 =?us-ascii?Q?tQlkBEC0p8ONIDj+GJ6TH/qUJqZ9Z8OB/gcUvf1jZTV+BzW+Y0lNmLX+nNOM?=
 =?us-ascii?Q?Oc4iq9iX+rwBY/bpSOmv/lI+kB6+d7oUSXYgJHCsDxfNbG8u/v8dPxJKFPAI?=
 =?us-ascii?Q?DhMqe7DTsgXXt35w3y0UMsZnXJ9lmGxWhPq5AWfIxB2yf8nYUya1r97smlSc?=
 =?us-ascii?Q?w02DGa+sJwBHNzhod1+S/DygVUTYHEkyqJtZ0u9Oz53xtX17cswjcB+1AXD7?=
 =?us-ascii?Q?qK790b6togHOvpQwFTBrfNbcTZplrq9XbjwE8dv/srS7QCYvHZAMwCqr3wVI?=
 =?us-ascii?Q?R8NA+nfbx0PiGt9st6oGWwqLS5yQS6YQuVVl6GEN0fuQJcJAVlwiU70gRt6Y?=
 =?us-ascii?Q?XXZLms4OTHKPES+N1nZrepurQ6ejnJDB1wHSTsY2aArCN9NH4XWeK8utH9AI?=
 =?us-ascii?Q?XCE+ybgIo9c2cABgLJaMyyCkSepx2CKpjtmlTEJSVbL1CMTDfjZ6XlDCFhOY?=
 =?us-ascii?Q?1gfjJMoJoY74Y9lsjzM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ccb0555-9fa5-45b7-bba8-08dace4ee986
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 19:05:54.8288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YSt60wYViqkXVGQDb/NSy3A6ZVUJ6/V2zE3DDlBsZIU4sDqOs6uYu6P0YWNX1Bhq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4264
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 31, 2022 at 03:27:54PM -0500, Bob Pearson wrote:
> +/**
> + * enum rxe_mr_copy_op - Operations peformed by rxe_copy_mr/dma_data()
> + * @RXE_COPY_TO_MR:	Copy data from packet to MR(s)
> + * @RXE_COPY_FROM_MR:	Copy data from MR(s) to packet
> + * @RXE_FRAG_TO_MR:	Copy data from frag list to MR(s)
> + * @RXE_FRAG_FROM_MR:	Copy data from MR(s) to frag list
> + */
> +enum rxe_mr_copy_op {
> +	RXE_COPY_TO_MR,
> +	RXE_COPY_FROM_MR,
> +	RXE_FRAG_TO_MR,
> +	RXE_FRAG_FROM_MR,

These FRAG ones are not used in this patch, add them in a patch that
implements them

Jason
