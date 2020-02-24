Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA0516A7B4
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2020 14:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbgBXNyH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Feb 2020 08:54:07 -0500
Received: from mail-am6eur05on2072.outbound.protection.outlook.com ([40.107.22.72]:6060
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727339AbgBXNyH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 Feb 2020 08:54:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkMoMmOClmjmiWXTOlm4QCKaL0LQ4vRFn50GnCBZ7yr0X1CGqsz/ok10XyysXLSeABre++oh3qfJpEDsn+HHTMQ8Uunc0XYRzBUm70zgKQk7d3cReK9E2uQNAbzqeQYtLFF5hz7YSShg6JV38jUYY6qkH6SIAJYlvjwj969y57B3FlrwVlJw2BzFcwLmUX8lDsndeiXAOtvyRxe22zv7dJ5OV4xwFGUwaR3vTdsKT4h1uzcMg2EV5w7S+2t0aBVMqFpNWtU9zWN6SN3OwW5ZwWXVgOarur+jJZsc1dWL+1f4DdCZLYLvTDpAzNJ5DoH4mqdwGwEIvNvSfwPgmOjNTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4A0y6CDGBx+JcY7/bqHIBofcr7ii8IgUzCs1M4Oxokc=;
 b=fQSBaSh/EfH9rckYi0NvtucdRSPTtkAX2eO08A15o+LSanj9M9rluhHZCaEznxxojisgow/P7vQbunnydGhR707TU28BVW72mPcIotE+JqFoutFVDUK2NuesA0I+g4z4fDo6Q2GoU7dpUnz7rjtHASIlX8I8C14bkKzfau2iXkPq5nDa8bLJqJwLQJvZC0zpLHKTr2sUVZMhdnOI8l4ZuIrH+PEPL7Fl3hDn58qBya5ivwsfo1Y4SFKW9Y67ppKMhw0E5lORur86I6XODjn+spuT+UREwgIG89OZeJ1XjsmNkpCZMSyQEgit7Y7XxiySyB7FLdkvT6sxsrCdLl47fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4A0y6CDGBx+JcY7/bqHIBofcr7ii8IgUzCs1M4Oxokc=;
 b=QE5KVaeQ7wm/4Y5ivAtYFAsmTzZUcISl5+Gd39Z8SH8uN+4R+k2hOEWJEZ1rwPCzVrWdt54gRw9dcme6uiLgUM+I31mtBdDPPIxX71O3PXQPi5P9DvY1XJhE2+F7iyvsZEGvAPfDFYCNVB1TdRHdm7PgDzRxqN9SntWtRn0h8j0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB5038.eurprd05.prod.outlook.com (20.177.52.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Mon, 24 Feb 2020 13:54:02 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 13:54:02 +0000
Date:   Mon, 24 Feb 2020 09:53:58 -0400
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v2 2/3] RDMA/bnxt_re: Refactor device add/remove
 functionalities
Message-ID: <20200224135358.GJ26318@mellanox.com>
References: <1582541395-19409-1-git-send-email-selvin.xavier@broadcom.com>
 <1582541395-19409-3-git-send-email-selvin.xavier@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582541395-19409-3-git-send-email-selvin.xavier@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR10CA0019.namprd10.prod.outlook.com
 (2603:10b6:208:120::32) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR10CA0019.namprd10.prod.outlook.com (2603:10b6:208:120::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Mon, 24 Feb 2020 13:54:02 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1j6EBK-0002nq-Om; Mon, 24 Feb 2020 09:53:58 -0400
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 90f68f3b-26b1-400f-fe59-08d7b931016e
X-MS-TrafficTypeDiagnostic: VI1PR05MB5038:
X-Microsoft-Antispam-PRVS: <VI1PR05MB5038E07066067878D457CDFCCFEC0@VI1PR05MB5038.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-Forefront-PRVS: 032334F434
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(189003)(199004)(52116002)(186003)(8676002)(81166006)(5660300002)(4326008)(66556008)(8936002)(2906002)(316002)(81156014)(66476007)(26005)(86362001)(1076003)(33656002)(2616005)(478600001)(9786002)(66946007)(6916009)(36756003)(9746002)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5038;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WEKTkhlTw8tNKDGdUgcUbyj4PD5lbDgnl9UkXVmGQ878sC65RF6KLVtEcQ6EurdG4gzoNEyqyeiayUEICoWJpc/HNLxmBUCfBUzq3MOqGFHVTwkdqnAKM8U863587rJkYZ56tqRvdEetk+fLWJlSGQdQOo4V8WEW9zfUFeWU5C4/7vrC7vPf3FSq/5Q3HtIu5QsqjsrTOAn9oKl2zX8Uys9ztiAiQ5jKRs3uRfl3ChhE+YlP1Gps3Wq7z9aXCJejHOshqj3BLZIyOSptScqsCLUyOtQFeZa/tQsYYgRuVZF7MbPXxBsvRWMqGepsncLgfgeudzDboLj2GV2ZzDNmp/edLl0yT3guiCYDupc2gIZRlBSUm2T4Sg6x57J3Rvegrg4Lv+VlDYdo48mkRdPTTXvjwnvrNUYb/sQZjryeEqw8RVls5AToye4vZ7cjxb6tk/ol7boSEanTBC921klYUgkyIJn4mLjxgr2QAbTLRBQvAt7I4ihR5q3puSAUVoOq
X-MS-Exchange-AntiSpam-MessageData: 4cAW1SzX1uTz9EvwsYxrLvDuHqUn5qQ7ckHwJZsHY48LJIawzkZyTaLh0aZvqwLXgVP4T1poSGZbPcSaK2XY6KAfKUSK6mEiYY7eTJBx+9FuiCv88McO37UEgJS1P35PQS+nuCIEVezfOtHG9nCOdA==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f68f3b-26b1-400f-fe59-08d7b931016e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2020 13:54:02.6071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 416b7ptsu1pVBNpdYD0WRrJcmMvBg2BB9RcVUK8+dSbDy6QFX7XC2jsKBJ2h7tW03y9+mHfeOF55ipDjOiDn9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5038
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

>  static void bnxt_re_stop_irq(void *handle)
> @@ -1317,7 +1320,37 @@ static void bnxt_re_query_hwrm_intf_version(struct bnxt_re_dev *rdev)
>  		le16_to_cpu(resp.hwrm_intf_patch);
>  }
>  
> -static void bnxt_re_ib_unreg(struct bnxt_re_dev *rdev)
> +static void bnxt_re_ib_uninit(struct bnxt_re_dev *rdev)
> +{
> +	/* Cleanup ib dev */
> +	if (test_bit(BNXT_RE_FLAG_IBDEV_REGISTERED, &rdev->flags)) {
> +		ib_unregister_device(&rdev->ibdev);
> +		clear_bit(BNXT_RE_FLAG_IBDEV_REGISTERED, &rdev->flags);
> +	}

The reason ib_unregister_device_queued exists is because you can't
call unregistration while holding RTNL.

>  	case NETDEV_UNREGISTER:
> @@ -1704,9 +1727,8 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
>  		 */
>  		if (atomic_read(&rdev->sched_count) > 0)
>  			goto exit;
> -		bnxt_re_ib_unreg(rdev);
> -		bnxt_re_remove_one(rdev);
> -		bnxt_re_dev_unreg(rdev);
> +		bnxt_re_ib_uninit(rdev);
> +		bnxt_re_remove_device(rdev);
>  		break;

ie here.

This *must* simply be a call to ib_unregister_device_queued() and all
this other stuff has to go into the dealloc.

As written this is all kinds of deadlocking and racy

Jason
