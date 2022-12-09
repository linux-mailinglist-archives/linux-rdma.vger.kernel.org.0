Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05452648B5E
	for <lists+linux-rdma@lfdr.de>; Sat, 10 Dec 2022 00:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiLIXaj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Dec 2022 18:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLIXai (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Dec 2022 18:30:38 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E871B1CD
        for <linux-rdma@vger.kernel.org>; Fri,  9 Dec 2022 15:30:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0MqVeuOPv2uH/+lYZTLSLGmK0MWJ4scgdHAQcxu6qT6cINVX6BG0bDtZBPFMN/yh7AU3+GKsrMNXiOCvbXM4XtJjJ74lQ7K05dnKJrs3aFGf0LHAf8ccYJpezJwvMR3GnFBLoLfnRLzacL6/+XaFtb6DtwvDBQ48vy7Uw6IVKKjfZPFoWx/VjawGIHN6sMMCo58wumWwL+UOzUsRaiVB3oZ/SJubKcXZ0MJhNN6wNtWfPzs17xpWqUdALu1RPdwqRCNvSHKkwguaRJKVbvP1FvP5/OJBb3zuswoAnAMEH4+3e9/wVOCJuWimEXFu4Rb5cTVjEi+WeWSTjGUuDTP2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJAkEUdiNLBhZrPZWn3Cisb/QoguJmxrjGWeL26Vgsc=;
 b=iNPN1xH20yoTUs7i5ZbQCFdX0flrW271Ps1wo0E888MAGr6ozkkhwNTFWo5xv9TbeINg2vXQYCke5tiQsXgCh0OYdXSQHZoUxOAeiRnn+bf/mXVXrDEb+fNbPosFV+Hit0+0wsEox42/T3MQ0QDXmmX60V93LFD6kA9k5DMV1chRvEH9gU22ouLiKv0OLzzIGPMvoM9gRSouxHKCTVCJbZ4183NsvTBZ/uTT1wGPuSiakjNWRpFWHj3p1k/d7+9+hmKtnk0uVaJ1dMINhlsEvxzH6tF3ZogJHRUNsqlUKWjBPPFKoSrDb2ZZjwjE7bYNlL4t7u0iTMMXSRcIXDr3rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJAkEUdiNLBhZrPZWn3Cisb/QoguJmxrjGWeL26Vgsc=;
 b=P7y7z+C8QPacymOdPVvbWBrLntowPzZtPgdvrUWlfZqyfTuSqnp5w26YWcLBS6ssicgbq9JeqlhNoqybd1CrgPGiNHhNTlDksUT2yKU8NQ9KU0DT4lgLMva/vWlz+Ou73BeADdP8R5Mngj37D1yCrrbtRYtg13uIIymEhI8kJWUxwwRYwZv7UZGSCV5hrD5hUmrRsUWXVAdHcAJ1GIGRfNavEDq/dQ3D1qCRnsggI6CRFpsTkWyZNmKnvfIMOW0N8oT2nD5E6qFKNmvyZ2ZPw/YWIcNIJecJFggZjNSWzZ8ZtFmTLwAtr3lRzFruUIyZS8U5phJ/6WDE7UXbeK7XyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4577.namprd12.prod.outlook.com (2603:10b6:5:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16; Fri, 9 Dec
 2022 23:30:35 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5880.014; Fri, 9 Dec 2022
 23:30:35 +0000
Date:   Fri, 9 Dec 2022 19:30:33 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/rxe: Fix incorrect responder length
 checking
Message-ID: <Y5PFGUCjCc7hBo/e@nvidia.com>
References: <20221208210945.28607-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208210945.28607-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR16CA0003.namprd16.prod.outlook.com
 (2603:10b6:208:134::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4577:EE_
X-MS-Office365-Filtering-Correlation-Id: a45032e1-fa1f-4b07-f9e5-08dada3d5efb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rV9eQNxAFUkay9yWPzRu8/Y61kBfIDFzK91ccaSAob88edg7Wgu3Fc1tfkxosIfE4I5ZQZHB/061guOk00BFHxJLC0Edrf8xIfH1VjZ4txwEU3x0hN43LL0CYYrozpOqRjn1JeNoC/4CSM4JkmXydvvGN8tbD/znhYtn3ZKraxFmDBM30c8ZG8nhAoG3M1w6pNJQHTFNorvKxIP5X/CkqXie2KnTupA0vvrMkQlYF7ZtrefkikySUijPDTdzMd0uTgsPRSr8/Babma8bpAQOTYnYkNfTpoIr8KKCagp137VdU9Jp9gvJP1LJJ6hUIp6yiZXjEfkOQfMEPR+3ivq5QROcwBQVGJSKe8XY3pmpSKYssC7Y1lfz8vFYIRHAlarhaMuBLcqTmf3WXBv7LrqF2zhnk14Ksz/izUAHh62hkq071NZnP5ETVrnYDLJHdyOjHBmIEcqo7wimWqUv24gwpIamRZJSoylONgYtYkRTP4Agv8/GmqO9/c2DxLAd3CYMEfZHd0weSVcGLh5+5lD+PDEV4YXJzNuTzwtZlAuHD10cjHi1353akW0/MYQ1ra9vwGjA2NHVq6dMAO+o2ueIz8AVLbGIh1SWrjn4y4VBimwzkJQboUlVQKSCCnxwtljoXenywZ2n3iLfUjVBeXlIhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(451199015)(4744005)(5660300002)(2906002)(36756003)(8936002)(41300700001)(86362001)(66476007)(8676002)(4326008)(66556008)(6916009)(66946007)(6512007)(6506007)(83380400001)(186003)(6486002)(26005)(2616005)(478600001)(316002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t6PvStrlI5avkYw13WQKO10Oi9djJM1nO12pBVkrmS6o4nWkYwK1Xfl3Zpju?=
 =?us-ascii?Q?4qEGQQAMAFZUIGlKAsU0UXWHe34SOUiYjgicfEdXSe4gL0V9U/wHTKy/65au?=
 =?us-ascii?Q?Nye0pmts622sVaDf0ECMr6AWAOu74Q4j20dEwPU/sILZ6zOQbjQ7E6UxYDec?=
 =?us-ascii?Q?P8xAgaP+P3uqGCj/1hVTcbkClUBTNp944Yve9QOLC4nXoUTZTX+CYz9ojsJy?=
 =?us-ascii?Q?L7Ffum9TwT0iZc3wX/rIqgYwdahxHjlj09656fk2cggvJWoiH61Hhboc4clJ?=
 =?us-ascii?Q?gJ6+3WFId0y4Btry7dybiUAr8ITOg5iVq54wDUsdrsgKAde4ZWrgQZlcg95P?=
 =?us-ascii?Q?oRe/Hdecsni2ROWOs7MNpzK1kb7lGytw1GkQ2aUWAcAiT9RnQ9BrN+LDRGEs?=
 =?us-ascii?Q?uY26nxcYcMghp9lHvF7NoMeGwQG8V9VV57VAq7gFm02neSdwnJmlsGETR2zU?=
 =?us-ascii?Q?sZx8cRO27NYRMH3LpLQC9tMbOaZPcFOlPYK5ECmB956oP3PeltqtWT94Eljh?=
 =?us-ascii?Q?70TYayhxHaPTynFH36HXl2n88pDM+ZPn6qSCGKkiJljLyMWN3qHsmi9PM6CV?=
 =?us-ascii?Q?V6MjkWAyAtnMBJu3xiKQTI76xoz3sSHPuLxtAsMiPlQJocjB7Z98eqaoAXsB?=
 =?us-ascii?Q?9zXS7CguwlI+nknSC1Y6AGp/YqSHLqppcCqptUUw53bdwlIPkuIcRs76T/Gd?=
 =?us-ascii?Q?GthBV+NgpdJ+YbQJlKVCCkZN4u1+QbCj+0sOTH2h+RC+9eTZG6XgvJG5wpPJ?=
 =?us-ascii?Q?jA4MwNQ4W0UQJH90EEjfnEkS0cyF9M4R29JiC7VxWuUNWV6NgH1V49sw8cOs?=
 =?us-ascii?Q?9xMXaxXzX8uK7oYs7sRGFGSKapVC2jM7i1L8V8r11QXiatTc46XZAw1JM3ZW?=
 =?us-ascii?Q?O41oalD1sNmeDUUAJbW4ahkfiCC8jh8+TSnr17iJnPboVmOPku7mgDD6X1dp?=
 =?us-ascii?Q?fd1cmpLyGLvOorqRajbVPXP+6dwDAJxyjybzgZ/0wknkxfyCFRRhoyCwicxH?=
 =?us-ascii?Q?cdyoN+utDg4+1sfZtgyv7SKKW2ud6zSRcE7Wg9lacJryL6G5/Q1N5HiYrROe?=
 =?us-ascii?Q?1bm0EsLCpDsEibTWTEZ7iK0W4CZJ4C4ttiwqHYfWWVtJzoxrocHNAmGgskaP?=
 =?us-ascii?Q?HRNH9nCV0axWwJ4rFn44MHKELBSQ8F4pqGiQu4Rwyh7lZnykg6tfMaKEhaOd?=
 =?us-ascii?Q?/hxNCA2yWJFEHeQuQawkz1v67+Ir4p//Er5mMIQXpPaVp8h3g+38ANn14A+m?=
 =?us-ascii?Q?wB098HxYuW9/IUhZCsORAGyKj7CIRPnlCYLpSFT5IAzh6q9HMi/UkmS9B7hL?=
 =?us-ascii?Q?Erbmi9Si4jfxaaZjs/RdeQqiz5ryPL90idUbEkBSTR/qwP0NscHGP0pSSEEB?=
 =?us-ascii?Q?ElcsmjV+HaLPrz2wDQZZngumpixq11PLwmaIeALSEzD0RvZdSptT02BRZQYV?=
 =?us-ascii?Q?gxUaTXmnRbBuN5Vy6us6aV96QlnwJUJjZs3zAwsAm/AVQyR4Hstd3/Zaarr9?=
 =?us-ascii?Q?Wlvx7HRwtl7jfVNQlFsPrE2/73XQYRM1RARRNXYLN5hmOtWvCr4MJfK9vzZG?=
 =?us-ascii?Q?YRRdIT4tTFFJdxCaxgo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a45032e1-fa1f-4b07-f9e5-08dada3d5efb
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 23:30:35.2477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iPJ5FhEeIgnFD4biNMpj39XUmghGN4xjAStJIJpKnVic86W0c+Vc340FsG3Y2gKS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4577
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 08, 2022 at 03:09:46PM -0600, Bob Pearson wrote:
> The code in rxe_resp.c at check_length() is incorrect as it
> compares pkt->opcode an 8 bit value against various mask bits
> which are all higher than 256 so nothing is ever reported.
> 
> This patch rewrites this to compare against pkt->mask which is
> correct. However this now exposes another error. For UD send
> packets the value of the pmtu cannot be determined from qp->mtu.
> All that is required here is to later check if the payload fits
> into the posted receive buffer in that case.
> 
> Fixes: 837a55847ead ("RDMA/rxe: Implement packet length validation on responder")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> Reviewed-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_resp.c | 62 ++++++++++++++++------------
>  1 file changed, 36 insertions(+), 26 deletions(-)

Applied to for next, thanks

Jason
