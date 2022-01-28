Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01F4A49FE64
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jan 2022 17:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350327AbiA1Qvx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jan 2022 11:51:53 -0500
Received: from mail-mw2nam10on2050.outbound.protection.outlook.com ([40.107.94.50]:52010
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350305AbiA1Qv3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 Jan 2022 11:51:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z46U+2Xa4xOGRY4WcfmJirN6oZYn7qujdt0fhg+f64FiMwizYBEunAhjEXeeK/Frl1ELqXouYg0TKWmsdMsRSoX08l9Qyg2hYEZiCpNY/a8qZKOzpGmi55pgZoIxGidte5fjyRIUOL0FpTeqFr64LSy37FXGa/5gcGfXLqJeek55r7Bo+Y4nmUlWiU0XCoXYAQfcLE9EHZ7MvhuNzwdi/KXdPdXwNxSuqe7JrqXgEtsOmH3JVIDpTy7q7jGWcTVhIbFOtWk9hbZ8ZaCAgAiTL9/bwQrVyLpuKfLZG9BXDXWTY6UVGf1SVb18vkWHIKtA55t3BqZFh9utxa5eLHys+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rt24FalLgQjDMkHCSSLsRRv/0mLnle9ncAOJc1WBc+Y=;
 b=Wl8k/r6W4XKCPmIXUKrm6IGYaMoGliGQViwNUUNG9O340hMQe3oVkLDbmUt++4HOdkxemHhdnx+ubOVBKtGr/9zrKzcqVSNwp3fmapBTwCpnk2J03tgfRVy2V+3s9bO00F0PA/57Y5oNBxhjCsR27LAuyVAnUUPiwl7mPt/lrgtWjLzuG8euvsEd4KalSVMN6kJvXGY8Tkt47gPxQOzZ9gstrnfsO6NUp1qy9m1jUo6ukSRxh2W6yhudDdNFo5QhZx0I3xvzToh2d8bZIULxWaS8XbyJ1QfsCyqZnGzdT0KHfPk9AcNnW11DAdb8z17Y5EkVwAWGgQDfU4dHOZXIJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rt24FalLgQjDMkHCSSLsRRv/0mLnle9ncAOJc1WBc+Y=;
 b=Sda5xiKO4oyZgSqUFy26gngKFQWYuvXWW7UECRrr68Y+NP04sOZhF+SEmp6Bcl2+VaZNwvWubiO9ekG8sZIsyaaCW4ptSF+wLXJAsVJVK/rG2A/xnuCh8IrbVHxLuD2nx8MitFmNmEvscJ7sx12OEz/BlFnc60EOBOo+IfJrQf52o0USNuHzb5iJfaS/jykNiGJpAMm9ckVXFy3FLddzVT8nIps6g/p3Ri3oGrNKD1nqsWmRlAov3AEzqueQ9ZuI9hDxOqYbMsglIPz47sDmKrqf9DkyspaB/mmoe3K11duKizsbL4N8VAvqr020+suybvLxx6Zkf/5xSckdOStwpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BY5PR12MB3857.namprd12.prod.outlook.com (2603:10b6:a03:196::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 16:51:25 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4930.020; Fri, 28 Jan 2022
 16:51:25 +0000
Date:   Fri, 28 Jan 2022 12:51:24 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Mark Zhang <markzhang@nvidia.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] IB/cm: Release previously acquired reference
 counter in the cm_id_priv
Message-ID: <20220128165124.GA1870180@nvidia.com>
References: <7615f23bbb5c5b66d03f6fa13e1c99d51dae6916.1642581448.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7615f23bbb5c5b66d03f6fa13e1c99d51dae6916.1642581448.git.leonro@nvidia.com>
X-ClientProxiedBy: MN2PR22CA0020.namprd22.prod.outlook.com
 (2603:10b6:208:238::25) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c080350f-968c-4794-bb53-08d9e27e6c07
X-MS-TrafficTypeDiagnostic: BY5PR12MB3857:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3857C1890580B2C7FD81443CC2229@BY5PR12MB3857.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AFzAyOWPih4A0OS3Xkv5AU2gcjoqtgQXPHGWu2ctllTr/ib5LmT/nvWdxp713sP3sd48hT+NPTz3qeVTe7g8XEf+M4/jyRDt/VEYlUp8WXvm5JnYiq6nNezJuC68Qa92Vt3I0pF5MXX1WXr6CCltglrERvGwxoxwri64DP4e6eemw8bW8jaZE0bOsoV2SCWBu7pjvaAf/Y+xxugU4Beslu4t2TCFl1S8TEJn5NkByTBrb20i2cKBxuRr1YoP9h7H/+PspQJrcSQvAvVG5JheVgq+4sthJhAa1vev8GIXqXCK8/f2w3S/hqFaL9lPpmMEeoAQnSPgDBG/vkZlZncxLrvBCF4OYHL8UqmFKdOO8ImnOtxyKxiBE4uCYbJqAEweSnAb9/WHyUhWU3Hd4J+L9/k0UMsTwKJjHMxKfRySc3qJTKshqmGoQyYT1VHEIonsbgQM8sBB78vuL7blb9nvI5PB3rR8y2az+a5D9K0O3iAnvctbDdUMt8Pkb8WiE3r5Zj4POxc1YnMKjnVwC3O+kbod8oHnvWXX6ojzES0G6BH1EiUHObgXkHe+5Xd+VjpdleeFgSbJlqDfM9Tf2z/cUb1Mk6sugzaUABfDGuTKrO4XQ3mppTIw7hwU5qrK4pXtti7rIDcuoVJymoQln3Coig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(33656002)(508600001)(4744005)(54906003)(26005)(316002)(38100700002)(6916009)(6486002)(2906002)(86362001)(186003)(1076003)(66946007)(66476007)(66556008)(83380400001)(2616005)(4326008)(8676002)(8936002)(36756003)(6512007)(6506007)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xTw1c95e2qY2NHi7GB7ciVLSvFShyCE0QRUWdiTO/9mj+m8fmAEvKSMph+Ck?=
 =?us-ascii?Q?U6HSZtF3FyFYscvbVIJA8PVZXdSDeQIO0+CWgpo8Z2IbPK03xFo5kxZp/TpP?=
 =?us-ascii?Q?liR/qEKjqchXBtnbXSPSK/oNeF1xhz9iyx0vnkHAsPW/e24xmCxhFEaOjZzF?=
 =?us-ascii?Q?aZnGchW/yfzrCKyn7SGlchgN1uFlvKjGp4HUYxM0g3nLjBn1imOGUknZCSnN?=
 =?us-ascii?Q?jU7dBFDkBxsHvTsd1hHaG/QZXw7QACjGQaiC/HuDJQ1tTI4kDqxQcowpZz8T?=
 =?us-ascii?Q?dD+KSiS+gUg0fpMz4oTU7r2/yFhbg/uG87Dct7iFeNLsU7sP1F7BJMMOKm2K?=
 =?us-ascii?Q?dKoSYbIQ1poRG3DxFGNtZlpdx/BymJIeRApQ5dliEaIsehLd20MEA/fAqutr?=
 =?us-ascii?Q?CSZYsp5/qYy+UpmQia5DWnFtLmFO71oPVjzKL68wfiocAQuqiLdn7JzUYuYZ?=
 =?us-ascii?Q?GQiJJX/J8Wqk8kxa3ZU2ktKWaP8sqj6CG/RMczgUaQ4lkrzYuqTkXAgz/Hzu?=
 =?us-ascii?Q?OVEFOs23a6utKwEF4k0/Wjh4wBTtgO5hdhCOahoZpnIubhx6GbvGuoLIaR4L?=
 =?us-ascii?Q?nG/NxIZo8iN1D6P5WCxMpyx6NGIWU9s+2u1ZwZ9XmqtbJ3N2Yu6pfNaCA0qU?=
 =?us-ascii?Q?8UooU12RGsN11oCX0upzbSEl5HrpucouHIC4bN8BnJIShU5nHjl78Aeg8EQs?=
 =?us-ascii?Q?jIlSlgtR/DJr0wLDl9Lp2hyIo6vMVFtJUtnkFwtyQ2ySrVJtmUt/JlJ9vwfK?=
 =?us-ascii?Q?OvkXjkM8gE0JbQWZyFW8aFhxfXFae4MpCZOkvW/gregqZExFq5wm+TWSF2oY?=
 =?us-ascii?Q?FCrC7KNOVPNwPeFcZ9rEeT8KxDhwD8iK2i5xeuJGyX9W0ii+OC1/A0HgLwqf?=
 =?us-ascii?Q?tTmWx/47wbQBmzhTqcrK+igefy7j+oIEFrzY1UeYG5/vhsFxQUP5u5G9zJwJ?=
 =?us-ascii?Q?D6YVItuu4r33Bzpq+MU1BsJX28a9QCvs+lLLMQq1oDilQ6QE4Mblgb/sQoHJ?=
 =?us-ascii?Q?n7u5plfAq+rodJsrHld8zIDWT3j0UWfPx1ItsEim9pN1xma3x5uRqlhNjZIj?=
 =?us-ascii?Q?VbRk3suKm1inxzXk2Vew27RTcaIVSGXV96//yyGb1GbPsrqa+QqcVAjKjJXw?=
 =?us-ascii?Q?zZNsohr0NPsZ0kVudUSbH3YmEq5ebaw1YsdCdDxJ7HQNw4vmS+EJWjT9uLDp?=
 =?us-ascii?Q?P41ji3+mHbXqvRan4Q4XK3PfyTdi3FdqcHmW5Hp9c4mRcQvhRyMe3DeiVi5y?=
 =?us-ascii?Q?KhCMko12x8/nygAMYj8zrP5Y7FWtKbwg4yCXgawYL2ROxEkhny7ucQJ+R2w3?=
 =?us-ascii?Q?nmnICsGfDTLCCAgWf3R5GyuOs8GyGRKDz98T+GqxrlX/0F0GLaO5T6a7nXUk?=
 =?us-ascii?Q?QEdCsYt/PpM1TNTLFME1EGMa7cdCydEmiIxyG3HZ86dNpbzq7VPe19TfSCC6?=
 =?us-ascii?Q?sz2SDOna+1OubLv9iOpmUM0zbQSM7OMZRy/a0sB2BhN0bi4o4q/nrbxhXwo/?=
 =?us-ascii?Q?F1CaF8sEtk3hC+MgHQbMwMZckcLvlpIQOKO/ArapSnJlcqRk035uaqCns04f?=
 =?us-ascii?Q?S10Da9gLEvHpgV+LoJg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c080350f-968c-4794-bb53-08d9e27e6c07
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 16:51:25.7413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jJW9TrsvrwdDbkeSmzi/ebivbqLx//9dBDS+cAh+7GsevCABlO57F20XH1vC0igA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3857
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 19, 2022 at 10:37:55AM +0200, Leon Romanovsky wrote:
> From: Mark Zhang <markzhang@nvidia.com>
> 
> In failure flow, the reference counter acquired was not released,
> and the following error was reported:
> 
>   drivers/infiniband/core/cm.c:3373 cm_lap_handler() warn: inconsistent
> 			refcounting 'cm_id_priv->refcount.refs.counter':
> 
> Fixes: 7345201c3963 ("IB/cm: Improve the calling of cm_init_av_for_lap and cm_init_av_by_path")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Mark Zhang <markzhang@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/cm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
