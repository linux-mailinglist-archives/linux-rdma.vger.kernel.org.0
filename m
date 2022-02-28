Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1434C7208
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Feb 2022 17:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbiB1Q6P (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Feb 2022 11:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238066AbiB1Q6O (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Feb 2022 11:58:14 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D671EEF0
        for <linux-rdma@vger.kernel.org>; Mon, 28 Feb 2022 08:57:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SccCSlSgg54uh0Zipuq2x6ApxnBE5VUO9akYrUN/eCrgHRS5ZYVE+g6jJQDNAGp05EZ+cTYpvNkCsXC+WnsIztevOHTpXMB7ONAejbYF+QTfggXw1bH4z/xxgCQaAIHvlT6Fi5E2sRYpXVrVnUsoHbIROxHCpkLmf/aPY0V3rB4wF8BbZjs4LfBOVmgeTa3PRL1f9kZ8xob+xZSBUBB41126mDSw02mjk9mT7e8DvFmckYCedmS+qWppcEOd2LFlQgBn0CdS3z0INna2WLvMTUwyPyFYAFB5yhe6l+XOtjMtLyopAX5YFuDPyMqOti2s9+hvRO3CcGloFEkmBHwscA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RUrd3G9PK8BmaJN4u089dcYTfxXLO6nUXpdazFtoSk=;
 b=e7QDOJf2jvcvWqGxpbke9KvY3MB3733ps6YPOiUjVAo62PFmHvdC/sCmb2NrbxhBcqnjmZ3D6wiy+N0mHZIYYGhz+sX8L49/Ju3xiPmACfGlMYS7V36RHpSEkSEz1Qbr7OXstVbt42Ct8tS9h6SZe9sbtas5D2jrSttIvKCjHchsUi1R/9iNumCnmOeHi5ADADC6lMQbw+7QVgXAN9rpP9BWfceKauFrpkAGCFdMbu46dHC+8xYwaC6Kdb63HQTRu1kFwNXLOaEv1pxnsdHAPLq8VO1YLigCmDZX3iH9jb1KUpHz/U06d+5+u0CnvGVdtR/Ak9+99sL7hONYQXfVkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RUrd3G9PK8BmaJN4u089dcYTfxXLO6nUXpdazFtoSk=;
 b=V+QxZoO8lmGW31Wy+QVNg8vg/nYK2JaWXHMkUuImUuNP9wDrEYpz09Cnh+ty1q2UAiKZ0L+Jfh/sXqLSqNkTWVWAt6OdXYCYu9TiUPrG0SGohxA0qfWpxdTt5ueqSPnzqGC0I2ybNWWR2C+ZD02klrO1if8A/4PK+/X1jAhJeRP8Efa1/a16lInuwYs2k+ce4PYTfonBNknmY6P2rqJEZK7gP2SfZJTuzyvrEofXI1IbcTbjUlY6n9MxtGMO9/k0bsHkGZXRzOIkHpCSafoIweJ+1OX+JBgFy1CO59Os96AMzlORAlJoXbgy8y2VlaMI87C+z37yj2Wz/EmxZB4EKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BYAPR12MB2853.namprd12.prod.outlook.com (2603:10b6:a03:13a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23; Mon, 28 Feb
 2022 16:57:32 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.5017.027; Mon, 28 Feb 2022
 16:57:32 +0000
Date:   Mon, 28 Feb 2022 12:57:31 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v10 04/11] RDMA/rxe: Replace red-black trees by
 xarrays
Message-ID: <20220228165731.GI219866@nvidia.com>
References: <20220225195750.37802-1-rpearsonhpe@gmail.com>
 <20220225195750.37802-5-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225195750.37802-5-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BLAPR03CA0116.namprd03.prod.outlook.com
 (2603:10b6:208:32a::31) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56b14e17-c13c-42c5-89ea-08d9fadb6946
X-MS-TrafficTypeDiagnostic: BYAPR12MB2853:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB28536B8A37F192BBDD34AD4CC2019@BYAPR12MB2853.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gPmrg9O5sMAmouZmI4oKFU+hIMt9DHaDo64x6whQF7+Zy+XC/ri4Ni6f0eEkX9rvdApsF2MQMa/tyfm39CB3XRtKHiXWgXkWU/aK2EJcKLIf0lHWwLXLVW0MbnnXHGxPKzLz2NYlGv2qh1mTFvqbEU+lb9mJ33icolNamhu9vRHLtruucE1IkH2tdV5lzx0OYEmPY99wzxEoJpB9kUDCPfy8V26D9FqKElyams7lhHHRwWrJi6g/NAOPXOt/6lqcncJbASG61QRngWtErYocK3/wK2qk03Rzs6ru7TOCgT7Hox+aqyY9rGmNEJg1/2rzi3bhXQzLrrzbr6Dn38caQWzsPpdpr0JyQkPCUVtG8LtVWVIMUaMVoF6CU49uOhqwWZss/zP0leQoJEgzVa27xLcnjv8HvTZyMIFpIdenNQVITJjl0HB+K1/snLBS6yy9fj3vAly6d23ZvgQFWjVfAzIgGILjwhkvoSlQLYilrJSTq2l3dgJEAH8mJTCjf55Endj3ELDlKEChW7+C1spu0TFUWMakiF68vvQaT219xr786DQ1HXBW0wt0eOv3+jXupRlrugb21OYL6xPfL0PmlgfzftNzoud8f33KR0GKAVc4kP91nJhz/npN45ncxclEKQS2bUJa/uDmM5Zx0vZDrXMvAH/wmjZaZTGUtuK3JRLukKb8FirEqe+zG7zw6ABl+x5GbpLA9lWEYKZyXhqI8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(5660300002)(1076003)(66946007)(4326008)(8676002)(186003)(26005)(36756003)(38100700002)(2616005)(66556008)(66476007)(8936002)(33656002)(6506007)(6486002)(6512007)(83380400001)(86362001)(316002)(508600001)(6916009)(4744005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1bXPXZxmUYShcXtVX/BqIy+KioDQ/otpyHCQSot5uTrMViT4FNMRzYp830FV?=
 =?us-ascii?Q?UG1Fc5BZJFGb2omDmso2lHArEOBQECj1EF3pXaKESP5X7vdkENrdrBMQFjx8?=
 =?us-ascii?Q?NeQEFEtjYT/WDSNU76wiB0LDRrLNbMPscP6wgzwHkJCJg7lg7reQRcEhSIK4?=
 =?us-ascii?Q?IXyzFU5f0d/PugZzl6Iu6dQN9tUPj5Ille4ghPVbjLLTT6rreNfMAtQAaIzK?=
 =?us-ascii?Q?sGpjrNfxErepjmsz6pw6qTH+3laTdneh3Z8DK4MIZRCuTdsFKEqq1CgMpLsV?=
 =?us-ascii?Q?QwOx+K2EJnwK0Oj0nj9sstLlohUYdu9liMNk8nZRaU56uH1YYuLSYwOIK5sw?=
 =?us-ascii?Q?jhzt9uAvRz7qTrGgA9aj0aaRoeWicx21crBbLdbBYx+ZNTY4Off3qFP0cwHC?=
 =?us-ascii?Q?jy5N505mjJk56xqVshTIs/NxVFO/dCFLZY91Y4REL9kbgQCsuF2R4piEHmvi?=
 =?us-ascii?Q?NTgaakqCJEuc5P5aMCOdjC4mVD5VkRI/tqzT7F2JL5/iY/zloCN0x/m4kxi8?=
 =?us-ascii?Q?CNYm/L+xR/Wb6avBkXGd4J8KZZZNrKctRSN/ymFcH83+RN7qTZSPpvIw62Bw?=
 =?us-ascii?Q?G1TGo0ycKtqYiGC5cbM/Zihgx+EW5xEJh0J+FnW30HiQeaNxmUQvyJNVgVsQ?=
 =?us-ascii?Q?RPrLfarRhR7rRRk/ouZRcEKfmnVezgSFI9rzwoZzoSGUDb64MR+jZLlDfQxd?=
 =?us-ascii?Q?cFhEkDWrFFz2vO3BN0avdwZ8LfgnDHyiMye0Kbvz52EGubHR1j8rTDeNbCbm?=
 =?us-ascii?Q?VPBU4PlhVTqQkiR/zU0rzt1+wmaJ3PcKCmD1/O0fVFuO0sXsb1NVCBPrD90I?=
 =?us-ascii?Q?0de6luJiv9tUUHiE1FYxOnxTABHMix7cpOukD6KW3aXf0URzqzjNS7vLLUxe?=
 =?us-ascii?Q?s2nzjdBL+iEFf3b0w5ges9wDTsEWPCWIH6zcs/5r8EgX3gUpTikqPFMFnG0a?=
 =?us-ascii?Q?6lSy8qHGM69e2szShAsBv4qh3Om7gZd9/+Ya8HwYXAd3xXXNwvA+GFMV2IzI?=
 =?us-ascii?Q?yIr6u4kv9ausiSBIycy/OKmBTApRe9LbG20h2IGMzpYtAC6e96tl1VR5dRGC?=
 =?us-ascii?Q?nuwh3qakc7rmeA/rT9T43GnXdSpKS7svPOEPnn1+fdgv583DurRygCaE9qBu?=
 =?us-ascii?Q?A/bNPaxZ5TPfoeWy1Ukd8+QXVwpJ5Ah6H4W8f5Orycij7hJOW2KGu029aIQA?=
 =?us-ascii?Q?DTnLfiLjbRIJWk8zWH4rF8ae9I+hV7f+MpP/DFn8R+SFyzSer0d25z3tKn8d?=
 =?us-ascii?Q?8P8Ohae4uxvnxJ3DS34N++NFO6OyR51ry9YhQrAdOdaKhEyppDLoPntPuLwi?=
 =?us-ascii?Q?ZZ7EG8eqcQIWkh6L2x80WnVXq/FEXfDDWHAkZJ/BNoFB2fM9YrK6sJ85LROU?=
 =?us-ascii?Q?78S+4jLYnPbK9m98nq0wScvFFmKAJgCR605SmJeUgvCUR5tDjcpN1JZktnIk?=
 =?us-ascii?Q?p82uWvZOSVy3XISaFmZCm4L1ku6SqVMjOhboTE3RWOiA6D2x6gBs/lCfJLXe?=
 =?us-ascii?Q?SgH02ZN831yA+R/yD93WSNSwljkY3HccuKaWjyz/ZafHKlLVxbZto237cjOl?=
 =?us-ascii?Q?VM/cM3JlMpWq5Bg/pKQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b14e17-c13c-42c5-89ea-08d9fadb6946
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 16:57:32.2198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UCOZIhgw6wFLnUo25kwuwd1koBOqaS0s6htVi5+L9oyX4rTnGP1hhV+eh9SzbLot
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2853
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 25, 2022 at 01:57:44PM -0600, Bob Pearson wrote:

> +void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
> +{
> +	struct rxe_pool_elem *elem;
> +	unsigned long flags;
> +	void *obj;
> +
> +	spin_lock_irqsave(&pool->xa.xa_lock, flags);

You can't reach into the xa_lock like this, use the xa_lock()
family of functions instead, everywhere.

Jason
