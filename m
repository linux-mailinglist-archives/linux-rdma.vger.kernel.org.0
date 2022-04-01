Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFBA14EF249
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Apr 2022 17:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242234AbiDAPEX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 1 Apr 2022 11:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348900AbiDAOpD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 1 Apr 2022 10:45:03 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2131.outbound.protection.outlook.com [40.107.93.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11F92976E6;
        Fri,  1 Apr 2022 07:35:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VeFI5tmY4IjOwRLndJJAmbdVYjwLzfZ9bXjc/zcsVToNpdmZfdI7jqVqaW8eLaJWS5oR4lw+RH2RJVLbcibX8llXJ3TBBb4ZWgept2iStoBmO4VFtvLa3yYOyK+F0vvKd1EWsfZ4w8U7MXdUn0NrA0kvZkc+CKxTajiUlOEPMZlbTrdCZDo+xs0xzisXWuoiIWq73X08mGnDUFbe5rnzqXVCOJZHuJKwbyKuktkC9m/gvI05SQPr/Gsm8qM5afRcoMEmI0CgY+jaENqbD3oU6O7OEbpTRKLUqB6cNCgos3Grzy9a0OTLjY+9zbYvm1jC3DFtZwURtaRM7h35Euao3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JjXhLMP0QJ/PQdyr2LO98rgNwGJpzcrykvJBye00gec=;
 b=KIuLd+zGUnZVmSeKRwkYkGzYlri+zan6V7r6A0a3PlgX5k9PhIFDEE6lO4kdYOcWo8WmqGwCOpbqheXD9Aj/QZVFpW1TiT1ckX5DTFKZ1dFEZH3Bsl+E/0AFoz1VE6jYoGiDe78Fau1u5B8LAKpHmfZ0qiG1krJG7fAssWIVt/96h06WYnI7Lqbm7ggfZ2x+5b8co7wsiasG8naGLJZZjA0xhQdfCceo5i1hz+xCmbsczOQfCnrrIxiyhT35FqOpFFyewBTI5SiZ+MtAdvJCmtdErq+bokY0gwkMLJ3k6IW1vyyAl8ZK8d2UsY6090mGCoUIQFs5s2/r3qI/dCw+Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjXhLMP0QJ/PQdyr2LO98rgNwGJpzcrykvJBye00gec=;
 b=ZcH6gMjUSXnzzKRuGoE+KDSxr+oHLsUXlPcO+W0x0bWMzqhWRNxK/yNvdbWlQ/uFKBRn7b1JSluKF4D8+pMZbXVICHHe9+K6EOmoX2yLiprWd3VeX0QzKJAlJl4nbPz6IfbvR2yLmSEWR/OBAZ3Qkm5xuxdD9UqDMf9Yq2VRlfsCpsnjSm/WHWnddRwWzfSEZUs1bmzUt5I3tb1j2ke0bjGcVJ7LAWgHPA230b+bUkJPWJJbM67ZMa4M7Zp0v1ZUnBlPomsA3Y7No5xu5gow8Q70+ILvEF2crRzP9taiktEOZvmWz3PbfK5T6Z0LzFFoYsiaR94msH7B52X4hxw4LA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 BL3PR01MB7042.prod.exchangelabs.com (2603:10b6:208:35d::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5123.18; Fri, 1 Apr 2022 14:34:30 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com ([fe80::98bd:3eac:d0e:875])
 by PH0PR01MB6439.prod.exchangelabs.com ([fe80::98bd:3eac:d0e:875%5]) with
 mapi id 15.20.5102.025; Fri, 1 Apr 2022 14:34:30 +0000
Message-ID: <0d3e61ea-b3b8-620a-f418-0c91b381b67d@cornelisnetworks.com>
Date:   Fri, 1 Apr 2022 10:34:26 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH] IB/hfi1: remove check of list iterator against head past
 the loop body
Content-Language: en-US
To:     Jakob Koschel <jakobkoschel@gmail.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
References: <20220331224501.904039-1-jakobkoschel@gmail.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20220331224501.904039-1-jakobkoschel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0433.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::18) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55f4db38-92dd-4c2b-0651-08da13ecbb12
X-MS-TrafficTypeDiagnostic: BL3PR01MB7042:EE_
X-Microsoft-Antispam-PRVS: <BL3PR01MB704229FA96615F9F70C92A2DF4E09@BL3PR01MB7042.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZXyYDKiT10jKT+IRgOzsF4mVREt+bm7d0N5s7ALbhx1HI7Lwz+/yWwuqsgNnMPLgMhT9MxcGRD6m49g8Qe1FsipUnsRgwqn7FGG8mt/kqZ5f+qLn4C1yPHzAgCvpOOQJMBO/LFgcTV6QwlQzJfUK3pzqCP8ItJrxs0opWkzMX0YHFGtati2EeJ7FIUMbPagw2EftJynaSjgvDkGKVA20gkwQS4XoNb5fmoTY9qyFcL8DxVWDwqHPrJbmCYY63mfzKCOOEBg3XzQfWuSOv+TZuyZC322Zm5VkkFb3d5+u7nzWxzgRNfPdHAmWIS0juFblHdmKITWsYUzfRLoZxS7Lnux9HWpPCljsJky7PuCxFoVYkSGTkXYQd4QtbJ0buaZhgkQgk6IwTN7rnUXn1KsGFsgx9+F/rBEw6hNwxtP8O2Ve/Dn5aLkLZP8C2Gc9z5kT5KfEjHeH0sDJLozeTYxaJTNJBy3rhd8TJBYUXIhdTwb6pMgNs+zuuPtonHsnTGHBhOh+AxUPajcRrVMKyBLEaVdeWuhW5C7pt+MqzpOVrcpjfKoU9nlHNmzJaHgjgawZHjB/6bCuwTDOby1FdF70ZH32ZlzFovEsQDKDmLGReCjonGj4GLRoKqBmC/gzUfuoCFFjLcgm/6+3P21O9kX6E4vL7eKu+1rvM3BV7Rbe7ie/tKwBWsK/wbMihOZiFV4R5YB2JCPrpHmmo21HIxBJZgBzH95CBTXAdbNCLJanhuOF9nBLvdVjTVz0+orsfVAn/aVsp4hNsf4JJ6q6iXNz4lhnpjGTRD5h+ulqiOSiKxqFG2FoeGboYRFmcY0f3hq+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(39840400004)(376002)(346002)(366004)(396003)(136003)(6506007)(2616005)(6512007)(186003)(2906002)(52116002)(44832011)(53546011)(26005)(8936002)(38100700002)(31686004)(66946007)(54906003)(110136005)(66556008)(66476007)(6636002)(4326008)(8676002)(966005)(6666004)(38350700002)(83380400001)(6486002)(5660300002)(31696002)(508600001)(86362001)(36756003)(316002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzRTTU9UVmd5YUNXZ1VMSkI0MzZFc0xDNExscDZxUzVjUnZRZERkUkNEOHI0?=
 =?utf-8?B?QlNacHJ1VnRycEFnejVaMzBQMFBZeStTZXhGU09jSUFmVmtlaUlXQ3Z1TlFJ?=
 =?utf-8?B?djIyNWFSVGU5NlFIVnhVZUFYWnFlVjBqbzZiWS9Nb05QZDMrcE43OGZ2OVQ1?=
 =?utf-8?B?eHl2VTNDamE2aHUwNTQ0aUR3MURCZXRJL0QvWEpXZ0U0eit0M2d4YnBLb0gz?=
 =?utf-8?B?clB1dUdqVGt1U09xVVFkTVdIdVI2WWp3aXpnaFVqZzVaOGZLYVM0ZjlaeUcy?=
 =?utf-8?B?a2ZlNWMvZ2xpcjRWa0hBNmlaaFN5STZrOXdrWm4zZGZqUENKVU83cURFUnZT?=
 =?utf-8?B?K000NGc0N0M3NUdhME1QYU9FL0tsUWJnOXphY1A0UWlLNmxPZFVxa3BvM2Vo?=
 =?utf-8?B?ZExnM3BWeFhNSDg4WHNudlQ3Vis0TEg0VDk1eEhhYXV1WCtieVdxdUFneG43?=
 =?utf-8?B?bW1PM2hkVS9zVjh6eFl6c1RZQjdEWXluci9vcGlOWXhZSG5iRlh0QnN0LzJK?=
 =?utf-8?B?OHcrc1lMaVAxME1iaFNtbzFqQUphS280NWpMY0dJRUtIZS9GS2JkZHJwUnFr?=
 =?utf-8?B?Y3czNXNRQ2FFWGtoTXRGb2V2aDBjb0dEY24zWEljOGwxaDVpT2VHYUlCcGRV?=
 =?utf-8?B?cS9YV0xBRVErbXZNVUljSzMxVkhqUzFMNmZxTXllTmdGTXBSS0Z1VlpxMHRM?=
 =?utf-8?B?T0dvVVo4Y2dYSjh4OHB4RkV6MmJqdWJLcjlHODVKTCtTT3Nhejk0bXVxY1Ja?=
 =?utf-8?B?ZTY4VlFXZ3VMNXpEQ0g1VDRkQUc4MmdNK2ROQkpwOFpUV1dCdklBVjNRRitx?=
 =?utf-8?B?VFpMeDJNY0xtdGZYRjFEc1I2NUpxRXFyQzFCZmNZWG96Z2NQcGs1akxoZjRy?=
 =?utf-8?B?NWQ3dEZsU2R1M0FkYlVCN0tZY0I1N1k3N2JjaTlpTDduYUYvZVBVU0FnRFU3?=
 =?utf-8?B?VXhKTDF1TEJpaGdLQ1pnY09pVTZDWTlVeUtLZzkzSEJ0djh4TUZSYUkvbHdx?=
 =?utf-8?B?Y1VVb1c1cUlPd096ZklKdVVZQnBZSlkrZzFielBRWWtjSFd0Mk9JdlFUamxQ?=
 =?utf-8?B?dDBiaDUrM0ZRNmtJNFYrSDl1dTBHNVdtSFVDVWhIWDgzZWRUbFMwekNOSzMr?=
 =?utf-8?B?WS8vMkpMM1RMeHB6cGtEQm4xb3d3b2lEQmxpK0U5Qmk4Zit1WEd2YUtOaEVj?=
 =?utf-8?B?ZkRsR240UEZ4UnMxY0hyNlYvMU01TkdwMm5UbzV5bHhObmhJZHAwaUwyOGpR?=
 =?utf-8?B?bmJDWGFiSmNQK0tUR1NodFNXYUlwTjZMWjY1SW1Fa1I2d245dmUzVXFhaTB4?=
 =?utf-8?B?cUp6NE1VOHdMK0twcXVoQldxazY4RFIyMnE1bWt1ZmdRQVFVUFRyOFkrQXVu?=
 =?utf-8?B?akp0THkyUHZYV0RQbVFYRFZGSGFvWFJ3d3lxakpEcDE5cnNrOHJjRm9BZ01D?=
 =?utf-8?B?WHpDNUozT2hnazJMV0FDR28vSEdFMEJsK25TRjNyY3N0ZktKa3VjZDVMcWh0?=
 =?utf-8?B?OGlpQmJHU1crRVd4WVp6Z1k1eWpFUmt1L0hjNmZtUTNkV0EvdmVXYWxqTER5?=
 =?utf-8?B?dDRxeHNPRU1qbngxa0xUMmV6cjBVeldVM1pnZUp0S1phakJsY0ZXa0pLeTFt?=
 =?utf-8?B?Z0EyRG9xVWhBMDQveVNoUTZmSHYrbFBRZFRkTEhRaW9rN1hoTVB1Rk9RY1VW?=
 =?utf-8?B?RnhLQlJlWTl6ZkR0S3FLeDRBOFdXYWpNdjlvNXpXNWZ0WkMxS3JCWmZRczFp?=
 =?utf-8?B?NGFWdlRrTDZkbFgrSFBBRWIzWjlCTXJudDN0MVBzUVZQcEQ4V2o4QUppTnB6?=
 =?utf-8?B?dlFMcS9WM1FsdktMdXZ1Q2daSnF5WStwZ2d3Y1ppaEZRRzJBU1dKdnh5Vm1S?=
 =?utf-8?B?SSsvNHRzaFdDNERHV2VYRGN5UllnQnVZbHBkOHhPNW9RMFBYODJIUnpTd0xS?=
 =?utf-8?B?bWhBY2tVV0c1TllkTVdoSHl3SlppaUJTWlNYdXA2ZktmN0M4UjRwVCtyTlVG?=
 =?utf-8?B?TmEvOEw0SlFhVG5iNEdINkd6ZUpZeS9aNVNZN2NZcTB6eTNmZyt1OWx3RVpt?=
 =?utf-8?B?T2d5WkEzN1Uyenp4bml4Q0JtUlBYRENKemJENjgzVk1YQzVoc0Z6aWwrZWVy?=
 =?utf-8?B?Z0U1TnZMNjBCdmxwelhBc0txY3pYeE00L3oySVQ1aFE3MnNrSk56WDZBZnBt?=
 =?utf-8?B?UTlJVXo1WFVRbmx3Y2V3YWdkN081UWNQbGp1QlZZYWpMbXV3SUVIY3NtMlBN?=
 =?utf-8?B?ZnpPTFhrNGc2YnpJYmwyNDV1SUZGL0tuYUhsMk9BVDlZaVhBVHdDZ0kvNWJX?=
 =?utf-8?B?K1ByMmNFVGxuY3JuYUs3eDZqUzk2RGdsT1kwQVFGOGFTSDg2c0tuVGNMZXFE?=
 =?utf-8?Q?ygvLQ+CufXUncOdsx9N1u+Wbyw19ZwJG/rUeT?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f4db38-92dd-4c2b-0651-08da13ecbb12
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 14:34:29.9482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9FGUCyr7TJZV6gmigW/VpUw7ZoQpTtiwyCrvUqozVeuLON6I3TBCVHEpON0DD+fDiu5319fnQCO3kjGYNaKjwz2/6eyx2Yr8FLEaILu0VuYXcIsNdWPSNjAAaNXNE8g4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB7042
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/31/22 6:45 PM, Jakob Koschel wrote:
> When list_for_each_entry() completes the iteration over the whole list
> without breaking the loop, the iterator value will be a bogus pointer
> computed based on the head element.
> 
> While it is safe to use the pointer to determine if it was computed
> based on the head element, either with list_entry_is_head() or
> &pos->member == head, using the iterator variable after the loop should
> be avoided.
> 
> In preparation to limit the scope of a list iterator to the list
> traversal loop, use a dedicated pointer to point to the found element [1].

The code isn't searching the list. So there is no "found" element. It is walking
a list of things and using each one it comes across.

> 
> Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
> ---
>  drivers/infiniband/hw/hfi1/tid_rdma.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/tid_rdma.c b/drivers/infiniband/hw/hfi1/tid_rdma.c
> index 2a7abf7a1f7f..b12abf83a91c 100644
> --- a/drivers/infiniband/hw/hfi1/tid_rdma.c
> +++ b/drivers/infiniband/hw/hfi1/tid_rdma.c
> @@ -1239,7 +1239,7 @@ static int kern_alloc_tids(struct tid_rdma_flow *flow)
>  	struct hfi1_ctxtdata *rcd = flow->req->rcd;
>  	struct hfi1_devdata *dd = rcd->dd;
>  	u32 ngroups, pageidx = 0;
> -	struct tid_group *group = NULL, *used;
> +	struct tid_group *group = NULL, *used, *iter;
>  	u8 use;
>  
>  	flow->tnode_cnt = 0;
> @@ -1248,13 +1248,15 @@ static int kern_alloc_tids(struct tid_rdma_flow *flow)
>  		goto used_list;
>  
>  	/* First look at complete groups */
> -	list_for_each_entry(group,  &rcd->tid_group_list.list, list) {
> -		kern_add_tid_node(flow, rcd, "complete groups", group,
> -				  group->size);
> +	list_for_each_entry(iter,  &rcd->tid_group_list.list, list) {
> +		kern_add_tid_node(flow, rcd, "complete groups", iter,
> +				  iter->size);
>  
> -		pageidx += group->size;
> -		if (!--ngroups)
> +		pageidx += iter->size;
> +		if (!--ngroups) {
> +			group = iter;
>  			break;
> +		}
>  	}

The original code's intention was that if group is NULL we never iterated the
list. If group != NULL we either iterated the entire list and ran out or we had
enough and hit the break.

Under the proposed code, group is NULL if we never iterated the loop. It will
also be NULL if we reach the end of the list. So the only time group != NULL is
when we iterated the list and found all the groups we needed.

>  	if (pageidx >= flow->npagesets)
> @@ -1277,7 +1279,7 @@ static int kern_alloc_tids(struct tid_rdma_flow *flow)
>  	 * However, if we are at the head, we have reached the end of the
>  	 * complete groups list from the first loop above
>  	 */
> -	if (group && &group->list == &rcd->tid_group_list.list)
> +	if (!group)

So the problem here is group->list may point to gibberish if we iterated the
entire loop?

Perhaps instead of group, add a bool, call it "need_more" or something. Set it
to True at init time. Then when/if we hit the break set it to False. Means we
found enough groups. Then down here we check if (need_more)....

At the very least if you want to keep the code as it is, fix up the comments to
make sense and explain the situation.

-Denny
