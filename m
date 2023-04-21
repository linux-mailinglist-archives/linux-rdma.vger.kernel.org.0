Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42AC16EAC3A
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Apr 2023 16:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjDUODC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Apr 2023 10:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbjDUOC6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Apr 2023 10:02:58 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2113.outbound.protection.outlook.com [40.107.92.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661CB118E2;
        Fri, 21 Apr 2023 07:02:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7tt2QlPi3gWGkCqBNkBmsdPFRiq30X8NJMt+htJiqd/8iLMtc2cBAJrHUD0jKPTw3gTSGj81Texa6Dtxgp5SokzIjEOPPUmGi5lAcreh/AvWntKi44mjFBjFQI/UrUk53q27bY5Rv83WN/FU9R0Bn0dm2TYxg/1RTWeHpQFCmwXwgOKveQXa+uNQXNewk53SWhGs5yF5K4VHrSdFGJWXuYtNMy4uvoujCacIGw7BGsc5AlkEDzkdKK+VBx4yeIZSk9+zRSbuQMj/SB9uOKvW2TG0NhHsgvh0pXWo0MVw+jxgXJMACQ+HcaxzUSA8fqIb6dWSefhRNHZ2gvdhAo3GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xRCSrcfoChNmgWXBXFBccyx4/aOfLmAmnjNBve9uoz4=;
 b=DklzHE72octw2SBr3NEBXVzh/DMUsw0gZlaXo2nYbQYc4nk7qtYJvtcvFLwu1D4rkgiGoLzYVaS9r4oQQNPGMxePOmT7W7gu2sHbKabbW/Lrx4tUuuiFLcKqvBczfZT4ntpZT+jJBI+GSuDnqJaCbbzgOJsZq/ufIKiEzk1sS8VvX9peONOKNJ+ZKRMD2PQE/q3HaqTvD+41d8QjxGi5ChnaaBuoiVCuYLqlhy7eiGuvNcUyN1yKMs6hoCuVuIuKd8/w7+/bMgcnezxaohsAEBkCFpQrxQkI2aexiXvsVz2tVkTQW9RIriXZ+j+1b55NXg+AvP18dqjaXzsAuhO3vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRCSrcfoChNmgWXBXFBccyx4/aOfLmAmnjNBve9uoz4=;
 b=K/qAwgeyv53KiMCPbLw29EQtYJbybs7v29XGyyxT+tLCxgalyBCqhsZ40AGXxBhiVKInndFlXUN8WLu0D5s8Hc42pkEfLoKrdkinF1cENOO2YWX8qlrDz90LXEiOjgPpHKHt2YuIQi2PP8OeuCBYSfdtXAstikTMBewTLDRUetrFu0gEBgd/MI54HY9OYeF8Um/1TJThNxoxLg9oclSFng0FIZjWUJXUU1Lc0CDrp2E2EhnKjBzDQA5XXNqqFm19sOrjNPhc8FxNriY5lr8/ffwORy/Aq09eN02JY0guryEymVV5+2kGlM7SARkeJi6rP4knDPqRyNzKJzlQ7+/TzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from DM6PR01MB4107.prod.exchangelabs.com (2603:10b6:5:22::24) by
 BL0PR01MB4193.prod.exchangelabs.com (2603:10b6:208:27::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.11; Fri, 21 Apr 2023 14:02:42 +0000
Received: from DM6PR01MB4107.prod.exchangelabs.com
 ([fe80::f33a:edf4:c24:d88e]) by DM6PR01MB4107.prod.exchangelabs.com
 ([fe80::f33a:edf4:c24:d88e%7]) with mapi id 15.20.6340.009; Fri, 21 Apr 2023
 14:02:42 +0000
Message-ID: <26ff5035-2d70-44a0-6f0e-3e934b0ae8b6@cornelisnetworks.com>
Date:   Fri, 21 Apr 2023 10:02:39 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH 03/22] IB/hfi1: Use alloc_ordered_workqueue() to create
 ordered workqueues
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>, jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
References: <20230421025046.4008499-1-tj@kernel.org>
 <20230421025046.4008499-4-tj@kernel.org>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20230421025046.4008499-4-tj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0022.prod.exchangelabs.com (2603:10b6:208:10c::35)
 To DM6PR01MB4107.prod.exchangelabs.com (2603:10b6:5:22::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR01MB4107:EE_|BL0PR01MB4193:EE_
X-MS-Office365-Filtering-Correlation-Id: 135c4b88-d5ec-4c5b-1ead-08db4271131a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6XvKgIe9YLOfRv4xevCz1Vt6QVLGbcrj0R2CKKr7IZdY7hGIVeO6JlUCJsILLyQ7fXqRNwNNirJ8BkAzbEdq35sSY4YvpuUtRhLdG9HMN9O9XhEmqOspomzPVPoBjBn8+DMWE6d/wEtC1RkG5wa3N55YM7K3ih0eTpxDe76Z1rwV1YJslM+q2gwOBVRFPHe2q6XQLx4NAWQlCfmUhgJybGmWLBGp1XaZWZ7WS7hlR62J32MAGC5LH4Z8BRG00xlANzMo3oekvAsHdhFGIEzKvRrm83Ivb9s4LWjD56CZgwHDwcTALwB7mUEJJ3A13G330ZB6MCmxWZSCOeScaCOVncCsee3sr2lWP4U0DsaOiqmahPgtLRK3aCwSL5qHOiMEZV3lA2CHW9zb1Bo2VYE92vXCLxIIX7oluv0KUSo2Id04kEUE79FlAm9FEShLxzQLWs+0zG53cmVNlgX6cQINhcCz5agYHV3NY2b/Jz0YYT5foNc1AbjmuZCp0TXCKoc3M4sevPcp98BOPEdpf/G2UgDk63OO/kFP7b2J80SMz0hrc59iC6EeUxHlNLW1hq2qoUKx3dJvHicsI/mD7/8XLNyjM3xgIVI5+bv5yMQ2PpKvWQl7KOETBs7Hpm8HyAvETyMOpmCYlTsXnKvFYp067w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR01MB4107.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(376002)(366004)(136003)(346002)(396003)(451199021)(66946007)(66556008)(66476007)(316002)(54906003)(26005)(4326008)(478600001)(41300700001)(8936002)(8676002)(83380400001)(5660300002)(6512007)(6506007)(53546011)(6666004)(31686004)(6486002)(36756003)(52116002)(186003)(2906002)(44832011)(2616005)(38100700002)(38350700002)(86362001)(31696002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnhjMGZBTjFlUlVyV1d5bEVGM1ZhVFREL3ZZd2lISWhKZkYwWGNOMUZtTXBS?=
 =?utf-8?B?bkJrbThDN2NCOUZTTjUyTEZLUjdpaXdrYlRNbWh3ZkpNWkdXdVpZZVM2ZFli?=
 =?utf-8?B?N0x4bmM3VTJPalVoQkFiTnFqeHVpUkNyRkVEYU1TYnVDYTV0N0RzdkpVQVpa?=
 =?utf-8?B?U05KQ2YxR0tyVDZxSlh2SlpXOHd0V1g5RDMybVJaejd1WjM1WHE5a0dHSVVU?=
 =?utf-8?B?dmNpVEs5U1FGMEJMTEhPeC9Sekk5QXdtSlNXOGxUMG4zN1hNREJqTnhLb2Jj?=
 =?utf-8?B?SEFJOHBXanp3Q2ZNQVh6bmJxZGRKSlloSGxEUEc0a2dLZWVXRlFabktNNnBW?=
 =?utf-8?B?MWhWMnZiTHdZWjZ5alR5V1g5cWVmUFkyL0UyMC8vUGpZbGxYTmRaVGM1S3dN?=
 =?utf-8?B?QzJ5Ymt2QlFKOGZjZnBhTTlCL1k1RCt4aU9PSHBwSmV0NWI3Um1TcDkrUUJN?=
 =?utf-8?B?UGFqNnM0bXBYdFVnQURaR3FUOHdtYm44QjdFWGdyeFU2bEU5cEZoNnF0OUVS?=
 =?utf-8?B?SHpFajQxWUhOMFNndUF6VTZ4YmNaTS9aK25YcmVMNVN0UTlYd0YwMTdsZ2xR?=
 =?utf-8?B?cVhJK25kZ0dDVHBFN1N5QmNYK2RmQjFabENxcVhZaUNXZ1pPQkxzNi9aZUxD?=
 =?utf-8?B?dWdJd2J1OVZHRmJHMXNKb0JhNmNYd1U4YWxjY2Q4d1RjcWxJeWRmN256ME91?=
 =?utf-8?B?QStDNWlzNEQxOHIwWk5zQnVqM1J6Nm5tUWZFK3AyQkxJK3dtWDlDeE1KSzJD?=
 =?utf-8?B?cTE5dEFUc1ZoM2hic2g4OFI5dzYwd0NQdC9ZdmFIa1FhekhYV250ZFZUeC9M?=
 =?utf-8?B?OUpmNkxad3d3ekkxbjh5U3R2MWp0ekdWZis3cGZuTFpMN0xjN1Z0Z0daSzU1?=
 =?utf-8?B?T1l2ZG9oYWFiRXpFbjlDK0dKdThCRytJMHBZSXhkTCtEZlpRTEwvT1ZnVEI4?=
 =?utf-8?B?NGVBcVM5RVh5MFJWdi9UUFVhQ0JGd01RZXV0eTJKWHpuMjB2NzZ1U0ZXeTBS?=
 =?utf-8?B?RG94OXhUbG5kaHFFMnhOMW9RbGFGMVVENFozdXJDbkR2dnFZU1RubzJGQ2JX?=
 =?utf-8?B?M3ZNaUdMT2cydUJhb25zblZUbXA4WTJBZlIxS0oxa0R4K0lOanNtUEVHRzFa?=
 =?utf-8?B?NUNlUnAxUlVkWnI4alNnM1VyVVRrS3FwWERrcTYxTlJLcEY1TnpCeFgvQlhN?=
 =?utf-8?B?a2ZWazRaLzJYUVQ2MjQzWW1vUll0eVFqT3pvUFJhWG9JckJhTDgvRklnT0t5?=
 =?utf-8?B?NVJvbXYzVndWeVBESGtYOHVsa0pFMjNBWVJjWENrSWtLUmpTa0ZhemU2ellm?=
 =?utf-8?B?RDg4WndjUE1XdmpPQ0NjeVhSZ3U2VEJGeFRVZTVOTFVDMmlJUGIrZnhCaksr?=
 =?utf-8?B?VndxUHBDUUZlQ2dQQUU5bi8zQmpsU3RXd1JVUTdPWDNBaUJleFRJd1Badzln?=
 =?utf-8?B?cjlMWnF2ekpCOUc5S0RvQXlzSWE2YnpCZHZPeFNVbFRFRE9FQ1F6WE9FcUlX?=
 =?utf-8?B?WnBDZzdTVjNiaGhqbllvV0FnMjBZNVpPL3dxN0JTOWthNjhaQ0FKTkRUck5Q?=
 =?utf-8?B?SG1KQ1FWeEM2WXFSVjZ2MnFZbm9JMVluTHFJc3A1MlF0dDRsYXB3WEkwT3VX?=
 =?utf-8?B?RGVtMWRDOHRYWlVab0xmNUhkdmdyblFXeSt2V01iSkNnNUFaSHdKZW54RGdn?=
 =?utf-8?B?bi82VW43ZlZUbGMyM3kwMzNFWXNYSFJSRWxacDQ0TXp6M1RDWE15cXVCSnEv?=
 =?utf-8?B?ZCtBVGMxVEJwbG5jN1JuL2trc1dxbndZVWhQdjZhb1h3bDZ1R1hGTFZ5QlZo?=
 =?utf-8?B?T0VVd0wreDVSbU1iQjJLU2VGanFyOGg1dGdNN2FXd2FkUUd1Uk0yQ2xiTTFO?=
 =?utf-8?B?RUhnTXVZTm93eDB3WDI4T2JQN3F0UjhlUkNGZFJ0MStDcUp6SWJZa1ZRZ2JM?=
 =?utf-8?B?YWhMMU1Oc1J5a0xCR2crQ3gxSXJEckVVd21GVDVaOTcyYlQ4LzFTd0Q4bVJF?=
 =?utf-8?B?ZnkyTUx1T2hOTHlhaURXYWhkMU1lSS9EYThBb2srOG9IQ2VZQlFJTVFpcU9H?=
 =?utf-8?B?ZzdzQkw2M1lhRDJKQ2svZzhENWxXNk1NT0lzWExPV3hjZnNMbjZBQ0F1ZklZ?=
 =?utf-8?B?bjRJai9pdHNDcWdJdlFCVDFSeUJxdWd1ZlpoMUlJWWZXS3M0cTRjNjRuS1Ra?=
 =?utf-8?Q?n2iUG9eUQzVpfPzInW138to=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 135c4b88-d5ec-4c5b-1ead-08db4271131a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR01MB4107.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 14:02:42.4690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SMifFnP5pWXnZT34SjQBI+tQb+oTbC7r05+nP9hQcXmtI8g6csYOqczoS4ejuBmXLXCeH0HDsrTXWJOhnW4vtaA1JelChlw2PQURLpwC3/5WrFp6rfspg/41XSknBYkO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR01MB4193
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/20/23 10:50 PM, Tejun Heo wrote:
> BACKGROUND
> ==========
> 
> When multiple work items are queued to a workqueue, their execution order
> doesn't match the queueing order. They may get executed in any order and
> simultaneously. When fully serialized execution - one by one in the queueing
> order - is needed, an ordered workqueue should be used which can be created
> with alloc_ordered_workqueue().
> 
> However, alloc_ordered_workqueue() was a later addition. Before it, an
> ordered workqueue could be obtained by creating an UNBOUND workqueue with
> @max_active==1. This originally was an implementation side-effect which was
> broken by 4c16bd327c74 ("workqueue: restore WQ_UNBOUND/max_active==1 to be
> ordered"). Because there were users that depended on the ordered execution,
> 5c0338c68706 ("workqueue: restore WQ_UNBOUND/max_active==1 to be ordered")
> made workqueue allocation path to implicitly promote UNBOUND workqueues w/
> @max_active==1 to ordered workqueues.
> 
> While this has worked okay, overloading the UNBOUND allocation interface
> this way creates other issues. It's difficult to tell whether a given
> workqueue actually needs to be ordered and users that legitimately want a
> min concurrency level wq unexpectedly gets an ordered one instead. With
> planned UNBOUND workqueue updates to improve execution locality and more
> prevalence of chiplet designs which can benefit from such improvements, this
> isn't a state we wanna be in forever.
> 
> This patch series audits all callsites that create an UNBOUND workqueue w/
> @max_active==1 and converts them to alloc_ordered_workqueue() as necessary.
> 
> WHAT TO LOOK FOR
> ================
> 
> The conversions are from
> 
>   alloc_workqueue(WQ_UNBOUND | flags, 1, args..)
> 
> to
> 
>   alloc_ordered_workqueue(flags, args...)
> 
> which don't cause any functional changes. If you know that fully ordered
> execution is not ncessary, please let me know. I'll drop the conversion and
> instead add a comment noting the fact to reduce confusion while conversion
> is in progress.
> 
> If you aren't fully sure, it's completely fine to let the conversion
> through. The behavior will stay exactly the same and we can always
> reconsider later.
> 
> As there are follow-up workqueue core changes, I'd really appreciate if the
> patch can be routed through the workqueue tree w/ your acks. Thanks.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: linux-rdma@vger.kernel.org
> ---
>  drivers/infiniband/hw/hfi1/init.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/init.c b/drivers/infiniband/hw/hfi1/init.c
> index 62b6c5020039..e03d867cda13 100644
> --- a/drivers/infiniband/hw/hfi1/init.c
> +++ b/drivers/infiniband/hw/hfi1/init.c
> @@ -755,14 +755,13 @@ static int create_workqueues(struct hfi1_devdata *dd)
>  		}
>  		if (!ppd->link_wq) {
>  			/*
> -			 * Make the link workqueue single-threaded to enforce
> +			 * Make the link workqueue ordered to enforce
>  			 * serialization.
>  			 */
>  			ppd->link_wq =
> -				alloc_workqueue(
> +				alloc_ordered_workqueue(
>  				    "hfi_link_%d_%d",
> -				    WQ_SYSFS | WQ_MEM_RECLAIM | WQ_UNBOUND,
> -				    1, /* max_active */
> +				    WQ_SYSFS | WQ_MEM_RECLAIM,
>  				    dd->unit, pidx);
>  			if (!ppd->link_wq)
>  				goto wq_error;

Seems OK to me.

Acked-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
