Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C11773DDC
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Aug 2023 18:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjHHQXk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Aug 2023 12:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbjHHQWV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Aug 2023 12:22:21 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2050.outbound.protection.outlook.com [40.107.8.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CC3A244;
        Tue,  8 Aug 2023 08:49:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cgn9MSxzseCTZAFKQNPcFIBL2I2JvmEcLJCQhdbE999DP81xGKKNXCkR69LMNPqPYAA0KS+VMZk5TrIhH9tm5RdFE3xnB5S2xrNXftNKWeIawygdFgmgdRiyz502g42LGvSydyEdovAEhSiTZzKJ6A4uqEvUXbOBc016TOfuRSrIQGVFoI05EHhvEoFAAcCxQJJ4ibT5LAtg/W2PFM5CsnRefw8k3eHz9RWOTnM/O57vB7XTb92zHf7rSNWxNoNjfkKVxqn6DjTzlQ3+zvQNRd1yOJ6SN+FCgdJkQGNPBkuap1/XvbPjTmbrT5eMoWmGXe0cTVyTJ7lAdqR3VdP6Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+C7re5OFhK6TkjxpsgvBHMNqORdVjihXHcLTdJm5GKk=;
 b=QRRmzR1AgZYT7m+8OlYXLptBMHrE4TXyLif3rVYy4QgGu+8X/AHWJrb6Mv+7tH6RTXnHpZV82FY9cuLX7r1fqouCoSIcHcdVFvN9D6vQXW2jGxW9MuYc+W7svzK3xf4ZK0hBB4s7FuQTO0tDZcFBO22b1q/kKThHbLrL/eVRCJVV2JdmdaC5sssC1Dcy+Up9iozplFrbcXMTjlRqnUSkCZWBozzH6NpR/FjRGLuETxcICgkk6Qslrcem/ujmlRTDf/mRroctjE9zeTRphKZTZT7C1DT+SoaeoanuMVwwZgR0zO3s+8266WaqHmoffWufbU8yZdCv1l7b2YDbZNWVlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+C7re5OFhK6TkjxpsgvBHMNqORdVjihXHcLTdJm5GKk=;
 b=saw0y8VduEcCPL2CeOmIk7RbH6V3NHpmfQllbhJIlJIhn9c188yB8cckKLwTbXLHEf/XQtFFaiCNqDm5Q8AUpojaDtcGUvx1695AmPVvpzBD9+4oq30YTX3KtekTaPc3a0r+f/iIh8ZT6aoqTpu3DxrXf4IZNNti6E//t+KZ6Zc3q0IRKpoUSJ2JyUvY4mlu/sGTvHgJ9J1Ue3x88K5SlfixRnlyhccav4hW+FlGsnjqTCbYrKjQgQ3U85WsrJnkzNxnZl37XG0NRmcNi6VBXjZ+wQzh/HTUrpFZCwD9+imUPBw6WQFzpVTv1AqEJN0aEdjRBpSjS3nfoKE4OyphoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16) by PR3PR04MB7403.eurprd04.prod.outlook.com
 (2603:10a6:102:8b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 12:15:17 +0000
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::da23:cf17:3db5:8010]) by AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::da23:cf17:3db5:8010%3]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 12:15:17 +0000
Message-ID: <5bc1e871-0788-18ba-6a01-7ce8c773eff5@suse.com>
Date:   Tue, 8 Aug 2023 14:15:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 03/10] mlx4: Replace the mlx4_interface.event
 callback with a notifier
Content-Language: en-US
To:     Simon Horman <horms@kernel.org>
Cc:     tariqt@nvidia.com, yishaih@nvidia.com, leon@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, jgg@ziepe.ca, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230804150527.6117-1-petr.pavlu@suse.com>
 <20230804150527.6117-4-petr.pavlu@suse.com> <ZND4iQMbv5LWNaZA@vergenet.net>
From:   Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <ZND4iQMbv5LWNaZA@vergenet.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0028.eurprd03.prod.outlook.com
 (2603:10a6:803:118::17) To AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3395:EE_|PR3PR04MB7403:EE_
X-MS-Office365-Filtering-Correlation-Id: a423ead7-1183-42f5-7438-08db980920b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fd2Eh6giXYGaa/hpF3hpmgDSb8UAK4rnGeVEhAixSzGXalCP3lrVlhxUzmIoRSyZ0EJW9zjqAdP1C3u2IeP3PMtnS8NXqelfqsy5lB+AF71tsi7iioCwqVXCdXz4Fgqu6onLZs9tdZ+hS0UyGle3Hjya0hAj6T92ojcgsLNd87iS12PsZm6hRx7wf1gtSXvmp/4vonDJSe/d+i7HUq4i+5/2F6sdEftPtQNJzdFN+0scp6hR3i1SzoAkRiMfoVI4ydoDgA51p4E6OlxsHrIYKylAKWYG0evUbxAgq13jomCuBcOBCnBI6bAIqXMGI/R0AjZP/ypue0Qu93v9qUkfKmt7FXHdWpfw32yDhi3EkM4cHFxBHtiToSU3zCAkUd/nox051ceB698xU09kkEjreWb2PINMBcnN1h302pfhtO3iZhIuZZxA8AwmfiX+VNj4yyGjhyzrHAOEQ1iSYLROlF0CNOwDrdP1IgeP01+dGHfF0JgHf4lP6FWvIhw3YGQooeqD+YgCh7k3gocnpz8QEGp4fHeuDsQNgqjl23pXCuej4v1GuRMafemuHMzWEODaozRFreaWHcmjvvZeeP6EVhgf2m2uQzuAy/Zi6/TlxxpTXtaLrEodpOI1/3cRVBIogGMEq0ayHi0ezlNQscP6jQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3395.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(366004)(376002)(346002)(136003)(451199021)(1800799003)(186006)(44832011)(7416002)(8676002)(8936002)(5660300002)(4326008)(6916009)(41300700001)(316002)(86362001)(83380400001)(31696002)(2906002)(4744005)(6512007)(6486002)(2616005)(26005)(6506007)(53546011)(55236004)(36756003)(66556008)(66476007)(66946007)(478600001)(31686004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGV1b3ZBOFNKSUVIMnRyUHE4aWpVcE5GN0lMZXU4T05VZ3ZlaWxUaEhmb3BT?=
 =?utf-8?B?OWV5d3pLQ2RZMWxrM0p4dFhNbkZaMGhOeEo3c3plNWFaZHZPWm1sL2JodEo2?=
 =?utf-8?B?Y3hXT2ZWYWVqYytRNWhhOGVSd1NkblJhUFpJL0tPMWY5dDVCM3VqMzdVWURI?=
 =?utf-8?B?eXVMM3VXYnBpR1FSTGs4eVNQcC9ZTnVxL1hRaElmMDJSSXFpNXFkY1JCZmRr?=
 =?utf-8?B?RWRMSW5JTHM5c0d0ZTl6WUxHTmpLcHFUYlNzVk41WlBXd3FBZ3M5R0o2Tm9S?=
 =?utf-8?B?Rjl5SHFQQXpkYmdsVlZjWlZQS0RZcGYzOXhWTExoRzcrRytuZ1JsQU0vTExY?=
 =?utf-8?B?WUdjaUlhNGIvNzA5MlNoRmE1YUFKWVJ1SVpQU1NtdXFXUC83a3pBUHcvY3Bt?=
 =?utf-8?B?SGMrczg3bGJ4ajVpVng2RTNhUlJUWURkWmJvQzBnWlFuUHd0ZzRmdDNZQVN3?=
 =?utf-8?B?N2p4MytQbi9Vb0E4OC9IdndPa0NYUElDYTJJWDFsZUdoWllwdnBka3VEeE9L?=
 =?utf-8?B?QVRUT1YraDVjcjM0emJwbkF5dGpNUmp5RmpSeUZqa2VGUGtGR015ZFVQZkkr?=
 =?utf-8?B?RGQrMDFDc2ViZy9KNVF5Y2VQdkxURGtDM2o0anVoM1NKdE1xUjNwTlRtV2ZR?=
 =?utf-8?B?RjVhSmYyMXNhNFJCaDVmeEhPTGRxa2xTVVk4ZUZFd1duVGRUV2ZJVHJ5alc0?=
 =?utf-8?B?RW1QUDdQZU94T0lXQUJEVWpYQ0VBZVVTS1paVzRpbEtISWIwelRWSUoxaS85?=
 =?utf-8?B?dGFOVC8vR3l1a1NHZVNtck4zQk15VkFIVTg2dnpOREhhb2hKbTcwUHBMYXdJ?=
 =?utf-8?B?WHpMZVp4SGtzUk1zVUYyWWtrYXhObmhERkk2M0U2NGVIa2lmOWxmQjBEbm5F?=
 =?utf-8?B?cFYzL0loMjhSbHh0ck9LSGJzSW9qd3dzSDIwV0xMbmkyNjI3VjhPdFlVUVpR?=
 =?utf-8?B?c29HL2xZMnhTZko3T2NtUlBTZ1NsendNYVNrR0wvRmxKSHRLSXVqcGlneFJw?=
 =?utf-8?B?NEQ5aFVoVWwxdW9tS0RFOVh2NjYyQk5laFJtNFJPSFg5SEw1dnJnWmI3M3Fo?=
 =?utf-8?B?WnZ0MkNXVDc5QUR1QU8rMXQ5ZFNSbi9WZGY0SUdoUmhvWWM3ckw3L0grTVNR?=
 =?utf-8?B?RkF3VUFiZ0VvWUU5TC90bmk1Z29kSG5jM1hSZU5VYkU3UFZVcGVBT1ZORW4v?=
 =?utf-8?B?N3pkNzc1UFh2U2JZdjYwZTlsSFQ4eE5BWDhobnlKRWFINlY0SDI4cFIwTGR1?=
 =?utf-8?B?SkswbDRlS1FheDNEOWROUklma3VyTDh6UGExYXBvSFJHckh3RWpFYjdadkds?=
 =?utf-8?B?aE1jcnlBRDFyRmwyL096WlNaWWFQMnZxWmRMNXpwcU8xRnp1OUp2R2RUR1JD?=
 =?utf-8?B?cVVBSzIyOW00bGkwWlVleDllWXV1ZXlpdzAxeGxCNW0rdFZCcGhpanFSb1hV?=
 =?utf-8?B?ek1aLzVsaHNUbzZ5bFUvSk5SRXkrVmZmRFE0NWdzMzlHTk1rcmJibXh1aXdv?=
 =?utf-8?B?c0lCSjJrRmNYcCtVTWFsRE14a3NrMWsramFCcXBSbExiRHpqTGdsYmlTdTN2?=
 =?utf-8?B?UTlYT1pycWhNaGJpSDVDZnBwVGdGSlZnckRGd28rN29jSVo3a0puOHoremVW?=
 =?utf-8?B?V0ExRjhhS0lMK0dTSnd4bGRaKzB1OTNJTFpGbXpibTVmaFhTOWRIektMZWkz?=
 =?utf-8?B?V3BpSmRwYVF1ZmJCTzhtU093d1B5N2VXUWtOeE5hSTdsREwxL3l2QTVCS0ZH?=
 =?utf-8?B?WmdLOEJpandDWTVvQ0N0TGltcjNIbXZodmgwNzVsNUQzcmx3bW1xaUVDRUpW?=
 =?utf-8?B?K0hyZDA1SGVuWUdnUitFckpOV0ZjbURrZkJpZTh3ZWtCcjliTC9xUWd4R2F5?=
 =?utf-8?B?Y2RQSEh1NU9vMUExSDM3akR3Z2NTMVhVSml5M2UrN1ZpbVNITk5jdG1MMi9E?=
 =?utf-8?B?T21QbEtWN05WQXdRL2xkL0pVUytkVkpQcFBPT1JSVWNicEp0alNvL05PVC82?=
 =?utf-8?B?REJEVzd3cVV1SS9rOXRXbnJpN2l4VWlpNmtaYWFQckVSc1FHbjVxMU42UTZW?=
 =?utf-8?B?TWZzYlNHNFpZaWVkZXY0MllYWnZLb1lhcTRYZXpaM1RxZ1RyeWpKcWhrQWFL?=
 =?utf-8?Q?5DTD7kRYPtYw0G7c39kYNe5SO?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a423ead7-1183-42f5-7438-08db980920b2
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3395.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 12:15:17.4969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +gJ7UTwGwHF7Zyty400BcmDToEOgr1oUQ959Zj6jgM31s59AR39n0eVrtapZwXjErYUgF89cFE0VH+LiLdFL5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7403
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/7/23 15:58, Simon Horman wrote:
> On Fri, Aug 04, 2023 at 05:05:20PM +0200, Petr Pavlu wrote:
> 
> ...
> 
>> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_main.c b/drivers/net/ethernet/mellanox/mlx4/en_main.c
> 
> ...
> 
>> @@ -326,6 +333,11 @@ static void *mlx4_en_add(struct mlx4_dev *dev)
>>  	mutex_init(&mdev->state_lock);
>>  	mdev->device_up = true;
>>  
>> +	/* register mlx4 core notifier */
>> +	mdev->mlx_nb.notifier_call = mlx4_en_event;
>> +	err = mlx4_register_event_notifier(dev, &mdev->mlx_nb);
> 
> Hi Petr.
> 
> This fails to build because err isn't declared in this context.

Ah, the err variable in mlx4_en_add() is only defined by a subsequent
patch in the series. I'll fix it in v2.

Thanks,
Petr
