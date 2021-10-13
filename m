Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D0D42C2AC
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Oct 2021 16:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236349AbhJMOSW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Oct 2021 10:18:22 -0400
Received: from mail-dm6nam11on2137.outbound.protection.outlook.com ([40.107.223.137]:53601
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236409AbhJMOST (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 13 Oct 2021 10:18:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mlAKpCuPhpozYEJJqn5whCJ/vDCEIhcXHq4iywJHNN7h52QjQd9Xdcd56tKcJMI+WQLtCkR9zWthkIbnOreQQgTraI0Fkx9PDofxqr66TdC8vusc1xET1wTjV+snvWa/GNqDZaH+Mn0V6rLdOnCb9O95KoCqYo+4DCNRv9dcrL6Ki+di+vRCjQM5oF9O01k76dikzFapNnJKn8oyoTQWQ9GMpd8dglEIY/gxQHWXbKp2g52Vtw1t7TO2xOMHaOidWY4Pzod1K4FptXaWUxoTXCJi8bIXEJ8dXuf/Hh03atxBJ3GuzZmvnKKV7VGAkpzHNmITlfstc+OhU8NFP5nDCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4HSSWl5MpmNDhyX0OGZaI6Wk/qy3GBh35DrO7J+6Yo=;
 b=L24VE4ofTj2wX92ZVo1KdJzOZ64DrMohMfCvDYkrJhaPC/VxKW7jvv637ARVgFcvRDY2DQMPzP0n+C3R4VpiNr88ZNtje0yng9VeV/cpEIhHbPHMYJISk/9tM4AYOib6igyDacAdQ9GC+grakucgNIDMtHMXHgeV00N8PogpWpSNRHdyDpzekys6KbgqzX/9+zrfjz1Tcb04wPTPkII9Vv6w1fXQDIN8hRkc7/KvWT9M4W7pG7x+yVcF8DPkNZflcIbzGmVG8TGako1Sd7tbAj0bHWEYTF9gN1pTF9+I5F8JsA51hbb71tLZ4txA6O9glwAZeDmrS3XmFHeRXNLgnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4HSSWl5MpmNDhyX0OGZaI6Wk/qy3GBh35DrO7J+6Yo=;
 b=LeZG2row6XaBizLcoWQUGDySaDrOzRIYHMNekv88OcmOBTUHC7kyZT2mkLheAbwprAsjeFkzKX+dKmdrGK0PN4uxcau13ZErVf2lSQfskwbcz6dAqBGUft+WMDzk9CcfdwdYNY//kWomxiK5wFBT1UQr2Cp9GAOLtdkvhac3W4tBv7xW2+nicEhsUSMsxU6PVrmfjX98Hu6D/LAJgdeiSnXxRfvSstXbSVnqQ6C8zaZkmYyy+95BaEwNlMVK2y8qMwxjz/wlrnjYC+rAGgLjeNr14UE+Q8asd+5u0j5cNKAxGv6kmEqFitnrmM44ad/uSGkbhtQBBeaeo43PVgld7Q==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6408.prod.exchangelabs.com (2603:10b6:510:12::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.16; Wed, 13 Oct 2021 14:16:14 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::88df:62ca:347:917f]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::88df:62ca:347:917f%7]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 14:16:14 +0000
Message-ID: <f9ef1de3-6aba-1656-a478-1b7af60ffcec@cornelisnetworks.com>
Date:   Wed, 13 Oct 2021 10:16:08 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.2
Subject: Re: [PATCH] RDMA/rdmavt: fix error code in rvt_create_qp()
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Gal Pressman <galpress@amazon.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20211013080645.GD6010@kili>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20211013080645.GD6010@kili>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR17CA0006.namprd17.prod.outlook.com
 (2603:10b6:208:15e::19) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
Received: from [192.168.40.173] (24.154.216.5) by MN2PR17CA0006.namprd17.prod.outlook.com (2603:10b6:208:15e::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Wed, 13 Oct 2021 14:16:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7937f4c6-ff99-4e55-572b-08d98e540366
X-MS-TrafficTypeDiagnostic: PH0PR01MB6408:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR01MB64087962BDC9CA09098849D1F4B79@PH0PR01MB6408.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9nuz3Bd5+sZNR57IX2g0IQHS+5Hq7/B+O/EelXH/XOHYI51uvouPC5s2csAUyrKYiSUiwYcd6PR0f+wvCgz5f5EIKvYpx6Hiw5Loa018jOc78rVKESidm4TYXniMtdZtnWOomUi7BYURtS/y/vSl/GGY4MM4U2L36JwEfOVx1Y34aCywhtOATuf0xaGWUyOP9qENmEqrLawbEdsyiiyzRwNtzQsN1o5uH29Tz4rIrItTbA1C7c1ay+ipDmerg1Pi8X8wy5g8r4kVMLvRHWNVGDKqpEQN+2KYnrZfmSskPYqdhG72xQB3GBFKz+Tp3EgqX3Ru7l/junb4JYLmstvjO6KiSmipZUZI2K2AtH+CEurUUdAC8JQQcfsdRCjOZbIvHXOM9XnRKee31C8w5x43sBWTBjzzQRM6qCR1YjOvxogLtPhadvaHLAwunreScif8MSwnK7Y7xFOGvwAtw5Q2fo56XZP48VZwH1gEJ+qSE2s5nvrnrhobhYUV5clQKO4lf9Vs3vxfVRfKW2SyuMEpv1g4Jp0r4ZBEZ3LgiJ+9fcPDb7o6MuhwfR23QtzaC1Gyx8NegseceeAY9Jupl+78gpwiTSZOBSxl/CsdtGy0wsyS5SHoxMfnCU+xGehC1ZQj0k9XdRcol1sSlKrKXwodra+le1fvSe6GJKla/1hMSpmiahx5fyFoGVDkGkJxrytH9YppDkbN9XMTxJKfZPzq1oMcBLt5jc72kr2ZlSTbiDolrZhDpjtUw+z7ybGGxy4mXytRoIvP+Y39rHeA2XS4fw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(39840400004)(136003)(396003)(8936002)(2906002)(44832011)(6666004)(66556008)(66476007)(31686004)(26005)(54906003)(6486002)(110136005)(4326008)(5660300002)(186003)(16576012)(316002)(36756003)(508600001)(31696002)(8676002)(86362001)(83380400001)(38100700002)(38350700002)(53546011)(956004)(66946007)(2616005)(52116002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1pEalpjSzJwbVYxY3RrQzloRWFRTG5ZVlJuWEhPdnVrZzQ5UFNrWEdRYWZo?=
 =?utf-8?B?cmJoUFYwYmtJNTVQTHE5UktzdWFvOEtLU0pSQlAwWFNBM0djb2xySkgvbVV2?=
 =?utf-8?B?Szd6UG9HYjNHZmxwdk5Mcm9KbTNsWHhReFgvRU5Za24wSXhaVERsUkg2UTJO?=
 =?utf-8?B?OGhRcjFtb1ZkRm9DNnlNenJZejROMXhnd2s5dTR1ci8yNytwa0lGMDNXMVFO?=
 =?utf-8?B?NmRLa2ppZkt5OFlCK3ZUQ0RiSk5kZG9KUURCR2RCSTBPYmZNL1ZrM3dpN2Y1?=
 =?utf-8?B?dGlmbFN2aWVSU1FMUitlNXlqcklZSDd4d3lTaVB4MldSWHdRNFBGcU9xMkg5?=
 =?utf-8?B?dFp0Z0k4VENWZk5NWnZWdWVSdnNtcnhOczBxdys1dzVDekpwZ1RjaE8zOWNy?=
 =?utf-8?B?K21ROGlpZGJGZG1PaWRwdEdZUktoQm9KR1YvdkIzcXU4RlBRdUhaQ3ZNNWVt?=
 =?utf-8?B?M0lWSzFZT1V3TG96YUNISEJ1YXdsOWFMQkxRKy9PQXNMR0lEa2VvM01ZVHJ3?=
 =?utf-8?B?azFtSzJ0QTIzL3J3bmoyRXFrUzdYSk5VWkMxNzZib1prMFRpRW96bmNtRHN4?=
 =?utf-8?B?ZTc4eGZkQmJ0dURpQjZBcDdUSVIrQmZzYUdUbGZxdWU0UWxuZ1cxbGF5OXVG?=
 =?utf-8?B?VmVqdThSR09ZSGNOOHQvM1V0L3ovTzQ3ZWFEckFkVFlPa29rYW43UzdtalJ5?=
 =?utf-8?B?d0c4T3lSeDVTd08vSlJCVFVRU0xuVzVWWi9vNE10TzFNMGNuSGFRdXdnTTNv?=
 =?utf-8?B?Vk1CenhNeGNvdzZ6Q3N4SkZkRE5kVW93U291UHE1dUZFZUJKYmQxYkswWXhX?=
 =?utf-8?B?MGZSbW8xRlI2MEdnV1B0WXUybkJVd2xtdGdMMW1GNzdRZTNBMVorZ1JzUmhL?=
 =?utf-8?B?NFdxclU1YWtSakk2anJ4bW1aZ3laMExSOE5ZazhpdWJSdjRWa1VQUWpPL0kx?=
 =?utf-8?B?R0MvZGYwT2pTeEtaUzdjSFMzTWU2bTVwVFQ0bFhqQUxsay9QUCtjSWVwcm5O?=
 =?utf-8?B?MjAvTUFQWmtUZXFPS2lNK20zVVdUbFJwOVpRdmFZeDhuMHFtN1hQMUlzSUJ2?=
 =?utf-8?B?d0VYZ1RYWmlkdUNJQVNDYzBhMnJHc0xiS1NlNlFnMElQWG45K1ZkeTRmQ0xh?=
 =?utf-8?B?Vk5PbGlsODhHMHpmbENNQTFSaG5IUklHR0JRcHRubUJzTkhwTm53MDZ4UU5T?=
 =?utf-8?B?aEk1T3FMRStVMFhCZmZYSDVVQ0Y3Y1JiMVJ3UmhOT0tZKzB2U1pzUy8zUEdE?=
 =?utf-8?B?Y2VIUEVoY1d2L1VjNE9GMFVsOWlrNzUyUmFnVVduKzg0LzJ5Y1VPRmpLUWdZ?=
 =?utf-8?B?L1h1L2JEYm9qblV1eUlSd21Fa05nYVNjWFJnMmNLamMwWXNTcWJPY0N3amgw?=
 =?utf-8?B?TlU1RU1adlFnSGFlVkJHd2dORE5jU09NWU5HTXVBNU1KRFd6aEx2bDZKK2Qz?=
 =?utf-8?B?blVURzBtZTRCWVdzUnlyWjd5c2hRclFlWTk2NHcvemVMdithMjI3YnhnK3lr?=
 =?utf-8?B?ZkJVT21iUlhaQnYwYkZhZW1QSmxsZVk5SkJMVkttK2d1UmUyLzJoQWFiZWI5?=
 =?utf-8?B?UlRncHJUU0VzM1lWNm1kdlkrcEVTUmhZNFJ2MDNSMVY5K2pkV0tReGt5RXZu?=
 =?utf-8?B?NmZtQ1RjUHFCZXZRSEN2NlhIV2pIbUNQWTVad1U5eXVGL3FncGFrVzlLMGcr?=
 =?utf-8?B?dVkxL3RaVExiRkhQOWpwUStoam85YVZXcXAvREw2ZGd5WEtodkhQczdxNFMx?=
 =?utf-8?Q?sMlZXPGBw00iO67T4wvPaaAAsDBd5EeGhKqKnyN?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7937f4c6-ff99-4e55-572b-08d98e540366
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 14:16:13.8725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hYefI7ASJxy7pYwkKe1mGCjwau3vtISgQ2BjzmBL1S1gMFxZDE47TkNGZumSjA6DQKYV92PR5JqMPXwYKzERsiAp3Ql6Q3xsO0OW+0rJb/+iTjtD0JNOBoPIlTQaIx2c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6408
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/13/21 4:06 AM, Dan Carpenter wrote:
> Return negative -ENOMEM instead of positive ENOMEM.  Returning a postive
> value will cause an Oops because it becomes an ERR_PTR() in the
> create_qp() function.
> 
> Fixes: 514aee660df4 ("RDMA: Globally allocate and release QP memory")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/infiniband/sw/rdmavt/qp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
> index 49bdd78ac664..3305f2744bfa 100644
> --- a/drivers/infiniband/sw/rdmavt/qp.c
> +++ b/drivers/infiniband/sw/rdmavt/qp.c
> @@ -1223,7 +1223,7 @@ int rvt_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
>  	spin_lock(&rdi->n_qps_lock);
>  	if (rdi->n_qps_allocated == rdi->dparms.props.max_qp) {
>  		spin_unlock(&rdi->n_qps_lock);
> -		ret = ENOMEM;
> +		ret = -ENOMEM;
>  		goto bail_ip;
>  	}
>  
> 

Thanks Dan.

Acked-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
