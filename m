Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35AE570134
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Jul 2022 13:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiGKLwf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Jul 2022 07:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiGKLwd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 Jul 2022 07:52:33 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DFE23BE6;
        Mon, 11 Jul 2022 04:52:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCD7tj9RO4gXfkOEAG7wy039uxysnD/FBKkPUhdFr/XlJ0P4zs1UL2a/zyCapcOFf60F7fABHDGpFwedUanB/yFUGnBeVp+QvfJ1fFI9wg+BziNVsz7xRCVB6S3l8Ncs52ib6QweruB3hRgz7Wobn2SZtaDt2FRfJ7h/jtr7T+SBQKcxq54aGmhuIO3HdOFYUNlXGFTWM2drNM5Cp4ZJy52GE4r83E9R5j1WQZXUvczDpOt2qQmB0wHNDZa3ayLxpvAbVULEks/bRJ12pKDrKlJE2GbCco7pH+t2Hr7nqzz+SxKuNmIiF3XYs4mdfX9G2v28Nw1rr3XYKb52nxw59A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEBMBkJG+haY9vgsBV+wpQzpTqd3J+hsUPIzhVtYovw=;
 b=YLH+FgSgjQ4EKgJXQOUQ70nh0qYvSUqEa6zRmpLiDM3/2ekifq7ois5TgLmEfS5xqzqAy+Gxq4We6iLcy91xm0iEh5FQY/IFLvGVCtrgVqUSmTrILpHKfTE4boaj+ttsgbObI2nWG/6AEjBUND2vVVpfQt/Ko713MKMYzHXRZS1If9ubx5uoaR3RRMHj8nBEj+Q8jWFvxHczmi6eIlt3t9gFDFDjcgE8HI3gjw1L7krjLbmQ8rjyLM6qgZ1ZJ7mpUmTMSUCtaphDd9kRXwe6CEuuOVBl3Dp1w62eBNvHP1VwbsluFE7uyo0ziBUkQeWHRYjiaFpi1USKwTrDTy2kGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEBMBkJG+haY9vgsBV+wpQzpTqd3J+hsUPIzhVtYovw=;
 b=eS0s6BIZTMG6okVZxkY1tKzz2m+TsEHxSQj+KMdocV/ceOUnHhCltBTS9JsCLRa7IRMY5Zy//nqTMsWzScbu/T4IBRWvvDAUJZlMxDI2KfeN5un2R7OGKXnJaLfYOd38/m00udVP78EHIiJ77NR3tyXZP0MfM0h+o7t+LAB6SC5pdwFj8aYyOaZC+0Jj98TqM77He06BBtoaAYhkERP5JP2Lhm+Rm2o57kNiEp6ibdtNXtoICT8B+q+unpQGtEHTD6tf5YuUzeXjiWnrZse4kX8ZS1tQH7zr3Y2QfTNr78mPvoiOy9lN+jJyKGpEJhspJ5/Ph8kDIR9+G1TuF3Ls9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 DM6PR01MB4041.prod.exchangelabs.com (2603:10b6:5:26::28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.23; Mon, 11 Jul 2022 11:52:29 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::4000:7ba9:d4a:c339]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::4000:7ba9:d4a:c339%7]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 11:52:28 +0000
Message-ID: <1038e814-5f0d-17a3-1331-8ed24a64d597@cornelisnetworks.com>
Date:   Mon, 11 Jul 2022 07:52:25 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH] RDMA/hfi1: fix potential memory leak in setup_base_ctxt()
Content-Language: en-US
To:     Jianglei Nie <niejianglei2021@163.com>, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220711070718.2318320-1-niejianglei2021@163.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20220711070718.2318320-1-niejianglei2021@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0123.namprd03.prod.outlook.com
 (2603:10b6:208:32e::8) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26fadabb-5391-4bff-5212-08da6333d48e
X-MS-TrafficTypeDiagnostic: DM6PR01MB4041:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9rIw7B+K72gzMyaFQYF+Qtfry6dwcImTFv1uWIfwedwehlK2Qo870fOvp4A28CvzNkUvKmTZqVShrVpOHrrZi8AfGrYksQl1K84PCZbhOE5f66uDizMiFI2G3JszaWu92QSGBgfsZpSyB1fxVAvsN9daX2n86g73OFqdV8uvKfaBlYX0IbBePDERd8p+XC7pfK3IqjA6j0dRDYdL1eDDmhwloIy9LHyME62QHic8iS+7goRR4YZFo2mNyG7P1aszE03UNKXqadxvifqNoL8bDyi9FAiRH01qgIGhlR1CK/WTLH6stXZid3NZJrwJAhXIFCecOZWsscJdSAvHvGIDmI/vFrmxfa6KwuRxZ9R76ps8qUIVoVU8R42lm0rpxsWjielRBnd1rbGsO9X2my6LXePBcOqqg17Zs1kQEu+y/VdwTLw5NZHQqnq3rhU8tFm1PLHN5xrdO9EZL9xZwyYoknPZvBTHJmz3/btCAcnXA6BDDbECBChgZlhj7YS4KCJwGwA1RaUsvk8/7y7UPl/51MLgSAqZxTPx32bl7kJdJ7h9c9LwSvxGYlL5BfgVIEdsgksgp99jsjjAzkqJZ1A2xrU/YyMxGpcQnhppo4sKEqvG/FrLJxOk0qTYZAU8N0ldGtFFsB9rqH7bP8wpz4l73aSpFMjR6K/nAdaRfOp1Zz+WzBGM5PBlwXMbWW70sA8G2pVlznOz+bPe+KVBFf5OeWwYbXqXaboG/Z8HqBVTHi0fQBULH3dS6i2UviN/0ARD02sLp1QU1z9x61f0LY4pZZbdGvyF3456H3Fj+hE3DqGRHXe/Ib1LfKBtgRhpftg9eX354Tg2DrlZHqLMAsf46OxlFzR9zW+mRTlwtXZVp6s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(136003)(39830400003)(346002)(396003)(41300700001)(44832011)(31686004)(6512007)(52116002)(86362001)(6506007)(26005)(38350700002)(5660300002)(38100700002)(36756003)(2906002)(8936002)(186003)(2616005)(8676002)(66946007)(66556008)(66476007)(478600001)(6486002)(4326008)(316002)(53546011)(6666004)(31696002)(83380400001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjNUbEFGcjEreWE4a25uTUhYenRyUFBGNFdtM1dRbVJZTDhwK1FFdlVCVDcv?=
 =?utf-8?B?a0FJUEplelVOd0xIc0QzM1hLS0NLVXlQSUVyUE1YV3c3eGw3UVpUT3ZnQldT?=
 =?utf-8?B?TUNNa3ZaVWNpOHRPcTRyY01yUkxRaHpPcXUrb3ZnVG5aR0E3QVV4TWxZa09p?=
 =?utf-8?B?T2hQOGdabGZqTjhVOWsrN3RoR0NPNENkTFQ2Y1FxbHFMbU1ZS2U5VzlyRk5D?=
 =?utf-8?B?UU1WVDRhRlRqNjdKckNVL0MvMFdaNVd5TU9mT0pkTGJmSWFhb0VNbStDWVF3?=
 =?utf-8?B?MHF4aldReWJIRGxvWXIybVVmaDZpUGpuRDFXSTBjcjlkUDN3Mys2WUN1TUty?=
 =?utf-8?B?MjZiVVNLY2VtUkFHc0dPZkoxZDdBb0pwR3V2aWJhWjVBRXpxTXJTcXpidm45?=
 =?utf-8?B?c2tXY2x5bzgwa1dCMS9HcmFRQ0s4RjByMEx1WEt0bmQ5OCtpZUU0Q0pHUllD?=
 =?utf-8?B?RGxpNFh3WnliRG9zVTFxcDl1Skt0eURNRVpiZVZYYW5tTGJMcWJDMU5wSnVk?=
 =?utf-8?B?ZG9TRlpDc01IWUkrYnErRVN3RUFqbk1HTy80YXRlVFBrdkh4TWR4SWdkd3Ni?=
 =?utf-8?B?UXp4N2hNZGJXSTdEV3RMRkpJWllrOFlxd0U4WEVLeHZZSXZnbDFFYUQ3a0FZ?=
 =?utf-8?B?MjJDZWlpdk4yV3ZpZ3FNNCs3YlhxMjV6TnBBc0lxOUJLRkE5ejZIay9oOUt3?=
 =?utf-8?B?VlJRdlhxU1gxODNEcW95Y3FwcGdBYjRvWWM1THlleElRa1hwaUpTZ2g1bWRm?=
 =?utf-8?B?KzFjdFptdW9DUHRRNURTNHpMVEJDMjVqYm5nVy95YTZOZExKbDhWQlZnZHBu?=
 =?utf-8?B?WXdCREptQS9CWHJGUWVyeDFSQ0hpOEtNSXdIZ3BmcjRLWnFEa0YwbnliTlA1?=
 =?utf-8?B?SDY3UWFVN25hVUFwWGF3UXNEQVBEb1FhV09VUHd2ekYwMXN6UkJYNm5CZDFJ?=
 =?utf-8?B?RnVtengza0x1akxYcGtFY29WVVVIT2U4ejNZU01UNkFFb05EbUdZeDFNZEpk?=
 =?utf-8?B?d3hvUjNxaWxJTyttNVJodEFMUHpvc1FkMFlIYXhZTTZoZjJIZEkzbENWaTk4?=
 =?utf-8?B?U2FwaTY5OEg0a0YwbThpYVJlL2NNM3gyV1JhOE9Rc0I3MFdXcVBqTitJZmw5?=
 =?utf-8?B?TGlpQ1pjSC91TkVRMUJMaG9OMFZYK2lGaC9pcjlBUi9EZFk1bVJGMDR5MFcx?=
 =?utf-8?B?Z1A5OS9XUXJLN1N5dFBTc0ZvSGxaR2toUER3Zlo4cW1BeFN5bjlDdEc5M2xU?=
 =?utf-8?B?SXIwVWZMRGQzSEY0TlE0UjZORWRlMmhSc2xxellNc29iYnIycW02OWRpMHpC?=
 =?utf-8?B?cEtiZ3JWeWFRQUFNSDYzNnhpLzJ3ejhINGloMnhPdzN1MmlIaFp3V3praks3?=
 =?utf-8?B?ZVJhSDdJSURQcXFHNE5oUE9NNWxSa3d0Wm1HSnVROGZ0ODZLeVNtKzlVVG55?=
 =?utf-8?B?N1REYnA1U1ZzbG1Qa3B2dEorR0RhVlgwbjRvS05ndGIyQlZ6ME94eVQvZ3ZP?=
 =?utf-8?B?R0pJaDRrcE5VUHpvVmFnK3lRWUpMdFlIdmFVbFdUcy9Hd3NLOVR3cVozT1ov?=
 =?utf-8?B?M2IzQjhzZ1NUTis4T1htN2FLTFJQVFVnMXhpZFRiNDZTVU5SVnh1YUp0bk5V?=
 =?utf-8?B?WTVxMHFHMDA4OEJuK3VHaHZ0aDhEd0c5K0YvZ3c2bFRtUmlsbFEvdHNkOGpy?=
 =?utf-8?B?TzdZZFlZNWFVajdjMWl0YUY2eDNkWUc1OGl3Wno4elZ1TnN6SzgwWTA4QnA4?=
 =?utf-8?B?UFV0TkpsTTBuY3RzTmVqcGpZdTBlaWtHWDcvaVNnclM1azNKZkJIalpCZTNl?=
 =?utf-8?B?SU15WUV1TWJQU2FNdTVmMmVlemc5TmtkSHJSaVVBc0c0MXd5WkNORk9Kbm4x?=
 =?utf-8?B?R0E2cEtYcmdTcDd2R3lPUUExN3ZvM2gyQUpJWWcxcmNCaHlHUjBMeFowVkY1?=
 =?utf-8?B?NzUvbHRZeEVrYWFoWDhmRTZCZWlHMTNRazg5S0lldXBKbGJIZzJkR2JzUmZ2?=
 =?utf-8?B?akd0WTBEVnBLZTk0UWQ2M1BTeENhMmdDbGZpRDZyQzhFMG54RlZ1MzFkclBV?=
 =?utf-8?B?Nlc4NFlhT3RVa0loTm5mV2ZQZVZFRjNIOXFxQnJMdGxiK1VrZjhRenZvU2NE?=
 =?utf-8?B?VHhVL2lsQWQ0WXVodjhWVUVJeUsrK2krNS9ObWdsaEpLNGhCVTh2b1cvaTlH?=
 =?utf-8?Q?XsnDdvWolX9P2q4phN6CyjY=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26fadabb-5391-4bff-5212-08da6333d48e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 11:52:28.8175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: akwxG1ey8Jav/hy+3q+7zy+356AHfmM206BdSMEmh2oOeJtWax9+gHw9zC+A1yG4ICbIPNfBqzK+lKjdRLIjpA0Q38eGp5x6LPLpCt8RHEUZEKYjklg6JJbL/yVl5eHK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB4041
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/11/22 3:07 AM, Jianglei Nie wrote:
> setup_base_ctxt() allocates a memory chunk for uctxt->groups with
> hfi1_alloc_ctxt_rcv_groups(). When init_user_ctxt() fails, uctxt->groups
> is not released, which will lead to a memory leak.
> 
> We should release the uctxt->groups with hfi1_free_ctxt_rcv_groups()
> when init_user_ctxt() fails.
> 
> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> ---
>  drivers/infiniband/hw/hfi1/file_ops.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
> index 2e4cf2b11653..629beff053ad 100644
> --- a/drivers/infiniband/hw/hfi1/file_ops.c
> +++ b/drivers/infiniband/hw/hfi1/file_ops.c
> @@ -1179,8 +1179,10 @@ static int setup_base_ctxt(struct hfi1_filedata *fd,
>  		goto done;
>  
>  	ret = init_user_ctxt(fd, uctxt);
> -	if (ret)
> +	if (ret) {
> +		hfi1_free_ctxt_rcv_groups(uctxt);
>  		goto done;
> +	}
>  
>  	user_init(uctxt);
>  

Doesn't seem like this patch is correct. The free is done when the file is
closed, along with other clean up stuff. See hfi1_file_close().

-Denny
