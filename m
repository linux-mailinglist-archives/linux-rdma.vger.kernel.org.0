Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89C861198C
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Oct 2022 19:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiJ1RpE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Oct 2022 13:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiJ1RpD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Oct 2022 13:45:03 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584C8357EE;
        Fri, 28 Oct 2022 10:44:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OtHqRP2pAI0Sx+31M6HY468zxoFwTvKc7cplsxdHMnK+FLECkBOeUWF4fdIB8QddxT90+ojR5xxT7s5SIJi88ku0T0gMSxpE7eIoJj7jzpGvOSLaPGm0XiAJEnabpABdY1zmDruGffCbGC9Ex+4Ua4lwhXFk3t5Wo/cSVyskb/qQUgB18yq4pZ3JRbhi2ypm67n5RdzptWhidFDDNxWw2vQMkMr4N+IRsONG9uEHEyMGZr1XSTnN9HTxlVM3DSkuY4Gc8XTr4jhIjUsjlyB9grIAQ5VG7jvUJ0j9P6vS60aInkeTGly18gdShPywIXd6DMDwEuhqUltdFRqTst2t9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=giwP/WC5FIf0J2ASahKyIGalgBYV5DAKVFrhRVkGhlI=;
 b=itud8Zu/IVEmye6dg3BXO+5VZJwMCxNsbgJpzE2aQdAa0DLNBJG+xmGERyKMg1aFArvSEyYba74a5Ojbu8H/j+UI3AgTSfV9ifIUO4pHAV0ZcjZnqAPhYrlmeLtA7cqXf3+HZQgPfpbOYm4bhbV0DgWeUUZVlxxjTItgwtR26H/aZXTmh6h85CuVOTI5C29TiQxDobZIIFlCaJ9uR2+TNbthKOF1ncqn0570L7nwzdCC97MBm39DqrzlkHk58syMBw3zXVzjwt82txC0717IJpsF1GMDzHoiym0OB2rOy5t39M/ZzgY5sxrXp0avvB1cOSAFHyY93ZnwM+5i4ZTqAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=giwP/WC5FIf0J2ASahKyIGalgBYV5DAKVFrhRVkGhlI=;
 b=pWvQ/Fli8+NU3SXUg2vfaJjyHamW/wRcHsXx5qrRQkAP1VCb18LEZ00suSkz5qgoPxyG8c9zrq/xGVJXAdrMhGXkmPOfTw3EBKTZEwBzmFiqd0pAuDMGQ6Lc4mnX5JAo3g2OoYLhjLndE0OIiyavcQFaJ37DkntFZY1VRfTtIxU622krbCPHj+FTfiojjK7Zc1z4tqPAlRHaqMJpW0KjaDlNu0k75zu+J8qPHRa292Imi6Fs5B8PoS2ZJhne5+h7hlUE22HNR8S3xyTmcIzX+M3KYSfmTkO0NfO4OUbqHJqMjuTwzojy+HFmeAFuJ4fN5WIFyw/21Mhgk3d1bMkh7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4370.namprd12.prod.outlook.com (2603:10b6:5:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Fri, 28 Oct
 2022 17:44:56 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 17:44:56 +0000
Date:   Fri, 28 Oct 2022 14:44:54 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        Zhu Yanjun <zyjzyj2000@gmail.com>, yangx.jy@fujitsu.com,
        y-goto@fujitsu.com, mbloch@nvidia.com, liangwenpeng@huawei.com,
        tom@talpey.com, tomasz.gromadzki@intel.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [for-next PATCH v5 03/11] RDMA: Extend RDMA kernel verbs ABI to
 support flush
Message-ID: <Y1wVFm2SVQ/ZLUpU@nvidia.com>
References: <20220927055337.22630-1-lizhijian@fujitsu.com>
 <20220927055337.22630-4-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927055337.22630-4-lizhijian@fujitsu.com>
X-ClientProxiedBy: MN2PR07CA0030.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::40) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4370:EE_
X-MS-Office365-Filtering-Correlation-Id: 887fd9e0-2a20-4072-3c3e-08dab90c2044
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +rAZ//NByxADDUT+wpSjDaz5Efc3jXpdmOayIg+P3CZj2nPLH67i2hFj0Fot+ouSjPfEKj2uQMrC7GP7v47HhP7q5mOQBekv0KlMB3IHD8TidIppHWWUvTiF34nG+ORTFlN0Lb9H5EkmuUL95HNojLpsoFM32/TleiRHGvtuPZEGV3Fd57H1hKlE8rk6X83SlHZhcMfnkGe8298RAXFF0FcF/A23pN9A6E4IjEFHo+LN1wm50g/x/RXiUx4OwhYqIgc0L4ysg0d7t8SGthZ0+GMrqIAJezuSubF6r7jnjMcl+MsFKcIDI0EHo8/ydcQ8/89HT7vfu80EdtTtHsLoKChfvOu6MsOw3cTjfTD+AWMH/vh4L260159AE7+22nuoopXFiVCPRHHwyjpv6ux2D4RDG9B0OYFMIchzlcvwmnDNpSaJgPH3UX7zp5hGR+xEYqas41yodyWtLeJArcYx5UkIKyF4sheyvFBbuRP+tbe+AWPYY1xknNugSuNjS8LPLZPh2GM2IuCIbblQqdxKw2jXkgLMZFbjs/73Hvr8dd9cN4B24pqg6Rr0zok4Ie/eJ9R+7yEbdnAjoeLL3l8k3sosRERGKc++UbebMpYDaSTNQJPjkoo/NFS4l0VnxnsYDKWiNhyzrRKwhSTDm71DTM8Wu2Utb3xdqWbLqpnIa6uv+9jFvHQBLkp8J3XTWn1NFCPWL2jBuBeAR5Z9TSofyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199015)(2906002)(66899015)(186003)(2616005)(6512007)(83380400001)(26005)(6506007)(7416002)(66556008)(66946007)(41300700001)(478600001)(4744005)(54906003)(6486002)(5660300002)(38100700002)(6916009)(316002)(86362001)(8936002)(66476007)(8676002)(4326008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rY5PSlvJDQSHYYimPfGIcuArGWGCryDu9OX6yMfnbFrmnsDIcjkGbPuPSapj?=
 =?us-ascii?Q?aKBwWkuR5VBiGyciX4h3NBcQzNaeJT7WweMWAOuJj2QKoneBa/3TX4eyjkps?=
 =?us-ascii?Q?QG/94fEPKJCTBi/XzTbJIIBMSj0tUIqIaZLAnXIK92dUZd1LeZ7KWQIhOg0l?=
 =?us-ascii?Q?2nh57aTBfmYjFK6EAI63Fi5CaFzXGj+PAXF/OWZvWlr736ZAIZCPHoeSb298?=
 =?us-ascii?Q?CvGkmO0ku+yDDOWk/d5iTKr5uU2QUTPkvPfm3edDnVs6pfqViC4wC1nQpmJ9?=
 =?us-ascii?Q?qvYc1ixLgBjifO4ZvQOW5kRt3GpaZSu/eaV+qVY3+hQefErUS80URhcFU93e?=
 =?us-ascii?Q?jdI2XrcOcnJ7j9dV3aq6hMCxi7ml8hZJPLy8GZiEiCSF8C+L0wHx/+t0iENt?=
 =?us-ascii?Q?Am6wkW6xxLIdYJfholEWSw1Nb7IPWcJdRXwby3C9VpPR6B2wuHc1IC39kxcG?=
 =?us-ascii?Q?CSORxP0DH0gyxyCFC8YtMikF2QnFL0wL+xx4MlUU/2EQ5qGAdvW/kPTUdEym?=
 =?us-ascii?Q?YmSQaSYuUGkVtFgkNUbUJLGk4INiM9aEnFUhmPu8wTtHvbJi052Rfb+pIoTv?=
 =?us-ascii?Q?bgtuY54/CmStKPP4XWvARBNBQ3wC2tzQ+SDlReAcDJ07CdMt6HD9YJ9/ZwbC?=
 =?us-ascii?Q?/MsegkB3Ot+chIDRckRYuxcd38lY5O/5ZJJD+QrGbnO4FgUVjiggrpF/OakN?=
 =?us-ascii?Q?ffE/uEAiWL2vEUx5UZhyXHnSfqgsP9f00Frc3jeecA13qGsobYN/P4M7kA+/?=
 =?us-ascii?Q?D2MNvRusLAl2YGKXVU0B4YsEKa6u1qzhyn7BtCFWvibz183t9KJ9gvA1rY9r?=
 =?us-ascii?Q?g23bXF3wEF9L4JpqQjKRTk42/57pDPK0BA7ScwPfE96MK39CfcaTOfsSAy2T?=
 =?us-ascii?Q?E6PVSiLRZcBSdw6GcAi8LZVqU9XrrKR24IQM4xMvNWMaTDR7sGmtpcY3Qbt9?=
 =?us-ascii?Q?b9ZaztQl4ZpoM+emG5MB9qJblkMB/zs2me9N6RWuoTR7Pl4l9Wr188vg4O7o?=
 =?us-ascii?Q?5vF5ytXvJQPKSykE5YOFpYET55U7IQWgvhmWeqj1KSCWkwX0DIZNpasxLGKx?=
 =?us-ascii?Q?Ghg1WwXdMwM75uXiEpIUGz1U0O+hOkdd0ISXE+2xAsG/C6w8QvtJN23dKq2u?=
 =?us-ascii?Q?5K5+NffYL44BJDNAqVG6uoQhC37KV58av+N3z32p9p+XAPf9LBr8Jm4Ix7On?=
 =?us-ascii?Q?uPrDDdg6zp8Kepu41l8PfvyjSlaCCh/KzgVAPQvsN1gB8O+W3uikSkCQalbj?=
 =?us-ascii?Q?Z0GZ3dn/hKRc8JOLk6+NCmCSPiTb8pRDdnHRzWxIQeODkyCjVshmiOzITFhN?=
 =?us-ascii?Q?v9AQnx8sSbpjk5V1EK5/WSWvz4eNNr5mxzwNmdgsNPh+RYh0/Lx4VhICq78Y?=
 =?us-ascii?Q?r3fsv/StBgNzafUU1cDgRAa5WLVrHl6U0zIh7MTnLy3LQP5s0/QYlB+fQOKR?=
 =?us-ascii?Q?N+9op/idTxw6jndjxSrBHMmnaMr0tmnXiwj7wqEJmrBLflCB0Wzj4TzLRqJ1?=
 =?us-ascii?Q?6Aqi+HM5QZXlinsoodLWl/6qKxxAOmV0knvo1DRhVqSmarUPCM54vx/d1xOd?=
 =?us-ascii?Q?+47YgZR+nlzsfAXELEY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 887fd9e0-2a20-4072-3c3e-08dab90c2044
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 17:44:55.9841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DPDxQ6l/WhcDE0nsgjxG05whqwLZ/365szAbhO7K8TBsbMQaOsSSRCXfAg2KOl+2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4370
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 27, 2022 at 01:53:29PM +0800, Li Zhijian wrote:
> @@ -4321,6 +4330,8 @@ int ib_dealloc_xrcd_user(struct ib_xrcd *xrcd, struct ib_udata *udata);
>  static inline int ib_check_mr_access(struct ib_device *ib_dev,
>  				     unsigned int flags)
>  {
> +	u64 device_cap = ib_dev->attrs.device_cap_flags;
> +
>  	/*
>  	 * Local write permission is required if remote write or
>  	 * remote atomic permission is also requested.
> @@ -4335,6 +4346,13 @@ static inline int ib_check_mr_access(struct ib_device *ib_dev,
>  	if (flags & IB_ACCESS_ON_DEMAND &&
>  	    !(ib_dev->attrs.kernel_cap_flags & IBK_ON_DEMAND_PAGING))
>  		return -EINVAL;
> +
> +	if ((flags & IB_ACCESS_FLUSH_GLOBAL &&
> +	    !(device_cap & IB_DEVICE_FLUSH_GLOBAL)) ||
> +	    (flags & IB_ACCESS_FLUSH_PERSISTENT &&
> +	    !(device_cap & IB_DEVICE_FLUSH_PERSISTENT)))
> +		return -EINVAL;

This should be -EOPNOTSUPP as the above is changed to in for-next

Jason
