Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF124B2D11
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Feb 2022 19:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352948AbiBKSn0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Feb 2022 13:43:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352849AbiBKSnG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Feb 2022 13:43:06 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E90335
        for <linux-rdma@vger.kernel.org>; Fri, 11 Feb 2022 10:43:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fd9qjg3qG4+bfz3RJK2501wmo64NlBpjMsEXb51pAS+BTACm6JcOkk7602XM4pXFfEzJXbxV43juUuJJxzfIG9VqE2osIIfvi7rlrYgKVh05EGAPiDr6BvnRtAHUi9TdlonvPI0+jQfMclPtRqGCu4ysGc50sHFIm753kYQ3jpbRGUCnp56eE5dR83ZhMn/5w6STLMLF3aa1mQyx12FK5hOog/mdBoqLgIVXkdYcHqb0NVodrzZKqSLP2cGErj2LAD4RVXx/ZYMfxV6bwhccTdNGeo0ZLAqvTsPd21oGg1peF2+krDKnckTxQSuEwkNR5loGxnPM583yP6PtVr+Xrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCSjE1kgYnOCk1tynKJEBzHX82Zw215t8rkZXqtWpAM=;
 b=WewV2sVB1CXmykQO4OSfevS7sF0QbFbikFM2l/m7xl4wx3dNh9PpC7WFRpiHZZ2On5QdLQrBqM8RYrAFMsCQ4EYxQczO/May+gmImNXNhVdB6KaYGl8XLB60NXLjtdoGUQK5jSSuSbX/mgDMshhFViHpMGlEeqtUMFdbrpysJvLkO8ktiGfTnG0qoEy3ulWE9JOTRHMcI4M9L4VHEn2+YCVmTVecRIFP2t1/8XnV1ifOyiG6OFJtbYL5K9VWPsaxhsDfb7ZOtPuAFAM0rxZ5fEWNiJY8LjwIa5aD2lhtYwv384zdK+9q0GTNdEsi5ucCj4XUDoc5FaIxZ9GB6q7XOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCSjE1kgYnOCk1tynKJEBzHX82Zw215t8rkZXqtWpAM=;
 b=LBeejlRDVwx8AK+qxsiei8M++BkRYc34wmKHDrKjmRyOWD8uHcOpwgvta1iLX/X1vGqfPvCdmPgYa8Ek9+u/YpAfviezvEgC/Uh60XxBPSa9G2pwLntA2WB9I/uQR5rPAcqRNF8668zNKLVFHGw8uKDqtIUvuE2fLs1NNzpXe7J2x43+uMSklNVvadFNnGiEQhGd/H2jNnOg2teKgroojfn+xNX2Yuz5+j+G6WDjaFZ7LyMFfLRdtRDZoep3/bmmS/q4EZvdnGm+oMLXj2yT90Gp3TYPBVk6JYTxIUCHMUJYqGxLurSYUj86wnGbDmQW9VL8ftObSTl8QjB51gBeJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BYAPR12MB2790.namprd12.prod.outlook.com (2603:10b6:a03:69::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 11 Feb
 2022 18:43:02 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4975.011; Fri, 11 Feb 2022
 18:43:02 +0000
Date:   Fri, 11 Feb 2022 14:43:01 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v11 08/11] RDMA/rxe: Add code to cleanup mcast
 memory
Message-ID: <20220211184301.GA576950@nvidia.com>
References: <20220208211644.123457-1-rpearsonhpe@gmail.com>
 <20220208211644.123457-9-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208211644.123457-9-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR07CA0004.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::14) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5a47fc0-afb8-423d-70bc-08d9ed8e5540
X-MS-TrafficTypeDiagnostic: BYAPR12MB2790:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB27909742A865F622EBD3922AC2309@BYAPR12MB2790.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5qd2UFI5LdAK9F29S1G0edsMScWrxnqwxQAJNP9DiJ8k+Fv22erC+/8FtQK5lWac0+E1Q131dO8PklUlFJ5gHVw53RBC1xKdVjG55fYNhptEazFMEYua5jajzfxEDCsdE8G9cn0HY88P9rBbVM7SVCQZGvGyjkEHV83jdGENQAp+OpceWfZ2IYzRXFl5dFLE25UHuFiAuCfX0J394VOgIVcEPaRcYtpYXcx9cAjYYMFXjWx3dngkoMjn6S0AstScc1uOJV7lP4PdpRocfoUPYYtZ1x8uxyuxjnus65TULYEmqho9MYc6U3uwLJKCv8KIKz4I5zc7j2Ovtx40rvm/7Wr/ecz9xEbi6vFoU2a2s9SkHWi9Vgc4mWaXzW4kxYy+giwsVeNWEzm84Ht/sKtOVoYZyEUKMsR/2OZv29gP+qt/uQO3oiIAta14KtzHdKWN4Jc+CjgXOkQb84tlelQjwBM2jvOtQ0m0T8xq8mhGBYgYXG1EEQLWHnA1DEcFFadLIWZUXWL2iq68MPxRlSEsoJ8Qr5kUH2C4zfaiUq2W3eTS1UpjZG+7QTq/oL/EiI7c3ekYenTob3eG2GFZhCSCCvhHHI52iwnDJ31VcP0QqPQcNFZD8JNw7NqehcNAf/OEDXTnqoaanJlH2qJpJTz/DeHMErPUATXPfSWd65Z26u5ObqafG+CgychBIjepXX3xMYypu311wsUjKoXEI/TO4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(6506007)(6486002)(33656002)(66946007)(8676002)(8936002)(66476007)(36756003)(66556008)(316002)(6916009)(186003)(86362001)(2616005)(26005)(38100700002)(4744005)(2906002)(5660300002)(1076003)(508600001)(4326008)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q+ofCgcRJ4Y8FgBV+oZaxhMwO8y/dNRhWgBckyMSmA6hOF98vWl8Czi1hntZ?=
 =?us-ascii?Q?U4P6iAfGipzO4uUrK5jN8sKDW7feWNMCMjRfLtG44GA23IGWFErlT407TQYa?=
 =?us-ascii?Q?ec+CsRI/cngfq5dSVljCcMi/erPcXf8lEkl79paGvKUFD9VnLOPAKlRJlUDi?=
 =?us-ascii?Q?u3uEMDObX8IghRL3X/9s/DFFYKDBpnzO6k8Q32IsruNLt1xQOTvx7yRssYqc?=
 =?us-ascii?Q?ZSSdEQwLb7giVNiwlMq7rKMiLm6nqBLPQCWNQ6+sU6bFQlDPgs9hdq00hrjH?=
 =?us-ascii?Q?8G0WfGxQIGKqnvBrBqpgc+YN/fiVw4JUAFY3gnkJoI+o7lgxczEenOz3WMgL?=
 =?us-ascii?Q?UnMSheIrnSCMBYYdMoi6GR2sxPN1iCmzjonbHAGw/hykqLJVc1P8sNiM2T3n?=
 =?us-ascii?Q?HFfvqShUhyJCrB93PiNlhv1ruiFO5QqMbrcpm8FyXg8aD/MXAikgK5t1LBTq?=
 =?us-ascii?Q?494HB88d51bV48e4lwkbSD48a6eFYipjcyJm1PAW3GGyaL0/AyLABA9ZDHrj?=
 =?us-ascii?Q?Mqaj+Z2i+E/aP0cPfmyaO6fT295gz35EtkNa0N8wrOKhDP4dRIfPaOeIForI?=
 =?us-ascii?Q?Q+MGxV4s9evh0xRzWvlmQMBf3+y5DhAkK+xIEhYEnU2YoeMLJO1aiSUeLjBk?=
 =?us-ascii?Q?olFXILQ0z6rdxy1U4EsoFbwCrSPmYliwaxxD9iz8Rv/8zWutsQIFcuwMs/wr?=
 =?us-ascii?Q?XdEara/DHA4jU7ZjUk8unqxP8jSv3d0/0RSfR4nzJ4kX6VHTbVMEAcz7jiSi?=
 =?us-ascii?Q?Ar3Q+VBZhi5PHy67SgXA/LeWv9R6rj8awurtWIPW+AGDtBHOJ3ETw+F0/q1l?=
 =?us-ascii?Q?CQnN5deqo7TRCBbZ00BTsCrjLFQeCHMRm9Z248fGa0O4dd5xJ2G0rTSapZsB?=
 =?us-ascii?Q?x4Vi/PUu+PHjlxOd+9sRtrU2lOgOszQsr4RspHT/7WxyGfL95Z4q96Ci8nzW?=
 =?us-ascii?Q?oSeZnaaHUHS/rS8PZ3/TNLERzh4CEkgBF5KFNUedoFyDKk3RCRPyfMc9A8Pq?=
 =?us-ascii?Q?aRGQ2jtq0tYQ+DOV3N5QTqESUdqKYPHmvh8GV2pyzOCtT8+e6ec58S5YlhK4?=
 =?us-ascii?Q?wUfHwtQKRVF03Sego5p8cz59aSAYaIXWLZTqkHy9iQXTI9NVxc1JjwisdHDM?=
 =?us-ascii?Q?+UDsmb5anrrWgr57pDE08r16K6c+e/pQYY/o8co57idfv0ZusM7/cPA48F3A?=
 =?us-ascii?Q?GoynqW7AVSl3WTXMf6M0gjZfqX5GCgndcvcByURtUCB/EvmJWWjhYh6017+R?=
 =?us-ascii?Q?60d/y/wAyapmk+Y9lri8cvbveKM0JQwZtNZDzEUGt41almolsrc9OkcDmQho?=
 =?us-ascii?Q?wncrR9gtDCUHgH7ctCxCLGFzCA9RvnlDPEYpNpTeGvMgN5d4HmoUHoVM5g7i?=
 =?us-ascii?Q?XpLNFY9quMj5EFWLERmLDw4oJatqF6SreMQc/FDcOxGPtfnzNR7ny4sCCQCF?=
 =?us-ascii?Q?5rYH11mqJ62EarhUhM+H8Pl7L2PwMfZbqd5ifheQvrThsmkFhkgpT16sQsw5?=
 =?us-ascii?Q?VQC9EZdW3+PQPlaj2srAIVmPcFhyPM7TwQdqpxU4cIA5aU7m0lLkIhLGuYbK?=
 =?us-ascii?Q?Npe4Y0gXHL9h84aeciE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a47fc0-afb8-423d-70bc-08d9ed8e5540
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 18:43:02.3092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z5O7MESDQQK27brKPGRevGbTe1B+HFOBDTTw99guXbhi6ReDq7+slDdJpDQEBQx5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2790
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 08, 2022 at 03:16:42PM -0600, Bob Pearson wrote:
> Well behaved applications will free all memory allocated by multicast
> but programs which do not clean up properly can leave behind allocated
> memory when the rxe driver is unloaded. This patch walks the red-black
> tree holding multicast group elements and then walks the list of attached
> qp's freeing the mca's and finally the mcg's.

How does this happen? the ib core ensures that all uobjects are
destroyed, so if something is still in the rb tree here it means that
an earlier uobject destruction leaked it

Jason
