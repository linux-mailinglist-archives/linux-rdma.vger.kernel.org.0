Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47D272A0F4
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jun 2023 19:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjFIRKf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Jun 2023 13:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjFIRKe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Jun 2023 13:10:34 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9B73A9C
        for <linux-rdma@vger.kernel.org>; Fri,  9 Jun 2023 10:10:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORMCUC/mMMpTwit60Jb/iHVmg8UaslrhaLKwPM0uCFSuw9BVDWz8qBfrgLBQt8BGwtN0JwD1zFhFScMzPr+qL8DYj2djXuoq3WXo6Ibh2jzJrhGXZF2r9NcRuGlMdUeP3nQ7tzrBTkYfio8c+e6CLmWBlykN2w1kIf5uTnfWTcxe2QUC+di1szogcbX/LPvDxgeCaUm21NZe/BcussQlBoVWr9N9YRU2/wZHCoZR3jhI7AOc5x1qBgMZGj7ygBq+mEJePLC2YQuSPC3PjTTpj1xIpMFHLeqhxb7/MbswZgvjQn0/cTzbcFa+6KvGxURAR8AyG759qke6OgqdTwARJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBW29qiC9NgQXqra+RyvIILh2j2ZpVMeryCJDP+vdzQ=;
 b=BPg570HuLqcAKylHnV6gcJgA/StDy+anh5b5bjjd33PRzYSRk68DPjd1lRyWvZVZQL0SXIOUoxHRTc3FjQ4iSLpDmZOPsz6COro0ch90epQ/FIyrk1fwvHTSdmuKLLLkWyCxWTgF9cqBhFrAV7KEYXQ2vmt3FfCUi/Bdnhk4IZImhHvDgsGdmcrbhL+peHCzwi8sn1ZFs5gkvuLs1FZkrtkFnyVaz35xFGQYue9/JzDPQGgJBMaCcwKuJUOCTbJC/tD8ZIuGycyR/02C1wFyjkQXcXxBJiTc6lfJZ7Zsi/k9PC4dfO8Jsbnt1iJS4932nlk4BKXUVRFbkZAO8wteAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBW29qiC9NgQXqra+RyvIILh2j2ZpVMeryCJDP+vdzQ=;
 b=sQY8lfMQNoxI2hCprgp9jbD/DtNJ3h6iKf0A231K+bCE/kDqZVfWGdTLAgayrn6fxDoz+bsoWftCVvMUCrFD2r4/dwGwdi50cJsxGKmu5ljgyX8oX4OJLzREA7fPN0tzOTtJfJajyXGtbSxLZ4160Uh/tzor+h7NMOI0REJhtJThc8j2iMW6IQctNgEmtbIv2toI0dJRtVH9R8NN9Afe8/lzu0ZktgjCeIFhc1AlF2P/GFQx/bdxC7IVfYoKShrVQdRqUOdGjUMgiN7TXbI9K0nBIhaFQB+jzUWQOPAZYfawcwBwZpZAt38sK6VsW41ARq/wQJL2U1fwZhJBYKA7hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB5483.namprd12.prod.outlook.com (2603:10b6:510:ee::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 17:10:29 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 17:10:29 +0000
Date:   Fri, 9 Jun 2023 14:10:26 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/rxe: Send last wqe reached event on qp
 cleanup
Message-ID: <ZINdAjjfwldp1iMc@nvidia.com>
References: <20230602164229.9277-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230602164229.9277-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0387.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB5483:EE_
X-MS-Office365-Filtering-Correlation-Id: c1eca473-8091-4896-ec6e-08db690c6d21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KGjf/w8T3fI5Ptg9L4W3SR7wUKHmt0+MMCsxOHkp83CSYpI6i2CpPY+NEzk0BK9iZhEDELluGzKnUgTnVIot2dXRidaCA0+9VzeLrp8lPPNG5mlzBNIKWAWXNVNRhrG6lQtb6HE4XhRmfkgnov4kgVnFDf3q4RRvoQy8DxOVdlFza7IlA5jwwIDNQVK6Sh/1eL4Yth2uO/yjMV5ZJyem+Uzrm0kEqd2P2JKTijVarulmRfDf9E94l+CbGciw1cBtRvBYYm6N9ivYZJbwspfqHH8k759i5doa1ZwN11m5mkIOcc2eIwojwqnzpSUpNsIEP1dZwXdAfoIoKklT9bkTTrVPACwUYMft0axEnr9zauNG9BjT2YUi4RLHnONQVtxZqyKk+jDZ0N7bwly0rBWbBI2WrvlUMeqRl9rViEdkmQOhoidhHFbR4kCgZQ2fXdu1BNi0yIFscGb/Jusj4pRNA/b6U4nQCxm513YqWhwCg1twtVRLd6Ukmj19LZRq6FylMYqJ5gj/gHLsrn8s7YpduA9XRSCINz6p4DfzPhb3rZF9tUM7MSuqVy9aE1zDIlPQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(451199021)(83380400001)(6512007)(6506007)(26005)(6486002)(6666004)(186003)(478600001)(2616005)(41300700001)(38100700002)(4326008)(316002)(5660300002)(6916009)(66476007)(66946007)(66556008)(2906002)(4744005)(8936002)(86362001)(36756003)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2tOeTJpK1puRlRnYnU4ZmFwK2YzZjhKWmZRQys2M2h1QUFLZnZyVDZHYUpn?=
 =?utf-8?B?ekZ2Q2p5VXNVUGlVSDFLMkNHWnhveW13MzgyZ25pOERVUGlvMG9peXAyNExk?=
 =?utf-8?B?Q09pZ2hOejV6b1pHMEJ5ZXhyR2ZibHRmSHVTbjlvSHBWQVUyS0ExdTFxbGNZ?=
 =?utf-8?B?YnJreS9VMkVNd0ZuVXlJN2MwTWFxMzYrTHhjdFpJN3FYRnYxU1Z4SzRkQlo0?=
 =?utf-8?B?Uy9henUrd2pmTDZmVEtLSk90SktiR1BKVWgyYWVUVEhOVjBJL3c4SkxvUWU0?=
 =?utf-8?B?RHFva0krSU1QSWNtMDQyU1kzYWVHd2ltWFFEL2VWWVEwMEFCdHI3R0NuQlcx?=
 =?utf-8?B?K1FYNGxZK1lmdjBCTmx2RnFFOXk4ampPa1d2TlgrOXpsRkxjclJidTRNT1Jj?=
 =?utf-8?B?UXZ1TDg1SlVOMFFRQnFIMko3eTNBeC9HZnlFY3FJa3JvaXN5Y0ZsdTRxd2ZH?=
 =?utf-8?B?dC9YV05GSEZBSTFrL05WZnAxRHR0ZkZIc01IZVp4bTRxcU8wZkx1S2Y1MEUr?=
 =?utf-8?B?NS9FUmFYd0ZPY3RLUkQ2YjY0eGNZNnlENWVqaFk0WW5tSlJrb1g2eThEV0M3?=
 =?utf-8?B?cVdiNi9rNTZqQW1YQ2dGZWNrRFduT0p3MkhrVkl4T1AvWUJxcVAxYmNpQkdT?=
 =?utf-8?B?NFEyZFVoZDNPODJSUm9HNXBwWjdEZms5c3dhUW1HL3EzRGdZRGlxVkxVZDgv?=
 =?utf-8?B?aUZzYlhMaW1YdTgwbWhxalNURGcrOTRyYW9FbWxrVVlMcHJlYzZuNS9hLzFL?=
 =?utf-8?B?VmJOeWc3cHhhYWdXN0RsajRpSmJXa1pnODY2c0d1LzRjSjlpa1YvUldEMjVB?=
 =?utf-8?B?eG1vRVJISTQ2Rm0xUWlHSm5BZWlFL3NEMlNWdUovbExLb2Q3aUd1VWhMMlZR?=
 =?utf-8?B?dCtmSGkxOTVPc1Vrc2kyTWJhdVNvQkhoUmJZdGVOQUlWSVdDS3lFRkJ2WHRK?=
 =?utf-8?B?Sk1iWGFCUVNzUk42T1hMS3hidEJoRUdxeHZPZ08yQUU3Mk92SlRZMGYveWFz?=
 =?utf-8?B?Y1FFNGc2dUZ6c0xNTUtKd2RITitHdEoybGRGUEpWamZkR2lQRHRDSXduM3BS?=
 =?utf-8?B?OEhmZXkxdVg2eHo5OW9oTkhpMUZBK3E3a2hHYVViU2N6b21CcW1zQkNKWEwr?=
 =?utf-8?B?bHpST0xNV2J0blJOdENwTlVpUWlsT2dkUFI0N0doZ0VGT25heHFoUXFtQUlr?=
 =?utf-8?B?YWU0d3RjR29JbVFZUzFEN2dFaGh2b3B5OXluY0VYazBRWk1ieStUR1l4Ny8x?=
 =?utf-8?B?WnptY0F1VUhjS0ZSVDBWSkM1ZEoybkhUd1d1MEpoY0tCVnVkQktLSzB2K0Rw?=
 =?utf-8?B?WExuYlBRVHhnQmdxVlR2dWNYRWY0WWQ1enFja1BlTUp3TDlrZ0htdXFEcGR6?=
 =?utf-8?B?RzhFZ051VHdDdm15bzBubkw0SmdpUTlURW1RYzVGU3NQKzRHU204bkFRMnJK?=
 =?utf-8?B?MVFrMVU3TElDNXIzZG53ZHJkNlBNdEdOem4zcUhrM040OXBFMDczb25ENDZl?=
 =?utf-8?B?SHZRVDBMajFnLzRQL2grMDRKYXUweFhRQ1pzakZsYkl1WEVlclBleDdCMVVN?=
 =?utf-8?B?SGNkNDdncml0c2lVd2tUYzFMTkRTRlhQN1RVdTZxVjZ2aWg1QitINVdLQmxr?=
 =?utf-8?B?V1NPUktuSmVNMjR6cFkvTDMvZHdKVEdpTGN3TjBnS3JQQVEya0h0Wjg2ZFhR?=
 =?utf-8?B?cEVhQkxmL1hnT1oxN1h3SEZ0LzVTUVFZQWp4R0RXTmpiUzJwYlFQa3QyUEpL?=
 =?utf-8?B?U0xJR0lYOE41UXZsMXoxb1UyeDhCNnloREY4bmt3ajBJSXZ4Z0dSUEx2cU5R?=
 =?utf-8?B?dlZWQWhGQVJjUkdnaWxKK1F6QUF0clMyTnpScHY5OHpXSmZVNE9WOTR3SkY4?=
 =?utf-8?B?Vkx5NVhyby9zWnl6UDNudDFOMzZLUW5rczlGMGN3ZkZseVk4NzJjLzZxRFNx?=
 =?utf-8?B?ZnU0N0hRcDVlVCtGdGYraGl6azRLNXRBY1VMLzhmSE9HdjYxOTlYRm9pZ1VW?=
 =?utf-8?B?ak9aaGhCdGR0dllaMWh4SU5jVlNqMkVGTmtSL21FVnZQb21jaWRsUlducXRQ?=
 =?utf-8?B?QTE5NlpSQ084YmhGM1AxNzgzZ295TU10QkpIbzhvVzN4VlJWdmJxWXlrK1cr?=
 =?utf-8?Q?cfWPG2Cr3xt8+QNCSNF1u4QP1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1eca473-8091-4896-ec6e-08db690c6d21
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 17:10:29.5729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UpkCgdV8zGG8tW7oQ9XT29QODsSFg6PUDGZ935QlquiI0muolaZ1fT0qhcxTuq4p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5483
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 02, 2023 at 11:42:29AM -0500, Bob Pearson wrote:
> The IBA requires:
> 	o11-5.2.5: If the HCA supports SRQ, for RC and UD service,
> 	the CI shall generate a Last WQE Reached Affiliated Asynchronous
> 	Event on a QP that is in the Error State and is associated with
> 	an SRQ when either:
> 		• a CQE is generated for the last WQE, or
> 		• the QP gets in the Error State and there are no more
> 		  WQEs on the RQ.
> 
> This patch implements this behavior in flush_recv_queue() which is
> called as a result of rxe_qp_error() being called whenever the qp
> is put into the error state. The rxe responder executes SRQ WQEs
> directly from the SRQ so there are never more WQES on the RQ.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_resp.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

Applied to for-next, thanks

Jason
