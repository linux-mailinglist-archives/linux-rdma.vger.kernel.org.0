Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6914E274F
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Mar 2022 14:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347725AbiCUNQU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Mar 2022 09:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347667AbiCUNQT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Mar 2022 09:16:19 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DB14EA08
        for <linux-rdma@vger.kernel.org>; Mon, 21 Mar 2022 06:14:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLL/zeTyb/sO/00f+THXaqMpogrxAOhBuVRFaQIDCxWeSi0UkwtMG+ZH77q9jJiWSwWDOvbY+uFmAhg244wpaHijLVceS2w7asnmwOuh7ZiNWdU94hhwVrlaBmU5KJRyJXZp7VbBaMMSufoK5Qo0xRgA7wRPX5sX04n7DdZ3Zwj5dKX11/T5EILmG3X7pIiesC3RyT+kJJm0XguQrci2Yifb9fTgxWX02sjYW/n10Pp6YliCjQuxpFg/HMXDJHxLcJ7dnWFlsvbhTwEdDATPDh0q1oz4109sknJqYbU21jxWRzHRn5+58TQ1h47Z8VJLyP4X+Ws4rbjTWuJXTlz+Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JiVUUcn/kKZU/Sh0jhYX5osYYA77tcPQeeLlYxqk3s=;
 b=TxuA9MqCFTDfIPWlpt0hmvyjmS8+XJwyYE3f0ECbs3sYcIuNDutn7C20zpib07b2cGzNjA2aFqaLMECeGMB/EZpjX/dYGCyeB+EoQDzhswkN1ltUCYgeKUcQ5vJORB8DnW55gz9jpAI0T0XHh7JQzVW1C0q1S79p3B5rdfskejT8DRVP9P/E5g08MBWZSH8AZzeTnP4KA7HyoPl6QolHKTTr/LXWMykvx1kcm9Zht+stcvebIarK2px0gbL++gQ3e5FKgYgC+sIjfslnBueneIy0Q38EHGV7bmb6Ik3iJ1ZICyF6wPSok013WBBpi/Ko800G3DnFfPKRn74Gs2Hpeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JiVUUcn/kKZU/Sh0jhYX5osYYA77tcPQeeLlYxqk3s=;
 b=axO6KaoeUTTw8ePlxqWCOQIezQWXGK+092e1LfU5uC8BbkU5T082DYfwuKQrPUY6TxZSRY08OnJ1L0wS6ytYf+eBG9IGGFvP8x3fCdSw/adg05PQLrf3tBi7Me/taP2dbHpE/C5MksRLrS9r2X95nmliC7M2HtDU3r9fjADGGmxk+IXggWAT7V1Bz3ZrOWCKKCy7qaL18dwxUcvcN52B8+qLcvTVWirs3d2JOWCkXjhV0cqkq1p9grMRfnTrnFhXBypgVY5GpWWDjceCsr70QkhBMQ1VKTd/70xN3n1BdkILCZ79tDhNB+Cqme7XJYTHIwIE2Zo70fuK/IzmaHLaRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB4403.namprd12.prod.outlook.com (2603:10b6:5:2ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Mon, 21 Mar
 2022 13:14:53 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%5]) with mapi id 15.20.5081.023; Mon, 21 Mar 2022
 13:14:53 +0000
Date:   Mon, 21 Mar 2022 10:14:51 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/2] IB/uverbs: Move enum ib_raw_packet_caps to uapi
Message-ID: <20220321131451.GR11336@nvidia.com>
References: <20220319170351.336731-1-yangx.jy@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220319170351.336731-1-yangx.jy@fujitsu.com>
X-ClientProxiedBy: MN2PR19CA0019.namprd19.prod.outlook.com
 (2603:10b6:208:178::32) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d8dc354-5fc1-4f8c-d47a-08da0b3cc93c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4403:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB44036115B837654A38141E8EC2169@DM6PR12MB4403.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zuDqtN0GduygimDO1kTEFCDqEE/WiMYUz7hClWU2LJeUVVLFLtqoa9GZZW50uCl/n/km433V+rIkZkYmp31pcHjokNfyL7Mh01QwG6Xw7X73cjUDLz6jxXIg3aqzKI+0y/oSvxDi5OaT3CUX9JYWhfWYgasiypXcPiLsuspbh1mHn+QoAdvTfSveM0Caq+w0KWc3r62p9wC6M3i3KQlQ45FuzNC9I9y5FBB9HXllCSBm8SxogSTJRaMS4/4ya5JcYj4Jxq+2EbPeAghm8KL38KAbvEhLtdf3oSgM6PzzvOa2E+C0rdtGZSBnWN11VA0SCUKKRKPvHhrJWCe7r3p+7obDWFESncHxKLGbJaB2Ei01snDqwZKZ/VdgoGMqQJSBZM/ZrLibxn8yL7Q1f+k7oHnzrZxPSofwAi8EoNwiE0dtxf8f6xQvcq79iDVJO+9R0YhxBEH/CzSvhQMudoyWT362IksjDOs/7Rn7NLW/511IjDHBW1LJGfYWKiAiONhsG/zcCKhho5WQijQ8LF9rxGornzQ8Kp8gfiG9lH2eiZ8PzHf5QufPsbk2QNfQowqjGCHYoG1JAR8FeoTvtxtub0J7eEaV4GeGsxvXJLS9pWQ2Sl3RheK9BJyjEw10XZxMBOciNN6a76h36HjbU5JVvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(6512007)(36756003)(33656002)(2906002)(508600001)(6486002)(316002)(186003)(26005)(4744005)(4326008)(66946007)(66556008)(66476007)(8676002)(1076003)(2616005)(6916009)(38100700002)(5660300002)(86362001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c3ga/5DoV5v7N5PqeCpbu6+kkOdKXoHH0hl9usOqF5ezP/Aj21zXR1XYEsVN?=
 =?us-ascii?Q?RRldaZMkjH7ssnFZXx9xPFGF5OiOwhIeTB+tKkF9HsJRDIoB1JsY/GOgrxxg?=
 =?us-ascii?Q?iVL73iBbNu9d+R+6Xic/pXE2lRMGZo3a9oSVvPG0YSARTMzMrHXnNcDo13pi?=
 =?us-ascii?Q?iIB5bnN0tL9CVnrgFLzyGc5Pn00+TdLSdDvq1xlll/ZH1iUEXSJVZDyKz0MD?=
 =?us-ascii?Q?RjBmU8CP86uFbVZrHtYmsNvYqIez8vrwrc4I/UUwx1bHYNV462I2aTqzTc2G?=
 =?us-ascii?Q?/UsgzqT++NWeGKNIDgzpHHrDnXOLQkl4OqI6LCl/aKgfvE7zceixWfOQrrJL?=
 =?us-ascii?Q?VDQ6PmJ8Zwn7BXuu/DxGr/f+y7HPhcnPGgPAASD4KidBUtZYGQAZjoYhQxuv?=
 =?us-ascii?Q?nc5TQafT9/7ZodkDwI1/FpZU1dMkimP0lWHUzxJ9cbFHxN0lAGQm/esV7Q/p?=
 =?us-ascii?Q?OE5izdn1T8sL/H/kAYdiO/wE2O1NCbKs+DlwcwSGrmxtWB/eTQzj2AlQ5eNz?=
 =?us-ascii?Q?jiJONHt74HA0+uHZ39pPMVmTpt6znoiNMYe8dgUO1ziAKwfSV98ccBB3p2DM?=
 =?us-ascii?Q?60qGr/CxyhC5T2Z1Dp9zXO5eelJsKZ/tMhPdDmS8EyVi7Ax1a5+zubpsB6ZU?=
 =?us-ascii?Q?IYJB2emVgaiWv6FQtgTa6I6pn475G7jRTsdpcB803j3S187UkV15jRa+jf2b?=
 =?us-ascii?Q?6mqlI5IigSl/oc0ls01R8Q+F00RZ6eZrrfx4fokq5i7xReiNCZHr/JQQsB9z?=
 =?us-ascii?Q?4JxByUqG4MdUeRXJDfdZSYyY27GhLY2HmvqLX+dWbI1NkOyZD5Xue8rqv9hc?=
 =?us-ascii?Q?Ze5QWDQqGl47qCqGZSMX0Knua1qwvrMn7gNUJu58VcXDbWlNppc/tnLeR4eK?=
 =?us-ascii?Q?52tbG4xP7X8NMS43RaflN9CbmwhGQ1GDQqfvdF/ylW41Rcc4Ds0lLFw6evJK?=
 =?us-ascii?Q?f1cBpcPEoSXo36Wk6Bcmf9/OiWHePfHcLUOpO9GVoXzNwj2Gcak8A1Fn9B9l?=
 =?us-ascii?Q?B9XRUs67nOrTBCxTTrmpF/X8yLpI50mcv3Mw4URdGOCOJpqRTwRqZcV6URFC?=
 =?us-ascii?Q?GEVl5YO+vP3Ch2djHWjXY8bKGKgd++C0tQ/mVxniK/A14uWA+DEPom7hRLwH?=
 =?us-ascii?Q?nM+gfnepMpcqDlRj7oKwrEO2oHnIwg1Rl+XwDGMoglMirQYQ/W13ptFsLt3U?=
 =?us-ascii?Q?H263fYt+CQG1w9NYutlLNN1bHRRtNtBftEZ0dSbLPBhf5BG/rv2cxdCJwugK?=
 =?us-ascii?Q?s2b5WrIcyp2nBB2QmY6gj0T5vrefAQcFFJUw34wmHjaDRlPh4//3uI2VOL39?=
 =?us-ascii?Q?AUrEDOSJvJZfnhi8M1lh7dYbF/fZF67n9q5ewGELc+nse7GoSYjgSgXNiYVR?=
 =?us-ascii?Q?s6VuzNedb5kxK+nxRamyNGshCObrfEHA0HH/Umgql2x2AqUni+8rSVevKEeZ?=
 =?us-ascii?Q?niivNsSNkpe3xma40oUMgj6TExsL0Pb/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d8dc354-5fc1-4f8c-d47a-08da0b3cc93c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 13:14:52.9746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMOtDdDqSgG9mnFr779BkwfnIzBkvIjLeJplgniAhpRTRrN9fBj8OeSfKDtPKlRP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4403
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Mar 20, 2022 at 01:03:50AM +0800, Xiao Yang wrote:
> diff --git a/include/uapi/rdma/ib_user_verbs.h b/include/uapi/rdma/ib_user_verbs.h
> index 7ee73a0652f1..0660405ca2cb 100644
> +++ b/include/uapi/rdma/ib_user_verbs.h
> @@ -1298,4 +1298,11 @@ struct ib_uverbs_ex_modify_cq {
>  
>  #define IB_DEVICE_NAME_MAX 64
>  
> +enum ib_uverbs_raw_packet_caps {
> +	IB_UVERBS_RAW_PACKET_CAP_CVLAN_STRIPPING	= (1 << 0),
> +	IB_UVERBS_RAW_PACKET_CAP_SCATTER_FCS		= (1 << 1),
> +	IB_UVERBS_RAW_PACKET_CAP_IP_CSUM		= (1 << 2),
> +	IB_UVERBS_RAW_PACKET_CAP_DELAY_DROP		= (1 << 3),
> +};

Doesn't need the () but it is OK otheriwse

Thanks,
Jason
