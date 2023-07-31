Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6E576A041
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jul 2023 20:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjGaSWu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jul 2023 14:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjGaSWt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jul 2023 14:22:49 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F38DE49
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jul 2023 11:22:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbWXrUnJT8v/BWoTurtAVhF6pS/94LOdAfDms2qNibkSF80QdQhtadc3KabMb+xLcqJnVgR+MrU5PpwnDO0N/f4R3RB6ir200vk0ZpMGxTUmfn2xAHWvTrHMDNIu0eZHJ1PQtjyYF4QweMCnqRgRK6HVQ5epH/PQ4vZ58RqRfuxnVjIfdpzQXaVkwT8jH10n2ZsMCnRZHVUdaiZzdcVJSD/ojXXm126Sikkc5sy5inHnsVzA6ik2ZsPp/ATbsA+7/0NpTKN1ysZinWycFaLIXPfKaZ8hvOPIUR2fqujBAGJsbAdoI8ZaZkIPeNrtEXzjmLmYoLe+bdCn54EyN82RCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftfsLAcLnktFxwkKDqO1Tbu92Vcas9cDJBU6+pedAc0=;
 b=hy3k3BhDhj+8qGH0wfJ1nNoRzvwbd9XFhwSlVTiuwBlw9n7yiq9WBvN3P97nRWq5eq/JxuG7sDR0gOeSG5shUAIOeVHc3iYLazXIAYoH/M3loO8C2XKbRSzTXrHC4Pivz0+cnVf03bXi1ESWwnWpfZAuNwKpmQiILUmoX+w+UIdbxoIno+O8ksUruwwyri0f6t3GhFMKiyPEOSsQ/E05/4CzB6x15+Z4PBqXao04m2Q2y0mMXWX1pEf8A564RcdfoWqY+pNFsm4WsDkbHOOjrkPv7sdGZ/z+78wF9hxgkKKspubiN7W8ManHCbfISGYIdwsEYx7+lscDy0dzpO+uKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftfsLAcLnktFxwkKDqO1Tbu92Vcas9cDJBU6+pedAc0=;
 b=GEBk8xXXDhw4RYSbbRwSdq+gjtHEcbMCBkpRwI4ZFlFzapq13o/jZR86kw56ozZhf8ZB1rSDbcVhrGBfMBo53ljFlzB/E4YImRKb0K0uPjgr+K7Hq0aM8xUmKo/BemoAqUfu8QYQdkuev3rGGefI+gIgZWWwlrq7gZ7lYYHkqvVU3L5lTWUaVxIoHZ+A93eS6ADzteLaRQ9q7uqL7ACgdfcLDSZtYb62943xyp3/lpf3icHFNOH2zlY7x4sBAWPtmzFH7L9l9tXCKnn9Zb+lNWeBt7zhWyrzjwf4bKkhhR5DUQXS2sfYRRGDRUMDbBCB7e576iZvbeOYN3Iw64F5ZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL3PR12MB6450.namprd12.prod.outlook.com (2603:10b6:208:3b9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 18:22:45 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 18:22:45 +0000
Date:   Mon, 31 Jul 2023 15:22:42 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     leon@kernel.org, zyjzyj2000@gmail.com, jhack@hpe.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 3/9] RDMA/rxe: Fix freeing busy objects
Message-ID: <ZMf78rDLesRO7ZF0@nvidia.com>
References: <20230721205021.5394-1-rpearsonhpe@gmail.com>
 <20230721205021.5394-4-rpearsonhpe@gmail.com>
 <ZMf5RRowWoO5MkD5@nvidia.com>
 <e8b4e355-be62-591f-a034-1888a891c846@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8b4e355-be62-591f-a034-1888a891c846@gmail.com>
X-ClientProxiedBy: SJ0PR05CA0183.namprd05.prod.outlook.com
 (2603:10b6:a03:330::8) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL3PR12MB6450:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b7c5d1a-aef5-42ff-cada-08db91f322e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lu939APbpudTiFQD4WNGWe8um3lcjLt+Q8SsqrssFd9kuF4Aa5zv4eY91Psj3zzHKvau9U7IsEsw7ZwJJWzc5s690HUinjDvvg5KQTS1w3w6TonPuj7P82vBdkfa/hS4vsQEWEJ2Rjb/4mpf7CeII4yYT0bdu1pYt9KazNbhlJd2MTpiL1lzSHbVEVR3p/koHTFTs76HsN4tdsnUBfL76Q6PPHoxqsy7w42I+OS/tGQoBOXCbGKlhMYA5CWAXkkmSICbZbOSTnBxQyHbguVs6Cqf+lQ3BVCWokqF89HW9Mnri8iYirsB5DYlMNM/f3odZafmZWHLbw8uxrrE/JgtkRmAVheXlO2g+XJnM8Ku2beXZF5A0dGfkyRIuTyyYdvqEXKt0J+4s20BU9WIWi+NbrBjbN3T30cX/kmQ29O074glTb2YIM9zCRJpFeOQ4C/e1LjKAQBzlmrRAwWk/luzK4pxZDsnG2GoCHr8p7O62Fvz8mySOKq1JX4mt1Z0/J/XzIUBmAd195IARGgAMEFzz4m/iXbTS/xWFgfo1IXL87EHcEpAVjBpTMnVEMkn8G+h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199021)(5660300002)(66556008)(2906002)(6916009)(66476007)(66946007)(4326008)(316002)(41300700001)(6486002)(2616005)(478600001)(6666004)(8676002)(8936002)(6506007)(26005)(53546011)(186003)(86362001)(36756003)(38100700002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e8NTSFbmJQqtgvoniprjsBoF2abSGOiRUkcF0p441jt1EBPMKNlJL4QUkatn?=
 =?us-ascii?Q?J8l/LnbmhJgM2KgzJYI4RxXMXPMLkK7JGojSAARoTD6Yz/7sVD7W7r7XJVke?=
 =?us-ascii?Q?ovjdFz993JmRiIzoqgqP/1HQPzvnlRHeMb7YRDdHsLLRlzkNO4YsDqHsqilZ?=
 =?us-ascii?Q?1+ehXX/CHD+Rk078Ok7mMLU1+kCfyObyMwCQv4FrsdfuJJOINegjVZK7QncU?=
 =?us-ascii?Q?bBiDrowjtAXbodRtwks260VlJS0PkSAY95EbRloJbamszQprWABOx5/bMhiX?=
 =?us-ascii?Q?1POiiO2HYHPDd2HuRr6azzwhiEw4lVBTt7aDNqbJ+vkFcFwHh25GqDMNDuhf?=
 =?us-ascii?Q?7prryC1PfY+3Y2jRyS6l6Z8wxo3LtGk6kBuBqLX3PJMjYypGf+WAtJmBo3L5?=
 =?us-ascii?Q?cKXSBxwJW2gX1J5VtqGFlzmC4auqoW8U8sU+LEEXV2XHGPP7NTyediO4L48P?=
 =?us-ascii?Q?F75mvF7Vsq+MbnSBfATNt8nVLWX5IxwDnutyoJ/1NrLP5/fbRRRe2dTzRmjC?=
 =?us-ascii?Q?8FBBhUOYtANDZvZki6Sh07ebYD/S+a+qFgEJkziBC+aa/6C6V+stLmAfo77q?=
 =?us-ascii?Q?5dle4AAWgxrHCYnsEiyYg9r3w1IE+/8blG1nKx3OL8ZYbqTP663CjfiF489c?=
 =?us-ascii?Q?GqCnR0Uv8jNidl6E5hVEvbL/sj4myobMc2vJTKJFMSAqmKawZYzjVX9aMrsx?=
 =?us-ascii?Q?DClp1Cqj8IoycE1zYQzh2YYxuOgGJ/D99lQe0tYfb7F2z3mtYQV6QmvobMwG?=
 =?us-ascii?Q?KRL4o1TwBHRQ3LAlfHSc8nDp6NrmGoR0GGY7+bJpGtrwzKKD/nSD+tU16VMP?=
 =?us-ascii?Q?8AyJ1YBDMtzg97RTBwe2SfWe2w73YKYdOekIDOYV3qn3sHSz07IPhqU74yxO?=
 =?us-ascii?Q?iRS2C2H617LzP9wBupxlvbYpwGUj5lQRXGG+fVs6gKl7ilFP0I8MPFZtqs9L?=
 =?us-ascii?Q?QiFQpTBC+vDm2COt3fzjPncLLbp+KOM7XShLlwo4LvPrPp62uwWI7/169Xgb?=
 =?us-ascii?Q?S+0jR7SO+kXM83dnlw0IM+zspXlk9SNHqE4f3WP5GfxaZf/HWocOChIbTJTx?=
 =?us-ascii?Q?At26Az3cX9XZwpUPIlKyG+rvPr1UGhegeD/OjR8OOcKI3MVFt1O7MqBYF8sP?=
 =?us-ascii?Q?6M3Pob67wTzQ2djJtzsgX+XAU5pUEL8LX8nXzJ6LDb3sfl+YQs2FY25Z9zxA?=
 =?us-ascii?Q?ryBaC0BbLHfnM4W6R0JH3xuyzUBzULK7aLNkWzVY/I+57XDDJ+gX+Z8PCEgX?=
 =?us-ascii?Q?liHbNMD/k1WPjhHartrGFfO16Th446Mym5BvoB7Tu6kYYwXBGIZBk0qYWWHL?=
 =?us-ascii?Q?H7Gf9R296Elcn5sGQEFEGVUYD6x5coVfaesqLSUfq7dq7QV+z7pD5Car3kNm?=
 =?us-ascii?Q?tnnzGV+UVR081NcylvwW3mmLcBjdiL0rSHHEZLd1nX9hTjXIrmE4B4IAvCNU?=
 =?us-ascii?Q?a/pwCP/mmSJBsz5I2hwcfA/FCm//Hitvqyxm6BGu/KjsXa0YvT1n33bT2QcY?=
 =?us-ascii?Q?Rv56/MGAEv18I9ZbprL3C5ky4M94bjqA547mmzEH0o5virhDPagma9+1mYto?=
 =?us-ascii?Q?RMefRzHFJLdzMXQ0n2KUuGvwfnrAmWUAJalidlen?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b7c5d1a-aef5-42ff-cada-08db91f322e8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 18:22:45.3300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q4oqPR8R8zBnqQ3+RIF2YKSWQq9k/9vDmpmPu6odH8/VwZD+7T+jBwHeNm49oKCs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6450
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 31, 2023 at 01:16:48PM -0500, Bob Pearson wrote:
> On 7/31/23 13:11, Jason Gunthorpe wrote:
> > On Fri, Jul 21, 2023 at 03:50:16PM -0500, Bob Pearson wrote:
> >> @@ -175,16 +175,17 @@ static void rxe_elem_release(struct kref *kref)
> >>  {
> >>  	struct rxe_pool_elem *elem = container_of(kref, typeof(*elem), ref_cnt);
> >>  
> >> -	complete(&elem->complete);
> >> +	complete_all(&elem->complete);
> >>  }
> >>  
> >> -int __rxe_cleanup(struct rxe_pool_elem *elem, bool sleepable)
> >> +void __rxe_cleanup(struct rxe_pool_elem *elem, bool sleepable)
> >>  {
> > 
> > You should definately put this one change in its own patch doing just
> > that.
> > 
> > Jason
> 
> Please explain a little more. 

I mean just remove the function return in one patch, these functions
are not supposed to fail anyhow.

> I only found this change because the change in rxe_complete to
> repeat the wait_for_completion call didn't work.  This seemed to fix
> it but the man page and comments didn't explain complete_all very
> well.

I didn't mean the complete_all hunk, I ment the __rxe_cleanup hunk :)

Jason
