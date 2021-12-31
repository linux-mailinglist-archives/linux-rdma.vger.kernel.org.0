Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D13848245F
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Dec 2021 15:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbhLaOkR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 31 Dec 2021 09:40:17 -0500
Received: from mail-mw2nam10on2078.outbound.protection.outlook.com ([40.107.94.78]:33504
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229474AbhLaOkQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 31 Dec 2021 09:40:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OiGUdt3oM+4kuhEZlRkPA8RlbWQ+INPe5z8qN54atlNk7SMqW+EYo3zgFQnOh0IfSdOo74IN72GJ+tLIe4oldkTdazaCyvTo+YW94iVhXLueR8pLzBSIvX9aK/gasYW39uQcIFTqwsHUL/qZAliaUrEtkCMJDefxi6A+Cgz2zw257bjuoQRkQrwQ6wWhOxL4sAB2QO+aNmoM65kLsTnuvZ6OooLH5/9Olvy1ki60vOPBYMdhocuNS+MhCf78q5jtCqlES6AszWLRlzWCbFrUDzJvp4O0oG9X34+/mIX8MvbEAE86TI1z9kTrb6X3yxIcjmO92Qy68jFNHNX+vuF/Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tds+JqRyPtsmPvnW/Nza3KT9jd7og78KhBTLifjVk8c=;
 b=f5D2wcBzXJj3krNCknow9CAG85Wotv8Be4lt54YuS4hiWFjM/TOkqd7A2u/3+Ww6ngZp5EXjzaA0rbsxxiHrdBfhdQr0CWx7jiF9LZDID4rk8ibjbIONIbXfYCzFtu/fk0fG5+JzO2R3R3ks8SZ77J2fGXFrVVkFjLSufqL2VX//BqzNWPm2UFVqgajIn++nXWNduRPH7iIRV/CZf2uwDlFIru4Uk8eWrCYlmLu27jjxVbXB7K1D/WHE+M0DlhzbUNVSg6XGzKN2vRUZZfds8QDI3vXKiwZUo5VWKJRcpZtYUlaePNBhrgJQiZ7yFRYjJzq4O1eilzJA3VVu/UYoaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from BL0PR0102MB3313.prod.exchangelabs.com (2603:10b6:207:19::10) by
 MN2PR01MB5856.prod.exchangelabs.com (2603:10b6:208:189::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4823.19; Fri, 31 Dec 2021 14:40:13 +0000
Received: from BL0PR0102MB3313.prod.exchangelabs.com
 ([fe80::10e9:e695:9aaa:1eb6]) by BL0PR0102MB3313.prod.exchangelabs.com
 ([fe80::10e9:e695:9aaa:1eb6%6]) with mapi id 15.20.4823.024; Fri, 31 Dec 2021
 14:40:13 +0000
Message-ID: <b865c232-6652-bbc9-0676-b435fa03e98b@talpey.com>
Date:   Fri, 31 Dec 2021 09:40:12 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [RFC PATCH rdma-next 05/10] RDMA/rxe: Allow registering
 persistent flag for pmem MR only
Content-Language: en-US
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "aharonl@nvidia.com" <aharonl@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mbloch@nvidia.com" <mbloch@nvidia.com>,
        "liweihang@huawei.com" <liweihang@huawei.com>,
        "liangwenpeng@huawei.com" <liangwenpeng@huawei.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>
References: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
 <20211228080717.10666-6-lizhijian@cn.fujitsu.com>
 <45bfd837-a784-5ea2-7ae0-46e7e557b030@talpey.com>
 <15ad4285-7a74-2b3f-1c1e-823b36cfcf82@fujitsu.com>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <15ad4285-7a74-2b3f-1c1e-823b36cfcf82@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P223CA0021.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::26) To BL0PR0102MB3313.prod.exchangelabs.com
 (2603:10b6:207:19::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3937c44-7cc1-437f-7b10-08d9cc6b73df
X-MS-TrafficTypeDiagnostic: MN2PR01MB5856:EE_
X-Microsoft-Antispam-PRVS: <MN2PR01MB5856AFB944C2CB108F99A3A1D6469@MN2PR01MB5856.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uRQzc4vt3S0GxigXWbZpoiKU3POKtF5hSPI5MqUh43mrURPRO8qV9pMbB4I7ZBuFg1q68zbL+/huXPtmC4c+fCnaZHsLv/fohw9WIH5zmc6wJikTBfVAYtS9Rou3o6s4vhSZRVCa7m9T+qm2GL9ts+ZSJAm0PMJv/jqvtUibjyD4St3n2qa2xqx6BdSieMK5fgs6E5yirYXwMtO4FwBYnEq8E1yAt+plAuVkcYdGFoupB3q+8RoJGVLH6MqiIEk/Tn1YLCtL7cavP+gGi3CgtUtSvFeB3R56P88p/Mu85ixWsewZD+znygbxqKn8WgTFcl3pZdPkpUt67CVPiUI4FLWrCTAzbNeYO80gvwEqMHQGzLEhoaEqxIBSYTrgWSfSEPFACfa3UOEVlANid6WEBiAxMB9kxHdMWyW6YVLT8S/oLMgg/yu8DwYP5AlWwOHrbus1hCZsDinWCRXTmsWLyBtDdw/SKFwIh6jgYBZXtgWWyI3mmXQ0pRpDQ4+t0p+NxMuv3t4M+NOClW8BRc9rbw8dCgUiUxPezWpLfP7NacSaLzrxN5LHnzJ+hZPFkzsy7SA5zhhsdvym/4nN+xM5RU1nBmuvZjLzJQjY1snkoYfuYJ6MMCAmtRgFNto/hrDsc0ut+Emh/d9BE1S3U+BMgx2xaQEUftOj0qR3iFtygzcYch8CvTVjjK4KAbvdX1usWw32Vt7UuMRWlSqdubgOVSx+9hFDyeuoRC/iUF724vE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR0102MB3313.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(376002)(366004)(396003)(39830400003)(136003)(346002)(86362001)(186003)(26005)(6512007)(6486002)(5660300002)(2616005)(53546011)(83380400001)(4744005)(66946007)(6506007)(508600001)(4326008)(52116002)(66476007)(316002)(36756003)(2906002)(38350700002)(7416002)(38100700002)(31696002)(110136005)(8936002)(8676002)(31686004)(66556008)(54906003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWwvRjA0UkpiZE1NVTJ2WnFSNVB2WHFYRHhPdkN6bmlhWDJOME51YnA1M0p5?=
 =?utf-8?B?OHJ4MCtENXNTVHJlMU1VdldqaGp1MmdPKzI5WGJiYVkrRFh2UE5Ua1NnemtI?=
 =?utf-8?B?cE1zazVJOXFjQmREZ0tzbmlKT2xNTjR2cG00dlV5ZFA5ZHFFemM2UXVMUjFV?=
 =?utf-8?B?SlgwcTh5UTNuWGdLS1QwS0JVNnpmT3Rxd053eWFLSmdRemdKMXRNcGtGTFov?=
 =?utf-8?B?bzlkbnlJUUxEZkRtdDVtdm44T1hFd1dxSytmblBLRTJKZmhqM0tMMzFhM2pT?=
 =?utf-8?B?S0hMMnFmcytxeEZ4Qk1JOSt4VUtEN21tVUtpb1NtS3FFWURoWThnWmRUYUcv?=
 =?utf-8?B?cURWSXMvcDdPR1cvYTZlM0JFU2o5Kzd6VGxPVzgyZWkyYldoL0ExQUhsNGNl?=
 =?utf-8?B?MDJTdTdHZ2l4b296TkFFVFlXYks2eFczb25ib1Z5UG1ZN0hXZ0V4UHUwRVBk?=
 =?utf-8?B?dXhuT0JCcnd3bFBhWE44ZHB0d0o4NTFHOGpySStQeklXalh4TmpHNHVGTStq?=
 =?utf-8?B?bTRhaW9hWWphWHZwRW0vZjVvSFh2V1FaSjVXM3FrU2JPbm5PM25iN29CWTQy?=
 =?utf-8?B?QkhEMlQyZHJvekxoS3Y0S0pkZ1g2OXdmSVp1OVJsU3drYXBNRGl4L291djZJ?=
 =?utf-8?B?ZWRXQ2RZNnVLQkhOcWp5akJNR2ErajN6RWRKNjhOYnhXZThjY0l2K3JiaThH?=
 =?utf-8?B?dW9IZG1XZHVWenM3bkU1S3M1SjN1UGdSdm1CQjVJTmlpWFJ4Qm1rbVMva0o4?=
 =?utf-8?B?Mk9ycjl6c3NwQnNQTlNOUzVyaUF0ckxxY0pBbFJLKzM5NUIzVUdaaVN6ZUN5?=
 =?utf-8?B?c2NYYm5tdDR5SHJCeEpkMXlRbHUxbXRsTlZOVmh3dGc4TjNDdnlZYitCK2RU?=
 =?utf-8?B?OElmU1NHZ3VIUGk0Y1VuaGllRU9yV0FGcHl0dnhSVi8veUVQY0hRMWc5c3Jw?=
 =?utf-8?B?aGk2dmdsRDE4My91MEM0SnJhZ0hocFBMbXV2VGVpdVNmcERacmlFMWhzbnZj?=
 =?utf-8?B?S20yc252dTJTVHpydE93VEJQYmtPSEdBWGhmUHIxK2gyOVdQM2dyV3JLSnFP?=
 =?utf-8?B?WFZFNUZjSCtleVAzM2NjNjBVUXlXYzZjcCtHNmJ1KzErdmJsRWRUT3EybUQx?=
 =?utf-8?B?M28waStmb2ZhbktjTFI0WXJjcyt6cHJ4TUxObnk5SVRSZ1lZZVd5MVcwWDFi?=
 =?utf-8?B?T0tFanJJT1piRnc1ZkkzZUVwQWdYdDM5UXA4MUxTTms2MkxFQjJnb0YrVXBs?=
 =?utf-8?B?aVY2RE9qWE9vcmZWdFFKYVdLbFBQcVNlczJidzVXdmpDRG1na1A5MDVJZ1JL?=
 =?utf-8?B?Y25QTHFZU1hLWDh6aHA2WmFQRUJIWGdFWDNmNmNYb1R1UHFCN3l6ODA0N1lu?=
 =?utf-8?B?eXBaV1dQYnFmTzM2OFBCMkU5YVlTQitNYmJSWW9GRUpTNlpFZE5uRDBMdk9P?=
 =?utf-8?B?Z0Z4RVR6dnJnNWNOZU5ieCtOejVWQWZDcTk5STk0REcvVCtSQ2VZaWg4aE1v?=
 =?utf-8?B?TnozN0t3QzQydzd0Qm1hUTdLVXFXMEFaMklWQW1jUHZ1VWhTTGVmY0lTakc5?=
 =?utf-8?B?czlYcUxwR2c5dVhtQ3JCR3hPaGlMTEV3dXpiNUFselU3UW4rNHdOQTJQZ0xK?=
 =?utf-8?B?V1pBbEFDT04vV2U2ekl1WHVWTUN1YTB3NTBMZnhiNUZXZDJTbnNMQjl3Sm1u?=
 =?utf-8?B?cExCK0dyN2d5ZG5BNzVQWWJoSVAzcGMwck9LMHUvUUw4NUtpMmYyNTJFNlJu?=
 =?utf-8?B?UWM2YlpuL1ZPWXplZS9tUVR2dUs5Y1AvNzkvQ3V1WmNxUGdVaWFRdkFER2pI?=
 =?utf-8?B?bnhBcStzcDQzQUJQbWJ0ZHIraXI2WUZESzgzYWVIazN5a2lFaUZTRzNERXF1?=
 =?utf-8?B?dVFmUGdMK2pOaVdRM2Q4OW1FNnl0dUFNTS9KQythRzZaak1ucjNyU09EazVJ?=
 =?utf-8?B?SHJ5RVJTM0RRcGwyVmFvSnVoQXladE1KcFZzb2FFbHI0TjBXZnpOanNYV1lE?=
 =?utf-8?B?Sm1zZGdtbERtWWtKMWJNTjJRWW8wQlVNMFNpK1g4YUtrQzM1eUFQU0VnZjd5?=
 =?utf-8?B?WGZGWWkvdFcwN1o2SDNUZlpQUDRSbHFtUGdYU0U1bE5aWS8yK09UVG9wWHZE?=
 =?utf-8?Q?kL2s=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3937c44-7cc1-437f-7b10-08d9cc6b73df
X-MS-Exchange-CrossTenant-AuthSource: BL0PR0102MB3313.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2021 14:40:12.9259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zg9n7fBEPv0rHDHQ1Upwv2SXuTGzX7H41yyKCLTKK73q3DwC3pMntzIH7wGWScuw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR01MB5856
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/30/2021 10:34 PM, lizhijian@fujitsu.com wrote:

>>>    +static bool ib_check_flush_access_flags(struct ib_mr *mr, u32 flags)
>>> +{
>>> +    return mr->is_pmem || !(flags & IB_ACCESS_FLUSH_PERSISTENT);
>>> +}

>> Its name is confusing and needs to be clarified.
> 
> Err,  let me see.... a more suitable name is very welcome.

Since the subroutine is rather simple, and with only a single
reference in a single file, it would be best to just pull
the test inline and delete it. This would also remove some
inefficient code.

  	if (flags & IB_ACCESS_FLUSH_PERSISTENT) {
		if (!iova_in_pmem(mr, iova, length) {
			pr_err("Cannot set IB_ACCESS_FLUSH_PERSISTENT for non-pmem memory\n");
			mr->state = RXE_MR_STATE_INVALID;
			mr->umem = NULL;
			err = -EINVAL;
			goto err_release_umem;
		}
		mr-> ibmr.is_pmem = true;
	}
...

