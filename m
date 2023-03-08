Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F18A6B1302
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Mar 2023 21:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjCHUZO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Mar 2023 15:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjCHUZD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Mar 2023 15:25:03 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2100.outbound.protection.outlook.com [40.107.101.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D591BAD2E;
        Wed,  8 Mar 2023 12:25:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=brlSPJvV1g0u1UAgEWNJVBCcV2e8RzSJN/DyOhiL79I9pHgrus9KsWSEr4NL1rbnI9uLk4KgS6tWaSiKfvmGr8wS7SRneevFBxvCtphBcu5pR9cFo5qNq+TkH78rj/ScZ0DIB1AlPkIYIttR3azTMFtHW79egPxUgxL8tP1s2NtDwBRlzq1N64undTKh9UwaHwjPyoymKBJovRvdmpQR7OznwqqXH0WjBbDht9LUfSSOn8pCb5+1uochzaId5JxwHyJaoZxKULALIpnp/L8nvN9rZ6ZkA3LDa5s9GX2BPq8W7T/XCK9baaQKMD9ewrEsUIt6QVE5qDlYSPIpk1a9hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pew5pUUtaTG6fl4NfwoCNIqOjTM+x/4G4fCPOC5498o=;
 b=RJ4C0ziuAe73i8+BET04OPdjM48Ji8IpB2907QkByBafTfRYddVqpPwNSQyWJBtNcUIHgtF+2Ek1vvZqy29aQ8p9UKI8yLJ9Vj3dvQeKecotxvCq9wkLxcM2/ELTdNzYwBsBjN79AMgXfzHsJF0i5IEbH7CHlvpwlqcTtVnAvQH9S2Mo42xXXeqHeTsA8XlXDAJrBZpRwojio6x5N1qfjd2xoKCxfXS5mkO0PfprGZXVGGvWRnHzDKQM311ztM9oaaAGRrr8lHIUPjLb3MIyA1mF5x+n4XbgXkM30hF84dwIA+HlVvecCDrXZEYOObuYuepgNJhwzv/VGLUgUKuxMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pew5pUUtaTG6fl4NfwoCNIqOjTM+x/4G4fCPOC5498o=;
 b=KGxKcAB74JOn8WrWysKY4fIDsWSf96gST0rjcLxwvVuD/01qviPyWwqjsVMDXl6H5DYv5vHU+M6Elm2N3X6G5GfTivPQzpQqGEyR8szoDQdB+XZh4BpiTcsiQUmMDJBwDp+E74HHS6KNU8IC+IV8JNaQcUYdUp8/mir7sN3JEpYZT4lbRpveNvr3uxVpWqgk7eLdYtEVbOqYA6yYhIznJWerLpeczBfaqc4dCaGUVuhRKZpk9YcGVvPT+fk/XSra8YP+bTCpqLJyBpOANzMDUa/JECNQbaolNaKENTytgCKdxvef8QGC+Qf/o573gZ7Yp3I3zcf5PF3CGqvLYztIYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BN6PR01MB2610.prod.exchangelabs.com (2603:10b6:404:d0::7) by
 CY4PR01MB2535.prod.exchangelabs.com (2603:10b6:903:6a::9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.17; Wed, 8 Mar 2023 20:24:57 +0000
Received: from BN6PR01MB2610.prod.exchangelabs.com
 ([fe80::5844:6112:4eb1:a8f8]) by BN6PR01MB2610.prod.exchangelabs.com
 ([fe80::5844:6112:4eb1:a8f8%9]) with mapi id 15.20.6178.011; Wed, 8 Mar 2023
 20:24:57 +0000
Message-ID: <110becd9-3511-b7ab-f34c-1a4fe7fc9e82@cornelisnetworks.com>
Date:   Wed, 8 Mar 2023 15:24:55 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH] rdma/qib: Remove deprecated kmap() call
Content-Language: en-US
To:     Ira Weiny <ira.weiny@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230217-kmap-qib-v1-1-e5a6fde167e0@intel.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20230217-kmap-qib-v1-1-e5a6fde167e0@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0070.namprd02.prod.outlook.com
 (2603:10b6:207:3d::47) To BN6PR01MB2610.prod.exchangelabs.com
 (2603:10b6:404:d0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR01MB2610:EE_|CY4PR01MB2535:EE_
X-MS-Office365-Filtering-Correlation-Id: b3a39f37-5856-47d7-1f2a-08db20132f63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: saI6yiyPvrcKKnzoCn7ePnCk8l178wG22NvAQG11Pl+JRnHFmOE31FoWx8tR1xXkiapHiZClU9A6G+8P8AHxkIanUmfH83v2GTnRFGm1D14qgY5yvX+w1HCK2VdxX6VTW7yK+AZvGkc8ZeCgeXD+IlhpdLfSDI71oJAK1Jbfzj1k1CA+bcogtwjud73dwVWd7I9Bq4NwnMhNa15tapIretC4p0oy4QDNMZXRBIEH9f/AovxI/ocY6SF8cOUDTmblRVGyOPc/G3qMZ/gmq/cGW/Qxp+SP0ViV67DlVCvuqU6EREOVunxnyvqUF1I5EisRE0hXpNB74HrPUR+2B/z2VLTUsmg5ZDbO7XRtYRgEyeqhCNLf+XldtLxBd5nMDutS7PuvtxqJgWvDPbVMDw8H5qtcSad+9TS1xsTaRY/FC7UO1aBRg9r5ZExmvhiOy3i0K6Q7t6aO7tT0izNPvaiZFqIMfwd694rO12qaZ8SbbXjOoBA+nmQQK2lJR8ndLdt1nEn2HLuEJFWTvdHbYl/NeG+NkMAY/+wXSy0SWq2umO/xwuATZeZNHPmftWGGDQbI+FBW+K6BmiIIsUYbKNWBNRi5CcH+V9VJzjKD3eAASLz59s4t2UkD3yc25VMW9o15D5miZ2y3iaMu8mMfjk2InpQIi1C/nLFV/yWKt/wi9dm7Qg5wfezG1xazt/n2Tt/mbDonzy6L4kaHHX7C6Si005gabD89HQ1KOTxqXJZlOOc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR01MB2610.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39840400004)(136003)(346002)(366004)(376002)(451199018)(36756003)(316002)(110136005)(478600001)(6486002)(5660300002)(52116002)(8936002)(66476007)(66556008)(4326008)(66946007)(44832011)(8676002)(2906002)(41300700001)(4744005)(6512007)(38100700002)(26005)(86362001)(186003)(38350700002)(2616005)(53546011)(6506007)(31696002)(31686004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVI5OXlpREpNNWoxcUp5K0JxQnhKN1ZlV2JnYy9ibEhHUFRRQTBGUzRvSlRJ?=
 =?utf-8?B?SFBWODg3eENOaVdCNURmbnRldkpYOW5jWGZudWdremdLdTAwWnBUbGVqV2VP?=
 =?utf-8?B?RTBwenBOQy9qWTFoY2JHaEF6TnJadE41ZDc5azN2U1diTWR6MXhnYTBJZmJB?=
 =?utf-8?B?cFlRUEo1ZzVmSTBuRlRpcXo3YWEycElPcHB3NitSbVZBQzhRb25uTmIyRTNy?=
 =?utf-8?B?eEwveUdadkNsL2RRVzZOSDNteS9tVFRvRkpoYzFEaUtEeVRaMmFpTk1OYTlw?=
 =?utf-8?B?eDRZMzJzdDhoQ0Z0VVFBbmJJUFBQaFVjOXFIVGU0WVhYbXh3b0lpMW1lV2xN?=
 =?utf-8?B?RjhUU3I4aGhmTE1VNm41RmZyRXlrV0VKOTZ1TGhNY3Z4VXdUTXZuZVBscm9Y?=
 =?utf-8?B?YkZ4WWFRRmlLVDQ0OGRhR1pBOXo5S3NOcUIvQldHVHRJK2xkMTVDS1VYNzdr?=
 =?utf-8?B?STdJL3VGVjdvVGhheGtuT0xkTFJkRWlUL3FqOGxnaUZVS20rTE5HUXlrbG9C?=
 =?utf-8?B?WUNFaWpYZFpWaWJDdG1FM09zVE1DQkhuSVVFS1B3a09yeEo2NWc5dURiZnVa?=
 =?utf-8?B?bmVIRmRZdnFZMlRWVWhKRkVMQldjbG8rYkdkOXlISE1Mei96dVJiN3FSc2ow?=
 =?utf-8?B?aExsQ3U5Y3RVcHRWczRaUWJVOGh3T2RQZE84NjlJT2wrRkV1S0NhWHlRMitn?=
 =?utf-8?B?eXJnOTVmZ1YyaVJNaEhXZmVlK3JVOXFzZU14dyswblNFVG1sUTdUNkNWY3ZQ?=
 =?utf-8?B?TSt4YXR5MXBkWjB3WndPZEVxMWQ0L3RnKzFXd0t1SWFsWStlaUlTRnB3dkhh?=
 =?utf-8?B?d2psOWQ5cG1Cb1diWVhrL1l6bDZlN1dFTyttby9rZGJNLzlueVJ2MEpkcnZa?=
 =?utf-8?B?TUhLQk52U25XbW9JQ3p6TnZLazdZRUdKcGZFN3VwZi82azBrZHRxUFJUQzJS?=
 =?utf-8?B?VVVFMllHbUNJdUk5QjdKT1Z5QzNnSHB3M0RMUXZoTE9JNVJOQkd3MmRhemxW?=
 =?utf-8?B?R0kvalRFbzBQTG9JNUR0Z25rUFB4ZTVyWXd3N1lBWFR3ODJIdis4bGN0S1Rv?=
 =?utf-8?B?cU0xNk43eThEa2lqbWFJZzczYUcvREJMTGcyMDFSSFAzTHlKZXV4YW80YTdj?=
 =?utf-8?B?dmMwdlV5VUVDTDZKaTh0V3AyaWlzT2FkWlpiZ1hZdzZVblVwTVFMZitmY1lC?=
 =?utf-8?B?ZlIwRWVFQ2E2T2xHZ1d4a282dUpRRER3WGZCSXFJRmJGL0tSbWxyUkt2SURX?=
 =?utf-8?B?MmxrT1VHQTlMVGlLb2NkTUdTNlpxeWUwZHpaUGo0WElyOVBERGJ5NHpLRDRQ?=
 =?utf-8?B?eng2VjhKNlRrNjdtVkswL3RIdDlway8xRFQ5R1RncFROM0Y1bWlHY1N6N1FE?=
 =?utf-8?B?WGptUnZIYUNuNkovUjlWUHQ4L0MyUFRFZVI4SWVFMHcyMCtsVVlZK05kZC9G?=
 =?utf-8?B?eGsweGtBYVNtelcvbHkzYTVVejlZZllYazdqMXozclZCQWd6c3U2cE1xNVJ2?=
 =?utf-8?B?bEY3RnkwME42ODBjTGE2RWpDV2JjcTVSdXV4aXpyOW5iYkpwZWppOGxuNUVC?=
 =?utf-8?B?dE0zTnRhblMxYVBOMjVZT1ZISERyVXltZmRrNWJncW9tNHVWUVJ6aUk2VURl?=
 =?utf-8?B?cHVqUU4xTnlPbEsyWGtTZ2V4cDRYeGMwaUhSWlFHOHp3bzgwazhUWjgyYVBS?=
 =?utf-8?B?M01NWkgrb0FFcE5NSllCSGRjRC91U1E5bXlXK1FXNUcvOUJBUmVKS1lQbTFj?=
 =?utf-8?B?aWhGUS9OMFFOS1l1QW9yb3hWOWNDdmZmQmxBbjFtTzBDajVFVjF0MDJRZmwx?=
 =?utf-8?B?cDNRMTRUTllqR296Z1d0VlFIOC9TYVNJMHFQcVAzZjJpdllzQmEwVnI0OFht?=
 =?utf-8?B?bTBXMkpOZzhkYWNJbngwQ0E4Y3FXWjMxNkRxV3pyckZtNmllM0NrUnRxaFdB?=
 =?utf-8?B?ZVFwK1lOQmxMTEdrY0N3WTMyRjNBWVpJTmpFU2t6cFhEOUhHa0J5U1VwYjBH?=
 =?utf-8?B?QWhiaDR0TndmZzJBTmJNdG91WDlndHUyMVhtTU05a0RXVVhkaFpFR2xJRmlJ?=
 =?utf-8?B?R2JlVksxT3VWRzNzbVFOemlaVDltZlVEeHdLd2tqYkhzbTd0T1gzcEFTZjlk?=
 =?utf-8?B?ZTRCaWp6enZEWXVtUVVrSCtSSjBnZkx5N2MxSHV1c2JtM3JWNUpKRjgwZTFT?=
 =?utf-8?Q?3XiDPnTNhacW6GG+Ti8D03Y=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a39f37-5856-47d7-1f2a-08db20132f63
X-MS-Exchange-CrossTenant-AuthSource: BN6PR01MB2610.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 20:24:57.6112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lezGPxgLJ4EZeT5Lyg6lquThISk57opxnLHSEmwV0DMYlkmBMy6lvYpnj2WSM8v5hUlRFQSb8Xka2eunDSq8Wa2LS0CqW+fPITFXf9wqUt+PUng2pOn/oXmHqBkogRBH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR01MB2535
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/7/23 12:15 PM, Ira Weiny wrote:
> kmap() has been deprecated in favor of the kmap_local_page() call.
> kmap_local_page() is thread local.
> 
> In the sdma coalesce case the page allocated is potentially free'ed in a
> different context through qib_sdma_get_complete() ->
> qib_user_sdma_make_progress().  The use of kmap_local_page() is
> inappropriate in this call path.  However, the page is allocated using
> GFP_KERNEL and will never be from highmem.
> 
> Remove the use of kmap calls and use page_address() in this case.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Acked-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
