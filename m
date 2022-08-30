Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7045A658A
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Aug 2022 15:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbiH3NvK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Aug 2022 09:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbiH3Nux (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Aug 2022 09:50:53 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A61FD17
        for <linux-rdma@vger.kernel.org>; Tue, 30 Aug 2022 06:48:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUhg0/iGhNiJM0mqikvDCIRSEGWnPfWQz4qN0LPNEHBorrTBJK2Njshy6oHdtfPgoD5FQyZ0hx8UVa31GdVu4dVC24ILHUTTeicO0BFY6u6EWBLSWCsfEB8OZA/H3uACJ34/XQ+WozmH5unRcpykXUnTWoujnxxh176AtxJBOq12To89GBFhKU++kITdRf4PMmmcN5W9UMnuSEnBLYEGuiV+phqbOzgt07rvI5N1uzjpX6KQslbQ/sUZ/e6OnUZ2xVtm2Nlw9C0bHfcB0SsgJePnuvZpUDTZlX2NVKzPrk9wcSasNu4QeUUHJecH2YnZE+cNAEnFpxs9s2LzwnhXWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30XCFnkfFNK5f6JnXxKtRThPIh0Ma58mKaEDC5aAH2Y=;
 b=fN7QsXiTu7oJosBaebIyykIhFQZDz6V0iLEUUfVXj5TmCJ4BafzFHcTHwujtCHrkLkEryp+jfTudDWT+NdSz3ZZzBcyeUNCvaYzHR8WzyypNakm0qNyjO5KvIK07tOdo4kqbKO1S4X69hD8eCOIXJuBV5qyrXhVx+Eowuo/AayVNWSDHMmg9O2xYQR446Zd7hM4DLZ9RbwPelljd9bOnNLzBTt4fU6do+wUMZvkpd3m3h8WlEfTUJtvDcLIi2hwTef5dSUZENLjtn3F+1w+lp6xRU4nQjOoa3LOc4yCBdpgMTcgZ8QKieQBJC1K4BflgwlRXPTreAdJRWT14bOH0qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30XCFnkfFNK5f6JnXxKtRThPIh0Ma58mKaEDC5aAH2Y=;
 b=PorTm/Vvhm4JUAZGwA8uu5d7V5VVF5X3EWItpSS6enoG8QAZDu/uaWT+7DRXTfN2mDMSongKr+F4rlQNV239DgMIasU4UlduLxwKPx80VZwOiQg5hHHTWdtpE2CBqEfNBkNeF0B6hqGqHZKM3u6+qlmCg5hYrG6YpBp2UrkbyZrzHF8VAM68QDPzDXDg5vgSLssfCmMFPOxW+RcLfnWJ2pkWE5mbEizn5drRTWrLmqIRGy1x+nsHqV/QBKYhNqeuIYqUQy0CneDODt+7u5dD45E4/jHmxVAVcgaf9Nw05KVeyi7WS9J7qRhlZCmlk27KhXHsnHyxDiU/UCzzJXtMxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM5PR12MB1322.namprd12.prod.outlook.com (2603:10b6:3:70::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Tue, 30 Aug
 2022 13:48:39 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%8]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 13:48:39 +0000
Date:   Tue, 30 Aug 2022 10:48:38 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Wenpeng Liang <liangwenpeng@huawei.com>,
        linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH for-next] RDMA/hns: Disable local invalidate operation
Message-ID: <Yw4VNtNY/mcCYGfd@nvidia.com>
References: <20220829105203.1569481-1-liangwenpeng@huawei.com>
 <Yw28pZu4wuLzfYVT@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yw28pZu4wuLzfYVT@unreal>
X-ClientProxiedBy: BL1PR13CA0270.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::35) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8a3cbe8-06e2-421c-889f-08da8a8e582f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1322:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7hTThCCfOgr1JT6zD8IpWW6amhi9yrIHLBmKh9C5KJHMc1x3VpBJp/91eovWqNpa6EhoohTSFpXO8qDfHg7dm5uCuomrixOFAoRtHSGv6Qchew0zf0phfxUrf+IwygsQcZ9UDvTvDpC0EqTACEH7LdbaS6qc1bjQozPlCInFwN2J9TkxeM7/GwlcFdzR0BBXb6H+v7SqrhXPhexclvjiG3ifm2oJXWo1QxaqZbXMEaBwkRie4NtpfXcAR3AnSHDhmTqAf5qwymx19qdZoMZFRmyd0P0906EXDlhOZJXTHgUhaHyOaTTFPL5fMQp0azmwYeKs3qJ9v6aN1qgxZPpwDasKf48/6D17s9fpBnPtdnj1Dj6R+YPmHAeBOiAHPuMN2kerJG1M3XEhReLk3i8Eo1QVdfEBppx3Gx2sJhaDZoZoCYeWXSlbwK2MqOqqS9q5SRqJFHuoM1LLpJeUljSBpMX/UeCsjiLs2Oxo7L3fyCtYEFEiKnDEAFcyUfeXJRKCAh9T4TNo/wwig//3GJ+LrF34BCX7jimz1vr5L6NyD9KZEPIgwnObVEsvVE+qP5Gfp1XNthii5G0mStsfQI7r1/szJ87o/SospWis/Sg+hDflnRSraTZHSgDo/ztt2tXRFdW2+MbK/LU5chXoGA279e05mcs+ES1LaIK7p8Xb5FCcycA0p+fk9RtNFY9NXfkBI11UbxbILR8RgDvhZF95fQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(5660300002)(66946007)(66476007)(66556008)(8676002)(2906002)(8936002)(4326008)(2616005)(6916009)(4744005)(316002)(36756003)(478600001)(6486002)(41300700001)(6506007)(26005)(86362001)(6512007)(83380400001)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jf2g+yaUse4HJJqHwRKgspMAvM/bdrxh6O3twcNUkeTCEupR+fPBnwlvX2cz?=
 =?us-ascii?Q?XggCRcc7bDexaCMKo0vqOYXVMenL8/GE6AC2yXswteK93YsNevKLpucc/icl?=
 =?us-ascii?Q?MaoEI4T8Gs/m0/YThE2+9HNcAxqtCinboXyhNLlGwhluvd7/hjUy6dq/Jjyr?=
 =?us-ascii?Q?+1cDZfveZfJERdtLl7aJsUcdFZpLwy0rhCN59BxQ212ZyBbIGMKcqP7gLRnE?=
 =?us-ascii?Q?8Mpis4nnI11xrTAjw1HI7vmRPPJ6IEdC147nrXHWHyT7p8BTpy3l3TiACeBV?=
 =?us-ascii?Q?5nC6msfHj/SwSA4oZGCs04zRjIZXH2JEkAi+8mJeCRtwcxNrTMM2c7i8mun9?=
 =?us-ascii?Q?O3UxyrpNG0+ocBbqZTsuoR+io6dj60ardHaOSeld4lkjXswI69EsFuQgIa8U?=
 =?us-ascii?Q?7x9qVRUHMPzYmySv5N6W2ozwJLFyHf6LP/5UlcsC0Czt3Q+xLiY08QNI9TIh?=
 =?us-ascii?Q?Pjxj0oKNItXY4xLG8oW3m4ooadgE6BGj8B7LedC/yThJtgeYZ7J8qddifi0r?=
 =?us-ascii?Q?rpp3JoZLMjVT/hOlDAaBpjEF5iqDWHuaFiPqWNthBNyfqTD0J5zvq2ybXJ2r?=
 =?us-ascii?Q?FyVr2ALMZqiIrIl0Duw1fdWIKYpoJDnw+NLT4/dr+ne/sywTzDVjkctW9Gmn?=
 =?us-ascii?Q?T9lK7VMusPggH1hkKNsz4I8hYGinW4h4gYWSagzyhIH7XZmeAaK7iQAKbqAf?=
 =?us-ascii?Q?dcFZqw82TaWBCwKv6IuwjQLzF5P3auh/syUD4xvilD3m6Qhhhd7RPA/CJvz5?=
 =?us-ascii?Q?OyIpTkaOtJOLuEPQqXhN5ZKfXQ092JoMPQcGuc6NjbvdqifKz9KG7cqr7GP9?=
 =?us-ascii?Q?fkdvEANQXuiMyveDfKVENFKO3qWZgMFS1WAcw91le0JmqvlrcGqZY6l5PwPc?=
 =?us-ascii?Q?CiorkZbVWMXq1FiETk/sHx+QnWx2wBxnEGW0z8iecvDkT/IwLFcx78SrnnyQ?=
 =?us-ascii?Q?TPhtJ9vd/79aU7m71YK/PznLm7GVX7Cd2TZqnRhtyrmQCF0e05xOpxraxniT?=
 =?us-ascii?Q?/oL6ms0eOq8uLiiXAJ9EjiI2MFQFNSqIzz7AQImt83qFVv5i0iDMx0SDL1Xl?=
 =?us-ascii?Q?OK1r/C/bFXIQPpqeWtinjAJsxRIl0fX3LZ0fCBuG+lWSsTVujtLWCJ02W8Wm?=
 =?us-ascii?Q?w7DGihJr9LHVRsLlVpmICCVxOivCD+1PP7kaiq836WsiKze17FlKia0acIO4?=
 =?us-ascii?Q?MWfM7DfeuUPZnaVRQ1CMngtSxnp6OhLdqbBvjrTbqski2z+i27aTkmOYgLkZ?=
 =?us-ascii?Q?msF3vG873Fi8Lh3CtgTjiO/1O7DEKq70a3edsa9ucCDROt0omdL8P3GSCmoA?=
 =?us-ascii?Q?1MZ/yaKtShCDo6jArysH8oWLwugmq5Q3m1rItEOW42X+ezGb74FxtE/dyPRq?=
 =?us-ascii?Q?ID3O+NNufWxbZdIfd9B96neY3/BAy754X70rDzhzwhvKepc//0LF2aw199KW?=
 =?us-ascii?Q?Vkz2W59L/VfBN/FwnDZ8NPIXuh4MrNMq8dfrvSj1OL34AUx9p6bVAeVgc50O?=
 =?us-ascii?Q?Ynsl5QVPJREWqnLY3OFWe2BShezbUzZob0zSG2silYBYQAzkiEeKL+ALqma+?=
 =?us-ascii?Q?PtJWwK/BZsF9Olot//p5X0lPoOYS1uDHFlsAhdUv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a3cbe8-06e2-421c-889f-08da8a8e582f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 13:48:39.7095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DoSEu29wgjYQ2U8qEjwXQtIi3k0tn30veHTzyO3hdDMaXJLA0lpVgaiqUN2G/ns5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1322
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 30, 2022 at 10:30:45AM +0300, Leon Romanovsky wrote:
> On Mon, Aug 29, 2022 at 06:52:03PM +0800, Wenpeng Liang wrote:
> > From: Yangyang Li <liyangyang20@huawei.com>
> > 
> > Currently, local invalidate operation doesn't work well. So the hns driver
> > does not support it temporarily and removes related code.
> 
> Please add Fixes line, and provide some context, so we can take it to
> -rc and to all stable@ trees so this feature will be deleted from
> previous kernel versions too.
>

A more detailed description of what "works well" means would be good
too

Jason
