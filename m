Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120A1776CE4
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Aug 2023 01:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjHIXxN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Aug 2023 19:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjHIXxN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Aug 2023 19:53:13 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB859DA;
        Wed,  9 Aug 2023 16:53:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AwDxFIZslCJIR3PB9UBPmYiZwuwfuShaHpAUCOyBDboMAW3T4GDTIOzZ3xU+28r3b1bYq3OzjRN2wI3sf1zUgKuo08aQq/H8xUo9E5iHXeXsrcvdLDIrI6/F9DZPyqeL7PwPbgxhV6Sliqh6r2As26hH9FXdaIX6evcTI60klJ5BGTpBwReRhsQNPt0YC7vPoz/ws9W4L+OlkJyTfU3Wq7Uc8OsBDhG0S9lp0iKEUS+cuEiW5v9jzY16gQ9XIYYiDNOb8JsuFZ4qphmzaL+SbI4YoMCh3uTgn/oX+CK7TM6x2G7I1l6OLxstDLTBwyncjHJIMVJCITnHibqp19DNsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MdhZYO/67ED2f8uwQauaXUDaibCDDfTKGy5DgRCa7M=;
 b=hMVsYp3K6PgLGRE9rrzz9HkUZGEqmk8mhzTf8AfxOYtKPcYSU2/PuEFSkgbMrIe/gTNngBr1LeTovS/q0CT3dwIlu0zFWYAE8joClX34mGzp92fxpATHPCtxaTbes3maFztzxJcvXc0rVeBMSFRdiCA6VdpBOO0s6HtGr6W1FRa6qQOiR5qowlXA1Joel7OXlFJwGdE1oRDvn3nvFuGVOasLlUz1LyrbtyCnzy7tPZgmBkSJDfTU2GUrW3bD8IqRf7GYnRi+NadRlouifOJ/A8d+rY6paZF7vozq9r9htGT27DTf/HbKT7WD1dPfyrVhZPOGs8pCIpAd7Hwv6VksMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MdhZYO/67ED2f8uwQauaXUDaibCDDfTKGy5DgRCa7M=;
 b=XD4w9ZP07TaaFUxK9Rw8i6RP/8bC1bHlwJMgDY/2sjp4heIojI/bRU3tA/Wi3i/v/PuylUtQpGReCZfAtkGjPhswNS0oZOCO+UNsSSWG+QRY10We7CmKMNKIuiS/5iRnSaFTYO1kU7XUFRI89vexmTjq3tsDwA7iRmdmECEBFDH8CGnoOM+6ElH+W+I7k3ufwvNbgVWh7Pc/G/HVazQiCjI6lSOUDVQWtnVtQxlqbJG+mDOlcsjyjHK6R/ammePTLtybPaFaH0FSkzGcsDTcNupAonPLfjW+RYXQXYGj5P0RhhcASn/YLgAIxG7mK/JpZqVLY4crMlbBp10KavU7jA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB7994.namprd12.prod.outlook.com (2603:10b6:8:149::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 23:53:09 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6652.029; Wed, 9 Aug 2023
 23:53:09 +0000
Date:   Wed, 9 Aug 2023 20:53:07 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Mark Zhang <markzhang@nvidia.com>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>,
        Patrisious Haddad <phaddad@nvidia.com>,
        Raed Salem <raeds@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Simon Horman <horms@kernel.org>
Subject: Re: [PATCH mlx5-next v1 00/14] mlx5 MACsec RoCEv2 support
Message-ID: <ZNQm49Mlo48I63+P@nvidia.com>
References: <cover.1691569414.git.leon@kernel.org>
 <20230809160945.386168f9@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809160945.386168f9@kernel.org>
X-ClientProxiedBy: YT1PR01CA0097.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB7994:EE_
X-MS-Office365-Filtering-Correlation-Id: 784ae346-63ae-4063-2b1c-08db9933c8c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F17USez3bHd5pCoQXjuoURGazo/WkyAemTwhWrTy3QrAFG6rFekHnrwFsIplQRIRkIIGjKZ8X/QUzd3dGpjV1D+s1pqGugUyAjHgJ2RvLN/jSVQYYnZqvjllbnO5yBZiLeVl0gTu4215N2VXj2VMWwv8wZLHX5UVn9npkToDfyqd+XFb5t/zR5DIU7lGcrOVBBrQlv3GXiIs5pxp2hq/DFHOigMxUO/S5Eu6tdAo44HkYkr9PM0tbk4sAMjfr6C/SR+fH8XxwI2oGl3hYCbFhBTG2M8N2Cy2YSw/JZiL2IYHRcEjrpHUqMYp0O+QgciZO2xh6XQ74S4IPN1gxH+ILKnCMhMl4rMLn47syqVqyqrS9Zyyo4S6ER7/dKgrcHFClH//R3EGCIA6xshPMfy3ctFqOrAwjQ5MWHtHlSSzfPsUefBmTVRh8QTftK5TASjqp4ysEsw5HNVa09RhZvXfpbCOvA0zKK4bH0MGaAmy1K1nbWVn3OKg+7GGlOU3B4Mao4/saNAQV5MN+cH/UhVgAje0IG+xrEMwBflqNOodCqbjqOTKIZLnBiql81vXwOfQ/dNV7YTUimpBDwPB3QhsqHPDt1aFEsCPw75V4kh+EDU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(366004)(39860400002)(376002)(451199021)(1800799006)(186006)(54906003)(6506007)(26005)(6486002)(478600001)(6512007)(83380400001)(2616005)(41300700001)(316002)(5660300002)(66556008)(8936002)(66476007)(4326008)(66946007)(2906002)(6916009)(8676002)(86362001)(36756003)(38100700002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aSvJifMwhPqiNT3MHKa3qLrApXVEN/LbgvvFlwHwtRHOw6sGIL0Hp4i2VKkz?=
 =?us-ascii?Q?0ABej7TAYFkzcl6Rd8STr4esJxZJiJkJfGdED6bDnS3XIjT3ps0cb1O4oquB?=
 =?us-ascii?Q?iqKpCFlGiJuezJIy182cR063vk8DzmchIkymaQ82suh0C/GJOPvgYcejnWg8?=
 =?us-ascii?Q?KSjY4YSd8vis3TwCOnniNnc/r4joj5GAwPVM7hGX1Lb/ufJfJZsngsu/ce9t?=
 =?us-ascii?Q?TO06VdxSwFeaZnbfTYuVm9xs7S2Toy4nbfuGwnwBcalnoU/lho41wgskvT/8?=
 =?us-ascii?Q?wbhCWAWU9LLF4w4w9g2XqDJcy9OQAbCwdYGUbRR+lC8KxdxEFRs929H5KhpA?=
 =?us-ascii?Q?LB0arjcFF0ZXbBYdPxd/vaCH5SmrTt5zYLn0JQ0Wxt8EPlS9A6xOvZb6WZfR?=
 =?us-ascii?Q?NlIffrfUqI9acEpqAY1iP+vKAkMmLMf1sw7KnZyMR3JbPTO/doaPJFRetjev?=
 =?us-ascii?Q?Gy514L1xJWGliIhU6tzd6dWKPEDsZ9OIzVw0aeMzTktpsuLpqlExFPKrmnXu?=
 =?us-ascii?Q?OurlzexcPOjoAsQqqKJHcH9KQ8DOIZCWGSvGuK3FHi08Us827hr4k+mOLRJj?=
 =?us-ascii?Q?nbeOQpXqlfxS+5dfBUPN8XokQ1rgL72chqZL//QNK5RNsHSo5cJq8Mn54fdA?=
 =?us-ascii?Q?qS75iwyaTxlf0yDQ1fnYBuCkPlTdVWvziN488wuj3hf3z+THYjlFvv9s5Rdw?=
 =?us-ascii?Q?UvYFdkRoM1+OAzHEHmlwbbnDc0hAxK6OZkxyl/7a63oZ4w7ry6+eerJVduE6?=
 =?us-ascii?Q?l01XV3X2MgPseSk+b+ZnCCP4NzxsjcUXcVfew3j+A/HUevDyrUlXsfi+I9Nv?=
 =?us-ascii?Q?KziN+fp1FNjrKCIj2tGlAZvm1zWEose1lwjUK3B2WZQb3WrtW348Rr6xbhRu?=
 =?us-ascii?Q?LIHxvkxvQ7xbYPMIy5xwCQg1xuVoUPa41YcJzCK8jgooCDQ86g3wEau6NZy9?=
 =?us-ascii?Q?ajgeFiLWM24cals8+cQC/a5OFsU6LGlJMC+dIIu/BvJNDYGEc0w7XT2pISkS?=
 =?us-ascii?Q?lBdrBRoWrnftJp9NYRfQF2Lv8s8d9w6M8KF0ohAejkB+9AotP3wlCTNr3CZC?=
 =?us-ascii?Q?mijIGZ0lbz00QtX2tGAsSqu+uzdVRJdy/AvDr+2d/+ubxU43j7F1aIGd6et/?=
 =?us-ascii?Q?l+VGSYxb2Oda4dmW1Mb2PymKZSAFPc8IR7zxA8b2yHy8JXADM3NyDjB/IJVO?=
 =?us-ascii?Q?eHor5FMViOBGIQc2GNahkcMSmw+TfzTHcaVsFTCgSiuoKgEmlyLLSUIqLQ+e?=
 =?us-ascii?Q?v27SsZkn3yzEKZl8RzeXQvoHMTEiX/SquKDWE3ajaCEgwKAYcEAehltiz7lb?=
 =?us-ascii?Q?HpMajTBVjiC6ZJD8S5/nNf1YdAGwENQjWgeqqsJJw6uvIgGvP6rFFkbm1JKD?=
 =?us-ascii?Q?U4P8HnjJP5VX+3oxIfU2xaFD2e3xIUv640bYWw2WVGli1B3mCfjoHKiy5PQw?=
 =?us-ascii?Q?Y+9UkWg4CiNkVugSCcIO81KVXUpx18nQ48OUIzq9sW5EV/FRZNnk9ZgAX09H?=
 =?us-ascii?Q?ka/Am8ctPqDuCDnjYf/f42JIBxB3hQd/lnHv2I7YZqOZ0WpD5Is79i09zFfJ?=
 =?us-ascii?Q?hPoCcdy7Pj0QFx8U9UgY1WFPe1hTw1FxrgIQ3IvA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 784ae346-63ae-4063-2b1c-08db9933c8c1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 23:53:09.5317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: emkgT3OUHT13oFUwYpjExMPZQ260035/fa/3aNRaJMknc8376mb3H8P8aXK4ACJz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7994
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 09, 2023 at 04:09:45PM -0700, Jakub Kicinski wrote:
> On Wed,  9 Aug 2023 11:29:12 +0300 Leon Romanovsky wrote:
> > This series extends previously added MACsec offload support
> > to cover RoCE traffic either.
> > 
> > In order to achieve that, we need configure MACsec with offload between
> > the two endpoints, like below:
> > 
> > REMOTE_MAC=10:70:fd:43:71:c0
> > 
> > * ip addr add 1.1.1.1/16 dev eth2
> > * ip link set dev eth2 up
> > * ip link add link eth2 macsec0 type macsec encrypt on
> > * ip macsec offload macsec0 mac
> > * ip macsec add macsec0 tx sa 0 pn 1 on key 00 dffafc8d7b9a43d5b9a3dfbbf6a30c16
> > * ip macsec add macsec0 rx port 1 address $REMOTE_MAC
> > * ip macsec add macsec0 rx port 1 address $REMOTE_MAC sa 0 pn 1 on key 01 ead3664f508eb06c40ac7104cdae4ce5
> > * ip addr add 10.1.0.1/16 dev macsec0
> > * ip link set dev macsec0 up
> > 
> > And in a similar manner on the other machine, while noting the keys order
> > would be reversed and the MAC address of the other machine.
> > 
> > RDMA traffic is separated through relevant GID entries and in case of IP ambiguity
> > issue - meaning we have a physical GIDs and a MACsec GIDs with the same IP/GID, we
> > disable our physical GID in order to force the user to only use the MACsec GID.
> 
> Can you explain why you need special code to handle this?
> MACsec is L2, RDMA is L4.

It is similar in concept to how TCP validates the 5 tuple, and
optionally Rx netdev of every packet.

The RDMA Rx layer uses a hardware handle for the entire L2/L3 path
called the 'GID Index'. It has the interface IP, VLAN information and
so on. Logically for MACSEC the 'GID Index' should include the L2
MADSEC association too.

For security, at the L4 layer, the RDMA engines enforce that queues
can only process packets that are matching the correct 'GID Index'. Ie
you cannot Rx a packet on VLAN 10 and have it be delivered to a queue
that thinks it is working on VLAN 11. Or Rx on IP A to a queue working
on IP B. Same basic principle for MADSEC, rx unencrypted/wrong SA
cannot be delivered to a queue that is expecting a certain SA.

This HW generation is not able to directly associate the MADSEC L2
information with the GID index. Thus we cannot create distinct GID
Indexes for the same IP, same VLAN but differing in MADSEC.

Thus if there is an attempt to create two identical GID indexes the
driver will prioritize the encrypted one under the idea that is the
more secure option in case of misconfiguration.

Jason
