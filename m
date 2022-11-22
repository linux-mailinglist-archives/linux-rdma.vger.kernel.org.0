Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D405633F2D
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Nov 2022 15:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbiKVOqw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Nov 2022 09:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbiKVOqp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Nov 2022 09:46:45 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8365664A21;
        Tue, 22 Nov 2022 06:46:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XqdRtTG56tgwLJAs3QffJrboZ0QKXP9zfyMHwZFXKen3x2awZgC3nN55mdu1Fw/WiJKdeZ9nlG9VianZcRsAqECY5zOcDEN7ChQ0hdU4uDVcwetOpnnFFXLjuJRQiFHMLbNeXe6UX3psSIbq1De9mAdZAovW1vcKXv6U5sfad9nImavM3toosD2zMAS7t7Jt1GloxWFam+eG1NfNGFNZDftaPGjeYKPgt+4U+FpBZdWpggrsHigJglK6EpNvvCq4zPsg6sUKMydZ2fLo2A8FAbiIC4/rO27WzyS1gH4Go2xRCQZChIKRgOI6t/wKebDU43cz9SfPULmXifW/zjKFAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0t6CBX9KWvppx92i9MUoWd/hs5nA5RwGUny/5v7Wvq0=;
 b=AS8wO4stWoqe4jAKjPJ+DPEQF+0He1lcN9laneFfxj82IS1uChcIAjoLY+YmGbMw9xMjCai7+Tj30qVwmjceUc35G74wjMB8d4KDxryf8BiKA8JcJo4/eVOH2CPZRY57zd4g/jrGm+VmF1VKhMLMm5H9s7Dmdaapx/bpTNgraoACDpBzvpbhOrp7dgYDKDMPr92AOVbTC4J2xFQhmqBkEPj9hga/M5+qFtpE8WUA+WnOf8NzdcFMaCEwCjWHAXQBrEZhvp5uQIGsV2LC5ENZQOU4Gwr1O9QPcsBxuymE2jVuaNlY+GHizmjEIyzc+DZPr2uLWx6C6aOX2VYh5iqj8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0t6CBX9KWvppx92i9MUoWd/hs5nA5RwGUny/5v7Wvq0=;
 b=m5X/T5ghDE2QHfWR4aKalJ4FukkxAu0JLzLmleLMEEqxHyljXWwn/ghVRZdud37vB45XxV4amF3Ipl7YN+TkahJJyKedVaPZ2E9h1RJcZpR4hQXiDAdfa9pplh/cIkQKxXfRfK1KVA4yp618x7oGd+xw7k0703/YGpJ21nHyMyTXZdJ5B+SPTfweszJs4Cjd53nE7BRp4N7awtfTFUTa6YLlophz7kWgVphlczuiwuAQXYGHnOJQLHmvJbCIl+z0k6y4zOv0zAHl20mol5B+OFGSI3Mmq5ZbLjJ/QB95IjQ50PEGCUrLILoZjNoPnSRDrBDYc3MgrvZ1LJP91DOYVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB5386.namprd12.prod.outlook.com (2603:10b6:610:d5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 14:46:41 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 14:46:41 +0000
Date:   Tue, 22 Nov 2022 10:46:39 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     zyjzyj2000@gmail.com, leon@kernel.org,
        Bob Pearson <rpearsonhpe@gmail.com>,
        linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
        Tom Talpey <tom@talpey.com>, tomasz.gromadzki@intel.com,
        Dan Williams <dan.j.williams@intel.com>,
        Xiao Yang <yangx.jy@fujitsu.com>, y-goto@fujitsu.com,
        linux-kernel@vger.kernel.org
Subject: Re: [for-next PATCH v6 04/10] RDMA/rxe: Allow registering persistent
 flag for pmem MR only
Message-ID: <Y3zgzyMN71AmIFPI@nvidia.com>
References: <20221116081951.32750-1-lizhijian@fujitsu.com>
 <20221116081951.32750-5-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116081951.32750-5-lizhijian@fujitsu.com>
X-ClientProxiedBy: BL1PR13CA0150.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::35) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB5386:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f00b273-a126-4ea4-76e7-08dacc985de6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lm6MeTgxKw4powdGIR8LwmXjQrscH/TOxZtSNst3e3LA25kqeTCuAlGMe/OsL0je/7kQdgXfJI8Um+9HyuvluxUHLxnrNAu1jEmFZbkscziuxm5LDJnd/EoysrdX9MvMeK3J8JEPf2cBkIhYj0hMqef2G/3X9JdcEjpQ1RO7i/en624Ge+OSzjTaRBHyyyrvnTmHmx3UGhZAzAHEIKL38f6dR4Wcc9TKSSjm1RAo6E3Ei6bTp+eiWZCr0TnAMlj/xDsOXuENOPXItZq+NKx99BCGWlMQuxvXwKQGjq/ctF/DZ6R5gZ2NP885Mip1vKnQiIzL/RQLa9z59knIuOvSXz3dBGMQXpvITMP8vfIo7WvVMUTMd/ZuCeT7iFfl+F8B0k3pEebPL4Sa1kBBNPAqbpCEtvovHXlasDCYu9eH4VRa79UYxQxnENECqCKDPu2IfPLwspjhnvzp22M/Zc7PF+xYb/4IjLKU+K4td6eOwR0p0ibwz1v53OXgXQ6J1hZ0sOGbjThNeOqMVFATas4ppp+f2e+z95PoRz34LmsIdgT/W8UZon/PjMs/TS5ZmUMgNA205/gi3xNXtijZUVqmDhzTKrrFEzhIfVFCPft+ei+jcjfF9O6xWM4cBAQ2xmnJyye5CZCe/iEYgIu0tp9UEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(451199015)(2906002)(83380400001)(2616005)(66946007)(41300700001)(86362001)(36756003)(66556008)(54906003)(6916009)(6506007)(38100700002)(4326008)(6486002)(8936002)(8676002)(4744005)(5660300002)(186003)(66476007)(6512007)(478600001)(316002)(7416002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5cszWiyyyOE1vQhECA9GkYx6vmaceVjRohz4RPvgV0cjcz+njRBtQQJaS2BS?=
 =?us-ascii?Q?AQCBnDHtU9HtZyIRHc++hlWbc/qo4qxbQ8phh0qTPGZyEvFBnKLHigftgTFL?=
 =?us-ascii?Q?vZBXxyvLD4J2cHtxnGfDYeYwxJoTWlS7t5LbTuRNQxGo7w+75gxMRrv7f4J0?=
 =?us-ascii?Q?p9R1yon+5PRe7nz9I8n77azp5Fq66l86qpxNGW7Rtg0SzuEHjftBodWSmdyH?=
 =?us-ascii?Q?uC/Od8g6/cyHfbaoAA0j+liYhAOUDdCeGIitJ9IlHFJeU4J5iBP8P0m4P9wD?=
 =?us-ascii?Q?DQYwuaxCrLH3J+rXFPnJWjG+e0enrRS5aul72LgCZPDONWgvr4X/81pz9TsX?=
 =?us-ascii?Q?K4lySkG6XZLf1NRQqYU0DRzI0GHyYcfk4kiKHKdLpTDv/vaUGMmwC4XIiFF7?=
 =?us-ascii?Q?vCbqn8j8P80bLyKEV2PMfcb1Qd3Zsgfii4KhUU/ZRQ0MwPKq98ugtYQ2rmzM?=
 =?us-ascii?Q?50Apu+2Ln+hi2ymCMmLvG9cdX+gVzPFoQSQwrrVlzkW6NKEaKkcquONj6z+L?=
 =?us-ascii?Q?37cnb9DF6qAKv/1P1i43Kndzc8a6VElIGRhHULvpRbR3W63kuBVjsN79xXb1?=
 =?us-ascii?Q?dEEcAHQfrpoNnfRiFwXSUsTLSjQhLdDJc1M4QaLiBcnwZUdfbN9+VZKklgur?=
 =?us-ascii?Q?2mecPXw5ial611XhuJUmdLEuTQJsHmoEMFZpQHggEa6p2eJVKkFruL/czZLi?=
 =?us-ascii?Q?5/NhWImjMJdkcq6m1nIEw46EcLoyvVDgv4O7jbydPRA7h3a4AXIPB2HcSfAF?=
 =?us-ascii?Q?MlwJMBJH/D6BzJVU8+uXXrfFt3TzXYa/pjHLCf6MbX9Ff4Byj0AcNCYOQusp?=
 =?us-ascii?Q?YRLY9PUOH38LJ69PVqZZWZWxIvSIUTiBbAq6q1rvTElwL1KTJhHvex5YgCm2?=
 =?us-ascii?Q?3n6xPJ0nQM0mUUckjrT+XQKFskmeBaZIGJwGXp7hBPa1lAk1gsxzogA1LUzL?=
 =?us-ascii?Q?aQf/2FZw+B8mB4fU8gudRZLNQRKaeKH6nX7jn8Vz3Dqd53MAd3ifh5qG1yq3?=
 =?us-ascii?Q?ymCV3glZxA58CssDCOFuPN4FBNu7Fe0YhlMQzlbGVhUheR8tD/X8IArM9KlG?=
 =?us-ascii?Q?UEnkjMJBodFmVGUAVO/7exbBCsRe/5XciGABlZHp4c+zr9R1BL9ToifvsECv?=
 =?us-ascii?Q?+znyTrD0U2V+4FwdsLMfAZKv6/h/RNYGAK76z4bsGa/bkqoA3QjLbjEcwQh8?=
 =?us-ascii?Q?sw6hdLFESqsvE8J+oNfXrKWU8EcbRzGb2iF/3QJlkwh+XtZMBIyK2vFX98HB?=
 =?us-ascii?Q?UacVrsIpM+KP7UYFLmAledts3RVFmr0eKNlOL51VeM1U7i9sQLtyuuxCJFUK?=
 =?us-ascii?Q?/Rq2rFY9w3SLO3L/pFvIJ6h1AUhfprQb6cAdFel9J0UUZW3pAk7k3XtNCJVk?=
 =?us-ascii?Q?QAZgu2haRD4F4MMOgY2+Qe55/4kGjmNqR4JokcNYUA0icOimuoKkGtPy5F5+?=
 =?us-ascii?Q?SHhKM6M+1Hf8gQJHWnhtm3zw7s+OqJmBb3Ue5lLFyf4O91J+8M5sB7zxhoox?=
 =?us-ascii?Q?V0irGJs7hd+/cgO/ZnVyWQlbatfH4I1vxy2LNa+69nQBEutxAXhammT0vig9?=
 =?us-ascii?Q?BZMln2Td2Kx5vwQjx+Q=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f00b273-a126-4ea4-76e7-08dacc985de6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 14:46:41.0389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VbTf4a5RutSvheOMQZ3v9AZpQOn22weljw5jsOtVVbjp+9q40wC0UNMNJH+kTrjd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5386
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 16, 2022 at 04:19:45PM +0800, Li Zhijian wrote:
>  int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
>  		     int access, struct rxe_mr *mr)
>  {
> @@ -148,16 +157,25 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
>  	num_buf			= 0;
>  	map = mr->map;
>  	if (length > 0) {
> -		buf = map[0]->buf;
> +		bool persistent_access = access & IB_ACCESS_FLUSH_PERSISTENT;
>  
> +		buf = map[0]->buf;
>  		for_each_sgtable_page (&umem->sgt_append.sgt, &sg_iter, 0) {
> +			struct page *pg = sg_page_iter_page(&sg_iter);
> +
> +			if (persistent_access && !is_pmem_page(pg)) {
> +				pr_debug("Unable to register persistent access to non-pmem device\n");
> +				err = -EINVAL;
> +				goto err_release_umem;

This should use rxe_dbg_mr()

Jason
