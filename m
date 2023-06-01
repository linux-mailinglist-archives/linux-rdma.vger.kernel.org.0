Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D8C71F27D
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Jun 2023 20:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjFAS67 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Jun 2023 14:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjFAS64 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Jun 2023 14:58:56 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAFB186
        for <linux-rdma@vger.kernel.org>; Thu,  1 Jun 2023 11:58:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AewT5MT97Xj/wf904QL7VsgEq8aHDMot/4YgKIAIWEjUzs2RtVg1Rh+lr0xOHHf/dV4Y8IE1MeuISMpqXuUgaQjmjnMN3ZwMyYIbBjCYLyXQ2lHTY57lDmA/qSiMCe6SRbuUiHf0H1IVqB8ZaUrWeT7BxfCKzSL5EbirD5LXEdNKoqn1jQi+ZujFka+qy0Z8DGlCSSDsDIq3EBQYo7caVRQkZuEvT6CPOFEaBampRmSnnTXDIJ7v95+Jlzm97M6VDJoDmPV38EuUERRc5NDt9xHrIBFrX6l+JNnhMfeWAK8K9p6MhglmCaA9MEGsLd5jWdptqOWE9ur35JZoCqJl4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5S2b4ld6FwclgNgHgSUj4KL6zBb7VZVAO+x6+fUCz84=;
 b=cORiyvy2oDbHId9J6q1STscH0a3gu09WuBY2IITq+7Diz9+nImmB4ymIvqRUWDyAFmCArI0UasSEBYNL5LVOSWHyBBb7CYaKI7JwzNLQX2R8X8C5/zJ3uEDmxCcHUG9KKN+vPyPg9MzOp/NrgKTO9Z6MfNgaWKfxGdkbfcMBmAEVcHwB3981SoDUXgC/Mc2+eY/rK4WY41kMea04BlrY9BRWSrVLV/O5pbi29TLPaEVdHLLsc0hHLkK7hDxFA5CNy7igcowNIo8gmVgMW9jG1f9rsKY+4M4+FeeJfKub1mjSmwAAwGpklXEoAq/q8ly62DKwnnaJrQEdYIcXDarB3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5S2b4ld6FwclgNgHgSUj4KL6zBb7VZVAO+x6+fUCz84=;
 b=teTvsEVuVTJ2tvde7qLrbVpGVbfyMCJXVti9Xmv3t3JN04fq+GSuE3ZD6s2j6BiVF/feJCBcJwRcb3rpo1vlfaAcrFZrH1Evs4emTxdJZ99ihYNJwRMZCKSp+B4Mv+qFidr4rM1pmr3CY1ZUf2CmxM9K9WU2lK8n5G947OwEAh73wM2IYT7hHCtPbKpMjyoaDIy2Ox8kIuudNdEgIr324LTxffiXp29v1r+wzdsFV2WlJqfF2j7XABGnMEUCrksW/zQEJEPyQ8ZkQslcI6SnFvLn+QybP/owSYkao1fR1elIqCyEm6SxI2igKvwtVYcj5VoQpjVi6iB3hgUJMomeMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5985.namprd12.prod.outlook.com (2603:10b6:8:68::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 18:58:52 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 18:58:52 +0000
Date:   Thu, 1 Jun 2023 15:58:49 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     leonro@nvidia.com,
        Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        Patrick Kelsey <pat.kelsey@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 3/3] IB/hfi1: Separate user SDMA page-pinning
 from memory type
Message-ID: <ZHjqacc3eKiJ0Kt0@nvidia.com>
References: <168451505181.3702129.3429054159823295146.stgit@awfm-02.cornelisnetworks.com>
 <168451527025.3702129.12415971836404455256.stgit@awfm-02.cornelisnetworks.com>
 <ZHjZQOYgNW9tllNx@nvidia.com>
 <034e5eff-ff84-f91c-dbb0-decc04b4c340@cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <034e5eff-ff84-f91c-dbb0-decc04b4c340@cornelisnetworks.com>
X-ClientProxiedBy: SJ0PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5985:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e661d13-e3da-41b9-605c-08db62d23db1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W5HxL/pcu2B62ryd/OoGzJdxtJODpqF54qbsY0yZ9lKPoPQtZtxjAK8X7VK4ZT+RyhOzv23yhkS/tM81MKPattcDuDkqNkz5ryUitGreXDeqRw7mguGEqWRuAdqq+AIskudd3D4JfWWrmsZyWFIRJHprE/x0Rhl19I9emB2rI2LNRkRA2EW1CJLlpuvJeIIRO6fGRdzzU34ihgeS9KfdVbub6fWgQKklHtJwN9ELDhJMXi2cFxDnYV1mhaxBci5msIvNFgu+1n+oy721sFXnIqvwi2HhK0KsSpw2HyYlUvufdZqGjIep00uSbwrZLdCGZd3wI7Gdcf7RKOgLEJ07wBtOj6OTIshgPIT81yWtImVGK9kLtnlEek0AVv/01MsLxxPAjA776WHphVCJ7f9QnOHjPcvcj5Nc1ieMIQ6ogZOJSWJjyUd3ERlTJBO2zTPPzEdqAqT6dlab7EGKwtRYrTWSVxNJmw8J7mLj6Ya2tZ4d56gbdmky5yzNDAJuJgYvZZP62i5Ukl8ZVhGbQl33X+k3XU3V+RVml+E2vid37zxIG6+DicSWpAsckVV6HAvCdvhB6GZRX0YlFrbrzNXDDwVd0JTPFStJekL5CiVsiK4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(451199021)(54906003)(4326008)(26005)(6506007)(83380400001)(2616005)(316002)(86362001)(6512007)(66946007)(6916009)(478600001)(66476007)(2906002)(66556008)(4744005)(41300700001)(5660300002)(6666004)(186003)(6486002)(36756003)(8676002)(38100700002)(8936002)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hVDheRkyUq05EUUl3AT91tkuQ20i7EMlZZJqYpXmg5bGMrdiNRpLFA7DnD+h?=
 =?us-ascii?Q?1ZTLx241vkitxtvJTzWb6Dz24MV7SjE98slaXrMe9/2RKNlDEGgeWDh/JQzs?=
 =?us-ascii?Q?nZfV6sm61xQ1zPL1EG3SnfydRPdptbrbPorzsBtKsUKe7lfqCtgAFdqpnVOB?=
 =?us-ascii?Q?40gvX54obbf7XfuhmLsqVsCz+Jc08LshQwpmD7QbB3LcJsS5zAHiWbbGM9/0?=
 =?us-ascii?Q?+I/ugQl5Cq4Vc2w5PWZeBBy9+iP9gdSLpKZnTjndu+VAcCtkjQ6uYvxri1dk?=
 =?us-ascii?Q?repVT2XuNSLkFUBX3Ug7VgHJudFCQS17sMfGPI+GdXvsY9UpTEXHUxGacFnr?=
 =?us-ascii?Q?ca4RC2AWsP5rs3fD5prmzsib7QiPFQPcdFuOtZ2Lrsfo16i7M2ZkYON1Werk?=
 =?us-ascii?Q?EbCpeauS9rXNnb3oItpHu8fxnXI8cTn8+2/DXp4nOa+NnpOt1kf9N4towUBi?=
 =?us-ascii?Q?Ch88Ayu6IHVa+f+W+KEphaXcvk/cHNZWMvq4SEb0Afh68oTnen40W8sdS4o5?=
 =?us-ascii?Q?i0DbGUM56ECPWnFq/awBDYGEIOdhetv8fXnHFTMjESFJ+8gUE9UmzipJdzPA?=
 =?us-ascii?Q?MnjPVMW4TvLIV6UxZ9yJOW1CEw49Mzr23GJ0XbngXF2a/5iZQMkGkhGr24ph?=
 =?us-ascii?Q?R/eyDsQ4mWWA7z3YtPui0i5hpZ4w5iqMIuVx2DwWa11nNKW4ALqlBU+VF+CV?=
 =?us-ascii?Q?1tSHvKjkBuANmnoqAYTGz7vM7Uk9mls/t5bEpgJK6tjcV6nIXd62SdnVolQg?=
 =?us-ascii?Q?oCXkZX7d6CffO5HNQRdLhTDKT03JaVcP/uI5BCcCVaO86hZQchVBoYl9zAyR?=
 =?us-ascii?Q?G0Aioh3pnzJrdJr+YbPzRWZvVafAM4y7jBd9q11zla2F3GJr8uXZen1ygWni?=
 =?us-ascii?Q?IHzwxgR+acwuavvyPXAnTkHceXnhsNTVx4bpOHYdKtFLY0Q3Ijt1ji23KbMe?=
 =?us-ascii?Q?IXLAIfd57d1ZWYftVrlhosjrPj0wDDNa00mqXHyoVpFAPoRbnLJ687PDPEee?=
 =?us-ascii?Q?51YEC0cYO66qm5IkoJ09JG6Yt/mlothw+lQktSqX0zmc49EeepwdkuSwQPHp?=
 =?us-ascii?Q?jnPPS7rcjckwdPEXhyT7eFteQivbb9y+/cFw3I6ZVeL/g9bAzIhMGavH8CcG?=
 =?us-ascii?Q?ZpZ7kms6eLrJ6URtQWzC7eXzIulY6FU2Tg4aJrC+kXmXcdjrBRRfrBk7RPx0?=
 =?us-ascii?Q?XX0gMX4IsCh2Cw9HQYcZ+aAfZBld0IUAV4JKTtnhDvLdMPocwhqLJLJ44gjn?=
 =?us-ascii?Q?G9f2G7xDMzLcvYkBDVXtpaIXkTLOSS0MH5EclMokqCBs9v1pqv28UAE4dqmD?=
 =?us-ascii?Q?rbJBLyM+lHyIic3mZLTOLvjj910ZHg/QU44qnVSYTq4BiJ00OmuRccIQBVyz?=
 =?us-ascii?Q?ws+ePZGHI0JXTrjq32VA61PlpsXtf9Yv+FnS/GqJAnnASezzbV1Ka759BQ6S?=
 =?us-ascii?Q?tCaCqAkpHy1IuHr4RS16cdVSGQJtDNIImQTRSIscqzlc/cAbQmbaa1xWVZLz?=
 =?us-ascii?Q?TjBbbdP5ShpcCF4r0OqcL4ewnBCZnCmbxP6jHIA2Km4zv33RVQxMlb1H5wk7?=
 =?us-ascii?Q?p0fC+aZd5eFwIFw3b68P/Ne8xLS73mfaOJ+TL9Ex?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e661d13-e3da-41b9-605c-08db62d23db1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 18:58:52.2023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lS6CqI7Z7GTEwXer82uqrF3YSRbkkchxCOX8JKSxweebgkOXlWcUqRl3iaFS0L61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5985
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 01, 2023 at 02:15:59PM -0400, Dennis Dalessandro wrote:
> On 6/1/23 1:45 PM, Jason Gunthorpe wrote:
> > On Fri, May 19, 2023 at 12:54:30PM -0400, Dennis Dalessandro wrote:
> >> From: Patrick Kelsey <pat.kelsey@cornelisnetworks.com>
> >>
> >> In order to handle user SDMA requests where the packet payload is to be
> >> constructed from memory other than system memory, do user SDMA
> >> page-pinning through the page-pinning interface. The page-pinning
> >> interface lets the user SDMA code operate on user_sdma_iovec objects
> >> without caring which type of memory that iovec's iov.iov_base points to.
> > 
> > What is "other than system memory" memory??
> 
> For instance dmabuff, or something new in the future. This is pre-req work to
> make it more abstract and general purpose and design it in a way it probably
> should have been in the first place.

But why is there uapi components to this?

And HFI doesn't support DMABUF?

Jason
