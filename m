Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E439E16A780
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2020 14:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgBXNnp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Feb 2020 08:43:45 -0500
Received: from mail-eopbgr130053.outbound.protection.outlook.com ([40.107.13.53]:28384
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725535AbgBXNnp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 Feb 2020 08:43:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yc58RljHb/bGxQI+sq6ua1dk6S9B6xkvFjakh3LXxxdQlaII6zf+P3gYzNq1USoaXfNGVYC4z0csL7XqVlGLQmqibxgtjoBx+fUT3ucb8OxQKgvqGj5LixWz86C79VFymzfJnNx3ism5mFhNBnPjJAYKctx2bUHLJYBtenU4JKqGRKBKpqDM8OitW/qhwRggC/N9XLKavBNS4biLbTZQdORkfsnXeOHZol10T0aE8ne6c7rNTizC4eIqM/Vq/FvPJ25nJ5ENpE1pqEILdW2bnCdKRc/klxdD7/UcBt6tKxnir3xVU7GgsOoCng1nMnfus/KtmpkPW17WM9PB1hgugw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vc30C5emjyqqTxboKcBxx6LZFriLJtoZ+yrb24hQMtQ=;
 b=cDmSegPgO/348JdA+PgsYTmIZR0pZWpQy5b/98fGa6CM9PDwHuQOnMaw816gEvVEQq9+vFAFD50ljR4xBRDvkI2+i640y87mJz3iM3SY0JIQ4Gq1DrRLq0u9GBVP1/8LAmg2omrCd3Bggr5wLnnzLjhLaea3Y5iqRoNRFcFk37MHj1Z5BsiTAvWRkvEVaVQIOdyIubrtdoiHNnMbGQczDfckZREmTOGQV668fR+chvZ2K/2SilFpp75+4ZB3PTqrUZZjZKBOOu+Drk+8/e4KjAHbXDKXVudq4zm6BhpsiFSlj+mS26qkP3M/7ZK9QSegyrq/QmeTUAfIcM4UemU6gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vc30C5emjyqqTxboKcBxx6LZFriLJtoZ+yrb24hQMtQ=;
 b=nJjE2h1Q9cDP/J72JoX/YPxVQV226lg95raz6M2vaIWrF4SX1PlRn6GE0V5xxtZGnjwe9z9Kf1jOZ8TJbWy8tj9iDPc2VtnmBDNR2jW6qlB87xXKqY5qOlFW3qx0MGX6vKXJb2RbVTySe62gsdcNZZ73TrBZU9EfSBuygaATBYI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB3263.eurprd05.prod.outlook.com (10.170.238.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18; Mon, 24 Feb 2020 13:43:42 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 13:43:41 +0000
Date:   Mon, 24 Feb 2020 09:43:38 -0400
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v2 3/3] RDMA/bnxt_re: Use driver_unregister and
 unregistration API
Message-ID: <20200224134338.GH26318@mellanox.com>
References: <1582541395-19409-1-git-send-email-selvin.xavier@broadcom.com>
 <1582541395-19409-4-git-send-email-selvin.xavier@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582541395-19409-4-git-send-email-selvin.xavier@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR16CA0014.namprd16.prod.outlook.com
 (2603:10b6:208:134::27) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR16CA0014.namprd16.prod.outlook.com (2603:10b6:208:134::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Mon, 24 Feb 2020 13:43:41 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1j6E1K-0002hC-8D; Mon, 24 Feb 2020 09:43:38 -0400
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 29431d0a-6295-421a-045d-08d7b92f8f5d
X-MS-TrafficTypeDiagnostic: VI1PR05MB3263:
X-Microsoft-Antispam-PRVS: <VI1PR05MB3263A71CC62B88F7F9A3F153CFEC0@VI1PR05MB3263.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 032334F434
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(199004)(189003)(1076003)(9786002)(66946007)(66556008)(186003)(2906002)(26005)(66476007)(36756003)(9746002)(81166006)(86362001)(33656002)(5660300002)(81156014)(2616005)(8676002)(52116002)(8936002)(4326008)(478600001)(6916009)(316002)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3263;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fydMrASO4CXJLnudvWOhD/PU0fYBYyi9W1C+2fFKuUOtl93gu8GO6DVLvc5hIjzju887C+QPTyTrIPtguuM3YvPc+ls0x7/DTHGUI5TdgviFBoivJgI3+NFCLkvX0tyB6jjeRcpYUiMlKtcctjd6hcHqx8Hvwae6Bp/Uw16YkgOJxmSd2i2Nq5LujyZrnA9JnkCvq3AmCIdtDJn6ZxVf68u3Dq+E6cpPU3W8pezuTD/6uotWknNCXFjwAw7HAeM8W7IXsrQGv1WRlyaZe+TSr9+VrHSKIJ6JyWtEzPJvEb3KBKzN3W2eBx/mqTa2h2B84R5WcWOPsNByaQazsEvnY8xGptHYEsRMK5aeDaLKnL9CxfR+go/bWtUPPF+kj16Yt8fePmv8hO66vvwlrRFrUEaAd5KGP/TzF6peb5vz5cUOB6dE/lff0zMtplevEzBjTVsk7vqmmB2X1eL156YjIhk2SbilbtE1IdCS7njb7TPN8r6Eq4dzKpeFJ1IOtEUu
X-MS-Exchange-AntiSpam-MessageData: fWeNR7EWHM3bw9wmyBo2VAzSzst/6ee+eWOi5aJr+cOk+MJB0h/O2cZVv72TvX9aQjO3jV4EdFOQbjSjuymst9Gfy802P+lGZSzG18bjm3U2aFw+YkRrJlCIhQ+Xy4nszFciPIaK5XVOUPqw+SWgwA==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29431d0a-6295-421a-045d-08d7b92f8f5d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2020 13:43:41.8432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X5jhg0pM5GJIuzxrgWqzanWbYqusLeS94L9yBhwL/3Zg5YgTrFkkWCBRg5MIkrHwsmXsc6QPorzFMIQ9MMiq0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3263
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 24, 2020 at 02:49:55AM -0800, Selvin Xavier wrote:
>  
> @@ -1785,32 +1777,23 @@ static int __init bnxt_re_mod_init(void)
>  
>  static void __exit bnxt_re_mod_exit(void)
>  {
> -	struct bnxt_re_dev *rdev, *next;
> -	LIST_HEAD(to_be_deleted);
> +	struct bnxt_re_dev *rdev;
>  
> +	flush_workqueue(bnxt_re_wq);

What is this for? Usually flushing a work queue before preventing new
work from queueing (ie via unregister) is racy.

>  	mutex_lock(&bnxt_re_dev_lock);
> -	/* Free all adapter allocated resources */
> -	if (!list_empty(&bnxt_re_dev_list))
> -		list_splice_init(&bnxt_re_dev_list, &to_be_deleted);
> -	mutex_unlock(&bnxt_re_dev_lock);
> -       /*
> -	* Cleanup the devices in reverse order so that the VF device
> -	* cleanup is done before PF cleanup
> -	*/
> -	list_for_each_entry_safe_reverse(rdev, next, &to_be_deleted, list) {
> -		ibdev_info(&rdev->ibdev, "Unregistering Device");
> -		/*
> -		 * Flush out any scheduled tasks before destroying the
> -		 * resources
> +	list_for_each_entry(rdev, &bnxt_re_dev_list, list) {
> +		/* VF device removal should be called before the removal
> +		 * of PF device. Queue VFs unregister first, so that VFs
> +		 * shall be removed before the PF during the call of
> +		 * ib_unregister_driver. Commands to any VFs after the
> +		 * PF removal will timeout and driver will proceed with
> +		 * unregisteration and free up the host resources.
>  		 */
> -		flush_workqueue(bnxt_re_wq);
> -		bnxt_re_dev_stop(rdev);
> -		bnxt_re_ib_uninit(rdev);
> -		/* Acquire the rtnl_lock as the L2 resources are freed here */
> -		rtnl_lock();
> -		bnxt_re_remove_device(rdev);
> -		rtnl_unlock();
> +		if (rdev->is_virtfn)
> +			ib_unregister_device_queued(&rdev->ibdev);

Why do it queued? Just call ib_unregister_device(). Otherwise it won't
order reliably.

But be very careful about lifetime. All the other drivers had problems
managing the lifetime of the pointers in their device lists.

Jason
