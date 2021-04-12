Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C1835D003
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Apr 2021 20:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240709AbhDLSJ0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Apr 2021 14:09:26 -0400
Received: from mail-dm6nam12on2089.outbound.protection.outlook.com ([40.107.243.89]:54272
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238523AbhDLSJZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Apr 2021 14:09:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YiQ5jEUXENZW6YWk9QFEJYipEjKn1dUwOSdVr8IeRH7Ggqo504T5dz9W6tcMMRTQZ5i4xBdSRWEiXszrCMSJLghhT9+c4hQTIx/QT546X/fu/42LjxWWHTs2B7LYUdmFHjhaQPWz4mRH0WuYzWRALWVw6heZ9N1y1OxbtAfJFaV+hqsjPX/A2S6I1YdZtWU87ZVUQ0xHKCKXxcV9TW9arKah0KrgIJgd8ymSGDtskkbFGXJue64xmE0n+Jlsb1qNegqVsviFsE8d7f6CuNxSNn0iSfdXEgFoHS9DiemA9klcBvQYKiyNs4TGg05XY45U7rNsZ3sCHdgUi5vsNDvklQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUsIQXGmskB3PS0haOK35JaTb28h/h9cSB3LcXgMk4c=;
 b=AUFMtSPvKz/bzZwGwHHNpP1+VMHToIXioTVePxndYPgZN5Hp6UZ3HuGPb+1swyRNwWcZgpz9NYdX3LDMog8W1M+zqCgI17kzth6zy3i8jeoQJBAnxtTvNGv65WDr7N7xL80hXHzk3sNXdtMb05hOesMxxKRLw4i6xW6SuF96qWnlzerG+QuzlpkR620zdiDHO0Mb4LHQtDAs8mtTVfLTGRUYJN/y6DPeMuZi+YXpOXP6Uar7mn5SYORB1sVcBklW/3T5u2EQEujqYBd1Uscr/0I5piQFwZ1MGZ59xeoGWrkQbmjQOIQXh89SAHMenG2hST8C2igeaBtluRo7vF1Zqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUsIQXGmskB3PS0haOK35JaTb28h/h9cSB3LcXgMk4c=;
 b=DpSYOQ48ydu2P0ycoEqZBU6Rh9cMAVMWkL7eSrHVIKrmbUvoQg5F6NE5lUM+2HGAWcHS6Ne5eR8KCuFVEFa6UqhWgogW7Mv5q286qxPGguKhwr8ol7kNE+BdF1qOHgWJMb69ZrLzkvgTj8YXAeYKkjM0D1bXtC985KRyyT4GH8p/Ee8A/EYZYE9qYJhJOZouYFHIPHjx6D4s4Ptc4q+dgrhzkRETBYwUzzWpyr1wiHWlGAvblc1Jnz6WLcAGJ6EM7+B7XLNXLBOJDYu6RaWhjU+slBq/xFt5u8oOyfXjz185j/WVJECKROU4osbBmA513OdQ531yg8PsK6BbvOcQmw==
Authentication-Results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0201.namprd12.prod.outlook.com (2603:10b6:4:5b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Mon, 12 Apr
 2021 18:09:06 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 18:09:06 +0000
Date:   Mon, 12 Apr 2021 15:09:04 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Wang Wensheng <wangwensheng4@huawei.com>, dledford@redhat.com,
        linux-rdma@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, rui.xiang@huawei.com
Subject: Re: [PATCH -next] RDMA/srpt: Fix error return code in
 srpt_cm_req_recv()
Message-ID: <20210412180904.GA1152997@nvidia.com>
References: <20210408113132.87250-1-wangwensheng4@huawei.com>
 <241d391f-2f18-18e5-9e3f-3cf214a30b38@acm.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <241d391f-2f18-18e5-9e3f-3cf214a30b38@acm.org>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BLAPR03CA0047.namprd03.prod.outlook.com
 (2603:10b6:208:32d::22) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BLAPR03CA0047.namprd03.prod.outlook.com (2603:10b6:208:32d::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Mon, 12 Apr 2021 18:09:05 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lW0zg-004q1J-6u; Mon, 12 Apr 2021 15:09:04 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 618fe2f9-073f-44b2-e6f8-08d8fdde0f67
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0201:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02018705AD3119F85FE79808C2709@DM5PR1201MB0201.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0gMm640EE0IM8WGg/2klZE3HnCmWamRzE/8y7/bvxZ2GcS7leK3bqAzydirrQM1L1ZSeOg3n1nINIEx6owi/nHaGW8q+zAve3Ym3jhww/IAwsZrg8ZJI18zUVGCV9uvZDHefZu3ujTMfzclyyUgTQqJ6n05YtlSVuSeHhg7wktTFlRGoc4i36FI2KGfMhO2JOXDwear1DCZlkF5AGRIxXjUmTGpjjQZuW/VQBMX9NcBTmuBNGgw531ecU9FbZ5bykIrSe/oSN1g2Mg1uYkfTCpHXs9E5k+o57uIs0opXb3joNrJhpwDQ8l6yhKKT71BrtIKOz+FW9JhFDdWWWueB08zNN44pkIyHWdEhPOIFLwyiKjn2SbyiMQBelCNuC8G/S906Q641X0sI8mflRLaRL3rVYhryGpOTw6hLDdpYf98Ok+xkiHaB01NqS7eYy7qz1V8Qu3wmNfTYFxYh+s9yJITQTjfnIJLiX64C2disymHqR3SQC6kLN/5oW1Nz2s2AtjBzlA0ahxyzzd0ou29uNbIGVg8L5uhXfidBAIRku/E5MHU4NwBIKHZpXUq68GN6R33fZpCOLq2FImsxt8IXquN9zpCk+LDCvZsuDLjNMCI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(33656002)(36756003)(4326008)(8676002)(5660300002)(6916009)(86362001)(2906002)(426003)(53546011)(9746002)(2616005)(8936002)(38100700002)(66556008)(478600001)(83380400001)(186003)(26005)(66946007)(66476007)(1076003)(316002)(9786002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?dqLfsrLhumPCBlH93eKj1jW7ByQ32eAApATJ/P9fmsvgwPkHEM4eaPCnW6nD?=
 =?us-ascii?Q?bPXoL60hRlhklWuqQAFIgRxTWP/d5VH//lUqDJF0wUBdgkhTgR4b9ZxXR2J+?=
 =?us-ascii?Q?8WKtx6acxhHNAH0NFTEpD8w/NGkaYuVsOX8bdWUbJxy6xzKgwlThYRu9nVMK?=
 =?us-ascii?Q?mb4NA2AEc9Ae868MIDNL2c/4seTJ/j5Rnp4uyfrQPeUZOlcxtU7OKi/yq77D?=
 =?us-ascii?Q?j8rQ9Z9fuIs1ynVWFlVp+C7ZnwItq9zxpjkdJekvvhxC5Cd2Ml1JFgjPFp9I?=
 =?us-ascii?Q?MDpi20UU1gPY5EeKMvwOxkGyu8KY2vS+yggGaObUztXJ2wfWPdDdb5WmSz14?=
 =?us-ascii?Q?yjEplT2MsdKo2gBcj9l4mmgmiFgh5seCt8/tUHDXEGVjYM9T6ryoC8ldRnam?=
 =?us-ascii?Q?N77DI/ld2anI8/eWWJDNAywLR87DtYKQpnl1HGRVGmuijP3CQMB9pHtZeWhn?=
 =?us-ascii?Q?VzJYFie3WF+87aAOaMfaNV7cUCMf5ssb7jwkVRjrUV0gRjP7Wnpa2DcSN1sG?=
 =?us-ascii?Q?IYvF+evTnoLlGzqVxXyjVQSjXepBnXa7iy0B3T4IdTQxMkldquq33efRc4FM?=
 =?us-ascii?Q?+f62LmDWPtm8CmHj5ghPc6GwK3mgk+nOk9SEaVkIUHTcDNWPl1I60ZJ6+9rq?=
 =?us-ascii?Q?TXQSmjS3wPBkk1DflZ5TJHePYjoSIJ/5/pkRPdEGL0FFXh6wIWdWsy8v1gFL?=
 =?us-ascii?Q?WJnPGno9P2SEA3kMIqPMGtdNw+FquYGAKqBklHl3brguIgaTXgx5V6VOxj3U?=
 =?us-ascii?Q?/7hwN8wPUehb+aTPjEK/U/SusdtnO/W05JZrOpOzxj2LH2vn+kmGWP+5LGfM?=
 =?us-ascii?Q?3Dm4yuck3KXx4OLvlgUOMv1FCgDf1yLrjPWffA7P0PGztswBT0Q2IefGzd8w?=
 =?us-ascii?Q?N6NFGhGRD7vVU9V1rNDaDpKHCixtEjmjFSSI9uuF4U83+mrPj0LLVdX8KZCy?=
 =?us-ascii?Q?JiXBEbcHN3L981MXMyRaES7ElhuwtIqWh+56f/1/XH7hOlCafh86DHj6cWub?=
 =?us-ascii?Q?yD2TZm+2z56Qpqlkt7vt/yykkklZE4k/M76LIgxmaf6q2EE6xz819GsVZvxQ?=
 =?us-ascii?Q?1fy2vGebBRxUb0n6NCFb7M77s9CUfb4PBjRgrIo5Q2YDuPM/XbkRJHnh+y7z?=
 =?us-ascii?Q?0GLsePKj0hpn65Eb3Zxwk3loTaq0GhF3h4Sf7j3dUfj/4KRJFxYdjB23SRj8?=
 =?us-ascii?Q?nmT1TxBPqSx2kSlTILanrbHE/pGwJ8j+hMoGo0fSF0TC2YRbSSntZqdNZU1w?=
 =?us-ascii?Q?DOKU6/t/Hh1z1KuPW+qctPUnIZMeGSTl/BMwRbMx5kJ0bHNQLbzDcUgrbuO4?=
 =?us-ascii?Q?V1q+hJ52wGQrs9h6K0kT//LWjxl5rE/e/TwV+rk27Ew2JA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 618fe2f9-073f-44b2-e6f8-08d8fdde0f67
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 18:09:06.0287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E4XElE9RkW2IlVoRC3zcotgoYz43OEv9eD37EsM3QfEyti9t+RZHi3n3lNx8Mx/i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0201
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 08, 2021 at 09:50:30AM -0700, Bart Van Assche wrote:
> On 4/8/21 4:31 AM, Wang Wensheng wrote:
> > Fix to return a negative error code from the error handling
> > case instead of 0, as done elsewhere in this function.
> > 
> > Fixes: db7683d7deb2 ("IB/srpt: Fix login-related race conditions")
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
> >  drivers/infiniband/ulp/srpt/ib_srpt.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
> > index 98a393d..ea44780 100644
> > +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> > @@ -2382,6 +2382,7 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
> >  		pr_info("rejected SRP_LOGIN_REQ because target %s_%d is not enabled\n",
> >  			dev_name(&sdev->device->dev), port_num);
> >  		mutex_unlock(&sport->mutex);
> > +		ret = -EINVAL;
> >  		goto reject;
> >  	}
> 
> Please fix the Hulk Robot. The following code occurs three lines above
> the modified code:
> 
> 	ret = -EINVAL;

That is a different if.

The patch looks correct to me, please check again:

	ret = srpt_create_ch_ib(ch);
	if (ret) {
	// Ret is proven to be 0
	
	[..]

	if (!sport->enabled) {
		rej->reason = cpu_to_be32(
				SRP_LOGIN_REJ_INSUFFICIENT_RESOURCES);
		pr_info("rejected SRP_LOGIN_REQ because target %s_%d is not enabled\n",
			dev_name(&sdev->device->dev), port_num);
		goto reject; // Ret is 0

If there is an assignment to ret between those two blocks it is hidden..

Jason
