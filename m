Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEF462FA71
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Nov 2022 17:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbiKRQit (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Nov 2022 11:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235320AbiKRQiq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Nov 2022 11:38:46 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472066204A;
        Fri, 18 Nov 2022 08:38:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itx2TFKxsDYHGN8KO4Tark/DmQCx124z3hLBrkszDBCerUdsv/g1z4veODVsuWij8VvNoQ1fXFQILNrzuqxrpEQ0FZU4cVq+durt/z3flnGK1+wGb625yDxBL5tvj3dSwma5uEbd/qWnTxWDT8NNioUbUOYFgr1jIzlUlCUUuAwxS9TM4coklGNpC8bcoK25qJmTAMpSgcFC+YoCGtKegdlTJVJG59aGVWBaNtw1RIJuuZBXHZZyqEbMW/FsRWeFkItAS5mDcOcy7GeWoOeng5P9id9ZCJITMZZbHzzTN69JBSMOice5v539h1RM3/ibRXMAEdJH5EtKnb4WINf0wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4fQW7s8oC9rZn0P8aOesqNDR/234TODuMxTGwfL7PA=;
 b=FmzDA7y8+JsP8B551rQWKOIjInLl4MSzYKk5+aj1y5uuQb6RSw8GKInd4P7w5J4M/WDc9Jq82rqqLRoiDK9+zAe0Fik9DQApnoD2SYTAxgkh7S7XRG3jt7jNvHDHeFnbfr6hZ+CjqAiXEH6aWXSdIeQvjR9+LAQoTIbUZ9SPpROjxNrVFqI9HxwKt0QrCcniyVDSm8W0V4Q6e98q1/GMo1mMpvxHorjTVXgo23GZpgdG/012FVCJ1vpaCCfEtz9Y5UdRWp6/ZIPwgph8w8bVY3qIbeE0mYvguPAVyFDgx07T3SbntvNomaNYIkMtWwYCc5ptMyt06uDRa+4elkot3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4fQW7s8oC9rZn0P8aOesqNDR/234TODuMxTGwfL7PA=;
 b=LoqCM3/p7tKe8GzjeJMtbQSuj5QHJ+KstmBCBTzvuSdCLxXWjeWLv844TsJFzZsZTresTdc+HUHrgPO/QVmoxCngXxP8IfknGSuoOQT7z6jAZ2qQ4B4jGM0+4Qj9WDoIYhcHYx0ZHWzdmV1oT06gpuHcx2bzvaMXorv3CNmg/yqAgktqlh98TqtDzenos/KHdQn5iGLKQLInN2u3iWniCI108BV7ol5Y+nyQ+XRKjBjEvOmYZ4MlhJODWuApvxFJ//t2/RAQnlNSyoVZe/rchGJWRZECy/0U5xh9/hGrSAiaMHslARwAUrJHlk0agBSo1x7rDF+ynWGBFEY5V+xP2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB5934.namprd12.prod.outlook.com (2603:10b6:8:7d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Fri, 18 Nov
 2022 16:38:43 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Fri, 18 Nov 2022
 16:38:43 +0000
Date:   Fri, 18 Nov 2022 12:38:42 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [for-next PATCH 1/5] RDMA/rxe: Remove rxe_phys_buf.size
Message-ID: <Y3e1EvHE4uk2LLLv@nvidia.com>
References: <1668141030-2-1-git-send-email-lizhijian@fujitsu.com>
 <1668141030-2-2-git-send-email-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1668141030-2-2-git-send-email-lizhijian@fujitsu.com>
X-ClientProxiedBy: BL1PR13CA0336.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::11) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB5934:EE_
X-MS-Office365-Filtering-Correlation-Id: 004ae2dc-d913-442f-22ea-08dac9835af7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aHHrQOsVqiuBIQnL9BqH9aeP+xx8vSurqMFzK2wrkKP/I37QZN78ztTygZpCzKP5+PrY69jGWj63xCqtwlV66tc3ychJwvUTq4g6dhJ62EsCkAndjlFNSz+hEjdcGHjtvz/JNvHqBl2eQwFfBeowQYju7Ukfl0vvHS9wsJGWXUzrhnVL+f3tStWKPmwdSaSDvvR7F9EcZQdAG5kTL2/Af0Ly1VIUTt43hKLI8uoLUCkQXQCZQXeo0U0JLvk8gJu1EcR/iBMKjDIRFpycfeWsWn6kvd15zCeZdcWFNTRXzoT7NULUDJax47bXEd9x8V01FcoQTj+HNu1L9gxmm/PzpXGThrM5NDLSCDG2ypx4Fdl5HXGbcrNcO6A3mY0gcBURmY0BV22Qqp0S7HToy6OaEAnLaqtmi6lRP8tZyVZ0K5qfquTABOQJIITy+ZZjNvbHxJGfMHO5eBsAACalkVdUqZBzBDFvu84t2wZnw1PV73cR6C9iDfMMfhTpBoiRNHvs8Yk/BNrbxMO9E37oQOxJY9GAyLhs4o4NuelHPkXUepjdAV4JgLvENl4NjPEdTSxKjRTjbMqeGNz6tbb4sj0tPqJhtUnn+cnWhGqHufz9OO9h5askJvEMVgDLASbr+hBK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(451199015)(36756003)(66946007)(2906002)(4744005)(4326008)(8936002)(86362001)(316002)(8676002)(54906003)(186003)(2616005)(6486002)(478600001)(5660300002)(66556008)(26005)(66476007)(41300700001)(6916009)(6506007)(6512007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U6L7LYrMz5opAX8kqxBCaUUYY+ivWriEVu1or36lqSCYPR42GLvDo1UHGDYV?=
 =?us-ascii?Q?x4Tg2JS7w6MFyKRPeTHBgWLTNJczCZtaZsOIIv+2mxNgTKlKaYAjIreiwWmS?=
 =?us-ascii?Q?jkX6vX4WXQIfKd280kLgrBe8BBJjEcgVe8s8aBZSn/KqUR4Rr3go42o/kJ8j?=
 =?us-ascii?Q?/YiYJ1Av+aFMMqgejg8PnincT2lC19AwyinJdSFbf9MbXlTqSmXmija4DEN/?=
 =?us-ascii?Q?yLhjWRioJddWCHRBRC0rlKQQdufZpN7JhDZ+mRF/6XGGYeRsruN2Jwf4AaHh?=
 =?us-ascii?Q?JlOelb1Gw8SfRCQZ+v3LX/y9+0s+AacxMAFzfY3u77lFuqn2NDuGIzM8KUCX?=
 =?us-ascii?Q?wKrIAZk7cYemRHmD5CB/1r+Jjg7Pd07egnqCJ7KE9FJqFfB4l8i8/Of3Po7E?=
 =?us-ascii?Q?1HGQDChoiHYb1AMr6RD5bZ6yto5v1AGYa9d92Rb4gYq+msGcVPe4A5vpRWTf?=
 =?us-ascii?Q?+oyXIdUZP3UdOK65lpXrER3xn4tnmrHW5HaxZn/gZFd+7HlPB4y21VW4QU4f?=
 =?us-ascii?Q?BBqAXLXNB4zdovvGw9WrVOYlsl/XPkiJKhd43WGKNzIh0zUd26JF4R0zY8ho?=
 =?us-ascii?Q?UBbNJ5+j75IkKZF8pjs1ZIq5xGm0Q76FZQlfzBBvAlVgNOKAaEBNMfS92LYz?=
 =?us-ascii?Q?mSVkxMtcEigMIQYOCyVA4wOMar0k/WgpdLZ30RbTHEFVhcX5QRatrKFPz47Y?=
 =?us-ascii?Q?H7RHCwHPQk0219t3XRBeShdpthIDG+VnE1u08/COXHJABybsEEcfZPTReBeg?=
 =?us-ascii?Q?YffnfVnnuz5eQ7QxtgPW43iD8KmWsG4Isu457CXIPH6mNybPw/2QhNGxe4+h?=
 =?us-ascii?Q?3s8786u08lQirsKelHkvkKpqfEHxS/u3Q53CXKSGinNowj9behzdfQG7FSGy?=
 =?us-ascii?Q?n7IiSp/KXR+Gr90j+VuZsML5oS3u9mdI/vDLJxJS8ygraetGtNVKEvvhMr/O?=
 =?us-ascii?Q?Hq6sqU2Rhyhmpse6mxWKQBe6xtUGZe2zynS70QNitchTMgNd1+UWYRpHSewd?=
 =?us-ascii?Q?tPHkWG2i6H4IwNHgAKcBcUJZlruOkHWJOJWpPMiOouA1rtXj2hLBlezaqvOS?=
 =?us-ascii?Q?Gm4tCve/PjW8lwakwZwoA4hXQOZWDQ7dRctn6Deo8ozWwBHtmLb5rVnd1raR?=
 =?us-ascii?Q?HLFNcyWNyt4zz9YZuNdMYcdT2cSLq6/zbTSeeMY6IM4cChxPCZQqYnCSrzk8?=
 =?us-ascii?Q?ynFrrxdd5Kwxft7lrrLp2Rb8kg1gbyWiJl4G78gpDxMIpbRPBaPoKI8CSXqA?=
 =?us-ascii?Q?MAeKNNbpMIw5yodZuoCDK9KoqgzVSukTsXNfT6Yf6Gr+ngj0E1e/PZHs1yMs?=
 =?us-ascii?Q?/mGtVOfryXe4hOW2UxBvXfDiVpxf6WEexh8jQynO7uc4JYay5xzCXJT0VHwA?=
 =?us-ascii?Q?SHfd2maCWHCnDolsmer+BT9Zht6Ff+j9gCHl/maJujqjuZmURytK5jDd9X/S?=
 =?us-ascii?Q?Kb5aJgGMPeFfFjvy6jGKCAR75cJTxTgTZbojX4qFp07ytXflDVEzYti6GIpI?=
 =?us-ascii?Q?ad3IVwfCTnzvoc58UlR+htXHiOoPYDZJNlMMjrlgLoWqiMjy3ITrECxtRhmW?=
 =?us-ascii?Q?Shr1REG2obG/UkpARHo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 004ae2dc-d913-442f-22ea-08dac9835af7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 16:38:43.4921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iIwQFrS2ne3SJzgwNPOsahz/zFNnwXrpTiiysiULw6qd65weAbHnuDLeBvQcNFUT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5934
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 11, 2022 at 04:30:26AM +0000, Li Zhijian wrote:
> Every rxe_phys_buf used by either IB_MR_TYPE_MEM_REG or IB_MR_TYPE_USER
> has the same size, which should be same with ibmr->page_size. So we can
> use ibmr->page_size correspondingly.

ibmr->page_size is really only supposed to be used by MRs that are
going to be used with FMR. It is some protocol to pass information to
the IB_WR_REG_MR op

The whole way rxe stores the MRs really could stand to be modernized,
just replace the whole mr->map and everything under it with a simple
xarray of page pointers.

You are right though, the page_size of the logical page array should
be global to the mr, not stored in every entry. It isn't a sgl, it is
a dynamic array. Just don't abuse ibmr->page_size for it..

Jason
