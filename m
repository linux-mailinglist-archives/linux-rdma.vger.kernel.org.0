Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263277370F5
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jun 2023 17:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjFTPva (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jun 2023 11:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjFTPv3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Jun 2023 11:51:29 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B73F4;
        Tue, 20 Jun 2023 08:51:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUwRYWDjY0KyP02kWefSj1d2wV0euSp1ocFsg0UlHhJi25fyBJ/k5/0zDTMH9D8aDQJVMj7EGciyXxUupRyvkvTciKIA68/YtVplk0xnFzj/eEb7VZ7EGz2USnfwTxtcXN+pXlaB2IqSQBnNRkVWoZW8CHI/Bu+ScfPRDNp126XF5S4ufZc+phiPWp3MlimZKpnHGAso45+543KUwBst7wl5ciYg3ZtouACISdGgc6Sq3snSR9dSM4VH/Q+G7qXP2WtkIdIIiumvSI5nAD+eolYWkMmFMOtlnG9ufy06PcpTMGHaHYw9MXGAjm807ORKolUyHTIrGDpgSfzKEeZtSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SD03vG5tgxhORdPhXx41gDMXEi3myD81Bpd4Cyo8OiU=;
 b=NgjGr6uHuXK00wjiulWKAduiIG7UEnwJ+DMT2e3gcYJLIwuA1DVqosDLvTUMt9cSYfPunHm7ff4cDse+/uEBmw5h0fRGZZa6Ik2nf3vqyHAsQ1wb9qWMhJ2XJpb7x5iukFGumZGSwaq5hpjRZ4rbPjDrCKNqaqRWvBddNl0IaiVrDZtf81N4tmRiS+UZ/VQYsv9LutPiCfp8uszqCw+hTlUewWwA1vAlvCs7NqUjB4sbj24WZOIBy1lAipOxTF1u/IQIciK5OVjJCPRU4lIcR6Lh0cHXL2ToR2p4e//jWeNSYGWqLsuJPZ6rfdAWD3avHaPAZS0ZqdE5sG2Nppq7rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SD03vG5tgxhORdPhXx41gDMXEi3myD81Bpd4Cyo8OiU=;
 b=Yze2HF7U/LOmslQZa4XLnXdjRhCWGYCogacvTmiAtdrNbpDfcBYNXd4laV2CbLIJp12j4PBkYZagu02+rdaJk1lRGac0KkEQUU1tRX+j5veH6/w9D8yjScR+Jr7aN40W0iSvQel16QcvQ1hDGhkXpAwtheGTBWdXosC6cXnwnaavmgXOpcv13FeaRoSPnnar7NGZqv+ZvljSBpZJ5z91LCtwjrtDEBsElFpRWrt2OSs9pu12eaxf9rjFFmkY8KeQWbhyYDyzGeaX+0w0u7mgdQ6SUau+bWjuUxpFy28Aa6PpsgtV2Qdzh93/Hgx3Uvv/hLTgSyIrCHbqoO3Zqgf4yA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB8129.namprd12.prod.outlook.com (2603:10b6:806:323::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 15:51:24 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%7]) with mapi id 15.20.6500.031; Tue, 20 Jun 2023
 15:51:24 +0000
Date:   Tue, 20 Jun 2023 12:51:21 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] RDMA/cma: Remove NULL check before dev_{put, hold}
Message-ID: <ZJHK+XVOxRNxpiXm@nvidia.com>
References: <20230614014328.14007-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614014328.14007-1-yang.lee@linux.alibaba.com>
X-ClientProxiedBy: SJ0PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::8) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB8129:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d8af26b-ba65-465f-3190-08db71a63354
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0LAhLFuuFcnrGrCZUzE4V1j/r2JUg6gexrnq85Hx8muBH7sk/+cFW8OPniFeKNAoitoAvz0nPFzUfG2rL72836Re1vlC+FuzU9FMjBhhCiS6H2ZQ3VsNwYdualYSmAfe2/lgNm4Rle/WaRAx8qJuOTMUPshcTFDpjINR6R6EzA9JZXSHb6927SE4Nt9nbVBw6jGYMxVGXyE2PuSkWHtiL9MursLiPfTRXCJcCz3Bktm7459QeG5suJfERiMo3dckHwrk/hbCxuykB8o+vcJJ3zeUiebfcIPqkoPIr7oZhoDVwHqGdF/YaaM5MXugIdn9LruLoikYVALxKjdWLGv8KPO9bZXnc2AUd7nFWjX0VE+rlYSLV07gDbhQ3NasuC+dhJPCg+9DSATYs+pTMjn0tKeCVnjvq41qF+e2AXqMGujc3CZROrhzyVg3wXJQkqV9AapiuUGHONYaaKzUxvzMgNADY1SyDxZCv7pqf+DEl/pccUS/ncnjeBNm82YswmE6Xz2tBt8yjTbVzY1HEAN+HP8BcXoKWOLXwhvfPhh8UhJmxIqZU1CKYoS8btNKIz2m11sBIno63aJ6eu2uYSCoEiKtZvfzKrYXuJJ3RKVlzRPQDdg87pJIHjYNmiBqmzymLrMM5IsN8fD6N5DI4vhKbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(451199021)(8936002)(41300700001)(8676002)(478600001)(38100700002)(6506007)(83380400001)(2616005)(6666004)(6512007)(26005)(186003)(966005)(6486002)(86362001)(36756003)(66556008)(4326008)(66476007)(316002)(6916009)(66946007)(5660300002)(4744005)(2906002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WH955qZOfLmIG1lnp2GWfcmvJ/IjdmekEt6VqjfgZsX3J+XV9+jsGT0g+cPH?=
 =?us-ascii?Q?1NUBhVzslfxyHGBes+W/q9gaplacejVIE+q+U6LouXat+wzokRqoQcS7ts1d?=
 =?us-ascii?Q?nV7V93RxjLldXHj2QwPMb7JO1aMXDMgsP5wA+D8sIQkaUr/Avn0c4GjD1XWH?=
 =?us-ascii?Q?1ircgExyaKPn5X+naAYKB9asPdyv3C08ua3UHhUTzqyR3mrfQZFVOZqpRwfy?=
 =?us-ascii?Q?aFawfA+MtFWXmvd/pEBZfqP/J+MjOz3FdOfkrhJxzFjT/gWcgzc52PoqtA/A?=
 =?us-ascii?Q?pEymmxJVj3ETA/hVNByqYxWj7NUIZxrri0kZY8lFkAY18hji9Gu8fOJ64MWk?=
 =?us-ascii?Q?21eyQMz4q/XDPXq7zRVUHp6lrhFoddb95q1hFeSKUJIHSOIsJwfts7a1wVBX?=
 =?us-ascii?Q?q5Aj1nbYEr+ndyqRjzViGtapBg9e1Vtdbrfh7gsX3SkpF1UEd0xnDnNnKKeq?=
 =?us-ascii?Q?KtQmRrvEIXuO7PlGKBFbnEwxHXs2hgqiFuORqan2u3xLVhqDWI5Ov8yZS6y4?=
 =?us-ascii?Q?RbAzuZhtWpeuRX5s9BTU/g3G0YTJnMDg2yqYYr2aQwPw05iwRGRFxI23KnFo?=
 =?us-ascii?Q?mSNfrDkQM3ADhKO9z3jBWdLLkL7PoTR/OO94rIM5d6fEZIAADwhhG9nBXGnM?=
 =?us-ascii?Q?ogpAvK+lOidsi5thQ8Dm0FOd20RroRdJqcs2+4jAk95XnwyaVtkQOSoJxknn?=
 =?us-ascii?Q?BJYF4zXuW82V0OVN5K6Yfm7euP49ijV3UM58P/r9fvBLE9osNQDlaeohnV4r?=
 =?us-ascii?Q?aDZ8UEJsARfc5SccPv67JtOSW7uwUOQJo+YYAnSLSADjO87DqwkvlWv6WnIK?=
 =?us-ascii?Q?fLD4rsj4j381jsMubzpERKGx42UoKMtwRamORKBMqN56onA+R2xIIUAzQfta?=
 =?us-ascii?Q?VX7Ni3na+bWqJ5B4+K22VPyfVeua4i3b+MYh8fqQfomsVfIOjUwb5++NvM9y?=
 =?us-ascii?Q?rLFFP+T2RkdeGwoZAqpOAwn0HBeChINWVWXNA1oZ3rmJZz5AbevjgoQAVHVC?=
 =?us-ascii?Q?NCLjDKgrpp2nmpIKsJjoOd0t7LmBmkdYKcxaBbuM02EAHeWOlCMIVOy5cRtA?=
 =?us-ascii?Q?O5IZFwuEPBAwAzSosDee+RGsjvBlvYUKbT6MOGA3Wk9uI2Vred/kzLst0TIv?=
 =?us-ascii?Q?pCd+LaKJgwrbCpBYAbQGgAF6465HjGLcQsBSKcxE1s2TZs74G7V+wZr8bjWn?=
 =?us-ascii?Q?QVReyiQUvOH+Uqj26Uf+pBGSyI1x45wH1v4RjeQEUbXBGC6ecKrO/nbcI7Xe?=
 =?us-ascii?Q?5FH9efPhLuoOmK+uLqu2eqylmMu/aj5zGVw4+M/QAFfYHA66ePZHUnG4uAFH?=
 =?us-ascii?Q?xGQSma5W6hUeZfP8HLW/r1gsMoKPFvxFuxrWrME0jtUeCEeRY6fVP0bDB8wf?=
 =?us-ascii?Q?TWCXF5gdwye5WkEXA8JJHZO8Ch24UPuMRENnDDfK3mpHo9Gq932BNj/XflMY?=
 =?us-ascii?Q?YXza/3n+aA7cbUVAWsxLZ3jpaLyCmZOBervaK6AaZWIz1irXEJXLU9yfcPV9?=
 =?us-ascii?Q?QSUQ2P3gkHTQVQ1V+ev1bi6KUvChOpkY2YMwXz1lIOEV65ELtWHGd8j3Q969?=
 =?us-ascii?Q?1hp8OHp+RtDgB0DF7Pu95Qq987b0SBylxi9O1Uty?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d8af26b-ba65-465f-3190-08db71a63354
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 15:51:24.4965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Qgh9zm5xY7ftT3xKgninre9bV0C1SU5yI5xV0OzKI4fxi3cM94Ro7r4Wwiqh9PF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8129
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

On Wed, Jun 14, 2023 at 09:43:28AM +0800, Yang Li wrote:
> The call netdev_{put, hold} of dev_{put, hold} will check NULL,
> so there is no need to check before using dev_{put, hold},
> remove it to silence the warning:
> 
> ./drivers/infiniband/core/cma.c:4812:2-9: WARNING: NULL check before dev_{put, hold} functions is not needed.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5521
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/infiniband/core/cma.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied to for-next, thanks

Jason
