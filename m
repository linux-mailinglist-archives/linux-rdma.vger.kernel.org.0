Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F25346948
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Mar 2021 20:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhCWTqi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Mar 2021 15:46:38 -0400
Received: from mail-dm6nam08on2049.outbound.protection.outlook.com ([40.107.102.49]:51969
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230406AbhCWTqN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Mar 2021 15:46:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WnOx4N0NT5Hxldaf474ok7/ldWFzIebjqRJtKBsz1lIqiiX9X1NL6tLdwpYb7T4P7zk7gRZiFKlDX6g9KxRUP+mGXWIBGbFUN9CD3xUkAS5nTTEZ9NYmJYh90qpz8FW0DIm0mVG8U+b7bTM4CM+x6yEYzqw0dsawvNktNEK0TIVhqdRNPjkTGJpt8Cbuhg0zVTakSyAqi1CQfk0mNimV3v0LzBMNrXg6kTPXvhYK+T+mynfAcoHlTvqz9RupGlEH21Kv89FKVtPTfccJOE2bAPiGXUuR9sMqg5MhZgSYKiWoaHBe5q1ArVtht8nstAeagtNPfZQ2q/acxI2+Zje5lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FX2W04QWxud2NhheuIl9QBqR5ctiP6b4oqygrrfHuMo=;
 b=R9mWygf7MbiDmzEnf6+OXQJOC09q7szIBC+EWhuPWQX8q+4gjoU1NgVP0O6LCJCWjP4LNauXgdASr80eYt+JewqoTrGqOSr+cM/6qeQCcZNunsTmubJSiJjEkGw767R0Psa1KGDOPSE4vBwat7eO2tteLFGLsqoV4KIFQvxE+8JfaiAIZ1CggW1im/DgA8P863O3/I6BMA2QGYClCKWl8EevHWnfi4CNRyNqquBncMqgebUvgxG5lC8yybtRjX5GmmTBWW82U1lKcvthaHjIEEULkS2lS6OKtF/NHYdoDgxcFI1aaLpR++LKFoujfs/r4EeI4HW5lUhTzBEk4zJgxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FX2W04QWxud2NhheuIl9QBqR5ctiP6b4oqygrrfHuMo=;
 b=uk5UyFi/PzGLZmMmJZH06LSZf9sI+0Qj5K5wI9DZwGFZxo6VkYmv9FsaQbr74M9mTIacvzUnL+pDWP5x+c52WH5U5aE76AXD47F3gUYvNBpyPUJI7mnB0v0Nq3iMEYSuaGBd/m4FvNEBx1TEUalgRX/jOzNVRah59Ci8Azm/a1SnbaZEEIdTai/Fsv6pduNG+qO0R/coV7e6r0+Ft1IkuLkQgZ27B4Gv8fsFE9lajsdas1iVqO0VQTqfvwy3X3djq0572M7yobc18hICy/j78zLv3bGi1wjZ0SN8t10LcMZuBujxBBW3XdSSf89pP4EkkObjFVbWBv468oTqOL+w7w==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 19:46:09 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 19:46:09 +0000
Date:   Tue, 23 Mar 2021 16:46:08 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc] RDMA/core: Fix corrupted SL on passive side
Message-ID: <20210323194608.GO2356281@nvidia.com>
References: <1616420132-31005-1-git-send-email-haakon.bugge@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1616420132-31005-1-git-send-email-haakon.bugge@oracle.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: BL0PR02CA0143.namprd02.prod.outlook.com
 (2603:10b6:208:35::48) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by BL0PR02CA0143.namprd02.prod.outlook.com (2603:10b6:208:35::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Tue, 23 Mar 2021 19:46:09 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lOmye-001fPT-2A; Tue, 23 Mar 2021 16:46:08 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92ed20ca-86b2-430b-fc7a-08d8ee344e8a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1753:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1753D6AFB5E7F96E39C3E30AC2649@DM5PR12MB1753.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L6lEjhItPfaDbrz5B2KvTh6ilykNrAlKJheiRtZ32euvLL+qbNgA8Ap3J7/zb9PhBHrefTcPdChxCz1pAUyhdPj9kqYWi17Vx2N1WbpIIKr+pKbWM6mMOmxuOdkEBNpr1ZFtaqpL5t2FaPSy9yPOmyZbLrbSy7z0sd5gUB5bmgDLQo34rfTJJsj2n46iJA62X+VASjLZRHPyF/kbMDdeE2EegFmL5Z1VxMPdL18CtrpdJ+DT11PrJQWEpraM3E6W2++sKBGDY7DSlrmIflgm+N5S4bXhwxmQHBDQAxLfbWcrDrK4TrOkeavWi8PlnB1wL+Bv8mZ2yrf6wACGMvoZJVftpCz/25QlitR11KSC2k62HI83dWtJHsmyIE0yGhZZX2jk8l/N98434LlpPPPLQcfCAZvvmQeWgMZvI8F0bCfHRW//j54IdmzYUxqImIw5uijki5X2VYL2XKIf/iopS0W6V/8FYiwPBaHsZOJT21lelX/XmaGtMytd55RVrjpVgjS7AAReO6wLOpVKI/J8zVp3qqFB4Y0HFMyus3n/hj/ivUUB6eNV4GsjyA8cBEz4K0UcYDW+sMX64mSz+t+MlquxRy1lzv6lrExAvIea9OX29eyneM8ydDuLcmWMzOHCZYiaZ0y19VJ8wmgkKTy9smAzScx2mmY0SxLbg4rsKjk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(346002)(39860400002)(396003)(426003)(8676002)(5660300002)(2616005)(8936002)(33656002)(1076003)(66574015)(83380400001)(9746002)(66946007)(9786002)(38100700001)(2906002)(36756003)(66476007)(66556008)(4326008)(6916009)(478600001)(86362001)(26005)(186003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?akdPdU5qNjVPUi8ra2FndnFBNUo2ekdhZ296aFczYU8rOHIyaElaOU5nK2pF?=
 =?utf-8?B?TW02OCtJVHB2MVd2azFFZnNwRVBDSkdJTEI3QVlsZVQvTEtYNUwzaXVwbWRC?=
 =?utf-8?B?T0lENUJSdTRPWER6bkM1dlBiTzV6cUFINzQ3SWZhWDZDT2oyVzFobk4yRld5?=
 =?utf-8?B?dVV4NnZ4TklCQ1dpOXJIQ29VTnR2bUhEVkMrV2Y3TW9DK05lVDA4dWlkWkZH?=
 =?utf-8?B?OFZtdVRENzdiZTJ4VkdQaVQ2eWo3LzAwbERzT0lLR2RMdjVxZkMvMUlUYTJZ?=
 =?utf-8?B?UDJueWV2dWJGbm9MYjRUWXh3cnR0VFNTVXVMdlFCRGd1RTVRaHQwcWwyd0ow?=
 =?utf-8?B?NzFHWWpvZUNoejVOa1ZoblpXVllnVDQvUHEzWlNXZXRKeVFyTlpxcW9saGc1?=
 =?utf-8?B?SlBwVHR2UUFkOVVoRUlzS0JCU1ZuOVcwNmFpczdnRzl1REt6TDh2dHcvQjB5?=
 =?utf-8?B?YnIxN0g5R1BtUG9TWXByaFZXM1FUdHNJazNhNzNwSG5UQWJWSHdCT2pnU0RH?=
 =?utf-8?B?TXhaVVBzWkhiT3dkbVJtL0xUWndjZ1ovOGxsSzlmZys3RG16Qmcwenora1pT?=
 =?utf-8?B?LzdVUVhadklVaVp2ZnNEUHZEcit1ZEpqWFZjZXhxK0J1V2RGd3IxS0pXNmtI?=
 =?utf-8?B?amlSdVliZHIzcUZYd2hHamlySW95K0pBNHNnWkdnZStrNjRabldVd2VPRHUw?=
 =?utf-8?B?aGU1S2dFUTF0MUNYMWZndVo1ZUVzZkJGdGNCcDRiSExuYlMwcnBIV1BiY2o2?=
 =?utf-8?B?Zmp5ZlNRWjNZdGsrb29YSGtYY0t0SjBxcDhsR3JVSUQzSmZLemJYMkhiZUhY?=
 =?utf-8?B?UnMxVFFhcDNPT2cxelhhVVRaMk5oeFNXMzRDMUticEd6aG1jOTkxV2h1RGlM?=
 =?utf-8?B?K0FPcmJIU2Uwa2ZObENIWU5LQ04wM3lLN1Z0UnhuTDNwOU5yRWJLODd1Q3lr?=
 =?utf-8?B?MmFKVndYWDlhNXJ0bTFqaWtSVDZGdTdYNWcxcHpmRDJxblorUElHU092dlhp?=
 =?utf-8?B?aGc0bkJpUk9uOHhKL3BNdlBmam1RdUZJbUlvY1FMczJWOUxnS3RKRVpXSWtR?=
 =?utf-8?B?NFNoSjlvM1V0aHdWTWxoc1FMc2lvNGdVc3c5Znc3WWpNR0ovMGJkWEJnNDNw?=
 =?utf-8?B?em8rSEIvanA5MW5MaXIzb1Q3ZEc1SmJxUlM0ckdWenhqRFVNK2xpTTFyRVJi?=
 =?utf-8?B?c0F4S0c5NW81bGFjRlhYMVB6YlNrdXhzYnMySDd5eWpSNjBwTWNtTVJHcVZ0?=
 =?utf-8?B?SjdBeld4KzNYMysyMmRseXlCaVg1V0RNZUxsQUExUWJIR3hwbmlZcDV6TXNT?=
 =?utf-8?B?UHd5TU53WmdjSmloSmpoWFp0QjVxdEpEdHhLa2tFdXYvZVlkMHgxTzEraVEy?=
 =?utf-8?B?am4xcWlEczczbUNYdi9RdEg3dlFiR29PRjdyaFVmSjN6TkNQU0tkRUN3bjRo?=
 =?utf-8?B?U0k5MlFlVFRXeXVzdm1JZDFYRTJSMC8rYWpPYzVQeU1vWWdZbFBmSnFWUnJZ?=
 =?utf-8?B?N25lanJ2YVZmaEpmMUpXYTYrV1RqZlJCb25iNFZ0eHUyV1FwKzczZlJ0SThG?=
 =?utf-8?B?Q1lHMkZkR2ZYaDA1bk1ycEptUXlaYmRrYkRZM2E0Z2FXUFY1dGxucGk3dHg2?=
 =?utf-8?B?cURuUWswQXdyNFJBazFNQjh6R3ZlQndyYS9QWjViSGtiUUtsQ1oyNHpOWU15?=
 =?utf-8?B?STMwZnBLRFA5eHJMbmhLclhCUGx0OUNxNVJRNTBKb29VSjNjeWhqSXgvTE5s?=
 =?utf-8?Q?Y3kQ6QTAo7U+jR02GfLoqPGOqkugtIHSyQ6nD7E?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ed20ca-86b2-430b-fc7a-08d8ee344e8a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 19:46:09.8295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cwahPKoUishCLO8764ETE2IBkrB65SalQnpa2Ibz/R2MVRxP8HjeI2UF6qS3vHCJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1753
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 22, 2021 at 02:35:32PM +0100, Håkon Bugge wrote:
> On RoCE systems, a CM REQ contains a Primary Hop Limit > 1 and Primary
> Subnet Local is zero.
> 
> In cm_req_handler(), the cm_process_routed_req() function is
> called. Since the Primary Subnet Local value is zero in the request,
> and since this is RoCE (Primary Local LID is permissive), the
> following statement will be executed:
> 
>       IBA_SET(CM_REQ_PRIMARY_SL, req_msg, wc->sl);
> 
> This corrupts SL in req_msg if it was different from zero. In other
> words, a request to setup a connection using an SL != zero, will not
> be honored, and a connection using SL zero will be created instead.
> 
> Fixed by not calling cm_process_routed_req() on RoCE systems.
> 
> Fixes: 3971c9f6dbf2 ("IB/cm: Add interim support for routed paths")
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
>  drivers/infiniband/core/cm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
> index 3d194bb..6adbaea 100644
> +++ b/drivers/infiniband/core/cm.c
> @@ -2138,7 +2138,8 @@ static int cm_req_handler(struct cm_work *work)
>  		goto destroy;
>  	}
>  
> -	cm_process_routed_req(req_msg, work->mad_recv_wc->wc);
> +	if (cm_id_priv->av.ah_attr.type != RDMA_AH_ATTR_TYPE_ROCE)
> +		cm_process_routed_req(req_msg, work->mad_recv_wc->wc);

why use ah_attr.type when a few lines below we have:

	if (gid_attr &&
	    rdma_protocol_roce(work->port->cm_dev->ib_device,
			       work->port->port_num)) {

?

I suspect you can just move this into the else?

Jason
