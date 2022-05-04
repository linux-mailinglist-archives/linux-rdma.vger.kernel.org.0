Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C7D51A246
	for <lists+linux-rdma@lfdr.de>; Wed,  4 May 2022 16:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351347AbiEDOhs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 May 2022 10:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348928AbiEDOhr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 May 2022 10:37:47 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B1220F5D
        for <linux-rdma@vger.kernel.org>; Wed,  4 May 2022 07:34:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2pHwNBSi8J/8vi0zzWWuBNzvSYKTCTb6G+vWWM2Q3djymLh2pcMq3wJLdKB2bUrprefN64iApjwyoa/thgRB3BevTzEtdphpoP8WyCNjpZD9ATvvhG+Ti6++JvFvqlnWRoaDe39wSI1yprTTrszg8XfB1rIuy1W14HK5vpj3mHzFNnUc4hdBzToPXdRaFTJZvdP93Et4TByw9snVtPlaEMHo/AosT0MWAmz3enwN+5WgxMe/5n3B3XiHkw7V9EbqwM1YUBxQ8bg4nrQYn1bq6CQjjRpQVyxF7V37s1aFSw/FtH9D3LUo+FcCLNoDcvveHZ2p2d/4V7IN9csWH6tSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjXRC5eet/FWfY2tDxNmUZf8vOCILTl8lU4LsYzKR30=;
 b=YhlyYb6IpfFpjgQGdw08ppSAv/ZG6j7hucSfzebTnjHrN/HwlbE+crZGtJeqAQwvh9Nl29LicTNHbe7OSsxI5GL7h8L10zxXP4SxMWQ2eMBw3Xa58R/pTA1hKkHtnSSV1yVxeuPBBwJHqbZxOYtMT4a2YgN32LCKu0DSIaYKiL7Aj7H+LiiIfNR2jQBeEvHXP7RO9aAINk3t9hz3iu03yuoZVjRYoJkCo1bu+f8WzVd4yluDNLs3lOsIGeuwzyKZIgZ1TxRbOuL8NvIYQ2memF6LFICcJabJKQtFH9opxC7dOzXPfiA9db/VxOEA3+1RFITSoB/d72xxZU/a929IQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjXRC5eet/FWfY2tDxNmUZf8vOCILTl8lU4LsYzKR30=;
 b=TpzRTL3QuenOJjvb2p9kKr668IUC1+7yRKMf71jS/re5EjoMqeyQ0b6NvbvgDSkX3OQmg1O23+CC2w5uoJ0faRN6thCgso3ncbwzZvhop0FvZf8lEzdDu1zkaXIWyL98uwVmqJwkMeIQxoF8wQZs6ko6Ywb2Q1jvU00x9YHlEUwNNQwVM3zVNS7KYfJqRFiRwQpjnjxHrldZLemR7aDeGFUQm1Yg4ia5NgLBDkaIEdwcl6LNyyd6OHrOP7nLtYBDn3ruoMlWen4WI9t8Lm3iTi1sxOTPsgNGAVO3+uVYgydTckM7iAimGo04rvrzqBEJN1Rcj3mOI4nlMsggZH3rjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH2PR12MB3687.namprd12.prod.outlook.com (2603:10b6:610:2b::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14; Wed, 4 May
 2022 14:34:10 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5206.025; Wed, 4 May 2022
 14:34:10 +0000
Date:   Wed, 4 May 2022 11:34:09 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/rxe: Fix typo: replace paylen by payload
Message-ID: <20220504143409.GA70052@nvidia.com>
References: <20220420172316.5465-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420172316.5465-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: CH0PR03CA0330.namprd03.prod.outlook.com
 (2603:10b6:610:118::22) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa5b0792-052d-4d4e-c33c-08da2ddb270f
X-MS-TrafficTypeDiagnostic: CH2PR12MB3687:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB3687BDE0E1B1B7C46F2CDD0EC2C39@CH2PR12MB3687.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3tCufkErFIzGPke5DBgW7+SGEJJ2w4dUjIuelMwdJtSWb5ihVKsk+vhYaXczgStd+HW8psJp1DxJBT3oDvmAT7vW/jJU8zX0wnLsPF7RctHYcN3hMYNEBRcYvNbGi1LAyRuVXQVw/heXbLbZszeP/WWdcu8INOAEhKLZQA4/akBJMs5kbqqa3pY5fA0/0aI8WLn5U2qoxa+tbGp/EleQwVbBl1nMMNl2fO9h91+MjrhYh5NU9Y8QwN+OZp51o/402eLCu1h0nlJrSUyvFbOdEVlHaKk9DUl7lKv0EbIpsxz8E86QBEMo179kEbXk21WL/aRvmTtxfGKCMU+ii8LYDixXM5zMWu0rOny74MXOkputzfGoWbLmBTqoja/dj6YUt6h9aTIW2Rh5GfUMviWZmwkRSyWh4mDCdJrHDiudzoiX57AfmO8hfJnr8bRBEF9QeX2OYijzKdDsSdKXiD5tIMBKau974EyEGyQKK53HpirMvIiNdL/XzqvJW+nF1XAS/MwvuNAll/wgs1W8m68fZX6+GkFty1CA6v6LgQ4qnXwCqswUk+jz017Af7Wr8LQkld4fjGxe2QQROmr5+n2ADz7Z+FiAPPQpbhp/q7weZcka36hTwSjbzSspMm6ABCrJhL9LthJ86XhRh0CyYduamA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(6506007)(6916009)(316002)(26005)(38100700002)(6512007)(2906002)(186003)(5660300002)(2616005)(508600001)(83380400001)(8936002)(4326008)(6486002)(66946007)(66556008)(66476007)(86362001)(1076003)(8676002)(33656002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/qgGsqUWf1/vRfd8Itk3dxdWMD7KyQJYXKB3gib8kDoSvgojbIr8RdMFtDbA?=
 =?us-ascii?Q?3kvQjt+HUeOngVxageOSQwKHS+tVwm9N1I4Btp5WD5rIOJ8bcXzzQAwTS9Id?=
 =?us-ascii?Q?zIBOTYdMEeR7UCEcOHRP9/iy9pznG7sw+iYqEIydrh7r/JEcIqw3xx1bQm96?=
 =?us-ascii?Q?DeiZC2CSNwBfX6E6GqGreJM2mLXO5YKo666viM9iNL9inBS6XKOTAnl9f3IQ?=
 =?us-ascii?Q?FREDhaJrPYf60XR5ylkaJ8N/NQmIjK9GDWR96gzVG+9iVTguNiZig/pAgtog?=
 =?us-ascii?Q?cNdv/c3dtL5INwy6sSwYmiqtTiJecdpfEDrCVYavNw4ls6G4Uh7QycdXBt4W?=
 =?us-ascii?Q?/33wYoMR8N2ekYqEfaY+K5U3ZW0qoH9Ugk5+S7WjleWTP8m3haBFNeanZ4Yx?=
 =?us-ascii?Q?Jg7XWXhK7qq081c1xoAhoghFRvjYZwt+enVMn3PMtLmOT4sKTJZL5ZXBz96q?=
 =?us-ascii?Q?CSN8xI5+9smRuVVrR4DRI/2s5tZkhg/H9Px0TM7PG3jew7pWFOXuNtovwc4a?=
 =?us-ascii?Q?wILP95ID7HKi2vOS45VqOjy2a3BkLNjypa9PkDth3szOoPl6USaBydelcIbj?=
 =?us-ascii?Q?QgS5sVBJbuw4IiEtyE32ZCyu/mfm+EWd9oqY5awmxBgvVSEQ+56SZH+s0Kdr?=
 =?us-ascii?Q?u5UARPre8ZqxgPGz3vun5o1RhioydceqR1u9p+6K0aisTBc6S++Y2xzokE5U?=
 =?us-ascii?Q?2Snt70PV6ArM0JpSZVYV52JI9fXZa3FAxqQatvbWIvGjKzBLfPp7DHeyIJFm?=
 =?us-ascii?Q?vzcnaKIsrBmZYrkg7OJv4Tk0C7tdL8zz3ZL5OW0iVR9wyZ7WwCBj4e2kdWoh?=
 =?us-ascii?Q?EEa7kT4bs3X2Gbo/lR34AJBQNCctewVvpYrpyXkYjyfVZY7etTpulkX3d4VJ?=
 =?us-ascii?Q?vyaGkOwV/v3iAc+WYxxWKTRMeUhMmIfXqXR6SdEzgoLkL8DSg/r/gVJykUOV?=
 =?us-ascii?Q?jgZE4IC9irSSnGtK3kGrkRf1KJafLJe33t0Tyg4+Bz+CXkN1BYS9RjnfMu/e?=
 =?us-ascii?Q?CKD60csZ3CVz2QG3JhYA9GZrkgezZHuTbk0AibrsSMTZekp2akGVavPUSKHR?=
 =?us-ascii?Q?utq+5zQnzz4o3fiN8HtdqxXh2fx/t4vWZEaE5rzpmm59y0CVaccId4JYGyu5?=
 =?us-ascii?Q?uF4of6HdvpTZK/6VgR74y0Y2ARpBpwcKvY+j97MrxglkQktnLXzPhFymDhzX?=
 =?us-ascii?Q?tMtQ26MdN4Y/gwxU9WNiQgT1b1Rc/ORnVoJjK6HOkoRuVoYwedXrQige2soV?=
 =?us-ascii?Q?qF3Q8ajmgcV32AXfCPR1ZYbh9tjDFCyOpXE0soHGAFC7qt2PwS+4oHPiGCFS?=
 =?us-ascii?Q?JlqBt2da2zKhp1iNmEtmrMHyWHBu5hxOErm5iaLkeHUvoqxik7d48zWNCxW0?=
 =?us-ascii?Q?n41TxxuQDmnrrhMdtl4vdb4J1GWLr9dmHeOb4l25l0LuzzCUO1yPpSgKVDsV?=
 =?us-ascii?Q?vkzClQZtp9mKEWCP52u+G32kebUge3m8MS54wJDzKQIMPEh0cBZDHyafVDsA?=
 =?us-ascii?Q?fODjKmPR5ez3wvOmo+PQWMjfyvZ0pkyh9QClXg5HkmEacncFaAt0cHjwPE4o?=
 =?us-ascii?Q?e8M3WJxH5p89pD52NWLXR22JLwhGR/x2jzEF572JJjoLq4NxBG7ND4HUgiz4?=
 =?us-ascii?Q?1psGDtmMKmDpiaNgDrFwTfCCft1FWwEIv5rHgI8X5jK/AbbLTChBJ2RhkEnm?=
 =?us-ascii?Q?2JCCv7aFDgqR7Dzz0Wzxahd651RhjI56yJSBNfq7AFGBbwiqr1Ziq8a0GL42?=
 =?us-ascii?Q?5RgMCgSB+A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa5b0792-052d-4d4e-c33c-08da2ddb270f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 14:34:10.4028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EceuxaLu/SxDal1WiufOipDqeKNigxAcqFTwBOleUDtCr5R/a4a/h+PhxjGIr4tR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3687
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Apr 20, 2022 at 12:23:17PM -0500, Bob Pearson wrote:
> In finish_packet() in rxe_req.c a variable was incorrectly called
> paylen instead of payload. Elsewhere in the rxe source payload is
> always used for the RoCE payload length and paylen is always used
> for the UDP payload length. This will cause unnecessary confusion.
> 
> Replace paylen by payload in finish_packet().
> 
> Fixes: 63221acb0c631 ("RDMA/rxe: Fix ref error in rxe_av.c")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_req.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Applied to for-next, thanks

Jason
