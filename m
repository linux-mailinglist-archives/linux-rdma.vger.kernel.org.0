Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C69E2036B9
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2020 14:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgFVM3S (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jun 2020 08:29:18 -0400
Received: from mail-eopbgr20081.outbound.protection.outlook.com ([40.107.2.81]:65166
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728101AbgFVM3R (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Jun 2020 08:29:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJsUWZiSs1t+5lVfrNS/7kGXSIESZFgB1LSVNSRUHaA56GEPlaXcitGgQZ0SYecTR70F9ocsNFLS8GQ4mICDl0vxg5m5PDJUu71sGzaQVDkqsj6tzaajqkdIJuBw20NjMW9JFUcnQW8VmnXmQxBo421fuoMPxCCK9cbnDvQW06mEzuH8h65tNQ3oRKZjp7yUjhNAZ92phX233I2qQS2tr0vx8d4H+AS8L1K15yJxQSKWnuxvtsK1I1ugHYjjDNPPVuVT/pKlxmMvk30HSwumQUSKEOfnECfm0rAPPj6Y31cOC+WP5tHupqon2a2zhRho6E0Le6V0Y8WuzjTiZjVkZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BT+22sNesJ/2/I78BgwmaxFP9y/Dxt0G5juQu0R7KLI=;
 b=YgTxoedAo/4wT1SudYT0JXShMEL4mcn0LiQkbtvBx0FYf74dEl1aAcKF7Q7MI44ngL3Y8v0PlbeWXfVNHxTOABQrpCpF6WwXi0Cd9Wvc+meNSOdUHJ5PU4Bfr31pMLlpVu6BQur9J01GluysW5kiSH+ux84PECYA+yDipPnW4jG2z9cXyR1ApOqPE+dnD6iKLsvNmugtHX3pmYz84Lh+prZTf40ZdLNoOISsLx3LlTEonsxriOGDpa2qbq5+YzB1HiRbHBgqqruYmgZpx0d+9uzDlptOerE9kfX7ZpfQGfalt9Ny9ZnAu7WgaxFma8LhNpKHaI5EXOtlOlbewDsR1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BT+22sNesJ/2/I78BgwmaxFP9y/Dxt0G5juQu0R7KLI=;
 b=Jcwq67ukxfSpIfFyJpYKlvPT1LzPRytRz+/1uuoTyzg9MOIKjuAqzZE4rH9lsSuHSK5p1ZbOALlZ8xvBBdUE4Qr0vL5T2K7KtPEXIud+p/G6Ii1zmYtEeZhkynyv67s3JWXykvmSl8xUvrOcr19RTjZJl5SxxzAsASM9LM0ryBI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB5566.eurprd05.prod.outlook.com (2603:10a6:803:9c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Mon, 22 Jun
 2020 12:29:14 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e%7]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 12:29:14 +0000
Date:   Mon, 22 Jun 2020 09:29:10 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 2/2] RDMA/core: Optimize XRC target lookup
Message-ID: <20200622122910.GB2590509@mellanox.com>
References: <20200621104110.53509-1-leon@kernel.org>
 <20200621104110.53509-3-leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200621104110.53509-3-leon@kernel.org>
X-ClientProxiedBy: BL0PR02CA0011.namprd02.prod.outlook.com
 (2603:10b6:207:3c::24) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR02CA0011.namprd02.prod.outlook.com (2603:10b6:207:3c::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Mon, 22 Jun 2020 12:29:13 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@mellanox.com>)      id 1jnLZW-00BsvS-Mx; Mon, 22 Jun 2020 09:29:10 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0955e81e-696f-4667-0658-08d816a7df73
X-MS-TrafficTypeDiagnostic: VI1PR05MB5566:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB556696BC08DA4691D227AE38CF970@VI1PR05MB5566.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Skd0a0GXtFJsCstyFJT9BBgn/QeVvE96MYCfJKKAQTbGxITY+pf+MxlvvdLdPPNaDOQQDhMj1x+89tPCvZqfYvj4/z+tdefqZFf79i1Daw5HcgpdJanmDHewf8epPishGG56Zx434hDeAxnKdJbifrRJY61DIo/okMM+1RmHOlkexwKtcKhTrONQi7W3n9R1t5z74J15jUpw4T4sAOJOFAMLW2US7xpl/jUsaJSiCkwWqEjlWgiYoATn44zLX8K0uAm7vLKdBF4H0wfVur/LaMAg9+co9r9xytJ+dEAVjGzNblgmoknswRBSVH9pN4bsPCuRCjbZHQvfCiKFJTBUCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(4326008)(26005)(36756003)(8936002)(186003)(5660300002)(6916009)(8676002)(2616005)(4744005)(426003)(9786002)(9746002)(33656002)(86362001)(66946007)(66476007)(66556008)(2906002)(316002)(1076003)(54906003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: loBdClUodBVzYyTuDzRpnTck30Ubfbh3VBUpl7pSCfIMd82jgm80B28Hxp27SOgHFQ2FR4qcxB8C/rvCblL1BImkDFhWK2zN5hHS+uV5K9SEVoMGFgBqaK2jfGgqBWUVqD/nr5jodZ3iZXyEPyYCVteSUPxftl8i38t2ezeBv6/D7NE9lF9+D8gc25D7I4jTKfJ7VTDJcO521pCFjilMpJmXdpqx2pjC9+YWcnUf8Ahc2+WvV2826LcLR0sWxR09TS+ZKm9AuGNIq79dyJrLEYuFEpBtvKuVxtK9KczB+qZWxwxB1f1DfSS+3L6ro5fdF7jc7as/RdUqj1bUfksUQJtXPjCUWVIcwRnmU5fCf07Pgn3pfGfbd5oFTj10xq3gXv9XoUGXZxMFR314V9QiPQb6zvvkoy5iz2alV5A0w6z5Yi7cplWHUeuPgIRaO5nX5k48RB9KrxHoEzSVDokdasnKoVoIP2tay0TrZCt8enQ=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0955e81e-696f-4667-0658-08d816a7df73
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 12:29:13.9430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rqkzYX0zWEOciT9/0bLfDJgbNHztQ2eHZUjphj7RnRordlaL68NNZExelEiDXbdMIexzM6oNKtE6bwa+yvc73w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5566
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jun 21, 2020 at 01:41:10PM +0300, Leon Romanovsky wrote:
> @@ -2318,19 +2313,18 @@ EXPORT_SYMBOL(ib_alloc_xrcd_user);
>  
>  int ib_dealloc_xrcd_user(struct ib_xrcd *xrcd, struct ib_udata *udata)
>  {
> +	unsigned long index;
>  	struct ib_qp *qp;
>  	int ret;
>  
>  	if (atomic_read(&xrcd->usecnt))
>  		return -EBUSY;
>  
> -	while (!list_empty(&xrcd->tgt_qp_list)) {
> -		qp = list_entry(xrcd->tgt_qp_list.next, struct ib_qp, xrcd_list);
> +	xa_for_each(&xrcd->tgt_qps, index, qp) {
>  		ret = ib_destroy_qp(qp);
>  		if (ret)
>  			return ret;
>  	}

Why doesn't this need to hold the tgt_qps_rwsem? 

Jason
