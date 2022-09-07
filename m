Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92E05B0AA0
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Sep 2022 18:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiIGQtR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Sep 2022 12:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbiIGQtB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Sep 2022 12:49:01 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278D623145
        for <linux-rdma@vger.kernel.org>; Wed,  7 Sep 2022 09:48:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHDdZgbaRX8dJZmWKDKCviI6BdfShtIrrYB2v+YcGVnFp75MLHzG9wG38493yw47bcAkBtpva36nJ64r5wA19UgYCf00mXg6FytVCaH0U5kZlSIwnGegiTf+d5TczfaJtjETZeTsQS0J8nnuEIJnIgV2LuQE4Os8HKk1Ul/xoylI1UEy+MtwzgEzwy31IyQRexq2zACImoShi+7KCtiVHH/Iai37JCcg33Ad8bRKfm/WgUgXZH5w7yKXFyZYMMOwFWKfuyNuyCylj+diEkqQceNCt9TqUzR2kDbxdCuZrbMwZQg4bZLU7qM0rAk0n9elLWgsqgC25kxzhgr0X6CG4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s4XurXFLhX2Wmh/qj7ONrt0SwP8o/eR6UH08BJSnebs=;
 b=BKOBvHwfYOpuqfLKcY8ZjGCAEFFAXk3Ce/MrPSizXxGOxJMOIt+iQvTYa2/GhnRvQfeAEDseo2Hjj80UK29sX3qh235ZTITT83Sm61cuiu1ogBWrCkYUTDOEjBpfJUE552G+byG1/PeUNLaW7s72Np5yp/qOfyiMa2PtXs6jnHwOml7mRFXC2J+rb43qohHWRIVdBLg+IFVYV+LfmUUQBwix5vN5pxIkDNpGHSzMlSPNHiICwLs1H2yB3ytJX+aGRaLg4NE4a4n3fcObFZ/yFP/34SqmKNyyYFylKg0V5IdsEw8IvTWhMPO38YKsk8cwXPP77LGa5rMgeCPv1E4rNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4XurXFLhX2Wmh/qj7ONrt0SwP8o/eR6UH08BJSnebs=;
 b=YJq24PMbuwI6xqXmQHTkEt/2mTem30yRkZpsLGvZZEA915qLhXRBVuDRHrNkBbBTecGuTunWvGEvcr9qpFiwnct2gLAkSxJZw5AX58PM9Yp27OJ7SHj8isUyqokfPTtbdbk2pI0sYlqq4LTJyPPJz4q+/keopjhkY9lBfVIR4Xjl2lHCJe7qqlxjJ6LogdbGxuJ6vfC92AqTLLQs4jY5qIzsBavB4boHa12DzzRq446esAvxlIPl6cerqv1QGsTsmO2MxfGWiLLdN+826lKFTNeslZL7e106j0zDX+LN5GglkLmn+jeRKwz0fvMpngpZh3OBfJUgsm+yLEzE8ksZOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH2PR12MB4279.namprd12.prod.outlook.com (2603:10b6:610:af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Wed, 7 Sep
 2022 16:48:37 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5588.018; Wed, 7 Sep 2022
 16:48:37 +0000
Date:   Wed, 7 Sep 2022 13:48:36 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tom Talpey <tom@talpey.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] Add missing ib_uverbs dependency from SoftiWARP
Message-ID: <YxjLZFX6Akk/r+Ge@nvidia.com>
References: <4e7574d7-960f-9f92-e92f-630287f1903f@talpey.com>
 <Yxih3M3rym7Abt0P@nvidia.com>
 <0b035368-5da3-73c6-4d6f-1e22bcc70ecb@talpey.com>
 <YxilUf2HbA6PAo59@nvidia.com>
 <3a9fed9c-2ac5-dd78-a63c-5d9dd61d3c7a@talpey.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a9fed9c-2ac5-dd78-a63c-5d9dd61d3c7a@talpey.com>
X-ClientProxiedBy: BL0PR0102CA0052.prod.exchangelabs.com
 (2603:10b6:208:25::29) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbc4ef75-fb76-42fd-43fe-08da90f0cf68
X-MS-TrafficTypeDiagnostic: CH2PR12MB4279:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SN9tRL8DsYc64BlWHnO4nhXPTxbN2+6+U6UjPCoTPUro0XjvseKBIV+xe+0VWHjUhhYPI2IPqmoZERNQq4HXY1zZyz8n6ANT6QHAFGMXQgIoRzdKKM+XEo5H2zRCTIgHE2nUgZU+zedxTCJ5VZ8QaWLk04oYFb8ZzomqmKFIt1fImMKTTZqvTV8CKus7bln/EryXvE3vvhBTATRQnTN9URig57AVEOL+er6kjuurrL5TL8wloiBQfMq14fMojZpv4zsZUEGABZgoHn6MG7ydVvsQbpY8W4mhcbndDA1WTkF3kxOygvqgFaZ/M7XIPD9FYkXcdhD4mzablSVZnhg9ZS7SQErXocrOLtDVJnAUifwSPms0KHnhHRS+SUx7Y1jyQvzvVzC8yQqxlCcPIs6gzZC/JDeOzGqRUaV8zm5gJ5WSsFntE/IKgLEeFYhFg9MyzzlH5CFDCmRnpH4hVqSu1f4LyHIoYhgr3u2UwQxgRtOzVpccsdpJPRcvD82KJQW0zC568ShnyzlNzg7aija8hkfukGuL1cgv1Q2rrsPdu9cbypfWqiQqPE5Sj4zYlhx2VToIMTyHXMqJgUESpF3NThTF+rbMcOhCe0AcksIDKWK6o70n2FHSLZlD4iDGqsdHxZUerJPpRaSC6HAeEwGxVPwN285+OveInQ9S837JPBGrM0FbPLYFXT+D9o7HLb+90YQarKfgLaA4N6+4H7FlkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(316002)(66556008)(8676002)(4326008)(66476007)(66946007)(2616005)(6486002)(38100700002)(41300700001)(186003)(6512007)(6506007)(54906003)(53546011)(6916009)(26005)(478600001)(8936002)(86362001)(5660300002)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i8LiaONgdtFj68J4alOi1m8lh46VR/y/AtGx7H8+XNvZxVVuZlHJeYJBB59L?=
 =?us-ascii?Q?wq5lDyLgi68tGUoBEV7NdgZx8luFgnKYd++fEtzd9qTAEetAeDCwfhJwJOl+?=
 =?us-ascii?Q?OMF+9Pi4PMGJRiUyox3MDfQfxLFyyOKFYPPGxEmutg/HnwuJOpmtE7ySsyfD?=
 =?us-ascii?Q?Ix+I+Qt0UQ+zzUveRA1LqM6i29Brxard3UsLksjNIIS51mYdJMP97DXh71q/?=
 =?us-ascii?Q?0KwHcsH5yWWrxbtxmCAzN3JiHP3fgcax4AaLd5qao8YHNaeQRGne+1bGe2/K?=
 =?us-ascii?Q?97F90e01F27CbYsS9Vf/dJfZVv7fHRJahP70rFxpXpsnCYFrwAarIft7Jiej?=
 =?us-ascii?Q?c7rDTMQRREDXxQE6li0SEXfjUyw7UlcZGBeWAXQaPjeEOQ1bzkAxxicL7c2/?=
 =?us-ascii?Q?4G5xRinD8V8A9RmuvmEyFQBSnCXWuGQxCmYeCIbRwI17RM4d/y9wSu4ap5eA?=
 =?us-ascii?Q?ckoJ+Q6E8zQnb8Tgxu3Hojc5l+DCKUfFfpYgOaymb1pZTLuEktYvXG31j4js?=
 =?us-ascii?Q?GBxY5rG/VbKlKWO3wS5485371n/mWs1jJXZIThm8ClRPElAu4aMuPt/O7qef?=
 =?us-ascii?Q?3Pco137O5Eo6Xk+Aql0cROs6TBlmk4NcKDUls26wPeZWgk3jsN7Xt1Di9M3q?=
 =?us-ascii?Q?71kLWfJpugd6PlsQJFdX2yTc4aZgBwRgliCKNT469Dna0aCCGunR2pwndArt?=
 =?us-ascii?Q?ywj8K5E5SFcoXb5sYpwwFoZeIvfBTPHerCG4jPPW53gycheVZLt1mzVvxq7w?=
 =?us-ascii?Q?xxeGpE6zdvjqJCXa3XtgH0aI+vW8yAFCh4zfplb0klIcRHy0fvVdxsmWRPT9?=
 =?us-ascii?Q?t/MkqMKZCuUrN3y+Sw6+mAo1Owszb2LO5Xxab8I3vKPn/Ojh6h33xBJrWlhJ?=
 =?us-ascii?Q?G+J7gdd3YV7KaoMRGpUNGLmyfnGlMD1IvCJ7ratpD95rjsjEFwFWIe87Wa3f?=
 =?us-ascii?Q?eVE274Nr5TAtjjYomF5Mz0q6w8+OaJBiPw6sdScNEAf9gSptrFLjE7ncgGVe?=
 =?us-ascii?Q?DOuqkNFf9Qf0nD2I3nYOJ0dJUnqv/FZhsLIpHYCubHOVN5PPP+NI4lBXu8l6?=
 =?us-ascii?Q?DoTZfdQqQw0myo7n2/dO6pYkfb37qLB3eeoEB32CHyK+L01qgQsxrzoKgNjd?=
 =?us-ascii?Q?WTRGN51nCt1ziZqAzgMLUNIKafsmqtGRDSXpOvyuOPmijAPLOTRUNvyOdm8a?=
 =?us-ascii?Q?d4Hr82StzEIpGVVW5M+zct6IrfMeJQVknQrIemCzpusruzL+fFKYoklb46vB?=
 =?us-ascii?Q?n5j5Hnb1HNyULY2x1Twqb7C+PMaTB63cmcW/WMJPI181tsu74/l3H1x+qq/n?=
 =?us-ascii?Q?z1y+ithhpYTEiveXXBCOd+eaaP96oJV63aeBcQ2o+imI03VIn1+5PwHXKmPz?=
 =?us-ascii?Q?SZqu++t7khxcjx9xqdaLavaV0XzltbyYWEvxzLvsWUIK4yJ8JzgmxdShzCx/?=
 =?us-ascii?Q?z9md8N7I0iX45DP61QL6KUPKSyf6dY6tFHyguAVq0JcEGLDsfr3RRkBDY8wY?=
 =?us-ascii?Q?GlC95UGpHp9uEOSuMc/RMMiL9jgSXqJoWxQKwF1yxDMugRIUwLQ7lbdUxYj/?=
 =?us-ascii?Q?WoRfqrWG12Kj3brcdDwzjiYmPOsYCpIwigAFl1vN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc4ef75-fb76-42fd-43fe-08da90f0cf68
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 16:48:37.4020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mxuWqoaezrjXbUMgdEStSuFeob3x149PSY8PRspShzGwihbBlfvsTJ9CEo/2YYY5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4279
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 07, 2022 at 11:24:19AM -0400, Tom Talpey wrote:

> On 9/7/2022 10:06 AM, Jason Gunthorpe wrote:
> > On Wed, Sep 07, 2022 at 09:57:43AM -0400, Tom Talpey wrote:
> > 
> > > You can test it easily, just load siw on a laptop without any
> > > other RDMA provider. The ib_uverbs module will not be loaded,
> > > and the siw provider won't be seen, rping -s will run but peers
> > > cannot connect for example.
> > 
> > Perhaps there is something funky with rping, it works fine in simpler cases:
> > 
> > $ rdma link show
> > link siw0/1 state ACTIVE physical_state LINK_UP netdev enp0s31f6
> > $ sudo rmmod ib_uverbs
> > $ build/bin/ibv_devinfo
> > hca_id:	siw0
> > 	transport:			iWARP (1)
> > 	fw_ver:				0.0.0
> > 	node_guid:			7686:e2ff:fe28:63fc
> > 	sys_image_guid:			7486:e228:63fc:0000
> > 	vendor_id:			0x626d74
> > 	vendor_part_id:			1
> > 	hw_ver:				0x0
> > 	phys_port_cnt:			1
> > 		port:	1
> > 			state:			PORT_ACTIVE (4)
> > 			max_mtu:		1024 (3)
> > 			active_mtu:		1024 (3)
> > 			sm_lid:			0
> > 			port_lid:		0
> > 			port_lmc:		0x00
> > 			link_layer:		Ethernet
> > $ lsmod | grep -i uverb
> > ib_uverbs             163840  0
> > ib_core               393216  2 ib_uverbs,siw
> 
> 
> That's odd - your ib_uverbs "Used by" list is empty. Did some
> module dependency cache force-load it? On my system, it doesn't
> load at all. With the proposed siw softdep, it does.

As I said, modern rdma-core auto-loads it on its own. There is no
module dependency causing it to load.

Jason
