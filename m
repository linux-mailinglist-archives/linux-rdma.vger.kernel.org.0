Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626FC718E65
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Jun 2023 00:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjEaW0U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 May 2023 18:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjEaW0T (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 May 2023 18:26:19 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8DC9D
        for <linux-rdma@vger.kernel.org>; Wed, 31 May 2023 15:26:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CR9vYBQ/MPHhFo7WB2RvyjbbqLLCUKwB4YvomsrStmUu1aYP4vL6afq8pHvg6N4gFmviHR0xE1+IqHkvfS9QhZcBInR5oOKbf9cwgH6GLjRW0eAgGxMyJnbGEdmDcv/3h1/qmZIV7k9zesU4o54Hs37fEyWaMaJm17SBP3FftrOf/dQPoyQA7xMckccWEobOeme2EJVs4Q7y3AWW8VcWp0fOMZJaroYEAgdR4Jp8tgSwYhRCaj/iNc40EqSaEEzmd7WeahUin9007F7hVz5hIs8hu4AUgEIGdctMyGhQf2lEDY6bIUbtNOrUqjv1xDhMEw1bmTjf3rzoi3hrvWzt6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZbMx8fiUxUQEbVLeqA2RKuOohO3EQ7VBClRF9gGf/c=;
 b=eXWwJuBvpK/q96cGUdxofm8CUI4b2FYxHJi6YCOjA7kX6x+ZhvcNTJv4lagj+2atelsN710we3rhXBKY7A7kHwfCO0d+vbsEfWrekGQVBjVaCvkgl5FBlFH3uDVP9OSANXdfbybqczfy5M8MjbCvaXVZxyv+Xzxh2jDnN7K2QzKPny3PguQ0Ya/xHJxFqwp+bSbAAAqpjf/GJm/2WqWke0ddIeT3I8vOlavimnV9/QWq/crw3fhKAeURrLs+OVr9LjfcpCrpkLwFRLRrRW1gpbGNUVZFZf3Ea2ybbiZySiugGgLoGC3sNUcVQ05PxdjjJrPcB6VABJ7SsJG+EaxPNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZbMx8fiUxUQEbVLeqA2RKuOohO3EQ7VBClRF9gGf/c=;
 b=B0hb9Lusp42bMnI4mpbURlgBwHmyrrNLMLAFUuj3P/n/FoJpAqsQj95HQitPRd7IiDnZTdWeOmZg+D+cD8lSTHG29Pr378J1pFOueiylMLVZCTW4la2nQhdBmhtalgYjesFp7X3ilbdtUnOPRDZPFwPHuy0WYkEp3YyemmrI3qymHn7nPjDkRIvGIHiwz3jFD1HpbnG3ppyWjNRv0c7UekmaDsHuNOq1rLRcOM/NvvTFkbSlfvH+QQKXDzVsUlY4KQ+8AUx1cTdytQRn40AfWI0nH2DTheUXeY/zAHzIZBZeUZvJMhl8A6sCPI67iVafdI+vqrIAEqjvF+TXiHePQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM5PR12MB1340.namprd12.prod.outlook.com (2603:10b6:3:76::15) by
 DM4PR12MB5263.namprd12.prod.outlook.com (2603:10b6:5:39b::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.22; Wed, 31 May 2023 22:26:16 +0000
Received: from DM5PR12MB1340.namprd12.prod.outlook.com
 ([fe80::acb6:3bf1:b720:530c]) by DM5PR12MB1340.namprd12.prod.outlook.com
 ([fe80::acb6:3bf1:b720:530c%5]) with mapi id 15.20.6433.024; Wed, 31 May 2023
 22:26:15 +0000
Date:   Wed, 31 May 2023 15:26:13 -0700
From:   Saeed Mahameed <saeedm@nvidia.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Eli Cohen <elic@nvidia.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: mlx5 WARNING during shutdown
Message-ID: <ZHfJhfnUhhp5xJY1@x130>
References: <19D363C1-86EE-4A0A-A204-38A37AD96EF1@oracle.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <19D363C1-86EE-4A0A-A204-38A37AD96EF1@oracle.com>
X-ClientProxiedBy: BYAPR11CA0080.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::21) To DM5PR12MB1340.namprd12.prod.outlook.com
 (2603:10b6:3:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB1340:EE_|DM4PR12MB5263:EE_
X-MS-Office365-Filtering-Correlation-Id: 1001c490-b4ef-4d75-954e-08db62260bd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NNe6QZuiv85+GaRRZ4qjGmu2o4z+WgjK4281Hyei1uoZoL+V02JSZw5Uop/DxlxDbx9CyDZF2FXLdZ6/hV74Es/xwNzRjv+w+AdBto5I6D0bYDBXZH7lOnMuf/9blkAdXqaQXGV7H//ElgRXErKmGXWntHsgNF/5kflECq8/HOPyuVTYwHLxX6xAtf4WNEi7MYvBdQCN+E9eG+Rv6ll9l8HEDoojoCzh/jH59nsSF/ENAq4PC1jrMgmHe9g0Ni7u7tzV295sNEYVXolQ2cExtl/jpLIQ/HXjQipuQJQonulup/rUILbMZ6YwsRxsGf7rgmr/qgm0vq/xITxe0neXWOWDlwiKGOw3vK/ntG2YDwT2ZItA4WuwOLRgUlTWvAArm/vCu9Ix7HOo+z5hSUI6sDDCL9niq7wbpqIzInGgIwRZp+5ZT95Hqkv9MkZgDfQW5wVXfgXS+rkqFXKrYoN+YL4cFQ/lDieU1yj9UL6TdALgOoAuKjXE1LbR+ioOy+A3hEYSsqO5bwtRT0J41Xsvp+nxqmEXErg3u9z8aFJN75SWnn5+vd3VzqM6MyD7GuB6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1340.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(376002)(366004)(346002)(396003)(39860400002)(136003)(451199021)(66476007)(54906003)(478600001)(5660300002)(4744005)(86362001)(2906002)(8936002)(33716001)(66556008)(6916009)(66946007)(4326008)(316002)(8676002)(41300700001)(38100700002)(186003)(6506007)(26005)(9686003)(6512007)(83380400001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XMaPhgQVUGbo7f8pzLD9Q24Ne8HT4cmmwFGVqLqZP7ia/8e40hfKlTC8Xsan?=
 =?us-ascii?Q?v6WEQvvw0Fg0NrG4XGV/Qn45AAzo2TiqLVrG86Ldins+fRCUDYbgzYpMLbXV?=
 =?us-ascii?Q?x3YVhTnZ8a6xUeLPMhXQksXdqKgT6fee/SE8WXcPeGiuPCybB24TplgAmNZS?=
 =?us-ascii?Q?eT2JnPziYdiUHA0TQv375je058VoElZWJ8zKDZ4ocNq7PNfZzUIuwfnVo/4O?=
 =?us-ascii?Q?+tFo4xY5g+jC65dCQRvsQT9MPiHlNImCICwYMlBxoOmV/LAE9QoN2obA6ycu?=
 =?us-ascii?Q?IDXNOR0SCQNwsVo+lAF8zsJLyP73mt2CEqeVvdeusbF8q40w1Xi86dePAbtd?=
 =?us-ascii?Q?a70giCgYvBpmv3CaKJu9d8PDAfiMf4dQ2WnHqY2rHWz/5RPdEEciho68/jff?=
 =?us-ascii?Q?0M7fJGcG6hx7/uV2Vf4jtFB/fjJ5zjAuZj9iBlAZOMjyKJjcPl5OAchnXL8i?=
 =?us-ascii?Q?89kzu66MvKZkDuM8hyXr1iGMJUWKnUM2DpQeKHCCztlK5VB91JTXGz4EdCPT?=
 =?us-ascii?Q?pbi/rQB1bYuv+SVMwdAMnLjoK9QglTxLNjd4lvU+ykWN/kmHWhrsPcEKOIzj?=
 =?us-ascii?Q?o7oBKnb01HOOk2l1sYcu22GFwyMBSFeqMFi8Qp0LZgvDhnm0QMUFfzD+ZmOT?=
 =?us-ascii?Q?yqCx0EwcZhfmZ8TqlnJ8IJx60GLQZIbJcRzLqBYXTMymf1qU+iRDp2EH/3gi?=
 =?us-ascii?Q?RaZWWgb0on3RSTFBSR66vP2fcfCqZFyWBX1H7q/ZUgho+2/BGd+LVfZJKttD?=
 =?us-ascii?Q?BGVLuuqaIE3a76XcGvgXuguaKtgWFE3OTOHEoRqwHRlr2AulAYTOysh6mKDh?=
 =?us-ascii?Q?tcRKjYSAPtF8CD+biubq3e+a11qBp2BYqFPoHifU/1UpBjPqgbhkYG6Ko9RS?=
 =?us-ascii?Q?W5ZtdzCLraI/vqUI7Up38I3hzvdIktlzxW2tguUinb8v/3K1xosQo6vzEVVT?=
 =?us-ascii?Q?nTK0IyRWrj1EUUhOC8mdALdSNZ6DeDgYREnCxFfmGosQR1Ej63APKSpounmt?=
 =?us-ascii?Q?7ce4NnqKtD0HIn8P/8USdXJCovcS1Rg8Vf/QM/c9R42nJdVgkVSPwH0Z4Yu9?=
 =?us-ascii?Q?QagXo6WNu7TWjMke/AXMFUQh+erdgnVVz8gEo/Shn0hAvvof5nkJJaBe+Bwl?=
 =?us-ascii?Q?tIpioa3Pld2U7gv2qeH2WktBon3zkO9UNtr0gynMd1ymNitjo5592lpkQyu1?=
 =?us-ascii?Q?cEC9JdByAnvwoiIQ4+AVSlKk7g7hM0tcdehX6az0JHiyoltXV3ra3MqhoO8/?=
 =?us-ascii?Q?Q0z8ErHuEOQhW5JbnFDyVsaFP4Evu97A95KxIP3J1a0COr9G/hTHIkadIB8w?=
 =?us-ascii?Q?Qmdan5Irgyr0gqu6mKM/LOhc+yMFPrCv55yHdUX4gCkiYVrYLqPRdiQahf96?=
 =?us-ascii?Q?UbNYuZZPSZ/C5atqjYmRi0W3D9NQRcDHa5TPDOp2gX7a9Fs3Cb70CMA57U79?=
 =?us-ascii?Q?B2teYm9GysyxjxRbkZ6vNy0cS2yZdMz3yuY7O9DCmsB96bg02rLP/BY5zLLQ?=
 =?us-ascii?Q?jWJQxNVWZrbgkhTB3hQty1cnBYdGvcAMssGLAakr+wDAo+nHyLAoAZBLn8Be?=
 =?us-ascii?Q?mFGUZ1TUwps1krhQ71ayD71kGT4UnCX6a8H0+pTy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1001c490-b4ef-4d75-954e-08db62260bd4
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 22:26:15.3437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A58+E8yZCvMn/SCJLG5gN8KWbDdERbWdkIEg4ZdLQ21wA7byZpYIlcoC1PRwxcAXfNj5zL+NG6IFh0btq4tcsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5263
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 31 May 20:06, Chuck Lever III wrote:
>The below WARNING displays on the system console multiple
>times during shutdown. It does not appear to block shutdown
>processing.
>
>This is on 6.4-rc4 with the mlx5_irqs_request_vectors() fix
>applied.
>
>
>[  270.146851][    T1] WARNING: CPU: 7 PID: 1 at kernel/irq/manage.c:2034 free_irq+0x59/0x70

There is a patch pending submission to fix this, Just CC'ed you, thanks for
the report.

