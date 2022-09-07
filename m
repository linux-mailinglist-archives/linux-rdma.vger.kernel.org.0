Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9985B0613
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Sep 2022 16:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiIGOGR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Sep 2022 10:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiIGOGQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Sep 2022 10:06:16 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9330E8A7FB
        for <linux-rdma@vger.kernel.org>; Wed,  7 Sep 2022 07:06:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRBZ9jHvtyk5+IIAthh4wV2qRHg04NaUZRvUM+Mn7cm4JWdeTR1OMj0xWp3HUaidAQdgusKMJU/akpYPET2qM8rOVEsM+cty63xfwUI2tX4c7/FF8KaQQuUH5RxJ5Kbh0m1RldrmwX5NBqDLzq93vSiZpwP5FHKI0M+HX/olKHPpbofJ+/YFuM8ju2/PkVntH2Sc6zkTsVuSwJtDVKBfXTK7js8T5c2OoXnbFe0FnxrCRGGtvSspjvV6Ulql9Trqz/k5MZJNyTBWJRF/eukGbrKMEVVxrIdd8wAMoYAnjyBJXphqW3uAhUS/yfEI4WTdz8HvEFqD8bbzfZQ/CsaZOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qj2fozajoMUr+DEFy55AFYdzuSioZNuP7988aJSzjwg=;
 b=NHeN0YicuRXHNP+Z/0XCFyyqA7MgIX6jjqZ000MITUVCW7OSPKhhmNaDXF+dEe1ySSmR48C0J2HMUsim5z8/t54d2ahfxePkyVj/frkC4omVNPDiRTPLakdcVf/uyJs/7H70rKLJ+G3dOcacRRSOOdwitBpv2h1A9Ue44qo3+gnN70YQLdeqCnmjQnRRMUVbMC/H/jQzVA3A37/Z9faK7Qcn/xF5JYRCAyDzawJhcl32TcLqWVTff/7qJZHrbrrKGHDTRi+3/NxzSmiEPbNqFS6PEGNd0Jc6LuyE59FoPe2jn1DFRHdCNR1hp6OrDAofKt6frh4Ikd7gLw0MWVZF6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qj2fozajoMUr+DEFy55AFYdzuSioZNuP7988aJSzjwg=;
 b=HLGwEOES+dtr+0KzqfRY2hVab9yMe+eZKb1xuFh/5eDkoh8iJ1bSl9r++GeZGoG9z3FkXkPOeF3FlaWz2zYR1cJhki5uJ+xRjQB3esGLbdsSL/Sx/ALwXpgZHXduRWUEOdx3a8QueCmIY7Eqodc59syGkW51tmBDJ0WOFQ3FYnkLGy7LBo/jd3g9TVFcqVHbSdjKNYo7jEbIzgnwBFkH9LWUOkDum4m+qlWDhFei7e4H0yGO3xF6BqUx2BnOIIwPiJNWG4YXYglzDR+0ffHa/qw61v9jzg2qJ881/309ImHYSf3tj7ii6pVLQtfRCBCz2ihuuZvJDTHZpqkTtUvO5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by IA1PR12MB6041.namprd12.prod.outlook.com (2603:10b6:208:3d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Wed, 7 Sep
 2022 14:06:09 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5588.018; Wed, 7 Sep 2022
 14:06:09 +0000
Date:   Wed, 7 Sep 2022 11:06:09 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tom Talpey <tom@talpey.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] Add missing ib_uverbs dependency from SoftiWARP
Message-ID: <YxilUf2HbA6PAo59@nvidia.com>
References: <4e7574d7-960f-9f92-e92f-630287f1903f@talpey.com>
 <Yxih3M3rym7Abt0P@nvidia.com>
 <0b035368-5da3-73c6-4d6f-1e22bcc70ecb@talpey.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b035368-5da3-73c6-4d6f-1e22bcc70ecb@talpey.com>
X-ClientProxiedBy: BL0PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:208:91::12) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0cf68a5f-2ef9-4060-7d5e-08da90da1d69
X-MS-TrafficTypeDiagnostic: IA1PR12MB6041:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RYxdP+G2O3HAlEy/gjyy8fqvt/mdG942euC7STaJqtSYFqIJX0W2AzkUMgC2Q6n3uyIRbmltDdBGggsDrsIXK6I2wFOyNErcJFqi0CkN0IvR9slD+W6bnKjIOgQ4TpEp6ASVVGjRnxw1tUMCavWTRgfugNUXC+NQSPPj0VbNNWj8f7aC+vuPOLehcCKqb3GwWHwEJ62QUCT0QVRBq0gu9KajMEjZmoUxy6wWX5nX72p/YCKlMlJ2pouyIQ90ceWVAjuUuG5gAFBg96NKUBwYlVi7eq0TrnSKdAhfmGbkeaT+s45DggjDucHCN+rYuWSOm2z2xTsTjqrncrsRbfGDRvYtLS8hJy2cY7GESs5gTgQ+MSVWW9uISrQaCrhG0cGqZLeBWadlTFBem9/LE57y11v0tT7T5M3vMgFpJkU4OZz8Lxyc7p5Z64+s73CEGhmRMX4PsaN2R5Q4s+3BpBqe0wpPlcgZ0QVVE+jfyv6KzB9AtDyirIJRL2N+8JAxt8TArHJuSWDgUVDhxj9n9zSPfUEvvnhM3QrZhKRjyRVgE8mqrK8TnOoU7zgvFaSC3AxiijMVFhzI3sFlAZi/B5owjqwtg6waoZ4v3F3LAXqxP3+jrmH/EUOVQBM3bISdBg0sJXcc2t/+THizYW3A1uF6XIz0++eNnVYl3TEBOIgmfnsl0ldvGW4FQ1z7bk1PV6paE45DwO4jqgWPfSPInqgbCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(8676002)(66476007)(6486002)(478600001)(66556008)(66946007)(4326008)(6506007)(2906002)(6512007)(2616005)(8936002)(5660300002)(4744005)(26005)(186003)(86362001)(41300700001)(36756003)(38100700002)(316002)(54906003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PN0iQaBsZ/GgU2aMisFiVmSmrHv0HDsoXMSG/SXYOzD0mtJwCxRfY47t8RT8?=
 =?us-ascii?Q?Zn5HG/7nCWZEuPnnJd31HGioazVpYj9NjGz4gAZ+rPFl83qxijwmDP0rBNYu?=
 =?us-ascii?Q?3SFEex8ZCPzHo6+547cPhosf8vpXMPxhUd2ldhVNmt1fCBPtDtXl6vAu+ZHg?=
 =?us-ascii?Q?1i2nr31IvmbSK/CK8tqh/tV7IucAHdIWqNftRfbF4es6EGwo2+1JreILlsCs?=
 =?us-ascii?Q?lYMEpVkZIHhjqD9SRg3jL3yQ08Idv0XrHaib87sXsbsY7RZQ0Gm93eZA85yX?=
 =?us-ascii?Q?WwMbKc8qf2wabfqcrvNoMErIA4g6Qsa8IhgK5qf0Xw7EH+bDnPUDpVnlm/L7?=
 =?us-ascii?Q?avvCk02PRrMhv6UFNwLNwN34TVYVCt1bnjqeFyqi0PtvUZMh/I4HayPxMz2g?=
 =?us-ascii?Q?HQTMbmvimWsuFlAHzbQzwFgyjZDhiIUN1VQ3iHXrSgzvJnRbl4jaM3wKCiNg?=
 =?us-ascii?Q?TVcbzjHmfKurPOXAd2/8JeJFypUllxwHdvXiZUE23FfFI1nThAx5j0b69RDA?=
 =?us-ascii?Q?ODJksGazclqEFeZFKYBjM4T6eY1GGvJB8lrRpZs5y3enA3jRdEAFVkHg89Gy?=
 =?us-ascii?Q?MJHNLXvP9gWMdIx+aRmXT8pLUUaHB35JzMlLJAih9T7sRCHh5JXDxwQ0yJAX?=
 =?us-ascii?Q?W6MtNPaj2P1xKSu8hlMOXZ4d5Q5UG7EINA95BIpWIfVKkhON0Go2ZHnYOr2w?=
 =?us-ascii?Q?4UFsNfxmF93A74FVLsvW1ImbTjwdHO2waBAslR0LO+uPSe2maze24511W9Uy?=
 =?us-ascii?Q?ArAi7+33UNjrw4gcOUXB32smHxe4tYy9HeoRtWyQcnmCXaAP5f7DwJup6L4z?=
 =?us-ascii?Q?0sBQ484mPb0nuAdfqGSUhRHtWn5R0UNbLy/JdTQfLlF+gFDCHco+GFmg8dW7?=
 =?us-ascii?Q?IYLV1bTsPrpG1xZiOdTFlV05hDijW6dBS3++MhQi9ecbYhAtFi8Gu4Y23e/n?=
 =?us-ascii?Q?Z2tSPIVnUSU9XCHmB3+BSoq5+4QE9h96uOGuN4LWxaFwpWgvOdkAagxJ9x/j?=
 =?us-ascii?Q?4aMpUjRI7rzqTglUfCXW+jj2BMTpr7nxGeEjI+zL9v3RkYzoOl6ih2mwOJ7I?=
 =?us-ascii?Q?NqS9fLH0I36gUXakdsxn1P7adSjb7l5yEX9l5rDyx4alsNyfRQKJqPT2BZmI?=
 =?us-ascii?Q?2i1PQBKdGnH/Fgmkhr72SnTikigJ+hT4FfS/JyaJc9FFN4+5B/a5FljipUP0?=
 =?us-ascii?Q?8m0h7PmgBRczxn3Xfob/AfbwqC5wToVIruAX5fa0mTZsSEL5Cku5iGO4VXAy?=
 =?us-ascii?Q?X5ThWT8jUdqBoPQsVy179HHLqsCtuzdLVTFE36mOHt1ruQcOB3lNIprt6QRo?=
 =?us-ascii?Q?W8/m/O0gHADgKU09LZyAC1qVfeJzdINB5djPv7CjbzsRJFGiKXJWPIQwVuL/?=
 =?us-ascii?Q?kWSZYuJkZsNbvSEQb87UCO+W9pF/pFf9ursvUN17mUEDFp3xj3Lb504NYsX9?=
 =?us-ascii?Q?iD1YLznEzLWXu4d7OUSmNJhFurdDmPBhjtgrW92iWIaGTte9joO6rdophoAU?=
 =?us-ascii?Q?nRFnayRXbzMvHq1VFpL539l+1mYPdWnTtpQTXj44Il8xVwHwUvNAQfJ0SlaM?=
 =?us-ascii?Q?CGf9xQVduTw2DFJo78inbjwuz1qwq2LPtP9umX9r?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf68a5f-2ef9-4060-7d5e-08da90da1d69
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 14:06:09.8006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rNhMOCzoNHKuzqwhyf3EhP1wwJ9XIjk+SfeqdYjDYMG/7eYe8b9xqGSlcCydfC6P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6041
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 07, 2022 at 09:57:43AM -0400, Tom Talpey wrote:

> You can test it easily, just load siw on a laptop without any
> other RDMA provider. The ib_uverbs module will not be loaded,
> and the siw provider won't be seen, rping -s will run but peers
> cannot connect for example.

Perhaps there is something funky with rping, it works fine in simpler cases:

$ rdma link show
link siw0/1 state ACTIVE physical_state LINK_UP netdev enp0s31f6 
$ sudo rmmod ib_uverbs
$ build/bin/ibv_devinfo
hca_id:	siw0
	transport:			iWARP (1)
	fw_ver:				0.0.0
	node_guid:			7686:e2ff:fe28:63fc
	sys_image_guid:			7486:e228:63fc:0000
	vendor_id:			0x626d74
	vendor_part_id:			1
	hw_ver:				0x0
	phys_port_cnt:			1
		port:	1
			state:			PORT_ACTIVE (4)
			max_mtu:		1024 (3)
			active_mtu:		1024 (3)
			sm_lid:			0
			port_lid:		0
			port_lmc:		0x00
			link_layer:		Ethernet
$ lsmod | grep -i uverb
ib_uverbs             163840  0
ib_core               393216  2 ib_uverbs,siw

Jason

