Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E863C484615
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jan 2022 17:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbiADQk0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jan 2022 11:40:26 -0500
Received: from mail-dm6nam10on2084.outbound.protection.outlook.com ([40.107.93.84]:25313
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233941AbiADQk0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 4 Jan 2022 11:40:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILckLCQhsgeE91+wMiXUWjq8EHHs2TbhCXLXXicdOJreEMJc/QfkcRwr4m20GcyP6x25DAO8KFH06MZL4L2e5ZWVJ3AZ8IQ9bdgYELy/faVc1OtOMqoyzC+djszDKvqLWboVQnwGJ6Cw0Xd//dINvpLYSLL00fOxfR8TXb3GJiRBzF4UGTV+aVjlkSL1iwNh7gsCwFyhwVlQCZEUfX0/2qUijk8YQUnV+gdb2NTfQY+Q3dSYscv6mz8DyRIdOau83tpLAaUipza4ce9j3bow1MBEZ02Ii6QkYa+uYJ4cvqkgeWSurshGDePpGok9t8fRYQfUoTWLLHaqhxQaeArkDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r57zYez/aMAsVyy5s0pYTlNqRND1RpYMgLhhzaQgiAo=;
 b=En/vFLAkwdMptAPTpNMiQFXh4fqq8ygD9h40L2J1JrT2vJaGEfscSctOORTvOrSq04y/lpnMHECkirq2OKtelusJrPvF3hw+ucJO4X1uDnGKPaAmlBRAaU7ij+bNAckUrGRx1+u2M5dVNv4Vaw3CBdRUFsVopLzP6mH8j8sulhISo0sTrtin6uI/P+SLAHSDrUkjZzE4r4Ta3WlV9gReqPZbaLu/DG3pHEtkCCxjvZmynY086FGW8YRCIxBcPJ7BDGfo56B+KK1IARd24xQNEWox6SxFjt/4D/qTNMb2TyUVjP+nFQ0f4mD1XUD24aTqgs1wqWw/t6cGVCrlCSpPAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from BL0PR0102MB3313.prod.exchangelabs.com (2603:10b6:207:19::10) by
 BL0PR0102MB3505.prod.exchangelabs.com (2603:10b6:207:36::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4844.14; Tue, 4 Jan 2022 16:40:23 +0000
Received: from BL0PR0102MB3313.prod.exchangelabs.com
 ([fe80::10e9:e695:9aaa:1eb6]) by BL0PR0102MB3313.prod.exchangelabs.com
 ([fe80::10e9:e695:9aaa:1eb6%6]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 16:40:23 +0000
Message-ID: <40fe1dc1-1ef6-63cd-267b-21f7498cd203@talpey.com>
Date:   Tue, 4 Jan 2022 11:40:21 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [RFC PATCH rdma-next 08/10] RDMA/rxe: Implement flush execution
 in responder side
Content-Language: en-US
To:     Li Zhijian <lizhijian@cn.fujitsu.com>, linux-rdma@vger.kernel.org,
        zyjzyj2000@gmail.com, jgg@ziepe.ca, aharonl@nvidia.com,
        leon@kernel.org
Cc:     linux-kernel@vger.kernel.org, mbloch@nvidia.com,
        liweihang@huawei.com, liangwenpeng@huawei.com,
        yangx.jy@cn.fujitsu.com, rpearsonhpe@gmail.com, y-goto@fujitsu.com
References: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
 <20211228080717.10666-9-lizhijian@cn.fujitsu.com>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <20211228080717.10666-9-lizhijian@cn.fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0003.prod.exchangelabs.com (2603:10b6:208:10c::16)
 To BL0PR0102MB3313.prod.exchangelabs.com (2603:10b6:207:19::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a1d360b-ebd7-43c9-a4b8-08d9cfa0e73e
X-MS-TrafficTypeDiagnostic: BL0PR0102MB3505:EE_
X-Microsoft-Antispam-PRVS: <BL0PR0102MB3505BC21774C7FB7F0DEC62AD64A9@BL0PR0102MB3505.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4A5sBU9+tI6XScxqYufy8Ou6vNY6erZXoZMLU6+3w8KEMVTk532LtLkCenYmPi8YGbH1oo7PpWzfWAJvyxen7oVO9AjQft3J7vFSQlZYHVLDmPuXY/NDYchEPZJucQhgPRud6d0z32Mz53L5CrAGglVk4BiIsI5z6Uk94gm9muysVuTMr5oMsDZ5Vpom1RwOADa6LklsMgfxE+BiffRpG/fffrpDxEbuLUx58AObVm7WILjadm/dH8JqR9UTh6B5YTuw04u+rj4q5O/SDcAwt6K1bZFu0GApCZp9coJxIpwRdZK0epTQ0Rd5rfx4ZydOWqAGjM/3F8Yth/K/qk00xczlIX+wHhKwJupa0Xt/WZjs0wQUADrgkPAvpsIk4NfQg8BOzs7dbM3JUxJQ2RI8Sj6mPMMc4D5wFcUZzvD44Q4t9Vv/2SmOgS3pwZ6G5WJBINjVIJsJCS4YJwELJ2UmcOGygMOSczDjlBzoJgEqrVC6uuHyScul3gkx/LVYJUzlgGch3TpSaByoqxXhmEmoZsqAQh1y7l3iG/dX2bnUGoTovVNWAy4/YT46QamXRpTYvMALj+pAnlWrxQzRhT5YzYkSexQGb3zLRbFJ5d5R81j3uz7gi9jlS4aU0EQZGZ1xjECKV6dxEMAkHMaNL95xTb3KiGlGgRBIHAtJWGP8T8TvAtaTFxpY3SoyzSYPk7AyZGfz5G2hrUQVINAoZ0EH8Sdrt7f85KBIU54S2yoWwqU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR0102MB3313.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(396003)(346002)(136003)(39830400003)(366004)(376002)(2906002)(5660300002)(2616005)(66946007)(66556008)(7416002)(38100700002)(26005)(186003)(38350700002)(83380400001)(66476007)(6486002)(6506007)(53546011)(4326008)(8676002)(86362001)(31686004)(52116002)(6512007)(508600001)(36756003)(8936002)(31696002)(316002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?US9VQTE3VHVnQWxyWVlEQ24ySGNwN2RHOU1CTVhrMXRoNkJIdnFZdXJZbHRG?=
 =?utf-8?B?WDNISjFmVnlLYzg2N1Vnc05pV2IzSStJZ1Npc2lOWSt5VlhUc1ZTU1QvekQw?=
 =?utf-8?B?aENPc3pibWtvdmZOY0Fpc1hPcWNDdnNuR1B1cUxEZ1QzZFd6ZXZmTVhpczFo?=
 =?utf-8?B?L2dBaGRGQ1ZldFV2K3NueUd0NFloZy9iRXlZWmg3SjNuSjdFd1FPNDdlUXVi?=
 =?utf-8?B?aXZpSzZFcWt0Z2hsK0hyOGV4aExxWVh4Nmw2VC82azljVEphUHpsdFBqamQ3?=
 =?utf-8?B?djhMSlpDSnJrQ3Ribzd4ME5jUDZybEVpNU5Cb3pkb3B3R3QreC85RjNROTRK?=
 =?utf-8?B?aXBITXErY1J1T3dUdWVHUTZEbTllcHlRMkhWSDhlRmZiV0FhNm9OMGlCb2xk?=
 =?utf-8?B?QjJQS0F0ajJabURYWkVwaFRodDdnYitrd1BRbUNBdUozMG9wRkNHeDhLcUZ1?=
 =?utf-8?B?SDVPWUc1MXlKcDVDUzN2aS9SRFlUb1NmZGtwUW9ZOXpqRm5nc2xKU1lrYkhK?=
 =?utf-8?B?TjFVU0I0K2xiRDZqM1J3bUhpN1YrTmg0RWMxK2dYSnAzSmVUbU9jNy8xU3Rl?=
 =?utf-8?B?RWZJZnhQS01CbVkrRUROVTdJbE5ieUdWV3VLU2NNNmt3UFRINDRjb0JqcWh4?=
 =?utf-8?B?UDdYTTRRUXlCWktIRHJlWkFIeGRtUVVoMDd2TkVMazJNQ3RISytJbE1pN2Vv?=
 =?utf-8?B?dTlXNVhHOUxtVC9CczVnbWcxMnRqVnA0NzBCWU8zUzNxQzA5RnpHM2RrMUtI?=
 =?utf-8?B?Qlhad1AydXdmeUFTKzBkUDd1TlRqV25uZkp3UHYwMGNrQTZzKzJXeGd3L1FH?=
 =?utf-8?B?Qlk1OGd0L29QRWlZc0VXcXNPdmNzWjlZVFRRcWVBbWtQSm82NnM1Y3ZsS01G?=
 =?utf-8?B?VEluNUl0TFhRTUJDczU4aGRkWDVGVU11eGhDWE9LUzBDb2F6QkZ2V09rZldq?=
 =?utf-8?B?MUNkRGVMeStETlQybEZsc3grL1JkenBLK01Fb0VBQlMrdENMTmZ0L0JWc0J5?=
 =?utf-8?B?ZXJhREZ1bjY1aWUwckZ4TFBZTXpRRVBzbkpiV29GQ0FncmJ3VDJzOWxKbUU2?=
 =?utf-8?B?MllGbDBmMWxZMnUwVHlWR2hHVmhwTjVjR2JiSENKVjJRUGFHekM5YXgwRlNG?=
 =?utf-8?B?blpOWlMzMFpLNEdzQk9YdnJ2UUhaK290czgrSFJJWndWaytHNDUyaERQVjhk?=
 =?utf-8?B?RmpSbjhYdDJqZXRObDFPTlBFNi80VXFYb2RFY3ljMjByTGM2ZzdZalRBS1lS?=
 =?utf-8?B?cUhvaUk2TUNSWVJ4a09ad3N6OWNXbkxRbnhIUDV5SnNxQ09UTW9PS0dXaG5n?=
 =?utf-8?B?L3VQK2lvL01GSk1RUytRclJXS1hXUmFtODh0VjRvVVVjQ0hOblg3VmJWQVFs?=
 =?utf-8?B?dDQwQUUySGpNaVYvQ0dBQUdqVzgxSXNwN01OZXRDRTdLOWx6ais3RWxFK3JJ?=
 =?utf-8?B?ZUEvdTBYR0Z6Z2tnZ0c5WXJ1TUJ4ZmI1N1NwNUZmZUtCaHBZekE0YWg1R2NE?=
 =?utf-8?B?emRGbnZpb1RNa202Ry95REdRSkJwamlFRmx3YzBUVnRBWmtwWm00R0t4SnM3?=
 =?utf-8?B?L3d0NTFML21ram1zOVMvSUhUQ3lpcXFESGg4NG5rN1RYUnN5SDNaV0NaS2Fh?=
 =?utf-8?B?SHlOcGJ3c0ZmOW1tLzRCeEw0TU9lMjJoV3N2bjNKWDNqZ0tDbm1ROXdWOHgz?=
 =?utf-8?B?YXNTSitvYWNkMlJ2YWlXcEM0N0pRRFBVQlI2M2ZrZUp2cUFvbms5WXVMNGw3?=
 =?utf-8?B?RUdDRmlTNXBnOW9DeDlhdnVwRDNLVy85NHRicXdmTzIySnk3RVVOUEdEMWxk?=
 =?utf-8?B?My9qTGZZODN5bHFkekJqSGxXMkg3VVV3aFN1YVpYbkZBSEF0cVI2b213L3dN?=
 =?utf-8?B?cm5VdktKaDF6Tk1KbHpDTWgrNmtZRlpyTHQwb1d4K2xyOGR6R0pyMnVoRzIr?=
 =?utf-8?B?M3FzeGJIeUMrRDgzWCtzTWZJN2VTbG5LR1JKUWNST1JGWHU1L3pLWHk4ckts?=
 =?utf-8?B?Vm5lSkk3UnQyT3g2TklmTTlROGluQUVMNWZzL1hnaUpEaXJNcjE3Q0pwS0tj?=
 =?utf-8?B?VnBobEFOM3lHRXIra255T1ovL2pGRHNxM0thVGNzc0MybThiRWxnbythaDBr?=
 =?utf-8?Q?cNXE=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1d360b-ebd7-43c9-a4b8-08d9cfa0e73e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR0102MB3313.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 16:40:23.3338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lk1XdhoE2l+7c0xTcK8UpqiLUDw+ZoV2wk2O3Gyj+KxrYaV30iw2g+DzOKbAHlnu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR0102MB3505
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 12/28/2021 3:07 AM, Li Zhijian wrote:

> +static enum resp_states process_flush(struct rxe_qp *qp,
> +				       struct rxe_pkt_info *pkt)
> +{
> +	u64 length = 0, start = qp->resp.va;
> +	u32 sel = feth_sel(pkt);
> +	u32 plt = feth_plt(pkt);
> +	struct rxe_mr *mr = qp->resp.mr;
> +
> +	if (sel == IB_EXT_SEL_MR_RANGE)
> +		length = qp->resp.length;
> +	else if (sel == IB_EXT_SEL_MR_WHOLE)
> +		length = mr->cur_map_set->length;

I noticed another issue in this. When the "Memory Region" flag is
set, the RETH:VA field in the request is ignored, in addition to
the RETH:DMALEN. Therefore, both the start and length must be set
from the map.

Is the mr->cur_map_set[0]->addr field a virtual address, or a
physical? I can't find the cur_map_set in any patch. The virtual
(mapped) address will be needed, to pass to arch_wb_cache_pmem().

Something like this?

	if (sel == IB_EXT_SEL_MR_WHOLE) {
		length = mr->cur_map_set->length;
		start = mr->cur_map_set[0]->addr;
	}

(in addition to my other review suggestions about 0-length, etc...)

Tom.
