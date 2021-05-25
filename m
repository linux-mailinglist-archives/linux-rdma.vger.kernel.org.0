Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 002D3390A67
	for <lists+linux-rdma@lfdr.de>; Tue, 25 May 2021 22:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbhEYUUA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 May 2021 16:20:00 -0400
Received: from mail-bn8nam11on2082.outbound.protection.outlook.com ([40.107.236.82]:57313
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232744AbhEYUT6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 May 2021 16:19:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1gn6GhpjypNwl5qlcXlDLYHNxnR00bsJ60fEuJDs7nNkWVgottJ1aHMcSIgoDiF4DbT2HD+kv6at+B0ybQI8LNUir6/Poi7xb8/JvW8iQmCeyyQX+p1zSzc8joogfPnmyAwwTDmWsBErUrfV3a5MsWAPHfDjInZPThUM7xTa6V+aYMME3s7VaUTsFrm2FTx0LS/E35LCGAnES/lBEcFjFXsU+TDsEGdQi/mGlNhutQxhu8YlF8+hb9+J0FB4XFxXaXl20Z3F4Qiuxe8hIMBdlbvLq5k7MUNO7vh9UV030ZOPz5eFOicAyy8tFgJsaMNPSjhf1WB0kvctffNDdXcsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qDIqcOUDnfM5XRo3nuVl/3refhzOqHmrR1fABup4pc=;
 b=SXPZ06XTwZOAOg5TTJP+DaQTqv5bZByxLXR3qYvewu7IHhT4WlePFf70B9qZwUuzLALwemUHL29XDwafqQoJyV3+uZjdbmjRgxBYclIv6Czmh9YvFOlZy+fJ66v+vq+0DCVRH6yES1938nB/8A19uCHeJ+CSws7wLBmOlCQFV8kRfYlSM5di54fTlvZLvTU0Gyo/Xa5VjtSTRY9iumj/1cOz0+hmKY/QG59k6pLa/h6VU0q5gwyW44S/s2kMXd06uK05opMDynYq75ufZybOPcNLefpPFlM0aMnt3R3e+ScCn0MV8sjIpAm3si6biAZBhtL48oItZrhh2O8RJREplg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qDIqcOUDnfM5XRo3nuVl/3refhzOqHmrR1fABup4pc=;
 b=U08fprFBG1Jo6LZDYq1/l1gKs35hl5FrkT+QsGoQ8VChWhsEC/fFutfN6gdkK09FnJwNCFU861n+kFRb2sMrDXhI6Kc1B/jGlY1g83+DgaDaZTC98sWjBD7vnFqR+vss4vGjLmtaPiRW93QhB1mcSQYAHwqBhRIj++cPZCaxkEYBX0caqL6yfMfGOmeI9L2FyEl9Lc6HfoWg9h72NPT8fPSggpqMLc5/PrzUFG1acHOvzM6mwGiWskSO+w9qzb+cTVz8cQixpl5DvSHXan3gBMnKX8E4pJ6R+vYKjL2xtB52FM416wCmaH5GkD0Y3aqR43C065ORum9q0XXy/yVCXA==
Authentication-Results: ionos.com; dkim=none (message not signed)
 header.d=none;ionos.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5078.namprd12.prod.outlook.com (2603:10b6:208:313::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Tue, 25 May
 2021 20:18:25 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4173.020; Tue, 25 May 2021
 20:18:25 +0000
Date:   Tue, 25 May 2021 17:18:23 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gioh Kim <gi-oh.kim@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        dledford@redhat.com, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Subject: Re: [PATCHv2 for-next 03/19] RDMA/rtrs-srv: Add error messages for
 cases when failing RDMA connection
Message-ID: <20210525201823.GA3482566@nvidia.com>
References: <20210517091844.260810-1-gi-oh.kim@ionos.com>
 <20210517091844.260810-4-gi-oh.kim@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517091844.260810-4-gi-oh.kim@ionos.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: YT2PR01CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::10) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT2PR01CA0005.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27 via Frontend Transport; Tue, 25 May 2021 20:18:25 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lldVP-00Ebza-BB; Tue, 25 May 2021 17:18:23 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b48c1a26-ac97-4b3f-06d7-08d91fba403c
X-MS-TrafficTypeDiagnostic: BL1PR12MB5078:
X-Microsoft-Antispam-PRVS: <BL1PR12MB50785D89994DE6CC3C0F65A3C2259@BL1PR12MB5078.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wHPIpmALpdzbCgaQDlfZDEeZMxUfo2CRD/TpwYKqCeCeI0eX+xRnfeHek0ikLkiyHi8GSGnKELgE8WjzJppZ57KM8Ups1UbaxULFGyckHhCPFh7dlAPJZGSsYFrG6MZmMnyAEDWkChG4fD5GhnHov0nNISc/v1eTdS+pvceYVHnToKQek+HNg9Qx90cHDnwPm2bivO2g48GSA6/ONBGTtD7mNyfqUppU9C21WOR+021isEIMHS0XVwyQFh3/BL/XohBnA9PH+mJo+35ofvy3zrdH28PVMFQjmy0gaXdu+SvXOzj/hx8FxKqKRNfuDNXMqDODvGZYpRa6sZkRVb0qMh5muof+cRndfnBD3ERZXMBHCfcjp+TrHlRpjMfYcVrWw9W8wcIek39f70kar9erc6XJcd3ADNwc+PP1IDrtsrF60g9YDH4Po9HLlYgpafph/68VPS8N2TvEgp//oOiOPsyB6HnfoK5ZMS3J20C8wbM0hUB6JATAIG2j3rxs3YSiy/P5G0P2ErBvR1On5MnBkAGMs/HN1UyStF/JT+MS4OiCP/Jis7AYKqYX29JG0PpOYpsCK6Xh94nybSnFSh6CXkTXdEkqPoj0PTQwJrz8BUo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(1076003)(478600001)(6916009)(4326008)(316002)(5660300002)(38100700002)(186003)(26005)(86362001)(83380400001)(33656002)(36756003)(15650500001)(426003)(2906002)(66946007)(2616005)(8676002)(9786002)(9746002)(66556008)(66476007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?sBvKSkZgC6qDgHO+a7Im8VERI7QtD6Z/Zc93A62p3vzTYvGlKF1cSovkcY1a?=
 =?us-ascii?Q?6hBWijp2iWHA3NxRaq3IQb6Jl4iguGYsqkxd2vPZMVPLs+O0cQgr+IW9xcH/?=
 =?us-ascii?Q?NX4lKDRy2NdOQVk26u48bATjDUaQ8F+LPk20dIgpci5f6IGvxITO9x70RG2W?=
 =?us-ascii?Q?+pqxc6h/Uo7+qyXQdjAsr7iIhG7umVAziaW315mhBfOZMVYbLj81aeVVry4Y?=
 =?us-ascii?Q?taMcQYePTCcv6ix71TERLxe6J4KIzxMUVlEcEmw5oA6aU3zRD3YU/FDtrMnQ?=
 =?us-ascii?Q?xh5l5S8VOt56ZSALZJRK++/xlEXoTIV0M1E82Lui9dhrsqzQkVxJ5qaCPWi5?=
 =?us-ascii?Q?lHOZWKwXWpQ6QQJqJ/vXpTa0yknVRfXTsdOjMKmIFuJ+TsRMJDc7Ppw9Nw6w?=
 =?us-ascii?Q?zf0hOfK7zaAbbs1bE+NA0n6gn5vKtgXj3Qj0t2JUlqjKZYgGJuSRHfcapwzQ?=
 =?us-ascii?Q?FJYEzOKBEUgE+G9BZX5oMvBUazEJPJWdnvnx/PHq7A6ZkjhW+1wAxd0VRcTR?=
 =?us-ascii?Q?QA6QITXwbkw6/Kvb63v3RLQBTJ9AHBwRWgZKQ9ikeC6+5BaQtAQ7imikh0jG?=
 =?us-ascii?Q?8LYepDIADZ+IIGDG+HgosYWCTIwnxQTQK0sRbf4iJ5Wg2nyGdydkmc1p+PKH?=
 =?us-ascii?Q?diq5YMky52iPNjCQu7YOX9C968nArCmQjcncWXIAR42+bRadVF1x702C0J2k?=
 =?us-ascii?Q?ha/zAny/8Xh6uqOcQZ00BI8zNa/yvwM6Y0Vsiq4N+ZoKxfzr/1iMqT2VhbmC?=
 =?us-ascii?Q?AZzh5CvT5lVkw/4kBFvaIunVQ9vEkftkc+w9Vk9N5J5P0e95hGsLAg6peneS?=
 =?us-ascii?Q?GMnbE3eCd5st+8b0SXoj3LYr9oa2I98rDq7O7mHRq7KdRZsfPhaZVnSOTfLF?=
 =?us-ascii?Q?MvgU/6beRfLbaLmSAILbppvdGVW7zjyAyXEXs2L+7KaW01nrYRT9oWYpZKFQ?=
 =?us-ascii?Q?OB2iLA9hbNLSOvU+qOYHFlDVgLByxc9qjYhIq2VNFEsuAQ76524VtLcvSZOC?=
 =?us-ascii?Q?j429z9S5ztCDnCr7AODoz3XlkYgi41bkbMQhPfXHFLO9ZVlNuK33mkvvyQfT?=
 =?us-ascii?Q?/G3UbR3AhYkK7Pi4G9bgC4X5l0xhwH8NsROdWBah0QhvOUk99a2Y3/JiiDGz?=
 =?us-ascii?Q?8LoiTA9JuzHbFct9qdIKLis5ah3u8d9jgiV0Y7NK8pkKq1bTilSSiVl88fH/?=
 =?us-ascii?Q?xOTyJy3OSjV9A+e0By3+DUkE9SlLX4FaV2tC50CWyoX77kKPXEV90r6RHXXw?=
 =?us-ascii?Q?Gq1RjNmgDdSjx9vNgGfTbQFJ9CffWrnpUJsANA7zy2aVTkfAP+oODbdWPblJ?=
 =?us-ascii?Q?y5yuaf66FWVlYaDu8HsD3soy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b48c1a26-ac97-4b3f-06d7-08d91fba403c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 20:18:25.2794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x9XEKYH7ApnpJn+bLudqVqkq8/tSAsYH4PImMTj8SHVY9X73H0CiABTGSKoyxk1U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5078
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 17, 2021 at 11:18:27AM +0200, Gioh Kim wrote:
> From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> 
> It was difficult to find out why it failed to establish RDMA
> connection. This patch adds some messages to show which function
> has failed why.
> 
> Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> index 3d09d01e34b4..df17dd4c1e28 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> @@ -1356,8 +1356,10 @@ static struct rtrs_srv *get_or_create_srv(struct rtrs_srv_ctx *ctx,
>  	 * If this request is not the first connection request from the
>  	 * client for this session then fail and return error.
>  	 */
> -	if (!first_conn)
> +	if (!first_conn) {
> +		pr_err("Error: Not the first connection request for this session\n");
>  		return ERR_PTR(-ENXIO);

You really shouldn't be printing based on attacker controlled data..

Jason
