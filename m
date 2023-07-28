Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24BA6766165
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jul 2023 03:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjG1BkT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jul 2023 21:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjG1BkS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jul 2023 21:40:18 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B633D2701;
        Thu, 27 Jul 2023 18:40:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1zdnuNDjviogKBW1m+MEJmI97kNpRTZIZxu5lyGHsIUy2qSQcmXbsDSRV2Jc+laGSjCn8mqNso8F2h8UNuKFf1Js3mOjNxYC/wCD/MlbW8roOmKPMYLjZeM+om3IuJ6HUQICI6kDEF6xludrLupAA88agPKxWfZZA760lDJO3tMzI2IE+9DC8FIJD+sj9dr0QyOTxTZTh//bKXvooIRDeygACsFkHbypNGRV2JoKF8eyJA5SKGL0G5p0pn5NQYS/9jt9li4IATgM9aKWrbpAjTTXzhqLl1TeqCY9fUdNTDKlWOL0vGP3JDkIANg8//6f176IEdI6l54wtf6t5DrmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCjWOcecEMgJiB9T82Fj9V4ivSdN1aQR0N8NajPLzaA=;
 b=FCRNfcc2eAhqED0XDBwBu0M95pvpBmYjHxibpRigrDA2u2KL6xwQK3DazixDaK1wczYMykLOcy4rqbKH/ZoUAnVYdwpl9n2xIWbRQxt5dAWPELXTr774HgIGVi7PaQR49m4jXmcxFkSNMYrPrD9lShViitM6r7+y5QZRqw4X5n6C49BKxcJTS6pLIJJ94EGdYuQQqF0GGMLKDfby+n8iy9BGnym/ipxLznfgaN43GC81IS+K4nPihRpfWt/xBQpEso9Q+tq+QJ1McN6JjVfr0+9kpMk1cg4cTpQdOa6x7NRKNt70PqPRsEInnBSxlVZVtS09ThYBdFDIImQ8sIoAVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCjWOcecEMgJiB9T82Fj9V4ivSdN1aQR0N8NajPLzaA=;
 b=BWJmBcFis3phPXGUlg0b8z9OMQu6QGtZGegIcMk64tqDNUlMzNC5tJ0QUNBPoFOIQjozWVtjecYDtqEUVzfTPgEAXVJo0nbvJxiNwtLTMhtYWdXRHvDBOtk+Uv+jm8bC762oN7VXfUXpQkme3l2EZ+tTq9ulVUnnX3y50tCGVKgX2Wilh7Nhz1PT/Qk2c9+kt3FEwM78g8+mazS32177KsSkOWbAiANSLGokRG9qEqYPAL9rhG+4ulA0QF2oOzm2oaJ+VFm5nPzn1dhID+d1+EzSwn44nqh7wzWi0IBtNIuvxVnWmre1AWL8VCwLujawEfidW+V0LW8VqyLx0sgDlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB7495.namprd12.prod.outlook.com (2603:10b6:208:419::11)
 by PH8PR12MB6699.namprd12.prod.outlook.com (2603:10b6:510:1ce::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 01:40:15 +0000
Received: from IA1PR12MB7495.namprd12.prod.outlook.com
 ([fe80::b699:8c3f:cc39:ee6d]) by IA1PR12MB7495.namprd12.prod.outlook.com
 ([fe80::b699:8c3f:cc39:ee6d%4]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 01:40:15 +0000
Message-ID: <eaddbca3-fb83-4f0e-501e-fed2d7e292b4@nvidia.com>
Date:   Fri, 28 Jul 2023 09:40:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: use-after-free in debug_spin_lock_before invoked the rdma driver
Content-Language: en-US
To:     Zheng Zhang <zheng.zhang@email.ucr.edu>, jgg@ziepe.ca,
        leon@kernel.org, mbloch@nvidia.com
References: <CAC_GQSqAC56qOvJFYu02fmWaRRsZ-Q-e6Z0xD+j8iFU9GxCNXA@mail.gmail.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Mark Zhang <markzhang@nvidia.com>
In-Reply-To: <CAC_GQSqAC56qOvJFYu02fmWaRRsZ-Q-e6Z0xD+j8iFU9GxCNXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::19) To IA1PR12MB7495.namprd12.prod.outlook.com
 (2603:10b6:208:419::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7495:EE_|PH8PR12MB6699:EE_
X-MS-Office365-Filtering-Correlation-Id: b7366032-f0d5-4de9-aad8-08db8f0b9751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OpIwcK26yHhXhao3yM67QJv/HdnCwtlQkpiIufWF1NNhB2K5RgMB9dAemBXoMsFZXtNPLAeRLvFFOGa8c8OXJdCgN8FNsFZuK/I040OMRiv5WDqkzElZ+7vx2RxOqdFh7OE+TjgcL6yn1vjogBWvQJ2nKCGGuBnyKMR6e2vm1PCJT8xEfkekuX1lLHTr+XDi3hW9OpnQRsNuVqXTfjXlrXN50jmWelTE7DcFBLBCeNY9/UkqDas43Yld7hqtoGWcuW6HvjJ6b+/+G+ggP22odta1LqSkL57Kc78RSjQYH7alrIapajw14475UEMFh6hA2GxIH7jB+KDE6/f0EJ1F/ZL7x/YHf883Onj0lrIi+E9ghe0gM1hkZfNbemMo92S77bb8GSGu6kCX4/Xex22mmuQ0Rr4iZ4+Dn0hryyXLeGxXs+n0QfGDs5JnQvDLz6At8uSb8RMrvz150lpHy2gv66moz4+pmvdHescf0Zx+rBsxyYKbodnfROPaJXrWPvStH11P+69XULQ1eIMgVsiYpOOqvmhpLRMKp/XX63Gq6w9JmGXxkNln3yVuCVRkENpRZJSXOYjgn/gPZg7Z9ft/dp4JevGOXhHFcLuP42xB8hlrCoFpZ1kZewx6oMWOUeojeiFlFDrZWoKND2FQHcD9lQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7495.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(451199021)(2906002)(6506007)(26005)(186003)(316002)(38100700002)(2616005)(83380400001)(53546011)(41300700001)(66556008)(5660300002)(66946007)(66476007)(4326008)(8676002)(36756003)(6636002)(8936002)(31696002)(6666004)(6486002)(478600001)(6512007)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGo2b0JvVFlybjJUUTlITkZsMWJiYnhhazBKQkNhZXJzQmJCdmhMQ3VMVnpv?=
 =?utf-8?B?ektjeEhtTXAxaUtCZEJMdmNYdVl4Z05UY0N1QTRYQitQYllscWQvQ2M5eDF2?=
 =?utf-8?B?WG1CM0x3SFMvZTVtVEZaSE93VDNxdTRXeGpEbGFLUzI4NFVDajJ3bkpySy9D?=
 =?utf-8?B?dDRNZTNQOWZuTU9UeTVoQWRWWmlPcTdFWm9oSVQ4SEtudHFSSXI1LzFOLytj?=
 =?utf-8?B?Wnk5R2Q4Tk1JeHo0bkRNdmRzRkltY291a3p2VmwrQWVuQ3dnZGdDL0RWeVdv?=
 =?utf-8?B?SXBxWGdUWXBsczAycjhwUWZHc3hPOEF0Q0VJQlpYMmpZK3RoRkhwWVBOYTdR?=
 =?utf-8?B?VDhHVlo1MGlOV2kzL1ZlRDVncGc4VUpYLzYwK0RCaHVPeWNPV0J2R3NnbG5B?=
 =?utf-8?B?QVdqbUI2Tk95NVJaQWpCMEptSkdpRmJVQUFzZnJSbU10dTgxRTgyMWdrV1c3?=
 =?utf-8?B?REY0Ymw4UGJNM0dQb0dUTzFVQ3kveU05dmdoYm5OTFFOWVMxQzZuOUNPMlYw?=
 =?utf-8?B?Q2FSSzl4RmU5UHpLUkJxa0VOTGg5b3AwZjhaNXozTXRHVlRJWVFucUF0SCtw?=
 =?utf-8?B?NHZGamNYSHh5RTdYQ0E2U1FNZUxQajZHY1RVajZWR05HaG05NFJnNGtxSmZj?=
 =?utf-8?B?RlM2cUF1a3AxZWpjSWtRcTkxaEN3ZEV2ell2OC9lRGVFRjFoT09vZnUzYXFa?=
 =?utf-8?B?bGVnSUdLRTFTaXZBZmNYVjdpN3VFZmM3N2NiSDYvN2hvTGEvV3Q1NW5ZcDAz?=
 =?utf-8?B?YjdkZmZSVjAxY3JvcFIzS0svM0JCeU95dTZ4aXpLT0JKOUp2M2J5Mko0b2dw?=
 =?utf-8?B?OUpCblR4bmJPeVNoK0tEUWxoYXg0eU9IZm5NOFdtWkFrSTdNdnM1ZWNZNGlz?=
 =?utf-8?B?Z3BWRytnYTlFTERIenRvOVN1YzQzbXZ2bVE2bmZXaFB6b1YrYVNPTDc3Q1I4?=
 =?utf-8?B?QnU0TVVVMWRYcHl3aEE1OTdYT3FQcmVkVnUwbUloL0N3Q2ZJTnd5QU1sNkZz?=
 =?utf-8?B?REV4QVRocWRGUWxKd2xPUW4xTTJXOVBCdDVtbFZpemlnQi9RSFdDa3dLOVhl?=
 =?utf-8?B?VktZK1RYWFFNb01kb0NTbWNzZFo5aERHY1E4U0pKSG83U1M5OVducG9HNDBS?=
 =?utf-8?B?QWUzVXhEOGYzb1VDbWJiSjdWNisyT0piNnM4VEhsT1BzQ1FtNE0zR1dwbktH?=
 =?utf-8?B?QnZmY3NSaDhBTkFVdXBlMCtjNE1TVEt4bFVicDdqL2Q1WS9TbFE5anUvdXls?=
 =?utf-8?B?dTUweWloZXRFMlZpUU5WQ0tKZlhDRWREVUFoUFFjYWdleG95VzRhWVNwUG1X?=
 =?utf-8?B?RjM4ZEswMVVZMGpnYU9HRC96VWtEWlRDN1VxVHBHUjlyMWtjTkhoUGg2YWdv?=
 =?utf-8?B?a0ovQUVMSkRMbUlFZCtUN3l3Uzd4RVc4QjZWZmZCUEcyR3h6Y01lNCtHQktk?=
 =?utf-8?B?aHBQV0poaFpReGtzSXJiSXpId3V3MWs4Z1hWWjBnSFJYOHFQYTdWZzRlUkxi?=
 =?utf-8?B?Qk9ITE9nRFNKa1VIeTFIRWMyWnRaSmsxdGJ3bmNLREFFTnE3VHh5UnZ2MEFa?=
 =?utf-8?B?QmFoM2tvQmJ1R1JxamQwY1RsTUtrSXI0cUFrZHZWUmNWQTZ2UjRVREZKb01F?=
 =?utf-8?B?Y3czUHBoWm5JK1A1aUFwM1pXWjRFdTAxME83Sm5NQnJ5azIzUXpaeksvVXdZ?=
 =?utf-8?B?KzRJTjducXFxdTNpZlI2bFpXdmtDdUsxWnU1cTNqb3pUTXplMnRnM1VES241?=
 =?utf-8?B?Z1dDTGdqekxVanZCQ3paZ0tpdE5ZZUhMMjZwVFhCaFRxTHpBcDFxK05IRkdo?=
 =?utf-8?B?ZzRSSGdGMVdXenBKV0lsZDd2endCck9sTTZhQjNHbStTZGpJS2dzSmdXdEM3?=
 =?utf-8?B?SXN0WDdqbDVrb2tnejFUREFxN0RBUzdaWS92eG9haGNyaWJSTUZmcUV2enJH?=
 =?utf-8?B?QzdnUU1aL1lZc2hTUGQ5NTVUeWM3c1hRVkZLZ2tMT0xaeTJjby9YWkR5N1FC?=
 =?utf-8?B?UUVDNjZ2TzZ5Y0Vaa2Y4LzlzaW5oOVdHOVA4cmUzYzk4YWxUMmdXam1KTmNs?=
 =?utf-8?B?cGpENWlrVng2YTlQVnhTUGZqaGNlNGxrVkJlc0RhTkRFajF6Ly9VOEFlZ1hF?=
 =?utf-8?Q?IK9x8Pd9aoNP59WxuzQCV8l9O?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7366032-f0d5-4de9-aad8-08db8f0b9751
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7495.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 01:40:15.2833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KrjmcCJT4qdn/bhYz8eRTdvl64aVKVqy99N8usiKFwfmaPypSpSUe5oyHiUHnHln4SkxgxClwGupb91qPig20w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6699
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/28/2023 8:45 AM, Zheng Zhang wrote:
> *External email: Use caution opening links or attachments*
> 
> 
> Jason, Leon, Mark Zhang, Mark Bloch and  to whom it may concern:
> 
> Hello! We have found a bug in the Linux kernel version 6.2.0 by 
> Syzkaller with our own templates. In the call trace it invoked the rdma 
> driver, thus we think it may be different from the reported case invoked 
> io_ring whose fix is also in the io_ring module.
> Unfortunately, it doesn't generate a reproducer.
> 
> Attached is the report, log generated by syzkaller.
> Please let me know if there is any additional information that I can 
> provide to help debug this issue.
> Thanks!
> Best
> zheng
> 
Hi Zheng,

Thank you very much for reporting. Is it easy to reproduce? Can you 
please help test with this patch, thanks:

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 1ee87c3aaeab..76810aac1809 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -3491,11 +3491,13 @@ static void addr_handler(int status, struct 
sockaddr *src_addr,
  		event.event = RDMA_CM_EVENT_ADDR_RESOLVED;

  	if (cma_cm_event_handler(id_priv, &event)) {
+		cma_id_put(id_priv);
  		destroy_id_handler_unlock(id_priv);
  		return;
  	}
  out:
  	mutex_unlock(&id_priv->handler_mutex);
+	cma_id_put(id_priv);
  }

  static int cma_resolve_loopback(struct rdma_id_private *id_priv)
@@ -4107,6 +4109,9 @@ int rdma_resolve_addr(struct rdma_cm_id *id, 
struct sockaddr *src_addr,
  				rdma_addr_cancel(&id->route.addr.dev_addr);
  			else
  				id_priv->used_resolve_ip = 1;
+
+			/* Balances with cma_id_put() in addr_handler */
+			cma_id_get(id_priv);
  			ret = rdma_resolve_ip(cma_src_addr(id_priv), dst_addr,
  					      &id->route.addr.dev_addr,
  					      timeout_ms, addr_handler,

