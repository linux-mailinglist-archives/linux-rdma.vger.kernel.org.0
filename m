Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39262611987
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Oct 2022 19:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiJ1RnX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Oct 2022 13:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiJ1RnV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Oct 2022 13:43:21 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6A422BC81
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 10:43:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DuXtWVmfKK8q8AeuzhodxzUZNBnxeBk92nYk7j12Dk3jRk8AHeYIE92PDg4e1+htf+053tfnhjn4YVOOuY8WqpHeQBeDht3Uopy7UJnczCVKEopD1OmqJEsfJvhe0hyHy1TaXPTglRFjqsigIbEZxut3EC/87O7nwRqL4/pXLa6h+rE+UcBOIHxBdCJ72pz0bIdasNsjfNfBcSydy0qEUXty7xmc0mVlGgAO28R4q4sejxifchjh/yg12JeqdP/NgDRXElgZoky3cQLlYOcJbB6Bmv3+gEC7/Fboz456qmZSqEKb/zigSye7Jekwpcl5V7uxbZlnWGFzegL4GJ9+9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3UChUERkaOG92ZalN/vFV8s2adqNXeeXUwoez+hcLA=;
 b=V4yybx6ihYE3TvQC1JWC4vR8bt1W9k3VK4UhJu6wB9J23cFjCRb2je7HMkmcNFga1xHqimm3t5nSrMYeDBisnTXaAxYPiF7k+tUH3Id6bNt/zuDKE6yxG9ZoaND0LShVfOLoJyYuim2Br85iFKmVBTXUkc3428J7zQqcRjrPWHETzdCOleWDrIKwj+shH7Eo9s5QEqLUbeF2r1NmozKMwPXEow8EcKvpiqQ4U0t4wrkBAttr6mLK3mV5dzqddT5cmZu8Xr7nbOY009Z2YRJhQ004jXK0DMhmi2bEi+MeoAnJ9on+ors7uz2TaCHTotznFlOH13qknRMgE0QM+7KmGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3UChUERkaOG92ZalN/vFV8s2adqNXeeXUwoez+hcLA=;
 b=KFRq2/eK2vUmtRQizHQiVKgR8uZuHn43r0jbHNW943kFRNsxBigllh3wLtXD63/PMYWYr7M5qOaxrX/pwUqyzutl/YvgO1XDR5qoFHur3hXaNpyYkiWtQPGQUCiyav8O98PUT/PNBNA2GBTSp2hAnCfd2xT2KdUgGKePYdx6rHBzuocSh5k4lBdky9TTx2xqK9/tDWUfULYc85L1v0AIDRLVoC2kZuNcSgRDIou6eTMpu0itd4/Lr/LVpNlwuxAqCIVPAL64FAUgtag3Go7AcaGnYd5e6+cThwyhQY24n/We15bZJQ51uyqTpMsSioz0r5QssaefGvRxqjwYnNGkSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB6813.namprd12.prod.outlook.com (2603:10b6:806:267::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Fri, 28 Oct
 2022 17:43:17 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 17:43:17 +0000
Date:   Fri, 28 Oct 2022 14:43:15 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Pearson, Robert B" <robert.pearson2@hpe.com>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next] RDMA/rxe: Convert spin_lock_irqsave to spin_lock
Message-ID: <Y1wUs48SR9Kce9Lp@nvidia.com>
References: <20221006170454.89903-1-rpearsonhpe@gmail.com>
 <Y1wSRyFc809rFohX@nvidia.com>
 <MW4PR84MB23075142FFB21BDAE8B18D0BBC329@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW4PR84MB23075142FFB21BDAE8B18D0BBC329@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
X-ClientProxiedBy: MN2PR01CA0028.prod.exchangelabs.com (2603:10b6:208:10c::41)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB6813:EE_
X-MS-Office365-Filtering-Correlation-Id: d25863f8-05d2-407c-1c82-08dab90be54f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A/PapJez5QnRe6K1ODrzqY3UsELx9/jt5tFAYvCT72/AR/mhURLrpd6dAaXrBeyCZQfou3mjGZRS6O5kzwQqpk7obYnt8j60K8sXUvMTYBbKtDpQ4JmTfufx3ReT9t/J2FCPqXkrjnRCdiwF7/3NxWkckrAzME4yFGk+FSBzJNFlDM+wFE2hGpBKOm0dAIrDpops4svwgRlQ47fEXQvUvllKbJE7OI33E4Xo+iju6JXy4mOe+WT2GXWhpN1SBbNQSzkZGRI7+KI7ZewKcs/e1RpoZsrARC+vu/KwiMr4iREhv6lm53By0Z3JSEyXK+hRKvQmLKsixAsm/yb2DbfeoQ2uAzrWkaFJSYQlYmU5llWbbTuwR+ju0nwomzU44ZMpvA9LpyNIt9QusIzYSMEpOKBSctWdiUTqGz6YQjxfkx0OPPVz1jWohnymSo84QkC2BhLtfwenrLhQN9nXs8mSe18vpDkiy2wKtT4C7DKyYcdcKz6jvu4pSMuZWSOAJd0egC/KPy9Jr4/4IRFshjya/NEUbcRv2rve4OQPEbv5XNm88jxhBBORNRFm9zdTXLIB6vtny91RcrAr9c+J2u7fx1F0IXJhC0P22plD2BacAQ3VWEFfneWG6G9KcxkgNt2h6/njaQQjfdcBteLmZG7MqnFL7zceThOmXPIFMTZLW2tj7oa5Pm8D0I0ENSB0GfO6jgb4waMsgqethuC2ZVq+rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(136003)(396003)(346002)(39860400002)(451199015)(296002)(316002)(36756003)(2906002)(4326008)(2616005)(54906003)(8676002)(66476007)(8936002)(5660300002)(41300700001)(4744005)(6916009)(66556008)(66946007)(6512007)(6506007)(83380400001)(38100700002)(186003)(26005)(478600001)(6486002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rh5ahROAoTc3e0V0LOK69HeCfMpFzVOxtx+ftl4L4mk9IFUPx/5Xvz85OzuG?=
 =?us-ascii?Q?r6GbgOABiNaEaOhX/OHfCfmeFh/SAlaJEd6afFkbmntPMDyiRbV1J1bla/5c?=
 =?us-ascii?Q?lbaUOxQ7/h31lFXs3iiRuw3Q88QHtBLT3qin5ogIgXxca+JJc7wcpI5bqIfU?=
 =?us-ascii?Q?w8+OewscXqYG8IhxCbbyM7RB2As06wTfVEQB2SE5ZCA/ZOHrE6U6JA8KzA8L?=
 =?us-ascii?Q?ZhlDRN/eFoZ2LtJAm3crDpduz4j5eBlIEbqA6vsJasRNAQKjwHubS6UAaFl6?=
 =?us-ascii?Q?mjpdei10wUYqVfhGZwP6ydwgmzIacDALO+nmpcy2RbgmW06aZoY/X8OAsH5k?=
 =?us-ascii?Q?KDxfw8dN/4NDmlYwE0w2apQhQWEstxmlsxOML9LEOU/Wqud3wjtVCihuMN88?=
 =?us-ascii?Q?lKM0E43o6ND1Xv3uSmYnI50HtqEyCir+DtCxUjFueMFpidvjP8YA8WkLhkfv?=
 =?us-ascii?Q?t0XUotEfh31QFwJuBT6peEd0pIGuo6SCOJDV/5FL3SWT/T0vELo6ol4jbigL?=
 =?us-ascii?Q?7nyE/E5VmxkNEpFYca6TXx1Yeb/QWsrlE98ZdXhbl79BPCZ4y475czZFObzl?=
 =?us-ascii?Q?ELWDkAemHzsRYA1pNy8Oema9t7ijqZ/LzcRXCk+Owz0IaCSu4mom8PI/4p7i?=
 =?us-ascii?Q?zXuR+Qpi7Jqu+AlB+ckhwTrywKTm07lxjknzDOEsA1nd29LMYx00gqIadv2J?=
 =?us-ascii?Q?VrsHJ2QGK5NJaXMEt1ynyKK4LkNZSWd073U69sPWxbDXROn/HFETgmaFMHTT?=
 =?us-ascii?Q?G7TMC3M3chdg6jLZlez+N6DFqY28lpU6aSboeXzwZdg3FC0JvNk5mFxLYpuy?=
 =?us-ascii?Q?mvPlFls/MaKDHlxfjHmJdnjKnLcuUHdachROtaZNL2QOaymxY8aYckYGk8OS?=
 =?us-ascii?Q?h/kVKsT0lPLJ8lI38xE2TnbH3c0QoCkvFj3eyFfcdDKG7GuzAGZgFLLJr3Hp?=
 =?us-ascii?Q?OGinqA1hNUzJjQMB5MuiG/izGkXZSb8y5q7t+cgFwMjZO9jRxpRUHSlk8IJ6?=
 =?us-ascii?Q?NkNAVE2VRQE5s9JCXL5ONkUCeqm4ONGlHK60t4Tn9JQETILVrL06Ehi7UBe3?=
 =?us-ascii?Q?sdxSy5UezKGi8diJ677+WPbvWDJMUgEVp5C9s5putq+D4wayUqqy9QpReOEu?=
 =?us-ascii?Q?iLFn9Qmj97I2ndq/c+7dugbxHjjqUAgFNFucs6fxzX/UrhL4ydpuekGftL9H?=
 =?us-ascii?Q?IAx8lsuiv8AmTZH0EtZiCdjZxkbppHXVkDoKyNpcoHHZptEzvWT66135KlJL?=
 =?us-ascii?Q?cJLTlujhfNWey8jNk+dKwgEFN3tmtjwn6IDHKZKFSY3k7X32EL5PUtPDA8A+?=
 =?us-ascii?Q?4JMThxaAsdqq/19IAz6eoZQbuRYyx9dLmD3tocieZ4KCj8f1JDYNhhW3Co/p?=
 =?us-ascii?Q?KyVMsQYVd9iI0TYEzHKD79KVosNXrKCqfko5iSKrYzSJa8QI0TQxzVAspIHe?=
 =?us-ascii?Q?HwRsmFlh5wlTQDmd3Lqopx6hqJevrmrvqYA98evCojoLOrzobeGA98fOqc1r?=
 =?us-ascii?Q?ByfDG/Su0JetNFenSQdef5vZ7ZsU6qqemBXhhjgIdMkTTtneK0BkeUfu8NAL?=
 =?us-ascii?Q?AXZz0/cQVOzjt9DOb4k=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d25863f8-05d2-407c-1c82-08dab90be54f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 17:43:16.9917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bCxCTv1hhSz/nPrMb25Yg0thT/H1fzOOPOZ4EA0hGjZ3f+YMqMeXCcDBZf3psk6J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6813
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 28, 2022 at 05:41:29PM +0000, Pearson, Robert B wrote:

> Yes. Every time it turns out that you really need irqsave locks for
> rxe it is because some maniac is calling into the verbs API at
> interrupt level. I have run into this a couple of times.

I'm pretty sure post_send is not legal to call from an irq or
softirq..

Jason
