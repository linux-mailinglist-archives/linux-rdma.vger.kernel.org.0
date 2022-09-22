Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49AF35E6472
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Sep 2022 15:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbiIVN61 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Sep 2022 09:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiIVN6R (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Sep 2022 09:58:17 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D37EF089
        for <linux-rdma@vger.kernel.org>; Thu, 22 Sep 2022 06:58:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RAleHEfxKJw627g2y30kEChBDhUzLXEGm9bZkEe4JRpRlHHzOpnDpVILOG3XQtiKFfP/xOmTeE5AThgtUoKNRLYoSSGpLI/K7SKpzoy6eZF/fzGcwBk/HV8TWlPZHr4QSp9f2VX4iDIw82tSHIr8gDGJVKFBvZG7qk45gelWiRFbvJ4TzLE7t6US9PvccQJbBX4hxlqL5kQdilbbZ6qZhmxcp3trKlKJwmY8J9Q2ReF6rVTZHUMejGrXdopyLd/Lvw/nTTtH4d8gvbKDVjUQ2jzu37Z2S0p3VNP/DPjI+Hu15HwyE6mbuy6KgDLktbFWQVk8nPkmbCXO81/VAE9mMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFR869wjjt/i8uZEtNaRVUwx1in3O7Mliqibdzn0Yk4=;
 b=nicfX/pzUDVH2iJsYADBRSiaTnlMVbUEmYTnStrv8m/5gTeoeWspofS7xZfIXH/qLuzURvTC46XXizEZVJ6sI6PXl6r0EJLWLg4ZeG5MDG7digChNx3R8sI99qr2Wd+Gd98Iw0I12/PYoDOvMmhigm98ZgxOkYpJN63EBqZAbdPFSLWBiERMbd7O2IzUEvyltgnTMmL8/NJy8S5J+/ZzaY8jf0vC7otC5uYw7+CXdbABG9J+Dx99wJpvhMMdemWW35PcHnsdopw5bi5JswtbTyBeCPCp61JRp33urrNwkHLK6xElOP9FE7A0k+tskr5eOu7d/bpRAp/PcdImuKCtVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFR869wjjt/i8uZEtNaRVUwx1in3O7Mliqibdzn0Yk4=;
 b=NcgUzzaJ/8LYZXHHqanWoq5EgPaWO5CPsvU9q6ODTB694VzOBXaWn3+ggTu7vkvhnQ1lLMMct95UXcmYB1EyO+pfeb6kfvrNWF0JiOhxaPKTnZ/yY6zyrN5R4fcMnbPCUx3KLOe+L0fPsm7wKrbLKIKBAuqW/HZWH1RK9m5WcZ0SYRIgFOcwYeLAinDUSJenNmZ2ZpxNoBTuP/6b+iQLygqPA3Ktrlrt0Rzb/pMx+qe51IviAfZBuQ2TEN6ETNCkZWCSt0eb6h6Aj40N5g6ykyIpDXSK6l2xUt1OPFZwKt2Aesd0iByitLEJMr5qz3OClADpnZpik7Xteo//RxQS0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Thu, 22 Sep
 2022 13:58:13 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 13:58:13 +0000
Date:   Thu, 22 Sep 2022 10:58:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Mark Zhang <markzhang@nvidia.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>
Subject: Re: [PATCH rdma-next 2/4] RDMA/cma: Multiple path records support
 with netlink channel
Message-ID: <Yyxp9E9pJtUids2o@nvidia.com>
References: <cover.1662631201.git.leonro@nvidia.com>
 <2fa2b6c93c4c16c8915bac3cfc4f27be1d60519d.1662631201.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fa2b6c93c4c16c8915bac3cfc4f27be1d60519d.1662631201.git.leonro@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0131.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::16) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|CY5PR12MB6201:EE_
X-MS-Office365-Filtering-Correlation-Id: b910bb0b-6953-4b5c-2641-08da9ca27dca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GSGxQ/Acyu+vde5VJSY4PM5gFhLC22hry0lQ6DdWOOAdYXtSUyDaKaQyR5QuZs2qR7VMaMKKBYTOteH2OXnyVdSkzv8gMSf3Jf2hDRZfqViPkCz13EaxQ+iyen3jhcQi3JPsPujGzTQBto8ETMOtTYJyYTAzI1KvD75pWO5LVJldu4bJ2yt6licr437a3Hx23Zbnf90hJkpr8P/F0ELJn8YrR5MVsiNeY8WuQP5JZhcLq7p35VcVAr4uf0KVBSMgO81t4LAP7cQ8A0z3PIF4QHOX93nGKXUz1GbEPtjMMwPqJnUWfYvwgPw1rJLZydy0uxCZIjZgPhL5eq8Br3TrdWyW+V9kKUZSix+Q/2SNxzkK6YEsTRMYQTdk1+/ZxLB+1evSxo8vZrhxydnLBmqmLO7TqIU3ZTG1V4a/uZsh14M3Ej9N4Enj5MCxRhZnQVZDN0pAOtSFgkQxxt2X/oKL2xEey3LDSNMuxZM7bfB39iWjOTWSUUTYNIak6JkIxDHE70Wb5VfBRuyAzkRCmLCn5e+elQ4SlXXMMyG0/rTRY8hEmPZCz33mz0o5HCORPXsW1GjMWRniqHdbsi95Q5PaW6KNkvAi/mIPy0KuznOVtys3F+efwmQbMzgmzB5+BytPWWuRV2imOToOy3y2BUmckYbVJCToOZVAm1Pf2gjRKw3rmYB13eOGpKMks28AuZ0mAP1NSR22TwTOe4ZprZ81fg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(451199015)(4326008)(8676002)(66556008)(6916009)(8936002)(66476007)(54906003)(2906002)(5660300002)(316002)(66946007)(86362001)(36756003)(6512007)(83380400001)(2616005)(41300700001)(6486002)(478600001)(6506007)(26005)(38100700002)(186003)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?osDwLnMMGKT8jX6BVbLBL8Pe/O2DreaDXISNXa3s+S5RcurNON59CbvaLEEo?=
 =?us-ascii?Q?+GB5/dceSMXQdsIH5RYK2rTJ0c8C5FODYMXGw1vxKb+3qTY/lSjofY7X47C9?=
 =?us-ascii?Q?n4nSDV4Br1lolTOajZ3sEIP4xqJHvyilx2AqsiR9vM8gUC6VuYbNyYp+2hhA?=
 =?us-ascii?Q?Hy2delp3rDzAYi2w5/+1lMZDIRLJuTkh+TK8mcUjuPw951e2I4XadIxhFgdK?=
 =?us-ascii?Q?SlQYv7s2udMPtlunV71hlzgqZyaeNK92IoD+atYk1njUpLAQ8u38zW36WZy9?=
 =?us-ascii?Q?Qq1UaC2NeM9UyjD4sa5jGhHTOZmDHicqM78jye+riDVxBwINvbbDMUdONZre?=
 =?us-ascii?Q?5T4OoMfTETAqIVWFX/rp5soLx8/ANUisFUPQzcM09l7Fpj5l8Y7tbGJBeXPt?=
 =?us-ascii?Q?NW/KsEKXiTkQoB944e7rqnbRS7o/6fQf6aEsdvAbH9uDJpuKmMNFKMhEAn80?=
 =?us-ascii?Q?6EPMtQQ6RO22H9BRgNlTcP/VUmhOFNB7KppSVJIQvWPw1TItTg/+dd5OMP2f?=
 =?us-ascii?Q?dbIh4uT/WDr7REdIUCFrn8rrHIuTuhmkSBjlCp5RuxzbqWnNh7t7904wbg7r?=
 =?us-ascii?Q?qlu7zdc9Wa9Ni93injrT4fd8MlrA0M7Y/qTY80x6/Q9W5m9LyOEXwsSyUa/p?=
 =?us-ascii?Q?RqqrjgkVMJP9tbtKE/EXCTnBKSKnu2WadHOhPm9S6ntrMbyZgG+ClptdydcG?=
 =?us-ascii?Q?8Qefv83b/rD0RI7XJL2YafcETsl6mF1PitobmllotjjDKVDVcfLXA/wy9ssG?=
 =?us-ascii?Q?oLTa9At+xTKZoejabMHgriiMrgOCzurQ6CB/yleuLPdTcBzZgHKxiHUja3Ek?=
 =?us-ascii?Q?p0XCdY798xQnNk5QjmLn/nRdIxaFlU3IEmhKRdo5GnrtBMFmdhL78qJ+/vuM?=
 =?us-ascii?Q?m5VZCydXhexZFcRO0z6h1ja0OXy0q9lfYLDCw9RkE+EEozUmrYmW2L5d7AZc?=
 =?us-ascii?Q?NKUTE/iuCT3jZnK2ytb2GIo1mUhHGUbz/c8h0qSMEkBz1BfBRM4UnTWR4r7u?=
 =?us-ascii?Q?03TxPhNMvOjJMXE88x6Lcbw5u4jJU6+HAIBugAwfKXVD3HH8X0X/J6QCGGly?=
 =?us-ascii?Q?HkA6Mt6juCRju7sbJC/hnSHigc/+yM7oNt3RCjXAXouOU9JLgrB/x2UixES4?=
 =?us-ascii?Q?LPpeCmQBp4sUTqkrYkeuMw0DunqCIllDmbq/gDQw+Gf+pWrrYz0wbNvf4wCD?=
 =?us-ascii?Q?09kA22VbqvE4riIHYkuh46B6MCZxM/hbP8ZNKu/DXaY3hiyN+yeTDzOiAf/E?=
 =?us-ascii?Q?+6jlfROkFn0uzICrqSRYTmf1SKW643fegTG6/1S8AEugwSt4CMl1AksyZdjT?=
 =?us-ascii?Q?KYrGUHeywfemXVhn6I+JkkuGovhDWxtvFv3MnR8FLUMNyg9wKQLM+hwFo4T7?=
 =?us-ascii?Q?brUL1GkG1ZypyKigNzgGz2+RGGrAg1lNSi9FDIjM+VL5sSnVVJzUM1o9ihZ3?=
 =?us-ascii?Q?ncVrJaZ+keotrt1jN99j4xzwcBoodCxjO58dvdDAs2lVVxth8hgo2Gon1QmQ?=
 =?us-ascii?Q?uLjqxw43p+szmuJQ8NIF7h/QN7vpUzFpa4DwyRjswDnc0NrBLTSESA1ZSFrQ?=
 =?us-ascii?Q?uyEk+YJ4cukdTnijqHt8kGY0VUEYOk7dv8jBRGd5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b910bb0b-6953-4b5c-2641-08da9ca27dca
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 13:58:13.6475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7UqoYsfq6d0laWk/zPFULL6NCVw1zwEPhWVMZ1vtl3oMbKlrEIVxx7gWBWq/jXBF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6201
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 08, 2022 at 01:09:01PM +0300, Leon Romanovsky wrote:

> +static void route_set_path_rec_inbound(struct cma_work *work,
> +				       struct sa_path_rec *path_rec)
> +{
> +	struct rdma_route *route = &work->id->id.route;
> +
> +	if (!route->path_rec_inbound) {
> +		route->path_rec_inbound =
> +			kzalloc(sizeof(*route->path_rec_inbound), GFP_KERNEL);
> +		if (!route->path_rec_inbound)
> +			return;
> +	}
> +
> +	*route->path_rec_inbound = *path_rec;
> +}

We are just ignoring these memory allocation failures??

>  static void cma_query_handler(int status, struct sa_path_rec *path_rec,
> -			      void *context)
> +			      int num_prs, void *context)

This param should be "unsigned int num_prs"

>  {
>  	struct cma_work *work = context;
>  	struct rdma_route *route;
> +	int i;
>  
>  	route = &work->id->id.route;
>  
> -	if (!status) {
> -		route->num_pri_alt_paths = 1;
> -		*route->path_rec = *path_rec;
> -	} else {
> -		work->old_state = RDMA_CM_ROUTE_QUERY;
> -		work->new_state = RDMA_CM_ADDR_RESOLVED;
> -		work->event.event = RDMA_CM_EVENT_ROUTE_ERROR;
> -		work->event.status = status;
> -		pr_debug_ratelimited("RDMA CM: ROUTE_ERROR: failed to query path. status %d\n",
> -				     status);
> +	if (status)
> +		goto fail;
> +
> +	for (i = 0; i < num_prs; i++) {
> +		if (!path_rec[i].flags || (path_rec[i].flags & IB_PATH_GMP))
> +			*route->path_rec = path_rec[i];
> +		else if (path_rec[i].flags & IB_PATH_INBOUND)
> +			route_set_path_rec_inbound(work, &path_rec[i]);
> +		else if (path_rec[i].flags & IB_PATH_OUTBOUND)
> +			route_set_path_rec_outbound(work, &path_rec[i]);
> +	}
> +	if (!route->path_rec) {

Why is this needed? The for loop above will have already oops'd.

> +/**
> + * ib_sa_pr_callback_multiple() - Parse path records then do callback.
> + *
> + * In a multiple-PR case the PRs are saved in "query->resp_pr_data"
> + * (instead of"mad->data") and with "ib_path_rec_data" structure format,
> + * so that rec->flags can be set to indicate the type of PR.
> + * This is valid only in IB fabric.
> + */
> +static void ib_sa_pr_callback_multiple(struct ib_sa_path_query *query,
> +				       int status, int num_prs,
> +				       struct ib_path_rec_data *rec_data)
> +{
> +	struct sa_path_rec *rec;
> +	int i;
> +
> +	rec = kvcalloc(num_prs, sizeof(*rec), GFP_KERNEL);
> +	if (!rec) {
> +		query->callback(-ENOMEM, NULL, 0, query->context);
> +		return;
> +	}

This all seems really wild, why are we allocating memory so many times
on this path? Have ib_nl_process_good_resolve_rsp unpack the mad
instead of storing the raw format

It would also be good to make resp_pr_data always valid so all these
special paths don't need to exist.

> diff --git a/include/rdma/rdma_cm.h b/include/rdma/rdma_cm.h
> index 81916039ee24..cdc7cafab572 100644
> --- a/include/rdma/rdma_cm.h
> +++ b/include/rdma/rdma_cm.h
> @@ -49,9 +49,15 @@ struct rdma_addr {
>  	struct rdma_dev_addr dev_addr;
>  };
>  
> +#define RDMA_PRIMARY_PATH_MAX_REC_NUM 3

This is a strange place for this define, it should be in sa_query.c?

Jason
