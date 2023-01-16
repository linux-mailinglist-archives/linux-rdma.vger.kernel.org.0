Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042FC66C062
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jan 2023 14:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbjAPN5G (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Jan 2023 08:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjAPN4l (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Jan 2023 08:56:41 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC442CFC6
        for <linux-rdma@vger.kernel.org>; Mon, 16 Jan 2023 05:53:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7HW8QdTPV2CdeNX1qtKZ8CEzkO9HODtGT1PFo8/ir0ynGJ7QQjY8fMlnmNTabx36AlNcL8LkqGOFXu2/FL4zT7hpOaoGzWlbbPra9uMoscq9P92zukNvZHU9AKvvrKsWD01D4uQxM9ekEO8ZstHy3jmNEB7qoCapD637gV8YgXQ6kbCMJCfiBV3U3IYAMoHP6CytqgoaFMgoqTIE7g6NoOxUoGnazZMVlH8oLf7qQuX3aVYeFHRFrTMyzILmIR9SLGOfabHFjAeDxMcC7xtEweX2Gc06L03Hlk6NZLX9UgXL7zBuKeutM9feNGr3t4qO4ocIMDXao+b4FRdVMiUkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bz5lmDvXR10RlQSDEG+AjHZ2UFNVJm4uxOPsKEJq8k4=;
 b=f1lgyInDOmxhhaSmNLT4+kVgp71j+e1TelMyVrW6UXGF5L6HDfQdgr68+dJmS6Y+ikYjfFgnfsoOk5ZVTcV1/qyFp+xb2KgtHAXRjVZsrOvnyeMblU0BPWy936byOIbA2qymzzHU7EXelqsPBf4ZO72JM/WNpvPkU+4v0m+xCTDOrzm4B0nfqQPg4mxiOmV4h3LYTXnD4LKY1U9dqy3r1UvXQrLHeacsOKMhYFhm2DuusPdiDmHMWTgRn6FWDgEZJmPa7UUzNlS2tLszWomF+Qw5kjtc+131beuHBZG9cfgMG18Cu8ED6WxKjez/HLCCDKhEQtp3wFwyM8+KjMWkdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bz5lmDvXR10RlQSDEG+AjHZ2UFNVJm4uxOPsKEJq8k4=;
 b=tdC0AceFzmBpBx8x0fEbz2euMXNVd98WzZ535f1JBNbQl2v1oubc+MaKNjKeJVGog621RWWAQuHLuQrK3CwA/hqOrtdv/2Z4JukpSX9v5aLIMonxU94W/Lo46cntakjEX+8Sdrt+CQdEHF0giahU14XTobY15+BnCy7D2YMbLFttJQgLX+UugWwJmy3Y7MKYD5y6jM0BJHiOYgD51qFeBGoxcIBIoOM31E9M6kbtlf3MwGGqcnqAiRabePh9RpRHHaX6ZOak972viNhR+cl5mAZshY6VZd8aqWYi6XkjY45uBFX8HxyrfsMZF8n+3E2rSv3gCT2v8Tw+Jy326bwWnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB8247.namprd12.prod.outlook.com (2603:10b6:8:f5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Mon, 16 Jan
 2023 13:53:11 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.6002.013; Mon, 16 Jan 2023
 13:53:11 +0000
Date:   Mon, 16 Jan 2023 09:53:10 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next v3 4/6] RDMA-rxe: Isolate mr code from
 atomic_write_reply()
Message-ID: <Y8VWxleU9P/OPo2i@nvidia.com>
References: <20230113232704.20072-1-rpearsonhpe@gmail.com>
 <20230113232704.20072-5-rpearsonhpe@gmail.com>
 <7ab5a35c-7909-7302-8ce0-79d24a3f6592@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ab5a35c-7909-7302-8ce0-79d24a3f6592@fujitsu.com>
X-ClientProxiedBy: BL0PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:208:91::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB8247:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a58c0a9-2d42-4d35-f0ea-08daf7c90155
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M0qE8chavV6Yrv90HHeotHP+bI2nnssxKJpt8Q5o1hs0h2UynmYEY02x7FVARmxzfuillDgmAeMjhKkihACTGO3WzYIYs6EoeNpppoDUbDxCjo9rb429IUeqq2zbMojRgJfjkQun7n6Kuui7JzUKOzOtuOCpZx7+7RiAK/pb0XtUA53ydHCczm+amwRMFeFxoFw3clS3WhrEYE3QnOwwRboQOKrLAIpjwc3XxLAWeZsDbB1zcr7KaDkpR7+lQxbsONL98+nR8rM57XEukNT9k4mdwEwbe+eEcIF9JiTM2WDW6pkMdYbCCfiYmEITSyj4z0f3iKKvr1yRFeWEaoEytrUSo3od6jKNILSyNiouChKr3ETQjcHN/cZSkN7plv7VAi8VAJwJMf0d2xHXEhMtDYH3VahiuK1i3zMdBYZ2QPoGYf5T7xCGJsWHj6/FJeHwp2oZTDFnqMR/6NJDvqCG5PC48Mzgmija/WfCvDXQZQeiPyQ6HUp3xP+kBlI8LVeKSXl/aDNnTHBaN66Vx5S0eaU2NlxSPWWNaB3T6HBbd/KX/DcwJE/OrVCBtMCPaDOd7pY40W3az3fjHrNYZHD59oirowmSGPZ2nBj4upFexHGSrkF2TjezDzsKlL2PV8rnqEBJnSbwLWb3iCaiZfGNsHCAmUYIAZJ8OAISPNRZhX2D+AbkZEqCAwKfG21H/bX0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199015)(38100700002)(83380400001)(8936002)(6916009)(4326008)(86362001)(5660300002)(66476007)(4744005)(66946007)(8676002)(2906002)(66556008)(41300700001)(6512007)(26005)(186003)(6506007)(2616005)(478600001)(54906003)(6486002)(316002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?boBSnwmb7jpvOZcS0dPx75bdewnttU3yjBCGVkN9hdw6fEYMVDwVK36AB0+9?=
 =?us-ascii?Q?uy2x9mq2Fpc9M6VmmJy2+2g2MDbZqgeX2/wf/GWUOBLZCYHxhlvGEwQuYN82?=
 =?us-ascii?Q?hC1UcRGLyNeDEdWxWxlH1W6NYeATyv7ftpFRGX5wMQKUc78CJp1dMS2hsUjk?=
 =?us-ascii?Q?+GPeZjs3JcWAibNnsO9Rll6AB4g1LS9CIetOcS8ZodqAgC4wMjXTmr1sRQ8Q?=
 =?us-ascii?Q?iE9kCK5UyeOkR7EYkhE1+Nf567TjxUEMwVXsvuMjhaio1n3C24oCbClOu/MS?=
 =?us-ascii?Q?8nWgMuVbeSKQqREdf8qL9pYUjcnnihJ/h/ZKrmfyd87emWE5wevB0jo0d0kU?=
 =?us-ascii?Q?+kaL3v9jC3P5QutP4llWCHT6gPIPPuJaDhZkRqHKWnHDestN3/UJW1HSnl9z?=
 =?us-ascii?Q?Mxs8Gx58FmzGXit167LVYHQtv02IfybyxP3YAYvu+/tb/OXV5gNYSgct0e2O?=
 =?us-ascii?Q?jXPpcLyyYpXfmbf71hf2ZTchWC7z/hTcs3TjBizczvs4yi/pX8ecx4iE8Z0g?=
 =?us-ascii?Q?1lfwscLfTLrn16lmlv0t8r/Neck27mEP5w4SV21EKhiHexIWKQOVK3D/rbkj?=
 =?us-ascii?Q?Hf6k9iVCIksliC8+QbtRYWvdQ3fqGff8KZsLc7/FNe3xKg9BAI1HspaMlNXT?=
 =?us-ascii?Q?ARCWBbCyW4PSasWQ+IZJjwVEOIJZ8FfY9sB9VChvg7IvoUjcPXavf+d8UNmz?=
 =?us-ascii?Q?jVUa4G6rlJ85VkrJxBuY8S6c/mZtZHGkOr28/jvZLTIpq6cEVld/Z+uKPR/K?=
 =?us-ascii?Q?L2sMdmFVwRC4XKySnpUlDFkxwl3Iqtr/nYcsV1IdnIop1YxWArUTYgmbJ2dk?=
 =?us-ascii?Q?AM1VtJBY/dYFZNcRGYaVS/sIUGWuCKROQY3nHxvSenxjZyWthy3jf59KqkWO?=
 =?us-ascii?Q?L/+wbfAWQ5Gltu1nmfGWEYofsLEx9NaRJ71y7uqwRBaqisUaELkyfXkdeYnq?=
 =?us-ascii?Q?6Tkqzr0FRZ7CzgSjAY5WZwyvJef9HfRRQQ0bor4qSiyzER97HiINSza+Fn4R?=
 =?us-ascii?Q?FuT7w3lJQEFUGfV986oB60+pyqb9U1duvRUtmfgXNtliqZRVdIHnRMgILPrd?=
 =?us-ascii?Q?w+yvyoSm4y2JDzGNmLpbTSVBrNy03/GVExYhLsD4BwyBVdlVgKvOAeZIvmfv?=
 =?us-ascii?Q?+AH9+JoAPtf+dCGv3bWWZrGPQ0Mnl1uR4mpQIohR9N0jGaJ5i52oczURh91M?=
 =?us-ascii?Q?P3FIbAJaoLjk/gy+tsE5H6UMItf33PSvUwKaf+HiAGRIDBHxSGdyDyaRBwxQ?=
 =?us-ascii?Q?jHT9yPeLSdsyVVscwdSMZWC9Xd7TuuKTsdfwwFZKJ/xh7t+zc0wEgHP+PPDH?=
 =?us-ascii?Q?cTtg6icMnRgnboWvuhSW5w0u8HBZNIxBeuDFUZV85aEc4MlLB9jYf7v4O5EW?=
 =?us-ascii?Q?DoLkSnJ8qTxVD6hxxh63r/PixVNWpOh+yVCE8IyUwQ9tpjO9RU3GhF5VTQ2U?=
 =?us-ascii?Q?ZsmMVzSzpVWm1mUyLf8MPSdvzqN7yHXu9wyDgB3gqw0vLDSdTxN4GdwHzgUO?=
 =?us-ascii?Q?PbCLEiMoBZykALbNblS1wsolwFEBsE4SMQc1pOWgIAQ9gNdB5y5dkoqoCDep?=
 =?us-ascii?Q?x+cpstrOfb39ywhiinQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a58c0a9-2d42-4d35-f0ea-08daf7c90155
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 13:53:11.0492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kMQa4E1IAGbnoz9A7rDCe2nS4fSC9kzNxZ+Bqcc18HwCSJxqwOng9Zm0vRge9OCM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8247
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 16, 2023 at 02:11:29AM +0000, lizhijian@fujitsu.com wrote:
> > +/**
> > + * rxe_mr_do_atomic_write() - write 64bit value to iova from addr
> > + * @mr: memory region
> > + * @iova: iova in mr
> > + * @addr: source of data to write
> > + *
> > + * Returns:
> > + *	 0 on success
> > + *	-1 for misaligned address
> > + *	-2 for access errors
> > + *	-3 for cpu without native 64 bit support
> 
> Well, i'm not favor of such error code. especialy when it's not a staic subroutine.
> Any comments from other maintainers ?

It should at least have proper constants, but can it be structured to
avoid this in the first place?

Jason
