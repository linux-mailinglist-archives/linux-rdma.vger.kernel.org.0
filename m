Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29434351EDF
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Apr 2021 20:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236380AbhDASsT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Apr 2021 14:48:19 -0400
Received: from mail-co1nam11on2081.outbound.protection.outlook.com ([40.107.220.81]:6660
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237173AbhDASqY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Apr 2021 14:46:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QSXnEMgrcxTOxJUX8qDhZS0dOX6xldvkHYUHpEe3CsevhLZkkNw6Kr6VljlW7hOT8ZdZgXkY2Y6/oIvaOcMKpQxktjnRIsWFPzaox0d/FPM+ty90ubgiHStXDULIy15pGnpYnkrFKSMSH5LKim0dPrUr29zrXbx31sPBkY7ok7F8QvSFnKUldr/XYxEHGdSEL+2LJwcTVawFsBAH6YQ3zXMHPP+R4Zk3J7fbuV67cf8FNNKId1yKdq429kCs64R9oN+efiGQBaS5gQOVswQq+ssZvQZKfNsLAkoHGZ/yNTVLaCl/1qvkHy8tvp4C0nC923D7M+GmXpQY6EocstUcRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVYR3a0YZMRLvd21ZSnKgU5RazieVTqxqR9pJi/sXlI=;
 b=kpNUpD3J7xPPKPustlrKyuGURBMwmKIUFxjovwKytFEg3pX5jpGuCRM4N0PhslLl25TsWLGbcV+uQJNFiKJhVGSeC/wx5VSxsS8pk8Ok/fQcx7MK9JykIVYwhhNoaVYkKmUAj99UMlrDOn2hKhexJZk5tdofe8cQ38bWoGFP/+KvAPyQpozbl9n6GQOv2Xu98D8f36r46MwJVwI60rfKN+rwzPo1oHA/HAur0ZHyT1A1o3YTHv0st1g5RcMpOWQNFoKzEBYbpd6M4hXeYdqqSubAmHl1rfQI+5X8zqOmMFLgOkcZrvuPsa8oAubAwjIxdWqkfG44eTmEN6simTASjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVYR3a0YZMRLvd21ZSnKgU5RazieVTqxqR9pJi/sXlI=;
 b=FttDCrfDHNCfLA/hIUS0UztNwv1+dMMO6fVtcUv0Et4vb2QT9Z1Xw6ZwtRowS5nckujzCRhs3U8hYmA2iOrdS/XFQmN4hxTw+3meF5lRdJXlBR9fj9xmLybqrnAW6n8ZEeIsSrsBEFbbQUcZIJuK2aA+BLjwLopoN5EgK9XKcTrHJnj+RZtiQcBX4DO0ZdmV/h+bzq1O2zMgIiaFtOFhdPDBQJNpWJU3UQMICdNDF1qG7wRSt7Rwx9tiU2hF4DhkFPi5mKLWYpIvH/0Vealn9S2YLPmhetsIBtRehwqoAPjChSQP+hzKZRd2/x7DQbQRKqFFX35fBIkZWtQEoD0llg==
Authentication-Results: ionos.com; dkim=none (message not signed)
 header.d=none;ionos.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4943.namprd12.prod.outlook.com (2603:10b6:5:1bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Thu, 1 Apr
 2021 18:46:19 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 18:46:19 +0000
Date:   Thu, 1 Apr 2021 15:46:17 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gioh Kim <gi-oh.kim@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        dledford@redhat.com, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: Re: [PATCH for-next 14/22] RDMA/rtrs-clt: Print more info when an
 error happens
Message-ID: <20210401184617.GA1650879@nvidia.com>
References: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
 <20210325153308.1214057-15-gi-oh.kim@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325153308.1214057-15-gi-oh.kim@ionos.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0110.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::25) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0110.namprd13.prod.outlook.com (2603:10b6:208:2b9::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.9 via Frontend Transport; Thu, 1 Apr 2021 18:46:18 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lS2Kf-006vUA-JQ; Thu, 01 Apr 2021 15:46:17 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 521cd140-ab6d-40e9-4f61-08d8f53e6ff1
X-MS-TrafficTypeDiagnostic: DM6PR12MB4943:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4943FCC8310B5F98295DA8AAC27B9@DM6PR12MB4943.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:568;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /6FuXMTA2rlnnTFHztVNrtsbGMzKSS6JGoJpaABTJTdniHgCZsOnExb6ywY7lIX2mNiv4lIU+C6pNazFhmwRUa17lynxUK3xemi8a3opTxE8+R1W5GNSGZDQ5infniwLXCXMxGt9ZAdfWxj02zvmMcTkgmd7pWGKvKy3i518YKoA2Rt0C7Ny1//XcUrf/FhvmE0R6XlLW9LrCj7YaCrnmvsKf+d5SSj3QUDWn2HaXFjJfq/4ARmqsY8GcJaQntZiNBtCaX0aqhvRz3Ju6AoKbBVjOu1g388IgK+D3OeW00OqqiOBakO2uC9MHk/x4C8tRx+mZL0BjEZRJXIRlakrVzM5rPEyV5wx7ZVfchTpHpsuFQPXiLL0/cjGER+qtiYLMfurMWIX9mVXnOmMe92XSyD3QP83LgMTwkBGKvVSkhiyAJb4WST/FnQWQdQ/u46tNdkevENFOa24gAb+GExyky6LeTf2VLb0PNWBDSZCMFQIMKMBCclNUBPEWnUs88imRtY8wiMVQ5TTpbNJyJKwV2+8pmyfPBRZH6Fs2+IpGlxWgsGF1O7+12EP5yuJSNjyCSjyyxDXeV0aGlADnPdvKeRBapCoj4cABxyUA9LK5bqRwUtRYwVm4Mf/BmEJM6NLf5glD0K8Znz/iAld37rzKZRkHj8qCnfB7wYplDsSV+4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(39860400002)(376002)(366004)(5660300002)(426003)(26005)(186003)(2906002)(8936002)(36756003)(2616005)(4326008)(38100700001)(33656002)(316002)(66946007)(66476007)(66556008)(9746002)(9786002)(8676002)(1076003)(83380400001)(6916009)(478600001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?qzd6V+tM0QsqXZQHTWiC+tHmhOWh3lRhUOu4/ZQzCZ0p+W9gwsj/CuFe2uNG?=
 =?us-ascii?Q?rw8PJKWuIKerSY56gdl1joEi8LY0S0NHXncMEXD/NKHHzUFHy05nXmvfdU2h?=
 =?us-ascii?Q?lF76QkXVhi3HzB4Wx+mU9hYkDFKyP7tx14lzU3IAJgHzBAVlsNYqP4e6ar2O?=
 =?us-ascii?Q?ErXDmovlhYRhBDas/0Tpw2MyVk6ZJoZwpGglQoO5musffHvKB8Bf3PTAkhxa?=
 =?us-ascii?Q?CIZ/ZalHbzobiMhU16QPzBKGG76BVFaFjHoUY2dhOsqbtfzPgfIiT03g2YKH?=
 =?us-ascii?Q?fGQjxVIGVjyX+NeOjPMjU1F4xTUHUF+bU5bRMDW14whdYux83GZjO2BSrECb?=
 =?us-ascii?Q?MAiwfXWbq3k4F4/jDiIcbCmnDh9TKakqrOkdj9JZVrCOTHQKc/Nf25qzIzaC?=
 =?us-ascii?Q?7oieDPjd9Bjb/ylp3EFmEK5ongyu0ryWDYrH790cedblho2dkDAjFr58zhtF?=
 =?us-ascii?Q?tCHyHwD7fTeTke8znyeIT1sa4Ds4owvxp+zaAy+Co0UejZKy/0fByb9ZDq/n?=
 =?us-ascii?Q?Nj1fhxc9pVzQGKMzfLvzaDzMzwK639cwnelyrmBWHq0UUEeG0gqe1iHZAPyp?=
 =?us-ascii?Q?KUFmE9SGoWR+MyGNoxBDJ8QiKPdBCvny0HPutXo39iBVlq49wp8gMNSaojAp?=
 =?us-ascii?Q?YGtVGF1DiwDqJ9T6OQoSVvTJo0500CUmZ3l1+kywiMP2RYD+YF+5d9qb13nJ?=
 =?us-ascii?Q?E+OCWRcfe7S7jsw1lqnFgKwEFxhvaoG8NzbT+rh49idkx9PQbHGibDkjDYg7?=
 =?us-ascii?Q?VqexCHb5+lzBVWk6m+fzC8iUUnc/WIlLTEpteFCIUWGNpcA91+VTUB+dgUn2?=
 =?us-ascii?Q?kbB1RNaC2DdjWOcD6LirKzu/2g60ClYO98QOn6OeVPP6Os84HVQvx/Di2vG6?=
 =?us-ascii?Q?1j96s30CuJUm+3qwXcFEbj2QbMVk2JXKvMPEjXunlXyH6utbTZQNxQHf2tEZ?=
 =?us-ascii?Q?LlsmdS50TE9sQGLbzy1BtycvhtPhBi1OKfgFLoUUSnQVuy5rUWaH/ANZM30c?=
 =?us-ascii?Q?3djftulqvbKvchui9x53h5fihUxrUlqoB4uHrWSJmo1vsFZdH7gp1FVdDoj2?=
 =?us-ascii?Q?0a5buK+mfC/8t5/G0+8tzcEPzwu9jKy4pZqF4bCUI8TCkGt9UvT4q81ssy3C?=
 =?us-ascii?Q?xJm+CVJtd5NYeeTrC5nJS3kh8mGkar4P51WwPDk4WwSVLVDCQFT6pf0dQv5d?=
 =?us-ascii?Q?ff57iHT6w79dCZyubQEQiI22Gtx8l/GtdW6xfSxue6mZOvANOljbKGtKPnCq?=
 =?us-ascii?Q?XetGcSFZw5X6CmJQxnPMrxEfE6AyQKMIebRdgOrY66CWUEJUvOuAVwG1Qr/A?=
 =?us-ascii?Q?TkhTlLGcHhx80lTu5LZtr01jOLyZnEB0GRaJGEoHq5ZuXA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 521cd140-ab6d-40e9-4f61-08d8f53e6ff1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 18:46:18.9377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o54A/jy/E/1ywn1Zo3JMqmH1otlSLEZkfDeTWO4CNoTcItEEXG41WgldlxdX18XG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4943
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 25, 2021 at 04:33:00PM +0100, Gioh Kim wrote:
> From: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> 
> Client prints only error value and it is not enough for debugging.
> 
> 1. When client receives an error from server:
> the client does not only print the error value but also
> more information of server connection.
> 
> 2. When client failes to send IO:
> the client gets an error from RDMA layer. It also
> print more information of server connection.
> 
> Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 31 ++++++++++++++++++++++----
>  1 file changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> index 1519191d7154..a41864ec853d 100644
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -440,6 +440,11 @@ static void complete_rdma_req(struct rtrs_clt_io_req *req, int errno,
>  	req->in_use = false;
>  	req->con = NULL;
>  
> +	if (unlikely(errno)) {
> +		rtrs_err_rl(con->c.sess, "IO request failed: error=%d path=%s [%s:%u]\n",
> +			    errno, kobject_name(&sess->kobj), sess->hca_name, sess->hca_port);
> +	}
> +
>  	if (notify)
>  		req->conf(req->priv, errno);
>  }
> @@ -1026,7 +1031,8 @@ static int rtrs_clt_write_req(struct rtrs_clt_io_req *req)
>  				       req->usr_len + sizeof(*msg),
>  				       imm);
>  	if (unlikely(ret)) {
> -		rtrs_err(s, "Write request failed: %d\n", ret);
> +		rtrs_err_rl(s, "Write request failed: error=%d path=%s [%s:%u]\n",
> +			    ret, kobject_name(&sess->kobj), sess->hca_name, sess->hca_port);
>  		if (sess->clt->mp_policy == MP_POLICY_MIN_INFLIGHT)
>  			atomic_dec(&sess->stats->inflight);
>  		if (req->sg_cnt)
> @@ -1144,7 +1150,8 @@ static int rtrs_clt_read_req(struct rtrs_clt_io_req *req)
>  	ret = rtrs_post_send_rdma(req->con, req, &sess->rbufs[buf_id],
>  				   req->data_len, imm, wr);
>  	if (unlikely(ret)) {
> -		rtrs_err(s, "Read request failed: %d\n", ret);
> +		rtrs_err_rl(s, "Read request failed: error=%d path=%s [%s:%u]\n",
> +			    ret, kobject_name(&sess->kobj), sess->hca_name, sess->hca_port);
>  		if (sess->clt->mp_policy == MP_POLICY_MIN_INFLIGHT)
>  			atomic_dec(&sess->stats->inflight);
>  		req->need_inv = false;
> @@ -2465,12 +2472,28 @@ static int init_sess(struct rtrs_clt_sess *sess)
>  	mutex_lock(&sess->init_mutex);
>  	err = init_conns(sess);
>  	if (err) {
> -		rtrs_err(sess->clt, "init_conns(), err: %d\n", err);
> +		char str[NAME_MAX];
> +		int err;
> +		struct rtrs_addr path = {
> +			.src = &sess->s.src_addr,
> +			.dst = &sess->s.dst_addr,
> +		};
> +		rtrs_addr_to_str(&path, str, sizeof(str));

Coding style is to have new lines after variable blocks.

Jason
