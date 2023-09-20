Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D930E7A820B
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Sep 2023 14:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbjITMzT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Sep 2023 08:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235530AbjITMzR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Sep 2023 08:55:17 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A050992
        for <linux-rdma@vger.kernel.org>; Wed, 20 Sep 2023 05:55:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jACjYm1HDX5jgEIpKj3GJOldbF+Bgmv0qHBo9MGyw4hT8pC05CP8gwzO1woJyM8ZEvmDJvva8O2v2/sPtFJg01iFRpiVs+Vkxp631z9Ahx0m3OP5ujadtmZ108NvOIKu+OiYSSRnm77r5UsOQJzNXY2DX+IORhRAnQtlN8KxcDDoJn/BrNA5vFcsEct2BtFGnSWvx8Ikhl5veH36fLZRzb5V/Xly80IjcQNUNnmPeqg7Vn0tDNdq6budomTHi6yNpWVsS1i8M4m0BQvJ5j85EYPqfmDycoBtZA1GAXptP2ZYxN4Q0J/ClGDKxxsghDM/flTU3drdXXOLfEDlAdbH/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTVNot8phtUjmgMW5GZDUFKQ70N1lfPwsAV+EmzYEVA=;
 b=Ul5AWR808YFfMvYW3xFmTP+UEhKDhsxBM0XzHQwekgKSwXLBYLdTNOhBromcH7h+dARPpIm7b2frYmYU9ei60SwUJHEKIpM0qi81oj0IVqck+wJv8YGWTM0iNEmTdUBIgwmRBCUz/r2cLck5H9oyyMly2yza64nwHUxua/qul299HGjuN7/j6Qpsql21YmsidykYvSkvTk4pNoJ1I1BI8VjYJrYEs5eoVl5r2S7YdadGQM17SkW9sqU+ePgQZszjXlpOcmQR9aaroMptIjus9u2Z8OA7Z/9LgSytEbpfdHCp8DY6JfCXk2Tjz/GFm97FsmAQM9n31D34MWxXr1doPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTVNot8phtUjmgMW5GZDUFKQ70N1lfPwsAV+EmzYEVA=;
 b=QvP90Db4ckeOLsGtwsjerbYsJyDd+Moe17U7sevEbZ1C4bUzFikOxKegC+PftLKfXtVrIAXI6UTaS3mG2JNLZ3uoACmKeO5Nx7zYNqxmgOltull5VU4hhG0cAlrOMDy2s6qd7bJil4S+QScJqURMGDUWxfdSI8v1c3ib9kxHdPCJK42FSoSln4g82V0VlTVxR5TEwFnEMYHsRoQIzqB4nkqhSr4761Ynfgi6X9vIM4JJCxxWZlsezfO5J7kwARBj8g6W/bfWxpP3VR7HJkN2Gw+9vYBKAWEhFcV4MLZVLJDJoq5hpT0qSoVqmczlqP9QuVkSDbelaZZ6xF7SvCIwQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6788.namprd12.prod.outlook.com (2603:10b6:510:1ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Wed, 20 Sep
 2023 12:55:09 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%6]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 12:55:09 +0000
Date:   Wed, 20 Sep 2023 09:55:07 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Vitaly Mayatskikh <vitaly@enfabrica.net>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        linux-rdma@vger.kernel.org, David Ahern <dsahern@kernel.org>,
        Roland Dreier <roland@enfabrica.net>
Subject: Re: [PATCH] RDMA/core: use rdma_cap_iw_cm() in rdma_resolve_route()
Message-ID: <20230920125507.GU13733@nvidia.com>
References: <20230918142700.12745-1-vitaly@enfabrica.net>
 <20230919072136.GB4494@unreal>
 <CAF0Wxh=YhKCLbOLZ+-b+_rmzRoWQtqoBGn6Bo9X3zR308Vm1zA@mail.gmail.com>
 <CAF0Wxhkxa1Lk76nnkTQbNL6_v_4amczVd=wodPt00iOU2WB6+w@mail.gmail.com>
 <20230920054452.GH4494@unreal>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230920054452.GH4494@unreal>
X-ClientProxiedBy: BYAPR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6788:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a20e180-9904-4308-bba2-08dbb9d8d23c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h4nV9JZhq1sRQE4eskvdbbOL1vr7Gy5Vj+xiLKVRz3NyC64lzagh31q1ZHCAUXg+PtgX2i5e5nQBHBlE0aIU5+sWz+6V7Npf6AMgKxw9nK8j7I/mn6+8P2vYnQWxGHqUY/XsZ+WgFoEpppz/R7hs4WANnn50dwTH6U/CsUE5I+jrr7IUPfTXT1viSyF40R4YarXU/qEq2s6Ll6wkG2PpIRanM0RE25IWjwO0lYEYrqRVa0e9L8JUSYON61t80nmLRxI2bIw7WlQpUlrUnEL/gswj7iHYGZwfW2DE9dH/oehZ8LCS+qQaE/Nh9QNRxHcXpoq9uaVdR+z/KumD9O0mtWXmqOFywFSFkZdYcE6LEoIEZSnuVbb54nIQzrMeOvP+/4sb825Ve/gQJQM8WsnbQns13/dutR48o61ATtoAS87ljRI+UqtxkL6VFV3XiXSL8qpJIv/fQO62zpSZj2EvuUNIDWAb9/DnSkP3L6FQkZHU+9NQXk/dRmkFp585iE4MlzY1gDRKBiYk6y8t9gWJKyTYTiHMb24s2IKnvy5C1fmin0QBJZhM2KSbYlCP7KnL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199024)(1800799009)(186009)(316002)(4326008)(6916009)(5660300002)(41300700001)(6512007)(6506007)(6486002)(53546011)(2906002)(8676002)(54906003)(66476007)(66556008)(66946007)(8936002)(478600001)(33656002)(26005)(86362001)(83380400001)(36756003)(2616005)(1076003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGk1TVZuM3dqNHdOUEI1THR6UVVlUXFUZVZCVDdqdXViTVhOMlZJazYramQ2?=
 =?utf-8?B?YW81WFpXcm42WDNNcU1WUU5iZkxDdW05dWlVQTZIQlMvY2dZWjI3V3o1MVIw?=
 =?utf-8?B?NHZmTkFxMS9wMlV5OHQzbXJ0YWZsMWZGc05RcS9ja0NRV0pPSEQvbnNZbEFq?=
 =?utf-8?B?WlBKYkg4NkZNaTlaWE05eFJJaWpTQTRrVklPSnJod2VQaTlxcGJlK2pYZXZF?=
 =?utf-8?B?bXdkNUZ3all2aUlqMjRlM2tWbG16ZEZXS0p0M0E1b2F2MDV5R3J4bWNPM2t6?=
 =?utf-8?B?YU50ZDVZeE4vUk5tSzRPY1MvVTM2MlMwekVJK1pUemhxcjdVUmhrZ1ZCOW82?=
 =?utf-8?B?VGRITzNOZXNYRy8zYzNKWnpXR3poMVRjWW12V3BxT0hpZWF4RkVBK2Y2Y2E4?=
 =?utf-8?B?U09GMHV3UWpHSEozZytVdGI3a3Y2QndTTEZDcGhiNDhNR3N5VEovY3dsSTRs?=
 =?utf-8?B?U2Z5Mi9XWllxOTZGenVzeDNyUXgyV09LOXpJQ3cvL2x0T2pnYTd2SzZ0MGFq?=
 =?utf-8?B?bGVGM1RLMlc3MHFQaWFxSVViRVZnS24zVDdVTXZ2MmNaTUp2ZWZVNWRwY1BX?=
 =?utf-8?B?Smk5YWk2ZjJOUitrS0tWdXhqYUMwNlFPVDlSVkJka0x1azNaenNBcyswNkZL?=
 =?utf-8?B?TGJOUlBYMUI5SWEzejV1NVRvQkkraHVrYlBzUjk5ZkYyRjNLbU03TVZrRm95?=
 =?utf-8?B?RmFIdG9DM1FkcHkzVkh1UUUwVEpjUGIxLzJoNUZKUVVKc1ppVVF1d2NtVFdu?=
 =?utf-8?B?c0VWYzRRVklWUzk0U0krYS9ONjV3dUhzVlZsVFBtUE55VEJGZUtRb0o1MXpE?=
 =?utf-8?B?VzZ0TnBQRmRVK0ZTNUUxL3hZVmZVK3U3cWN5Y1lDd1JhRVRESFlTUFJEcGNR?=
 =?utf-8?B?OUhNYlRldERDMjFRMllGbTUxcWxmcFJYVWR4eXdtQ2svZmpZanE1ZTNhT216?=
 =?utf-8?B?L2RkWHlvdXgwMUdOYVcxQXJNdzNaejNjVGl3SVU3cHcvTjg5VFBEQ2NuL2hV?=
 =?utf-8?B?VTJhU09ac1QxQkQ2ZEZpbzdYMHBuc0U3LzZmbUNPUk4ya01JTE5IL1hjOTRY?=
 =?utf-8?B?NzRMaE9GaTlXVzl6WFZVRlRIZkU3cmtLYUM4dXprU0ZSeHRla2JuSnAxVWN0?=
 =?utf-8?B?UmozN0RPRExGUHdGZ0xTQkRyY1lEVkxRblp4Y0JjKzREczgvZUVjVVJyUjFE?=
 =?utf-8?B?SG5KaHgyYVJ5Kzh0Rzg0ZEp2dTNkOS9lVW55NE9OOEtyQkpOS0Yxc0t6c2Ft?=
 =?utf-8?B?S2RTU2FVbTVTTTA3OTJzbHV3YmlxTmd6SmQyNTd5K3Q0MEE3aGtKb2dVTTFz?=
 =?utf-8?B?WjVaV2FwWTdmWVdXdWFGc0xaRitoMi9ZemhZZk9RamFMU0NsZDZpOW5pSDBh?=
 =?utf-8?B?YlBOeDN3TEduKzMxZnAzSEZwMkxLN0NHYStWcmxBdXcwWXArV3ZzMzFjV0Jr?=
 =?utf-8?B?TXFwMDYvR2RnRExHM240KzR3Z2wwQU9UbGM4QUxqeXpFNnhSbkFJZkd2aDlm?=
 =?utf-8?B?bHZXaXNjSHdxM25pOVNCUDNPVzMxdm9IT3Q3WXdXWFJicktHbHNGRjdQdWw1?=
 =?utf-8?B?LzZYWTFFTDA1cmVBeEpOZ1ppbXFiZjNjcnFBOW40dWowRkxtUTl2SkxjY2tF?=
 =?utf-8?B?dEhEazFTckY2VTUreXdBZ0doU3p3aDNHTTlGWG5QSzgza1ZjVTYwTk5hUEd2?=
 =?utf-8?B?OENtRmMzWmRBSFFXQktNdjk2ZG5HM0M0azM4dHZPSG1vUGV1TGdQenpZN1Jo?=
 =?utf-8?B?WUtLQXdvcFEzaVBiR1J1eXliZ3FCV0I3RVZCWWRBS1pVM09ZNmJMT21qLzhM?=
 =?utf-8?B?cHV2a0crWnV0MTFwZG5uSG5GM1NmUzMxKzI5cXdxaGtIYm91VENTTGVkNXJo?=
 =?utf-8?B?QTJZay9Jd2lUVEhTaWhZM3l3OUJHeG8wOWZBbnV2b29rYVRSaC83Q3ZUSjl2?=
 =?utf-8?B?S2dVaTJmMTBCcFdQYWxKTnNFanpIR1REem1ES3A4QllkbEdVT2wvaFZnVVFI?=
 =?utf-8?B?dTBKTmdYMjdyMklMTk1ZTk5xWTF1NGlmaXBtMDNqV1JsSHc3eEtxQi8xQXlL?=
 =?utf-8?B?ZnltN1J1UkxvejhWS2Q5UjdBU3hTOXM5bDVrT2o1N3BtNVJsMWIyeHNZZGVy?=
 =?utf-8?Q?KfyHg2sHzXHpCgD950XbLRN5w?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a20e180-9904-4308-bba2-08dbb9d8d23c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 12:55:09.5297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 60vH+9sD4jZ0bK1tk6C7WfuD3RSFxPAIcdPxOwGAfWlfOrLGWKtbg24ScumV5sJW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6788
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 20, 2023 at 08:44:52AM +0300, Leon Romanovsky wrote:
> On Tue, Sep 19, 2023 at 04:08:38PM -0400, Vitaly Mayatskikh wrote:
> > On Tue, Sep 19, 2023 at 4:06 PM Vitaly Mayatskikh <vitaly@enfabrica.net> wrote:
> > >
> > > On Tue, Sep 19, 2023 at 3:21 AM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > > I see that rdma_protocol_iwarp() is used in other places in cma.c too,
> > > > Don't they need to be updated too?
> > > >
> > > > Also I see that we have check for protocol RoCE in else before the
> > > > changed line, shouldn't all cma.c be changed to rdma_cap_*_cm() calls?
> > > >
> > > >   3376         else if (rdma_protocol_roce(id->device, id->port_num)) {
> > >
> > > I can't really judge, but looking around in the code it seems that
> > > some if not all of
> > > those cma.c functions that are checking for the protocol - they only
> > > called from the
> > > drivers that actually use the protocol. For example, iSER.
> 
> Just to make sure that we are using correct terminology - iSER is ULP
> (upper layer protocol) and not driver. 
> 
> > >
> > > Our driver does not support iWarp, but implements IW_CM callbacks. The patch has
> > > the only fix that was needed to make it work w/o a full blown iWarp.
> 
> It is hard to say without having driver in-tree and seeing the result of
> ib_device_check_mandatory() in regards of kverbs_provider variable.
> 
> Does any existing in-tree driver require the proposed change in
> rdma-cm?

Yes, lets see a driver first please.

iWarp CM is tightly tied to iWarp, I have a hard time understanding
how you could have the CM without supporting iWarp too.

Jason
