Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019AD6DFB78
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Apr 2023 18:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjDLQgs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Apr 2023 12:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjDLQgr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Apr 2023 12:36:47 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1AA6A6F
        for <linux-rdma@vger.kernel.org>; Wed, 12 Apr 2023 09:36:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmmUo6/esu+RySFGr920rMIwbkkP5KvSWb/bfVsiD5j9UTxXoGBLcS5f8S7lYqHw43AEWQIc1+/L5wxjPUV6HCyXdP4LedcfTCHUNYkJM69REj7x+kae/GNbUNZbtraCcQccm8B26ds4uVvE7xDRANe9MOtBzDTkEq7PuJnQs0+27jMW7+YYPwX8Tqq/Tndgq4enENpedzByMCl5hmA5h5XqU4mObPC19h9DVl2lLyAu+vJrp0PjCsjgoEb2X9DUu2z5nPHtrRuisnz7RuPBI/huFdnhuwfPkQXBNJwj5ztLyQBaytQAEBWsjgfdAyDRH97cXRJfK0RdjLKM+lPZ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBqlF8cVznxY4zRu3T450bCq7S6l5cvSHULnP8OsXUs=;
 b=GdWeIbiASDPni9l49buuaA9727tPnJU7UrJ+g3OlJZ4wC1BzdpSanbv7spt65inPYbwZFmYQjoIAEKBz05Btb4VRHgadw3km5RUJR2tT6z5LzHbhYV8+ykcRmTn9sDwswPJGSLea7KJDqDrjXDZDxLxt8N/zyR5vEFHgP8W2BU2K69NDjFJ0KiknPzHDnxczI+etaUOXZZuaCSri6GhhyDC+qxujbWabdYH8GuE1w6wXhcyQLRVuXcTT5ba/FfkIlIJELG+SeoF3vf1eYCkZn86fO2tiZ7elxFxftFXy7wXJMZqMsXTUwB4pllhV+QYu7D2GSbMN2t+1H5wYtUYVlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBqlF8cVznxY4zRu3T450bCq7S6l5cvSHULnP8OsXUs=;
 b=gEOJsLnnM18O5qxJWpmU42Ub+DgfRpqNh9DTUqtHS+sEG/sFsfsFuEa382/m/Afc4E+v1TwR3RMWC8Xiln1KyB4zQp1ZkHRl+mwauyvL5k4usFUrUn5+APtlMNTbtr6LzAviIqV1G14Dmom+IGCC6xC77zci2cJp355oYm2aEXAZHpZ5B0PkNOkjyjVXWTvbYl7Coh3/TwqZ3qIhcAZs3rhJed4lEi16GomqevlWmThexC01xKUcb9ZWJY30h9xy6/QrIBLTLcGkRqnxxdTU3rf8vvOV9yxErowmGpQ28ti2WcznrydFfwFe9scvYwfPLa19j+ewdmcQ/JtskhtOLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB5073.namprd12.prod.outlook.com (2603:10b6:610:e0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.28; Wed, 12 Apr
 2023 16:36:44 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6277.038; Wed, 12 Apr 2023
 16:36:44 +0000
Date:   Wed, 12 Apr 2023 13:36:41 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: Re: [PATCH v2 for-rc] RDMA/core: Fix GID entry ref leak when
 create_ah fails
Message-ID: <ZDbeGcrD8KHgIiIP@nvidia.com>
References: <20230401063424.342204-1-saravanan.vajravel@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230401063424.342204-1-saravanan.vajravel@broadcom.com>
X-ClientProxiedBy: SJ0PR05CA0123.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::8) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB5073:EE_
X-MS-Office365-Filtering-Correlation-Id: b54b4f12-3d48-48cd-8265-08db3b741a00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hbq3bKbWZrLrm1+KY0+rz2eRA5pHo2M/0uLzGaaY5GYEx4rjuKdA9inmhQj8QlQWuRvoM3kjMGRyEx7k5E94O2iAbT9yDV/vIpEd8FIhDSTRKBE6lGZR/iEv16YUK3NhcbtXKsh8xUFBZD8B/WgzhMUP2AsAHphk71c9rnyCOKN4UHa83RRnAl47zRHm44yKXIzrwHYIbykinE60obDaKXXhy7PxkH3f3ki/5TsDypJ92bqtos6Ei+DOa0mi8BDCVzKSrRLe9Y3KnerjlyPybvXN77ncnU8FvCdtjRWrrHppqUyV+GDbI2gK/44qxAbrO+nCcNpGJTTZ38K3WqF9epO7c8E+wLwUxviBCZ+9UDHBxHKspwsQq82EqTTdpy9CZRMyBpgallrEwfg+boEkQe8amYJZZUsncMcO33RpiJyMxsPe/RMhF7qbL54ST5Yh0LMg7xxhbx/2WdvpetSjXLHOIbS2EZkAKx1JtVXm+aBTYV+UEwKs2+HI/MA/BKd1Djnq2ar6UiBDkoRwdT6u/UnaR2dhcFjKi5/KGpTJDTIJOBcT8bfbJzQIFIL6raWK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199021)(5660300002)(38100700002)(36756003)(4744005)(2906002)(316002)(86362001)(8936002)(8676002)(4326008)(66476007)(66556008)(66946007)(41300700001)(6916009)(2616005)(83380400001)(26005)(186003)(6512007)(6506007)(478600001)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pmfOhjzt4qf1JX9oS6SnmA38vt4zNgXc4BlTUbWtzEAL7bPMLJmAx5g/SFGZ?=
 =?us-ascii?Q?5S1UCq5tXZJuYvkaBMyAZM3EIEfI53jlwuPfuC+/6t/8JNlmXoeTOa3v+gYX?=
 =?us-ascii?Q?MdmSwSCTujKTZgBob6FSzkE2xaNy23/X+dF5bxUOsCNXwEzTQn/Tq+LrJpGU?=
 =?us-ascii?Q?UxQaMr/XOLgJD+SsS/0ygbfyYGoFPmMgIP+WWFejW9pjCq4XmOeyfJDl5qDW?=
 =?us-ascii?Q?gMB8OU4KxBG9QbKbH66a+PdPYt+Lj8DYa8CxceeSQO7x5uSnemwUaxZTsI82?=
 =?us-ascii?Q?yK9VEMG9NhQd6xIflvEwdfvmzT1ZQejOGtm/fVocQ13NtokC7yNcj/+YKIgQ?=
 =?us-ascii?Q?4Xc5X2PGQz8mlXFF+SDJenJQu1l9RBvdtYmLaP5R2Jy70tqGZ+iw3k4vBEmp?=
 =?us-ascii?Q?yvl+QADIsXEacLh9GLrKEokczH6nW9FxsgKPPLvFOvbiVfstI4g2aaMsMYbO?=
 =?us-ascii?Q?Ldf1iKBBzTnhib+S8eCzKV0xUuJwjYAz3PC1jtZYuskNuPiZ+jCd91JX6P7o?=
 =?us-ascii?Q?BxZfiJ9nQVopCOc0u8FkXHt6VIZ1B2UQID6lUfl2XRYhp7TkyWQ6+CWjvNyW?=
 =?us-ascii?Q?VBEMBHyz0/8S78wbyzOtm7K/lK3yj+l8hfc7xH5Te+TnpoT22aoSDO6wW79v?=
 =?us-ascii?Q?G79U2fXCDQbUkViaOe080iE1VvPztEp0ow195pxVJFXmmO44SIsuwmSzKQM/?=
 =?us-ascii?Q?maYFyMRQ27Jf/fUqXgGYh6hYMNjPcPUPjDTGDNpa0pwazj7wdx5bbg2f2iZa?=
 =?us-ascii?Q?NbgFr3bI++pnvRhcwC3MMw5zrgUNmAGkh8bG+vaKotbwE0hZr9cehs/yGmyH?=
 =?us-ascii?Q?ZvG5EsikjK3GnkddVftzvJp7Yq0gILX6N85WI6mPY8s33eqYCbrEfnmmjnHE?=
 =?us-ascii?Q?Epr0QeWlvcyUGF6jMXPKlPMDYTC2xFNxqNxVEttiNGf/wZbomwhaG86d8bPQ?=
 =?us-ascii?Q?xZSEIfWFMOZItlk2UgrXYSE8DDvLX6gRor1sHOA82LzDzKQ+052b5RyrcOxV?=
 =?us-ascii?Q?vR9DeFd8hCFEe0K+pSFUv+RNuhE9lY+UVm6PtBzQt+yZYwKRLoxIFY+DTtLS?=
 =?us-ascii?Q?7MsBSxKU47GaNeAl8xu+sNENf2A8NJHnt7POEhji4vZofBSNw0Nt9hfQ5SLd?=
 =?us-ascii?Q?P/GvK3Jhio8Sgw21ngYuWI02rs6fmpLaZxEESdr2h9MCQ/1ldGCXUbbPa0AT?=
 =?us-ascii?Q?4BoffIHkeURTHXV4Gxa2ddTITwYbU/OrhqyfAZ3ohJtJk7mh+thL7xd/XsC8?=
 =?us-ascii?Q?ASjaFXKHmAWO9cgsoOabsHfjXdb7hIDZs/m+uG1RcFjiHZBfnjFHSpqck68s?=
 =?us-ascii?Q?nSKSBHi//TyOA4uCjXmrmtrMnuHrUpFu9kzWG4rL1nPJxOw8ffPSzM5ONrzx?=
 =?us-ascii?Q?BTCoGWouYzWfJoRmpCHlhBkjQayahFt/HE6mDS7gWYG6WnNvjEcpTkGHLLaS?=
 =?us-ascii?Q?/D4DeHdU1Yt+vSg/Y4Iaxf/SGBOQrkjqhs2KYY1QnV7VGYrR+8NxX8pqGNlR?=
 =?us-ascii?Q?zNwH4KiwkRv3SaOgT4OKWpGe6cJqzGeChfD4AQDoh4xMISypDsHsINVWyGpL?=
 =?us-ascii?Q?GZa2YVT8fzouzs//ENIHMbWinqIQDnBiAACFjl2x?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b54b4f12-3d48-48cd-8265-08db3b741a00
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 16:36:44.4228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TJLR+ulQpsU+ikOQ8iTRYZE3sbWtBWhNLYEnxlskvncIRFBm3t5EYg556TRzTLHb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5073
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 31, 2023 at 11:34:24PM -0700, Saravanan Vajravel wrote:
> If AH create request fails, release sgid_attr to avoid
> GID entry referrence leak reported while releasing GID
> table
> 
> Fixes: 1a1f460ff151 ("RDMA: Hold the sgid_attr inside the struct ib_ah/qp")
> Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
> Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>

Applied to for-next, thanks

Jason
