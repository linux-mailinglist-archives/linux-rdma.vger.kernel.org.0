Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50565215B8
	for <lists+linux-rdma@lfdr.de>; Tue, 10 May 2022 14:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241927AbiEJMr4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 May 2022 08:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241929AbiEJMrv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 May 2022 08:47:51 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C1A54F87
        for <linux-rdma@vger.kernel.org>; Tue, 10 May 2022 05:43:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QykdGOTxV9reRr3SmmLj5YJXW2nSZf0OAmcNtMTb5aDftLb98n5Ts9uN07fgPuHo1TqN6uJeYMEa6CHRs4Z8e5IV5+Jp3XxTUQho8kgfnGre/+iEgEWQ0vGz6juHGvBm9RyQDWg0Ym52DWOiRWcLRhG5xU0NHiGPSemiDbiVLsJQWtqBkHPM7OPyCfa4MuioyVeImTJK/BDdbe5q/M2PS7H/4JjMG3u+9fq4GmJquMiHbdfJUIAr/UitpJECjXmPrinG5TIcOKkG1HC2UUdkB49cAOwKnDG0yqNk1Yv/TEgqCl21s+qa5NqjZpJwvuRguntDW/FA3le13zrOHyuTpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1A1MG3SiUxbOr+EkVHanZ8raGTDgyUKkDAV3xQrSj0=;
 b=FVdfLFpsAOrZeqjA0LNFuFTU3s10r7Tj4uDGzsKL0W218bqroVtVOmJCr76qsoc3z9NBQnGp4WTA0VsZ0gmm4w1/WX+GBsGiJZEfjxE2uuruQNeUF32BFiK10O4wsQvQ+s7adrlSuHmZ54hT8SKxcAffz3/NJ+x7XTPa+zcIAQs8cTE13m/CK2OhLubUyx8vQ0bQLST2fYsyNKkSREA/kxriE5m0Ex4lZzus5GCa8wyuGzRaV2nLf/RsM9WMgtq8/SemY8Wu0XITBs9FxyttcM9CZDARElWwV3raHTubLx3k37++b9/TihneRJa+NAMUdvWxRvc/H9bw+7L1yxLzEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1A1MG3SiUxbOr+EkVHanZ8raGTDgyUKkDAV3xQrSj0=;
 b=eQpXEv8LWwhmdGYO1VWUnm66xT9g7EqIER3zRP8PULGIBMoyVxmxWC2gYfgDPv7o29s2IW/eBpHPjgHGVt3buNHl70XD4DLFA+cKMVBzboaXqgIoYYvlkwqNlRHJpZtMo9g33TU2owOn9CErJprAZNhmHmVOOxgQMgxCIdEPfD0Wt3KLoq50IrlH9AqOCkWqz6OpRMsOHFbpczLL8FYbl0uKjHlGYqQvz7R89LLMaE/49O1buv3kb+uR0gwOCO5HMsA8IvZus1jJvnBh3BDGbUVg1V/8SvumhPNN3fbPv0Odn7J/LVsOG9KLeDqoMreptzAm2a0PutU+bEIfqicedA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN0PR12MB6341.namprd12.prod.outlook.com (2603:10b6:208:3c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Tue, 10 May
 2022 12:43:53 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 12:43:53 +0000
Date:   Tue, 10 May 2022 09:43:51 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v14 00/10] Fix race conditions in rxe_pool
Message-ID: <20220510124351.GX49344@nvidia.com>
References: <20220421014042.26985-1-rpearsonhpe@gmail.com>
 <20220509182353.GA927104@nvidia.com>
 <a52a0cc3-7f29-05f3-04f3-585483cd5d1d@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a52a0cc3-7f29-05f3-04f3-585483cd5d1d@linux.dev>
X-ClientProxiedBy: MN2PR07CA0003.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::13) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0135f5c-5b22-4f3a-9f00-08da3282bd49
X-MS-TrafficTypeDiagnostic: MN0PR12MB6341:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB6341FE6679FB8013CE935532C2C99@MN0PR12MB6341.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VLza1gZiXC8qFQiDS3ktfC/WxVxuN8neF8TymR4gDwVRNSy+blH2q8umeT1tKiFcLGDFNnKvJ7FgSjKMRz5yNHb7IRgEpepCYiaj7I2F71AzLApm1inyUgUb+vsGIu0kR7VVtIQYha4uEFijT95IVdPP4lOzXS6aiIpW1wexfQcchzy3+vSMRFMb3ns7rC0SfqbzkNjIeWVq531PzcVCIpdEydPm1hmxaYj/T/5Br/4AKq8g9bUd5mmWeMwwgLO61O0BN8rIuR6KGXYWNleb01Uyu6pvaCGyYA3/kN0BgXp+XMbiAsgPfQeHS562PzPOQgDsem+mwlflQ9PyKIxi8QqVm3ncyLMDCg3Q2Jp/l/p5F/gQ0eFv98TSLkQl1lrx0BqaiaKuguQD9xcGYef3qi5s/NWlJTnBi919gr4EvJnDqP5QuNBHa3B36wA3Oi2+TmSYtX2cI+zwQuCqXRu5yzlgidNmtaJrxExkZ2Gu7bLnRpOEnj9H21swYpIkJF4MM3Okub/9r+ZO121sVYhO/Gk4a/FoXl3iRBum4M+JLMo7Iy+h1t4QKxH1IwgyoJQonjcsYGVtV3s/GMUxVIG/bu7y7HVO+Yd8/64oddCTqAb8fwtfkBF2Dx6oB7VL9dpeWDxHe5UWCK7ZOcnGeXT+mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(6512007)(38100700002)(26005)(6916009)(36756003)(8676002)(4326008)(186003)(1076003)(66556008)(66946007)(66476007)(316002)(5660300002)(2906002)(86362001)(6506007)(508600001)(8936002)(33656002)(6486002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTdkV21vVTNjZlo0eDBMYm9valgxckRXaWZ2cUYvVXNXelpTbVpab3VxN3Fh?=
 =?utf-8?B?Q0drTkpmbFk2L2JKejNIZDdhd1ZqeE9BYUJkQlVXL1NYMnIzdzhqSDhIeGgx?=
 =?utf-8?B?ZThPWVRlbVIzUEtSVzNBVDJxRE9PWWwzNDdUM2FSWFVJYlZHN085dDFXcW5x?=
 =?utf-8?B?VldMQ29uOUplZkRmcmw2RTFkSjJHemJYUHdzTlc3NWNnT0E4OEpPR2RGTUZL?=
 =?utf-8?B?U0g4Ynk5ZFdXR2hJWXdrSjROMGVYK0lMcGpXTzczSkNGYnZMbVRzWFY0L0Vv?=
 =?utf-8?B?cmNzSWZGUkw2WFRtMVlOcENsTHE0ck9JU2xsdHNQdkVsQ0NyUkIwUU9yUzBD?=
 =?utf-8?B?dUpLMHV3b1Mxd1ZnNkdjaCtJRkFrMWcvSmR4aXRYdUpYcmNWRSt6OGVaZDUx?=
 =?utf-8?B?WmpOUXV0NERvWGFKYlF6dFRHNVpiWEJrZHRpRk92U0pOMmdjZXFKVjdNd2Vn?=
 =?utf-8?B?ZytIbEEwblJHUHNlaWt0dzBQdmZMaFNMdHpMcFZ3R2VtTkxkcXhZWWpjUHA0?=
 =?utf-8?B?MGRVTVhab3BiTUpTbWJpWUhSOUJiKy8zZWN2MjBZVVFiWFJGYWZodTl4N05M?=
 =?utf-8?B?OE1IbXNqckNielFISjRLaXA3akx3dHlvY0NvZGpBbmRYVVFsVlNOQjhKNTJL?=
 =?utf-8?B?QXZzZG1qOHMrVFIxR0lUUklQdjhWTjd4ckZNUE1ZK1U3Q1hzcllzY1N3MGVR?=
 =?utf-8?B?NkF1WGRlVUZFRnJvYkFXdmZ0a2N3My9LNzVPM3UrU1RFQ2RqOHJweXdJRzZt?=
 =?utf-8?B?MUZ6eUlBcVVtTkdMSjB1UW5tK2plb2ZlOWgvbksvMTk2ZTlYaGRCRWJBeiti?=
 =?utf-8?B?RG5RNDhRUVJNcDBZR2RLMjZZb3hqQXVGQnN3ekFUd1RiMkwzVVdseGx1NndB?=
 =?utf-8?B?akh2M1pXNDN4Ykh3ckdvK3NzclFUSkxKbFFUZ3VHeDdrMDNIVXp0M2htSnR2?=
 =?utf-8?B?Wm9yQ2JYNFZtTUYySDBnQzBRNzNQd2lBckxKdmUwQ3BGS292SG5wRW42anpu?=
 =?utf-8?B?VGl0azJQVERkRGp0eDQ4WnRzMkVOMVJ6ZjdWUDFDMGtZWk1OZWU3aitEQ3ho?=
 =?utf-8?B?bEtzdWU4UmVXVEZBcDc2NWVGcUlXeUdXeFJrYlg3TCtScXFudE94N29YTFh3?=
 =?utf-8?B?SjZQaTVuTzQ4cHZQL0w5bVdzc3RJUEE4cnRQU1EwUCt0Wm9oYTVsUDBnbFQv?=
 =?utf-8?B?SWhVUWt0ZkJ1cUczckdsQ09uWWFBRVpVc0dmWFpaUHJReS92eFdzVytDenoz?=
 =?utf-8?B?V0dCY0lhQnpEMndmdytQNVZwbkpkOHkzY090b3RXdy8veG1ZNUZyUWMzZmQv?=
 =?utf-8?B?Z3I2S0hWYTBHbUtPQVByQWIzaWFNVVQ3K2pFL3RCNWZXSWkyZ1dvRFoxTjhF?=
 =?utf-8?B?dkYyeWJySEFDaVJuS1V4SUxjaSt6ZkRZM1YwZkJIbkxVbTI5M2xtRkJNcXZk?=
 =?utf-8?B?TS9JQTdTdzg1WWtjbit5YlVOeElPUUpOdURjSElLdHhOb1hmaDRZbDlGRmky?=
 =?utf-8?B?alczZ0REdFdyaDBwQTFZdXl0eFhLSFdIZldnT25PVEhwMlRPeEo5Z0ZYYmc3?=
 =?utf-8?B?N2VHN3lLZUp1WlMzaFVhb1AzY1J0VkhqeStoS2xvNUtINC9pNjVrUGtNRnZ2?=
 =?utf-8?B?dU1ROUhxZGcwR2N6ejNwK3prTDhOOFU5WFQxeHMxbmFscjR3dXJJZytXaDQv?=
 =?utf-8?B?cWxYQUN3VWhSUk9URWRjeTNpdlJzci9DZnJ4NElhbWg5aFF0NGFsWE5kb2du?=
 =?utf-8?B?WkQ1OC96dnA1Q1MwWFphT3YxNEFBTWhNdzl1Y05xSkpkNitVSjdmUnB6cjkv?=
 =?utf-8?B?K3hoQlFjRmZkakVwazJYSVhPRzVlaHJudmpHdTJiRWt3b29GR1BZTmZBUnk2?=
 =?utf-8?B?ZXV5RmdaZkpLOENoVDVXdGNxbkIwYklrL2E3ZVdwQUZWTUwwckthc3NjMDNB?=
 =?utf-8?B?SkVzbTZZTE9xTmJjVmhiS1dQUXdWNUF6R2dnaFBCWnBWaGVWYTFoSDVEdjlN?=
 =?utf-8?B?OEVML084WU4xYWdaRlQ3WDl4NURsSkNnVkptSU9ZWjF3eWhwNDh2VGlOZ0U1?=
 =?utf-8?B?L0VxR0Q0YStONTdHQURtU3hhczhDSy9LZE5tUitCbUp2TlBGaDhJRDJsNmZX?=
 =?utf-8?B?bGgyN1cvMnNHTXpzeUNHZlVUTkhrZGVqUUlvSWhUZ3Myb0RnZlg4ZHpVMnVn?=
 =?utf-8?B?NFQrd1Vmc3lSdng1ZTU1a2tpMVE3djNxTTFtaTYxZUZyUTFwam5mRXRDWkhn?=
 =?utf-8?B?emVkSUNsd1pESVN2V0tadEV6RmppeW5OcmxaYlVEV1F2YkJHMXhQcVV3ZXhq?=
 =?utf-8?B?MzVZOGdWekw3M3FvLzI0RWdCVlpmKytQb0tIcnZlY09Ddms3SFMrdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0135f5c-5b22-4f3a-9f00-08da3282bd49
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 12:43:53.0452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gSnkOTJmER/EtjUG1U0akctzCH8WKfrFqfMNaTtX6Ye7FU27JRbaSZ6BKTpBvXIY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6341
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 10, 2022 at 08:35:34AM +0800, Yanjun Zhu wrote:
> 在 2022/5/10 2:23, Jason Gunthorpe 写道:
> > On Wed, Apr 20, 2022 at 08:40:33PM -0500, Bob Pearson wrote:
> > 
> > > Bob Pearson (10):
> > >    RDMA/rxe: Remove IB_SRQ_INIT_MASK
> > >    RDMA/rxe: Add rxe_srq_cleanup()
> > >    RDMA/rxe: Check rxe_get() return value
> > >    RDMA/rxe: Move qp cleanup code to rxe_qp_do_cleanup()
> > >    RDMA/rxe: Move mr cleanup code to rxe_mr_cleanup()
> > >    RDMA/rxe: Move mw cleanup code to rxe_mw_cleanup()
> > >    RDMA/rxe: Enforce IBA C11-17
> > 
> > I took these patches with the small edits I noted
> > 
> > >    RDMA/rxe: Stop lookup of partially built objects
> > >    RDMA/rxe: Convert read side locking to rcu
> > >    RDMA/rxe: Cleanup rxe_pool.c
> > 
> > It seems OK, but we need to fix the AH problem at least in the destroy
> > path first - lets try to fix it in alloc as well?
> 
> I do not mean to bring more efforts to Bob.
> But normally a new feature is merged into rdma. some test cases should also
> be added to rdma-core to verify this new feature.

It isn't a feature.

Jason
