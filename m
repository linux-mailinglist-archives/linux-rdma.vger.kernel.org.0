Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B92957D3ED
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jul 2022 21:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiGUTQP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jul 2022 15:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiGUTQC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jul 2022 15:16:02 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA6A7695B
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jul 2022 12:15:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=go3THBvSpqhXEwlZ0/6p1FmXfSGlXyU3lxMwhfMdGaZ+xWHTn2bhwEVjRHrVlnXBF2X0PzWbC8+HWle/hkeLmEzyb+fC1OZXnyCKZHmde5VCDumf6BOf0cJPiAP9xXXG1qxYQV51+wIzMBL8xyPLpQKgd3QtO265azeYpJlFyC1pLiKuaxNtw2XUBACWw/IAhX2ziEgyFgQENfV0P8OQ3yqp3GgXUhXhzNrwa6+CujO/bNM7EKg49lbEGQ+X9HLHeOa/rrmtcEtpmhw+6QRa5YAD9UXxImgj7+HzcJn2g4+mvMsMelfn4sr0AjQNTCsyyZH9Zpf8Olz4CC6sdrvetw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rr1R0fk7bHDyKERr6d/6tPLAi3ahuLv2ncUEsjYoCWw=;
 b=MFs0eha+m4iAQS21S99km+wkbOHJh07BGjzltIiCn43xexNmQQL5W7GQ6wwN/impfvTDyLBjh49r6jjDJroyZf58zpH6JV4D+9G7ZIderEgwAYrhK0T6LHGUVgRTEBww2PuK+N6GJ0j/32mHRCsOHsvnUiwUCgK8c3i4BDDZTISxgFZnzQQeyWyezsu8sUluMFYzJ5eSVZEW1d50aHN+Izk6A04IJiGjOHEE9mE2YAzCdRxlwahj32P0/oJOgK7ZwdG4Qr0SjhHLGfccOGSSYo8fTMxBNAQH1/TE5bmZz39B2iX6edgRKW7Lh6rTJbjrHdgwhh5rPDxT0USrYvNqXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rr1R0fk7bHDyKERr6d/6tPLAi3ahuLv2ncUEsjYoCWw=;
 b=UW5ntD67ueuH01++RAeRn17reKn8852J+ZqSOhg9NhP5BeGnrmgQbmJXX/tM0QA/LZsQN3+W8/V7Cu7hSx2nMFP853UESpX6fC2xewvkCak8pC/I8gFr2etfFuTZYZdo/9kSSB0Qy1rZb9y1DqVay9D2bV01TgOI1UQARKtrhsvousQooMEuExsXEGTfDBxCoM2P2BFrkQhu4jB8YSTQlt1WqGIefbVD/dhyiE1Fs0GlOuL7uEIGokywCJLMZa7umJuk9yR6YHSdIuQJcrYx+TNiD9PZREWj1NmfFshMZojXQvuvc8eK6YdFI+DgBMQjLBpMpOa6B3SYURcryqIpHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by PH7PR12MB5733.namprd12.prod.outlook.com (2603:10b6:510:1e0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 21 Jul
 2022 19:15:26 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5458.018; Thu, 21 Jul 2022
 19:15:26 +0000
Date:   Thu, 21 Jul 2022 16:15:25 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     lizhijian@fujitsu.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/rxe: Fix error paths in MR alloc routines
Message-ID: <20220721191525.GA9189@nvidia.com>
References: <20220715182414.21320-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715182414.21320-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BL1PR13CA0436.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::21) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58ebc215-5b52-4c2b-edd1-08da6b4d5e5b
X-MS-TrafficTypeDiagnostic: PH7PR12MB5733:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hKm0Ab5SQaSQNtez1iOnXGXTG/ivJ9SrgqXPSbYiEqHVkshLu3pGtRj/1LxqyH2v1Xc24KBQrp7pFAX/6TzqIKeBp9ct+6zn31tlWhQAXC8uzSMUEYUNpc12PF0k8wVX77R679L5Ueps5T6i4BcK5ZCw7S/0Visg621/i0iqfnxVjAV4ceAEagsKqcYKiU2AE1uJ7FfPwK4qHR/HlOvKQC3Gn1O9hZkAgj/qFsNmTj7pdjiGn0kiWemBqAVJFCypMqm15UbPv31FIS85JDkfXymt98B1u8isV1unsu6/o4iCkl7P5gpahW0/Jm/tKLNSTEJF7HdYuurks4raTTanpQ4p8tAG1+6d9cPV6Htu6HjwgZ0PzNs4YWJaJVDpDg5UeF00Ohbc/C5Kg+wx+qY5dtnV2F3ZVkCt42J0j2bBitnCUW9aAyX+5L2rZnj2ylQU5lw2F4qDSQAv3Nid9Fh31TLk0LKHRhi4DQKJSZu1TngG7qztpBTNAvdQcsGjO7ocIz88m24JLOHjqVg5vic+kdgd08F9y7wDZn3e0BIrtGjMibfMdurChISSBzGneN/QxUnUgkJP7LGrSLYMxbniB6+MwVO057Vb9CFxedcb81vqDsI6o/5URY/gXNALlbHj2O0VUu3SuDztdMsc5iQDEb4DX4hohVo5V279VINh0UZenrFhp3A3cab+IkPu7PB0/ebK88HGrCjuoOP6WqFL3bYxky8nE0ItiZjvXl6rOWk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(83380400001)(4326008)(8676002)(66556008)(66946007)(6512007)(6506007)(66476007)(41300700001)(26005)(33656002)(2616005)(316002)(36756003)(2906002)(86362001)(1076003)(186003)(6916009)(4744005)(478600001)(8936002)(6486002)(5660300002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vzJjK0pyqa6Ezjnqf+r0BSfGGc5zJ92bgztV3T1V34uU+dHYhub3/xoYCKZG?=
 =?us-ascii?Q?42d5SWc5dvPMxyB2Ef73XM2amBX/INuXiqTP2nCXevKEkxtquqkPfh9Nqqza?=
 =?us-ascii?Q?/wPndEjDej/dWvjhKpk34GAsDHNUvt6UdCWICT7vznFvNbpA/nZ9y/sLX4g4?=
 =?us-ascii?Q?aUQzbocjnwGAT4A7f9J2QZ1YHN0zxGsBEj1BttXBKyJvsWgicImUSGkgTGK6?=
 =?us-ascii?Q?vpylmDbWI2Yf3c8MAr+6Zg7D78mtK8kOYgEVP1wSRzzENQbBYcyUGXL/pUQs?=
 =?us-ascii?Q?kj75jj0IQqg5jE0Uq6bvbtR1TrMpLcY5wlCltYxkRSfisJWjEtXrn5POTfUx?=
 =?us-ascii?Q?k/pyaKUUX4NqjlKzArv8wvScSqtB0+/xRtmpTC4R6MxIYiEKZg4djc55j9H9?=
 =?us-ascii?Q?KIR9AEqYWVQkEp5jouwNCm/ztBvbmXJt99e4jbRH42J7+26GngubBN7fmkTi?=
 =?us-ascii?Q?2MiRs9/2aJv8HwacGdMfUGRqzLTw+SEPsedpbUjPWzSeUMBIOy5Xn1W/N4I5?=
 =?us-ascii?Q?Yduc1vgZOhOCwZtmjLnuk3XVcinoLg9GVJTvGeoYCKVyJcMZuJvEFaI3gt+j?=
 =?us-ascii?Q?kiqvA9JRMb0spJQCMCV2I/t/iPyOfWaWPB59GvLw+u/6g6KSmQIjhmQ/iNxP?=
 =?us-ascii?Q?V2PHGW5OaSbGbx+/fL1ACZHHZYeTpVOk6+pet0W3aFgB6mBdN5C2dtQsVuK2?=
 =?us-ascii?Q?zY2MxqQ/lRxbPdB0F1SMYuAWliYEJBji5ws2MQ48ZXpaliDmE8KEEEEPu2pS?=
 =?us-ascii?Q?nr8DQ+GqRQrguty7ppDQsfTa4UrFiiN02AmDzDpSthap6mdZKQJCQlez2M8i?=
 =?us-ascii?Q?5E6YJ+b28Y1kBEVmBYIQ70KrELePRAR3OL8UYjzYTfJepMBx6LjWvqIT9XLh?=
 =?us-ascii?Q?ml+SjcGjm2kuKDJNTVylxuqi05uJ+zzoOVOJNGEwg8/yAGsxOu2AFQIq7v25?=
 =?us-ascii?Q?KicoSySaSU+/3rfV8ihYdMVhPZO9FcN+Dw8IIa5f7uUVC0mDL6Nscp79ygWm?=
 =?us-ascii?Q?cH/rHMyvz/AOBc5SR86RpUeKmq+TXoKsYUCu/I+/feCVkJrzWLLemOQuG78x?=
 =?us-ascii?Q?bJDnHjPm22cGyDZUXLZ46cJcYwo3IOO00merkkVXnh4IWEaFD62TY6yGSqto?=
 =?us-ascii?Q?OSyloAo7QtlHEjolGNLRAFm3soBAPs6lZeBSVu5ne/6Q20V5dBDbx9cfGyEr?=
 =?us-ascii?Q?iKG6/HtpRaCUsa41kOLxXfQscREzZ9a6+5nmSQyup08MoObwxKctoeuSukAP?=
 =?us-ascii?Q?vB4b309untU+EWl5GNJjFBLa3WiHrDBK0PEadDoCRzUB0OCBwnBv49u6ALaf?=
 =?us-ascii?Q?d3LkB3oq2K4V5/KSkeuzg4U1tPCHDs3R5ff+YxKmHfd+9P5lnN1Y9Acx+Ouv?=
 =?us-ascii?Q?/RvK4tj0LGxlDRi1Jse7iW2aaJbSlsFhvrE4wmbXPl5CDL75lnCUXDlKPxVJ?=
 =?us-ascii?Q?rA/Mn38E/VMWcbdn9iwuMumOku9ibe2EiRKdnjvwnTKFEBzv61yUwuYFwb0A?=
 =?us-ascii?Q?L9vQMmBDXxusDrguN3kB3SZk902gDXW/P4S2Sm3zhlwd2/KDeHSskw1wgL24?=
 =?us-ascii?Q?nQexEUw+1xKsJfrr5NY0bUN7HAC8gAxX1okVNjW2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ebc215-5b52-4c2b-edd1-08da6b4d5e5b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 19:15:26.7801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZBkA5VSlmZD4bopTe+LRe1rbpnGIlBQ9JHa4OqGK7YFloTaiM3onxiMSMshn9Lsx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5733
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 15, 2022 at 01:24:15PM -0500, Bob Pearson wrote:
> @@ -173,12 +172,11 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
>  	void			*vaddr;
>  	int err;
>  
> -	umem = ib_umem_get(pd->ibpd.device, start, length, access);
> +	mr->umem = umem = ib_umem_get(&rxe->ib_dev, start, length, access);
>  	if (IS_ERR(umem)) {

So this puts an err_ptr into mr->umem and then later the cleanup:

	if (mr->umem)
		ib_umem_release(mr->umem);

Will not like it very much.

I'm OK with the idea of initializing structures that are cleaned up by
their single master cleanup, but you have to do it in a way that
doesn't put corrupted data into the object..

Jason
