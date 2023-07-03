Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE62F7464AE
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jul 2023 23:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjGCVHb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jul 2023 17:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGCVHa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Jul 2023 17:07:30 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8419EE59
        for <linux-rdma@vger.kernel.org>; Mon,  3 Jul 2023 14:07:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XfbyFHNi5Oh+yJoMdo4ngMsjkbdYZ7nJDviyiyHbXmp/tftnOvnTs8T2FRnKhB6UEBSdgf5eGzhcSD03SZCtBy2TgthKDzUqvX1ioe2zPrJ8Sy+2pK8e7AjiQUSeYh4DCDwOkq8GlLuzeeJ/P8ysKf30rquSrVIm2kEMETfVQUaVxwsnQoZy4VdhvKeLGNxPPwUbGnbhpStNHduKdI/kpCZCpik0So0BM10EnG240I3/d6yXoohtZnsypdFtR69oMejvLGD0yAq58EUYUwlWFZkTW/lj0oSqtO9CkmkMgOguWeQMenmgYnvlolGJIM+nbM2+tT2G6T4hmEMdmGlh5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0orrfq6F3fzC9vhBjjNr2Lwx/Q/SHYJVAaqcTZCCws=;
 b=YsjBR22ZaVUD9PByD+8ivYf7XBj0/jsQ2Y0HzNLWY+QIYfNogDlKAOCscqcsw+LFWr1bCGrTK44QUNFYGGY6NEJCt0m8RC1MsDnowHlonMswpaCA8VtXhmJmR857xsl+QnpBW20BRzesPhZL4eSy8QdvEH7Ms4fQu4/Z+1Qk6yNJ++0S/1MrVFfHvVcTrUf78anbRBMN+T4GiWFpdcJLSEKyFnm9lbjMFXL+CLv5F+VMTtOrpJdt9EiWJfJWp7ZreukyNI6Oi7qSM2aIYX1EV8XhJvK6Ow1RFhA9jpkaLVLcSJ1AA1/EuY9AXOFOmb6hV76rGW5I6UuMzOlAdvVLog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0orrfq6F3fzC9vhBjjNr2Lwx/Q/SHYJVAaqcTZCCws=;
 b=hGkkxo2B6kUcDsKlsucxtKTHJLs5W+OqRx5yyCfODA1FxyrN/RmQfPNAIvbRcTi2e3Myq2L+9esVhZH/fkD4r1k0DHy+dgLOfQ9NjdOoePMjOdq9gGy+dNf4EBOIURHfTH8yqfA8Iq8g2H88ftcnFvzaf78wS9aS8gh4zyNyjoG4uj4Bh863E1/andAe7NqUqoqXLEGYV06yBj5r7qcttRd8FXV9WrhsANi2FZwTMf1BUAcAU+W1JMpxrM3kDcgT5CxMEPS+vXQ3m6xUOHOutwx4uNT2C3Ouyd+ao68pDT6JqibXgLCmI7Bub5c4HtXMEWkl8eb+coFv3PCH1q8gVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB8511.namprd12.prod.outlook.com (2603:10b6:610:15c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 21:07:27 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b26d:72b8:be41:2f0c]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b26d:72b8:be41:2f0c%4]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 21:07:27 +0000
Date:   Mon, 3 Jul 2023 18:07:24 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Tom Talpey <tom@talpey.com>, Chuck Lever <cel@kernel.org>,
        Bernard Metzler <BMT@zurich.ibm.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v5 4/4] RDMA/cma: Avoid GID lookups on iWARP devices
Message-ID: <ZKM4jM6Ve5PUhHFk@nvidia.com>
References: <168805171754.164730.1318944278265675377.stgit@manet.1015granger.net>
 <168805181129.164730.67097436102991889.stgit@manet.1015granger.net>
 <1132df9f-63a1-f309-8123-b9302e5cdc3c@talpey.com>
 <7F4E0CAA-A06B-4F43-B019-4E471B10DDE7@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7F4E0CAA-A06B-4F43-B019-4E471B10DDE7@oracle.com>
X-ClientProxiedBy: BYAPR06CA0047.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB8511:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f261f82-e128-4cd2-9bec-08db7c09818c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oA4FQLQzd1/poSpiUwTA2klJLAG06yoJPhuYFpiBkIuR0wJKg72oGZ74Db5cYyV5Fq6TGFo7EtJMJZ8A13KoHyPJR7/hM02BuhhKhEBmvU5NYi9anmGlbFqd+LyZbQlRslaFp7qdqu8+9ZgeUPwaoAl1Ele1bAUvTIfDFmlgpOmWXNFMTeH9DCVJnXAIygflPh5I/DiWMCMdwSDuDMbDmXBzsuEu4KGhH6735t6PjUtQQ2ntsLdaGOe1WamtcyXCD1zGuKy/3uZW+pLeu3HLldOeq1KW8Pso/f4I2Fp8m2Ek8WD9ZYH8tCflNDT9lCMYHy0RJNriWGNcLZxjmK+WIcrA55q4Faqnl6pheI1i9KM5wL4rw7HqbA9y9Dv6Hg+8OYztSEkRhvDrNw6fw+U4oh1ZlrhlOM5Y8U0VSc4LXNsNXO4xqFpK64PcJ5/NvaQIvZ0q1B8w7bIDNTAZvqiQYE6SbvnUD6580J2bEOEJV5KpwihyXXh7sxu10cW+21Doos7LwIxdvTYkU5ffG67P9v/8q4YdD0tELnu6zOH2PvRLnmTVKW1+I/jllFYlHzFH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199021)(2906002)(41300700001)(5660300002)(8676002)(8936002)(36756003)(86362001)(186003)(2616005)(478600001)(26005)(6512007)(6506007)(6666004)(53546011)(6486002)(316002)(6916009)(66556008)(4326008)(66946007)(38100700002)(54906003)(66476007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CdYCahyghLxqrICZz57o4GrN9crYur5g0Cwv6+qYr2VNRY/ST5Ng9Jrwsn/r?=
 =?us-ascii?Q?kQaYy5lF+ZCtO+Hz2Jp2frVX6QUMG4Igl7a+QFkc37Nn2+qrSA3DdH6qUU5/?=
 =?us-ascii?Q?WfuRRbTPaYfXMgJ6eZbFxjPtw1XpIwkjFNSZeR8NLQsw4OCMmNHuBKDTBYXg?=
 =?us-ascii?Q?n1inFxyF8fcxzNAXnuyU//VooL1lVxecYq8JaftaQsS6YzWYpGj+fiUQWTLN?=
 =?us-ascii?Q?l8bHwhYVaChYuY8uDjVJoRTEKDhWEwNUU1SMBiUs8Ykw823KDs+lkVy80ubb?=
 =?us-ascii?Q?YCJWkgDKf1BITumZkj5P82ANn91IMR8FB0tWXAKktGeDz1AZFQd94O7BcViU?=
 =?us-ascii?Q?2/4mPdVfGlu/ckYeIvezaHG3z/BRhFz4mR8nUW/Bhxzcrz/yszA+99oRD316?=
 =?us-ascii?Q?g4j9x/8LkHEDnSVOWUuiA+cineAKh8tgEREzPCoxhl4r3LwmfoOoKdFok/0J?=
 =?us-ascii?Q?RLYDDVyXWjuz/bRVDZoiX4HllmJOvP8Y7oCZmTPBDGqgBTkgxSkbTP3DGXBP?=
 =?us-ascii?Q?s6xOL6Y5Lyll+YndVfqZW6Vl5yLOUxqG0+sWHf7epp2jRn28nk8W0W6437US?=
 =?us-ascii?Q?GNWGdjJyuamFUpvTFLkPS3Vyc+GJOb/LI9OGKgaAUlJeFq/W0HhwJ5L3027I?=
 =?us-ascii?Q?Iv0PFdW69D5mYTrhIlO/n8558tPLAAA8wLgURajfJfqhOLyhzV2PGPWw0isV?=
 =?us-ascii?Q?bvDjoy1x0zPbF/AO3gRFzRQNl7A12crMCLrHhBAJsVwMqPD0Vrx2ZlV112ik?=
 =?us-ascii?Q?VpNv8yJTV4RM5EAqZrfA3KqKff0heO75NSBXCkLPODwrbGwbokKqIlcV377Y?=
 =?us-ascii?Q?VBBc7liXpRc5TajdkABXu44PQQmDw3ut74PmejEG4Apaa0cik9bFnUFBNDcO?=
 =?us-ascii?Q?BE5rxmR67mTkcTt0PjvOtAy6VIM549EtvzHnjTkfDf8ZXZfX/L5joqjys2S0?=
 =?us-ascii?Q?KAppAwiPJ9Wgl+mYnXPC/ygUj2n83wmP0eQezqWNq812/GUxzdM0zaSwLHh4?=
 =?us-ascii?Q?KblVVsnd/JA7ygvC9fS9yBCEtpfvz4bPLGpK6aSC+7wBN4SvAWE8xaWf1B8r?=
 =?us-ascii?Q?MADy8zb/ukzpdOFzLUUOTRhYhGXBcTMrM3PInp9SQklL/Z7nY5OZoFQMxt2R?=
 =?us-ascii?Q?iULcEWFxqTqdYH9kQdYGdrSgJ77ScUbbyWPdCd1riuxE++X8faUg5bMNaUtU?=
 =?us-ascii?Q?WPecfCogpi1QFetxce+GKNYwCyTS3aWZhtiHt8Ix+06/d+vFrkJOTYyzI0xw?=
 =?us-ascii?Q?8EEwzO1w4y7tYftDNXyStqKZP1kmlYhW7VYdvkZE1FrxnOuBh+7slByRXj6u?=
 =?us-ascii?Q?5F0KzrDEe8FqCKUIS9RgIZ/F8us3dGIWzAY5iGgZpKj1n6s4K9blZX59LMAm?=
 =?us-ascii?Q?3DE4A31/zw8LP030r8xFGjt8Obx8A4CdJXFIZBpgml11eqnf/wwO6DCeOUXF?=
 =?us-ascii?Q?4A3SZAQ7QHHuqmlSQxP7ki3TY6hhuLphNCXT2h/IP+uBQo3sJIqqB5EMxdhc?=
 =?us-ascii?Q?ox6I1gFZxGWGuJFu5DFfkdDPNs+YF0BmoMYZNf1mAwik4cuvTO1vYFHxJFHM?=
 =?us-ascii?Q?L2Im6InewwkPxH8cLlpXmPZkdBaBVpLwjb4/fCt9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f261f82-e128-4cd2-9bec-08db7c09818c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 21:07:27.4948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /SXnCNLeiAQRmd1JUv2znW92saCoWvdjqLnPbQMsbNFpuaBhp3lm8G897oBS7dNj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8511
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jul 01, 2023 at 04:27:23PM +0000, Chuck Lever III wrote:
> 
> 
> > On Jul 1, 2023, at 12:24 PM, Tom Talpey <tom@talpey.com> wrote:
> > 
> > On 6/29/2023 11:16 AM, Chuck Lever wrote:
> >> From: Chuck Lever <chuck.lever@oracle.com>
> >> We would like to enable the use of siw on top of a VPN that is
> >> constructed and managed via a tun device. That hasn't worked up
> >> until now because ARPHRD_NONE devices (such as tun devices) have
> >> no GID for the RDMA/core to look up.
> >> But it turns out that the egress device has already been picked for
> >> us -- no GID is necessary. addr_handler() just has to do the right
> >> thing with it.
> >> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> >> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >> ---
> >>  drivers/infiniband/core/cma.c |   15 +++++++++++++++
> >>  1 file changed, 15 insertions(+)
> >> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> >> index 889b3e4ea980..07bb5ac4019d 100644
> >> --- a/drivers/infiniband/core/cma.c
> >> +++ b/drivers/infiniband/core/cma.c
> >> @@ -700,6 +700,21 @@ cma_validate_port(struct ib_device *device, u32 port,
> >>   if ((dev_type != ARPHRD_INFINIBAND) && rdma_protocol_ib(device, port))
> >>   goto out;
> >>  + /* Linux iWARP devices have but one port */
> > 
> > I don't believe this comment is correct, or necessary. In-tree drivers
> > exist for several multi-port iWARP devices, and the port bnumber passed
> > to rdma_protocol_iwarp() and rdma_get_gid_attr() will follow, no?
> 
> Then I must have misunderstood what Jason said about the reason
> for the rdma_protocol_iwarp() check. He said that we are able to
> do this kind of GID lookup because iWARP devices have only a
> single port.
> 
> Jason?

I don't know alot about iwarp - tom does iwarp really have multiported
*struct ib_device* models? This is different from multiport hw.

If it is multiport how do the gid tables work across the ports?

Jason
