Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7943072A186
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jun 2023 19:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjFIRoO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Jun 2023 13:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjFIRoL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Jun 2023 13:44:11 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55563A95
        for <linux-rdma@vger.kernel.org>; Fri,  9 Jun 2023 10:44:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=klFBzCKiP+1iTVshTUx6vTNuhUI9oPnKOt/kChKfaJkAbMhjQO2elAtKs7WlV40chW5rDg4jA03Vkr9UReshTYyZLe/FZA48j2EP7iQh44qSPQzEqI4a3/UoYFnGmTn5ZttgDUOgYQaknPwkg2hQNsTij4FU+awba25aBYEY4+ForeiGi6NxajfYXgXHiHlyoCPltqjkkVjT0OKRcJNOsXjzrFQJF0EfEF/EQ2LxS9b8en/o5pZkDe0mRGGV2rEQaYaqkP+qKBzqw8hasO/UQX8Fv0XeHx2e8Xxx59fL+GFxyArYzxBcy/ZjfnPgSRgPGwlmyYyoKgo9hz5LyCr5tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8AAmu6Ff3i7q1N0e1lh9gvGzHdYXwasUt6mhKgt49O4=;
 b=NYET/CZ5uhhvxYqgCtJFvtyBfol2XXgNq0iisq+as1839ezbVL/0mEZqmHN3XM3ttZ/3QqgcttgkgPB/yHsLU9P8KFlkqsvQXeGFkxX7p7TwJFOHxTnpsduuqBLCvjmUnC6keX7mxDhgPMtLnmkEQ6xnwilklACvMvCrqrUdpCqlpOHapXBtVKpIRp87U3uSuxeEv20+6H+d7imUlfggYKzBiX9aUGhLp7Wbo0GU0RmuFTaMr5GQU0PK55BCNB0JTDzAz8s9f15LhQ9cSJR+1fkBuLHuZUdq/L9Qfa/MDr+1Um/Z85Skp2xcHtn1bLyT1APttZO+5ovMpOUQb9mfiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AAmu6Ff3i7q1N0e1lh9gvGzHdYXwasUt6mhKgt49O4=;
 b=W/Je/m9zF2VaYWDITRuEArBo02E4AT+yGTSGnrRmqgN7hX8aDIVwesxQUYDAvvTpPuuScEF+VAjox6osYUWInNHvnASdfBeBA7NYCzUYpM017QRcvmRlwEzE+FOtEK/auiIA2LZCWeLUPgsiv7XRy9gRW8Ow39eDVTerJTCaHv/+o5WUYDLqAaaugHAeB9tU1yGswKht6f4I+Fb7YZIG7lIBoAoAyFg2GAV2dy+JlXNhqC53JeKNzrOGSQVC9GzN9jyDjYoaBBHa4CpiFmEV3Kx31k3AJq9v2tOGoa2aQOs3REf4nnRAAz7zTPKt8tveAiG91+ekldjPAcAM0DqxlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 17:44:02 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 17:44:02 +0000
Date:   Fri, 9 Jun 2023 14:44:00 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        Mustafa Ismail <mustafa.ismail@intel.com>
Subject: Re: [PATCH for-next v1] RDMA/irdma: Implement egress VLAN priority
Message-ID: <ZINk4KZamJbk+Ovb@nvidia.com>
References: <20230602230257.1430-1-shiraz.saleem@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602230257.1430-1-shiraz.saleem@intel.com>
X-ClientProxiedBy: CH0PR03CA0108.namprd03.prod.outlook.com
 (2603:10b6:610:cd::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL3PR12MB6425:EE_
X-MS-Office365-Filtering-Correlation-Id: bef0a187-e955-4ca9-71f4-08db69111c8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uBnCmNUNoE2O9jx7gYnO9gowY/k+vHnD/TKgN5OGpovzkfnxezWcP7T85CKOYfTqJ77uFNkDEaesdNGUGGH3puIMa2HaznpH4lqqxZiwMM82ETvSgsaU+FUsJxJANA1bqCS4Nb2GebsVg6/H3e0rAr+d455AHeTiRxhqQCVzyZt7HD4jcTyltZD74+5KYSf+eEMs54S4fK490Lu2gHT7YQoV3HNa1QTPh+9dJUjlmWk9BLEefKe/7YdcsIKl7ILaB/9fa+jnwQYRngDkb9hOygHLKd09WBfiUGOJsZx7A+yl+GLzWUdE1Kv/wnKIBwMF84si8Nt55+HbVWpwRD+yZRBHT0vbeqGjOagLXBr2cRMbWOqs9qUc5rspFpG5PZor07KY5O+lMD7Zmq1C8pgDoVIqZWpKI354hyOkyq23uOGesrXXpXCAeRBONXBYAZAM1xy+gWMO+Ly9dc7Yl+WNDpXs/lls4HACpa3927PRnS6kdJIWxSrdHAcOiRs+5+cZCtx5yG/IjpOfnJscvwvLWGbpn5BDAfZz1QdS4o0wIWdEcff3lM0JdbRtijWjlqsPJvX85zJicGNdKOyNN64OMmtjvWyF3EGc7I5OEwP/EMw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(451199021)(478600001)(8936002)(8676002)(4326008)(66946007)(316002)(66476007)(6916009)(66556008)(41300700001)(38100700002)(186003)(83380400001)(6486002)(6512007)(5660300002)(26005)(6506007)(2616005)(86362001)(2906002)(36756003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y3RwiESmu8D8HB687MZYtr0wJAzYauh9Uhw5JSzU4H1/P9DGirCHqqwOBdTr?=
 =?us-ascii?Q?OFgk8F7PL2ge0+j2QL8WhdOtNUMzkyOR016jdE97ZvYt9AjWMgdnsz2PEQfz?=
 =?us-ascii?Q?Bhe8Wu0HpC95d2jzMd03HeJWe7qD+End000pMvbhvjeQvcHuj3urnzuafADj?=
 =?us-ascii?Q?UnPd63N5kpzEvn26EqnkT3/2l7E7bMaWogKiQ7T0l2WPr/oSZJqinSO4WetN?=
 =?us-ascii?Q?qYahoPSCvdXiok9QQhWRpnkY2huAnwA+89Kx/QnbSPDnTarhmhnzZNJNXbnR?=
 =?us-ascii?Q?5x2fIeBd40tGtuyP7v8FIpgdAAmGyZ8CsEzCBeWSGdZEdkZ/V8JG2o6VQF3m?=
 =?us-ascii?Q?WTfpXrwDW+jq1VzuN4PkqfVIfEgrx+UsYK1VX/gakzXMbhaq/VNDaTvJjH1N?=
 =?us-ascii?Q?iqwURQS+CGAN4VX+tO5H4FzTc3eDObTYBGOl6vxEvLJ3E+nqFTLpLfu8JGTy?=
 =?us-ascii?Q?bJsM+zT/fp/I7Jf+CXG+UjtV+Huwyoe6hVgP/KiscClvrey+sfhDdaBePJ07?=
 =?us-ascii?Q?3uYaDD2baJRnQK15NTUDKncuokeAfw/BSC8r8Iw/teqwzNiV1RLzFviM4qgh?=
 =?us-ascii?Q?XE/dkd90E24YmRwrSsPonoLwQngN75il01F365keHZy77xOO8mwv++GkFn1w?=
 =?us-ascii?Q?MDZ165RIW4mktJC5VlLYxbc04wT43PYVUbrmFQ4FgGLLjCCMFNGN2Tfs3GmA?=
 =?us-ascii?Q?DIi8WQ2CJL6ZXa0bLUQlm1n4rbUTLWWYzJfHtCh4EZ57e/RyfSXmnAcayiUz?=
 =?us-ascii?Q?eitx9TZ1ZWs4iKhJdJIJeVdMLCffEkMi/GHSjU0OFpGX8lfw+0fd+cdmc9s+?=
 =?us-ascii?Q?dEy1/5ST0KnVxrUzhHSEcgB+d/WRqG18f3E/HRQNLHaXM2ZllrLVmyJO7Q/z?=
 =?us-ascii?Q?SNmquRzURiOIqZ9jsne8IO3cr5zoq2tTAwCGSpbCprkpjrfETypL3eYJpc+M?=
 =?us-ascii?Q?CLpZzEPFmjCM4JpUquDlavPIY4Z83x4jQKqCXLs8/wPs9a9KPg3JtUeVgp6I?=
 =?us-ascii?Q?yCjFPXte+JwHsoI7Vze4igUAqrBYLW66AohL2JozzNFd6l83pPWLQAPUHZl1?=
 =?us-ascii?Q?C1qADP/e1d/R9DQw29dwf6FWCZfOSa0ihswLO4Z9Kpk3QOumVkoHDGnIc5pb?=
 =?us-ascii?Q?KxRkADv4Sbpla59wSXEptMkZ1+c0hs5D+x4WyKTtiV6OZMRztZQO9e5q/IlU?=
 =?us-ascii?Q?gE6EYM9Jv/q2yCJhR39hnaAlZJCocMMItjoQCHJlFBYa/7cmo7q2acysQLSd?=
 =?us-ascii?Q?Rvfz4Yn6U2XZlwR3/xBB0gXluthhY3K/K0CLkvhj4WkAlWB56L39qZJ+MqWl?=
 =?us-ascii?Q?vDtVSLAylgVKBh73hWdU3isC6LpXhCu+bSKQYq+PbV3ZGprQqQc1XepMw8ju?=
 =?us-ascii?Q?srCV/fzV+C3292YgVbShmY6i2m6dXfbds4dXD0EwrEXCt53r9qlIgrFJhCHb?=
 =?us-ascii?Q?j9P5hLw7B3Pb4yD7Eb4sboMyvAEZQ3hUZbZXn2VPrmk4LdUWxBD1U3i35V0T?=
 =?us-ascii?Q?ZWQwKF5qY7g2V/OHFAy94hIvuuH8GidnUQUeP/t0AdyAjQeBTD8e1rFIBHzH?=
 =?us-ascii?Q?M/n7z7N4IuYvBF6DTnxGKkjQSEuRDgp2cRZ7G5w1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bef0a187-e955-4ca9-71f4-08db69111c8c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 17:44:01.8642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /gwUcczVO8IPqKt0W02ruOZ7ExiriR/KvA4ztpbGB5GWjoj4I6tE5Mt4o6HirJgD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6425
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 02, 2023 at 06:02:57PM -0500, Shiraz Saleem wrote:
> From: Mustafa Ismail <mustafa.ismail@intel.com>
> 
> When a VLAN interface is in use, get and use the VLAN
> egress mapping.
> 
> Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
> v0-->v1:
> Use rcu_dereference on GID attribute __rcu pointer
> vs the function arg in irdma_roce_get_vlan_prio
> 
>  drivers/infiniband/hw/irdma/cm.c    | 50 +++++++++++++++++++++++++++++++++++--
>  drivers/infiniband/hw/irdma/verbs.c | 45 ++++++++++++++++++++++++++-------
>  2 files changed, 84 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/irdma/cm.c b/drivers/infiniband/hw/irdma/cm.c
> index 70009b9..926823f 100644
> --- a/drivers/infiniband/hw/irdma/cm.c
> +++ b/drivers/infiniband/hw/irdma/cm.c
> @@ -1555,6 +1555,26 @@ static int irdma_del_multiple_qhash(struct irdma_device *iwdev,
>  	return ret;
>  }
>  
> +static u8 irdma_iw_get_vlan_prio(u32 *loc_addr, u8 prio, bool ipv4)
> +{
> +	struct net_device *ndev;
> +
> +	if (ipv4)
> +		ndev = ip_dev_find(&init_net, htonl(loc_addr[0]));
> +	else
> +		ndev = irdma_netdev_vlan_ipv6(loc_addr, NULL, NULL);
> +
> +	if (!ndev)
> +		return prio;
> +	if (is_vlan_dev(ndev))
> +		prio = (vlan_dev_get_egress_qos_mask(ndev, prio) & VLAN_PRIO_MASK)
> +			>> VLAN_PRIO_SHIFT;
> +	if (ipv4)
> +		dev_put(ndev);

Huuuuh??

struct net_device *irdma_netdev_vlan_ipv6(u32 *addr, u16 *vlan_id, u8 *mac)
{
	struct net_device *ip_dev = NULL;
	struct in6_addr laddr6;

	if (!IS_ENABLED(CONFIG_IPV6))
		return NULL;

	irdma_copy_ip_htonl(laddr6.in6_u.u6_addr32, addr);
	if (vlan_id)
		*vlan_id = 0xFFFF;	/* Match rdma_vlan_dev_vlan_id() */
	if (mac)
		eth_zero_addr(mac);

	rcu_read_lock();
	for_each_netdev_rcu (&init_net, ip_dev) {
		if (ipv6_chk_addr(&init_net, &laddr6, ip_dev, 1)) {
			if (vlan_id)
				*vlan_id = rdma_vlan_dev_vlan_id(ip_dev);
			if (ip_dev->dev_addr && mac)
				ether_addr_copy(mac, ip_dev->dev_addr);
			break;
		}
	}
	rcu_read_unlock();

	return ip_dev;

You can't take ip_dev out of the rcu

Jason
